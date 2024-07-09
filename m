Return-Path: <netdev+bounces-110277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFA92BB5E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A04285D1D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E8A15FCE5;
	Tue,  9 Jul 2024 13:31:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D617A90F;
	Tue,  9 Jul 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531885; cv=none; b=GGkvWFhLKxO1O/3BPRHDCnSrGvhLp4tUtxLEp6vdF86oZwnvYN7goWiA1LbjS+RyHigheZHk2Qo6e4uDxjRu045uOig6YjomLiMV1wq8oJYALjXU5u0RGz+lbevNiOEuyl9mYm8CZfFCfF+xV0kbAaWOuRYoNdk6ZTD9OJgvlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531885; c=relaxed/simple;
	bh=ItIkff5kLg3YO2ShlKuGkzyXhe310WTjCq8zBxEHCA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldCwOqdz+kLtFOAB5Liyd8uPY2/90S5bQXNf6JuJVUovl32XDIOg0r8pUG6Y5c1NHvm6ChbqZ1hm4IR7ofUS7O2JWScerFrwTIFbsuZ7hKLsjpaDS/Ex5WU45th69/geq0J46Rj5LTi/qoCmpwTFHvgd/wl5ocUwrTeMrGWtXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WJMH14sF0zQl5R;
	Tue,  9 Jul 2024 21:27:25 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 84A83140485;
	Tue,  9 Jul 2024 21:31:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 21:31:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v10 11/15] mm: page_frag: introduce prepare/probe/commit API
Date: Tue, 9 Jul 2024 21:27:36 +0800
Message-ID: <20240709132741.47751-12-linyunsheng@huawei.com>
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
 include/linux/page_frag_cache.h |  76 +++++++++++++++++++++
 mm/page_frag_cache.c            | 114 ++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 71e08db1eb2f..cd60e08f6d44 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -8,6 +8,8 @@
 #include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mmdebug.h>
 #include <asm/page.h>
 
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
@@ -83,6 +85,9 @@ static inline unsigned int page_frag_cache_page_size(unsigned long encoded_va)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
+struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
+				unsigned int *offset, unsigned int fragsz,
+				gfp_t gfp);
 void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 				 unsigned int fragsz, gfp_t gfp_mask,
 				 unsigned int align_mask);
@@ -95,12 +100,83 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
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
+	WARN_ON_ONCE(!is_power_of_2(align));
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
+	unsigned long encoded_va;
+	struct page *page;
+
+	VM_BUG_ON(!*fragsz);
+	if (unlikely(nc->remaining < *fragsz))
+		return NULL;
+
+	*fragsz = nc->remaining;
+	encoded_va = nc->encoded_va;
+	*va = encoded_page_address(encoded_va);
+	page = virt_to_page(*va);
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
index b2cb4473db54..b21001bb4087 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -88,6 +88,120 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
+				 unsigned int *fragsz, gfp_t gfp)
+{
+	unsigned long encoded_va;
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
+	unsigned long encoded_va;
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
+		page = virt_to_page((void *)encoded_va);
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
+	unsigned long encoded_va;
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
+		page = virt_to_page((void *)encoded_va);
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
+		unsigned long encoded_va = nc->encoded_va;
+
+		page = virt_to_page((void *)encoded_va);
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
2.33.0


