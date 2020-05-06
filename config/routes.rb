Rails.application.routes.draw do
  devise_for :users
  root 'tops#index'
  resources :accounts, only: %i(new create)
  resources :items, except: %i(index) do
    resources :orders, only: %i(new create) do
      get :cardRegist, on: :collection
      post :cardCreate, on: :collection
    end
  end
  resources :categories, only: %i(show index) do
    collection do
      post :root_parent_category, :parents, :children
    end
  end
  resources :brands, only: %i(index show)
  resources :categories, only: %i(index show)
  resources :users, only: %i(index) do
    collection do
      get :card, :logout
    end
  end
  resources :pays, only: %i(index new create destroy)
  resource :pays, only: %i(destroy)
  get :'category/:category_id/brand/:id', to: 'brands#root_category_brand_item'
end