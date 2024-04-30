Return-Path: <netdev+bounces-92297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69428B67C2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97534285542
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B398F6D;
	Tue, 30 Apr 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c0xoYs0w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDC8BF6
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442386; cv=none; b=mUQN0EvuPKb3b3LuT0jxE/7SQdCT7DkzEWXrG3HYYIdLBTIq4uj3clwAX6hlVtzZnEuhGDk8BgHIl3IG7HiImNbHyw5P3Q5brIhb0vG0cvJf+Au08G+b3qXvDDIAOh6xVmR8i4DsEXK9CBFvRh6S7iAajXvBkCxZYhTPq9tMHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442386; c=relaxed/simple;
	bh=HV3BPHqXPDmXYgQpQT1m2Ltigw1Fhh47Ep81QeL09/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maS5uNImiC43x6awfv8CAfMAhA2IAeX7KxbX+gHqnGkKAE4FI/bDsZ71LIkxuwLrdJGUnIsl4ChuKZ+9+hF5TCqj9c9REgTvMnswEPndYSfTqaxYXm8NMXnqhYm/hq0b+9ohb2DzdCkNj92Rc4gQPR+p0NqYmiBeF5i1gMTaciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c0xoYs0w; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442385; x=1745978385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8ijWAzy9Fufp4GKwbIfWSlcbybgK4zD9u8PFQfKdgQ=;
  b=c0xoYs0w2tGRNNdLwbuFvb6HCta+Fijf3HPUPT9A6HcjUJJ6zdO/0NQc
   tGWWQKtKzHtckNPOKf6pQnczgdjhmA7ADbRCOMdVB5xQojblv2KJ3BkkW
   WogYiXYrR5SHkeeltF5+NIQtked2FYt0CVBEbodY7mlOt7N9GAWjBaMtq
   M=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="291627914"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:59:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:19312]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.38:2525] with esmtp (Farcaster)
 id ec8018e2-aa2c-4a76-a2d9-d534a410a6eb; Tue, 30 Apr 2024 01:59:41 +0000 (UTC)
X-Farcaster-Flow-ID: ec8018e2-aa2c-4a76-a2d9-d534a410a6eb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:59:40 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 30 Apr 2024 01:59:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 3/7] arp: Factorise ip_route_output() call in arp_req_set() and arp_req_delete().
Date: Mon, 29 Apr 2024 18:58:09 -0700
Message-ID: <20240430015813.71143-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
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


