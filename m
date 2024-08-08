Return-Path: <netdev+bounces-116847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362E94BDE0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D60B25687
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63217126F1E;
	Thu,  8 Aug 2024 12:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35418F2FC;
	Thu,  8 Aug 2024 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120999; cv=none; b=hX8h6mziZuDy5EaqvGghkjcL0LyTPouImurOQ2NwyZeD/hcJnpvlIx5uy/NqFbCLK0ACWPIR3RCn2BYcI24VP0T7NtvDtPmQP7h/uq7fntO9+N1tKQMicuE3LvGmyLB/KI71pCx3MyTPxlMoqLtBMsx6E7GQ4fyx9PyNna/Dy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120999; c=relaxed/simple;
	bh=1cNBvGfpE9Sd//Mt8Sdvn6uQfUFMHfBUMfGZXcP16wM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZYUc3AekFkBgIa9GMejFU35nSqPLnUCl9wgORxb+WpCnLmxBov1vp9x/k2F2rjFfmr587znffpQRvUtJ5Chog32PPeTXwXY26i0KFcv/Wu/tx8/uPO9Q9aYELT1NUNodLdN4pwedL5/Wl/YOPJNmWdaGmtqN94ZBE5FNXoJF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wfmpn0QBnz1HG6M;
	Thu,  8 Aug 2024 20:40:17 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E4CE31400C9;
	Thu,  8 Aug 2024 20:43:14 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:43:14 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v13 08/14] mm: page_frag: some minor refactoring before adding new API
Date: Thu, 8 Aug 2024 20:37:08 +0800
Message-ID: <20240808123714.462740-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240808123714.462740-1-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Refactor common codes from __page_frag_alloc_va_align()
to __page_frag_cache_reload(), so that the new API can
make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |   2 +-
 mm/page_frag_cache.c            | 138 ++++++++++++++++++--------------
 2 files changed, 81 insertions(+), 59 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 4ce924eaf1b1..0abffdd10a1c 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -52,7 +52,7 @@ static inline void *encoded_page_address(unsigned long encoded_va)
 
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
-	nc->encoded_va = 0;
+	memset(nc, 0, sizeof(*nc));
 }
 
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 2544b292375a..4e6b1c4684f0 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -19,8 +19,27 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
-static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
-					     gfp_t gfp_mask)
+static bool __page_frag_cache_reuse(unsigned long encoded_va,
+				    unsigned int pagecnt_bias)
+{
+	struct page *page;
+
+	page = virt_to_page((void *)encoded_va);
+	if (!page_ref_sub_and_test(page, pagecnt_bias))
+		return false;
+
+	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+		free_unref_page(page, encoded_page_order(encoded_va));
+		return false;
+	}
+
+	/* OK, page count is 0, we can safely set it */
+	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+	return true;
+}
+
+static bool __page_frag_cache_refill(struct page_frag_cache *nc,
+				     gfp_t gfp_mask)
 {
 	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
@@ -35,8 +54,8 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
 		if (unlikely(!page)) {
-			nc->encoded_va = 0;
-			return NULL;
+			memset(nc, 0, sizeof(*nc));
+			return false;
 		}
 
 		order = 0;
@@ -45,7 +64,33 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	nc->encoded_va = encode_aligned_va(page_address(page), order,
 					   page_is_pfmemalloc(page));
 
-	return page;
+	/* Even if we own the page, we do not use atomic_set().
+	 * This would break get_page_unless_zero() users.
+	 */
+	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
+
+	return true;
+}
+
+/* Reload cache by reusing the old cache if it is possible, or
+ * refilling from the page allocator.
+ */
+static bool __page_frag_cache_reload(struct page_frag_cache *nc,
+				     gfp_t gfp_mask)
+{
+	if (likely(nc->encoded_va)) {
+		if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
+			goto out;
+	}
+
+	if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
+		return false;
+
+out:
+	/* reset page count bias and remaining to start of new frag */
+	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+	nc->remaining = page_frag_cache_page_size(nc->encoded_va);
+	return true;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
@@ -55,7 +100,7 @@ void page_frag_cache_drain(struct page_frag_cache *nc)
 
 	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
 				nc->pagecnt_bias);
-	nc->encoded_va = 0;
+	memset(nc, 0, sizeof(*nc));
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -73,67 +118,44 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int align_mask)
 {
 	unsigned long encoded_va = nc->encoded_va;
-	unsigned int size, remaining;
-	struct page *page;
-
-	if (unlikely(!encoded_va)) {
-refill:
-		page = __page_frag_cache_refill(nc, gfp_mask);
-		if (!page)
-			return NULL;
-
-		encoded_va = nc->encoded_va;
-		size = page_frag_cache_page_size(encoded_va);
-
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
-
-		/* reset page count bias and remaining to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->remaining = size;
-	} else {
-		size = page_frag_cache_page_size(encoded_va);
-	}
+	unsigned int remaining;
 
 	remaining = nc->remaining & align_mask;
-	if (unlikely(remaining < fragsz)) {
-		if (unlikely(fragsz > PAGE_SIZE)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			return NULL;
-		}
-
-		page = virt_to_page((void *)encoded_va);
 
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
-			goto refill;
-
-		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
-			free_unref_page(page, encoded_page_order(encoded_va));
-			goto refill;
-		}
+	/* As we have ensured remaining is zero when initializing and draining old
+	 * cache, 'remaining >= fragsz' checking is enough to indicate there is
+	 * enough available space for the new fragment allocation.
+	 */
+	if (likely(remaining >= fragsz)) {
+		nc->pagecnt_bias--;
+		nc->remaining = remaining - fragsz;
 
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		return encoded_page_address(encoded_va) +
+			(page_frag_cache_page_size(encoded_va) - remaining);
+	}
 
-		/* reset page count bias and remaining to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		remaining = size;
+	if (unlikely(fragsz > PAGE_SIZE)) {
+		/*
+		 * The caller is trying to allocate a fragment with
+		 * fragsz > PAGE_SIZE but the cache isn't big enough to satisfy
+		 * the request, this may happen in low memory conditions. We don't
+		 * release the cache page because it could make memory pressure
+		 * worse so we simply return NULL here.
+		 */
+		return NULL;
 	}
 
+	if (unlikely(!__page_frag_cache_reload(nc, gfp_mask)))
+		return NULL;
+
+	/* As the we are allocating fragment from cache by count-up way, the offset
+	 * of allocated fragment from the just reloaded cache is zero, so remaining
+	 * aligning and offset calculation are not needed.
+	 */
 	nc->pagecnt_bias--;
-	nc->remaining = remaining - fragsz;
+	nc->remaining -= fragsz;
 
-	return encoded_page_address(encoded_va) + (size - remaining);
+	return encoded_page_address(nc->encoded_va);
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


