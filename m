Return-Path: <netdev+bounces-62532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61809827B52
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 00:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6B2284FB2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 23:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937641A85;
	Mon,  8 Jan 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnUtSlyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113456740
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3ea5cc137so20920475ad.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704755645; x=1705360445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KP1d3VI4kPGYl+m0+e1zrf1pgdDjwe04goeKK1ojN4=;
        b=KnUtSlynH7lmI2SBxRVCxjooQUFDtNcwswObh4u9uKkQ/8HALz/EBj4f1Gb2LKt0g2
         ljwS9EbiS+9wzlUW37nm19GxwuRDhWaYtCqtAMiZGhdbad+Qus73TSduuqMap7QB66YZ
         At+ThBiZ4t8Z1ur4xtIIRBXxnXr1CZj4JVOskylZeCgr0AWAxnqYNnLLeMxyku1swA/S
         HTouUyPyhPSLJcGyysrClJuJ3daMGb0D1utqrXSY1BQsfkrKE4NADDhnnkP4p4P60Cnr
         1xSfSKOD3RS9GedpdjcICZo4BY1RsbJMP7l4NBg720fb/hGzwB/m2X8jJzuAd25eeSWS
         mxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704755645; x=1705360445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KP1d3VI4kPGYl+m0+e1zrf1pgdDjwe04goeKK1ojN4=;
        b=qKKY0iidso1SymhX9TgfGe/YhWhTpzQdNZ3lbKQkZCDVjH5AjsjQ3prm/hWk56gs1o
         zWUU3OozavBaShnxUB4dqVSf+dl2NQrFRYp/FWjBPlyfy2zi+xmR4GHzI7e9SZMq4IFY
         M7bRtderTGIlbBeUu6JWvVcNF+gZJMsCoozUg8sYuMcvO2+6f+nBwNiOQeWx86BDer6w
         t9f+ltJ7rw6QfftVZpe5b3p3V99XI31yECiwdnY3xi9w/YVg2YSwKzNP+VxoD0Tmc3hL
         v7W1PVDS6OMB/F2yzDDoHhQ0KO+TSoHVu6pdwlJgd7dNIQGP0y9QJ5XBvYBTbqQ3yLsu
         nHow==
X-Gm-Message-State: AOJu0Yzo3pcZpk45kep0K/6HpQHlmIn0Alz3P4ZDm1NSLBJPTOPXgEfm
	YDSfoO/hPUuPdV4jLxnIMoo=
X-Google-Smtp-Source: AGHT+IHzc+2WEgXwhOtYadTMQ1U2mES/tlUc+/V91vSRBN3qC4VD+0c00jmCcoIjaq94mYS9iBYxUA==
X-Received: by 2002:a17:903:32ca:b0:1d4:5276:765b with SMTP id i10-20020a17090332ca00b001d45276765bmr5938156plr.124.1704755645439;
        Mon, 08 Jan 2024 15:14:05 -0800 (PST)
Received: from jmaxwell.com ([203.220.178.35])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902be1500b001d4bcf6cc43sm418659pls.81.2024.01.08.15.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:14:04 -0800 (PST)
From: Jon Maxwell <jmaxwell37@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	jmaxwell37@gmail.com,
	Davide Caratti <dcaratti@redhat.com>
Subject: [net-next] tcp: Avoid sending an erroneous RST due to RCU race
Date: Tue,  9 Jan 2024 10:13:49 +1100
Message-Id: <20240108231349.9919-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 cases where a socket lookup races due to RCU and finds a 
LISTEN socket instead of an ESTABLISHED or a TIME-WAIT socket. As the ACK flag 
is set this will generate an erroneous RST. 

There are 2 scenarios, one where 2 ACKs (one for the 3 way handshake and 
another with the same sequence number carrying data) are sent with a very 
small time interval between them. In this case the 2 ACKs can race while being
processed on different CPUs and the latter may find the LISTEN socket instead 
of the ESTABLISHED socket. That will make the one end of the TCP connection 
out of sync with the other and cause a break in communications. The other 
scenario is a "FIN ACK" racing with an ACK which may also find the LISTEN 
socket instead of the TIME_WAIT socket. Instead of getting ignored that 
generates an invalid RST. 

