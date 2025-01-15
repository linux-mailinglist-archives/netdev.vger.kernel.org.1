Return-Path: <netdev+bounces-158573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C1EA128B4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76063A0411
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593C1917E9;
	Wed, 15 Jan 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfrNQxQh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B0165F18;
	Wed, 15 Jan 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958605; cv=none; b=fjPTVgHjKtpchiiZ57oy6//5uQpW6A7n1jKEMY4ki7hF0NH2Xj0V0mhgGXPSeGtkJmg0gNIgk43RdB7DUbjiBoBxm7cvKRXU3zPj4AKJglGrh502HHWZiT4lTHAEHoEJe8X1CMo2fd7y2/QdgfR90NTMivFC3MjSCr6P+nfcLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958605; c=relaxed/simple;
	bh=6RfRSCmOaitpM1FzlkrkDWblhGnC73Q86J0LvqJP4aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3HUcUJzuSKH4MBVO/DQSuDjstJHKt8GTFgPLfY6rqVP+ZQOtoEBYheemfPZptIRYDv8oSMXourNrSYSBYVSp/pMycl3dkA6sK2D2o8vShtON0dgo7npIsWq8HlinBNYqVUPuaur8QKJNJJbMnLWJtYlNhtjlI9V3szHCMRpO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfrNQxQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84EDC4CED1;
	Wed, 15 Jan 2025 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736958604;
	bh=6RfRSCmOaitpM1FzlkrkDWblhGnC73Q86J0LvqJP4aI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XfrNQxQhdNmSh9BicJCvY0HZpKLCClc1wspRxyu3p3W+V9Ogbfs1a/rLo+B35FnU9
	 DNHT+U1d2KFcLDwRrnqnsmPftG4yZA1sOadsRIrbks98XkBZak1H1Vsad2alZ0x+Hx
	 BHXSsVuRaEX0H9pVXOlWxu/mrMpnZg/IUhGGCfF0VmUuEnJtHm3NROe2gisHs6aEua
	 sXz3cWpTMAnF7IdXqT7pJ+IZfvZ/UyB0N1ib6R2AUJGnI4nGLJVWG8VrhQV/aIizDC
	 70bvkgnyPUorqRHNAr10PzAMEXedysyaGoB/1i5T4fB/J/ptpzzpRj+hH5YBuIaWI+
	 5OywUO2ojUNcg==
Message-ID: <921c827c-41b7-40af-8c01-c21adbe8f41f@kernel.org>
Date: Wed, 15 Jan 2025 17:29:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/8] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-4-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250110130703.3814407-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2025 14.06, Yunsheng Lin wrote:
[...]
> In order not to call DMA APIs to do DMA unmmapping after driver
> has already unbound and stall the unloading of the networking
> driver, use some pre-allocated item blocks to record inflight
> pages including the ones which are handed over to network stack,
> so the page_pool can do the DMA unmmapping for those pages when
> page_pool_destroy() is called. As the pre-allocated item blocks
> need to be large enough to avoid performance degradation, add a
> 'item_fast_empty' stat to indicate the unavailability of the
> pre-allocated item blocks.
> 

