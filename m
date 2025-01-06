Return-Path: <netdev+bounces-155458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D58A02636
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1FF165181
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0E1DC046;
	Mon,  6 Jan 2025 13:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468D1DE2A5;
	Mon,  6 Jan 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168920; cv=none; b=WtlPZwe+GsXfgQ6i5yZXtHUKygHw9JZ9oT8g9HHk9WHfg3A3FFjC/Wi+4vBPsTD47c64lPmcg+9I7YGUFGU92JcohH/PnJka3M3N9FYhC5so94i70pAhG0E8CHtkFPo1HBVTS+Gq9Gm1XrschyDqKoIjId4q6veJc9egpQ4d690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168920; c=relaxed/simple;
	bh=fyB3b/Uvp9sOv/RNRc08ilToGU5wOABPP2SmnKUqHrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmHTItCJ/cikBYdtjgX8cCouEsmVKVbZSApiTK6F9vpYXqyNA+/ehvG0Ji/U5GzdBNv2n79kFuQq3ApocUly3LXcReH0fh0vxcQOoLvGIj9+JL+YFNzco4OUDMyGtmcGlJS6f3u7TlrVQUlUtF3RAu3GfBP4/HdYIq/NXD+PT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YRZJ969Yqz20njP;
	Mon,  6 Jan 2025 21:08:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 89ECF1A016C;
	Mon,  6 Jan 2025 21:08:35 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 21:08:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 4/8] page_pool: support unlimited number of inflight pages
Date: Mon, 6 Jan 2025 21:01:12 +0800
Message-ID: <20250106130116.457938-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250106130116.457938-1-linyunsheng@huawei.com>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Currently a fixed size of pre-allocated memory is used to
keep track of the inflight pages, in order to use the DMA
API correctly.

As mentioned [1], the number of inflight pages can be up to
73203 depending on the use cases. Allocate memory dynamically
to keep track of the inflight pages when pre-allocated memory
runs out.

The overhead of using dynamic memory allocation is about 10ns~
20ns, which causes 5%~10% performance degradation for the test
case of time_bench_page_pool03_slow() in [2].

