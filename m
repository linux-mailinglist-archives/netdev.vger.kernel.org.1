Return-Path: <netdev+bounces-27664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F6077CBA2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 13:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1581C20C59
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6775710966;
	Tue, 15 Aug 2023 11:24:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532210965
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EA2C433C7;
	Tue, 15 Aug 2023 11:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692098692;
	bh=Q5TrKurT2V4yZHymYHBHdElu209s20+L7p37ce3WGpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQz+eCpoiW8g1C6M+rjd5bNTCcQCAKddvMg/GlDo8Cc/Zf7VyP5jG9CyKx+RqBelL
	 T5bli702r9gFFmKeCQyWug510u9V6P6UopxvESg082ZoNIDOMW4dpsZ7htA5RNch+Y
	 htVCwNbMf3s8hpmgnd5YiKJXiE6LFoU5XX9ifZSytD5/NbGJfemgDhaCJaYhdCAhKB
	 p7xQ2z1oxoNTpFMmc9Niuuhg2Rk72EcS+mfYyWQTBu7ahdOlg9/CJBDLcFBglr3Mnw
	 U/dpU3LEIT1tSyf69rTPU2oqLMy1VNdVp98/8JOpqVJzF5W0XGW9uJh88gk0K9QQ51
	 et+KKjvuQFeZw==
Date: Tue, 15 Aug 2023 13:24:47 +0200
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <ZNtgfy9KPUclHnLE@vergenet.net>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814125643.59334-2-linyunsheng@huawei.com>

On Mon, Aug 14, 2023 at 08:56:38PM +0800, Yunsheng Lin wrote:

...

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..d62c11aaea9a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c

...

> @@ -737,18 +736,16 @@ static void page_pool_free_frag(struct page_pool *pool)
>  	page_pool_return_page(pool, page);
>  }
>  
> -struct page *page_pool_alloc_frag(struct page_pool *pool,
> -				  unsigned int *offset,
> -				  unsigned int size, gfp_t gfp)
> +struct page *__page_pool_alloc_frag(struct page_pool *pool,
> +				    unsigned int *offset,
> +				    unsigned int size, gfp_t gfp)
>  {
>  	unsigned int max_size = PAGE_SIZE << pool->p.order;
>  	struct page *page = pool->frag_page;
>  
> -	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> -		    size > max_size))
> +	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG))

Hi Yunsheng Lin,

There is a ')' missing on the line above, which results in a build failure.

>  		return NULL;
>  
> -	size = ALIGN(size, dma_get_cache_alignment());
>  	*offset = pool->frag_offset;
>  
>  	if (page && *offset + size > max_size) {
> @@ -781,7 +778,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
>  	alloc_stat_inc(pool, fast);
>  	return page;
>  }
> -EXPORT_SYMBOL(page_pool_alloc_frag);
> +EXPORT_SYMBOL(__page_pool_alloc_frag);
>  
>  static void page_pool_empty_ring(struct page_pool *pool)
>  {

-- 
pw-bot: changes-requested

