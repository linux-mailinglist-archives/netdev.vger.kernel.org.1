Return-Path: <netdev+bounces-40349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB97C6D9C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A92B1C20D3B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C2225112;
	Thu, 12 Oct 2023 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957424A0B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:09:13 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C6BA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:09:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qquV3-0008Lu-H5; Thu, 12 Oct 2023 14:09:09 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemb@google.com>,
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [PATCH net-next] net: gso_test: fix build with gcc-12 and earlier
Date: Thu, 12 Oct 2023 14:08:56 +0200
Message-ID: <20231012120901.10765-1-fw@strlen.de>
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

gcc 12 errors out with:
net/core/gso_test.c:58:48: error: initializer element is not constant
   58 |                 .segs = (const unsigned int[]) { gso_size },

This version isn't old (2022), so switch to preprocessor-bsaed constant
instead of 'static const int'.

Cc: Willem de Bruijn <willemb@google.com>
Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/netdev/79fbe35c-4dd1-4f27-acb2-7a60794bc348@linux.vnet.ibm.com/
Fixes: 1b4fa28a8b07 ("net: parametrize skb_segment unit test to expand coverage")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/core/gso_test.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index c1a6cffb6f96..c4b13de6abfb 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -4,7 +4,7 @@
 #include <linux/skbuff.h>
 
 static const char hdr[] = "abcdefgh";
-static const int gso_size = 1000;
+#define GSO_TEST_SIZE 1000
 
 static void __init_skb(struct sk_buff *skb)
 {
@@ -18,7 +18,7 @@ static void __init_skb(struct sk_buff *skb)
 
 	/* proto is arbitrary, as long as not ETH_P_TEB or vlan */
 	skb->protocol = htons(ETH_P_ATALK);
-	skb_shinfo(skb)->gso_size = gso_size;
+	skb_shinfo(skb)->gso_size = GSO_TEST_SIZE;
 }
 
 enum gso_test_nr {
@@ -53,70 +53,70 @@ static struct gso_test_case cases[] = {
 	{
 		.id = GSO_TEST_NO_GSO,
 		.name = "no_gso",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_segs = 1,
-		.segs = (const unsigned int[]) { gso_size },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE },
 	},
 	{
 		.id = GSO_TEST_LINEAR,
 		.name = "linear",
-		.linear_len = gso_size + gso_size + 1,
+		.linear_len = GSO_TEST_SIZE + GSO_TEST_SIZE + 1,
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 1 },
 	},
 	{
 		.id = GSO_TEST_FRAGS,
 		.name = "frags",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frags = 2,
-		.frags = (const unsigned int[]) { gso_size, 1 },
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, 1 },
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 1 },
 	},
 	{
 		.id = GSO_TEST_FRAGS_PURE,
 		.name = "frags_pure",
 		.nr_frags = 3,
-		.frags = (const unsigned int[]) { gso_size, gso_size, 2 },
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 2 },
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, 2 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 2 },
 	},
 	{
 		.id = GSO_TEST_GSO_PARTIAL,
 		.name = "gso_partial",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frags = 2,
-		.frags = (const unsigned int[]) { gso_size, 3 },
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, 3 },
 		.nr_segs = 2,
-		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
+		.segs = (const unsigned int[]) { 2 * GSO_TEST_SIZE, 3 },
 	},
 	{
 		/* commit 89319d3801d1: frag_list on mss boundaries */
 		.id = GSO_TEST_FRAG_LIST,
 		.name = "frag_list",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frag_skbs = 2,
-		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
 		.nr_segs = 3,
-		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE },
 	},
 	{
 		.id = GSO_TEST_FRAG_LIST_PURE,
 		.name = "frag_list_pure",
 		.nr_frag_skbs = 2,
-		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
 		.nr_segs = 2,
-		.segs = (const unsigned int[]) { gso_size, gso_size },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
 	},
 	{
 		/* commit 43170c4e0ba7: GRO of frag_list trains */
 		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM,
 		.name = "frag_list_non_uniform",
-		.linear_len = gso_size,
+		.linear_len = GSO_TEST_SIZE,
 		.nr_frag_skbs = 4,
-		.frag_skbs = (const unsigned int[]) { gso_size, 1, gso_size, 2 },
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 1, GSO_TEST_SIZE, 2 },
 		.nr_segs = 4,
-		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size, 3 },
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
 	},
 	{
 		/* commit 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes") and
-- 
2.41.0


