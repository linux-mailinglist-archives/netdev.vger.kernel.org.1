Return-Path: <netdev+bounces-234097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD039C1C753
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B21734B9C0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB5350D7B;
	Wed, 29 Oct 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veemnVST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F65350A2F
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759232; cv=none; b=kec605Ed9thik7E540/vH2Re81Rku2yjruA3kY06p9XvJ/gIyl7wheKK+NPcPSaNJRtzUiick98MkSGttWdJn9WMUe0eJdc6NzWA/o3BwDQ3rDRYhxNL6qE6sXELB2l5+rG3A1SB+U9G026/soYuf1MpxPyZTPBBUCxt2G7uD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759232; c=relaxed/simple;
	bh=x7ltIQ8Omk+5+1MfGxjWC3Bi9tBks+zT6pQN4+T8ZgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lb8oJHZmyEcfnIFpZ/Eez2Bqza+z1vKIxVI4K8LTtTlhRhZYVVMftabyVB/IgN9GuG0h9QpqiA3cw3VsH4/xk5myRlTAd0rZBgTs57kDvptJGjhqjJAIXQ7y3UXy7BPO2eY6wjEuoEnz3z8aZbQygME3sr4uoYIKof766mJoLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veemnVST; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so12193a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759230; x=1762364030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrd3bvjmxIwag6MAPMWHZLoucra+ZHWnpPD7Sj5dK6w=;
        b=veemnVST1V+nydGK3Li9glH9PZGeFjWOKo5f9kbnjnn5ddxXLb9372SdeZyNkPmqJJ
         Hd/OSuYp7uF8q2DJ70y7ml7OxSRhJUNyErNe0wKFWoPBsZTNxFUyKep1eJ3dj3w4DAz/
         /eHi0kJxJwdKuhZKoqs2Z7xtJVsB9bwDpoTP7MrsEoUOfzl2MSLNZiw3oI7imddd9E4W
         8gMw61THwGifrWkHoijC6VTf1Rzs1NkIYWysr78fM+y12w3LbGxjgwPKZGoK/Qq3lF8r
         sgPtK2i1hWYzt8AqTDTiwnFwv5GEv5V5X1Ig2Xeez3vd+87hFrGsmeoLMfOcKe2tU5na
         LD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759230; x=1762364030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrd3bvjmxIwag6MAPMWHZLoucra+ZHWnpPD7Sj5dK6w=;
        b=XqdH2VTTXK8lBXo/QN0Hg/4FmWRw/drneszBrwpZA9aH0wMCHqSAPt9zssVeo0V+Ke
         OIJDWWf5vT2Z2i51k6/sEJNdLjgZJIqqV+h+pr25Ck2qupFxJcGiHu9tzvDhlo4o4mBj
         uRFLeFCAufzi0S70i/UuReGJcBbgVUpt5bWfqrc3S3dOA9Ogua1rROMYTjL3NzWQbh1M
         y19E4p4Pb3myKu/C2NYhsFHfMyZxWJslGYN2n7Lwn9oWIypQ0YIQw58AscPX3Nm45/gy
         QmsHry7rNnCApdf112eHuw5vVytrfJYuXqRrQ4YoqItRfCJLeQPh4HHxr3MKOMv6cisQ
         vc8g==
X-Forwarded-Encrypted: i=1; AJvYcCX0O+vAZqp1gpUnBIJGyB1FopkzHG+95vkVhzm1qhczYEgSuVWup/UK6e9AIrciX7/dkTqpHZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQErH1H1Q0treyGkgP3HPPbswUXMQZpzhcpxI0kB5+RM4r3mv
	Cy5heva7ZNlWS4+ksHTuaWxshVT8dmHTeAYDAXIybKIRvrzoVWht9idFP/pshXpTDCIdbsqKqmW
	S7/2Hvw==
X-Google-Smtp-Source: AGHT+IGWLcr7XZUThYUiqWShRtzvmFhBHfvpn+rPDJ3HHKAMghTGFehtFInoB7sxupGGKyXL6As3nFMUg84=
X-Received: from plas7.prod.google.com ([2002:a17:903:2007:b0:292:5d48:6269])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b70d:b0:25c:46cd:1dc1
 with SMTP id d9443c01a7336-294edc5b736mr1155345ad.33.1761759230107; Wed, 29
 Oct 2025 10:33:50 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:54 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/13] mpls: Hold dev refcnt for mpls_nh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MPLS uses RTNL

  1) to guarantee the lifetime of struct mpls_nh.nh_dev
  2) to protect net->mpls.platform_label

