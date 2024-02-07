Return-Path: <netdev+bounces-69834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4684CC9F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDE81F26A16
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDB7C088;
	Wed,  7 Feb 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFppjvhr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6A7CF23
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315924; cv=none; b=Z/Npevhm2xvQUVAe9TuiMUX6DlX8t+d9c9T90VvpRC2R+/cf7H3VqkrijPPUH/s+wUYEXOlBWyvcsavrWlAapoI+Pk7NsGxSEtPdmKeVqmgB69uwM4vfoI9LVvOQxyE/T22A/ViW4M48FhklMaHYrBncsfIGX9J7fD927VH4Ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315924; c=relaxed/simple;
	bh=YbF7ItpSq414VVt+Jfn2L3tG7nDh6HffiP4//B+QFio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVX7GZu/lDIfZSnaOU4A+Z3EoW7kNwis8Jfpz6yw9cZybv0Z2znt8xK9FkLCbCc3bzynk18nirO3BlrPJh61JF/yLY30td9gbr7VDWXnX0TBTcoMOqgoG4Ky80Xt2AKXNBDZ3uKk6xWtW3tlAyPSimrYzC0nraWLikE8PfHxhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFppjvhr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a38a1a9e2c0so9096766b.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315920; x=1707920720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlp4P8f0l0aVyHwDmrWrWXYRsktkcKQu/QRPLRlhkB4=;
        b=LFppjvhrwXbBgiG/MQ1QybqR/PokfBRP2yXnvDYU+AC+nx6jOcPIcOhg+OcR8O/kMd
         NEjmIXOub8x7HzdoRtBpA4KvkB3EUFvV1rWz75CChozbo4TSPJW8QGv8v76/f7eJS4S7
         SAt8NbiK58lZ1y3wJPAoS7mz0JpqJbpB6mAGyTmnKOqUmPIsqr0+a3gg3l+IFVEQv5BY
         Wdl3A7rcUloZNgOkKy8XNtxOZfsopAWN7btVrFYr7baZ8cT/8qmCsaxpLTlpvDmoMftI
         8LJ8AXXAaaC06/0YY12VIHWccVa8fBsZVxeQZelh/zK+l8isE+iDn3pRRmpSJCh3iSaL
         Cdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315920; x=1707920720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlp4P8f0l0aVyHwDmrWrWXYRsktkcKQu/QRPLRlhkB4=;
        b=D2e1fiuSn+ZJ7dWHaAcqhc7IpF+eTpx7dTwwkTvOx5WcKhCCPYl9S8U4fKmrVobpQA
         ON/YGP0bodowWutltsQO2UmHRlEyo0eIDAc6q/ahURX1vCDVjDpLMZeeOJerozLbgjaw
         fUtsryRT5zSNNQJZJ38fVDZas+vb9oClEUXV+oki0kRVRrnE6NjxGKA9GSqh34Ejqzcz
         2cyzDD+aOhUXMbk5LYEucBCzB95Y84065qnOwFurFoHu9dfAtL1NDgDQZSaPO3axtKhJ
         ZhoMVt/9WVAZL1DV1KMXJ5P9pNioR2zwbOsHihr8l7g9MYj0bgvmZsqYWZYbA6eRPdQn
         zY7A==
X-Gm-Message-State: AOJu0Yz+nDBBVywWAkmC0jexO15r557nuqwqY7OQMetEtaY7bS7ZUM7F
	01BWQXiitRr8aRTDUhM2DcL5ksLN1iFJL13nwy2/jCCOok2ZH3XklXFIL+oF
X-Google-Smtp-Source: AGHT+IFjL9FG4l3r1NdhUneog6H7uo5NvLvubkwXmy3smvU/XZaYJeNJFPj+P6HR5R4uv8ZhZ9CUcA==
X-Received: by 2002:a17:906:18b2:b0:a38:567a:6576 with SMTP id c18-20020a17090618b200b00a38567a6576mr2233324ejf.44.1707315919860;
        Wed, 07 Feb 2024 06:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1NcOm2Np/SmQwOObgrdiNNIeJBultywU+gUAoqXNTQsrAWI6R2T2eruCEvmHPT0g9CC3/r42/Id+deDUJGBa1u/dSQDX/JTf4vtX1UlKFhlapJujV1ywYyJvvYnRsQgkOFNBN+muyi7NS0pFdB95t1jY6EayO7iZq0XJpOHEm7/lfmMVSfvw7Ijph34emn1s=
Received: from 127.com ([2620:10d:c092:600::1:283])
        by smtp.gmail.com with ESMTPSA id vg8-20020a170907d30800b00a3807aa93e1sm808913ejc.222.2024.02.07.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:25:19 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC 1/2] udp: introduce udp specific skb destructor
Date: Wed,  7 Feb 2024 14:23:41 +0000
Message-ID: <f159776210ceca3d89ae6de629ba4d4c7d51c882.1707138546.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707138546.git.asml.silence@gmail.com>
References: <cover.1707138546.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a UDP specific skb destructor, udp_wfree(). We'll need it in
the next patch, which wires SOCK_NOSPACE support for udp sockets. We
can't reuse sock_wfree() there as is because SOCK_NOSPACE also requires
support from the poll callback.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/veth.c | 10 +++++++---
 include/net/sock.h |  1 +
 include/net/udp.h  |  1 +
 net/core/sock.c    | 10 +++++++---
 net/ipv4/udp.c     | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/udp.c     |  5 ++++-
 6 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 578e36ea1589..84ed58b957e5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -19,6 +19,7 @@
 #include <net/dst.h>
 #include <net/xfrm.h>
 #include <net/xdp.h>
+#include <net/udp.h>
 #include <linux/veth.h>
 #include <linux/module.h>
 #include <linux/bpf.h>
