Return-Path: <netdev+bounces-43027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1564C7D100B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380251C20FF3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF491D522;
	Fri, 20 Oct 2023 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KS+JcXwz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9F1CFA6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:12 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE8FD52
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso1040862276.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806690; x=1698411490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZy2MDzl8F3JktwSR5t+fl55CZZReZ2QqUWVgjfgzA=;
        b=KS+JcXwzTKK2/IvLt9dwdJIpVEP+0ONphimwksQLkdnFFcG2lCK2O6OSvmeozeEUTt
         FjkuJWLKHgzcBhwEHd3hj2R0gZ2hbgccG4BF2u4fU+7hkUZMeCoP0n+YF6hIkIPWH4sq
         y840ONLRQY9+oSNjxc9P18x1eesNpyvts3q6jo2rwDdefeew8Zg9gPFrbAMMSJGxASMB
         A1wtvXUe3u+DJXSM49YFQtps2TvgBoR3PnG+JcG+aGhuMb3mtk5a3TQFH1HBz7e1DKHR
         1xvk5ROMgCTOAk8j6pLx+sJa2BfeFmjkSezJ3OBbLTQcaCVAiOFbKQdT+zFxFg77gtnE
         2CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806690; x=1698411490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZy2MDzl8F3JktwSR5t+fl55CZZReZ2QqUWVgjfgzA=;
        b=qOJgbkRUHU4mt8MeK8usSU0uQF8e+FqID+FMBZ2qh67LBebNDMyydhPemzFgqcht3V
         JxTgmVdXE1noMGVoZ8XNc3XC9GhLcsYvgADF4mL8uh5Q4nWZ/3z81BRM1Kbgwn2pOsgl
         JmMlaVk/cS0D7ssZRGsOd29m6x1S5qKNxANudtLnGcnJSdlIVNpGBunn1yFY7kpanbQq
         HFkLmlTMW87iuj/FNPTJ5OXSwM9iAvJXaSrlQokpVDRHI7derQXxxRk1QD4CZOJoKSdO
         nDOGwPqyyZKnMAUl/6PmPA1gXWgjlcVXvT+KNw7UumqCT03rMlwPXhScF0pW3nxl6weT
         B1fA==
X-Gm-Message-State: AOJu0YwkEuouOhhoTvYFf4H5x+YDzjnzDkGxQ94/otYGdL6U7/p/pYcN
	SJywoIVNSqgxBJzX7AJ9p7eVOnNHv1YL+Q==
X-Google-Smtp-Source: AGHT+IGNjvzzmQwPvcnZH+roO5HtVV5va3neu3WzLZHMDt+UHcbMXl3+cK7nsorS9vZvqGKMOtGCHg9wnS4X1A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:bccc:0:b0:d9a:c218:8177 with SMTP id
 l12-20020a25bccc000000b00d9ac2188177mr40653ybm.8.1697806690149; Fri, 20 Oct
 2023 05:58:10 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:47 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-13-edumazet@google.com>
Subject: [PATCH net-next 12/13] tcp: add support for usec resolution in TCP TS values
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Back in 2015, Van Jacobson suggested to use usec resolution in TCP TS values.
This has been implemented in our private kernels.

Goals were :

1) better observability of delays in networking stacks.
2) better disambiguation of events based on TSval/ecr values.
3) building block for congestion control modules needing usec resolution.

Back then we implemented a schem based on private SYN options
to negotiate the feature.

For upstream submission, we chose to use a route attribute,
because this feature is probably going to be used in private
networks [1] [2].

ip route add 10/8 ... features tcp_usec_ts

Note that RFC 7323 recommends a
  "timestamp clock frequency in the range 1 ms to 1 sec per tick.",
but also mentions
  "the maximum acceptable clock frequency is one tick every 59 ns."

[1] Unfortunately RFC 7323 5.5 (Outdated Timestamps) suggests
to invalidate TS.Recent values after a flow was idle for more
than 24 days. This is the part making usec_ts a problem
for peers following this recommendation for long living
idle flows.

