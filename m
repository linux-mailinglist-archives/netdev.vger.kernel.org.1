Return-Path: <netdev+bounces-155461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A8A0263F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F70C3A551D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09DC1DF271;
	Mon,  6 Jan 2025 13:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17461DEFF7;
	Mon,  6 Jan 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168927; cv=none; b=NYoDkCYNJIlS9oJZfbIn5ZJRmeEtam7gUCnI1XRTOJgjJl/LR4uRwWulbG2nRNA21ucKRZH/C/sVJjYkJWfokaa++gyjIMJiofptm0DkIuCSRNNwJrbybe+pvBhmobIg6rYgBR7WmASRZZI5tLrL4PkYNMIj/Q2Q7QnJ7SXwSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168927; c=relaxed/simple;
	bh=pK90hb9orWRZ9OqTozGQCdwNJyO2Ck9ddwhLcvosOUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9Y0bmdt69aj2WIGlx7/WxOIQTQrqPYY0yMIgjlgw6yAj4NBLXckfW1NJxNdzifGp4QRPvwbgJtsx7GpXNYor/1pv3sUr8QpbAcc2DoCzVKYkKZwp5VkJG5sdXA539b0WLWRBH0ug0FFoY6dLhzlisuIYKb5dAPJdUBT8bzpMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YRZDR3gs0z2Dk4n;
	Mon,  6 Jan 2025 21:05:43 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8045A140135;
	Mon,  6 Jan 2025 21:08:42 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 21:08:42 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 8/8] page_pool: use list instead of array for alloc cache
Date: Mon, 6 Jan 2025 21:01:16 +0800
Message-ID: <20250106130116.457938-9-linyunsheng@huawei.com>
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
 include/net/page_pool/types.h |  2 +-
 net/core/page_pool.c          | 59 +++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ac83abea24b0..97f548c79e22 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -50,7 +50,7 @@
 #define PP_ALLOC_CACHE_REFILL	64
 struct pp_alloc_cache {
 	u32 count;
-	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
+	struct page_pool_item *list;
 
 	/* Keep batched refilled pages here to avoid doing the atomic operation
 	 * for each page.
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 429d44ede074..59aea3abf0eb 100644
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
@@ -677,10 +698,12 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
 
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
@@ -698,6 +721,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 	pref_nid = numa_mem_id(); /* will be zero like page_to_nid() */
 #endif
 
+	alloc = NULL;
 	/* Refill alloc array, but only if NUMA match */
 	do {
 		if (unlikely(!refill)) {
@@ -706,10 +730,13 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
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
@@ -729,7 +756,8 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
 		atomic_sub(pool->alloc.count, &pool->ring.count);
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		pool->alloc.list = page_pool_item_get_next(alloc);
+		pool->alloc.count--;
 		alloc_stat_inc(pool, refill);
 	}
 
@@ -744,7 +772,7 @@ static netmem_ref __page_pool_get_cached(struct page_pool *pool)
 	/* Caller MUST guarantee safe non-concurrent access, e.g. softirq */
 	if (likely(pool->alloc.count)) {
 		/* Fast-path */
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		alloc_stat_inc(pool, fast);
 	} else {
 		netmem = page_pool_refill_alloc_cache(pool);
@@ -863,6 +891,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 							gfp_t gfp)
 {
+	netmem_ref netmems[PP_ALLOC_CACHE_REFILL] = {0};
 	const int bulk = PP_ALLOC_CACHE_REFILL;
 	unsigned int pp_order = pool->p.order;
 	bool dma_map = pool->dma_map;
@@ -873,16 +902,12 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	if (unlikely(pp_order))
 		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
 
-	/* Unnecessary as alloc cache is empty, but guarantees zero count */
-	if (unlikely(pool->alloc.count > 0))
-		return pool->alloc.cache[--pool->alloc.count];
-
-	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array */
-	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
+	/* alloc cache should be empty */
+	DEBUG_NET_WARN_ON_ONCE(pool->alloc.count || pool->alloc.list);
 
 	nr_pages = alloc_pages_bulk_array_node(gfp,
 					       pool->p.nid, bulk,
-					       (struct page **)pool->alloc.cache);
+					       (struct page **)netmems);
 	if (unlikely(!nr_pages))
 		return 0;
 
@@ -890,7 +915,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 * page element have not been (possibly) DMA mapped.
 	 */
 	for (i = 0; i < nr_pages; i++) {
-		netmem = pool->alloc.cache[i];
+		netmem = netmems[i];
 
 		if (unlikely(!page_pool_set_pp_info(pool, netmem))) {
 			put_page(netmem_to_page(netmem));
@@ -903,7 +928,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 			continue;
 		}
 
-		pool->alloc.cache[pool->alloc.count++] = netmem;
+		__page_pool_recycle_in_alloc(pool, netmem);
 		/* Track how many pages are held 'in-flight' */
 		pool->pages_state_hold_cnt++;
 		trace_page_pool_state_hold(pool, netmem,
@@ -912,7 +937,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		alloc_stat_inc(pool, slow);
 	} else {
 		netmem = 0;
@@ -1082,7 +1107,7 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
 	}
 
 	/* Caller MUST have verified/know (page_ref_count(page) == 1) */
-	pool->alloc.cache[pool->alloc.count++] = netmem;
+	__page_pool_recycle_in_alloc(pool, netmem);
 	recycle_stat_inc(pool, cached);
 	return true;
 }
@@ -1427,7 +1452,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 * call concurrently.
 	 */
 	while (pool->alloc.count) {
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		page_pool_return_page(pool, netmem);
 	}
 
@@ -1567,7 +1592,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
-		netmem = pool->alloc.cache[--pool->alloc.count];
+		netmem = __page_pool_consume_alloc(pool);
 		__page_pool_return_page(pool, netmem, false);
 	}
 }
-- 
2.33.0


