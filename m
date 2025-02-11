Return-Path: <netdev+bounces-165042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7355AA3029E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 05:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E346162CAB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD21D61BB;
	Tue, 11 Feb 2025 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EbhIPdOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297E2F5E
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739249480; cv=none; b=mlK41tUiYxDyMikK4IWYQiKlxHrHooOVD8n0TWL7EaHUii2jzabFfS/5ckvAUeV/AOm2OD8FCGzUoC+LB3IRO5TqFXwEPZ+Vz+cyZlIHbNIFYTfLSJDoiP/B4xh9grFHqzF2YGXYNs010GZzcOnmd/f+iWf/RM93js8ubg98o1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739249480; c=relaxed/simple;
	bh=o7ZD/WBXHcMGqIzu8isxg03QvGPlALp0jzjipH43UQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=us1nLtjSEmPFUtdJWw8jXWHjNYltYyncJfuRXfLKnA4bo9fmyuTcyS/IMoOinfHWbQse/W45wnPOjOzqMdjwjcxF16SoLn6OrGWHG8EPp2nlKZ9SgDrf8iLqUrI6MRn8r82W8wkPv4mLMaxLBzsE0oaIKvRXdjiFJ51gGXOFGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EbhIPdOC; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739249479; x=1770785479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O88RaQEwuSgA8/FO2gnO6iLOZahEXsQtSjcxAxKEb4o=;
  b=EbhIPdOC+o+Lu79HEk7GOmXWvZsdRwue9D+vB88iupFreR/D9Lu999/d
   9NBXF9+lm/POVR7RkaCf8g6HEZ+pNwm8d0gqFKXa9DI1n1Yn61ZOTzzAH
   OG5e7VnKwow/ckiFWbHvGYuBiI1a/n4Xs5MWWlByL/tYPe8tGV2E7D3ep
   c=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="461444257"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:51:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:31597]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id c2c57d0b-9de0-4f44-bcd1-4c914d9cdb17; Tue, 11 Feb 2025 04:51:13 +0000 (UTC)
X-Farcaster-Flow-ID: c2c57d0b-9de0-4f44-bcd1-4c914d9cdb17
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 04:51:13 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 04:51:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] arp: Convert SIOCDARP and SIOCSARP to per-netns RTNL.
Date: Tue, 11 Feb 2025 13:50:57 +0900
Message-ID: <20250211045057.10419-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCDARP/SIOCSARP) operates on a single netns fetched from
an AF_INET socket in inet_ioctl().

Let's hold rtnl_net_lock() for SIOCDARP and SIOCSARP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index cb9a7ed8abd3..431d900c136c 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1062,8 +1062,8 @@ static int arp_req_set_proxy(struct net *net, struct net_device *dev, int on)
 		IPV4_DEVCONF_ALL(net, PROXY_ARP) = on;
 		return 0;
 	}
-	if (__in_dev_get_rtnl(dev)) {
-		IN_DEV_CONF_SET(__in_dev_get_rtnl(dev), PROXY_ARP, on);
+	if (__in_dev_get_rtnl_net(dev)) {
+		IN_DEV_CONF_SET(__in_dev_get_rtnl_net(dev), PROXY_ARP, on);
 		return 0;
 	}
 	return -ENXIO;
@@ -1293,14 +1293,14 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 
 	switch (cmd) {
 	case SIOCDARP:
-		rtnl_lock();
+		rtnl_net_lock(net);
 		err = arp_req_delete(net, &r);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 		break;
 	case SIOCSARP:
-		rtnl_lock();
+		rtnl_net_lock(net);
 		err = arp_req_set(net, &r);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 		break;
 	case SIOCGARP:
 		rcu_read_lock();
-- 
2.39.5 (Apple Git-154)


