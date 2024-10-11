Return-Path: <netdev+bounces-134712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A699AE80
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C0B2248D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1851D1E79;
	Fri, 11 Oct 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GAZRY+gb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D761D1E72
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684515; cv=none; b=fyV2QlBUfcOfY8cRRiJzv5Uho5XfVJWp2xpKRL+1uR8mb756gkBVPQ92Ml7YP7U48oQYgpS7xNRP/nirVk3R9JhHP1cYy1S79nBu3/V6/NZAA3E+6A3d82S11rVJj7nVAX4aruyvyvm8kGV/2IlRCd0m8F9df09sp+6dKsvjISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684515; c=relaxed/simple;
	bh=CoxdsmG/OokTC8+uDqFGsrBS2dbBa4I6KZvwc73MxS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwdYjDSZ+HkrNSnagaHOh3Nck0SKUO5FnHp3xNGgqoRcMgvAOx3MlSWMNcYLr90Uvq2hBIz+DUB9jCZsM5XuiRFaYXvhljPYniKm76YIJv9kYceT1UJjpyZ8kQ9pHNR0B8BzIAQjsr9yza3xJZOh9svleVMYWWoToj2SKYSvEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GAZRY+gb; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684514; x=1760220514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wrv9qmoj7o7oMQQllnLamcZ/MkPkQtYq1Al20R9ZT0A=;
  b=GAZRY+gbAUeU0pXQi+wi0g3XiEelFMu/g1WO2FnS4/SX9wiUm+xSo4ki
   SHAFoC99ghMHgKlJl49P595FjLrClKaFrhYZH4pntRJE0tvZLsIUKN6HQ
   2NyhKuyUJ9j2oHVS34g9xOUrRdanKfqP+1Fj4cHXQirsK7gbgZTefXEf5
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="137923185"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:08:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:37306]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id cf3168b5-def1-4d6e-b7ab-588910f57c69; Fri, 11 Oct 2024 22:08:33 +0000 (UTC)
X-Farcaster-Flow-ID: cf3168b5-def1-4d6e-b7ab-588910f57c69
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:08:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:08:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/11] ipmr: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:47 -0700
Message-ID: <20241011220550.46040-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() and rtnl_register_module() in favour
of rtnl_register_many().

When it succeeds for built-in callers, rtnl_register_many() guarantees
all rtnetlink types in the passed array are supported, and there is no
chance that a part of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/ipmr.c  | 19 ++++++++++---------
 net/ipv6/ip6mr.c | 12 ++++++++----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 089864c6a35e..2a5a6927229f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3139,6 +3139,14 @@ static struct pernet_operations ipmr_net_ops = {
 	.exit_batch = ipmr_net_exit_batch,
 };
 
+static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] = {
+	{NULL, RTNL_FAMILY_IPMR, RTM_GETLINK, NULL, ipmr_rtm_dumplink, 0},
+	{NULL, RTNL_FAMILY_IPMR, RTM_NEWROUTE, ipmr_rtm_route, NULL, 0},
+	{NULL, RTNL_FAMILY_IPMR, RTM_DELROUTE, ipmr_rtm_route, NULL, 0},
+	{NULL, RTNL_FAMILY_IPMR, RTM_GETROUTE,
+	 ipmr_rtm_getroute, ipmr_rtm_dumproute, 0},
+};
+
 int __init ip_mr_init(void)
 {
 	int err;
@@ -3159,15 +3167,8 @@ int __init ip_mr_init(void)
 		goto add_proto_fail;
 	}
 #endif
-	rtnl_register(RTNL_FAMILY_IPMR, RTM_GETROUTE,
-		      ipmr_rtm_getroute, ipmr_rtm_dumproute, 0);
-	rtnl_register(RTNL_FAMILY_IPMR, RTM_NEWROUTE,
-		      ipmr_rtm_route, NULL, 0);
-	rtnl_register(RTNL_FAMILY_IPMR, RTM_DELROUTE,
-		      ipmr_rtm_route, NULL, 0);
-
-	rtnl_register(RTNL_FAMILY_IPMR, RTM_GETLINK,
-		      NULL, ipmr_rtm_dumplink, 0);
+	rtnl_register_many(ipmr_rtnl_msg_handlers);
+
 	return 0;
 
 #ifdef CONFIG_IP_PIMSM_V2
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2ce4ae0d8dc3..8bb7bf4346f0 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1369,6 +1369,11 @@ static struct pernet_operations ip6mr_net_ops = {
 	.exit_batch = ip6mr_net_exit_batch,
 };
 
+static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] = {
+	{THIS_MODULE, RTNL_FAMILY_IP6MR, RTM_GETROUTE,
+	 ip6mr_rtm_getroute, ip6mr_rtm_dumproute, 0},
+};
+
 int __init ip6_mr_init(void)
 {
 	int err;
@@ -1391,9 +1396,8 @@ int __init ip6_mr_init(void)
 		goto add_proto_fail;
 	}
 #endif
-	err = rtnl_register_module(THIS_MODULE, RTNL_FAMILY_IP6MR, RTM_GETROUTE,
-				   ip6mr_rtm_getroute, ip6mr_rtm_dumproute, 0);
-	if (err == 0)
+	err = rtnl_register_many(ip6mr_rtnl_msg_handlers);
+	if (!err)
 		return 0;
 
 #ifdef CONFIG_IPV6_PIMSM_V2
@@ -1410,7 +1414,7 @@ int __init ip6_mr_init(void)
 
 void ip6_mr_cleanup(void)
 {
-	rtnl_unregister(RTNL_FAMILY_IP6MR, RTM_GETROUTE);
+	rtnl_unregister_many(ip6mr_rtnl_msg_handlers);
 #ifdef CONFIG_IPV6_PIMSM_V2
 	inet6_del_protocol(&pim6_protocol, IPPROTO_PIM);
 #endif
-- 
2.39.5 (Apple Git-154)


