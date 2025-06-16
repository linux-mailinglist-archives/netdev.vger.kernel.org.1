Return-Path: <netdev+bounces-198335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AFADBDB8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07059175D55
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713A23816E;
	Mon, 16 Jun 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOzFYdL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5D23770A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116892; cv=none; b=ck0y/OAAMnK9Q1sCahj51vIcfZmJiRLQilssV5d4g8AlnwOHT+nOjCkhgr8PtGA/3CCufOKWB+DVUnnQQ70uO6+iXgMIz+hwOxHnZ7pHPgor0QzI6GZyFFliHNe6WMzRBtO+99oN/3dJF8v4dmtBQYqN/DDmrnh+ucbpVe1f740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116892; c=relaxed/simple;
	bh=yYngAiHv8OKSL78lieW4JxBDaRyMu633p/3QTVlOvg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ2mlWGcJF7rk8pzsn/eLOdRycAq1Ynywn8YkK4KTyoQn7dTWpucAfi3pmYl49artTHqQ2Vjmw6/ZUsB3MrcU76HhnZl1RCxA3PeTxiwV5LdEGHb8uvjpR4SNSh/j3UfR4leosaGLpVPmUviA9Bspbl5IGq3drtVJPM2WMp7uOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOzFYdL3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138d31e40aso5061250a91.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116890; x=1750721690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FLbE/xPF5UFJSNc5H36cm10/de4DEDb2vR/++gWbEY=;
        b=cOzFYdL3WqbE4t8+0JeYf5DejLP/AV47n+w975TZcI3g7ZeLXIDV2tdxneYP9rt36j
         QrkAspOncXDNpc4SAB/6vCh0vD8xacRgxJm//64FX5fXX6rsyrN4jVm4Y+Faxq8GQtWT
         gKjGlRjTB4q2TFgSaU2Lw9sADUkchYKrENqgqcApRnhVP58xgJ6qrrnJwB07iZPuNx5R
         nOjLj4ZAJV6XoXUiqlW+V8IE9z7wQvU7/1EoRrGlkEHbnStNlxBDwWFHD8C+y4bckMjq
         fahcSNAY/DuvEvoL8tY9JdiSoUGRlnYNuQjWXjDNT7iJhE9AKby7eyfbQSNoejFiYEQo
         VBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116890; x=1750721690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FLbE/xPF5UFJSNc5H36cm10/de4DEDb2vR/++gWbEY=;
        b=aox4hzPmdCXLfzi+QwVw0O3Huie4++N2/UzO7c0jE9i0uEseL/iEiW4Y0kxmuS3PGo
         YJSEEv/TjjvbsR7YSLW3M0xl3Rd+IOnKaG+u0dEKlxBy5nm3ZVsEM1D97j8TFALxUZLQ
         toIZ4H8qd7/hhyKukZCQOwRCW1I48SIZzemP4Ua+JhUwVM6V/XabjvCIsAOflX3VSrrd
         2g61fInoVS3UD7ZOxMXiR1SYe4ssktOKpyKsLov0QORP4x71uCk3gi1LP7iseNXc8bma
         6y/IbQL4cEbRWfkqcQkN4ZAv86VVdCt7V0dCkophr3u2Z8N5hzhYlOERIMNNAGP3cXSf
         h1qg==
X-Forwarded-Encrypted: i=1; AJvYcCXuIqBUjIh1iflbKy9Rly+zhWoktZwMCLTpKE9F51pjrVSsIrKJORsvz1M6f8VHPgGd9J+nLYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MEUcPNjm7+jdoLtJ0NxtROk14AZS0jyL0IhnGoYdaywNtjY3
	+E0S6bsyxUzZlsvHUF4lpIooPE6oA5PxJPTqI0OUiape/hlsq71/sPE=
