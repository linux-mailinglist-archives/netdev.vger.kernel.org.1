Return-Path: <netdev+bounces-264552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBUmIWPyqWnhIQEAu9opvQ
	(envelope-from <netdev+bounces-264552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:15:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F003621872D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC71A30466A4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2E358395;
	Thu,  5 Mar 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1/Ekhjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC68358392;
	Thu,  5 Mar 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745251; cv=none; b=D76HRcj/Hh5oJ3+rL+WzSvaNtYFJlJ0cppJbJMSeLUlmewFBZK1WqS2DWIYDGou0xoH3PI9uFlyIx3iF6GoczWTytEtA/z0OI7ID3N4meI701XpIWEQMtHPJZckg/Rt4V+nsdYtsZ6jOU5uQMXO8xMVxZn+kLQs9MnXAncVlz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745251; c=relaxed/simple;
	bh=G2si2a4uPSeblvsqqb2u2vfwddbGERoSWnfEwkw9Qm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMkTeqx1hX9KPtMdBXnlgq7Ycjxy/c5xnPdt1c4NcjhaTvadiynMzoIC61E3+TZvGpCCeCuZ2p1POLh24Uh996ClGwdlROvJiE63xSMLtz+X4ujf0OUmVdsLrJhM+kzg8NVXX43/xGzWkB5vCNMKVm3Iog1weVqPdq6lf63QliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1/Ekhjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918CFC19422;
	Thu,  5 Mar 2026 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745251;
	bh=G2si2a4uPSeblvsqqb2u2vfwddbGERoSWnfEwkw9Qm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1/EkhjlNJHBU8J+U+CL4uG6hkf1tp9Fp9rSTGfcTWYdaDNjRtB3uHIiwGISKllRd
	 x6Ojg4CsNEcBsELeL+oD0IIthP32jSaLGXKl/bI66vouuaY2ud1L1YG6CKzOuYEBO2
	 KWaaGTEhQUO1qi0gZOvNtZhTzeW8LHDrRXtXqGIMhDJ+HRlX6wLtDeEai18VNplpCG
	 MWE7BfoIjlgKBbdMimGPj4To9dBpsIk3P5H1akbZ0z2bpHBN3kjCK5Vsi4aipfMbwF
	 qABOuImDdh3cdoZWskYmxxLbn1ea0/2lhvqse0M26VpPZ6eV8XplTNDZ4yYQyd+T9I
	 d3rKrYg3pVZ5g==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v1 6/6] tls: Enable batch async decryption in read_sock
Date: Thu,  5 Mar 2026 16:14:02 -0500
Message-ID: <20260305211402.39408-7-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305211402.39408-1-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F003621872D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264552-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

tls_sw_read_sock() decrypts one TLS record at a time, blocking until
each AEAD operation completes before proceeding. Hardware async
crypto engines depend on pipelining multiple operations to achieve
full throughput, and the one-at-a-time model prevents that. Kernel
consumers such as NVMe-TCP and NFSD (when using TLS) are therefore
unable to benefit from hardware offload.

When ctx->async_capable is true, the submit phase now loops up to
TLS_READ_SOCK_BATCH (16) records. The first record waits via
tls_rx_rec_wait(); subsequent iterations use tls_strp_msg_ready()
and tls_strp_check_rcv() to collect records already queued on the
socket without blocking. Each record is submitted with darg.async
set, and all resulting skbs are appended to rx_list.

After the submit loop, a single tls_decrypt_async_wait() collects
all pending AEAD completions before the deliver phase passes
cleartext records to the consumer. The batch bound of 16 limits
concurrent memory consumption to 16 cleartext skbs plus their AEAD
contexts. If async_capable is false, the loop exits after one
record and the async wait is skipped, preserving prior behavior.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 81 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 0e72a74ab1ee..d5b9ee7aca57 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2332,6 +2332,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	goto splice_read_end;
 }
 
+#define TLS_READ_SOCK_BATCH	16
+
 int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		     sk_read_actor_t read_actor)
 {
@@ -2343,6 +2345,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
+	bool async = false;
 	struct tls_msg *tlm;
 	ssize_t copied = 0;
 	ssize_t decrypted;
@@ -2365,33 +2368,71 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	decrypted = 0;
 	for (;;) {
 		struct tls_decrypt_arg darg;
+		int nr_async = 0;
 
-		/* Phase 1: Submit -- decrypt one record onto rx_list.
+		/* Phase 1: Submit -- decrypt records onto rx_list.
 		 * Flush the backlog first so that segments that
 		 * arrived while the lock was held appear on
 		 * sk_receive_queue before tls_rx_rec_wait waits
 		 * for a new record.
 		 */
 		if (skb_queue_empty(&ctx->rx_list)) {
-			sk_flush_backlog(sk);
-			err = tls_rx_rec_wait(sk, NULL, true, released);
-			if (err <= 0)
-				goto read_sock_end;
+			while (nr_async < TLS_READ_SOCK_BATCH) {
+				if (nr_async == 0) {
+					sk_flush_backlog(sk);
+					err = tls_rx_rec_wait(sk, NULL,
+							      true,
+							      released);
+					if (err <= 0)
+						goto read_sock_end;
+				} else {
+					if (!tls_strp_msg_ready(ctx)) {
+						tls_strp_check_rcv_quiet(&ctx->strp);
+						if (!tls_strp_msg_ready(ctx))
+							break;
+					}
+					if (!tls_strp_msg_load(&ctx->strp,
+							       released))
+						break;
+				}
 
-			memset(&darg.inargs, 0, sizeof(darg.inargs));
+				memset(&darg.inargs, 0,
+				       sizeof(darg.inargs));
+				darg.async = ctx->async_capable;
 
-			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+				err = tls_rx_one_record(sk, NULL, &darg);
+				if (err < 0) {
+					tls_err_abort(sk, -EBADMSG);
+					goto read_sock_end;
+				}
+
+				async |= darg.async;
+				released = tls_read_flush_backlog(sk, prot,
+								  INT_MAX,
+								  0,
+								  decrypted,
+								  &flushed_at);
+				decrypted += strp_msg(darg.skb)->full_len;
+				tls_rx_rec_release(ctx);
+				__skb_queue_tail(&ctx->rx_list, darg.skb);
+				nr_async++;
+
+				if (!ctx->async_capable)
+					break;
+			}
+		}
+
+		/* Async wait -- collect pending AEAD completions */
+		if (async) {
+			int ret = tls_decrypt_async_wait(ctx);
+
+			__skb_queue_purge(&ctx->async_hold);
+			async = false;
+			if (ret) {
+				__skb_queue_purge(&ctx->rx_list);
+				err = ret;
 				goto read_sock_end;
 			}
-
-			released = tls_read_flush_backlog(sk, prot, INT_MAX,
-							  0, decrypted,
-							  &flushed_at);
-			decrypted += strp_msg(darg.skb)->full_len;
-			tls_rx_rec_release(ctx);
-			__skb_queue_tail(&ctx->rx_list, darg.skb);
 		}
 
 		/* Phase 2: Deliver -- drain rx_list to read_actor */
@@ -2429,6 +2470,14 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	if (async) {
+		int ret = tls_decrypt_async_wait(ctx);
+
+		__skb_queue_purge(&ctx->async_hold);
+		__skb_queue_purge(&ctx->rx_list);
+		if (ret && !err)
+			err = ret;
+	}
 	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
-- 
2.53.0


