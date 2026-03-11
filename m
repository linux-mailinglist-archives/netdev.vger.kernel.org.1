Return-Path: <netdev+bounces-266392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLB4FdG1sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBEC259B7E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDF8D30B46B6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDD32D0D4;
	Wed, 11 Mar 2026 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kETbLBSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7231E83A;
	Wed, 11 Mar 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188407; cv=none; b=jLeLO2GHTM3vz0Ncvcr/VqQvckgl0jXsXvPt4LPxKOFS9T7l/N/yi1SzRzYPlxZUXnEMKpsI9fPrQD9wGT2Cmbe3eXP3GfdluPy5TaRspB/PE8ygOp3s9Uj4+6Zyl533v94yhRHYO0jD0xTtGPk8otXXMxN2iXobnQpHjRJJq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188407; c=relaxed/simple;
	bh=1LZZbq0+cSxFvf8KzrdAgm9SfNlqLHeKWtCA6Qu4oys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0uaZPTPEf/cCE7XFZXwkQpSx0k0UvE/+hpSlkY1E/t5hxpOpWvUXl7nL3PwL6WfbrXVIctPuE/Zk622iaUTJ4frMcdvfqvQtrwSb19f595DrcWwwF0NkdXxwcYOzOn9fdnKmTQifAe/iPxytocKf5FP0z+lnT+/aFTf1eJFFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kETbLBSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425B8C19423;
	Wed, 11 Mar 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188406;
	bh=1LZZbq0+cSxFvf8KzrdAgm9SfNlqLHeKWtCA6Qu4oys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kETbLBSY15xk9MliFfg/U1SodNwgBFXjiuyHuDHRxex0ueX4tDnM2GaUs3/snQwoN
	 /DGrE0190KjEyF0NO1oY2VE4zvkgg1ZLGpQkTCv9PLkqVTyO84YNRuWiMU+lA8m1OB
	 J5HfMkb7yvCU/Htaa5F/HD2pw9SHGcPDSNhgT5HR1SVGHFizOcrTQeSEGk3WSMyoy+
	 1trye1wM4CR6nXBt5NyYUySNtRv3m0578s+XWelQzwrGluzGNc8dVyuyxC4G8hiNoG
	 FmbwIKK+1KQZKKZOXdi3djI+QNSSMHYKmmcjSckjMFzbH5brCkF9rwvl0D6tWpxdHK
	 YaXnaORk5++Sw==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 8/8] tls: Enable batch async decryption in read_sock
Date: Tue, 10 Mar 2026 20:19:52 -0400
Message-ID: <20260311001952.57059-9-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311001952.57059-1-cel@kernel.org>
References: <20260311001952.57059-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDBEC259B7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266392-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,suse.de:email]
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

After the submit loop, a single tls_decrypt_async_drain() collects
all pending AEAD completions before the deliver phase passes
cleartext records to the consumer. The batch bound of 16 limits
concurrent memory consumption to 16 cleartext skbs plus their AEAD
contexts. If async_capable is false, the loop exits after one
record and the async wait is skipped, preserving prior behavior.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 95 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 17 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 535c856d64e0..0e2b7d285d06 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -261,6 +261,12 @@ static int tls_decrypt_async_drain(struct tls_sw_context_rx *ctx)
 	return ret;
 }
 
+/* Submit an AEAD decrypt request.  On success with darg->async set,
+ * the caller must not touch aead_req; the completion handler frees
+ * it.  Every error return clears darg->async and guarantees no
+ * in-flight AEAD operation remains -- callers rely on this to
+ * safely free aead_req and to skip async drain on error paths.
+ */
 static int tls_do_decryption(struct sock *sk,
 			     struct scatterlist *sgin,
 			     struct scatterlist *sgout,
@@ -2347,6 +2353,13 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	goto splice_read_end;
 }
 
+/* Bound on concurrent async AEAD submissions per read_sock
+ * call.  Chosen to fill typical hardware crypto pipelines
+ * without excessive memory consumption (each in-flight record
+ * holds one cleartext skb plus its AEAD request context).
+ */
+#define TLS_READ_SOCK_BATCH	16
+
 int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		     sk_read_actor_t read_actor)
 {
@@ -2358,6 +2371,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
+	bool async = false;
 	struct tls_msg *tlm;
 	ssize_t copied = 0;
 	ssize_t decrypted;
@@ -2380,31 +2394,68 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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
+
+				memset(&darg.inargs, 0, sizeof(darg.inargs));
+				darg.async = ctx->async_capable;
+
+				err = tls_rx_decrypt_record(sk, NULL,
+							    &darg);
+				if (err < 0)
+					goto read_sock_end;
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
+			int ret = tls_decrypt_async_drain(ctx);
+
+			async = false;
+			if (ret) {
+				__skb_queue_purge(&ctx->rx_list);
+				err = ret;
 				goto read_sock_end;
-
-			memset(&darg.inargs, 0, sizeof(darg.inargs));
-
-			err = tls_rx_decrypt_record(sk, NULL, &darg);
-			if (err < 0)
-				goto read_sock_end;
-
-			released = tls_read_flush_backlog(sk, prot, INT_MAX,
-							  0, decrypted,
-							  &flushed_at);
-			decrypted += strp_msg(darg.skb)->full_len;
-			tls_rx_rec_release(ctx);
-			__skb_queue_tail(&ctx->rx_list, darg.skb);
+			}
 		}
 
 		/* Phase 2: Deliver -- drain rx_list to read_actor */
@@ -2442,6 +2493,16 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	if (async) {
+		int ret = tls_decrypt_async_drain(ctx);
+
+		__skb_queue_purge(&ctx->rx_list);
+		/* Preserve the error that triggered early exit;
+		 * a crypto drain error is secondary.
+		 */
+		if (ret && !err)
+			err = ret;
+	}
 	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
-- 
2.53.0