Instead of the next connection attempt succeeding. The client then gets an 
ECONNREFUSED error on the next connection attempt when it finds a socket in 
the FIN_WAIT_2 state as discussed here: 

https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.com/ 

Modeled on Erics idea, introduce __inet_lookup_skb_locked() and
__inet6_lookup_skb_locked()  to fix this by doing a locked lookup only for 
these rare cases to avoid finding the LISTEN socket. The fix ensures it will 
wait until the state has transitioned on the other CPU and will find the 
socket in the correct state instead of finding the LISTEN socket, thus 
avoiding the invalid RST that causes secondary problems so that communications 
are unaffected. While maintaining better RCU performance for all other lookups.  

The commit is confirmed to fix both scenarios in testing.  

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/inet6_hashtables.h | 53 ++++++++++++++++++++++++++++++++++
 include/net/inet_hashtables.h  | 52 +++++++++++++++++++++++++++++++++
 net/ipv4/inet_hashtables.c     | 49 +++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c            |  9 ++++++
 net/ipv6/inet6_hashtables.c    | 45 +++++++++++++++++++++++++++++
 net/ipv6/tcp_ipv6.c            |  9 ++++++
 6 files changed, 217 insertions(+)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 533a7337865a4308c073b30b69dae4dcf7e6b264..04868881bf0c86afdd932494d65cbd594fe5defc 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -48,6 +48,14 @@ struct sock *__inet6_lookup_established(struct net *net,
 					const u16 hnum, const int dif,
 					const int sdif);
 
+struct sock *__inet6_lookup_established_locked(struct net *net,
+					       struct inet_hashinfo *hashinfo,
+					       const struct in6_addr *saddr,
+					       const __be16 sport,
+					       const struct in6_addr *daddr,
+					       const u16 hnum, const int dif,
+					       const int sdif);
+
 typedef u32 (inet6_ehashfn_t)(const struct net *net,
 			       const struct in6_addr *laddr, const u16 lport,
 			       const struct in6_addr *faddr, const __be16 fport);
@@ -103,6 +111,27 @@ static inline struct sock *__inet6_lookup(struct net *net,
 				     daddr, hnum, dif, sdif);
 }
 
+static inline struct sock *__inet6_lookup_locked(struct net *net,
+						 struct inet_hashinfo *hashinfo,
+						 struct sk_buff *skb, int doff,
+						 const struct in6_addr *saddr,
+						 const __be16 sport,
+						 const struct in6_addr *daddr,
+						 const u16 hnum,
+						 const int dif, const int sdif,
+						 bool *refcounted)
+{
+	struct sock *sk = __inet6_lookup_established_locked(net, hashinfo, saddr,
+							    sport, daddr, hnum,
+							    dif, sdif);
+	*refcounted = true;
+	if (sk)
+		return sk;
+	*refcounted = false;
+	return inet6_lookup_listener(net, hashinfo, skb, doff, saddr, sport,
+				     daddr, hnum, dif, sdif);
+}
+
 static inline
 struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 			      const struct in6_addr *saddr, const __be16 sport,
@@ -167,6 +196,30 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 			      iif, sdif, refcounted);
 }
 
