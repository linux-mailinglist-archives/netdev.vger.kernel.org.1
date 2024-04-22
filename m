Return-Path: <netdev+bounces-90256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C108AD52B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42161F21905
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D715539E;
	Mon, 22 Apr 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B1Th11q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D14155385
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815424; cv=none; b=THfyfzYIyP7HcZ9zo1h5WTV8EIaq/1LInY5HHvVW6Hdu7pNVk5GjKUd9+WwhA8fGAj9K8bBYIXGT7C9O0lExDiwej5gIH/E1aOHFxZ2VretCk8cIO1JlF71ZrVKbzJWqOv/NHiAYvAN1F8/88u3wpfe7f/bDPpwlwIXr96fJBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815424; c=relaxed/simple;
	bh=2ZiVa3U6Bcpfyln2faXHV4oFrmphgfGWnhSkbALy1GQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi74aQAo4E/ca56YNbt1dSXvtQRDDcp5Wyi2XzocAlw9T40LhlK2qmh2EmvS45rWiIBVBzzRgEJsmY8vROP4wWWUKF7wdhauKEkJ1X7ierf2rYFnqH246+4I0pNaPF6HVSuqKPJKMhIE8hIrbwwebZadFCoWvPRg0Ovi7lPfVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B1Th11q8; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713815423; x=1745351423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+uW+U1niRbQRxMWA4LjDxqZX1zd3QOdDcv+qtQu0Lg=;
  b=B1Th11q8gHCM+MbWOZxfukwDN3BEtPhYSakr8VCWd/OLxB/ntKQzdMTO
   q6DJWY2OdJ3NGzYHWzn4WB4rWH3Cm/Z0wUb7O4SFAQDF4zSQ0dBDJM7zL
   TxP76rMWAcelkiXBKqVP7jVL1/F6gwERJYydzExwffcy2fe9aE46qDNb1
   A=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="720670694"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:50:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:61090]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.77:2525] with esmtp (Farcaster)
 id 9110141d-7d5c-4a7a-aa6b-aaa759eef3e1; Mon, 22 Apr 2024 19:50:16 +0000 (UTC)
X-Farcaster-Flow-ID: 9110141d-7d5c-4a7a-aa6b-aaa759eef3e1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:50:16 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:50:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/6] arp: Get dev after calling arp_req_(delete|set|get)().
Date: Mon, 22 Apr 2024 12:47:54 -0700
Message-ID: <20240422194755.4221-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

arp_ioctl() holds rtnl_lock() first regardless of cmd (SIOCDARP,
SIOCSARP, and SIOCGARP) to get net_device by __dev_get_by_name().

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
index 60f633b24ec8..057aa23bf439 100644
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
+	if (!IS_ERR(dev))
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