[2] Attempts to standardize usec ts went nowhere:

https://www.ietf.org/proceedings/97/slides/slides-97-tcpm-tcp-options-for-low-latency-00.pdf
https://datatracker.ietf.org/doc/draft-wang-tcpm-low-latency-opt/

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h              |  4 +++-
 include/net/inet_timewait_sock.h |  3 ++-
 include/net/tcp.h                |  6 +++--
 net/ipv4/syncookies.c            |  6 ++++-
 net/ipv4/tcp.c                   | 18 ++++++++++----
 net/ipv4/tcp_input.c             |  5 +++-
 net/ipv4/tcp_ipv4.c              |  1 +
 net/ipv4/tcp_minisocks.c         | 19 +++++++++++----
 net/ipv4/tcp_output.c            | 12 ++++++----
 net/ipv4/tcp_timer.c             | 40 +++++++++++++++++++++-----------
 net/ipv6/tcp_ipv6.c              |  1 +
 11 files changed, 82 insertions(+), 33 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 04a0e647ef747e5c83520cd1b1c2156d3a315ba5..6df715b6e51d4420d8835146a75d0655e71dea5b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -152,6 +152,7 @@ struct tcp_request_sock {
 	u64				snt_synack; /* first SYNACK sent time */
 	bool				tfo_listener;
 	bool				is_mptcp;
+	s8				req_usec_ts;
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool				drop_req;
 #endif
@@ -257,7 +258,8 @@ struct tcp_sock {
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
-		unused:5;
+		tcp_usec_ts:1, /* TSval values in usec */
+		unused:4;
 	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u8	chrono_type:2,	/* current chronograph type */
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 4a8e578405cb37856f07dac6ad0f1809f786682a..b14999ff55db1be505f371be48c26ff946062e83 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -67,7 +67,8 @@ struct inet_timewait_sock {
 	/* And these are ours. */
 	unsigned int		tw_transparent  : 1,
 				tw_flowlabel	: 20,
-				tw_pad		: 3,	/* 3 bits hole */
+				tw_usec_ts	: 1,
+				tw_pad		: 2,	/* 2 bits hole */
 				tw_tos		: 8;
 	u32			tw_txhash;
 	u32			tw_priority;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0ab577869d7ac61c5c3b687e98068a16b69bb3af..39b731c900dd53fa2683f316fcd779e8e16ec7e2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -825,6 +825,8 @@ static inline u32 tcp_time_stamp_ms(const struct tcp_sock *tp)
 
 static inline u32 tcp_time_stamp_ts(const struct tcp_sock *tp)
 {
+	if (tp->tcp_usec_ts)
+		return tp->tcp_mstamp;
 	return tcp_time_stamp_ms(tp);
 }
 
@@ -852,12 +854,12 @@ static inline u32 tcp_skb_timestamp_ts(bool usec_ts, const struct sk_buff *skb)
 
 static inline u32 tcp_tw_tsval(const struct tcp_timewait_sock *tcptw)
 {
-	return tcp_clock_ts(false) + tcptw->tw_ts_offset;
+	return tcp_clock_ts(tcptw->tw_sk.tw_usec_ts) + tcptw->tw_ts_offset;
 }
 
 static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 {
-	return tcp_clock_ts(false) + treq->ts_off;
+	return tcp_clock_ts(treq->req_usec_ts) + treq->ts_off;
 }
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 62395fdb0ca557caee78d84ae70273eb42a837b9..c6433436323096fe0e63f89e889687f74b57e387 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -84,7 +84,9 @@ u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 	if (ts > ts_now)
 		ts -= (1UL << TSBITS);
 
-	return ts * (NSEC_PER_SEC / TCP_TS_HZ);
+	if (tcp_rsk(req)->req_usec_ts)
+		return ts * NSEC_PER_USEC;
+	return ts * NSEC_PER_MSEC;
 }
 
 
@@ -304,6 +306,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	treq->af_specific = af_ops;
 
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
+	treq->req_usec_ts = -1;
+
 #if IS_ENABLED(CONFIG_MPTCP)
 	treq->is_mptcp = sk_is_mptcp(sk);
 	if (treq->is_mptcp) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 805f8341064fec4fe0504e14c579185cfe11d896..b961364b4961c5f6fada9b2f6828413dfc8307ed 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3629,10 +3629,16 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			tp->fastopen_no_cookie = val;
 		break;
 	case TCP_TIMESTAMP:
-		if (!tp->repair)
+		if (!tp->repair) {
 			err = -EPERM;
-		else
-			WRITE_ONCE(tp->tsoffset, val - tcp_clock_ts(false));
+			break;
+		}
+		/* val is an opaque field,
+		 * and low order bit contains usec_ts enable bit.
+		 * Its a best effort, and we do not care if user makes an error.
+		 */
+		tp->tcp_usec_ts = val & 1;
+		WRITE_ONCE(tp->tsoffset, val - tcp_clock_ts(tp->tcp_usec_ts));
 		break;
 	case TCP_REPAIR_WINDOW:
 		err = tcp_repair_set_window(tp, optval, optlen);
@@ -4143,7 +4149,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TIMESTAMP:
-		val = tcp_clock_ts(false) + READ_ONCE(tp->tsoffset);
+		val = tcp_clock_ts(tp->tcp_usec_ts) + READ_ONCE(tp->tsoffset);
+		if (tp->tcp_usec_ts)
+			val |= 1;
+		else
+			val &= ~1;
 		break;
 	case TCP_NOTSENT_LOWAT:
 		val = READ_ONCE(tp->notsent_lowat);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5666f61371678ce1c7bf466e0d54c0b7a396841b..18b858597af4ef62248f7c759cddf7224a681fc8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -698,6 +698,8 @@ static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp)
 	u32 delta, delta_us;
 
 	delta = tcp_time_stamp_ts(tp) - tp->rx_opt.rcv_tsecr;
+	if (tp->tcp_usec_ts)
+		return delta;
 
 	if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
 		if (!delta)
@@ -2452,7 +2454,7 @@ static bool tcp_skb_spurious_retrans(const struct tcp_sock *tp,
 				     const struct sk_buff *skb)
 {
 	return (TCP_SKB_CB(skb)->sacked & TCPCB_RETRANS) &&
-	       tcp_tsopt_ecr_before(tp, tcp_skb_timestamp_ts(false, skb));
+	       tcp_tsopt_ecr_before(tp, tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb));
 }
 
 /* Nothing was retransmitted or returned timestamp is less
@@ -7045,6 +7047,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	req->syncookie = want_cookie;
 	tcp_rsk(req)->af_specific = af_ops;
 	tcp_rsk(req)->ts_off = 0;
+	tcp_rsk(req)->req_usec_ts = -1;
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
 #endif
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cdd65cc594bc4571fa5793bc14d6e9ab892dfd2a..7583d4e34c8c5fedaf29177f458f7aa39ca0519a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -296,6 +296,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		rt = NULL;
 		goto failure;
 	}
+	tp->tcp_usec_ts = dst_tcp_usec_ts(&rt->dst);
 	/* OK, now commit destination to socket.  */
 	sk->sk_gso_type = SKB_GSO_TCPV4;
 	sk_setup_caps(sk, &rt->dst);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a9fdba897a28f3a5835a1bd1426f82de0e81a633..ace806c5bd0cdc2ec79eca5065e125418dd0c5b1 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -300,6 +300,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		tcptw->tw_ts_recent	= tp->rx_opt.ts_recent;
 		tcptw->tw_ts_recent_stamp = tp->rx_opt.ts_recent_stamp;
 		tcptw->tw_ts_offset	= tp->tsoffset;
