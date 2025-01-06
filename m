Return-Path: <netdev+bounces-155456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1187A02635
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA013A3D4A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C61DA100;
	Mon,  6 Jan 2025 13:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC181DE4D3;
	Mon,  6 Jan 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168920; cv=none; b=kkIEToU8zj7o5BMjjMc6h0vAz+a5sJ6qpVF8pStl/4qZU84fWgGRvhRSOKm7p+BqJoXHoBV6H5Dk3KIgqmOEwOv2uvX4aapzk1BVkGOlcO+qqUowLFg6WgAxsYGgPLg3BQB34VRgNWDQqpLoAgMOGoDE3gY/AUHzQOk+nA0h5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168920; c=relaxed/simple;
	bh=K2KmTHJgNsem0mMkk7xJT+VccUc/EeNLQfnCmS+c64A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DepRQwkQXpOzNPRxIvamTk0rqvzkCy/H47MYLSK87LKoRGs5ON+uIdJKUKzFv+RsgPjcPbKqbhQt+pMbgNZ81efp7d4AXPT1H5parZR1hvfIc+96kecQnhEFr4ycaRKEJ0yhRkYKQU450itSayfeJBg6v6hnmgDIZZXp8FDVWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YRZF80FqqzRhlv;
	Mon,  6 Jan 2025 21:06:20 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4307D18010A;
	Mon,  6 Jan 2025 21:08:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 21:08:32 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v6 3/8] page_pool: fix IOMMU crash when driver has already unbound
Date: Mon, 6 Jan 2025 21:01:11 +0800
Message-ID: <20250106130116.457938-4-linyunsheng@huawei.com>
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

Networking driver with page_pool support may hand over page
still with dma mapping to network stack and try to reuse that
page after network stack is done with it and passes it back
to page_pool to avoid the penalty of dma mapping/unmapping.
With all the caching in the network stack, some pages may be
held in the network stack without returning to the page_pool
soon enough, and with VF disable causing the driver unbound,
the page_pool does not stop the driver from doing it's
unbounding work, instead page_pool uses workqueue to check
if there is some pages coming back from the network stack
periodically, if there is any, it will do the dma unmmapping
related cleanup work.

As mentioned in [1], attempting DMA unmaps after the driver
has already unbound may leak resources or at worst corrupt
memory. Fundamentally, the page pool code cannot allow DMA
mappings to outlive the driver they belong to.

Currently it seems there are at least two cases that the page
is not released fast enough causing dma unmmapping done after
driver has already unbound:
1. ipv4 packet defragmentation timeout: this seems to cause
   delay up to 30 secs.
2. skb_defer_free_flush(): this may cause infinite delay if
   there is no triggering for net_rx_action().

In order not to call DMA APIs to do DMA unmmapping after driver
has already unbound and stall the unloading of the networking
driver, use some pre-allocated item blocks to record inflight
pages including the ones which are handed over to network stack,
so the page_pool can do the DMA unmmapping for those pages when
page_pool_destroy() is called. As the pre-allocated item blocks
need to be large enough to avoid performance degradation, add a
'item_fast_empty' stat to indicate the unavailability of the
pre-allocated item blocks.

The overhead of tracking of inflight pages is about 10ns~20ns,
which causes about 10% performance degradation for the test case
of time_bench_page_pool03_slow() in [2].

