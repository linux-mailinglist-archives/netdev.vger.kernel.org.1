Return-Path: <netdev+bounces-146456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDAB9D3885
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F7BB21E61
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F619D89E;
	Wed, 20 Nov 2024 10:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B19CC20;
	Wed, 20 Nov 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099304; cv=none; b=XOeqcZ4ZIMejLGnSzDMkZT7PzjxityMbX9eePax6EKAyp9x9DVcuqAyLpyWHQ+FU1bV67yT/876G061fmox/vbZrH0kvjsZW1PAFlc8cPhUzWsPDgLxbU1vMp4uEw87o5Qfv3LOSjcwfPc2pK+fCzPUgJ+sFyA5B9NpLimsRZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099304; c=relaxed/simple;
	bh=RYgkZEqCorElXt0EcI+64LUaN0vsbRHSMoUBTH0s8gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNLwRhmeRiQwY2cg2hcBnH9cxBpdNzYZ/HZN2UgF69HigFSPVVGM4D6654i8srKmVxrHlMgqMwWCAC3t4ZtJeGAsKLexzOPxpxYYePOgURSeonipwyie51K673qrq2KZFGfFwjGA2OdECB/ITOvpsJK7mpmAnb74ZzbuT3hnz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XtdBk3Qb5z92Nn;
	Wed, 20 Nov 2024 18:38:54 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D61F9140360;
	Wed, 20 Nov 2024 18:41:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 18:41:37 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has already unbound
Date: Wed, 20 Nov 2024 18:34:54 +0800
Message-ID: <20241120103456.396577-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241120103456.396577-1-linyunsheng@huawei.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
driver, scan the inflight pages using some MM API to do the DMA
unmmapping for those pages when page_pool_destroy() is called.

The max time of scanning inflight pages is about 1.3 sec for
system with over 300GB memory as mentioned in [3], which seems
acceptable as the scanning is only done when there are indeed
some inflight pages and is done in the slow path.

Note, the devmem patchset seems to make the bug harder to fix,
and may make backporting harder too. As there is no actual user
for the devmem and the fixing for devmem is unclear for now,
this patch does not consider fixing the case for devmem yet.

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
2. https://github.com/netoptimizer/prototype-kernel
3. https://lore.kernel.org/all/17a24d69-7bf0-412c-a32a-b25d82bb4159@kernel.org/
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
---
 include/net/page_pool/types.h |  6 ++-
 net/core/page_pool.c          | 95 ++++++++++++++++++++++++++++++-----
 2 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..7393fd45bc47 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -228,7 +228,11 @@ struct page_pool {
 	 */
 	refcount_t user_cnt;
 
-	u64 destroy_cnt;
+	/* Lock to avoid doing dma unmapping concurrently when
+	 * destroy_cnt > 0.
+	 */
+	spinlock_t destroy_lock;
+	unsigned int destroy_cnt;
 
 	/* Slow/Control-path information follows */
 	struct page_pool_params_slow slow;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b3dae671eb26..33a314abbba4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -272,9 +272,6 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -312,9 +309,6 @@ static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->dma_map)
-		put_device(pool->p.dev);
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
@@ -365,7 +359,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 }
 EXPORT_SYMBOL(page_pool_create);
 
-static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
+static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem);
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
@@ -403,7 +397,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			 * (2) break out to fallthrough to alloc_pages_node.
 			 * This limit stress on page buddy alloactor.
 			 */
-			page_pool_return_page(pool, netmem);
+			__page_pool_return_page(pool, netmem);
 			alloc_stat_inc(pool, waive);
 			netmem = 0;
 			break;
@@ -670,7 +664,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
  * a regular page (that will eventually be returned to the normal
  * page-allocator via put_page).
  */
-void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
+void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 {
 	int count;
 	bool put;
@@ -697,6 +691,27 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
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
+		spin_lock_bh(&pool->destroy_lock);
+		__page_pool_return_page(pool, netmem);
+		spin_unlock_bh(&pool->destroy_lock);
+	} else {
+		__page_pool_return_page(pool, netmem);
+	}
+
+	rcu_read_unlock();
+}
+
 static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 {
 	int ret;
@@ -924,7 +939,7 @@ static netmem_ref page_pool_drain_frag(struct page_pool *pool,
 		return netmem;
 	}
 
-	page_pool_return_page(pool, netmem);
+	__page_pool_return_page(pool, netmem);
 	return 0;
 }
 
@@ -938,7 +953,7 @@ static void page_pool_free_frag(struct page_pool *pool)
 	if (!netmem || page_pool_unref_netmem(netmem, drain_count))
 		return;
 
-	page_pool_return_page(pool, netmem);
+	__page_pool_return_page(pool, netmem);
 }
 
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
@@ -1045,7 +1060,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 static void page_pool_scrub(struct page_pool *pool)
 {
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	WRITE_ONCE(pool->destroy_cnt, pool->destroy_cnt + 1);
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
@@ -1119,6 +1134,58 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
 }
 EXPORT_SYMBOL(page_pool_disable_direct_recycling);
 
+static void page_pool_inflight_unmap(struct page_pool *pool)
+{
+	unsigned int unmapped = 0;
+	struct zone *zone;
+	int inflight;
+
+	if (!pool->dma_map || pool->mp_priv)
+		return;
+
+	get_online_mems();
+	spin_lock_bh(&pool->destroy_lock);
+
+	inflight = page_pool_inflight(pool, false);
+	for_each_populated_zone(zone) {
+		unsigned long end_pfn = zone_end_pfn(zone);
+		unsigned long pfn;
+
+		for (pfn = zone->zone_start_pfn; pfn < end_pfn; pfn++) {
+			struct page *page = pfn_to_online_page(pfn);
+
+			if (!page || !page_count(page) ||
+			    (page->pp_magic & ~0x3UL) != PP_SIGNATURE ||
+			    page->pp != pool)
+				continue;
+
+			dma_unmap_page_attrs(pool->p.dev,
+					     page_pool_get_dma_addr(page),
+					     PAGE_SIZE << pool->p.order,
+					     pool->p.dma_dir,
+					     DMA_ATTR_SKIP_CPU_SYNC |
+					     DMA_ATTR_WEAK_ORDERING);
+			page_pool_set_dma_addr(page, 0);
+
+			unmapped++;
+
+			/* Skip scanning all pages when debug is disabled */
+			if (!IS_ENABLED(CONFIG_DEBUG_NET) &&
+			    inflight == unmapped)
+				goto out;
+		}
+	}
+
+out:
+	WARN_ONCE(page_pool_inflight(pool, false) != unmapped,
+		  "page_pool(%u): unmapped(%u) != inflight pages(%d)\n",
+		  pool->user.id, unmapped, inflight);
+
+	pool->dma_map = false;
+	spin_unlock_bh(&pool->destroy_lock);
+	put_online_mems();
+}
+
 void page_pool_destroy(struct page_pool *pool)
 {
 	if (!pool)
@@ -1139,6 +1206,8 @@ void page_pool_destroy(struct page_pool *pool)
 	 */
 	synchronize_rcu();
 
+	page_pool_inflight_unmap(pool);
+
 	page_pool_detached(pool);
 	pool->defer_start = jiffies;
 	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
@@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
 		netmem = pool->alloc.cache[--pool->alloc.count];
-		page_pool_return_page(pool, netmem);
+		__page_pool_return_page(pool, netmem);
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
-- 
2.33.0


