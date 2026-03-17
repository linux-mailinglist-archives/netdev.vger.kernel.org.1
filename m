Return-Path: <netdev+bounces-268645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN4oNqdvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:13:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62E2ACC28
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A68593093502
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793B3EC2CC;
	Tue, 17 Mar 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WinmH9p8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385D3E928A;
	Tue, 17 Mar 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759888; cv=none; b=FsRf/Dwv8Z0+ym3Yw8vnsnZS+31MkJ5Np5Q+f3Ikc2nP61GPIzVVWcgyeNm22uL1wdl5SXZ7mCZaejTFwlU1cy9eymZff9a2dd0hHCabWCDh6RtKWnqAT6T3dPIQy7T4BNCERkjUUEP3QKcKyqCZ00nwSR04657fXHwA/v3ML3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759888; c=relaxed/simple;
	bh=yc8i9VPkh7BWjY1T7lX14LZg1WSFWpbpuxjhAufkR68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+rPSj6h8wMpHOV0cafNRTEu2d+LFkeDLxJ3A41P8Q/BUy2J+uZF4vzwTJXxn0TZKApvhxoCQ1CckY3GuqbCNiO/qv/4O53hM2JnMg+ng0g2BfQrjvS5nas+gV9Tld1MCedzCgJbdQRZ3T2YDtqNC+aTb0dj6MW2EskF5CQ7sQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WinmH9p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA7EC19424;
	Tue, 17 Mar 2026 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759888;
	bh=yc8i9VPkh7BWjY1T7lX14LZg1WSFWpbpuxjhAufkR68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WinmH9p8QKFsoNEVbeA8r8V4FwJS7hxyFW6gSgT1iz5XDtmBu7qI4aMZKV0wnpnRy
	 J0BIrFV5qNNTaDhxoUi9N0Yt9Dv5bAq3xXcXEGvnZtwRZZ5wMLcDAzWQxidFQvglbU
	 RXlE0CjuAOidvxVthZVXLzcsuX0m5E8Bs9odFdw9GOiR2aVmQTnKcCvJSmbzeiDB0a
	 SRdPD5hAIhPt8UlPiiYnlRjmyHmJcEBdpTBIK1kZuI5+vmOvU4+btp2AabqSk5Qiwb
	 7/gpTQLA9vtwSY+kyPajNEWEbkjtZfId+s5T21PDA6fziiB0pbSPjVZ8pbHTbTKACj
	 rjxGevB2oh3ww==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:18 -0400
Subject: [PATCH PATCH net-next v4 5/8] tls: Suppress spurious
 saved_data_ready on all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-5-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6663;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=y3fsUZdoJ2NV2nW/nCRZCdtFs3cTAGjTkVTqCby+IPg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KuJURLzfd0NSpIet6X4GxFNb6R1FAYckoz
 OmI2hMRuxqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 l1uMEACMnIJ65FVitZKF+z6mTZHS39+a6GaFct6pcGyaMReC1CjlTRxaGuFVoxHYl8b2Car6tHr
 M9JSIcCflO1ZVv03+ESieVDdwk3dWigpCIWSbAbVCl+JPD5L98fA157xPSPKIsx8cvIcjP3N6X4
 3Pn30Ho5pPaMlnRhCC8/ph1PkjSDdbhKr6Ie4d3FBAAZNCNAaNmxlOdJuW0gvmBlpAa3do+SZTH
 d6yx0c/ZjuAa7uhIPt2Er5DTdwJ/j5mYG3Yw+Pvz8kfkcjoQiD1n0I1xeOquXoCJKzm+NNmuqY+
 qIb24mf3cSPhGDMBt/4UMNBxzzKPw3QusuhbTnfXjdjXxx1vaqEVUmIetBEFlq/UB/ZRW4DfLGv
 A0qlmry6AzMYrLeOOoMrHJl2GnePsvutezADMt6whVHdb+/zjmqymJw5yP+cNSoAGwX/GVXICrE
 KylzNmmRiCx8Y0+QuUc8FfZlCBmeSc6UTiImzetk2EafqUTt2S2P8K8VINFF7S9e9RUGeiOQwjj
 INfcUg0WnCg4Gs2/c7jJsaw9gtrDgQcdj21/4OpZOSLiKW2KQcaLQD1mycfdqzX/QJaIZAe3933
 POkr52WlnnY/A9DXXvTKEzaMOENGOIuy0ipTPVFFw7CkdwSvj0dnhcbvqcJjkeqyS7mcBFhY8kr
 NHcYMLCGm9W0Twg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
	TAGGED_FROM(0.00)[bounces-268645-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,oracle.com:email,oracle.com:mid,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC62E2ACC28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Each record release via tls_strp_msg_done() triggers
tls_strp_check_rcv(), which calls tls_rx_msg_ready() and
fires saved_data_ready(). During a multi-record receive,
the first N-1 wakeups are pure overhead: the caller is
already running and will pick up subsequent records on
the next loop iteration. The same waste occurs on the
recvmsg and splice_read paths.

Replace tls_strp_msg_done() with tls_strp_msg_release() in
all three receive paths (read_sock, recvmsg, splice_read),
deferring the tls_strp_check_rcv() call to each path's
exit point. Factor tls_rx_msg_ready() out of
tls_strp_read_sock() so that parsing a record no longer
fires the callback directly, and introduce
tls_strp_check_rcv_quiet() for use in tls_rx_rec_wait(),
which parses queued data without notifying.

With no remaining callers, tls_strp_msg_done() and its
wrapper tls_rx_rec_done() are removed.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  2 +-
 net/tls/tls_strp.c | 27 +++++++++++++++++++--------
 net/tls/tls_sw.c   | 21 ++++++++++++++-------
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index a97f1acef31d3a4ad1442c20c6914a9f5198a1e0..0ab3b83c37243ab393367ac80836b9fd8fec7f82 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -193,8 +193,8 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_check_rcv_quiet(struct tls_strparser *strp);
 void tls_strp_msg_release(struct tls_strparser *strp);
-void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
 void tls_rx_msg_ready(struct tls_strparser *strp);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index a7648ebde162b1bd944f53d44c89cd7da4cef082..6cf274380da2785b58206cf0e70cf4fee033a223 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -368,7 +368,6 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 		desc->count = 0;
 
 		WRITE_ONCE(strp->msg_ready, 1);
-		tls_rx_msg_ready(strp);
 	}
 
 	return ret;
