Return-Path: <netdev+bounces-253674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PzaGYcveGn5ogEAu9opvQ
	(envelope-from <netdev+bounces-253674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:22:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49F8F82E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F85302297B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0507229E0F6;
	Tue, 27 Jan 2026 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2V69hNgF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B964309EFB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484113; cv=none; b=jwpzmXbXStTxyoDo3KtrxIjS6dZiPesF+2U5sa8OTKhWhIWRwVxdb8z5rCDBTum9Y+7bj45qEjtjvadn4b6YhKSUCjd9Q3GyDH1Df+p1uYNj8fu+FiB1tgZd8K0OsUXl/LPO/LMyUrVMfsFMUMwjOD9GAETB+KJNKq4gRJicBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484113; c=relaxed/simple;
	bh=PwQ1o54/J4Q5gCE9HBNHaCNDUpZeP/7POLXSM9AypQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JWWt2oKF3SH8FA4nxmc9F3FjpiMv9zG9bFh5VMuRzFaRgNFvel4N6QkCNQxwxvEx4Jr1zKI/jr/ilG9ci8JFykEqD+yxrSaMlmmbik4ZmtoKN2NYbHGgwri+GO/61aKM6d3BfI9vW/vu9oZ6G3PbgCNBhIfKVoQtlmm0l6++osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2V69hNgF; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-890587d4e87so195697626d6.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484111; x=1770088911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYLUQQ+iCrCewHjRxgSfs4e64Vq+8BTa9AhQFalyreQ=;
        b=2V69hNgFCAXzj1kQ9JqgdOdlh1wUTjoWMI1qy1F19vYD693N4Sro1BTBj0iIotcnFM
         kTQ0B0B8RRH4MFesd1ZQ7KKTN8B8cXKeAkMUWq2KtjeYXpR8iDLNR3jSe9UbMsU5ZFs/
         ZX97sNDA7s2I3yKF0vYE3ebxqRBQhbdu3P8/EMEow80h11cDzBKlDkrof6KO5vB+eTgx
         wO4pivo8l9BtIcCcdjnyHWxzYq5mM0ReyQZZeKufhZxTvNZkNkDL0sOy1g5W2ON1uqtg
         y0cxftOKyF+FgdAk3mJZAclgHj2ToRFb30bvnPjhPij6a8tMZ2ZEDZsQMHzZFC3q0xfr
         C1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484111; x=1770088911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYLUQQ+iCrCewHjRxgSfs4e64Vq+8BTa9AhQFalyreQ=;
        b=eZYrSpZ0CGMN8eoQuRv+EtXcR478cROqLGl84/M4Wq3BSLbGrrj7nM824O99PD9x/D
         TaCLQ5iYsoS6QTIzI3HfcblRMFn3bn0Kf2sG3t00qaXUFXrwCkU+mOGBvNHjG4CCzZfd
         xCaQyDrQAYdoh/ZGO6//0fWZRe0A8odWl4vhuRsVpF8M1zkYbtS3c8z03PP+GTUtzeT7
         RuYoEqzw7NYnH69F1jCiwjvdiuKkXTRhV3f2maTdhej/mm63dn9XzPHgHEAQTwhgwoYK
         XrSiVjcSPb++oPIH0TjR4YnGB5yznBQn32P5d5KM6sqUvpw6QlTD5udicqOzlepHPn5D
         +L9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWMS0ndZ22J4iDd2QvuFkzplEM7xhVWocFSJUUmkMB3RyyN2Yl/wtzh0nIffCcOymxQLCh2F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KMyQW0vUoRyH3dsBWAtOTaewZdNnmvO6+kuVuOkVxHhoCCxT
	fL+hGLMAUYOOr9SYI6K5tF0XYGr+QZG4OQFtBxls1tFD6bYKqrh2VYCnwRkwxj91IPdPb8Ub/+0
	HU34fbXDynYXd2w==
X-Received: from qvbkk28.prod.google.com ([2002:a05:6214:509c:b0:894:7038:8dac])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:c4f:b0:880:8600:efbf with SMTP id 6a1803df08f44-894cc91d8fbmr5046596d6.56.1769484111490;
 Mon, 26 Jan 2026 19:21:51 -0800 (PST)
Date: Tue, 27 Jan 2026 03:21:46 +0000
In-Reply-To: <20260127032147.3498272-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127032147.3498272-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127032147.3498272-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: move tcp_rack_update_reo_wnd() to tcp_input.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253674-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E49F8F82E
X-Rspamd-Action: no action

tcp_rack_update_reo_wnd() is called only once from tcp_ack()

Move it to tcp_input.c so that it can be inlined by the compiler
to save space and cpu cycles.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 110/-153 (-43)
Function                                     old     new   delta
tcp_ack                                     5631    5741    +110
__pfx_tcp_rack_update_reo_wnd                 16       -     -16
tcp_rack_update_reo_wnd                      137       -    -137
Total: Before=22572723, After=22572680, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h       |  1 -
 net/ipv4/tcp_input.c    | 43 +++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_recovery.c | 43 -----------------------------------------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index efff433de9a4..a4d9f263ea68 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2517,7 +2517,6 @@ extern bool tcp_rack_mark_lost(struct sock *sk);
 extern void tcp_rack_advance(struct tcp_sock *tp, u8 sacked, u32 end_seq,
 			     u64 xmit_time);
 extern void tcp_rack_reo_timeout(struct sock *sk);
-extern void tcp_rack_update_reo_wnd(struct sock *sk, struct rate_sample *rs);
 
 /* tcp_plb.c */
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f2fafba95705..d504a9a9b6ec 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4149,6 +4149,49 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
 	return delivered;
 }
 
