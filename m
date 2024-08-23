Return-Path: <netdev+bounces-121427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421695D146
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D60B2BBA3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C41018BC05;
	Fri, 23 Aug 2024 15:06:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5218BBA8;
	Fri, 23 Aug 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425612; cv=none; b=F2dzK2PBhrmHksavlhRd2W6GtPVm2pi9bmV9QhaM52VnXiq1e+aqutq2E/UlyxXnp0OPlnub+xLa8HTp+yJEKRpEBVCgO4XBtZe3asPALTO2bcU7x4nQZRMhSSe3v1I5OnTZ/8Q73nlKzZuLOc6dHqV12PauRfyd6MFIUhfzrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425612; c=relaxed/simple;
	bh=Ew/RwZXarMMJdl4/2ROvQD33NsVQ0Q5grvaSYfxY8ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zv3xjgqLwKWcPtJHiI1eT5l8Y9EV1VjEOZ0OWh/y1YCZe9N4w2s3WFUeWT/OBrMRRoy9h2TYLDFwLq30sPb+/iQ99eGtGkN2tfmhq2Gl40WOIiBkGR6cdsfEsRrzTCdPvgFkVPpkH8dnv1ee0b/R89QbL964gtXcKZTG67kqwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wr3FQ2vzwz20mBR;
	Fri, 23 Aug 2024 23:02:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7490C1402E1;
	Fri, 23 Aug 2024 23:06:46 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 23:06:46 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v14 05/11] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Fri, 23 Aug 2024 23:00:33 +0800
Message-ID: <20240823150040.1567062-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240823150040.1567062-1-linyunsheng@huawei.com>
References: <20240823150040.1567062-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 include/linux/mm_types_task.h   | 19 ++++---
 include/linux/page_frag_cache.h | 98 +++++++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 64 +++++++++++----------
 3 files changed, 140 insertions(+), 41 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index cdc1e3696439..a8635460e027 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -50,18 +50,21 @@ struct page_frag {
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 struct page_frag_cache {
-	void *va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* encoded_page consists of the virtual address, pfmemalloc bit and order
+	 * of a page.
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
index 0a52f7a179c8..1ed0d1b7014b 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,24 +3,114 @@
 #ifndef _LINUX_PAGE_FRAG_CACHE_H
 #define _LINUX_PAGE_FRAG_CACHE_H
 
+#include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/log2.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+/* Use a full byte here to enable assembler optimization as the shift
+ * operation is usually expecting a byte.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
+#else
+/* Compiler should be able to figure out we don't read things as any value
+ * ANDed with 0 is 0.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		0
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	0
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
+#endif
+
+static inline unsigned long page_pool_encode_page(struct page *page,
+						  unsigned int order,
+						  bool pfmemalloc)
+{
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);
+
+	return (unsigned long)page_address(page) |
+		(order & PAGE_FRAG_CACHE_ORDER_MASK) |
+		((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+}
+
+static inline unsigned long page_pool_encoded_page_order(unsigned long encoded_page)
+{
+	return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
+}
+
+static inline bool page_pool_encoded_page_pfmemalloc(unsigned long encoded_page)
+{
+	return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
+}
+
+static inline void *page_pool_encoded_page_address(unsigned long encoded_page)
+{
+	return (void *)(encoded_page & PAGE_MASK);
+}
+
+static inline struct page *page_pool_encoded_page_ptr(unsigned long encoded_page)
+{
+	return virt_to_page((void *)encoded_page);
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
+	return page_pool_encoded_page_pfmemalloc(nc->encoded_page);
+}
+
+static inline unsigned int page_frag_cache_page_size(unsigned long encoded_page)
+{
+	return PAGE_SIZE << page_pool_encoded_page_order(encoded_page);
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask);
+
+static inline void __page_frag_cache_commit(struct page_frag_cache *nc,
+					    struct page_frag *pfrag, bool referenced,
+					    unsigned int used_sz)
+{
+	if (referenced) {
+		VM_BUG_ON(!nc->pagecnt_bias);
+		nc->pagecnt_bias--;
+	}
+
+	/* Committed offset might be bigger than the current offset due to alignment */
+	VM_BUG_ON(nc->offset > pfrag->offset);
+
+	VM_BUG_ON(used_sz > pfrag->size);
+	VM_BUG_ON(pfrag->offset + pfrag->size > page_frag_cache_page_size(nc->encoded_page));
+
+	nc->offset = pfrag->offset + used_sz;
+}
+
+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
+					    gfp_t gfp_mask, unsigned int align_mask)
+{
+	struct page_frag page_frag;
+	void *va;
+
+	va = __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_mask, align_mask);
+	if (unlikely(!va))
+		return NULL;
+
+	__page_frag_cache_commit(nc, &page_frag, true, fragsz);
+
+	return va;
+}
 
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 4c8e04379cb3..2865bff7199d 100644
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
+			nc->encoded_page = 0;
+			return NULL;
+		}
+
+		order = 0;
+	}
 
-	nc->va = page ? page_address(page) : NULL;
+	nc->encoded_page = page_pool_encode_page(page, order,
+						 page_is_pfmemalloc(page));
 
 	return page;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
-	if (!nc->va)
+	if (!nc->encoded_page)
 		return;
 
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
+	__page_frag_cache_drain(page_pool_encoded_page_ptr(nc->encoded_page),
+				nc->pagecnt_bias);
+	nc->encoded_page = 0;
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -59,35 +68,32 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask)
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
+	size = page_frag_cache_page_size(encoded_page);
+	page = page_pool_encoded_page_ptr(encoded_page);
+
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
+		size = page_frag_cache_page_size(encoded_page);
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
@@ -107,13 +113,12 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = virt_to_page(nc->va);
-
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+		if (unlikely(page_pool_encoded_page_pfmemalloc(encoded_page))) {
+			free_unref_page(page,
+					page_pool_encoded_page_order(encoded_page));
 			goto refill;
 		}
 
@@ -125,12 +130,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		offset = 0;
 	}
 
-	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
+	pfrag->page = page;
+	pfrag->offset = offset;
+	pfrag->size = size - offset;
 
-	return nc->va + offset;
+	return page_pool_encoded_page_address(encoded_page) + offset;
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_cache_prepare);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
-- 
2.33.0


