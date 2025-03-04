Return-Path: <netdev+bounces-171547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521BA4D84F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4006E17229B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D494620298A;
	Tue,  4 Mar 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rphXP1ni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAB20126A;
	Tue,  4 Mar 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080353; cv=none; b=KVJLw5e47tPZhPZ9eSOBGJddPsIwqp9blrTEfF2aWSKtrjKXasuYOA7Hwe1Oe38FC7fXG7+FDm7I0U8eeKoB8aOe1tJ1RhXGZpfgapZjJTrxT4T7EWRLJIiZIoJSjAZ13fYnOlSWK/wrroGiT/h9EFwQYyb4d+WpZNebqzjYMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080353; c=relaxed/simple;
	bh=IYGGzd2iv7ffriZYtqfCxV0m2FT/feC0iBGQEH0feac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th8/zrwEGRzJ70ubpOZrgKrCJBsrsmkNMtxHTHDS0NHiQ1FYgAJBEGnp19mk0YZ9ay68JE4Y137QM5GDO0UUpPnjCvQjVumcrI4MyvILa6jJ7qE55DeaSSh8o5btb4ca2dPsqHSgB5hZM3qZdAKSCXVd0e3NHEdTSarEU3vk+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rphXP1ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DEEC4CEEF;
	Tue,  4 Mar 2025 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741080352;
	bh=IYGGzd2iv7ffriZYtqfCxV0m2FT/feC0iBGQEH0feac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rphXP1niKEtij+m65KQ/s0IEFyhpQy7BEQU6Y98xxVrnbyUZ6EABXhz0rFZ/DlvrL
	 2+7woXJRBTK6uJsYWhuMWeehX+r+8StvWU7bir4Oes2HhTbBKlrCBzrZK1dvYp2qBY
	 Djk4UpyiTv8FoaYGmN1AQNAu+ISKiqzXVfl05JGLO9lr0+q8s7SxhwrJw4VsOFqlWk
	 yrKEV2riVjDpHMXavpZZiWa5SSzsdx0p0RF21CzmPiay63ha9sZ+ivMEI1NwNjKLfR
	 NVzk1TgMznSLa08iovVUPYGXmQ5uUrM+Ujbl4iG1ZRnpNecdXTyec/mvnzZ7YgOlvk
	 AT+ip6OUfYrkg==
Message-ID: <d3c7d421-566f-4007-b272-650294edd019@kernel.org>
Date: Tue, 4 Mar 2025 10:25:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 3/4] page_pool: support unlimited number of
 inflight pages
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-4-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250226110340.2671366-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(comments requesting changes inlined below)

On 26/02/2025 12.03, Yunsheng Lin wrote:
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
>   Documentation/netlink/specs/netdev.yaml | 16 +++++
>   include/net/page_pool/types.h           | 10 ++++
>   include/uapi/linux/netdev.h             |  2 +
>   net/core/page_pool.c                    | 79 ++++++++++++++++++++++++-
>   net/core/page_pool_priv.h               |  2 +
>   net/core/page_pool_user.c               | 39 ++++++++++--
>   tools/net/ynl/samples/page-pool.c       | 11 ++++
>   7 files changed, 154 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 36f1152bfac3..7c121d0a5d15 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -162,6 +162,20 @@ attribute-sets:
>           type: uint
>           doc: |
>             Amount of memory held by inflight pages.
> +      -
> +        name: item_mem_resident
> +        type: uint
> +        doc: |
> +          Amount of actual memory allocated to track inflight pages.
> +          memory fragmentation ratio for item memory can be calculated
> +          using item_mem_resident / item_mem_used.
> +      -
> +        name: item_mem_used
> +        type: uint
> +        doc: |
> +          Amount of actual memory used to track inflight pages.
> +          memory fragmentation ratio for item memory can be calculated
> +          using item_mem_resident / item_mem_used.
>         -
>           name: detach-time
>           type: uint
> @@ -602,6 +616,8 @@ operations:
>               - detach-time
>               - dmabuf
>               - io-uring
> +            - item_mem_resident
> +            - item_mem_used
>         dump:
>           reply: *pp-reply
>         config-cond: page-pool
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
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 7600bf62dbdf..9309cbfeb8d2 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -103,6 +103,8 @@ enum {
>   	NETDEV_A_PAGE_POOL_DETACH_TIME,
>   	NETDEV_A_PAGE_POOL_DMABUF,
>   	NETDEV_A_PAGE_POOL_IO_URING,
> +	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
> +	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
>   
>   	__NETDEV_A_PAGE_POOL_MAX,
>   	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d927c468bc1b..dc9574bd129b 100644
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
> @@ -431,6 +434,7 @@ static void page_pool_item_uninit(struct page_pool *pool)
>   					 struct page_pool_item_block,
>   					 list);
>   		list_del(&block->list);
> +		WARN_ON(refcount_read(&block->ref));
>   		put_page(virt_to_page(block));
>   	}
>   }
> @@ -514,10 +518,42 @@ static struct page_pool_item *page_pool_fast_item_alloc(struct page_pool *pool)
>   	return llist_entry(first, struct page_pool_item, lentry);
>   }
>   
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

