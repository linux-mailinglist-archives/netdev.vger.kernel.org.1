Return-Path: <netdev+bounces-268648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCh4AuJvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:14:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C882ACC5D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 718E1309E7F9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738F3EC2F6;
	Tue, 17 Mar 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVZY3SHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345933EC2F5;
	Tue, 17 Mar 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759891; cv=none; b=QihbH+P5w+JX9PmkMtxF1EBbtkzv1eF9+y9jWIc65bjDNRYNSCWkys3IzISxgA9GHAKdmGIyXB39B0dzzePvfUbfXXqNEPM8eohnDVtb9VjnZE6zz/NGCsrJo0RE0b+9MjwcT6APTSb/fzoJThkJKJD4sLsBfNpoVwtZV+hmTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759891; c=relaxed/simple;
	bh=AYjofd40ABZnn3d71e/FYlXkO1dPBQYRbsgvmuSN/KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNqXMPcj9n36rVSdH7BXymlbt2nbW47JSd/Cf5Dnhgn/A/cu0nq7VyT24WgkGiWcnieAdiGpscKLJoJgc8BqbOzbZ8EjjdYiTTCi8lhsvCXwao6cMebdKEd83Zm/Ek4ZWk/JfO7cyGY460poWvw7g7NlyYZyFciEAiYMm9agV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVZY3SHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01381C4CEF7;
	Tue, 17 Mar 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759890;
	bh=AYjofd40ABZnn3d71e/FYlXkO1dPBQYRbsgvmuSN/KE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qVZY3SHiFKZ6Q4DQL7+hiajbFcqK/W+jJ1GyXHKNr2dsgpzuybfTD24qQqJV/stwu
	 L2u29dqftCGep4gM+UQAzT7ykvndP9fg4eE040ruN6AF1HDwmy1oR8YZGXPyx+rf2h
	 v04LR9e+FWNDgZ0tGn2KqG6//AJPfjUABhKfU0599Eder11dQAuLB6otyJYr5BFx3I
	 Y+ozPbRcEWT9rF9ZRSF67Fg2pt8h3QsbgmWpJeSLuxlcWwZx8jCunVIouyJhduP+VY
	 I8jRI9dmOv//kd6uT8G4k4i48/2ZzriZpnrMjhhl8bMkN9egE8Yh94PUinzaPPS4u0
	 MBPbkGpg6UhbQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:21 -0400
Subject: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5556;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=hzeJNSNtrigJUVzQrDmdTj/zl4chhZwHBRUs2hem4N8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KKhDVgZUyeJIu2vMIBoI0kjleooTcp9Idm
 qM+L0hJPsOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 lwDVD/98ta2kPIZIuyik4nzv4cETmx5wcYs6x5Gr3kDmDGRm9HmeVukVX7QjlvgBkK+e0AWO9QF
 09ao0ja74MigIJ1+HarKDV+FxPzM9ksZRtRMLwWDmRHNwNrkoPeb4db3Zz4IE5t9zTiKmnSa5T3
 HbjMhkrGCzh1VUIK0ad++SLxrhkuvoZDDuLB5PY8/h9IIN5jEGUoxe6IB+FN1GhEH8cJZn1jT0u
 vouT/2sXJcaoG7/gA7fJulIja9hAeXJWn123ykd6CSLDGa98Q+0+aLu/4oIThT342dMGxrXQZqP
 ITMgqaR4OzLezRp+nxoD22rWwnbmx9/FQcJFwQ0KaI+x1YhiwGjjYaUIka9jKunfWOozr8uurc0
 ivps3Bgge3cy6NrrndWwu8gCPN61oeiaFHqfcbA2lVGHpsCIfxcuMKRMprCNTR7mbg8UfM2I8J3
 WeourmsrAZTRxLswWwMCvg/fPrv/QaI2+oUZM1VzaDm9UL3x80SAv/Srr1sHz/wUfi+WXuaavwC
 qTfEcn2QOIc6xG+NsJ8Fb9jGBAmupW8OqfB2jKSb3MvXpwxZimpJvWV66sH2xLWxFtpKRSpEY8l
 pTvPVPB952U7/lsAi75NGxkmQfD/u4YVeBFmM9Wt0twW/XqYvMBzL0iqCrVLJssbzPpANRbsez8
 BaAmpCXcT5I/9SQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268648-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36C882ACC5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 net/tls/tls_sw.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5ae7e0c026e4437fe442c3a77b0a6d9623816ce1..bc500ba7ce81eb33763c37a8b73473c42dc66044 100644
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
@@ -2340,6 +2346,13 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
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
@@ -2351,6 +2364,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
+	bool async = false;
 	struct tls_msg *tlm;
 	ssize_t copied = 0;
 	ssize_t decrypted;
@@ -2373,25 +2387,61 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	decrypted = 0;
 	for (;;) {
 		struct tls_decrypt_arg darg;
+		int nr_async = 0;
 
-		/* Phase 1: Submit -- decrypt one record onto rx_list. */
+		/* Phase 1: Submit -- decrypt records onto rx_list. */
 		if (skb_queue_empty(&ctx->rx_list)) {
-			err = tls_rx_rec_wait(sk, NULL, true, released);
-			if (err <= 0)
+			while (nr_async < TLS_READ_SOCK_BATCH) {
+				if (nr_async == 0) {
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
+				err = tls_rx_one_record(sk, NULL, &darg);
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
-			err = tls_rx_one_record(sk, NULL, &darg);
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
@@ -2429,6 +2479,16 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


