Return-Path: <netdev+bounces-158406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C5A11B8D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19193A801E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D0236ED0;
	Wed, 15 Jan 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eOZ54NlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964F2361F4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928550; cv=none; b=kzyapLtOZ7wfxYu8m611RCj9OIqa3BAx6tK5xWXPO8dRJj1J/wWtoOltKYoVPvSJThwf327QQkjvHLbi2Pell2zkXYQCqR8Lokx1rUCgJ7yfE2ku1mMAZMp99w8iVLvsEwJYnxqjSiE0rvjVPgH9Lc8U/swnQgBkjx49f1wlDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928550; c=relaxed/simple;
	bh=nzpBKvmTz/8qA591JiqbXFF7v83zJ3vLfLwckKfIYjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4xNYEH119Yv1u1C3ek7bvxCNGTs1e5IUdR4CF6u526kk78CZxbTuYqqlOly8kcSpfWjZfZvddCUVdgrpJ2rHo1CGYzh1LLv8zwBbyuQlxfe1vS3iZCIF1SPMe6ehtiY3MrIynvhMbmMNDwZg+SHQaUsdWSMnNpKpJRbz2lA/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eOZ54NlX; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928549; x=1768464549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biQyjvND8ZWBXLoKmAbl4u3wwQLXyTB06Sn7MdS6Jrs=;
  b=eOZ54NlXO9tuI2uRiMPcZzsrqAnwHrwOwWGI34pZkXEI0bf8TqzfJBLU
   4yUeMZ74VPEPeAkmcv3N00hZBhSeWhWJBM1tWxBXbcOFl6WK/AlYoAlyw
   ZdWEbJqrlUUAVsRV9jeMOi3Q5ijYomuCM/+zoCntmccVYz/t8AI3S3MdF
   4=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="400957524"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:09:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:38127]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.219:2525] with esmtp (Farcaster)
 id 5b4de601-53b1-412f-b717-84dba252120c; Wed, 15 Jan 2025 08:09:07 +0000 (UTC)
X-Farcaster-Flow-ID: 5b4de601-53b1-412f-b717-84dba252120c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:09:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:09:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/11] ipv6: Convert inet6_ioctl() to per-netns RTNL.
Date: Wed, 15 Jan 2025 17:06:03 +0900
Message-ID: <20250115080608.28127-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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


