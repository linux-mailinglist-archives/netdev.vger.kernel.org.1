Return-Path: <netdev+bounces-158013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4ACA101B8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1C37A0F8E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637A243356;
	Tue, 14 Jan 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="muq1pmoy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEF246327
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842049; cv=none; b=d5gURf8kaAn/TQQ/ebXaonMBNmK8WL3s4ppfYJaQ430Ex3xng9c7GmcNiEqZu+3fPte/IsNiQqMXklPGbXwluz/ERTpmUa7/y6VqrsdcfkNcSo8/1AVNbyu2b1rJmfqdhwhWDkhxEfk4a0zRv4kZr2dBtSnXg1fTCzSNMVKwprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842049; c=relaxed/simple;
	bh=bjtD3EQ97Y7om98Rqyz6Myt9ujmQxwtqImTBfHYY4fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A33IZe8A/S2QyhqUayNk6GNibQlAUsSI54PRyYwKCja3gWSuGIPyQiDUhiV1bTG+L5Sxo2BlgDgtoq3SkQ5m+8AQ1DOKvE2pIIruh5qhPLJWrQXCzUuYg9pRvXnMrJytCxKRjO+G/2CW0KsKaSq8Mw3wkNSjEGL+qilkkmd55Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=muq1pmoy; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736842047; x=1768378047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvMdKy5xN3GS2Nzc7pJw11zXpCMKbtq9u+xwI3h57b8=;
  b=muq1pmoyNcIL4/IOj2C3K8JsMDdIZ3DczNlOgQbuW70JEp5XWPdCxP3v
   51t1xOBHk/Fxkt3zUyv9dsUSM5ipJ6WQFGHl7PNuSjvLNJYykTqJqCB6X
   QXoNAr6w+hsD60JGCdjcUAwjtP77Pi32vWQiAQ2iqXCXdWp280thSz87S
   I=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="161242276"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:07:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30646]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.5:2525] with esmtp (Farcaster)
 id 826325d8-8860-4622-a0a7-320a394a0150; Tue, 14 Jan 2025 08:07:24 +0000 (UTC)
X-Farcaster-Flow-ID: 826325d8-8860-4622-a0a7-320a394a0150
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:07:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:07:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/11] ipv6: Hold rtnl_net_lock() in addrconf_dad_work().
Date: Tue, 14 Jan 2025 17:05:09 +0900
Message-ID: <20250114080516.46155-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
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


