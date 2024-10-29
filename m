Return-Path: <netdev+bounces-139947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13689B4C59
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008281C2110F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B1206E9A;
	Tue, 29 Oct 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9DVbJkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE943206E93
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212955; cv=none; b=WyIXSM082FidwLOHneBidQM843lzK7/jJk5sLMDWz3MPWJqg0225YDuC6iR85srLJxZkB+qwg66hr/1q8S8SQDZ/bMI7C0Yo0bm8S4sc7mWYoXwfBw2q0SvrzgxKL17G6WCfNmd++kevzquT6hJl4Em4h7meqOBaJARFAbhLglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212955; c=relaxed/simple;
	bh=MLymTEsRzQuzQENV/vi/FF8jTFgeXj2xG9Aa0BD56Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SApyZOHL+SR4NQGY6IVHNxUkMcefdSVIxeJrbR3J1qgOAmkWuWQr2G3f9R7XWf4Js8Ev5+RJOIYWqzAv8WflM0t9VluexqrqTDXKFg1ExlScosV9vmt3eJTSHl5AFZucNAeGpiJZxrk2adD1qO8CTzyQHAop3DK0+CTG/fB71MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9DVbJkJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso3674066f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730212951; x=1730817751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrhufGRDR04gVm6b8Pn3NznE+nb7oNa9ZMGbVAljqGU=;
        b=Y9DVbJkJu81u6GKxz+ue1hetQZsVRVSNQB+mOiTrWLSHb2Gi4Le3XSWU2Vk+qhQ4Y7
         bGYTud9jxxBccMsetn4xRZ0Qzm5mVRR8xIgho6IhDY9KIQz2NFnHiHByHBN3nbtXkFIV
         VNB24fDLw9tNLCmd48CPmGKXykEYkReB6UsRppYzLLOlfsLLN5Snk23O8ySboeK8/w2P
         H/xxJ3FNevB2UHRAL578IRXyZ84LIoyj5fU5Hr6OnfjvOsg29o3GYAKJD32kDAmx4/Ax
         W9tClwE1x2a5eT9UIGEKqgjpXshL6Ucq4tnqqbAog55ZNc00sZIr3N+awPcwzmIajuWy
         tLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212951; x=1730817751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrhufGRDR04gVm6b8Pn3NznE+nb7oNa9ZMGbVAljqGU=;
        b=AJmRwlmKG82NrZbxSzHDtyfmR90llLrUPHnQda8h/o+mqtSytUmRrn+fzpnY789kYa
         pLvEkYUo9ID71xAy7/rtemy7mhNI/dl5zZqhhf9BKEnOGiddf2OyWmG6CS8XV7TYXtXx
         q1NNaBujP4qURW+vX+zlIMCk8kCBQ2eOUTZ9i4ucx6Y1dzDQv/2dRg8aVLJFH/CKvvHM
         yFw2vTDnYCt0h0Yu2GWXVDnCOIFLUfb/FhCMyO8wBxjzhQZjnWUI+0rMXijqRX9pV/3S
         49V2JfBFSvVsyr/kllInGEEEiXtpKq6/E6XyIv0QqWLE/27EfZ3KyAtiheJttJ4Y4p9c
         qQpQ==
X-Gm-Message-State: AOJu0Yzi94RyWpXFbd5g+vzVpmiZd2UTsjbTTibYmFETB/2AyDTFm132
	uiMDCHND6C4IN/pksxbjcx5YwTOytkZGTpnTNJEqU9+xDu9QlE9Z67uYB0lnyFk=
X-Google-Smtp-Source: AGHT+IGrRPMLyPdCcZ1emCx91qVERuCTAPkElgmKPMNwQXBl5HWmxVJ/D7S1uIPIykF4/vXh36KjIQ==
X-Received: by 2002:a5d:48c4:0:b0:37d:50a4:5da4 with SMTP id ffacd0b85a97d-38061206c42mr8709205f8f.50.1730212950647;
        Tue, 29 Oct 2024 07:42:30 -0700 (PDT)
