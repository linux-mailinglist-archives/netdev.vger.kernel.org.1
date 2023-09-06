Return-Path: <netdev+bounces-32325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FF7941DE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4531C20986
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CF1096B;
	Wed,  6 Sep 2023 17:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDE11185
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 17:09:02 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F092E13E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:09:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DA1620004;
	Wed,  6 Sep 2023 17:08:58 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net 2/5] tls: fix use-after-free with partial reads and async decrypt
Date: Wed,  6 Sep 2023 19:08:32 +0200
Message-Id: <aa1a31a25c2d0121e039f34ee58a996ea9a130ad.1694018970.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1694018970.git.sd@queasysnail.net>
References: <cover.1694018970.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tls_decrypt_sg doesn't take a reference on the pages from clear_skb,
so the put_page() in tls_decrypt_done releases them, and we trigger a
use-after-free in process_rx_list when we try to read from the
partially-read skb.

This can be seen with the recv_and_splice test case.

Fixes: fd31f3996af2 ("tls: rx: decrypt into a fresh skb")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 4f3dd0403efb..f23cceaceb36 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -63,6 +63,7 @@ struct tls_decrypt_ctx {
 	u8 iv[MAX_IV_SIZE];
 	u8 aad[TLS_MAX_AAD_SIZE];
 	u8 tail;
+	bool put_outsg;
 	struct scatterlist sg[];
 };
 
@@ -221,7 +222,8 @@ static void tls_decrypt_done(void *data, int err)
 		for_each_sg(sg_next(sgout), sg, UINT_MAX, pages) {
 			if (!sg)
 				break;
-			put_page(sg_page(sg));
+			if (dctx->put_outsg)
+				put_page(sg_page(sg));
 		}
 	}
 
@@ -1549,6 +1551,8 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	if (err < 0)
 		goto exit_free;
 
+	dctx->put_outsg = false;
+
 	if (clear_skb) {
 		sg_init_table(sgout, n_sgout);
 		sg_set_buf(&sgout[0], dctx->aad, prot->aad_size);
@@ -1558,6 +1562,8 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 		if (err < 0)
 			goto exit_free;
 	} else if (out_iov) {
+		dctx->put_outsg = true;
+
 		sg_init_table(sgout, n_sgout);
 		sg_set_buf(&sgout[0], dctx->aad, prot->aad_size);
 
-- 
2.40.1


