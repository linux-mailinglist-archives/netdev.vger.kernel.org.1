Return-Path: <netdev+bounces-202416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A70AEDC9E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32357A9095
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF528A40B;
	Mon, 30 Jun 2025 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQy9N5jX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30866289813
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285993; cv=none; b=Y0cfIBkNCJTRaAEkIuY9qHQvwEAabjZ627ENxxkGeU8fdRbDGpzb4dn/1+8BXvNDhLIzsZ+VFs1q0xSx0Yxw1T+QLP7KTG7wDEYrT7FjDgdIa/JwEDKtMrEyvU7AF2Cp7UHbFHTA5h2ViJLTzufwt9rO3Ytr1rQzO2tl69cfC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285993; c=relaxed/simple;
	bh=KsCTJPsHIxndVYqJrrnRH9enAc9BMnDbTQspADibgZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qW/Tx99ITjHyTVq5nRBviymXBNdDsTeLNeraAMoswkN9IL3z4nnVkHgooHBgPB/NgoshAFIAcoBWaKpAnkzRJJPLGZp+RsEnpOZXSDLRYd3+2IJkCMf/Xytrzh0zfMycSzkLWhQJNL5peuNMuDiCQ9g5UTEy1s1zKWPOAKTInxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQy9N5jX; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fb1be925fbso36313976d6.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285990; x=1751890790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/KZCPXZxMV4BPsThTTuqSHdGagDN4xwkzs+3Xaqc1g=;
        b=KQy9N5jXpB61Uk5psidOolr5EVG+RMFSKvrKpMQbvhlJATNuMXo7VFCWfgNrgSI01j
         nS8B14CwVzJWfAJO1+AeVNUqRB2brIjnxyyueZXi/Doevsr41fc14Df5KJ5ctQ6hVJOl
         IjVO1ix1ycdednsNw34qGqEjAjSMHzdZ7h/bJlk87OsJmNTWAGRtvobzeDGTgZPVXsLA
         vRPaWaizBvsFDgn9f84CgxOwKxKgQzhhi0Ns8xRMcmWUcRVLRZlb+N8HE4vzuxoflxn0
         QvVmoUCJKzYZgXFMjj8+REiqOcb7C9uM5CmrX9fRWip0qWy05X/Fq0rlLNN6PiO3vPBs
         YjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285990; x=1751890790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/KZCPXZxMV4BPsThTTuqSHdGagDN4xwkzs+3Xaqc1g=;
        b=YfUoX73CHpe6orr6+wmoC+COrBSkkEmSPy0UHdKguUcUrZYf3s7qTh0UNh9b7iqgSS
         ftuhqGxLOJV/nmQB5PdgenU3RG+NKF8stYNX8705WbjAXo3+EuuSIc30o7wbupBxUHl6
         O1zfkwMp2Cj2QKAcfs1OV2m1ZQgNFaaW7lQllCoQyVrJfwsrqL2FLNdc8V2AmKlgXx35
         Y6Y5TpATkxWzgvy05jcYAngfse+a5HMvanU9sjYJDvHU/80mSywzj/pR9ebs9M77vTrd
         Y1aGQunnd0Cr0g3SweSkn5fBqTJ0D/mUAN8cyrzM7Li6h20feOZSF40cw+o5NhebcEGf
         5Wlw==
X-Forwarded-Encrypted: i=1; AJvYcCXHOLVQFBRxk529IsSRnX8AMSV5d3d+evR8z3/WKvvDpZOM7pZZbxKUAXLzWEWwU1r0N2WABnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/IxCXM5QoKORpslUz5y6yoxI0yRRJxQ8KdKK4NrKwnkQ2odd
	ftSAWMaSVnFJQBo088h5q+epewQLc5d4xz2BsLl579OzIIPCoR4N9x2/yCQ6xWN9JWzto+9QK5h
	pdMQoVQTJFS7zMQ==
X-Google-Smtp-Source: AGHT+IEvD9ifCk9+us/kSriuo4rTB441toUWkqrM0jBvFCUem9up4A8G43DHVpnVgAYzB+/d+WCcQc6QNqXVGA==
X-Received: from qvbks6.prod.google.com ([2002:a05:6214:3106:b0:6fd:5d40:fa92])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:621:b0:6fd:5c:2d75 with SMTP id 6a1803df08f44-70002a0d4d5mr257644646d6.36.1751285990194;
 Mon, 30 Jun 2025 05:19:50 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:33 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/10] ipv6: adopt skb_dst_dev() and
 skb_dst_dev_net[_rcu]() helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers as a step to deal with potential dst->dev races.

