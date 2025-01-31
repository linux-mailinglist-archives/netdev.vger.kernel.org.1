Return-Path: <netdev+bounces-161799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58640A241AB
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F31884E0A
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74B1F1533;
	Fri, 31 Jan 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fg/pTk7C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E071F03DB
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343632; cv=none; b=oq2+0CPzYbCV7nvf2stvQEIDhUEIG5r7Aiy1Z2J+03h5z+GXgZ9RApJQfb3xGZJNJH7rcfRDVP9Zsug0X6LDaCHsY1wnhZ1vpqTN0XfUDm5WNYw4YVJF29TXOTFz6DvcVdXrSWaF4VplpGaf9Tit1g6txr1S905uynegWN9PLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343632; c=relaxed/simple;
	bh=Su71tS1t839pW0Qia6o4NdX50LNBz+q3aZFDeHWJyAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WJsbLSabG54PFK4FWV7d83kVA6gHV4SlPwKRr38coFbzWjqHt3QrKoUe3qvRn8/Lx3NWdigwFq14hC++JZD0Y/2TSudSgUBPfxU6N0yDXSypdiqICEmUBu1PkuHP58cIGAWc8OJUSQmX62bgQSbLO8bhuJh/3iHN+Y2FvpcYRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fg/pTk7C; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6e6cf6742so579279885a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343629; x=1738948429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZJPGFPK8A4N2BlEnxm50TTESOqK4C81A5N3OIT+bEs=;
        b=fg/pTk7C85uyYjIk+qnpjoIb2j/Cg4xJIdFBWDtNgns5ey/ad6uocDjpDubmpxDLx9
         spu/rP8c3fHo/BW4MNZsU0bKBh9fZpyc9I7sUIuL3n7m1WGlVpTFvjD62TYEOA9MQCyY
         c6ybwbpYewVqmis2bhwb0PYLSqx1A6dlSVfXFgH8dcCTf58Hw2n/HxpDWJ5XryLSqOQX
         0VuVaXg0gD7DbniJuPTTRhsn6JzIBvZ/kZy2/tNQ0rzgLyI4OdiCeuRjOtMANhcupOfs
         7gVnOnz3jJZwgsPmw0JLbCwheGdwOZIP73jj49PGMuNQcfTGbQNQe8Bmz2O/ICBUvsW9
         UfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343629; x=1738948429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZJPGFPK8A4N2BlEnxm50TTESOqK4C81A5N3OIT+bEs=;
        b=ma3iNeSQLvGdlkhMN8c2RurC3FJm7w6OBQZhDZiIIQU5op9OwDX32817Pl+ZDU2emC
         G50Nf7BxRxNIvnxhhqTS/AR7s7sofLNZQcvYdS5EXXi+8Q5bUbOWted/pEpdGNOcwu54
         VE/IReorEzziQt94ds4fTGPpkqW9dpqfZ+5CsPGWxAOL4T/VPW9LTu0OG6UDJwwl/Cv3
         edDNfWCx97zFl12Bj0fpx3SMYicuLc9fOtqUj9tbPz5504mrB11I8sGo56F3PmGKSu+L
         f/2XuIlw6cz4lCadNwzEuZYL+OXhsDam4xOZmUKuzVtVUFfHCSVDrneEGh1lb+WWvUKp
         Yo6Q==
X-Gm-Message-State: AOJu0Yzp0FWOFjM15kX76DTTUmhoXRuN2nboEmqr3v49oAewLYoPqp6e
	kbe49O2FwxnwYu/1qCWnha9ZqkHYMAlFd6+maX1r6nwAC6LcdFe1vzK/tJcNItF7R62LXTiGjeI
	o3bXRYTVJ6g==
X-Google-Smtp-Source: AGHT+IExuckDKdMUBWqVytUXNSvFnpKdz64zrs202tVn+3vn8+BO4WwzTr8y86XnzJbKiWqbWiL2kMpoXubtPQ==
X-Received: from qkpc11.prod.google.com ([2002:a05:620a:268b:b0:7b6:ee83:e490])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1727:b0:7b6:c90e:e227 with SMTP id af79cd13be357-7bffccdfa77mr1645000185a.20.1738343629496;
 Fri, 31 Jan 2025 09:13:49 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:26 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-9-edumazet@google.com>
Subject: [PATCH net 08/16] udp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP uses of dev_net() are safe, change them to dev_net_rcu()
to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 19 ++++++++++---------
 net/ipv6/udp.c | 18 +++++++++---------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c472c9a57cf68880a277603b4a771152c6f79ff6..54912b31f57ce340dbaffc3e80719140f4e85ecd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -750,7 +750,7 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 {
 	const struct iphdr *iph = ip_hdr(skb);
 
-	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
+	return __udp4_lib_lookup(dev_net_rcu(skb->dev), iph->saddr, sport,
 				 iph->daddr, dport, inet_iif(skb),
 				 inet_sdif(skb), udptable, skb);
 }
