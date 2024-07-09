Return-Path: <netdev+bounces-110278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3C92BB60
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207A0285F43
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3617B4E9;
	Tue,  9 Jul 2024 13:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76915FA6B;
	Tue,  9 Jul 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531886; cv=none; b=KN4SwvlFayzoY3RfkjBeoQgzpiUqCyQRQdziOJoHUFBsopMnk0HsHlOPYY4nkiLSJ5kbdJs0dhUn9E8HoX273F7pWy6W2PjINXV//TTQWH3WHB+DMAFyi/1LlDNXQ6WhBdSLxSVvxTnlZ+5L8Zl+3yYLkn9sMpV4/uKwYpd/9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531886; c=relaxed/simple;
	bh=82GcXnB6OrYb4wq6kIAa/gTCyD78yeIWncGeRScn2Fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gu8PDsTPHeV+DeX8meL/g6fqOxpvLovko+dGe5rtOg+d8iDGH6oMWbx9Ze59UBAgUchbrjaI/1S6SGKdLCc7qfKPJ3X53qIUQdq3BdiVe4bjFb6+oV3WFA4SN+qtF3sKZiG7fn3FISkFS48D1StC3IKPe3Ryf+twJKbI9BKE3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJMG85xBmzwWGp;
	Tue,  9 Jul 2024 21:26:40 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 61D89180AE5;
	Tue,  9 Jul 2024 21:31:22 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 21:31:22 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v10 12/15] mm: page_frag: move 'struct page_frag_cache' to sched.h
Date: Tue, 9 Jul 2024 21:27:37 +0800
Message-ID: <20240709132741.47751-13-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240709132741.47751-1-linyunsheng@huawei.com>
References: <20240709132741.47751-1-linyunsheng@huawei.com>
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

As the 'struct page_frag_cache' is going to replace the
'struct page_frag' in sched.h, including page_frag_cache.h
in sched.h has a compiler error caused by interdependence
between mm_types.h and mm.h for asm-offsets.c, see [1].

Avoid the above compiler error by moving the 'struct
page_frag_cache' to sched.h as suggested by Alexander, see
[2].

1. https://lore.kernel.org/all/15623dac-9358-4597-b3ee-3694a5956920@gmail.com/
2. https://lore.kernel.org/all/CAKgT0UdH1yD=LSCXFJ=YM_aiA4OomD-2wXykO42bizaWMt_HOA@mail.gmail.com/
Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/mm_types_task.h   | 18 ++++++++++++++++++
 include/linux/page_frag_cache.h | 20 +-------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index a2f6179b672b..f2610112a642 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -8,6 +8,7 @@
  * (These are defined separately to decouple sched.h from mm_types.h as much as possible.)
  */
 
+#include <linux/align.h>
 #include <linux/types.h>
 
 #include <asm/page.h>
@@ -46,6 +47,23 @@ struct page_frag {
 #endif
 };
 
+#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
+#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
+struct page_frag_cache {
+	/* encoded_va consists of the virtual address, pfmemalloc bit and order
+	 * of a page.
+	 */
+	unsigned long encoded_va;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
+	__u16 remaining;
+	__u16 pagecnt_bias;
+#else
+	__u32 remaining;
+	__u32 pagecnt_bias;
+#endif
+};
+
 /* Track pages that require TLB flushes */
 struct tlbflush_unmap_batch {
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index cd60e08f6d44..e0d65b57ac80 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,18 +3,15 @@
 #ifndef _LINUX_PAGE_FRAG_CACHE_H
 #define _LINUX_PAGE_FRAG_CACHE_H
 
-#include <linux/align.h>
 #include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/mm_types_task.h>
 #include <linux/mmdebug.h>
 #include <asm/page.h>
 
-#define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
-#define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
-
 #define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
 #define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
 #define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
@@ -53,21 +50,6 @@ static inline void *encoded_page_address(unsigned long encoded_va)
 	return (void *)(encoded_va & PAGE_MASK);
 }
 
-struct page_frag_cache {
-	/* encoded_va consists of the virtual address, pfmemalloc bit and order
-	 * of a page.
-	 */
-	unsigned long encoded_va;
-
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
-	__u16 remaining;
-	__u16 pagecnt_bias;
-#else
-	__u32 remaining;
-	__u32 pagecnt_bias;
-#endif
-};
-
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
 	memset(nc, 0, sizeof(*nc));
-- 
2.33.0


