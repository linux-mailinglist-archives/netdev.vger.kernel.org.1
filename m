Return-Path: <netdev+bounces-112198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138379375D8
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364AE1C22842
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4A143751;
	Fri, 19 Jul 2024 09:37:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DB13F441;
	Fri, 19 Jul 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381836; cv=none; b=lr8IqG7jYl9bY/yeQ/MJcqL5gGaJdlXVeaj8dwCEtFJnu0lfDU/syGd33ItMs1/jdKQ5jvmZ6CQaPBRdk4Bb0G3FTm69mlRxXgB/GTIC4vW4BROpiWGbVZmt2mt40kB3mGiD29qtqueu7wDfevQE5yRNx4K9lVNoKMTWrQRUGnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381836; c=relaxed/simple;
	bh=pQJlYjiv5DR6baOXwSyh0wpn0yBBKxQtqaysVKkIO9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtCTb3kJI0NKWkPZ0PRs0WJ447HtBFTOsa9as+zWqrUyCTMLEONQ6UBIc4voexTf6RoU0bPl7JKLc5ZjF6eRIJAs5PKTeenGY644GT4U5knmxmTbHUj5Pj562+u+q5iiu868JMaunqKe9qWOSMJWTzu1NjvZIIsxgu8/Ql7wAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WQPfl6g7Bzdj4Q;
	Fri, 19 Jul 2024 17:35:27 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DB601402E2;
	Fri, 19 Jul 2024 17:37:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Jul 2024 17:37:12 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [RFC v11 07/14] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Fri, 19 Jul 2024 17:33:31 +0800
Message-ID: <20240719093338.55117-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240719093338.55117-1-linyunsheng@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
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

Currently there is one 'struct page_frag' for every 'struct
sock' and 'struct task_struct', we are about to replace the
'struct page_frag' with 'struct page_frag_cache' for them.
Before begin the replacing, we need to ensure the size of
'struct page_frag_cache' is not bigger than the size of
'struct page_frag', as there may be tens of thousands of
'struct sock' and 'struct task_struct' instances in the
system.

By or'ing the page order & pfmemalloc with lower bits of
'va' instead of using 'u16' or 'u32' for page size and 'u8'
for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
And page address & pfmemalloc & order is unchanged for the
same page in the same 'page_frag_cache' instance, it makes
sense to fit them together.

After this patch, the size of 'struct page_frag_cache' should be
the same as the size of 'struct page_frag'.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/mm_types_task.h   | 16 +++++------
 include/linux/page_frag_cache.h | 49 +++++++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 49 +++++++++++++++------------------
 3 files changed, 77 insertions(+), 37 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index b1c54b2b9308..f2610112a642 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -50,18 +50,18 @@ struct page_frag {
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 struct page_frag_cache {
-	void *va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* encoded_va consists of the virtual address, pfmemalloc bit and order
+	 * of a page.
+	 */
+	unsigned long encoded_va;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
 	__u16 remaining;
-	__u16 size;
+	__u16 pagecnt_bias;
 #else
 	__u32 remaining;
+	__u32 pagecnt_bias;
 #endif
-	/* we maintain a pagecount bias, so that we dont dirty cache line
-	 * containing page->_refcount every time we allocate a fragment.
-	 */
-	unsigned int		pagecnt_bias;
-	bool pfmemalloc;
 };
 
 /* Track pages that require TLB flushes */
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index ef1572f11248..12a16f8e8ad0 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,19 +3,64 @@
 #ifndef _LINUX_PAGE_FRAG_CACHE_H
 #define _LINUX_PAGE_FRAG_CACHE_H
 
+#include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/mm_types_task.h>
 #include <asm/page.h>
 
+#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
+
+static inline unsigned long encode_aligned_va(void *va, unsigned int order,
+					      bool pfmemalloc)
+{
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT >= PAGE_SHIFT);
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	return (unsigned long)va | order |
+		(pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+#else
+	return (unsigned long)va |
+		(pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+#endif
+}
+
+static inline unsigned long encoded_page_order(unsigned long encoded_va)
+{
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	return encoded_va & PAGE_FRAG_CACHE_ORDER_MASK;
+#else
+	return 0;
+#endif
+}
+
+static inline bool encoded_page_pfmemalloc(unsigned long encoded_va)
+{
+	return encoded_va & PAGE_FRAG_CACHE_PFMEMALLOC_BIT;
+}
+
+static inline void *encoded_page_address(unsigned long encoded_va)
+{
+	return (void *)(encoded_va & PAGE_MASK);
+}
+
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
-	nc->va = NULL;
+	nc->encoded_va = 0;
 }
 
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
-	return !!nc->pfmemalloc;
+	return encoded_page_pfmemalloc(nc->encoded_va);
+}
+
+static inline unsigned int page_frag_cache_page_size(unsigned long encoded_va)
+{
+	return PAGE_SIZE << encoded_page_order(encoded_va);
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index b12496f05c4a..7928e5d50711 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -22,7 +22,7 @@
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
-	unsigned int page_size = PAGE_FRAG_CACHE_MAX_SIZE;
+	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
@@ -35,28 +35,27 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
 		if (unlikely(!page)) {
-			nc->va = NULL;
+			nc->encoded_va = 0;
 			return NULL;
 		}
 
-		page_size = PAGE_SIZE;
+		order = 0;
 	}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	nc->size = page_size;
-#endif
-	nc->va = page_address(page);
+	nc->encoded_va = encode_aligned_va(page_address(page), order,
+					   page_is_pfmemalloc(page));
 
 	return page;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
-	if (!nc->va)
+	if (!nc->encoded_va)
 		return;
 
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
+	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
+				nc->pagecnt_bias);
+	nc->encoded_va = 0;
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -73,36 +72,30 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
-	unsigned int size = PAGE_SIZE;
-	unsigned int remaining;
+	unsigned long encoded_va = nc->encoded_va;
+	unsigned int size, remaining;
 	struct page *page;
 
-	if (unlikely(!nc->va)) {
+	if (unlikely(!encoded_va)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
+		encoded_va = nc->encoded_va;
+		size = page_frag_cache_page_size(encoded_va);
+
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
 		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
 		/* reset page count bias and remaining to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->remaining = size;
 	}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	/* if size can vary use size else just use PAGE_SIZE */
-	size = nc->size;
-#endif
-
+	size = page_frag_cache_page_size(encoded_va);
 	remaining = nc->remaining & align_mask;
 	if (unlikely(remaining < fragsz)) {
 		if (unlikely(fragsz > PAGE_SIZE)) {
@@ -118,13 +111,15 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = virt_to_page(nc->va);
+		page = virt_to_page((void *)encoded_va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+			VM_BUG_ON(compound_order(page) !=
+				  encoded_page_order(encoded_va));
+			free_unref_page(page, encoded_page_order(encoded_va));
 			goto refill;
 		}
 
@@ -141,7 +136,7 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->remaining = remaining - fragsz;
 
-	return nc->va + (size - remaining);
+	return encoded_page_address(encoded_va) + (size - remaining);
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


