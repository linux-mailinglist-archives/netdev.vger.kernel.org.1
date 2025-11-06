Return-Path: <netdev+bounces-236313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24800C3ABDD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A6DD4E11ED
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D930EF63;
	Thu,  6 Nov 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QY4l73Cw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EB30DEB9
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429960; cv=none; b=IV/zfJjzEp+nz4psCo3YyJR6cU98RqorzjqSnWzmUecvlPGHTF6YMVCAiO9vXwGn9L5DdyF7ciNQii9Xw+5Hd6IMz6n9UjPu5+H9pDozn/f2TBhSVWZzfOhjv8RTkboW4+BVmLyBOjH+FdvGFt+hArcLdcZizFNC+aDsyELUTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429960; c=relaxed/simple;
	bh=rQlw/ptCX4JEH4pbk5oPJ3OGv7XEHoIZXVuDFYNWFSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tVeUTLDKQD6um6D5PMpinsVQDfCsCgtkLCfudhtJ9jHnShLT2sPvwBemx+gUeosZvBCOffHfzvIVhPnOGGjrFhL1y+Yd6Px5Uq72wNPg1nnYN1go6YStGjp1BiZTfE3Ns6fDxHYdiskkgaF81RewbbK6UQaJH4cCI3NceZa3uQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QY4l73Cw; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8805713e84fso8974266d6.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762429957; x=1763034757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1uEQIaSBvNJFzg+t9VMAyR1NqApVVuOfEZ+558GW5k=;
        b=QY4l73CwuEE7r4nD9z5CB0E48E4mryV1cFvr9/mFe3WU11BdNgof/gKpmZQPvJ8JhV
         9lv9DC1y25e/3qYHjlAGMPOiWQfu4FTo51yoVC1unpwQv7riLVtlnaVN0+VyQT8RahFs
         Y4a4v0WX6S23sn2sv3/qifGAFZkHhCWg3u+7XfSHpK8X92nEXkmcvGSowrpZBchviD47
         QipyM2feAf8pkyJ69kvi6TLQrbatbRH0BDom+wsNzX93tNnI0Y890wbb4ztcIogaW50C
         PlnLmhrRFw21QBKexguDs+ejkQx1yzhWOLvYv7glEhWQFiB/jqk2JXg3MTay2rNzebHD
         BleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429957; x=1763034757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1uEQIaSBvNJFzg+t9VMAyR1NqApVVuOfEZ+558GW5k=;
        b=ggjbYNtMsg0HoH0K36w8x1Xm1Li9GHFNERKpgNQLhRM7U70J/K+zOp9cW/FFjtmFrE
         2Bwsg7t1BtNRtHs4OLGOmgv629hJGK2hSsreNxqm+QYJpuRaxrv90D5tM4L3CHWu4Y0G
         1EufEKLVJKO2IHq8B+84jV29Oj10ibBUyqXY5aESnvA3qN7TdmsuEMpOwnl3Pw/HZYE3
         9UON3tmOmYwmuzVLa/RywBeFETQnVgbxfhyma/fKZgukpX+5iIaghrJfbq2GLEZ99Ho7
         7jUgmF108f8B+//PT9lf3qzZJAgql6WiVkdsi8zfCxGk7PtDtRL1DA7JP4gLrSfq5kHm
         BH3A==
X-Forwarded-Encrypted: i=1; AJvYcCWtcsBJjGvHmpNDyXnm3wVn63ICOJdVx+A1zGidhoOplHagE7tSODJhTTClnf68KLwhwo5FLCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvKaOLHqvRbssxVKU2XE0xi4G8VVIUi5we/daI4nH0/BhfClb
	sXuznYUMG9+RGLfQ65gNa806v/J2UgdiWSePtX93vRY9SUOlIQVZwsS8xrzaSKU7JLoSOyJOKAR
	5up8j7+LXoM1FRQ==
