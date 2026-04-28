Return-Path: <netdev+bounces-281884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMb4NFrB8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666B7486C21
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A6BE33A230C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581046AF1D;
	Tue, 28 Apr 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1T0iduZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADF46AF18;
	Tue, 28 Apr 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383071; cv=none; b=FLNMjLAgqJeBVcVCjziw2AWAWt61DkS2YzDRwyqae/5GON1KnNebXwQILYBlIKAYWfeUNtMFWpx+p2BgOsQ6q/GtmbB1/AFNgpNBAhOi+ZRg8rsNNGSfP7eZWod9e7dA1/RSiaOEnfB01c+hdH8JABaTRUIPa4/NFe4z/TiG9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383071; c=relaxed/simple;
	bh=reYoL+GJnltkOGFaZTq95vOyHBZlIHgvtiTp7r8YeZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bovkCb5tyOF5aShzhiZ3HHRIGhx3xrPBJw+BXnKnTbcvKtdsTXQGNsGDrX9UDkTHPASfvSoMh0PVGc6xuYp/hxsuaDuKimacy9V0vq1htyfi2jlI57EOHEGozbhJz6tjvBo2OqgxEBdlLQHOKzU7bBlZwOFSiWpKK0+fN5gki9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1T0iduZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F1FC2BCAF;
	Tue, 28 Apr 2026 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383071;
	bh=reYoL+GJnltkOGFaZTq95vOyHBZlIHgvtiTp7r8YeZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F1T0iduZ5hz7hB8LGc7AJXBp3UMscFbffh6FLcAQQ4wEXYr7YYMujLmyJsEAO09vP
	 95ucgtDP0TSAETk9G/WlWZBUIys4fvgGpBdWH+YduzlDIzsACswPuZq7/2aDtz1U7x
	 VHa3yW9SKKC3toHUSvrFQkUFTFhmHlZ57QHhXrNhITzyTtoZutqtHq3/FiOqevSFHa
	 cfyU7iZfrVc5c2zr/bPdblFVlqprQ5gTsnAbXCeHpEQcMk7/+aTH7/AC5OfTbglmVB
	 YE+xxxuaexFfsjC199Yr0cFvh4MlMZ5o796bkcrtz56lNaj+/ll7jsT1v3qcvrGfc5
	 bnqiGScuUSjKw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 28 Apr 2026 09:30:49 -0400
Subject: [PATCH net-next v8 4/5] tls: Suppress spurious saved_data_ready on
 all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tls-read-sock-v8-4-85f96c7df24c@oracle.com>
References: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
In-Reply-To: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7564;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=PX7n6bTHv8KrqZMRl02j+1+hnORPmC4PSU+R/CC8IJ4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8LabaReiSrami/Cj9WsvCErcn7avN14cGXrWJ
 YRrYOf/Fs+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafC2mwAKCRAzarMzb2Z/
 l3izEACvohg62pkk6hc717GlTZxwz53JWUW/H8brxYmdi+pwS6be3uLL36TuSywAuY4/z+ek262
 hAQwHlxdYZTN5bYNGqvIb2R9iSd4ce5Yxw/sqZHtf649g1DyWvA4+w/DNQQ1vvkqGuQt7ml7LuR
 ijDLnG9SWYKGgYKVFjQom2OtnbjFXHdH7hEJLQs+sgkhhJenEmMbL6yxEOQBIHCsweYbkP4PJCV
 hn0dl22V7naiEiQ702fd6Jk/wXJCkUV3JzkXWeVRWEYX7JirtSeWJ5jPJQe8LbWuDnwyibVl5L9
 aebnRZfkrVbNuikwUHkXa72ycw1Jen8DbG+XhMCBBsX4VfysjX2W1/9i3VdqAeiS7gx5q0+DmtX
 P2FTcGmIIsLEK5vTvnCPBxeDUmgir0nTSbf7c8thUZzfWr/W7N+XfuacNwTV5GK74/DHw8x7zkJ
 jDOiErcn3dUGPbSvChOSj3c98CGqpNAnwDE41iGgtc78jvRYYrNS+hYcIu59/ACGmARX+kqzx3m
 LBLaT0FE+cmhpg7OEv4b3wCze1imb5qtIgwhGCnq+mtM/cxtrxOzvSrPkslD0/CbRLA6EiTyh58
 CP9bIhJOL79LrUZ1sUIUy92aI8UmN5JrJGuXtErQ81zA8ZuWfsFAUyUt/INyMSdvkvVNIjjGIgb
 zh4ugSDy7uE9zKQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 666B7486C21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281884-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,oracle.com:mid,oracle.com:email,wdc.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Each record release via tls_strp_msg_done() triggers
tls_strp_check_rcv(), which calls tls_rx_msg_ready() and
fires saved_data_ready(). During a multi-record receive,
the first N-1 wakeups are pure overhead: the caller is
already running and will pick up subsequent records on
the next loop iteration. On the splice_read path the
per-record wakeup is similarly unnecessary because the
caller still holds the socket lock.

Replace tls_strp_msg_done() with tls_strp_msg_release()
in all three receive paths (read_sock, recvmsg,
splice_read), deferring the tls_strp_check_rcv() call
to each path's exit point. Factor tls_rx_msg_ready()
out of tls_strp_read_sock() so that parsing a record
no longer fires the callback directly, and add a @wake
parameter to tls_strp_check_rcv() so callers can parse
queued data without notifying.

