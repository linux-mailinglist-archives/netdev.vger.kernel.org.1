Return-Path: <netdev+bounces-215498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C1B2EE05
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305D55E37B3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276425A325;
	Thu, 21 Aug 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDPrHWQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17062D4B4E
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756969; cv=none; b=Xck8xX6przQTi0MR1F7qWWMEHJ5vlU8u9zGeZb207s7EAwtx4y3eINoozz23lvg10kepa+0ZAgO02Tl06U9pOJswseayK7zyqpSwis4HI1SwkHaxgnXNd2XH+HmSyv4fcL7fQNx92u+eZK8HIGvZcMi9j/PjfGUHswcQ7TKx8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756969; c=relaxed/simple;
	bh=1ZWWHOXpX8L0RzZEi4aL9MNmnOgmcVmON62QzA1r46s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=el1IqSG6U4n1caLrle1nmHAw+dI4SoJc/piYbHaAmZRUu058/V+LPovArRhZ9M94LiLNKfCjDPwR6ktzyVYnrDlNzW15i9WGBuF4IDdC9yvVWqhqopDypSBCLsiIzjKguySqI4N9a1IGhlfSdp9fIoOc0oFSPm9I0I9h3H070CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDPrHWQR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eac3650so2073377b3a.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756967; x=1756361767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDZUt2QnIKhMwP0l+IzGuOwmoIlKe9qD5hK4dLFlxZc=;
        b=oDPrHWQRjhjYXv/gxfCCiBGKEyWQ9Qs1VR5DLsXTvP1pWUu1Ko5+fLQQ5hWdZaNP9r
         /HtLeVCMp34x/jME0ufSWgVD806QaB24nUaGp50zskuj/YryDCtW56k+B0iKCI99PSzc
         9cvm2v8uGhyb+14DApEpMN++a9c4jTx90NQPBBTon3lTO2OCUTa6JdDbxa85kfJJy3rB
         Ya0XgPvW+6VNtJ2dxUynH3KNp3m+Lx3ItB01gy5dehR7qBItkjQdrFDu49szycRQY+gv
         eLsROyQQgTuchiAEbTDkmXBx9CTy2QeQFSyxG865p7zhKF1kmjTRz3qafkEENv3DQJkt
         gWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756967; x=1756361767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDZUt2QnIKhMwP0l+IzGuOwmoIlKe9qD5hK4dLFlxZc=;
        b=L/BKJ7f2BoD1/1Wf8dwvh2TywltnMaY6zUS4g0doul/U9tdexlRqD9KRsVnroa39lD
         /DZepRplAFc3tsvWB0rJ8vLMTuGY8aghWBUwNFICl84ch7kdcs75fsxAnzI6DuKOist8
         VGjrO0xZNzINaFGOFeBicYbVZEm1SbCDxHmb8WIys+hyFwDQPl2hW5XUVsRSz6zZI9GT
         x3rogSCGQBg8CqxhzuLvShN3GgRa4HEDK1i9Lm8H6zdbW2EAkQ/1rxgLiBlKe0Yam6JP
         vin8WcsZmoIjD8JftzrDStOzX41bt+4GievBQtROyUCQOXC4xg0Uxngt6gMhyj47h4eb
         fNcA==
X-Forwarded-Encrypted: i=1; AJvYcCWpDWd62CHEOw7lAHcoknIz/MhrJvQUH0sp0KRtp+mt5xno4Ym78qn9Zu/iGyqC876Z1jClhQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQ5KeIw/nDnZRLRhVoVhfrp1X2Jsxe+2zicEc4AdRVJgtZOxZ
	XZKmv6WlNPq15rQIDfw1yZU59qQljX0dPSy7WArkRmqNDFVn8wuKokNxioT6phWn/L0rVJCw7bF
	lIb+AbQ==
