Return-Path: <netdev+bounces-96553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC48C66F6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD1284E54
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6847127E0A;
	Wed, 15 May 2024 13:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DF12AAEB;
	Wed, 15 May 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778759; cv=none; b=KNGlnW8vdK045fnOn7buZl0z6zOdMFGMm1gLxltSLRhcgId5AaIjMK/Y8Yk9ebG+XK0vasMlo63MYBfexWxZF96dSWtnUMgwgxt0SLxSpspdslPFwe5W2+5xsBTJUUBVnPTPhfpqVCKj2Qw81M3U7ZHeEeoMIlN26jVZFQbYWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778759; c=relaxed/simple;
	bh=qEXuc3p5hwOyD6brYLf7OG5VYwINvfEp8zy3rtODKgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgBaYG3CfyU5eMJZoPg9rgp4D4bMM0jAxJq0FWBC4ldyfE/eQk9CdESAf9jOU+mko3ie+HSJX0G/REIgrakrUPlbhX9myDcAnjcaEQes7lXn8DAOmjibuIixYnfVZ8eltbaI9AyuvHgKVsvHFFVBhlEBoJ4cW+q7xMVoxkj0wXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VfYSf3JMSzVm4p;
	Wed, 15 May 2024 21:08:34 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id EEB3218007D;
	Wed, 15 May 2024 21:12:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 21:12:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [RFC v4 03/13] mm: page_frag: use free_unref_page() to free page fragment
Date: Wed, 15 May 2024 21:09:22 +0800
Message-ID: <20240515130932.18842-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240515130932.18842-1-linyunsheng@huawei.com>
References: <20240515130932.18842-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

free_the_page() used by page_frag call free_unref_page() or
__free_pages_ok() depending on pcp_allowed_order(), as the
max order of page allocated for page_frag is 3, the checking
in pcp_allowed_order() is unnecessary.

So call free_unref_page() directly to free a page_frag page
to aovid the unnecessary checking.

As the free_the_page() is a static function in page_alloc.c,
using the new one also allow moving page_frag related code
to a new file in the next patch.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d336..7adb29f8f364 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4693,6 +4693,9 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_t gfp = gfp_mask;
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* Ensure free_unref_page() can be used to free the page fragment */
+	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);
+
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
@@ -4722,7 +4725,7 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
 
 	if (page_ref_sub_and_test(page, count))
-		free_the_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page));
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
@@ -4763,7 +4766,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 
 		if (unlikely(nc->pfmemalloc)) {
-			free_the_page(page, compound_order(page));
+			free_unref_page(page, compound_order(page));
 			goto refill;
 		}
 
@@ -4807,7 +4810,7 @@ void page_frag_free(void *addr)
 	struct page *page = virt_to_head_page(addr);
 
 	if (unlikely(put_page_testzero(page)))
-		free_the_page(page, compound_order(page));
+		free_unref_page(page, compound_order(page));
 }
 EXPORT_SYMBOL(page_frag_free);
 
-- 
2.33.0


