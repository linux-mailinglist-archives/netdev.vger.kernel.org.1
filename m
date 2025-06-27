Return-Path: <netdev+bounces-201910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E954DAEB647
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6991895172
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4EB2BEC41;
	Fri, 27 Jun 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWY0n2Xl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1B29B8FE
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023550; cv=none; b=ht/jteqMu7ZL3C+/yiuYNtG2BNLa95YLGS9gptG2lAj/qkJsLWrkhXwGNWSktz7U9W1BCRY7MEL5weA2H67XwPRPWhH2y90BkdiRdnmfJQDEr11q2kbUphBmk/eXoyZFm64qvn0jVN2v7vRSFtTLnlJGL5emOmBBsR3sOZhWe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023550; c=relaxed/simple;
	bh=HXy+QiVeR1VC+E4QF6g6b8Dee7B3GUAfxThitw8hmXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s83fpJTUkQa3nrxceM0Ss2060R6Ufm1X0MUmS+Kprj1QnwPBdlV+KMWbC3Cl9XSlPER3CvhiUN0SJ8+GCim4g9qLoOeMyRnUWkGQNB3/IzNxQzj3ouWBm8hKqsdwqTr3Bb4ptrNfmpmw/PZygWzQjyHiJZrQ7o+bh4tCj5lcptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWY0n2Xl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7d09ed509aaso289005785a.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023548; x=1751628348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMBK+FI/+DBMvE8yuUaZufsqxW+pH+mvW37paKsCQHw=;
        b=tWY0n2XlDVqbEm2wZJhJqncAzkZOkp/4FatmDrtrP4Hbv7w4CO3nJqAQVSzmuMCmXQ
         +ugcfTcYzePgSI9SWjbHnLtvcKNtCGL5p0778REdi2qrFTP9csRkGxlZYB+CjWceYhj4
         iUQR99y0Hwru76z6CQIdb5/g8uqvRW6BqZ6v+/EWK2l9OD90dcxXE+j7HHgEaBVy2kKb
         fKJdv5Q4mvXgcZH7rrXRQJa8wBqVP67YLP2MEYZO6fsOFw+TXhob+Ynj+ELhQAjaNluP
         ZtMdOHMEub23dPz6Kf5D+oV6E+WTc0l5b7XZxFW5uZIakypavaZ0oDG69BQCIdQ9PZFf
         Hyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023548; x=1751628348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMBK+FI/+DBMvE8yuUaZufsqxW+pH+mvW37paKsCQHw=;
        b=NEcsLZSfoUsnmVIgojoDlFxrSFuBlLKVDrCbJqtZRTHTmZ4wH2pSN0VrYXvF5rOwUn
         C01P8uLaHdkwrrXCRlPa+eWWsmYoU+ZyiK20Q3X4hD80RUUeCy2bpTqdN7UoU6VtGxba
         WtU5SlPVjtylnBgE5j6/Mrd8qZkvoXqGHaGkdUd484n/tMR3rIV3g+qINskbj5WkHE7p
         zrAKB2n1iLYEb+D1c8o7IoUUZiL12+KUXrZFvI5DGPHPsKkmGSuhVMhKEilUl5JO/x/C
         sXryR9OP2BJkN2582EUFfaAGAgR+RceuKyKUT+1IgTx041Prepc2/OPrCbgnYCjE/K4f
         z2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjw02VbraxWtFQp+1mUfE+uVUXVB0qi1IrAysv6I0jB6RzQL1w5TN9+2+/n+XeB6C78h9pIUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8F7iEaVgd+DkyQeTlVkPdgB8c5nMAO30RhkQOmqdDNzOm0bqG
	L5Dg1jKlOzOf6aqYVTzDOBGwU15Gp74pqzGVgeROH/fvhzUPRykGoJwMoAzWmH8FFBuI2OxS6GX
	nzQcL7Syn+4YEkA==
X-Google-Smtp-Source: AGHT+IGv5mSFmmf6M7GiaFQRTuusQeg07H+llKGU8NsqURifAz1NzkrF45En9ViThdi/w+ggdb7ORfXyPy0B8A==
X-Received: from qvbre8.prod.google.com ([2002:a05:6214:5e08:b0:6fb:5027:1dff])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8396:b0:7d3:8d1e:9703 with SMTP id af79cd13be357-7d44399091emr393934985a.33.1751023547629;
 Fri, 27 Jun 2025 04:25:47 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:23 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-8-edumazet@google.com>