Note, the devmem patchset seems to make the bug harder to fix,
and may make backporting harder too. As there is no actual user
for the devmem and the fixing for devmem is unclear for now,
this patch does not consider fixing the case for devmem yet.

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
2. https://github.com/netoptimizer/prototype-kernel
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
---
 include/linux/mm_types.h        |   2 +-
 include/linux/skbuff.h          |   1 +
 include/net/netmem.h            |  24 ++-
 include/net/page_pool/helpers.h |   8 +-
 include/net/page_pool/types.h   |  36 +++-
 net/core/devmem.c               |   4 +-
 net/core/netmem_priv.h          |   5 +-
 net/core/page_pool.c            | 304 +++++++++++++++++++++++++++-----
 net/core/page_pool_priv.h       |  10 +-
 9 files changed, 338 insertions(+), 56 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..abbb19f3244a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -120,7 +120,7 @@ struct page {
 			 * page_pool allocated pages.
 			 */
 			unsigned long pp_magic;
-			struct page_pool *pp;
+			struct page_pool_item *pp_item;
 			unsigned long _pp_mapping_pad;
 			unsigned long dma_addr;
 			atomic_long_t pp_ref_count;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..a47a23527724 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -39,6 +39,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <net/page_pool/types.h>
 
 /**
  * DOC: skb checksums
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 1b58faa4f20f..c848a48b8e96 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -23,7 +23,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
 struct net_iov {
 	unsigned long __unused_padding;
 	unsigned long pp_magic;
-	struct page_pool *pp;
+	struct page_pool_item *pp_item;
 	struct dmabuf_genpool_chunk_owner *owner;
 	unsigned long dma_addr;
 	atomic_long_t pp_ref_count;
@@ -33,7 +33,7 @@ struct net_iov {
  *
  *        struct {
  *                unsigned long pp_magic;
- *                struct page_pool *pp;
+ *                struct page_pool_item *pp_item;
  *                unsigned long _pp_mapping_pad;
  *                unsigned long dma_addr;
  *                atomic_long_t pp_ref_count;
@@ -49,7 +49,7 @@ struct net_iov {
 	static_assert(offsetof(struct page, pg) == \
 		      offsetof(struct net_iov, iov))
 NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
-NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(pp_item, pp_item);
 NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
@@ -67,6 +67,11 @@ NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
  */
 typedef unsigned long __bitwise netmem_ref;
 
+/* Mirror page_pool_item_block, see include/net/page_pool/types.h */
+struct netmem_item_block {
+	struct page_pool *pp;
+};
+
 static inline bool netmem_is_net_iov(const netmem_ref netmem)
 {
 	return (__force unsigned long)netmem & NET_IOV;
@@ -154,6 +159,11 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
+static inline struct page_pool_item *netmem_get_pp_item(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp_item;
+}
+
 /**
  * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
  * @netmem: netmem reference to get the pointer from
@@ -167,12 +177,16 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
  */
 static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
 {
-	return __netmem_to_page(netmem)->pp;
+	struct page_pool_item *item = __netmem_to_page(netmem)->pp_item;
+	struct netmem_item_block *block;
+
+	block = (struct netmem_item_block *)((unsigned long)item & PAGE_MASK);
+	return block->pp;
 }
 
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp;
+	return __netmem_get_pp((__force netmem_ref)__netmem_clear_lsb(netmem));
 }
 
 static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 9c4dbd2289b1..d4f2ec0898a5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -83,9 +83,15 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 }
 #endif
 