v2: fix typo in ipv6_rthdr_rcv() (kernel test robot <lkp@intel.com>)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet6_hashtables.h      |  2 +-
 include/net/ip6_tunnel.h            |  2 +-
 net/ipv6/exthdrs.c                  |  8 ++++----
 net/ipv6/ioam6.c                    | 17 +++++++++--------
 net/ipv6/ip6_input.c                |  6 ++++--
 net/ipv6/ip6_output.c               |  5 +++--
 net/ipv6/ip6_tunnel.c               |  2 +-
 net/ipv6/ip6_vti.c                  |  2 +-
 net/ipv6/netfilter.c                |  4 ++--
 net/ipv6/netfilter/nf_reject_ipv6.c |  2 +-
 net/ipv6/output_core.c              |  2 +-
 net/ipv6/reassembly.c               | 10 +++++-----
 net/ipv6/route.c                    |  4 ++--
 net/ipv6/seg6_iptunnel.c            |  6 +++---
 net/ipv6/tcp_ipv6.c                 |  4 ++--
 net/ipv6/xfrm6_output.c             |  2 +-
 16 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index c32878c69179dac5a7fcfa098a297420d9adfab2..ab3929a2a95697a0e417cf4a4e3b355f3a68a78c 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -150,7 +150,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = skb_dst_dev_net_rcu(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index dd163495f3539f1e3522c0c8d8715e5b0dd91b27..120db2865811250ea9ddbf3bc5396c20a90e1937 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -159,7 +159,7 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 	IP6CB(skb)->flags = ip6cb_flags;
 	pkt_len = skb->len - skb_inner_network_offset(skb);
-	err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
+	err = ip6_local_out(skb_dst_dev_net(skb), sk, skb);
 
 	if (dev) {
 		if (unlikely(net_xmit_eval(err)))
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 1947530fb20ac17dcd6660703e3e94d584d5f688..d1ef9644f82629cde1307eaa2d21a69f2793e946 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -460,7 +460,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_dst(skb)->dev->flags & IFF_LOOPBACK) {
+	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
@@ -621,7 +621,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_dst(skb)->dev->flags & IFF_LOOPBACK) {
+	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
@@ -783,7 +783,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 			kfree_skb(skb);
 			return -1;
 		}
-		if (!ipv6_chk_home_addr(dev_net(skb_dst(skb)->dev), addr)) {
+		if (!ipv6_chk_home_addr(skb_dst_dev_net(skb), addr)) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INADDRERRORS);
 			kfree_skb(skb);
 			return -1;
@@ -809,7 +809,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_dst(skb)->dev->flags&IFF_LOOPBACK) {
+	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index a84d332f952f66fb59554ee64057859d2c3f8c09..9553a32000813469265cacea4511fa74c1737c21 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -696,6 +696,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_schema *sc,
 				    u8 sclen, bool is_input)
 {
+	struct net_device *dev = skb_dst_dev(skb);
 	struct timespec64 ts;
 	ktime_t tstamp;
 	u64 raw64;
@@ -712,7 +713,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw32 = dev_net(skb_dst(skb)->dev)->ipv6.sysctl.ioam6_id;
+		raw32 = dev_net(dev)->ipv6.sysctl.ioam6_id;
 
 		*(__be32 *)data = cpu_to_be32((byte << 24) | raw32);
 		data += sizeof(__be32);
@@ -728,10 +729,10 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
 
-		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+		if (dev->flags & IFF_LOOPBACK)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -783,10 +784,10 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		struct Qdisc *qdisc;
 		__u32 qlen, backlog;
 
-		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK) {
+		if (dev->flags & IFF_LOOPBACK) {
 			*(__be32 *)data = cpu_to_be32(IOAM6_U32_UNAVAILABLE);
 		} else {
-			queue = skb_get_tx_queue(skb_dst(skb)->dev, skb);
+			queue = skb_get_tx_queue(dev, skb);
 			qdisc = rcu_dereference(queue->qdisc);
 			qdisc_qstats_qlen_backlog(qdisc, &qlen, &backlog);
 
@@ -807,7 +808,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw64 = dev_net(skb_dst(skb)->dev)->ipv6.sysctl.ioam6_id_wide;
+		raw64 = dev_net(dev)->ipv6.sysctl.ioam6_id_wide;
 
 		*(__be64 *)data = cpu_to_be64(((u64)byte << 56) | raw64);
 		data += sizeof(__be64);
@@ -823,10 +824,10 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
 
-		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+		if (dev->flags & IFF_LOOPBACK)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 39da6a7ce5f1245145dd74d4ac4eae63dd970939..16953bd0096047f9b5fbb8e66bf9cc591e6693aa 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -187,7 +187,9 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	 * arrived via the sending interface (ethX), because of the
 	 * nature of scoping architecture. --yoshfuji
 	 */
-	IP6CB(skb)->iif = skb_valid_dst(skb) ? ip6_dst_idev(skb_dst(skb))->dev->ifindex : dev->ifindex;
+	IP6CB(skb)->iif = skb_valid_dst(skb) ?
+				ip6_dst_idev(skb_dst(skb))->dev->ifindex :
+				dev->ifindex;
 
 	if (unlikely(!pskb_may_pull(skb, sizeof(*hdr))))
 		goto err;
@@ -504,7 +506,7 @@ int ip6_mc_input(struct sk_buff *skb)
 	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(dev_net(skb_dst(skb)->dev),
+	__IP6_UPD_PO_STATS(skb_dst_dev_net(skb),
 			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
 			 skb->len);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f494b4ece6b7cf08522abd20817c7a37432ab37e..877bee7ffee9284cf88cb13a79e8bf777b470bb9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -232,8 +232,9 @@ static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 
 int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
-	struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
+	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = dst_dev(dst), *indev = skb->dev;
+	struct inet6_dev *idev = ip6_dst_idev(dst);
 
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 535d97b08220c55c356c3032c294534018acfab9..d4d6b802cdcaef6b20cfda46304a4aaaf09c96ce 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -632,7 +632,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	} else {
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr,
 				   ip4h_dscp(eiph), skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
+		    skb_dst_dev(skb2)->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 2a86de922d42710b110057c23daad2f63fc69fe2..ad5290be4dd61dd98a6f6b4fd3a2161b3f44bf23 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -529,7 +529,7 @@ vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 xmit:
 	skb_scrub_packet(skb, !net_eq(t->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = dst_dev(dst);
 
 	err = dst_output(t->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0)
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 4541836ee3da207b163123f432d45647b6f869f7..45f9105f9ac1e1497c6471b01ce515d4d8672eed 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -24,7 +24,7 @@ int ip6_route_me_harder(struct net *net, struct sock *sk_partial, struct sk_buff
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct sock *sk = sk_to_full_sk(sk_partial);
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev = skb_dst_dev(skb);
 	struct flow_keys flkeys;
 	unsigned int hh_len;
 	struct dst_entry *dst;
@@ -72,7 +72,7 @@ int ip6_route_me_harder(struct net *net, struct sock *sk_partial, struct sk_buff
 #endif
 
 	/* Change in oif may mean change in hh_len. */
-	hh_len = skb_dst(skb)->dev->hard_header_len;
+	hh_len = skb_dst_dev(skb)->hard_header_len;
 	if (skb_headroom(skb) < hh_len &&
 	    pskb_expand_head(skb, HH_DATA_ALIGN(hh_len - skb_headroom(skb)),
 			     0, GFP_ATOMIC))
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 9ae2b2725bf99ab0c6057032996b7f249fb6f45c..838295fa32e36426a07645d215920d373e742f91 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -300,7 +300,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		skb_dst_set(oldskb, dst);
 	}
 
-	fl6.flowi6_oif = l3mdev_master_ifindex(skb_dst(oldskb)->dev);
+	fl6.flowi6_oif = l3mdev_master_ifindex(skb_dst_dev(oldskb));
 	fl6.flowi6_mark = IP6_REPLY_MARK(net, oldskb->mark);
 	security_skb_classify_flow(oldskb, flowi6_to_flowi_common(&fl6));
 	dst = ip6_route_output(net, NULL, &fl6);
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 90a178dd24aaeb44b69ad4abc9da6fa1c10f46d1..d21fe27fe21e344b694e0378214fbad04c4844d2 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -141,7 +141,7 @@ int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 
 	return nf_hook(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-		       net, sk, skb, NULL, skb_dst(skb)->dev,
+		       net, sk, skb, NULL, skb_dst_dev(skb),
 		       dst_output);
 }
 EXPORT_SYMBOL_GPL(__ip6_local_out);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 7d4bcf3fda5bac556b032e38934c6bc40d4f2ec9..25ec8001898df76eba08233c182e0c7154c1c1b7 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -104,11 +104,11 @@ fq_find(struct net *net, __be32 id, const struct ipv6hdr *hdr, int iif)
 	return container_of(q, struct frag_queue, q);
 }
 
-static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
+static int ip6_frag_queue(struct net *net,
+			  struct frag_queue *fq, struct sk_buff *skb,
 			  struct frag_hdr *fhdr, int nhoff,
 			  u32 *prob_offset, int *refs)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
 	int offset, end, fragsize;
 	struct sk_buff *prev_tail;
 	struct net_device *dev;
@@ -324,10 +324,10 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 
 static int ipv6_frag_rcv(struct sk_buff *skb)
 {
+	const struct ipv6hdr *hdr = ipv6_hdr(skb);
+	struct net *net = skb_dst_dev_net(skb);
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
-	const struct ipv6hdr *hdr = ipv6_hdr(skb);
-	struct net *net = dev_net(skb_dst(skb)->dev);
 	u8 nexthdr;
 	int iif;
 
@@ -384,7 +384,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 		spin_lock(&fq->q.lock);
 
 		fq->iif = iif;
-		ret = ip6_frag_queue(fq, skb, fhdr, IP6CB(skb)->nhoff,
+		ret = ip6_frag_queue(net, fq, skb, fhdr, IP6CB(skb)->nhoff,
 				     &prob_offset, &refs);
 
 		spin_unlock(&fq->q.lock);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index dacfe1284918bffc75d1b41745c8873b9132bfc6..3fbe0885c21c6e2dcab27d47b09dd71764762794 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4631,7 +4631,7 @@ static int ip6_pkt_discard(struct sk_buff *skb)
 
 static int ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 	return ip6_pkt_drop(skb, ICMPV6_NOROUTE, IPSTATS_MIB_OUTNOROUTES);
 }
 
@@ -4642,7 +4642,7 @@ static int ip6_pkt_prohibit(struct sk_buff *skb)
 
 static int ip6_pkt_prohibit_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 	return ip6_pkt_drop(skb, ICMPV6_ADM_PROHIBITED, IPSTATS_MIB_OUTNOROUTES);
 }
 
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 27918fc0c9721d777965a819863169f3bde5114c..3e1b9991131a233a3e6b080d6213e3eec946e81b 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -364,7 +364,7 @@ static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
-		struct net *net = dev_net(skb_dst(skb)->dev);
+		struct net *net = skb_dst_dev_net(skb);
 
 		err = seg6_push_hmac(net, &hdr->saddr, isrh);
 		if (unlikely(err))
@@ -530,7 +530,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 static int seg6_input_nf(struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev = skb_dst_dev(skb);
 	struct net *net = dev_net(skb->dev);
 
 	switch (skb->protocol) {
@@ -616,7 +616,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 static int seg6_output_nf(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev = skb_dst_dev(skb);
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9fb614e17bde99e5806cd56fdbc4d0b0b74a3f57..716aef323b7495c97b5d23b7060d07016684023f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -867,7 +867,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				 int oif, int rst, u8 tclass, __be32 label,
 				 u32 priority, u32 txhash, struct tcp_key *key)
 {
-	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 	unsigned int tot_len = sizeof(struct tcphdr);
 	struct sock *ctl_sk = net->ipv6.tcp_sk;
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -1042,7 +1042,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index b3d5d1f266eeea6bea32d81feede4c1076f2f829..512bdaf136997a29698029560b37992ae806a9e8 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -106,7 +106,7 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 int xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
-			    net, sk, skb,  skb->dev, skb_dst(skb)->dev,
+			    net, sk, skb,  skb->dev, skb_dst_dev(skb),
 			    __xfrm6_output,
 			    !(IP6CB(skb)->flags & IP6SKB_REROUTED));
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


