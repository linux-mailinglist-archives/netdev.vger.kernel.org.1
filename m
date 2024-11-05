Return-Path: <netdev+bounces-141756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589879BC2EE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12589280DCE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F32C190;
	Tue,  5 Nov 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TBpvbAPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B22A1CA
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772486; cv=none; b=j1CMwsBghEMiut12mO3sUqbYfmJVdxq5taEs6c3lM5LCpuSAecH5eEoaYACnnMOGEKfva0ILla7s1XCk2g4MsOO+5Z0ffxBNR9x+Yuqgn4mcCAfRuTar1vUtau4VJRQPjcU6fGfcCimcNWgU4pjPMamkn9oGnarPmBcIYosLDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772486; c=relaxed/simple;
	bh=8SwbgH3Q6skwf0KA5qSECqA2/pSdBjjiWToRXILDm/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeQY/FmFAYiNClsAMug1tZIGVJMX7na5TwE+7eq7u6txTLqbNOtO6wRFpGMnOSGUjH/sfHJz8dlTzPo3L9rIW8vIPzmQvphD0U4aHFES0U/anOMXJlwqUh/7/+NSLaQFbt1JDk6ca2JF4CcxD4BiJM2J7nDyORQj9PE/NIjdK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TBpvbAPD; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772484; x=1762308484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2v68ria0qRpP06XIbx3P8Hd64e7e9pSCldoOpmoazM=;
  b=TBpvbAPDdHBCB7GOfaNc7lpCXb2A9tFZs86P81pn9574Ad+3HiALLjyU
   KADThVD+BEROaMcD7yscW9kBNu24bASZXsfojA93yISdF/Y1KHOH6E/nW
   foHh/DUpZjQ8GVUydRRa7DTh4GD7BTVr41INDdAQ1v4KEBBjrrH2EiBZr
   k=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="467193121"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:07:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:49985]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id 0b2445f9-469c-44ed-ad01-7d4e2776bbd4; Tue, 5 Nov 2024 02:07:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0b2445f9-469c-44ed-ad01-7d4e2776bbd4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:07:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:07:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 8/8] rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.
Date: Mon, 4 Nov 2024 18:05:14 -0800
Message-ID: <20241105020514.41963-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105020514.41963-1-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
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
index c3548da95ffa..4b0f53891f48 100644
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
index 0df0cba0a700..36bafc105bd5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3402,6 +3402,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[IFLA_MAX+1];
 	struct net_device *dev = NULL;
+	struct rtnl_nets rtnl_nets;
 	struct net *tgt_net;
 	int err;
 
@@ -3420,6 +3421,12 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3432,7 +3439,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else if (!err)
 		err = -ENODEV;
 
-	put_net(tgt_net);
+	rtnl_nets_unlock(&rtnl_nets);
 errout:
 	return err;
 }
@@ -3517,6 +3524,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return PTR_ERR(tgt_net);
 	}
 
+	rtnl_net_lock(tgt_net);
+
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
@@ -3531,6 +3540,8 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		err = -EINVAL;
 
+	rtnl_net_unlock(tgt_net);
+
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
@@ -7019,10 +7030,12 @@ static struct pernet_operations rtnetlink_net_ops = {
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