+static inline struct page_pool_item_block *
+page_pool_item_to_block(struct page_pool_item *item)
+{
+	return (struct page_pool_item_block *)((unsigned long)item & PAGE_MASK);
+}
+
 static inline struct page_pool *page_pool_get_pp(struct page *page)
 {
-	return page->pp;
+	return page_pool_item_to_block(page->pp_item)->pp;
 }
 
 /**
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ed4cd114180a..240f940b5ddc 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -102,6 +102,7 @@ struct page_pool_params {
  * @refill:	an allocation which triggered a refill of the cache
  * @waive:	pages obtained from the ptr ring that cannot be added to
  *		the cache due to a NUMA mismatch
+ * @item_fast_empty: pre-allocated item cache is empty
  */
 struct page_pool_alloc_stats {
 	u64 fast;
@@ -110,6 +111,7 @@ struct page_pool_alloc_stats {
 	u64 empty;
 	u64 refill;
 	u64 waive;
+	u64 item_fast_empty;
 };
 
 /**
@@ -142,6 +144,30 @@ struct page_pool_stats {
 };
 #endif
 
+struct page_pool_item {
+	unsigned long state;
+
+	union {
+		netmem_ref pp_netmem;
+		struct llist_node lentry;
+	};
+};
+
+/* The size of item_block is always PAGE_SIZE, so that the address of item_block
+ * for a specific item can be calculated using 'item & PAGE_MASK'
+ */
+struct page_pool_item_block {
+	struct page_pool *pp;
+	struct list_head list;
+	struct page_pool_item items[];
+};
+
+/* Ensure the offset of 'pp' field for both 'page_pool_item_block' and
+ * 'netmem_item_block' are the same.
+ */
+static_assert(offsetof(struct page_pool_item_block, pp) == \
+	      offsetof(struct netmem_item_block, pp));
+
 /* The whole frag API block must stay within one cacheline. On 32-bit systems,
  * sizeof(long) == sizeof(int), so that the block size is ``3 * sizeof(long)``.
  * On 64-bit systems, the actual size is ``2 * sizeof(long) + sizeof(int)``.
@@ -161,6 +187,7 @@ struct page_pool {
 
 	int cpuid;
 	u32 pages_state_hold_cnt;
+	struct llist_head hold_items;
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
@@ -223,13 +250,20 @@ struct page_pool {
 #endif
 	atomic_t pages_state_release_cnt;
 
+	/* Lock to protect item_blocks list when allocating and freeing
+	 * item block memory dynamically when destroy_cnt is zero.
+	 */
+	spinlock_t item_lock;
+	struct list_head item_blocks;
+	struct llist_head release_items;
+
 	/* A page_pool is strictly tied to a single RX-queue being
 	 * protected by NAPI, due to above pp_alloc_cache. This
 	 * refcnt serves purpose is to simplify drivers error handling.
 	 */
 	refcount_t user_cnt;
 
-	u64 destroy_cnt;
+	unsigned long destroy_cnt;
 
 	/* Slow/Control-path information follows */
 	struct page_pool_params_slow slow;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..cc7093f00af1 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -85,7 +85,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	niov = &owner->niovs[index];
 
 	niov->pp_magic = 0;
-	niov->pp = NULL;
+	niov->pp_item = NULL;
 	atomic_long_set(&niov->pp_ref_count, 0);
 
 	return niov;
@@ -380,7 +380,7 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	if (WARN_ON_ONCE(refcount != 1))
 		return false;
 
-	page_pool_clear_pp_info(netmem);
+	page_pool_clear_pp_info(pool, netmem);
 
 	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
 
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e00..3173f6070cf7 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -18,9 +18,10 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
-static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
+static inline void netmem_set_pp_item(netmem_ref netmem,
+				      struct page_pool_item *item)
 {
-	__netmem_clear_lsb(netmem)->pp = pool;
+	__netmem_clear_lsb(netmem)->pp_item = item;
 }
 
 static inline void netmem_set_dma_addr(netmem_ref netmem,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1aa7b93bdcc8..e6ffbb000e53 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -61,6 +61,7 @@ static const char pp_stats[][ETH_GSTRING_LEN] = {
 	"rx_pp_alloc_empty",
 	"rx_pp_alloc_refill",
 	"rx_pp_alloc_waive",
+	"rx_pp_alloc_item_fast_empty",
 	"rx_pp_recycle_cached",
 	"rx_pp_recycle_cache_full",
 	"rx_pp_recycle_ring",
@@ -94,6 +95,7 @@ bool page_pool_get_stats(const struct page_pool *pool,
 	stats->alloc_stats.empty += pool->alloc_stats.empty;
 	stats->alloc_stats.refill += pool->alloc_stats.refill;
 	stats->alloc_stats.waive += pool->alloc_stats.waive;
+	stats->alloc_stats.item_fast_empty += pool->alloc_stats.item_fast_empty;
 
 	for_each_possible_cpu(cpu) {
 		const struct page_pool_recycle_stats *pcpu =
@@ -139,6 +141,7 @@ u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 	*data++ = pool_stats->alloc_stats.empty;
 	*data++ = pool_stats->alloc_stats.refill;
 	*data++ = pool_stats->alloc_stats.waive;
+	*data++ = pool_stats->alloc_stats.item_fast_empty;
 	*data++ = pool_stats->recycle_stats.cached;
 	*data++ = pool_stats->recycle_stats.cache_full;
 	*data++ = pool_stats->recycle_stats.ring;
@@ -268,6 +271,7 @@ static int page_pool_init(struct page_pool *pool,
 		return -ENOMEM;
 	}
 
+	spin_lock_init(&pool->item_lock);
 	atomic_set(&pool->pages_state_release_cnt, 0);
 
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
@@ -325,6 +329,195 @@ static void page_pool_uninit(struct page_pool *pool)
 #endif
 }
 
+#define PAGE_POOL_ITEM_USED			0
+#define PAGE_POOL_ITEM_MAPPED			1
+
+#define ITEMS_PER_PAGE	((PAGE_SIZE -						\
+			  offsetof(struct page_pool_item_block, items)) /	\
+			 sizeof(struct page_pool_item))
+
+#define page_pool_item_init_state(item)					\
+({									\
+	(item)->state = 0;						\
+})
+
+#if defined(CONFIG_DEBUG_NET)
+#define page_pool_item_set_used(item)					\
+	__set_bit(PAGE_POOL_ITEM_USED, &(item)->state)
+
+#define page_pool_item_clear_used(item)					\
+	__clear_bit(PAGE_POOL_ITEM_USED, &(item)->state)
+
+#define page_pool_item_is_used(item)					\
+	test_bit(PAGE_POOL_ITEM_USED, &(item)->state)
+#else
+#define page_pool_item_set_used(item)
+#define page_pool_item_clear_used(item)
+#define page_pool_item_is_used(item)		false
+#endif
+
+#define page_pool_item_set_mapped(item)					\
+	__set_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
+
+/* Only clear_mapped and is_mapped need to be atomic as they can be
+ * called concurrently.
+ */
+#define page_pool_item_clear_mapped(item)				\
+	clear_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
+
+#define page_pool_item_is_mapped(item)					\
+	test_bit(PAGE_POOL_ITEM_MAPPED, &(item)->state)
+
+static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
+							 netmem_ref netmem,
+							 bool destroyed)
+{
+	struct page_pool_item *item;
+	dma_addr_t dma;
+
+	if (!pool->dma_map)
+		/* Always account for inflight pages, even if we didn't
+		 * map them
+		 */
+		return;
+
+	dma = page_pool_get_dma_addr_netmem(netmem);
+	item = netmem_get_pp_item(netmem);
+
+	/* dma unmapping is always needed when page_pool_destory() is not called
+	 * yet.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(!destroyed && !page_pool_item_is_mapped(item));
+	if (unlikely(destroyed && !page_pool_item_is_mapped(item)))
+		return;
+
+	/* When page is unmapped, it cannot be returned to our pool */
+	dma_unmap_page_attrs(pool->p.dev, dma,
+			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
+			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+	page_pool_set_dma_addr_netmem(netmem, 0);
+	page_pool_item_clear_mapped(item);
+}
+
+static void __page_pool_item_init(struct page_pool *pool, struct page *page)
+{
+	struct page_pool_item_block *block = page_address(page);
+	struct page_pool_item *items = block->items;
+	unsigned int i;
+
+	list_add(&block->list, &pool->item_blocks);
+	block->pp = pool;
+
+	for (i = 0; i < ITEMS_PER_PAGE; i++) {
+		page_pool_item_init_state(&items[i]);
+		__llist_add(&items[i].lentry, &pool->hold_items);
+	}
+}
+
+static int page_pool_item_init(struct page_pool *pool)
+{
+#define PAGE_POOL_MIN_INFLIGHT_ITEMS		512
+	struct page_pool_item_block *block;
+	int item_cnt;
+
+	INIT_LIST_HEAD(&pool->item_blocks);
+	init_llist_head(&pool->hold_items);
+	init_llist_head(&pool->release_items);
+
+	item_cnt = pool->p.pool_size * 2 + PP_ALLOC_CACHE_SIZE +
+		PAGE_POOL_MIN_INFLIGHT_ITEMS;
+	while (item_cnt > 0) {
+		struct page *page;
+
+		page = alloc_pages_node(pool->p.nid, GFP_KERNEL, 0);
+		if (!page)
+			goto err;
+
+		__page_pool_item_init(pool, page);
+		item_cnt -= ITEMS_PER_PAGE;
+	}
+
+	return 0;
+err:
+	list_for_each_entry(block, &pool->item_blocks, list)
+		put_page(virt_to_page(block));
+
+	return -ENOMEM;
+}
+
+static void page_pool_item_unmap(struct page_pool *pool,
+				 struct page_pool_item *item)
+{
+	spin_lock_bh(&pool->item_lock);
+	__page_pool_release_page_dma(pool, item->pp_netmem, true);
+	spin_unlock_bh(&pool->item_lock);
+}
+
+static void page_pool_items_unmap(struct page_pool *pool)
+{
+	struct page_pool_item_block *block;
+
+	if (!pool->dma_map || pool->mp_priv)
+		return;
+
+	list_for_each_entry(block, &pool->item_blocks, list) {
+		struct page_pool_item *items = block->items;
+		int i;
+
+		for (i = 0; i < ITEMS_PER_PAGE; i++) {
+			struct page_pool_item *item = &items[i];
+
+			if (!page_pool_item_is_mapped(item))
+				continue;
+
+			page_pool_item_unmap(pool, item);
+		}
+	}
+}
+
+static void page_pool_item_uninit(struct page_pool *pool)
+{
+	struct page_pool_item_block *block;
+
+	list_for_each_entry(block, &pool->item_blocks, list)
+		put_page(virt_to_page(block));
+}
+
+static bool page_pool_item_add(struct page_pool *pool, netmem_ref netmem)
+{
+	struct page_pool_item *item;
+	struct llist_node *node;
+
+	if (unlikely(llist_empty(&pool->hold_items))) {
+		pool->hold_items.first = llist_del_all(&pool->release_items);
+
+		if (unlikely(llist_empty(&pool->hold_items))) {
+			alloc_stat_inc(pool, item_fast_empty);
+			return false;
+		}
+	}
+
+	node = pool->hold_items.first;
+	pool->hold_items.first = node->next;
+	item = llist_entry(node, struct page_pool_item, lentry);
+	item->pp_netmem = netmem;
+	page_pool_item_set_used(item);
+	netmem_set_pp_item(netmem, item);
+	return true;
+}
+
+static void page_pool_item_del(struct page_pool *pool, netmem_ref netmem)
+{
+	struct page_pool_item *item = netmem_get_pp_item(netmem);
+
+	DEBUG_NET_WARN_ON_ONCE(item->pp_netmem != netmem);
+	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_item_is_used(item));
+	page_pool_item_clear_used(item);
+	netmem_set_pp_item(netmem, NULL);
+	llist_add(&item->lentry, &pool->release_items);
+}
+
 /**
  * page_pool_create_percpu() - create a page pool for a given cpu.
  * @params: parameters, see struct page_pool_params
@@ -344,12 +537,18 @@ page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
 	if (err < 0)
 		goto err_free;
 
-	err = page_pool_list(pool);
+	err = page_pool_item_init(pool);
 	if (err)
 		goto err_uninit;
 
+	err = page_pool_list(pool);
+	if (err)
+		goto err_item_uninit;
+
 	return pool;
 
+err_item_uninit:
+	page_pool_item_uninit(pool);
 err_uninit:
 	page_pool_uninit(pool);
 err_free:
@@ -369,7 +568,8 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 }
 EXPORT_SYMBOL(page_pool_create);
 
-static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
+static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
+				    bool destroyed);
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
@@ -407,7 +607,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			 * (2) break out to fallthrough to alloc_pages_node.
 			 * This limit stress on page buddy alloactor.
 			 */
-			page_pool_return_page(pool, netmem);
+			__page_pool_return_page(pool, netmem, false);
 			alloc_stat_inc(pool, waive);
 			netmem = 0;
 			break;
@@ -464,6 +664,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 {
+	struct page_pool_item *item;
 	dma_addr_t dma;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
@@ -481,6 +682,9 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	if (page_pool_set_dma_addr_netmem(netmem, dma))
 		goto unmap_failed;
 
+	item = netmem_get_pp_item(netmem);
+	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
+	page_pool_item_set_mapped(item);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
@@ -503,19 +707,24 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
-		put_page(page);
-		return NULL;
-	}
+	if (unlikely(!page_pool_set_pp_info(pool, page_to_netmem(page))))
+		goto err_alloc;
+
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page))))
+		goto err_set_info;
 
 	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page_to_netmem(page));
 
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
 	trace_page_pool_state_hold(pool, page_to_netmem(page),
 				   pool->pages_state_hold_cnt);
 	return page;
