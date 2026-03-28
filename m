Return-Path: <netdev+bounces-272776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ3nFw7xx2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:17:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97034ED54
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A96E3016C99
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29133431F8;
	Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB0cJrIu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B733D6F8;
	Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711042; cv=none; b=kKu4ArxVhHT+Z41C9y1M0pDzmQ9CZne41J3fIExD9trsmu0jdeYgNYjrMRsqSmaH9UzBpL16hg3TUhI5JZ/JxkgVBOB4/rJXiuKNGwIRTVzEzcQ0L9bPJpsXjWB0vQVfqDkrEczTWxVvqk5i8IZRMQ6s68bvo7etiLkP+mAvEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711042; c=relaxed/simple;
	bh=MKqHx2DsVWgIqTTYLAkpvdX9hb59MkEI5VpTYdIILjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eg72D2CxjuzYpiO8lsdaJ6kBkMQeqnIfYcOF+zDv4NtywFlGTUUAmOUA3VjTXmWGyB+4UnXDejTgGO4p9Y7KTUZ0l8dyFz03ci4+3eDsgGVZfoXO6ixzIhdZ9wm8N6PuNTIV2IxrhPqdUFr6pX+c4Vts3xwv9LVUcv83Z6Yu8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB0cJrIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3D0C2BC86;
	Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774711042;
	bh=MKqHx2DsVWgIqTTYLAkpvdX9hb59MkEI5VpTYdIILjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OB0cJrIuWsPxrRZVqEVhHqwNAGg8WMqT56iwM/BKBxAGX7HGYpAUK18KjannX2IeW
	 qCJN9Gmy9UDJZtFmKEqR/4dWPnU5qNBc2LQoeyAjmSBWsSW72kqKZicLrV7PTZLnvT
	 xmg/bRC/ppwIH6SrFvsEhDuyNk46eBCI2LMmuj2wPM3ND5Fm8M7VTEbYsmeXssziVr
	 ChE+vHRmyTl4/uT9LWpAqmRtOrpjq5ErMcO/8dfchmn9Ssj9CphKo8wOzjFVCh6eD3
	 +IeHxGLHCBb2DuR1VLERwtDPQi6COGFfsF+eEK3izcr5nLH7KZB8ybpZCHxA3c2P9b
	 6tsVYZLv3qArA==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 28 Mar 2026 11:17:08 -0400
Subject: [PATCH net-next v7 1/5] tls: Abort the connection on decrypt
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-tls-read-sock-v7-1-15678415dfc1@oracle.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
In-Reply-To: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=8rkFUaZwGHp34oZtLBHCP2ihwiz9+QlviZCigfPoS+o=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpx/EASXDl6nG7E4HmcqQYv2rDCfjfj0dKciwXn
 od9Etn8Y+WJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacfxAAAKCRAzarMzb2Z/
 lzQyEADAaFuFhZwQytgYn/sFqLnEojeaFmZbWcwucMzaIbOF19ZR1p1f734i7FPHh9A/4zMzi7P
 IBWm7K3kuB63Erv1t9cA/przIpzmyK7GOp+NNmIeW3WBedjV9wm/l5tyLDhjVy4r1p4P9b73ukb
 M+M8M2J3fyf783ErBPaaXanQMRmgqXSUXwrwPPv+vLFmxoEnMHQX3alABKSzr5D26lg4uAV49dN
 f8xRmAocCkHc42lsecwKz5SxoAoGrgqZ060+97EYHVVYdthd91ksE08WtgqZmz5vEonvBdgGqPp
 tpaA+PRF8b6fs94Mc16sonGWFPvsbVhJt2y+kkPgi9dKnO2D+LS/fVqQyl6t7iK7EGKVy+/me8Z
 2pU6SLn61ONqaWwCLVaidusanb+sD/2X6kGv/uoSiDcZVU7ztVVkUQY6ghy04k+ZkgWIhyjjojj
 IRps9QvlkpVpiUpZKglqCdBg2uURPkHeFJ3YOPujc6GpLIqakJL3bcXHgK3iKdEGghMdJGZgkIH
 cdRyFWCBsD9SATdJ+rNJ11gVkHYtPbDwZ7cCnZK39tXh/uZ2K8z9ZD+tXAmyEFcQBQmSewsG6yg
 RqoGbko+ehtyNfNHCiGoP9ReMHk5zk9umwGCyEzjzImdirTbjvedYYjeHkNp6l7w8U2ywgt/WY4
 B+NgiRkODjOswRg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272776-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: AD97034ED54
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