+/* Updates the RACK's reo_wnd based on DSACK and no. of recoveries.
+ *
+ * If a DSACK is received that seems like it may have been due to reordering
+ * triggering fast recovery, increment reo_wnd by min_rtt/4 (upper bounded
+ * by srtt), since there is possibility that spurious retransmission was
+ * due to reordering delay longer than reo_wnd.
+ *
+ * Persist the current reo_wnd value for TCP_RACK_RECOVERY_THRESH (16)
+ * no. of successful recoveries (accounts for full DSACK-based loss
+ * recovery undo). After that, reset it to default (min_rtt/4).
+ *
+ * At max, reo_wnd is incremented only once per rtt. So that the new
+ * DSACK on which we are reacting, is due to the spurious retx (approx)
+ * after the reo_wnd has been updated last time.
+ *
+ * reo_wnd is tracked in terms of steps (of min_rtt/4), rather than
+ * absolute value to account for change in rtt.
+ */
+static void tcp_rack_update_reo_wnd(struct sock *sk, struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if ((READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_recovery) &
+	     TCP_RACK_STATIC_REO_WND) ||
+	    !rs->prior_delivered)
+		return;
+
+	/* Disregard DSACK if a rtt has not passed since we adjusted reo_wnd */
+	if (before(rs->prior_delivered, tp->rack.last_delivered))
+		tp->rack.dsack_seen = 0;
+
+	/* Adjust the reo_wnd if update is pending */
+	if (tp->rack.dsack_seen) {
+		tp->rack.reo_wnd_steps = min_t(u32, 0xFF,
+					       tp->rack.reo_wnd_steps + 1);
+		tp->rack.dsack_seen = 0;
+		tp->rack.last_delivered = tp->delivered;
+		tp->rack.reo_wnd_persist = TCP_RACK_RECOVERY_THRESH;
+	} else if (!tp->rack.reo_wnd_persist) {
+		tp->rack.reo_wnd_steps = 1;
+	}
+}
+
 /* This routine deals with incoming acks, but not outgoing ones. */
 static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 {
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index c52fd3254b6e..40732b84771e 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -166,49 +166,6 @@ void tcp_rack_reo_timeout(struct sock *sk)
 		tcp_rearm_rto(sk);
 }
 
-/* Updates the RACK's reo_wnd based on DSACK and no. of recoveries.
- *
- * If a DSACK is received that seems like it may have been due to reordering
- * triggering fast recovery, increment reo_wnd by min_rtt/4 (upper bounded
- * by srtt), since there is possibility that spurious retransmission was
- * due to reordering delay longer than reo_wnd.
- *
- * Persist the current reo_wnd value for TCP_RACK_RECOVERY_THRESH (16)
- * no. of successful recoveries (accounts for full DSACK-based loss
- * recovery undo). After that, reset it to default (min_rtt/4).
- *
- * At max, reo_wnd is incremented only once per rtt. So that the new
- * DSACK on which we are reacting, is due to the spurious retx (approx)
- * after the reo_wnd has been updated last time.
- *
- * reo_wnd is tracked in terms of steps (of min_rtt/4), rather than
- * absolute value to account for change in rtt.
- */
-void tcp_rack_update_reo_wnd(struct sock *sk, struct rate_sample *rs)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if ((READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_recovery) &
-	     TCP_RACK_STATIC_REO_WND) ||
-	    !rs->prior_delivered)
-		return;
-
-	/* Disregard DSACK if a rtt has not passed since we adjusted reo_wnd */
-	if (before(rs->prior_delivered, tp->rack.last_delivered))
-		tp->rack.dsack_seen = 0;
-
-	/* Adjust the reo_wnd if update is pending */
-	if (tp->rack.dsack_seen) {
-		tp->rack.reo_wnd_steps = min_t(u32, 0xFF,
-					       tp->rack.reo_wnd_steps + 1);
-		tp->rack.dsack_seen = 0;
-		tp->rack.last_delivered = tp->delivered;
-		tp->rack.reo_wnd_persist = TCP_RACK_RECOVERY_THRESH;
-	} else if (!tp->rack.reo_wnd_persist) {
-		tp->rack.reo_wnd_steps = 1;
-	}
-}
-
 /* RFC6582 NewReno recovery for non-SACK connection. It simply retransmits
  * the next unacked packet upon receiving
  * a) three or more DUPACKs to start the fast recovery
-- 
2.53.0.rc1.217.geba53bf80e-goog


