Return-Path: <netdev+bounces-131011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF2498C60A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4939BB21D2A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7451CDA12;
	Tue,  1 Oct 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6owxyXV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB461CDA0E
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810972; cv=none; b=WG+ZbE1c3B8aA9PdXBYQXCcXiu9wmL1vLHRQ3Xr2bYwWcKObUgmju+yp6H4XYHNB32lIU4lrQd8vRDi3c+jyiAfesqI2L+4Kl4V9MPu8SJbKC5uBJLGZohTX7IRmfqH9OgrCRmkt/uCxguR4l5k38FAGfjA1ykfNW/EZW0Xuukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810972; c=relaxed/simple;
	bh=hSw+93w3Fj9oy/ZX89Ko8Yg0Vd4Hq9fxS/Hq7Q8zphg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBr3tgbUD5bqZMmOYweNVwqzJjm+5E8A02C/LlVYWlK8LaGOMkmXCU8dQV1lzH7zvp8/SehwbvO/UqDTwmwwUM7AALDdqNwcGEu9KjNhkzbDtTAkA9+iXsK3uQI+uacVBj3XWgC0ZPtw80QlHyLYBTs4hX3uhnpidhPCTjazZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6owxyXV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0cOw8V7kfpFsFykV7cij29Zj7Dz1qG6ze+YIlFK/6k=;
	b=M6owxyXVy0nvPnjQLkUxyfkP8ZNz2NSu8FufllciOJsKRpqdwS8KsS8u33qmLIS7P0ztgn
	ZnA5E91rfBtryNAnT3kbS4m0lJJz8zO7UE67Yvbtr5oiApuOl/jw4W7R/cPjWeLyn7kw89
	ZXPioL2AZ9rg7+jEq5DxIIVm+76mzzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-2GblzXogNpW92hCduuodmg-1; Tue, 01 Oct 2024 15:28:57 -0400
X-MC-Unique: 2GblzXogNpW92hCduuodmg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so489565e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 12:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810932; x=1728415732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0cOw8V7kfpFsFykV7cij29Zj7Dz1qG6ze+YIlFK/6k=;
        b=KH9k3nDPcoxxjubQ5Hhn4TJdNu/nAyE227D6gXMYjtOK5T4RZ/SeFw8xZ3cKsAqUVj
         WE94dDU7FCL7SqadPh1Z4V/gGZxZMMR0tuAc6LeuonPt6mSBpTwr9PYLOayr4pti7lE5
         kg+gYCDMkKeSwTYEoow0z9P1GbUc3FfXJMAjLeu7hUeYySlcn7/eVhNjdcm+ky9a8AvK
         gnrlFbxlOYuO/JL5WVJLv4YkUocke+Z4gmaTCP1NgNpBusz4zsOqRz9eGmyMgYdpwyN6
         qr5T8Oi9KdFFT/4y2xPXkyTuxkmEbDiWoucZBq6rQXh230nxCCFy35eonRQiHn7KeNaS
         znYw==
X-Gm-Message-State: AOJu0YwlYH42K/kIOFmO+SAqVRneTcgdBgzis5k4OEVL2q02p0h7fPmw
	cay9eHlgdFHGTDVsSSv74hJBfM6sluU5siyXVyx0nDmwMmJs9ASu/udqupb7oFJVHYFQpz7TJNY
	8Grkix62zdKWCpKJrnbaJ4T/78FJGaZ+UZgBRNL+R6vcO1IwO4qarRg==
X-Received: by 2002:a05:600c:c11:b0:42c:ba81:117c with SMTP id 5b1f17b1804b1-42f776dfabfmr4191865e9.6.1727810932367;
        Tue, 01 Oct 2024 12:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOie0bGOglplFLNnsPS4f+J346loIxXphx9UwSm5oGJlIatkgBve7KcDdVeL0DZ7vjeNzKxg==
X-Received: by 2002:a05:600c:c11:b0:42c:ba81:117c with SMTP id 5b1f17b1804b1-42f776dfabfmr4191745e9.6.1727810931944;
        Tue, 01 Oct 2024 12:28:51 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddfc9sm188700575e9.5.2024.10.01.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:28:51 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:28:49 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH net-next 3/5] ipv4: Convert ip_route_input_noref() to dscp_t.
Message-ID: <a8a747bed452519c4d0cc06af32c7e7795d7b627.1727807926.git.gnault@redhat.com>
References: <cover.1727807926.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727807926.git.gnault@redhat.com>

Pass a dscp_t variable to ip_route_input_noref(), instead of a plain
u8, to prevent accidental setting of ECN bits in ->flowi4_tos.

Callers of ip_route_input_noref() to consider are:

  * arp_process() in net/ipv4/arp.c. This function sets the tos
    parameter to 0, which is already a valid dscp_t value, so it
    doesn't need to be adjusted for the new prototype.

  * ip_route_input(), which already has a dscp_t variable to pass as
    parameter. We just need to remove the inet_dscp_to_dsfield()
    conversion.

  * ipvlan_l3_rcv(), bpf_lwt_input_reroute(), ip_expire(),
    ip_rcv_finish_core(), xfrm4_rcv_encap_finish() and
    xfrm4_rcv_encap(), which get the DSCP directly from IPv4 headers
    and can simply use the ip4h_dscp() helper.

