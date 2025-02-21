Return-Path: <netdev+bounces-168465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6449A3F18E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7923A80CB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55E204C37;
	Fri, 21 Feb 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXzdiqc8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6302010EE;
	Fri, 21 Feb 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132782; cv=none; b=t8udHCHntoMNgpGdZB0kSYuTPluieNuLJR8blvVRC06npxZJFmIoVtXv2ifqHvjz+ww8XUXfycAdnqm7hmkY0XRU7uIcXi+f8Zh4bHiaErkDclOfPiduszlC3dvyeNplHjKQ3U9tvO729EzGKjGSeGHvhRvFCMEjE9mEjzBV1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132782; c=relaxed/simple;
	bh=GYnWIeFhjAQiDhXS+WrOD/JXnr2uUllAjENAcUll5kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3j+MLR/44HyfvhAn3AjDEwBS5IxLhMaMn5JCzWOcbYuRgGC2xDSQS81w8h05pDrNaVF+AOWTXqvsJcz0bYUK/BloU1/OtuJ99zLgp7W/gM/1ZU2895PBQ19dsx9l+ceBgfEL3s0LdnhVBIP/Ro2mDk3vVPgWZF58fBm2Z1QfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXzdiqc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1827FC4CEE6;
	Fri, 21 Feb 2025 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740132781;
	bh=GYnWIeFhjAQiDhXS+WrOD/JXnr2uUllAjENAcUll5kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JXzdiqc8TEYdA/1hLzYh/hgI/9Lkwsr9D2/XCYK2WwIL0fXBZhmcIczI6F8rdlCSA
	 5IT8V21H5wlQZUwYIAfocpVf/Am2jxRtAX55w3wXVWxFpNvMl82rMWQVj0I63WQABi
	 FBQVXv+dFOyKudeXrURi55SKH8kOXkzE4X6K6nXbwq8urJrWs6IDNq/4iEGMVHRtvB
	 HbcssP4ubQSikXz0nxM0/hsfLlOrydWAtqfeWyC6TJkKYe0ZxG/605R31RNZ5BARIK
	 5Lqn1aOkNpt2LrfdKvuKOAFGDWnhlPE/qmYGBrjqnqBg9tvARAZfQ2TzRNJv7zROy6
	 0bkHU9BYj8ujg==
Message-ID: <640946c8-237d-40de-b64e-0f8fd8f1a600@kernel.org>
Date: Fri, 21 Feb 2025 11:12:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/4] page_pool: support unlimited number of
 inflight pages
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212092552.1779679-1-linyunsheng@huawei.com>
 <20250212092552.1779679-4-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250212092552.1779679-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


See below, I request changes to add memory accounting for these item_blocks.