@@ -335,9 +336,12 @@ static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
 					 const struct net_device *rcv,
 					 const struct sk_buff *skb)
 {
-	return !(dev->features & NETIF_F_ALL_TSO) ||
-		(skb->destructor == sock_wfree &&
-		 rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
+	if (skb->destructor == sock_wfree ||
+	    (IS_ENABLED(CONFIG_INET) && skb->destructor == udp_wfree))
+		return rcv->features & (NETIF_F_GRO_FRAGLIST |
+					NETIF_F_GRO_UDP_FWD);
+
+	return !(dev->features & NETIF_F_ALL_TSO);
 }
 
 static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
diff --git a/include/net/sock.h b/include/net/sock.h
index a7f815c7cfdf..bd58901ff87a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1811,6 +1811,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern);
 void sk_free(struct sock *sk);
+void __sk_free(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
 void sk_free_unlock_clone(struct sock *sk);
diff --git a/include/net/udp.h b/include/net/udp.h
index 488a6d2babcc..bdb3dabf789d 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -288,6 +288,7 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int __udp_disconnect(struct sock *sk, int flags);
 int udp_disconnect(struct sock *sk, int flags);
 __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait);
+void udp_wfree(struct sk_buff *skb);
 struct sk_buff *skb_udp_tunnel_segment(struct sk_buff *skb,
 				       netdev_features_t features,
 				       bool is_ipv6);
diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a..6172686635a8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -140,6 +140,7 @@
 #include <trace/events/sock.h>
 
 #include <net/tcp.h>
+#include <net/udp.h>
 #include <net/busy_poll.h>
 #include <net/phonet/phonet.h>
 
@@ -2221,7 +2222,7 @@ void sk_destruct(struct sock *sk)
 		__sk_destruct(&sk->sk_rcu);
 }
 
-static void __sk_free(struct sock *sk)
+void __sk_free(struct sock *sk)
 {
 	if (likely(sk->sk_net_refcnt))
 		sock_inuse_add(sock_net(sk), -1);
@@ -2231,6 +2232,7 @@ static void __sk_free(struct sock *sk)
 	else
 		sk_destruct(sk);
 }
+EXPORT_SYMBOL(__sk_free);
 
 void sk_free(struct sock *sk)
 {
@@ -2531,8 +2533,10 @@ static bool can_skb_orphan_partial(const struct sk_buff *skb)
 	if (skb->decrypted)
 		return false;
 #endif
-	return (skb->destructor == sock_wfree ||
-		(IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree));
+	if (skb->destructor == sock_wfree)
+		return true;
+	return IS_ENABLED(CONFIG_INET) &&
+		(skb->destructor == tcp_wfree || skb->destructor == udp_wfree);
 }
 
 /* This helper is used by netem, as it can hold packets in its
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 148ffb007969..90ff77ab78f9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -796,6 +796,42 @@ int udp_err(struct sk_buff *skb, u32 info)
 	return __udp4_lib_err(skb, info, dev_net(skb->dev)->ipv4.udp_table);
 }
 
+static inline bool __udp_wfree(struct sk_buff *skb)
+{
+	struct socket_wq *wq;
+	struct sock *sk = skb->sk;
+	bool free;
+
+	free = refcount_sub_and_test(skb->truesize, &sk->sk_wmem_alloc);
+	/* a full barrier is required before waitqueue_active() */
+	smp_mb__after_atomic();
+
+	if (!sock_writeable(sk))
+		goto out;
+
+	wq = rcu_dereference(sk->sk_wq);
+	if (wq && waitqueue_active(&wq->wait))
+		wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
+	/* Should agree with poll, otherwise some programs break */
+	sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+out:
+	return free;
+}
+
+void udp_wfree(struct sk_buff *skb)
+{
+	bool free;
+
+	rcu_read_lock();
+	free = __udp_wfree(skb);
+	rcu_read_unlock();
+
+	if (unlikely(free))
+		__sk_free(skb->sk);
+}
+EXPORT_SYMBOL_GPL(udp_wfree);
+
 /*
  * Throw away all pending data and cancel the corking. Socket is locked.
  */
@@ -989,6 +1025,7 @@ int udp_push_pending_frames(struct sock *sk)
 	if (!skb)
 		goto out;
 
+	skb->destructor = udp_wfree;
 	err = udp_send_skb(skb, fl4, &inet->cork.base);
 
 out:
@@ -1246,8 +1283,10 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 				  sizeof(struct udphdr), &ipc, &rt,
 				  &cork, msg->msg_flags);
 		err = PTR_ERR(skb);
-		if (!IS_ERR_OR_NULL(skb))
+		if (!IS_ERR_OR_NULL(skb)) {
+			skb->destructor = udp_wfree;
 			err = udp_send_skb(skb, fl4, &cork);
+		}
 		goto out;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3f2249b4cd5f..d0c74a8f0914 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1309,6 +1309,7 @@ static int udp_v6_push_pending_frames(struct sock *sk)
 	if (!skb)
 		goto out;
 
+	skb->destructor = udp_wfree;
 	err = udp_v6_send_skb(skb, &inet_sk(sk)->cork.fl.u.ip6,
 			      &inet_sk(sk)->cork.base);
 out:
@@ -1576,8 +1577,10 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 				   (struct rt6_info *)dst,
 				   msg->msg_flags, &cork);
 		err = PTR_ERR(skb);
-		if (!IS_ERR_OR_NULL(skb))
+		if (!IS_ERR_OR_NULL(skb)) {
+			skb->destructor = udp_wfree;
 			err = udp_v6_send_skb(skb, fl6, &cork.base);
+		}
 		/* ip6_make_skb steals dst reference */
 		goto out_no_dst;
 	}
-- 
2.43.0


