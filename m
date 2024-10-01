Return-Path: <netdev+bounces-130754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8798B662
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9151F225A1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4B1BE24B;
	Tue,  1 Oct 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk83umPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4111BDAA9;
	Tue,  1 Oct 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769586; cv=none; b=jeHeT2uRr/XPzf7NwC+vQadLsx8cgUZ6wpsPn4enhlb0Mmq37qde34OjoYpFIYJD38mK0PdEXptBe3HCubs9fU4YKQE4lw7IWeLfCYAdmuo/l11oiCd9kPlUBJtV6kn8IqIqtsX9aqTdHZshc6OPVCMJ4srR+f2KLLNJHDiI15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769586; c=relaxed/simple;
	bh=LmJmEvpcC2NZ7YL3p0jcWgycLVf5ESkFlh4tzYxfKcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3x+eKyjS2inRhZtQgdoiHyeu3GuTWx13EuLgGQTM4g9yLV7QiKBh32/bxBZOg5PEeVqpch6WKe9DK4LXJ1VQGpqaWJd2AjKDDsoR1gXlhbLsWQZquoHF0WgaKElV8gk2g2ol1UMviLogzTuP7VYQ2kmpIY7tg3+RdtK9aCeUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk83umPQ; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7d7a9200947so3522340a12.3;
        Tue, 01 Oct 2024 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769584; x=1728374384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1flmiq1CIb5dWvur8o1cuFYGIlZjiDxQSttLTSZj20=;
        b=Mk83umPQbldx7US09B9b+C8Nv9bGRAqpEuRAzT4KQAZxc45/j19mMWglnbCfmewIBl
         7i2S3p9qktWNR7TtihU3EvGZtRUDkzTaK8kkPcZWeiMk5b597THSzjB+4SBiWmSAkr3C
         SQn0Gc1HNbrXrXkv5vdA0fiNux055/J0gheNE9wc/Rpa9ZEggATH/GdfRS5vC5aImms2
         Hn9VPwJXoqfrvAZIdYLWTO3UuzG7hIRsLcOfxLgq6un7L+MJ704I+SZpwalBnE2hdKxS
         HuHEJMClhhAcjdquyIjpFhvqV3MF2rdXmSG3a6NM9Sm5qsvt9rSEBl1J2O7HmhqCLMuQ
         flaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769584; x=1728374384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1flmiq1CIb5dWvur8o1cuFYGIlZjiDxQSttLTSZj20=;
        b=KRn/7faw5ykM9YFxC73FHPeMHyPwEmSKZGG3IqBc9zIguojsF8jEeWxQ76OFDNHl3i
         qEbS1yKzke2EQrLn5r9DaqbnBwOnvS1v29g7zasySSCnZFyHwfSIS1Y8n9KzKpToIxPQ
         EV4sqMW63lf8bkMAOtK9iLjFXKvk+fsdwBG4+yWzfK3lhe8KPLnq68veEESIfvI4EwxM
         qmlpcBIp4+pAPSoKvmdthHmwgJXkhoArrUA+czr32I2X4l+5YHidATa06BlFgzRezJJs
         9g9u1Zd+R5cMEDRfsIgejvUghgHe5508Z8rUZO+2Gg1PaHFskoiFXOhGV5UX1QP4hMaH
         ZkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP8CRX6bdSMUijy8mi+UG5ORYEsj2jChv5zdt71n6+u72u25SMr4lh3d8sQWpIr8xB/RzJYFoEW7qRakI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9zrmbBglWF+xRF9hms8MSJTjQ0AxKyhYdZSQGbhFdH3Vm+KG
	cx0KXYFJ5zpntFv3Kb/p53x8eE47CJ8uIQyq5wdMfXzd2TjAUXt1rwZ/xnaCTxU=
X-Google-Smtp-Source: AGHT+IGWWcq93SolMOcbPJboqSEg9Ubcs85ynCA4UMkBOerDIZugeKeyo4zjy4R1BEFlqXCJokgRZA==
X-Received: by 2002:a17:90a:ac02:b0:2e0:8719:5f00 with SMTP id 98e67ed59e1d1-2e0b8b2261dmr17048516a91.22.1727769583943;
        Tue, 01 Oct 2024 00:59:43 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:43 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH net-next v19 06/14] mm: page_frag: reuse existing space for 'size' and 'pfmemalloc'
Date: Tue,  1 Oct 2024 15:58:49 +0800
Message-Id: <20241001075858.48936-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is one 'struct page_frag' for every 'struct
sock' and 'struct task_struct', we are about to replace the
'struct page_frag' with 'struct page_frag_cache' for them.
Before begin the replacing, we need to ensure the size of
'struct page_frag_cache' is not bigger than the size of
'struct page_frag', as there may be tens of thousands of
'struct sock' and 'struct task_struct' instances in the
system.

By or'ing the page order & pfmemalloc with lower bits of
'va' instead of using 'u16' or 'u32' for page size and 'u8'
for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
And page address & pfmemalloc & order is unchanged for the
same page in the same 'page_frag_cache' instance, it makes
sense to fit them together.