Subject: [PATCH net-next 07/10] ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers as a first step to deal with
potential dst->dev races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_hashtables.h |  2 +-
 include/net/ip.h              | 11 ++++++-----
 include/net/route.h           |  2 +-
 net/ipv4/icmp.c               | 24 +++++++++++++-----------
 net/ipv4/igmp.c               |  2 +-
 net/ipv4/ip_fragment.c        |  2 +-
 net/ipv4/ip_output.c          |  6 +++---
 net/ipv4/ip_vti.c             |  4 ++--
 net/ipv4/netfilter.c          |  4 ++--
 net/ipv4/route.c              |  8 ++++----
 net/ipv4/tcp_fastopen.c       |  4 +++-
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv4/tcp_metrics.c        |  8 ++++----
 net/ipv4/xfrm4_output.c       |  2 +-
 14 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ae09e91398a5d3253750547ef4bb100d00b419ef..19dbd9081d5a5e75946c1306e7a63b6fd35434c7 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -481,7 +481,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = skb_dst_dev_net_rcu(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/ip.h b/include/net/ip.h
index 391af454422ebe25ba984398a2226f7ed88abe1d..befcba575129ac436912d9c19740a0a72fe23954 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -472,7 +472,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -486,7 +486,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	if (mtu)
 		goto out;
 
-	mtu = READ_ONCE(dst->dev->mtu);
+	mtu = READ_ONCE(dst_dev(dst)->mtu);
 
 	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
@@ -506,16 +506,17 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
+	const struct dst_entry *dst = skb_dst(skb);
 	unsigned int mtu;
 
 	if (!sk || !sk_fullsock(sk) || ip_sk_use_pmtu(sk)) {
 		bool forwarding = IPCB(skb)->flags & IPSKB_FORWARDED;
 
-		return ip_dst_mtu_maybe_forward(skb_dst(skb), forwarding);
+		return ip_dst_mtu_maybe_forward(dst, forwarding);
 	}
 
-	mtu = min(READ_ONCE(skb_dst(skb)->dev->mtu), IP_MAX_MTU);
-	return mtu - lwtunnel_headroom(skb_dst(skb)->lwtstate, mtu);
+	mtu = min(READ_ONCE(dst_dev(dst)->mtu), IP_MAX_MTU);
+	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
 struct dst_metrics *ip_fib_metrics_init(struct nlattr *fc_mx, int fc_mx_len,
diff --git a/include/net/route.h b/include/net/route.h
index 3d3d6048ffca2b09b7e8885b04dd3f6db7a3e5cb..7ea840daa775b29d88cf7125a9d168599be6545d 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -390,7 +390,7 @@ static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 		const struct net *net;
 
 		rcu_read_lock();
-		net = dev_net_rcu(dst->dev);
+		net = dev_net_rcu(dst_dev(dst));
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
 		rcu_read_unlock();
 	}
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 717cb7d3607a1c77a3f54b56d2bb98b1064dd878..2ffe73ea644ff71add3911f213735e8ebda590c0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -311,18 +311,20 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 {
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
+	struct net_device *dev;
 	bool rc = true;
 
 	if (!apply_ratelimit)
 		return true;
 
 	/* No rate limit on loopback */
-	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
+	dev = dst_dev(dst);
+	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
 	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
-			       l3mdev_master_ifindex_rcu(dst->dev));
+			       l3mdev_master_ifindex_rcu(dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
 	rcu_read_unlock();
@@ -466,13 +468,13 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
  */
 static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
 {
-	struct net_device *route_lookup_dev = NULL;
+	struct net_device *dev = skb->dev;
+	const struct dst_entry *dst;
 
-	if (skb->dev)
-		route_lookup_dev = skb->dev;
-	else if (skb_dst(skb))
-		route_lookup_dev = skb_dst(skb)->dev;
-	return route_lookup_dev;
+	if (dev)
+		return dev;
+	dst = skb_dst(skb);
+	return dst ? dst_dev(dst) : NULL;
 }
 
 static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
@@ -869,7 +871,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net_rcu(skb_dst(skb)->dev);
+	net = skb_dst_dev_net_rcu(skb);
 
 	/*
 	 *	Incomplete header ?
@@ -1012,7 +1014,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net_rcu(skb_dst(skb)->dev);
+	net = skb_dst_dev_net_rcu(skb);
 	/* should there be an ICMP stat for ignored echos? */
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
@@ -1182,7 +1184,7 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
-	__ICMP_INC_STATS(dev_net_rcu(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(skb_dst_dev_net_rcu(skb), ICMP_MIB_INERRORS);
 	return SKB_DROP_REASON_PKT_TOO_SMALL;
 }
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d1769034b6438bb5c994e1660b181e05109ab365..7182f1419c2a4d4ea1e90ef6857f6af895dd2770 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -427,7 +427,7 @@ static int igmpv3_sendpack(struct sk_buff *skb)
 
 	pig->csum = ip_compute_csum(igmp_hdr(skb), igmplen);
 
-	return ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
+	return ip_local_out(skb_dst_dev_net(skb), skb->sk, skb);
 }
 
 static int grec_size(struct ip_mc_list *pmc, int type, int gdel, int sdel)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 64b3fb3208af65b569f37575467060797acf7002..b2584cce90ae1c14550396de486131b700d4afd7 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -476,7 +476,7 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
+	struct net_device *dev = skb->dev ? : skb_dst_dev(skb);
 	int vif = l3mdev_master_ifindex_rcu(dev);
 	struct ipq *qp;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a2705d454fd645b442b2901833afa51b26512512..414b47a0d513fd4a8acfe1a101b91fad8efcc4d4 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -116,7 +116,7 @@ int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IP);
 
 	return nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		       net, sk, skb, NULL, skb_dst(skb)->dev,
+		       net, sk, skb, NULL, skb_dst_dev(skb),
 		       dst_output);
 }
 
