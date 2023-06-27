Return-Path: <netdev+bounces-14155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC9873F4E2
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBB5280DE8
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11B9445;
	Tue, 27 Jun 2023 06:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E58F7F
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:53:28 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A26A2698;
	Mon, 26 Jun 2023 23:53:10 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 1/6] lib/ts_bm: reset initial match offset for every block of text
Date: Tue, 27 Jun 2023 08:52:59 +0200
Message-Id: <20230627065304.66394-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230627065304.66394-1-pablo@netfilter.org>
References: <20230627065304.66394-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeremy Sowden <jeremy@azazel.net>

The `shift` variable which indicates the offset in the string at which
to start matching the pattern is initialized to `bm->patlen - 1`, but it
is not reset when a new block is retrieved.  This means the implemen-
tation may start looking at later and later positions in each successive
block and miss occurrences of the pattern at the beginning.  E.g.,
consider a HTTP packet held in a non-linear skb, where the HTTP request
line occurs in the second block:

  [... 52 bytes of packet headers ...]
  GET /bmtest HTTP/1.1\r\nHost: www.example.com\r\n\r\n

and the pattern is "GET /bmtest".

Once the first block comprising the packet headers has been examined,
`shift` will be pointing to somewhere near the end of the block, and so
when the second block is examined the request line at the beginning will
be missed.

Reinitialize the variable for each new block.

Fixes: 8082e4ed0a61 ("[LIB]: Boyer-Moore extension for textsearch infrastructure strike #2")
Link: https://bugzilla.netfilter.org/show_bug.cgi?id=1390
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 lib/ts_bm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 1f2234221dd1..c8ecbf74ef29 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -60,10 +60,12 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 	struct ts_bm *bm = ts_config_priv(conf);
 	unsigned int i, text_len, consumed = state->offset;
 	const u8 *text;
-	int shift = bm->patlen - 1, bs;
+	int bs;
 	const u8 icase = conf->flags & TS_IGNORECASE;
 
 	for (;;) {
+		int shift = bm->patlen - 1;
+
 		text_len = conf->get_next_block(consumed, &text, conf, state);
 
 		if (unlikely(text_len == 0))
-- 
2.30.2