@@ -760,7 +760,7 @@ struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int iif, sdif;
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
@@ -934,13 +934,13 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 	struct inet_sock *inet;
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
 	struct udphdr *uh = (struct udphdr *)(skb->data+(iph->ihl<<2));
+	struct net *net = dev_net_rcu(skb->dev);
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
 	bool tunnel = false;
 	struct sock *sk;
 	int harderr;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
 			       iph->saddr, uh->source, skb->dev->ifindex,
@@ -1025,7 +1025,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
 int udp_err(struct sk_buff *skb, u32 info)
 {
-	return __udp4_lib_err(skb, info, dev_net(skb->dev)->ipv4.udp_table);
+	return __udp4_lib_err(skb, info, dev_net_rcu(skb->dev)->ipv4.udp_table);
 }
 
 /*
@@ -2466,7 +2466,7 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		udp_post_segment_fix_csum(skb);
 		ret = udp_queue_rcv_one_skb(sk, skb);
 		if (ret > 0)
-			ip_protocol_deliver_rcu(dev_net(skb->dev), skb, ret);
+			ip_protocol_deliver_rcu(dev_net_rcu(skb->dev), skb, ret);
 	}
 	return 0;
 }
@@ -2632,12 +2632,12 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
+	struct net *net = dev_net_rcu(skb->dev);
+	struct rtable *rt = skb_rtable(skb);
 	struct sock *sk = NULL;
 	struct udphdr *uh;
 	unsigned short ulen;
-	struct rtable *rt = skb_rtable(skb);
 	__be32 saddr, daddr;
-	struct net *net = dev_net(skb->dev);
 	bool refcounted;
 	int drop_reason;
 
@@ -2804,7 +2804,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 
 int udp_v4_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct in_device *in_dev = NULL;
 	const struct iphdr *iph;
 	const struct udphdr *uh;
@@ -2873,7 +2873,8 @@ int udp_v4_early_demux(struct sk_buff *skb)
 
 int udp_rcv(struct sk_buff *skb)
 {
-	return __udp4_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
+	return __udp4_lib_rcv(skb, dev_net_rcu(skb->dev)->ipv4.udp_table,
+			      IPPROTO_UDP);
 }
 
 void udp_destroy_sock(struct sock *sk)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6671daa67f4fab28f847bd4d8475ef752a63f05d..1972a0f9c9c39c8b311d536a60fa7d6e79f74c29 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -410,7 +410,7 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 
-	return __udp6_lib_lookup(dev_net(skb->dev), &iph->saddr, sport,
+	return __udp6_lib_lookup(dev_net_rcu(skb->dev), &iph->saddr, sport,
 				 &iph->daddr, dport, inet6_iif(skb),
 				 inet6_sdif(skb), udptable, skb);
 }
@@ -420,7 +420,7 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int iif, sdif;
 
 	inet6_get_iif_sdif(skb, &iif, &sdif);
@@ -702,16 +702,16 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		   u8 type, u8 code, int offset, __be32 info,
 		   struct udp_table *udptable)
 {
-	struct ipv6_pinfo *np;
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct in6_addr *saddr = &hdr->saddr;
 	const struct in6_addr *daddr = seg6_get_daddr(skb, opt) ? : &hdr->daddr;
 	struct udphdr *uh = (struct udphdr *)(skb->data+offset);
+	struct net *net = dev_net_rcu(skb->dev);
+	struct ipv6_pinfo *np;
 	bool tunnel = false;
 	struct sock *sk;
 	int harderr;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
 			       inet6_iif(skb), inet6_sdif(skb), udptable, NULL);
@@ -818,7 +818,7 @@ static __inline__ int udpv6_err(struct sk_buff *skb,
 				u8 code, int offset, __be32 info)
 {
 	return __udp6_lib_err(skb, opt, type, code, offset, info,
-			      dev_net(skb->dev)->ipv4.udp_table);
+			      dev_net_rcu(skb->dev)->ipv4.udp_table);
 }
 
 static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
@@ -929,7 +929,7 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		udp_post_segment_fix_csum(skb);
 		ret = udpv6_queue_rcv_one_skb(sk, skb);
 		if (ret > 0)
-			ip6_protocol_deliver_rcu(dev_net(skb->dev), skb, ret,
+			ip6_protocol_deliver_rcu(dev_net_rcu(skb->dev), skb, ret,
 						 true);
 	}
 	return 0;
@@ -1072,7 +1072,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sock *sk = NULL;
 	struct udphdr *uh;
 	bool refcounted;
@@ -1220,7 +1220,7 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
 
 void udp_v6_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct udphdr *uh;
 	struct sock *sk;
 	struct dst_entry *dst;
@@ -1262,7 +1262,7 @@ void udp_v6_early_demux(struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 {
-	return __udp6_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
+	return __udp6_lib_rcv(skb, dev_net_rcu(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
 }
 
 /*
-- 
2.48.1.362.g079036d154-goog


