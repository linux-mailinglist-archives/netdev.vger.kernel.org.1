Return-Path: <netdev+bounces-164052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C7A2C71D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B6C16B1DC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBFF24060F;
	Fri,  7 Feb 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0Um+V9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68269240601
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942121; cv=none; b=SpcXBmCcjCFA4VGuo6OaV4tsqwz6Fy9ddTHZdCajwP7ZdZk4o4bdohaGRZwFtfVRv6rz3urlz5bWJslMLFjxg8wj8/J+GdkY3KJ4tVPc+ZAwJvXxRIq8jh8ancAPAycCvvhGqZDWHzYwoJJbLsKPPtm+MaUe+nSUF+jPjBgig+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942121; c=relaxed/simple;
	bh=5Gavabx2R0XQUiiK+32nI5HXxn6djtrTdXyVHBALpX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EM7TcsPp+grL9KgtBBUGq45Q4cJ96abv9nXfhRSUFMr6j+Ax5E6ZhQGjn/uCoXbx8qzJwOxf8+4latSRySBeMZao8OCTJzkaOSSarxDyQejq7x9O0e/AHFrlUfnDA9aYgSEjaf8sQRGAsiIslm4a/CzAc+ta9Y6HhUaGH4A0Ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0Um+V9B; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6ef813ed1so339534785a.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942118; x=1739546918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wl1W2qK3gqkgENzJSWy11s8DhH1P1fDEfnjTkCM7ikI=;
        b=i0Um+V9Bw3cG7TnO5i7QUIlQtLGVur2VMTfgt890t5kAuqq0tZM6dmRnIxWDZqrJmy
         1XGQkNk88EhF+FEfQVO5GREW7JqPsZqDnthlugqAvtlTtgy6bZ7UqK3nGw6+o8zMUsCA
         EXs6XIJPyqcBG1yJdBSiAB5ayo7x/5DGkRhARX5S3z+dPAQoAbJj5RzI+2FWBUTTsgXs
         /FQa5oeD6kjTY7l8fy3ZdNagZBDPqZHzeV/aYX0sH3a8m+KBaskQQ/lH4Yr1K4W2bTOH
         0cp/OxLKth7d9aCNPc7jjVp5gmOnrnh157RGBnBDIBMM2vO3Z56sCzrtNIm/gwrOyWJt
         qY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942118; x=1739546918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wl1W2qK3gqkgENzJSWy11s8DhH1P1fDEfnjTkCM7ikI=;
        b=N3tVdcOHLCIKbZia+R7FbCVdcVd9mAcr7sR87dPmjVaTNbZO9XUXjkQ/b5DE5BI8GV
         P9ytxwbZDVeZt6cr9djAo6XXs2SuZFv3UaeyV5w5G2+7vECcKFfkdUDIRpsvWnTi4lOn
         YoIv732FPBVI6W7X56Ln13j6nRV02dz27iDHgax7WSt8Jznx3apufDsDdKpGnaJoiTlb
         mG/wpMw73NcVBtscaZxXCwbjLIOkc+cqMIfQlX/vC2XfR1rLxQ3SCFaqCDqtvtmEWlhE
         fcYdbx3CCMZOFktDAsb0rPMZ7421ixAy90AQtd4kdubBg+1LJDGWo+9ouIjqQvegodbE
         GL9g==
X-Gm-Message-State: AOJu0YyRQu3rXQqScs4dCTKh/eME8DLwb5+MWTBMrUcDyoObmc/9d5vX
	EML3yWr8h1bQXgZ7QlqHFkjQSXniMnrdVRcyZDfG45ataBC4bAQg22+ztV9t1UAHtG2xp/Q70b5
	tQni78X1bxw==
