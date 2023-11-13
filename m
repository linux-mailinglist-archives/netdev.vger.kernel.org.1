Return-Path: <netdev+bounces-47350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06B7E9C9E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58916280E1B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924A41DFE4;
	Mon, 13 Nov 2023 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4A1DA39
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:00:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3726519A7;
	Mon, 13 Nov 2023 05:00:39 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4STTvY6l89zPnY6;
	Mon, 13 Nov 2023 20:56:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:37 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH RFC 5/8] skbuff: remove compound_head() related function calling
Date: Mon, 13 Nov 2023 21:00:37 +0800
Message-ID: <20231113130041.58124-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231113130041.58124-1-linyunsheng@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

As we have ensured that the page for the skb frag is
always a base page or head page for a compound page, we
can remove some compound_head() related function.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/skbuff.h | 8 +++++---
 net/core/skbuff.c      | 4 +---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3e2f806c8ed8..1889b0968be0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2473,13 +2473,15 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
 static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
 					struct page *page, int off, int size)
 {
-	__skb_fill_page_desc_noacc(skb_shinfo(skb), i, page, off, size);
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+	skb_frag_fill_page_desc(frag, page, off, size);
 
 	/* Propagate page pfmemalloc to the skb if we can. The problem is
 	 * that not all callers have unique ownership of the page but rely
 	 * on page_is_pfmemalloc doing the right thing(tm).
 	 */
-	page = compound_head(page);
+	page = frag->bv_page;
 	if (page_is_pfmemalloc(page))
 		skb->pfmemalloc	= true;
 }
@@ -3429,7 +3431,7 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
  */
 static inline void __skb_frag_ref(skb_frag_t *frag)
 {
-	get_page(skb_frag_page(frag));
+	page_ref_inc(skb_frag_page(frag));
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..ada3da4fe221 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -896,8 +896,6 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	bool allow_direct = false;
 	struct page_pool *pp;
 
-	page = compound_head(page);
-
 	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
 	 * in order to preserve any existing bits, such as bit 0 for the
 	 * head page of compound page and bit 1 for pfmemalloc page, so
@@ -939,7 +937,7 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 {
 	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
 		return false;
-	return napi_pp_put_page(virt_to_page(data), napi_safe);
+	return napi_pp_put_page(virt_to_head_page(data), napi_safe);
 }
 
 static void skb_kfree_head(void *head, unsigned int end_offset)
-- 
2.33.0


