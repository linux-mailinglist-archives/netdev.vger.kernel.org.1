Return-Path: <netdev+bounces-157166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40CA091A2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A34188EFA4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA3211298;
	Fri, 10 Jan 2025 13:14:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561A211265;
	Fri, 10 Jan 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514866; cv=none; b=a/7JpfxxVTA7gRVrIkJwcHl2M55is2YlRZrumtNhOVESH6vIb9q2ZRVsmpA23VebPU6/VzHlfCMRTu3n6qoFPbVB+BAk0yrns9wYk5bsw5nVPzZc/OBY4hqMQ6eUszMgkpfof/vnYiE5Krg28WAqef0cQqHWh5FTEwSzLKdTuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514866; c=relaxed/simple;
	bh=EL2MA+bIrsR2m3M/6akl14KgoJ03XzKrxhrcoehg/ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbyqB4tSbu4v4pZatySfnR5xt0smYmaPGh3VSrvSmdeLKZd1cb9Dj9CVpvlXLs17z/7K6UEqQp0sz8BuvW5X9dtPXvAoC7eS6RQAryj34yLDpB6UYr8l7jJ19S3GT0/P6Oz40b5H06tDAD+lSSIigswjUOXfPwkdRTPlTziCnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YV29x08fhz22kFn;
	Fri, 10 Jan 2025 21:12:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E096180044;
	Fri, 10 Jan 2025 21:14:22 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jan 2025 21:14:22 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v7 8/8] page_pool: use list instead of array for alloc cache
Date: Fri, 10 Jan 2025 21:07:02 +0800
Message-ID: <20250110130703.3814407-9-linyunsheng@huawei.com>
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

As the alloc cache is always protected by NAPI context
protection, use encoded_next as a pointer to a next item
to avoid the using the array.

Testing shows there is about 3ns improvement for the
performance of 'time_bench_page_pool01_fast_path' test
case.

CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h |  1 +
 net/core/page_pool.c          | 59 ++++++++++++++++++++++++++++-------
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index d01c5d26cd56..ff6ebacaa57a 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -50,6 +50,7 @@
 #define PP_ALLOC_CACHE_REFILL	64
 struct pp_alloc_cache {
 	u32 count;
+	struct page_pool_item *list;
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 
 	/* Keep batched refilled pages here to avoid doing the atomic operation
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index eb18ab0999e6..459f783a354a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -386,6 +386,27 @@ static netmem_ref page_pool_consume_ring(struct page_pool *pool)
 	return list->pp_netmem;
 }
 
+static netmem_ref __page_pool_consume_alloc(struct page_pool *pool)
+{
+	struct page_pool_item *item = pool->alloc.list;
+
+	pool->alloc.list = page_pool_item_get_next(item);
+	pool->alloc.count--;
+
+	return item->pp_netmem;
+}
+
+static void __page_pool_recycle_in_alloc(struct page_pool *pool,
+					 netmem_ref netmem)
+{
+	struct page_pool_item *item;
+
+	item = netmem_get_pp_item(netmem);
+	page_pool_item_set_next(item, pool->alloc.list);
+	pool->alloc.list = item;
+	pool->alloc.count++;
+}
+
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem,
 							 bool destroyed)
@@ -681,10 +702,12 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
-	struct page_pool_item *refill;
+	struct page_pool_item *refill, *alloc, *curr;
 	netmem_ref netmem;
 	int pref_nid; /* preferred NUMA node */
 
+	DEBUG_NET_WARN_ON_ONCE(pool->alloc.count || pool->alloc.list);
+
 	/* Quicker fallback, avoid locks when ring is empty */
 	refill = pool->alloc.refill;
 	if (unlikely(!refill && !READ_ONCE(pool->ring.list))) {
@@ -702,6 +725,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 	pref_nid = numa_mem_id(); /* will be zero like page_to_nid() */
 #endif
 
+	alloc = NULL;
 	/* Refill alloc array, but only if NUMA match */
 	do {
 		if (unlikely(!refill)) {
@@ -710,10 +734,13 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 				break;
 		}
 
+		curr = refill;
 		netmem = refill->pp_netmem;
 		refill = page_pool_item_get_next(refill);
 		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
-			pool->alloc.cache[pool->alloc.count++] = netmem;
+			page_pool_item_set_next(curr, alloc);
+			pool->alloc.count++;
+			alloc = curr;
 		} else {
 			/* NUMA mismatch;
 			 * (1) release 1 page to page-allocator and
@@ -733,7 +760,9 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
 		atomic_sub(pool->alloc.count, &pool->ring.count);
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = alloc->pp_netmem;
+		pool->alloc.list = page_pool_item_get_next(alloc);
+		pool->alloc.count--;
 		alloc_stat_inc(pool, refill);
 	}
 
@@ -748,7 +777,7 @@ static netmem_ref __page_pool_get_cached(struct page_pool *pool)
 	/* Caller MUST guarantee safe non-concurrent access, e.g. softirq */
 	if (likely(pool->alloc.count)) {
 		/* Fast-path */
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		alloc_stat_inc(pool, fast);
 	} else {
 		netmem = page_pool_refill_alloc_cache(pool);
@@ -867,6 +896,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 							gfp_t gfp)
 {
+	struct page_pool_item *curr, *alloc = NULL;
 	const int bulk = PP_ALLOC_CACHE_REFILL;
 	unsigned int pp_order = pool->p.order;
 	bool dma_map = pool->dma_map;
@@ -877,9 +907,8 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	if (unlikely(pp_order))
 		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
 
-	/* Unnecessary as alloc cache is empty, but guarantees zero count */
-	if (unlikely(pool->alloc.count > 0))
-		return pool->alloc.cache[--pool->alloc.count];
+	/* alloc cache should be empty */
+	DEBUG_NET_WARN_ON_ONCE(pool->alloc.count || pool->alloc.list);
 
 	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array */
 	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
@@ -907,7 +936,11 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 			continue;
 		}
 
-		pool->alloc.cache[pool->alloc.count++] = netmem;
+		curr = netmem_get_pp_item(netmem);
+		page_pool_item_set_next(curr, alloc);
+		pool->alloc.count++;
+		alloc = curr;
+
 		/* Track how many pages are held 'in-flight' */
 		pool->pages_state_hold_cnt++;
 		trace_page_pool_state_hold(pool, netmem,
@@ -916,7 +949,9 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = alloc->pp_netmem;
+		pool->alloc.list = page_pool_item_get_next(alloc);
+		pool->alloc.count--;
 		alloc_stat_inc(pool, slow);
 	} else {
 		netmem = 0;
@@ -1086,7 +1121,7 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
 	}
 
 	/* Caller MUST have verified/know (page_ref_count(page) == 1) */
-	pool->alloc.cache[pool->alloc.count++] = netmem;
+	__page_pool_recycle_in_alloc(pool, netmem);
 	recycle_stat_inc(pool, cached);
 	return true;
 }
@@ -1431,7 +1466,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 * call concurrently.
 	 */
 	while (pool->alloc.count) {
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		page_pool_return_page(pool, netmem);
 	}
 
@@ -1571,7 +1606,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		__page_pool_return_page(pool, netmem, false);
 	}
 }
-- 
2.33.0


