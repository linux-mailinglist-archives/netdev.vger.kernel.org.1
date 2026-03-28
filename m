Return-Path: <netdev+bounces-272779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEnvGFbxx2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:18:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B649B34ED79
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4585304C138
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27D346E6C;
	Sat, 28 Mar 2026 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8TfgxwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFC19F137;
	Sat, 28 Mar 2026 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711045; cv=none; b=q3SgdfrlsHw9WFiExALkrD09UV7E2Xn7DEef3sMYef6KO0F7LKv8Ji5kE+MH4cKeGM/tNMaXW6ERERJmY9San5le/IeZCD8aRIoYGteHVaVKRo4I9ngJP2hWdiMKxBcNAfP3NF1cK9vXctdwRI04QqnF0FYFhEtdea6q3oQm238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711045; c=relaxed/simple;
	bh=DG/GZ8WuvTeRAQ2BZeJTjjHoP1q2zHBqZB7be7iA5nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8PSCloKL4/WKzE3Lup535IavmCGVzbD21jns+SF+AL2VEKAwZ/CxDb7KOATAWWXFSfP3gVYMOYYNz4hVbyg3E/p9OYvHYhLNz8s0POQDYFJDohFr4sajg8AjYkI+CCMZA0SNUergBl5PWqVnwG1nusZcuV2CPj2x8sVzQMZUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8TfgxwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAF7C4CEF7;
	Sat, 28 Mar 2026 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774711045;
	bh=DG/GZ8WuvTeRAQ2BZeJTjjHoP1q2zHBqZB7be7iA5nY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u8TfgxwPofLsdyGsRG3MJS20Mxe7feqtWkS1NIEN+Rp8cRwa8OzxXWJbYepZLwBk6
	 fBYP/IoNnDOAvCZeMwmXlg9HGUqoVwUge7U0WbRN3HBidgHBg9cL8sM+xntTPUCyYo
	 oOMADCgG/E7AABSbmGZU0P3jWboTzELj9WMxRstFARt88OvvVdPc4x3JQ1EAJjfNOC
	 Ym13ArCz4dy0C6TiDsK8xUeqbUhz37JL2KKV2xJEjBRJrYteAqNvHrcdi219dUoUww
	 SeL8S8enNOkLhbD3cVU9/wZ5gG1F/+NQgsjhotF9jrQfD2S6uFzFSPfhyrYEMHtXbG
	 XFUTWh+ug1wCQ==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 28 Mar 2026 11:17:11 -0400
Subject: [PATCH net-next v7 4/5] tls: Suppress spurious saved_data_ready on
 all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-tls-read-sock-v7-4-15678415dfc1@oracle.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
In-Reply-To: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7564;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=p9UZ1x5xOk5RTPTSfWvn7mFdBHlIO7ihk8AyHHdsdPw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpx/EA+MoYxYs1YExGtC7YLgA3EEDq0rEdBWmhx
 mNaBHPQhNyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacfxAAAKCRAzarMzb2Z/
 l1vED/9jOcil20iG0GVwBoGK1pFyzRfx20G46J6F8LdQ679YQKai/H5kwqcTCoqIv5KBMUFuXm/
 Ye52NGRtwuhU0saHIRpyPc+Sq4UU7oGOrplj9UZNhyCgydIstt860Ldt2USvXkgVLzcsMXIr5t+
 4aHFT6P9C7oT/m1g5NKngdYxwPvq4QzxbEiLLPqnxmKvC673DmvnePDOc3FOYqeSLdG3JtQIXUX
 bJMXF4s9aC9WjEX5Q0hYXYII+2Bk/U2vDgz5ojYYdS2I2aVygrkBR0o5N5KRGhEBgJ/zHTzgJ9T
 AE9wRgiW8BiiEuR3MLqEtaf+c1kSaFmNPU6dmNfVyROXPs2+1bLxbqNTY285fA9WExs9e2OVmld
 d/dw9tWzcVgP4e0WLC/bjuVOzMeWf+xRUmifsWd/kqvJ1tJk3Gup/1chVLFHchCa0D+Sd0dhh6X
 oiJ0eRIMncd8wcFdBub4/AaXlyVOcmxqJcUsHzHMSOdaWw/UnfK2p+leCQMELvzLbX0PsZYKY2U
 WeoJ0P8jXKtVxlhAxrCzbmWCQnUA/9IwFxqd4vdvYBPwSHQofIrj4R2jA3x3UCklaGJOAyUcU9b
 lu7F20uNBMyBUO1NKc8C42TKZhftrHkuT2E6kg73eyv2YFcAeWPkaRbyp3E2BvFdlh3ExhsmlDg
 FEfPi6IAPaeI5uA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272779-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,oracle.com:email,oracle.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: B649B34ED79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 5fdd43a55f1e..8fb2f2a93846 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1373,7 +1373,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
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
@@ -1859,9 +1863,9 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
-static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
+static void tls_rx_rec_release(struct tls_sw_context_rx *ctx)
 {
-	tls_strp_msg_done(&ctx->strp);
+	tls_strp_msg_release(&ctx->strp);
 }
 
 /* This function traverses the rx_list in tls receive context to copies the
@@ -2142,7 +2146,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
 		if (err <= 0) {
 			DEBUG_NET_WARN_ON_ONCE(darg.zc);
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 put_on_rx_list_err:
 			__skb_queue_tail(&ctx->rx_list, darg.skb);
 			goto recv_end;
@@ -2156,7 +2160,8 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* TLS 1.3 may have updated the length by more than overhead */
 		rxm = strp_msg(darg.skb);
 		chunk = rxm->full_len;
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
+		tls_strp_check_rcv(&ctx->strp, false);
 
 		if (!darg.zc) {
 			bool partially_consumed = chunk > len;
@@ -2250,6 +2255,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	copied += decrypted;
 
 end:
+	tls_strp_check_rcv(&ctx->strp, true);
 	tls_rx_reader_unlock(sk, ctx);
 	if (psock)
 		sk_psock_put(sk, psock);
@@ -2290,7 +2296,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		if (err < 0)
 			goto splice_read_end;
 
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
 		skb = darg.skb;
 	}
 
@@ -2317,6 +2323,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	consume_skb(skb);
 
 splice_read_end:
+	tls_strp_check_rcv(&ctx->strp, true);
 	tls_rx_reader_unlock(sk, ctx);
 	return copied ? : err;
 
@@ -2382,7 +2389,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 		}
 
 		/* read_sock does not support reading control messages */
@@ -2412,6 +2419,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	tls_strp_check_rcv(&ctx->strp, true);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
 

-- 
2.53.0


