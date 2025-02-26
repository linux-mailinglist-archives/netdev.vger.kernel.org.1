Return-Path: <netdev+bounces-169985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6C3A46B18
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F002116E8B1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD530234966;
	Wed, 26 Feb 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T5fKp2ol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417621ABA9
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598297; cv=none; b=rJM7GgK80OIXPno+icBZx1VWCX/wWb+WYM59SW0ggAG9TQ5TAp6WjKrqsb3Gd+yzIiiJhw6JENPJATZdE1TuKx6Wy2eEcv+4ki2g/uLYBiTyY7z0kgsW1o2IZk8Ij3O9vq2NcQ/e6FqQGWq7IQWpQrMVpvInFuqf/wLSTh+QmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598297; c=relaxed/simple;
	bh=WqIeWs5TOBaXtLnowolkiUPXc9jeoxpqC7RapXgPTic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBDB97h3cFzITjG8y0i59idv0QYm0CZJPB64/K5IrTi2QjrHU+6XU89CgZnWw89TUuNgRn2TcitY5EHFxeh334GSx+wXFTsGdxiYsn8Mx+IadWyJxPW7GAO8Vv0n1jRPg1bi5W1cl3zYZGEQQgcCX/+W3Jz3o7t6LGVAdM8CHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T5fKp2ol; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598293; x=1772134293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfK8FEFW5RMVO5+IYO4ybU2+lGS8HhROHjUl+Xt4IZM=;
  b=T5fKp2olW8tygvMvie6FeumfMN2pGMVgHUzi1E5ILBr2/cGYmNS4kzxK
   g9FUNNIF5c70QU66FygFyUx7PPVXD0fKC/80dZmrLhp+pf+9F8pMX8Cke
   1Mh4Og+gjFQBgsLhoUj7OL8O0bdIUFhb5nRqZk+7AQpstYtLqQj1EIS19
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="466073849"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:30:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:51063]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.186:2525] with esmtp (Farcaster)
 id 37dd9a89-a21a-4ea0-904c-92f6e6448853; Wed, 26 Feb 2025 19:30:15 +0000 (UTC)
X-Farcaster-Flow-ID: 37dd9a89-a21a-4ea0-904c-92f6e6448853
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:30:15 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:30:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/12] ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
Date: Wed, 26 Feb 2025 11:25:54 -0800
Message-ID: <20250226192556.21633-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCADDRT/SIOCDELRT) calls ip_rt_ioctl() to add/remove a route in
the netns of the specified socket.

Let's hold rtnl_net_lock() there.

Note that rtentry_to_fib_config() can be called without rtnl_net_lock()
if we convert rtentry.dev handling to RCU later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


