Return-Path: <netdev+bounces-164053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51FA2C722
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261087A566B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2524061F;
	Fri,  7 Feb 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9ViTXG6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A324060A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942122; cv=none; b=Os3wIe6A5lOo2HqahXPnxlQAdhy6svbwsbozLXLUJ5ygr1ORC+yckgbCSTGQrgXuZTSrQiJvspP0GAIXfPG2FuHM4mRv4vqCKdTuIOkfJ0xqsow/aogMlgsqJ2fSXdxiB6pLOxhwyw42M147QL7Afq+8GvTFVDqJw1GCU15kYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942122; c=relaxed/simple;
	bh=NNnbWHuwj574rTYCFA12cg4LsOMc4Jxyp/bJhCBDayE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lrSy3F7oPGTh70qxqSFoBv9lPfJaXnXHhJYHVRgiogg52NJsTiF/gQhW6TucxK92UQzr1lu54NwUpxIihOLD6Y6nkBKL8JHOAUoYsA+tj12OfOz7c+BIeW9FxqcrDuUhf2LFT/Wp8Pe137S0yt15RbK29poxyVMlW6AIMOcPgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9ViTXG6; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46799aa9755so65447041cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942120; x=1739546920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HO4qNwEJsDi5dYMX4pd1JVkM8xWaqdgSDRcLjbN+3t8=;
        b=h9ViTXG6/2rl3ZDauXk8LlWlR+ZTpQma/HIk7fwTmTifdHDlHUtW2vER8Vn8ZmLlwr
         0jlHfLVQ/UbRIfoIzDQJ9NY679MXlPX/D26Sn9+NfoaOVxKd7oodMAjWa17woF7nE/C/
         lh6xe2ST8RT5s1Mj9zCJNnBIQRk4uktjckJt+y/hbc9mm1S4A/zdshtVLYkJbP2D5xzM
         T10OY1J/oTgDBAMLLP/zkYsYfEAPncaL+bls4UMvwqee3R04FOWhLd9Rhh7V91+QYaWy
         r780QE3/wJrR85D7AGmWQqVZL2x2+PU7Vqhy9GsVIjcHKP43p9yzBP8GVgza+6bP0uet
         qleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942120; x=1739546920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO4qNwEJsDi5dYMX4pd1JVkM8xWaqdgSDRcLjbN+3t8=;
        b=MW/PmxR1lvxWnpbRMchAM8cROiHPaRZkOPMIug3mLcB4Q8PsZRlilWqymhW+Tuorhw
         EX+AJ41zDY94O0FSjLKdii2Nw/IwfjbWOpyZawpZ7ekALeeYEJVxjun9H2n9nDdzap7E
         7zBdaCHqUEIILhvbYXTWp+LHsw+u1qUSbes81g7mm/N0A5llwxNF5Hv9NxaGvytMw7sf
         deQzzfoeXsFW7SjSfpOVUWEZCh3I2aBWWJnasqgpqLOJ+/n8wvg0JZJFaGlHN2lEp2Wx
         1frxCsnE4b1lTxfygsZcNtHGZs6VmQ7yp9wb3fl5JStHB6ikTHNVdyuF94qr6sWsXmXs
         PXKA==
X-Gm-Message-State: AOJu0YxMjs21elzQ/bn3b9C0NK1V7bP2DLF94gF1eZq3FfF42W58WmiM
	Qu+q9SThC+AkxjpuTAf7huNWM6lCsuWVXVpV68nudYUaNhWyoaGxmfksdcFP1hGVygNRS7YC7DS
	xKKJS3jaiKw==
