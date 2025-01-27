Return-Path: <netdev+bounces-161049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A480A1CFB3
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 04:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65001886B78
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B51FCFC1;
	Mon, 27 Jan 2025 03:05:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A61FCFC0;
	Mon, 27 Jan 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737947108; cv=none; b=l3xXcoPtNgnKA0rAufzalT9Knql62/9SCgx1SgNQ/J9Ub4u8BhQ0rppqZdUb3mf/wB5mLskFg8G6S4JGHuSndhX2co+I3liYwMrYDpGMF63slBwovZkycA93WAzGqS6jtxCt7eh8toJcBNBxzpc1ojaQ37f3X7Piol/k5KK4aF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737947108; c=relaxed/simple;
	bh=a3slRYUOH75ANQAss5H386VAN8u1Ki+dwG+HDBEi4L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHvgPTzyX6HWkKNY5RhB++00KpHpOopRtBMMvcjzjt5cCEROneN+vPLBk9PGf3OwETUhReFpOUqyVQRU/2aQRDrNKIXAxn0cBMG6+pes4xepkY1Gt8WjCcuRKNRutFP0w3cS9urK/9rRm7Y3bTZM84UPLwIGg3QSlnJxJmrMWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YhCrY0XpkzRm2B;
	Mon, 27 Jan 2025 11:02:21 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8243F1802E1;
	Mon, 27 Jan 2025 11:04:56 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 11:04:56 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC v8 4/5] page_pool: support unlimited number of inflight pages
Date: Mon, 27 Jan 2025 10:57:33 +0800
Message-ID: <20250127025734.3406167-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250127025734.3406167-1-linyunsheng@huawei.com>
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 include/net/page_pool/types.h | 10 +++++
 net/core/page_pool.c          | 80 ++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index e7f6c8f1a778..ea393e8b7d65 100644
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
@@ -159,9 +161,16 @@ struct page_pool_item {
 struct page_pool_item_block {
 	struct page_pool *pp;
 	struct list_head list;
+	unsigned int flags;
+	refcount_t ref;
 	struct page_pool_item items[];
 };
 
+struct page_pool_slow_item {
+	struct page_pool_item_block *block;
+	unsigned int next_to_use;
+};
+
 /* Ensure the offset of 'pp' field for both 'page_pool_item_block' and
  * 'netmem_item_block' are the same.
  */
@@ -188,6 +197,7 @@ struct page_pool {
 	int cpuid;
 	u32 pages_state_hold_cnt;
 	struct llist_head hold_items;
+	struct page_pool_slow_item slow_items;
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dfce02623afa..470c8ccde4ef 100644
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
@@ -418,6 +421,7 @@ static void page_pool_item_uninit(struct page_pool *pool)
 					 struct page_pool_item_block,
 					 list);
 		list_del(&block->list);
+		WARN_ON(refcount_read(&block->ref));
 		put_page(virt_to_page(block));
 	}
 }
@@ -496,10 +500,43 @@ static struct page_pool_item *page_pool_fast_item_alloc(struct page_pool *pool)
 	return llist_entry(first, struct page_pool_item, lentry);
 }
 
+#define PAGE_POOL_SLOW_ITEM_BLOCK_BIT			BIT(0)
+static struct page_pool_item *page_pool_slow_item_alloc(struct page_pool *pool)
+{
+	if (unlikely(!pool->slow_items.block ||
+		     pool->slow_items.next_to_use >= ITEMS_PER_PAGE)) {
+		struct page_pool_item_block *block;
+		struct page *page;
+
+		page = alloc_pages_node(pool->p.nid, GFP_ATOMIC | __GFP_NOWARN |
+					__GFP_ZERO, 0);
+		if (!page) {
+			alloc_stat_inc(pool, item_slow_failed);
+			return NULL;
+		}
+
+		block = page_address(page);
+		block->pp = pool;
+		block->flags |= PAGE_POOL_SLOW_ITEM_BLOCK_BIT;
+		refcount_set(&block->ref, ITEMS_PER_PAGE);
+		pool->slow_items.block = block;
+		pool->slow_items.next_to_use = 0;
+
+		spin_lock_bh(&pool->item_lock);
+		list_add(&block->list, &pool->item_blocks);
+		spin_unlock_bh(&pool->item_lock);
+	}
+
+	return &pool->slow_items.block->items[pool->slow_items.next_to_use++];
+}
+
 static bool page_pool_set_item_info(struct page_pool *pool, netmem_ref netmem)
 {
 	struct page_pool_item *item = page_pool_fast_item_alloc(pool);
 
+	if (unlikely(!item))
+		item = page_pool_slow_item_alloc(pool);
+
 	if (likely(item)) {
 		item->pp_netmem = netmem;
 		page_pool_item_set_used(item);
@@ -509,6 +546,37 @@ static bool page_pool_set_item_info(struct page_pool *pool, netmem_ref netmem)
 	return !!item;
 }
 
+static void __page_pool_slow_item_free(struct page_pool *pool,
+				       struct page_pool_item_block *block)
+{
+	spin_lock_bh(&pool->item_lock);
+	list_del(&block->list);
+	spin_unlock_bh(&pool->item_lock);
+
+	put_page(virt_to_page(block));
+}
+
+static void page_pool_slow_item_drain(struct page_pool *pool)
+{
+	struct page_pool_item_block *block = pool->slow_items.block;
+
+	if (!block || pool->slow_items.next_to_use >= ITEMS_PER_PAGE)
+		return;
+
+	if (refcount_sub_and_test(ITEMS_PER_PAGE - pool->slow_items.next_to_use,
+				  &block->ref))
+		__page_pool_slow_item_free(pool, block);
+}
+
+static void page_pool_slow_item_free(struct page_pool *pool,
+				     struct page_pool_item_block *block)
+{
+	if (likely(!refcount_dec_and_test(&block->ref)))
+		return;
+
+	__page_pool_slow_item_free(pool, block);
+}
+
 static void page_pool_fast_item_free(struct page_pool *pool,
 				     struct page_pool_item *item)
 {
@@ -518,13 +586,22 @@ static void page_pool_fast_item_free(struct page_pool *pool,
 static void page_pool_clear_item_info(struct page_pool *pool, netmem_ref netmem)
 {
 	struct page_pool_item *item = netmem_get_pp_item(netmem);
+	struct page_pool_item_block *block;
 
 	DEBUG_NET_WARN_ON_ONCE(item->pp_netmem != netmem);
 	DEBUG_NET_WARN_ON_ONCE(page_pool_item_is_mapped(item));
 	DEBUG_NET_WARN_ON_ONCE(!page_pool_item_is_used(item));
 	page_pool_item_clear_used(item);
 	netmem_set_pp_item(netmem, NULL);
-	page_pool_fast_item_free(pool, item);
+
+	block = page_pool_item_to_block(item);
+	if (likely(!(block->flags & PAGE_POOL_SLOW_ITEM_BLOCK_BIT))) {
+		DEBUG_NET_WARN_ON_ONCE(refcount_read(&block->ref));
+		page_pool_fast_item_free(pool, item);
+		return;
+	}
+
+	page_pool_slow_item_free(pool, block);
 }
 
 /**
@@ -1339,6 +1416,7 @@ void page_pool_destroy(struct page_pool *pool)
 
 	page_pool_disable_direct_recycling(pool);
 	page_pool_free_frag(pool);
+	page_pool_slow_item_drain(pool);
 
 	if (!page_pool_release(pool))
 		return;
-- 
2.33.0


