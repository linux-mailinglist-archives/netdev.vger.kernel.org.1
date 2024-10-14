Return-Path: <netdev+bounces-135300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646499D810
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549F2281FC9
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AE1CACDD;
	Mon, 14 Oct 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nvekWgDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69AE14A4E7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937165; cv=none; b=Ql6+kKi8BUNiI4zWwuv0mi9mO+Cvh11hcXI8WGQL2Pe0x0vH8aDvqkwvA6AT7m23BrrRphW7yhOAU9Adj/T6Kdpix2trOsinLDTgNFX237/WoCPINSs8HJKcZxh19J5es95M03QBdghlgu1A9848E0fs247dMt9g5XLipg5y7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937165; c=relaxed/simple;
	bh=kdOpivGh21xJfDVA+qCqfWU7rhb+nVx3dq0+u66F2hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzRJFiZv1+8klIr2WVqzBEQ+WshWNUIECAWjfnhkdqa2QUtf701ZFEoPh9WdpwlDBTerhRdUymUIl9mmJVe8cMzvRJkuHS3DjQaiD7UU5xnAFhVCwv03G0vBKSKn5h1GpSNoOr6/CGMLoGveErDzTyPUbFWEZTDTzM6aoUDrhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nvekWgDT; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937164; x=1760473164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqw1Lo/TezUKrA+ICx0z+7+r8Q4KujujaLNaiba3uvw=;
  b=nvekWgDTnOPRmhVJblP4ZrA4DrvNBBqbsyQ3BvucdyyrR+7n6qeNiinu
   ncjlo1Oq2gFcUogApu1vqq1efOzT2ftgBFpquW+Jl2mPeFjObZHgnW8vl
   Ze0pf5qFqIl0dcU7ywgAZE7MUmxbsUaYVxpGLY60QP2ldcvSRjlixy6Jh
   0=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="239237187"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:19:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:47855]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 359cf5b7-fb06-4a40-a62b-3df30c11e63d; Mon, 14 Oct 2024 20:19:19 +0000 (UTC)
X-Farcaster-Flow-ID: 359cf5b7-fb06-4a40-a62b-3df30c11e63d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:19:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:19:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/11] rtnetlink: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:19 -0700
Message-ID: <20241014201828.91221-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
References: <20241014201828.91221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add __initconst
  * Use C99 initialisation
---
 net/core/rtnetlink.c | 63 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8f2cdb0de4a9..0fbbfeb2cb50 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6843,6 +6843,38 @@ static struct pernet_operations rtnetlink_net_ops = {
 	.exit = rtnetlink_net_exit,
 };
 
+static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
+	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink},
+	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
+	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+	{.msgtype = RTM_SETLINK, .doit = rtnl_setlink},
+	{.msgtype = RTM_GETADDR, .dumpit = rtnl_dump_all},
+	{.msgtype = RTM_GETROUTE, .dumpit = rtnl_dump_all},
+	{.msgtype = RTM_GETNETCONF, .dumpit = rtnl_dump_all},
+	{.msgtype = RTM_GETSTATS, .doit = rtnl_stats_get,
+	 .dumpit = rtnl_stats_dump},
+	{.msgtype = RTM_SETSTATS, .doit = rtnl_stats_set},
+	{.msgtype = RTM_NEWLINKPROP, .doit = rtnl_newlinkprop},
+	{.msgtype = RTM_DELLINKPROP, .doit = rtnl_dellinkprop},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_GETLINK,
+	 .dumpit = rtnl_bridge_getlink},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_DELLINK,
+	 .doit = rtnl_bridge_dellink},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_SETLINK,
+	 .doit = rtnl_bridge_setlink},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_NEWNEIGH, .doit = rtnl_fdb_add},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_DELNEIGH, .doit = rtnl_fdb_del,
+	 .flags = RTNL_FLAG_BULK_DEL_SUPPORTED},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_GETNEIGH, .doit = rtnl_fdb_get,
+	 .dumpit = rtnl_fdb_dump},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_NEWMDB, .doit = rtnl_mdb_add},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_DELMDB, .doit = rtnl_mdb_del,
+	 .flags = RTNL_FLAG_BULK_DEL_SUPPORTED},
+	{.protocol = PF_BRIDGE, .msgtype = RTM_GETMDB, .doit = rtnl_mdb_get,
+	 .dumpit = rtnl_mdb_dump},
+};
+
 void __init rtnetlink_init(void)
 {
 	if (register_pernet_subsys(&rtnetlink_net_ops))
@@ -6850,34 +6882,5 @@ void __init rtnetlink_init(void)
 
 	register_netdevice_notifier(&rtnetlink_dev_notifier);
 
-	rtnl_register(PF_UNSPEC, RTM_GETLINK, rtnl_getlink,
-		      rtnl_dump_ifinfo, RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
-	rtnl_register(PF_UNSPEC, RTM_SETLINK, rtnl_setlink, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_NEWLINK, rtnl_newlink, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELLINK, rtnl_dellink, NULL, 0);
-
-	rtnl_register(PF_UNSPEC, RTM_GETADDR, NULL, rtnl_dump_all, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETROUTE, NULL, rtnl_dump_all, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETNETCONF, NULL, rtnl_dump_all, 0);
-
-	rtnl_register(PF_UNSPEC, RTM_NEWLINKPROP, rtnl_newlinkprop, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELLINKPROP, rtnl_dellinkprop, NULL, 0);
-
-	rtnl_register(PF_BRIDGE, RTM_NEWNEIGH, rtnl_fdb_add, NULL, 0);
-	rtnl_register(PF_BRIDGE, RTM_DELNEIGH, rtnl_fdb_del, NULL,
-		      RTNL_FLAG_BULK_DEL_SUPPORTED);
-	rtnl_register(PF_BRIDGE, RTM_GETNEIGH, rtnl_fdb_get, rtnl_fdb_dump, 0);
-
-	rtnl_register(PF_BRIDGE, RTM_GETLINK, NULL, rtnl_bridge_getlink, 0);
-	rtnl_register(PF_BRIDGE, RTM_DELLINK, rtnl_bridge_dellink, NULL, 0);
-	rtnl_register(PF_BRIDGE, RTM_SETLINK, rtnl_bridge_setlink, NULL, 0);
-
-	rtnl_register(PF_UNSPEC, RTM_GETSTATS, rtnl_stats_get, rtnl_stats_dump,
-		      0);
-	rtnl_register(PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0);
-
-	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
-	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
-	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL,
-		      RTNL_FLAG_BULK_DEL_SUPPORTED);
+	rtnl_register_many(rtnetlink_rtnl_msg_handlers);
 }
-- 
2.39.5 (Apple Git-154)


