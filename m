Return-Path: <netdev+bounces-200824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A1AE70AB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7CC17EC39
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638B2EE28A;
	Tue, 24 Jun 2025 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKWDN5+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92462EACE9
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796796; cv=none; b=GUpJWQET6zBzw8YBRfl2fMVdFlP8pdHe49UV4iqtAO13fgpoi3rAOdv1Ck4UTDPMISBGsGdP6Nn+xV+uR59ce04JlHSGAocrjE3/Uqpp4X5o2xas1i003ZAPZ7gEMkLP8ww+Vza+qEDi6VLr18CS4py4QkdhZnDJUdV9hEKKU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796796; c=relaxed/simple;
	bh=q512zyQxJNGFFWfcWIwY69YUYQV2QpMgD6ks8fv9ZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anMaX47hRrcIUQ8p+rnT16lVWChTvTGemF1kbX/y+era1zWu6azIdZNDfrObXvqpaVnQOxvnLynGhDVi2WiTiRiB0ugUyK8o/ryRQxMQah5quyA08v//o9HJRLVE85sSXW8axfkil94KE/OiEdxVBgxNLPm6Y2RZtjUAuKETr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKWDN5+3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso537936b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796794; x=1751401594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CgXmmynj3HizAaoWK6MJNsg7sGhIr2QN9LZXTpqBMM=;
        b=MKWDN5+3eGPYstjnlEWru843bzOLvZDzh7D6CO0X7iqeQjKG3XKb796vpqv2VpDkpJ
         VhzJsgotl3xlQFqU9wU23hxO6yRFqsZupmpzcfAwAXVcpgh/44gekazIrfu5h9dOMrk7
         tfEAZcoqRq4rxgMBAF2hg/f/caaY9IFocZcvqGQNBtBTyAe3WQ1ZhggNp4ssYFv0RSjz
         OOV9OqeffBuHVZo7S7JLWDZOgAEi7RFSPGKBj7KCOH70XUKPuCnZoIVSOtD2Iyftk1Z+
         zjTSAyf/NVQfj8AfcKc9PdPBnKLidiO5gA5RskgGyBwNmhFIVx7Ny0MeoDWA3zVZW1Rq
         SenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796794; x=1751401594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CgXmmynj3HizAaoWK6MJNsg7sGhIr2QN9LZXTpqBMM=;
        b=usgQRhSupHJmcQuMGB96B2PjMB/xocHqmng/e2dK4aquuFv1CahrpoVUhpS32DWEc4
         qJSf6mpB5dqH4oJNsqVYfJjidZrG4yalvQnuAzaR7VpP5kOE4/GsJkaGCAaOdLvWO/Qg
         bTkdPbH8lUEGuHTMbZT3HK3k880f2BRhT/1yS4fHq4epffVY7SzUX/MenMLY0VcVzCfV
         r3qgbw9vbWA16VoEXh0SeHAV58WO58FAHMhRbf6EGo8UyguoWh2XFb34iYD1FAvGEXbs
         ldHW4Po3VVJWVyCSvfaGy8+FB+fxwO9mwmqZr3CUAdFQs2m6d6tv02ETRxzAnxJMDf8E
         0spg==
X-Forwarded-Encrypted: i=1; AJvYcCURwnrmSH+Xe4qKRjoz9//XT3A1PyiaHmfj/vIg7zOwaJv77DMCWwfhLHRY2NRpmWT+04WHFNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOqxBbDnD62aMGpbowG+4jc/BdRuvvrHYh10+Y57QCKCAIHDo
	4V6QuLAT6T7v4xWQwYNg7eJz8WqqGDx9Rntx9E+eHLolzNlrDL0fS9vnbq3bjw+cXTeY
X-Gm-Gg: ASbGnct4exsSF4qWNoByEzztpw2dXGcBXAFbwP+I/DJDFUj/W88ZxbpTdGSjq2SfVnH
	va0O/yY+PeGEPFOM22EmpbuL4/ehzg3nBCm0SMWZTUDqQhkE3PbCMWCwc2bIJXu3NWViXdyWelg
	2QA32YVO+rLJIo+6S6vfUPrthSH9CIUMjbUuoTPeCHWt+BBKOTzBnNQIL6o7aWUi46V8QCz/Kav
	aK+4V2M6eAPbPBrUJ9gIsHS54WP8xrrb29d64lBMZ8Np7ToRBn5LcDsYI198XbpcWlWBvWdgx0J
	TxI9V3l79HIbbQXu7FHzPPGXWGJIlvwzNW6P0/Y=
X-Google-Smtp-Source: AGHT+IGpDjkM/nAymyuV8DV9U1+aa2bbr/GTM1CoV9PxSALwKMC+Mrl6y1+WdYK8Z5bcBVmQup/W9w==
X-Received: by 2002:a05:6a00:21d3:b0:742:a7e3:7c84 with SMTP id d2e1a72fcca58-74ad44b23c2mr641220b3a.13.1750796794274;
        Tue, 24 Jun 2025 13:26:34 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:33 -0700 (PDT)
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
Subject: [PATCH v2 net-next 07/15] ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Date: Tue, 24 Jun 2025 13:24:13 -0700
Message-ID: <20250624202616.526600-8-kuni1840@gmail.com>
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
index 9fc7672926bf..afa3ff092702 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -253,14 +253,36 @@ int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
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
@@ -270,23 +292,8 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
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


