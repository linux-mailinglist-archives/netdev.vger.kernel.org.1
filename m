Return-Path: <netdev+bounces-158015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495AA101BE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662A83A478A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA9246327;
	Tue, 14 Jan 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K92F9H6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A623278D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842103; cv=none; b=jnA0PxDS+6PFJhH8ttFlrJZyaVVPZOYk6Vf//v6b5HZvspmc0GmIShymrp4Hpyo4cwNfMd6YE4FGkNb/Hsvg46NQdK9yPDPJLDt36VM0MbLrxNygu5+7RsOywKkBCEdmjIflm7zJ6POFQAaS8gf+mIPhtm/H+nCKm6H475ftQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842103; c=relaxed/simple;
	bh=nzpBKvmTz/8qA591JiqbXFF7v83zJ3vLfLwckKfIYjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUA8bRn5kvyJbsjVqTHYi0dBaZnka5qWSzBiJtld0ghjFZsx279XsfJS0Wxpndr2fXkQzOidQHRnwjwAbtUXMGf/jZV8vd6eDZgLrRNuRsF8azPmGKGc9sVUcvkyvw8YV6oBKf0IVS++GU44G/hEkRgOgDYhAi3ClkoHg5MBVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K92F9H6y; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842102; x=1768378102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biQyjvND8ZWBXLoKmAbl4u3wwQLXyTB06Sn7MdS6Jrs=;
  b=K92F9H6yH5QO39fk+w9nxAmiuDPmqYaI1+XrfxCn0dN6F+XY3BOzKg8q
   ahGTWDO8470reBMn9vYTzmJ/lmAH38nVTcz7I8ZtjddiD4FWVG/VNRZd4
   dWoU3Py33KQR2L/4fQidQ3X04P2ZncpIYNoi0aGMEd7meK2lr2YhajEze
   A=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="463924782"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:08:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:33897]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.27:2525] with esmtp (Farcaster)
 id b70edd7d-ab7e-474b-b3f0-20b956e61a07; Tue, 14 Jan 2025 08:08:19 +0000 (UTC)
X-Farcaster-Flow-ID: b70edd7d-ab7e-474b-b3f0-20b956e61a07
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:08:19 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:08:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/11] ipv6: Convert inet6_ioctl() to per-netns RTNL.
Date: Tue, 14 Jan 2025 17:05:11 +0900
Message-ID: <20250114080516.46155-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

These functions are called from inet6_ioctl() with a socket's netns
and hold RTNL.

  * SIOCSIFADDR    : addrconf_add_ifaddr()
  * SIOCDIFADDR    : addrconf_del_ifaddr()
  * SIOCSIFDSTADDR : addrconf_set_dstaddr()

Let's use rtnl_net_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4d1ec290a259..9c7257b28a84 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2979,11 +2979,11 @@ int addrconf_set_dstaddr(struct net *net, void __user *arg)
 	if (copy_from_user(&ireq, arg, sizeof(struct in6_ifreq)))
 		return -EFAULT;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
 	if (dev && dev->type == ARPHRD_SIT)
 		err = addrconf_set_sit_dstaddr(net, dev, &ireq);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	return err;
 }
 
@@ -3181,9 +3181,9 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 	cfg.pfx = &ireq.ifr6_addr;
 	cfg.plen = ireq.ifr6_prefixlen;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	err = inet6_addr_add(net, ireq.ifr6_ifindex, &cfg, NULL);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	return err;
 }
 
@@ -3198,10 +3198,10 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
 	if (copy_from_user(&ireq, arg, sizeof(struct in6_ifreq)))
 		return -EFAULT;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	err = inet6_addr_del(net, ireq.ifr6_ifindex, 0, &ireq.ifr6_addr,
 			     ireq.ifr6_prefixlen, NULL);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	return err;
 }
 
-- 
2.39.5 (Apple Git-154)


