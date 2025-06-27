Return-Path: <netdev+bounces-201912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56BFAEB653
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AFF3BB546
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A32D3A80;
	Fri, 27 Jun 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmXQBZun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6B2C324E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023553; cv=none; b=EYVjJPfRtrBght1aLMq908d6i0a/RiGgS4LDmtWwYO0IPLo8sppSt7RZmb1mXjmvXWxf0Mytmf3gVwHEvGGiMvHTrNftXMsFfEk6xcImOjj8ZpkHELE5nNRncyj/4UW4HmB20S06SC6A1c54sQWARZKZAFwYqMKDGNbj/UpORhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023553; c=relaxed/simple;
	bh=3f0ubl//xllNUZdiCdCQO9sqkFrEUY4EWRIqNutf0PU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMtEahevElb6S0jd416U1XjJ8elPmjX/2B2ELqqajKrvHIb4woNO+hjRqi9uogyMiZh0oBQIrp7mxpVsiuwOwoKle+Lx5r1zyGN4KWRCMW4KmLoaI91HaqGemF5nvydtmYiyUpSIAqdyptPfgLxjAQHMJyERzuCfWL68d3Aqq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmXQBZun; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a6f6d07bb0so43234451cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023550; x=1751628350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RISCh4KaN70YEdszEXedjNLya++oDW8T1GA8p8bbTfk=;
        b=EmXQBZunq7GqAvbk6sPdLwh0WRYysSL4jyPoualB8G32x20vqMnp5WKBqDSYXoeSpO
         v/kjxtX5b1mb4xpsLEQwbrJ9Tvs9v+LDhwYWa26/TdDjhCvOStpSI1w9tDjJcud+gnCC
         k95xUJPXWTI0rIRQtroK+cOO3cqr0UUvlEXdRVgtiEQLmZsmyrvtGkxkBeIh356gQxAH
         HItklzmehY9NvY2jPDdYCjtDTJ3lVOxAx+SIixbszdWctjGuPwlIVUZ4ZAkF/lAH8LWR
         9edLa6t5PUTQ+JgTYJ+iFk7mwMqBuvwDr7PVjqXbRxYpiFYhV0XMVGDgtU8JUEllF7IA
         knSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023550; x=1751628350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RISCh4KaN70YEdszEXedjNLya++oDW8T1GA8p8bbTfk=;
        b=WgRw+EB2gKmBWYglQPK6w3jktmKBCTLInF5otylD2EFv1KE/dvh/G/6Ou8IKUZRlMW
         gyrwd2784Lb8auhnK5i+nmBUvqeZQkLu1zMOjgRGUtJ6+Kl0l0+drx9qKIGpR/lE7in8
         +cFczdx4scg/zFH+wJTBGtG6ZqYp7EjKKoE/x6c28PjHcL5lSHgHoL5DlKjUyewfuKBo
         RUtiylFVG4QkKs92jNzC+Fhug14wzN3YLVar/xg+CrYvnBvUBUFYd5qpTqcOI3TE8MJZ
         tTQidEkO68vgUBsA3+Kr+UBjhfsqhjav+YJDFLNzgDHD38EgripN5wsa/KhpgWNf0IBA
         wzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4eGP2WCDQRiY1ko2WYou/9+MX/EeEkwiOhugE8fgzrliKE0aRDUhxMm6H/KKkQxcQ1/DUv0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4CFGcEccZF5JHhexHh3b6amFKYYxTk0FLeTlN/68zM0SwG+c
	GfL77Cr1TpgIiAXgP0XNYGiuNrf/Sl+mzfIZW1OSv+DdfRJYExJXyOyjbJfUKICRcT3JIN70jQ0
	J9AeTgyeYa3CrHA==
X-Google-Smtp-Source: AGHT+IF30ZzlFZwqlie2QxpWa6gfGx/eruIbVc/xVUoKQSYWI+NPGVRj0Fg+O+dWLTjzVyMGrrzvIkOKeNUopQ==
X-Received: from qtas4.prod.google.com ([2002:ac8:5cc4:0:b0:4a4:328c:ff59])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1182:b0:4a6:f518:6b11 with SMTP id d75a77b69052e-4a7fcacffa9mr54945191cf.28.1751023550656;
 Fri, 27 Jun 2025 04:25:50 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:25 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-10-edumazet@google.com>
Subject: [PATCH net-next 09/10] ipv6: adopt skb_dst_dev() and
 skb_dst_dev_net[_rcu]() helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers as a step to deal with potential dst->dev races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index 1947530fb20ac17dcd6660703e3e94d584d5f688..ec53c127dae3eac223c85b8815853fca2e749fe7 100644
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
+		if (!ipv6_chk_home_addr(dev_net(skb_dst_dev(skb), addr)) {
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
index f0ce62549d90d6492b8ab139640cca91e4a9c2c7..89751e079dacd56afd28b0be06a16439fef2fa37 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -868,7 +868,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				 int oif, int rst, u8 tclass, __be32 label,
 				 u32 priority, u32 txhash, struct tcp_key *key)
 {
-	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 	unsigned int tot_len = sizeof(struct tcphdr);
 	struct sock *ctl_sk = net->ipv6.tcp_sk;
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -1043,7 +1043,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
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


