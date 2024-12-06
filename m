Return-Path: <netdev+bounces-149701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49369E6E37
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A1F1883531
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D52036E8;
	Fri,  6 Dec 2024 12:32:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A751FF5FA;
	Fri,  6 Dec 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488346; cv=none; b=YxyZjH8EcKlIUesj3nfX862hheCZoh4SZ3CKygCOxt/g/aZ6V/dmir3tI0oYUDkMeqQlJcvecbnXeftfTeESpxKZuFpNFbsaNrv+qYa8MNv5Wwm8QdoaHk39HyyBHX4NmddSCWQlJaFCTO2qTMubRGFeeAIGPvZGfJGjXNdKEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488346; c=relaxed/simple;
	bh=u7Y8vcACw0nN7XvzUTUQjb+zsdFCruoZHnJv/2+6AWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIdK9ew9P96ji2V0HIkzDmVSKwFTummUfSzcm4PeOJAKj/jhAcow78Whm4Rde79A0LFUy/Q+IBHRh/0NFBZruf/Bz/ox5vpQNDLjbuYVfyqPMAD20gDQjqB5Vh7PB28L4rkzw7v/DljsOh0mSBGJ1IBiYMUaS/AYlAYqqIGjvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4VvZ743kz1kvGW;
	Fri,  6 Dec 2024 20:30:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 507741401DC;
	Fri,  6 Dec 2024 20:32:22 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 20:32:22 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>
Subject: [PATCH net-next v2 01/10] mm: page_frag: some minor refactoring before adding new API
Date: Fri, 6 Dec 2024 20:25:24 +0800
Message-ID: <20241206122533.3589947-2-linyunsheng@huawei.com>
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

Refactor common codes from __page_frag_alloc_va_align() to
__page_frag_cache_prepare() and __page_frag_cache_commit(),
so that the new API can make use of them.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 34 ++++++++++++++++++++++++++--
 mm/page_frag_cache.c            | 40 ++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 41a91df82631..5ae97f93a0a1 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/log2.h>
+#include <linux/mmdebug.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
@@ -39,8 +40,37 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 
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
+	if (likely(va))
+		__page_frag_cache_commit(nc, &page_frag, fragsz);
+
+	return va;
+}
 
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 3f7a203d35c6..f55d34cf7d43 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -90,9 +90,31 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
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
+	VM_BUG_ON(pfrag->page != encoded_page_decode_page(nc->encoded_page));
+	VM_BUG_ON(pfrag->offset + pfrag->size >
+		  (PAGE_SIZE << encoded_page_decode_order(nc->encoded_page)));
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
@@ -114,6 +136,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
+	} else {
+		page = encoded_page_decode_page(encoded_page);
 	}
 
 	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
@@ -132,8 +156,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = encoded_page_decode_page(encoded_page);
-
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
@@ -148,15 +170,17 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
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
 
 	return encoded_page_decode_virt(encoded_page) + offset;
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_cache_prepare);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
-- 
2.33.0


