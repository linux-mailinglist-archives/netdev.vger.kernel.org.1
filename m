Return-Path: <netdev+bounces-125817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7596EC53
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CB01C240B0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60803158DA3;
	Fri,  6 Sep 2024 07:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40C158A00;
	Fri,  6 Sep 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608576; cv=none; b=ekgR5YA+XJv8fDoYIrDqSzaZSZ9NjSJx4Vnn/4Y4FZuuI/k5H0RvQWFkUAy0it171Nz3CfOvOIjim4dOH5hWDeEEMbETs19m51Hj1jZ/l8Nrzcn9CmPuODQjgCDsTJdr1Sfn6De++Maw5Riw7tw63afKmFurJvOinNPxN9qvVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608576; c=relaxed/simple;
	bh=XkI2LyH3ZdL25RzNLIMVh/fAhtXbg5EMcrZe7ZVMY3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUG5ekgX9V5+JaQhkUCP/H5/naq7csvmdm/LpUP9ovYlDtDwlQlMAnVm2TC7rmACCe9j2sdNBwHlbG7j6+taixNUWjL19I2L6XS1YtkMMRf3EYYpLCmyIPQ/3Phz6N5Af4rrFTmljKOUesnNceRQ97Pj40dXPDCfZGprAGUfQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X0Sqm5fm8z2DbqN;
	Fri,  6 Sep 2024 15:42:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 88E921A016C;
	Fri,  6 Sep 2024 15:42:51 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:42:51 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v18 06/14] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Fri, 6 Sep 2024 15:36:38 +0800
Message-ID: <20240906073646.2930809-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906073646.2930809-1-linyunsheng@huawei.com>
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
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
 include/linux/page_frag_cache.h | 26 +++++++++++-
 mm/page_frag_cache.c            | 75 +++++++++++++++++++++++----------
 3 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index cdc1e3696439..73a574a0e8f9 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -50,18 +50,21 @@ struct page_frag {
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
index 0a52f7a179c8..75aaad6eaea2 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,18 +3,40 @@
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
+static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encoded_page)
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
+	return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 4c8e04379cb3..cf9375a81a64 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -12,6 +12,7 @@
  * be used in the "frags" portion of skb_shared_info.
  */
 
+#include <linux/build_bug.h>
 #include <linux/export.h>
 #include <linux/gfp_types.h>
 #include <linux/init.h>
@@ -19,9 +20,41 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
+static unsigned long page_frag_encode_page(struct page *page, unsigned int order,
+					   bool pfmemalloc)
+{
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);
+
+	return (unsigned long)page_address(page) |
+		(order & PAGE_FRAG_CACHE_ORDER_MASK) |
+		((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+}
+
+static unsigned long page_frag_encoded_page_order(unsigned long encoded_page)
+{
+	return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
+}
+
+static void *page_frag_encoded_page_address(unsigned long encoded_page)
+{
+	return (void *)(encoded_page & PAGE_MASK);
+}
+
+static struct page *page_frag_encoded_page_ptr(unsigned long encoded_page)
+{
+	return virt_to_page((void *)encoded_page);
+}
+
+static unsigned int page_frag_cache_page_size(unsigned long encoded_page)
+{
+	return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
+}
+
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
+	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
@@ -30,23 +63,26 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
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
+		page_frag_encode_page(page, order, page_is_pfmemalloc(page)) : 0;
 
 	return page;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
-	if (!nc->va)
+	if (!nc->encoded_page)
 		return;
 
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
+	__page_frag_cache_drain(page_frag_encoded_page_ptr(nc->encoded_page),
+				nc->pagecnt_bias);
+	nc->encoded_page = 0;
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -63,35 +99,29 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
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
 
+	size = page_frag_cache_page_size(encoded_page);
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
 	if (unlikely(offset + fragsz > size)) {
 		if (unlikely(fragsz > PAGE_SIZE)) {
@@ -107,13 +137,14 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = virt_to_page(nc->va);
+		page = page_frag_encoded_page_ptr(encoded_page);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+		if (unlikely(page_frag_encoded_page_pfmemalloc(encoded_page))) {
+			free_unref_page(page,
+					page_frag_encoded_page_order(encoded_page));
 			goto refill;
 		}
 
@@ -128,7 +159,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->offset = offset + fragsz;
 
-	return nc->va + offset;
+	return page_frag_encoded_page_address(encoded_page) + offset;
 }
 EXPORT_SYMBOL(__page_frag_alloc_align);
 
-- 
2.33.0


