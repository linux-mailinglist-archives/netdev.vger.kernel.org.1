Return-Path: <netdev+bounces-239127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B2C645DC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13CE3AB29C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D9332903;
	Mon, 17 Nov 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDPXYZJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5A3321B2
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386090; cv=none; b=NK0TkL3RpWoqNpPDzPa88j23xHeamt5EWxJ8IOtg3fR9klzWLjgoqcBI4qOSTVMICAD5WlBpWTnBWEKGnrP5CYAy2TsEFpW1fJounqPUdvETbi2jo49RUzpfMtZz7IFqyoKirg49n4l8DQdKobPCuz3JUmy7boE2cABMDIaBX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386090; c=relaxed/simple;
	bh=nRuXi0PK6HqyorDhrLYYsTPqkAb8R0BJn0lqyP6eaMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DH7rqBUL53P64nHWfKXZCsqVr8Mt/CrEQ4fRkw5kxrUEYrCD6xOLVY9SwVDo72wyRWRNvKvhuxvk3gi8twTXwQHNQRmiaUvu2BNlKiak4ew4GnKQL+igTuHfiognZcTvYWA6AsGqHfg85iHY8Dcifa8oSnzozUyOdc6OElTmLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDPXYZJB; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88050708ac2so30299576d6.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763386088; x=1763990888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=stfqZg9bH28bp8D3EFO+GVsIQXazaY5RHr1timPZPyQ=;
        b=EDPXYZJBONQMWsscNSjrrZ+CrGKlicPIvVemngCIHXHSesrLG21136SQD5WV/c+9B9
         fvuitjD7n7+Gd+aO6r16q+HNlJIV6mjTHdbIjf5QTitZscF7QVrmMfpgLZWXC5yzObgK
         zpvGXQw7F0nccxaszvpo4batZ7ze2WFkpgeN503xBB1kiE+B35eGaGkVDmsWVvxcL1fZ
         tIb0ZHgBC8X0AYN5ui2gHojIPPt4nAzb31wdMc3a+ZN9X4g6DwpfWc9v6NNMBUO7o29V
         m9xNu3pvZ5dZuf8ZXXRsqqVxjke1QbVh0JTOzA3n3eRhhb7f/lrCdlpgUt8UD+XiKPVe
         DyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386088; x=1763990888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stfqZg9bH28bp8D3EFO+GVsIQXazaY5RHr1timPZPyQ=;
        b=lE4jNYTPviEhE9WAy9jPOlxreuyfAcOr7KuMgFhGp3WwdwW/jzwacJ7epMnIbtj8Om
         qm8CwgdgWmpsqqLrwqUZwx69gNpeszIUFogvpBGugcVZlXST8k1TJ9F0/BmTbzTR4HhG
         a6xUdO/Nkh5hGtTm6kg5xTppx0bTLCzX7Ol+U/bV17+pd9Hah3ddqaDS+oHUrHpJnMTd
         0ViQBEWidGLo3AHstuEc3zAOEcbC15EzTjopBayakrI4R3iS8vaHNowOn21pMAkIlI6B
         1tT5R5aq88DqE9kp/I+pybc5eeq/UYoukViV4+fHbcBIdY7ncCj77lSLDMLVjleS9ST6
         lK9A==
X-Forwarded-Encrypted: i=1; AJvYcCWW4Ga9q+//SmAHMe7kNpRuc2x9KjVnU+wEjO1Va1xRW88bhUkvuIV5IjU/gBvM4eJqjFqcsOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jt1cW0fLHv9CbClemlanspy6dXZVns3CCTC9N+cTnXdfwVTs
	oeGkZaWhHqNS1fQ0cJX1jHf0wO9JQBv5jDGhF+UPdt9Kio7yqsyz5ythT9t07Zf97UKPsuFSbF8
	ZOSNuclw0VRxXTQ==
X-Google-Smtp-Source: AGHT+IFFuaGUTvAmNqsBmdgE1efPmoVb/D/mlXyKKrAntiEfFu/3SU8LvRTNPlUlP5phukYxDfD+EiELk7kVJQ==
X-Received: from qvbld27.prod.google.com ([2002:a05:6214:419b:b0:881:174f:e562])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:226f:b0:882:8746:b047 with SMTP id 6a1803df08f44-88292594583mr142026086d6.10.1763386087625;
 Mon, 17 Nov 2025 05:28:07 -0800 (PST)
Date: Mon, 17 Nov 2025 13:28:02 +0000
In-Reply-To: <20251117132802.2083206-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117132802.2083206-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a follow up of commit aa251c84636c ("tcp: fix too slow
tcp_rcvbuf_grow() action") which brought again the issue that I tried
to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")

We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
("tcp: increase tcp_rmem[2] to 32 MB")

Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
force NIC driver to not recycle pages from the page pool, and also
can cause cache evictions for DDIO enabled cpus/NIC, as receivers
are usually slower than senders.

Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1 ms)
If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshold
ratio to control sk_rcvbuf inflation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst         | 10 ++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst       |  1 +
 include/net/netns/ipv4.h                       |  1 +
 net/core/net_namespace.c                       |  2 ++
 net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
 net/ipv4/tcp_input.c                           | 18 ++++++++++++++----
 net/ipv4/tcp_ipv4.c                            |  1 +
 7 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2bae61be18593a8111a83d9f034517e4646eb653..ce2a223e17a61b40fc35b2528c8ee4cf8f750993 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -673,6 +673,16 @@ tcp_moderate_rcvbuf - BOOLEAN
 
 	Default: 1 (enabled)
 