With no remaining callers, tls_strp_msg_done() and its
wrapper tls_rx_rec_done() are removed.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  3 +--
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 35 +++++++++++++++++++++--------------
 net/tls/tls_sw.c   | 22 +++++++++++++++-------
 4 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index a97f1acef31d..f41dac6305f4 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -192,9 +192,8 @@ void tls_strp_stop(struct tls_strparser *strp);
 int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
-void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_check_rcv(struct tls_strparser *strp, bool wake);
 void tls_strp_msg_release(struct tls_strparser *strp);
-void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
 void tls_rx_msg_ready(struct tls_strparser *strp);
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
index a7648ebde162..b0b2ca92fa99 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -368,7 +368,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 		desc->count = 0;
 
 		WRITE_ONCE(strp->msg_ready, 1);
-		tls_rx_msg_ready(strp);
 	}
 
 	return ret;
@@ -539,18 +538,32 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 		return tls_strp_read_copy(strp, false);
 
 	WRITE_ONCE(strp->msg_ready, 1);
-	tls_rx_msg_ready(strp);
 
 	return 0;
 }
 
-void tls_strp_check_rcv(struct tls_strparser *strp)
+/**
+ * tls_strp_check_rcv - parse queued data and optionally notify
+ * @strp: TLS stream parser instance
+ * @wake: if true, fire consumer notification when a message is ready
+ *
+ * When @wake is false, queued data is parsed without consumer
+ * notification. A subsequent call with @wake set to true is
+ * required before the socket lock is released; otherwise queued
+ * data stalls until the next tls_strp_data_ready() event.
+ */
+void tls_strp_check_rcv(struct tls_strparser *strp, bool wake)
 {
-	if (unlikely(strp->stopped) || strp->msg_ready)
+	if (unlikely(strp->stopped))
 		return;
 
-	if (tls_strp_read_sock(strp) == -ENOMEM)
-		queue_work(tls_strp_wq, &strp->work);
+	if (!strp->msg_ready) {
+		if (tls_strp_read_sock(strp) == -ENOMEM)
+			queue_work(tls_strp_wq, &strp->work);
+	}
+
+	if (wake && strp->msg_ready)
+		tls_rx_msg_ready(strp);
 }
 
 /* Lower sock lock held */
@@ -568,7 +581,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 		return;
 	}
 
-	tls_strp_check_rcv(strp);
+	tls_strp_check_rcv(strp, true);
 }
 
 static void tls_strp_work(struct work_struct *w)
@@ -577,7 +590,7 @@ static void tls_strp_work(struct work_struct *w)
 		container_of(w, struct tls_strparser, work);
 
 	lock_sock(strp->sk);
-	tls_strp_check_rcv(strp);
+	tls_strp_check_rcv(strp, true);
 	release_sock(strp->sk);
 }
 
@@ -603,12 +616,6 @@ void tls_strp_msg_release(struct tls_strparser *strp)
 	memset(&strp->stm, 0, sizeof(strp->stm));
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
-{
-	tls_strp_msg_release(strp);
-	tls_strp_check_rcv(strp);
-}
-
 void tls_strp_stop(struct tls_strparser *strp)
 {
 	strp->stopped = 1;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 71fc72a1b878..a16f2954d393 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1383,7 +1383,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 			return ret;
 
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
-			tls_strp_check_rcv(&ctx->strp);
+			/* Defer notification to the exit point;
+			 * this thread will consume the record
+			 * directly.
+			 */
+			tls_strp_check_rcv(&ctx->strp, false);
 			if (tls_strp_msg_ready(ctx))
 				break;
 		}
@@ -1869,9 +1873,9 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
-static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
+static void tls_rx_rec_release(struct tls_sw_context_rx *ctx)
 {
-	tls_strp_msg_done(&ctx->strp);
+	tls_strp_msg_release(&ctx->strp);
 }
 
 /* This function traverses the rx_list in tls receive context to copies the
@@ -2152,7 +2156,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
 		if (err <= 0) {
 			DEBUG_NET_WARN_ON_ONCE(darg.zc);
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 put_on_rx_list_err:
 			__skb_queue_tail(&ctx->rx_list, darg.skb);
 			goto recv_end;
@@ -2166,7 +2170,8 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* TLS 1.3 may have updated the length by more than overhead */
 		rxm = strp_msg(darg.skb);
 		chunk = rxm->full_len;
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
+		tls_strp_check_rcv(&ctx->strp, false);
 
 		if (!darg.zc) {
 			bool partially_consumed = chunk > len;
@@ -2260,6 +2265,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	copied += decrypted;
 
 end:
+	tls_strp_check_rcv(&ctx->strp, true);
 	tls_rx_reader_unlock(sk, ctx);
 	if (psock)
 		sk_psock_put(sk, psock);
@@ -2300,7 +2306,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		if (err < 0)
 			goto splice_read_end;
 
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
 		skb = darg.skb;
 	}
 
@@ -2327,6 +2333,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	consume_skb(skb);
 
 splice_read_end:
+	tls_strp_check_rcv(&ctx->strp, true);
 	tls_rx_reader_unlock(sk, ctx);
 	return copied ? : err;
 
@@ -2392,7 +2399,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 		}
 
 		/* read_sock does not support reading control messages */
@@ -2422,6 +2429,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	tls_strp_check_rcv(&ctx->strp, true);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
 

-- 
2.53.0


