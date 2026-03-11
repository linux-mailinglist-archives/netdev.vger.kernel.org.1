Return-Path: <netdev+bounces-266389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDz7DrG1sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B74259B52
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D71D130A5CD6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9F326942;
	Wed, 11 Mar 2026 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGp399ZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA5325710;
	Wed, 11 Mar 2026 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188404; cv=none; b=f93jqFEeRQoJ3+3sDuI7li2Rpf0KRejvGf5Wpej7cu1mAO/5JGTh7dRVcxU8d2nakm1Fx5qRAEW1X9NyLJyPKaANmvOJvIQNUkDPusnlpjqu0bsy3jbhGeUIVN8Nt/ZgdpY/JMQTPRjo3hrggskLwCVWa/fBpXuWrZs2bFQBpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188404; c=relaxed/simple;
	bh=eXtmP9flpGz2I5lFaLHKS6gAU2Er15Zx8ESpOfGouT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPifov0SIasU7Us5PD/xQIefG9so5cjYzSrsWi2rFmtVC3q+EtDdKgm2BjNUPRoIeHIf2g39Nsc6RudsriHIfKIsyxxEZS9arhdTh/TJ2LVgj//JSQfYyHnjrWJQyOSfD3lshrwE0F90SdIyCuBmhP3ZOwznK2RoyVEPA1trP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGp399ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879DEC19423;
	Wed, 11 Mar 2026 00:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188404;
	bh=eXtmP9flpGz2I5lFaLHKS6gAU2Er15Zx8ESpOfGouT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGp399ZFP7L6z17gwWatcBMDRpJNEYHe7Eqdda4O4cOBEc0k56XqfIxo0pum6Mj26
	 9Ki2SAR+hV2aGY/rn1NDjoOEMPvsW/WRxdnDnfz4Af6o7US2125cmxmhuomPYUii/v
	 0OGAxH40++YwF+6Wb7En0KVwZizHPowuL5F6dRPWQjlj0iaazLrKp1Nbb2FaM9CNBo
	 Xlh4e3PGRioE8IsmaV+tkc+Ut7fu/YE2Izp8AZzBatwhm+1cT8PgWR50Ah5IEwoss2
	 fbhW5njLbGCO7QGX5BJ1oTkMzb/6FT2R/x+jgxC4pP0TTvNY7UDMlhPAGN1dkdCp6h
	 ZSDBuFLYZvYxw==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 5/8] tls: Suppress spurious saved_data_ready on all receive paths
Date: Tue, 10 Mar 2026 20:19:49 -0400
Message-ID: <20260311001952.57059-6-cel@kernel.org>
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
X-Rspamd-Queue-Id: D1B74259B52
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
	TAGGED_FROM(0.00)[bounces-266389-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,wdc.com:email,suse.de:email]
X-Rspamd-Action: no action

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
 net/tls/tls_sw.c   | 20 +++++++++++++-------
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index a97f1acef31d..0ab3b83c3724 100644
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
index a7648ebde162..6cf274380da2 100644
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
index e5d0447cbba6..006e0a955b3f 100644
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
@@ -1876,9 +1879,9 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
-static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
+static void tls_rx_rec_release(struct tls_sw_context_rx *ctx)
 {
-	tls_strp_msg_done(&ctx->strp);
+	tls_strp_msg_release(&ctx->strp);
 }
 
 /* This function traverses the rx_list in tls receive context to copies the
@@ -2159,7 +2162,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_record_content_type(msg, tls_msg(darg.skb), &control);
 		if (err <= 0) {
 			DEBUG_NET_WARN_ON_ONCE(darg.zc);
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 put_on_rx_list_err:
 			__skb_queue_tail(&ctx->rx_list, darg.skb);
 			goto recv_end;
@@ -2173,7 +2176,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* TLS 1.3 may have updated the length by more than overhead */
 		rxm = strp_msg(darg.skb);
 		chunk = rxm->full_len;
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
 
 		if (!darg.zc) {
 			bool partially_consumed = chunk > len;
@@ -2267,6 +2270,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	copied += decrypted;
 
 end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_unlock(sk, ctx);
 	if (psock)
 		sk_psock_put(sk, psock);
@@ -2307,7 +2311,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		if (err < 0)
 			goto splice_read_end;
 
-		tls_rx_rec_done(ctx);
+		tls_rx_rec_release(ctx);
 		skb = darg.skb;
 	}
 
@@ -2334,6 +2338,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	consume_skb(skb);
 
 splice_read_end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_unlock(sk, ctx);
 	return copied ? : err;
 
@@ -2399,7 +2404,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 		}
 
 		/* read_sock does not support reading control messages */
@@ -2429,6 +2434,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
 
-- 
2.53.0


