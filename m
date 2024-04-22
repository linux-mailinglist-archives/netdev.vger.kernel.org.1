Return-Path: <netdev+bounces-90257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEF98AD545
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FA8B23D30
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615EC157E6E;
	Mon, 22 Apr 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d46VekKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B961553AA
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815448; cv=none; b=gDpAuSAdX/D+yykCkYvBf56R3+d734X54lHxochXtc0B7TpRatSeXBlFM0u10p3qJdCL0FkbP8j7hQ8l5edd17FLssCLtNE1+9GdJbwUsncy/kL4/DISMDh3Yz16rTn21Umyg+/VEwSEAIAH94YHOGGIly9zcXrkMACdBMwFkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815448; c=relaxed/simple;
	bh=L8c9ige/2H4o0ZD8LtZA1zXeS3i6z1c15SYatDse7Bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK0XXlZQSIFtKJAYLPJlzsk1zydfF79oMQVwildSD6lmwDkGarBB9pPtEG3ydC/dn5Kb1is3eEHnjNWJ12xb63Rt3d6dWvCYPuKkXuSp6fqfZVhfvHtpOC37s9bqZIGa2kpoK24xR5tfST3kL0ZZcvR2jE+bTqKcGQXMuG/EVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d46VekKW; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713815447; x=1745351447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sBrRuH/2Jp9sdd3IcXXO6JvheU5/w7UxutUPWQKFcTQ=;
  b=d46VekKW6eTsNTzE7TbVDDmmh/UNIH1XV7A/S8T42ZdyClXjxX2un/pZ
   McCCNPXZmbizLlzY/wX81AKfi6ikZ/lHAEHHzpw4FP+zBpi3aiFiZgrFA
   H6S+/Uee3OJDqQL7fLKp1B+f8dBhRAVeDjOxvwa+4LbvjJXcVzX1joH6U
   k=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="413811290"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:50:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:44128]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.46:2525] with esmtp (Farcaster)
 id aea3dcbd-2ef4-4c3c-9904-5231fdb20a3c; Mon, 22 Apr 2024 19:50:46 +0000 (UTC)
X-Farcaster-Flow-ID: aea3dcbd-2ef4-4c3c-9904-5231fdb20a3c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:50:41 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:50:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/6] arp: Convert ioctl(SIOCGARP) to RCU.
Date: Mon, 22 Apr 2024 12:47:55 -0700
Message-ID: <20240422194755.4221-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422194755.4221-1-kuniyu@amazon.com>
References: <20240422194755.4221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCGARP) holds rtnl_lock() for __dev_get_by_name() and
later calls neigh_lookup(), which calls rcu_read_lock().

Let's extend the RCU section and replace __dev_get_by_name()
with dev_get_by_name_rcu() to avoid locking rtnl_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 057aa23bf439..33cfa8c90445 100644
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


