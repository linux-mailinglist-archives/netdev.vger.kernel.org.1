Return-Path: <netdev+bounces-141199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD49BA019
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176ED1F21D8F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AB189BBB;
	Sat,  2 Nov 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lerIXVpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87318A6B7
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551932; cv=none; b=XStzhKm2bMoqolkXv1CaEx49DOqZbMLGkG2RZCuyzHC21/BRA1PDomnOnmSJoS+B2vZfvY8rLrWmiQC+/lC3Xqc++OFnzHpgnn/78ukd7zftRlyCwIA4nqUPJga+Buxe8TaGkBocSrZq6tKhyULhQCxutoRwCsY6EbYUmiglT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551932; c=relaxed/simple;
	bh=ERnxGbMuDui9PMgdN01NqJNw8wE4ZAg8jWr01Vtr28w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuvLQNsGEZ6ocFMxQUf5wPPfAdnmOM77nvgP10BU1IYW7foQMj7FrwancUp399HY4WpZNGz1cGxtlyjG1/IjFJgxldlHryMVO/GFTftSAyCOPo/zGirnpF0OIw0yq94P96PZ2mLuuSFfdbRcuGOQHRTbTr+5aLr0wLMZq+Fxtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lerIXVpc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso21332855e9.1
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730551928; x=1731156728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYk8w4TkW05tqDbmrR1dofL1c3g5zJruyBYVRSy+Ph0=;
        b=lerIXVpcAbLVsjG8SFgpZHqx0BLXWccRYT3mTZ57MW3DiGwkEaLdN3Jgvr4ZFu4yhH
         VBatmL26UwYV16ndL0nPlyCORLWhU6tn8vRKqqiQX+iYKOigj7ObIudMF68i/kkzOzO4
         e0hQheqMUiMU0Z4YaaGurJ8uMIRT9koleMK5AWhcDElfdRF/RcaU5OJYYTp8rIXQ6Xy+
         yH/TMflJeXVcINwS9Ysa2Z+rpuRZ2zX3adKyKs/c3RakRWzseUiY0FJJtukIYh+esXAJ
         b6BoNB5pJem5TCG9FHrsCZLfMsCoChwGkF3sziJLmB4nCli2FHb4gfmR3mCF2F0mtllQ
         XX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551928; x=1731156728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYk8w4TkW05tqDbmrR1dofL1c3g5zJruyBYVRSy+Ph0=;
        b=gs4TDTvugbynAHQNsQepORqTQZZueGv2XSH0eHiv6uTIwirAJq3WnAoHw7QmWLJgs0
         jbTKrhN5QY808G3hTi2lOuCLKvVEF6L75g03x4yuHqZQwNX0WQNHzf49PTmY19rvdhMi
         U5dFU6YiJvLK4AyL4a3L4qaOrmmxRcNlbhkMss33BEgepv+1JWWRKlnJ+qnJLKP33TZG
         vzAJ7I+0FIjaaxT/owoneZqHP8+Mqdz/Gxm9jL9Vnbts10D9sdk80nUwtxZ9MyWIonR/
         eV1OFwRIy+GymaCj3muNXbFasbo3RmFWfvc9t3XBcPUkaepuRLZ/J3JTZqP851a+UHRP
         RgLg==
X-Gm-Message-State: AOJu0YzKzREIyvNzTqfoSjbs6qjB8zyR4lUA80eb+01tXPMYeiHuSwwM
	+U4367dUeQrIGOIzjBXwQMKtiouqq5oRIFaXr8tdhmZZeAeQ6n2hCrd+htnX
X-Google-Smtp-Source: AGHT+IEfR2KCbBaeiHh9ft8AgR+x5Be3xqXpMHyWKsk2ZLPOGKNkSFm9E0bJBN37Wcw56LKZmN+f6g==
X-Received: by 2002:a05:600c:3ca3:b0:42f:823d:dde9 with SMTP id 5b1f17b1804b1-4319acbba20mr248320375e9.21.1730551928362;
        Sat, 02 Nov 2024 05:52:08 -0700 (PDT)