1. https://lore.kernel.org/all/b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org/
2. https://github.com/netoptimizer/prototype-kernel
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h |   6 ++
 net/core/devmem.c             |   2 +-
 net/core/page_pool.c          | 109 +++++++++++++++++++++++++++++++---
 net/core/page_pool_priv.h     |   6 +-
 4 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 240f940b5ddc..ae9b6159ca9f 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -103,6 +103,7 @@ struct page_pool_params {
  * @waive:	pages obtained from the ptr ring that cannot be added to
  *		the cache due to a NUMA mismatch
  * @item_fast_empty: pre-allocated item cache is empty
+ * @item_slow_failed: failed to allocate memory for item_block
  */
 struct page_pool_alloc_stats {
 	u64 fast;
@@ -112,6 +113,7 @@ struct page_pool_alloc_stats {
 	u64 refill;
 	u64 waive;
 	u64 item_fast_empty;
+	u64 item_slow_failed;
 };
 
 /**
@@ -159,6 +161,8 @@ struct page_pool_item {
 struct page_pool_item_block {
 	struct page_pool *pp;
 	struct list_head list;
+	unsigned int flags;
+	refcount_t ref;
 	struct page_pool_item items[];
 };
 
@@ -188,6 +192,8 @@ struct page_pool {
 	int cpuid;
 	u32 pages_state_hold_cnt;
 	struct llist_head hold_items;
+	struct page_pool_item_block *item_blk;
+	unsigned int item_blk_idx;
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index cc7093f00af1..4d8b751d6f9c 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -380,7 +380,7 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	if (WARN_ON_ONCE(refcount != 1))
 		return false;
 
-	page_pool_clear_pp_info(pool, netmem);
+	page_pool_clear_pp_info(pool, netmem, false);
 
 	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e6ffbb000e53..76992a5195f0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -62,6 +62,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
 	"rx_pp_alloc_refill",
 	"rx_pp_alloc_waive",
 	"rx_pp_alloc_item_fast_empty",
+	"rx_pp_alloc_item_slow_failed",
 	"rx_pp_recycle_cached",
 	"rx_pp_recycle_cache_full",
 	"rx_pp_recycle_ring",
@@ -96,6 +97,7 @@ bool page_pool_get_stats(const struct page_pool *pool,
 	stats->alloc_stats.refill += pool->alloc_stats.refill;
 	stats->alloc_stats.waive += pool->alloc_stats.waive;
 	stats->alloc_stats.item_fast_empty += pool->alloc_stats.item_fast_empty;
+	stats->alloc_stats.item_slow_failed += pool->alloc_stats.item_slow_failed;
 
 	for_each_possible_cpu(cpu) {
 		const struct page_pool_recycle_stats *pcpu =
@@ -142,6 +144,7 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 	*data++ = pool_stats->alloc_stats.refill;
 	*data++ = pool_stats->alloc_stats.waive;
 	*data++ = pool_stats->alloc_stats.item_fast_empty;
+	*data++ = pool_stats->alloc_stats.item_slow_failed;
 	*data++ = pool_stats->recycle_stats.cached;
 	*data++ = pool_stats->recycle_stats.cache_full;
 	*data++ = pool_stats->recycle_stats.ring;
@@ -407,6 +410,8 @@ static void __page_pool_item_init(struct page_pool *pool, struct page *page)
 
 	list_add(&block->list, &pool->item_blocks);
 	block->pp = pool;
+	block->flags = 0;
+	refcount_set(&block->ref, 0);
 
 	for (i = 0; i < ITEMS_PER_PAGE; i++) {
 		page_pool_item_init_state(&items[i]);
@@ -479,8 +484,82 @@ static void page_pool_item_uninit(struct page_pool *pool)
 {
 	struct page_pool_item_block *block;
 
-	list_for_each_entry(block, &pool->item_blocks, list)
+	list_for_each_entry(block, &pool->item_blocks, list) {
+		WARN_ON(refcount_read(&block->ref));
 		put_page(virt_to_page(block));
+	}
+}
+
+#define PAGE_POOL_ITEM_BLK_DYNAMIC_BIT			BIT(0)
+
+static bool page_pool_item_blk_add(struct page_pool *pool, netmem_ref netmem)
+{
+	struct page_pool_item *item;
+
+	if (unlikely(!pool->item_blk || pool->item_blk_idx >= ITEMS_PER_PAGE)) {
+		struct page_pool_item_block *block;
+		struct page *page;
+
+		page = alloc_pages_node(pool->p.nid, GFP_ATOMIC | __GFP_NOWARN |
+					__GFP_ZERO, 0);
+		if (!page) {
+			alloc_stat_inc(pool, item_slow_failed);
+			return false;
+		}
+
+		block = page_address(page);
+		spin_lock_bh(&pool->item_lock);
+		list_add(&block->list, &pool->item_blocks);
+		spin_unlock_bh(&pool->item_lock);
+
+		block->pp = pool;
+		block->flags |= PAGE_POOL_ITEM_BLK_DYNAMIC_BIT;
+		refcount_set(&block->ref, ITEMS_PER_PAGE);
+		pool->item_blk = block;
+		pool->item_blk_idx = 0;
+	}
+
+	item = &pool->item_blk->items[pool->item_blk_idx++];
+	item->pp_netmem = netmem;
+	page_pool_item_set_used(item);
+	netmem_set_pp_item(netmem, item);
+	return true;
+}
+
+static void __page_pool_item_blk_del(struct page_pool *pool,
+				     struct page_pool_item_block *block)
+{
+	spin_lock_bh(&pool->item_lock);
+	list_del(&block->list);
+	spin_unlock_bh(&pool->item_lock);
+
+	put_page(virt_to_page(block));
+}
+
+static void page_pool_item_blk_free(struct page_pool *pool)
+{
+	struct page_pool_item_block *block = pool->item_blk;
+
+	if (!block || pool->item_blk_idx >= ITEMS_PER_PAGE)
+		return;
+
+	if (refcount_sub_and_test(ITEMS_PER_PAGE - pool->item_blk_idx,
+				  &block->ref))
+		__page_pool_item_blk_del(pool, block);
+}
+
+static void page_pool_item_blk_del(struct page_pool *pool,
+				   struct page_pool_item_block *block,
+				   bool destroyed)
+{
+	/* Only call __page_pool_item_blk_del() when page_pool_destroy()
+	 * is not called yet as alloc API is not allowed to be called at
+	 * this point and pool->item_lock is reused to avoid concurrent
+	 * dma unmapping when page_pool_destroy() is called, taking the
+	 * lock in __page_pool_item_blk_del() causes deadlock.
+	 */
+	if (refcount_dec_and_test(&block->ref) && !destroyed)
+		__page_pool_item_blk_del(pool, block);
 }
 
 static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
@@ -493,7 +572,7 @@ static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
 
 		if (unlikely(llist_empty(&pool->hold_items))) {
 			alloc_stat_inc(pool, item_fast_empty);
-			return false;
+			return page_pool_item_blk_add(pool, netmem);
 		}
 	}
 
