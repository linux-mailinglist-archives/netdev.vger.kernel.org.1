Return-Path: <netdev+bounces-158404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E53A11B86
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A03A32F7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565DF22F830;
	Wed, 15 Jan 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NFTzxDKD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAE22F3AF
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928503; cv=none; b=ZCs6I1UzNuQv8MSMGhu/Kzl6RDqErDhHdOW5+Dzpbvfq8pgM4/1Dbz9W/pDh6bxTDxsYy0A5YSC1zJqOebsn6KdS6A8cC4uINLXnOMu14EThmQ/L+ZmTMBNB1jZx0zXvVHDSAz6mBIJCK1CnTsu6gZB9HKveysKMAjP/Ml2xaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928503; c=relaxed/simple;
	bh=bjtD3EQ97Y7om98Rqyz6Myt9ujmQxwtqImTBfHYY4fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwCEvyJFbqwlx5YFt9GXA7TtHYVRjgp+qQStFj9RBLy10H7EXn4VA6wQPdm1NOezKFvYGIoqhG67Y2VwrDOzS8nOY8YMSnUR7JglL+2/dhk339T42KhTzfg3vMqMfeKTHON/S6RyD9p45eZJAaMK2ljjIGyekalf3EDfNzgSU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NFTzxDKD; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928502; x=1768464502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvMdKy5xN3GS2Nzc7pJw11zXpCMKbtq9u+xwI3h57b8=;
  b=NFTzxDKDHd/qZ/ZDp4x5l56eAR3L1kEYb7DvkFXbe2JXtQuQc8xK4Eu5
   lFL0rOG0hSijkImj2G6edqSE3m4Tfg83fSywHsQH7TV1YV+3vyMaB8czL
   l8z0G8F0stkOltM+y81jf71FK4iW5ksSuw1NYEJMbQllqrbJef3rnJrqg
   0=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="689346326"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:08:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:51370]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.5:2525] with esmtp (Farcaster)
 id 474a48a0-6145-4e4a-9254-bade37baec24; Wed, 15 Jan 2025 08:08:16 +0000 (UTC)
X-Farcaster-Flow-ID: 474a48a0-6145-4e4a-9254-bade37baec24
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:08:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:08:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/11] ipv6: Hold rtnl_net_lock() in addrconf_dad_work().
Date: Wed, 15 Jan 2025 17:06:01 +0900
Message-ID: <20250115080608.28127-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

addrconf_dad_work() is per-address work and holds RTNL internally.

We can fetch netns as dev_net(ifp->idev->dev).

Let's use rtnl_net_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index fe85cb2d49c8..e297cd6f9fd2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4204,6 +4204,7 @@ static void addrconf_dad_work(struct work_struct *w)
 	struct inet6_dev *idev = ifp->idev;
 	bool bump_id, disable_ipv6 = false;
 	struct in6_addr mcaddr;
+	struct net *net;
 
 	enum {
 		DAD_PROCESS,
@@ -4211,7 +4212,9 @@ static void addrconf_dad_work(struct work_struct *w)
 		DAD_ABORT,
 	} action = DAD_PROCESS;
 
-	rtnl_lock();
+	net = dev_net(idev->dev);
+
+	rtnl_net_lock(net);
 
 	spin_lock_bh(&ifp->lock);
 	if (ifp->state == INET6_IFADDR_STATE_PREDAD) {
@@ -4221,7 +4224,7 @@ static void addrconf_dad_work(struct work_struct *w)
 		action = DAD_ABORT;
 		ifp->state = INET6_IFADDR_STATE_POSTDAD;
 
-		if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->accept_dad) > 1 ||
+		if ((READ_ONCE(net->ipv6.devconf_all->accept_dad) > 1 ||
 		     READ_ONCE(idev->cnf.accept_dad) > 1) &&
 		    !idev->cnf.disable_ipv6 &&
 		    !(ifp->flags & IFA_F_STABLE_PRIVACY)) {
@@ -4303,7 +4306,7 @@ static void addrconf_dad_work(struct work_struct *w)
 		      ifp->dad_nonce);
 out:
 	in6_ifa_put(ifp);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 }
 
 /* ifp->idev must be at least read locked */
-- 
2.39.5 (Apple Git-154)