X-Google-Smtp-Source: AGHT+IHu9GQp/5P8aRgFzLoX5quNuorJjR/VOYGoSFOeb93+Gfa49fyNTLh29+MuccY/Dwxm7d7lJO6Z38Q=
X-Received: from pgbfe11.prod.google.com ([2002:a05:6a02:288b:b0:b47:3ab8:86d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a27:b0:243:15b9:765c
 with SMTP id adf61e73a8af0-24330b643a0mr1891094637.54.1755756967048; Wed, 20
 Aug 2025 23:16:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:16 +0000
In-Reply-To: <20250821061540.2876953-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/7] tcp: Don't pass hashinfo to socket lookup helpers.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These socket lookup functions required struct inet_hashinfo because
they are shared by TCP and DCCP.

  * __inet_lookup_established()
  * __inet_lookup_listener()
  * __inet6_lookup_established()
  * inet6_lookup_listener()

DCCP has gone, and we don't need to pass hashinfo down to them.

Let's fetch net->ipv4.tcp_death_row.hashinfo directly in the above
4 functions.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  9 ++--
 .../net/ethernet/netronome/nfp/crypto/tls.c   |  9 ++--
 include/net/inet6_hashtables.h                | 18 +++-----
 include/net/inet_hashtables.h                 | 37 +++++++--------
 net/core/filter.c                             |  5 +--
 net/ipv4/esp4.c                               |  4 +-
 net/ipv4/inet_diag.c                          |  6 +--
 net/ipv4/inet_hashtables.c                    | 28 ++++++------
 net/ipv4/netfilter/nf_socket_ipv4.c           |  3 +-
 net/ipv4/netfilter/nf_tproxy_ipv4.c           |  5 +--
 net/ipv4/tcp_ipv4.c                           | 16 +++----
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv6/esp6.c                               |  4 +-
 net/ipv6/inet6_hashtables.c                   | 45 ++++++++++---------
 net/ipv6/netfilter/nf_socket_ipv6.c           |  3 +-
 net/ipv6/netfilter/nf_tproxy_ipv6.c           |  5 +--
 net/ipv6/tcp_ipv6.c                           | 14 +++---
 net/ipv6/tcpv6_offload.c                      |  3 +-
 18 files changed, 94 insertions(+), 123 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..d7a11ff9bbdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -498,9 +498,9 @@ static void resync_update_sn(struct mlx5e_rq *rq, struct sk_buff *skb)
 		depth += sizeof(struct iphdr);
 		th = (void *)iph + sizeof(struct iphdr);
 
-		sk = inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-					     iph->saddr, th->source, iph->daddr,
-					     th->dest, netdev->ifindex);
+		sk = inet_lookup_established(net, iph->saddr, th->source,
+					     iph->daddr, th->dest,
+					     netdev->ifindex);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct ipv6hdr *ipv6h = (struct ipv6hdr *)iph;
@@ -508,8 +508,7 @@ static void resync_update_sn(struct mlx5e_rq *rq, struct sk_buff *skb)
 		depth += sizeof(struct ipv6hdr);
 		th = (void *)ipv6h + sizeof(struct ipv6hdr);
 
