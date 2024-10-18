Return-Path: <netdev+bounces-136793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FCF9A320A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DCC280CD9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98C3BBC5;
	Fri, 18 Oct 2024 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sShjd+Kc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AF3A1CD
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214749; cv=none; b=GpZ4P9v4nk4bA4PXWq0wTA3JGyFdaIxwLqVhfDbF1I9T/LfBuZiiYjS+gjYGD4bl69LYikvTPgqUrXuKjoAwlL2kUbsbBrLh3CL/xidhv/O5L+tv9krifG4X+tKPJVEPczwufKVaSlq11nDPR9TsWkoH9QTBHNCZQVahgvNhWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214749; c=relaxed/simple;
	bh=NMQ+tuCz34oZ9i6Z4626257yr8c1nB13ngA8kcB1zDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfdugXLROtHVBityEtvK3xSYDlrKRWDR0j2+2KSchYB2GyA5YnYfj0sdZtNH2OTi+thIg58EGocyfZ8sO8sMoeZP+JC53VfI6QD6igzILTzYNTGAcd7BXpsL6d4iUYHdY+K3rmlJYH4KWpIfUG8PyyZX3cScvApT5ePrAojVI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sShjd+Kc; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214748; x=1760750748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hM4vD1dcp/yNwrTBoFt4N9cdNsXwJYuIwbSSLNj0C34=;
  b=sShjd+KcO4oHXle0YQE2JolEjNYiXfL/DXpdVBuz3NAGBTv/hof4xpgH
   05IdnaQ8jR++kIJ5U/2kfHIqFlTIY2S38ZbRpzbY9mcmInsGWKsgkas1E
   Mn6fQ528aU8jvsV7gpWeBw5va2vKHCgOFL0dg25pALwBSaY2bxxH1aynV
   s=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="139029170"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:25:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:45698]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 0211ab50-450d-4f04-a11c-3a372c53ef83; Fri, 18 Oct 2024 01:25:47 +0000 (UTC)
X-Farcaster-Flow-ID: 0211ab50-450d-4f04-a11c-3a372c53ef83
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:25:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:25:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/11] ipv4: Convert devinet_ioctl() to per-netns RTNL except for SIOCSIFFLAGS.
Date: Thu, 17 Oct 2024 18:22:24 -0700
Message-ID: <20241018012225.90409-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Basically, devinet_ioctl() operates on a single netns.

However, ioctl(SIOCSIFFLAGS) will trigger the netdev notifier
that could touch another netdev in different netns.

Let's use per-netns RTNL helper in devinet_ioctl() and place
ASSERT_RTNL() for SIOCSIFFLAGS.

We will remove ASSERT_RTNL() once RTM_SETLINK and RTM_DELLINK
are converted.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 1cc2c2b4a10a..f4790859ea69 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -574,9 +574,7 @@ static int inet_insert_ifa(struct in_ifaddr *ifa)
 
 static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 {
-	struct in_device *in_dev = __in_dev_get_rtnl(dev);
-
-	ASSERT_RTNL();
+	struct in_device *in_dev = __in_dev_get_rtnl_net(dev);
 
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
@@ -1114,7 +1112,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 		goto out;
 	}
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 
 	ret = -ENODEV;
 	dev = __dev_get_by_name(net, ifr->ifr_name);
@@ -1124,7 +1122,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 	if (colon)
 		*colon = ':';
 
-	in_dev = __in_dev_get_rtnl(dev);
+	in_dev = __in_dev_get_rtnl_net(dev);
 	if (in_dev) {
 		if (tryaddrmatch) {
 			/* Matthias Andree */
@@ -1134,7 +1132,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 			   This is checked above. */
 
 			for (ifap = &in_dev->ifa_list;
-			     (ifa = rtnl_dereference(*ifap)) != NULL;
+			     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
 			     ifap = &ifa->ifa_next) {
 				if (!strcmp(ifr->ifr_name, ifa->ifa_label) &&
 				    sin_orig.sin_addr.s_addr ==
@@ -1148,7 +1146,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 		   comparing just the label */
 		if (!ifa) {
 			for (ifap = &in_dev->ifa_list;
-			     (ifa = rtnl_dereference(*ifap)) != NULL;
+			     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
 			     ifap = &ifa->ifa_next)
 				if (!strcmp(ifr->ifr_name, ifa->ifa_label))
 					break;
@@ -1190,6 +1188,9 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 				inet_del_ifa(in_dev, ifap, 1);
 			break;
 		}
+
+		/* NETDEV_UP/DOWN/CHANGE could touch a peer dev */
+		ASSERT_RTNL();
 		ret = dev_change_flags(dev, ifr->ifr_flags, NULL);
 		break;
 
@@ -1291,7 +1292,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 		break;
 	}
 done:
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 out:
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)


