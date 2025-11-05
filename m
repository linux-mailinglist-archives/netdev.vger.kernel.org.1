Return-Path: <netdev+bounces-235753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AFC34E43
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 10:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F818971CB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD92FFDCA;
	Wed,  5 Nov 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PR43V2sa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA312FE584
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335523; cv=none; b=Wx3RETxP4XUCp46YDGUYl9m2DLMkig7e81H31UEC0csreeuKXiBNivY9AOSzdf5d8cwBRy8F6nqpDjjPuBHkvFxCYnc7kSmAsRRjY2lihSVkWoyExaUrImKHqhILe2QYZYxIDiXOirqx5js2tK7rhoBCKWOYLgy2ZMgI+/0zr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335523; c=relaxed/simple;
	bh=6ji48r+OmWPUfbLc7n2av+mVnQNPBPpoz9iRkEAapZk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F1z0pv39B7j2Q0KkgHKkgF5yXnDYLdTtiqhkVRPD+mvqfQ9axH5ioInIyzX2SWGYsbygvoF9sJNcd90xxo0EcansQKbz+8bLB4kOeYOfQdDEMaRFbkZwNIA6PqGoG6rDxgxSPVVYm38luU4GEjn0BV/qIQ193ZkFyB6GpTWhCXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PR43V2sa; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-63dcbe3d18dso9285658d50.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 01:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762335520; x=1762940320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8I0YUQk7JDuj7P2FXGlAkkNgTDnPiPY3CRFrwvmX4Xk=;
        b=PR43V2sa+UXcSz6F8e+EYZ2rHlUmtmmYAa2dABLSUjwFssmgnL9lpvz8C4+Up340v0
         a7V+fRs8TeGfec5ghbLLjtoTiUozuNHLzIINTesR8fsziQ/F95oaOdeGp6VNYP9d83+y
         rbHJ7crwq60Q41xi4tEetlVBq7wuncKjVnIHDdQWzRZrNVCCDUStPVQufj9L/v3M4Q8O
         hTIUfeEXpiQkpfi/4Vs0fNrp2z52taauHoovWCs5usaYDzbIuvX3DQEi3qzkgwfNSSlj
         9FEWVrFqjW1WQmW0a4m3ayK9gXn60CoPQNUj9BQrupldqUolNf0zO/zfMQBK2utb9ZQm
         Jw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335520; x=1762940320;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I0YUQk7JDuj7P2FXGlAkkNgTDnPiPY3CRFrwvmX4Xk=;
        b=XyXoK4wR+ztNsSrunVgj7RupGpqxWfgGDn51T5bLjdotT8b4xa7RmyInb8DWQMk3Z2
         S1PgbAX2vB3Le4n7GlbstYjAFpnNUXhGTSmIIwdJlVoya2J6OBgbPmkaLGuEI2F8QPtI
         dc4REQgu7xPOy0uVWTLDRQCuLHw501PTaTbXQ6ebOs2rrup3hzAK/osTJAeVerhV/eeD
         SuA/umawKOPEtw1AkvRu3TNEpb2g611pv6+zjnvDiOe2Jbu0QBXV3rGtrXMkXnK9fhGF
         cStg3tkd3oD2c0mQWsekTeXPn6DffOk71CJc1DhQ3/jB36dzkSpn4M+O6ipxdvLvtWZ4
         QiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkJyLzzkZCcJTh3wYHp1NIcSeOERGaShIQ+Ebi8oPIjV3O4QdGDH0dt28RjCzNMN+jqkoqK3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZPcGE+7CnD2seSUph2pio9vWiEprWyLwM/L5EJTFQJy1iU5R
	nx4FlCvGEXVVVCd5nHkDn47dpD5x3XqjwmGXdEoHsY9AlzdyRvpuIOZpOj2I25o60OUlI/71PuP
	8oQwY72igokYpZw==
X-Google-Smtp-Source: AGHT+IHM1hde3LKu2VpJh1Alxld13WdTxepWwP8lfujLbrEp+PW9X3vWOI9Y9mZ2Zu1t6/gJiJ4N5FH4gBNLCQ==
X-Received: from yxox10.prod.google.com ([2002:a53:e58a:0:b0:63f:a4d4:32a8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4182:b0:63f:a7dc:159e with SMTP id 956f58d0204a3-63fd34e80e0mr1815042d50.29.1762335520486;
 Wed, 05 Nov 2025 01:38:40 -0800 (PST)
Date: Wed,  5 Nov 2025 09:38:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251105093837.711053-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add net.ipv4.tcp_comp_sack_rtt_percent
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
set the default value to 100.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst | 13 +++++++++++--
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 net/ipv4/tcp_input.c                   | 26 ++++++++++++++++++--------
 net/ipv4/tcp_ipv4.c                    |  1 +
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7cd35bfd39e68c5b2650eb9d0fbb76e34aed3f2b..ebc11f593305bf87e7d4ad4d50ef085b22aef7da 100644
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
+	Default : 100 %
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
index b7526a7888cbe296c0f4ba6350772741cfe1765b..a4411cd0229cb7fc5903d206e549d0889d177937 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3596,6 +3596,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
 	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 100 * NSEC_PER_USEC;
 	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
+	net->ipv4.sysctl_tcp_comp_sack_rtt_percent = 100;
 	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
 	net->ipv4.sysctl_tcp_fastopen = TFO_CLIENT_ENABLE;
 	net->ipv4.sysctl_tcp_fastopen_blackhole_timeout = 0;
-- 
2.51.2.1026.g39e6a42477-goog