-		sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-						&ipv6h->saddr, th->source,
+		sk = __inet6_lookup_established(net, &ipv6h->saddr, th->source,
 						&ipv6h->daddr, ntohs(th->dest),
 						netdev->ifindex, 0);
 #endif
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index f80f1a6953fa..f252ecdcd2cd 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -495,14 +495,13 @@ int nfp_net_tls_rx_resync_req(struct net_device *netdev,
 
 	switch (ipv6h->version) {
 	case 4:
-		sk = inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-					     iph->saddr, th->source, iph->daddr,
-					     th->dest, netdev->ifindex);
+		sk = inet_lookup_established(net, iph->saddr, th->source,
+					     iph->daddr, th->dest,
+					     netdev->ifindex);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case 6:
-		sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-						&ipv6h->saddr, th->source,
+		sk = __inet6_lookup_established(net, &ipv6h->saddr, th->source,
 						&ipv6h->daddr, ntohs(th->dest),
 						netdev->ifindex, 0);
 		break;
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index ab3929a2a956..1f985d2012ce 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -41,7 +41,6 @@ static inline unsigned int __inet6_ehashfn(const u32 lhash,
  * The sockhash lock must be held as a reader here.
  */
 struct sock *__inet6_lookup_established(const struct net *net,
-					struct inet_hashinfo *hashinfo,
 					const struct in6_addr *saddr,
 					const __be16 sport,
 					const struct in6_addr *daddr,
@@ -65,7 +64,6 @@ struct sock *inet6_lookup_reuseport(const struct net *net, struct sock *sk,
 				    inet6_ehashfn_t *ehashfn);
 
 struct sock *inet6_lookup_listener(const struct net *net,
-				   struct inet_hashinfo *hashinfo,
 				   struct sk_buff *skb, int doff,
 				   const struct in6_addr *saddr,
 				   const __be16 sport,
@@ -83,7 +81,6 @@ struct sock *inet6_lookup_run_sk_lookup(const struct net *net,
 					inet6_ehashfn_t *ehashfn);
 
 static inline struct sock *__inet6_lookup(const struct net *net,
-					  struct inet_hashinfo *hashinfo,
 					  struct sk_buff *skb, int doff,
 					  const struct in6_addr *saddr,
 					  const __be16 sport,
@@ -92,14 +89,14 @@ static inline struct sock *__inet6_lookup(const struct net *net,
 					  const int dif, const int sdif,
 					  bool *refcounted)
 {
-	struct sock *sk = __inet6_lookup_established(net, hashinfo, saddr,
-						     sport, daddr, hnum,
+	struct sock *sk = __inet6_lookup_established(net, saddr, sport,
+						     daddr, hnum,
 						     dif, sdif);
 	*refcounted = true;
 	if (sk)
 		return sk;
 	*refcounted = false;
-	return inet6_lookup_listener(net, hashinfo, skb, doff, saddr, sport,
+	return inet6_lookup_listener(net, skb, doff, saddr, sport,
 				     daddr, hnum, dif, sdif);
 }
 
@@ -143,8 +140,7 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	return reuse_sk;
 }
 
-static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
-					      struct sk_buff *skb, int doff,
+static inline struct sock *__inet6_lookup_skb(struct sk_buff *skb, int doff,
 					      const __be16 sport,
 					      const __be16 dport,
 					      int iif, int sdif,
@@ -161,14 +157,12 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 	if (sk)
 		return sk;
 
-	return __inet6_lookup(net, hashinfo, skb,
-			      doff, &ip6h->saddr, sport,
+	return __inet6_lookup(net, skb, doff, &ip6h->saddr, sport,
 			      &ip6h->daddr, ntohs(dport),
 			      iif, sdif, refcounted);
 }
 
-struct sock *inet6_lookup(const struct net *net, struct inet_hashinfo *hashinfo,
-			  struct sk_buff *skb, int doff,
+struct sock *inet6_lookup(const struct net *net, struct sk_buff *skb, int doff,
 			  const struct in6_addr *saddr, const __be16 sport,
 			  const struct in6_addr *daddr, const __be16 dport,
 			  const int dif);
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 19dbd9081d5a..a3b32241c2f2 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -294,7 +294,6 @@ int inet_hash(struct sock *sk);
 void inet_unhash(struct sock *sk);
 
 struct sock *__inet_lookup_listener(const struct net *net,
-				    struct inet_hashinfo *hashinfo,
 				    struct sk_buff *skb, int doff,
 				    const __be32 saddr, const __be16 sport,
 				    const __be32 daddr,
@@ -302,12 +301,12 @@ struct sock *__inet_lookup_listener(const struct net *net,
 				    const int dif, const int sdif);
 
 static inline struct sock *inet_lookup_listener(struct net *net,
-		struct inet_hashinfo *hashinfo,
-		struct sk_buff *skb, int doff,
-		__be32 saddr, __be16 sport,
-		__be32 daddr, __be16 dport, int dif, int sdif)
+						struct sk_buff *skb, int doff,
+						__be32 saddr, __be16 sport,
+						__be32 daddr, __be16 dport,
+						int dif, int sdif)
 {
-	return __inet_lookup_listener(net, hashinfo, skb, doff, saddr, sport,
+	return __inet_lookup_listener(net, skb, doff, saddr, sport,
 				      daddr, ntohs(dport), dif, sdif);
 }
 
@@ -358,7 +357,6 @@ static inline bool inet_match(const struct net *net, const struct sock *sk,
  * not check it for lookups anymore, thanks Alexey. -DaveM
  */
 struct sock *__inet_lookup_established(const struct net *net,
-				       struct inet_hashinfo *hashinfo,
 				       const __be32 saddr, const __be16 sport,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
@@ -384,18 +382,16 @@ struct sock *inet_lookup_run_sk_lookup(const struct net *net,
 				       __be32 daddr, u16 hnum, const int dif,
 				       inet_ehashfn_t *ehashfn);
 
-static inline struct sock *
-	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
-				const __be32 saddr, const __be16 sport,
-				const __be32 daddr, const __be16 dport,
-				const int dif)
+static inline struct sock *inet_lookup_established(struct net *net,
+						   const __be32 saddr, const __be16 sport,
+						   const __be32 daddr, const __be16 dport,
+						   const int dif)
 {
-	return __inet_lookup_established(net, hashinfo, saddr, sport, daddr,
+	return __inet_lookup_established(net, saddr, sport, daddr,
 					 ntohs(dport), dif, 0);
 }
 
 static inline struct sock *__inet_lookup(struct net *net,
-					 struct inet_hashinfo *hashinfo,
 					 struct sk_buff *skb, int doff,
 					 const __be32 saddr, const __be16 sport,
 					 const __be32 daddr, const __be16 dport,
@@ -405,18 +401,17 @@ static inline struct sock *__inet_lookup(struct net *net,
 	u16 hnum = ntohs(dport);
 	struct sock *sk;
 
-	sk = __inet_lookup_established(net, hashinfo, saddr, sport,
+	sk = __inet_lookup_established(net, saddr, sport,
 				       daddr, hnum, dif, sdif);
 	*refcounted = true;
 	if (sk)
 		return sk;
 	*refcounted = false;
-	return __inet_lookup_listener(net, hashinfo, skb, doff, saddr,
+	return __inet_lookup_listener(net, skb, doff, saddr,
 				      sport, daddr, hnum, dif, sdif);
 }
 
 static inline struct sock *inet_lookup(struct net *net,
-				       struct inet_hashinfo *hashinfo,
 				       struct sk_buff *skb, int doff,
 				       const __be32 saddr, const __be16 sport,
 				       const __be32 daddr, const __be16 dport,
@@ -425,7 +420,7 @@ static inline struct sock *inet_lookup(struct net *net,
 	struct sock *sk;
 	bool refcounted;
 
-	sk = __inet_lookup(net, hashinfo, skb, doff, saddr, sport, daddr,
+	sk = __inet_lookup(net, skb, doff, saddr, sport, daddr,
 			   dport, dif, 0, &refcounted);
 
 	if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
@@ -473,8 +468,7 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	return reuse_sk;
 }
 
-static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
-					     struct sk_buff *skb,
+static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
 					     int doff,
 					     const __be16 sport,
 					     const __be16 dport,
@@ -492,8 +486,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 	if (sk)
 		return sk;
 
-	return __inet_lookup(net, hashinfo, skb,
-			     doff, iph->saddr, sport,
+	return __inet_lookup(net, skb, doff, iph->saddr, sport,
 			     iph->daddr, dport, inet_iif(skb), sdif,
 			     refcounted);
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index da391e2b0788..93dc968fcf9d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6767,7 +6767,6 @@ static const struct bpf_func_proto bpf_lwt_seg6_adjust_srh_proto = {
 static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 			      int dif, int sdif, u8 family, u8 proto)
 {
-	struct inet_hashinfo *hinfo = net->ipv4.tcp_death_row.hashinfo;
 	bool refcounted = false;
 	struct sock *sk = NULL;
 
@@ -6776,7 +6775,7 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		__be32 dst4 = tuple->ipv4.daddr;
 
 		if (proto == IPPROTO_TCP)
-			sk = __inet_lookup(net, hinfo, NULL, 0,
+			sk = __inet_lookup(net, NULL, 0,
 					   src4, tuple->ipv4.sport,
 					   dst4, tuple->ipv4.dport,
 					   dif, sdif, &refcounted);
@@ -6790,7 +6789,7 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		struct in6_addr *dst6 = (struct in6_addr *)&tuple->ipv6.daddr;
 
 		if (proto == IPPROTO_TCP)
-			sk = __inet6_lookup(net, hinfo, NULL, 0,
+			sk = __inet6_lookup(net, NULL, 0,
 					    src6, tuple->ipv6.sport,
 					    dst6, ntohs(tuple->ipv6.dport),
 					    dif, sdif, &refcounted);
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index f14a41ee4aa1..2c922afadb8f 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -132,8 +132,8 @@ static struct sock *esp_find_tcp_sk(struct xfrm_state *x)
 	dport = encap->encap_dport;
 	spin_unlock_bh(&x->lock);
 
-	sk = inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo, x->id.daddr.a4,
-				     dport, x->props.saddr.a4, sport, 0);
+	sk = inet_lookup_established(net, x->id.daddr.a4, dport,
+				     x->props.saddr.a4, sport, 0);
 	if (!sk)
 		return ERR_PTR(-ENOENT);
 
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 2fa53b16fe77..9d909734cf8a 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -526,18 +526,18 @@ struct sock *inet_diag_find_one_icsk(struct net *net,
 
 	rcu_read_lock();
 	if (req->sdiag_family == AF_INET)
-		sk = inet_lookup(net, hashinfo, NULL, 0, req->id.idiag_dst[0],
+		sk = inet_lookup(net, NULL, 0, req->id.idiag_dst[0],
 				 req->id.idiag_dport, req->id.idiag_src[0],
 				 req->id.idiag_sport, req->id.idiag_if);
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (req->sdiag_family == AF_INET6) {
 		if (ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_dst) &&
 		    ipv6_addr_v4mapped((struct in6_addr *)req->id.idiag_src))
-			sk = inet_lookup(net, hashinfo, NULL, 0, req->id.idiag_dst[3],
+			sk = inet_lookup(net, NULL, 0, req->id.idiag_dst[3],
 					 req->id.idiag_dport, req->id.idiag_src[3],
 					 req->id.idiag_sport, req->id.idiag_if);
 		else
-			sk = inet6_lookup(net, hashinfo, NULL, 0,
+			sk = inet6_lookup(net, NULL, 0,
 					  (struct in6_addr *)req->id.idiag_dst,
 					  req->id.idiag_dport,
 					  (struct in6_addr *)req->id.idiag_src,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 374adb8a2640..4bc2b1921d2b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -425,13 +425,13 @@ struct sock *inet_lookup_run_sk_lookup(const struct net *net,
 }
 
 struct sock *__inet_lookup_listener(const struct net *net,
-				    struct inet_hashinfo *hashinfo,
 				    struct sk_buff *skb, int doff,
 				    const __be32 saddr, __be16 sport,
 				    const __be32 daddr, const unsigned short hnum,
 				    const int dif, const int sdif)
 {
 	struct inet_listen_hashbucket *ilb2;
+	struct inet_hashinfo *hashinfo;
 	struct sock *result = NULL;
 	unsigned int hash2;
 
@@ -444,6 +444,7 @@ struct sock *__inet_lookup_listener(const struct net *net,
 			goto done;
 	}
 
+	hashinfo = net->ipv4.tcp_death_row.hashinfo;
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
@@ -489,21 +490,22 @@ void sock_edemux(struct sk_buff *skb)
 EXPORT_SYMBOL(sock_edemux);
 
 struct sock *__inet_lookup_established(const struct net *net,
-				  struct inet_hashinfo *hashinfo,
-				  const __be32 saddr, const __be16 sport,
-				  const __be32 daddr, const u16 hnum,
-				  const int dif, const int sdif)
+				       const __be32 saddr, const __be16 sport,
+				       const __be32 daddr, const u16 hnum,
+				       const int dif, const int sdif)
 {
-	INET_ADDR_COOKIE(acookie, saddr, daddr);
 	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
-	struct sock *sk;
+	INET_ADDR_COOKIE(acookie, saddr, daddr);
 	const struct hlist_nulls_node *node;
-	/* Optimize here for direct hit, only listening connections can
-	 * have wildcards anyways.
-	 */
-	unsigned int hash = inet_ehashfn(net, daddr, hnum, saddr, sport);
-	unsigned int slot = hash & hashinfo->ehash_mask;
-	struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	struct inet_ehash_bucket *head;
+	struct inet_hashinfo *hashinfo;
+	unsigned int hash, slot;
+	struct sock *sk;
+
+	hashinfo = net->ipv4.tcp_death_row.hashinfo;
+	hash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+	slot = hash & hashinfo->ehash_mask;
+	head = &hashinfo->ehash[slot];
 
 begin:
 	sk_nulls_for_each_rcu(sk, node, &head->chain) {
diff --git a/net/ipv4/netfilter/nf_socket_ipv4.c b/net/ipv4/netfilter/nf_socket_ipv4.c
index a1350fc25838..5080fa5fbf6a 100644
--- a/net/ipv4/netfilter/nf_socket_ipv4.c
+++ b/net/ipv4/netfilter/nf_socket_ipv4.c
@@ -71,8 +71,7 @@ nf_socket_get_sock_v4(struct net *net, struct sk_buff *skb, const int doff,
 {
 	switch (protocol) {
 	case IPPROTO_TCP:
-		return inet_lookup(net, net->ipv4.tcp_death_row.hashinfo,
-				   skb, doff, saddr, sport, daddr, dport,
+		return inet_lookup(net, skb, doff, saddr, sport, daddr, dport,
 				   in->ifindex);
 	case IPPROTO_UDP:
 		return udp4_lib_lookup(net, saddr, sport, daddr, dport,
diff --git a/net/ipv4/netfilter/nf_tproxy_ipv4.c b/net/ipv4/netfilter/nf_tproxy_ipv4.c
index 73e66a088e25..041c3f37f237 100644
--- a/net/ipv4/netfilter/nf_tproxy_ipv4.c
+++ b/net/ipv4/netfilter/nf_tproxy_ipv4.c
@@ -81,7 +81,6 @@ nf_tproxy_get_sock_v4(struct net *net, struct sk_buff *skb,
 		      const struct net_device *in,
 		      const enum nf_tproxy_lookup_t lookup_type)
 {
-	struct inet_hashinfo *hinfo = net->ipv4.tcp_death_row.hashinfo;
 	struct sock *sk;
 
 	switch (protocol) {
@@ -95,7 +94,7 @@ nf_tproxy_get_sock_v4(struct net *net, struct sk_buff *skb,
 
 		switch (lookup_type) {
 		case NF_TPROXY_LOOKUP_LISTENER:
-			sk = inet_lookup_listener(net, hinfo, skb,
+			sk = inet_lookup_listener(net, skb,
 						  ip_hdrlen(skb) + __tcp_hdrlen(hp),
 						  saddr, sport, daddr, dport,
 						  in->ifindex, 0);
@@ -109,7 +108,7 @@ nf_tproxy_get_sock_v4(struct net *net, struct sk_buff *skb,
 			 */
 			break;
 		case NF_TPROXY_LOOKUP_ESTABLISHED:
-			sk = inet_lookup_established(net, hinfo, saddr, sport,
+			sk = inet_lookup_established(net, saddr, sport,
 						     daddr, dport, in->ifindex);
 			break;
 		default:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c7b9377e5a66..4a7d2b97c1ea 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -506,8 +506,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	struct sock *sk;
 	int err;
 
-	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-				       iph->daddr, th->dest, iph->saddr,
+	sk = __inet_lookup_established(net, iph->daddr, th->dest, iph->saddr,
 				       ntohs(th->source), inet_iif(skb), 0);
 	if (!sk) {
 		__ICMP_INC_STATS(net, ICMP_MIB_INERRORS);
@@ -823,8 +822,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 		 * Incoming packet is checked with md5 hash with finding key,
 		 * no RST generated if md5 hash doesn't match.
 		 */
-		sk1 = __inet_lookup_listener(net, net->ipv4.tcp_death_row.hashinfo,
-					     NULL, 0, ip_hdr(skb)->saddr,
+		sk1 = __inet_lookup_listener(net, NULL, 0, ip_hdr(skb)->saddr,
 					     th->source, ip_hdr(skb)->daddr,
 					     ntohs(th->source), dif, sdif);
 		/* don't send rst if it can't find key */
@@ -1992,8 +1990,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 	if (th->doff < sizeof(struct tcphdr) / 4)
 		return 0;
 
-	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-				       iph->saddr, th->source,
+	sk = __inet_lookup_established(net, iph->saddr, th->source,
 				       iph->daddr, ntohs(th->dest),
 				       skb->skb_iif, inet_sdif(skb));
 	if (sk) {
@@ -2236,8 +2233,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
 lookup:
-	sk = __inet_lookup_skb(net->ipv4.tcp_death_row.hashinfo,
-			       skb, __tcp_hdrlen(th), th->source,
+	sk = __inet_lookup_skb(skb, __tcp_hdrlen(th), th->source,
 			       th->dest, sdif, &refcounted);
 	if (!sk)
 		goto no_tcp_socket;
@@ -2426,9 +2422,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN: {
-		struct sock *sk2 = inet_lookup_listener(net,
-							net->ipv4.tcp_death_row.hashinfo,
-							skb, __tcp_hdrlen(th),
+		struct sock *sk2 = inet_lookup_listener(net, skb, __tcp_hdrlen(th),
 							iph->saddr, th->source,
 							iph->daddr, th->dest,
 							inet_iif(skb),
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index be5c2294610e..e6612bd84d09 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -434,8 +434,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	inet_get_iif_sdif(skb, &iif, &sdif);
 	iph = skb_gro_network_header(skb);
 	net = dev_net_rcu(skb->dev);
-	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-				       iph->saddr, th->source,
+	sk = __inet_lookup_established(net, iph->saddr, th->source,
 				       iph->daddr, ntohs(th->dest),
 				       iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 72adfc107b55..e75da98f5283 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -149,8 +149,8 @@ static struct sock *esp6_find_tcp_sk(struct xfrm_state *x)
 	dport = encap->encap_dport;
 	spin_unlock_bh(&x->lock);
 
-	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo, &x->id.daddr.in6,
-					dport, &x->props.saddr.in6, ntohs(sport), 0, 0);
+	sk = __inet6_lookup_established(net, &x->id.daddr.in6, dport,
+					&x->props.saddr.in6, ntohs(sport), 0, 0);
 	if (!sk)
 		return ERR_PTR(-ENOENT);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index d6c3db31dcab..a3a9ea49fee2 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -47,24 +47,23 @@ EXPORT_SYMBOL_GPL(inet6_ehashfn);
  * The sockhash lock must be held as a reader here.
  */
 struct sock *__inet6_lookup_established(const struct net *net,
-					struct inet_hashinfo *hashinfo,
-					   const struct in6_addr *saddr,
-					   const __be16 sport,
-					   const struct in6_addr *daddr,
-					   const u16 hnum,
-					   const int dif, const int sdif)
+					const struct in6_addr *saddr,
+					const __be16 sport,
+					const struct in6_addr *daddr,
+					const u16 hnum,
+					const int dif, const int sdif)
 {
-	struct sock *sk;
-	const struct hlist_nulls_node *node;
 	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
-	/* Optimize here for direct hit, only listening connections can
-	 * have wildcards anyways.
-	 */
-	unsigned int hash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
-	unsigned int slot = hash & hashinfo->ehash_mask;
-	struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
-
+	const struct hlist_nulls_node *node;
+	struct inet_ehash_bucket *head;
+	struct inet_hashinfo *hashinfo;
+	unsigned int hash, slot;
+	struct sock *sk;
 
+	hashinfo = net->ipv4.tcp_death_row.hashinfo;
+	hash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+	slot = hash & hashinfo->ehash_mask;
+	head = &hashinfo->ehash[slot];
 begin:
 	sk_nulls_for_each_rcu(sk, node, &head->chain) {
 		if (sk->sk_hash != hash)
@@ -200,13 +199,15 @@ struct sock *inet6_lookup_run_sk_lookup(const struct net *net,
 EXPORT_SYMBOL_GPL(inet6_lookup_run_sk_lookup);
 
 struct sock *inet6_lookup_listener(const struct net *net,
-		struct inet_hashinfo *hashinfo,
-		struct sk_buff *skb, int doff,
-		const struct in6_addr *saddr,
-		const __be16 sport, const struct in6_addr *daddr,
-		const unsigned short hnum, const int dif, const int sdif)
+				   struct sk_buff *skb, int doff,
+				   const struct in6_addr *saddr,
+				   const __be16 sport,
+				   const struct in6_addr *daddr,
+				   const unsigned short hnum,
+				   const int dif, const int sdif)
 {
 	struct inet_listen_hashbucket *ilb2;
+	struct inet_hashinfo *hashinfo;
 	struct sock *result = NULL;
 	unsigned int hash2;
 
@@ -219,6 +220,7 @@ struct sock *inet6_lookup_listener(const struct net *net,
 			goto done;
 	}
 
+	hashinfo = net->ipv4.tcp_death_row.hashinfo;
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
@@ -243,7 +245,6 @@ struct sock *inet6_lookup_listener(const struct net *net,
 EXPORT_SYMBOL_GPL(inet6_lookup_listener);
 
 struct sock *inet6_lookup(const struct net *net,
-			  struct inet_hashinfo *hashinfo,
 			  struct sk_buff *skb, int doff,
 			  const struct in6_addr *saddr, const __be16 sport,
 			  const struct in6_addr *daddr, const __be16 dport,
@@ -252,7 +253,7 @@ struct sock *inet6_lookup(const struct net *net,
 	struct sock *sk;
 	bool refcounted;
 
-	sk = __inet6_lookup(net, hashinfo, skb, doff, saddr, sport, daddr,
+	sk = __inet6_lookup(net, skb, doff, saddr, sport, daddr,
 			    ntohs(dport), dif, 0, &refcounted);
 	if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
 		sk = NULL;
diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
index 9ea5ef56cb27..ced8bd44828e 100644
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -83,8 +83,7 @@ nf_socket_get_sock_v6(struct net *net, struct sk_buff *skb, int doff,
 {
 	switch (protocol) {
 	case IPPROTO_TCP:
-		return inet6_lookup(net, net->ipv4.tcp_death_row.hashinfo,
-				    skb, doff, saddr, sport, daddr, dport,
+		return inet6_lookup(net, skb, doff, saddr, sport, daddr, dport,
 				    in->ifindex);
 	case IPPROTO_UDP:
 		return udp6_lib_lookup(net, saddr, sport, daddr, dport,
diff --git a/net/ipv6/netfilter/nf_tproxy_ipv6.c b/net/ipv6/netfilter/nf_tproxy_ipv6.c
index 52f828bb5a83..b2f59ed9d7cc 100644
--- a/net/ipv6/netfilter/nf_tproxy_ipv6.c
+++ b/net/ipv6/netfilter/nf_tproxy_ipv6.c
@@ -80,7 +80,6 @@ nf_tproxy_get_sock_v6(struct net *net, struct sk_buff *skb, int thoff,
 		      const struct net_device *in,
 		      const enum nf_tproxy_lookup_t lookup_type)
 {
-	struct inet_hashinfo *hinfo = net->ipv4.tcp_death_row.hashinfo;
 	struct sock *sk;
 
 	switch (protocol) {
@@ -94,7 +93,7 @@ nf_tproxy_get_sock_v6(struct net *net, struct sk_buff *skb, int thoff,
 
 		switch (lookup_type) {
 		case NF_TPROXY_LOOKUP_LISTENER:
-			sk = inet6_lookup_listener(net, hinfo, skb,
+			sk = inet6_lookup_listener(net, skb,
 						   thoff + __tcp_hdrlen(hp),
 						   saddr, sport,
 						   daddr, ntohs(dport),
@@ -109,7 +108,7 @@ nf_tproxy_get_sock_v6(struct net *net, struct sk_buff *skb, int thoff,
 			 */
 			break;
 		case NF_TPROXY_LOOKUP_ESTABLISHED:
-			sk = __inet6_lookup_established(net, hinfo, saddr, sport, daddr,
+			sk = __inet6_lookup_established(net, saddr, sport, daddr,
 							ntohs(dport), in->ifindex, 0);
 			break;
 		default:
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4bc0431bf928..25d6a8e974c0 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -388,8 +388,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	bool fatal;
 	int err;
 
-	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-					&hdr->daddr, th->dest,
+	sk = __inet6_lookup_established(net, &hdr->daddr, th->dest,
 					&hdr->saddr, ntohs(th->source),
 					skb->dev->ifindex, inet6_sdif(skb));
 
@@ -1073,8 +1072,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 		 * Incoming packet is checked with md5 hash with finding key,
 		 * no RST generated if md5 hash doesn't match.
 		 */
-		sk1 = inet6_lookup_listener(net, net->ipv4.tcp_death_row.hashinfo,
-					    NULL, 0, &ipv6h->saddr, th->source,
+		sk1 = inet6_lookup_listener(net, NULL, 0, &ipv6h->saddr, th->source,
 					    &ipv6h->daddr, ntohs(th->source),
 					    dif, sdif);
 		if (!sk1)
@@ -1789,7 +1787,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	hdr = ipv6_hdr(skb);
 
 lookup:
-	sk = __inet6_lookup_skb(net->ipv4.tcp_death_row.hashinfo, skb, __tcp_hdrlen(th),
+	sk = __inet6_lookup_skb(skb, __tcp_hdrlen(th),
 				th->source, th->dest, inet6_iif(skb), sdif,
 				&refcounted);
 	if (!sk)
@@ -1976,8 +1974,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	{
 		struct sock *sk2;
 
-		sk2 = inet6_lookup_listener(net, net->ipv4.tcp_death_row.hashinfo,
-					    skb, __tcp_hdrlen(th),
+		sk2 = inet6_lookup_listener(net, skb, __tcp_hdrlen(th),
 					    &ipv6_hdr(skb)->saddr, th->source,
 					    &ipv6_hdr(skb)->daddr,
 					    ntohs(th->dest),
@@ -2029,8 +2026,7 @@ void tcp_v6_early_demux(struct sk_buff *skb)
 		return;
 
 	/* Note : We use inet6_iif() here, not tcp_v6_iif() */
-	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-					&hdr->saddr, th->source,
+	sk = __inet6_lookup_established(net, &hdr->saddr, th->source,
 					&hdr->daddr, ntohs(th->dest),
 					inet6_iif(skb), inet6_sdif(skb));
 	if (sk) {
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a8a04f441e78..effeba58630b 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -36,8 +36,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 	hdr = skb_gro_network_header(skb);
 	net = dev_net_rcu(skb->dev);
-	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
-					&hdr->saddr, th->source,
+	sk = __inet6_lookup_established(net, &hdr->saddr, th->source,
 					&hdr->daddr, ntohs(th->dest),
 					iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
-- 
2.51.0.rc1.193.gad69d77794-goog


