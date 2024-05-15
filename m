Return-Path: <netdev+bounces-96561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E28C670D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7CA285231
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EF12FB08;
	Wed, 15 May 2024 13:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0D1272C6;
	Wed, 15 May 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778791; cv=none; b=IvdorhzbUKEpG55l9klhzznGjxeA5vSgGpyHgvC1Dyo7URhlVmyNS8BfxWCfUfL0xsGS+nKJLo1f/L0JLBcWlbo41Rkzl+cOwuXOvd4C5H7FtwRWElH/bI21WBYQHh6myTe6X9369Voy0Ebz+VOUA/NUAkKFUO83AS0C2t7ZaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778791; c=relaxed/simple;
	bh=rprf0hIF/lh/fMd1F9dWDjhzLBr59fAeiYlGZjn0u1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tebf0hK2YRRA0Ynq6vi6jVIyVMtZ1l6DF4/RhsH9rXSbIlxoX/f9iEtcPF6puPDOOxjeCYbQrLxLc2PNlrpzytsN+U3npKBYBMGipWxA5G8/otQFYHyypt06az2vnvpLLTha2vsOoFaxfL5SuXb9lF+8NaHk6eJ+EKrYvQD6gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VfYVY4rcXzPkHr;
	Wed, 15 May 2024 21:10:13 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3537E18007D;
	Wed, 15 May 2024 21:13:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 21:13:07 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [RFC v4 10/13] mm: page_frag: introduce prepare/probe/commit API
Date: Wed, 15 May 2024 21:09:29 +0800
Message-ID: <20240515130932.18842-11-linyunsheng@huawei.com>
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

As next patch is about to replace 'struct page_frag' with
'struct page_frag_cache' in linux/sched.h, which is included
by the asm-offsets.s, using the virt_to_page() in the inline
helper of page_frag_cache.h cause a "'vmemmap' undeclared"
compiling error for asm-offsets.s, use a macro for probe API
to avoid that compiling error.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |  78 ++++++++++++++++++++
 mm/page_frag_cache.c            | 121 ++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 5f9971c1be74..50466f5b71ea 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -100,12 +100,90 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
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
+	struct page *__page = NULL;					\
+									\
+	VM_BUG_ON(!*(fragsz));						\
+	if (likely((nc)->remaining >= *(fragsz)))			\
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
index 97cbc2dac67f..273ccd715eae 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -54,6 +54,127 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+static struct page *page_frag_cache_refill(struct page_frag_cache *nc,
+					   gfp_t gfp_mask)
+{
+	struct encoded_va *encoded_va = nc->encoded_va;
+	struct page *page;
+
+	if (unlikely(!encoded_va)) {
+refill:
+		page = __page_frag_cache_refill(nc, gfp_mask);
+		if (!page)
+			return NULL;
+
+		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		return page;
+	}
+
+	page = virt_to_page(encoded_va);
+
+	if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+		goto refill;
+
+	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
+		free_unref_page(page, compound_order(page));
+		goto refill;
+	}
+
+	/* OK, page count is 0, we can safely set it */
+	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+
+	/* reset page count bias and offset to start of new frag */
+	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+	nc->remaining = page_frag_cache_page_size(encoded_va);
+
+	return page;
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


