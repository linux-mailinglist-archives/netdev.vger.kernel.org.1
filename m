Return-Path: <netdev+bounces-40347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC47C6D8D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0388282830
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496425101;
	Thu, 12 Oct 2023 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9B22EE6
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:02:57 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD9A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:02:55 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qquOz-0008I6-1s; Thu, 12 Oct 2023 14:02:53 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: gso_test: release each segment individually
Date: Thu, 12 Oct 2023 14:02:37 +0200
Message-ID: <20231012120240.10447-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

consume_skb() doesn't walk the segment list, so segments other than
the first are leaked.

Move this skb_consume call into the loop.

Cc: Willem de Bruijn <willemb@google.com>
Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/core/gso_test.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index c4b13de6abfb..ceb684be4cbf 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -144,8 +144,8 @@ KUNIT_ARRAY_PARAM(gso_test, cases, gso_test_case_to_desc);
 static void gso_test_func(struct kunit *test)
 {
 	const int shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	struct sk_buff *skb, *segs, *cur, *next, *last;
 	const struct gso_test_case *tcase;
-	struct sk_buff *skb, *segs, *cur;
 	netdev_features_t features;
 	struct page *page;
 	int i;
@@ -236,7 +236,10 @@ static void gso_test_func(struct kunit *test)
 		goto free_gso_skb;
 	}
 
-	for (cur = segs, i = 0; cur; cur = cur->next, i++) {
+	last = segs->prev;
+	for (cur = segs, i = 0; cur; cur = next, i++) {
+		next = cur->next;
+
 		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
 
 		/* segs have skb->data pointing to the mac header */
@@ -247,13 +250,14 @@ static void gso_test_func(struct kunit *test)
 		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
 
 		/* last seg can be found through segs->prev pointer */
-		if (!cur->next)
-			KUNIT_ASSERT_PTR_EQ(test, cur, segs->prev);
+		if (!next)
+			KUNIT_ASSERT_PTR_EQ(test, cur, last);
+
+		consume_skb(cur);
 	}
 
 	KUNIT_ASSERT_EQ(test, i, tcase->nr_segs);
 
-	consume_skb(segs);
 free_gso_skb:
 	consume_skb(skb);
 }
-- 
2.41.0


