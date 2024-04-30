Return-Path: <netdev+bounces-92299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79D8B67C5
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA9E1C2246C
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B379EF;
	Tue, 30 Apr 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iNX9PBQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7E2CA9
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442433; cv=none; b=UQvvuetemfbdsjNRzB1Icqa09zOcNEPPAQvN4hTez1M86TxU5/EldByvwBtvmaCpYoE8tEWsKEU1Z5aqtmPCitkmvC+q/e4jBQq1FJLHKguSHwG7x7FL1LpTbajB+n+aylEmx6rqjpFMkWz1VI03yEUU1qrupWgNHLpiNQ+BZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442433; c=relaxed/simple;
	bh=wknSglZPe3+AT7eZoBsgjR57Q6GVZjUMOg3gn/mxtK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGouA2Dj/O+dL4UcgRmdtaPEvRt78yNfOd05os562V7Tu2JzwDXYTBEzxTgt/w9Cx5gRkSWcpFOwV93ffZEZdo7T//e2PTqhcOgCJcgBVw/PYKjnNRVoohn+per3vsE72BwyOpNaTRzWxK4GAEUr93BB5kS/b5RksHoMAbmACQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iNX9PBQx; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442432; x=1745978432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAX5bs4OkHx4HPUMUWqsF4l/u/i+FtS34zKX0bJSj7M=;
  b=iNX9PBQx2+EIRSJ1PwlHdqzTZbvnUGW3tVzSPQ3JnAIshi9QGoyLQ3si
   5oV9pjflN1ayoVSNdRZ6wZ0tpSEgkhNfEF/2vhnJEl1FXgaDNmr+F4NI0
   /q0/4COi4D5Jp67CjSrxzwEWjTEUUOi+VO28lK2pH9BoB62yAt2q1EJPB
   w=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="85474361"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 02:00:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:45860]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.142:2525] with esmtp (Farcaster)
 id cb2d0d58-0007-446d-89eb-c505750b3663; Tue, 30 Apr 2024 02:00:30 +0000 (UTC)
X-Farcaster-Flow-ID: cb2d0d58-0007-446d-89eb-c505750b3663
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:00:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:00:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 5/7] arp: Get dev after calling arp_req_(delete|set|get)().
Date: Mon, 29 Apr 2024 18:58:11 -0700
Message-ID: <20240430015813.71143-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

arp_ioctl() holds rtnl_lock() first regardless of cmd (SIOCDARP,
SIOCSARP, and SIOCGARP) to get net_device by __dev_get_by_name()
and copy dev->name safely.

In the SIOCGARP path, arp_req_get() calls neigh_lookup(), which
looks up a neighbour entry under RCU.

We will extend the RCU section not to take rtnl_lock() and instead
use dev_get_by_name_rcu() for SIOCGARP.

As a preparation, let's move __dev_get_by_name() into another
function and call it from arp_req_delete(), arp_req_set(), and
arp_req_get().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 86 +++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 60f633b24ec8..5034920be85a 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1003,12 +1003,36 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
  *	User level interface (ioctl)
  */
 
+static struct net_device *arp_req_dev_by_name(struct net *net, struct arpreq *r)
+{
+	struct net_device *dev;
+
+	dev = __dev_get_by_name(net, r->arp_dev);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	/* Mmmm... It is wrong... ARPHRD_NETROM == 0 */
+	if (!r->arp_ha.sa_family)
+		r->arp_ha.sa_family = dev->type;
+
+	if ((r->arp_flags & ATF_COM) && r->arp_ha.sa_family != dev->type)
+		return ERR_PTR(-EINVAL);
+
+	return dev;
+}
+
 static struct net_device *arp_req_dev(struct net *net, struct arpreq *r)
 {
 	struct net_device *dev;
 	struct rtable *rt;
 	__be32 ip;
 
+	if (r->arp_dev[0])
+		return arp_req_dev_by_name(net, r);
+
+	if (r->arp_flags & ATF_PUBL)
+		return NULL;
+
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
 	rt = ip_route_output(net, ip, 0, 0, 0, RT_SCOPE_LINK);
@@ -1063,21 +1087,20 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	return arp_req_set_proxy(net, dev, 1);
 }
 
