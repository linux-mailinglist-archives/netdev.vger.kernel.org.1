Return-Path: <netdev+bounces-47352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D87E9CA3
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950CD280D1E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3BF1DA39;
	Mon, 13 Nov 2023 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6F1DDE0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:00:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC701984;
	Mon, 13 Nov 2023 05:00:38 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4STTwZ5Mryz1P8HW;
	Mon, 13 Nov 2023 20:57:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:35 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>
Subject: [PATCH RFC 4/8] skbuff: explicitize the semantics of skb_frag_fill_page_desc()
Date: Mon, 13 Nov 2023 21:00:36 +0800
Message-ID: <20231113130041.58124-5-linyunsheng@huawei.com>
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

As we have ensured that the page and the offset to the page
for the skb frag is passed togetherly in one function call,
see [1], make it explicit that skb_frag_fill_page_desc()
expect a base page or head page for a compound page, so
that we can avoid the compound_head() in the net stack.

Log a warning if the caller passes a tail page of compoud
page and adjust 'page' to point to it's head page and
'offset' to point to start of it's head page. The warning
can be removed if we have ensured all the caller is passing
non tail page to skb_frag_fill_page_desc() in the future.

1. https://lore.kernel.org/all/20230511011213.59091-2-linyunsheng@huawei.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27998f73183e..3e2f806c8ed8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2423,6 +2423,14 @@ static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
 					   struct page *page,
 					   int off, int size)
 {
+	/* expect head page for compound page */
+	if (WARN_ON_ONCE(PageTail(page))) {
+		struct page *head = compound_head(page);
+
+		off += (page_to_pfn(page) - page_to_pfn(head)) * PAGE_SIZE;
+		page = head;
+	}
+
 	frag->bv_page = page;
 	frag->bv_offset = off;
 	skb_frag_size_set(frag, size);
-- 
2.33.0


