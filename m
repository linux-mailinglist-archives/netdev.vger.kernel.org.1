Return-Path: <netdev+bounces-75920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD186BADC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4274928A16B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FF7292A;
	Wed, 28 Feb 2024 22:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954E72901
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160261; cv=none; b=oychRo8Zco2D1CWjw7OBRaf9TG3lgNBfPNbyios3+xmYm/7szHnC3KEWykLZg39U9jVurmcs2DFv5+oeWtPwbvy744XXkZVxKQyM//ujG6skZDPhfuTAJ+uA4UXqhrGF3qBwPFM/sNvL4p13Wdl2JWpMFGwr+w5e8dV77IgHXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160261; c=relaxed/simple;
	bh=UHWi0Zi6PWMvl+XFy9eHFvordok3YbwyPLONXU3FyCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjRXFTPzXKSkAOfrzaL9QcRj1EzEKGgp9tAg596GlPQQEy697zL01OOm5PnZsi/qOUbDZ6DSg1jeZCxkLkKcTZzwhNOw1fZBaJW/J95oOuXRl++Yb8aL6qdTYgqcICFdniLXCtC+n8GfW6HMrwMw48ZTYYp0nczhpnotz/Po7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61E0320007;
	Wed, 28 Feb 2024 22:44:11 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/4] tls: fix peeking with sync+async decryption
Date: Wed, 28 Feb 2024 23:43:58 +0100
Message-ID: <1b132d2b2b99296bfde54e8a67672d90d6d16e71.1709132643.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709132643.git.sd@queasysnail.net>
References: <cover.1709132643.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

If we peek from 2 records with a currently empty rx_list, and the
first record is decrypted synchronously but the second record is
decrypted async, the following happens:
  1. decrypt record 1 (sync)
  2. copy from record 1 to the userspace's msg
  3. queue the decrypted record to rx_list for future read(!PEEK)
  4. decrypt record 2 (async)
  5. queue record 2 to rx_list
  6. call process_rx_list to copy data from the 2nd record

We currently pass copied=0 as skip offset to process_rx_list, so we
end up copying once again from the first record. We should skip over
the data we've already copied.

Seen with selftest tls.12_aes_gcm.recv_peek_large_buf_mult_recs

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
I'm not very happy with this, because the logic is already hard to
follow and I'm adding yet another variable counting how many bytes
we've handled, but everything else I tried broke at least one test
case :(

I'll see if I can rework this for net-next.


 net/tls/tls_sw.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9f23ba321efe..1394fc44f378 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1950,6 +1950,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
 	ssize_t copied = 0;
+	ssize_t peeked = 0;
 	bool async = false;
 	int target, err;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
@@ -2097,8 +2098,10 @@ int tls_sw_recvmsg(struct sock *sk,
 			if (err < 0)
 				goto put_on_rx_list_err;
 
-			if (is_peek)
+			if (is_peek) {
+				peeked += chunk;
 				goto put_on_rx_list;
+			}
 
 			if (partially_consumed) {
 				rxm->offset += chunk;
@@ -2137,8 +2140,8 @@ int tls_sw_recvmsg(struct sock *sk,
 
 		/* Drain records from the rx_list & copy if required */
 		if (is_peek || is_kvec)
-			err = process_rx_list(ctx, msg, &control, copied,
-					      decrypted, is_peek, NULL);
+			err = process_rx_list(ctx, msg, &control, copied + peeked,
+					      decrypted - peeked, is_peek, NULL);
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek, NULL);
-- 
2.43.0


