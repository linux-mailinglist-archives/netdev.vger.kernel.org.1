Return-Path: <netdev+bounces-157163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E94A0919C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C03188E821
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB352101A0;
	Fri, 10 Jan 2025 13:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8220E031;
	Fri, 10 Jan 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514860; cv=none; b=KZe85+UewOypZd+th4K9bZjmlMSRGJEMBOkwzgNspHyPWEZscZLLiPTsK+tCKz8IXtglOgk8vb1PmVeKCXSLVF3ygCs/7QSO2K0Mps5UvGxJk5ACmet7KRNucxQo48YNabNZ1METG+KsxllTw3biQRknUlmIY9U3QnNcBOFxEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514860; c=relaxed/simple;
	bh=ga4vJS4n6etc965f8lVJK+wyXoyNhUIIPKkMs3P9VIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIZJYobDvrDaUCLiK/tH6cs30YT+YOyALrBgbD1qsdjhLRIzj82b9VFUa0l4M693BGAqVTafbO1eVKBwWHEBjw0y7Q5iqYecE0CGUIDJ/0d+sgWmnk010Xjo4O+F3jrDSsPE/NQ5yLHaWQj/AipvRqXD3jLklc0NxnNIQZPrDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YV28v4ZBMz1V4Z9;
	Fri, 10 Jan 2025 21:11:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 55732180044;
	Fri, 10 Jan 2025 21:14:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 21:14:16 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v7 5/8] page_pool: skip dma sync operation for inflight pages
Date: Fri, 10 Jan 2025 21:06:59 +0800
Message-ID: <20250110130703.3814407-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250110130703.3814407-1-linyunsheng@huawei.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
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

Skip dma sync operation for inflight pages before the
page_pool_destroy() returns to the driver as DMA API
expects to be called with a valid device bound to a
driver as mentioned in [1].

After page_pool_destroy() is called, the page is not
expected to be recycled back to pool->alloc cache and
dma sync operation is not needed when the page is not
recyclable or pool->ring is full, so only skip the dma
sync operation for the infilght pages by clearing the
pool->dma_sync, as synchronize_rcu() in
page_pool_destroy() is paired with rcu lock in
page_pool_recycle_in_ring() to ensure that there is no
dma syncoperation called after page_pool_destroy() is
returned.

1. https://lore.kernel.org/all/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/core/page_pool.c | 57 ++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f65d946e964b..232ab56f7fac 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -280,9 +280,6 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -323,9 +320,6 @@ static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->dma_map)
-		put_device(pool->p.dev);
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
@@ -755,6 +749,25 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 
+static __always_inline void
+page_pool_dma_sync_for_device_rcu(const struct page_pool *pool,
+				  netmem_ref netmem,
+				  u32 dma_sync_size)
+{
+	if (!pool->dma_sync)
+		return;
+
+	rcu_read_lock();
+
+	/* Recheck the dma_sync under rcu lock to pair with synchronize_rcu() in
+	 * page_pool_destroy().
+	 */
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+
+	rcu_read_unlock();
+}
+
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 {
 	struct page_pool_item *item;
@@ -1016,7 +1029,8 @@ static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	rcu_read_unlock();
 }
 
-static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem,
+				      unsigned int dma_sync_size)
 {
 	int ret;
 	/* BH protection not needed if current is softirq */
@@ -1025,12 +1039,12 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
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
@@ -1083,10 +1097,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
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
@@ -1149,7 +1163,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 
 	netmem =
 		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
-	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
+	if (netmem && !page_pool_recycle_in_ring(pool, netmem, dma_sync_size)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
@@ -1175,14 +1189,17 @@ static void page_pool_recycle_ring_bulk(struct page_pool *pool,
 	/* Bulk produce into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
 
+	rcu_read_lock();
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
 		}
+		page_pool_dma_sync_for_device(pool, (__force netmem_ref)bulk[i],
+					      -1);
 	}
-
+	rcu_read_unlock();
 	page_pool_producer_unlock(pool, in_softirq);
 	recycle_stat_add(pool, ring, i);
 
@@ -1489,6 +1506,16 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	/* After page_pool_destroy() is called, the page is not expected to be
+	 * recycled back to pool->alloc cache and dma sync operation is not
+	 * needed when the page is not recyclable or pool->ring is full, so only
+	 * skip the dma sync operation for the infilght pages by clearing the
+	 * pool->dma_sync, and the synchronize_rcu() is paired with rcu lock in
+	 * page_pool_recycle_in_ring() to ensure that there is no dma sync
+	 * operation called after page_pool_destroy() is returned.
+	 */
+	pool->dma_sync = false;
+
 	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
 	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
 	 * before returning to driver to free the napi instance.
-- 
2.33.0


