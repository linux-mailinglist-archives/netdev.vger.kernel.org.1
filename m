Return-Path: <netdev+bounces-121884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE395F1CE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF11F23314
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49918D65C;
	Mon, 26 Aug 2024 12:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0945186613;
	Mon, 26 Aug 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676384; cv=none; b=RH+MR8LxP65Cnlo4PI2Ba9t4KjAqxYPxBXLuXo6WvNNhWOw0WcjqeMIM59cn8wVwb0Y37AlXotO+58yGi+pcMdpA7/n8qw1XmvLAIwQoiuHSOKr3UuPtKozX0bv8oqFHGnImWgQF9ZntERK3k5bcf6wb3FJJMZseaTLiGX5lmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676384; c=relaxed/simple;
	bh=y6NzsHBgOB3vYcSXc+qKh17Hbhiw+YbOFuXjpfolR5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STPp32a8AtTRllZBpwKnwuRzMjOjxTh/oAnzsITV5LQnRC8MEMpE9Vq+VEm2Bf+QX1s6FXEiCCQwU8XuIUfxHcjyTvCkgzvyrNzqhBl3nayjYmrYedLmiVOGaAuJosxHLV5Untel6h2H0NaWC3DmTWe/VtUDvYBjJ1/x7B2FE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wsr5H6p44z1j7Kn;
	Mon, 26 Aug 2024 20:46:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 99F121402E1;
	Mon, 26 Aug 2024 20:46:20 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 20:46:20 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v15 07/13] mm: page_frag: some minor refactoring before adding new API
Date: Mon, 26 Aug 2024 20:40:14 +0800
Message-ID: <20240826124021.2635705-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240826124021.2635705-1-linyunsheng@huawei.com>
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align() to
__page_frag_cache_prepare() and __page_frag_cache_commit(),
so that the new API can make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 51 +++++++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 20 ++++++-------
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 372d6ed7e20a..2cc18a525936 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -7,6 +7,7 @@
 #include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
@@ -75,8 +76,54 @@ static inline unsigned int page_frag_cache_page_size(unsigned long encoded_page)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask);
+
+static inline void __page_frag_cache_commit(struct page_frag_cache *nc,
+					    struct page_frag *pfrag, bool referenced,
+					    unsigned int used_sz)
+{
+	if (referenced) {
+		VM_BUG_ON(!nc->pagecnt_bias);
+		nc->pagecnt_bias--;
+	}
+
+	VM_BUG_ON(used_sz > pfrag->size);
+	VM_BUG_ON(pfrag->page != page_frag_encoded_page_ptr(nc->encoded_page));
+
+	/* nc->offset is not reset when reusing an old page, so do not check for the
+	 * first fragment.
+	 * Committed offset might be bigger than the current offset due to alignment
+	 */
+	VM_BUG_ON(pfrag->offset && nc->offset > pfrag->offset);
+	VM_BUG_ON(pfrag->offset &&
+		  pfrag->offset + pfrag->size > page_frag_cache_page_size(nc->encoded_page));
+
+	pfrag->size = used_sz;
+
+	/* Calculate true size for the fragment due to alignment, nc->offset is not
+	 * reset for the first fragment when reusing an old page.
+	 */
+	pfrag->size += pfrag->offset ? (pfrag->offset - nc->offset) : 0;
+
+	nc->offset = pfrag->offset + used_sz;
+}
+
+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
+					    gfp_t gfp_mask, unsigned int align_mask)
+{
+	struct page_frag page_frag;
+	void *va;
+
+	va = __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_mask, align_mask);
+	if (unlikely(!va))
+		return NULL;
+
+	__page_frag_cache_commit(nc, &page_frag, true, fragsz);
+
+	return va;
+}
 
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 228cff9a4cdb..bba59c87d478 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -67,16 +67,14 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask)
 {
 	unsigned long encoded_page = nc->encoded_page;
 	unsigned int size, offset;
 	struct page *page;
 
-	size = page_frag_cache_page_size(encoded_page);
-
 	if (unlikely(!encoded_page)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
@@ -94,6 +92,9 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
+	} else {
+		size = page_frag_cache_page_size(encoded_page);
+		page = page_frag_encoded_page_ptr(encoded_page);
 	}
 
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
@@ -111,8 +112,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = page_frag_encoded_page_ptr(encoded_page);
-
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
@@ -130,12 +129,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		offset = 0;
 	}
 
-	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
+	pfrag->page = page;
+	pfrag->offset = offset;
+	pfrag->size = size - offset;
 
 	return page_frag_encoded_page_address(encoded_page) + offset;
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_cache_prepare);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
-- 
2.33.0


