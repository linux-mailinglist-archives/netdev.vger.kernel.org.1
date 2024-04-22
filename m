Return-Path: <netdev+bounces-90254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3348D8AD527
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA5B281BC1
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BAD155335;
	Mon, 22 Apr 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pn5kpeQr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1046A03F
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815371; cv=none; b=YYdNOjy9tjAgYeq1Si2vd1jPfzlkM9E3+wO2PqpFvcLN+kHv8zVF7PgXKQ6zRMMvrB0h90Rid1EKDunxyYxMzStFVL7nhlFXiU29zqS3Fam6X0cumHfE4fLsO1TLD9FE6wHD+a0Wa4I97ITxE56CJaHJ3clEW33YylA3Cd2ELgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815371; c=relaxed/simple;
	bh=HV3BPHqXPDmXYgQpQT1m2Ltigw1Fhh47Ep81QeL09/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFPIrUYoGcaO4VVj4H0cW1PkWWEOGMVhYGtgAQqeDBio8iyO3Z5wL2HrVBT0xVZqrOmcgGf/6QyG3tjcUnPmSdMsJ9BycuqDj9ZUnMZ1mZt9CsoSpcB2bg8c3qu+Z+isGzk/8RtqdG4tUdWUOv5qFCZco6CFXhGWdB4fwShUKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pn5kpeQr; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713815370; x=1745351370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8ijWAzy9Fufp4GKwbIfWSlcbybgK4zD9u8PFQfKdgQ=;
  b=Pn5kpeQrUf8+wfdFdNjU/lqdj4dGI8GAhhDzmI9YidLWbm/PYNhsO19t
   UBL5ki4RVCTwuYRMgMq7qSz5sWUzeNcAf6rbl19OOyQx6zX5qJRo+Mp//
   ZmBVGxMZxQcsz8yIvXdwlcIPhQUujpnVSK+okIKPv5vWAm4QLR7IcYr+7
   M=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="391676862"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:49:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:9998]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.77:2525] with esmtp (Farcaster)
 id 989cd98e-e566-4a87-a495-7728f0162a25; Mon, 22 Apr 2024 19:49:26 +0000 (UTC)
X-Farcaster-Flow-ID: 989cd98e-e566-4a87-a495-7728f0162a25
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:49:26 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:49:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/6] arp: Factorise ip_route_output() call in arp_req_set() and arp_req_delete().
Date: Mon, 22 Apr 2024 12:47:52 -0700
Message-ID: <20240422194755.4221-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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


