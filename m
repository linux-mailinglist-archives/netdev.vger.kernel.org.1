Return-Path: <netdev+bounces-134706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FCF99AE7A
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B076F1F215DB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5881D14E0;
	Fri, 11 Oct 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sWnseG+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AF1D12EC
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684398; cv=none; b=nAbNng4mONDIIEhjn3AOT8RBXBfiuUki75zUHO82xYMqzg9nRLRivBFEhTFSoRogJbpAdMoTtjKy66GHsk/Bq0UURqyw+wEw4zJW9ebuvKaBZzdB7IbE+Cbt+pFa99ZPEzlhtYy+3ozV5nqyx+LGTNVY2n5MgooWONguJ0CuAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684398; c=relaxed/simple;
	bh=NPh6YrXgsuDawz5S4PHEF0Tjy7oyu9/8+0KiAkHxNh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDknqCVYkq1tL1RtD7sD3tTbITUIhRvqmEBsCXLfBnJLesnWZg+gO1x4DZcHQ8jCYvQdjtbulcXG0CKcaiAwW5pEuO61MgHQiEEEIQwZ8ZWdajpjsxapeFO1v5LqdxMrgL086FPJ7OYewRXUzeIcRabLz/wHpEAVCYS0M8acyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sWnseG+a; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684397; x=1760220397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LeYe7a273ixSI0atiqVe0BBxyfXCMdGEGJNKFWWy9GQ=;
  b=sWnseG+a0P7XRbJdZqg+vbxIsJfhaHzRF5BVXerfHS3jswELTOERGVtD
   X3bbpFyixdF84LWVrUF7/YJPLJ2+4AgThhwE2xnE22AW4ocY1bBM1DHXO
   Gj5skeryxtHemBxBqkoYZthziC8Whe1qy8LtkuRBqBlSBAM5+nwGvsGQx
   c=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="137922851"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:06:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:42003]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 5e31e81a-9615-4b40-855c-ecc8de896fd4; Fri, 11 Oct 2024 22:06:36 +0000 (UTC)
X-Farcaster-Flow-ID: 5e31e81a-9615-4b40-855c-ecc8de896fd4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:06:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:06:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/11] rtnetlink: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:41 -0700
Message-ID: <20241011220550.46040-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 57 +++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8f2cdb0de4a9..edaafdcd24ad 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6843,6 +6843,32 @@ static struct pernet_operations rtnetlink_net_ops = {
 	.exit = rtnetlink_net_exit,
 };
 
+static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWLINK, rtnl_newlink, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELLINK, rtnl_dellink, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETLINK, rtnl_getlink, rtnl_dump_ifinfo,
+	 RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
+	{NULL, PF_UNSPEC, RTM_SETLINK, rtnl_setlink, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETADDR, NULL, rtnl_dump_all, 0},
+	{NULL, PF_UNSPEC, RTM_GETROUTE, NULL, rtnl_dump_all, 0},
+	{NULL, PF_UNSPEC, RTM_GETNETCONF, NULL, rtnl_dump_all, 0},
+	{NULL, PF_UNSPEC, RTM_GETSTATS, rtnl_stats_get, rtnl_stats_dump, 0},
+	{NULL, PF_UNSPEC, RTM_SETSTATS, rtnl_stats_set, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_NEWLINKPROP, rtnl_newlinkprop, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELLINKPROP, rtnl_dellinkprop, NULL, 0},
+	{NULL, PF_BRIDGE, RTM_GETLINK, NULL, rtnl_bridge_getlink, 0},
+	{NULL, PF_BRIDGE, RTM_DELLINK, rtnl_bridge_dellink, NULL, 0},
+	{NULL, PF_BRIDGE, RTM_SETLINK, rtnl_bridge_setlink, NULL, 0},
+	{NULL, PF_BRIDGE, RTM_NEWNEIGH, rtnl_fdb_add, NULL, 0},
+	{NULL, PF_BRIDGE, RTM_DELNEIGH, rtnl_fdb_del, NULL,
+	 RTNL_FLAG_BULK_DEL_SUPPORTED},
+	{NULL, PF_BRIDGE, RTM_GETNEIGH, rtnl_fdb_get, rtnl_fdb_dump, 0},
+	{NULL, PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0},
+	{NULL, PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL,
+	 RTNL_FLAG_BULK_DEL_SUPPORTED},
+	{NULL, PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0},
+};
+
 void __init rtnetlink_init(void)
 {
 	if (register_pernet_subsys(&rtnetlink_net_ops))
@@ -6850,34 +6876,5 @@ void __init rtnetlink_init(void)
 
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


