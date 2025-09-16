Return-Path: <netdev+bounces-223654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC689B59D37
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E643BB8BD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0489B31FED6;
	Tue, 16 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caEPwM6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FA31FEDC
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039012; cv=none; b=cxqmVYJkdonO89Kp7iMe9qI1bxTsKQYpPNbOk0/ZE+oZDphaXFKupEmiVdj6m4MFMJxgY9cRUqV1XVfO3ga8JZz8MSOzoasbvXjU/WMSWC3Z26hqIGE/4hgYxlnzRU7gOuEd8LJpobHZx7wvtZ79cbZGh0Z0Yn/zHgcBafIDYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039012; c=relaxed/simple;
	bh=FWFvUYSn3y7PBiV5fwCDTdyiaDCrpArNF4vinvWdH7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kyaYFm9ymoFNUYeGgxLlG64AOkbHaiA/cnEa+4SUDXkrzVozcf1HisdlQcurNXK3SkrcQ5oS5gNC0yijuLaA59cLrkd3V+QCcgOjyvNj7G04PkBc+glx06aRop1WFq+8fuXu7FxZlCRbKb9Lgjl8+ufFOBua9PXNDXtXKTk6ShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caEPwM6f; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b78fb758e9so356231cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039010; x=1758643810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRcJvKf5KbDdNoEqUl0sHmcotIGvW7XEXU0xFoxyrgk=;
        b=caEPwM6f+io+EBAuU8NYjzt27lF2hMOtZ/2WxKeQbFmgFKkUKQE5sjuxXs2RWojZ4e
         OqGQWdeBCc5Kfw0qNjXPvPbDP81UyoarMo0J4q5g6FaAJLomFogiPr8ySvoc7u+Tg/K0
         rA2nq9niOP4307GzVLBRro/Oi6lkGJ+Ak12CqS9Z6kOJbkl52XV6/uqcAjOsNU3YGjB8
         Qfg3YLFCECcWA+VXqVhdAfBZdb5Fck0Rfbh3pZUwwctitnQtVne18AzQ/kXwBDXvCtjD
         uubO1R+s6Ak39q8g/0H9IfSmBGPcakvFjiFKJ3Wb4cghAIdRbnWLKTxhYOvXWQ1vzT6Z
         LVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039010; x=1758643810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRcJvKf5KbDdNoEqUl0sHmcotIGvW7XEXU0xFoxyrgk=;
        b=r9sR1Fw03uRdrc9gAs5y6LwL4qsifjhbOBHRFQIRDxyMd8BA+0NPI2ICjGI5Ii+FNz
         eRe1qjdaRYnwKIV9TijAB+zfxVh7xcFUJZQhtGGPynZywygNfI75LDPlHV2wb196MqbI
         4SnySNLfAU9hgxjVlscUrL47vogQhflL985ZGSWHDlKuWf15tbJp4Zd8Pcant/4j0C8/
         rXvlcIt0cDE+v/SAInabn7vl+v0p6xvNo2qBtoeKvxYJb49ZGO4StC90Bx/qsZ83shMz
         J7vDAG5HaSU1s/+5zJeiDOrbdE5JH0+Jnu1RbLe4UlJH0MQHautkIrQhUcUHdPfs0IYa
         bYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRlHTRc5i++7O5A4oOSvkhUt1pVzdoYxiCNVJdltMg1eQm3pgBsyOtlqz48vxac4hrvXppjLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFiuqBgSxAd7TaW3WtEUGqs4estpFgfU/vdeRoumRpw0XYGH+
	e9wblv7Rv4zGWrVBKzFGYAUh4vAHAQ5U7GXz4BCMKjfGE8ju0ZOb29DrpjZ5+jsd0zEcpPZNMid
	1iwpvglxfBjW9rQ==
