Return-Path: <netdev+bounces-149705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E829E6E41
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EE1282B41
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20320767B;
	Fri,  6 Dec 2024 12:32:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565C20126D;
	Fri,  6 Dec 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488355; cv=none; b=LIw5pbB6HY35+vXklvpYnxGQThNaBadQc2LAxA3p/gvsfdYhgA1hvGA/A+9RrtsuX7Smtotp0OO93rWqMfojFCwMkeSt9D81I2ziYacFoDoKVqizwd+LMGnmAiMeLx+w9ZD+nLgnikAGvphK+ikBEkfIO6ei5KkEU0ionu4Q0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488355; c=relaxed/simple;
	bh=jkShJGMFXH2aUoPQSpMC6gQbUPJ2P3Bjy7ypp6gtvTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddESs4wSgNkFM6WxgF9ey1nah+EwRIrfGpfubGc2aQDuyv/EUmdk1IIyKJ65iStIuNL4/Ghw5eGGcwGi78A6hEs+ZzBjODWwTnRS0C3X6oAi6k/HTgcrlCyrTIh/eE4RCi4VUfZeh708AFDgGXW1Ehy+iY8upuGsZjXFAdfyk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y4VwV3k1zz21mgp;
	Fri,  6 Dec 2024 20:30:50 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1577A1401DC;
	Fri,  6 Dec 2024 20:32:30 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 20:32:29 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v2 05/10] mm: page_frag: introduce refill prepare & commit API
Date: Fri, 6 Dec 2024 20:25:28 +0800
Message-ID: <20241206122533.3589947-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241206122533.3589947-1-linyunsheng@huawei.com>
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
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

Currently page_frag only have a alloc API which returns
the virtual address of a fragment by a specific size.

There are many use cases that need minimum memory in order
for forward progress, but more performant if more memory is
available, and expect to use the 'struct page' of the
allocated fragment directly instead of the virtual address.

Currently skb_page_frag_refill() API is used to solve the
above use cases, but caller needs to know about the internal
detail and access the data field of 'struct page_frag' to
meet the requirement of the above use cases and its
implementation is similar to the one in mm subsystem.

To unify those two page_frag implementations, introduce a
prepare API to ensure minimum memory is satisfied and return
how much the actual memory is available to the caller. The
caller needs to either call the commit API to report how much
memory it actually uses, or not do so if deciding to not use
any memory.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst |  43 ++++++++++++-
 include/linux/page_frag_cache.h | 110 ++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 339e641beb53..4cfdbe7db55a 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -111,10 +111,18 @@ page is aligned according to the 'align/alignment' parameter. Note the size of
 the allocated fragment is not aligned, the caller needs to provide an aligned
 fragsz if there is an alignment requirement for the size of the fragment.
 
+There is a use case that needs minimum memory in order for forward progress, but
+more performant if more memory is available. By using the prepare and commit
+related API, the caller calls prepare API to requests the minimum memory it
+needs and prepare API will return the maximum size of the fragment returned. The
+caller needs to either call the commit API to report how much memory it actually
+uses, or not do so if deciding to not use any memory.
+
 .. kernel-doc:: include/linux/page_frag_cache.h
    :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
 		 __page_frag_alloc_align page_frag_alloc_align page_frag_alloc
-		 page_frag_alloc_abort
+		 page_frag_alloc_abort __page_frag_refill_prepare_align
+		 page_frag_refill_prepare_align page_frag_refill_prepare
 
 .. kernel-doc:: mm/page_frag_cache.c
    :identifiers: page_frag_cache_drain page_frag_free page_frag_alloc_abort_ref
@@ -152,3 +160,36 @@ Allocation & freeing API
     ...
 
     page_frag_free(va);
+
+
+Refill Preparation & committing API
+-----------------------------------
+
+.. code-block:: c
+
+    struct page_frag page_frag, *pfrag;
+    bool merge = true;
+
+    pfrag = &page_frag;
+    if (!page_frag_refill_prepare(nc, 32U, pfrag, GFP_KERNEL))
+        goto wait_for_space;
+
+    copy = min_t(unsigned int, copy, pfrag->size);
+    if (!skb_can_coalesce(skb, i, pfrag->page, pfrag->offset)) {
+        if (i >= max_skb_frags)
+            goto new_segment;
+
+        merge = false;
+    }
+
+    copy = mem_schedule(copy);
+    if (!copy)
+        goto wait_for_space;
+
+    if (merge) {
+        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+        page_frag_refill_commit_noref(nc, pfrag, copy);
+    } else {
+        skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
+        page_frag_refill_commit(nc, pfrag, copy);
+    }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index c3347c97522c..1e699334646a 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -140,6 +140,116 @@ static inline void *page_frag_alloc(struct page_frag_cache *nc,
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
 }
 
+/**
+ * __page_frag_refill_prepare_align() - Prepare refilling a page_frag with
+ * aligning requirement.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the fragment
+ *
+ * Prepare refilling a page_frag from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * True if prepare refilling succeeds, otherwise return false.
+ */
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
+/**
+ * page_frag_refill_prepare_align() - Prepare refilling a page_frag with
+ * aligning requirement.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache needs to be refilled
+ * @align: the requested aligning requirement for the fragment
+ *
+ * WARN_ON_ONCE() checking for @align before prepare refilling a page_frag from
+ * page_frag cache with aligning requirement.
+ *
+ * Return:
+ * True if prepare refilling succeeds, otherwise return false.
+ */
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
+/**
+ * page_frag_refill_prepare() - Prepare refilling a page_frag.
+ * @nc: page_frag cache from which to refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * True if refill succeeds, otherwise return false.
+ */
+static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
+					    unsigned int fragsz,
+					    struct page_frag *pfrag,
+					    gfp_t gfp_mask)
+{
+	return __page_frag_refill_prepare_align(nc, fragsz, pfrag, gfp_mask,
+						~0u);
+}
+
+/**
+ * page_frag_refill_commit - Commit a prepare refilling.
+ * @nc: page_frag cache from which to commit
+ * @pfrag: the page_frag to be committed
+ * @used_sz: size of the page fragment has been used
+ *
+ * Commit the actual used size for the refill that was prepared.
+ *
+ * Return:
+ * The true size of the fragment considering the offset alignment.
+ */
+static inline unsigned int page_frag_refill_commit(struct page_frag_cache *nc,
+						   struct page_frag *pfrag,
+						   unsigned int used_sz)
+{
+	return __page_frag_cache_commit(nc, pfrag, used_sz);
+}
+
+/**
+ * page_frag_refill_commit_noref - Commit a prepare refilling without taking
+ * refcount.
+ * @nc: page_frag cache from which to commit
+ * @pfrag: the page_frag to be committed
+ * @used_sz: size of the page fragment has been used
+ *
+ * Commit the prepare refilling by passing the actual used size, but not taking
+ * refcount. Mostly used for fragmemt coalescing case when the current fragment
+ * can share the same refcount with previous fragment.
+ *
+ * Return:
+ * The true size of the fragment considering the offset alignment.
+ */
+static inline unsigned int
+page_frag_refill_commit_noref(struct page_frag_cache *nc,
+			      struct page_frag *pfrag, unsigned int used_sz)
+{
+	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
+}
+
 void page_frag_free(void *addr);
 void page_frag_alloc_abort_ref(struct page_frag_cache *nc, void *va,
 			       unsigned int fragsz);
-- 
2.33.0


