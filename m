Return-Path: <netdev+bounces-282512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAroM9V88ml2rwEAu9opvQ
	(envelope-from <netdev+bounces-282512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD349AB60
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE783302087B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C93B3BFF;
	Wed, 29 Apr 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTOq3p1A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291723B3BEC;
	Wed, 29 Apr 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499308; cv=none; b=PU3yHwu+ZGG25aeT6uOmQiFmILCRUbGcd0WKIsD86psm+TgRjq9mjzIHD5+0GbuGOY8Z6vEYJjktxC5QEiqo0kztmjnj2tPNtwAZLg6FcqcfAXckiNUq8bUS16ZhukR+cXRWTJbagytbwULY956IuMUG7Te1VKQy/08HCaEBmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499308; c=relaxed/simple;
	bh=IEg7kOq3fqVDKPcPKmWm/HmmlPAGWn/OBnnWPzDGx1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvFfkbhkFFq9k/gzV3FuA6lCIBE/kVpYxkGqxsSdLv+QJj4ql5inn2108X5+aD+GHJAqFoONEC1zzhA2xtVJ4mH5jjWS95PUX5nhhZqRoml05mxCSCMH51Xpth5RxzwXq5G50Yb65WahOlYX4oniv3BEm/KuGdmbU58igMj3QMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTOq3p1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E654AC2BCB3;
	Wed, 29 Apr 2026 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499307;
	bh=IEg7kOq3fqVDKPcPKmWm/HmmlPAGWn/OBnnWPzDGx1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mTOq3p1AUtu69A8a5UDzLA86cysN4/OPuofaX8J9V+D5ITiQWzckfiV4KbERWjMVE
	 GXi5UgsWp1xnGmxIHq9OAhZDZHjns2jIH5pQ14BvF1Lsu693p7xAl7/Y6KPKT/F2sb
	 baoYczMm48CnDxOdQn0+G7W38K5tJ4MuV4LQYyHBudxKvO6BifEY30U8OfiIYGAgNS
	 qAv8EjHAF23onMWM3PhDg9kHLGrb4i1wlKaruuWmrBp8YGxu+jLTwd6OhVSi1F8YSA
	 rfiqu/1MIlU/F6jZkUcgQ0C23/KAc/4V4p73iEjRZ8h305FGD3Hnw4dvfJ4+Sn0Xmb
	 U6d088dr7RU1w==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 17:48:11 -0400
Subject: [PATCH net-next v9 4/5] tls: Suppress spurious saved_data_ready on
 all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-tls-read-sock-v9-4-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10096;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ZV/+FbAqRcQbxVx7gm0c7/UloL/24G3trFu+KkopkDU=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGnyfKajAsTg3Tk3qUyhzNrDrtMC7V5Cb61kKn0vmW7QDGnLZ
 IkCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJp8nymAAoJEDNqszNvZn+X+PkP/jfv
 Gp6pRcTyHxAACYZv1OJqASqMxvS68T1JhZbDKXYjImfAk1v7pw7iT278PRv6VAB160xRb08PZE6
 xtT5c1y/fGcscMhsricLUq08TabUU1ZW6n4ghGUFo50qmgOWCd6cmjirfgMh5WzU3seVAXHpmUM
 idQFYL/Kon1FbkzRRJFcukt3QWR9rG2TNF9JeKN0klWTJpzAqvCVX87c3qCiV0ppYHBt7XDghIA
 s7W1S6sdIFi7G1vlI54NElXliid0nVRWsaPP153B7usygPSX/I5LZDvZinbIFp5cemDjwzjvlgf
 pwAUonbWFw+ybxTwRTM//W6JkF/wKzx2PkVeUoLddsbWgeswbm66Dx7hUZkqYcvtpDh1hZX91V3
 OE5sKXjAKgRoBL8pa+Ir0HLpKeLYtKwwLzGyI/xf/fyq3BzPFjQZG4IvPYHOuPMrjxJYlIbSUOJ
 GRLrrCr2/Mz3FwAHXPD4udwPA7phuRxU6IXrgJQ9iixx6TsAixkY3XCTKXLCguFrxWMLpzWnzUK
 ae1TnE3DVrbNnuppyf1a0XDv2eROk5RMsgUsQf+ojbdlEjpCiqnLOKS0l1wKDHKzdoN4+cLxkmS
 KYdXeoOlpr7XHaYLFlRQtBJpQsVHIx1M0vTKOjnL/BmMPdEhRFkS9SrWf1SpxJiZsaMMs7NP3+V
 AA0DW
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 69FD349AB60
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
	TAGGED_FROM(0.00)[bounces-282512-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
splice_read), deferring the consumer notification to
each path's exit point. Factor tls_rx_msg_ready() out
of tls_strp_read_sock(), and add a @wake parameter to
tls_strp_check_rcv() so callers can parse queued data
without notifying. tls_strp_check_rcv() retains its
no-op-on-msg_ready semantics, so the BH and worker
notification paths fire saved_data_ready() at most once
per parsed record.

The exit points then invoke tls_rx_msg_ready() once,
covering records the inline parse loop left behind for
a subsequent reader. To keep that final notification
idempotent against records BH or the worker has already
announced, tls_strparser gains a msg_announced bit:
tls_rx_msg_ready() sets it when firing saved_data_ready();
the bit is cleared whenever the parsed record is wiped,
by tls_strp_msg_release() on consumption or by
tls_strp_msg_load() when the lower socket loses bytes
from under the parse. A second call for the same parsed
record, as happens when recvmsg() satisfies the request
from ctx->rx_list without touching the strparser, is then
a no-op.

With no remaining callers, tls_strp_msg_done() and its
wrapper tls_rx_rec_done() are removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/tls.h  |  4 ++++
 net/tls/tls.h      |  3 +--
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 29 ++++++++++++++++++-----------
 net/tls/tls_sw.c   | 38 +++++++++++++++++++++++++++++++-------
 5 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..b5c00a93f6ba 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -111,10 +111,14 @@ struct tls_sw_context_tx {
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
 
 	bool msg_ready;
 
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
index a7648ebde162..bf88fad58b9b 100644
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
@@ -539,18 +539,30 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 		return tls_strp_read_copy(strp, false);
 
 	WRITE_ONCE(strp->msg_ready, 1);
-	tls_rx_msg_ready(strp);
 
 	return 0;
 }
 
-void tls_strp_check_rcv(struct tls_strparser *strp)
+/**
+ * tls_strp_check_rcv - parse queued data and optionally notify
+ * @strp: TLS stream parser instance
+ * @wake: if true, fire consumer notification when a record is newly
+ *        parsed by this call
+ *
+ * Returns immediately when a record is already ready; the wake fires
+ * only on transitions from no-record to record-ready. Callers that
+ * need to notify a waiter about a record parsed by another path
+ * should invoke tls_rx_msg_ready() directly.
+ */
+void tls_strp_check_rcv(struct tls_strparser *strp, bool wake)
 {
 	if (unlikely(strp->stopped) || strp->msg_ready)
 		return;
 
 	if (tls_strp_read_sock(strp) == -ENOMEM)
 		queue_work(tls_strp_wq, &strp->work);
+	else if (wake && strp->msg_ready)
+		tls_rx_msg_ready(strp);
 }
 
 /* Lower sock lock held */
@@ -568,7 +580,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 		return;
 	}
 