X-Gm-Gg: ASbGncuqOe7WE18JEqRUUzErX+AHIVtlWREIYTx3xtUJV1ozfZ0hMn24BH5MdQiT0Mi
	o6+VvJbikROKK37Te8qt31oaQy0j1CnHQ7g/I20ZYwtyjQ68tmbwYv4FwFdAojcWVzFGNqI6kx8
	qb7V4+O6lXshl78we7Ryku2wfwyXSgv9e0zog9dXH5XVM6A2j8zbSlBxpMT5zBE02Rd0fP/Ploh
	cfY8NFBvSRa9c51LHq2DMqlZ9cdyroaSBofea0QsEOzesPIkQgJbL6kIcni/MjPwUyB0c/v9rrn
	XcOf7RE1jl7MOdOhEgi9LSTx4yu4GsL72Fouhk5hZgBXV8v/SA==
X-Google-Smtp-Source: AGHT+IFAVaJYivBUTt48eMEIXSgRl77c+vUj5obLc2/ot66ksEnZy5Aklk3kCEwCPKwtMDsF4B+klg==
X-Received: by 2002:a17:90b:264b:b0:313:db0b:75e3 with SMTP id 98e67ed59e1d1-313f1e6f3fcmr18237821a91.35.1750116890040;
        Mon, 16 Jun 2025 16:34:50 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:49 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net-next 09/15] ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
Date: Mon, 16 Jun 2025 16:28:38 -0700
Message-ID: <20250616233417.1153427-10-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In ip6_mc_source() and ip6_mc_msfilter(), per-socket mld data is
protected by lock_sock() and inet6_dev->mc_lock is also held for
some per-interface functions.

ip6_mc_find_dev_rtnl() only depends on RTNL.  If we want to remove
it, we need to check inet6_dev->dead under mc_lock to close the race
with addrconf_ifdown(), as mentioned earlier.

Let's do that and drop RTNL for the rest of MCAST_ socket options.

Note that ip6_mc_msfilter() has unnecessary lock dances and they
are integrated into one to avoid the last-minute error and simplify
the error handling.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ipv6_sockglue.c |  5 ---
 net/ipv6/mcast.c         | 67 ++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index c8892d54821f..0c870713b08c 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -123,11 +123,6 @@ static bool setsockopt_needs_rtnl(int optname)
 	case IPV6_ADDRFORM:
 	case IPV6_JOIN_ANYCAST:
 	case IPV6_LEAVE_ANYCAST:
-	case MCAST_JOIN_SOURCE_GROUP:
-	case MCAST_LEAVE_SOURCE_GROUP:
-	case MCAST_BLOCK_SOURCE:
-	case MCAST_UNBLOCK_SOURCE:
-	case MCAST_MSFILTER:
 		return true;
 	}
 	return false;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 84c7ed23bc2d..fd0cab5066bb 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -300,31 +300,33 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 }
 EXPORT_SYMBOL(ipv6_sock_mc_drop);
 