X-Google-Smtp-Source: AGHT+IE/TSunP819iRMcTQuv/jpJc4DUguEH5j598KCeu4B7OLWpwp1bmlcyJkxo+U2We9SmSjENHTo/WPIb9g==
X-Received: from qtqg19.prod.google.com ([2002:ac8:4813:0:b0:4b3:4718:504c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5b0d:b0:4b3:4d20:301 with SMTP id d75a77b69052e-4b7b449cdabmr34555061cf.18.1758039010013;
 Tue, 16 Sep 2025 09:10:10 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:49 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-9-edumazet@google.com>
Subject: [PATCH net-next 08/10] udp: add udp_drops_inc() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Generic sk_drops_inc() reads sk->sk_drop_counters.
We know the precise location for UDP sockets.

Move sk_drop_counters out of sock_read_rxtx
so that sock_write_rxtx starts at a cache line boundary.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h |  2 +-
 include/net/udp.h  |  5 +++++
 net/core/sock.c    |  1 -
 net/ipv4/udp.c     | 12 ++++++------
 net/ipv6/udp.c     |  6 +++---
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 867dc44140d4c1b56ecfab1220c81133fe0394a0..82bcdb7d7e6779de41ace0dde3a8b54e6adb0c14 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -451,7 +451,6 @@ struct sock {
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
-	struct numa_drop_counters *sk_drop_counters;
 	__cacheline_group_end(sock_read_rxtx);
 
 	__cacheline_group_begin(sock_write_rxtx);
@@ -568,6 +567,7 @@ struct sock {
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
+	struct numa_drop_counters *sk_drop_counters;
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
diff --git a/include/net/udp.h b/include/net/udp.h
index 93b159f30e884ce7d30e2d2240b846441c5e135b..a08822e294b038c0d00d4a5f5cac62286a207926 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -295,6 +295,11 @@ static inline void udp_lib_init_sock(struct sock *sk)
 	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
 }
 
+static inline void udp_drops_inc(struct sock *sk)
+{
+	numa_drop_add(&udp_sk(sk)->drop_counters, 1);
+}
+
 /* hash routines shared between UDPv4/6 and UDP-Litev4/6 */
 static inline int udp_lib_hash(struct sock *sk)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 1f8ef4d8bcd9e8084eda82cad44c010071ceb171..21742da19e45bbe53e84b8a87d5a23bc2d2275f8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4444,7 +4444,6 @@ static int __init sock_struct_check(void)
 #ifdef CONFIG_MEMCG
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
 #endif
-	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_drop_counters);
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 658ae87827991a78c25c2172d52e772c94ea217f..25143f932447df2a84dd113ca33e1ccf15b3503c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1790,7 +1790,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 
 drop:
-	sk_drops_inc(sk);
+	udp_drops_inc(sk);
 	busylock_release(busy);
 	return err;
 }
@@ -1855,7 +1855,7 @@ static struct sk_buff *__first_packet_length(struct sock *sk,
 					IS_UDPLITE(sk));
 			__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
 					IS_UDPLITE(sk));
-			sk_drops_inc(sk);
+			udp_drops_inc(sk);
 			__skb_unlink(skb, rcvq);
 			*total += skb->truesize;
 			kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
@@ -2011,7 +2011,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 		__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
 		__UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
-		sk_drops_inc(sk);
+		udp_drops_inc(sk);
 		kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
 		goto try_again;
 	}
@@ -2081,7 +2081,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 
 	if (unlikely(err)) {
 		if (!peeking) {
-			sk_drops_inc(sk);
+			udp_drops_inc(sk);
 			UDP_INC_STATS(sock_net(sk),
 				      UDP_MIB_INERRORS, is_udplite);
 		}
@@ -2452,7 +2452,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
 drop:
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
-	sk_drops_inc(sk);
+	udp_drops_inc(sk);
 	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
@@ -2537,7 +2537,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		nskb = skb_clone(skb, GFP_ATOMIC);
 
 		if (unlikely(!nskb)) {
-			sk_drops_inc(sk);
+			udp_drops_inc(sk);
 			__UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS,
 					IS_UDPLITE(sk));
 			__UDP_INC_STATS(net, UDP_MIB_INERRORS,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e87d0ef861f88af3ff7bf9dd5045c4d4601036e3..9f4d340d1e3a63d38f80138ef9f6aac4a33afa05 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -524,7 +524,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	}
 	if (unlikely(err)) {
 		if (!peeking) {
-			sk_drops_inc(sk);
+			udp_drops_inc(sk);
 			SNMP_INC_STATS(mib, UDP_MIB_INERRORS);
 		}
 		kfree_skb(skb);
@@ -908,7 +908,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplite);
 drop:
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
-	sk_drops_inc(sk);
+	udp_drops_inc(sk);
 	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
@@ -1013,7 +1013,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		}
 		nskb = skb_clone(skb, GFP_ATOMIC);
 		if (unlikely(!nskb)) {
-			sk_drops_inc(sk);
+			udp_drops_inc(sk);
 			__UDP6_INC_STATS(net, UDP_MIB_RCVBUFERRORS,
 					 IS_UDPLITE(sk));
 			__UDP6_INC_STATS(net, UDP_MIB_INERRORS,
-- 
2.51.0.384.g4c02a37b29-goog


