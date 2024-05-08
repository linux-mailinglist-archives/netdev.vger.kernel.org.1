Return-Path: <netdev+bounces-94588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656FF8BFEF0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB8284655
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D88127B4D;
	Wed,  8 May 2024 13:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5986ADE;
	Wed,  8 May 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175425; cv=none; b=jDQFOJMk2oklgcGUudWTH0e2zH5TEu56dsiPtByb8pGc/Dt1mWHO2uQ/nmX+ttb2ejh8Zd84gITxVDaXsWpPPkzxMuCd+DehPrqiZplWIl1mnJYwb7I+g+LraA6GP2H9EU9ho8HwHSOW4LtHESXg1qHEdElSr8dKczNiP4ghZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175425; c=relaxed/simple;
	bh=B8wHLiPysTfBg2nMFwGXKpRynAT704tXbUTNVmCk1tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saZgfaPdSw0wUtLgpHd8lTli7j5P6tUi4fr0NCOs1D0UuLnvcvlscRjvQgLWeS1lWp2YenJXHNuyMVbXb1bnaguTV9MsiV1kdyc5vBMccfYwJsTvnPUp00MUO5WpSVExUWRTmjmyNfdpYaDqrfNpTuAGwdoOk8HjvW3k/8e2SaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VZGLl2BwMztT5f;
	Wed,  8 May 2024 21:33:35 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 89D8218007B;
	Wed,  8 May 2024 21:37:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:37:01 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v3 10/13] mm: page_frag: introduce prepare/probe/commit API
Date: Wed, 8 May 2024 21:34:05 +0800
Message-ID: <20240508133408.54708-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240508133408.54708-1-linyunsheng@huawei.com>
References: <20240508133408.54708-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

There are many use cases that need minimum memory in order
for forward progressing, but more performant if more memory
is available or need to probe the cache info to use any
memory available for frag caoleasing reason.

Currently skb_page_frag_refill() API is used to solve the
above usecases, caller need to know about the internal detail
and access the data field of 'struct page_frag' to meet the
requirement of the above use cases and its implementation is
similar to the one in mm subsystem.

To unify those two page_frag implementations, introduce a
prepare API to ensure minimum memory is satisfied and return
how much the actual memory is available to the caller and a
probe API to report the current available memory to caller
without doing cache refilling. The caller needs to either call
the commit API to report how much memory it actually uses, or
not do so if deciding to not use any memory.

As next patch is about to replace 'struct page_frag' with
'struct page_frag_cache' in linux/sched.h, which is included
by the asm-offsets.s, using the virt_to_page() in the inline
helper of page_frag_cache.h cause a "‘vmemmap’ undeclared"
compiling error for asm-offsets.s, use a macro for probe API
to avoid that compiling error.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |  86 ++++++++++++++++++++++++
 mm/page_frag_cache.c            | 113 ++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 88e91ee57b91..30893638155b 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -71,6 +71,21 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 	return encoded_page_pfmemalloc(nc->encoded_va);
 }
 
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
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
@@ -85,12 +100,83 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
 }
 
+static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
+{
+	return __page_frag_cache_page_offset(nc->encoded_va, nc->remaining);
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
+static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache *nc,
+							 unsigned int *offset,
+							 unsigned int *fragsz,
+							 void **va)
+{
+	struct encoded_va *encoded_va;
+
+	*fragsz = nc->remaining;
+	encoded_va = nc->encoded_va;
+	*offset = __page_frag_cache_page_offset(encoded_va, *fragsz);
+	*va = encoded_page_address(encoded_va) + *offset;
+
+	return encoded_va;
+}
+
+#define page_frag_alloc_probe(nc, offset, fragsz, va)			\
+({									\
+	struct encoded_va *__encoded_va;				\
+	struct page *__page = NULL;					\
+									\
+	if (likely((nc)->remaining))					\
+		__page = virt_to_page(__page_frag_alloc_probe(nc,	\
+							      offset,	\
+							      fragsz,	\
+							      va));	\
+									\
+	__page;								\
+})
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
 void page_frag_free_va(void *addr);
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 4542d72e7b01..eb8bf59b26bb 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -60,6 +60,119 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return NULL;
 }
 
+static struct page *page_frag_cache_refill(struct page_frag_cache *nc,
+					   gfp_t gfp_mask)
+{
+	struct encoded_va *encoded_va = nc->encoded_va;
+
+	if (likely(encoded_va)) {
+		struct page *page = virt_to_page(encoded_va);
+
+		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+			return __page_frag_cache_refill(nc, gfp_mask);
+
+		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+			free_unref_page(page, compound_order(page));
+			return __page_frag_cache_refill(nc, gfp_mask);
+		}
+
+		/* OK, page count is 0, we can safely set it */
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+		/* reset page count bias and offset to start of new frag */
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		nc->remaining = page_frag_cache_page_size(encoded_va);
+
+		return page;
+	}
+
+	return __page_frag_cache_refill(nc, gfp_mask);
+}
+
+void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
+				 unsigned int *fragsz, gfp_t gfp)
+{
+	struct encoded_va *encoded_va;
+	unsigned int remaining;
+
+	remaining = nc->remaining;
+	if (unlikely(*fragsz > remaining)) {
+		if (WARN_ON_ONCE(*fragsz > PAGE_SIZE) ||
+		    !page_frag_cache_refill(nc, gfp))
+			return NULL;
+
+		remaining = nc->remaining;
+	}
+
+	encoded_va = nc->encoded_va;
+	*fragsz = remaining;
+	return encoded_page_address(encoded_va) +
+			__page_frag_cache_page_offset(encoded_va, remaining);
+}
+EXPORT_SYMBOL(page_frag_alloc_va_prepare);
+
+struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
+					unsigned int *offset,
+					unsigned int *fragsz, gfp_t gfp)
+{
+	struct encoded_va *encoded_va;
+	unsigned int remaining;
+	struct page *page;
+
+	remaining = nc->remaining;
+	if (unlikely(*fragsz > remaining)) {
+		if (WARN_ON_ONCE(*fragsz > PAGE_SIZE)) {
+			*fragsz = 0;
+			return NULL;
+		}
+
+		page = page_frag_cache_refill(nc, gfp);
+		remaining = nc->remaining;
+		encoded_va = nc->encoded_va;
+	} else {
+		encoded_va = nc->encoded_va;
+		page = virt_to_page(encoded_va);
+	}
+
+	*offset = __page_frag_cache_page_offset(encoded_va, remaining);
+	*fragsz = remaining;
+
+	return page;
+}
+EXPORT_SYMBOL(page_frag_alloc_pg_prepare);
+
+struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
+				     unsigned int *offset,
+				     unsigned int *fragsz,
+				     void **va, gfp_t gfp)
+{
+	struct encoded_va *encoded_va;
+	unsigned int remaining;
+	struct page *page;
+
+	remaining = nc->remaining;
+	if (unlikely(*fragsz > remaining)) {
+		if (WARN_ON_ONCE(*fragsz > PAGE_SIZE)) {
+			*fragsz = 0;
+			return NULL;
+		}
+
+		page = page_frag_cache_refill(nc, gfp);
+		remaining = nc->remaining;
+		encoded_va = nc->encoded_va;
+	} else {
+		encoded_va = nc->encoded_va;
+		page = virt_to_page(encoded_va);
+	}
+
+	*offset = __page_frag_cache_page_offset(encoded_va, remaining);
+	*fragsz = remaining;
+	*va = encoded_page_address(encoded_va) + *offset;
+
+	return page;
+}
+EXPORT_SYMBOL(page_frag_alloc_prepare);
+
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->encoded_va)
-- 
2.33.0


