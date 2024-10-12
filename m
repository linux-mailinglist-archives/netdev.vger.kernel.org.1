Return-Path: <netdev+bounces-134828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B399B454
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4888C28E33C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988702040A2;
	Sat, 12 Oct 2024 11:29:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094C1A0B08;
	Sat, 12 Oct 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732597; cv=none; b=Mg6C0v3L7jZwahJ1NbjrF6z8KtbpzfPB4igPLOnNDmrPcLpx+DeJY0Y6S6uoljE4yJi10PTsylHgDQLnATXhBIb704foQxsvXM8asVwlGA8i2jWpiNKz6ow8aGUVfTnwxTxeikChXQaz4Fj9ZzNcUZ8MRodA3boIGet0IVqxrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732597; c=relaxed/simple;
	bh=le1jJsxG2hG8+S/6kiQeOL3nY3QgeFDH/55Gds/jM3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ2jI2b5UnWuO69z9ZqKpEtbaLyv7UZnhzyYl0l/yiM/cfling9F7YxAZMmsL56/a3qcCizSmOJ0FG/sHqFj9stOVTp1TaKzpc07r/jFjZqlxURWn3bFwgF7j09bBsHs56T/pNtwDGfBy7qKdiMKd6wjMe27uUBbxZde7VbQQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XQh8n2VjszQrcZ;
	Sat, 12 Oct 2024 19:29:13 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 65C0D180087;
	Sat, 12 Oct 2024 19:29:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 19:29:53 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v21 10/14] mm: page_frag: introduce prepare/probe/commit API
Date: Sat, 12 Oct 2024 19:23:16 +0800
Message-ID: <20241012112320.2503906-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241012112320.2503906-1-linyunsheng@huawei.com>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 include/linux/page_frag_cache.h | 135 ++++++++++++++++++++++++++++++++
 mm/page_frag_cache.c            |  21 +++++
 2 files changed, 156 insertions(+)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index feed99d0cddb..e21688e7edc8 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -38,6 +38,11 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 	return encoded_page_decode_pfmemalloc(nc->encoded_page);
 }
 
+static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
+{
+	return nc->offset;
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
@@ -46,6 +51,10 @@ void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
 unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
 					    struct page_frag *pfrag,
 					    unsigned int used_sz);
+void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
+					   unsigned int fragsz,
+					   struct page_frag *pfrag,
+					   unsigned int align_mask);
 
 static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
 						    struct page_frag *pfrag,
@@ -88,6 +97,132 @@ static inline void *page_frag_alloc(struct page_frag_cache *nc,
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
 }
 
+static inline bool __page_frag_refill_align(struct page_frag_cache *nc,
+					    unsigned int fragsz,
+					    struct page_frag *pfrag,
+					    gfp_t gfp_mask,
+					    unsigned int align_mask)
+{
+	if (unlikely(!__page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask,
+						align_mask)))
+		return false;
+
+	__page_frag_cache_commit(nc, pfrag, fragsz);
+	return true;
+}
+
+static inline bool page_frag_refill_align(struct page_frag_cache *nc,
+					  unsigned int fragsz,
+					  struct page_frag *pfrag,
+					  gfp_t gfp_mask, unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, -align);
+}
+
+static inline bool page_frag_refill(struct page_frag_cache *nc,
+				    unsigned int fragsz,
+				    struct page_frag *pfrag, gfp_t gfp_mask)
+{
+	return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, ~0u);
+}
+
+static inline bool __page_frag_refill_prepare_align(struct page_frag_cache *nc,
+						    unsigned int fragsz,
+						    struct page_frag *pfrag,
+						    gfp_t gfp_mask,
+						    unsigned int align_mask)
+{
+	return !!__page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask,
+					   align_mask);
+}
+
+static inline bool page_frag_refill_prepare_align(struct page_frag_cache *nc,
+						  unsigned int fragsz,
+						  struct page_frag *pfrag,
+						  gfp_t gfp_mask,
+						  unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_refill_prepare_align(nc, fragsz, pfrag, gfp_mask,
+						-align);
+}
+
+static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
+					    unsigned int fragsz,
+					    struct page_frag *pfrag,
+					    gfp_t gfp_mask)
+{
+	return __page_frag_refill_prepare_align(nc, fragsz, pfrag, gfp_mask,
+						~0u);
+}
+
+static inline void *__page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
+							   unsigned int fragsz,
+							   struct page_frag *pfrag,
+							   gfp_t gfp_mask,
+							   unsigned int align_mask)
+{
+	return __page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask, align_mask);
+}
+
+static inline void *page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
+							 unsigned int fragsz,
+							 struct page_frag *pfrag,
+							 gfp_t gfp_mask,
+							 unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
+						      gfp_mask, -align);
+}
+
+static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
+						   unsigned int fragsz,
+						   struct page_frag *pfrag,
+						   gfp_t gfp_mask)
+{
+	return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
+						      gfp_mask, ~0u);
+}
+
+static inline void *page_frag_alloc_refill_probe(struct page_frag_cache *nc,
+						 unsigned int fragsz,
+						 struct page_frag *pfrag)
+{
+	return __page_frag_alloc_refill_probe_align(nc, fragsz, pfrag, ~0u);
+}
+
+static inline bool page_frag_refill_probe(struct page_frag_cache *nc,
+					  unsigned int fragsz,
+					  struct page_frag *pfrag)
+{
+	return !!page_frag_alloc_refill_probe(nc, fragsz, pfrag);
+}
+
+static inline void page_frag_commit(struct page_frag_cache *nc,
+				    struct page_frag *pfrag,
+				    unsigned int used_sz)
+{
+	__page_frag_cache_commit(nc, pfrag, used_sz);
+}
+
+static inline void page_frag_commit_noref(struct page_frag_cache *nc,
+					  struct page_frag *pfrag,
+					  unsigned int used_sz)
+{
+	__page_frag_cache_commit_noref(nc, pfrag, used_sz);
+}
+
+static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
+					 unsigned int fragsz)
+{
+	VM_BUG_ON(fragsz > nc->offset);
+
+	nc->pagecnt_bias++;
+	nc->offset -= fragsz;
+}
+
 void page_frag_free(void *addr);
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index f55d34cf7d43..5ea4b663ab8e 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -112,6 +112,27 @@ unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(__page_frag_cache_commit_noref);
 
+void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
+					   unsigned int fragsz,
+					   struct page_frag *pfrag,
+					   unsigned int align_mask)
+{
+	unsigned long encoded_page = nc->encoded_page;
+	unsigned int size, offset;
+
+	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(!encoded_page || offset + fragsz > size))
+		return NULL;
+
+	pfrag->page = encoded_page_decode_page(encoded_page);
+	pfrag->size = size - offset;
+	pfrag->offset = offset;
+
+	return encoded_page_decode_virt(encoded_page) + offset;
+}
+EXPORT_SYMBOL(__page_frag_alloc_refill_probe_align);
+
 void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
 				struct page_frag *pfrag, gfp_t gfp_mask,
 				unsigned int align_mask)
-- 
2.33.0


