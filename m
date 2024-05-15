Return-Path: <netdev+bounces-96559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319768C6709
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557101C22332
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53112F580;
	Wed, 15 May 2024 13:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114E12F399;
	Wed, 15 May 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778788; cv=none; b=X9urKGaw+P7WBS/FSFrSQA2bk6TuYb1zMZSrYlR9Qrz85Ge4IbAnQtF01ThX3xgF6VklwI1KrImK7m8vctPaqCMOOY66AgagQUrP6+hLhlaaqZM1ADLx6l3uEb44gqK84AX245hAX0UbzyEDCOWCBr+dR13x48VdkxZzXzQZrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778788; c=relaxed/simple;
	bh=ip24y5id8VmP7yOn9F1cUt3J1V47zGuysEaGgU6FQHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq9o/QFMKBSb/zXe5RLpG5DG+NkrAWirmXlbnLZ4M67x5Ei0GKDBTBeFP9dm3ImXkSUlkwEdwADzzQaVLOpDxJRFbxEOyGOlPpJ3RYviYwzICA2rgvt+jfGZlQO4ygB95GZp7yFf9TR8hefc796xthtbiXvTq0aE52gVnQ5GrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VfYTq10f6ztX5j;
	Wed, 15 May 2024 21:09:35 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CD2418007D;
	Wed, 15 May 2024 21:13:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 21:13:04 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [RFC v4 08/13] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Wed, 15 May 2024 21:09:27 +0800
Message-ID: <20240515130932.18842-9-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240515130932.18842-1-linyunsheng@huawei.com>
References: <20240515130932.18842-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

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
 include/linux/page_frag_cache.h | 77 ++++++++++++++++++++++++++++-----
 mm/page_frag_cache.c            | 77 +++++++++++++++++++--------------
 2 files changed, 110 insertions(+), 44 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 024ff73a7ea4..5f9971c1be74 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -8,29 +8,82 @@
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
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
+	return (struct encoded_va *)((unsigned long)va | order |
+			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+}
+
+static inline unsigned long encoded_page_order(struct encoded_va *encoded_va)
+{
+	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
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
 struct page_frag_cache {
-	void *va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	__u16 offset;
-	__u16 size;
+	struct encoded_va *encoded_va;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
+	u16 pagecnt_bias;
+	u16 remaining;
 #else
-	__u32 offset;
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
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	return PAGE_SIZE << encoded_page_order(encoded_va);
+#else
+	return PAGE_SIZE;
+#endif
+}
+
+static inline unsigned int __page_frag_cache_page_offset(struct encoded_va *encoded_va,
+							 unsigned int remaining)
+{
+	return page_frag_cache_page_size(encoded_va) - remaining;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index c0ecfa733727..97cbc2dac67f 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -23,6 +23,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 {
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
+	unsigned int order;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	/* Ensure free_unref_page() can be used to free the page fragment */
@@ -32,23 +33,35 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
 #endif
-	if (unlikely(!page))
+	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		if (unlikely(!page)) {
+			nc->encoded_va = NULL;
+			nc->remaining = 0;
+			return NULL;
+		}
 
-	nc->va = page ? page_address(page) : NULL;
+		order = 0;
+		nc->remaining = PAGE_SIZE;
+	} else {
+		order = PAGE_FRAG_CACHE_MAX_ORDER;
+		nc->remaining = PAGE_FRAG_CACHE_MAX_SIZE;
+	}
 
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
 
@@ -65,10 +78,19 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
-	unsigned int size, offset;
+	struct encoded_va *encoded_va;
+	unsigned int remaining;
 	struct page *page;
 
-	if (unlikely(!nc->va)) {
+	encoded_va = nc->encoded_va;
+	if (unlikely(!encoded_va)) {
+		/* fragsz is not supposed to be bigger than PAGE_SIZE as we are
+		 * allowing order 3 page allocation to fail easily under low
+		 * memory condition.
+		 */
+		if (WARN_ON_ONCE(fragsz > PAGE_SIZE))
+			return NULL;
+
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
 		if (!page)
@@ -79,34 +101,23 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 		 */
 		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
-		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = 0;
+		/* reset page count bias and remaining of new frag */
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE;
+		nc->remaining -= fragsz;
+		return encoded_page_address(nc->encoded_va);
 	}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	/* if size can vary use size else just use PAGE_SIZE */
-	size = nc->size;
-#else
-	size = PAGE_SIZE;
-#endif
+	remaining = nc->remaining & align_mask;
 
-	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
-	if (unlikely(offset + fragsz > size)) {
-		/* fragsz is not supposed to be bigger than PAGE_SIZE as we are
-		 * allowing order 3 page allocation to fail easily under low
-		 * memory condition.
-		 */
+	if (unlikely(fragsz > remaining)) {
 		if (WARN_ON_ONCE(fragsz > PAGE_SIZE))
 			return NULL;
 
-		page = virt_to_page(nc->va);
-
+		page = virt_to_page(encoded_va);
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
+		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
 			free_unref_page(page, compound_order(page));
 			goto refill;
 		}
@@ -114,15 +125,17 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
-		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = 0;
+		/* reset page count bias and remaining of new frag */
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE;
+		nc->remaining = page_frag_cache_page_size(encoded_va) - fragsz;
+		return encoded_page_address(nc->encoded_va);
 	}
 
+	nc->remaining = remaining - fragsz;
 	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
 
-	return nc->va + offset;
+	return encoded_page_address(encoded_va) +
+		__page_frag_cache_page_offset(encoded_va, remaining);
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