+tcp_rtt_threshold - INTEGER
+	rcvbuf autotuning can over estimate final socket rcvbuf, which
+	can lead to cache trashing for high throughput flows.
+
+	For small RTT flows (below tcp_rtt_threshold usecs), we can relax
+	rcvbuf growth: Few additional ms to reach the final (and smaller)
+	rcvbuf is a good tradeoff.
+
+	Default : 1000 (1 ms)
+
 tcp_mtu_probing - INTEGER
 	Controls TCP Packetization-Layer Path MTU Discovery.  Takes three
 	values:
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 5d5d54fb6ab1b2697d06e0b0ba8c0a91b5dbd438..29abaf74cb5d5a46b6da319c927eb038466ef1a6 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -103,6 +103,7 @@ u8                              sysctl_tcp_frto
 u8                              sysctl_tcp_nometrics_save                                                            TCP_LAST_ACK/tcp_update_metrics
 u8                              sysctl_tcp_no_ssthresh_metrics_save                                                  TCP_LAST_ACK/tcp_(update/init)_metrics
 u8                              sysctl_tcp_moderate_rcvbuf                                       read_mostly         tcp_rcvbuf_grow()
+u32                             sysctl_tcp_rtt_threshold                                         read_mostly         tcp_rcvbuf_grow()
 u8                              sysctl_tcp_tso_win_divisor                   read_mostly                             tcp_tso_should_defer(tcp_write_xmit)
 u8                              sysctl_tcp_workaround_signed_windows                                                 tcp_select_window
 int                             sysctl_tcp_limit_output_bytes                read_mostly                             tcp_small_queue_check(tcp_write_xmit)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 11837d3ccc0ab6dbd6eaacc32536c912b3752202..d8a908560665549fef5d07f35bc1ac8438278562 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -85,6 +85,7 @@ struct netns_ipv4 {
 	/* 3 bytes hole, try to pack */
 	int sysctl_tcp_reordering;
 	int sysctl_tcp_rmem[3];
+	int sysctl_tcp_rtt_threshold;
 	__cacheline_group_end(netns_ipv4_read_rx);
 
 	struct inet_timewait_death_row tcp_death_row;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index c8adbbe014518602857b5f36b90da64333fbeafd..1c25ce609db360b5a06e685f202c3972e6e42435 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1227,6 +1227,8 @@ static void __init netns_ipv4_struct_check(void)
 	/* RX readonly hotpath cache line */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_moderate_rcvbuf);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_rtt_threshold);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_ip_early_demux);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 35367f8e2da32f2c7de5a06164f5e47c8929c8f1..b89cbb263a06eb33c54aec7fb26a2b389f059332 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1342,6 +1342,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "tcp_rtt_threshold",
+		.data		= &init_net.ipv4.sysctl_tcp_rtt_threshold,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
+	},
 	{
 		.procname	= "tcp_tso_win_divisor",
 		.data		= &init_net.ipv4.sysctl_tcp_tso_win_divisor,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9df5d75156057e6ba6b64ff7a0517809e8d1d49a..320a6177eb66ce38977f892b65fcccd84bb47ad4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -896,6 +896,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 rcvwin, rcvbuf, cap, oldval;
+	u32 rtt_threshold, rtt_us;
 	u64 grow;
 
 	oldval = tp->rcvq_space.space;
@@ -908,10 +909,19 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	/* DRS is always one RTT late. */
 	rcvwin = newval << 1;
 
-	/* slow start: allow the sender to double its rate. */
-	grow = (u64)rcvwin * (newval - oldval);
-	do_div(grow, oldval);
-	rcvwin += grow << 1;
+	rtt_us = tp->rcv_rtt_est.rtt_us >> 3;
+	rtt_threshold = READ_ONCE(net->ipv4.sysctl_tcp_rtt_threshold);
+	if (rtt_us < rtt_threshold) {
+		/* For small RTT, we set growth to rcvwin * rtt_us/rtt_threshold.
+		 * It might take few additional ms to reach 'line rate',
+		 * but will avoid sk_rcvbuf inflation and poor cache use.
+		 */
+		grow = div_u64((u64)rcvwin * rtt_us, rtt_threshold);
+	} else {
+		/* slow start: allow the sender to double its rate. */
+		grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
+	}
+	rcvwin += grow;
 
 	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7d9fec2950b915e24f0586b2cb964e0e68866ed..4689a25d647df3fe809f9ea146a2553c487e6fa6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3566,6 +3566,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_adv_win_scale = 1;
 	net->ipv4.sysctl_tcp_frto = 2;
 	net->ipv4.sysctl_tcp_moderate_rcvbuf = 1;
+	net->ipv4.sysctl_tcp_rtt_threshold = USEC_PER_MSEC;
 	/* This limits the percentage of the congestion window which we
 	 * will allow a single TSO frame to consume.  Building TSO frames
 	 * which are too large can cause TCP streams to be bursty.
-- 
2.52.0.rc1.455.g30608eb744-goog


