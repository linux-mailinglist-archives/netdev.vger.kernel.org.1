Return-Path: <netdev+bounces-137986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E59AB5D9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FF6B217CB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952231C9DC5;
	Tue, 22 Oct 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpnC4U4t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669DA1BD516;
	Tue, 22 Oct 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620894; cv=none; b=T9M1+hsMgGMWEYDuPZMXgBK/buxydrCRya4561HzHq7AMNQM7ouB3dnXJTazbDIvrzAOwLdOy+9zf7xRaJ6K4CofQg8kls/EB2t61ZOdYXBt/uT0tWRGsI7IHWNs/haoGEGEcLrik4gUy/zvvr7sKr6j6Me2cfwPGdlbcRIvfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620894; c=relaxed/simple;
	bh=7Vs/AUOlhVkuntzVMBkkDKEdYY6RV6Fj9QII9BcgMk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A95Ilc3Vp01qlPFcSTgRJQo/vZeHEIqOfaouCBXuAN6chwFiAgLW/NBRkLYsyPw65UOPcGuGfrOED3bYNZzLBYnFiBvqvG9P4eij/sXAYeYY/EI0RdRq+f5JCngi0Yp1spQ4N29gQLaJs/vUX77Y74QMbiKlBEo7GYj8KPq9OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpnC4U4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B699C4CEC3;
	Tue, 22 Oct 2024 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729620894;
	bh=7Vs/AUOlhVkuntzVMBkkDKEdYY6RV6Fj9QII9BcgMk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XpnC4U4tDNsNyshJ6ZPlWIrKuAIWE0O+cCorF1s3EkurD1q1VLf0lyqoK/yvCi6UZ
	 fn9E7LEWcvWDc2bTKjUSogQir0NCd9Kc4YsjzFq81pTfpaUwIFiFI+nWxraQSPGxR1
	 wnLD64ELMAeTsgys02L3oWxOXUjB7pjMOUMxnf6prIgv402/GZ1LzJ0ZoWF+NIkdIO
	 0hi294ja/kxOIhD35KvG1sNMZTHqbsqfwQwJzkXqOliuobvz7UJo8rS43YJ3GLv2z5
	 ffYLXeXaOY037NGIFKiXvbSU2zbheetP8+KdQSnO8gouM1dPSTb3jmOKNsDLOevgLk
	 ogFrTsN++ZjKg==
Message-ID: <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
Date: Tue, 22 Oct 2024 20:14:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20241022032214.3915232-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/10/2024 05.22, Yunsheng Lin wrote:
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
> 
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
> 
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>     delay up to 30 secs.
> 2. skb_defer_free_flush(): this may cause infinite delay if
>     there is no triggering for net_rx_action().
> 
> In order not to do the dma unmmapping after driver has already
> unbound and stall the unloading of the networking driver, add
> the pool->items array to record all the pages including the ones
> which are handed over to network stack, so the page_pool can

I really really dislike this approach!

Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Having to keep an array to record all the pages including the ones
which are handed over to network stack, goes against the very principle
behind page_pool. We added members to struct page, such that pages could
be "outstanding".

The page_pool already have a system for waiting for these outstanding /
inflight packets to get returned.  As I suggested before, the page_pool
should simply take over the responsability (from net_device) to free the
struct device (after inflight reach zero), where AFAIK the DMA device is
connected via.

The alternative is what Kuba suggested (and proposed an RFC for),  that
the net_device teardown waits for the page_pool inflight packets.


> do the dma unmmapping for those pages when page_pool_destroy()
> is called. As the pool->items need to be large enough to avoid
> performance degradation, add a 'item_full' stat to indicate the
> allocation failure due to unavailability of pool->items.

Are you saying page_pool will do allocation failures, based on the size
of this pool->items array?

Production workloads will have very large number of outstanding packet
memory in e.g. in TCP sockets.  In production I'm seeing TCP memory
reach 24 GiB (on machines with 384GiB memory).


