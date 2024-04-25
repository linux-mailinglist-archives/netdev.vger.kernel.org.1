Return-Path: <netdev+bounces-91398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A78B2712
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B8AB21F3D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32614A4EC;
	Thu, 25 Apr 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="INn21bPQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1514D44E
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064500; cv=none; b=mG9pQXz0lA7Aq00IUssxPHPy8o9ZG/aIYZ0DUwc/q7T6ymlkBGT2oH8Ox0i1o0cBqK8jmynP0+Zcki2KP9IBiIFTcIVsfhpfhdJHfEqT0VbLmKkT7ejIUcis3/MdgyYpENb7X1vGhe8AMhXvG48CZG4QSWJIbDQH7+1vBweRxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064500; c=relaxed/simple;
	bh=HV3BPHqXPDmXYgQpQT1m2Ltigw1Fhh47Ep81QeL09/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbIjuTIQ9bMFt2xUM4HI5li3HvkD6IfL8iZEP+h+2R/k2XzWkUsDkbYxsrqYJYBeR8O4gcUwWh6g5Y+hOOkeV9VGGQGIpdST3Di6C4pIyttea361+SVinHN1g7bgIh5Ncu0fU/1O9P8hbxPsWNEX0NbsNidltbY1w+D/PzZptCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=INn21bPQ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714064498; x=1745600498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8ijWAzy9Fufp4GKwbIfWSlcbybgK4zD9u8PFQfKdgQ=;
  b=INn21bPQ8W6KHEWEdTWWRZhQTqEk53r2kTduYITBLoCxjtIA1OXQ01p3
   hhsgBNVn0zBYWfTEVOsxGj1VPQ/cigbU2VetlHb8aveDyQycttSuKzaB2
   YJ+oDqnmNHJinfYo6jx3BrgoCyA2C1Lz7VklTPORtvcRaL7sRJW+oSuIn
   o=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="84678799"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:01:36 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:16022]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.211:2525] with esmtp (Farcaster)
 id 67326564-70ef-465a-9c92-a7fc4c0d4bdb; Thu, 25 Apr 2024 17:01:36 +0000 (UTC)
X-Farcaster-Flow-ID: 67326564-70ef-465a-9c92-a7fc4c0d4bdb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:01:32 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 25 Apr 2024 17:01:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/6] arp: Factorise ip_route_output() call in arp_req_set() and arp_req_delete().
Date: Thu, 25 Apr 2024 09:59:59 -0700
Message-ID: <20240425170002.68160-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When ioctl(SIOCDARP/SIOCSARP) is issued for non-proxy entry (no ATF_COM)
without arpreq.arp_dev[] set, arp_req_set() and arp_req_delete() looks up
dev based on IPv4 address by ip_route_output().

Let's factorise the same code as arp_req_dev().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index b20a5771d069..ac3e15799c2f 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1003,6 +1003,27 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
  *	User level interface (ioctl)
  */
 
+static struct net_device *arp_req_dev(struct net *net, struct arpreq *r)
+{
+	struct net_device *dev;
+	struct rtable *rt;
+	__be32 ip;
+
+	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
+
+	rt = ip_route_output(net, ip, 0, 0, 0, RT_SCOPE_LINK);
+	if (IS_ERR(rt))
+		return ERR_CAST(rt);
+
+	dev = rt->dst.dev;
+	ip_rt_put(rt);
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	return dev;
+}
+
 /*
  *	Set (create) an ARP cache entry.
  */
@@ -1045,25 +1066,17 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 static int arp_req_set(struct net *net, struct arpreq *r,
 		       struct net_device *dev)
 {
-	__be32 ip;
 	struct neighbour *neigh;
+	__be32 ip;
 	int err;
 
 	if (r->arp_flags & ATF_PUBL)
 		return arp_req_set_public(net, r, dev);
 
-	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
-
 	if (!dev) {
-		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
-						    RT_SCOPE_LINK);
-
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
-		dev = rt->dst.dev;
-		ip_rt_put(rt);
-		if (!dev)
-			return -EINVAL;
+		dev = arp_req_dev(net, r);
+		if (IS_ERR(dev))
+			return PTR_ERR(dev);
 	}
 	switch (dev->type) {
 #if IS_ENABLED(CONFIG_FDDI)
@@ -1086,6 +1099,8 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 		break;
 	}
 
+	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
+
 	neigh = __neigh_lookup_errno(&arp_tbl, &ip, dev);
 	err = PTR_ERR(neigh);
 	if (!IS_ERR(neigh)) {
@@ -1191,14 +1206,9 @@ static int arp_req_delete(struct net *net, struct arpreq *r,
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 	if (!dev) {
-		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
-						    RT_SCOPE_LINK);
-		if (IS_ERR(rt))
-			return PTR_ERR(rt);
-		dev = rt->dst.dev;
-		ip_rt_put(rt);
-		if (!dev)
-			return -EINVAL;
+		dev = arp_req_dev(net, r);
+		if (IS_ERR(dev))
+			return PTR_ERR(dev);
 	}
 	return arp_invalidate(dev, ip, true);
 }
-- 
2.30.2