+static inline struct sock *__inet6_lookup_skb_locked(struct inet_hashinfo *hashinfo,
+						     struct sk_buff *skb, int doff,
+						     const __be16 sport,
+						     const __be16 dport,
+						     int iif, int sdif,
+						     bool *refcounted)
+{
+	struct net *net = dev_net(skb_dst(skb)->dev);
+	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	struct sock *sk;
+
+	sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, &ip6h->daddr, dport,
+			      refcounted, inet6_ehashfn);
+	if (IS_ERR(sk))
+		return NULL;
+	if (sk)
+		return sk;
+
+	return __inet6_lookup_locked(net, hashinfo, skb,
+				     doff, &ip6h->saddr, sport,
+				     &ip6h->daddr, ntohs(dport),
+				     iif, sdif, refcounted);
+}
+
 struct sock *inet6_lookup(struct net *net, struct inet_hashinfo *hashinfo,
 			  struct sk_buff *skb, int doff,
 			  const struct in6_addr *saddr, const __be16 sport,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 7f1b384587437d06834bde554edd8df983fd64a4..6ea4a38c385629f989cbe1ace5ba0a055d48e511 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -374,6 +374,12 @@ struct sock *__inet_lookup_established(struct net *net,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
 
+struct sock *__inet_lookup_established_locked(struct net *net,
+					      struct inet_hashinfo *hashinfo,
+					      const __be32 saddr, const __be16 sport,
+					      const __be32 daddr, const u16 hnum,
+					      const int dif, const int sdif);
+
 typedef u32 (inet_ehashfn_t)(const struct net *net,
 			      const __be32 laddr, const __u16 lport,
 			      const __be32 faddr, const __be16 fport);
@@ -426,6 +432,27 @@ static inline struct sock *__inet_lookup(struct net *net,
 				      sport, daddr, hnum, dif, sdif);
 }
 
+static inline struct sock *__inet_lookup_locked(struct net *net,
+						struct inet_hashinfo *hashinfo,
+						struct sk_buff *skb, int doff,
+						const __be32 saddr, const __be16 sport,
+						const __be32 daddr, const __be16 dport,
+						const int dif, const int sdif,
+						bool *refcounted)
+{
+	u16 hnum = ntohs(dport);
+	struct sock *sk;
+
+	sk = __inet_lookup_established_locked(net, hashinfo, saddr, sport,
+					      daddr, hnum, dif, sdif);
+	*refcounted = true;
+	if (sk)
+		return sk;
+	*refcounted = false;
+	return __inet_lookup_listener(net, hashinfo, skb, doff, saddr,
+				      sport, daddr, hnum, dif, sdif);
+}
+
 static inline struct sock *inet_lookup(struct net *net,
 				       struct inet_hashinfo *hashinfo,
 				       struct sk_buff *skb, int doff,
@@ -509,6 +536,31 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 			     refcounted);
 }
 
