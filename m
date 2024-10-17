Return-Path: <netdev+bounces-136727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539DB9A2C36
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E016283B9E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411917C7B1;
	Thu, 17 Oct 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="owayeaWv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCE16EB42
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189950; cv=none; b=aREOf3JTY9zjr9fgP+0npa4AM/Vd3OWjcQsgM/WRZhx4/L+K5QWd62M72phbVmbhKevKEN762PFnljllTo6/etWuqknRXK0/eRVzcd2pfCnCCdZl1WdwX+fqa5qW19XjEANhi1B/1ewgPfpiERbHadOsPfLtdrtQ/UdmMggVP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189950; c=relaxed/simple;
	bh=jmqr+EiMLiYsBuK/mPqJA+xzJakliE1oiYcs8QusXpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5VH6PKAAYcBt7wAuPqJsre8bP4dTxctPI2EXk7qeSLbzEGHiWZnSRfk9yClkol6gpuyIcrDYFQ3hZSRtBPNhXHUH8QoE4BD7PjBYTQpdgph6CKBEqTJXP2s2VhMh2o3FWMxIqHWindaXGBVgtSux4kGABuri5cJRfmpdvnYKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=owayeaWv; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729189949; x=1760725949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5AJ4+IPkQ+QDeeUhDf/QSm2KySCaT4eh3AoQDmylbYE=;
  b=owayeaWvEudRzOq5sJxqY8FFC7DtsMtZsPZrj02doTC2Fl4PRypVRfOf
   T9uM+pS6q8pcczM+vNA1dV9P5Jnd2fjBiQwNa9iza9UbmMJye5A1FkVwi
   ndcRCDzC69ZquFQpscmOV6O9k7FtGCgmAwLVwZRruyE9SPViIegyZVjTS
   I=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="343906596"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:32:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:49177]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id b226df2b-85f9-4369-b526-4172a5262619; Thu, 17 Oct 2024 18:32:26 +0000 (UTC)
X-Farcaster-Flow-ID: b226df2b-85f9-4369-b526-4172a5262619
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:32:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:32:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/9] phonet: Pass net and ifindex to phonet_address_notify().
Date: Thu, 17 Oct 2024 11:31:33 -0700
Message-ID: <20241017183140.43028-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241017183140.43028-1-kuniyu@amazon.com>
References: <20241017183140.43028-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, phonet_address_notify() fetches netns and ifindex from dev.

Once addr_doit() is converted to RCU, phonet_address_notify() will be
called outside of RCU due to GFP_KERNEL, and dev will be unavailable
there.

Let's pass net and ifindex to phonet_address_notify().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/phonet/pn_dev.h |  2 +-
 net/phonet/pn_dev.c         | 10 +++++++---
 net/phonet/pn_netlink.c     | 12 ++++++------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/phonet/pn_dev.h b/include/net/phonet/pn_dev.h
index e9dc8dca5817..6b2102b4ece3 100644
--- a/include/net/phonet/pn_dev.h
+++ b/include/net/phonet/pn_dev.h
@@ -38,7 +38,7 @@ int phonet_address_add(struct net_device *dev, u8 addr);
 int phonet_address_del(struct net_device *dev, u8 addr);
 u8 phonet_address_get(struct net_device *dev, u8 addr);
 int phonet_address_lookup(struct net *net, u8 addr);
-void phonet_address_notify(int event, struct net_device *dev, u8 addr);
+void phonet_address_notify(struct net *net, int event, u32 ifindex, u8 addr);
 
 int phonet_route_add(struct net_device *dev, u8 daddr);
 int phonet_route_del(struct net_device *dev, u8 daddr);
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index cde671d29d5d..2e7d850dc726 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -98,10 +98,13 @@ static void phonet_device_destroy(struct net_device *dev)
 	mutex_unlock(&pndevs->lock);
 
 	if (pnd) {
+		struct net *net = dev_net(dev);
+		u32 ifindex = dev->ifindex;
 		u8 addr;
 
 		for_each_set_bit(addr, pnd->addrs, 64)
-			phonet_address_notify(RTM_DELADDR, dev, addr);
+			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
+
 		kfree(pnd);
 	}
 }
@@ -244,8 +247,9 @@ static int phonet_device_autoconf(struct net_device *dev)
 	ret = phonet_address_add(dev, req.ifr_phonet_autoconf.device);
 	if (ret)
 		return ret;
-	phonet_address_notify(RTM_NEWADDR, dev,
-				req.ifr_phonet_autoconf.device);
+
+	phonet_address_notify(dev_net(dev), RTM_NEWADDR, dev->ifindex,
+			      req.ifr_phonet_autoconf.device);
 	return 0;
 }
 
diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 3205d2457477..23097085ad38 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -22,7 +22,7 @@
 static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
 		     u32 portid, u32 seq, int event);
 
-void phonet_address_notify(int event, struct net_device *dev, u8 addr)
+void phonet_address_notify(struct net *net, int event, u32 ifindex, u8 addr)
 {
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
@@ -32,17 +32,17 @@ void phonet_address_notify(int event, struct net_device *dev, u8 addr)
 	if (skb == NULL)
 		goto errout;
 
-	err = fill_addr(skb, dev->ifindex, addr, 0, 0, event);
+	err = fill_addr(skb, ifindex, addr, 0, 0, event);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}
-	rtnl_notify(skb, dev_net(dev), 0,
-		    RTNLGRP_PHONET_IFADDR, NULL, GFP_KERNEL);
+
+	rtnl_notify(skb, net, 0, RTNLGRP_PHONET_IFADDR, NULL, GFP_KERNEL);
 	return;
 errout:
-	rtnl_set_sk_err(dev_net(dev), RTNLGRP_PHONET_IFADDR, err);
+	rtnl_set_sk_err(net, RTNLGRP_PHONET_IFADDR, err);
 }
 
 static const struct nla_policy ifa_phonet_policy[IFA_MAX+1] = {
@@ -89,7 +89,7 @@ static int addr_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		err = phonet_address_del(dev, pnaddr);
 	if (!err)
-		phonet_address_notify(nlh->nlmsg_type, dev, pnaddr);
+		phonet_address_notify(net, nlh->nlmsg_type, ifm->ifa_index, pnaddr);
 	return err;
 }
 
-- 
2.39.5 (Apple Git-154)


