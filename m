Return-Path: <netdev+bounces-91401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9818B2716
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B71C22545
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BA14D44E;
	Thu, 25 Apr 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IqpjG+6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B41CF8A
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064570; cv=none; b=K8Bx4XZrIaacvbJUBGoYdo4WLAaHne3cdKqU7JBhEYXiP8sOVvhspVLByzf5NRPydPHVRe3wTa9easq6tA6utYFZGNMXn94twnsbD3s4RAdqRyuhVNgJaeGUQsXJqqfB0ZJO+ekZ5X0XHkMhvH94SEOIeeJcAt0hhn3sWHgqac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064570; c=relaxed/simple;
	bh=ciQaKRK2x+nMwgqTz/8HOGd9P1pDLob6qcFyVu0Q1eI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izNKGN4Ii2lpZe+GxR2cJvU0nFfkDP46iq1U6Gvob7aa93BnaEN4zyytGJyzVUiCU9tPHgnT0fGxB7VxI9UznNMH1LL6AbezOEVgTC5zFdpJlCoVsYKgSY1vpSO/OFIdHw640HpO/J/qCJQEFTeBvM/ndQHxYQH0YcW7W0cTSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IqpjG+6r; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714064568; x=1745600568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdUhSD7R9hD4VK0T9FZDQxxbtiD2Z/pthrHQYZeKgQk=;
  b=IqpjG+6rz5v7cjUSZBEuWwaJmfgE3Ny7bIb0ET0In/AYoUKXXQuEtwAo
   N/CqayIIH5cRASbyTJwU49EEUQmqUSdeYbXkDUk7XMa7K4I2mSV4k2iqV
   qGtPAw0Zouxdj8WQ7e/22rnACBCrMExVFWjTixkCP2BwFQv7pnmFUcyd7
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="84679251"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:02:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19800]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.180:2525] with esmtp (Farcaster)
 id 190ba340-ee72-4fa0-ae13-59f407296f83; Thu, 25 Apr 2024 17:02:48 +0000 (UTC)
X-Farcaster-Flow-ID: 190ba340-ee72-4fa0-ae13-59f407296f83
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:02:47 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 25 Apr 2024 17:02:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/6] arp: Convert ioctl(SIOCGARP) to RCU.
Date: Thu, 25 Apr 2024 10:00:02 -0700
Message-ID: <20240425170002.68160-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425170002.68160-1-kuniyu@amazon.com>
References: <20240425170002.68160-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCGARP) holds rtnl_lock() for __dev_get_by_name() and
later calls neigh_lookup(), which calls rcu_read_lock().

Let's replace __dev_get_by_name() with dev_get_by_name_rcu() to
avoid locking rtnl_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 5034920be85a..9430b64558cd 100644
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


