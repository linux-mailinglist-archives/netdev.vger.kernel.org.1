Return-Path: <netdev+bounces-253675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKEiC5UveGn5ogEAu9opvQ
	(envelope-from <netdev+bounces-253675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:23:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D88F83D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA6C302C6F7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A13033FF;
	Tue, 27 Jan 2026 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD0mncN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4B2FE582
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484115; cv=none; b=Tz1IQDjxcZvGT9/P3dvpK+jjue3QJ6wfjAfMhjBdIHbkT24wzV8xzBd+T/OUX+4xSUvy1uIzTRgf+kTZos6cW7sOt2/XG5eYfR5Wd2ApyWmZb1hwtUfeR/6KAsodnSHXNxTRCYo+VEb2gf8NtQfE3FtquUQtGCMnTbjNSB/0kN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484115; c=relaxed/simple;
	bh=ocyvdKrP3Hy32p8oQ/1IYKwBrsdgytyKRMZjxekS1m8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d6+GSxrE8jINOVgQ+83gQuGZxB53jLzfTUV2RSpztqCQ1l+rFcvavPPgP6IUI1rro5sXLDSnG16JItv3fuF5HuTYaA6KBk7UD+yfp4qk1S75ocwk4LQQOPDb6c0ZNRxbc3ppwhLlQlhEZObAVzprv9+2sDHenep0KggEScfuCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD0mncN7; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-64956928dafso5723527d50.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484113; x=1770088913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gT/Eb//4hPc8Ua+9EmOIlzxcPFWWGdqENEs/7+97xzI=;
        b=JD0mncN7Q1w0JstJgxr2CdDMkvdUTnWnEWp8ypTzZG5P1EZfKEQpX0GrPXu4kxECfd
         6Z0S3VyHxFck5QYn0Xc1uMsSrsElpfLgRaWKkOALbEo/ujUok2YXQestbgf8EL8u/Sv3
         RHdVfUivi2vqPbTMOFhif5DkXQh3S/TRcD63K71fjByKUHK5ix7a5He3KZ66sxUTDLTh
         Xt4ZoxPu2qN1INU4ZepmOIWptowNBEN+Pn51EcyItcxicYlWZH+MZztooZjM+9fPqX1L
         UC4dyEd6ML8cosuosoisFFk94uokdrhfUcDR5QdWBXdFRE2WlGJ2kHA8NnUz/UgzgHWt
         0BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484113; x=1770088913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT/Eb//4hPc8Ua+9EmOIlzxcPFWWGdqENEs/7+97xzI=;
        b=VCm+KYdnnrR5vP63vKYcTiPFOAIkjxT3e9T8mzxo8gJf7nbAi32b6xXTJLIgAhR499
         phovA509C2r5tjYzjeST3JJaIbYgemMeIjo5d6KbTL36u4V2aTkIpkxqiH0vLtyM8dDk
         rD+WF+D6YopoxrF8XLobH595JFMi1e5ScBpwEXmW468caCayEP+DhZ/kg0RqeQNfN2GW
         e5fUt4S6umPxi5svkSnsDW+1+vVcnWNhl4cR3qCvOAw8YH6G7+tnwFj07jEnG+8K5Amp
         wrApnzjrYjhfr2sGeyui12efo12rmF+SpmQSmnZLwhZ7GCqgB0OgtxCBCUGNCTWXxMbD
         bfOA==
X-Forwarded-Encrypted: i=1; AJvYcCXnCRExPC8H5COWouHRQZS2li6bD+e4L9B3ZP51wmCTOzgLRUnSZOKKVZdz+GOp2OqbDPyyrhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbyEorMZ5rLGd4CX81mm1wakOLCM2fRz4T6yVz+rlgJUviqYF
	R1NzdhMUCyEgpOEdn8rdhr3NPYn/aLErJlCZiTGKvC6GHX7WDBzPURMyzHzwsrPwMjpbZ2LEZex
	Ygi4r+o8k3tAFhg==
X-Received: from yxrn10.prod.google.com ([2002:a53:ebca:0:b0:641:4b3:8bd9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:419a:b0:649:5ff5:707 with SMTP id 956f58d0204a3-6498fc3b242mr93627d50.57.1769484113138;
 Mon, 26 Jan 2026 19:21:53 -0800 (PST)
Date: Tue, 27 Jan 2026 03:21:47 +0000
In-Reply-To: <20260127032147.3498272-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127032147.3498272-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127032147.3498272-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: move tcp_rack_advance() to tcp_input.c
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
	TAGGED_FROM(0.00)[bounces-253675-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A71D88F83D
X-Rspamd-Action: no action

tcp_rack_advance() is called from tcp_ack() and tcp_sacktag_one().

Moving it to tcp_input.c allows the compiler to inline it and save
both space and cpu cycles in TCP fast path.

$ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
add/remove: 0/2 grow/shrink: 1/1 up/down: 98/-132 (-34)
Function                                     old     new   delta
tcp_ack                                     5741    5839     +98
tcp_sacktag_one                              407     395     -12
__pfx_tcp_rack_advance                        16       -     -16
tcp_rack_advance                             104       -    -104
Total: Before=22572680, After=22572646, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h       |  2 --
 net/ipv4/tcp_input.c    | 32 ++++++++++++++++++++++++++++++++
 net/ipv4/tcp_recovery.c | 32 --------------------------------
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a4d9f263ea68..f1cf9e6730c8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2514,8 +2514,6 @@ void tcp_newreno_mark_lost(struct sock *sk, bool snd_una_advanced);
 extern s32 tcp_rack_skb_timeout(struct tcp_sock *tp, struct sk_buff *skb,
 				u32 reo_wnd);
 extern bool tcp_rack_mark_lost(struct sock *sk);
-extern void tcp_rack_advance(struct tcp_sock *tp, u8 sacked, u32 end_seq,
-			     u64 xmit_time);
 extern void tcp_rack_reo_timeout(struct sock *sk);
 
 /* tcp_plb.c */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d504a9a9b6ec..a2a872382fc0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1558,6 +1558,38 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 	return in_sack;
 }
 
+/* Record the most recently (re)sent time among the (s)acked packets
+ * This is "Step 3: Advance RACK.xmit_time and update RACK.RTT" from
+ * draft-cheng-tcpm-rack-00.txt
+ */
+static void tcp_rack_advance(struct tcp_sock *tp, u8 sacked,
+			     u32 end_seq, u64 xmit_time)
+{
+	u32 rtt_us;
+
+	rtt_us = tcp_stamp_us_delta(tp->tcp_mstamp, xmit_time);
+	if (rtt_us < tcp_min_rtt(tp) && (sacked & TCPCB_RETRANS)) {
+		/* If the sacked packet was retransmitted, it's ambiguous
+		 * whether the retransmission or the original (or the prior
+		 * retransmission) was sacked.
+		 *
+		 * If the original is lost, there is no ambiguity. Otherwise
+		 * we assume the original can be delayed up to aRTT + min_rtt.
+		 * the aRTT term is bounded by the fast recovery or timeout,
+		 * so it's at least one RTT (i.e., retransmission is at least
+		 * an RTT later).
+		 */
+		return;
+	}
+	tp->rack.advanced = 1;
+	tp->rack.rtt_us = rtt_us;
+	if (tcp_skb_sent_after(xmit_time, tp->rack.mstamp,
+			       end_seq, tp->rack.end_seq)) {
+		tp->rack.mstamp = xmit_time;
+		tp->rack.end_seq = end_seq;
+	}
+}
+
 /* Mark the given newly-SACKed range as such, adjusting counters and hints. */
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index 40732b84771e..139646751073 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -111,38 +111,6 @@ bool tcp_rack_mark_lost(struct sock *sk)
 	return !!timeout;
 }
 
-/* Record the most recently (re)sent time among the (s)acked packets
- * This is "Step 3: Advance RACK.xmit_time and update RACK.RTT" from
- * draft-cheng-tcpm-rack-00.txt
- */
-void tcp_rack_advance(struct tcp_sock *tp, u8 sacked, u32 end_seq,
-		      u64 xmit_time)
-{
-	u32 rtt_us;
-
-	rtt_us = tcp_stamp_us_delta(tp->tcp_mstamp, xmit_time);
-	if (rtt_us < tcp_min_rtt(tp) && (sacked & TCPCB_RETRANS)) {
-		/* If the sacked packet was retransmitted, it's ambiguous
-		 * whether the retransmission or the original (or the prior
-		 * retransmission) was sacked.
-		 *
-		 * If the original is lost, there is no ambiguity. Otherwise
-		 * we assume the original can be delayed up to aRTT + min_rtt.
-		 * the aRTT term is bounded by the fast recovery or timeout,
-		 * so it's at least one RTT (i.e., retransmission is at least
-		 * an RTT later).
-		 */
-		return;
-	}
-	tp->rack.advanced = 1;
-	tp->rack.rtt_us = rtt_us;
-	if (tcp_skb_sent_after(xmit_time, tp->rack.mstamp,
-			       end_seq, tp->rack.end_seq)) {
-		tp->rack.mstamp = xmit_time;
-		tp->rack.end_seq = end_seq;
-	}
-}
-
 /* We have waited long enough to accommodate reordering. Mark the expired
  * packets lost and retransmit them.
  */
-- 
2.53.0.rc1.217.geba53bf80e-goog