X-Google-Smtp-Source: AGHT+IG7T6Dz4Hj21V77t4HE850562JfuN9/5gZGJ+CybZm6iO5nh3tw7x6nPS6Y1moRe/GcU/h2GKixxZMDNg==
X-Received: from qkoz14.prod.google.com ([2002:a05:620a:260e:b0:7b6:df7f:374b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2586:b0:7b6:deaa:3189 with SMTP id af79cd13be357-7c047c9b4d5mr633741985a.54.1738942118286;
 Fri, 07 Feb 2025 07:28:38 -0800 (PST)
Date: Fri,  7 Feb 2025 15:28:29 +0000
In-Reply-To: <20250207152830.2527578-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207152830.2527578-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] tcp: add the ability to control max RTO
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, TCP stack uses a constant (120 seconds)
to limit the RTO value exponential growth.

Some applications want to set a lower value.

Add TCP_RTO_MAX_MS socket option to set a value (in ms)
between 1 and 120 seconds.

It is discouraged to change the socket rto max on a live
socket, as it might lead to unexpected disconnects.

Following patch is adding a netns sysctl to control the
default value at socket creation time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net_cachelines/inet_connection_sock.rst     |  1 +
 include/net/inet_connection_sock.h              |  1 +
 include/net/tcp.h                               | 16 +++++++++++-----
 include/uapi/linux/tcp.h                        |  1 +
 net/ipv4/tcp.c                                  | 12 ++++++++++++
 net/ipv4/tcp_input.c                            |  2 +-
 net/ipv4/tcp_ipv4.c                             |  2 +-
 net/ipv4/tcp_output.c                           |  4 ++--
 net/ipv4/tcp_timer.c                            | 17 +++++++++--------
 9 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index 4a15627fc93b8438342165a47e58c2ff10ce13d2..b2401aa7c45090b07c2262ac31a3584725f92233 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -17,6 +17,7 @@ struct timer_list                   icsk_retransmit_timer  read_mostly
 struct timer_list                   icsk_delack_timer      read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
 u32                                 icsk_rto               read_write                              tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_connect_init,tcp_connect,tcp_write_xmit,tcp_push_one
 u32                                 icsk_rto_min
+u32                                 icsk_rto_max           read_mostly                             tcp_reset_xmit_timer
 u32                                 icsk_delack_max
 u32                                 icsk_pmtu_cookie       read_write                              tcp_sync_mss,tcp_current_mss,tcp_send_syn_data,tcp_connect_init,tcp_connect
 struct tcp_congestion_ops           icsk_ca_ops            read_write                              tcp_cwnd_validate,tcp_tso_segs,tcp_ca_dst_init,tcp_connect_init,tcp_connect,tcp_write_xmit
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c7f42844c79a9bde6d77c457f392229b1d3a9d5c..fc160175adb0fc719e089ae7c42418f64c2bd873 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -90,6 +90,7 @@ struct inet_connection_sock {
  	struct timer_list	  icsk_delack_timer;
 	__u32			  icsk_rto;
 	__u32                     icsk_rto_min;
+	u32			  icsk_rto_max;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
 	const struct tcp_congestion_ops *icsk_ca_ops;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9472ec438aaa53580bd2f6d5b320005e6dcceb29..f622505781ce55e102318e85a5cede0b6a3a28b0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -143,8 +143,9 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_DELACK_MIN	4U
 #define TCP_ATO_MIN	4U
 #endif
-#define TCP_RTO_MAX	((unsigned)(120*HZ))
-#define TCP_RTO_MIN	((unsigned)(HZ/5))
+#define TCP_RTO_MAX_SEC 120
+#define TCP_RTO_MAX	((unsigned)(TCP_RTO_MAX_SEC * HZ))
+#define TCP_RTO_MIN	((unsigned)(HZ / 5))
 #define TCP_TIMEOUT_MIN	(2U) /* Min timeout for TCP timers in jiffies */
 
 #define TCP_TIMEOUT_MIN_US (2*USEC_PER_MSEC) /* Min TCP timeout in microsecs */
@@ -739,10 +740,14 @@ int tcp_mtu_to_mss(struct sock *sk, int pmtu);
 int tcp_mss_to_mtu(struct sock *sk, int mss);
 void tcp_mtup_init(struct sock *sk);
 
+static inline unsigned int tcp_rto_max(const struct sock *sk)
+{
+	return READ_ONCE(inet_csk(sk)->icsk_rto_max);
+}
+
 static inline void tcp_bound_rto(struct sock *sk)
 {
-	if (inet_csk(sk)->icsk_rto > TCP_RTO_MAX)
-		inet_csk(sk)->icsk_rto = TCP_RTO_MAX;
+	inet_csk(sk)->icsk_rto = min(inet_csk(sk)->icsk_rto, tcp_rto_max(sk));
 }
 
 static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
@@ -1427,7 +1432,8 @@ static inline void tcp_reset_xmit_timer(struct sock *sk,
 {
 	if (pace_delay)
 		when += tcp_pacing_delay(sk);
-	inet_csk_reset_xmit_timer(sk, what, when, TCP_RTO_MAX);
+	inet_csk_reset_xmit_timer(sk, what, when,
+				  tcp_rto_max(sk));
 }
 
 /* Something is really bad, we could not queue an additional packet,
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dbf896f3146c5fb2a35d68f8633fda4e0b74a6fb..32a27b4a5020ad066d5e443b04a3a2e34fbf6178 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -136,6 +136,7 @@ enum {
 #define TCP_AO_REPAIR		42	/* Get/Set SNEs and ISNs */
 
 #define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7f43d31c9400ef450ad6f2124aeb5babc1085499..a9b92d8bfb5644431683ec214aedd0e9756e8a0a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -432,6 +432,10 @@ void tcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
 
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
+
+	/* Use a sysctl ? */
+	icsk->icsk_rto_max = TCP_RTO_MAX;
+
 	rto_min_us = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rto_min_us);
 	icsk->icsk_rto_min = usecs_to_jiffies(rto_min_us);
 	icsk->icsk_delack_max = TCP_DELACK_MAX;
@@ -3807,6 +3811,11 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
 					   TCP_RTO_MAX / HZ));
 		return 0;
