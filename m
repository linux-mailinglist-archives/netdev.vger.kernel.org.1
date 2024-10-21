Return-Path: <netdev+bounces-137615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A179B9A727A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA8C1F257E1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF191F9AB1;
	Mon, 21 Oct 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p4OSjTT1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A91DF754
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535783; cv=none; b=snUYTTCMhrS50lZzdcEqIdN79Kece3Ch+JjbHoHDN6+MSByDWt2tV45Cm3Q1HejS8d4MxBKXhwA5k4nfF9wM1pLKOSbqC9p74dFeq1uCsginU6HgU2LZnzl7lEiNeT6nDWwQTi590yJu8kmY1lQDa6A7okrWnEMy8BtqRtaP4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535783; c=relaxed/simple;
	bh=I32w/hAESFnwtHqY8brOqiC1ZGxBhcMyhqA9FCbIpYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQPhzDq/zXAXHWF0NOlsPeLDiYQBrs4wF7UK87BOzTlBK5RlKgyICe0w5rmeExGlc1pzR6cYXIEoeLncatx8b/jmToNLasHFQq43GKW+TMKa2vpNuoS9WWJ/GBOr5W55QhM2TPlYvVn5FAhL8Z2c9RxU2XFokGPWtsWsemWqtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p4OSjTT1; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535782; x=1761071782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTQq56tLQMMpcdJDcw1ls/VPf35Xp1XABNUi0W6KC/8=;
  b=p4OSjTT1phTR2vgETz0QqFuqL5W6/ggX55Ain4yBZdn9DdEFlf9vqLqP
   3/EKT2JxKYKUXA8Y4z+nioltKUrwF1DR8LFA9bAr/YoAWVr7KQvSNbTzd
   zPHVK55xfRPQkNWmDwe+BGkouOrZZ0PaE7CYlyvWq6sqNWtCzwTsmWSWG
   8=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="442698936"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:36:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:17676]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 4a1085e3-f2b7-4800-804e-ef824db548fe; Mon, 21 Oct 2024 18:36:15 +0000 (UTC)
X-Farcaster-Flow-ID: 4a1085e3-f2b7-4800-804e-ef824db548fe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:36:14 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:36:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/12] ipv4: Convert devinet_ioctl() to per-netns RTNL except for SIOCSIFFLAGS.
Date: Mon, 21 Oct 2024 11:32:38 -0700
Message-ID: <20241021183239.79741-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Basically, devinet_ioctl() operates on a single netns.

However, ioctl(SIOCSIFFLAGS) will trigger the netdev notifier
that could touch another netdev in different netns.

Let's use per-netns RTNL helper in devinet_ioctl() and place
ASSERT_RTNL() for SIOCSIFFLAGS.

We will remove ASSERT_RTNL() once RTM_SETLINK and RTM_DELLINK
are converted.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index dcfc060694fa..fb6320f144c5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -589,9 +589,7 @@ static int inet_insert_ifa(struct in_ifaddr *ifa)
 
 static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 {
-	struct in_device *in_dev = __in_dev_get_rtnl(dev);
-
-	ASSERT_RTNL();
+	struct in_device *in_dev = __in_dev_get_rtnl_net(dev);
 
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
@@ -1129,7 +1127,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 		goto out;
 	}
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 
 	ret = -ENODEV;
 	dev = __dev_get_by_name(net, ifr->ifr_name);
@@ -1139,7 +1137,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 	if (colon)
 		*colon = ':';
 
-	in_dev = __in_dev_get_rtnl(dev);
+	in_dev = __in_dev_get_rtnl_net(dev);
 	if (in_dev) {
 		if (tryaddrmatch) {
 			/* Matthias Andree */
@@ -1149,7 +1147,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 			   This is checked above. */
 
 			for (ifap = &in_dev->ifa_list;
-			     (ifa = rtnl_dereference(*ifap)) != NULL;
+			     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
 			     ifap = &ifa->ifa_next) {
 				if (!strcmp(ifr->ifr_name, ifa->ifa_label) &&
 				    sin_orig.sin_addr.s_addr ==
@@ -1163,7 +1161,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 		   comparing just the label */
 		if (!ifa) {
 			for (ifap = &in_dev->ifa_list;
-			     (ifa = rtnl_dereference(*ifap)) != NULL;
+			     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
 			     ifap = &ifa->ifa_next)
 				if (!strcmp(ifr->ifr_name, ifa->ifa_label))
 					break;
@@ -1205,6 +1203,9 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 				inet_del_ifa(in_dev, ifap, 1);
 			break;
 		}
+
+		/* NETDEV_UP/DOWN/CHANGE could touch a peer dev */
+		ASSERT_RTNL();
 		ret = dev_change_flags(dev, ifr->ifr_flags, NULL);
 		break;
 
@@ -1306,7 +1307,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
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


