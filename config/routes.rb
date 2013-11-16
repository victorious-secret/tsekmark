require 'api'

Tsekmark::Application.routes.draw do
  authenticated :user do
    root :to => 'dashboard#index'
  end

  devise_for :users, :controllers => {:sessions => "sessions", :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }

  devise_scope :user do
    get "users/sign_out", :to => "sessions#destroy", :as => :destroy_user_session
    get "users/sign_in", :to => "sessions#create", :as => :create_user_session
  end

  mount Base => "/"
  mount GrapeSwaggerRails::Engine => '/swagger'
  resources :authentications, only: :destroy

  namespace :dashboard do
    get :index
    get :switch
  end

  resources :locations

  get "/oauth2callback" => "invites#index"
  get "/invites/:provider/callback" => "invites#index"

  resources :projects
  resources :sectors
  resources :departments
  resources :regions

  resources :users
  root :to => "home#index"
end