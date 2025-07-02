Return-Path: <netdev+bounces-203556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5FBAF65C5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06274869F3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE12BE7DC;
	Wed,  2 Jul 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksAZbnQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FA2D9490
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497344; cv=none; b=TKp8Ji0SYS2GzC4deJBEyK+yNt/M/t6mYUvNHslBMakb67FtVscVsgzoYufKZ3pLGCTNYRanuNjhflp33rdH+Bi/BpRo/o6q6QlCQRPNCm+lPMWQaY5WAT6bQVZpvrsXYKE8wuH0uBDgandcUaDy4JPFFAPw+1GN/8J6A6fYvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497344; c=relaxed/simple;
	bh=M0lSBWS2L359lx5WhmPV0wec5+kFCeecW9WAWzTMbg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXWQTTsUehxbRGZTn0Qg5rQ+R2CIGMUzUiAASC5xvxDsV/fHNmRJFVS5jZBo2vCSSASqUzyx2fNshyoaoMl/UJdoPNX01FBZXcVNNxcJU3tKNWXybNVN1KtUusZFO2rhssrhJjsLSYEFvRg5FlQ64qmZE++b8n0crlO1C5+B12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksAZbnQc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234c5b57557so49982645ad.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497342; x=1752102142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s5zB9+dLPJXHdKTQUKJqD5sbN79+LkF6bw/mbCoCo0=;
        b=ksAZbnQcUj/z2GoS+Y5ztAsQDeNyhFYGx6y5kh67Y9LZodb3eW54oDOWW6r1UPFHxU
         OSCSvXDBuXsDunsUJtMq9dPrvDbwWBtpcc0PC//Z5csw9GE+s7+uRvHbGcF0ryDpH9j1
         cesBWYoKCkxi5Ij+XFQ+2XryVallwlOpFUXBWmMgY8skSOQWnCwPlm1/GYxMZdY3j4Ws
         2UrPrbp3NL6iPIClbl/bSwOBt3KUjY2klg8gzpZYbJw4YSLP2y8S0zi2iqNIp/zy1n7m
         x0u6hFSCkibRhghaO0iL3e8sDhj8mVg79eTd6QRuIspUmKFdFgptGURJHNsr5I1qhYE5
         EYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497342; x=1752102142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s5zB9+dLPJXHdKTQUKJqD5sbN79+LkF6bw/mbCoCo0=;
        b=IjXyzY+vqp31zOk6JtWl3PN1ma72Mf7UWGz9IBNIDTb9jHtq4hmp2b5v30jAsaB9U2
         HHydV6/0+aODZ2KmyoHiawCW993nfovdvgLVkTlD8eSy6b90rz80+cqLU2o/kP+6T7Du
         blHURoGpH6OTOjrGoxS6jNJQif048rf3KHLdDmEfsJBf/Cg5jSypEg8VXwQBpC0o6Zdf
         jr29lOxK77AjYiYBVBxgf8jX8yK5kPWEXyGXb6ifkgCNqGrAwC31Eiak1whry5nHzINm
         YW9hWtmnwjXW0CnX3TQhwr5+T4CIfPWgkM3pKsGrMxJp+20XTOR4DUFx9lhIqY8YWoGv
         bq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUUXib3on2t8NuC5I7JdA7bb/KlMwCbVxSiyZ3lLYU7tmTldWUVaUH+9qQQAz8g8l6QZoSfSD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+oxstGDagjDp1Nd7ByIdsbiDhTvFcKm9An7NV8eIVdRvV6ZP
	QZJzjZd6fcYl8zEEtlaW2NCJbueCwgDQfz0fXp/fprU5Nt9psYle3LQ=
