Return-Path: <netdev+bounces-136732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AAD9A2C3C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4357B2690B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32D183CB0;
	Thu, 17 Oct 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SBTY50vk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27B17A589
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190049; cv=none; b=tZM2gtxJr+/UQepOLwLEdaM+ie1MumEigxvxOXogTh0fYK0xYwfAWNQgNDAxunX2YE/PQBl1svQXuzqVQD7RdNAho1v9HPodJFa8bCpsKxE9po99YTMcOWvenPZ2QSfsfzeAeldK4FtV8CgwCQXAhyp2BL4CqhL4nlk5MiAswDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190049; c=relaxed/simple;
	bh=CJYtiRu6LnW/vblRiLGMfCaNHP5KaGjPKbNAfEe/Kvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbGIGw9BMemSV/wfTXjtXQblYkajDxXh4gmSRHzvQ9zifUcQFqbNhG6JR/kaxt2+dHpsX5azY4nnwrpF+RVtZAyYgYL8SpHtGPFrTKbKPe3tIfmqVM7+P6g1GrpBR1trjo9JOt0BuYGDr66yasrDUQYH7twKNye49SSoYm5W/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SBTY50vk; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729190048; x=1760726048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sIFbceOLf291K2eoHLutPSQ/EXnoJkdK3pC8yrD2nQ=;
  b=SBTY50vkP7SKE5c+LaOqBOuZnmyM2F1JWOPG5BfYclFwnBplZ01wHMzB
   xW+65ywUj0fUImxJyNI3q9dKarRkxY711M83Hv6JCHcSBkB1HzfQPAifI
   ny39raKuEv7xlzUaCpiAQCj8M45R8vu6chQxpsRcRfjxYOhdxxHW22WP6
   U=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="767719617"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:34:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:42309]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id d8a264dc-0688-480d-beec-e3189b195baf; Thu, 17 Oct 2024 18:34:02 +0000 (UTC)
X-Farcaster-Flow-ID: d8a264dc-0688-480d-beec-e3189b195baf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:34:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:33:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 7/9] phonet: Pass net and ifindex to rtm_phonet_notify().
Date: Thu, 17 Oct 2024 11:31:38 -0700
Message-ID: <20241017183140.43028-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, rtm_phonet_notify() fetches netns and ifindex from dev.

Once route_doit() is converted to RCU, rtm_phonet_notify() will be
called outside of RCU due to GFP_KERNEL, and dev will be unavailable
there.

Let's pass net and ifindex to rtm_phonet_notify().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/phonet/pn_dev.h |  2 +-
 net/phonet/pn_dev.c         | 10 +++++++---
 net/phonet/pn_netlink.c     | 16 +++++++++-------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/net/phonet/pn_dev.h b/include/net/phonet/pn_dev.h
index ac0331d83a81..021e524fd20a 100644
--- a/include/net/phonet/pn_dev.h
+++ b/include/net/phonet/pn_dev.h
@@ -43,7 +43,7 @@ void phonet_address_notify(struct net *net, int event, u32 ifindex, u8 addr);
 
 int phonet_route_add(struct net_device *dev, u8 daddr);
 int phonet_route_del(struct net_device *dev, u8 daddr);
-void rtm_phonet_notify(int event, struct net_device *dev, u8 dst);
+void rtm_phonet_notify(struct net *net, int event, u32 ifindex, u8 dst);
 struct net_device *phonet_route_get_rcu(struct net *net, u8 daddr);
 struct net_device *phonet_route_output(struct net *net, u8 daddr);
 
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 545279ef5910..6ded0d347b9f 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -263,9 +263,13 @@ static int phonet_device_autoconf(struct net_device *dev)
 
 static void phonet_route_autodel(struct net_device *dev)
 {
-	struct phonet_net *pnn = phonet_pernet(dev_net(dev));
-	unsigned int i;
+	struct net *net = dev_net(dev);
 	DECLARE_BITMAP(deleted, 64);
+	u32 ifindex = dev->ifindex;
+	struct phonet_net *pnn;
+	unsigned int i;
+
+	pnn = phonet_pernet(net);
 
 	/* Remove left-over Phonet routes */
 	bitmap_zero(deleted, 64);
@@ -281,7 +285,7 @@ static void phonet_route_autodel(struct net_device *dev)
 		return; /* short-circuit RCU */
 	synchronize_rcu();
 	for_each_set_bit(i, deleted, 64) {
-		rtm_phonet_notify(RTM_DELROUTE, dev, i);
+		rtm_phonet_notify(net, RTM_DELROUTE, ifindex, i);
 		dev_put(dev);
 	}
 }
diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index c9a4215ec560..bfec5bd639b6 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -200,7 +200,7 @@ static int fill_route(struct sk_buff *skb, u32 ifindex, u8 dst,
 	return -EMSGSIZE;
 }
 
-void rtm_phonet_notify(int event, struct net_device *dev, u8 dst)
+void rtm_phonet_notify(struct net *net, int event, u32 ifindex, u8 dst)
 {
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
@@ -210,17 +210,17 @@ void rtm_phonet_notify(int event, struct net_device *dev, u8 dst)
 	if (skb == NULL)
 		goto errout;
 
-	err = fill_route(skb, dev->ifindex, dst, 0, 0, event);
+	err = fill_route(skb, ifindex, dst, 0, 0, event);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}
-	rtnl_notify(skb, dev_net(dev), 0,
-			  RTNLGRP_PHONET_ROUTE, NULL, GFP_KERNEL);
+
+	rtnl_notify(skb, net, 0, RTNLGRP_PHONET_ROUTE, NULL, GFP_KERNEL);
 	return;
 errout:
-	rtnl_set_sk_err(dev_net(dev), RTNLGRP_PHONET_ROUTE, err);
+	rtnl_set_sk_err(net, RTNLGRP_PHONET_ROUTE, err);
 }
 
 static const struct nla_policy rtm_phonet_policy[RTA_MAX+1] = {
@@ -235,6 +235,7 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[RTA_MAX+1];
 	struct net_device *dev;
 	struct rtmsg *rtm;
+	u32 ifindex;
 	int err;
 	u8 dst;
 
@@ -260,7 +261,8 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (dst & 3) /* Phonet addresses only have 6 high-order bits */
 		return -EINVAL;
 
-	dev = __dev_get_by_index(net, nla_get_u32(tb[RTA_OIF]));
+	ifindex = nla_get_u32(tb[RTA_OIF]);
+	dev = __dev_get_by_index(net, ifindex);
 	if (dev == NULL)
 		return -ENODEV;
 
@@ -269,7 +271,7 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		err = phonet_route_del(dev, dst);
 	if (!err)
-		rtm_phonet_notify(nlh->nlmsg_type, dev, dst);
+		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
 	return err;
 }
 
-- 
2.39.5 (Apple Git-154)


