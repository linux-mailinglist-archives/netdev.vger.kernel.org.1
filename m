Return-Path: <netdev+bounces-125821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6296EC63
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D09D1F26E0D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E315B133;
	Fri,  6 Sep 2024 07:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC8154449;
	Fri,  6 Sep 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608582; cv=none; b=l0c/61A/cYn41L8LH6aAJ8FdFnW/3BEy/p8IGzyeXEhkqYpHaQviOXjiCnW+Jh0vV/4CJ+H2IHnqBUyW39n1Pj74/DaVbxTb/YjOtgDOiOF03uJOqfJ5uLQ3HdICec9r5yjfFlw5sAItl4BYHU8qK1eSz35yvW1tPcj0R2HUYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608582; c=relaxed/simple;
	bh=MjNpIOFR13jYDcEPa2AYENc8rWGBSlcQdbLZTDbhX8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgCMmtiHVCFtnp8b1H8tzw7b+3m85aPIeqACQoMS8DUowx39GZzcchBSajB7wA03O4IGFkDvNT6xXOyu0a1RlQt9A8Gp2T7coK9MozdA1HtLH4tQMEWtarQnB88SmtYGVqlva0RSAmZzh1GOsTut5sFAuwhxVwrPQZyzFZgVudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X0Sp04Rrzz1xx4R;
	Fri,  6 Sep 2024 15:40:56 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CCD31401F0;
	Fri,  6 Sep 2024 15:42:58 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:42:57 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v18 10/14] mm: page_frag: introduce prepare/probe/commit API
Date: Fri, 6 Sep 2024 15:36:42 +0800
Message-ID: <20240906073646.2930809-11-linyunsheng@huawei.com>
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
index b634e1338741..4e9018051956 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -40,6 +40,11 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 	return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
 }
 
+static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
+{
+	return nc->offset;
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
@@ -48,6 +53,10 @@ void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
 unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
 					    struct page_frag *pfrag,
 					    unsigned int used_sz);
+void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
+					   unsigned int fragsz,
+					   struct page_frag *pfrag,
+					   unsigned int align_mask);
 
 static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
 						    struct page_frag *pfrag,
@@ -90,6 +99,132 @@ static inline void *page_frag_alloc(struct page_frag_cache *nc,
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
index a5448b44068a..c052c77a96eb 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -117,6 +117,27 @@ unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
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
+	size = page_frag_cache_page_size(encoded_page);
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(!encoded_page || offset + fragsz > size))
+		return NULL;
+
+	pfrag->page = page_frag_encoded_page_ptr(encoded_page);
+	pfrag->size = size - offset;
+	pfrag->offset = offset;
+
+	return page_frag_encoded_page_address(encoded_page) + offset;
+}
+EXPORT_SYMBOL(__page_frag_alloc_refill_probe_align);
+
 void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
 				struct page_frag *pfrag, gfp_t gfp_mask,
 				unsigned int align_mask)
-- 
2.33.0


