Return-Path: <netdev+bounces-142213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB09BDD0B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D969E1C22CF2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1142C191494;
	Wed,  6 Nov 2024 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kBpuq/TE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E11D319C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860021; cv=none; b=i7TwK4iXaY53bPDE632GjKF0N8MOB3RW4puHvmgsrqiglPMWAmJvukvqbwKh/jEF4Fvq1dxyXu8nCyqSVhh890bNerGETp1erN2wXWBUdqPtqM3sFl2HGDfx6mkWywTI22rwV1oFW9tHEyRO3wvNTALSGW0MQm4JRIQY9vkXOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860021; c=relaxed/simple;
	bh=8gMZLLnSc32kMDO7afSuHkyae7EVmkx6ELFm/PuHsAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUzDIBgV7oQt3cQvXziGSrDtrUFWQWS+a9iaRK8R7kK9MOSDDtCLdwTjncT1A0TA3cEJ6sIeVscqWU3C/JxHdRDXGrTKXHaWWCnPmwLbDobjcP4pCWHpWmrzEJhZFZ+56ajs0c0VyCByqVIvmzJ2K0dMhx6v+lDy4qNWP3ngHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kBpuq/TE; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730860019; x=1762396019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g5s3iGchZbi9ph9xRF5r4XOxT6tRcpnaDCpWlUh7pGM=;
  b=kBpuq/TEo5vrLjNLJR+OwwMB85eEJ5/lLbDbnrTbmtEy7BUQgUCzv2XO
   2pWAB/rRHmpUhSOnKs+BChEBuAp27aWQk4lt3zqWtvR4Ub1pSeazdG7cg
   g9WAZni04uqMGPMwx/5sTBHtLaFS4eqbrUxZ+oVYfvdvdImJL5g+5YvR+
   k=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="440597725"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:26:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:9560]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.121:2525] with esmtp (Farcaster)
 id 1d709028-2d92-4460-8354-99dae9fc8649; Wed, 6 Nov 2024 02:26:56 +0000 (UTC)
X-Farcaster-Flow-ID: 1d709028-2d92-4460-8354-99dae9fc8649
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:26:56 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:26:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 7/7] rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.
Date: Tue, 5 Nov 2024 18:24:32 -0800
Message-ID: <20241106022432.13065-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106022432.13065-1-kuniyu@amazon.com>
References: <20241106022432.13065-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, rtnl_setlink() and rtnl_dellink() cannot be fully converted
to per-netns RTNL due to a lack of handling peer/lower/upper devices in
different netns.

For example, when we change a device in rtnl_setlink() and need to
propagate that to its upper devices, we want to avoid acquiring all netns
locks, for which we do not know the upper limit.

The same situation happens when we remove a device.

rtnl_dellink() could be transformed to remove a single device in the
requested netns and delegate other devices to per-netns work, and
rtnl_setlink() might be ?

Until we come up with a better idea, let's use a new flag
RTNL_FLAG_DOIT_PERNET_WIP for rtnl_dellink() and rtnl_setlink().

This will unblock converting RTNL users where such devices are not related.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h |  1 +
 net/core/rtnetlink.c    | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index f17208323c08..64b0c18651b5 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -13,6 +13,7 @@ typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
 enum rtnl_link_flags {
 	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
 #define RTNL_FLAG_DOIT_PERNET		RTNL_FLAG_DOIT_UNLOCKED
+#define RTNL_FLAG_DOIT_PERNET_WIP	RTNL_FLAG_DOIT_UNLOCKED
 	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
 	RTNL_FLAG_DUMP_UNLOCKED		= BIT(2),
 	RTNL_FLAG_DUMP_SPLIT_NLM_DONE	= BIT(3),	/* legacy behavior */
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1b58a7c4c912..28af19cc36a8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3408,6 +3408,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFLA_MAX+1];
 	struct net_device *dev = NULL;
+	struct rtnl_nets rtnl_nets;
 	struct net *tgt_net;
 	int err;
 
@@ -3426,6 +3427,12 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
+	rtnl_nets_init(&rtnl_nets);
+	rtnl_nets_add(&rtnl_nets, get_net(net));
+	rtnl_nets_add(&rtnl_nets, tgt_net);
+
+	rtnl_nets_lock(&rtnl_nets);
+
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
@@ -3438,7 +3445,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else if (!err)
 		err = -ENODEV;
 
-	put_net(tgt_net);
+	rtnl_nets_unlock(&rtnl_nets);
 errout:
 	return err;
 }
@@ -3523,6 +3530,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return PTR_ERR(tgt_net);
 	}
 
+	rtnl_net_lock(tgt_net);
+
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
@@ -3537,6 +3546,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		err = -EINVAL;
 
+	rtnl_net_unlock(tgt_net);
+
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
@@ -7023,10 +7034,12 @@ static struct pernet_operations rtnetlink_net_ops = {
 static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
 	 .flags = RTNL_FLAG_DOIT_PERNET},
-	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink},
+	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink,
+	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
 	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
-	{.msgtype = RTM_SETLINK, .doit = rtnl_setlink},
+	{.msgtype = RTM_SETLINK, .doit = rtnl_setlink,
+	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETADDR, .dumpit = rtnl_dump_all},
 	{.msgtype = RTM_GETROUTE, .dumpit = rtnl_dump_all},
 	{.msgtype = RTM_GETNETCONF, .dumpit = rtnl_dump_all},
-- 
2.39.5 (Apple Git-154)


