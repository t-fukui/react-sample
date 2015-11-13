class ArticlesController < ApplicationController
  # GET /articles.json
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(params[:per_page])
  end

  # GET /articles/new
  def new
    @article = Article.new
    render :index
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: { notice: 'Article was successfully created.', location: article_path(@article) }, status: :created
    else
      render json: @article.errors.full_messages, status: :unprocessable_entity
    end
  end

  # GET /articless/1
  # GET /articless/1.json
  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html { render :index }
      format.json { @article }
    end
  end

  private
    def article_params
      params.require(:article).permit(:name, :body)
    end
end
