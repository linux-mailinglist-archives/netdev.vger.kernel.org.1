Return-Path: <netdev+bounces-110273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C957B92BB53
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5562C1F25F14
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4666176AC5;
	Tue,  9 Jul 2024 13:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D816F85D;
	Tue,  9 Jul 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531877; cv=none; b=fbvQCIXjCMCudUH8wk3V1FijKwz7Nkvmp6CWUH7WhzJlLan/pfdOEpnYZPbtqQAKonubaoaTd+Cxy6pnFKJTOiI5+1C2aSb/52T9ixxzgi1V2KEIxNFipptd/CF0M+7l+bZe0YBiFIJl2xrBFkNYdeSofus0AFNLWUfAzPqgFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531877; c=relaxed/simple;
	bh=NaxKaeMPbsn46stRkJ+nctxkY91l7oSKl3SREQpcizE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onlHFLxYgkojgS8qzhlfzbTdK4ZgjA64wKKOk7yiO8RltPD4/Uei09f2DaHPIlwdSxBlV5uqJB7n1Jhi1HYIdsWWK4XIwFXFy66DBQEzsK31tNK2ORhoOU+fDmdIzsCgXPkJGA7EaFbmhk0rAJyOCBp3wGf18ciKLTfVuktdNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJMLv0NVRzcpK3;
	Tue,  9 Jul 2024 21:30:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 33A0B180064;
	Tue,  9 Jul 2024 21:31:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 21:31:12 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v10 07/15] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Tue, 9 Jul 2024 21:27:32 +0800
Message-ID: <20240709132741.47751-8-linyunsheng@huawei.com>
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
 include/linux/page_frag_cache.h | 65 ++++++++++++++++++++++++++++-----
 mm/page_frag_cache.c            | 47 +++++++++++-------------
 2 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 0ba96b7b64ad..87c3eb728f95 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -4,6 +4,8 @@
 #define _LINUX_PAGE_FRAG_CACHE_H
 
 #include <linux/align.h>
+#include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <asm/page.h>
@@ -11,29 +13,72 @@
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
-struct page_frag_cache {
-	void *va;
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
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
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
+struct page_frag_cache {
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
index 373f3bc29fcb..02e4ec92f948 100644
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
 
@@ -73,46 +72,44 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask)
 {
+	unsigned long encoded_va = nc->encoded_va;
 	int aligned_remaining, remaining;
-	unsigned int size = PAGE_SIZE;
+	unsigned int size;
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
+	size = page_frag_cache_page_size(encoded_va);
 
 	aligned_remaining = nc->remaining & align_mask;
 	remaining = aligned_remaining - fragsz;
 	if (unlikely(remaining < 0)) {
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
 
@@ -142,7 +139,7 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->remaining = remaining;
 
-	return nc->va + (size - aligned_remaining);
+	return encoded_page_address(encoded_va) + (size - aligned_remaining);
 }
 EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
-- 
2.33.0


