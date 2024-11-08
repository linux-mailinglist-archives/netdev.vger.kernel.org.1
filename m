Return-Path: <netdev+bounces-143121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCC9C1351
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D41C21980
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB34EBE;
	Fri,  8 Nov 2024 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M0HDkj+T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE923D7
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027092; cv=none; b=SEneUnZf2YYkwGtXkNMlSTdJZUV+d4glB2MerneLYUNv2+Ex1kzNtj90UV3CTEK0oLM3BeeKAxnznYMTDEAfzSN9dzzms2b2PzGjEQ1dUAC1PFeRUvzB2ycLwoOiRsE86qlKRX21M0DDnG6umxepji0YrzebP+rhYiInkVF+XFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027092; c=relaxed/simple;
	bh=vRbVFyGuV/E5AhZDZxLBonVKIRrPGA57OwXKCrYzeLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0hhoJWDFqtJyadYq5Qg87jB4qxrM3OZgZ4RXqxlW0vYp1arGcy5EKgx3RXmzZPBezpw0M00beHaEn6/XiFe1TUNLMjZHihtT+23F7v37OAmjduPeB46WfKcd3drN9pvJWsii7jf7KzLo52GwQXYNSOcDvgqXVUm7v1EgNjcfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M0HDkj+T; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731027091; x=1762563091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h0HAaoqnLWko/iCa3XRQ6L4nJbf2GH5bv1gRnMSRiHg=;
  b=M0HDkj+TvSxwkACf2seTWfJSwH5njpEQnOSQQ/LzTkADeYDHMKctkQ8b
   AWVKxzb0NLEliSbsQTlD8MCpoUmOEdZfFQ30FRTk3kNOIxkmNmeC81S55
   J70JzYfgvcIt6ZU3lINzXkKTQoKQmMpR4tfiedsLX26Ev2FBrUtsbwaZQ
   A=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="39875595"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:51:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:1506]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.195:2525] with esmtp (Farcaster)
 id 6f2818e0-652c-4aef-aa51-8a5df3c2cb3a; Fri, 8 Nov 2024 00:51:28 +0000 (UTC)
X-Farcaster-Flow-ID: 6f2818e0-652c-4aef-aa51-8a5df3c2cb3a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:51:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:51:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 09/10] rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
Date: Thu, 7 Nov 2024 16:48:22 -0800
Message-ID: <20241108004823.29419-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now, we are ready to convert rtnl_newlink() to per-netns RTNL;
rtnl_link_ops is protected by SRCU and netns is prefetched in
rtnl_newlink().

Let's register rtnl_newlink() with RTNL_FLAG_DOIT_PERNET and
push RTNL down as rtnl_nets_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: Remove __rtnl_unlock() dance in rtnl_newlink().
---
 net/core/rtnetlink.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fe65dd6cde8d..cac94fb4be18 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -319,6 +319,26 @@ static void rtnl_nets_add(struct rtnl_nets *rtnl_nets, struct net *net)
 	rtnl_nets->len++;
 }
 
+static void rtnl_nets_lock(struct rtnl_nets *rtnl_nets)
+{
+	int i;
+
+	rtnl_lock();
+
+	for (i = 0; i < rtnl_nets->len; i++)
+		__rtnl_net_lock(rtnl_nets->net[i]);
+}
+
+static void rtnl_nets_unlock(struct rtnl_nets *rtnl_nets)
+{
+	int i;
+
+	for (i = 0; i < rtnl_nets->len; i++)
+		__rtnl_net_unlock(rtnl_nets->net[i]);
+
+	rtnl_unlock();
+}
+
 static struct rtnl_link __rcu *__rcu *rtnl_msg_handlers[RTNL_FAMILY_MAX + 1];
 
 static inline int rtm_msgindex(int msgtype)
@@ -3906,9 +3926,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ops = rtnl_link_ops_get(kind, &ops_srcu_index);
 #ifdef CONFIG_MODULES
 		if (!ops) {
-			__rtnl_unlock();
 			request_module("rtnl-link-%s", kind);
-			rtnl_lock();
 			ops = rtnl_link_ops_get(kind, &ops_srcu_index);
 		}
 #endif
@@ -3971,7 +3989,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
+	rtnl_nets_lock(&rtnl_nets);
 	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
+	rtnl_nets_unlock(&rtnl_nets);
 
 put_net:
 	rtnl_nets_destroy(&rtnl_nets);
@@ -6975,7 +6995,8 @@ static struct pernet_operations rtnetlink_net_ops = {
 };
 
 static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
-	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
+	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink},
 	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
 	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
-- 
2.39.5 (Apple Git-154)