Received: from raccoon.t.hu (20014C4D21419900D048749C30556844.dsl.pool.telekom.hu. [2001:4c4d:2141:9900:d048:749c:3055:6844])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947bf4sm127471305e9.27.2024.11.02.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:52:08 -0700 (PDT)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v2 2/2] support SO_PRIORITY cmsg
Date: Sat,  2 Nov 2024 13:51:36 +0100
Message-ID: <20241102125136.5030-3-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102125136.5030-1-annaemesenyiri@gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux socket API currently supports setting SO_PRIORITY at the
socket level, which applies a uniform priority to all packets sent
through that socket. The only exception is IP_TOS; if specified as
ancillary data, the packet does not inherit the socket's priority.
Instead, the priority value is computed when handling the ancillary
data (as implemented in commit <f02db315b8d88>
("ipv4: IP_TOS and IP_TTL can be specified as ancillary data")). If
the priority is set via IP_TOS, then skb->priority derives its value
from the rt_tos2priority function, which calculates the priority
based on the value of ipc->tos obtained from IP_TOS. However, if
IP_TOS is not used and the priority has been set through a control
message, skb->priority will take the value provided by that control
message. Therefore, when both options are available, the primary
source for skb->priority is the value set via IP_TOS.

Currently, there is no option to set the priority directly from
userspace on a per-packet basis. The following changes allow
SO_PRIORITY to be set through control messages (CMSG), giving
userspace applications more granular control over packet priorities.

This patch enables setting skb->priority using CMSG. If SO_PRIORITY
is specified as ancillary data, the packet is sent with the priority
value set through sockc->priority_cmsg_value, overriding the
socket-level values set via the traditional setsockopt() method. This
is analogous to existing support for SO_MARK (as implemented in commit
<c6af0c227a22> ("ip: support SO_MARK cmsg")).

Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 include/net/inet_sock.h | 2 +-
 include/net/ip.h        | 3 ++-
 include/net/sock.h      | 4 +++-
 net/can/raw.c           | 2 +-
 net/core/sock.c         | 8 ++++++++
 net/ipv4/ip_output.c    | 7 +++++--
 net/ipv4/raw.c          | 2 +-
 net/ipv6/ip6_output.c   | 3 ++-
 net/ipv6/raw.c          | 2 +-
 net/packet/af_packet.c  | 2 +-
 10 files changed, 25 insertions(+), 10 deletions(-)

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
index 0e548c1f2a0e..e8f71a191277 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -81,7 +81,7 @@ struct ipcm_cookie {
 	__u8			protocol;
 	__u8			ttl;
 	__s16			tos;
-	char			priority;
+	u32			priority;
 	__u16			gso_size;
 };
 
@@ -96,6 +96,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
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
index 5ecf6f1a470c..d5586b9212dd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2941,6 +2941,14 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SO_PRIORITY:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		if (sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg))) {
+			sockc->priority = *(u32 *)CMSG_DATA(cmsg);
+			break;
+		}
+		return -EPERM;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..72b37321c0ea 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1328,7 +1328,10 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->ttl = ipc->ttl;
 	cork->tos = ipc->tos;
 	cork->mark = ipc->sockc.mark;
-	cork->priority = ipc->priority;
+	if (cork->tos != -1)
+		cork->priority = ipc->priority;
+	else
+		cork->priority = ipc->sockc.priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
@@ -1465,7 +1468,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		ip_options_build(skb, opt, cork->addr, rt);
 	}
 
-	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
+	skb->priority = cork->priority;
 	skb->mark = cork->mark;
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->transmit_time, SKB_CLOCK_MONOTONIC);
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
index 8476a3944a88..c82cc6cfdbd2 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -619,7 +619,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 
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


