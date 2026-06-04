Return-Path: <netdev+bounces-295376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3bQfH4y6IWrPMgEAu9opvQ
	(envelope-from <netdev+bounces-295376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 445F9642648
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WhGf5nLO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295376-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295376-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B319A3015851
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E844CA287;
	Thu,  4 Jun 2026 17:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234244C957E;
	Thu,  4 Jun 2026 17:48:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595323; cv=none; b=l0x2UsazP2GKlnRkj8SVlLTknc/HXX8P8QKAmqnmV0Uz3r3E/1+Zq8QutEysqh6d3F1SVtrU1IaK0E94AsIZ5cyjClPkkYKe24YHSeqNS1WycptcDeGfYgya0/6kXVAWAFwAN3ArZYcjuXpyNg0XFLV8tfQfF2E1dgFn9J3xVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595323; c=relaxed/simple;
	bh=TN3e9vUKCQZTpcwJLsAxaBx2oIJDTKf+ZZbbvy2OoSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPKFmfuOQuXvPp5cakasPssGaHpyXYdvxleoZoH+5Rx/65jUZxPecKuuWA4oHuhdSaJlcN29G1h9SBXGh2NBfhSXFtNu5dHw0A9EfYD3Ww686Lma4iy7VVlBqBNj0/23RfdchPd/6T+1mZj7O62x+tVIbuNz962MoffV+JvSnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhGf5nLO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD451F0089A;
	Thu,  4 Jun 2026 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595321;
	bh=8n9jRU6qGOqsXjzqvpgUUlOx4fGv8R7RYaezld0pUlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WhGf5nLOOYn3G9dCKpDPz+z/588rLh72jT7mEJksEfQp4UlXkeTG+eh1WJ++D/9uj
	 wj+bBdvX37Ah2L8hLiHnMbrU5JiZ870OxdkxrHi6K+uFqeqC6WXaPYs3s1supZgEyu
	 2UXdwoPUhUVbt+0L5WIwhTGnaDF9qsVFbApw2z1r2vPrjrpdav++9YxAxrKLOG6kmf
	 Fjd7FCf7WhQ8Lj7ltuUWHi19fQ5EwLuW+Ui/K3b0h8Uw3UDF8+s3/l5xZjJS8va1EA
	 ra4nxIwp8VgV/59bA0XT9SyLC7LKCrJmm/roJCu0FjC+ko0EN80RxKy+fBIDlzoMWg
	 YCZOg/xlgcgXA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:48:26 -0400
Subject: [PATCH net-next v12 3/6] tls: Move decrypt-failure abort into
 tls_rx_one_record()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tls-read-sock-v12-3-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+/l4Pon/KAfZrJzOb9SNKcX00AtoXRLqyLgb80E5Cfs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbp39jCLPVMWKftvY1tD97xkFMkAgwF8sfO/L
 YrR1oIJd6qJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6dwAKCRAzarMzb2Z/
 l04qEAClAu7tgymFucNn4/0Avhi96ZhTgwGC/Wzmp8TaqpT5K/R15HJyBgEGzyqoUSN+jfmrMfM
 5v28Wnh2urHJSl9pZzY3KKPDgrzfWnQyvMzWbmSGlSiWXSe3NagObXt1xOp7QWvP7e31eJ1c9P5
 MtINIEZ/C6IosAFIWP69BAojagP68eZTob8ObWx0f6tGLxtKroG0RYhYBBhw/KcbhoNtJ/oun3E
 Ftl35935YQ89w33lzJtlQNLaQFEkrcxlCST16EbQoRKCQ5jQWEYzlDsccDVLA4WbnC2Y0nNiPZQ
 3zxLTu24GTsPqv4kbGtLQaO/moqpRyCZdkaemBe1zLL+zpvTBp+m8PqNuRStXcDOKSOppfKZEgU
 ynYLrLoxEqYluwxCGh5pbNyyHH3uavNnMylA0cVmru+V/+uzjaYpDohIwacl9oKT70tX5EemjPB
 nwIPIlrK4oY5GqGmXarjFK4Kn9B2TG3umq/+1wDIVA3FV5yzYUdSyBknR/IfQRbBz+FF6se/RFR
 O7JOjxsJNWR2WmhsiTc6bEcuP/wM+tsj7/8XrCjAQgz8N/cSwNnVq9oIzwvZH5SYGsx0XwjLHnG
 uYu65B/FLYX1Fql6xNn8MRPMw3Vm+UgE4ZlJHlOJ3oo9YpbTXR07lpcCa8Zpk2JlPI4uF2TdPAj
 tEX4+f47LwYykTw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295376-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@suse.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,queasysnail.net:email,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 445F9642648

From: Chuck Lever <chuck.lever@oracle.com>

Three receive paths -- recvmsg, read_sock, and splice_read --
each follow tls_rx_one_record() with the same tls_err_abort()
call. Consolidate the abort into tls_rx_one_record() so the
decrypt-and-abort sequence lives in one place.

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
index fd8d3c979368..798f2535ddf7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1827,6 +1827,9 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	return 0;
 }
 
+/* On decrypt failure the connection is aborted (sk_err set) before
+ * returning a negative errno.
+ */
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1838,8 +1841,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
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
@@ -2150,10 +2155,8 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.async = false;
 
 		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2312,10 +2315,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2398,10 +2399,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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
2.54.0


