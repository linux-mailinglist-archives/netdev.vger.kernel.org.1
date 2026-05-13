Return-Path: <netdev+bounces-287590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJarJJl1BGqdJwIAu9opvQ
	(envelope-from <netdev+bounces-287590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:59:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D2533774
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BA2C30530AD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D423FA5D4;
	Wed, 13 May 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+ZXpAm3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08073E5A0A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677110; cv=none; b=ByFZtP+GH08MxKkgBW5i335pYwY3RwleMeZnwoAe95jYiVMNRByx43obBHaTkNIMgyFD5+HWJ28aw88WLQ2MG34g3pm9r7fDhnaVAYF2evuCogz9IihGP0DFKAy3+wCrqCsvtRxIA+eHigaRxbXtXF8owb0CiYk6r3ZTH2HZgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677110; c=relaxed/simple;
	bh=LEUBIiNlhIwLVoS07r7CEgQFYEL3sJFAgY7Ax/ZODxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+EMWqyhJXjDGryETjlczwzVJHf5nIH5DJQ+mP2AAzSQ0pOBp1LTgOPBIgE6NAzQ+9+3cmnvsfBHNTp4tN/BJQ8t/igiBN50dz4CJ4P5ZIyZhWWj1kDwffSg4pX3Ou8wl6dPzNCXWxelcJnQrg3aG/CgXXU44sFLrVyoVRTLbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+ZXpAm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE893C2BCB7;
	Wed, 13 May 2026 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778677110;
	bh=LEUBIiNlhIwLVoS07r7CEgQFYEL3sJFAgY7Ax/ZODxY=;
	h=From:To:Cc:Subject:Date:From;
	b=L+ZXpAm32iTYghL2PacX7SpCOMUtLNwpgcdDO695PppdglN2aO+rJuYxeMh48zAzR
	 Yo1wy5IDASrkbA5AsOL9umMSu9iXNYOUHhXZbNGiu3jBIyhE3YQLBi5t0pQ/L6oMPy
	 16ee4xP1CKktkVo6cu6fiHbrEXpf4TRX7Fb/Ebco5CA4jyxmOAuaGAWeFpdATL2LhJ
	 UfKBCUdWUMLvIXxfHo6KpMNxLEYUXFO3xlHEJqt6Yje28mFPRJeAudz+Pv3AasScIV
	 P2PewY7KbMQSxrfizKnMH9cH3oa40qrFE+I87unW/BO29V5KvqQs0AoGczgtl4ILwQ
	 hyke8s/xJVGIQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH net] tls: Preserve sk_err across recvmsg() when data has been copied
Date: Wed, 13 May 2026 08:58:25 -0400
Message-ID: <20260513125825.205189-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 543D2533774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287590-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The sk_err check in tls_rx_rec_wait() consumes the error via
sock_error(), which clears sk_err atomically. When the caller
(tls_sw_recvmsg, tls_sw_splice_read, or tls_sw_read_sock) already
has bytes copied to userspace, it returns those bytes and discards
the error from this call. sk_err is now zero on the socket, so the
next read syscall observes only RCV_SHUTDOWN and reports a clean
EOF instead of the actual error (typically -ECONNRESET).

The race is reachable when tls_read_flush_backlog()'s periodic
sk_flush_backlog() triggers tcp_reset() in the middle of a
multi-record read.

Pass a has_copied flag to tls_rx_rec_wait(). When has_copied is
false, consume sk_err via sock_error() as before. When has_copied
is true, report the error from READ_ONCE() but leave sk_err set:
the caller returns the byte count and discards the err from this
call, and the next read syscall surfaces the preserved sk_err. This
mirrors the tcp_recvmsg() preserve-and-surface pattern.

The decrypt-abort path is unaffected: tls_err_abort() raises
sk_err to EBADMSG after tls_rx_rec_wait() returns, and nothing
on the caller's return path consumes it, so the EBADMSG surfaces
on the next read.

tls_sw_splice_read() passes has_copied=false: it processes
one record per call, so no bytes have been copied within the
function when tls_rx_rec_wait() runs. A reset that arrives
between iterations of splice_direct_to_actor() (the sendfile()
path) is still consumed by sock_error() in the later call, and the
outer loop returns the prior iterations' byte count and drops the
error. tcp_splice_read() exhibits the same pattern at the iteration
boundary; addressing it belongs at the splice_direct_to_actor()
layer and is out of scope here.

Fixes: c46b01839f7a ("tls: rx: periodically flush socket backlog")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2590e855f6a5..c4cc4e357848 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1356,9 +1356,14 @@ void tls_sw_splice_eof(struct socket *sock)
 	mutex_unlock(&tls_ctx->tx_lock);
 }
 
+/* When has_copied is true the caller has already moved bytes to
+ * userspace. Report sk_err but leave it set so the next read
+ * surfaces it instead of a spurious EOF, otherwise sk_err is
+ * consumed via sock_error().
+ */
 static int
 tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
-		bool released)
+		bool released, bool has_copied)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
@@ -1376,8 +1381,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (!sk_psock_queue_empty(psock))
 			return 0;
 
-		if (sk->sk_err)
+		if (sk->sk_err) {
+			if (has_copied)
+				return -READ_ONCE(sk->sk_err);
 			return sock_error(sk);
+		}
 
 		if (ret < 0)
 			return ret;
@@ -1413,7 +1421,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	}
 
 	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
-		return tls_rx_rec_wait(sk, psock, nonblock, false);
+		return tls_rx_rec_wait(sk, psock, nonblock, false, has_copied);
 
 	return 1;
 }
@@ -2100,7 +2108,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		int to_decrypt, chunk;
 
 		err = tls_rx_rec_wait(sk, psock, flags & MSG_DONTWAIT,
-				      released);
+				      released, !!(decrypted + copied));
 		if (err <= 0) {
 			if (psock) {
 				chunk = sk_msg_recvmsg(sk, psock, msg, len,
@@ -2287,7 +2295,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		struct tls_decrypt_arg darg;
 
 		err = tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
-				      true);
+				      true, false);
 		if (err <= 0)
 			goto splice_read_end;
 
@@ -2373,7 +2381,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			struct tls_decrypt_arg darg;
 
-			err = tls_rx_rec_wait(sk, NULL, true, released);
+			err = tls_rx_rec_wait(sk, NULL, true, released, !!copied);
 			if (err <= 0)
 				goto read_sock_end;
 
-- 
2.54.0


