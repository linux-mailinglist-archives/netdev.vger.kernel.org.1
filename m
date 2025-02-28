Return-Path: <netdev+bounces-170558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC23A49054
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498CD188E094
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359EB1A08B5;
	Fri, 28 Feb 2025 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rKUVd0Tf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3D19993D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716876; cv=none; b=mZOLgjx3vM8kd8MpNc+7tp2RXlOdi7FNrSuJulT/YI9ABR5llH3vVT4IpqSOSabZC+WDQPMfxYMUvnjQX3GHdi7EJaiGWrpcGvq2+89zrEIoRdPVBklyFQ6ApoDdl7sB1YxU0XnrIHX7uXvMG/ST4bQzFuPy1wZkqijQD2VhbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716876; c=relaxed/simple;
	bh=5E2a5GN+m0jpspODNsWG1e7xCllUNtPogEc3vHeXa8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5HdVZEnJDB1K+GXT1IvBZ9oodk1gAAzOULLLLtxEH7K5a1S8d9EXR1Hty/tPeRmKZ1DANJcC1HmU6i2NZX2VMLNaHfgP4naSHO7htXr/b461pO79/g3r7iQrGgcWIMEZH/7C+69ZoWgkP2FcNbmtEvq971wGERatz0AdzJwmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rKUVd0Tf; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716874; x=1772252874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMtLkZqwxB+B68hOWQPiB5P8O/AMg6q5DKEB9r19J90=;
  b=rKUVd0TfpgK7Q+M3bkIewAZUiJO/fXAmcE5DxHvxMcEOanyKYfkVShHq
   jRKFm9J7LoeZstfhMSpXc+bLrM2sviioOhYjzeBfYvBd585gCjiyig9r8
   JnMdAo18BgAQgqz5Zykq7fI0qjf4qsr3fIt8tP4W4QghPfvwxcdkvdb+m
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="497997050"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:27:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:11741]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id 4620add9-5761-4c5b-9642-f8b791a70503; Fri, 28 Feb 2025 04:27:53 +0000 (UTC)
X-Farcaster-Flow-ID: 4620add9-5761-4c5b-9642-f8b791a70503
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:27:53 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:27:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 10/12] ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
Date: Thu, 27 Feb 2025 20:23:26 -0800
Message-ID: <20250228042328.96624-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCADDRT/SIOCDELRT) calls ip_rt_ioctl() to add/remove a route in
the netns of the specified socket.

Let's hold rtnl_net_lock() there.

Note that rtentry_to_fib_config() can be called without rtnl_net_lock()
if we convert rtentry.dev handling to RCU later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c48ed369b179..a76dacc3e577 100644
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


