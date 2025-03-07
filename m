Return-Path: <netdev+bounces-172833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7AA5645F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1301892168
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6055206F2E;
	Fri,  7 Mar 2025 09:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B619C575;
	Fri,  7 Mar 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341061; cv=none; b=l7RQ8XPXUKVGOyHRb4jZPTK6eJayLkkVn6/UhjHtQkIXLc4OM6bI6O6A6IoveTTP8emaeXkfaMZ+efvF+lVyBWOREb1S5s80Ajd0CSkTLwBngeVDLOAoq6Ap6BCdA+HWnGhXOhzB0gIhN23SKtZ+oAaBU0yyjjjNnylFaF2kPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341061; c=relaxed/simple;
	bh=9tHrYYqtQxnelrQhcOndg0qSH3TjJtxGF8QFkZupR5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC/ym2WxdYs5haDDzYZKRtvS1owMQjJyDfDBmop7hzp2W31cpazup2ivccPCUDoHtjCqXyd8bf6g4VLbm62QGOEwugyvvTPzQn3gp9SNFepUI6QDNDXDO1YZwHF8tTtmtD/yex+K1LszziZOIzbmlHsi3+npUVEUY81EJsTrP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z8Lc16xDzzpbYr;
	Fri,  7 Mar 2025 17:30:09 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DA3518006C;
	Fri,  7 Mar 2025 17:31:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 17:31:39 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 4/4] page_pool: skip dma sync operation for inflight pages
Date: Fri, 7 Mar 2025 17:23:55 +0800
Message-ID: <20250307092356.638242-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250307092356.638242-1-linyunsheng@huawei.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Skip dma sync operation for inflight pages before the
sync operation in page_pool_item_unmap() as DMA API
expects to be called with a valid device bound to a
driver as mentioned in [1].

After page_pool_destroy() is called, the page is not
expected to be recycled back to pool->alloc cache and
dma sync operation is not needed when the page is not
recyclable or pool->ring is full, so only skip the dma
sync operation for the infilght pages by clearing the
pool->dma_sync, as rcu sync operation in
page_pool_destroy() is paired with rcu lock in
page_pool_recycle_in_ring() to ensure that there is no
dma sync operation called after rcu sync operation.

1. https://lore.kernel.org/all/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/core/page_pool.c | 56 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dbac9d4b9ea8..1cb8fc62c54a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -281,9 +281,6 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -330,9 +327,6 @@ static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->dma_map)
-		put_device(pool->p.dev);
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
@@ -484,6 +478,16 @@ static void page_pool_item_unmap(struct page_pool *pool)
 	if (!pool->dma_map || pool->mp_priv)
 		return;
 
+	/* After page_pool_destroy() is called, the page is not expected to be
+	 * recycled back to pool->alloc cache and dma sync operation is not
+	 * needed when the page is not recyclable or pool->ring is full, skip
+	 * the dma sync operation for the infilght pages by clearing the
+	 * pool->dma_sync, and the below synchronize_net() is paired with rcu
+	 * lock when page is recycled back into ptr_ring to ensure that there is
+	 * no dma sync operation called after rcu sync operation.
+	 */
+	pool->dma_sync = false;
+
 	/* Paired with rcu read lock in __page_pool_release_page_dma() to
 	 * synchronize dma unmapping operations.
 	 */
@@ -767,6 +771,25 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
+static __always_inline void
+page_pool_dma_sync_for_device_rcu(const struct page_pool *pool,
+				  netmem_ref netmem,
+				  u32 dma_sync_size)
+{
+	if (!pool->dma_sync || !dma_dev_need_sync(pool->p.dev))
+		return;
+
+	rcu_read_lock();
+
+	/* Recheck the dma_sync under rcu lock to pair with rcu sync operation
+	 * in page_pool_destroy().
+	 */
+	if (likely(pool->dma_sync))
+		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+
+	rcu_read_unlock();
+}
+
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 {
 	struct page_pool_item *item;
@@ -1004,7 +1027,8 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	 */
 }
 
-static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem,
+				      unsigned int dma_sync_size)
 {
 	int ret;
 	/* BH protection not needed if current is softirq */
@@ -1013,12 +1037,12 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 	else
 		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
 
-	if (!ret) {
+	if (likely(!ret)) {
+		page_pool_dma_sync_for_device_rcu(pool, netmem, dma_sync_size);
 		recycle_stat_inc(pool, ring);
-		return true;
 	}
 
-	return false;
+	return !ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -1071,10 +1095,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	if (likely(__page_pool_page_can_be_recycled(netmem))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
-
-		if (allow_direct && page_pool_recycle_in_cache(netmem, pool))
+		if (allow_direct && page_pool_recycle_in_cache(netmem, pool)) {
+			page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 			return 0;
+		}
 
 		/* Page found as candidate for recycling */
 		return netmem;
@@ -1130,7 +1154,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 
 	netmem =
 		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
-	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
+	if (netmem && !page_pool_recycle_in_ring(pool, netmem, dma_sync_size)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
@@ -1156,14 +1180,18 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	/* Bulk produce into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
 
+	rcu_read_lock();
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
 		}
+
+		page_pool_dma_sync_for_device(pool, bulk[i], -1);
 	}
 
+	rcu_read_unlock();
 	page_pool_producer_unlock(pool, in_softirq);
 	recycle_stat_add(pool, ring, i);
 
-- 
2.33.0


