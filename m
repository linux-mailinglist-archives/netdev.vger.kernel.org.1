Return-Path: <netdev+bounces-104031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493290AEF9
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9479D28E99E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CD1991DF;
	Mon, 17 Jun 2024 13:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCB10958;
	Mon, 17 Jun 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630260; cv=none; b=NbrVoF4y+4/6QLF61goWVE5qkHYFJ6Ei81Qa08WSQuA7TglvPIxH7BoSoVM7bM4/WKyWkNCJ7kWctE+QbFWZEo8Qo/izVpAJvrOVGu4ko7dhDFAsgXfgb34z/MVQulrL/cHWUr3g6bI4py9DbPI8gwNuVRuWehW+rZljlCXP71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630260; c=relaxed/simple;
	bh=2ggA17W7k8rbu4piVAMALMtlqFTr3RfnfFRAM4Jt/f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhLgnBkM8SqHIlSbomT/oGqbL8ohflIVQATUJ0LlNVJsDjav8VYPXHWWWCC+E3ckGMFgClgRY+/xWXG3VotxGj41Cu3igASf3X3FwMnA6mPaW5bAT+A7Euu1c/iPdVL3QCoSs1KtZ4A2XRJxxzDpiZMjH5K4QlBbO2CEISHrSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W2r120gQrzxNd7;
	Mon, 17 Jun 2024 21:13:26 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 256611402CA;
	Mon, 17 Jun 2024 21:17:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v8 06/13] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Mon, 17 Jun 2024 21:14:05 +0800
Message-ID: <20240617131413.25189-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240617131413.25189-1-linyunsheng@huawei.com>
References: <20240617131413.25189-1-linyunsheng@huawei.com>
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

Also, it is better to replace 'offset' with 'remaining', which
is the remaining size for the cache in a 'page_frag_cache'
instance, we are able to do a single 'fragsz > remaining'
checking for the case of cache not being enough, which should be
the fast path if we ensure size is zoro when 'va' == NULL by
memset'ing 'struct page_frag_cache' in page_frag_cache_init()
and page_frag_cache_drain().

