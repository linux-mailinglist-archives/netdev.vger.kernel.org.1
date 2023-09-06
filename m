Return-Path: <netdev+bounces-32326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD357941DF
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D341C20A75
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FE10970;
	Wed,  6 Sep 2023 17:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307E11185
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 17:09:06 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10C13E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:09:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7796F2000A;
	Wed,  6 Sep 2023 17:09:03 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net 3/5] tls: fix returned read length with async !zc decrypt
Date: Wed,  6 Sep 2023 19:08:33 +0200
Message-Id: <c80bbd6e7c810cdf062bcb6937f259205f914b9a.1694018970.git.sd@queasysnail.net>
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

We can double-count the chunk size:
 - once via decrypted
 - once in async_copy_bytes, which then becomes part of
   process_rx_list's return value

Subtract it from decrypted before adding in process_rx_list's return
value.

Fixes: 4d42cd6bc2ac ("tls: rx: fix return value for async crypto")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
This logic is so complex, in this series I'm just trying to make all
the selftests pass at the same time :/

 net/tls/tls_sw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f23cceaceb36..babbd43d41ed 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2132,7 +2132,13 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek);
-		decrypted += max(err, 0);
+
+		if (err > 0) {
+			/* decrypted already accounts for async_copy_bytes,
+			 * we don't want to double-count
+			 */
+			decrypted += err - async_copy_bytes;
+		}
 	}
 
 	copied += decrypted;
-- 
2.40.1


