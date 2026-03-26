Return-Path: <netdev+bounces-272081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNpmIl06xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:53:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E7B336529
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5124A3060A24
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE883195EF;
	Thu, 26 Mar 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czxg/Ine"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2204318BB5;
	Thu, 26 Mar 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533070; cv=none; b=l/nsbO78GaTjqBRJaGmZpmOr3DiVlQmk8ugJAAGz6RILxF2df75PEr+0VeH4/+7JFFkGqYVl5g2AmAA9hPX/KhKQBCNRGiafHVGa5rZs9/oC0KHWgYJ2Ek4hv7oHSmRBdIXvPnaBJ0gioOIBAeC4sLuonW9tn/IuiCFMN0oM4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533070; c=relaxed/simple;
	bh=DG/GZ8WuvTeRAQ2BZeJTjjHoP1q2zHBqZB7be7iA5nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIVe7ZOCr0aK2Fs/59MRyEqGS5mXLpSBBGyJcGwX9PQtbRKtkATWB6wq5jnH90TaKHO/21YiId2iNggUZmM5ZsAujAvE+ByN81GV7LPgVwqgjBYulZRpjTcbvffNssfJ0SrXeVuOzGVoodYMUjFR+OpzzLp09iy6YgQlqROqUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czxg/Ine; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1586C19424;
	Thu, 26 Mar 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533070;
	bh=DG/GZ8WuvTeRAQ2BZeJTjjHoP1q2zHBqZB7be7iA5nY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Czxg/InebBm9IHNwote0/rptjHjzaAjoo/R3eQ1jstmZywiA5qRadY3WHTl1B7sNo
	 msUqm2p9m+UeV/z+ZdbvpOBgHDiIhK9DjdC2z5EWDN03JDbJF/5IU02BM0TE1PHbT4
	 mY/MTPfxFppNMhqfC0GxJVRJm3JWiplYxb6x5kDGTR6OVYEn0M7oD1PJrTaAD7s/lr
	 /WETiDGG3/Mo1bSD0UJWkIZPAoKXhy7jjYJJzUv1/QnFlvhBE9ifCqBCEi4KqwOhDZ
	 /al8NN1DvmfSW54l3FK40R8l/HuoFPwPmDo+YzzoWeCTt3j5zjO4eFib9AZCzwXomS
	 8nh3et6osGsSg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 09:50:50 -0400
Subject: [PATCH net-next v6 5/6] tls: Suppress spurious saved_data_ready on
 all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tls-read-sock-v6-5-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7564;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=p9UZ1x5xOk5RTPTSfWvn7mFdBHlIO7ihk8AyHHdsdPw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnJ26xoIORNz194V+xx8jBD27aCPP4xQEKM9
 t2D8Gw4GjqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5yQAKCRAzarMzb2Z/
 lyQVEACz9+L90CuowP4L4gOwdj6NloimC7N0Rrgoic7kAgtFppv6U/l01GLQJ1Ap3vfGC8F47iM
 f4msLxv38XZ1Krxuc0w8mGXx6/o+J4hw7MEmMOSQX/jUzBX50bkLAUF17BBa6lL1MKh/HZlJnC5
 aOnAE9M3vE6NvPPWam53o5VNNytLF//P9wQ9Yf7pkmoiNxHOb2WofAR4nPe24TJtH06jSqgAotF
 ZGIzoWp2OQ9n16wFyitRvHopZnk6v1hADbVsmUHTY0Lv3OXsSLGvMjq1XRmb14Bci8MWpIhY+21
 JZaEztJ9+Mvw1JoW+Bcren9byz/JEBoftTvLLodvhK/VFQrGQEPxn/0V72dRIsXJ+kqod+2ecx6
 zJ/uCDAqhpYBy6a/mm7zVdzxDCJGyz6pRFW9fpBh9jmsOOMJfabjhpi5wz/CEWan6bEYV/tsajS
 CSWtMvJms2sjNXHX5CnaZ2fpa/3EbZiTADWMMdsvNg45M7bZ4Afgl1u2e1TOAuBNHGU9Ne4ZWf5
 1rOFIS+xpLQtHF8o/cwnBqOoKwC6BG3AcUgR5ghFecVwvSrx9eXkjDH7PAustO3UiulDzqOHQXR
 r8IPyNRZ5nmzApDtjyZwAdPOU4/tDOwXBwdOuZoSyA/OJJ9OQBetw8nGzysNUZePxq5XDWppMZ7
 WjajlCVQkYST2NA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272081-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,oracle.com:email,oracle.com:mid,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32E7B336529
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


