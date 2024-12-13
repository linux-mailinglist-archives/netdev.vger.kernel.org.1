Return-Path: <netdev+bounces-151757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7D9F0C68
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B51188D796
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561971E2312;
	Fri, 13 Dec 2024 12:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4391E1C37;
	Fri, 13 Dec 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093295; cv=none; b=hfLhFeGO2GnaSoRuXsg/gPQzuIjXrTRcOfHLwH/vsZImivBCHm0Xcfgn5/fe0rtcQFHjM21xB9ka2qqd83VIi+/9TVeGNv6XmQp15lM9rm6i4njYisq0Vj0wWbOIK1YEtZMPb1crEgJU5pIJ+iYsaxzjLwQyFpy791GeEpHzCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093295; c=relaxed/simple;
	bh=V+FcFi40szJKLxEZqWWlC5I8GTUqTKvhnT1en4Oi5sQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFFWHXX8GC/7p9fxTFfaUJWTy7M2uh+V2Rz4X02aLaeUhLjwPWhJEFClaVYMpmTH8aEDfiaGcRA3qo0YA43WqSUB5J6caczhaF2SClu69UXqyef91fhOS0uTStiTm4TbBgrMWKQS26jslr6LX8bch55+yJEgMzol7rR1okdstyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y8phD0QQDz20ldN;
	Fri, 13 Dec 2024 20:35:08 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 571D51A016C;
	Fri, 13 Dec 2024 20:34:50 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 20:34:50 +0800
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
Subject: [PATCH RFCv5 7/8] page_pool: batch refilling pages to reduce atomic operation
Date: Fri, 13 Dec 2024 20:27:38 +0800
Message-ID: <20241213122739.4050137-8-linyunsheng@huawei.com>
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

Add refill variable in alloc cache to keep batched refilled
pages to avoid doing the atomic operation for each page.

Testing shows there is about 10ns improvement for the
performance of 'time_bench_page_pool02_ptr_ring' test case.

CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h |  5 +++++
 net/core/page_pool.c          | 25 +++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 0a7309d9ff1a..be50a25c4aa0 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -51,6 +51,11 @@
 struct pp_alloc_cache {
 	u32 count;
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
+
+	/* Keep batched refilled pages here to avoid doing the atomic operation
+	 * for each page.
+	 */
+	struct page_pool_item *refill;
 };
 
 /**
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dcda837392bf..ab832bfa004b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -673,11 +673,13 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
+	struct page_pool_item *refill;
 	netmem_ref netmem;
 	int pref_nid; /* preferred NUMA node */
 
 	/* Quicker fallback, avoid locks when ring is empty */
-	if (unlikely(!READ_ONCE(pool->ring.list))) {
+	refill = pool->alloc.refill;
+	if (unlikely(!refill && !READ_ONCE(pool->ring.list))) {
 		alloc_stat_inc(pool, empty);
 		return 0;
 	}
@@ -694,10 +696,14 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 
 	/* Refill alloc array, but only if NUMA match */
 	do {
-		netmem = page_pool_consume_ring(pool);
-		if (unlikely(!netmem))
-			break;
+		if (unlikely(!refill)) {
+			refill = xchg(&pool->ring.list, NULL);
+			if (!refill)
+				break;
+		}
 
+		netmem = refill->pp_netmem;
+		refill = page_pool_item_get_next(refill);
 		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
 			pool->alloc.cache[pool->alloc.count++] = netmem;
 		} else {
@@ -707,14 +713,18 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			 * This limit stress on page buddy alloactor.
 			 */
 			__page_pool_return_page(pool, netmem, false);
+			atomic_dec(&pool->ring.count);
 			alloc_stat_inc(pool, waive);
 			netmem = 0;
 			break;
 		}
 	} while (pool->alloc.count < PP_ALLOC_CACHE_REFILL);
 
+	pool->alloc.refill = refill;
+
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
+		atomic_sub(pool->alloc.count, &pool->ring.count);
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, refill);
 	}
@@ -1371,6 +1381,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 
 static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 {
+	struct page_pool_item *refill;
 	netmem_ref netmem;
 
 	if (pool->destroy_cnt)
@@ -1384,6 +1395,12 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		page_pool_return_page(pool, netmem);
 	}
+
+	while ((refill = pool->alloc.refill)) {
+		pool->alloc.refill = page_pool_item_get_next(refill);
+		page_pool_return_page(pool, refill->pp_netmem);
+		atomic_dec(&pool->ring.count);
+	}
 }
 
 static void page_pool_scrub(struct page_pool *pool)
-- 
2.33.0