Received: from localhost.localdomain (20014C4E1E932F009E48D667672CC3C0.dsl.pool.telekom.hu. [2001:4c4e:1e93:2f00:9e48:d667:672c:c3c0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b713f0sm12701458f8f.75.2024.10.29.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:42:30 -0700 (PDT)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com
Subject: [PATCH net-next] support SO_PRIORITY cmsg
Date: Tue, 29 Oct 2024 15:41:40 +0100
Message-ID: <20241029144142.31382-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Linux socket API currently supports setting SO_PRIORITY at the socket
level, which applies a uniform priority to all packets sent through that
socket. The only exception is IP_TOS, if that is specified as ancillary
data, the packet does not inherit the socket's priority. Instead, the
priority value is computed when handling the ancillary data (as implemented
in commit <f02db315b8d888570cb0d4496cfbb7e4acb047cb>: "ipv4: IP_TOS
and IP_TTL can be specified as ancillary data").

Currently, there is no option to set the priority directly from userspace
on a per-packet basis. The following changes allow SO_PRIORITY to be set
through control messages (CMSG), giving userspace applications more
granular control over packet priorities.

This patch enables setting skb->priority using CMSG. If SO_PRIORITY is
specified as ancillary data, the packet is sent with the priority value
set through sockc->priority_cmsg_value, overriding the socket-level
values set via the traditional setsockopt() method. This is analogous to
existing support for SO_MARK (as implemented in commit
<c6af0c227a22bb6bb8ff72f043e0fb6d99fd6515>, “ip: support SO_MARK
cmsg”).

Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 include/net/inet_sock.h |  2 ++
 include/net/sock.h      |  5 ++++-
 net/can/raw.c           |  6 +++++-
 net/core/sock.c         | 12 ++++++++++++
 net/ipv4/ip_output.c    | 11 ++++++++++-
 net/ipv4/raw.c          |  5 ++++-
 net/ipv6/ip6_output.c   |  8 +++++++-
 net/ipv6/raw.c          |  6 +++++-
 net/packet/af_packet.c  |  6 +++++-
 9 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index f9ddd47dc4f8..9d4e4e2a8232 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -175,6 +175,8 @@ struct inet_cork {
 	__u16			gso_size;
 	u64			transmit_time;
 	u32			mark;
+	__u8		priority_cmsg_set;
+	u32			priority_cmsg_value;
 };
 
 struct inet_cork_full {
diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..e02170977165 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1794,13 +1794,16 @@ struct sockcm_cookie {
 	u64 transmit_time;
 	u32 mark;
 	u32 tsflags;
+	u32 priority_cmsg_value;
+	u8 priority_cmsg_set;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
 	*sockc = (struct sockcm_cookie) {
-		.tsflags = READ_ONCE(sk->sk_tsflags)
+		.tsflags = READ_ONCE(sk->sk_tsflags),
+		.priority_cmsg_set = 0
 	};
 }
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 00533f64d69d..cf7e7ae64cde 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -962,7 +962,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
+	if (sockc.priority_cmsg_set)
+		skb->priority = sockc.priority_cmsg_value;
+	else
+		skb->priority = READ_ONCE(sk->sk_priority);
+
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..899bf850b52a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2863,6 +2863,18 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SO_PRIORITY:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+
+		if ((*(u32 *)CMSG_DATA(cmsg) >= 0 && *(u32 *)CMSG_DATA(cmsg) <= 6) ||
+		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+			sockc->priority_cmsg_value = *(u32 *)CMSG_DATA(cmsg);
+			sockc->priority_cmsg_set = 1;
+			break;
+		}
+		return -EPERM;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..0e44ebd031f7 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1322,6 +1322,8 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->ttl = ipc->ttl;
 	cork->tos = ipc->tos;
 	cork->mark = ipc->sockc.mark;
+	cork->priority_cmsg_value = ipc->sockc.priority_cmsg_value;
+	cork->priority_cmsg_set = ipc->sockc.priority_cmsg_set;
 	cork->priority = ipc->priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
@@ -1455,8 +1457,15 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		ip_options_build(skb, opt, cork->addr, rt);
 	}
 
-	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
+	if (cork->tos != -1)
+		skb->priority = cork->priority;
+	else if (cork->priority_cmsg_set)
+		skb->priority = cork->priority_cmsg_value;
+	else
+		skb->priority = READ_ONCE(sk->sk_priority);
+
 	skb->mark = cork->mark;
+
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->transmit_time, SKB_CLOCK_MONOTONIC);
 	else
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 474dfd263c8b..bbe481dc98a9 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -358,7 +358,10 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IP);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	if (sockc->priority_cmsg_set)
+		skb->priority = sockc->priority_cmsg_value;
+	else
+		skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 	skb_dst_set(skb, &rt->dst);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f26841f1490f..4c4f4b76ef90 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,6 +1401,8 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
+	cork->base.priority_cmsg_set = ipc6->sockc.priority_cmsg_set;
+	cork->base.priority_cmsg_value = ipc6->sockc.priority_cmsg_value;
 	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
 
 	cork->base.length = 0;
@@ -1931,7 +1933,11 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	hdr->saddr = fl6->saddr;
 	hdr->daddr = *final_dst;
 
-	skb->priority = READ_ONCE(sk->sk_priority);
+	if (cork->base.priority_cmsg_set)
+		skb->priority = cork->base.priority_cmsg_value;
+	else
+		skb->priority = READ_ONCE(sk->sk_priority);
+
 	skb->mark = cork->base.mark;
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->base.transmit_time, SKB_CLOCK_MONOTONIC);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 608fa9d05b55..6944dc3ec4c9 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -619,7 +619,11 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	if (sockc->priority_cmsg_set)
+		skb->priority = sockc->priority_cmsg_value;
+	else
+		skb->priority = READ_ONCE(sk->sk_priority);
+
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4a364cdd445e..8b7924f775a4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3125,7 +3125,11 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
+	if (sockc.priority_cmsg_set)
+		skb->priority = sockc.priority_cmsg_value;
+	else
+		skb->priority = READ_ONCE(sk->sk_priority);
+
 	skb->mark = sockc.mark;
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 
-- 
2.43.0


