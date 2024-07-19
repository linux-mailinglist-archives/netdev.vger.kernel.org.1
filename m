Return-Path: <netdev+bounces-112193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC39375C5
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AA1B226AC
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11A83A0E;
	Fri, 19 Jul 2024 09:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC6823C3;
	Fri, 19 Jul 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381825; cv=none; b=uC0ohJZn9ekGIw0D3Q3YiySJonTO96gX99mTs1Nlx/yqXfTR76wMKniJckKBIcA2CcUWpFxXTrtwAEEMN9ib9hstwUORWezdNWSDhhPShkYJCrfYLWmCZ/tEdmEDipp//p31viR7mRJpoMHYKS93cldiUBKUfPDHNh6uC+MVZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381825; c=relaxed/simple;
	bh=vInUddj6K15/jkauadL7IbXRvEribTObskZSEjEpOTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzjvWHta49UJHjhKFo/OSmraKUjQLlcebuAh3wk5B4E3ttH34J2yQndnJiZsNT6tGGVxLBBhNxdb85sqrnEdENwnyKp+y4DLfNgDLCjOWu7pnYHaOGSYEcyNgWCmH+qoh+xnw3mkucazK4Qg7gls3VytRcoqPsvOFfLaQex87ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WQPfX3jDDzdhyt;
	Fri, 19 Jul 2024 17:35:16 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3762E140154;
	Fri, 19 Jul 2024 17:37:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Jul 2024 17:37:00 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [RFC v11 03/14] mm: page_frag: use initial zero offset for page_frag_alloc_align()
Date: Fri, 19 Jul 2024 17:33:27 +0800
Message-ID: <20240719093338.55117-4-linyunsheng@huawei.com>
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

We are about to use page_frag_alloc_*() API to not just
allocate memory for skb->data, but also use them to do
the memory allocation for skb frag too. Currently the
implementation of page_frag in mm subsystem is running
the offset as a countdown rather than count-up value,
there may have several advantages to that as mentioned
in [1], but it may have some disadvantages, for example,
it may disable skb frag coaleasing and more correct cache
prefetching

We have a trade-off to make in order to have a unified
implementation and API for page_frag, so use a initial zero
offset in this patch, and the following patch will try to
make some optimization to avoid the disadvantages as much
as possible.

Rename 'offset' to 'remaining' to retain the 'countdown'
behavior as 'remaining countdown' instead of 'offset
countdown'. Also, Renaming enable us to do a single
'fragsz > remaining' checking for the case of cache not
being enough, which should be the fast path if we ensure
'remaining' is zero when 'va' == NULL by memset'ing
'struct page_frag_cache' in page_frag_cache_init() and
page_frag_cache_drain().

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/mm_types_task.h |  4 +-
 mm/page_frag_cache.c          | 71 +++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index cdc1e3696439..b1c54b2b9308 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -52,10 +52,10 @@ struct page_frag {
 struct page_frag_cache {
 	void *va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	__u16 offset;
+	__u16 remaining;
 	__u16 size;
 #else
-	__u32 offset;
+	__u32 remaining;
 #endif
 	/* we maintain a pagecount bias, so that we dont dirty cache line
 	 * containing page->_refcount every time we allocate a fragment.
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 609a485cd02a..2958fe006fe7 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -22,6 +22,7 @@
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
+	unsigned int page_size = PAGE_FRAG_CACHE_MAX_SIZE;
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
@@ -30,12 +31,21 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
 #endif
-	if (unlikely(!page))
+	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		if (unlikely(!page)) {
+			nc->va = NULL;
+			return NULL;
+		}
 
-	nc->va = page ? page_address(page) : NULL;
+		page_size = PAGE_SIZE;
+	}
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	nc->size = page_size;
+#endif
+	nc->va = page_address(page);
 
 	return page;
 }
@@ -64,8 +74,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int align_mask)
 {
 	unsigned int size = PAGE_SIZE;
+	unsigned int remaining;
 	struct page *page;
-	int offset;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -82,35 +92,20 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		 */
 		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
-		/* reset page count bias and offset to start of new frag */
+		/* reset page count bias and remaining to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
+		nc->remaining = size;
 	}
 
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
-		page = virt_to_page(nc->va);
-
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
-			goto refill;
-
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
-			goto refill;
-		}
-
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
+	/* if size can vary use size else just use PAGE_SIZE */
+	size = nc->size;
 #endif
-		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
-		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = size - fragsz;
-		if (unlikely(offset < 0)) {
+	remaining = nc->remaining & align_mask;
+	if (unlikely(remaining < fragsz)) {
+		if (unlikely(fragsz > PAGE_SIZE)) {
 			/*
 			 * The caller is trying to allocate a fragment
 			 * with fragsz > PAGE_SIZE but the cache isn't big
@@ -122,13 +117,31 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			 */
 			return NULL;
 		}
+
+		page = virt_to_page(nc->va);
+
+		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+			goto refill;
+
+		if (unlikely(nc->pfmemalloc)) {
+			free_unref_page(page, compound_order(page));
+			goto refill;
+		}
+
+		/* OK, page count is 0, we can safely set it */
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+		/* reset page count bias and remaining to start of new frag */
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		nc->remaining = size;
+
+		remaining = size;
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
+	nc->remaining = remaining - fragsz;
 
-	return nc->va + offset;
+	return nc->va + (size - remaining);
 }
 EXPORT_SYMBOL(__page_frag_alloc_align);
 
-- 
2.33.0


