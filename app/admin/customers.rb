ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  actions :index, :edit, :update, :create, :destroy

  permit_params :full_name, :phone_number, :email_address, :notes, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:full_name, :phone_number, :email_address, :notes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :full_name
    column :phone_number
    column :email_address
    column "Image" do |customer|
      if customer.image.attached?
        image_tag customer.image.variant(resize_to_limit: [100, 100])
      else
        "No Image"
      end
    end
    actions
  end


  filter :full_name
  filter :phone_number
  filter :email_address

  form do |f|
    f.inputs 'Customer Information' do
      f.input :full_name
      f.input :phone_number
      f.input :email_address
      f.input :notes
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :full_name
      row :phone_number
      row :email_address
      row :notes
      row :image do |cust|
        if cust.image.attached?
          image_tag url_for(cust.image), width: "50%"
        else
          "No image attached"
        end
      end
    end
  end
end
