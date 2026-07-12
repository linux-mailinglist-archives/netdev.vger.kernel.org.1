Return-Path: <netdev+bounces-306946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 546/MhOZU2qFcAMAu9opvQ
	(envelope-from <netdev+bounces-306946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D56744CFA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:39:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=DGNTVDUL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306946-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306946-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 161FE300C98B
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37739A7F6;
	Sun, 12 Jul 2026 13:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2401A6807;
	Sun, 12 Jul 2026 13:39:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863568; cv=none; b=mrti8cSBTjaIN3LTHqnHmWN018XKk+2z04K4gCnjZVDTrIoza0s31c/quQG0TEUWKDfiAWMa+gcAfEy6LS4OzWhDyBtaKACiNQZ8vaVKt4K3tVxF/+0lma3OfCbakqe3rb/9cOKhhs5nVuVKE3avCjiqfTwSw+tHuUr+bWdReaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863568; c=relaxed/simple;
	bh=W6UW1PTPZxlptu0er6TLUY3G/lbgIGf2Pt7ofAYpQMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r1y3kOxFtbcVUhen4fdVU9sIm3khnHZhjsTTOpoH8IfTJIbhwdF9iB873psEApKxreGWcSyinOxJAtgymC7DydaCTO6LtqaZgOam+JqWOSsYqoG9eT0YrkD2k//twY2zWuxW7XUEtd06dhWpmKs1gbhCOq8I356EqmlWPQOT7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGNTVDUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69265C2BCB7;
	Sun, 12 Jul 2026 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783863568;
	bh=W6UW1PTPZxlptu0er6TLUY3G/lbgIGf2Pt7ofAYpQMM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DGNTVDULcs80Ua8gTIUp0YwTDe2y14WDBQqJwJLx4WjgyTJzP330kLjRzdPR6GI3K
	 Df9LWx4b+6UqHW4fcD67fx4WNTYu/VUiXRQibPZ8szCWRv/ZgouKlg7cCvrUgnaE5p
	 7K4A32FFGz/5llvyN6r5pXqovXag16+N2/CYONkch5tGB2+OmTlwBhrtVbYcQXXPcg
	 SRSsdOpcJb9nFIYJnwzcWJK/5EP7pBe+3bWL6d3NXu8mE1on5jaCWp0+fllSrpDVjh
	 BVQ09bcVehazAwTqbIrDPJdn6diYkZ8UYrrgo7lcYjXOWa0i1ixAgtRK8oDyY6bsEe
	 uNJoJpeolaqSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55742C43458;
	Sun, 12 Jul 2026 13:39:28 +0000 (UTC)
From: Northernside via B4 Relay <devnull+git.northernsi.de@kernel.org>
Date: Sun, 12 Jul 2026 15:39:28 +0200
Subject: [PATCH RFC net-next] tls: sw: coalesce records in
 tls_sw_splice_read()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-tls-splice-coalesce-v1-1-03e073c96719@northernsi.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFrxJm7UATaQW3ggdwW1ykk6mOhLRko
 hRK796ou//4vLeCchZWOJsVMn9EZUoV7MEAPX16MEqoDK5xXXOyDktU1DkKMdLkI2sdIdghtKP
 v3JGgmnPmUZZftYfb9WISF0y8FLj/X30PL6byDcO27QtDcV6FAAAA
X-Change-ID: 20260712-tls-splice-coalesce-dd1bd5fa623c
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Northernside <git@northernsi.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783863567; l=6152;
 i=git@northernsi.de; s=20260712; h=from:subject:message-id;
 bh=owDZgaho1ntNrpexIaPlLSnhdvuDcEG4zwQ0wTkpsxA=;
 b=qxNlMZ9xjsK0IzbT0BZc8hCiDKCzcAquUoZwFjLbV7WUeKyUPF2yozsXJybkEWU/MeFjk/lhU
 jFD8M/yE/1sA6t3hni5tkO5Cl5h162AAG2dKN2EplhZssuiZo0prRYQ
X-Developer-Key: i=git@northernsi.de; a=ed25519;
 pk=BMN+nWVka4U/ivwhMm3TeWWdxHstESv4QrGNobOqNaw=
X-Endpoint-Received: by B4 Relay for git@northernsi.de/20260712 with
 auth_id=867
X-Original-From: Northernside <git@northernsi.de>
Reply-To: git@northernsi.de
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306946-lists,netdev=lfdr.de,git.northernsi.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:git@northernsi.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[git@northernsi.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29D56744CFA

From: Northernside <git@northernsi.de>

tls_sw_splice_read() currently returns a single TLS record per call.
It dequeues (or decrypts) one record, splices it into the pipe and
returns. Draining a stream therefore costs one splice() syscall per
~16KB record, unlike tls_sw_recvmsg() which already coalesces multiple
records into the caller's buffer in a single call.

With this splice_read coalesces the same way by looping over ready
records, splicing each into the pipe, until the requested length is
reached, the pipe cannot take another record or a non DATA record is
hit.

Blocking behaviour is deliberately preserved.
Only the first record may block:

 - data records after the first are fetched with a nonblocking wait
   so a short splice is returned rather than sleeping for more input

 - a further record is only started if it already fits in the pipe, so
   the loop never turns a short read into a blocking
   skb_splice_bits() where the original single record path would not
   have blocked

A non DATA record met mid batch is left on rx_list and returned on the
next call. The copied ?: err return masks the -EINVAL exactly as
tls_sw_recvmsg() does for mid batch errors. When it is the first
record the -EINVAL behaviour is unchanged.

Since the loop can decrypt many records under a single reader lock,
the socket backlog is flushed periodically between records via
tls_read_flush_backlog(), like tls_sw_recvmsg() and tls_sw_read_sock()
already do and the released state is fed back into the next
tls_rx_rec_wait() call. Waits after the first record pass has_copied
so a pending sk_err is preserved rather than consumed by a short
splice.

Measured on a single stream (TLS 1.3, AES-128-GCM, loopback, 16KB
records), draining an upload dropped from 64 splice syscalls per MiB
(one per record) to ~12/MiB and throughput rose from ~2.2 to
~2.8 GiB/s, reaching parity with what tls_sw_recvmsg() achieves on
the same workload.

read()/recvmsg() users should see no change. This only brings the
zerocopy splice path (e.g. a proxy splicing a TLS socket to a backend
fd) to parity.

Signed-off-by: Northernside <git@northernsi.de>
---
 net/tls/tls_sw.c | 101 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 32 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d4afc90fd796..8bc0361e3bf4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1986,8 +1986,11 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sock->sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct strp_msg *rxm = NULL;
 	struct sock *sk = sock->sk;
+	size_t flushed_at = 0;
+	bool released = true;
 	struct tls_msg *tlm;
 	struct sk_buff *skb;
 	ssize_t copied = 0;
@@ -1998,47 +2001,81 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (err < 0)
 		return err;
 
-	if (!skb_queue_empty(&ctx->rx_list)) {
-		skb = __skb_dequeue(&ctx->rx_list);
-	} else {
-		struct tls_decrypt_arg darg;
+	/* Coalesce successive DATA records into the pipe, the way
+	 * tls_sw_recvmsg() coalesces into the msg buffer, instead of
+	 * returning one record per call. Only the first record may block.
+	 */
+	while (copied < len) {
+		bool first = !copied;
 
-		err = tls_rx_rec_wait(sk, flags & SPLICE_F_NONBLOCK,
-				      true, false);
-		if (err <= 0)
-			goto splice_read_end;
+		if (!skb_queue_empty(&ctx->rx_list)) {
+			skb = __skb_dequeue(&ctx->rx_list);
+		} else {
+			struct tls_decrypt_arg darg;
 
-		memset(&darg.inargs, 0, sizeof(darg.inargs));
+			err = tls_rx_rec_wait(sk,
+					      first ? (flags & SPLICE_F_NONBLOCK) : true,
+					      released, !first);
+			if (err <= 0)
+				goto splice_read_end;
 
-		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0)
-			goto splice_read_end;
+			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-		tls_rx_rec_done(ctx);
-		skb = darg.skb;
-	}
+			err = tls_rx_one_record(sk, NULL, &darg);
+			if (err < 0)
+				goto splice_read_end;
 
-	rxm = strp_msg(skb);
-	tlm = tls_msg(skb);
+			released = tls_read_flush_backlog(sk, prot,
+							  len - copied, 0,
+							  copied, &flushed_at);
+			tls_rx_rec_done(ctx);
+			skb = darg.skb;
+		}
 
-	/* splice does not support reading control messages */
-	if (tlm->control != TLS_RECORD_TYPE_DATA) {
-		err = -EINVAL;
-		goto splice_requeue;
-	}
+		rxm = strp_msg(skb);
+		tlm = tls_msg(skb);
 
-	chunk = min_t(unsigned int, rxm->full_len, len);
-	copied = skb_splice_bits(skb, sk, rxm->offset, pipe, chunk, flags);
-	if (copied < 0)
-		goto splice_requeue;
+		/* splice does not support reading control messages
+		 * mid batch the record is left on rx_list for the next call
+		 */
+		if (tlm->control != TLS_RECORD_TYPE_DATA) {
+			err = -EINVAL;
+			goto splice_requeue;
+		}
 
-	if (copied < rxm->full_len) {
-		rxm->offset += copied;
-		rxm->full_len -= copied;
-		goto splice_requeue;
-	}
+		/* Records after the first must not block on pipe space,
+		 * stop if this one does not already fit
+		 */
+		if (!first) {
+			unsigned int need = DIV_ROUND_UP(rxm->full_len,
+							 PAGE_SIZE);
+
+			if (pipe_occupancy(pipe->head, pipe->tail) + need >
+			    pipe->max_usage) {
+				__skb_queue_head(&ctx->rx_list, skb);
+				goto splice_read_end;
+			}
+		}
+
+		chunk = min_t(unsigned int, rxm->full_len, len - copied);
+		chunk = skb_splice_bits(skb, sk, rxm->offset, pipe, chunk,
+					flags);
+		if (chunk < 0) {
+			err = chunk;
+			goto splice_requeue;
+		}
 
-	consume_skb(skb);
+		copied += chunk;
+
+		/* pipe full, requeue the remainder */
+		if (chunk < rxm->full_len) {
+			rxm->offset += chunk;
+			rxm->full_len -= chunk;
+			goto splice_requeue;
+		}
+
+		consume_skb(skb);
+	}
 
 splice_read_end:
 	tls_rx_reader_unlock(sk, ctx);

---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260712-tls-splice-coalesce-dd1bd5fa623c

Best regards,
--  
Northernside <git@northernsi.de>



