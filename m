Return-Path: <netdev+bounces-116850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7F94BDEA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A8B288916
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364818FDA3;
	Thu,  8 Aug 2024 12:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E7190470;
	Thu,  8 Aug 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121005; cv=none; b=Izk7TQrDxe2/LU4INk3hLodaVMeEbBLW3VJE3UQSYdlTwHpuff1VxCSE5O1bqyTB9xxmMne0FHlg7GyqvXqLLznkj0BCNQuE99myipU4JRe5plONvMc90G/JsBgK7l1lqutCVczsiOhvRMSwnA3d91fbZ9im7a79d2weRxQ5Bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121005; c=relaxed/simple;
	bh=p+N8DK0ve7ReR+PrLHPZmG27K6JrokchfEks9QeyikU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCkSM3JpeIXDVb9HZzf0BvyMSFPtDQr77FawdBwIvVnmOfh8izosP8XG6D/NjrooVEjWDCKh/1zyCsAVm98NvgRLY5hIRc3ivaNK3aaTGqnK+OUhrUmV3QwEc62D0bOoYKYXv4OUgQ9cbx3ooNt5oBzUilBdH45q/VOXKIvxpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wfmr63MlvzDqbp;
	Thu,  8 Aug 2024 20:41:26 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D22F31800FF;
	Thu,  8 Aug 2024 20:43:20 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:43:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v13 11/14] mm: page_frag: introduce prepare/probe/commit API
Date: Thu, 8 Aug 2024 20:37:11 +0800
Message-ID: <20240808123714.462740-12-linyunsheng@huawei.com>
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

There are many use cases that need minimum memory in order
for forward progress, but more performant if more memory is
available or need to probe the cache info to use any memory
available for frag caoleasing reason.

Currently skb_page_frag_refill() API is used to solve the
above use cases, but caller needs to know about the internal
detail and access the data field of 'struct page_frag' to
meet the requirement of the above use cases and its
implementation is similar to the one in mm subsystem.

To unify those two page_frag implementations, introduce a
prepare API to ensure minimum memory is satisfied and return
how much the actual memory is available to the caller and a
probe API to report the current available memory to caller
without doing cache refilling. The caller needs to either call
the commit API to report how much memory it actually uses, or
not do so if deciding to not use any memory.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |  75 ++++++++++++++++
 mm/page_frag_cache.c            | 152 ++++++++++++++++++++++++++++----
 2 files changed, 212 insertions(+), 15 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 0abffdd10a1c..ba5d7f8a03cd 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -7,6 +7,8 @@
 #include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
@@ -67,6 +69,9 @@ static inline unsigned int page_frag_cache_page_size(unsigned long encoded_va)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
+struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
+				unsigned int *offset, unsigned int fragsz,
+				gfp_t gfp);
 void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask);
@@ -79,12 +84,82 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
 }
 
+static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
+{
+	return page_frag_cache_page_size(nc->encoded_va) - nc->remaining;
+}
+
 static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 				       unsigned int fragsz, gfp_t gfp_mask)
 {
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
 }
 
+void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned int *fragsz,
+				 gfp_t gfp);
+
+static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
+						     unsigned int *fragsz,
+						     gfp_t gfp,
+						     unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
+	nc->remaining = nc->remaining & -align;
+	return page_frag_alloc_va_prepare(nc, fragsz, gfp);
+}
+
+struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
+					unsigned int *offset,
+					unsigned int *fragsz, gfp_t gfp);
+
+struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
+				     unsigned int *offset,
+				     unsigned int *fragsz,
+				     void **va, gfp_t gfp);
+
+static inline struct page *page_frag_alloc_probe(struct page_frag_cache *nc,
+						 unsigned int *offset,
+						 unsigned int *fragsz,
+						 void **va)
+{
+	unsigned long encoded_va = nc->encoded_va;
+	struct page *page;
+
+	VM_BUG_ON(!*fragsz);
+	if (unlikely(nc->remaining < *fragsz))
+		return NULL;
+
+	*va = encoded_page_address(encoded_va);
+	page = virt_to_page(*va);
+	*fragsz = nc->remaining;
+	*offset = page_frag_cache_page_size(encoded_va) - *fragsz;
+	*va += *offset;
+
+	return page;
+}
+
+static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
+					  unsigned int fragsz)
+{
+	VM_BUG_ON(fragsz > nc->remaining || !nc->pagecnt_bias);
+	nc->pagecnt_bias--;
+	nc->remaining -= fragsz;
+}
+
+static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
+						unsigned int fragsz)
+{
+	VM_BUG_ON(fragsz > nc->remaining);
+	nc->remaining -= fragsz;
+}
+
+static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
+					 unsigned int fragsz)
+{
+	nc->pagecnt_bias++;
+	nc->remaining += fragsz;
+}
+
 void page_frag_free_va(void *addr);
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 27596b84b452..f8fad7d2cca8 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -19,27 +19,27 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
-static bool __page_frag_cache_reuse(unsigned long encoded_va,
-				    unsigned int pagecnt_bias)
+static struct page *__page_frag_cache_reuse(unsigned long encoded_va,
+					    unsigned int pagecnt_bias)
 {
 	struct page *page;
 
 	page = virt_to_page((void *)encoded_va);
 	if (!page_ref_sub_and_test(page, pagecnt_bias))
-		return false;
+		return NULL;
 
 	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
 		free_unref_page(page, encoded_page_order(encoded_va));
-		return false;
+		return NULL;
 	}
 
 	/* OK, page count is 0, we can safely set it */
 	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
