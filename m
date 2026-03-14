Return-Path: <netdev+bounces-267852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG+7GFHCtWkV4wAAu9opvQ
	(envelope-from <netdev+bounces-267852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:17:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D528ECF4
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD0B306221D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC545384235;
	Sat, 14 Mar 2026 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzoTk/o5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4873845D4
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519290; cv=none; b=DyKannA8rXuGN66PS+StEw1kPvnAzcitzIflefp0Gx/PHiwaRW++bj9O3wfEppA6VxPXnTBgwpfBVxNR/ngEO7bCnKFkSuifF3aVGCFp0Yh5NttB9M01nAphTVFn26YE9dSAjNyAXdOqejS/NzZY15xWEcsSb8E/+jM6Jr3wOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519290; c=relaxed/simple;
	bh=2EkRqoGXrOUfHB63oRGb5TDy5HRb1y3sBh+IDjMEZ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/NN2DyjukGXRwMvC7aPPsgI0QnO1+1h3TkWPN0WZ4MAtSzyfMl3EenPCTcAvU31oXqfQ0u3khx4TE2E4gT82aS1cOvuzlAWPjzHzSeORQO50BmwKfeuDMxZeGUr2fQoNOyJ97vYL9c9ONYLB3Zhhy+s/XYFzKslcTcg3ffBEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzoTk/o5; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-466f935a82fso2214925b6e.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519287; x=1774124087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTjO+z47PYHq3eZ5eRulxWts7U/pAeGFmyBg9Cf0dZo=;
        b=HzoTk/o5XQt2v5xx6QWk4rY+G7uNBLanSaRLHwKz95tFB/BvzUyoGHa5eOB5czVkHs
         V3L/nLCvUIiGtHmHLYnZ9jXmCBezPi+C8kdLT55PArkjtvm6M621to35zQEPJ8rZQI2M
         fPEv6rR04ooH/PiKYB7W9CVCnCYgVGETeTBbFl2pLn+///r6iMKa183QViv+VqD6F7eF
         sfIet1IdIhHSMIkgYGrkB9ZV+B62OM9N2JeftpkP+SPPZWqlueQ7i+s0XxmEhbsBTMLP
         GFwo2dar5HRcXBYl1RXgZbSkBjeTBO21fmwH0mCYtJrQnwaRm/oBtpOiomxwI7sgDnU7
         TXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519287; x=1774124087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTjO+z47PYHq3eZ5eRulxWts7U/pAeGFmyBg9Cf0dZo=;
        b=XO+kviI8rvMJSw6tebNZ2qeQmxrg03eFww5EMqGl5aBtmGPXV3o1jBwrqk8hUlGWpC
         HM239Sn2ZCIcPg1vVqjb7MJ07+iKjQDpSqhFOT2HaQTgRXi1lYMvIFBvO1Xle5uhEYNs
         Prx/JzR6ObPhM6ErROMQYPEun9sOkE5xNDoWUki5PQn+LJQsBjRA0Pl7Pi1J9NWrjCt7
         XlIpSGqSsJG2BqHG2G2EcCCn1CbVZcjRbLl78r7kTfRHgQ3+JVLvQzLAh50iXJLwBsFX
         Wskl4LNsJtmS1fe3pP//cFjhNKpd17G3CKI//Id/EjvO8kyQfRzBpIVTLrYDTF1SpOD5
         P8GA==
X-Gm-Message-State: AOJu0YwgE3wFDXowqZ9Wz0t1ka2eaUc0aLbKgvLkTfZFHMTWJ8t5jewc
	+N8xYuCLDp08qDadhtBC1KkapjD9fyf+L3X/gsHPqYqNPu4G9Q2jSwPQn5vci6E4ha0=
X-Gm-Gg: ATEYQzxuzf70jepXjKH/B4lS2C2faojHgpIZTTIIS8SHfm5efml4gjc8o22rTjNiRFI
	qEUddbtmTj4DafHvUkjjvvS82C8KW15iXTftMonBO6zoFOpxgJBfJKCOuMVVCfz6U855I0isQhM
	wPcmSoR/GERtIH2WJZL306Z39B8o2rL89z1DbyBQU2zwrUX5lhqVPbSVJyAUVyE0hiR9lDZdfh6
	u1D1sk4bQgcIayVPGxSGWHNv624wJb//w4kvjOfuRgU6KDoLaT5VsYi6nQXdfviqdpIM7Oc324L
	pbAyhFgYRbLLv4jWaXww5u2sfmL1cZyGi94hwe8PKmth5KFzAGwoZbHXD/w9neCn3TJjpgaWLMx
	NNSpvBELQOQkUTMXxtWM8n/pFLCyrHVoNrarOqSeSQ3zoXpIjs9gA7qtCns3aSrQ5GhYQs6R0dD
	ftMBLzRS1VFoP69cFYXSU/4RatVELWdCNC4kl6qsQ+YUfmi1Iy7txo/wuQ28c7sC4szu7H4U/uP
	2JilQHJoPoYNv0ErHN2DRRLAx66KtnEKH+acbP3Tk9bSHRn9FI=
X-Received: by 2002:a05:6808:23d1:b0:467:15ad:9de5 with SMTP id 5614622812f47-467570a27f2mr4101052b6e.13.1773519287456;
        Sat, 14 Mar 2026 13:14:47 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:47 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 04/14] tcp: snapshot the maximum advertised receive window