+err_set_info:
+	page_pool_clear_pp_info(pool, page_to_netmem(page));
+err_alloc:
+	put_page(page);
+	return NULL;
 }
 
 /* slow path */
@@ -550,12 +759,18 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
+
+		if (unlikely(!page_pool_set_pp_info(pool, netmem))) {
+			put_page(netmem_to_page(netmem));
+			continue;
+		}
+
 		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+			page_pool_clear_pp_info(pool, netmem);
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
 
-		page_pool_set_pp_info(pool, netmem);
 		pool->alloc.cache[pool->alloc.count++] = netmem;
 		/* Track how many pages are held 'in-flight' */
 		pool->pages_state_hold_cnt++;
@@ -627,9 +842,11 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 	return inflight;
 }
 
-void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
+bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
-	netmem_set_pp(netmem, pool);
+	if (unlikely(!page_pool_item_add(pool, netmem)))
+		return false;
+
 	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
@@ -641,32 +858,14 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 	page_pool_fragment_netmem(netmem, 1);
 	if (pool->has_init_callback)
 		pool->slow.init_callback(netmem, pool->slow.init_arg);
-}
 
-void page_pool_clear_pp_info(netmem_ref netmem)
-{
-	netmem_clear_pp_magic(netmem);
-	netmem_set_pp(netmem, NULL);
+	return true;
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
-							 netmem_ref netmem)
+void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
-	dma_addr_t dma;
-
-	if (!pool->dma_map)
-		/* Always account for inflight pages, even if we didn't
-		 * map them
-		 */
-		return;
-
-	dma = page_pool_get_dma_addr_netmem(netmem);
-
-	/* When page is unmapped, it cannot be returned to our pool */
-	dma_unmap_page_attrs(pool->p.dev, dma,
-			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
-			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-	page_pool_set_dma_addr_netmem(netmem, 0);
+	netmem_clear_pp_magic(netmem);
+	page_pool_item_del(pool, netmem);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -674,7 +873,8 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
+			     bool destroyed)
 {
 	int count;
 	bool put;
@@ -683,7 +883,7 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
 		put = mp_dmabuf_devmem_release_page(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_page_dma(pool, netmem, destroyed);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
@@ -692,7 +892,7 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	trace_page_pool_state_release(pool, netmem, count);
 
 	if (put) {
-		page_pool_clear_pp_info(netmem);
+		page_pool_clear_pp_info(pool, netmem);
 		put_page(netmem_to_page(netmem));
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
@@ -701,6 +901,27 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	 */
 }
 
+/* Called from page_pool_put_*() path, need to synchronizated with
+ * page_pool_destory() path.
+ */
+static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+{
+	unsigned int destroy_cnt;
+
+	rcu_read_lock();
+
+	destroy_cnt = READ_ONCE(pool->destroy_cnt);
+	if (unlikely(destroy_cnt)) {
+		spin_lock_bh(&pool->item_lock);
+		__page_pool_return_page(pool, netmem, true);
+		spin_unlock_bh(&pool->item_lock);
+	} else {
+		__page_pool_return_page(pool, netmem, false);
+	}
+
+	rcu_read_unlock();
+}
+
 static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 {
 	int ret;
@@ -963,7 +1184,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	__page_pool_return_page(pool, netmem, false);
 	return 0;
 }
 
@@ -977,7 +1198,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	__page_pool_return_page(pool, netmem, false);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1053,6 +1274,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 	if (pool->disconnect)
 		pool->disconnect(pool);
 
+	page_pool_item_uninit(pool);
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 
@@ -1084,7 +1306,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 static void page_pool_scrub(struct page_pool *pool)
 {
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	WRITE_ONCE(pool->destroy_cnt, pool->destroy_cnt + 1);
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
@@ -1178,6 +1400,8 @@ void page_pool_destroy(struct page_pool *pool)
 	 */
 	synchronize_rcu();
 
+	page_pool_items_unmap(pool);
+
 	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
@@ -1198,7 +1422,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		__page_pool_return_page(pool, netmem, false);
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 57439787b9c2..5d85f862a30a 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -36,16 +36,18 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 }
 
 #if defined(CONFIG_PAGE_POOL)
-void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
-void page_pool_clear_pp_info(netmem_ref netmem);
+bool page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
+void page_pool_clear_pp_info(struct page_pool *pool, netmem_ref netmem);
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq);
 #else
-static inline void page_pool_set_pp_info(struct page_pool *pool,
+static inline bool page_pool_set_pp_info(struct page_pool *pool,
 					 netmem_ref netmem)
 {
+	return true;
 }
-static inline void page_pool_clear_pp_info(netmem_ref netmem)
+static inline void page_pool_clear_pp_info(struct page_pool *pool,
+					   netmem_ref netmem)
 {
 }
 static inline int page_pool_check_memory_provider(struct net_device *dev,
-- 
2.33.0


