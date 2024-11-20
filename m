Return-Path: <netdev+bounces-146457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E19D3887
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0143C1F23D7D
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FC19EED7;
	Wed, 20 Nov 2024 10:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C819D060;
	Wed, 20 Nov 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099305; cv=none; b=Z38+ApbL/XeJbILBkP85+3mGW6AYHEFRqeTQvNSqa1ra/1iF1cOWM5T/o6ugIJmXwscyuq7qNnUITy3oDBOXbO/d57kHxft9aosH+OdPvfA/4645m4dT8jjKWvtc0ykNHUej/L+TE5y2Az6Gy1zKcJ6PnRTxLNjJTs0Z6oEJ/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099305; c=relaxed/simple;
	bh=mcby2DGppHd18uHygt54sfA41+/bgOa1b8xhVO49ZeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX1ISy/f8mtJ32h9fbNk85Av6Gm0wgQbNK4IWyMIkvyDSnSVCtJK4WucqyNlXSjS37u2o7wyikTu/t6/EPvV92ktARYtb5dGfJrVuM4kMxj+ZdYS6HweSMdEB022kt22vKEIK2Y1pcNPiIHCis/VMPvro1ZZCWpH6u6EoRxEOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XtdBs1qkjz1V4dw;
	Wed, 20 Nov 2024 18:39:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 819D01800F2;
	Wed, 20 Nov 2024 18:41:39 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 18:41:39 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v4 3/3] page_pool: skip dma sync operation for inflight pages
Date: Wed, 20 Nov 2024 18:34:55 +0800
Message-ID: <20241120103456.396577-4-linyunsheng@huawei.com>
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

Skip dma sync operation for inflight pages before the
page_pool_destroy() returns to the driver as DMA API
expects to be called with a valid device bound to a
driver as mentioned in [1].

After page_pool_destroy() is called, the page is not
expected to be recycled back to pool->alloc cache and
dma sync operation is not needed when the page is not
recyclable or pool->ring is full, so only skip the dma
sync operation for the infilght pages by clearing the
pool->dma_sync under protection of rcu lock when page
is recycled to pool->ring to ensure that there is no
dma sync operation called after page_pool_destroy() is
returned.

1. https://lore.kernel.org/all/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: IOMMU <iommu@lists.linux.dev>
CC: MM <linux-mm@kvack.org>
Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/core/page_pool.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 33a314abbba4..0bde7c6c781a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -712,7 +712,8 @@ static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	rcu_read_unlock();
 }
 
-static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem,
+				      unsigned int dma_sync_size)
 {
 	int ret;
 	/* BH protection not needed if current is softirq */
@@ -723,10 +724,13 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
 
 	if (!ret) {
 		recycle_stat_inc(pool, ring);
-		return true;
+
+		rcu_read_lock();
+		page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+		rcu_read_unlock();
 	}
 
-	return false;
+	return !ret;
 }
 
 /* Only allow direct recycling in special circumstances, into the
@@ -779,10 +783,11 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 	if (likely(__page_pool_page_can_be_recycled(netmem))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
-
-		if (allow_direct && page_pool_recycle_in_cache(netmem, pool))
+		if (allow_direct && page_pool_recycle_in_cache(netmem, pool)) {
+			page_pool_dma_sync_for_device(pool, netmem,
+						      dma_sync_size);
 			return 0;
+		}
 
 		/* Page found as candidate for recycling */
 		return netmem;
@@ -845,7 +850,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 
 	netmem =
 		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
-	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
+	if (netmem && !page_pool_recycle_in_ring(pool, netmem, dma_sync_size)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
 		page_pool_return_page(pool, netmem);
@@ -903,14 +908,18 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 
 	/* Bulk producer into ptr_ring page_pool cache */
 	in_softirq = page_pool_producer_lock(pool);
+	rcu_read_lock();
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, data[i])) {
 			/* ring full */
 			recycle_stat_inc(pool, ring_full);
 			break;
 		}
+		page_pool_dma_sync_for_device(pool, (__force netmem_ref)data[i],
+					      -1);
 	}
 	recycle_stat_add(pool, ring, i);
+	rcu_read_unlock();
 	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages was return into ptr_ring */
@@ -1200,6 +1209,8 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_release(pool))
 		return;
 
+	pool->dma_sync = false;
+
 	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
 	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
 	 * before returning to driver to free the napi instance.
-- 
2.33.0