-	return true;
+	return page;
 }
 
-static bool __page_frag_cache_refill(struct page_frag_cache *nc,
-				     gfp_t gfp_mask)
+static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
+					     gfp_t gfp_mask)
 {
 	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
@@ -55,7 +55,7 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,
 		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
 		if (unlikely(!page)) {
 			memset(nc, 0, sizeof(*nc));
-			return false;
+			return NULL;
 		}
 
 		order = 0;
@@ -69,29 +69,151 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,
 	 */
 	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
-	return true;
+	return page;
 }
 
 /* Reload cache by reusing the old cache if it is possible, or
  * refilling from the page allocator.
  */
-static bool __page_frag_cache_reload(struct page_frag_cache *nc,
-				     gfp_t gfp_mask)
+static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
+					     gfp_t gfp_mask)
 {
+	struct page *page;
+
 	if (likely(nc->encoded_va)) {
-		if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
+		page = __page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias);
+		if (page)
 			goto out;
 	}
 
-	if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
-		return false;
+	page = __page_frag_cache_refill(nc, gfp_mask);
+	if (unlikely(!page))
+		return NULL;
 
 out:
 	/* reset page count bias and remaining to start of new frag */
 	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 	nc->remaining = page_frag_cache_page_size(nc->encoded_va);
-	return true;
+	return page;
+}
+
+void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
+				 unsigned int *fragsz, gfp_t gfp)
+{
+	unsigned int remaining = nc->remaining;
+
+	VM_BUG_ON(!*fragsz);
+	if (likely(remaining >= *fragsz)) {
+		unsigned long encoded_va = nc->encoded_va;
+
+		*fragsz = remaining;
+
+		return encoded_page_address(encoded_va) +
+			(page_frag_cache_page_size(encoded_va) - remaining);
+	}
+
+	if (unlikely(*fragsz > PAGE_SIZE))
+		return NULL;
+
+	/* When reload fails, nc->encoded_va and nc->remaining are both reset
+	 * to zero, so there is no need to check the return value here.
+	 */
+	__page_frag_cache_reload(nc, gfp);
+
+	*fragsz = nc->remaining;
+	return encoded_page_address(nc->encoded_va);
+}
+EXPORT_SYMBOL(page_frag_alloc_va_prepare);
+
+struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
+					unsigned int *offset,
+					unsigned int *fragsz, gfp_t gfp)
+{
+	unsigned int remaining = nc->remaining;
+	struct page *page;
+
+	VM_BUG_ON(!*fragsz);
+	if (likely(remaining >= *fragsz)) {
+		unsigned long encoded_va = nc->encoded_va;
+
+		*offset = page_frag_cache_page_size(encoded_va) - remaining;
+		*fragsz = remaining;
+
+		return virt_to_page((void *)encoded_va);
+	}
+
+	if (unlikely(*fragsz > PAGE_SIZE))
+		return NULL;
+
+	page = __page_frag_cache_reload(nc, gfp);
+	*offset = 0;
+	*fragsz = nc->remaining;
+	return page;
+}
+EXPORT_SYMBOL(page_frag_alloc_pg_prepare);
+
+struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
+				     unsigned int *offset,
+				     unsigned int *fragsz,
+				     void **va, gfp_t gfp)
+{
+	unsigned int remaining = nc->remaining;
+	struct page *page;
+
+	VM_BUG_ON(!*fragsz);
+	if (likely(remaining >= *fragsz)) {
+		unsigned long encoded_va = nc->encoded_va;
+
+		*offset = page_frag_cache_page_size(encoded_va) - remaining;
+		*va = encoded_page_address(encoded_va) + *offset;
+		*fragsz = remaining;
+
+		return virt_to_page((void *)encoded_va);
+	}
+
+	if (unlikely(*fragsz > PAGE_SIZE))
+		return NULL;
+
+	page = __page_frag_cache_reload(nc, gfp);
+	*offset = 0;
+	*fragsz = nc->remaining;
+	*va = encoded_page_address(nc->encoded_va);
+
+	return page;
+}
+EXPORT_SYMBOL(page_frag_alloc_prepare);
+
+struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
+				unsigned int *offset, unsigned int fragsz,
+				gfp_t gfp)
+{
+	unsigned int remaining = nc->remaining;
+	struct page *page;
+
+	VM_BUG_ON(!fragsz);
+	if (likely(remaining >= fragsz)) {
+		unsigned long encoded_va = nc->encoded_va;
+
+		*offset = page_frag_cache_page_size(encoded_va) -
+				remaining;
+
+		return virt_to_page((void *)encoded_va);
+	}
+
+	if (unlikely(fragsz > PAGE_SIZE))
+		return NULL;
+
+	page = __page_frag_cache_reload(nc, gfp);
+	if (unlikely(!page))
+		return NULL;
+
+	*offset = 0;
+	nc->remaining = remaining - fragsz;
+	nc->pagecnt_bias--;
+
+	return page;
 }
+EXPORT_SYMBOL(page_frag_alloc_pg);
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
-- 
2.33.0