After this patch, the size of 'struct page_frag_cache' should be
the same as the size of 'struct page_frag'.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/mm_types_task.h   | 19 +++++----
 include/linux/page_frag_cache.h | 26 +++++++++++-
 mm/page_frag_cache.c            | 75 +++++++++++++++++++++++----------
 3 files changed, 88 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 0ac6daebdd5c..a82aa80c0ba4 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -47,18 +47,21 @@ struct page_frag {
 #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 struct page_frag_cache {
-	void *va;
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* encoded_page consists of the virtual address, pfmemalloc bit and
+	 * order of a page.
+	 */
+	unsigned long encoded_page;
+
+	/* we maintain a pagecount bias, so that we dont dirty cache line
+	 * containing page->_refcount every time we allocate a fragment.
+	 */
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
 	__u16 offset;
-	__u16 size;
+	__u16 pagecnt_bias;
 #else
 	__u32 offset;
+	__u32 pagecnt_bias;
 #endif
-	/* we maintain a pagecount bias, so that we dont dirty cache line
-	 * containing page->_refcount every time we allocate a fragment.
-	 */
-	unsigned int		pagecnt_bias;
-	bool pfmemalloc;
 };
 
 /* Track pages that require TLB flushes */
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 0a52f7a179c8..75aaad6eaea2 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -3,18 +3,40 @@
 #ifndef _LINUX_PAGE_FRAG_CACHE_H
 #define _LINUX_PAGE_FRAG_CACHE_H
 
+#include <linux/bits.h>
 #include <linux/log2.h>
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+/* Use a full byte here to enable assembler optimization as the shift
+ * operation is usually expecting a byte.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
+#else
+/* Compiler should be able to figure out we don't read things as any value
+ * ANDed with 0 is 0.
+ */
+#define PAGE_FRAG_CACHE_ORDER_MASK		0
+#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	0
+#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
+#endif
+
+static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encoded_page)
+{
+	return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
+}
+
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
-	nc->va = NULL;
+	nc->encoded_page = 0;
 }
 
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
-	return !!nc->pfmemalloc;
+	return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 4c8e04379cb3..cf9375a81a64 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -12,6 +12,7 @@
  * be used in the "frags" portion of skb_shared_info.
  */
 
+#include <linux/build_bug.h>
 #include <linux/export.h>
 #include <linux/gfp_types.h>
 #include <linux/init.h>
@@ -19,9 +20,41 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
+static unsigned long page_frag_encode_page(struct page *page, unsigned int order,
+					   bool pfmemalloc)
+{
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);
+
+	return (unsigned long)page_address(page) |
+		(order & PAGE_FRAG_CACHE_ORDER_MASK) |
+		((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
+}
+
+static unsigned long page_frag_encoded_page_order(unsigned long encoded_page)
+{
+	return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
+}
+
+static void *page_frag_encoded_page_address(unsigned long encoded_page)
+{
+	return (void *)(encoded_page & PAGE_MASK);
+}
+
+static struct page *page_frag_encoded_page_ptr(unsigned long encoded_page)
+{
+	return virt_to_page((void *)encoded_page);
+}
+
+static unsigned int page_frag_cache_page_size(unsigned long encoded_page)
+{
+	return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
+}
+
 static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 					     gfp_t gfp_mask)
 {
+	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
 
@@ -30,23 +63,26 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
 #endif
-	if (unlikely(!page))
+	if (unlikely(!page)) {
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		order = 0;
+	}
 
-	nc->va = page ? page_address(page) : NULL;
+	nc->encoded_page = page ?
+		page_frag_encode_page(page, order, page_is_pfmemalloc(page)) : 0;
 
 	return page;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
-	if (!nc->va)
+	if (!nc->encoded_page)
 		return;
 
-	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
-	nc->va = NULL;
+	__page_frag_cache_drain(page_frag_encoded_page_ptr(nc->encoded_page),
+				nc->pagecnt_bias);
+	nc->encoded_page = 0;
 }
 EXPORT_SYMBOL(page_frag_cache_drain);
 
@@ -63,35 +99,29 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int fragsz, gfp_t gfp_mask,
 			      unsigned int align_mask)
 {
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-	unsigned int size = nc->size;
-#else
-	unsigned int size = PAGE_SIZE;
-#endif
-	unsigned int offset;
+	unsigned long encoded_page = nc->encoded_page;
+	unsigned int size, offset;
 	struct page *page;
 
-	if (unlikely(!nc->va)) {
+	if (unlikely(!encoded_page)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
+		encoded_page = nc->encoded_page;
+
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
 		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = 0;
 	}
 
+	size = page_frag_cache_page_size(encoded_page);
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
 	if (unlikely(offset + fragsz > size)) {
 		if (unlikely(fragsz > PAGE_SIZE)) {
@@ -107,13 +137,14 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			return NULL;
 		}
 
-		page = virt_to_page(nc->va);
+		page = page_frag_encoded_page_ptr(encoded_page);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
 			goto refill;
 
-		if (unlikely(nc->pfmemalloc)) {
-			free_unref_page(page, compound_order(page));
+		if (unlikely(page_frag_encoded_page_pfmemalloc(encoded_page))) {
+			free_unref_page(page,
+					page_frag_encoded_page_order(encoded_page));
 			goto refill;
 		}
 
@@ -128,7 +159,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	nc->pagecnt_bias--;
 	nc->offset = offset + fragsz;
 
-	return nc->va + offset;
+	return page_frag_encoded_page_address(encoded_page) + offset;
 }
 EXPORT_SYMBOL(__page_frag_alloc_align);
 
-- 
2.34.1


