Return-Path: <netdev+bounces-286858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG6uFaxlAmqZsQEAu9opvQ
	(envelope-from <netdev+bounces-286858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DEF517439
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A93CD300F7B4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424423624A4;
	Mon, 11 May 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHgbb2Ub"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDC35675D;
	Mon, 11 May 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541976; cv=none; b=s9gg9EwQP31MnKHKLWZxLtmsDqlM3m35Xnw11HwMxru7YhgjybthTsv05Cj/XTUSGJfbXkiX+GzXjpQwjK9+qdGe1ia5khSpJ8zqTNHdjzjlmqTUAdBYzZHrY3RtMohno7JaHag0br9BxAiY/FYV679ub6i19vYMaURkQxdEtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541976; c=relaxed/simple;
	bh=jbP8VbDBHOEAUKNDQ4VLb70zbxRbJtJU0XRB+iSBfFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LTQlCvSODU0foyj0ZXn+hxauxZQh/s7hgq+u1XGvnEPvlhzI0k0o9jKniHs2CEmbgaGqX+sXvb4DvJynnL55WlcU3un27IcH7KKup7jss8aH2Km5JsKS1IXnNdL+dwdkAnukPQcmuiMPNZVTyXyIwNWdW5l7OAVfHrza4ee7Kbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHgbb2Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEBCC2BCB0;
	Mon, 11 May 2026 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541976;
	bh=jbP8VbDBHOEAUKNDQ4VLb70zbxRbJtJU0XRB+iSBfFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHgbb2UbZn1Y9UrFd4FeK4E1GDe7lhZmRLeByqKg6vxWgZUz7Wz94Ec9604IIAFr6
	 XkN/h9yIdY9RG7Je4GnAHnnuuWQR0oG1ltWbr3YMfAgjaapNO0m52eADLjGLqc/uMc
	 wj8xpetdQhQ4j6finnKA9y2xEOPFj+osYA3cLTYvg3KbyQDdMUApbqgVDp1pydhwYF
	 FicU4qGpJlCv4hBxPQdeWNqZOYRExios/j0FWSmClJpwOlyyn49rFLNZqwecVb898J
	 wBtuzVwY0/4hXlm2wkCHcS9jZcP2rzNhp80CZGwAxQap9hVaY8rjm6/i/7tIySjsOO
	 vjnwLk1TXvP+A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:56 -0400
Subject: [PATCH net-next v10 5/7] tls: Suppress spurious saved_data_ready
 on all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-5-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=8303;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=IBgbzyUQOIH9nKa1co/ZCGNtiUDWb+gZpQyuSFJraFY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWSfMFQ8pJCNHzQydOQtfUN7fMAvXS0a9wze
 QCmTN0uEuGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkgAKCRAzarMzb2Z/
 l/XkD/wPRDtSHiyNZzEapWIhu4/QXX0IuqivKzd/3hN2N4qqLN29ZgJuSL6KMUtl47AsoVCCic/
 l93D0W4Z9LYTYDOlYvTPQ6ThSDKTbwpfSZ2FwZt/HX8K2VJgr4zxy6gXAuzFq2OW17ULd8zggnh
 kR71MFc6YiFegLuKuuOluTprOkagc2q2UrGoUP/7wqVhpt2yCkGtAUGoK8a++CKbcwIJT0jtjsl
 tNkKDXdqmhzV5MAX0D6kJHKzGEQLyZSSvMjV4F1ntD8Lzds7nuA3n6+tw2Cxf+Q1wFTM5G05B3Y
 BNZw9iJRQ9oC3/+gTM+gmDGq2S/lAxGBV/wV/4zvi6sg/dTlR4Z21OxLvJOhBTeVYcACNBVAQxY
 AqCLQmCZe+LSg48zOQAREx3CB5Lv2HWs4LZx/FzTDwrlaVYqGXuPfk6sQd671Jx8JK6SwBz3/YZ
 04vnSnCncak0Anisrxi3Shj6EDHjkGPJqtDND1v55fupDAbDwjpiuN36HSajsN+ckjUiUJbF5f8
 Yy0oMLBPO4GoPlR3ZAJb5bwfozrDVKB1dIda9Cgrg1A0ZgtLhE9hl/KfH5URXhWYFioZfx1iweR
 XtYF9mucKCs/6swG6cgLgLgY83fi/IOnB0bTk1xH420l7mLcBxRw3OqBavmc95gPHkBBIKZENV0
 c1NarcTJlZllMxg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 53DEF517439
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286858-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Each record release via tls_strp_msg_done() triggered
tls_strp_check_rcv(), which called tls_rx_msg_ready() and
fired saved_data_ready(). During a multi-record receive, the
first N-1 wakeups are pure overhead: the caller is already
running and will pick up subsequent records on the next loop
iteration. The recvmsg and splice_read paths share this waste.

Suppress per-record notifications and emit a single one on
reader exit. tls_rx_rec_done() releases the current record
and parses the next without announcing; tls_strp_check_rcv()
gains a bool announce parameter so callers can request the
quiet form. tls_rx_reader_release() fires the deferred
announce on exit through tls_rx_msg_maybe_announce(), an
idempotent helper that calls saved_data_ready() only when a
record is parsed and has not yet been announced.

To keep the final notification idempotent against records that
the BH or the worker has already announced, tls_strparser gains
a msg_announced bit. tls_rx_msg_maybe_announce() sets the bit
when firing saved_data_ready(); the bit is cleared whenever
the parsed record is wiped, by tls_strp_msg_consume() on
consumption or by tls_strp_msg_load() when the lower socket
loses bytes from under the parse. A second call for the same
parsed record -- as when recvmsg() satisfies the request from
ctx->rx_list without touching the strparser -- becomes a
no-op.

With no remaining callers, tls_strp_msg_done() is removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/tls.h  |  5 +++++
 net/tls/tls.h      |  5 ++---
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 23 ++++++++++++-----------
 net/tls/tls_sw.c   | 27 ++++++++++++++++++++++++---
 5 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..3811943288b3 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -111,11 +111,16 @@ struct tls_sw_context_tx {
 struct tls_strparser {
 	struct sock *sk;
 
+	/* Bitfield word and msg_ready are serialized by the lower
+	 * socket lock; BH and worker contexts both acquire it.
+	 */
 	u32 mark : 8;
 	u32 stopped : 1;
 	u32 copy_mode : 1;
 	u32 mixed_decrypted : 1;
 
+	u32 msg_announced : 1;
+
 	bool msg_ready;
 
 	struct strp_msg stm;
diff --git a/net/tls/tls.h b/net/tls/tls.h
index cb0091e03f41..60a37bdaaa25 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -193,12 +193,11 @@ void tls_strp_stop(struct tls_strparser *strp);
 int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
-void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_check_rcv(struct tls_strparser *strp, bool announce);
 void tls_strp_msg_consume(struct tls_strparser *strp);
-void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
-void tls_rx_msg_ready(struct tls_strparser *strp);
+void tls_rx_msg_maybe_announce(struct tls_strparser *strp);
 
 bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh);
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..c10a3fd7fc17 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -769,7 +769,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	} else {
 		struct tls_sw_context_rx *rx_ctx = tls_sw_ctx_rx(ctx);
 
-		tls_strp_check_rcv(&rx_ctx->strp);
+		tls_strp_check_rcv(&rx_ctx->strp, true);
 	}
 	return 0;
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index e7aaee6efe6e..61b10c697ecc 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -368,7 +368,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 		desc->count = 0;
 
 		WRITE_ONCE(strp->msg_ready, 1);
-		tls_rx_msg_ready(strp);
 	}
 
 	return ret;
