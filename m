Return-Path: <netdev+bounces-203557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79139AF65C6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4349F1C42C68
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8D42EBDC1;
	Wed,  2 Jul 2025 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjTBKmld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C52E4998
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497345; cv=none; b=UrOKcLGXSUcZtcRcoUnTPCjufsCrbKC1zlj+plfRWwkAX53W9PG6L6GG3pyFOf5SwiuOwSIVLvFmCSsrljdxz2PjOdUBlsOmsx96QoO+u7ZFkid97OTpvW1dSwFWf6GCsmIqsEm/QFi1abnPAD2al1NsbnQXTdJs9rWXD8BLKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497345; c=relaxed/simple;
	bh=8vnlIj8pCSmPPJLkpzWzsNGnhcMs9aSdFez4za2dJZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU28CDCGwBUewPZ2L8yEA3M/p8WEzsq962dGqkSYcN4ZjYBH0EpUhdalvy7eYNJPiRVgEgpzmWZ9sBnYXYgJ3VYIpdB0ri/AjANuUzRzq6JI9s9EDeSUsMOi+3t0/qiRqQHdR6FcEmZuGfgImnjaw4YydQBdvjhK7KBaqKJxLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjTBKmld; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31befde0a0so3588177a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497343; x=1752102143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qQ/ZfOsB78VvJCliFB2SpVyOVP1UqQYjkcvGzDvzg0=;
        b=GjTBKmldn3wPXPrVn7ZlybK3Wav7DkHNRyJMNOOTXFLZNDtka8kQ59P3+/0pu4WUC4
         ESwss5i2Gyrh5PLkh2wIhvuyW9TsnnL3xOInqh8FPXkVNg716XmE0GFKR4LQWJVwS5L5
         6D/dKNNSHXP+kOWXm/TgGHdkbWDXFL3PxEnzDpeZX1uynzIc3H2GFqYyGraFcnun5kuu
         qXNQ+Y0gjrvxELFT61QZly7tgr+XbU0+wi3fmjHQuemCT1y1YvOlTi8huIS+dE6l5+TI
         zyWqbI2baoC4TkBVj3wTeGBcAyEjkaYT5n6YP2vIBKmN9wiAViYBRA7WsWg9YqnNUszd
         vYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497343; x=1752102143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qQ/ZfOsB78VvJCliFB2SpVyOVP1UqQYjkcvGzDvzg0=;
        b=bFqCm0ncNGxwYF8UPYrWt6aIkXIp7aelWAc0leOFoK7zlr6tCDbSvRcX0T04lsQlpz
         EF2wv0p3EsvHVApghmD46l70v8K9JFBhQPDHtgTFB9ByspZ9wcbJ2WjzHx2Xg76Y6nfA
         p+GCST/2kXfxTrTgQxHqxnQMnhOS2SC5Q2pVaczfr4+fN3yzEtB/IIJBUbFUqTQ4Ik+m
         bXrCw88EaHTuvOr0r3uhCD2HnfZhgPWJDZ2VJPGLFRFzElWHDqzcUg8vc3aaafUZQnM6
         AzxrVzumzHpethCqcuJUNhcz4uVCuEStDN2lUtHhumGsvp/+WEWljFNi0P47cYyc5Ef9
         rL2g==
X-Forwarded-Encrypted: i=1; AJvYcCXWRRL3fSEZqo67hiwrWOLVDeYXClbtL7gabeXtzECR6dFqg3XVjt2yo2gaG4FGo11f2QHEbHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5c6e9Dx4LWsaMMml9hYu9cWrrcLf4+geRMOUwvrRrbGNyJVfJ
	Gqn9i0pPrmA37awGewHSiBpE/y9qvGXBlD4w74d6GOLr9U6lDWmrEr4=
X-Gm-Gg: ASbGncsVKrgP8BH4tUAYIpV0Od86Wybz8Cu2adnyXH7DHRHJEulKOCQ7A17xQU1kuC5
	HyJ+aYMq+kspy/LUgf/Ge+R82ZVcVxZa9WsLSVlgCugwp1h4bfVhAuF9kRkRMjOg84q/hY02xHj
	W2PdT2kNdEr7Bvv+X5rPXSXYrl86p653+hG2D2oXxeipkBHLvk2QcJ4aJBCvQRTdIHh4mKOnn1S
	zdKr86s5JKTQzOvcFG4gwJzwlTT42KCarOxHJftPKGKgipfqD35aeQHQqUK1Ycal1+bY13QGILw
	Es329XD43WSKIuQZXFtkaURUtR/xFNGKxkt87PQ=
X-Google-Smtp-Source: AGHT+IHUhX6DLMJwfhBdZJ4LjHmzTwLXuumo6Q7cBRxSoZC/jH2Az3jTK693qbCQuIjSu1X0EdhwEg==
X-Received: by 2002:a17:90b:1dc4:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31a90bdabafmr7736691a91.18.1751497343289;
        Wed, 02 Jul 2025 16:02:23 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:22 -0700 (PDT)
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
Subject: [PATCH v3 net-next 07/15] ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Date: Wed,  2 Jul 2025 16:01:24 -0700
Message-ID: <20250702230210.3115355-8-kuni1840@gmail.com>
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

In __ipv6_sock_mc_drop(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() and __in6_dev_get() require RTNL.

Let's use dev_get_by_index() and in6_dev_get() and drop RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.

Note that __ipv6_sock_mc_drop() is factorised to reuse in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index d55c1cb4189a..ed40f5b132ae 100644
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