+	case TCP_RTO_MAX_MS:
+		if (val < MSEC_PER_SEC || val > TCP_RTO_MAX_SEC * MSEC_PER_SEC)
+			return -EINVAL;
+		WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies(val));
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -4643,6 +4652,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_IS_MPTCP:
 		val = 0;
 		break;
+	case TCP_RTO_MAX_MS:
+		val = jiffies_to_msecs(tcp_rto_max(sk));
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5a79253bfa1906e1fe26625f6644e765e962b0e9..042155c0399f0db97ae78a06fa297428a140e630 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3558,7 +3558,7 @@ static void tcp_ack_probe(struct sock *sk)
 		 * This function is not for random using!
 		 */
 	} else {
-		unsigned long when = tcp_probe0_when(sk, TCP_RTO_MAX);
+		unsigned long when = tcp_probe0_when(sk, tcp_rto_max(sk));
 
 		when = tcp_clamp_probe0_to_user_timeout(sk, when);
 		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, true);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e065f7097611b70f41e75502d7d6f9248af1c85f..06fb0123d2d60e22f19ea48b73ac3668c51465a2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -458,7 +458,7 @@ void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
 
 	icsk->icsk_backoff--;
 	icsk->icsk_rto = tp->srtt_us ? __tcp_set_rto(tp) : TCP_TIMEOUT_INIT;
-	icsk->icsk_rto = inet_csk_rto_backoff(icsk, TCP_RTO_MAX);
+	icsk->icsk_rto = inet_csk_rto_backoff(icsk, tcp_rto_max(sk));
 
 	tcp_mstamp_refresh(tp);
 	delta_us = (u32)(tp->tcp_mstamp - tcp_skb_timestamp_us(skb));
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e198435a9ca66a0920e1dbcff35d875c1e384037..2e67c731710252fb9f55a604e6c27146d193514b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4252,7 +4252,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 		unsigned long delay;
 
 		delay = TCP_DELACK_MAX << icsk->icsk_ack.retry;
-		if (delay < TCP_RTO_MAX)
+		if (delay < tcp_rto_max(sk))
 			icsk->icsk_ack.retry++;
 		inet_csk_schedule_ack(sk);
 		icsk->icsk_ack.ato = TCP_ATO_MIN;