@@ -506,16 +585,26 @@ static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
 	return true;
 }
 
-static void page_pool_item_del(struct page_pool *pool, netmem_ref netmem)
+static void page_pool_item_del(struct page_pool *pool, netmem_ref netmem,
+			       bool destroyed)
 {
 	struct page_pool_item *item = netmem_get_pp_item(netmem);
+	struct page_pool_item_block *block;
 
 	DEBUG_NET_WARN_ON_ONCE(item->pp_netmem != netmem);
 	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
 	DEBUG_NET_WARN_ON_ONCE(!page_pool_item_is_used(item));
 	page_pool_item_clear_used(item);
 	netmem_set_pp_item(netmem, NULL);
-	llist_add(&item->lentry, &pool->release_items);
+
+	block = page_pool_item_to_block(item);
+	if (likely(!(block->flags & PAGE_POOL_ITEM_BLK_DYNAMIC_BIT))) {
+		DEBUG_NET_WARN_ON_ONCE(refcount_read(&block->ref));
+		llist_add(&item->lentry, &pool->release_items);
+		return;
+	}
+
+	page_pool_item_blk_del(pool, block, destroyed);
 }
 
 /**
@@ -721,7 +810,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 				   pool->pages_state_hold_cnt);
 	return page;
 err_set_info:
-	page_pool_clear_pp_info(pool, page_to_netmem(page));
+	page_pool_clear_pp_info(pool, page_to_netmem(page), false);
 err_alloc:
 	put_page(page);
 	return NULL;
@@ -766,7 +855,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 		}
 
 		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
-			page_pool_clear_pp_info(pool, netmem);
+			page_pool_clear_pp_info(pool, netmem, false);
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
@@ -862,10 +951,11 @@ bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 	return true;
 }
 
-void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem)
+void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem,
+			     bool destroyed)
 {
 	netmem_clear_pp_magic(netmem);
-	page_pool_item_del(pool, netmem);
+	page_pool_item_del(pool, netmem, destroyed);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -892,7 +982,7 @@ void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
 	trace_page_pool_state_release(pool, netmem, count);
 
 	if (put) {
-		page_pool_clear_pp_info(pool, netmem);
+		page_pool_clear_pp_info(pool, netmem, destroyed);
 		put_page(netmem_to_page(netmem));
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
@@ -1390,6 +1480,7 @@ void page_pool_destroy(struct page_pool *pool)
 
 	page_pool_disable_direct_recycling(pool);
 	page_pool_free_frag(pool);
+	page_pool_item_blk_free(pool);
 
 	if (!page_pool_release(pool))
 		return;
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 5d85f862a30a..643f707838e8 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -37,7 +37,8 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 
 #if defined(CONFIG_PAGE_POOL)
 bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
-void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem);
+void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem,
+			     bool destroyed);
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq);
 #else
@@ -47,7 +48,8 @@ static inline bool page_pool_set_pp_info(struct page_pool *pool,
 	return true;
 }
 static inline void page_pool_clear_pp_info(struct page_pool *pool,
-					   netmem_ref netmem)
+					   netmem_ref netmem,
+					   bool destroyed)
 {
 }
 static inline int page_pool_check_memory_provider(struct net_device *dev,
-- 
2.33.0


