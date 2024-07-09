Return-Path: <netdev+bounces-110274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F392BB56
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4BAB24397
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51194176FCE;
	Tue,  9 Jul 2024 13:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C2176AC0;
	Tue,  9 Jul 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531879; cv=none; b=nXaf/gVThRXs4M664WWwjZOSetq9C+IYcClvChux/C2EICVtVY36pHYL2o8ZF+mrdGtRKI3i9OHzc0iZx32F48nFwVt/H4wXQOECaYirBcQe9Q5cOhZ2m+LSKDYuLai37h7lAdazLr/bPN3AyNq72dJuYNlgCyVP8StLZIrx4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531879; c=relaxed/simple;
	bh=B3+hPNPGvnyr5YEHeRboytbpmreuTuxrsVJRPFkUMjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+pTOvxv55eyUfnUeeznSpziHHtxeOM7+XabqXCyTj0hUaNAkXA4eKcJMwUHa9NUh6feUyb4xi5LcaY9UHahP1NPCAV63RM/3CoVQnAix9XJOGAEONSjSJTJQzKhDYM18t2q3ohyPBuddV49w/EFSAuHKCjsq6CmbSfL0e/f8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJMLw68S9zcpK6;
	Tue,  9 Jul 2024 21:30:48 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B10C140258;
	Tue,  9 Jul 2024 21:31:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 21:31:14 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v10 08/15] mm: page_frag: some minor refactoring before adding new API
Date: Tue, 9 Jul 2024 21:27:33 +0800
Message-ID: <20240709132741.47751-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240709132741.47751-1-linyunsheng@huawei.com>
References: <20240709132741.47751-1-linyunsheng@huawei.com>
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
to __page_frag_cache_refill(), so that the new API can
make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |  2 +-
 mm/page_frag_cache.c            | 96 +++++++++++++++++----------------
 2 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 87c3eb728f95..71e08db1eb2f 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -68,7 +68,7 @@ struct page_frag_cache {
 
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
-	nc->encoded_va = 0;
+	memset(nc, 0, sizeof(*nc));
 }
 
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 02e4ec92f948..73164d2482f8 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -19,6 +19,28 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
+static struct page *__page_frag_cache_recharge(struct page_frag_cache *nc)
+{
+	unsigned long encoded_va = nc->encoded_va;
+	struct page *page;
+
+	page = virt_to_page((void *)encoded_va);
+	if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+		return NULL;
+
+	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+		VM_BUG_ON(compound_order(page) !=
+			  encoded_page_order(encoded_va));
+		free_unref_page(page, encoded_page_order(encoded_va));
+		return NULL;
+	}
+
+	/* OK, page count is 0, we can safely set it */
+	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+	return page;
+}
+
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
@@ -26,6 +48,14 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
+	if (likely(nc->encoded_va)) {
+		page = __page_frag_cache_recharge(nc);
+		if (page) {
+			order = encoded_page_order(nc->encoded_va);
+			goto out;
+		}
+	}
+
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
@@ -35,7 +65,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
 		if (unlikely(!page)) {
-			nc->encoded_va = 0;
+			memset(nc, 0, sizeof(*nc));
 			return NULL;
 		}
 
@@ -45,6 +75,16 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	nc->encoded_va = encode_aligned_va(page_address(page), order,
 					   page_is_pfmemalloc(page));
 
+	/* Even if we own the page, we do not use atomic_set().
+	 * This would break get_page_unless_zero() users.
+	 */
+	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
+
+out:
+	/* reset page count bias and remaining to start of new frag */
+	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+	nc->remaining = PAGE_SIZE << order;
+
 	return page;
 }
 
@@ -55,7 +95,7 @@ void page_frag_cache_drain(struct page_frag_cache *nc)
 
 	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
 				nc->pagecnt_bias);
-	nc->encoded_va = 0;
+	memset(nc, 0, sizeof(*nc));
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -72,53 +112,15 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
-	unsigned long encoded_va = nc->encoded_va;
-	int aligned_remaining, remaining;
-	unsigned int size;
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
+	unsigned int size = page_frag_cache_page_size(nc->encoded_va);
+	int aligned_remaining = nc->remaining & align_mask;
+	int remaining = aligned_remaining - fragsz;
 
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
-
-		/* reset page count bias and remaining to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->remaining = size;
-	}
-
-	size = page_frag_cache_page_size(encoded_va);
-
-	aligned_remaining = nc->remaining & align_mask;
-	remaining = aligned_remaining - fragsz;
 	if (unlikely(remaining < 0)) {
-		page = virt_to_page((void *)encoded_va);
-
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
-			goto refill;
-
-		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
-			VM_BUG_ON(compound_order(page) !=
-				  encoded_page_order(encoded_va));
-			free_unref_page(page, encoded_page_order(encoded_va));
-			goto refill;
-		}
-
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		if (!__page_frag_cache_refill(nc, gfp_mask))
+			return NULL;
 
-		/* reset page count bias and remaining to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->remaining = size;
+		size = page_frag_cache_page_size(nc->encoded_va);
 
 		aligned_remaining = size;
 		remaining = aligned_remaining - fragsz;
@@ -139,7 +141,7 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->remaining = remaining;
 
-	return encoded_page_address(encoded_va) + (size - aligned_remaining);
+	return encoded_page_address(nc->encoded_va) + (size - aligned_remaining);
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