-	tls_strp_check_rcv(strp);
+	tls_strp_check_rcv(strp, true);
 }
 
 static void tls_strp_work(struct work_struct *w)
@@ -577,7 +589,7 @@ static void tls_strp_work(struct work_struct *w)
 		container_of(w, struct tls_strparser, work);
 
 	lock_sock(strp->sk);
-	tls_strp_check_rcv(strp);
+	tls_strp_check_rcv(strp, true);
 	release_sock(strp->sk);
 }
 
@@ -600,15 +612,10 @@ void tls_strp_msg_release(struct tls_strparser *strp)
 		tls_strp_flush_anchor_copy(strp);
 
 	WRITE_ONCE(strp->msg_ready, 0);
+	strp->msg_announced = 0;
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
index c58d3b0b0a8a..cbb068266bab 100644
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
@@ -1869,9 +1873,17 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
-static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
+/* Parse any data left in the lower socket and hand off a single
+ * notification to the next reader. tls_rx_msg_ready() is a no-op
+ * when the current record has already been announced, so paths
+ * that drained ctx->rx_list without touching the strparser do
+ * not re-fire saved_data_ready() for a record BH or the worker
+ * already announced.
+ */
+static void tls_rx_handoff(struct tls_sw_context_rx *ctx)
 {
-	tls_strp_msg_done(&ctx->strp);
+	tls_strp_check_rcv(&ctx->strp, false);
+	tls_rx_msg_ready(&ctx->strp);
 }
 
 /* This function traverses the rx_list in tls receive context to copies the
@@ -2152,7 +2164,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
 		if (err <= 0) {
 			DEBUG_NET_WARN_ON_ONCE(darg.zc);
-			tls_rx_rec_done(ctx);
+			tls_strp_msg_release(&ctx->strp);
 put_on_rx_list_err:
 			__skb_queue_tail(&ctx->rx_list, darg.skb);
 			goto recv_end;
@@ -2166,7 +2178,8 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* TLS 1.3 may have updated the length by more than overhead */
 		rxm = strp_msg(darg.skb);
 		chunk = rxm->full_len;
-		tls_rx_rec_done(ctx);
+		tls_strp_msg_release(&ctx->strp);
+		tls_strp_check_rcv(&ctx->strp, false);
 
 		if (!darg.zc) {
 			bool partially_consumed = chunk > len;
@@ -2260,6 +2273,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	copied += decrypted;
 
 end:
+	tls_rx_handoff(ctx);
 	tls_rx_reader_unlock(sk, ctx);
 	if (psock)
 		sk_psock_put(sk, psock);
@@ -2300,7 +2314,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		if (err < 0)
 			goto splice_read_end;
 
-		tls_rx_rec_done(ctx);
+		tls_strp_msg_release(&ctx->strp);
 		skb = darg.skb;
 	}
 
@@ -2327,6 +2341,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	consume_skb(skb);
 
 splice_read_end:
+	tls_rx_handoff(ctx);
 	tls_rx_reader_unlock(sk, ctx);
 	return copied ? : err;
 
@@ -2392,7 +2407,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
-			tls_rx_rec_done(ctx);
+			tls_strp_msg_release(&ctx->strp);
 		}
 
 		/* read_sock does not support reading control messages */
@@ -2420,6 +2435,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	tls_rx_handoff(ctx);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
 
@@ -2504,10 +2520,18 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	return ret;
 }
 
+/* Fire saved_data_ready() at most once per parsed record.
+ * msg_announced is cleared by tls_strp_msg_release() when the
+ * current record is consumed, arming the next announcement.
+ */
 void tls_rx_msg_ready(struct tls_strparser *strp)
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
2.53.0


