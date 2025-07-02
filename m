Return-Path: <netdev+bounces-203559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B747AF65C7
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212C7484C21
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198342E7BA5;
	Wed,  2 Jul 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSBLtfEl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC52F19A9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497348; cv=none; b=L0tW/rs60p4JGUvwaf8yqz0vh8N1vywfGeKYyExfU1n36KU5PElJjKV0mVSIkF7Q2Kx9nKvsBCHqAs+8hmHnpx2BEsaqve2EHLdoLhfgJSAmPzVeBjiPLCxedFktXZ70kvyqI62DOUSxwhkFSzzF3O87kaaJExzNpJXG3MuysWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497348; c=relaxed/simple;
	bh=BeppIfCZxWuYVFU0BfcEvzKBfKx4kvmGCXkhsNhj9aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifXM43gvEFQBpGcjT1/EdUIy79fBus9rmsMkajprPAw+/XyL1x9xaNKuQVcvOtK16LVxpDawRIQwrErl9FSVF52pgJMTwuYayZSUtciEZZ3mxv0RujyZjFVdeHXkLiwnes6G4hizwmEDSd0wh3WWrgS0i9KwdfmwOGzHtggL53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSBLtfEl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3226307787so3792492a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497346; x=1752102146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAxLtiX9Mi4W/QN8E5YVNXw0M1nbRaXSc0QJsUUP62c=;
        b=BSBLtfElJscX9mywOuuvrw3YBcDB+JYOArYjh1nyYCIYOGXkjEn5bpBH++hsibva+6
         /5I6Y6DbFW7BHZfOa/9CbzqNHCuyERvm0utkn14hA45N2HnnOuxBdlwbX3V3D+N5Ut7s
         s65eOj7QzhgJdh+V9D6t1ViZcUt1SM3FDIYMygBxN6W9fadOByJwF8lOzUR45lQY9LY8
         yMyWXAhfLR+WyzAjM5UjwcnlXKaqacxqeKbXaCi9xnSdc6YrVY1tEE7BSOoH50w+I411
         GMMm+owsMOg8aNjrbfXExdi6sBuru6Jfs5bJp0bwKqvJkCNvrkUidWD12/R/qqSSlcJj
         UTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497346; x=1752102146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAxLtiX9Mi4W/QN8E5YVNXw0M1nbRaXSc0QJsUUP62c=;
        b=eNlqHuMMMOfMz8urntCFtvuqTzcwuceCqkaKpE2DN7Yre5yePsM7u251+tngRraAmY
         x6JoFAYwWzShGEsZlO9PKUxJJ8XpUNApabi6FcY1BB5u+nn9J6w/7d5ptXaLafYL9tkf
         FQijfCOJaxYqpmKGNrWlgb7L1/JpNNC64QSt2B4tUYcGErlzQ8wRqIqlkKfvwVMo2EdK
         dSJ95irNA24bGPOVnIxnkDj1HEZbE3S3oXA8Q5E6/P/tC3+sTXTgISO1yPbUGsOmSqeA
         3epU1FzkSq0qFVKh79+dY1sj2SVDa85p7hCMdXLePU0uThZeNWPheo5CMDw/RHNBbXTd
         Owzg==
X-Forwarded-Encrypted: i=1; AJvYcCXxmknmV+BopbXccCHiloSPkgqdN/X01UfA8gHCPWz/kjFb4zwcGWcsjkKKKQEA/CWSlNQ/xjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbf8OdtplgO1g8cVyhx1bXFgLEFKxM37P2Af96wCnOLSuJV339
	ajOKdQt4E8wDa1rvvEa6Zx5SOwueWLVvswTtt2oHX7ZTbad9mYm9HSY=
X-Gm-Gg: ASbGncuq+fI2J+3KXjaq5rPud07Oim/ZOG7L3oi1h7i83Ir+S0OoWF/XZnR+kqtTOB7
	RtLj3aXberhUP94IXLkGDwat0XMsURmEn9R9LrOYuN5k6xXwiJZ4xpRn+skJjuijmn1Gmz/bWJT
	armUgQLb/BF5769vRrX/rn2RO0/u0RTmq8CARBrDVNt2M1wHxUyp+/4Z4oOH93tZ0jJmZCtDrqS
	LGIR9go96BmFHo4WCBJO1ce7OBOokU6ZEKfc15CEhRG9oVScDmvSOFvc1de4dcsG4f1dwUdAw/N
	QbjszbCH55XytJXV+XsG3XotIggqDj875H7nlCY=
X-Google-Smtp-Source: AGHT+IF4xHMVjuqC7Jce2fhSqfWVUhN6IjBPs/ypOECG8qRJcxtrO7dUSfvcgdhuMoawj4xKLrpQ0Q==
X-Received: by 2002:a17:90b:4e8b:b0:313:14b5:2538 with SMTP id 98e67ed59e1d1-31a90c1526amr6346568a91.35.1751497345544;
        Wed, 02 Jul 2025 16:02:25 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:25 -0700 (PDT)
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
Subject: [PATCH v3 net-next 09/15] ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
Date: Wed,  2 Jul 2025 16:01:26 -0700
Message-ID: <20250702230210.3115355-10-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3: Use dst_dev() for rt->dst.dev
v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
---
 net/ipv6/ipv6_sockglue.c |  5 ---
 net/ipv6/mcast.c         | 74 ++++++++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 34 deletions(-)

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
index 5c5f69f23d4a..edae7770bf8c 100644
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
-			dev = rt->dst.dev;
+			dev = dst_dev(&rt->dst);
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


