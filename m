Return-Path: <netdev+bounces-169585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45918A44AA5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD14B881A02
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B26C14F9C4;
	Tue, 25 Feb 2025 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j7+in+mP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BE17B418
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508050; cv=none; b=ILMO+TorTGmE96RRKw31BJ8mhh3h5ssl75wa96eoXAF7OOZZ0SqzTGOg1MwNzS7qCWAfMuijqnpM5G9fjQEwSKIssOa64FI/9d9zOL1+roRyhqk3/AoqmnrHeG/74WfmkIB7zX6a7hq1IodYkVistNO5eq++g8sV9x9ONgFW6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508050; c=relaxed/simple;
	bh=6fka2yx/cc7fS3AxRU5Gk23ZVpiX/1vViQus6b9bxRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seS40+eWgQngcIYBEOlihL8GWP7OuAbYzK3WNXk5jD0uwcI7w4A7bE2846MBUvUWkKE1OORABGX7WvR1U0SEWZR2xNBMhMaTvTP0K1g5aq4PbmgcT/oUtGz2dJr52xKbBL8Sgv59vS9SMSJ03UCEmRfwUuV/WGIjFR+ExQzhCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j7+in+mP; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740508049; x=1772044049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7RhlVM3t8VGKwXm9T97zNPtPVEhhqDY7dqP8as5470=;
  b=j7+in+mP8Fg0ZMu/Noc7pvH1lCe1cwU4cZmuNXdrEjivWVgVwJ+EHCUG
   kPyKSqTH66TE3FCo86UA2BQO8hs+1ZhDs6OqfKxmzcDkqxXJB/ZvDc3fz
   4w2SX4VS910bYXoKPffIjGvZCEq0aZEbj9vbLNcW0y+rB0AIJ09dOZGei
   s=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="801938254"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:27:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:39710]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 50fd57c1-86a8-463b-b1ba-6731142d532f; Tue, 25 Feb 2025 18:27:19 +0000 (UTC)
X-Farcaster-Flow-ID: 50fd57c1-86a8-463b-b1ba-6731142d532f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:27:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:27:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/12] ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
Date: Tue, 25 Feb 2025 10:22:48 -0800
Message-ID: <20250225182250.74650-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225182250.74650-1-kuniyu@amazon.com>
References: <20250225182250.74650-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCADDRT/SIOCDELRT) calls ip_rt_ioctl() to add/remove a route in
the netns of the specified socket.

Let's hold rtnl_net_lock() there.

Note that rtentry_to_fib_config() can be called without rtnl_net_lock()
if we convert rtentry.dev handling to RCU later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/fib_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index ad3a36bc928b..180c1944c064 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -553,18 +553,16 @@ static int rtentry_to_fib_config(struct net *net, int cmd, struct rtentry *rt,
 			const struct in_ifaddr *ifa;
 			struct in_device *in_dev;
 
-			in_dev = __in_dev_get_rtnl(dev);
+			in_dev = __in_dev_get_rtnl_net(dev);
 			if (!in_dev)
 				return -ENODEV;
 
 			*colon = ':';
 
-			rcu_read_lock();
-			in_dev_for_each_ifa_rcu(ifa, in_dev) {
+			in_dev_for_each_ifa_rtnl_net(net, ifa, in_dev) {
 				if (strcmp(ifa->ifa_label, devname) == 0)
 					break;
 			}
-			rcu_read_unlock();
 
 			if (!ifa)
 				return -ENODEV;
@@ -635,7 +633,7 @@ int ip_rt_ioctl(struct net *net, unsigned int cmd, struct rtentry *rt)
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		rtnl_lock();
+		rtnl_net_lock(net);
 		err = rtentry_to_fib_config(net, cmd, rt, &cfg);
 		if (err == 0) {
 			struct fib_table *tb;
@@ -659,7 +657,7 @@ int ip_rt_ioctl(struct net *net, unsigned int cmd, struct rtentry *rt)
 			/* allocated by rtentry_to_fib_config() */
 			kfree(cfg.fc_mx);
 		}
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 		return err;
 	}
 	return -EINVAL;
-- 
2.39.5 (Apple Git-154)