[...]
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1aa7b93bdcc8..fa7629c3ec94 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
[...]
> @@ -268,6 +271,7 @@ static int page_pool_init(struct page_pool *pool,
>   		return -ENOMEM;
>   	}
>   
> +	spin_lock_init(&pool->item_lock);
>   	atomic_set(&pool->pages_state_release_cnt, 0);
>   
>   	/* Driver calling page_pool_create() also call page_pool_destroy() */
> @@ -325,6 +329,200 @@ static void page_pool_uninit(struct page_pool *pool)
>   #endif
>   }
>   
> +#define PAGE_POOL_ITEM_USED			0
> +#define PAGE_POOL_ITEM_MAPPED			1
> +
> +#define ITEMS_PER_PAGE	((PAGE_SIZE -						\
> +			  offsetof(struct page_pool_item_block, items)) /	\
> +			 sizeof(struct page_pool_item))
> +
> +#define page_pool_item_init_state(item)					\
> +({									\
> +	(item)->state = 0;						\
> +})
> +
> +#if defined(CONFIG_DEBUG_NET)
> +#define page_pool_item_set_used(item)					\
> +	__set_bit(PAGE_POOL_ITEM_USED, &(item)->state)
> +
> +#define page_pool_item_clear_used(item)					\
> +	__clear_bit(PAGE_POOL_ITEM_USED, &(item)->state)
> +
> +#define page_pool_item_is_used(item)					\
> +	test_bit(PAGE_POOL_ITEM_USED, &(item)->state)
> +#else
> +#define page_pool_item_set_used(item)
> +#define page_pool_item_clear_used(item)
> +#define page_pool_item_is_used(item)		false
> +#endif
> +
> +#define page_pool_item_set_mapped(item)					\
> +	__set_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
> +
> +/* Only clear_mapped and is_mapped need to be atomic as they can be
> + * called concurrently.
> + */
> +#define page_pool_item_clear_mapped(item)				\
> +	clear_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
> +
> +#define page_pool_item_is_mapped(item)					\
> +	test_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
> +
> +static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> +							 netmem_ref netmem,
> +							 bool destroyed)
> +{
> +	struct page_pool_item *item;
> +	dma_addr_t dma;
> +
> +	if (!pool->dma_map)
> +		/* Always account for inflight pages, even if we didn't
> +		 * map them
> +		 */
> +		return;
> +
> +	dma = page_pool_get_dma_addr_netmem(netmem);
> +	item = netmem_get_pp_item(netmem);
> +
> +	/* dma unmapping is always needed when page_pool_destory() is not called
> +	 * yet.
> +	 */
> +	DEBUG_NET_WARN_ON_ONCE(!destroyed && !page_pool_item_is_mapped(item));
> +	if (unlikely(destroyed && !page_pool_item_is_mapped(item)))
> +		return;
> +
> +	/* When page is unmapped, it cannot be returned to our pool */
> +	dma_unmap_page_attrs(pool->p.dev, dma,
> +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +	page_pool_set_dma_addr_netmem(netmem, 0);
> +	page_pool_item_clear_mapped(item);
> +}
> +

I have a hard time reading/reviewing/maintaining below code, without
some design description.  This code needs more comments on what is the
*intend* and design it's trying to achieve.

 From patch description the only hint I have is:
  "use some pre-allocated item blocks to record inflight pages"

E.g. Why is it needed/smart to hijack the page->pp pointer?

> +static void __page_pool_item_init(struct page_pool *pool, struct page *page)
> +{

Function name is confusing.  First I though this was init'ing a single
item, but looking at the code it is iterating over ITEMS_PER_PAGE.

Maybe it should be called page_pool_item_block_init ?

> +	struct page_pool_item_block *block = page_address(page);
> +	struct page_pool_item *items = block->items;
> +	unsigned int i;
> +
> +	list_add(&block->list, &pool->item_blocks);
> +	block->pp = pool;
> +
> +	for (i = 0; i < ITEMS_PER_PAGE; i++) {
> +		page_pool_item_init_state(&items[i]);
> +		__llist_add(&items[i].lentry, &pool->hold_items);
> +	}
> +}
> +
> +static int page_pool_item_init(struct page_pool *pool)
> +{
> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS		512
> +	struct page_pool_item_block *block;
> +	int item_cnt;
> +
> +	INIT_LIST_HEAD(&pool->item_blocks);
> +	init_llist_head(&pool->hold_items);
> +	init_llist_head(&pool->release_items);
> +
> +	item_cnt = pool->p.pool_size * 2 + PP_ALLOC_CACHE_SIZE +
> +		PAGE_POOL_MIN_INFLIGHT_ITEMS;
> +	while (item_cnt > 0) {
> +		struct page *page;
> +
> +		page = alloc_pages_node(pool->p.nid, GFP_KERNEL, 0);
> +		if (!page)
> +			goto err;
> +
> +		__page_pool_item_init(pool, page);
> +		item_cnt -= ITEMS_PER_PAGE;
> +	}
> +
> +	return 0;
> +err:
> +	list_for_each_entry(block, &pool->item_blocks, list)
> +		put_page(virt_to_page(block));
> +
> +	return -ENOMEM;
> +}
> +
> +static void page_pool_item_unmap(struct page_pool *pool,
> +				 struct page_pool_item *item)
> +{
> +	spin_lock_bh(&pool->item_lock);
> +	__page_pool_release_page_dma(pool, item->pp_netmem, true);
> +	spin_unlock_bh(&pool->item_lock);
> +}
> +
> +static void page_pool_items_unmap(struct page_pool *pool)
> +{
> +	struct page_pool_item_block *block;
> +
> +	if (!pool->dma_map || pool->mp_priv)
> +		return;
> +
> +	list_for_each_entry(block, &pool->item_blocks, list) {
> +		struct page_pool_item *items = block->items;
> +		int i;
> +
> +		for (i = 0; i < ITEMS_PER_PAGE; i++) {
> +			struct page_pool_item *item = &items[i];
> +
> +			if (!page_pool_item_is_mapped(item))
> +				continue;
> +
> +			page_pool_item_unmap(pool, item);
> +		}
> +	}
> +}
> +
> +static void page_pool_item_uninit(struct page_pool *pool)
> +{
> +	while (!list_empty(&pool->item_blocks)) {
> +		struct page_pool_item_block *block;
> +
> +		block = list_first_entry(&pool->item_blocks,
> +					 struct page_pool_item_block,
> +					 list);
> +		list_del(&block->list);
> +		put_page(virt_to_page(block));
> +	}
> +}
> +
> +static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
> +{
> +	struct page_pool_item *item;
> +	struct llist_node *node;
> +
> +	if (unlikely(llist_empty(&pool->hold_items))) {
> +		pool->hold_items.first = llist_del_all(&pool->release_items);
> +
> +		if (unlikely(llist_empty(&pool->hold_items))) {
> +			alloc_stat_inc(pool, item_fast_empty);
> +			return false;
> +		}
> +	}
> +
> +	node = pool->hold_items.first;
> +	pool->hold_items.first = node->next;
> +	item = llist_entry(node, struct page_pool_item, lentry);
> +	item->pp_netmem = netmem;
> +	page_pool_item_set_used(item);
> +	netmem_set_pp_item(netmem, item);
> +	return true;
> +}
> +
> +static void page_pool_item_del(struct page_pool *pool, netmem_ref netmem)
> +{
> +	struct page_pool_item *item = netmem_get_pp_item(netmem);
> +
> +	DEBUG_NET_WARN_ON_ONCE(item->pp_netmem != netmem);
> +	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
> +	DEBUG_NET_WARN_ON_ONCE(!page_pool_item_is_used(item));
> +	page_pool_item_clear_used(item);
> +	netmem_set_pp_item(netmem, NULL);
> +	llist_add(&item->lentry, &pool->release_items);
> +}
> +
>   /**
>    * page_pool_create_percpu() - create a page pool for a given cpu.
>    * @params: parameters, see struct page_pool_params
> @@ -344,12 +542,18 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
>   	if (err < 0)
>   		goto err_free;
>   
> -	err = page_pool_list(pool);
> +	err = page_pool_item_init(pool);
>   	if (err)
>   		goto err_uninit;
>   
> +	err = page_pool_list(pool);
> +	if (err)
> +		goto err_item_uninit;
> +
>   	return pool;
>   
> +err_item_uninit:
> +	page_pool_item_uninit(pool);
>   err_uninit:
>   	page_pool_uninit(pool);
>   err_free:
> @@ -369,7 +573,8 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>   }
>   EXPORT_SYMBOL(page_pool_create);
>   
> -static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
> +static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
> +				    bool destroyed);
>   
>   static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>   {
> @@ -407,7 +612,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>   			 * (2) break out to fallthrough to alloc_pages_node.
>   			 * This limit stress on page buddy alloactor.
>   			 */
> -			page_pool_return_page(pool, netmem);
> +			__page_pool_return_page(pool, netmem, false);
>   			alloc_stat_inc(pool, waive);
>   			netmem = 0;
>   			break;
> @@ -464,6 +669,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>   
>   static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>   {
> +	struct page_pool_item *item;
>   	dma_addr_t dma;
>   
>   	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
> @@ -481,6 +687,9 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>   	if (page_pool_set_dma_addr_netmem(netmem, dma))
>   		goto unmap_failed;
>   
> +	item = netmem_get_pp_item(netmem);
> +	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
> +	page_pool_item_set_mapped(item);
>   	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
>   
>   	return true;
> @@ -503,19 +712,24 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
>   	if (unlikely(!page))
>   		return NULL;
>   
> -	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
> -		put_page(page);
> -		return NULL;
> -	}
> +	if (unlikely(!page_pool_set_pp_info(pool, page_to_netmem(page))))
> +		goto err_alloc;
> +
> +	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page))))
> +		goto err_set_info;
>   
>   	alloc_stat_inc(pool, slow_high_order);
> -	page_pool_set_pp_info(pool, page_to_netmem(page));
>   
>   	/* Track how many pages are held 'in-flight' */
>   	pool->pages_state_hold_cnt++;
>   	trace_page_pool_state_hold(pool, page_to_netmem(page),
>   				   pool->pages_state_hold_cnt);
>   	return page;
> +err_set_info:
> +	page_pool_clear_pp_info(pool, page_to_netmem(page));
> +err_alloc:
> +	put_page(page);
> +	return NULL;
>   }
>   
>   /* slow path */
> @@ -550,12 +764,18 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
>   	 */
>   	for (i = 0; i < nr_pages; i++) {
>   		netmem = pool->alloc.cache[i];
> +
> +		if (unlikely(!page_pool_set_pp_info(pool, netmem))) {
> +			put_page(netmem_to_page(netmem));
> +			continue;
> +		}
> +
>   		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
> +			page_pool_clear_pp_info(pool, netmem);
>   			put_page(netmem_to_page(netmem));
>   			continue;
>   		}
>   
> -		page_pool_set_pp_info(pool, netmem);
>   		pool->alloc.cache[pool->alloc.count++] = netmem;
>   		/* Track how many pages are held 'in-flight' */
>   		pool->pages_state_hold_cnt++;
> @@ -627,9 +847,11 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>   	return inflight;
>   }
>   
> -void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
> +bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>   {
> -	netmem_set_pp(netmem, pool);
> +	if (unlikely(!page_pool_item_add(pool, netmem)))
> +		return false;
> +
>   	netmem_or_pp_magic(netmem, PP_SIGNATURE);
>   
>   	/* Ensuring all pages have been split into one fragment initially:
> @@ -641,32 +863,14 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>   	page_pool_fragment_netmem(netmem, 1);
>   	if (pool->has_init_callback)
>   		pool->slow.init_callback(netmem, pool->slow.init_arg);
> -}
>   
> -void page_pool_clear_pp_info(netmem_ref netmem)
> -{
> -	netmem_clear_pp_magic(netmem);
> -	netmem_set_pp(netmem, NULL);
> +	return true;
>   }
>   
> -static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> -							 netmem_ref netmem)
> +void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem)
>   {
> -	dma_addr_t dma;
> -
> -	if (!pool->dma_map)
> -		/* Always account for inflight pages, even if we didn't
> -		 * map them
> -		 */
> -		return;
> -
> -	dma = page_pool_get_dma_addr_netmem(netmem);
> -
> -	/* When page is unmapped, it cannot be returned to our pool */
> -	dma_unmap_page_attrs(pool->p.dev, dma,
> -			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> -			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> -	page_pool_set_dma_addr_netmem(netmem, 0);
> +	netmem_clear_pp_magic(netmem);
> +	page_pool_item_del(pool, netmem);
>   }
>   
>   /* Disconnects a page (from a page_pool).  API users can have a need
> @@ -674,7 +878,8 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
>    * a regular page (that will eventually be returned to the normal
>    * page-allocator via put_page).
>    */
> -void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
> +void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
> +			     bool destroyed)
>   {
>   	int count;
>   	bool put;
> @@ -683,7 +888,7 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
>   		put = mp_dmabuf_devmem_release_page(pool, netmem);
>   	else
> -		__page_pool_release_page_dma(pool, netmem);
> +		__page_pool_release_page_dma(pool, netmem, destroyed);
>   
>   	/* This may be the last page returned, releasing the pool, so
>   	 * it is not safe to reference pool afterwards.
> @@ -692,7 +897,7 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   	trace_page_pool_state_release(pool, netmem, count);
>   
>   	if (put) {
> -		page_pool_clear_pp_info(netmem);
> +		page_pool_clear_pp_info(pool, netmem);
>   		put_page(netmem_to_page(netmem));
>   	}
>   	/* An optimization would be to call __free_pages(page, pool->p.order)
> @@ -701,6 +906,27 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   	 */
>   }
>   
> +/* Called from page_pool_put_*() path, need to synchronizated with
> + * page_pool_destory() path.
> + */
> +static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
> +{
> +	unsigned int destroy_cnt;
> +
> +	rcu_read_lock();
> +
> +	destroy_cnt = READ_ONCE(pool->destroy_cnt);
> +	if (unlikely(destroy_cnt)) {
> +		spin_lock_bh(&pool->item_lock);
> +		__page_pool_return_page(pool, netmem, true);
> +		spin_unlock_bh(&pool->item_lock);
> +	} else {
> +		__page_pool_return_page(pool, netmem, false);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>   {
>   	int ret;
> @@ -963,7 +1189,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
>   		return netmem;
>   	}
>   
> -	page_pool_return_page(pool, netmem);
> +	__page_pool_return_page(pool, netmem, false);
>   	return 0;
>   }
>   
> @@ -977,7 +1203,7 @@ static void page_pool_free_frag(struct page_pool *pool)
>   	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
>   		return;
>   
> -	page_pool_return_page(pool, netmem);
> +	__page_pool_return_page(pool, netmem, false);
>   }
>   
>   netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
> @@ -1053,6 +1279,7 @@ static void __page_pool_destroy(struct page_pool *pool)
>   	if (pool->disconnect)
>   		pool->disconnect(pool);
>   
> +	page_pool_item_uninit(pool);
>   	page_pool_unlist(pool);
>   	page_pool_uninit(pool);
>   
> @@ -1084,7 +1311,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
>   static void page_pool_scrub(struct page_pool *pool)
>   {
>   	page_pool_empty_alloc_cache_once(pool);
> -	pool->destroy_cnt++;
> +	WRITE_ONCE(pool->destroy_cnt, pool->destroy_cnt + 1);
>   
>   	/* No more consumers should exist, but producers could still
>   	 * be in-flight.
> @@ -1178,6 +1405,8 @@ void page_pool_destroy(struct page_pool *pool)
>   	 */
>   	synchronize_rcu();
>   
> +	page_pool_items_unmap(pool);
> +
>   	page_pool_detached(pool);
>   	pool->defer_start = jiffies;
>   	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
> @@ -1198,7 +1427,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>   	/* Flush pool alloc cache, as refill will check NUMA node */
>   	while (pool->alloc.count) {
>   		netmem = pool->alloc.cache[--pool->alloc.count];
> -		page_pool_return_page(pool, netmem);
> +		__page_pool_return_page(pool, netmem, false);
>   	}
>   }
>   EXPORT_SYMBOL(page_pool_update_nid);
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> index 57439787b9c2..5d85f862a30a 100644
> --- a/net/core/page_pool_priv.h
> +++ b/net/core/page_pool_priv.h
> @@ -36,16 +36,18 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>   }
>   
>   #if defined(CONFIG_PAGE_POOL)
> -void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
> -void page_pool_clear_pp_info(netmem_ref netmem);
> +bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
> +void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem);
>   int page_pool_check_memory_provider(struct net_device *dev,
>   				    struct netdev_rx_queue *rxq);
>   #else
> -static inline void page_pool_set_pp_info(struct page_pool *pool,
> +static inline bool page_pool_set_pp_info(struct page_pool *pool,
>   					 netmem_ref netmem)
>   {
> +	return true;
>   }
> -static inline void page_pool_clear_pp_info(netmem_ref netmem)
> +static inline void page_pool_clear_pp_info(struct page_pool *pool,
> +					   netmem_ref netmem)
>   {
>   }
>   static inline int page_pool_check_memory_provider(struct net_device *dev,