+		tw->tw_usec_ts		= tp->tcp_usec_ts;
 		tcptw->tw_last_oow_ack_time = 0;
 		tcptw->tw_tx_delay	= tp->tcp_tx_delay;
 		tw->tw_txhash		= sk->sk_txhash;
@@ -554,21 +555,29 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->max_window = newtp->snd_wnd;
 
 	if (newtp->rx_opt.tstamp_ok) {
+		newtp->tcp_usec_ts = treq->req_usec_ts;
 		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
+		newtp->tcp_usec_ts = 0;
 		newtp->rx_opt.ts_recent_stamp = 0;
 		newtp->tcp_header_len = sizeof(struct tcphdr);
 	}
 	if (req->num_timeout) {
-		newtp->undo_marker = treq->snt_isn;
-		newtp->retrans_stamp = div_u64(treq->snt_synack,
-					       USEC_PER_SEC / TCP_TS_HZ);
 		newtp->total_rto = req->num_timeout;
+		newtp->undo_marker = treq->snt_isn;
+		if (newtp->tcp_usec_ts) {
+			newtp->retrans_stamp = treq->snt_synack;
+			newtp->total_rto_time = (u32)(tcp_clock_us() -
+						      newtp->retrans_stamp) / USEC_PER_MSEC;
+		} else {
+			newtp->retrans_stamp = div_u64(treq->snt_synack,
+						       USEC_PER_SEC / TCP_TS_HZ);
+			newtp->total_rto_time = tcp_clock_ms() -
+						newtp->retrans_stamp;
+		}
 		newtp->total_rto_recoveries = 1;
-		newtp->total_rto_time = tcp_clock_ms() -
-					newtp->retrans_stamp;
 	}
 	newtp->tsoffset = treq->ts_off;
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a1fec8be9ac36c67022c90b08b0a5faa935725f0..2866ccbccde073bff26182a0ad52446e84f789de 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -799,7 +799,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 
 	if (likely(READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps) && !*md5)) {
 		opts->options |= OPTION_TS;
-		opts->tsval = tcp_skb_timestamp_ts(false, skb) + tp->tsoffset;
+		opts->tsval = tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) + tp->tsoffset;
 		opts->tsecr = tp->rx_opt.ts_recent;
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
@@ -884,7 +884,8 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	}
 	if (likely(ireq->tstamp_ok)) {
 		opts->options |= OPTION_TS;
-		opts->tsval = tcp_skb_timestamp_ts(false, skb) + tcp_rsk(req)->ts_off;
+		opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
+			      tcp_rsk(req)->ts_off;
 		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
@@ -943,7 +944,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (likely(tp->rx_opt.tstamp_ok)) {
 		opts->options |= OPTION_TS;
-		opts->tsval = skb ? tcp_skb_timestamp_ts(false, skb) + tp->tsoffset : 0;
+		opts->tsval = skb ? tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) +
+				tp->tsoffset : 0;
 		opts->tsecr = tp->rx_opt.ts_recent;
 		size += TCPOLEN_TSTAMP_ALIGNED;
 	}
