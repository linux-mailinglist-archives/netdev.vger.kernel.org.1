Return-Path: <netdev+bounces-143122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA99C1352
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CFD1C219EE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705AAEBE;
	Fri,  8 Nov 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TkXsKCqa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6D8F54
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027111; cv=none; b=ckg3aF3XZwXTXTHX2fxr3q1Am2faQHDcvnRJwEnibmwAQwfZM5D6Y2NRCsSXTPBduao2+IyKiOtnLerQud0+81GhBKLpyhNIH6ADrs5xv5/QQTC8maMXgO2582cJgxOAu2Vn/1Vvt4WL+IiLjPR2veiVKF+U7UuSaXXlQ6MxKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027111; c=relaxed/simple;
	bh=fTARUZ3ZILInUUsrkJBfuQhScBlFEd3RAb8zIlziWbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEhY8MYH1v3/k4Wghge3Wah/fic/Z7YxW+js7EJGz6LxC3PFZ1R1tz07GwxISwtL5Si01qEavMjfE+dSm0SCpjFZFY97PCNfreWQ1bVy+ZNe2/ofQxDo78vMfvt6xrnJF+LlxqmWRFs8bKsNRIvdnvfyP/HW5BbpqmgpiUaRCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TkXsKCqa; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731027110; x=1762563110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdE2xsovL/Gdzg41RfMTlIRQQ7jyDqdkbwXU5Oagrdc=;
  b=TkXsKCqajcz52XDWG9v/5/s2IkXKiY1+S0qKt9EqUriHlXHFT0a6+5Ob
   YP1y5Fe56JhyTX6YgCICTWndAg4vqR1Px/OfbvxAoY9WsDT3j6drzZt/3
   fYCMFRasc9N2IuaJCnrhbCVGXDl1PHgAXsQOgTuThG4t2LsbwTSjkQVOF
   c=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="39875630"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:51:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:60598]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.224:2525] with esmtp (Farcaster)
 id 18252978-f2dd-45fd-89a1-77b9171a27c2; Fri, 8 Nov 2024 00:51:48 +0000 (UTC)
X-Farcaster-Flow-ID: 18252978-f2dd-45fd-89a1-77b9171a27c2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:51:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:51:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 10/10] rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.
Date: Thu, 7 Nov 2024 16:48:23 -0800
Message-ID: <20241108004823.29419-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108004823.29419-1-kuniyu@amazon.com>
References: <20241108004823.29419-1-kuniyu@amazon.com>
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rtnetlink.h |  1 +
 net/core/rtnetlink.c    | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bef76abcff8d..bc0069a8b6ea 100644
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
index cac94fb4be18..5d13b39f884b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3382,6 +3382,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFLA_MAX+1];
 	struct net_device *dev = NULL;
+	struct rtnl_nets rtnl_nets;
 	struct net *tgt_net;
 	int err;
 
@@ -3400,6 +3401,12 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3412,7 +3419,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else if (!err)
 		err = -ENODEV;
 
-	put_net(tgt_net);
+	rtnl_nets_unlock(&rtnl_nets);
 errout:
 	return err;
 }
@@ -3497,6 +3504,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return PTR_ERR(tgt_net);
 	}
 
+	rtnl_net_lock(tgt_net);
+
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
@@ -3511,6 +3520,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		err = -EINVAL;
 
+	rtnl_net_unlock(tgt_net);
+
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
@@ -6997,10 +7008,12 @@ static struct pernet_operations rtnetlink_net_ops = {
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