X-Google-Smtp-Source: AGHT+IH2Ij6C8gMw8XYNJbsFtcxctcgEaeCdJY2TIoiQzdKLUBfVs21LdEh1p1i1TURZqd67kobE0bW7Pp1qEw==
X-Received: from qtbch12.prod.google.com ([2002:a05:622a:40cc:b0:46c:74db:e1cb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d4a:0:b0:466:954e:a89f with SMTP id d75a77b69052e-471679f3027mr51417141cf.14.1738942119888;
 Fri, 07 Feb 2025 07:28:39 -0800 (PST)
Date: Fri,  7 Feb 2025 15:28:30 +0000
In-Reply-To: <20250207152830.2527578-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207152830.2527578-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] tcp: add tcp_rto_max_ms sysctl
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Previous patch added a TCP_RTO_MAX_MS socket option
to tune a TCP socket max RTO value.

Many setups prefer to change a per netns sysctl.

This patch adds /proc/sys/net/ipv4/tcp_rto_max_ms

Its initial value is 120000 (120 seconds).

Keep in mind that a decrease of tcp_rto_max_ms
means shorter overall timeouts, unless tcp_retries2
sysctl is increased.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst              | 13 +++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst |  1 +
 include/net/netns/ipv4.h                            |  1 +
 net/ipv4/sysctl_net_ipv4.c                          | 10 ++++++++++
 net/ipv4/tcp.c                                      |  6 +++---
 net/ipv4/tcp_ipv4.c                                 |  1 +
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 363b4950d542aa32fbf6ab1617de46a900061f82..054561f8dcae77d4183f5b7e45f671ba8979390a 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -705,6 +705,8 @@ tcp_retries2 - INTEGER
 	seconds and is a lower bound for the effective timeout.
 	TCP will effectively time out at the first RTO which exceeds the
 	hypothetical timeout.
+	If tcp_rto_max_ms is decreased, it is recommended to also
+	change tcp_retries2.
 
 	RFC 1122 recommends at least 100 seconds for the timeout,
 	which corresponds to a value of at least 8.
@@ -1237,6 +1239,17 @@ tcp_rto_min_us - INTEGER
 
 	Default: 200000
 
+tcp_rto_max_ms - INTEGER
+	Maximal TCP retransmission timeout (in ms).
+	Note that TCP_RTO_MAX_MS socket option has higher precedence.
+
+	When changing tcp_rto_max_ms, it is important to understand
+	that tcp_retries2 might need a change.
+
+	Possible Values: 1000 - 120,000
+
+	Default: 120,000
+
 UDP variables
 =============
 
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index de0263302f16dd815593671c4f75a93ed6f7cac4..6e7b20afd2d4984233e91d713ee9acd4b2e007f2 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -86,6 +86,7 @@ u8                              sysctl_tcp_sack
 u8                              sysctl_tcp_window_scaling                                                            tcp_syn_options,tcp_parse_options
 u8                              sysctl_tcp_timestamps
 u8                              sysctl_tcp_early_retrans                     read_mostly                             tcp_schedule_loss_probe(tcp_write_xmit)
+u32                             sysctl_tcp_rto_max_ms
 u8                              sysctl_tcp_recovery                                                                  tcp_fastretrans_alert
 u8                              sysctl_tcp_thin_linear_timeouts                                                      tcp_retrans_timer(on_thin_streams)
 u8                              sysctl_tcp_slow_start_after_idle                                                     unlikely(tcp_cwnd_validate-network-not-starved)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 46452da352061007d19d00fdacddd25bbe56444d..45ac125e8aebb99d4083d540c907f0d560dac0b0 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -181,6 +181,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_window_scaling;
 	u8 sysctl_tcp_timestamps;
 	int sysctl_tcp_rto_min_us;
+	int sysctl_tcp_rto_max_ms;
 	u8 sysctl_tcp_recovery;
 	u8 sysctl_tcp_thin_linear_timeouts;
 	u8 sysctl_tcp_slow_start_after_idle;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 42cb5dc9cb245c26f9a38f8c8c4b26b1adddca39..3a43010d726fb103beaad2b11d6797424b0c946e 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -28,6 +28,7 @@ static int tcp_adv_win_scale_max = 31;
 static int tcp_app_win_max = 31;
 static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
 static int tcp_min_snd_mss_max = 65535;
+static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
 static int ip_privileged_port_min;
 static int ip_privileged_port_max = 65535;
 static int ip_ttl_min = 1;
@@ -1583,6 +1584,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "tcp_rto_max_ms",
+		.data		= &init_net.ipv4.sysctl_tcp_rto_max_ms,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE_THOUSAND,
+		.extra2		= &tcp_rto_max_max,
+	},
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a9b92d8bfb5644431683ec214aedd0e9756e8a0a..d01f42cf3863bd87ac0a91ab01505616a1bd4225 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -423,7 +423,7 @@ void tcp_init_sock(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	int rto_min_us;
+	int rto_min_us, rto_max_ms;
 
 	tp->out_of_order_queue = RB_ROOT;
 	sk->tcp_rtx_queue = RB_ROOT;
@@ -433,8 +433,8 @@ void tcp_init_sock(struct sock *sk)
 
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 
-	/* Use a sysctl ? */
-	icsk->icsk_rto_max = TCP_RTO_MAX;
+	rto_max_ms = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rto_max_ms);
+	icsk->icsk_rto_max = msecs_to_jiffies(rto_max_ms);
 
 	rto_min_us = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rto_min_us);
 	icsk->icsk_rto_min = usecs_to_jiffies(rto_min_us);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 06fb0123d2d60e22f19ea48b73ac3668c51465a2..d1fd2128ac6cce9b845b1f8d278a194c511db87b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3532,6 +3532,7 @@ static int __net_init tcp_sk_init(struct net *net)
 
 	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
 	net->ipv4.sysctl_tcp_rto_min_us = jiffies_to_usecs(TCP_RTO_MIN);
+	net->ipv4.sysctl_tcp_rto_max_ms = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
 
 	return 0;
 }
-- 
2.48.1.502.g6dc24dfdaf-goog


