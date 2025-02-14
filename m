Return-Path: <netdev+bounces-166589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB12A36843
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FB33B2028
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87271FCFE6;
	Fri, 14 Feb 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHn9JYve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEDC1FCD08
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572051; cv=none; b=NzSqmVHeXvhZDfGEzPG9gVdU0v7sZHVqGuAilzOK7c+diGNTu7AJldecF3wuCL7CiFX79UvZ8QoJUSS7wSIvvkPABgvGy9y2M9/yI4aAY6jU8HxLVFwAW2AravIRcs58BEpZooAvsJK36lAAc8JbwUmhORT3uzr1W90ePe8+QyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572051; c=relaxed/simple;
	bh=V5ZFL3ULgoosoPu5EmnzFr55Ra2ewdgF+sSpU4Ieya4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVjTiKU2wiVQ1jB/EUgPb/CgG9YWkG89M+/EOj1b7HziQ6srrgAz1HbsRm/oypcq1GkbOMjO718b+v3A7pPdFxCasEV+GxUKp2I81THW2lzkeEB7PM0X2r2WXKv7o4+wWTpkbRxqpdGy8jyp1FQJg7ZmZdBB5XlDrTAbs6UFHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHn9JYve; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8e8445219so22699326d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572048; x=1740176848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwyGUWMeNL1A1pupcuqtyY3Swyxyu2aa4STZA3HcRBE=;
        b=iHn9JYveX5KYvLgg2axH6gdWLINMz1m7q4ENpnmGCf7S3mX2l8U6xWexuPAats9jws
         Tq/Qa2UAVe1gbGtfOIuWmaTROcnN3DtXA0puLvJOOwqQToeb6w+ytEaS8YQOnn2JXpTV
         y23AWUN4Clc1naKjalOinFgtPkufbUq24ZciXT71cUEAu3Y8SiDQZCO24SD1dqf2jad1
         uFnWyGLZDk9Koy3R0rS7M41wDnDPOqevQngA8TvJU4DTJT8vqfsHVa7+kxa0lEO4QlxQ
         Sfb5QkhvSaD/NimTexeP6KSDP69t/tkitYHgi8DhOoM8pLgjPrV+04z7kgDxVJNokVpM
         XE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572048; x=1740176848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwyGUWMeNL1A1pupcuqtyY3Swyxyu2aa4STZA3HcRBE=;
        b=F8CUkFVj21OU5xI0F73efBZZU0Pw72EnILcvIUDF3EOJyBxbgzqZImpZ4Z4vJUN4FT
         J+82VD5lDR4yPrH0kOE6ilwad+zfSHx3n+PUcimKQOxPyrX7rXEuNP8DkhO5QEyCt8PV
         NyyBi5WcWn6CWBK4BTf3q7RxROphao+etxxnEuUpWiyt1fo4s3AFekXy8+oP7jnbP/fK
         9vKyZueAuc+IxrpOI0eDAYcwkCHp0B34RYPR/S9erO0WfvcxoKljBk5JPHx/Uoz1H/hO
         760Xi1mr9H+BahPwFOepa1cSGPohhUyD+sfpVgdsCv9p6l7UiB5UJ5fOQofg7lwcDSRd
         6SkQ==
X-Gm-Message-State: AOJu0Yy6Lpj1d7DYlQU4UYkQbubpKOA6Hkq8/ZphKSQN1p1TCWCdaIp2
	Ng9UVnAzGYkFeWFqqy+GuvN1IQuuK4XFq05241EeGAy9pgzWZbcsJ3KvAg==
X-Gm-Gg: ASbGncuowlBodp/4A5NOx25lGpd0dJ1WHBZuCGuGWEk1Rwjkme8+bJ7xcBFZmHeTM+j
	0GpEdA00M9gxZSn+vJF9xyOMy4SIHz9Qhiee3gyUCx9sRY0cMTspE6/tKd/LZyJVDu8N1osrV3I
	gre3PVj4lWzCMhrmRn+AeJFqaObWIcpssZMrIXqYuyjMfqRsm82WQuwOf0RRPQ3c+HJ4O8gPIbi
	2viuyYbi4JVM/owCeWhyaPBt7HFIGMDlHWs5Y5kkNgdnkQ/HczPw2geumbJSU+pza4d6eNGJxzK
	H/EIfFX/L9RlhgaGVSbx/xQ7FFkpIJLcAOj073UN77/tha8BaUFnnEskkFMMi4NElHBHvzNSLbH
	FKNQKzOOz6Q==
