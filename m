Return-Path: <netdev+bounces-233405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A22C12C5E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB4E1AA693B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED8227FD52;
	Tue, 28 Oct 2025 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kBz293d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450C27F016
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622711; cv=none; b=HGPiWcRSSD7sYZCsv4Br5f6UCNUa28AUPDNLRQW829ccFgPnD76UiKBluF3hzjgVIdYFfiF6Z/LhvCihX55+Hv47THHf7XGaGfLX2cac7qYuKO7W5DM9FqqQqNWLQtULSt2LaR6L4ojMleBa6Amj/dQ/wlmR5Cm5qTgVFtB6lhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622711; c=relaxed/simple;
	bh=Pz5NYjddXGOh8bODshERb95cDtRpTp5vqnKLKYVgQDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hon/ApMmpXHMMTIqvxsr4BQLs0CFvKepWLHarc1ouiZQATyTgDsDB5PCTisi6DCIq4tkxNBeVriE2CmRuFlZQCehm5jg+SxvQb5Sr9XQlSBAPJjoIS9gm7mRwt6xDsmyb9OWWszN5HaYsZ9Po5ymU/4JVr+QjxtwPuyyF/vQId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kBz293d; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a153ba0009so10290325b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622709; x=1762227509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2b+fMW7W+vRk6MrbC8tJmvxBGYiPiAeT1CSlj9tT7Q=;
        b=3kBz293dcZR8g34QmEld1w89qAZm5LrJwVGYZPnP8rMJcq8moaUHS0g45ah9h53PZ7
         Axm36qY9C1kBMzCG2GznoK+1QsN5JBUtBWLUJ1BPdgJywxxOZppb1zI7T4lBMdyFcdlF
         Dcq9ahyFAi+DLPr9XdMmF/AwvnY5oCGesGJI45n2M3rhmmsOFpWNGKadccyVo2Xdwacr
         ugU+oQmBysMC5QG5BsdC9YdyP5iasvoIo2E5L48M/4zIpAFqJehKw2ntKLcSJLEtbSez
         ESAsbEAgsEcmtPUIiEDJfDbVVF6aUCfJE2HaVUsul81pEWAxcPmPRZK+yXvpJ7SkyPtZ
         OBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622709; x=1762227509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2b+fMW7W+vRk6MrbC8tJmvxBGYiPiAeT1CSlj9tT7Q=;
        b=NHL8JDbYlbZijfMgrihMzfhGPLyLRMULpKoQX8NwNUxAhqoc4W+IgC0/hG9TK0lfBx
         fMT+Rg4bh57X1n34/sF6I5p0ZhcGuuRFaBC4rr5xTShUmolp2VlEHaslLMczFfpZe0+3
         Q4I+c9oPhdL1INOyqjGGNq2epVdqAs4xrKoO3+I/jgl+RBC7TTa5ahszLmrIrtFlMrfb
         Dy3sqsHy9d3pyewT0CQ6XbvbRwgd/4Fb+cw8cEd36FnGwplnHrCWgZ0GVcpE8I6cxqXe
         xptyG9d7y7lzOxm69/JYPmCVgs+mX3BsOMJI/bZyk/rODeSwimwU5RDXRGR/gyh1dg9V
         dmig==
X-Forwarded-Encrypted: i=1; AJvYcCUArUOoi6VVFBGqODdWTmIHVuhGBjBOD8IevGxbAAhzqo15kZtKNM49AdBACy2pEIMFXdzGxPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL645RJWgb/zioU+QlT/y2aiiv+FHRk55su0nh9W/O0VeZD9+w
	js4WS/1bhxNZ3fh+XisH2ckX/KLUHObHotNsG+s/1tw6IJfSmhPbmL2rbYaW84WLz6fs32vb3A1
	VkXG3/g==
X-Google-Smtp-Source: AGHT+IEW+BI0GZawDzWjfhxKZAnSvtgcV7i0V32g7ihkKuzgQBeDrcDD8f/oCQkion9BFzFPmNxb9GwkIOo=
X-Received: from pfme14.prod.google.com ([2002:aa7:98ce:0:b0:77f:352f:809])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b41:b0:771:fdd9:efa0
 with SMTP id d2e1a72fcca58-7a441c1d8b8mr2779594b3a.15.1761622709478; Mon, 27
 Oct 2025 20:38:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:36:57 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/13] mpls: Hold dev refcnt for mpls_nh.
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
2.51.1.838.g19442a804e-goog


