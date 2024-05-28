Return-Path: <netdev+bounces-98708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B5E8D223B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04A91C21D30
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F03175560;
	Tue, 28 May 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBRs2T64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E54175546
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916443; cv=none; b=HXpsg/H7z36LwEoHOAFMKTImpXQO54dY31684kkDA/FUfjAHfTF8C0NlFfp0e/cTPzyLGSOW99HPQnxarpxKNu2J/m3KAlxhxa+1j1wnxNcsGb75NVq6y6OuEyCGl0CreJDYuN18YLJphTpclmGFm04xK4cnapnM/wvEIodsNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916443; c=relaxed/simple;
	bh=BG05HNPHUE7ZV/HGaIIAYlcS9yYK4QMdfVqoHoq3Vek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOQ0K1xq0w89pZOfA+32WWqjWPaI2WeWu3oNOuN9uLIJttbDZDt7L6guipqzCEsjO7brEenG3VXiRGVuuhtnqrf0wzD8o2tUFdpIwMOQMiajrfVc1iZQr3HTl8PgPeh7y1or+Y8kpFnh6ImTPuGsdP1f3RPq1Or7tbkQRVHziro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBRs2T64; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a0841402aso16820947b3.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716916440; x=1717521240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUIgxr3cugz00o2P8UW4WNCAcffInCJnKK0N0bifgRM=;
        b=cBRs2T64NR67GUQf6rT7YLsx28p9BY2pQOxthC3o6P3kBMvVG5UMLgfdj++g8Al9rI
         4FL65U+a/6eWo0oKp2r65HltK0SUNGSn9yNHLSGU/9YcGX3HmMhTCYqWcLzoQphoBm0O
         ZhL3FC8uVF606+NM8LMhDCppMN2EPuo/7vdyhPbRpc2FWRL/WcNfWgPaZpvCJIdrx4rv
         ma56EPgSowtl5UTNE6FQuysnyW0o/W/M+SIqqD35zw5VxtPqMv1XQtKDDJ6VhRlVt+fN
         UMQmmkmDEvRTfIirBNEjqTN/fKsaeNxy6XQr8OvPd0gLGAKYYZuo4c5FghIgC/Ev3P9l
         oa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916440; x=1717521240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUIgxr3cugz00o2P8UW4WNCAcffInCJnKK0N0bifgRM=;
        b=YSMZWzylV1RTc3dEYhRNwT6tQlvE2q4uoVdFQtFpiDUOMV9xFsTqHbp9lI9WRBRauS
         ECfKIprwV+ACSXt7xF/kLeIIpP1qh3iEbDsllKunpCj8wldKwSAkt90Tv/nuIqVl6A9D
         Kw4OyEGqZLml89KBfHzIQ+UiZNf6WP5ZNjIg38EiaWDit8eSTfv+rKCHZ4lVKkoz2sjq
         p7Co+cJQtnLfCCAp0jnCOPclleA3XU0WOyKXDsaDfro6+BgcuhE6SMmUzTcc4IB5403Z
         5sskpbfmzYnBM07d8lPTL+pmjo5pe8r2aoszH+WmGjUtAXEW+9Q87M5dfDNVsGz/hEvC
         OnFg==
X-Gm-Message-State: AOJu0YxdT7UJB4OGjkOyxcjBbJ9mnhB7EbD91ZKpci4o9YgdTvJt6tkD
	6PqWSwOF1rY3I8SvC+2aWeRfEpCtMZkK500SKer4n9v6xxuFrAGCUzWrmuuZcM2kTQ==
X-Google-Smtp-Source: AGHT+IGpm6OxWm2vObRufDyJxKXm2pd2DwHqBC41tbwVOxAifiK5CiciS+cys1RgkRa264CcRcd+YWs=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a5b:812:0:b0:df9:20a2:228e with SMTP id
 3f1490d57ef6-df920a224bfmr108857276.5.1716916440711; Tue, 28 May 2024
 10:14:00 -0700 (PDT)
Date: Tue, 28 May 2024 17:13:20 +0000
In-Reply-To: <20240528171320.1332292-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528171320.1332292-3-yyd@google.com>
Subject: [PATCH net-next 2/2] tcp: add sysctl_tcp_rto_min_us
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Kevin Yang <yyd@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
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
---
 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
 net/ipv4/tcp.c                         |  3 ++-
 net/ipv4/tcp_ipv4.c                    |  1 +
 5 files changed, 25 insertions(+), 1 deletion(-)

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
index 162a0a3b6ba5..58be05f8812c 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1501,6 +1501,14 @@ static struct ctl_table ipv4_net_table[] = {
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
index 06aab937d60a..8e91b60ac1ce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -428,7 +428,8 @@ void tcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&tp->tsorted_sent_queue);
 
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
-	icsk->icsk_rto_min = TCP_RTO_MIN;
+	icsk->icsk_rto_min = usecs_to_jiffies(READ_ONCE(sock_net(sk)->
+					      ipv4.sysctl_tcp_rto_min_us));
 	icsk->icsk_delack_max = TCP_DELACK_MAX;
 	tp->mdev_us = jiffies_to_usecs(TCP_TIMEOUT_INIT);
 	minmax_reset(&tp->rtt_min, tcp_jiffies32, ~0U);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 108a438dc247..da005a197ca1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3511,6 +3511,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_shrink_window = 0;
 
 	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
+	net->ipv4.sysctl_tcp_rto_min_us = jiffies_to_usecs(TCP_RTO_MIN);
 
 	return 0;
 }
-- 
2.45.1.288.g0e0cd299f1-goog