On 12/02/2025 10.25, Yunsheng Lin wrote:
> Currently a fixed size of pre-allocated memory is used to
> keep track of the inflight pages, in order to use the DMA
> API correctly.
> 
> As mentioned [1], the number of inflight pages can be up to
> 73203 depending on the use cases. Allocate memory dynamically
> to keep track of the inflight pages when pre-allocated memory
> runs out.
> 
> The overhead of using dynamic memory allocation is about 10ns~
> 20ns, which causes 5%~10% performance degradation for the test
> case of time_bench_page_pool03_slow() in [2].
> 
> 1. https://lore.kernel.org/all/b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org/
> 2. https://github.com/netoptimizer/prototype-kernel
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: IOMMU <iommu@lists.linux.dev>
> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   include/net/page_pool/types.h | 10 +++++
>   net/core/page_pool.c          | 80 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index c131e2725e9a..c8c47ca67f4b 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -103,6 +103,7 @@ struct page_pool_params {
>    * @waive:	pages obtained from the ptr ring that cannot be added to
>    *		the cache due to a NUMA mismatch
>    * @item_fast_empty: pre-allocated item cache is empty
> + * @item_slow_failed: failed to allocate memory for item_block
>    */
>   struct page_pool_alloc_stats {
>   	u64 fast;
> @@ -112,6 +113,7 @@ struct page_pool_alloc_stats {
>   	u64 refill;
>   	u64 waive;
>   	u64 item_fast_empty;
> +	u64 item_slow_failed;
>   };
>   
>   /**
> @@ -159,9 +161,16 @@ struct page_pool_item {
>   struct page_pool_item_block {
>   	struct page_pool *pp;
>   	struct list_head list;
> +	unsigned int flags;
> +	refcount_t ref;
>   	struct page_pool_item items[];
>   };
>   
> +struct page_pool_slow_item {
> +	struct page_pool_item_block *block;
> +	unsigned int next_to_use;
> +};
> +
>   /* Ensure the offset of 'pp' field for both 'page_pool_item_block' and
>    * 'netmem_item_block' are the same.
>    */
> @@ -191,6 +200,7 @@ struct page_pool {
>   	int cpuid;
>   	u32 pages_state_hold_cnt;
>   	struct llist_head hold_items;
> +	struct page_pool_slow_item slow_items;
>   
>   	bool has_init_callback:1;	/* slow::init_callback is set */
>   	bool dma_map:1;			/* Perform DMA mapping */
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 508dd51b1a9a..3109bf015225 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -64,6 +64,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
>   	"rx_pp_alloc_refill",
>   	"rx_pp_alloc_waive",
>   	"rx_pp_alloc_item_fast_empty",
> +	"rx_pp_alloc_item_slow_failed",
>   	"rx_pp_recycle_cached",
>   	"rx_pp_recycle_cache_full",
>   	"rx_pp_recycle_ring",
> @@ -98,6 +99,7 @@ bool page_pool_get_stats(const struct page_pool *pool,
>   	stats->alloc_stats.refill += pool->alloc_stats.refill;
>   	stats->alloc_stats.waive += pool->alloc_stats.waive;
>   	stats->alloc_stats.item_fast_empty += pool->alloc_stats.item_fast_empty;
> +	stats->alloc_stats.item_slow_failed += pool->alloc_stats.item_slow_failed;
>   
>   	for_each_possible_cpu(cpu) {
>   		const struct page_pool_recycle_stats *pcpu =
> @@ -144,6 +146,7 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>   	*data++ = pool_stats->alloc_stats.refill;
>   	*data++ = pool_stats->alloc_stats.waive;
>   	*data++ = pool_stats->alloc_stats.item_fast_empty;
> +	*data++ = pool_stats->alloc_stats.item_slow_failed;
>   	*data++ = pool_stats->recycle_stats.cached;
>   	*data++ = pool_stats->recycle_stats.cache_full;
>   	*data++ = pool_stats->recycle_stats.ring;
> @@ -430,6 +433,7 @@ static void page_pool_item_uninit(struct page_pool *pool)
>   					 struct page_pool_item_block,
>   					 list);
>   		list_del(&block->list);
> +		WARN_ON(refcount_read(&block->ref));
>   		put_page(virt_to_page(block));
>   	}
>   }
> @@ -513,10 +517,43 @@ static struct page_pool_item *page_pool_fast_item_alloc(struct page_pool *pool)
>   	return llist_entry(first, struct page_pool_item, lentry);
>   }
>   
> +#define PAGE_POOL_SLOW_ITEM_BLOCK_BIT			BIT(0)
> +static struct page_pool_item *page_pool_slow_item_alloc(struct page_pool *pool)
> +{
> +	if (unlikely(!pool->slow_items.block ||
> +		     pool->slow_items.next_to_use >= ITEMS_PER_PAGE)) {
> +		struct page_pool_item_block *block;
> +		struct page *page;
> +
> +		page = alloc_pages_node(pool->p.nid, GFP_ATOMIC | __GFP_NOWARN |
> +					__GFP_ZERO, 0);
> +		if (!page) {
> +			alloc_stat_inc(pool, item_slow_failed);
> +			return NULL;
> +		}

We also need stats on how many pages we allocate for these item_blocks
(and later free). This new scheme of keeping track of all pages
allocated via page_pool, is obviously going to consume more memory.

I want to be able to find out how much memory a page_pool is consuming.
(E.g. Kuba added a nice interface for querying inflight packets, even
though this is kept as two different counters).

What I worry about, is that fragmentation happens inside these
item_blocks. (I hope you understand what I mean by fragmentation, else
let me know).

Could you explain how code handles or avoids fragmentation?


> +
> +		block = page_address(page);
> +		block->pp = pool;
> +		block->flags |= PAGE_POOL_SLOW_ITEM_BLOCK_BIT;
> +		refcount_set(&block->ref, ITEMS_PER_PAGE);
> +		pool->slow_items.block = block;
> +		pool->slow_items.next_to_use = 0;
> +
> +		spin_lock_bh(&pool->item_lock);
> +		list_add(&block->list, &pool->item_blocks);
> +		spin_unlock_bh(&pool->item_lock);
> +	}
> +
> +	return &pool->slow_items.block->items[pool->slow_items.next_to_use++];
> +}
> +
>   static bool page_pool_set_item_info(struct page_pool *pool, netmem_ref netmem)
>   {
>   	struct page_pool_item *item = page_pool_fast_item_alloc(pool);
>   
> +	if (unlikely(!item))
> +		item = page_pool_slow_item_alloc(pool);
> +
>   	if (likely(item)) {
>   		item->pp_netmem = netmem;
>   		page_pool_item_set_used(item);
> @@ -526,6 +563,37 @@ static bool page_pool_set_item_info(struct page_pool *pool, netmem_ref netmem)
>   	return !!item;
>   }
>   
> +static void __page_pool_slow_item_free(struct page_pool *pool,
> +				       struct page_pool_item_block *block)
> +{
> +	spin_lock_bh(&pool->item_lock);
> +	list_del(&block->list);
> +	spin_unlock_bh(&pool->item_lock);
> +
> +	put_page(virt_to_page(block));

Also counter for releasing block page here.

--Jesper

> +}
> +
> +static void page_pool_slow_item_drain(struct page_pool *pool)
> +{
> +	struct page_pool_item_block *block = pool->slow_items.block;
> +
> +	if (!block || pool->slow_items.next_to_use >= ITEMS_PER_PAGE)
> +		return;
> +
> +	if (refcount_sub_and_test(ITEMS_PER_PAGE - pool->slow_items.next_to_use,
> +				  &block->ref))
> +		__page_pool_slow_item_free(pool, block);
> +}
> +
> +static void page_pool_slow_item_free(struct page_pool *pool,
> +				     struct page_pool_item_block *block)
> +{
> +	if (likely(!refcount_dec_and_test(&block->ref)))
> +		return;
> +
> +	__page_pool_slow_item_free(pool, block);
> +}
> +
>   static void page_pool_fast_item_free(struct page_pool *pool,
>   				     struct page_pool_item *item)
>   {
> @@ -535,13 +603,22 @@ static void page_pool_fast_item_free(struct page_pool *pool,
>   static void page_pool_clear_item_info(struct page_pool *pool, netmem_ref netmem)
>   {
>   	struct page_pool_item *item = netmem_get_pp_item(netmem);
> +	struct page_pool_item_block *block;
>   
>   	DEBUG_NET_WARN_ON_ONCE(item->pp_netmem != netmem);
>   	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
>   	DEBUG_NET_WARN_ON_ONCE(!page_pool_item_is_used(item));
>   	page_pool_item_clear_used(item);
>   	netmem_set_pp_item(netmem, NULL);
> -	page_pool_fast_item_free(pool, item);
> +
> +	block = page_pool_item_to_block(item);
> +	if (likely(!(block->flags & PAGE_POOL_SLOW_ITEM_BLOCK_BIT))) {
> +		DEBUG_NET_WARN_ON_ONCE(refcount_read(&block->ref));
> +		page_pool_fast_item_free(pool, item);
> +		return;
> +	}
> +
> +	page_pool_slow_item_free(pool, block);
>   }
>   
>   /**
> @@ -1383,6 +1460,7 @@ void page_pool_destroy(struct page_pool *pool)
>   
>   	page_pool_disable_direct_recycling(pool);
>   	page_pool_free_frag(pool);
> +	page_pool_slow_item_drain(pool);
>   
>   	if (!page_pool_release(pool))
>   		return;

