Return-Path: <netdev+bounces-134709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B499AE7D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33951C21E96
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41EE1D1E72;
	Fri, 11 Oct 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t9/ljrkM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB511D173C
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684460; cv=none; b=j+ejWYXwZ2aIT1D8Gfo4XAyoDebvxWGRnVEiweeI5mIxK4NxoUp0aTCXpL97j2/K4tnTYwj19FHSkkqzfncAgF42bC00+jH6GvZkmKO56eWLK4yPb1zBU+wUijFs+qNffhfCWALB6qgs9E5efDuhqWLYsB1QhH+abojcwQNWakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684460; c=relaxed/simple;
	bh=OKdavwSYjSH9MNE/Ur3KVlFnROFC+csgF9mM6lERHgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBMBObrAzomlSQeRuRf75bMl+3hHvG0ksbAqwF1uD1BXXHZrkOpULMIv22wm0L4rhdFyXeoZfxrou/6V/PC4oX1LDTccLOopbmm7aZWdTpT08/13ESa942gp2dHSanR2jKbp2WCnZyEZ7c7+Rju2RaM0NUsgWIHXJOrCJi3dyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t9/ljrkM; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684459; x=1760220459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJmOCEjXuxuHEbIh3kpxPop3gqJv8DkTHNNrTn00/7I=;
  b=t9/ljrkMmbCdHq70LYFfGrG86NBjZ98tg+omlT2dzZgtgT8Ag79Jc0j6
   zWwW4NwzB651v5ucPTsuOZUeRSFHSMyoyDjcBVivjDrYEHYaQlW5HCLGx
   2/jB2mz1prpF510/kqPS3MC9El2UsuzdVYa//45Bvc8xmfIWUJQUNXtiH
   c=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="665586319"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:07:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:14208]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id e35cf234-3aaf-4994-9a4c-422d3f115850; Fri, 11 Oct 2024 22:07:35 +0000 (UTC)
X-Farcaster-Flow-ID: e35cf234-3aaf-4994-9a4c-422d3f115850
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:07:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:07:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/11] net: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:44 -0700
Message-ID: <20241011220550.46040-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 0a86aff17f51..488ea2f9e6bc 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1169,6 +1169,13 @@ static void __init netns_ipv4_struct_check(void)
 }
 #endif
 
+static const struct rtnl_msg_handler net_ns_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{NULL, PF_UNSPEC, RTM_GETNSID, rtnl_net_getid, rtnl_net_dumpid,
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED },
+};
+
 void __init net_ns_init(void)
 {
 	struct net_generic *ng;
@@ -1206,11 +1213,7 @@ void __init net_ns_init(void)
 	if (register_pernet_subsys(&net_ns_ops))
 		panic("Could not register network namespace subsystems");
 
-	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
-		      RTNL_FLAG_DOIT_UNLOCKED);
-	rtnl_register(PF_UNSPEC, RTM_GETNSID, rtnl_net_getid, rtnl_net_dumpid,
-		      RTNL_FLAG_DOIT_UNLOCKED |
-		      RTNL_FLAG_DUMP_UNLOCKED);
+	rtnl_register_many(net_ns_rtnl_msg_handlers);
 }
 
 static void free_exit_list(struct pernet_operations *ops, struct list_head *net_exit_list)
-- 
2.39.5 (Apple Git-154)