@@ -492,6 +491,7 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	if (!strp->copy_mode && force_refresh) {
 		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
+			strp->msg_announced = 0;
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
 		}
@@ -539,18 +539,24 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 		return tls_strp_read_copy(strp, false);
 
 	WRITE_ONCE(strp->msg_ready, 1);
-	tls_rx_msg_ready(strp);
 
 	return 0;
 }
 
-void tls_strp_check_rcv(struct tls_strparser *strp)
+/* Parse queued data. When @announce is true and parsing produces a
+ * newly-ready record, fire the consumer notification. Callers that
+ * need to notify a waiter about a record parsed by another path
+ * should invoke tls_rx_msg_maybe_announce() directly.
+ */
+void tls_strp_check_rcv(struct tls_strparser *strp, bool announce)
 {
 	if (unlikely(strp->stopped) || strp->msg_ready)
 		return;
 
 	if (tls_strp_read_sock(strp) == -ENOMEM)
 		queue_work(tls_strp_wq, &strp->work);
+	else if (announce && strp->msg_ready)
+		tls_rx_msg_maybe_announce(strp);
 }
 
 /* Lower sock lock held */
@@ -568,7 +574,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 		return;
 	}
 
-	tls_strp_check_rcv(strp);
+	tls_strp_check_rcv(strp, true);
 }
 
 static void tls_strp_work(struct work_struct *w)
