Return-Path: <netdev+bounces-99453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A559C8D4F2E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE3A285AF3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8504182D22;
	Thu, 30 May 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKn9c4dI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13F182D1D
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083333; cv=none; b=Y7WzsV0MBBsaZ1haXTNEEL367AHgFF73gRQAFXa1L5w7Dg99qbluGJmd0o7czS2MlObVgGU9Ds8Xc3TX6EdlR8wxmkoOkpyxjGzQfUeLhcfjqfSiV269AuaF3rr99Mv9y6nzBzI2NlJt7g4auT+0dynMuoTZRp1cWQULPXbIofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083333; c=relaxed/simple;
	bh=4L97r+0z1Zhfln/5re9uTaNvOFODzAqToKNu8CCh/ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SAkhc741U6deI4LD9b3eqh8GAzyUJGG7yX4Q/mtlVILUJuQQqvaUoWfG0xqdMlpNabahlBt1YcmLsE4wCZHnLXfmo2KqyybC7KHNTaxWN3QklNFS0PIdM3nVqwKNu8gGgDT6eXc4iiYGZFPGRhi6pKWufJxBY/j4B9uYTSX5DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKn9c4dI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df78acd5bbbso1815668276.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717083331; x=1717688131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoqpIvvH43hsGrd/sUpp3WJhNLZ4dhTt6GFW0BG1zpA=;
        b=aKn9c4dI06GaLaSyBDYkDWiMiffSuhjfCyjN4Yj+WLpySXXaZZVasGRMUemW5Z2GHk
         X1cN5AxF4h2Lj5sGrGaJizu46eaRLIq+9vfDh1lqKD1aRyGHi0ZPrJTmlsyioNiOk5n8
         hYrv2S9uV90VHqk2SthSixQMxUEaq7bDZo/BqANFeVx0m+8UcuIp2jcgm/7qgOmKf5Zh
         oIyqnyr8W1VZvKctwR/MuznJaMIBfuHOuQ5DxnpTgfy6WWqalkcdVSALzir+59WwQXKH
         Bf7BmfKEyVNFT18Xgy1Y3lDqMMMUgYzWtKqLqIrhI9Vb+oEAt09ILVNKRm7CyMOkq0Ds
         5Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083331; x=1717688131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoqpIvvH43hsGrd/sUpp3WJhNLZ4dhTt6GFW0BG1zpA=;
        b=Wm8Pqgs8VDiUKPQn0ouzkaP7Vks6HJ1WGmNAnCW5OuMS4Kbp73lNje5VqkUefhdzgW
         BmUlDB7bZsIRHwu3DblDaHfTbOI3d9OMJ9CLT96vwTzlo/plIgNMzBs9M/pdQG5nYIII
         gQf+xc1r1HwAFcSp1Tsdi8xHzs0lYQiyYHoynGdWw4RAYY7TodwDcFQm/pHClaqtuvDE
         eDMCw2oz+LT4sk0EU9iPXfrjkXfwWbWfkyFdlhu2YsolJB5+KqREExU61M7iU4FevNXF
         Zy7faSZ4xped7H48qmXNf6L51e0IP7OHHLyvnP+wlNxyh1KR31PBi7j4svKYfJe4KWOh
         kQ9A==
X-Gm-Message-State: AOJu0YzEAKmbEQs9/0iN18OUMsoc/9qvmj60T0I8X6ooX3G/ChQc05sj
	39pw2utynFDwvlcWjs0QKAQCmpYxPWVmLQuR99dnYUBrWORWB6GJzXnv11p1O0v4vQ==
X-Google-Smtp-Source: AGHT+IEE0yhjHLsGa18+lyw+3LcA7nyolcVb6PSHf2DGrg98zU4DbOuOo4onK4r2sAxtI+UaC/EH7Zg=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:6902:1026:b0:df7:8c1b:4309 with SMTP id
 3f1490d57ef6-dfa5a5b68ffmr148848276.3.1717083331540; Thu, 30 May 2024
 08:35:31 -0700 (PDT)
Date: Thu, 30 May 2024 15:34:36 +0000
In-Reply-To: <20240530153436.2202800-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240530153436.2202800-1-yyd@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530153436.2202800-3-yyd@google.com>
Subject: [PATCH net-next v2 2/2] tcp: add sysctl_tcp_rto_min_us
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com, 
	kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com, 
	Kevin Yang <yyd@google.com>
Content-Type: text/plain; charset="UTF-8"

Adding a sysctl knob to allow user to specify a default
rto_min at socket init time, other than using the hard
coded 200ms default rto_min.

Note that the rto_min route option has the highest precedence
for configuring this setting, followed by the TCP_BPF_RTO_MIN
socket option, followed by the tcp_rto_min_us sysctl.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp.c                         |  4 +++-
 net/ipv4/tcp_ipv4.c                    |  1 +
 5 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bd50df6a5a42..6e99eccdb837 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1196,6 +1196,19 @@ tcp_pingpong_thresh - INTEGER
 
 	Default: 1
 
+tcp_rto_min_us - INTEGER
+	Minimal TCP retransmission timeout (in microseconds). Note that the
+	rto_min route option has the highest precedence for configuring this
+	setting, followed by the TCP_BPF_RTO_MIN socket option, followed by
+	this tcp_rto_min_us sysctl.
+
+	The recommended practice is to use a value less or equal to 200000
+	microseconds.
+
+	Possible Values: 1 - INT_MAX
+
+	Default: 200000
+
 UDP variables
 =============
 
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index c356c458b340..a91bb971f901 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -170,6 +170,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_sack;
 	u8 sysctl_tcp_window_scaling;
 	u8 sysctl_tcp_timestamps;
+	int sysctl_tcp_rto_min_us;
 	u8 sysctl_tcp_recovery;
 	u8 sysctl_tcp_thin_linear_timeouts;
 	u8 sysctl_tcp_slow_start_after_idle;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index d7892f34a15b..bb64c0ef092d 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1503,6 +1503,14 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "tcp_rto_min_us",
+		.data		= &init_net.ipv4.sysctl_tcp_rto_min_us,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5fa68e7f6ddb..fa43aaacd92b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -420,6 +420,7 @@ void tcp_init_sock(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
+	int rto_min_us;
 
 	tp->out_of_order_queue = RB_ROOT;
 	sk->tcp_rtx_queue = RB_ROOT;
@@ -428,7 +429,8 @@ void tcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
 
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
-	icsk->icsk_rto_min = TCP_RTO_MIN;
+	rto_min_us = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rto_min_us);
+	icsk->icsk_rto_min = usecs_to_jiffies(rto_min_us);
 	icsk->icsk_delack_max = TCP_DELACK_MAX;
 	tp->mdev_us = jiffies_to_usecs(TCP_TIMEOUT_INIT);
 	minmax_reset(&tp->rtt_min, tcp_jiffies32, ~0U);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 041c7eda9abe..49a5e2c4ec18 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3506,6 +3506,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_shrink_window = 0;
 
 	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
+	net->ipv4.sysctl_tcp_rto_min_us = jiffies_to_usecs(TCP_RTO_MIN);
 
 	return 0;
 }
-- 
2.45.1.288.g0e0cd299f1-goog


