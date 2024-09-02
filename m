Return-Path: <netdev+bounces-124192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5079E96873E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E9528798A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536F21C19F;
	Mon,  2 Sep 2024 12:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205D3DABE2;
	Mon,  2 Sep 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278968; cv=none; b=GAzzCO20g23JkruAlb8jcMi7MZyPgmlTvw4HZ4QM+1SiZQP2Mzl1cRddzxyetimuoDmFKE30W3qqGNOliGI4XZkOqe4wmkjI6Jgi0E12HSysY7HFUJ2KjbiLLdmEYgQmX+pMBF/49BKWSE7uXie4CE2VAswXiSZ4+qvhh1OMJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278968; c=relaxed/simple;
	bh=Vy9Yb66122sosLhueUwbUojJEM3KF3/xYCpsEEmclJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itykjBqMIMAlEV79umMOR9ai4JCTy1qF//7oHgeI/M132wOzM3gterDANzBYTVAcCsVJSJvYuwlQ4QhnYwhz0XJJ0Cy88se83zAT67QNtJ4sFnX+LaKeAsWXUHfuFwuLev29Q93BzM5Arv28OvffueixHlI6qDycmuWD1gXxLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wy6sf2kMMz1HJ2L;
	Mon,  2 Sep 2024 20:05:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B557418001B;
	Mon,  2 Sep 2024 20:09:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 20:09:23 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v17 10/14] mm: page_frag: introduce prepare/probe/commit API
Date: Mon, 2 Sep 2024 20:03:09 +0800
Message-ID: <20240902120314.508180-11-linyunsheng@huawei.com>
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

There are many use cases that need minimum memory in order
for forward progress, but more performant if more memory is
available or need to probe the cache info to use any memory
available for frag caoleasing reason.

Currently skb_page_frag_refill() API is used to solve the
above use cases, but caller needs to know about the internal
detail and access the data field of 'struct page_frag' to
meet the requirement of the above use cases and its
implementation is similar to the one in mm subsystem.

To unify those two page_frag implementations, introduce a
prepare API to ensure minimum memory is satisfied and return
how much the actual memory is available to the caller and a
probe API to report the current available memory to caller
without doing cache refilling. The caller needs to either call
the commit API to report how much memory it actually uses, or
not do so if deciding to not use any memory.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 151 ++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 24835ec8c891..16cc94755dd3 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -61,6 +61,11 @@ static inline unsigned int page_frag_cache_page_size(unsigned long encoded_page)
 	return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
 }
 
+static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
+{
+	return nc->offset;
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
@@ -126,6 +131,152 @@ static inline void *page_frag_alloc(struct page_frag_cache *nc,
 	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
 }
 
+static inline bool __page_frag_refill_align(struct page_frag_cache *nc,
+					    unsigned int fragsz,
+					    struct page_frag *pfrag,
+					    gfp_t gfp_mask,
+					    unsigned int align_mask)
+{
+	if (unlikely(!__page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask,
+						align_mask)))
+		return false;
+
+	__page_frag_cache_commit(nc, pfrag, true, fragsz);
+	return true;
+}
+
+static inline bool page_frag_refill_align(struct page_frag_cache *nc,
+					  unsigned int fragsz,
+					  struct page_frag *pfrag,
+					  gfp_t gfp_mask, unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, -align);
+}
+
+static inline bool page_frag_refill(struct page_frag_cache *nc,
+				    unsigned int fragsz,
+				    struct page_frag *pfrag, gfp_t gfp_mask)
+{
+	return __page_frag_refill_align(nc, fragsz, pfrag, gfp_mask, ~0u);
+}
+
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
+static inline bool page_frag_refill_prepare(struct page_frag_cache *nc,
+					    unsigned int fragsz,
+					    struct page_frag *pfrag,
+					    gfp_t gfp_mask)
+{
+	return __page_frag_refill_prepare_align(nc, fragsz, pfrag, gfp_mask,
+						~0u);
+}
+
+static inline void *__page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
+							   unsigned int fragsz,
+							   struct page_frag *pfrag,
+							   gfp_t gfp_mask,
+							   unsigned int align_mask)
+{
+	return __page_frag_cache_prepare(nc, fragsz, pfrag, gfp_mask, align_mask);
+}
+
+static inline void *page_frag_alloc_refill_prepare_align(struct page_frag_cache *nc,
+							 unsigned int fragsz,
+							 struct page_frag *pfrag,
+							 gfp_t gfp_mask,
+							 unsigned int align)
+{
+	WARN_ON_ONCE(!is_power_of_2(align));
+	return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
+						      gfp_mask, -align);
+}
+
+static inline void *page_frag_alloc_refill_prepare(struct page_frag_cache *nc,
+						   unsigned int fragsz,
+						   struct page_frag *pfrag,
+						   gfp_t gfp_mask)
+{
+	return __page_frag_alloc_refill_prepare_align(nc, fragsz, pfrag,
+						      gfp_mask, ~0u);
+}
+
+static inline void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc,
+							 unsigned int fragsz,
+							 struct page_frag *pfrag,
+							 unsigned int align_mask)
+{
+	unsigned long encoded_page = nc->encoded_page;
+	unsigned int size, offset;
+
+	size = page_frag_cache_page_size(encoded_page);
+	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
+	if (unlikely(!encoded_page || offset + fragsz > size))
+		return NULL;
+
+	pfrag->page = page_frag_encoded_page_ptr(encoded_page);
+	pfrag->size = size - offset;
+	pfrag->offset = offset;
+
+	return page_frag_encoded_page_address(encoded_page) + offset;
+}
+
+static inline void *page_frag_alloc_refill_probe(struct page_frag_cache *nc,
+						 unsigned int fragsz,
+						 struct page_frag *pfrag)
+{
+	return __page_frag_alloc_refill_probe_align(nc, fragsz, pfrag, ~0u);
+}
+
+static inline bool page_frag_refill_probe(struct page_frag_cache *nc,
+					  unsigned int fragsz,
+					  struct page_frag *pfrag)
+{
+	return !!page_frag_alloc_refill_probe(nc, fragsz, pfrag);
+}
+
+static inline void page_frag_commit(struct page_frag_cache *nc,
+				    struct page_frag *pfrag,
+				    unsigned int used_sz)
+{
+	__page_frag_cache_commit(nc, pfrag, true, used_sz);
+}
+
+static inline void page_frag_commit_noref(struct page_frag_cache *nc,
+					  struct page_frag *pfrag,
+					  unsigned int used_sz)
+{
+	__page_frag_cache_commit(nc, pfrag, false, used_sz);
+}
+
+static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
+					 unsigned int fragsz)
+{
+	VM_BUG_ON(fragsz > nc->offset);
+
+	nc->pagecnt_bias++;
+	nc->offset -= fragsz;
+}
+
 void page_frag_free(void *addr);
 
 #endif
-- 
2.33.0


