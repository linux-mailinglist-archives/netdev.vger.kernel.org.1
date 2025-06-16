Return-Path: <netdev+bounces-198333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D1ADBDB7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257283B596D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB179237176;
	Mon, 16 Jun 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUSQzv4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C032367C9
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116889; cv=none; b=vDKZ2CMQ+DAr9S/jjGdZtcGtxyspOpv7UT46mFd1QU/yrg9mJwJp6GneiFgMf1BeLZV4MK7EBjYia+dOgitv8ZOs0lbByuuTHSuwbdLEpHtiGOY921QVp774AdhetVdb2fM8LkDv+QvGDRGsFbmhKr+ueBwhGRhc7+FL5NmElYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116889; c=relaxed/simple;
	bh=gsPKCLgql5c0R8fj7fZ710VH4TRBPYYsvwi7pAF/fV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnXJFihNuP2v1tjZcEN+w3eQLDOC2yNr3H3rAWQc6FdMpeYrHnB0pSECaWze6lHyNYnmCiUq3AMSjTGk2G9UhvHuTbVQAIRo1tLil1d2WIeSZmFyiS2K4Aj42YIYEkjdSxaNpTPPMts102RqFS6CTyvfNy2geRiEiKiZKbqjD60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUSQzv4S; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2fca9d7872so3244492a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116887; x=1750721687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO11jy71k9I7r0mjHgP0jOC7qeF4IPMMP03vGuK+Em4=;
        b=gUSQzv4S55NcCrB36eQL+ZEg6Q94+ZlnlW3BxxuRNO19mAsYsCmxvIz+j1J/w/N9Db
         3Tf/z2cGxMdyfByCA/L/QvimjrFFUj67yNvsLvZvW1YlG5KvRciT154lwFCq7KsSXO4T
         w7Hs3cNHmMJG5gwnXk8SHkyZdszXm2Z0yY8NGNhP9b7CGneeZMd6lwl4A+bTH3dKKfZi
         AdldzE/ByvhCsp6vEpLFbHWs9sERzkIakovoIN6fQsFIv0CwS/t/NaRIrEkYkzg55Sq7
         +GazDznaSR1CMP0mKMtPuYidd3PkukInj2Gx1ihH51D8wx2lhF8H+TWcMZWi9CsKipyx
         OhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116887; x=1750721687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO11jy71k9I7r0mjHgP0jOC7qeF4IPMMP03vGuK+Em4=;
        b=TPnXC/skCbpdGkdJOaPUrU+Gx8rPpe8b658k9X8a0rDA4jE0tjtoidPkX7036FIp8z
         PLYot6/n8IA7iJpjfqF0QnbXpX87eLpFvlDX0B2DDJFKvkU2uThN4M9zGxZxRSgXma4i
         F/DUtPnG0SHwRSNUANm7S7IoyFJIHn8Vy1NU7MB0FvYZa9c/22905dgNhLqJIWikciC2
         oP/37XOinLC/q+CumydCJqR+cp84w4t7jxJ+DO01gaDX/oKkFBmZjs821f3MZc4WvXt2
         kAB3iSX9/dT2sSWAgktpvz5Z+qZOUNtUUzldqKAk9tppZvANh2kXi+qlz5Z4DbRY7R/5
         qJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb7L7JsLkjXh8EqVUS3qhMNzDulkJHJkm/PcKOH4eSakNODIaLlNebyMc2LZV0VNAhS4X2Ta4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnffJO9Cs61noCfkvnafNAcIOA4sWZNhT+sAXBDnfCh18M9vf
	i9rkxLpUnULHWir482nvCz433IONAAAHUt0l9clz4vK4gTdm78Y2EDs=
X-Gm-Gg: ASbGncsc7VU6W3xGgBFbw3QW2EQjiukYau7MDTGjZxUPFj+jmkNn0c96mtLyq/mG5A7
	74dIPZ/YBaDg6cyppvxbWQSHwgW+ZaPz1WclEZNmg9zCd0S/qumsYoHVSdBONayoclvTTksVETi
	s02FtKqIbFiXYs0X1dsEwqMHXvgifpoVZcNQ5FvxaX9YYKnMV7AbfKUNUctK71RBX/iwSUjUYQL
	zFdVv67g2PuvZVi+fS0BhtD+ZZBAIiqo9pauROEituVtNoOs1HX8ZuG015C6Ht9pnzGwiSMhH1E
	wRi8+HHxkdWgO2e25Hwzowm0XNMSBjN1cp8aU76UR6O6nWHIzw==
