Return-Path: <netdev+bounces-131776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F498F85C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F392B2147E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9301ABEBD;
	Thu,  3 Oct 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pBE7Nysg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4B1B85CB
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989208; cv=none; b=IJ5LMvOwPW+8zciypxFdCTluz0IEKxY9GP2viG15S6WkxHbMjYlSvv8VfFIGyFuQJaJn2C0CMi/wl/fsgpOTzJZ8RyqsHtKW5aD7my61KtIWGhIaEt5p/7J12PgDEOpY5xdNv+gbFrwzovZndvBK9jgQ3FBSnyQy3Wt3gwdHBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989208; c=relaxed/simple;
	bh=vn2OqySmPduV6bQ8iIhZMkLsGO6m9NSzpa6w4B+acM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyvTEcF8qkJ3845mkOFQqtk8co1Y1LbbYneVMHiIV/XCDO7cP7TYnypZQ6lfx6zskslKDOzONa1WVk0VM5TgO5XrKDtRsOfW5wtPMg5uZJnJRsjVIX17jdIsn9U5SYK4XdqmG6udm441XtKBR5fjzd3do31KyqhigBxlyHbZA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pBE7Nysg; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727989208; x=1759525208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSQDUAF1Kx9sqOJCUiEVjJHxubWxak+52JKbhay6Tos=;
  b=pBE7NysgayNjxb9zCvuOtiId0N0x/QlxO9QnyhlhBE1ouGx3z9Ala5ls
   G3c0MG1t2lBsWAk3F9fFlEPKj7eGXjTe7dU7AAS4o6OGMQfYJxjvCrOqP
   +k+EGi+BExCGE9Xn149RSxym+cfCmmYspmm73FgmcrijbA+EYjQEBpWkL
   s=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="339352493"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 21:00:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:36958]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.223:2525] with esmtp (Farcaster)
 id e5a109a1-ed38-46ca-b3ef-d7955f27125f; Thu, 3 Oct 2024 21:00:06 +0000 (UTC)
X-Farcaster-Flow-ID: e5a109a1-ed38-46ca-b3ef-d7955f27125f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 21:00:06 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 21:00:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Remi Denis-Courmont
	<courmisch@gmail.com>, Florian Westphal <fw@strlen.de>
Subject: [PATCH v1 net 6/6] phonet: Handle error of rtnl_register_module().
Date: Thu, 3 Oct 2024 13:57:25 -0700
Message-ID: <20241003205725.5612-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003205725.5612-1-kuniyu@amazon.com>
References: <20241003205725.5612-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl
message handlers"), once the first rtnl_register_module() allocated
rtnl_msg_handlers[PF_PHONET], the following calls never failed.

However, after the commit, rtnl_register_module() could fail to allocate
rtnl_msg_handlers[PF_PHONET][msgtype] and requires error handling for
each call.

Let's use rtnl_register_module_many() to handle the errors easily.

Fixes: addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message handlers")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Remi Denis-Courmont <courmisch@gmail.com>
Cc: Florian Westphal <fw@strlen.de>
---
 net/phonet/pn_netlink.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 7008d402499d..d39e6983926b 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -285,23 +285,16 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_module = {
+	{PF_PHONET, RTM_NEWADDR, addr_doit, NULL, 0},
+	{PF_PHONET, RTM_DELADDR, addr_doit, NULL, 0},
+	{PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
+	{PF_PHONET, RTM_NEWROUTE, route_doit, NULL, 0},
+	{PF_PHONET, RTM_DELROUTE, route_doit, NULL, 0},
+	{PF_PHONET, RTM_GETROUTE, NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 int __init phonet_netlink_register(void)
 {
-	int err = rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWADDR,
-				       addr_doit, NULL, 0);
-	if (err)
-		return err;
-
-	/* Further rtnl_register_module() cannot fail */
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELADDR,
-			     addr_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETADDR,
-			     NULL, getaddr_dumpit, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWROUTE,
-			     route_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
-			     route_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETROUTE,
-			     NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED);
-	return 0;
+	return rtnl_register_module_many(phonet_rtnl_msg_handlers);
 }
-- 
2.30.2