@@ -199,7 +199,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rtable *rt = dst_rtable(dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
 	bool is_v6gw = false;
@@ -425,7 +425,7 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
+	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 686e4f3d83aa7fd2639e16466a50ed3f257f2a88..95b6bb78fcd274ec38ebda549e91d9cc0b38e3f9 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -229,7 +229,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error_icmp;
 	}
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		dst_release(dst);
@@ -259,7 +259,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 xmit:
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 
 	err = dst_output(tunnel->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0)
diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index 08bc3f2c0078bbc956f45daab605b287efbd4819..0565f001120dcae8a7f6a552c40bb897b4786abb 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -20,12 +20,12 @@
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
 int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, unsigned int addr_type)
 {
+	struct net_device *dev = skb_dst_dev(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
 	struct flowi4 fl4 = {};
 	__be32 saddr = iph->saddr;
 	__u8 flags;
-	struct net_device *dev = skb_dst(skb)->dev;
 	struct flow_keys flkeys;
 	unsigned int hh_len;
 
@@ -74,7 +74,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 #endif
 
 	/* Change in oif may mean change in hh_len. */
-	hh_len = skb_dst(skb)->dev->hard_header_len;
+	hh_len = skb_dst_dev(skb)->hard_header_len;
 	if (skb_headroom(skb) < hh_len &&
 	    pskb_expand_head(skb, HH_DATA_ALIGN(hh_len - skb_headroom(skb)),
 				0, GFP_ATOMIC))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ce6aba4f01ff25a8f9238271a7ae2295f7c7bb93..64ba377cd6cc6664626029a325d08572e9d5949d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -413,7 +413,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct neighbour *n;
 
 	rcu_read_lock();
@@ -440,7 +440,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	const __be32 *pkey = daddr;
 
 	if (rt->rt_gw_family == AF_INET) {
@@ -1026,7 +1026,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1326,7 +1326,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 5107121c5e37fa5741ca97d4f79dc8eb958a9fba..f1884f0c9e523d50b2d120175cc94bc40b489dfb 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -559,6 +559,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
 void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	struct net_device *dev;
 	struct dst_entry *dst;
 	struct sk_buff *skb;
 
@@ -576,7 +577,8 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 	} else if (tp->syn_fastopen_ch &&
 		   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times)) {
 		dst = sk_dst_get(sk);
-		if (!(dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK)))
+		dev = dst ? dst_dev(dst) : NULL;
+		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
 		dst_release(dst);
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 429fb34b075e0bdad0e1c55dd6b1101b3dfe78dd..3269c15c149a7b860717b3381d954257265aacc7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -787,7 +787,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 4251670e328c83b55eff7bbda3cc3d97d78563a8..03c068ea27b6ad3283b8365f31706c11ecdd07f2 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -166,11 +166,11 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 					  unsigned int hash)
 {
 	struct tcp_metrics_block *tm;
-	struct net *net;
 	bool reclaim = false;
+	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 3cff51ba72bb019d920554fa653937d729469b32..0ae67d537499a247c139a49e83f6f68dbc5114fa 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -31,7 +31,7 @@ static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, skb->dev, skb_dst(skb)->dev,
+			    net, sk, skb, skb->dev, skb_dst_dev(skb),
 			    __xfrm4_output,
 			    !(IPCB(skb)->flags & IPSKB_REROUTED));
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


