Return-Path: <netdev+bounces-29297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D37828D8
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE66280E84
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5953B4;
	Mon, 21 Aug 2023 12:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D353AD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:19:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD44BE;
	Mon, 21 Aug 2023 05:19:06 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTryy0xBQztSfT;
	Mon, 21 Aug 2023 20:15:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 20:19:04 +0800
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Jakub Kicinski <kuba@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>
CC: Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com>
 <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org>
 <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org>
 <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
Date: Mon, 21 Aug 2023 20:18:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230818145145.4b357c89@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/19 5:51, Jakub Kicinski wrote:
> On Fri, 18 Aug 2023 09:12:09 +0300 Ilias Apalodimas wrote:
>>> Right, IIUC we don't have enough space to fit dma_addr_t and the
>>> refcount, but if we store the dma addr on a shifted u32 instead
>>> of using dma_addr_t explicitly - the refcount should fit?  
>>
>> struct page looks like this:
>>
>> unsigned long dma_addr;
>> union {
>>       unsigned long dma_addr_upper;
>>       atomic_long_t pp_frag_count;
>> };
> 
> I could be completely misunderstanding the problem.
> Let me show you the diff of what I was thinking more or less.
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e74ce4a28cd..58ffa8dc745f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -126,11 +126,6 @@ struct page {
>  			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
>  			union {
> -				/**
> -				 * dma_addr_upper: might require a 64-bit
> -				 * value on 32-bit architectures.
> -				 */
> -				unsigned long dma_addr_upper;
>  				/**
>  				 * For frag page support, not supported in
>  				 * 32-bit architectures with 64-bit DMA.
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 94231533a369..6f87a0fa2178 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -212,16 +212,24 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>  	dma_addr_t ret = page->dma_addr;
>  
>  	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +		ret <<= PAGE_SHIFT;
>  
>  	return ret;
>  }
>  
> -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>  {
> +	bool failed = false;
> +
>  	page->dma_addr = addr;
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -		page->dma_addr_upper = upper_32_bits(addr);
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +		page->dma_addr >>= PAGE_SHIFT;
> +		/* We assume page alignment to shave off bottom bits,
> +		 * if this "compression" doesn't work we need to drop.
> +		 */
> +		failed = addr != page->dma_addr << PAGE_SHIFT;
> +	}
> +	return failed;
>  }
>  
>  static inline bool page_pool_put(struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..9ea42e242a89 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
>  		 */
>  	}
>  
> -	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> -	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> -		return -EINVAL;
> -
>  #ifdef CONFIG_PAGE_POOL_STATS
>  	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>  	if (!pool->recycle_stats)
> @@ -359,12 +355,19 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>  	if (dma_mapping_error(pool->p.dev, dma))
>  		return false;
>  
> -	page_pool_set_dma_addr(page, dma);
> +	if (page_pool_set_dma_addr(page, dma))
> +		goto unmap_failed;

What does the driver do when the above fails?
Does the driver still need to implement a fallback for 32 bit arch with
dma addr with more than 32 + 12 bits?
If yes, it does not seems to be very helpful from driver's point of view
as the driver might still need to call page allocator API directly when
the above fails.

>  
>  	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>  		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>  
>  	return true;
> +
> +unmap_failed:
> +	dma_unmap_page_attrs(pool->p.dev, dma,
> +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +	return false;
>  }
>  
>  static void page_pool_set_pp_info(struct page_pool *pool,
> .
> 