, but neither actually requires RTNL.

If we do not call dev_put() in find_outdev() and call it
just before freeing struct mpls_route, we can drop RTNL for 1).

Let's hold the refcnt of mpls_nh.nh_dev and track it with
netdevice_tracker.

Two notable changes:

If mpls_nh_build_multi() fails to set up a neighbour, we need
to call netdev_put() for successfully created neighbours in
mpls_rt_free_rcu(), so the number of neighbours (rt->rt_nhn)
is now updated in each iteration.

When a dev is unregistered, mpls_ifdown() clones mpls_route
and replaces it with the clone, so the clone requires extra
netdev_hold().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c  | 63 +++++++++++++++++++++++++++++++--------------
 net/mpls/internal.h |  1 +
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index e3533d85d372..e7be87466809 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -530,10 +530,23 @@ static struct mpls_route *mpls_rt_alloc(u8 num_nh, u8 max_alen, u8 max_labels)
 	return rt;
 }
 
+static void mpls_rt_free_rcu(struct rcu_head *head)
+{
+	struct mpls_route *rt;
+
+	rt = container_of(head, struct mpls_route, rt_rcu);
+
+	change_nexthops(rt) {
+		netdev_put(nh->nh_dev, &nh->nh_dev_tracker);
+	} endfor_nexthops(rt);
+
+	kfree(rt);
+}
+
 static void mpls_rt_free(struct mpls_route *rt)
 {
 	if (rt)
-		kfree_rcu(rt, rt_rcu);
+		call_rcu(&rt->rt_rcu, mpls_rt_free_rcu);
 }
 
 static void mpls_notify_route(struct net *net, unsigned index,
@@ -587,6 +600,7 @@ static unsigned find_free_label(struct net *net)
 
 #if IS_ENABLED(CONFIG_INET)
 static struct net_device *inet_fib_lookup_dev(struct net *net,
+					      struct mpls_nh *nh,
 					      const void *addr)
 {
 	struct net_device *dev;
@@ -599,14 +613,14 @@ static struct net_device *inet_fib_lookup_dev(struct net *net,
 		return ERR_CAST(rt);
 
 	dev = rt->dst.dev;
-	dev_hold(dev);
-
+	netdev_hold(dev, &nh->nh_dev_tracker, GFP_KERNEL);
 	ip_rt_put(rt);
 
 	return dev;
 }
 #else
 static struct net_device *inet_fib_lookup_dev(struct net *net,
+					      struct mpls_nh *nh,
 					      const void *addr)
 {
 	return ERR_PTR(-EAFNOSUPPORT);
@@ -615,6 +629,7 @@ static struct net_device *inet_fib_lookup_dev(struct net *net,
 
 #if IS_ENABLED(CONFIG_IPV6)
 static struct net_device *inet6_fib_lookup_dev(struct net *net,
+					       struct mpls_nh *nh,
 					       const void *addr)
 {
 	struct net_device *dev;
@@ -631,13 +646,14 @@ static struct net_device *inet6_fib_lookup_dev(struct net *net,
 		return ERR_CAST(dst);
 
 	dev = dst->dev;
-	dev_hold(dev);
+	netdev_hold(dev, &nh->nh_dev_tracker, GFP_KERNEL);
 	dst_release(dst);
 
 	return dev;
 }
 #else
 static struct net_device *inet6_fib_lookup_dev(struct net *net,
+					       struct mpls_nh *nh,
 					       const void *addr)
 {
 	return ERR_PTR(-EAFNOSUPPORT);
@@ -653,16 +669,17 @@ static struct net_device *find_outdev(struct net *net,
 	if (!oif) {
 		switch (nh->nh_via_table) {
 		case NEIGH_ARP_TABLE:
-			dev = inet_fib_lookup_dev(net, mpls_nh_via(rt, nh));
+			dev = inet_fib_lookup_dev(net, nh, mpls_nh_via(rt, nh));
 			break;
 		case NEIGH_ND_TABLE:
-			dev = inet6_fib_lookup_dev(net, mpls_nh_via(rt, nh));
+			dev = inet6_fib_lookup_dev(net, nh, mpls_nh_via(rt, nh));
 			break;
 		case NEIGH_LINK_TABLE:
 			break;
 		}
 	} else {
-		dev = dev_get_by_index(net, oif);
+		dev = netdev_get_by_index(net, oif,
+					  &nh->nh_dev_tracker, GFP_KERNEL);
 	}
 
 	if (!dev)
@@ -671,8 +688,7 @@ static struct net_device *find_outdev(struct net *net,
 	if (IS_ERR(dev))
 		return dev;
 
-	/* The caller is holding rtnl anyways, so release the dev reference */
-	dev_put(dev);
+	nh->nh_dev = dev;
 
 	return dev;
 }
@@ -686,20 +702,17 @@ static int mpls_nh_assign_dev(struct net *net, struct mpls_route *rt,
 	dev = find_outdev(net, rt, nh, oif);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
-		dev = NULL;
 		goto errout;
 	}
 
 	/* Ensure this is a supported device */
 	err = -EINVAL;
 	if (!mpls_dev_get(dev))
-		goto errout;
+		goto errout_put;
 
 	if ((nh->nh_via_table == NEIGH_LINK_TABLE) &&
 	    (dev->addr_len != nh->nh_via_alen))
-		goto errout;
-
-	nh->nh_dev = dev;
+		goto errout_put;
 
 	if (!(dev->flags & IFF_UP)) {
 		nh->nh_flags |= RTNH_F_DEAD;
@@ -713,6 +726,9 @@ static int mpls_nh_assign_dev(struct net *net, struct mpls_route *rt,
 
 	return 0;
 
+errout_put:
+	netdev_put(nh->nh_dev, &nh->nh_dev_tracker);
+	nh->nh_dev = NULL;
 errout:
 	return err;
 }
@@ -890,7 +906,8 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 	struct nlattr *nla_via, *nla_newdst;
 	int remaining = cfg->rc_mp_len;
 	int err = 0;
-	u8 nhs = 0;
+
+	rt->rt_nhn = 0;
 
 	change_nexthops(rt) {
 		int attrlen;
@@ -926,11 +943,9 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 			rt->rt_nhn_alive--;
 
 		rtnh = rtnh_next(rtnh, &remaining);
-		nhs++;
+		rt->rt_nhn++;
 	} endfor_nexthops(rt);
 
-	rt->rt_nhn = nhs;
-
 	return 0;
 
 errout:
@@ -1523,8 +1538,12 @@ static int mpls_ifdown(struct net_device *dev, int event)
 		change_nexthops(rt) {
 			unsigned int nh_flags = nh->nh_flags;
 
-			if (nh->nh_dev != dev)
+			if (nh->nh_dev != dev) {
+				if (nh_del)
+					netdev_hold(nh->nh_dev, &nh->nh_dev_tracker,
+						    GFP_KERNEL);
 				goto next;
+			}
 
 			switch (event) {
 			case NETDEV_DOWN:
@@ -2518,10 +2537,13 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	/* In case the predefined labels need to be populated */
 	if (limit > MPLS_LABEL_IPV4NULL) {
 		struct net_device *lo = net->loopback_dev;
+
 		rt0 = mpls_rt_alloc(1, lo->addr_len, 0);
 		if (IS_ERR(rt0))
 			goto nort0;
+
 		rt0->rt_nh->nh_dev = lo;
+		netdev_hold(lo, &rt0->rt_nh->nh_dev_tracker, GFP_KERNEL);
 		rt0->rt_protocol = RTPROT_KERNEL;
 		rt0->rt_payload_type = MPT_IPV4;
 		rt0->rt_ttl_propagate = MPLS_TTL_PROP_DEFAULT;
@@ -2532,10 +2554,13 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	}
 	if (limit > MPLS_LABEL_IPV6NULL) {
 		struct net_device *lo = net->loopback_dev;
+
 		rt2 = mpls_rt_alloc(1, lo->addr_len, 0);
 		if (IS_ERR(rt2))
 			goto nort2;
+
 		rt2->rt_nh->nh_dev = lo;
+		netdev_hold(lo, &rt2->rt_nh->nh_dev_tracker, GFP_KERNEL);
 		rt2->rt_protocol = RTPROT_KERNEL;
 		rt2->rt_payload_type = MPT_IPV6;
 		rt2->rt_ttl_propagate = MPLS_TTL_PROP_DEFAULT;
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index 83c629529b57..3a5feca27d6a 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -88,6 +88,7 @@ enum mpls_payload_type {
 
 struct mpls_nh { /* next hop label forwarding entry */
 	struct net_device	*nh_dev;
+	netdevice_tracker	nh_dev_tracker;
 
 	/* nh_flags is accessed under RCU in the packet path; it is
 	 * modified handling netdev events with rtnl lock held
-- 
2.51.1.851.g4ebd6896fd-goog