X-Google-Smtp-Source: AGHT+IFboHxOFX5cgzRzmANnNXOcfHHiGJr/u849tDVdAOVFOdf4TZd907wksP6IOp3usmk6AV6HgsJZUZdf+A==
X-Received: from qtbch9.prod.google.com ([2002:a05:622a:40c9:b0:4ed:6580:fbfd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d8a:b0:4e7:1f73:b40a with SMTP id d75a77b69052e-4ed721295bfmr97465881cf.1.1762429957588;
 Thu, 06 Nov 2025 03:52:37 -0800 (PST)
Date: Thu,  6 Nov 2025 11:52:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106115236.3450026-1-edumazet@google.com>
Subject: [PATCH v2 net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP SACK compression has been added in 2018 in commit
5d9f4262b7ea ("tcp: add SACK compression").

It is working great for WAN flows (with large RTT).
Wifi in particular gets a significant boost _when_ ACK are suppressed.

Add a new sysctl so that we can tune the very conservative 5 % value
that has been used so far in this formula, so that small RTT flows
can benefit from this feature.

delay = min ( 5 % of RTT, 1 ms)

This patch adds new tcp_comp_sack_rtt_percent sysctl
to ease experiments and tuning.

Given that we cap the delay to 1ms (tcp_comp_sack_delay_ns sysctl),
set the default value to 33 %.

Quoting Neal Cardwell ( https://lore.kernel.org/netdev/CADVnQymZ1tFnEA1Q=vtECs0=Db7zHQ8=+WCQtnhHFVbEOzjVnQ@mail.gmail.com/ )

The rationale for 33% is basically to try to facilitate pipelining,
where there are always at least 3 ACKs and 3 GSO/TSO skbs per SRTT, so
that the path can maintain a budget for 3 full-sized GSO/TSO skbs "in
flight" at all times:

+ 1 skb in the qdisc waiting to be sent by the NIC next
+ 1 skb being sent by the NIC (being serialized by the NIC out onto the wire)
+ 1 skb being received and aggregated by the receiver machine's
aggregation mechanism (some combination of LRO, GRO, and sack
compression)

Note that this is basically the same magic number (3) and the same
rationales as:

(a) tcp_tso_should_defer() ensuring that we defer sending data for no
longer than cwnd/tcp_tso_win_divisor (where tcp_tso_win_divisor = 3),
and
(b) bbr_quantization_budget() ensuring that cwnd is at least 3 GSO/TSO
skbs to maintain pipelining and full throughput at low RTTs

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: changed default to 33% (instead of 100% in v1)
v1: https://lore.kernel.org/netdev/CANn89iJpinbbrU2YxiWNQa9b2vQ035A75g00hWFLce-CAJi9hA@mail.gmail.com/T/#m5047025977aaddcd2c1b2ed0117fd2177898fa87

 Documentation/networking/ip-sysctl.rst | 13 +++++++++++--
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 net/ipv4/tcp_input.c                   | 26 ++++++++++++++++++--------
 net/ipv4/tcp_ipv4.c                    |  1 +
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7cd35bfd39e68c5b2650eb9d0fbb76e34aed3f2b..2bae61be18593a8111a83d9f034517e4646eb653 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -854,9 +854,18 @@ tcp_sack - BOOLEAN
 
 	Default: 1 (enabled)
 
+tcp_comp_sack_rtt_percent - INTEGER
+	Percentage of SRTT used for the compressed SACK feature.
+	See tcp_comp_sack_nr, tcp_comp_sack_delay_ns, tcp_comp_sack_slack_ns.
+
+	Possible values : 1 - 1000
+
+	Default : 33 %
+
 tcp_comp_sack_delay_ns - LONG INTEGER
-	TCP tries to reduce number of SACK sent, using a timer
-	based on 5% of SRTT, capped by this sysctl, in nano seconds.
+	TCP tries to reduce number of SACK sent, using a timer based
+	on tcp_comp_sack_rtt_percent of SRTT, capped by this sysctl
+	in nano seconds.
 	The default is 1ms, based on TSO autosizing period.
 
 	Default : 1,000,000 ns (1 ms)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 0e96c90e56c6d987a16598ef885c403d5c3eae52..de9d36acc8e22d3203120d8015b3d172e85de121 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -221,6 +221,7 @@ struct netns_ipv4 {
 	int sysctl_tcp_pacing_ss_ratio;
 	int sysctl_tcp_pacing_ca_ratio;
 	unsigned int sysctl_tcp_child_ehash_entries;
+	int sysctl_tcp_comp_sack_rtt_percent;
 	unsigned long sysctl_tcp_comp_sack_delay_ns;
 	unsigned long sysctl_tcp_comp_sack_slack_ns;
 	int sysctl_max_syn_backlog;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 0c7c8f9041cbf4aa4e51dcebd607aa5d8ac80dcd..35367f8e2da32f2c7de5a06164f5e47c8929c8f1 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1451,6 +1451,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
+	{
+		.procname	= "tcp_comp_sack_rtt_percent",
+		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_rtt_percent,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE_THOUSAND,
+	},
 	{
 		.procname	= "tcp_comp_sack_slack_ns",
 		.data		= &init_net.ipv4.sysctl_tcp_comp_sack_slack_ns,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6db1d4c36a88bfa64b48388ee95e4e9218d9a9fd..d4ee74da018ee97209bed3402688f5e18759866b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5893,7 +5893,9 @@ static inline void tcp_data_snd_check(struct sock *sk)
 static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	unsigned long rtt, delay;
+	struct net *net = sock_net(sk);
+	unsigned long rtt;
+	u64 delay;
 
 	    /* More than one full frame received... */
 	if (((tp->rcv_nxt - tp->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss &&
@@ -5912,7 +5914,7 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 		 * Defer the ack until tcp_release_cb().
 		 */
 		if (sock_owned_by_user_nocheck(sk) &&
-		    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_backlog_ack_defer)) {
+		    READ_ONCE(net->ipv4.sysctl_tcp_backlog_ack_defer)) {
 			set_bit(TCP_ACK_DEFERRED, &sk->sk_tsq_flags);
 			return;
 		}
@@ -5927,7 +5929,7 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 	}
 
 	if (!tcp_is_sack(tp) ||
-	    tp->compressed_ack >= READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_nr))
+	    tp->compressed_ack >= READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_nr))
 		goto send_now;
 
 	if (tp->compressed_ack_rcv_nxt != tp->rcv_nxt) {
@@ -5942,18 +5944,26 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 	if (hrtimer_is_queued(&tp->compressed_ack_timer))
 		return;
 
-	/* compress ack timer : 5 % of rtt, but no more than tcp_comp_sack_delay_ns */
+	/* compress ack timer : comp_sack_rtt_percent of rtt,
+	 * but no more than tcp_comp_sack_delay_ns.
+	 */
 
 	rtt = tp->rcv_rtt_est.rtt_us;
 	if (tp->srtt_us && tp->srtt_us < rtt)
 		rtt = tp->srtt_us;
 
-	delay = min_t(unsigned long,
-		      READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_delay_ns),
-		      rtt * (NSEC_PER_USEC >> 3)/20);
+	/* delay = (rtt >> 3) * NSEC_PER_USEC * comp_sack_rtt_percent / 100
+	 * ->
+	 * delay = rtt * 1.25 * comp_sack_rtt_percent
+	 */
+	delay = (u64)(rtt + (rtt >> 2)) *
+		READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_rtt_percent);
+
+	delay = min(delay, READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_delay_ns));
+
 	sock_hold(sk);
 	hrtimer_start_range_ns(&tp->compressed_ack_timer, ns_to_ktime(delay),
-			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_slack_ns),
+			       READ_ONCE(net->ipv4.sysctl_tcp_comp_sack_slack_ns),
 			       HRTIMER_MODE_REL_PINNED_SOFT);
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b7526a7888cbe296c0f4ba6350772741cfe1765b..851ed25dd90318db3872e824d916316bbf9aa973 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3596,6 +3596,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
 	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 100 * NSEC_PER_USEC;
 	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
+	net->ipv4.sysctl_tcp_comp_sack_rtt_percent = 33;
 	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
 	net->ipv4.sysctl_tcp_fastopen = TFO_CLIENT_ENABLE;
 	net->ipv4.sysctl_tcp_fastopen_blackhole_timeout = 0;
-- 
2.51.2.1026.g39e6a42477-goog


