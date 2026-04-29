Return-Path: <netdev+bounces-282164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK7+CgBa8Wn/gAEAu9opvQ
	(envelope-from <netdev+bounces-282164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:08:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8548DE07
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DBD5304527C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69E21ADB7;
	Wed, 29 Apr 2026 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OR7uMh73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE618A6A8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424893; cv=none; b=HQd88it5si8t9cVmh1Eg2+ZpFvfXMDyIbJOM1QXkZMDE1BrHQigjvbzF9O2f9sSl6q6kZYBy9IXtKb//RrLRR9c75OzBpgS7KLUMeb3W/bkXzcnyCkzbmMAQwn7cr2FHvk371yp3f0rMxdBks/tnPXDKaELir5eONNoDjWdRDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424893; c=relaxed/simple;
	bh=lYd+iWvhDf1I1SCRjClzNHGWBLv7k2qUy/5FqAskYAg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I1VM/PXuTdKVtnmLulhp25QYbkOMRfhSMF91pNDz7A+QC/SRvqBUeEuv1pHMlFkXCgrW7uyzXgRUU79Hg30JikDeeaCOPd6RSR0bYsN4h3oGLKPITxdjSXfIEFFko9q1kx78z3673NpTuZ8MgqgXEVOh+MKF9fNOTskb5rjN9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OR7uMh73; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50faf1ecd1dso259209451cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777424891; x=1778029691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=orH73nQDw6Ke0h8O6Ce+5We6K2K/EbHU6Ro5LIkStW4=;
        b=OR7uMh73Y3HZABss1VmRglLZ5x7bbuRl2+fMk3LbKbJBNLQDITnaJhh2dLsqTNsLfP
         TIa4FAnRQLBj2VnLI6tQqUbOZqaYbJv2pNbFAP1+DNLGA4Tq1Bg6w/F5rE9+9l5Y/8JR
         Xv6JgC689mchOLa6jLmP7tuaR+1r9biBW3Ld2CEVA/622+BA0pXWlHNiGnwwGhXB95lA
         AQoE3je4j+ITunFt8nKipnIGppimVr9zTso0wTfOqdIQNYl901dL6t7b0UkpS2uXI2hF
         BzlIWMWSIg6/MlcSDWZiK/q9Im0cT53KrPQ1PYIkvEkpODiUoek51RWPDOkAAY4ByDre
         yliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777424891; x=1778029691;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orH73nQDw6Ke0h8O6Ce+5We6K2K/EbHU6Ro5LIkStW4=;
        b=QfeNuLkxc0jowNmApjlud7Rv8aF7tNJTryouQOXjwMHYuRAw6s8IQB+zMtU7eZEqV6
         GxYAHHXAGBg6S2flMmqo2Mg4cH9H6UjBKbQ2dqcz7mHgwWDKLujKH9KmiwZaJkLplOAR
         0jFYiJIQHpgqsIpd55NnO4Vfp1coG7d9BgrEThLQcj1nQqO/dgcuW9Oza//81PmoLZsy
         KfLzJ++AAjqhAQpy75tsY6+fkLXzvWXokXx5BM7uVjOlHFUBIgbdx26TGYmlv1onHDoe
         KnRfWcvL315b7x19+2yEFNA9w86aq/oScCD7Un3/B0zui/mYWhNQb/Iu569NBCN7gvK9
         Xodg==
X-Forwarded-Encrypted: i=1; AFNElJ8uxsUYsMKyj21lRjOnxOWYJSFfplYLsTXqKT/rX3kCyWZJQWwFortyB9gnJG64HW8FSw2Epyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPN8rnfgdQPsueVzcXP01cKZVviKIhWvDWPkYgJbqjQenBQMFr
	VE3JIMUi7Vh8TYGcbY0CAJrggSDs64N88Cktun+Sh7LA3YzRbBKRoxPWYtk9AIL0r6Uxgw4y/3t
	/VdR1S1SknXh4AA==
X-Received: from qtxz3.prod.google.com ([2002:a05:622a:1243:b0:50f:a53b:ca5b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5807:0:b0:50d:71aa:6b67 with SMTP id d75a77b69052e-5100e1e6f0bmr78428271cf.53.1777424890654;
 Tue, 28 Apr 2026 18:08:10 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:08:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429010809.784315-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add tcp_mstamp_refresh_inline()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 95A8548DE07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282164-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vmlinux.new:url]

We want to inline tcp_mstamp_refresh() in fast path only:

- tcp_rcv_established()
- tcp_write_xmit()

Add tcp_mstamp_refresh_inline() for this purpose.

Add noinline qualifier on tcp_mstamp_refresh() for the other paths,
to reduce bloat.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/4 up/down: 26/-123 (-97)
Function                                     old     new   delta
tcp_rcv_established                         2238    2264     +26
tcp_connect                                 4027    4003     -24
tcp_tsq_write                                152     120     -32
tcp_send_active_reset                        476     444     -32
tcp_send_window_probe                        235     200     -35
Total: Before=25316710, After=25316613, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 10 ++++++++++
 net/ipv4/tcp_input.c  |  2 +-
 net/ipv4/tcp_output.c | 12 +++---------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a7446cb18c245e670ba49ff574dfaff7..fb2bc9edc7de01bfc494afa828428723a352c02b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1015,6 +1015,16 @@ static inline u32 tcp_time_stamp_ts(const struct tcp_sock *tp)
 	return tcp_time_stamp_ms(tp);
 }
 
+/* Refresh clocks of a TCP socket,
+ * ensuring monotically increasing values.
+ */
+static inline void tcp_mstamp_refresh_inline(struct tcp_sock *tp)
+{
+	u64 val = tcp_clock_ns();
+
+	tp->tcp_clock_cache = val;
+	tp->tcp_mstamp = div_u64(val, NSEC_PER_USEC);
+}
 void tcp_mstamp_refresh(struct tcp_sock *tp);
 
 static inline u32 tcp_stamp_us_delta(u64 t1, u64 t0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d97606d8eb57aba8ebc2373adf1bed62b..7995a89bafc9d1d997b936eeac3964cdd7e7741a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6474,7 +6474,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	/* TCP congestion window tracking */
 	trace_tcp_probe(sk, skb);
 
-	tcp_mstamp_refresh(tp);
+	tcp_mstamp_refresh_inline(tp);
 	if (unlikely(!rcu_access_pointer(sk->sk_rx_dst)))
 		inet_csk(sk)->icsk_af_ops->sk_rx_dst_set(sk, skb);
 	/*
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f9d8755705f762fe4da3064d2b1bfce4828ec0c1..c8d7b5d20d1874bb7840e1c480195076830f1058 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -52,15 +52,9 @@
 
 #include <trace/events/tcp.h>
 
-/* Refresh clocks of a TCP socket,
- * ensuring monotically increasing values.
- */
-void tcp_mstamp_refresh(struct tcp_sock *tp)
+void noinline tcp_mstamp_refresh(struct tcp_sock *tp)
 {
-	u64 val = tcp_clock_ns();
-
-	tp->tcp_clock_cache = val;
-	tp->tcp_mstamp = div_u64(val, NSEC_PER_USEC);
+	tcp_mstamp_refresh_inline(tp);
 }
 
 static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
@@ -2971,7 +2965,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 
 	sent_pkts = 0;
 
-	tcp_mstamp_refresh(tp);
+	tcp_mstamp_refresh_inline(tp);
 
 	/* AccECN option beacon depends on mstamp, it may change mss */
 	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
-- 
2.54.0.545.g6539524ca2-goog


