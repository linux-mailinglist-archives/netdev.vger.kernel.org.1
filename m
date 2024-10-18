Return-Path: <netdev+bounces-136966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F89A3CA8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E219B2857E6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9320A5D6;
	Fri, 18 Oct 2024 11:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F62208967;
	Fri, 18 Oct 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249225; cv=none; b=Z6nGXLWdrzvCelY/evdRalLBeWE/qqGKyRJpJU3mh6kQqHR/yOYspiyQldPf2odQ9pA5CkEq5Kqc6V801hpWI9xLD8W7twpsyIVmVjlhWJjxQWtjy3djdYAqinsQgI8WNoKGgax2ICyZbDekWiWwkVGfCNip5ereI+dno8kgeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249225; c=relaxed/simple;
	bh=/j/MksuomVkl336uj0nuHKDXE3UjBmp1VvgGVhxWDMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZKtvKqfLjZC7EJxHG5qSZR/Qb88Mt9vNJhTlZhD0UnR7ptgW/2yCX7PChSdOi2AzMJjwyXYU3AmHXxYsuSjSfIGXkjYRcNAGcdgbe/xFooq/yY4mCZn1jV9PcBbbvAD+WUU17F/xfP81qPAFWhafNBvnFk3cCBEIjK0FbpBH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XVMCC5jpHz1SCqw;
	Fri, 18 Oct 2024 18:59:03 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FD6814022D;
	Fri, 18 Oct 2024 19:00:21 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 19:00:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v22 06/14] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Fri, 18 Oct 2024 18:53:43 +0800
Message-ID: <20241018105351.1960345-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241018105351.1960345-1-linyunsheng@huawei.com>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
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

After this patch, the size of 'struct page_frag_cache' should be
the same as the size of 'struct page_frag'.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/mm_types_task.h   | 19 +++++----
 include/linux/page_frag_cache.h | 24 ++++++++++-
 mm/page_frag_cache.c            | 70 ++++++++++++++++++++++-----------
 3 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 0ac6daebdd5c..a82aa80c0ba4 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -47,18 +47,21 @@ struct page_frag {
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 struct page_frag_cache {
-	void *va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* encoded_page consists of the virtual address, pfmemalloc bit and
+	 * order of a page.
+	 */
+	unsigned long encoded_page;
+
+	/* we maintain a pagecount bias, so that we dont dirty cache line
+	 * containing page->_refcount every time we allocate a fragment.
+	 */
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
 	__u16 offset;
-	__u16 size;
+	__u16 pagecnt_bias;
 #else
 	__u32 offset;
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
index 0a52f7a179c8..41a91df82631 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,18 +3,38 @@
 #ifndef _LINUX_PAGE_FRAG_CACHE_H
 #define _LINUX_PAGE_FRAG_CACHE_H
 
+#include <linux/bits.h>
 #include <linux/log2.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+/* Use a full byte here to enable assembler optimization as the shift
+ * operation is usually expecting a byte.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
+#else
+/* Compiler should be able to figure out we don't read things as any value
+ * ANDed with 0 is 0.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		0
+#endif
+
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		(PAGE_FRAG_CACHE_ORDER_MASK + 1)
+
+static inline bool encoded_page_decode_pfmemalloc(unsigned long encoded_page)
+{
+	return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
+}
+
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
-	nc->va = NULL;
+	nc->encoded_page = 0;
 }
 
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
-	return !!nc->pfmemalloc;
+	return encoded_page_decode_pfmemalloc(nc->encoded_page);
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 4c8e04379cb3..a36fd09bf275 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -12,6 +12,7 @@
  * be used in the "frags" portion of skb_shared_info.
  */
 
+#include <linux/build_bug.h>
 #include <linux/export.h>
 #include <linux/gfp_types.h>
 #include <linux/init.h>
@@ -19,9 +20,36 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
+static unsigned long encoded_page_create(struct page *page, unsigned int order,
+					 bool pfmemalloc)
+{
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);
+
+	return (unsigned long)page_address(page) |
+		(order & PAGE_FRAG_CACHE_ORDER_MASK) |
+		((unsigned long)pfmemalloc * PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
+}
+
+static unsigned long encoded_page_decode_order(unsigned long encoded_page)
+{
+	return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
+}
+
+static void *encoded_page_decode_virt(unsigned long encoded_page)
+{
+	return (void *)(encoded_page & PAGE_MASK);
+}
+
+static struct page *encoded_page_decode_page(unsigned long encoded_page)
+{
+	return virt_to_page((void *)encoded_page);
+}
+
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
+	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
@@ -30,23 +58,26 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
 #endif
-	if (unlikely(!page))
+	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		order = 0;
+	}
 
-	nc->va = page ? page_address(page) : NULL;
+	nc->encoded_page = page ?
+		encoded_page_create(page, order, page_is_pfmemalloc(page)) : 0;
 
 	return page;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
-	if (!nc->va)
+	if (!nc->encoded_page)
 		return;
 
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
+	__page_frag_cache_drain(encoded_page_decode_page(nc->encoded_page),
+				nc->pagecnt_bias);
+	nc->encoded_page = 0;
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -63,35 +94,29 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int fragsz, gfp_t gfp_mask,
 			      unsigned int align_mask)
 {
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	unsigned int size = nc->size;
-#else
-	unsigned int size = PAGE_SIZE;
-#endif
-	unsigned int offset;
+	unsigned long encoded_page = nc->encoded_page;
+	unsigned int size, offset;
 	struct page *page;
 
-	if (unlikely(!nc->va)) {
+	if (unlikely(!encoded_page)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
+		encoded_page = nc->encoded_page;
+
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
 		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
 	}
 
+	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
 	if (unlikely(offset + fragsz > size)) {
 		if (unlikely(fragsz > PAGE_SIZE)) {
@@ -107,13 +132,14 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = virt_to_page(nc->va);
+		page = encoded_page_decode_page(encoded_page);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+		if (unlikely(encoded_page_decode_pfmemalloc(encoded_page))) {
+			free_unref_page(page,
+					encoded_page_decode_order(encoded_page));
 			goto refill;
 		}
 
@@ -128,7 +154,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->offset = offset + fragsz;
 
-	return nc->va + offset;
+	return encoded_page_decode_virt(encoded_page) + offset;
 }
 EXPORT_SYMBOL(__page_frag_alloc_align);
 
-- 
2.33.0