-static struct inet6_dev *ip6_mc_find_dev_rtnl(struct net *net,
-					      const struct in6_addr *group,
-					      int ifindex)
+static struct inet6_dev *ip6_mc_find_dev(struct net *net,
+					 const struct in6_addr *group,
+					 int ifindex)
 {
 	struct net_device *dev = NULL;
-	struct inet6_dev *idev = NULL;
+	struct inet6_dev *idev;
 
 	if (ifindex == 0) {
 		struct rt6_info *rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
 
 		if (rt) {
 			dev = rt->dst.dev;
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
 	} else {
-		dev = __dev_get_by_index(net, ifindex);
+		dev = dev_get_by_index(net, ifindex);
 	}
-
 	if (!dev)
 		return NULL;
-	idev = __in6_dev_get(dev);
+
+	idev = in6_dev_get(dev);
+	dev_put(dev);
+
 	if (!idev)
 		return NULL;
-	if (idev->dead)
-		return NULL;
+
 	return idev;
 }
 
@@ -352,16 +354,16 @@ void ipv6_sock_mc_close(struct sock *sk)
 }
 
 int ip6_mc_source(int add, int omode, struct sock *sk,
-	struct group_source_req *pgsr)
+		  struct group_source_req *pgsr)
 {
+	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct in6_addr *source, *group;
+	struct net *net = sock_net(sk);
 	struct ipv6_mc_socklist *pmc;
-	struct inet6_dev *idev;
-	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct ip6_sf_socklist *psl;
-	struct net *net = sock_net(sk);
-	int i, j, rv;
+	struct inet6_dev *idev;
 	int leavegroup = 0;
+	int i, j, rv;
 	int err;
 
 	source = &((struct sockaddr_in6 *)&pgsr->gsr_source)->sin6_addr;
@@ -370,13 +372,19 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev_rtnl(net, group, pgsr->gsr_interface);
+	idev = ip6_mc_find_dev(net, group, pgsr->gsr_interface);
 	if (!idev)
 		return -ENODEV;
 
+	mutex_lock(&idev->mc_lock);
+
+	if (idev->dead) {
+		err = -ENODEV;
+		goto done;
+	}
+
 	err = -EADDRNOTAVAIL;
 
-	mutex_lock(&idev->mc_lock);
 	for_each_pmc_socklock(inet6, sk, pmc) {
 		if (pgsr->gsr_interface && pmc->ifindex != pgsr->gsr_interface)
 			continue;
@@ -473,6 +481,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	ip6_mc_add_src(idev, group, omode, 1, source, 1);
 done:
 	mutex_unlock(&idev->mc_lock);
+	in6_dev_put(idev);
 	if (leavegroup)
 		err = ipv6_sock_mc_drop(sk, pgsr->gsr_interface, group);
 	return err;
@@ -481,12 +490,12 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 		    struct sockaddr_storage *list)
 {
-	const struct in6_addr *group;
-	struct ipv6_mc_socklist *pmc;
-	struct inet6_dev *idev;
 	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct ip6_sf_socklist *newpsl, *psl;
 	struct net *net = sock_net(sk);
+	const struct in6_addr *group;
+	struct ipv6_mc_socklist *pmc;
+	struct inet6_dev *idev;
 	int leavegroup = 0;
 	int i, err;
 
@@ -498,10 +507,17 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	    gsf->gf_fmode != MCAST_EXCLUDE)
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev_rtnl(net, group, gsf->gf_interface);
+	idev = ip6_mc_find_dev(net, group, gsf->gf_interface);
 	if (!idev)
 		return -ENODEV;
 
+	mutex_lock(&idev->mc_lock);
+
+	if (idev->dead) {
+		err = -ENODEV;
+		goto done;
+	}
+
 	err = 0;
 
 	if (gsf->gf_fmode == MCAST_INCLUDE && gsf->gf_numsrc == 0) {
@@ -534,24 +550,19 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 			psin6 = (struct sockaddr_in6 *)list;
 			newpsl->sl_addr[i] = psin6->sin6_addr;
 		}
-		mutex_lock(&idev->mc_lock);
+
 		err = ip6_mc_add_src(idev, group, gsf->gf_fmode,
 				     newpsl->sl_count, newpsl->sl_addr, 0);
 		if (err) {
-			mutex_unlock(&idev->mc_lock);
 			sock_kfree_s(sk, newpsl, struct_size(newpsl, sl_addr,
 							     newpsl->sl_max));
 			goto done;
 		}
-		mutex_unlock(&idev->mc_lock);
 	} else {
 		newpsl = NULL;
-		mutex_lock(&idev->mc_lock);
 		ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
-		mutex_unlock(&idev->mc_lock);
 	}
 
-	mutex_lock(&idev->mc_lock);
 	psl = sock_dereference(pmc->sflist, sk);
 	if (psl) {
 		ip6_mc_del_src(idev, group, pmc->sfmode,
@@ -561,12 +572,14 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	} else {
 		ip6_mc_del_src(idev, group, pmc->sfmode, 0, NULL, 0);
 	}
+
 	rcu_assign_pointer(pmc->sflist, newpsl);
-	mutex_unlock(&idev->mc_lock);
 	kfree_rcu(psl, rcu);
 	pmc->sfmode = gsf->gf_fmode;
 	err = 0;
 done:
+	mutex_unlock(&idev->mc_lock);
+	in6_dev_put(idev);
 	if (leavegroup)
 		err = ipv6_sock_mc_drop(sk, gsf->gf_interface, group);
 	return err;
-- 
2.49.0