@@ -3379,7 +3381,7 @@ int tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 
 	/* Save stamp of the first (attempted) retransmit. */
 	if (!tp->retrans_stamp)
-		tp->retrans_stamp = tcp_skb_timestamp_ts(false, skb);
+		tp->retrans_stamp = tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb);
 
 	if (tp->undo_retrans < 0)
 		tp->undo_retrans = 0;
@@ -3665,6 +3667,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
+	if (tcp_rsk(req)->req_usec_ts < 0)
+		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
 	now = tcp_clock_ns();
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(synack_type == TCP_SYNACK_COOKIE && ireq->tstamp_ok))
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bfcf3fe44c72427eccb37376bec15fb71b594c56..1f9f6c1c196b2de35b0bc2f734484f09ba90541a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -26,14 +26,18 @@
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 elapsed, start_ts, user_timeout;
+	const struct tcp_sock *tp = tcp_sk(sk);
+	u32 elapsed, user_timeout;
 	s32 remaining;
 
-	start_ts = tcp_sk(sk)->retrans_stamp;
 	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	if (!user_timeout)
 		return icsk->icsk_rto;
-	elapsed = tcp_time_stamp_ts(tcp_sk(sk)) - start_ts;
+
+	elapsed = tcp_time_stamp_ts(tp) - tp->retrans_stamp;
+	if (tp->tcp_usec_ts)
+		elapsed /= USEC_PER_MSEC;
+
 	remaining = user_timeout - elapsed;
 	if (remaining <= 0)
 		return 1; /* user timeout has passed; fire ASAP */
