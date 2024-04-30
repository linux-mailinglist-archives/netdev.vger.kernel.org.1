Return-Path: <netdev+bounces-92301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6B8B67C7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078EA28262D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328179F2;
	Tue, 30 Apr 2024 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="je/GHinR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347118F5C
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442503; cv=none; b=pHSAYPbatg9x0K8ELW5rNKVS4R652+uVppzrKTxtl1//sNI2WCTq+g5i+QQ5n+rGhXu2KN34V1VhH1rMECeLlIGO4ccYhzhzYCSdcgX2cN3qUBfuF+eoDQWErGfC4Re1zD92b3UYLgpGTPloJyHB7nXVwz9xuP+uWkqb7VG1Fyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442503; c=relaxed/simple;
	bh=/TuYi1s8m9ClNmhCbpxcC9TJoNhQasiMhqt/pa4KWdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoByLYGFdau/Gxj6hlaP5tXzyKSLX+CoiAXKsRIuAcevqPuiW2QucxpSaOEukkIIHMF19SAWl4eZJac/eFsABxPAeVCkXozZBWpGZihhUyUN/yrvBvkoBvySrIQajUwxfZMel1Caxc4Zmp+/l6kTlNmxI5Z5D/fEww3kZ6TEt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=je/GHinR; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442502; x=1745978502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=soyHOpXFvaf2yG863aXbcux2A2IGm6i6JEo7ZyZ3Q24=;
  b=je/GHinRKv7R1dDmk7/mWQia1FakkfFQXo5yiw+vvtHKtIsTPQKlE5mB
   gaiQyVybdtcjvLQDMM/XB1szIgRudViGB01kHxxbwhLo69WvTv7zC2QmT
   ngEJrHCKJTY7/rH8v1fI9gRIz3HZqdC5TvdKMgyobgmn+B9QZOkJgCucs
   w=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="341719380"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 02:01:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:59976]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.7:2525] with esmtp (Farcaster)
 id 2e9e5fd8-ab6c-44b7-9db3-3ef3672005ce; Tue, 30 Apr 2024 02:01:19 +0000 (UTC)
X-Farcaster-Flow-ID: 2e9e5fd8-ab6c-44b7-9db3-3ef3672005ce
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:01:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:01:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 7/7] arp: Convert ioctl(SIOCGARP) to RCU.
Date: Mon, 29 Apr 2024 18:58:13 -0700
Message-ID: <20240430015813.71143-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240430015813.71143-1-kuniyu@amazon.com>
References: <20240430015813.71143-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCGARP) holds rtnl_lock() to get netdev by __dev_get_by_name()
and copy dev->name safely and calls neigh_lookup() later, which looks
up a neighbour entry under RCU.

Let's replace __dev_get_by_name() with dev_get_by_name_rcu() and strscpy()
with netdev_copy_name() to avoid locking rtnl_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 5034920be85a..11c1519b3699 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1003,11 +1003,15 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
  *	User level interface (ioctl)
  */
 
-static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r)
+static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r,
+					      bool getarp)
 {
 	struct net_device *dev;
 
-	dev = __dev_get_by_name(net, r->arp_dev);
+	if (getarp)
+		dev = dev_get_by_name_rcu(net, r->arp_dev);
+	else
+		dev = __dev_get_by_name(net, r->arp_dev);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -1028,7 +1032,7 @@ static struct net_device *arp_req_dev(struct net *net, struct arpreq *r)
 	__be32 ip;
 
 	if (r->arp_dev[0])
-		return arp_req_dev_by_name(net, r);
+		return arp_req_dev_by_name(net, r, false);
 
 	if (r->arp_flags & ATF_PUBL)
 		return NULL;
@@ -1166,7 +1170,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 	if (!r->arp_dev[0])
 		return -ENODEV;
 
-	dev = arp_req_dev_by_name(net, r);
+	dev = arp_req_dev_by_name(net, r, true);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
@@ -1188,7 +1192,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 	neigh_release(neigh);
 
 	r->arp_ha.sa_family = dev->type;
-	strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));
+	netdev_copy_name(dev, r->arp_dev);
 
 	return 0;
 }
@@ -1287,23 +1291,27 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 	else if (*netmask && *netmask != htonl(0xFFFFFFFFUL))
 		return -EINVAL;
 
-	rtnl_lock();
-
 	switch (cmd) {
 	case SIOCDARP:
+		rtnl_lock();
 		err = arp_req_delete(net, &r);
+		rtnl_unlock();
 		break;
 	case SIOCSARP:
+		rtnl_lock();
 		err = arp_req_set(net, &r);
+		rtnl_unlock();
 		break;
 	case SIOCGARP:
+		rcu_read_lock();
 		err = arp_req_get(net, &r);
+		rcu_read_unlock();
+
+		if (!err && copy_to_user(arg, &r, sizeof(r)))
+			err = -EFAULT;
 		break;
 	}
 
-	rtnl_unlock();
-	if (cmd == SIOCGARP && !err && copy_to_user(arg, &r, sizeof(r)))
-		err = -EFAULT;
 	return err;
 }
 
-- 
2.30.2


