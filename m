Return-Path: <netdev+bounces-272078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO2gNYg7xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:58:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4823366A5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04589308FE5C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7C930E851;
	Thu, 26 Mar 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqh8Rawr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A2231A23;
	Thu, 26 Mar 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533068; cv=none; b=azHzlx2GMOC6Aw6RyK/Lg2nVvN7sOgnWP2wqFIpeNvbFn5bA1vxl8YLXzbG/VaioW///o1OBURa1v0E7D32dU7usxvygYPueUJmzGhJbKvuqiUYU0YAl/HaJvfMFsOx9juru8velscbiPZbBoEHqTOxEzldZ3x33S/QbGRJMUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533068; c=relaxed/simple;
	bh=MKqHx2DsVWgIqTTYLAkpvdX9hb59MkEI5VpTYdIILjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdT/PTzy+OPnjuWQYJaFOwutoQR1ae7Xv0tUn+/yB5KkZFezZcT9oez5zWS7RXOBAu/DH7pXSz7hc0Z/mGJduebb96oiuqPIeE4O0vIIifa0dXDirwwEUy98zPtZDaGSnxt2jTiv+XDVuDputaMDCtZRC1nH2UU6+XZO6S2CJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqh8Rawr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD056C4AF09;
	Thu, 26 Mar 2026 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533068;
	bh=MKqHx2DsVWgIqTTYLAkpvdX9hb59MkEI5VpTYdIILjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rqh8RawrezX9QxVPHnoY/yaMv+OFJewTqMgRoLcBnXPe9glMkbz8A3wXSoww7tiPY
	 3lfERnlIpjOT+ryAMBnPqTtXxa+GfD2uIl816/TY2JtpzGI5skjvZ+k0/Vcu3iSQt3
	 lpOec/k44tfusKC0fCnlcpT9kPqd4cyTIoRzJUmB2B8yaVbtN0LEPSNsIAVYyhH2k9
	 Kp/eosABeEHX6+IQqlDma7o3CACETDjo5Yp6yr0M4wS8DpVs1AH1eV5zTOjHFwhpjz
	 WeFHgbeAL6lfQSMn5D4acFgtqwV9fKUulSsyrbF3U1Avh2Em3BmRMFfWWP2G/A09gG
	 P3zRFn2NxswLQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 09:50:47 -0400
Subject: [PATCH net-next v6 2/6] tls: Abort the connection on decrypt
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tls-read-sock-v6-2-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=8rkFUaZwGHp34oZtLBHCP2ihwiz9+QlviZCigfPoS+o=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnJy/P5cyHP3VEj9CDbhEY3Zkn2F2Zv3R5wl
 ZwIlk1uUdyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5yQAKCRAzarMzb2Z/
 l6qaD/9D1h/qTX0UoXUBPaoc6DOhZKg4RUyKzelopS/8AEm23anoCIicNJQlJyLnpij6tBCtkmQ
 nvPL4cj/RilPNpvH6lMUL4pCVIk02Iqx5fQpLQM+hAoW+VjnHwfkx1nAlRMwb9HVj3A1ZzUL4gB
 m4Fo4zFursIKU8x4qWtKG9cIZsvZ31IB6oT6luXCNVv3qGrXQAdCSbqsB6MpV7k3D8T0NaY4tBq
 jsx7Ryj9Y7dzI61MoV4P+0gQ3l0kHmrylsdkWLSbOf5s6xWdZwXVCsq1UTWNKl6DCFzMq2jmsy+
 Sy6k421ErRm0pEEyCdfx6oNsr1ge97j+5CKAl7sJ+ftnbIfL598+3GvBSpA7NQTMGm7pDtD7Hwx
 J8KpZD3sCeU03gtd81+NbsmDM8g2nanTAlrFNTsXy7wyFdTHp0/HHdDnT4nTGZDMlELylCfA2w8
 1chIiA88VcKuEhz8EZa3/CmHebEURt+/4zVBnk2C3qHQoDraMy+gRRbKc8FPepitpSKhTokz79w
 dOCp5b4xDhQSqua2Oyt9S5QVGbiVItRZJtFJB6x3+YinFbcjO1m0bwCjOnDXfdBgHJXQ3w5k+SR
 Ev6jv+JZzsR1+TgLPaYs4kJyA73OROnUxvvCgP1vmH/R279d4TjNMgMAiZr51D26ajYmwnBEUNU
 NoFKlXC/xKxOBDg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272078-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 3F4823366A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

recvmsg, read_sock, and splice_read each open-code a
tls_err_abort() call after tls_rx_one_record() fails. Move
the abort into tls_rx_one_record() so each receive path
shares a single decrypt-and-abort sequence.

A tls_check_pending_rekey() failure after successful
decryption no longer triggers tls_err_abort(). That path
fires only when skb_copy_bits() fails on a valid skb,
which is not a realistic scenario.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 20f8fc84c5f5..5626fdd4ea0a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1799,6 +1799,9 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	return 0;
 }
 
+/* Decrypt and return one TLS record. On decrypt failure the connection is
+ * aborted (sk_err set) before returning a negative errno.
+ */
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1810,8 +1813,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
 	if (!err)
 		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
-	if (err < 0)
+	if (err < 0) {
+		tls_err_abort(sk, -EBADMSG);
 		return err;
+	}
 
 	rxm = strp_msg(darg->skb);
 	rxm->offset += prot->prepend_size;
@@ -2122,10 +2127,8 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.async = false;
 
 		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2284,10 +2287,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2370,10 +2371,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+			if (err < 0)
 				goto read_sock_end;
-			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,

-- 
2.53.0


