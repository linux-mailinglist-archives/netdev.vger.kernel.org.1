Return-Path: <netdev+bounces-32327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249867941E0
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F461C20A2C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BE10973;
	Wed,  6 Sep 2023 17:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6AEDB
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 17:09:12 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1171998
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:09:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6983620007;
	Wed,  6 Sep 2023 17:09:09 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net 4/5] tls: fix race condition in async decryption of corrupted records
Date: Wed,  6 Sep 2023 19:08:34 +0200
Message-Id: <e094325019f7fd960470c10efda41c1b7f9bc54f.1694018970.git.sd@queasysnail.net>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In case a corrupted record is decrypted asynchronously, the error can
be reported in two ways:
 - via the completion's error mechanism
 - via sk->sk_err

If all asynchronous decrypts finish before we reach the end of
tls_sw_recvmsg, decrypt_pending will be 0 and we don't check the
completion for errors. We should still check sk->sk_err, otherwise
we'll miss the error and return garbage to userspace. This is visible
in the bad_auth test case.

Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index babbd43d41ed..f80a2ea1dd7e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2116,6 +2116,9 @@ int tls_sw_recvmsg(struct sock *sk,
 		ret = 0;
 		if (pending)
 			ret = crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+		/* Crypto completion could have run before us, check sk_err */
+		if (ret == 0)
+			ret = -sk->sk_err;
 		__skb_queue_purge(&ctx->async_hold);
 
 		if (ret) {
-- 
2.40.1