Date: Sat, 14 Mar 2026 14:13:38 -0600
Message-ID: <20260314201348.1786972-5-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267852-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B92D528ECF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

Track the maximum sender-visible receive-window right edge separately
from the live rwnd, along with the scaling basis that was in force when
that larger window was advertised.

This gives later admission and restore paths enough information to
reason about retracted windows without losing the original sender-
visible bound.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 include/net/tcp.h                             | 21 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  1 +
 net/ipv4/tcp_fastopen.c                       |  2 +-
 net/ipv4/tcp_input.c                          |  4 ++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 net/ipv4/tcp_output.c                         |  2 +-
 8 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 09ece1c59c2d..d58a3b1eb55d 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -11,6 +11,7 @@ Type                          Name                    fastpath_tx_access  fastpa
 struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
+u8                            rcv_mwnd_scaling_ratio  read_write          read_mostly         tcp_init_max_rcv_wnd_seq,tcp_update_max_rcv_wnd_seq,tcp_repair_set_window,do_tcp_getsockopt
 u8                            rcv_wnd_scaling_ratio   read_write          read_mostly         tcp_set_rcv_wnd,tcp_can_ingest,tcp_repair_set_window,do_tcp_getsockopt
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2ace563d59d6..e5d7a65ac439 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -297,6 +297,7 @@ struct tcp_sock {
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		prev_ecnfield:2; /* ECN bits from the previous segment */
+	u8	rcv_mwnd_scaling_ratio; /* 0 if unknown, else tp->rcv_mwnd_seq basis */
 	u8	rcv_wnd_scaling_ratio; /* 0 if unknown, else tp->rcv_wnd basis */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6fa7cdb0979e..fc22ab6b80d5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -947,13 +947,21 @@ static inline u32 tcp_max_receive_window(const struct tcp_sock *tp)
 	return (u32) win;
 }
 
+static inline void tcp_init_max_rcv_wnd_seq(struct tcp_sock *tp)
+{
+	tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+	tp->rcv_mwnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
+}
+
 /* Check if we need to update the maximum receive window sequence number */
 static inline void tcp_update_max_rcv_wnd_seq(struct tcp_sock *tp)
 {
 	u32 wre = tp->rcv_wup + tp->rcv_wnd;
 
-	if (after(wre, tp->rcv_mwnd_seq))
+	if (after(wre, tp->rcv_mwnd_seq)) {
 		tp->rcv_mwnd_seq = wre;
+		tp->rcv_mwnd_scaling_ratio = tp->rcv_wnd_scaling_ratio;
+	}
 }
 
 /* Choose a new window, without checks for shrinking, and without
@@ -1766,6 +1774,16 @@ static inline bool tcp_space_from_rcv_wnd(const struct tcp_sock *tp, int win,
 					   space);
 }
 
+/* Same as tcp_space_from_rcv_wnd(), but for the remembered maximum
+ * sender-visible receive window.
+ */
+static inline bool tcp_space_from_rcv_mwnd(const struct tcp_sock *tp, int win,
+					   int *space)
+{
+	return tcp_space_from_wnd_snapshot(tp->rcv_mwnd_scaling_ratio, win,
+					   space);
+}
+
 /* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
@@ -1776,6 +1794,7 @@ static inline void tcp_scaling_ratio_init(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	tp->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+	tp->rcv_mwnd_scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	tp->rcv_wnd_scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0383ee8d3b78..66706dbb90f5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5275,6 +5275,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_mwnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd_scaling_ratio);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_mwnd_seq);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 4e389d609f91..56113cf2a165 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -377,7 +377,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 
 	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
 	tp->rcv_wup = tp->rcv_nxt;
-	tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+	tcp_init_max_rcv_wnd_seq(tp);
 	/* tcp_conn_request() is sending the SYNACK,
 	 * and queues the child into listener accept queue.
 	 */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b8e65e31255e..352f814a4ff6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6902,7 +6902,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
-		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+		tcp_init_max_rcv_wnd_seq(tp);
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
@@ -7015,7 +7015,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
-		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+		tcp_init_max_rcv_wnd_seq(tp);
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1c02c9cd13fe..85bd9580caf9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -604,7 +604,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
 	tcp_set_rcv_wnd(newtp, req->rsk_rcv_wnd);
-	newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
+	tcp_init_max_rcv_wnd_seq(newtp);
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
 		newtp->rx_opt.snd_wscale = ireq->snd_wscale;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0b082726d7c4..57a2a6daaad3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4171,7 +4171,7 @@ static void tcp_connect_init(struct sock *sk)
 	else
 		tp->rcv_tstamp = tcp_jiffies32;
 	tp->rcv_wup = tp->rcv_nxt;
-	tp->rcv_mwnd_seq = tp->rcv_nxt + tp->rcv_wnd;
+	tcp_init_max_rcv_wnd_seq(tp);
 	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 
 	inet_csk(sk)->icsk_rto = tcp_timeout_init(sk);
-- 
2.43.0


