Return-Path: <netdev+bounces-116846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E094BDDE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73216B255D6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E118F2F9;
	Thu,  8 Aug 2024 12:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9018F2E8;
	Thu,  8 Aug 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120997; cv=none; b=WD7ogDtIUc4kfmyr3KQpY3B6jCEdemMzZwtyRgdcLrfk0v/cga2n/VjGHCx6whYycTaH31zicEULcGJGDvJlCikBFz/x8DWD3b7/rYRhIYXSgehKZME7YGgp2w5Ej1AGYZ2r9h89insDL/rR0Zs54EXWEOxXb1Xsj3+2t89DGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120997; c=relaxed/simple;
	bh=Uz8yK71Ka0y/Z5Fhp2gHKeU0tMElHrqd1/m4B1F59aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TB2r5vxG/wRRyO8ieiWmiVyksxGn/Uuv5UpC/8o6i6NKn21YVvGQSNBMHQDLMRODxszp7Nd1XKYiqKKcHl6y5XgOkEdS4GHrIQZWNJ68su/GDBHDZ7y4843B4+4LOWnPOgLy0ZxFHfHiRMXZnV+KO3/fN2w/9NIrajSYz5tDg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wfmn131Vwz20lCH;
	Thu,  8 Aug 2024 20:38:45 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DAA8E180018;
	Thu,  8 Aug 2024 20:43:12 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:43:12 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v13 07/14] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Thu, 8 Aug 2024 20:37:07 +0800
Message-ID: <20240808123714.462740-8-linyunsheng@huawei.com>
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
 include/linux/mm_types_task.h   | 16 +++++-----
 include/linux/page_frag_cache.h | 52 +++++++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 49 +++++++++++++++++--------------
 3 files changed, 85 insertions(+), 32 deletions(-)

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
index 7c9125a9aed3..4ce924eaf1b1 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,18 +3,66 @@
 #ifndef _LINUX_PAGE_FRAG_CACHE_H
 #define _LINUX_PAGE_FRAG_CACHE_H
 
+#include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/mm_types_task.h>
 
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+/* Use a full byte here to enable assembler optimization as the shift
+ * operation is usually expecting a byte.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
+#else
+/* Compiler should be able to figure out we don't read things as any value
+ * ANDed with 0 is 0.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		0
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(0)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	0
+#endif
+
+static inline unsigned long encode_aligned_va(void *va, unsigned int order,
+					      bool pfmemalloc)
+{
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT >= PAGE_SHIFT);
+
+	return (unsigned long)va | (order & PAGE_FRAG_CACHE_ORDER_MASK) |
+		((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+}
+
+static inline unsigned long encoded_page_order(unsigned long encoded_va)
+{
+	return encoded_va & PAGE_FRAG_CACHE_ORDER_MASK;
+}
+
+static inline bool encoded_page_pfmemalloc(unsigned long encoded_va)
+{
+	return !!(encoded_va & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
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
index 70fb6dead624..2544b292375a 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -22,6 +22,7 @@
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
+	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
@@ -30,23 +31,31 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
 #endif
-	if (unlikely(!page))
+	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		if (unlikely(!page)) {
+			nc->encoded_va = 0;
+			return NULL;
+		}
 
-	nc->va = page ? page_address(page) : NULL;
+		order = 0;
+	}
+
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
 
@@ -63,33 +72,29 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	unsigned int size = nc->size;
-#else
-	unsigned int size = PAGE_SIZE;
-#endif
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
+	} else {
+		size = page_frag_cache_page_size(encoded_va);
 	}
 
 	remaining = nc->remaining & align_mask;
@@ -107,13 +112,13 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = virt_to_page(nc->va);
+		page = virt_to_page((void *)encoded_va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+			free_unref_page(page, encoded_page_order(encoded_va));
 			goto refill;
 		}
 
@@ -128,7 +133,7 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->remaining = remaining - fragsz;
 
-	return nc->va + (size - remaining);
+	return encoded_page_address(encoded_va) + (size - remaining);
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


