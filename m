Return-Path: <netdev+bounces-200825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA4AE70AC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F2917EA6B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0D2EB5B8;
	Tue, 24 Jun 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQqB/6fF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD62E9EB4
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796799; cv=none; b=oxB5tJ9QEjZWHX5NJWTvNMi3tDEa5q/3BKkpAYmGf4wvvaxvRcVDOdKSxCRMPbbDe4Y3SwhOLnbzKO3g6ycWuSBgyVW0W2ZSRs8k+8PkqBsnjBDDXwrJG6TnUgx8lzNAzWsF1IHK6+2QF/w8kOkDPTulsWJ1ViSeyrIiiMgFfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796799; c=relaxed/simple;
	bh=0/SF3n0oIEMMQ74EZyKCARW3rvps5ZNziy2hQoXAIak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5o2ucY53mDOu1p2xwuCZJSdXVfOUKMQPVvbN3RUPFm4p1ICdRB9Mv9qu7sJqu5349rcRNKmjn3g9eZn8LspvlhO8yGExQ0O/xKhO/x9hED7kK9fEXFgTl0gFA4KP+pSI0JVEQmiEY2qVQJRyVJJYMotwhyCyYkYGzuU1UuWeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQqB/6fF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e92cso440584b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796797; x=1751401597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guIRyqO4Q6w9pfVb7AnXoNLhiQ/wfOMXUCBvp+i0shY=;
        b=fQqB/6fFVDu0ehnA2fB/uatJTvMT46yN7omjG14EgQfAu+6i/jK2Kntb2mlGzwDlQS
         KDW6Y/L5HX7vjQcQBgJ73BFsNfrperG0oEYeWgIsg0rbSOkICK6cjXRDH1OVGtCc9MJX
         eZmQIn3Iac9yqFrEYiQ70OdaODWJ01ksWjtqQ+JDMldqPAm9I8BzYeysl6bDzdzcVlrC
         oq1BIVRksdq//cZulVZNekmygKVkqI95XQfLnPIh3QvsPl3W6nrxK5BdhmdJjrcI1+xl
         m+gIx/DfGTVUcUGN37cqLpqu36NKCq1pK1GMNVW2xhdQZaeLXeQdsADvM/LUnh++6Sgu
         il0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796797; x=1751401597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guIRyqO4Q6w9pfVb7AnXoNLhiQ/wfOMXUCBvp+i0shY=;
        b=mz/7km6FDf7/uY1P5gzdvcJ68nClYZx+I3vE2quZKTAym9UxWz7xJk4NPEeQsOQ+Aq
         wsuRPq+hNisYaPQKOkM8g7mLI1iui/b+fdjKP1k5rsiYq7NYvX+AA2fbwmoI3y3gKDb2
         W2ajI41FlEyKd+4cmnKK7N7LR4cxmDXbYHjyWBc8iYUokUsdaWa1rYu4+B3PA9IXIjzt
         PVzqUA2JXijh8DARO8OU3xhGWkP5uml6YU4SA0MmO/YbFRtcveqTIwQcq6VdNjcjJ3Fw
         p94zQVa+89Fkaq903wpZ5kinYBFuYtzrqSSXu0Bl4SRiFmDC7smN6WKUO4n0FoCIinSo
         Ryiw==
X-Forwarded-Encrypted: i=1; AJvYcCVnULdXXdPpB+P7XP2HQzqn3/621tNFokOfchNfg9tTEvfI8JlT4MokWiEjbwA4g0zWgnA2l0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/br37pVxIneMWa6Ys/UG3SH9nc7X14G4Vz2leRvYFp1TSdYuq
	/Fmvxvr0O5PA4hDXbsg8h6VjyZJDD/VBmfJCySm6WdZ8hJ1xAJjktRM=
X-Gm-Gg: ASbGncvS8lhcIGs8Rng2+JmTl+UK13zTcyIaFW+HEJ5RKRv0EV0zpeEjEa9y2AcSbEv
	CwItdFEoRW3/Al0AHUNfa94xJ3oh8qB0tgHJUwboQN4eCD+6cgJnjOiXmFTjXam8sXOh0CWjXQd
	ikXK3BQzedNbFboOnpJh8CiDV5RRSjSPJZLQhRwsk4P1xgpAuEMPYl9DKFz98nl7zX+UluWyvcq
	s2yMULJmOVhwqqr9fJAuUQNtf/B8JYXqwXxfGWjjiTP3+Cw4O0pmVrJ21ErGayub0YQEhaQ5jAn
	Idd34jtZhVP7XLKqZeZaA7GMpuHPo8dGkGg6OOo=
X-Google-Smtp-Source: AGHT+IGmBjliAM6jlSckHtGuqBXq2R9UnwHPaWCA07UM961kvDzdtcvjKjDCzMm7OEz5kyipKC0dsg==
X-Received: by 2002:a05:6a21:700f:b0:21c:fea4:60e2 with SMTP id adf61e73a8af0-2207f14d8fbmr576847637.3.1750796797265;
        Tue, 24 Jun 2025 13:26:37 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:36 -0700 (PDT)
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
Subject: [PATCH v2 net-next 09/15] ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
Date: Tue, 24 Jun 2025 13:24:15 -0700
Message-ID: <20250624202616.526600-10-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
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
v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
---
 net/ipv6/ipv6_sockglue.c |  5 ---
 net/ipv6/mcast.c         | 72 ++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 33 deletions(-)

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
index e47d3fd7f789..af322a455346 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -302,31 +302,36 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
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
-		struct rt6_info *rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
+		struct rt6_info *rt;
 
+		rcu_read_lock();
+		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
 		if (rt) {
 			dev = rt->dst.dev;
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
+		rcu_read_unlock();
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
 
@@ -354,16 +359,16 @@ void ipv6_sock_mc_close(struct sock *sk)
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
@@ -372,13 +377,19 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
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
@@ -475,6 +486,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	ip6_mc_add_src(idev, group, omode, 1, source, 1);
 done:
 	mutex_unlock(&idev->mc_lock);
+	in6_dev_put(idev);
 	if (leavegroup)
 		err = ipv6_sock_mc_drop(sk, pgsr->gsr_interface, group);
 	return err;
@@ -483,12 +495,12 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
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
 
@@ -500,10 +512,17 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
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
@@ -536,24 +555,19 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
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
@@ -563,12 +577,14 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
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


