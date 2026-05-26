Return-Path: <netdev+bounces-291718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBTALguuFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A105D77A8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06B07304B574
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EFB3FF8B5;
	Tue, 26 May 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeBqnTGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A83FF1D5;
	Tue, 26 May 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805310; cv=none; b=Ox63CP958kYj9YcGRJZdhoOMKb7WIhDTHHnIs1pLvucOwvatj0bNLfXWtf0MvQugI4Vr4gC+rUcj/+wnyIOSG7tSsSyoeF5frhxjTUq6wUFnW9HTMlO/TI08+L2XRnwSUW/Wo3Ysgzyy8nrZziL5+0xKnaQTzqHFlXgqCcztLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805310; c=relaxed/simple;
	bh=TN3e9vUKCQZTpcwJLsAxaBx2oIJDTKf+ZZbbvy2OoSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5GqtazG0Vp9Hw4vHr+u831FJt4F6srRIr2Q26p+fSDaLDh98EdvHgBJLBwDUCiWjR2P0L2NV5zGJRmjqNBkTg96M/7eHgvUMU9noTibsvDEaCfrd3fQV/cHCZRFeznht4EqG99wo8t0IsoDMM+d3hW8mMkEc6v1nUkYOTVE+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeBqnTGP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F44F1F000E9;
	Tue, 26 May 2026 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805309;
	bh=8n9jRU6qGOqsXjzqvpgUUlOx4fGv8R7RYaezld0pUlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PeBqnTGPhxicAKUBQbyw7CesWyM1buwzBKKbS4sFADOFRIB2tG7HhTh7Epu1tZeG1
	 DzKQtYhNzTSDTYKPWcrtcIoBFKyoIaKkfGqYcDJCoRYMKgzNCVihaRegvCG6YYCKYG
	 4pQQ+BSY3Y9vw8GTadTtSUGnHaG2f1gSuIWnBVfcC6goWZ8CYo2EGG+c/KvOKvQc85
	 7bAoFlhsdeQ8hKGAvQyapFY/sg4EmurCCBpG6vxmypMKVPRmbDNigbKY18+eH5oh39
	 sBPkBNcH7pW1hOVQajqEixWxpz0BAa2K02LqM6pqdmOK/GbJGy2npxap1LB0XbCuNV
	 xtfn8+/j9g7zg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 10:21:33 -0400
Subject: [PATCH net-next v11 3/6] tls: Move decrypt-failure abort into
 tls_rx_one_record()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tls-read-sock-v11-3-244fe1dc4abd@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
In-Reply-To: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFax4i+xWzzI6kzHTWlIxgiqOYpQiD0Xstf/LI
 28nN7FLUtmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWseAAKCRAzarMzb2Z/
 l4ldD/9/UhQ4W4VTP5iE3oEdwLNshJN8R8LXOhcqCvKxjipzYTPoY6mYdk1Y2XkBzWTkNdU4Yoc
 1zOddPEuI49Tvge/gDmXo0OGOpWg8LToO4zgCM0e973Qh7OEkW6y40dMD8Lbqc53Fv2hRuXC7Um
 1ChCBkrwwKKz/BWiTzUUNQbJqCNGHQnLpIUx1dU+IKI3smU9O1m20xiEmTDJGQnRwaA9t2Lgbzn
 +7IcR4hfKTUBbu4CNxe1udvhtEYROu5DNX4HSxq+ago8Wap7aRi86j9qP2oO2SpUrLR7r8iURW7
 eBNEBp3ZIsVaKQ2ggMrXQx4sdZM15YPiEEgXNdfZ9H/dFmM+C9SC/gK86qmc+JYNrjUx6uGqTU1
 2e8AtWaETc1c7LfTGlnd0V/rS2BoIvng5RPZHLuDq4D7SWAm76o19aiT3yLKTKk8FRA2kT3+gvI
 18qi+IbgR1i9fFytscq/9Tw36zv1RPCX3Z76umUCeio8dNBr2fGipCT6k2PtzDe57J4FnxJgpCs
 agMPq2IESwi2cdSIVvhWlwn3tNt8FuqXPgb4kbihtM0Tyn9AUM2OLnJBlzVfDKB9wgGyb7OMsNe
 PI3gATf4x7iqvrTRuagLVoG8RRRwmE4jgDO2yT3gfxoQv8BGu0lInCvUKQGLrObasA7MrLiMPja
 8vYL0nmym9oVkuw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291718-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,queasysnail.net:email]
X-Rspamd-Queue-Id: 38A105D77A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


