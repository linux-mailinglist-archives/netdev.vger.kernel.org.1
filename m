Return-Path: <netdev+bounces-135303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39899D813
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2D2282741
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9B71CCECD;
	Mon, 14 Oct 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wu3v8hBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A181CACE0
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937223; cv=none; b=fpMi8B+mby9jFT335dPKTEZaQLIRLjXI/KIB6yb6gzdWQ6FOWd4fofIxDloxgILagjTLp4cJca1kKzC69q3qk6ykYX1sQVK7oF5Hu2pqyrgD2rgZUBukPDpLCpaeliEuugpLYOc5Yx62uEGixdcCKPj5yY/o88a0zd5iR6U11ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937223; c=relaxed/simple;
	bh=32jnDhCUhXh+jqUV0bU96tn275WcEjkWo4qJ7lkTOiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgjwYTJkA/d6fSXSb9mzScS2GCNcWm6ohKiHBGiUU0uAj4IvegLwBnsEQWL8wcQ0zLyUSW4XOIQbaJlP2E+fJSMlnq7yCTzVua4QtERyX6phN7klF+ZJ6jWkTQNjQYxAiSiUxHeRYke6RUxOuWq8M2t0Y+vfXqebgr2yHuAmaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wu3v8hBA; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937222; x=1760473222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+nICapXNnbTD/LnbfOHr4OFdRYcikfHJJ1QkxYTYO0=;
  b=Wu3v8hBAoq5osAmUwdADLpfXDto8S+F7zsJRQItZTyEkmtIlfXNPoedc
   lH7CvfQbbuwI4nVFqXJUvNSUblkKKOZ7D95obzwgSuvUGnd0/h8UbfA5A
   iiTbi6sDoXaPwDvTYYVuQfSF1tlF7Qy4hq1VwqK9FIz5oWTIbPG+Jdqtv
   s=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="460691546"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:20:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:17036]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 9b3199ae-ec56-4af4-ad79-73e1d3a15a8c; Mon, 14 Oct 2024 20:20:16 +0000 (UTC)
X-Farcaster-Flow-ID: 9b3199ae-ec56-4af4-ad79-73e1d3a15a8c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:20:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:20:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/11] net: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:22 -0700
Message-ID: <20241014201828.91221-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
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
 net/core/net_namespace.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 0a86aff17f51..809b48c0a528 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1169,6 +1169,14 @@ static void __init netns_ipv4_struct_check(void)
 }
 #endif
 
+static const struct rtnl_msg_handler net_ns_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWNSID, .doit = rtnl_net_newid,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.msgtype = RTM_GETNSID, .doit = rtnl_net_getid,
+	 .dumpit = rtnl_net_dumpid,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 void __init net_ns_init(void)
 {
 	struct net_generic *ng;
@@ -1206,11 +1214,7 @@ void __init net_ns_init(void)
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


