Return-Path: <netdev+bounces-139544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44979B2FBB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2599CB246A1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A541DDA09;
	Mon, 28 Oct 2024 12:05:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04261DD9D3;
	Mon, 28 Oct 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117152; cv=none; b=G67xggemWZtuoSVsDDKrBNZ9/2Co1z00uRTHGchVDQQd9G0QM9wUVgixD8ocJ6/gdyZHprmNqU4G86vvgmPMjjQQGr0ppYKVPMUHklx4tje1Vn/5wbbIS/j7mBcLNGfTBf9ko7mYcn5EOeybnvgEvIrrb6VN3jndJ6W5/wp2UbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117152; c=relaxed/simple;
	bh=t8V0hpUj05kltlxBRa+iuwiv1coFLeOxyPz3fv0eFYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEzJUkSeo1Rg6ky3AxSq7LmIXrzYPelOKAr4vmndfjffKharSCWy7FDA88uF349+J7h4pNi2ST2Rfi+oEgqCyXMB01Dql/1GBQJyDCRABBrQV4sgii65TnwTr+pJOKivlK48AWnUZt7Ks9AJpiqi8jlpv8iIiLqaBk71+W0LnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XcX8c3pMSz10P7X;
	Mon, 28 Oct 2024 20:03:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AA351800CF;
	Mon, 28 Oct 2024 20:05:21 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 20:05:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH RFC 07/10] mm: page_frag: introduce probe related API
Date: Mon, 28 Oct 2024 19:58:47 +0800
Message-ID: <20241028115850.3409893-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241028115850.3409893-1-linyunsheng@huawei.com>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index dcfceee3b923..c39b3daa5ca5 100644
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
index 4d5626da42ed..c2902bdf7350 100644
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


