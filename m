Return-Path: <netdev+bounces-90253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A18AD526
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF3B23A84
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63519155335;
	Mon, 22 Apr 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n/LMCIJU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA8155310
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815345; cv=none; b=A4GKBEwITqvr/ET8/R7BgSWI9cXUJr6gf5akj231RQWoOhDuAYK8oxKz3xLodQkclqEO2aW+ZPGWA6xDMTYKRcH7nD4y+u62QJNJUXOSzGom3o8qFwOmRXxCZTzgQ9CTErkZw27sArO3ijd/3aKtoJGuWu2+hmiEzoN+ahYvW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815345; c=relaxed/simple;
	bh=8nLfXofPYxLC/qRA6lX/xKdJmDzQNvmSO6A50KVMCgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AP8P+SUo4s7kfkirkA5N0q8LptNcRkasEGr8p7wrvQdF4UAoTCCuEZY5l+Qq7bUg8GM9zPza85mhQI7Z9UShsUDG+ZwMGIxVahuceyX6Nd2I+be8a3kHRwYDZIzAkt2FkLG1fLZ2ectaJdEDLexqi/NFTXfF90XeZI05V6x2CDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n/LMCIJU; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713815345; x=1745351345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XNxwJUTQlpDDvyH0259WoW+9/hOr/wutWBc0IDS76W0=;
  b=n/LMCIJUsXVWRW2908naTjPMajsMdUOCqbNrIjUY8QIhIcmnTuV6kVAl
   6M1rREc+Y85MQ1LsrBHV+zW6lAHfEKkLl9R7kxGSppC4b9rgqy+oYapZV
   o7bJPQ4FU7HzVkDpxUO9Bou5/3zKEWxbSzw01ht0WCVrbDCFylEOafl8J
   k=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="290920917"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:49:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21040]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.77:2525] with esmtp (Farcaster)
 id d0616ecb-4737-4b5b-9af3-ca489e82164f; Mon, 22 Apr 2024 19:49:01 +0000 (UTC)
X-Farcaster-Flow-ID: d0616ecb-4737-4b5b-9af3-ca489e82164f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:49:01 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:48:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/6] arp: Validate netmask earlier for SIOCDARP and SIOCSARP in arp_ioctl().
Date: Mon, 22 Apr 2024 12:47:51 -0700
Message-ID: <20240422194755.4221-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When ioctl(SIOCDARP/SIOCSARP) is issued with ATF_PUBL, r.arp_netmask
must be 0.0.0.0 or 255.255.255.255.

Currently, the netmask is validated in arp_req_delete_public() or
arp_req_set_public() under rtnl_lock().

We have ATF_NETMASK test in arp_ioctl() before holding rtnl_lock(),
so let's move the netmask validation there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 3093374165fa..b20a5771d069 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1023,11 +1023,8 @@ static int arp_req_set_proxy(struct net *net, struct net_device *dev, int on)
 static int arp_req_set_public(struct net *net, struct arpreq *r,
 		struct net_device *dev)
 {
-	__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
-	if (mask && mask != htonl(0xFFFFFFFF))
-		return -EINVAL;
 	if (!dev && (r->arp_flags & ATF_COM)) {
 		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
@@ -1035,6 +1032,8 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 			return -ENODEV;
 	}
 	if (mask) {
+		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
+
 		if (!pneigh_lookup(&arp_tbl, net, &ip, dev, 1))
 			return -ENOBUFS;
 		return 0;
@@ -1171,14 +1170,13 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 static int arp_req_delete_public(struct net *net, struct arpreq *r,
 		struct net_device *dev)
 {
-	__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
-	if (mask == htonl(0xFFFFFFFF))
-		return pneigh_delete(&arp_tbl, net, &ip, dev);
+	if (mask) {
+		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-	if (mask)
-		return -EINVAL;
+		return pneigh_delete(&arp_tbl, net, &ip, dev);
+	}
 
 	return arp_req_set_proxy(net, dev, 0);
 }
@@ -1211,9 +1209,10 @@ static int arp_req_delete(struct net *net, struct arpreq *r,
 
 int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 {
-	int err;
-	struct arpreq r;
 	struct net_device *dev = NULL;
+	struct arpreq r;
+	__be32 *netmask;
+	int err;
 
 	switch (cmd) {
 	case SIOCDARP:
@@ -1236,9 +1235,13 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 	if (!(r.arp_flags & ATF_PUBL) &&
 	    (r.arp_flags & (ATF_NETMASK | ATF_DONTPUB)))
 		return -EINVAL;
+
+	netmask = &((struct sockaddr_in *)&r.arp_netmask)->sin_addr.s_addr;
 	if (!(r.arp_flags & ATF_NETMASK))
-		((struct sockaddr_in *)&r.arp_netmask)->sin_addr.s_addr =
-							   htonl(0xFFFFFFFFUL);
+		*netmask = htonl(0xFFFFFFFFUL);
+	else if (*netmask && *netmask != htonl(0xFFFFFFFFUL))
+		return -EINVAL;
+
 	rtnl_lock();
 	if (r.arp_dev[0]) {
 		err = -ENODEV;
-- 
2.30.2