-static int arp_req_set(struct net *net, struct arpreq *r,
-		       struct net_device *dev)
+static int arp_req_set(struct net *net, struct arpreq *r)
 {
 	struct neighbour *neigh;
+	struct net_device *dev;
 	__be32 ip;
 	int err;
 
+	dev = arp_req_dev(net, r);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
 	if (r->arp_flags & ATF_PUBL)
 		return arp_req_set_public(net, r, dev);
 
-	if (!dev) {
-		dev = arp_req_dev(net, r);
-		if (IS_ERR(dev))
-			return PTR_ERR(dev);
-	}
 	switch (dev->type) {
 #if IS_ENABLED(CONFIG_FDDI)
 	case ARPHRD_FDDI:
@@ -1134,10 +1157,18 @@ static unsigned int arp_state_to_flags(struct neighbour *neigh)
  *	Get an ARP cache entry.
  */
 
-static int arp_req_get(struct arpreq *r, struct net_device *dev)
+static int arp_req_get(struct net *net, struct arpreq *r)
 {
 	__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
 	struct neighbour *neigh;
+	struct net_device *dev;
+
+	if (!r->arp_dev[0])
+		return -ENODEV;
+
+	dev = arp_req_dev_by_name(net, r);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
 	neigh = neigh_lookup(&arp_tbl, &ip, dev);
 	if (!neigh)
@@ -1201,20 +1232,20 @@ static int arp_req_delete_public(struct net *net, struct arpreq *r,
 	return arp_req_set_proxy(net, dev, 0);
 }
 
-static int arp_req_delete(struct net *net, struct arpreq *r,
-			  struct net_device *dev)
+static int arp_req_delete(struct net *net, struct arpreq *r)
 {
+	struct net_device *dev;
 	__be32 ip;
 
+	dev = arp_req_dev(net, r);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
 	if (r->arp_flags & ATF_PUBL)
 		return arp_req_delete_public(net, r, dev);
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
-	if (!dev) {
-		dev = arp_req_dev(net, r);
-		if (IS_ERR(dev))
-			return PTR_ERR(dev);
-	}
+
 	return arp_invalidate(dev, ip, true);
 }
 
@@ -1224,7 +1255,6 @@ static int arp_req_delete(struct net *net, struct arpreq *r,
 
 int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 {
-	struct net_device *dev = NULL;
 	struct arpreq r;
 	__be32 *netmask;
 	int err;
@@ -1258,35 +1288,19 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 		return -EINVAL;
 
 	rtnl_lock();
-	if (r.arp_dev[0]) {
-		err = -ENODEV;
-		dev = __dev_get_by_name(net, r.arp_dev);
-		if (!dev)
-			goto out;
-
-		/* Mmmm... It is wrong... ARPHRD_NETROM==0 */
-		if (!r.arp_ha.sa_family)
-			r.arp_ha.sa_family = dev->type;
-		err = -EINVAL;
-		if ((r.arp_flags & ATF_COM) && r.arp_ha.sa_family != dev->type)
-			goto out;
-	} else if (cmd == SIOCGARP) {
-		err = -ENODEV;
-		goto out;
-	}
 
 	switch (cmd) {
 	case SIOCDARP:
-		err = arp_req_delete(net, &r, dev);
+		err = arp_req_delete(net, &r);
 		break;
 	case SIOCSARP:
-		err = arp_req_set(net, &r, dev);
+		err = arp_req_set(net, &r);
 		break;
 	case SIOCGARP:
-		err = arp_req_get(&r, dev);
+		err = arp_req_get(net, &r);
 		break;
 	}
-out:
+
 	rtnl_unlock();
 	if (cmd == SIOCGARP && !err && copy_to_user(arg, &r, sizeof(r)))
 		err = -EFAULT;
-- 
2.30.2