X-Google-Smtp-Source: AGHT+IFE8yQLxEedbq5hIbSs27hth6IqE5txapyIwoYaRtcjYdLU4esUj6sLT213pcXyYr3RoMBlow==
X-Received: by 2002:ad4:5ae6:0:b0:6e6:659d:296 with SMTP id 6a1803df08f44-6e66cc86b35mr19678446d6.5.1739572048658;
        Fri, 14 Feb 2025 14:27:28 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:28 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 4/7] ipv4: remove get_rttos
Date: Fri, 14 Feb 2025 17:27:01 -0500
Message-ID: <20250214222720.3205500-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Initialize the ip cookie tos field when initializing the cookie, in
ipcm_init_sk.

The existing code inverts the standard pattern for initializing cookie
fields. Default is to initialize the field from the sk, then possibly
overwrite that when parsing cmsgs (the unlikely case).

This field inverts that, setting the field to an illegal value and
after cmsg parsing checking whether the value is still illegal and
thus should be overridden.

Be careful to always apply mask INET_DSCP_MASK, as before.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>

---

v1->v2
  - limit INET_DSCP_MASK to routing
---
 include/net/ip.h | 11 +++--------
 net/ipv4/ping.c  |  6 +++---
 net/ipv4/raw.c   |  6 +++---
 net/ipv4/udp.c   |  6 +++---
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 3c4ef5ddad83..ce5e59957dd5 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -92,7 +92,9 @@ static inline void ipcm_init(struct ipcm_cookie *ipcm)
 static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 				const struct inet_sock *inet)
 {
-	ipcm_init(ipcm);
+	*ipcm = (struct ipcm_cookie) {
+		.tos = READ_ONCE(inet->tos),
+	};
 
 	sockcm_init(&ipcm->sockc, &inet->sk);
 
@@ -256,13 +258,6 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
 	return RT_SCOPE_UNIVERSE;
 }
 
-static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
-{
-	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
-
-	return dsfield & INET_DSCP_MASK;
-}
-
 /* datagram.c */
 int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 619ddc087957..85d09f2ecadc 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -705,7 +705,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	struct ip_options_data opt_copy;
 	int free = 0;
 	__be32 saddr, daddr, faddr;
-	u8 tos, scope;
+	u8 scope;
 	int err;
 
 	pr_debug("ping_v4_sendmsg(sk=%p,sk->num=%u)\n", inet, inet->inet_num);
@@ -768,7 +768,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		faddr = ipc.opt->opt.faddr;
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
 	if (ipv4_is_multicast(daddr)) {
@@ -779,7 +778,8 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	} else if (!ipc.oif)
 		ipc.oif = READ_ONCE(inet->uc_index);
 
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos, scope,
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
 			   saddr, 0, 0, sk->sk_uid);
 
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4304a68d1db0..6aace4d55733 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -486,7 +486,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	struct ipcm_cookie ipc;
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
-	u8 tos, scope;
+	u8 scope;
 	int free = 0;
 	__be32 daddr;
 	__be32 saddr;
@@ -581,7 +581,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			daddr = ipc.opt->opt.faddr;
 		}
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
 	uc_index = READ_ONCE(inet->uc_index);
@@ -606,7 +605,8 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 	}
 
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos, scope,
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
 			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3485989cd4bd..17c7736d8349 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1280,7 +1280,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int free = 0;
 	int connected = 0;
 	__be32 daddr, faddr, saddr;
-	u8 tos, scope;
+	u8 scope;
 	__be16 dport;
 	int err, is_udplite = IS_UDPLITE(sk);
 	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
@@ -1404,7 +1404,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		faddr = ipc.opt->opt.faddr;
 		connected = 0;
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 	if (scope == RT_SCOPE_LINK)
 		connected = 0;
@@ -1441,7 +1440,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		fl4 = &fl4_stack;
 
-		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark, tos, scope,
+		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
+				   ipc.tos & INET_DSCP_MASK, scope,
 				   sk->sk_protocol, flow_flags, faddr, saddr,
 				   dport, inet->inet_sport, sk->sk_uid);
 
-- 
2.48.1.601.g30ceb7b040-goog