@@ -4392,7 +4392,7 @@ void tcp_send_probe0(struct sock *sk)
 	if (err <= 0) {
 		if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
 			icsk->icsk_backoff++;
-		timeout = tcp_probe0_when(sk, TCP_RTO_MAX);
+		timeout = tcp_probe0_when(sk, tcp_rto_max(sk));
 	} else {
 		/* If packet was not sent due to local congestion,
 		 * Let senders fight for local resources conservatively.
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index c73c7db362cb2bea8044ad928232f50bdc4b9bd7..0802a6e64dea6777bfdb06986a324c512b00913a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -109,7 +109,7 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 
 	/* If peer does not open window for long time, or did not transmit
 	 * anything for long time, penalize it. */
-	if ((s32)(tcp_jiffies32 - tp->lsndtime) > 2*TCP_RTO_MAX || !do_reset)
+	if ((s32)(tcp_jiffies32 - tp->lsndtime) > 2*tcp_rto_max(sk) || !do_reset)
 		shift++;
 
 	/* If some dubious ICMP arrived, penalize even more. */
@@ -189,12 +189,12 @@ static unsigned int tcp_model_timeout(struct sock *sk,
 {
 	unsigned int linear_backoff_thresh, timeout;
 
-	linear_backoff_thresh = ilog2(TCP_RTO_MAX / rto_base);
+	linear_backoff_thresh = ilog2(tcp_rto_max(sk) / rto_base);
 	if (boundary <= linear_backoff_thresh)
 		timeout = ((2 << boundary) - 1) * rto_base;
 	else
 		timeout = ((2 << linear_backoff_thresh) - 1) * rto_base +
-			(boundary - linear_backoff_thresh) * TCP_RTO_MAX;
+			(boundary - linear_backoff_thresh) * tcp_rto_max(sk);
 	return jiffies_to_msecs(timeout);
 }
 /**
@@ -268,7 +268,7 @@ static int tcp_write_timeout(struct sock *sk)
 
 		retry_until = READ_ONCE(net->ipv4.sysctl_tcp_retries2);
 		if (sock_flag(sk, SOCK_DEAD)) {
-			const bool alive = icsk->icsk_rto < TCP_RTO_MAX;
+			const bool alive = icsk->icsk_rto < tcp_rto_max(sk);
 
 			retry_until = tcp_orphan_retries(sk, alive);
 			do_reset = alive ||
@@ -416,7 +416,8 @@ static void tcp_probe_timer(struct sock *sk)
 	}
 	max_probes = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_retries2);
 	if (sock_flag(sk, SOCK_DEAD)) {
-		const bool alive = inet_csk_rto_backoff(icsk, TCP_RTO_MAX) < TCP_RTO_MAX;
+		unsigned int rto_max = tcp_rto_max(sk);
+		const bool alive = inet_csk_rto_backoff(icsk, rto_max) < rto_max;
 
 		max_probes = tcp_orphan_retries(sk, alive);
 		if (!alive && icsk->icsk_backoff >= max_probes)
@@ -492,7 +493,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 	u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	int timeout = TCP_RTO_MAX * 2;
+	int timeout = tcp_rto_max(sk) * 2;
 	s32 rcv_delta;
 
 	if (user_timeout) {
@@ -665,7 +666,7 @@ void tcp_retransmit_timer(struct sock *sk)
 		icsk->icsk_backoff = 0;
 		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
 				       tcp_rto_min(sk),
-				       TCP_RTO_MAX);
+				       tcp_rto_max(sk));
 	} else if (sk->sk_state != TCP_SYN_SENT ||
 		   tp->total_rto >
 		   READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
@@ -673,7 +674,7 @@ void tcp_retransmit_timer(struct sock *sk)
 		 * activated.
 		 */
 		icsk->icsk_backoff++;
-		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
+		icsk->icsk_rto = min(icsk->icsk_rto << 1, tcp_rto_max(sk));
 	}
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 			     tcp_clamp_rto_to_user_timeout(sk), false);
-- 
2.48.1.502.g6dc24dfdaf-goog


