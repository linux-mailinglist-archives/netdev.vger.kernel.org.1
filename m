Return-Path: <netdev+bounces-111404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E84930CFD
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 05:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A353280BF9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 03:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E68E17DE19;
	Mon, 15 Jul 2024 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQCnLTG6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526617DE06
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014294; cv=none; b=r+gsxWsGYLfnG5zsnkkINvL76drwKyekOENR40mf2x45Oy0sxd7hDcZLf4nroGiDLhemy36vmtboBaoOM6O9rmCLLskiSkgHWASSZPE1bVbghj/HfrCmAasRgAgIdcgdbx9EW36VOL/Kl9NOPzo382WgetEcKnNhL9yDhoG+UC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014294; c=relaxed/simple;
	bh=wThg9YM+o+P8iubLMx8hMaunWIc3nEdrIT+EOo0datQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JrOaW3Vva1tnhpQ9Zer+ZFBn1QEwqKHHpXJIY5Rzg+sZzibwZVu8GJ/wfAPr7wFDjbI2RhcrAxfAHWiTIzyd3Bj9gs8puzP/vSwS33gre2bWBQG3GrkkYgzBG8GNT79T0YPvUBIcGGQdSrMBKeudT9QbJc5yEtDFwJZnboObZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQCnLTG6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb4a807708so33593005ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 20:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721014292; x=1721619092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YSZO7atVmSxVafGMqLvkpjN2+QsZnXkhX1sTkuEMn4=;
        b=UQCnLTG63MsEeR6PiTkdJIcc1odLipC9lpF1rHmN4/isSkjjRi9K7uXAYtKYjrT8iN
         ccXshVXqgAQNJWTqgEHxhUnie7vdH9A3WUyoUy/T+iWGPzSq1wMI5nMmY5aWGW7Hmc6p
         7at7qWJ3m7QloqW8LcL9adBDQgz+C2ocH0/7O0pLcyY9Icdb5aoCQxTz0UZzaiVI4H4O
         0Z2cTGYcN/NuY5xPdxcvKiXLGwTI+Ha+XuR6qSzZhJfG0aVyE6qCOKBg+9pBeKhjDP9P
         8WZ66lG/2e+uU22flBg08lsxoKcAybktj1RrWeDGL+tiYn2dw2guJSkqeXLhPdnBvLWP
         ThNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721014292; x=1721619092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YSZO7atVmSxVafGMqLvkpjN2+QsZnXkhX1sTkuEMn4=;
        b=sZZ6RBuz5q/deqbdmqEFQe1kvs9llU+20+8oAVOvQXJyUOX4xHKSE/8st7e97FbtJ1
         slxtQm6WqtqBjOi6n9ay1vX6jfvMAVnu7dZWJ9T8cdGp0U76e3u/tMeLnhv6A8xub1XL
         SasCyv7jhuwTQqFYu3JjVzOPAxKyy3+7SSsLRV7qRHK/WlAw+cfIxdJpVjlEnglfSbaq
         YlVnzWkmshqrv+Jf7uLJ5ykhKGrvugkHYi9BnkOID/MjZzHoFyTEro3GlZklA+TLqaCn
         V0PlYI4jkqFPXT3Up4wYqIfmqy8l++o7Lt6B/SB6Yfnt68kw4Z55vvIdAENS3GUSiPi2
         ZXPQ==
X-Gm-Message-State: AOJu0YwUT2L4XbijCvntwmmuEHoSe9qwv058oH+cGS3h2VCMS45xFbey
	MWBTWipgHT2/p45OwjMUGdoURE3+fpSCjBYq7a1cpOWmrxvZIoHw
X-Google-Smtp-Source: AGHT+IHg3IacY5QCn5dWc83Xll4Vol7faZOY47WCv+B8Tk4vh86YleHi69FvYY8h14RVzDFsb6kRDA==
X-Received: by 2002:a17:902:ce8f:b0:1fb:6794:b463 with SMTP id d9443c01a7336-1fbb6edb351mr185052635ad.54.1721014291818;
        Sun, 14 Jul 2024 20:31:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27671sm29992445ad.142.2024.07.14.20.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:31:31 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	ncardwell@google.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
Date: Mon, 15 Jul 2024 11:31:18 +0800
Message-Id: <20240715033118.32322-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As we all know, the algorithm of rto is exponential backoff as RFC
defined long time ago. After several rounds of repeatedly transmitting
a lost skb, the expiry of rto timer could reach above 1 second within
the upper bound (120s).

Waiting more than one second to retransmit for some latency-sensitive
application is a little bit unacceptable nowadays, so I decided to
introduce a sysctl knob to allow users to tune it. Still, the maximum
value is 120 seconds.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/ip-sysctl.rst | 10 ++++++++++
 include/net/inet_connection_sock.h     | 10 +++++++++-
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp_ipv4.c                    |  1 +
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 3616389c8c2d..32a1907ca95d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1223,6 +1223,16 @@ tcp_rto_min_us - INTEGER
 
 	Default: 200000
 
+tcp_rto_max_us - INTEGER
+	Maximum TCP retransmission timeout (in microseconds).
+
+	The recommended practice is to use a value less or equal to 120000000
+	microseconds.
+
+	Possible Values: 1 - INT_MAX
+
+	Default: 120000000
+
 UDP variables
 =============
 
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c0deaafebfdc..a0abbafcab9e 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -217,10 +217,18 @@ static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
  */
 static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 					     unsigned long when,
-					     const unsigned long max_when)
+					     unsigned long max_when)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
+	if (what == ICSK_TIME_RETRANS) {
+		int rto_max_us = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rto_max_us);
+		unsigned int rto_max = usecs_to_jiffies(rto_max_us);
+
+		if (rto_max < max_when)
+			max_when = rto_max;
+	}
+
 	if (when > max_when) {
 		pr_debug("reset_xmit_timer: sk=%p %d when=0x%lx, caller=%p\n",
 			 sk, what, when, (void *)_THIS_IP_);
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 5fcd61ada622..09a28a5c94d2 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -178,6 +178,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_window_scaling;
 	u8 sysctl_tcp_timestamps;
 	int sysctl_tcp_rto_min_us;
+	int sysctl_tcp_rto_max_us;
 	u8 sysctl_tcp_recovery;
 	u8 sysctl_tcp_thin_linear_timeouts;
 	u8 sysctl_tcp_slow_start_after_idle;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 9140d20eb2d4..304f173837bc 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1573,6 +1573,14 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "tcp_rto_max_us",
+		.data		= &init_net.ipv4.sysctl_tcp_rto_max_us,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288..f06859be5942 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3506,6 +3506,7 @@ static int __net_init tcp_sk_init(struct net *net)
 
 	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
 	net->ipv4.sysctl_tcp_rto_min_us = jiffies_to_usecs(TCP_RTO_MIN);
+	net->ipv4.sysctl_tcp_rto_max_us = jiffies_to_usecs(TCP_RTO_MAX);
 
 	return 0;
 }
-- 
2.37.3