After this patch, the size of 'struct page_frag_cache' should be
the same as the size of 'struct page_frag'.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 76 +++++++++++++++++++++++-----
 mm/page_frag_cache.c            | 90 ++++++++++++++++++++-------------
 2 files changed, 118 insertions(+), 48 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 6ac3a25089d1..b33904d4494f 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -8,29 +8,81 @@
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
-struct page_frag_cache {
-	void *va;
+/*
+ * struct encoded_va - a nonexistent type marking this pointer
+ *
+ * An 'encoded_va' pointer is a pointer to a aligned virtual address, which is
+ * at least aligned to PAGE_SIZE, that means there are at least 12 lower bits
+ * space available for other purposes.
+ *
+ * Currently we use the lower 8 bits and bit 9 for the order and PFMEMALLOC
+ * flag of the page this 'va' is corresponding to.
+ *
+ * Use the supplied helper functions to endcode/decode the pointer and bits.
+ */
+struct encoded_va;
+
+#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
+
+static inline struct encoded_va *encode_aligned_va(void *va,
+						   unsigned int order,
+						   bool pfmemalloc)
+{
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	__u16 offset;
-	__u16 size;
+	return (struct encoded_va *)((unsigned long)va | order |
+			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
 #else
-	__u32 offset;
+	return (struct encoded_va *)((unsigned long)va |
+			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+#endif
+}
+
+static inline unsigned long encoded_page_order(struct encoded_va *encoded_va)
+{
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
+#else
+	return 0;
+#endif
+}
+
+static inline bool encoded_page_pfmemalloc(struct encoded_va *encoded_va)
+{
+	return PAGE_FRAG_CACHE_PFMEMALLOC_BIT & (unsigned long)encoded_va;
+}
+
+static inline void *encoded_page_address(struct encoded_va *encoded_va)
+{
+	return (void *)((unsigned long)encoded_va & PAGE_MASK);
+}
+
+struct page_frag_cache {
+	struct encoded_va *encoded_va;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
+	u16 pagecnt_bias;
+	u16 remaining;
+#else
+	u32 pagecnt_bias;
+	u32 remaining;
 #endif
-	/* we maintain a pagecount bias, so that we dont dirty cache line
-	 * containing page->_refcount every time we allocate a fragment.
-	 */
-	unsigned int		pagecnt_bias;
-	bool pfmemalloc;
 };
 
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
-	nc->va = NULL;
+	memset(nc, 0, sizeof(*nc));
 }
 
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
-	return !!nc->pfmemalloc;
+	return encoded_page_pfmemalloc(nc->encoded_va);
+}
+
+static inline unsigned int page_frag_cache_page_size(struct encoded_va *encoded_va)
+{
+	return PAGE_SIZE << encoded_page_order(encoded_va);
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index dd640af5607a..a3316dd50eff 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -18,34 +18,61 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
+static void *page_frag_cache_current_va(struct page_frag_cache *nc)
+{
+	struct encoded_va *encoded_va = nc->encoded_va;
+
+	return (void *)(((unsigned long)encoded_va & PAGE_MASK) |
+		(page_frag_cache_page_size(encoded_va) - nc->remaining));
+}
+
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
+	unsigned int order;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
 #endif
-	if (unlikely(!page))
+	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		if (unlikely(!page)) {
+			memset(nc, 0, sizeof(*nc));
+			return NULL;
+		}
+
+		order = 0;
+		nc->remaining = PAGE_SIZE;
+	} else {
+		order = PAGE_FRAG_CACHE_MAX_ORDER;
+		nc->remaining = PAGE_FRAG_CACHE_MAX_SIZE;
+	}
 
-	nc->va = page ? page_address(page) : NULL;
+	/* Even if we own the page, we do not use atomic_set().
+	 * This would break get_page_unless_zero() users.
+	 */
+	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
+	/* reset page count bias of new frag */
+	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
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
+	__page_frag_cache_drain(virt_to_head_page(nc->encoded_va),
+				nc->pagecnt_bias);
+	memset(nc, 0, sizeof(*nc));
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -62,51 +89,41 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
-	unsigned int size = PAGE_SIZE;
+	struct encoded_va *encoded_va = nc->encoded_va;
 	struct page *page;
-	int offset;
+	int remaining;
+	void *va;
 
-	if (unlikely(!nc->va)) {
+	if (unlikely(!encoded_va)) {
 refill:
-		page = __page_frag_cache_refill(nc, gfp_mask);
-		if (!page)
+		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
 			return NULL;
 
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
-
-		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = 0;
+		encoded_va = nc->encoded_va;
 	}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	/* if size can vary use size else just use PAGE_SIZE */
-	size = nc->size;
-#endif
-
-	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
-	if (unlikely(offset + fragsz > size)) {
-		page = virt_to_page(nc->va);
-
+	remaining = nc->remaining & align_mask;
+	remaining -= fragsz;
+	if (unlikely(remaining < 0)) {
+		page = virt_to_page(encoded_va);
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
 
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
-		/* reset page count bias and offset to start of new frag */
+		/* reset page count bias and remaining of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = 0;
-		if (unlikely(fragsz > PAGE_SIZE)) {
+		nc->remaining = remaining = page_frag_cache_page_size(encoded_va);
+		remaining -= fragsz;
+		if (unlikely(remaining < 0)) {
 			/*
 			 * The caller is trying to allocate a fragment
 			 * with fragsz > PAGE_SIZE but the cache isn't big
@@ -120,10 +137,11 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 		}
 	}
 
+	va = page_frag_cache_current_va(nc);
 	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
+	nc->remaining = remaining;
 
-	return nc->va + offset;
+	return va;
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


