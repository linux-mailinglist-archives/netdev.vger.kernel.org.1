Return-Path: <netdev+bounces-125818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F251096EC55
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733171F26222
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758C15A4B7;
	Fri,  6 Sep 2024 07:42:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317E1591F0;
	Fri,  6 Sep 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608577; cv=none; b=jgQtiulX1VkbyYHJQejtOmQbq0B92v9eHxXj79M9J0c7GkCLsML2IkvcHQYX/64etkXTp0oGQqxv2ZdA7iaB8GH1eilbdA7G0NLAsrvK7n4328f2bsERfHGSiJ3ttpCw2kTvOBfTvuOvKqshUxwoBILgqjiMsBBzTtRsVbwDKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608577; c=relaxed/simple;
	bh=LDk5hxv6xjnb2Db7CJ4d/9CzvzuzMJaCN/jdLyzIy+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1RShdt0xKpogAryD9Xhrm++6Whmaqn+WWqXxAct0BCnagFQ+XQl+5EqBP83+xU19gXpgnBjDUeFgj11Ur7WX1KEB6vUjrHsv7NQ38+D/2ciu2MaeZMDtR7OJEXX4AbEr7ig6fOP0DdoJTl/PYHPqDCa8m6Jwrk/4YAJrecuoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X0Sqn6WX5z1S9vd;
	Fri,  6 Sep 2024 15:42:29 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 404E2180041;
	Fri,  6 Sep 2024 15:42:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:42:53 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v18 07/14] mm: page_frag: some minor refactoring before adding new API
Date: Fri, 6 Sep 2024 15:36:39 +0800
Message-ID: <20240906073646.2930809-8-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align() to
__page_frag_cache_prepare() and __page_frag_cache_commit(),
so that the new API can make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 36 +++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 40 ++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 75aaad6eaea2..b634e1338741 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/log2.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
@@ -41,8 +42,39 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask);
+unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
+					    struct page_frag *pfrag,
+					    unsigned int used_sz);
+
+static inline unsigned int __page_frag_cache_commit(struct page_frag_cache *nc,
+						    struct page_frag *pfrag,
+						    unsigned int used_sz)
+{
+	VM_BUG_ON(!nc->pagecnt_bias);
+	nc->pagecnt_bias--;
+
+	return __page_frag_cache_commit_noref(nc, pfrag, used_sz);
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
+	__page_frag_cache_commit(nc, &page_frag, fragsz);
+
+	return va;
+}
 
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index cf9375a81a64..6f6e47bbdc8d 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -95,9 +95,31 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+unsigned int __page_frag_cache_commit_noref(struct page_frag_cache *nc,
+					    struct page_frag *pfrag,
+					    unsigned int used_sz)
+{
+	unsigned int orig_offset;
+
+	VM_BUG_ON(used_sz > pfrag->size);
+	VM_BUG_ON(pfrag->page != page_frag_encoded_page_ptr(nc->encoded_page));
+	VM_BUG_ON(pfrag->offset + pfrag->size >
+		  page_frag_cache_page_size(nc->encoded_page));
+
+	/* pfrag->offset might be bigger than the nc->offset due to alignment */
+	VM_BUG_ON(nc->offset > pfrag->offset);
+
+	orig_offset = nc->offset;
+	nc->offset = pfrag->offset + used_sz;
+
+	/* Return true size back to caller considering the offset alignment */
+	return nc->offset - orig_offset;
+}
+EXPORT_SYMBOL(__page_frag_cache_commit_noref);
+
+void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				struct page_frag *pfrag, gfp_t gfp_mask,
+				unsigned int align_mask)
 {
 	unsigned long encoded_page = nc->encoded_page;
 	unsigned int size, offset;
@@ -119,6 +141,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
+	} else {
+		page = page_frag_encoded_page_ptr(encoded_page);
 	}
 
 	size = page_frag_cache_page_size(encoded_page);
@@ -137,8 +161,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = page_frag_encoded_page_ptr(encoded_page);
-
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
@@ -153,15 +175,17 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
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


