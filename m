Return-Path: <netdev+bounces-21937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9501F76553B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511B228237C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EF17AA5;
	Thu, 27 Jul 2023 13:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401B17AA1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:36:34 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E832728;
	Thu, 27 Jul 2023 06:36:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qP1AK-0003FC-UA; Thu, 27 Jul 2023 15:36:28 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Jeremy Sowden <jeremy@azazel.net>
Subject: [PATCH net-next 5/5] lib/ts_bm: add helper to reduce indentation and improve readability
Date: Thu, 27 Jul 2023 15:36:00 +0200
Message-ID: <20230727133604.8275-6-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727133604.8275-1-fw@strlen.de>
References: <20230727133604.8275-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeremy Sowden <jeremy@azazel.net>

The flow-control of `bm_find` is very deeply nested with a conditional
comparing a ternary expression against the pattern inside a for-loop
inside a while-loop inside a for-loop.

Move the inner for-loop into a helper function to reduce the amount of
indentation and make the code easier to read.

Fix indentation and trailing white-space in preceding debug logging
statement.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 lib/ts_bm.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index c8ecbf74ef29..e5f30f9177df 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -55,6 +55,24 @@ struct ts_bm
 	unsigned int	good_shift[];
 };
 
+static unsigned int matchpat(const u8 *pattern, unsigned int patlen,
+			     const u8 *text, bool icase)
+{
+	unsigned int i;
+
+	for (i = 0; i < patlen; i++) {
+		u8 t = *(text-i);
+
+		if (icase)
+			t = toupper(t);
+
+		if (t != *(pattern-i))
+			break;
+	}
+
+	return i;
+}
+
 static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 {
 	struct ts_bm *bm = ts_config_priv(conf);
@@ -72,19 +90,18 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 			break;
 
 		while (shift < text_len) {
-			DEBUGP("Searching in position %d (%c)\n", 
-				shift, text[shift]);
-			for (i = 0; i < bm->patlen; i++) 
-				if ((icase ? toupper(text[shift-i])
-				    : text[shift-i])
-					!= bm->pattern[bm->patlen-1-i])
-				     goto next;
-
-			/* London calling... */
-			DEBUGP("found!\n");
-			return consumed + (shift-(bm->patlen-1));
-
-next:			bs = bm->bad_shift[text[shift-i]];
+			DEBUGP("Searching in position %d (%c)\n",
+			       shift, text[shift]);
+
+			i = matchpat(&bm->pattern[bm->patlen-1], bm->patlen,
+				     &text[shift], icase);
+			if (i == bm->patlen) {
+				/* London calling... */
+				DEBUGP("found!\n");
+				return consumed + (shift-(bm->patlen-1));
+			}
+
+			bs = bm->bad_shift[text[shift-i]];
 
 			/* Now jumping to... */
 			shift = max_t(int, shift-i+bs, shift+bm->good_shift[i]);
-- 
2.41.0


