Return-Path: <netdev+bounces-142212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799179BDD0A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891361C22FBC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF91D31BB;
	Wed,  6 Nov 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jtY1MSG+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F881D3185
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859999; cv=none; b=AO4LDxrIG7lPBKzsgIOi89ENcodE/xCPZK6w2/bencFqqmNaSIdxU+AY98+Dv5uUIhUZT+YP50ce5cvkBIBY4KPJ1i+dapk22qfh5VUHSy54o0og5Lo3svmsDoaNvF3u9QLRfAgWIuqIYPGT3oXlNcEVQ/4xDPXtmqdMPLUOyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859999; c=relaxed/simple;
	bh=zALf9zJf1Ki1UfpxrIWcOG6qpO+7Jxrhcd0fRUTFuXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJKk5DRQWnK0bekq3UGdz7pB4kQ/QyVIFzopL/DgKlE5wla5Oh0GLZfeCL76pnU+KjwKzG/RO8t8rjAOo+XKs1JLRNgSqb0AL538RNlkiGLWHDybJVS5lATWqkkssjGtPa1ceG4FdKuw+us/ALsFdS1iHcI9FHU56m+XGRd8nTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jtY1MSG+; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859997; x=1762395997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8x0BkAOaDHam1pWr6fw+EnoQeFZ188PtUN0jd4R1Sxc=;
  b=jtY1MSG+KPI7HeiQjJ/VueDmO5Mys9Zsg3bMMo4VqD8fb4zPstwA7FB4
   5RGJCGBKqAHyXvmA4vOnNlqa3KYwVzIEW0ga2/TrpBVCbyRWtEWKFSLxG
   toK1/DCGrpYH56zhZkPVHoSgKYFoh0cy61q0P/aJX9XTz8RXSdMaj8eBf
   4=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="349723915"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:26:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:46985]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.121:2525] with esmtp (Farcaster)
 id 73924131-4b07-429a-984c-491c76b90643; Wed, 6 Nov 2024 02:26:36 +0000 (UTC)
X-Farcaster-Flow-ID: 73924131-4b07-429a-984c-491c76b90643
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:26:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:26:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/7] rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
Date: Tue, 5 Nov 2024 18:24:31 -0800
Message-ID: <20241106022432.13065-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now, we are ready to convert rtnl_newlink() to per-netns RTNL;
rtnl_link_ops is protected by SRCU and netns is prefetched in
rtnl_newlink().

Let's register rtnl_newlink() with RTNL_FLAG_DOIT_PERNET and
push RTNL down as rtnl_nets_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v2: Remove __rtnl_unlock() dance in rtnl_newlink().
---
 net/core/rtnetlink.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d5557a621099..1b58a7c4c912 100644
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
@@ -3932,9 +3952,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ops = rtnl_link_ops_get(kind, &ops_srcu_index);
 #ifdef CONFIG_MODULES
 		if (!ops) {
-			__rtnl_unlock();
 			request_module("rtnl-link-%s", kind);
-			rtnl_lock();
 			ops = rtnl_link_ops_get(kind, &ops_srcu_index);
 		}
 #endif
@@ -3997,7 +4015,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
+	rtnl_nets_lock(&rtnl_nets);
 	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
+	rtnl_nets_unlock(&rtnl_nets);
 
 put_net:
 	rtnl_nets_destroy(&rtnl_nets);
@@ -7001,7 +7021,8 @@ static struct pernet_operations rtnetlink_net_ops = {
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


