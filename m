Return-Path: <netdev+bounces-264549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAs/D0DyqWnhIQEAu9opvQ
	(envelope-from <netdev+bounces-264549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCF218717
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA783301DA77
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BE356A37;
	Thu,  5 Mar 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoKh7Z0U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF7356A08;
	Thu,  5 Mar 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745248; cv=none; b=KxHnfoMi8p1GOuLhzBkaxP7RS3lUZKyafGfMjaLsYUOfhTfLJ+kVAib0vW/HNY24Vbk4zeJD6M0/4neBFjn6W+8bDpQ3UTpE+8aAWx6xRxT1u6HHDKPZy68S9CXxWaGthiFxWQ9EqiuHGxvl6NpZsVOYaeUXUL/8gpMt+EDfYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745248; c=relaxed/simple;
	bh=dJL6USRU5wnCOsxC7h8IONJZQxuC/kDbIuSIjffRJpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irSCBzKbC1AHPLD/lPqDbCq2n3xNEUUxY8WTqX5C0aMqB1nZQNtpEFK7MlgZymHfJHCWneiBlM25vbhj+unBKXCwlTHIfc0tocW3Iy55t2ft2NG/4jUAD886XCaGsTEcO0uU3E7iF5opP1Ozd4NHtIsvf59V4iu1ihET9kQ/cE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoKh7Z0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C8AC2BC9E;
	Thu,  5 Mar 2026 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745248;
	bh=dJL6USRU5wnCOsxC7h8IONJZQxuC/kDbIuSIjffRJpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoKh7Z0UDlKdnX3UbRsDgM7FlJ+KAVSR+fpT8JNesCgwThS2UDn9bpaNzTyqdqDLY
	 K8Tq9GdJugW2YmCbQYDNRnac7gimho2iiU4zQVbH0jw5RMWbWjzKurLIlRhqoMXQkR
	 bKyTOxufGN/uZFjsRkBnM/JRld+2HaJvBqW/GVa20IIRQml5HUEjN/q1Rqb7I396Hv
	 r3+9BTULeoGzhER/uCKdlhm5nKj/RnXKpOGe3a6SSW4FIt5R4xcKMEv+h69vQWDZtL
	 icGG6XTG/5z2k1N8wrkYrw2f1gg6ddWVyLXcqWxSuFl5xbVjjvrLZYF6l1ozlAsq1Q
	 sOisMkVNbu5YQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v1 3/6] tls: Suppress spurious saved_data_ready during read_sock
Date: Thu,  5 Mar 2026 16:13:59 -0500
Message-ID: <20260305211402.39408-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305211402.39408-1-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54CCF218717
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264549-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

During tls_sw_read_sock(), each record release triggers
tls_strp_msg_done(), which calls back through the strparser into
saved_data_ready(). For a batch of N records, the first N-1
wakeups are pure overhead: the read_sock callback is already
running and will pick up subsequent records on the next iteration.

Remove the per-record wakeup from the record-release path by
introducing tls_rx_rec_release(), which calls
tls_strp_msg_release() instead of tls_strp_msg_done(). Factor
tls_rx_msg_ready() out of tls_strp_read_sock() so that parsing a
record no longer fires the callback directly, and introduce
tls_strp_check_rcv_quiet() for use in tls_rx_rec_wait(), which
parses queued data without notifying. A single
tls_strp_check_rcv() at the read_sock_end exit point fires at
most one notification, and only when data remains after the loop
exits.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 21 +++++++++++++++++++--
 net/tls/tls_sw.c   | 13 +++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index a97f1acef31d..d58d86e8e43e 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -193,6 +193,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_check_rcv_quiet(struct tls_strparser *strp);
 void tls_strp_msg_release(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index a7648ebde162..7b9f5051becb 100644
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
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 108d417dcfb7..a5905f4c1ae2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1372,7 +1372,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 			return ret;
 
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
-			tls_strp_check_rcv(&ctx->strp);
+			/* tls_strp_check_rcv() is called on the read_sock_end
+			 * path before the socket lock is released.
+			 */
+			tls_strp_check_rcv_quiet(&ctx->strp);
 			if (tls_strp_msg_ready(ctx))
 				break;
 		}
@@ -1853,6 +1856,11 @@ static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 	return 1;
 }
 
+static void tls_rx_rec_release(struct tls_sw_context_rx *ctx)
+{
+	tls_strp_msg_release(&ctx->strp);
+}
+
 static void tls_rx_rec_done(struct tls_sw_context_rx *ctx)
 {
 	tls_strp_msg_done(&ctx->strp);
@@ -2383,7 +2391,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			tlm = tls_msg(skb);
 			decrypted += rxm->full_len;
 
-			tls_rx_rec_done(ctx);
+			tls_rx_rec_release(ctx);
 		}
 
 		/* read_sock does not support reading control messages */
@@ -2413,6 +2421,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	}
 
 read_sock_end:
+	tls_strp_check_rcv(&ctx->strp);
 	tls_rx_reader_release(sk, ctx);
 	return copied ? : err;
 
-- 
2.53.0


