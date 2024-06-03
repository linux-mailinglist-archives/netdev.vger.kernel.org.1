Return-Path: <netdev+bounces-100372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027688E467D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8457C1F26B20
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE413BAFA;
	Mon,  3 Jun 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6UmMdV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FF74297
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450307; cv=none; b=FnKzl1j2sttYnft/vuZfV5K0vIv1/VyDr3qwGcaC8QeasUGt0eMsRmVEGh0w2CQhH4+SUnTr1yaiZMMK2NOYRgbu7qFJ0fdbw9C9stXbhxCf2Qtbrp0+xMR1nFF1Q750bO/Nvy9VpMjJJ0rIQk+HlH2i85FZFSm64sXF/KoXWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450307; c=relaxed/simple;
	bh=4L97r+0z1Zhfln/5re9uTaNvOFODzAqToKNu8CCh/ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cc0sp7iw5B31jtIo50suOEtUf70QEKXhEtTPvakK4WqR+7MYWV+GbmjAD4TDFzHCkXulJqLJaS0W8lhqP7pWJZq801HHO/euFl0CbQU0l6ULYVaLNRF2ei9pd6/Vf4VD+6yqAxerJiMtVZ9A+7cDwAQEMLzx3iMGM3x14IlnobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6UmMdV3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa744fe2f9so529598276.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717450304; x=1718055104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoqpIvvH43hsGrd/sUpp3WJhNLZ4dhTt6GFW0BG1zpA=;
        b=b6UmMdV3GNkSWNXHW5iiOiSpmQpRAqwrtj/NNwzjY/bTqifzeRHjVHNUQFpUugLEKR
         0Yu6xp4KRMZyql8B+E9hvqz6p35FQBkUtvckt414HjLhtw9XpyxAdmtv4FVCDwoKlW3g
         KlPJlmG2GamRqYScUCahAdUpOsRRVtl33js9l6zxGRzZDcvdWgnWofzxeVdfo3+UbArT
         KmqGFUkLLEvNgmbJr098K82oEV59B0fF5I+UDFzoO33qHLH+7YC23oKaDstEuveicOzf
         5KDG138tE2M23tGgGgK3BUO2jkPn+wNlqBhALbkgMD27HECa2FUNMhhV+Sc4GjMqHHc9
         Aa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450304; x=1718055104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoqpIvvH43hsGrd/sUpp3WJhNLZ4dhTt6GFW0BG1zpA=;
        b=LhvLiJMSPoTVIS3yaavlTb4gL43ZfybLAKq8gnIrRSTo1AfprpYiLNqb8VBolegRrg
         gBWiePM6+7y30OVdIkZKVAEjAhfuGMQgx4OPQixsNmQ7fHRK/hGDyI9CeeqL02YR0jV/
         fCAfGFXCLd5hOpOyMOQoHYizBRnYsJR8wwgZi5XuzQdfeJE73aD0/OIZTCSCAOQqmTix
         PA+B9OOzKfcOR+zibwxFBwYEq9S5zgktwA/XZ9v0Fcj9YqcETPuESuUh3GTEeXzFQSKu
         3phZ5lAvZDS/t3jcEP/tHL14aJ2DN8XwTZpYHybRd5Ek3DFmiVXNbd1r6coMxD6bJyZw
         ubgg==
X-Gm-Message-State: AOJu0YzWJnd5j/7iwLSKCAVOvMW1KO8mcKjtYI2I+oIf2j0aDYsWsl6h
	zJdCG0a/B8vz7ECJZ8BzdRD/jc6le5wEKGxQNi16V197X5XFzgkwu8WQ5RKuKZFmEA==
X-Google-Smtp-Source: AGHT+IE0GSgQrvLtbwPA0JDIm3TaFTAPDovIvVdJbtxQaKwx+TKIna9/Ji0U+iGABY2M91kMzfTEIoI=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:6902:708:b0:df7:9609:4ce2 with SMTP id
 3f1490d57ef6-dfa73d8da89mr800429276.8.1717450304576; Mon, 03 Jun 2024
 14:31:44 -0700 (PDT)
Date: Mon,  3 Jun 2024 21:30:54 +0000
In-Reply-To: <20240603213054.3883725-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240603213054.3883725-1-yyd@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240603213054.3883725-3-yyd@google.com>
Subject: [PATCH net-next v3 2/2] tcp: add sysctl_tcp_rto_min_us
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com, 
	kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com, 
	horms@kernel.org, David.Laight@aculab.com, Kevin Yang <yyd@google.com>
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


