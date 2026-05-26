Return-Path: <netdev+bounces-291720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF0jCyyuFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F525D77C7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AC593051A5A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA83FFABB;
	Tue, 26 May 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFobtF6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCE3FFAA6;
	Tue, 26 May 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805312; cv=none; b=vBOKBubWt+cqUPpUqbKeY/Kt9ZBi0q9uBNYcPzSg+oiPfhJ/iDYJbiLyYBIrzZx86WjHBmXwjQB72hl/BOOxZ5iBnuqSVv798vpE+7jGidNYE7lEmIp6TIodT3A9Fj7xdPaog3KhYdTU7S92r+1XITWzQztmWZEUWWVKOxxUxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805312; c=relaxed/simple;
	bh=oLN0islIvx8HOT+q8imPuPz4PONie0WEXArDcL+b3v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lhv2gnWNYl9WIOOA+lYZso/VJaEaUObYgmmvSVR1C/jnsQQDd18V2iXbUYB6gJnKR3H+Q/OMssHqdtiB/bgZ92R5UVc1+KRPVVSDnRyocWv9PHwaMDFlM+F6trH4M7495ZSFQNOdS1WWOzMUg/zZDG7NFyKHixjGl0P52HWzbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFobtF6r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CE61F00A3C;
	Tue, 26 May 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805311;
	bh=KboX6ur7+8DW9Be3ton0o11iTvkJXx7g+9tE0TphMRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UFobtF6rhOwdRTKwjPUD2NAMcDjwUXP5uQtMFfK4qxpwtAWqyYYTM1tq5MN/hzRlL
	 VFTHVV7mcV8Au3zr9NrhKyVgcalINSNYvIbyxhvYfFWfMj5Nm7f8Qzw9oT+6aYZU1I
	 rmuHYe4qrz4VSOrLFRYMyum4X3dnaMRbxLsBURdumtiUE5sBm1ww8BSpFrKcvA1AGK
	 0TgTh4SORvMrKnRq7oP3H07qRg9SSDuoqoq0S3Wwcmzx92ljU8UhGjmc3Tz3/GY0Hp
	 e2UAvRmIvh7UMRyQ+IlOT+BIVuWwnaPSS7/ueQDj6A5wupNS+RGKugXuLXBJAoAsmp
	 kqMzZr3A0r8cQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 10:21:35 -0400
Subject: [PATCH net-next v11 5/6] tls: Suppress spurious saved_data_ready
 on all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tls-read-sock-v11-5-244fe1dc4abd@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
In-Reply-To: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=8303;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=EYYdojnVfOT+eIOow8L0l/m+zQgJCloKkEBRZfazR64=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFax5DsOyPAuHHZBaVhSZUYCHj1qsZplXpvXNO
 bhm/GFOtteJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWseQAKCRAzarMzb2Z/
 l0a/EACMk8lDm55dvvcdI0OvcLrvlofahG+TduJ7k2hSWcCjP1zbT04osP4ln+AJeNVtiR3GXws
 EyWZfZsgVd92zTUnmY9ECYE7kctkkOaV6UbYsbl+sxxey5yUY+zRqSpbJwecvpkEkd7lrfdZGwy
 UzdS8m2SUMSm67wB3+XW+Lj3HKRwFen1ha/ZNIe1zk7kJdcWd6fpf+YNKgzzR2vobtRMeh/LLNj
 Xawu8gmD43fjQ7clTEY7dWenX6cmy2xB5X/+CHmz0IwATBiWFe5pNweOzkcUvRHt3xgcw9goc9I
 Z5GcCo4wOvHpNt/gIF+rKTYm5LGQH8IhWwllLmC2Sh8mQzUZ3FKJCAcEqB6Gn7TVo0sS7PcHImr
 fHQgsHvw4vCrovfCTKwTux/XfFq7ZbhxN6K4eVQ0BBRlJeHEiRTJowKgOHfa7z/Hr4gzgqdkRNI
 DgeHXZGmsxNh6cattzKAU5Sp+zsIN10XqCsgcvXbu8lEM1OZOjMaskLskVnA4Ho3rgI9ELqJT+v
 t9+eX/pymoLvj6iyes1APk3CTX9GfiTCQavx5U/A8GsujrzXkCIl5o5OXldxw6v/386NuL71jXW
 UiTkrHRw13HLFzPTa+roCA1EkcZXXbnYLccEPawqFIedto7tkulqsFRLBpkX9vhJ/rZVoX4j1RK
 G1jtHDTkV/SgERg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291720-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: D3F525D77C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 798f2535ddf7..df4cdf11f784 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1401,7 +1401,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
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
@@ -1887,9 +1890,13 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
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
@@ -2044,6 +2051,12 @@ static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
 
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
@@ -2520,10 +2533,18 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
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


