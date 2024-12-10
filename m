Return-Path: <netdev+bounces-150809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96459EB9E1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2085B283B3A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C786329;
	Tue, 10 Dec 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVq9wbLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E6214213
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858031; cv=none; b=muSETKijxDPx3IVprzP4aXSmajJvmGSUUrSHhLy9ylnIGjuoruHKOENZRK7i3iQJxgYwXEfQZlDFJwY7IJe0LdC5mvK2lEgyqDa1DzGgmYWSg9pAyVzSoO2kcTu9A7gzw5FS3yS00FWmSg1YPUPWDdgJt0MSB73OtY5MciK3PoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858031; c=relaxed/simple;
	bh=Sl6GRW5iCPIpRgCJflqImLWJSqpqskSMz6hDhNcVQ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRJnXQc1YjmXW8xg5P6cTctWGyK86618zCxxPwGtO3xmoyit+xsma1FytJpEaIRfYOP5mlSQeoLR5K9Y+pndIhnuxZ56XBVGVorC1HUm9WiKX+lQ4qd72sQAWw1psQXkAxraYxpgB6JUPHkbUnK5crd9OWoGLhQO/s8ZxVKOEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVq9wbLl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434fe0a8cceso19037475e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733858027; x=1734462827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhdEgZMIttJrwhWdkX71iUAWJ6QOVvPMGJLsgMmFF/o=;
        b=hVq9wbLlBTvO/d6qvT2PT04pDEY/r18C3a2Gg/jCk2tDesw+gcRnfEMfBX4mDgYLch
         fwG9D2RND5wg6n37ISGu9psXMkOLdtg5fOm8sER7e0c6QM58ojZdogAsFH7rG4GfZIyZ
         oB0BXGV9FGNa1yBaemoX5p9oISl6oKfc2qKDSgPiOp/dkmg2vmGhqZecudG9oWxKFWRa
         eTGBjLzSNy++3Znu4rdozGKX+fKIWs8gzTpJzu/zpO6Bt270KmMRh3+XoV0cUlbB7mKm
         FKI/sUgKiemWRTr526rV+Ti8sJ9XM1KTrNptPWsCZ38dNqur3htgK57NDfQOQqQDZ29d
         FhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858027; x=1734462827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhdEgZMIttJrwhWdkX71iUAWJ6QOVvPMGJLsgMmFF/o=;
        b=fDF+C+9lSdOmRTxDOxhoI11eSB73hjsDfRZ2iPnPWJIPnLTtIxqmAth4uLGVUNUztC
         GA4JJONCRwy4fLSiYs7qWhRdG9LirOlQDK5QsR5DpAT8gEeCdb2JWqCYlWJ9KHVTIaVp
         DbhOaiBSgiEZNjk5QsEm6q0ak+b67HbE9T+aDYdPOy5mQIEOIFIftyRXci0AoYEgzWxB
         7wsLS0VklzWRILIuHlv00QbrQyjGmUYmrNswR+g9Fii0rMo6ElvCth/vQagehNyTY782
         1onAK21HsvVQuNMBSVNXKxI+Lwn1dlGD8BQx8hSFRAl69gPglGlqRNbQoUx1S68S8kRh
         atAQ==
X-Gm-Message-State: AOJu0YzERowhhrYMlB5RmZzy0BMhs9G8nbp+83VumVcXXDbEBE7++8xO
	qvarLyGZVIyZqpcv4/f8H/MSD4SLEc2kJyh9RhdAyl4bOdaDygy49z8xBQ/YUjc=
X-Gm-Gg: ASbGncuscRPLAFF5V6ynak5r809BS2MC3C1JI22KbfUWCWfQ8Nx7wu16Yt8jzuNX5b4
	dxfqDXVQ1jahpkAcsomqFp7WHBnq3Z8zNTQAe3lvUv9jOTdNSYU2GJ+e0y4Vfv3f4c4jEjZq4uZ
	lWFEvsrWwCGfLe9m8OHzCyBmANg93iKtZH7y62TR+N4745acbXIziqacMUqTV0/NkqMevNI+jDz
	TC1dYHrOau3kdAL9u52G77M4P8HuNZhQCqRAz2N3nrde2Gk7n+PMDrTARcLPFjjOi7ulYhL2yio
	jMEmhqj/p47SLxJxeGX9GzMlQaTnolrLpE6GBRDkcly0dhvqRaUZsZUGXX12wQ==
X-Google-Smtp-Source: AGHT+IHh74tDz1cnaWa1cvUXX5iI2mm4mS7Jfk48FOZIRDX5fmRCK0+BBFpeZq3FwETEQK9SpFgsJA==
X-Received: by 2002:a05:6000:2d02:b0:385:f996:1bb9 with SMTP id ffacd0b85a97d-3864ce985ffmr156840f8f.23.1733858027069;
        Tue, 10 Dec 2024 11:13:47 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C7006406573B5E53AD5C.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:6406:573b:5e53:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13310345f8f.108.2024.12.10.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:13:46 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v6 2/4] sock: support SO_PRIORITY cmsg
Date: Tue, 10 Dec 2024 20:13:07 +0100
Message-ID: <20241210191309.8681-3-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210191309.8681-1-annaemesenyiri@gmail.com>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
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
index a59204a8d850..f45a083f2c13 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1333,7 +1333,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->ttl = ipc->ttl;
 	cork->tos = ipc->tos;
 	cork->mark = ipc->sockc.mark;
-	cork->priority = ipc->priority;
+	cork->priority = ipc->sockc.priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
@@ -1470,7 +1470,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
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
index 3d672dea9f56..993106876604 100644
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
@@ -1942,7 +1943,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
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