I'm missing a counter that I can use to monitor the rate of page
allocations for these "item" block's.
In production want to have a metric that shows me a sudden influx of
that cause code to hit this "item_slow_alloc" case (inflight_slow_alloc)

BTW should this be called "inflight_block" instead of "item_block"?


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
> @@ -527,6 +563,37 @@ static bool page_pool_set_item_info(struct page_pool *pool, netmem_ref netmem)
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

Here again I'm missing a counter that I can use to monitor the rate of
page free events.

In production I want a metric (e.g inflight_slow_free_block) that
together with "item_slow_alloc" (perhaps named
inflight_slow_alloc_block), show me if this code path is creating churn,
that I can correlate/explain some other influx event on the system.

BTW subtracting these (alloc - free) counters gives us the memory used.

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
> @@ -536,13 +603,22 @@ static void page_pool_fast_item_free(struct page_pool *pool,
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
> @@ -1390,6 +1466,7 @@ void page_pool_destroy(struct page_pool *pool)
>   
>   	page_pool_disable_direct_recycling(pool);
>   	page_pool_free_frag(pool);
> +	page_pool_slow_item_drain(pool);
>   
>   	if (!page_pool_release(pool))
>   		return;
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> index a5df5ab14ead..37adfc766c12 100644
> --- a/net/core/page_pool_priv.h
> +++ b/net/core/page_pool_priv.h
> @@ -7,6 +7,8 @@
>   
>   #include "netmem_priv.h"
>   
> +#define PAGE_POOL_SLOW_ITEM_BLOCK_BIT		BIT(0)
> +
>   extern struct mutex page_pools_lock;
>   
>   s32 page_pool_inflight(const struct page_pool *pool, bool strict);
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index c82a95beceff..0dc0090257ae 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -33,7 +33,7 @@ DEFINE_MUTEX(page_pools_lock);
>    *    - user.list: unhashed, netdev: unknown
>    */
>   
> -typedef int (*pp_nl_fill_cb)(struct sk_buff *rsp, const struct page_pool *pool,
> +typedef int (*pp_nl_fill_cb)(struct sk_buff *rsp, struct page_pool *pool,
>   			     const struct genl_info *info);
>   
>   static int
> @@ -111,7 +111,7 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
>   }
>   
>   static int
> -page_pool_nl_stats_fill(struct sk_buff *rsp, const struct page_pool *pool,
> +page_pool_nl_stats_fill(struct sk_buff *rsp, struct page_pool *pool,
>   			const struct genl_info *info)
>   {
>   #ifdef CONFIG_PAGE_POOL_STATS
> @@ -212,8 +212,36 @@ int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
>   	return netdev_nl_page_pool_get_dump(skb, cb, page_pool_nl_stats_fill);
>   }
>   
> +static int page_pool_nl_fill_item_mem_info(struct page_pool *pool,
> +					   struct sk_buff *rsp)
> +{
> +	struct page_pool_item_block *block;
> +	size_t resident = 0, used = 0;
> +	int err;
> +
> +	spin_lock_bh(&pool->item_lock);
> +
> +	list_for_each_entry(block, &pool->item_blocks, list) {
> +		resident += PAGE_SIZE;
> +
> +		if (block->flags & PAGE_POOL_SLOW_ITEM_BLOCK_BIT)
> +			used += (PAGE_SIZE - sizeof(struct page_pool_item) *
> +				 refcount_read(&block->ref));
> +		else
> +			used += PAGE_SIZE;
> +	}
> +
> +	spin_unlock_bh(&pool->item_lock);

Holding a BH spin_lock can easily create production issues.
I worry how long time it will take to traverse these lists.

We (Cc Yan) are currently hunting down a number of real production issue
due to different cases of control-path code querying the kernel that
takes a _bh lock to read data, hurting the data-path processing.

If we had the stats counters, then this would be less work, right?


> +
> +	err = nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT, resident);
> +	if (err)
> +		return err;
> +
> +	return nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ITEM_MEM_USED, used);
> +}
> +
>   static int
> -page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
> +page_pool_nl_fill(struct sk_buff *rsp, struct page_pool *pool,
>   		  const struct genl_info *info)
>   {
>   	size_t inflight, refsz;
> @@ -251,6 +279,9 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
>   	if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
>   		goto err_cancel;
>   
> +	if (page_pool_nl_fill_item_mem_info(pool, rsp))
> +		goto err_cancel;
> +
>   	genlmsg_end(rsp, hdr);
>   
>   	return 0;
> @@ -259,7 +290,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
>   	return -EMSGSIZE;
>   }
>   
> -static void netdev_nl_page_pool_event(const struct page_pool *pool, u32 cmd)
> +static void netdev_nl_page_pool_event(struct page_pool *pool, u32 cmd)
>   {
>   	struct genl_info info;
>   	struct sk_buff *ntf;
> diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
> index e5d521320fbf..16c48b6d3c2c 100644
> --- a/tools/net/ynl/samples/page-pool.c
> +++ b/tools/net/ynl/samples/page-pool.c
> @@ -16,6 +16,7 @@ struct stat {
>   	struct {
>   		unsigned int cnt;
>   		size_t refs, bytes;
> +		size_t item_mem_resident, item_mem_used;
>   	} live[2];
>   
>   	size_t alloc_slow, alloc_fast, recycle_ring, recycle_cache;
> @@ -52,6 +53,12 @@ static void count(struct stat *s, unsigned int l,
>   		s->live[l].refs += pp->inflight;
>   	if (pp->_present.inflight_mem)
>   		s->live[l].bytes += pp->inflight_mem;
> +
> +	if (pp->_present.item_mem_resident)
> +		s->live[l].item_mem_resident += pp->item_mem_resident;
> +
> +	if (pp->_present.item_mem_used)
> +		s->live[l].item_mem_used += pp->item_mem_used;
>   }
>   
>   int main(int argc, char **argv)
> @@ -127,6 +134,10 @@ int main(int argc, char **argv)
>   		       s->live[1].refs, s->live[1].bytes,
>   		       s->live[0].refs, s->live[0].bytes);
>   
> +		printf("\t\titem_mem_resident: %zu item_mem_used: %zu (item_mem_resident: %zu item_mem_used: %zu)\n",
> +		       s->live[1].item_mem_resident, s->live[1].item_mem_used,
> +		       s->live[0].item_mem_resident, s->live[0].item_mem_used);
> +
>   		/* We don't know how many pages are sitting in cache and ring
>   		 * so we will under-count the recycling rate a bit.
>   		 */