While there, declare the IPv4 header pointers as const in
ipvlan_l3_rcv() and bpf_lwt_input_reroute().
Also, modify the declaration of ip_route_input_noref() in
include/net/route.h so that it matches the prototype of its
implementation in net/ipv4/route.c.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/ipvlan/ipvlan_l3s.c | 6 ++++--
 include/net/route.h             | 7 +++----
 net/core/lwt_bpf.c              | 5 +++--
 net/ipv4/ip_fragment.c          | 4 ++--
 net/ipv4/ip_input.c             | 2 +-
 net/ipv4/route.c                | 6 +++---
 net/ipv4/xfrm4_input.c          | 2 +-
 net/ipv4/xfrm4_protocol.c       | 2 +-
 8 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index d5b05e803219..b4ef386bdb1b 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2014 Mahesh Bandewar <maheshb@google.com>
  */
 
+#include <net/ip.h>
+
 #include "ipvlan.h"
 
 static unsigned int ipvlan_netid __read_mostly;
@@ -48,11 +50,11 @@ static struct sk_buff *ipvlan_l3_rcv(struct net_device *dev,
 	switch (proto) {
 	case AF_INET:
 	{
-		struct iphdr *ip4h = ip_hdr(skb);
+		const struct iphdr *ip4h = ip_hdr(skb);
 		int err;
 
 		err = ip_route_input_noref(skb, ip4h->daddr, ip4h->saddr,
-					   ip4h->tos, sdev);
+					   ip4h_dscp(ip4h), sdev);
 		if (unlikely(err))
 			goto out;
 		break;
diff --git a/include/net/route.h b/include/net/route.h
index 03dd28cf4bc4..5e4374d66927 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -201,8 +201,8 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  u8 tos, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag);
-int ip_route_input_noref(struct sk_buff *skb, __be32 dst, __be32 src,
-			 u8 tos, struct net_device *devin);
+int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+			 dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      u8 tos, struct net_device *devin,
 		      const struct sk_buff *hint);
@@ -213,8 +213,7 @@ static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, inet_dscp_to_dsfield(dscp),
-				   devin);
+	err = ip_route_input_noref(skb, dst, src, dscp, devin);
 	if (!err) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 1a14f915b7a4..e0ca24a58810 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -10,6 +10,7 @@
 #include <linux/bpf.h>
 #include <net/lwtunnel.h>
 #include <net/gre.h>
+#include <net/ip.h>
 #include <net/ip6_route.h>
 #include <net/ipv6_stubs.h>
 #include <net/inet_dscp.h>
@@ -91,12 +92,12 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		struct net_device *dev = skb_dst(skb)->dev;
-		struct iphdr *iph = ip_hdr(skb);
+		const struct iphdr *iph = ip_hdr(skb);
 
 		dev_hold(dev);
 		skb_dst_drop(skb);
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   iph->tos, dev);
+					   ip4h_dscp(iph), dev);
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a92664a5ef2e..48e2810f1f27 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -175,8 +175,8 @@ static void ip_expire(struct timer_list *t)
 
 	/* skb has no dst, perform route lookup again */
 	iph = ip_hdr(head);
-	err = ip_route_input_noref(head, iph->daddr, iph->saddr,
-					   iph->tos, head->dev);
+	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
+				   head->dev);
 	if (err)
 		goto out;
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index b6e7d4921309..c0a2490eb7c1 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -363,7 +363,7 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	 */
 	if (!skb_valid_dst(skb)) {
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   iph->tos, dev);
+					   ip4h_dscp(iph), dev);
 		if (unlikely(err))
 			goto drop_error;
 	} else {
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 723ac9181558..00bfc0a11f64 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2465,14 +2465,14 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 u8 tos, struct net_device *dev)
+			 dscp_t dscp, struct net_device *dev)
 {
 	struct fib_result res;
 	int err;
 
-	tos &= INET_DSCP_MASK;
 	rcu_read_lock();
-	err = ip_route_input_rcu(skb, daddr, saddr, tos, dev, &res);
+	err = ip_route_input_rcu(skb, daddr, saddr, inet_dscp_to_dsfield(dscp),
+				 dev, &res);
 	rcu_read_unlock();
 
 	return err;
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index a620618cc568..b5b06323cfd9 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -33,7 +33,7 @@ static inline int xfrm4_rcv_encap_finish(struct net *net, struct sock *sk,
 		const struct iphdr *iph = ip_hdr(skb);
 
 		if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					 iph->tos, skb->dev))
+					 ip4h_dscp(iph), skb->dev))
 			goto drop;
 	}
 
diff --git a/net/ipv4/xfrm4_protocol.c b/net/ipv4/xfrm4_protocol.c
index b146ce88c5d0..4ee624d8e66f 100644
--- a/net/ipv4/xfrm4_protocol.c
+++ b/net/ipv4/xfrm4_protocol.c
@@ -76,7 +76,7 @@ int xfrm4_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 		const struct iphdr *iph = ip_hdr(skb);
 
 		if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					 iph->tos, skb->dev))
+					 ip4h_dscp(iph), skb->dev))
 			goto drop;
 	}
 
-- 
2.39.2