X-Google-Smtp-Source: AGHT+IGcGr9BUafyfX/kGJf1QEv7iO9WfVoj8eI1Xj6esQ9BDQoK11Zumh3Wsz7sU4/FfXAGEKOcEQ==
X-Received: by 2002:a17:90b:2ed0:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-313f1d644admr16133577a91.21.1750116887383;
        Mon, 16 Jun 2025 16:34:47 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:46 -0700 (PDT)
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
Subject: [PATCH v1 net-next 07/15] ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Date: Mon, 16 Jun 2025 16:28:36 -0700
Message-ID: <20250616233417.1153427-8-kuni1840@gmail.com>
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

In __ipv6_sock_mc_drop(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() and __in6_dev_get() require RTNL.

Let's use dev_get_by_index() and in6_dev_get() and drop RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.

Note that __ipv6_sock_mc_drop() is factorised to reuse in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ipv6_sockglue.c |  2 --
 net/ipv6/mcast.c         | 47 +++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index cb0dc885cbe4..c8892d54821f 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -121,10 +121,8 @@ static bool setsockopt_needs_rtnl(int optname)
 {
 	switch (optname) {
 	case IPV6_ADDRFORM:
-	case IPV6_DROP_MEMBERSHIP:
 	case IPV6_JOIN_ANYCAST:
 	case IPV6_LEAVE_ANYCAST:
-	case MCAST_LEAVE_GROUP:
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
 	case MCAST_BLOCK_SOURCE:
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index f36ab672fe72..7324e9bc2163 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -251,14 +251,36 @@ int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
 /*
  *	socket leave on multicast group
  */
+static void __ipv6_sock_mc_drop(struct sock *sk, struct ipv6_mc_socklist *mc_lst)
+{
+	struct net *net = sock_net(sk);
+	struct net_device *dev;
+
+	dev = dev_get_by_index(net, mc_lst->ifindex);
+	if (dev) {
+		struct inet6_dev *idev = in6_dev_get(dev);
+
+		ip6_mc_leave_src(sk, mc_lst, idev);
+
+		if (idev) {
+			__ipv6_dev_mc_dec(idev, &mc_lst->addr);
+			in6_dev_put(idev);
+		}
+
+		dev_put(dev);
+	} else {
+		ip6_mc_leave_src(sk, mc_lst, NULL);
+	}
+
+	atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
+	kfree_rcu(mc_lst, rcu);
+}
+
 int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct ipv6_mc_socklist *mc_lst;
 	struct ipv6_mc_socklist __rcu **lnk;
-	struct net *net = sock_net(sk);
-
-	ASSERT_RTNL();
+	struct ipv6_mc_socklist *mc_lst;
 
 	if (!ipv6_addr_is_multicast(addr))
 		return -EINVAL;
@@ -268,23 +290,8 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	      lnk = &mc_lst->next) {
 		if ((ifindex == 0 || mc_lst->ifindex == ifindex) &&
 		    ipv6_addr_equal(&mc_lst->addr, addr)) {
-			struct net_device *dev;
-
 			*lnk = mc_lst->next;
-
-			dev = __dev_get_by_index(net, mc_lst->ifindex);
-			if (dev) {
-				struct inet6_dev *idev = __in6_dev_get(dev);
-
-				ip6_mc_leave_src(sk, mc_lst, idev);
-				if (idev)
-					__ipv6_dev_mc_dec(idev, &mc_lst->addr);
-			} else {
-				ip6_mc_leave_src(sk, mc_lst, NULL);
-			}
-
-			atomic_sub(sizeof(*mc_lst), &sk->sk_omem_alloc);
-			kfree_rcu(mc_lst, rcu);
+			__ipv6_sock_mc_drop(sk, mc_lst);
 			return 0;
 		}
 	}
-- 
2.49.0


