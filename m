Return-Path: <netdev+bounces-142837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EBC9C072F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAEA1F2326B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FD2101A3;
	Thu,  7 Nov 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx6ZJavg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC9210180
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985786; cv=none; b=nwhY0u1Gds42fj6geldRHvNTRyoh1V2mjg9k20/DQ2Bmb290zt2rNKvz9CCkX8lvSBbxjmO+saoaHSN8Pei9VL95PH3GMTk6xMEZOX1f4nquopjieNsRCIKq7GoJXHjZMwcDkyEUEetlORdHaeVSSAzk0U1c/ZvA+TSeAXtKglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985786; c=relaxed/simple;
	bh=pH8vvNaBECo7SSWxOeqlGxhO2jAwMFsB4Bw/iTfrQkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G08BaHFlSqqw2owb+KL/MEYQFpnVg5vXfGTaBRYVtAgGsZ+DWEbUMaE2nzMGXHwCMZaSQgWN6taR4fKOhhbLG8E8wESjyi9sNgeuG3Del7JUvQuvRAGhW6fxVeGf8jhIlLl7VWcUhlNvjzaUfVaNl6MkUTvv2TfXmqlL4xFqlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx6ZJavg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43161c0068bso8375905e9.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985783; x=1731590583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pa2RDce8b3fUpa5ZPGXF6ddVAaLQ7nrHKF95AIjDLk=;
        b=Tx6ZJavg6QAORoYQZnXrhZGMT7YdVIWddZwrdAeYXvUb+bYisqVK4z7zGb/6VGi3i5
         pfcYEIyfwd4VK/2oRt4LTEVjf5O5qF9Fs2UETefJ5WS+gMx0g5pEYP3Gdq/8qX48m6M7
         eS9Y8TkWZcNsA9vldQDqEG5/v+iBcRx8C/vdbk+SKa2to5x/Pd/MxEBLOyXnceB8SbuP
         Y/YBzmXIwvr9UrtQF5xKOWB0F+OXO5EQSU2iXmjkhrnQ7ypYrb8fqU1ddOcuB4MRimzW
         AuOKtpBYux0YmBvDXOoeBZjqBm4JizF3Tl+q/GbDRWqzo5jXHE2cbWqUn4t7X4sTbkTZ
         TdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985783; x=1731590583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pa2RDce8b3fUpa5ZPGXF6ddVAaLQ7nrHKF95AIjDLk=;
        b=UtesPBYIozkKVk9DcT8mVYL+RXLegbQ3/M7BiuDQqBWnCwnWYqTUIFgqFZBsbsJ4X4
         14gUWMc2x5XtYqPP537awe22ul/XCbh3B3hFGaiG/EaLldUDy3QcPVgWO2OZImNbY991
         0rzoKQJRiB6lW0wDPQJGRHHXH/X3XGka7GryoEylUxhz9xsOSm2rRh1d7WepBXacD6y+
         43SL0yiDTYe+tmGXeujO8Gfqzy1C0lA62ep3wYVnUjMd/XOlhYT7yMaqkKu5VBcy884x
         Kvvu31jF0PLVWzvaWeWADl6+xeRB5QZneLLq9bVhN4KzfhtYGg7nBdbsh5iXr0YzRgEi
         Bb7w==
X-Gm-Message-State: AOJu0Yxybk+MA2o8iLdzp0eGZW+2c+f5EXk9pHwysM0B9cdHv+J2D+B8
	ydG13PDrCyqiXQcLsefLXB5BOMSEemZ+FVNPiCirsygBGB4CJwd92mb4/ZI+
X-Google-Smtp-Source: AGHT+IHhuyF3Q5aMoRxTcIKNOLnWZcRH8x48JErwwfXrQ47VzMIdT98GE3bYCvYXoGlJMY1BxV6q6g==
X-Received: by 2002:a05:600c:3b14:b0:431:612f:189b with SMTP id 5b1f17b1804b1-43283246c05mr219961935e9.12.1730985783062;
        Thu, 07 Nov 2024 05:23:03 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E912B00E77793ED09024636.dsl.pool.telekom.hu. [2001:4c4e:1e91:2b00:e777:93ed:902:4636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm24372355e9.38.2024.11.07.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:23:02 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v3 2/3] net: support SO_PRIORITY cmsg
Date: Thu,  7 Nov 2024 14:22:30 +0100
Message-ID: <20241107132231.9271-3-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107132231.9271-1-annaemesenyiri@gmail.com>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux socket API currently allows setting SO_PRIORITY at the
socket level, applying a uniform priority to all packets sent through
that socket. The exception to this is IP_TOS, when the priority value
is calculated during the handling of
ancillary data, as implemented in commit <f02db315b8d88>
("ipv4: IP_TOS and IP_TTL can be specified as ancillary data").
However, this is a computed
value, and there is currently no mechanism to set a custom priority
via control messages prior to this patch.

