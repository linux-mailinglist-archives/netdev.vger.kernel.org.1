Return-Path: <netdev+bounces-144887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D299C89DA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B50F1F2418C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EE1FAF07;
	Thu, 14 Nov 2024 12:22:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ED1FAEE4;
	Thu, 14 Nov 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586977; cv=none; b=G/2oObzYYZP06G0CGhhuriEVCPx2ppI5XjfEcl3XUgjmv6Wafh2uoGPuisRIUTaQrz0W23+Mrep3qgC0B4ShPNfKbhq5oRC3J8SyfoejIsmuNoCuxzqKkRzCGwGY19/fAk7FDE11vtYDB3mycmkkvc31lk9FcbZ8DUcosFxoIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586977; c=relaxed/simple;
	bh=oZyy6/yJR4CQBETo54Pol6OM6p01s3meRvsT1QPxdMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEuKOIyUlQqzTPpALYZfPLYl7CCvwTFsoLfOCOTWWkD6jaUzsRTC+6J+7gNeCc/f7O4wvvqZ7GBbM8e8jie9X3bVDFGTq8bM0ADZ1/cXZMtLtIfYchUYHPK3SiDX634gJcsisE6zFOddmmkXjUwZWvsFzaiqsAr6JTBBah6qaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xpzm16HH1z21l8Z;
	Thu, 14 Nov 2024 20:21:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E7881A0188;
	Thu, 14 Nov 2024 20:22:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 20:22:53 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v1 06/10] mm: page_frag: introduce alloc_refill prepare & commit API
Date: Thu, 14 Nov 2024 20:16:01 +0800
Message-ID: <20241114121606.3434517-7-linyunsheng@huawei.com>
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

Currently alloc related API returns virtual address of the
allocated fragment and refill related API returns page info
of the allocated fragment through 'struct page_frag'.

There are use cases that need both the virtual address and
page info of the allocated fragment. Introduce alloc_refill
API for those use cases.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 45 +++++++++++++++++++++
 include/linux/page_frag_cache.h | 71 +++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 4cfdbe7db55a..1c98f7090d92 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -111,6 +111,9 @@ page is aligned according to the 'align/alignment' parameter. Note the size of
 the allocated fragment is not aligned, the caller needs to provide an aligned
 fragsz if there is an alignment requirement for the size of the fragment.
 
+Depending on different use cases, callers expecting to deal with va, page or
+both va and page may call alloc, refill or alloc_refill API accordingly.
+
 There is a use case that needs minimum memory in order for forward progress, but
 more performant if more memory is available. By using the prepare and commit
 related API, the caller calls prepare API to requests the minimum memory it
@@ -123,6 +126,9 @@ uses, or not do so if deciding to not use any memory.
 		 __page_frag_alloc_align page_frag_alloc_align page_frag_alloc
 		 page_frag_alloc_abort __page_frag_refill_prepare_align
 		 page_frag_refill_prepare_align page_frag_refill_prepare
+		 __page_frag_alloc_refill_prepare_align
+		 page_frag_alloc_refill_prepare_align
+		 page_frag_alloc_refill_prepare
 
 .. kernel-doc:: mm/page_frag_cache.c
    :identifiers: page_frag_cache_drain page_frag_free page_frag_alloc_abort_ref
@@ -193,3 +199,42 @@ Refill Preparation & committing API
         skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
         page_frag_refill_commit(nc, pfrag, copy);
     }
+
+
+Alloc_Refill Preparation & committing API
+-----------------------------------------
+
+.. code-block:: c
+
+    struct page_frag page_frag, *pfrag;
+    bool merge = true;
+    void *va;
+
+    pfrag = &page_frag;
+    va = page_frag_alloc_refill_prepare(nc, 32U, pfrag, GFP_KERNEL);
+    if (!va)
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
+    err = copy_from_iter_full_nocache(va, copy, iter);
+    if (err)
+        goto do_error;
+
+    if (merge) {
+        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+        page_frag_refill_commit_noref(nc, pfrag, copy);
+    } else {
+        skb_fill_page_desc(skb, i, pfrag->page, pfrag->offset, copy);
+        page_frag_refill_commit(nc, pfrag, copy);
+    }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 1e699334646a..329390afbe78 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -211,6 +211,77 @@ static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
 						~0u);
 }
 
+/**
+ * __page_frag_alloc_refill_prepare_align() - Prepare allocating a fragment and
+ * refilling a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align_mask: the requested aligning requirement for the fragment.
+ *
+ * Prepare allocating a fragment and refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
+static inline void
+*__page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
+					unsigned int fragsz,
+					struct page_frag *pfrag,
+					gfp_t gfp_mask, unsigned int align_mask)
+{
+	return __page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask, align_mask);
+}
+
+/**
+ * page_frag_alloc_refill_prepare_align() - Prepare allocating a fragment and
+ * refilling a page_frag with aligning requirement.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement for the fragment.
+ *
+ * WARN_ON_ONCE() checking for @align before prepare allocating a fragment and
+ * refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
+static inline void
+*page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
+				      unsigned int fragsz,
+				      struct page_frag *pfrag, gfp_t gfp_mask,
+				      unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
+						      gfp_mask, -align);
+}
+
+/**
+ * page_frag_alloc_refill_prepare() - Prepare allocating a fragment and
+ * refilling a page_frag.
+ * @nc: page_frag cache from which to allocate and refill
+ * @fragsz: the requested fragment size
+ * @pfrag: the page_frag to be refilled.
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare allocating a fragment and refilling a page_frag from page_frag cache.
+ *
+ * Return:
+ * virtual address of the page fragment, otherwise return NULL.
+ */
+static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
+						   unsigned int fragsz,
+						   struct page_frag *pfrag,
+						   gfp_t gfp_mask)
+{
+	return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
+						      gfp_mask, ~0u);
+}
+
 /**
  * page_frag_refill_commit - Commit a prepare refilling.
  * @nc: page_frag cache from which to commit
-- 
2.33.0


