Return-Path: <netdev+bounces-32328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8385B7941E1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B471D1C209D6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080B10977;
	Wed,  6 Sep 2023 17:09:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBE10953
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 17:09:19 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5213E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:09:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 230032000C;
	Wed,  6 Sep 2023 17:09:15 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net 5/5] tls: don't decrypt the next record if it's of a different type
Date: Wed,  6 Sep 2023 19:08:35 +0200
Message-Id: <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
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

If the next record is of a different type, we won't copy it to
userspace in this round, tls_record_content_type will stop us just
after decryption. Skip decryption until the next recvmsg() call.

This fixes a use-after-free when a data record is decrypted
asynchronously but doesn't fill the userspace buffer, and the next
record is non-data, for example in the bad_cmsg selftest.

Fixes: c0ab4732d4c6 ("net/tls: Do not use async crypto for non-data records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f80a2ea1dd7e..86b835b15872 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2010,6 +2010,9 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			darg.async = false;
 
+		if (ctx->async_capable && control && tlm->control != control)
+			goto recv_end;
+
 		err = tls_rx_one_record(sk, msg, &darg);
 		if (err < 0) {
 			tls_err_abort(sk, -EBADMSG);
-- 
2.40.1


