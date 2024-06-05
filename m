Return-Path: <netdev+bounces-101026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FE8FD058
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81399B2CBA9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788519B58C;
	Wed,  5 Jun 2024 13:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBA19ADBA;
	Wed,  5 Jun 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594591; cv=none; b=bA1gPYCjjCPG91OkdR2yUTPtjUmZmeaLAU7KNmU3awb0FvN+JZQDXZMuoDfOiSfmVOGqnLL2LJ8DsdL4p+NBjMII5hb3Odw1rIxgDdL3QZJ2C5ebCjavUBO+sKh71c511unIdr9lHXuKYtQ6bpf2Deu2ZGsKXoT/xIr+FF1viqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594591; c=relaxed/simple;
	bh=koKXP6xg67ygGfuj3kYoe8zfvum0YQDhg13CFU9k5CI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6cviAiqhN5YLh74tarzfCp0gsne4d3cTxBHt4LPWAn4m5wjTI54IzuQ7erpbXLt4E6ZzqX3jNOJ4k73Cfmw/4MMtGQQeVPxiiucCAePls/46OpLIC5VuhmyZmo3uUiNxv5/zgKOI340X46jpl5GjUQLk4d/Ewby9zlnJsN5p1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvT0b3ZhCzwRrf;
	Wed,  5 Jun 2024 21:32:31 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A84118007A;
	Wed,  5 Jun 2024 21:36:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 21:36:28 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v6 12/15] mm: page_frag: introduce prepare/probe/commit API
Date: Wed, 5 Jun 2024 21:33:02 +0800
Message-ID: <20240605133306.11272-13-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240605133306.11272-1-linyunsheng@huawei.com>
References: <20240605133306.11272-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 include/linux/page_frag_cache.h |  82 +++++++++++++++++++++++
 mm/page_frag_cache.c            | 114 ++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index b33904d4494f..e95d44a36ec9 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -4,6 +4,7 @@
 #define _LINUX_PAGE_FRAG_CACHE_H
 
 #include <linux/gfp_types.h>
+#include <linux/mmdebug.h>
 
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
@@ -87,6 +88,9 @@ static inline unsigned int page_frag_cache_page_size(struct encoded_va *encoded_
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
+struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
+				unsigned int *offset, unsigned int fragsz,
+				gfp_t gfp);
 void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask);
@@ -99,12 +103,90 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
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
+static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache *nc,
+							 unsigned int *offset,
+							 unsigned int *fragsz,
+							 void **va)
+{
+	struct encoded_va *encoded_va;
+
+	*fragsz = nc->remaining;
+	encoded_va = nc->encoded_va;
+	*offset = page_frag_cache_page_size(encoded_va) - *fragsz;
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
index 525b577b03a9..9f86aa15bbeb 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -94,6 +94,120 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
+				 unsigned int *fragsz, gfp_t gfp)
+{
+	struct encoded_va *encoded_va;
+	unsigned int remaining;
+
+	remaining = nc->remaining;
+	if (unlikely(*fragsz > remaining)) {
+		if (unlikely(!__page_frag_cache_refill(nc, gfp) ||
+			     *fragsz > PAGE_SIZE))
+			return NULL;
+
+		remaining = nc->remaining;
+	}
+
+	encoded_va = nc->encoded_va;
+	*fragsz = remaining;
+	return encoded_page_address(encoded_va) +
+			page_frag_cache_page_size(encoded_va) - remaining;
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
+		if (unlikely(*fragsz > PAGE_SIZE)) {
+			*fragsz = 0;
+			return NULL;
+		}
+
+		page = __page_frag_cache_refill(nc, gfp);
+		remaining = nc->remaining;
+		encoded_va = nc->encoded_va;
+	} else {
+		encoded_va = nc->encoded_va;
+		page = virt_to_page(encoded_va);
+	}
+
+	*offset = page_frag_cache_page_size(encoded_va) - remaining;
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
+		if (unlikely(*fragsz > PAGE_SIZE)) {
+			*fragsz = 0;
+			return NULL;
+		}
+
+		page = __page_frag_cache_refill(nc, gfp);
+		remaining = nc->remaining;
+		encoded_va = nc->encoded_va;
+	} else {
+		encoded_va = nc->encoded_va;
+		page = virt_to_page(encoded_va);
+	}
+
+	*offset = page_frag_cache_page_size(encoded_va) - remaining;
+	*fragsz = remaining;
+	*va = encoded_page_address(encoded_va) + *offset;
+
+	return page;
+}
+EXPORT_SYMBOL(page_frag_alloc_prepare);
+
+struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
+				unsigned int *offset, unsigned int fragsz,
+				gfp_t gfp)
+{
+	struct page *page;
+
+	if (unlikely(fragsz > nc->remaining)) {
+		if (unlikely(fragsz > PAGE_SIZE))
+			return NULL;
+
+		page = __page_frag_cache_refill(nc, gfp);
+		if (unlikely(!page))
+			return NULL;
+
+		*offset = 0;
+	} else {
+		struct encoded_va *encoded_va = nc->encoded_va;
+
+		page = virt_to_page(encoded_va);
+		*offset = page_frag_cache_page_size(encoded_va) -
+					nc->remaining;
+	}
+
+	nc->remaining -= fragsz;
+	nc->pagecnt_bias--;
+
+	return page;
+}
+EXPORT_SYMBOL(page_frag_alloc_pg);
+
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->encoded_va)
-- 
2.30.0


