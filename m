Return-Path: <netdev+bounces-295378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lko6A5u6IWrXMgEAu9opvQ
	(envelope-from <netdev+bounces-295378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:49:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D49642651
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:49:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZRSN1nPB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295378-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295378-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 274963028469
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34A4D2ECA;
	Thu,  4 Jun 2026 17:48:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315C4CA273;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595324; cv=none; b=tKJmMWDIkoE9L+GSgI2Vqj7eQyi6uiUaDmAv6kzcxgZ4cQK/sgG659/b2KZXs79liuboig32RO2sbk3e/sJEx/5fZCqFTGXH7X204DV3aw67hQ0lbW7AZjLqC3/uAC497amKMPSueqPdSYSilNivikI9gDIaUJmGsvFKmAStGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595324; c=relaxed/simple;
	bh=C2/nssUxBkPedsqmFndypAybwKSTg2oDemH+VrUaJBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CV02vjjoeFu4UpH3q9zrBbcioFffnEZ1BZ6pkh8M86iGJk3iLadBrStbHmaoZK77Unm6xW22nJpNRHcnN1CirLHwmE16ullZJfeq8cf5MOxxIIScVuvfdVHjlryvV4MwfeD2vS5XuYISd7k+DIuNwCEDxDJFHAsBv16mYCDoaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRSN1nPB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF61F0089D;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595322;
	bh=V2saVs70r1BK11yZ8/U6XDPksLhhGD0CRO3QjBGK+EU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZRSN1nPBMDEBmdk628KyoaU8/hLnvRG0iAYULc+QW/OxcXVZk2d+mmvoPjBisieXa
	 Zjv3N3RV729ZH+M4gPFZuCsAk56/yUsLVVXmirbBjjrVVnlVU8dbg2MOvl51lBlr4k
	 Nsd08eaI5hQvqJkRS2X+fticKa3bmXcfmWuSPmKru9GNrMkl7cKjOhYoNaHx+L9DTp
	 b/OUnfh+ge2NJ9iERK3tyMzQOPeS0xTvTB6oB1bYFUxOQeBPljRphe5DeG0/AXyAy+
	 VN+4KlMEaRb/Ovo6NnVuekpqitII7baiT/dwZAYPB1jXbyTGzjOOmkacHIVx0hZOkh
	 cReH0r/VdYP6A==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:48:28 -0400
Subject: [PATCH net-next v12 5/6] tls: Suppress spurious saved_data_ready
 on all receive paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tls-read-sock-v12-5-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=8402;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=lt+aITkqtwmLLOEhw1No9gSiDpddh8d9T5+gc7F0vVM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbp3HIPTAYw9ZIo29ToHm8fLljJ5mmvbPbj1D
 QOOLpQMr6CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6dwAKCRAzarMzb2Z/
 l+vGD/9QkqUojfhG6YIpEuwIy9vQsmIP3uj0WniTQfD5jMl8WdFvx6rMnszh4JCOfzHxF8dQwS0
 5f858E+lLG0iOjhgOy8W8T6ryKz5YNtdWcZ53XbFmDHpOsFfLV02QUqBTvx0Mk3+3QeFFQHbvcN
 EmLSX+8Vzpg3kFW29XLHRKGzlz6OXQmZDI1Zgw/YjedjccHSL6oBHCQsfiLxuChOAXctHySsDaN
 Snef0sjz/+l1tWfHk4T4SUgFapnaXSqf6y4x7loUKifPoYKbMJVx7jGBEqO7s1p4dggTCPQCE8G
 gpk+RAnug4GZm/JftnPxJ2ueXW8kRjNdg5XBU1RpFOk9xDCHZyQNT1s/Et38Fcy6B8+a7Xfrlta
 PL0sHnsvufi8ABA1i2fUvBYcWJJSZeHMuAhpJYRCxKlwh1i9In/MgP19ns3fg3Cw0MjnommXnry
 Lx2lEhJU28BBKmENpmU0E+rNQwbluPbzYEPOLVfsNW0lTrDFy8W291/nkoTTupyeDTMmS5IGanc
 HHykldxrAGkv2Z6IV2CzJRD1d5EmQRUDHtxKfeUjN5DB+NQEug6//SLfQL7u9LAm+goxL+zwgkv
 c+/JhsEFkqsxmDLPmriaEfIn50cKGYAhTNknPU/aD36NDwUJjNTPs62aqN28R2a2ARWJcI3py7m
 auj6aCmZM+hM3/A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295378-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:email,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2D49642651

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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
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