+static inline struct sock *__inet_lookup_skb_locked(struct inet_hashinfo *hashinfo,
+						    struct sk_buff *skb,
+						    int doff,
+						    const __be16 sport,
+						    const __be16 dport,
+						    const int sdif,
+						    bool *refcounted)
+{
+	struct net *net = dev_net(skb_dst(skb)->dev);
+	const struct iphdr *iph = ip_hdr(skb);
+	struct sock *sk;
+
+	sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, iph->daddr, dport,
+			     refcounted, inet_ehashfn);
+	if (IS_ERR(sk))
+		return NULL;
+	if (sk)
+		return sk;
+
+	return __inet_lookup_locked(net, hashinfo, skb,
+				    doff, iph->saddr, sport,
+				    iph->daddr, dport, inet_iif(skb), sdif,
+				    refcounted);
+}
+
 static inline void sk_daddr_set(struct sock *sk, __be32 addr)
 {
 	sk->sk_daddr = addr; /* alias of inet_daddr */
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 93e9193df54461b25c61089bd5db4dd33c32dab6..ef9c0b5462bd0a85ebf350f53b4f3e6f6d394282 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -535,6 +535,55 @@ struct sock *__inet_lookup_established(struct net *net,
 }
 EXPORT_SYMBOL_GPL(__inet_lookup_established);
 
+struct sock *__inet_lookup_established_locked(struct net *net,
+					      struct inet_hashinfo *hashinfo,
+					      const __be32 saddr, const __be16 sport,
+					      const __be32 daddr, const u16 hnum,
+					      const int dif, const int sdif)
+{
+	INET_ADDR_COOKIE(acookie, saddr, daddr);
+	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
+	struct sock *sk;
+	const struct hlist_nulls_node *node;
+	/* Optimize here for direct hit, only listening connections can
+	 * have wildcards anyways.
+	 */
+	unsigned int hash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+	unsigned int slot = hash & hashinfo->ehash_mask;
+	struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, hash);
+
+	spin_lock(lock);
+begin:
+	sk_nulls_for_each(sk, node, &head->chain) {
+		if (sk->sk_hash != hash)
+			continue;
+		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
+			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+				goto out;
+			if (unlikely(!inet_match(net, sk, acookie,
+						 ports, dif, sdif))) {
+				sock_gen_put(sk);
+				goto begin;
+			}
+			goto found;
+		}
+	}
+	/*
+	 * if the nulls value we got at the end of this lookup is
+	 * not the expected one, we must restart lookup.
+	 * We probably met an item that was moved to another chain.
+	 */
+	if (get_nulls_value(node) != slot)
+		goto begin;
+out:
+	sk = NULL;
+found:
+	spin_unlock(lock);
+	return sk;
+}
+EXPORT_SYMBOL_GPL(__inet_lookup_established_locked);
+
 /* called with local bh disabled */
 static int __inet_check_established(struct inet_timewait_death_row *death_row,
 				    struct sock *sk, __u16 lport,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4bac6e319aca2e45d698889d2293b46632ae00f2..46c78464caf7ccae8a00e8029944d8438feed5dd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2209,6 +2209,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	sk = __inet_lookup_skb(net->ipv4.tcp_death_row.hashinfo,
 			       skb, __tcp_hdrlen(th), th->source,
 			       th->dest, sdif, &refcounted);
+
+	/* The 1st lookup is prone to races as it's RCU
+	 * Under rare conditions it can find a LISTEN socket
+	 * Avoid an erroneous RST and this time do a locked lookup.
+	 */
+	if (unlikely(sk && sk->sk_state == TCP_LISTEN && th->ack))
+		sk = __inet_lookup_skb_locked(net->ipv4.tcp_death_row.hashinfo,
+					      skb, __tcp_hdrlen(th), th->source,
+					      th->dest, sdif, &refcounted);
 	if (!sk)
 		goto no_tcp_socket;
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b0e8d278e8a9b794d0001efdc0f43716f9a34f8f..24138e4efbaf10f8f54bdd32ccd5767ec6962df2 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -90,6 +90,51 @@ struct sock *__inet6_lookup_established(struct net *net,
 }
 EXPORT_SYMBOL(__inet6_lookup_established);
 
+struct sock *__inet6_lookup_established_locked(struct net *net,
+					       struct inet_hashinfo *hashinfo,
+					       const struct in6_addr *saddr,
+					       const __be16 sport,
+					       const struct in6_addr *daddr,
+					       const u16 hnum,
+					       const int dif, const int sdif)
+{
+	struct sock *sk;
+	const struct hlist_nulls_node *node;
+	const __portpair ports = INET_COMBINED_PORTS(sport, hnum);
+	/* Optimize here for direct hit, only listening connections can
+	 * have wildcards anyways.
+	 */
+	unsigned int hash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+	unsigned int slot = hash & hashinfo->ehash_mask;
+	struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, hash);
+
+	spin_lock(lock);
+begin:
+	sk_nulls_for_each(sk, node, &head->chain) {
+		if (sk->sk_hash != hash)
+			continue;
+		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
+			continue;
+		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			goto out;
+
+		if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
+			sock_gen_put(sk);
+			goto begin;
+		}
+		goto found;
+	}
+	if (get_nulls_value(node) != slot)
+		goto begin;
+out:
+	sk = NULL;
+found:
+	spin_unlock(lock);
+	return sk;
+}
+EXPORT_SYMBOL(__inet6_lookup_established_locked);
+
 static inline int compute_score(struct sock *sk, struct net *net,
 				const unsigned short hnum,
 				const struct in6_addr *daddr,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d1307d77a6f094e49ea14c525820ba7635d0aa7c..f5986ff21d2c08e54cca5ae9e6aa123598c53a11 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1790,6 +1790,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	sk = __inet6_lookup_skb(net->ipv4.tcp_death_row.hashinfo, skb, __tcp_hdrlen(th),
 				th->source, th->dest, inet6_iif(skb), sdif,
 				&refcounted);
+
+	/* The 1st lookup is prone to races as it's RCU
+	 * Under rare conditions it can find a LISTEN socket
+	 * Avoid an erroneous RST and this time do a locked lookup.
+	 */
+	if (unlikely(sk && sk->sk_state == TCP_LISTEN && th->ack))
+		sk = __inet6_lookup_skb_locked(net->ipv4.tcp_death_row.hashinfo, skb,
+					       __tcp_hdrlen(th), th->source, th->dest,
+					       inet6_iif(skb), sdif, &refcounted);
 	if (!sk)
 		goto no_tcp_socket;
 
-- 
2.39.3


