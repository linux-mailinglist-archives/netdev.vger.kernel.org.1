Return-Path: <netdev+bounces-137613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850A9A7275
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E041F2581A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A561FA254;
	Mon, 21 Oct 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="awgtr06W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BD1EF941
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535760; cv=none; b=Q0IL2JqsOQybU6AnGWFOcHihSvfuSqMSH/H+k7uO9ExNJ7tNhGo/QxnYNDqyVMRQ0ZluhH61k+DPddi9ksp/EP6eAko3eD8K7pPo+NY1vc4EtIvLH8qUnctIChcQiZ4WfeI5FVbFPu3ebaQGm3XG5e4DhYvg6dZi9gcOYWkBSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535760; c=relaxed/simple;
	bh=cx+xUQxjYib/N5aI4RBpQJgbFpJ5+vjd1acg7hlXVjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLMQtCMGuYSTP+uJGpTFyTqXuN3C4uur2DhqBZb615iQ89rscNj1rpYrJXuDav1SWrbg75YyAzB5/Bll3X4j1Ran6mSihsr0lfTxDe6vB2A6JhH9I8NY216n6kG1bp8DhI60z3neE2WhB5eNe9WN4BoGuub6EWvEIB9f+4Ciabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=awgtr06W; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535759; x=1761071759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lwqS4O+iU9VmyvLJC+NwU4B1jeW5RgJY3mWNtJBI2Vk=;
  b=awgtr06WtWmUbbDZ+yWIYVIfXtilirRUJHV52ZiX07fll/vG0sSSgi34
   pYT+MfOs9jjKK9Mg2rYllTMadjk3vTuCTBokLuyUnvUAdrULvFS/FBFtM
   LRa0r5CtzI5JnbdPS1ihCO+4lxqS9Acl6ONmIJ06upNVn1OjSw+Dheym1
   s=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="241197965"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:35:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:47205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.20:2525] with esmtp (Farcaster)
 id fd0b1120-ba7a-45b7-88c0-f9626a145a9c; Mon, 21 Oct 2024 18:35:56 +0000 (UTC)
X-Farcaster-Flow-ID: fd0b1120-ba7a-45b7-88c0-f9626a145a9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:35:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:35:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/12] ipv4: Convert devinet_sysctl_forward() to per-netns RTNL.
Date: Mon, 21 Oct 2024 11:32:37 -0700
Message-ID: <20241021183239.79741-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

devinet_sysctl_forward() touches only a single netns.

Let's use rtnl_trylock() and __in_dev_get_rtnl_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 260df53ff342..dcfc060694fa 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2395,7 +2395,7 @@ static void inet_forward_change(struct net *net)
 		if (on)
 			dev_disable_lro(dev);
 
-		in_dev = __in_dev_get_rtnl(dev);
+		in_dev = __in_dev_get_rtnl_net(dev);
 		if (in_dev) {
 			IN_DEV_CONF_SET(in_dev, FORWARDING, on);
 			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
@@ -2486,7 +2486,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 
 	if (write && *valp != val) {
 		if (valp != &IPV4_DEVCONF_DFLT(net, FORWARDING)) {
-			if (!rtnl_trylock()) {
+			if (!rtnl_net_trylock(net)) {
 				/* Restore the original values before restarting */
 				*valp = val;
 				*ppos = pos;
@@ -2505,7 +2505,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 							    idev->dev->ifindex,
 							    cnf);
 			}
-			rtnl_unlock();
+			rtnl_net_unlock(net);
 			rt_cache_flush(net);
 		} else
 			inet_netconf_notify_devconf(net, RTM_NEWNETCONF,
-- 
2.39.5 (Apple Git-154)