> Note, the devmem patchset seems to make the bug harder to fix,
> and may make backporting harder too. As there is no actual user
> for the devmem and the fixing for devmem is unclear for now,
> this patch does not consider fixing the case for devmem yet.
> 
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: IOMMU <iommu@lists.linux.dev>
> ---
>   include/linux/mm_types.h        |   2 +-
>   include/linux/skbuff.h          |   1 +
>   include/net/netmem.h            |  10 +-
>   include/net/page_pool/helpers.h |   4 +-
>   include/net/page_pool/types.h   |  17 ++-
>   net/core/devmem.c               |   4 +-
>   net/core/netmem_priv.h          |   5 +-
>   net/core/page_pool.c            | 213 ++++++++++++++++++++++++++------
>   net/core/page_pool_priv.h       |  10 +-
>   9 files changed, 210 insertions(+), 56 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8e38bc..d3e30dcfa021 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,7 +120,7 @@ struct page {
>   			 * page_pool allocated pages.
>   			 */
>   			unsigned long pp_magic;
> -			struct page_pool *pp;
> +			struct page_pool_item *pp_item;

Why do we need to change the pp pointer?

Why can't we access the "items" array like pp->items?


>   			unsigned long _pp_mapping_pad;
>   			unsigned long dma_addr;
>   			atomic_long_t pp_ref_count;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 48f1e0fa2a13..44f3707ec3e3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -38,6 +38,7 @@
>   #include <net/net_debug.h>
>   #include <net/dropreason-core.h>
>   #include <net/netmem.h>
> +#include <net/page_pool/types.h>
>   
>   /**
>    * DOC: skb checksums
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 8a6e20be4b9d..5e7b4d1c1c44 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -23,7 +23,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
>   struct net_iov {
>   	unsigned long __unused_padding;
>   	unsigned long pp_magic;
> -	struct page_pool *pp;
> +	struct page_pool_item *pp_item;
>   	struct dmabuf_genpool_chunk_owner *owner;
>   	unsigned long dma_addr;
>   	atomic_long_t pp_ref_count;
> @@ -33,7 +33,7 @@ struct net_iov {
>    *
>    *        struct {
>    *                unsigned long pp_magic;
> - *                struct page_pool *pp;
> + *                struct page_pool_item *pp_item;
>    *                unsigned long _pp_mapping_pad;
>    *                unsigned long dma_addr;
>    *                atomic_long_t pp_ref_count;
> @@ -49,7 +49,7 @@ struct net_iov {
>   	static_assert(offsetof(struct page, pg) == \
>   		      offsetof(struct net_iov, iov))
>   NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> -NET_IOV_ASSERT_OFFSET(pp, pp);
> +NET_IOV_ASSERT_OFFSET(pp_item, pp_item);
>   NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
>   NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>   #undef NET_IOV_ASSERT_OFFSET
> @@ -127,9 +127,9 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>   	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
>   }
>   
> -static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
> +static inline struct page_pool_item *netmem_get_pp_item(netmem_ref netmem)
>   {
> -	return __netmem_clear_lsb(netmem)->pp;
> +	return __netmem_clear_lsb(netmem)->pp_item;
>   }
>   
>   static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 1659f1995985..f781c81f8aa9 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -85,7 +85,9 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>   
>   static inline struct page_pool *page_pool_to_pp(struct page *page)
>   {
> -	return page->pp;
> +	struct page_pool_item *item = page->pp_item;
> +
> +	return container_of(item, struct page_pool, items[item->pp_idx]);
>   }
>   
>   /**
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index c022c410abe3..194006d2930f 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -102,6 +102,7 @@ struct page_pool_params {
>    * @refill:	an allocation which triggered a refill of the cache
>    * @waive:	pages obtained from the ptr ring that cannot be added to
>    *		the cache due to a NUMA mismatch
> + * @item_full	items array is full
>    */
>   struct page_pool_alloc_stats {
>   	u64 fast;
> @@ -110,6 +111,7 @@ struct page_pool_alloc_stats {
>   	u64 empty;
>   	u64 refill;
>   	u64 waive;
> +	u64 item_full;
>   };
>   
>   /**
> @@ -142,6 +144,11 @@ struct page_pool_stats {
>   };
>   #endif
>   
> +struct page_pool_item {
> +	netmem_ref pp_netmem;
> +	unsigned int pp_idx;
> +};
> +
>   /* The whole frag API block must stay within one cacheline. On 32-bit systems,
>    * sizeof(long) == sizeof(int), so that the block size is ``3 * sizeof(long)``.
>    * On 64-bit systems, the actual size is ``2 * sizeof(long) + sizeof(int)``.
> @@ -161,6 +168,8 @@ struct page_pool {
>   
>   	int cpuid;
>   	u32 pages_state_hold_cnt;
> +	unsigned int item_mask;
> +	unsigned int item_idx;
>   
>   	bool has_init_callback:1;	/* slow::init_callback is set */
>   	bool dma_map:1;			/* Perform DMA mapping */
> @@ -228,7 +237,11 @@ struct page_pool {
>   	 */
>   	refcount_t user_cnt;
>   
> -	u64 destroy_cnt;
> +	/* Lock to avoid doing dma unmapping concurrently when
> +	 * destroy_cnt > 0.
> +	 */
> +	spinlock_t destroy_lock;
> +	unsigned int destroy_cnt;
>   
>   	/* Slow/Control-path information follows */
>   	struct page_pool_params_slow slow;
> @@ -239,6 +252,8 @@ struct page_pool {
>   		u32 napi_id;
>   		u32 id;
>   	} user;
> +
> +	struct page_pool_item items[] ____cacheline_aligned_in_smp;
>   };
>   
>   struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 11b91c12ee11..09c5aa83f12a 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -85,7 +85,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>   	niov = &owner->niovs[index];
>   
>   	niov->pp_magic = 0;
> -	niov->pp = NULL;
> +	niov->pp_item = NULL;
>   	atomic_long_set(&niov->pp_ref_count, 0);
>   
>   	return niov;
> @@ -380,7 +380,7 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
>   	if (WARN_ON_ONCE(refcount != 1))
>   		return false;
>   
> -	page_pool_clear_pp_info(netmem);
> +	page_pool_clear_pp_info(pool, netmem);
>   
>   	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
>   
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index 7eadb8393e00..3173f6070cf7 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -18,9 +18,10 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
>   	__netmem_clear_lsb(netmem)->pp_magic = 0;
>   }
>   
> -static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> +static inline void netmem_set_pp_item(netmem_ref netmem,
> +				      struct page_pool_item *item)
>   {
> -	__netmem_clear_lsb(netmem)->pp = pool;
> +	__netmem_clear_lsb(netmem)->pp_item = item;
>   }
>   
>   static inline void netmem_set_dma_addr(netmem_ref netmem,
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index dd497f5c927d..fa4a98b4fc67 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -61,6 +61,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
>   	"rx_pp_alloc_empty",
>   	"rx_pp_alloc_refill",
>   	"rx_pp_alloc_waive",
> +	"rx_pp_alloc_item_full",
>   	"rx_pp_recycle_cached",
>   	"rx_pp_recycle_cache_full",
>   	"rx_pp_recycle_ring",
> @@ -94,6 +95,7 @@ bool page_pool_get_stats(const struct page_pool *pool,
>   	stats->alloc_stats.empty += pool->alloc_stats.empty;
>   	stats->alloc_stats.refill += pool->alloc_stats.refill;
>   	stats->alloc_stats.waive += pool->alloc_stats.waive;
> +	stats->alloc_stats.item_full += pool->alloc_stats.item_full;
>   
>   	for_each_possible_cpu(cpu) {
>   		const struct page_pool_recycle_stats *pcpu =
> @@ -139,6 +141,7 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>   	*data++ = pool_stats->alloc_stats.empty;
>   	*data++ = pool_stats->alloc_stats.refill;
>   	*data++ = pool_stats->alloc_stats.waive;
> +	*data++ = pool_stats->alloc_stats.item_full;
>   	*data++ = pool_stats->recycle_stats.cached;
>   	*data++ = pool_stats->recycle_stats.cache_full;
>   	*data++ = pool_stats->recycle_stats.ring;
> @@ -267,14 +270,12 @@ static int page_pool_init(struct page_pool *pool,
>   		return -ENOMEM;
>   	}
>   
> +	spin_lock_init(&pool->destroy_lock);
>   	atomic_set(&pool->pages_state_release_cnt, 0);
>   
>   	/* Driver calling page_pool_create() also call page_pool_destroy() */
>   	refcount_set(&pool->user_cnt, 1);
>   
> -	if (pool->dma_map)
> -		get_device(pool->p.dev);
> -
>   	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>   		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
>   		 * configuration doesn't change while we're initializing
> @@ -312,15 +313,93 @@ static void page_pool_uninit(struct page_pool *pool)
>   {
>   	ptr_ring_cleanup(&pool->ring, NULL);
>   
> -	if (pool->dma_map)
> -		put_device(pool->p.dev);
> -
>   #ifdef CONFIG_PAGE_POOL_STATS
>   	if (!pool->system)
>   		free_percpu(pool->recycle_stats);
>   #endif
>   }
>   
> +static void page_pool_item_init(struct page_pool *pool, unsigned int item_cnt)
> +{
> +	struct page_pool_item *items = pool->items;
> +	unsigned int i;
> +
> +	WARN_ON_ONCE(!is_power_of_2(item_cnt));
> +
> +	for (i = 0; i < item_cnt; i++)
> +		items[i].pp_idx = i;
> +
> +	pool->item_mask = item_cnt - 1;
> +}
> +
> +static void page_pool_item_uninit(struct page_pool *pool)
> +{
> +	struct page_pool_item *items = pool->items;
> +	unsigned int mask = pool->item_mask;
> +	unsigned int i, unmapped = 0;
> +
> +	if (!pool->dma_map || pool->mp_priv)
> +		return;
> +
> +	spin_lock_bh(&pool->destroy_lock);
> +
> +	for (i = 0; i <= mask; i++) {
> +		struct page *page;
> +
> +		page = netmem_to_page(READ_ONCE(items[i].pp_netmem));
> +		if (!page)
> +			continue;
> +
> +		unmapped++;
> +		dma_unmap_page_attrs(pool->p.dev, page_pool_get_dma_addr(page),
> +				     PAGE_SIZE << pool->p.order,
> +				     pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC |
> +				     DMA_ATTR_WEAK_ORDERING);
> +		page_pool_set_dma_addr(page, 0);
> +	}
> +
> +	WARN_ONCE(page_pool_inflight(pool, false) != unmapped,
> +		  "page_pool(%u): unmapped(%u) != inflight page(%d)\n",
> +		  pool->user.id, unmapped, page_pool_inflight(pool, false));
> +
> +	pool->dma_map = false;
> +	spin_unlock_bh(&pool->destroy_lock);
> +}
> +
> +static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
> +{
> +	struct page_pool_item *items = pool->items;
> +	unsigned int mask = pool->item_mask;
> +	unsigned int idx = pool->item_idx;
> +	unsigned int i;
> +
> +	for (i = 0; i <= mask; i++) {
> +		unsigned int mask_idx = idx++ & mask;
> +
> +		if (!READ_ONCE(items[mask_idx].pp_netmem)) {
> +			WRITE_ONCE(items[mask_idx].pp_netmem, netmem);
> +			netmem_set_pp_item(netmem, &items[mask_idx]);
> +			pool->item_idx = idx;
> +			return true;
> +		}
> +	}
> +
> +	pool->item_idx = idx;
> +	alloc_stat_inc(pool, item_full);
> +	return false;
> +}
> +
> +static void page_pool_item_del(struct page_pool *pool, netmem_ref netmem)
> +{
> +	struct page_pool_item *item = netmem_to_page(netmem)->pp_item;
> +	struct page_pool_item *items = pool->items;
> +	unsigned int idx = item->pp_idx;
> +
> +	DEBUG_NET_WARN_ON_ONCE(items[idx].pp_netmem != netmem);
> +	WRITE_ONCE(items[idx].pp_netmem, (netmem_ref)NULL);
> +	netmem_set_pp_item(netmem, NULL);
> +}
> +
>   /**
>    * page_pool_create_percpu() - create a page pool for a given cpu.
>    * @params: parameters, see struct page_pool_params
> @@ -329,10 +408,15 @@ static void page_pool_uninit(struct page_pool *pool)
>   struct page_pool *
>   page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
>   {
> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS		512
> +	unsigned int item_cnt = (params->pool_size ? : 1024) +
> +				PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_INFLIGHT_ITEMS;
>   	struct page_pool *pool;
>   	int err;
>   
> -	pool = kzalloc_node(sizeof(*pool), GFP_KERNEL, params->nid);
> +	item_cnt = roundup_pow_of_two(item_cnt);
> +	pool = kvzalloc_node(struct_size(pool, items, item_cnt), GFP_KERNEL,
> +			     params->nid);
>   	if (!pool)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -340,6 +424,8 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
>   	if (err < 0)
>   		goto err_free;
>   
> +	page_pool_item_init(pool, item_cnt);
> +
>   	err = page_pool_list(pool);
>   	if (err)
>   		goto err_uninit;
> @@ -350,7 +436,7 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
>   	page_pool_uninit(pool);
>   err_free:
>   	pr_warn("%s() gave up with errno %d\n", __func__, err);
> -	kfree(pool);
> +	kvfree(pool);
>   	return ERR_PTR(err);
>   }
>   EXPORT_SYMBOL(page_pool_create_percpu);
> @@ -365,7 +451,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>   }
>   EXPORT_SYMBOL(page_pool_create);
>   
> -static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
> +static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
>   
>   static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>   {
> @@ -403,7 +489,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
>   			 * (2) break out to fallthrough to alloc_pages_node.
>   			 * This limit stress on page buddy alloactor.
>   			 */
> -			page_pool_return_page(pool, netmem);
> +			__page_pool_return_page(pool, netmem);
>   			alloc_stat_inc(pool, waive);
>   			netmem = 0;
>   			break;
> @@ -436,26 +522,32 @@ static netmem_ref __page_pool_get_cached(struct page_pool *pool)
>   	return netmem;
>   }
>   
> -static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
> -					    netmem_ref netmem,
> -					    u32 dma_sync_size)
> +static __always_inline void
> +__page_pool_dma_sync_for_device(const struct page_pool *pool, netmem_ref netmem,
> +				u32 dma_sync_size)
>   {
>   #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
> -	dma_addr_t dma_addr = page_pool_get_dma_addr_netmem(netmem);
> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {
> +		dma_addr_t dma_addr = page_pool_get_dma_addr_netmem(netmem);
>   
> -	dma_sync_size = min(dma_sync_size, pool->p.max_len);
> -	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
> -				     dma_sync_size, pool->p.dma_dir);
> +		dma_sync_size = min(dma_sync_size, pool->p.max_len);
> +		__dma_sync_single_for_device(pool->p.dev,
> +					     dma_addr + pool->p.offset,
> +					     dma_sync_size, pool->p.dma_dir);
> +	}
>   #endif
>   }
>   
> +/* Called from page_pool_put_*() path, need to synchronizated with
> + * page_pool_destory() path.
> + */
>   static __always_inline void
> -page_pool_dma_sync_for_device(const struct page_pool *pool,
> -			      netmem_ref netmem,
> +page_pool_dma_sync_for_device(const struct page_pool *pool, netmem_ref netmem,
>   			      u32 dma_sync_size)
>   {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +	rcu_read_lock();
> +	__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +	rcu_read_unlock();
>   }
>   
>   static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
> @@ -477,7 +569,7 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>   	if (page_pool_set_dma_addr_netmem(netmem, dma))
>   		goto unmap_failed;
>   
> -	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
> +	__page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
>   
>   	return true;
>   
> @@ -499,19 +591,24 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
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
> @@ -546,12 +643,18 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
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
> @@ -623,9 +726,11 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
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
> @@ -637,12 +742,14 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>   	page_pool_fragment_netmem(netmem, 1);
>   	if (pool->has_init_callback)
>   		pool->slow.init_callback(netmem, pool->slow.init_arg);
> +
> +	return true;
>   }
>   
> -void page_pool_clear_pp_info(netmem_ref netmem)
> +void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem)
>   {
>   	netmem_clear_pp_magic(netmem);
> -	netmem_set_pp(netmem, NULL);
> +	page_pool_item_del(pool, netmem);
>   }
>   
>   static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
> @@ -670,7 +777,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
>    * a regular page (that will eventually be returned to the normal
>    * page-allocator via put_page).
>    */
> -void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
> +void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   {
>   	int count;
>   	bool put;
> @@ -688,7 +795,7 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   	trace_page_pool_state_release(pool, netmem, count);
>   
>   	if (put) {
> -		page_pool_clear_pp_info(netmem);
> +		page_pool_clear_pp_info(pool, netmem);
>   		put_page(netmem_to_page(netmem));
>   	}
>   	/* An optimization would be to call __free_pages(page, pool->p.order)
> @@ -697,6 +804,27 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
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
> +		spin_lock_bh(&pool->destroy_lock);
> +		__page_pool_return_page(pool, netmem);
> +		spin_unlock_bh(&pool->destroy_lock);
> +	} else {
> +		__page_pool_return_page(pool, netmem);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>   {
>   	int ret;
> @@ -920,11 +1048,11 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
>   		return 0;
>   
>   	if (__page_pool_page_can_be_recycled(netmem)) {
> -		page_pool_dma_sync_for_device(pool, netmem, -1);
> +		__page_pool_dma_sync_for_device(pool, netmem, -1);
>   		return netmem;
>   	}
>   
> -	page_pool_return_page(pool, netmem);
> +	__page_pool_return_page(pool, netmem);
>   	return 0;
>   }
>   
> @@ -938,7 +1066,7 @@ static void page_pool_free_frag(struct page_pool *pool)
>   	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
>   		return;
>   
> -	page_pool_return_page(pool, netmem);
> +	__page_pool_return_page(pool, netmem);
>   }
>   
>   netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
> @@ -1022,7 +1150,7 @@ static void __page_pool_destroy(struct page_pool *pool)
>   		static_branch_dec(&page_pool_mem_providers);
>   	}
>   
> -	kfree(pool);
> +	kvfree(pool);
>   }
>   
>   static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
> @@ -1045,7 +1173,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
>   static void page_pool_scrub(struct page_pool *pool)
>   {
>   	page_pool_empty_alloc_cache_once(pool);
> -	pool->destroy_cnt++;
> +	WRITE_ONCE(pool->destroy_cnt, pool->destroy_cnt + 1);
>   
>   	/* No more consumers should exist, but producers could still
>   	 * be in-flight.
> @@ -1133,12 +1261,17 @@ void page_pool_destroy(struct page_pool *pool)
>   	if (!page_pool_release(pool))
>   		return;
>   
> +	/* Skip dma sync to avoid calling dma API after driver has unbound */
> +	pool->dma_sync = false;
> +
>   	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
>   	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>   	 * before returning to driver to free the napi instance.
>   	 */
>   	synchronize_rcu();
>   
> +	page_pool_item_uninit(pool);
> +
>   	page_pool_detached(pool);
>   	pool->defer_start = jiffies;
>   	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
> @@ -1159,7 +1292,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>   	/* Flush pool alloc cache, as refill will check NUMA node */
>   	while (pool->alloc.count) {
>   		netmem = pool->alloc.cache[--pool->alloc.count];
> -		page_pool_return_page(pool, netmem);
> +		__page_pool_return_page(pool, netmem);
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