@@ -212,12 +216,13 @@ static bool retransmits_timed_out(struct sock *sk,
 				  unsigned int boundary,
 				  unsigned int timeout)
 {
-	unsigned int start_ts;
+	struct tcp_sock *tp = tcp_sk(sk);
+	unsigned int start_ts, delta;
 
 	if (!inet_csk(sk)->icsk_retransmits)
 		return false;
 
-	start_ts = tcp_sk(sk)->retrans_stamp;
+	start_ts = tp->retrans_stamp;
 	if (likely(timeout == 0)) {
 		unsigned int rto_base = TCP_RTO_MIN;
 
@@ -226,7 +231,12 @@ static bool retransmits_timed_out(struct sock *sk,
 		timeout = tcp_model_timeout(sk, boundary, rto_base);
 	}
 
-	return (s32)(tcp_time_stamp_ts(tcp_sk(sk)) - start_ts - timeout) >= 0;
+	if (tp->tcp_usec_ts) {
+		/* delta maybe off up to a jiffy due to timer granularity. */
+		delta = tp->tcp_mstamp - start_ts + jiffies_to_usecs(1);
+		return (s32)(delta - timeout * USEC_PER_MSEC) >= 0;
+	}
+	return (s32)(tcp_time_stamp_ts(tp) - start_ts - timeout) >= 0;
 }
 
 /* A write timeout has occurred. Process the after effects. */
@@ -468,20 +478,18 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-				     const struct sk_buff *skb)
+				     const struct sk_buff *skb,
+				     u32 rtx_delta)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const int timeout = TCP_RTO_MAX * 2;
-	u32 rcv_delta, rtx_delta;
+	u32 rcv_delta;
 
 	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
-	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp_ts(tp) -
-			(tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb)));
-
-	return rtx_delta > timeout;
+	return msecs_to_jiffies(rtx_delta) > timeout;
 }
 
 /**
@@ -534,7 +542,11 @@ void tcp_retransmit_timer(struct sock *sk)
 		struct inet_sock *inet = inet_sk(sk);
 		u32 rtx_delta;
 
-		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb));
+		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ?: 
+				tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb));
+		if (tp->tcp_usec_ts)
+			rtx_delta /= USEC_PER_MSEC;
+
 		if (sk->sk_family == AF_INET) {
 			net_dbg_ratelimited("Probing zero-window on %pI4:%u/%u, seq=%u:%u, recv %ums ago, lasting %ums\n",
 				&inet->inet_daddr, ntohs(inet->inet_dport),
@@ -551,7 +563,7 @@ void tcp_retransmit_timer(struct sock *sk)
 				rtx_delta);
 		}
 #endif
-		if (tcp_rtx_probe0_timed_out(sk, skb)) {
+		if (tcp_rtx_probe0_timed_out(sk, skb, rtx_delta)) {
 			tcp_write_err(sk);
 			goto out;
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1ee6517e9b2f9d549268dea240a725976a9e2720..0c8a14ba104f29877a17beae0c378313e2b206b3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -286,6 +286,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		goto failure;
 	}
 
+	tp->tcp_usec_ts = dst_tcp_usec_ts(dst);
 	tcp_death_row = &sock_net(sk)->ipv4.tcp_death_row;
 
 	if (!saddr) {
-- 
2.42.0.655.g421f12c284-goog