X-Gm-Gg: ASbGncvD2KIps3m0XwmuI8b4duJ6KQsMas8bY/DL0o5ax65F1AX4QJ3DoHNlaO9ehil
	x02oxFM8QyqOnNjJZdukWvXIkKvEM2G9vAA94uqsUE3cpTclOqE6A3GThCUhmMib0igc0pRo6rH
	Qozst/XmiJj7fhlFoa8AfydMWpp+UHTjXT/B1/zuY6YhUHXPFJSQRUt3f6JbKQFt3Y7Om/Vy41M
	ZfSIT1LDMrz9cg+7HDeaAQiZaxUnQusLug+LXw8wxLaj6taHtYExzAtQi68fWksh9ixUSmnUJZp
	aOheiuKw4Ark5Ply1YSBNh6Fvug/IYYzwqhx4ZI=
X-Google-Smtp-Source: AGHT+IEsdUsygnKbixhonXYohlVhGyyMM2g7oVBGPoZpb5r9VnM6SN60EcF32sWDUC76s7dVuro3nw==
X-Received: by 2002:a17:90b:4ac8:b0:311:b0ec:135f with SMTP id 98e67ed59e1d1-31a9d5df651mr1282513a91.30.1751497342172;
        Wed, 02 Jul 2025 16:02:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:21 -0700 (PDT)
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
Subject: [PATCH v3 net-next 06/15] ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
Date: Wed,  2 Jul 2025 16:01:23 -0700
Message-ID: <20250702230210.3115355-7-kuni1840@gmail.com>
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

In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() requires RTNL.

Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
MCAST_JOIN_GROUP.

Note that we must call rt6_lookup() and dev_hold() under RCU.

If rt6_lookup() returns an entry from the exception table, dst_dev_put()
could change rt->dev.dst to loopback concurrently, and the original device
could lose the refcount before dev_hold() and unblock device registration.

dst_dev_put() is called from NETDEV_UNREGISTER and synchronize_net() follows
it, so as long as rt6_lookup() and dev_hold() are called within the same
RCU critical section, the dev is alive.

Even if the race happens, they are synchronised by idev->dead and mcast
addresses are cleaned up.

For the racy access to rt->dst.dev, we use dst_dev().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3: Add dst_dev() for rt->dst.dev
v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
---
 net/ipv6/ipv6_sockglue.c |  2 --
 net/ipv6/mcast.c         | 24 +++++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1e225e6489ea..cb0dc885cbe4 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -121,11 +121,9 @@ static bool setsockopt_needs_rtnl(int optname)
 {
 	switch (optname) {
 	case IPV6_ADDRFORM:
-	case IPV6_ADD_MEMBERSHIP:
 	case IPV6_DROP_MEMBERSHIP:
 	case IPV6_JOIN_ANYCAST:
 	case IPV6_LEAVE_ANYCAST:
-	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b3f063b5ffd7..d55c1cb4189a 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -175,14 +175,12 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 			       const struct in6_addr *addr, unsigned int mode)
 {
-	struct net_device *dev = NULL;
-	struct ipv6_mc_socklist *mc_lst;
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_mc_socklist *mc_lst;
 	struct net *net = sock_net(sk);
+	struct net_device *dev = NULL;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (!ipv6_addr_is_multicast(addr))
 		return -EINVAL;
 
@@ -202,13 +200,18 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 
 	if (ifindex == 0) {
 		struct rt6_info *rt;
+
+		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = rt->dst.dev;
+			dev = dst_dev(&rt->dst);
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
-	} else
-		dev = __dev_get_by_index(net, ifindex);
+		rcu_read_unlock();
+	} else {
+		dev = dev_get_by_index(net, ifindex);
+	}
 
 	if (!dev) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
@@ -219,12 +222,11 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 	mc_lst->sfmode = mode;
 	RCU_INIT_POINTER(mc_lst->sflist, NULL);
 
-	/*
-	 *	now add/increase the group membership on the device
-	 */
-
+	/* now add/increase the group membership on the device */
 	err = __ipv6_dev_mc_inc(dev, addr, mode);
 
+	dev_put(dev);
+
 	if (err) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
 		return err;
-- 
2.49.0