@@ -577,7 +583,7 @@ static void tls_strp_work(struct work_struct *w)
 		container_of(w, struct tls_strparser, work);
 
 	lock_sock(strp->sk);
-	tls_strp_check_rcv(strp);
+	tls_strp_check_rcv(strp, true);
 	release_sock(strp->sk);
 }
 
@@ -596,15 +602,10 @@ void tls_strp_msg_consume(struct tls_strparser *strp)
 		tls_strp_flush_anchor_copy(strp);
 
 	WRITE_ONCE(strp->msg_ready, 0);
+	strp->msg_announced = 0;
 	memset(&strp->stm, 0, sizeof(strp->stm));
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
-{
-	tls_strp_msg_consume(strp);
-	tls_strp_check_rcv(strp);
-}
-
 void tls_strp_stop(struct tls_strparser *strp)
 {
 	strp->stopped = 1;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 40cb0a92d88a..88d07199d5aa 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1383,7 +1383,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 			return ret;
 
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
-			tls_strp_check_rcv(&ctx->strp);
+			/* Defer notification to the exit point; this thread
+			 * will consume the record directly.
+			 */
+			tls_strp_check_rcv(&ctx->strp, false);
 			if (tls_strp_msg_ready(ctx))
 				break;
 		}
@@ -1869,9 +1872,13 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
+/* The deferred announce is fired once on reader exit by
+ * tls_rx_reader_release().
+ */
 static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
 {
-	tls_strp_msg_done(&ctx->strp);
+	tls_strp_msg_consume(&ctx->strp);
+	tls_strp_check_rcv(&ctx->strp, false);
 }
 
 /* This function traverses the rx_list in tls receive context to copies the
@@ -2026,6 +2033,12 @@ static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
 
 static void tls_rx_reader_release(struct sock *sk, struct tls_sw_context_rx *ctx)
 {
+	/* Fire any deferred announce once per reader so that a record
+	 * parsed but not yet announced becomes visible to the next
+	 * reader. The call is idempotent through msg_announced.
+	 */
+	tls_rx_msg_maybe_announce(&ctx->strp);
+
 	if (unlikely(ctx->reader_contended)) {
 		if (wq_has_sleeper(&ctx->wq))
 			wake_up(&ctx->wq);
@@ -2505,10 +2518,18 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	return ret;
 }
 
-void tls_rx_msg_ready(struct tls_strparser *strp)
+/* Fire saved_data_ready() at most once per parsed record. The
+ * msg_announced bit is cleared by tls_strp_msg_consume() when the
+ * record is consumed, arming the next announcement.
+ */
+void tls_rx_msg_maybe_announce(struct tls_strparser *strp)
 {
 	struct tls_sw_context_rx *ctx;
 
+	if (!READ_ONCE(strp->msg_ready) || strp->msg_announced)
+		return;
+	strp->msg_announced = 1;
+
 	ctx = container_of(strp, struct tls_sw_context_rx, strp);
 	ctx->saved_data_ready(strp->sk);
 }

-- 
2.54.0