@@ -539,11 +538,27 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 		return tls_strp_read_copy(strp, false);
 
 	WRITE_ONCE(strp->msg_ready, 1);
-	tls_rx_msg_ready(strp);
 
 	return 0;
 }
 
+/**
+ * tls_strp_check_rcv_quiet - parse without consumer notification
+ * @strp: TLS stream parser instance
+ *
+ * Parse queued data without firing the consumer notification. A subsequent
+ * tls_strp_check_rcv() is required before the socket lock is released;
+ * otherwise queued data stalls until the next tls_strp_data_ready() event.
+ */
+void tls_strp_check_rcv_quiet(struct tls_strparser *strp)
+{
+	if (unlikely(strp->stopped) || strp->msg_ready)
+		return;
+
+	if (tls_strp_read_sock(strp) == -ENOMEM)
+		queue_work(tls_strp_wq, &strp->work);
+}
+
 void tls_strp_check_rcv(struct tls_strparser *strp)
 {
 	if (unlikely(strp->stopped) || strp->msg_ready)
@@ -551,6 +566,8 @@ void tls_strp_check_rcv(struct tls_strparser *strp)
 
 	if (tls_strp_read_sock(strp) == -ENOMEM)
 		queue_work(tls_strp_wq, &strp->work);
+	else if (strp->msg_ready)
+		tls_rx_msg_ready(strp);
 }
 
 /* Lower sock lock held */
@@ -603,12 +620,6 @@ void tls_strp_msg_release(struct tls_strparser *strp)
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
index 07f4a3d1a6f854acc7762608cc7741b3de95c195..381a723b6cacc669e333752af34f051f296d6f52 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1384,7 +1384,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 			return ret;
 
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
-			tls_strp_check_rcv(&ctx->strp);
+			/* tls_strp_check_rcv() is called at each receive
+			 * path's exit before the socket lock is released.
+			 */
+			tls_strp_check_rcv_quiet(&ctx->strp);
 			if (tls_strp_msg_ready(ctx))
 				break;
 		}
@@ -1867,9 +1870,9 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
-static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
+static void tls_rx_rec_release(struct tls_sw_context_rx *ctx)
 {
-	tls_strp_msg_done(&ctx->strp);
+	tls_strp_msg_release(&ctx->strp);
 }
 
 /* This function traverses the rx_list in tls receive context to copies the
@@ -2150,7 +2153,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
 		if (err <= 0) {
 			DEBUG_NET_WARN_ON_ONCE(darg.zc);
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 put_on_rx_list_err:
 			__skb_queue_tail(&ctx->rx_list, darg.skb);
 			goto recv_end;
@@ -2164,7 +2167,8 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* TLS 1.3 may have updated the length by more than overhead */
 		rxm = strp_msg(darg.skb);
 		chunk = rxm->full_len;
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
+		tls_strp_check_rcv_quiet(&ctx->strp);
 
 		if (!darg.zc) {
 			bool partially_consumed = chunk > len;
@@ -2258,6 +2262,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	copied += decrypted;
 
 end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_unlock(sk, ctx);
 	if (psock)
 		sk_psock_put(sk, psock);
@@ -2298,7 +2303,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		if (err < 0)
 			goto splice_read_end;
 
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
 		skb = darg.skb;
 	}
 
@@ -2325,6 +2330,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	consume_skb(skb);
 
 splice_read_end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_unlock(sk, ctx);
 	return copied ? : err;
 
@@ -2390,7 +2396,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 		}
 
 		/* read_sock does not support reading control messages */
@@ -2420,6 +2426,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
 

-- 
2.53.0


