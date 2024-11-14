Return-Path: <netdev+bounces-144889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE249C8A0E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27698B2574C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61061FB3FE;
	Thu, 14 Nov 2024 12:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112E1FB3D7;
	Thu, 14 Nov 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586982; cv=none; b=eTymf+uSo7SI1bUcMTcNt6Av3vyY1yDa5+EVlAIIyfIA3KOCrtv3kEtk7aMmHeV6NNDYONEuFju4+TfaH0e0oJHcIvroHCZKJFPlJO94TqnO7xdtAvHlfuV5vbzZ+sBOdTFPSmVPOjvRs7kAbtX2SzaCn29ZpgMHYrZzEqah7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586982; c=relaxed/simple;
	bh=W3AVsAVLDdbyor+wQ6o1A8oHcmMgqyXwTinoCUUNnDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi2PHzA7d7fYm9PMX1F1hy62DTPSUBBwWPrmW9fyJ+RX4HzfxQQuItmgq6r/XtWgd8CJBE2SdSQKK8cidzZzftgwsAARMNiAJi1PVtKd5QLN/N0f8D6CRaYTbsJp61yaqk/nYXjJa4AHMd4vEPiINBgmGMawZ7cJEoCh2e6QxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XpzlP60DHz2Dh2P;
	Thu, 14 Nov 2024 20:21:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C66E1A016C;
	Thu, 14 Nov 2024 20:22:57 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 20:22:56 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v1 07/10] mm: page_frag: introduce probe related API
Date: Thu, 14 Nov 2024 20:16:02 +0800
Message-ID: <20241114121606.3434517-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241114121606.3434517-1-linyunsheng@huawei.com>
References: <20241114121606.3434517-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Some usecase may need a bigger fragment if current fragment
can't be coalesced to previous fragment because more space
for some header may be needed if it is a new fragment. So
introduce probe related API to tell if there are minimum
remaining memory in the cache to be coalesced to the previous
fragment, in order to save memory as much as possible.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 10 +++++++-
 include/linux/page_frag_cache.h | 41 +++++++++++++++++++++++++++++++++
 mm/page_frag_cache.c            | 35 ++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 1c98f7090d92..3e34831a0029 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -119,7 +119,13 @@ more performant if more memory is available. By using the prepare and commit
 related API, the caller calls prepare API to requests the minimum memory it
 needs and prepare API will return the maximum size of the fragment returned. The
 caller needs to either call the commit API to report how much memory it actually
-uses, or not do so if deciding to not use any memory.
+uses, or not do so if deciding to not use any memory. Some usecase may need a
+bigger fragment if the current fragment can't be coalesced to previous fragment
+because more space for some header may be needed if it is a new fragment, probe
+related API can be used to tell if there are minimum remaining memory in the
+cache to be coalesced to the previous fragment, in order to save memory as much
+as possible.
+
 
 .. kernel-doc:: include/linux/page_frag_cache.h
    :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
@@ -129,9 +135,11 @@ uses, or not do so if deciding to not use any memory.
 		 __page_frag_alloc_refill_prepare_align
 		 page_frag_alloc_refill_prepare_align
 		 page_frag_alloc_refill_prepare
+                 page_frag_alloc_refill_probe page_frag_refill_probe
 
 .. kernel-doc:: mm/page_frag_cache.c
    :identifiers: page_frag_cache_drain page_frag_free page_frag_alloc_abort_ref
+                 __page_frag_alloc_refill_probe_align
 
 Coding examples
 ===============
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 329390afbe78..0f7e8da91a67 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -63,6 +63,10 @@ void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
 unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
 					    struct page_frag *pfrag,
 					    unsigned int used_sz);
+void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
+					   unsigned int fragsz,
+					   struct page_frag *pfrag,
+					   unsigned int align_mask);
 
 static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
 						    struct page_frag *pfrag,
@@ -282,6 +286,43 @@ static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
 						      gfp_mask, ~0u);
 }
 
+/**
+ * page_frag_alloc_refill_probe() - Probe allocating a fragment and refilling
+ * a page_frag.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled
+ *
+ * Probe allocating a fragment and refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
+static inline void *page_frag_alloc_refill_probe(struct page_frag_cache *nc,
+						 unsigned int fragsz,
+						 struct page_frag *pfrag)
+{
+	return __page_frag_alloc_refill_probe_align(nc, fragsz, pfrag, ~0u);
+}
+
+/**
+ * page_frag_refill_probe() - Probe refilling a page_frag.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled
+ *
+ * Probe refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
+static inline bool page_frag_refill_probe(struct page_frag_cache *nc,
+					  unsigned int fragsz,
+					  struct page_frag *pfrag)
+{
+	return !!page_frag_alloc_refill_probe(nc, fragsz, pfrag);
+}
+
 /**
  * page_frag_refill_commit - Commit a prepare refilling.
  * @nc: page_frag cache from which to commit
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 8c3cfdbe8c2b..ae40520d452a 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -116,6 +116,41 @@ unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
 }
 EXPORT_SYMBOL(__page_frag_cache_commit_noref);
 
+/**
+ * __page_frag_alloc_refill_probe_align() - Probe allocating a fragment and
+ * refilling a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @align_mask: the requested aligning requirement for the fragment.
+ *
+ * Probe allocating a fragment and refilling a page_frag from page_frag cache
+ * with aligning requirement.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
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


