Return-Path: <netdev+bounces-151755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469769F0C62
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4029E188C85C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447E1E0E10;
	Fri, 13 Dec 2024 12:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B71DF99C;
	Fri, 13 Dec 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093284; cv=none; b=GWcrpFGaWZSH0WecEpRm9PPA/GXhoTx7MKD15nxcvDm0zv2PaVJJls4c/C7Iry3bBtuGal1hoo5Wl46V4AlWOs1tMUsMp0X5HNYToCuiXRmNhvpx6Y8YhgATu2HapLfy/6rGumsvpvXCCQjhITaDKrPBAaI7j8vFwQr2U/mUcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093284; c=relaxed/simple;
	bh=uG+2B7QwO5PxCKkhbuffYx9T5lY4r7fdNjOL3L9RLBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChOluWH+rmdRyh6pkr67QE+WWVQtLfJJKURV9VxrFewg4PnCngJdi8V7sn1iQhlb4Lh0RF7x6tfPrsGT2EhQhda2QBY9GHjMNDywNm62lM9uWUIj3M+uQ5Zswp3unEUAGN4UQJY9SyXsDk1TpHmoMASmqs/o12LbV2XkaA6T850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y8pc36XNwz1V6DL;
	Fri, 13 Dec 2024 20:31:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FC6D140155;
	Fri, 13 Dec 2024 20:34:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 20:34:40 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <somnath.kotur@broadcom.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFCv5 5/8] page_pool: skip dma sync operation for inflight pages
Date: Fri, 13 Dec 2024 20:27:36 +0800
Message-ID: <20241213122739.4050137-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241213122739.4050137-1-linyunsheng@huawei.com>
References: <20241213122739.4050137-1-linyunsheng@huawei.com>
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
 net/core/page_pool.c | 58 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 69a117c6f17e..678b5240f918 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -279,9 +279,6 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
-
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
 		 * configuration doesn't change while we're initializing
@@ -319,9 +316,6 @@ static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->dma_map)
-		put_device(pool->p.dev);
-
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
@@ -747,6 +741,25 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
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
@@ -1008,7 +1021,8 @@ static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	rcu_read_unlock();
 }
 
-static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem,
+				      unsigned int dma_sync_size)
 {
 	int ret;
 	/* BH protection not needed if current is softirq */
@@ -1017,12 +1031,12 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
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
@@ -1075,10 +1089,10 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
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
@@ -1141,7 +1155,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 
 	netmem =
 		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
-	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
+	if (netmem && !page_pool_recycle_in_ring(pool, netmem, dma_sync_size)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
@@ -1199,13 +1213,19 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
+	rcu_read_lock();
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, data[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
 		}
+
+		page_pool_dma_sync_for_device(pool, (__force netmem_ref)data[i],
+					      -1);
 	}
+
+	rcu_read_unlock();
 	recycle_stat_add(pool, ring, i);
 	page_pool_producer_unlock(pool, in_softirq);
 
@@ -1446,6 +1466,16 @@ void page_pool_destroy(struct page_pool *pool)
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


