Return-Path: <netdev+bounces-94581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B08BFEDC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ABA1F274EC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E184FDF;
	Wed,  8 May 2024 13:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3112F7D3FE;
	Wed,  8 May 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175412; cv=none; b=t9PL5M5FVQrcpSlCpx9Np3WnPXJfKThnpQYjJoBxufVkgExMZE9GDSwPUhyHfN2989d36pWeVODGAkrFpiwc+Jk4ooUydARDtqtfEEsP3UrCNPoS3C0UkgNmCIsx2fIklszpNjt07nhXiFY7Nq5hpGedngaGEKeg98UvBUTXNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175412; c=relaxed/simple;
	bh=fHwvymokB6csrLNCC+00KvTh9NF7HG3v/Py+8WAzgDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvKOBtzLMXn33MehkPWL7IRgGZBiaBWg/YvX7J1zs3jQtvM/RweLup2OsGBfCk/AyuXbb+h0wjblybrVe76hltCrcB9cjOsAXp47lrDdFqUoxFd9mpM+NjtjauzTNHeSa9LxvTmdgaQPNV/6Pt2wxWnw8F4rFT4hXiMaHy0YCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VZGKz65lVzYnCc;
	Wed,  8 May 2024 21:32:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id BD5C514011A;
	Wed,  8 May 2024 21:36:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:36:46 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v3 05/13] mm: page_frag: use initial zero offset for page_frag_alloc_align()
Date: Wed, 8 May 2024 21:34:00 +0800
Message-ID: <20240508133408.54708-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240508133408.54708-1-linyunsheng@huawei.com>
References: <20240508133408.54708-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

We are above to use page_frag_alloc_*() API to not just
allocate memory for skb->data, but also use them to do
the memory allocation for skb frag too. Currently the
implementation of page_frag in mm subsystem is running
the offset as a countdown rather than count-up value,
there may have several advantages to that as mentioned
in [1], but it may have some disadvantages, for example,
it may disable skb frag coaleasing and more correct cache
prefetching

We have a trade-off to make in order to have a unified
implementation and API for page_frag, so use a initial zero
offset in this patch, and the following patch will try to
make some optimization to aovid the disadvantages as much
as possible.

As offsets is added due to alignment requirement before
actually checking if the cache is enough, which might make
it exploitable if caller passes a align value bigger than
32K mistakenly. As we are allowing order 3 page allocation
to fail easily under low memory condition, align value bigger
than PAGE_SIZE is not really allowed, so add a 'align >
PAGE_SIZE' checking in page_frag_alloc_va_align() to catch
that.

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h |  2 +-
 mm/page_frag_cache.c            | 48 ++++++++++++++-------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 635b67ceb939..9da7cbd0ee47 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -32,7 +32,7 @@ static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
 					  unsigned int align)
 {
-	WARN_ON_ONCE(!is_power_of_2(align));
+	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
 }
 
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 64993b5d1243..152ae5dec58a 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -65,9 +65,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int fragsz, gfp_t gfp_mask,
 			      unsigned int align_mask)
 {
-	unsigned int size = PAGE_SIZE;
+	unsigned int size, offset;
 	struct page *page;
-	int offset;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -75,10 +74,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
@@ -87,11 +82,25 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
+		nc->offset = 0;
 	}
 
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* if size can vary use size else just use PAGE_SIZE */
+	size = nc->size;
+#else
+	size = PAGE_SIZE;
+#endif
+
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(offset + fragsz > size)) {
+		/* fragsz is not supposed to be bigger than PAGE_SIZE as we are
+		 * allowing order 3 page allocation to fail easily under low
+		 * memory condition.
+		 */
+		if (WARN_ON_ONCE(fragsz > PAGE_SIZE))
+			return NULL;
+
 		page = virt_to_page(nc->va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
@@ -102,33 +111,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 		}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = size - fragsz;
-		if (unlikely(offset < 0)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			return NULL;
-		}
+		offset = 0;
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
+	nc->offset = offset + fragsz;
 
 	return nc->va + offset;
 }
-- 
2.33.0


