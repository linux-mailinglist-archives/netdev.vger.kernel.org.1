Return-Path: <netdev+bounces-149400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B69E5751
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A8116D968
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C421A437;
	Thu,  5 Dec 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJwcHJ0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34E219A9F
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405517; cv=none; b=MAaXHMxh/MNIiGuO16TYPfg+gmFw3KtcGjRBnpMjVrNbeGU9jMphh6mCT2xizk4y0glK6pz5Le9cuJYEU3yLssgRb4B96f0ShvAqSgIjzmLZzuYnMP6mCiyOvMlpCVJkjIsTvp7zNmXxpE9smkFlumWxO2mBQ0DRsZA9KBw7/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405517; c=relaxed/simple;
	bh=DbHPvlIimZiedmRYTDT8zdoDSyoO1hTrxnWsGzmSiPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwHzklUPmdR5+k8rHQzsKRU2TqAVmnybpXDYOQEkv0z1ExSEVL8M9szMehvfkNlxqY8Cb6/2gy/tovm1xBeMHxaLG35WU5xcE7SFGmr+KI8ju8yIcbgDbMjLoXTgyjKYb+MHMveqwO/4CCnEtQ3b9TkHFroTL0zCWjlIQ73s0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJwcHJ0j; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a1639637so10028715e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405514; x=1734010314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEBuFHKRsrtBdcV60BXZPS+V3Bhyi4EnWZVBsP3ESnY=;
        b=VJwcHJ0jy6WCoQKINqv2wrOMLpcTvsE/HvmuOhO7I3fAQtsOsMalnq5oDKLgQ0Z7bS
         DmsD0Ho8xVlWthb4JtHwctLnX4369Fo9kmiDVtCRlnKiM7Xg3I+ryUR6LTh/bFSWZSUX
         q0Ms9X3j4SEB/M63WJd25WUfSICOchKAj/8V1M6j+gQzTDO5UlUcQYYgA12Pxyi5fT+a
         jnZAGUvBHYdR+Ysx/hA1fin7Nh/kiBrdFhA7pUxOMmyG021z32Q7a55BbwYWTPBnbI84
         1GQLP6epKCwWjQsPJLgps0pGHmjdfGSiCr8WvNxxn99nmhEBp2iCksCUoWh312bWMjbF
         JjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405514; x=1734010314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEBuFHKRsrtBdcV60BXZPS+V3Bhyi4EnWZVBsP3ESnY=;
        b=aWHosflMHeOKxQKtClmt8Lr8EmsAq8UWH4UWO9dp6b4jbL/5mzr1BgbwwPmjqYcD+8
         XZo9dlbTl/Cos0RXf5MGa1sgZnwBQmXJtcrbtSwY8tuWSF4wJVwxiJcSgTbVS1vxYYja
         ScuwaB1gQnnTWBzZ60BVz8nKGP5cmk1Qr8Jk0bN1xk8ckjADdn28HJl60NYVmvLtxKgi
         IuEazh0qzvTiTrbpFZ2VEnuqLBVCKpTkvbSj5AA4Up3XeXLBQzGEQuM35e3v1wIaa084
         kPo9JuzfIlIsuB1jMRghyJRcqT6qRMCQkwSspjWdzO7GgxvUiX5y6pAeoDHMLYKvl/Rv
         djlA==
X-Gm-Message-State: AOJu0YyKnzIflC2VmeOpzVQmFrVqCcPixsx1yAvw6Hjh2lNw+enyLfGe
	qFDp74U1qnrEey8MnWLatZmlQ1CSXN/U+lxZtqUfndPfqMOyVgabol5452nYfuk=
X-Gm-Gg: ASbGncsVGGj5mKrsodnGBuNrQyletUZpY1zMZO7t2j/Unnfj0bYldnhISLjoOGEiWTv
	ijoZwdi0wKchSzmdlvebJv8M1PE/wkMz9WdiVqgDNW/5tOGZm1mJ5kQ3ttEAs5SflCDodsZM7bD
	g+V5Dz6jEYo+DuzVgpUKCfjrHLGnAUvWF3P+0eJt4odpnK8VAFUVitN9KpP+SLNr5SB+aFacSy2
	30l+kB0bJeszNMxuKz0P3oCwl4Ku6fey2sL+9EvT4YC+Mr5RxR0R5B0S6IZksoREKe0mD7tzUR/
	U4Gp3VHSdMSyCg2FJTlYnMPUydlNbMapFW3yhcJXlUKrLwtJfvFFeD96fQ==
X-Google-Smtp-Source: AGHT+IFOPWJMarFVfSzL3FbSB8qDXZH+5RG/wGlL4bNwVMPAVnkAnLWVTYt1XAEivC3GTDAXLrQHYw==
X-Received: by 2002:a05:600c:5105:b0:434:a6af:79f6 with SMTP id 5b1f17b1804b1-434d09c2594mr94622725e9.15.1733405513532;
        Thu, 05 Dec 2024 05:31:53 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C700ABF575982C3B3E76.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:abf5:7598:2c3b:3e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm60852465e9.24.2024.12.05.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:31:53 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v5 2/4] sock: support SO_PRIORITY cmsg
Date: Thu,  5 Dec 2024 14:31:10 +0100
Message-ID: <20241205133112.17903-3-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205133112.17903-1-annaemesenyiri@gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
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

According to this patch, if SO_PRIORITY is specified as ancillary data,
the packet is sent with the priority value set through
sockc->priority, overriding the socket-level values
set via the traditional setsockopt() method. This is analogous to
the existing support for SO_MARK, as implemented in commit
<c6af0c227a22> ("ip: support SO_MARK cmsg").

If both cmsg SO_PRIORITY and IP_TOS are passed, then the one that
takes precedence is the last one in the cmsg list.

This patch has the side effect that raw_send_hdrinc now interprets cmsg
IP_TOS.

Reviewed-by: Willem de Bruijn <willemb@google.com>

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
 net/ipv6/ping.c         | 1 +
 net/ipv6/raw.c          | 3 ++-
 net/ipv6/udp.c          | 1 +
 net/packet/af_packet.c  | 2 +-
 13 files changed, 24 insertions(+), 11 deletions(-)

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
index 9016f984d44e..a3d9941c1d32 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2947,6 +2947,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
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
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 88b3fcacd4f9..46b8adf6e7f8 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,6 +119,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, sk);
+	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
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
index d766fd798ecf..7c14c449804c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1448,6 +1448,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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