According to this pacth, if SO_PRIORITY is specified as ancillary data,
the packet is sent with the priority value set through
sockc->priority, overriding the socket-level values
set via the traditional setsockopt() method. This is analogous to
the existing support for SO_MARK, as implemented in commit
<c6af0c227a22> ("ip: support SO_MARK cmsg").

Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 include/net/inet_sock.h | 2 +-
 include/net/ip.h        | 2 +-
 include/net/sock.h      | 4 +++-
 net/can/raw.c           | 2 +-
 net/core/sock.c         | 7 +++++++
 net/ipv4/ip_output.c    | 4 ++--
 net/ipv4/ip_sockglue.c  | 2 +-
 net/ipv4/raw.c          | 2 +-
 net/ipv6/ip6_output.c   | 3 ++-
 net/ipv6/raw.c          | 3 ++-
 net/ipv6/udp.c          | 1 +
 net/packet/af_packet.c  | 2 +-
 12 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 56d8bc5593d3..3ccbad881d74 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -172,7 +172,7 @@ struct inet_cork {
 	u8			tx_flags;
 	__u8			ttl;
 	__s16			tos;
-	char			priority;
+	u32			priority;
 	__u16			gso_size;
 	u32			ts_opt_id;
 	u64			transmit_time;
diff --git a/include/net/ip.h b/include/net/ip.h
index 0e548c1f2a0e..9f5e33e371fc 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -81,7 +81,6 @@ struct ipcm_cookie {
 	__u8			protocol;
 	__u8			ttl;
 	__s16			tos;
-	char			priority;
 	__u16			gso_size;
 };
 
@@ -96,6 +95,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm_init(ipcm);
 
 	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
+	ipcm->sockc.priority = READ_ONCE(inet->sk.sk_priority);
 	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..316a34d6c48b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1814,13 +1814,15 @@ struct sockcm_cookie {
 	u32 mark;
 	u32 tsflags;
 	u32 ts_opt_id;
+	u32 priority;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
 	*sockc = (struct sockcm_cookie) {
-		.tsflags = READ_ONCE(sk->sk_tsflags)
+		.tsflags = READ_ONCE(sk->sk_tsflags),
+		.priority = READ_ONCE(sk->sk_priority),
 	};
 }
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 255c0a8f39d6..46e8ed9d64da 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -962,7 +962,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc.priority;
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 5ecf6f1a470c..68e2af168da7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2941,6 +2941,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SO_PRIORITY:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		if (!sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg)))
+			return -EPERM;
+		sockc->priority = *(u32 *)CMSG_DATA(cmsg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..cd3e788600cc 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1328,7 +1328,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->ttl = ipc->ttl;
 	cork->tos = ipc->tos;
 	cork->mark = ipc->sockc.mark;
-	cork->priority = ipc->priority;
+	cork->priority = ipc->sockc.priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
@@ -1465,7 +1465,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		ip_options_build(skb, opt, cork->addr, rt);
 	}
 
-	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
+	skb->priority = cork->priority;
 	skb->mark = cork->mark;
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->transmit_time, SKB_CLOCK_MONOTONIC);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..f6a03b418dde 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -315,7 +315,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			if (val < 0 || val > 255)
 				return -EINVAL;
 			ipc->tos = val;
-			ipc->priority = rt_tos2priority(ipc->tos);
+			ipc->sockc.priority = rt_tos2priority(ipc->tos);
 			break;
 		case IP_PROTOCOL:
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 0e9e01967ec9..4304a68d1db0 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -358,7 +358,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IP);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 	skb_dst_set(skb, &rt->dst);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b4608bb316..ec9673b7ab16 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,6 +1401,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
+	cork->base.priority = ipc6->sockc.priority;
 	sock_tx_timestamp(sk, &ipc6->sockc, &cork->base.tx_flags);
 	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->base.flags |= IPCORK_TS_OPT_ID;
@@ -1939,7 +1940,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	hdr->saddr = fl6->saddr;
 	hdr->daddr = *final_dst;
 
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = cork->base.priority;
 	skb->mark = cork->base.mark;
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->base.transmit_time, SKB_CLOCK_MONOTONIC);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 8476a3944a88..a45aba090aa4 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -619,7 +619,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 
@@ -780,6 +780,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipcm6_init(&ipc6);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = fl6.flowi6_mark;
+	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0cef8ae5d1ea..dcce9fd33e98 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1353,6 +1353,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
+	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 
 	/* destination address check */
 	if (sin6) {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 886c0dd47b66..f8d87d622699 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3126,7 +3126,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc.priority;
 	skb->mark = sockc.mark;
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 
-- 
2.43.0


