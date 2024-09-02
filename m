Return-Path: <netdev+bounces-124189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F7968738
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A09D1C22188
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575C2101BD;
	Mon,  2 Sep 2024 12:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD720011D;
	Mon,  2 Sep 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278963; cv=none; b=K9KD2IPmt7DYwPoM00vXWpUDUo6XisYZsnaX+Ve9VUlKI4/r/oj/5Au0SQFPHyYeU5ce2YkjiBe8uPEkEa9FN6d+eIg6Ez7Fk8z07Imsgc14P9CwfyQk2BBUhPBvzcVR1CsrV3acvWc4ocgW2F6qbnGM+aNC0GgV3Op0obHqgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278963; c=relaxed/simple;
	bh=wHF6UlF02o7k0tUqrYMb8mqtadyQrMlui1UP7GM7xj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoTG4ZJbLsq451JLC77R3oBmi23YLHNM/Z3vyCFYEn8Ta89dBD9vndPgj+XIUv0RJOoGIetKUVnqtyjLd4vc7DTp9PiU4u9GBrPbffuwkC+RFJg3iX0x34ujeevexQih6/p6NBpeTAI6F3J9d+r8gdaPj8f0Wa2J4gm8Fn/5qNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wy6x92llgz1j7n0;
	Mon,  2 Sep 2024 20:09:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EE5218001B;
	Mon,  2 Sep 2024 20:09:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 20:09:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v17 07/14] mm: page_frag: some minor refactoring before adding new API
Date: Mon, 2 Sep 2024 20:03:06 +0800
Message-ID: <20240902120314.508180-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240902120314.508180-1-linyunsheng@huawei.com>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align() to
__page_frag_cache_prepare() and __page_frag_cache_commit(),
so that the new API can make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 51 +++++++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 21 +++++++-------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index cb89cd792fcc..24835ec8c891 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -6,6 +6,7 @@
 #include <linux/bits.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
@@ -62,8 +63,54 @@ static inline unsigned int page_frag_cache_page_size(unsigned long encoded_page)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask);
+
+static inline void __page_frag_cache_commit(struct page_frag_cache *nc,
+					    struct page_frag *pfrag,
+					    bool referenced,
+					    unsigned int used_sz)
+{
+	unsigned int committed_offset;
+
+	if (referenced) {
+		VM_BUG_ON(!nc->pagecnt_bias);
+		nc->pagecnt_bias--;
+	}
+
+	VM_BUG_ON(used_sz > pfrag->size);
+	VM_BUG_ON(pfrag->page != page_frag_encoded_page_ptr(nc->encoded_page));
+	VM_BUG_ON(pfrag->offset + pfrag->size >
+		  page_frag_cache_page_size(nc->encoded_page));
+
+	/* pfrag->offset might be bigger than the nc->offset due to alignment */
+	VM_BUG_ON(nc->offset > pfrag->offset);
+
+	committed_offset = pfrag->offset + used_sz;
+
+	/* Return true size back to caller considering the offset alignment */
+	pfrag->size = (committed_offset - nc->offset);
+
+	nc->offset = committed_offset;
+}
+
+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
+					    unsigned int fragsz, gfp_t gfp_mask,
+					    unsigned int align_mask)
+{
+	struct page_frag page_frag;
+	void *va;
+
+	va = __page_frag_cache_prepare(nc, fragsz, &page_frag, gfp_mask,
+				       align_mask);
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
index a5c5373cb70e..62d8cf33f27a 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -79,16 +79,14 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
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
@@ -106,6 +104,9 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
+	} else {
+		size = page_frag_cache_page_size(encoded_page);
+		page = page_frag_encoded_page_ptr(encoded_page);
 	}
 
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
@@ -123,8 +124,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = page_frag_encoded_page_ptr(encoded_page);
-
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
@@ -139,15 +138,17 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
+		nc->offset = 0;
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


