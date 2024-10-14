Return-Path: <netdev+bounces-135306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61C99D816
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9B81F22ACD
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401611CDFD2;
	Mon, 14 Oct 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D0dOA8ZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFB14A4E7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937277; cv=none; b=CQgyAZOLrEYCL2O7yzLYXFg6CGBqaaibv130yGu8xHdCltBRfYpQFR1nU9MZC5efwNwM2WnWw2v6zJ8C+cbRqKQUt2ZPItexxi0U8oQFG4p5p/FcrF4gTaMGvZpv/dtqafM2AULuo1/vY7ygQdavH+sjptPIEb/HNAKs6kwe3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937277; c=relaxed/simple;
	bh=QOYZwnuFeKFNU86A+/uxbGbbD6JnygzyJsb1eEx4GpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7mlc77QDi4oe+fyFcmIAMXYoqeHek2ob5ffWcxTErFq2Tl7Vxs0Apu27FZuR9dL5uukqH2Dtp6k9Mn+ZBYomTSUYQ5hmzbE2sur+HCIsXo43P8Vcz2LwDAQgOvWNi9imkLecoicuJj3PIL8kIUrk8fHAioa4ziFgVA0xiuBi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D0dOA8ZV; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937276; x=1760473276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAL1vQ/IAyFyEzhu7H/k2HSBeEUj5MU8/9VqEM0lOBw=;
  b=D0dOA8ZVEbqpAREe4AqJdHGcIo9oEdLHYUda5NbjIEKrfaJ9vFfn+NsQ
   H18YztW2zp0mOVRykUobHHcgcV2InbWv6Ek2g1C7E4M0/sA7aEiezkxyt
   WRoVabjcQA7Eqeet6CplQ9bvAWs1N8d+Q/y5ob9dXtPR2yxTEDlN3c74m
   k=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766497686"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:21:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:19717]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 59cf00e8-c076-4aca-80fc-8544ddf84075; Mon, 14 Oct 2024 20:21:14 +0000 (UTC)
X-Farcaster-Flow-ID: 59cf00e8-c076-4aca-80fc-8544ddf84075
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:21:14 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:21:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/11] ipmr: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:25 -0700
Message-ID: <20241014201828.91221-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() and rtnl_register_module() in favour
of rtnl_register_many().

When it succeeds for built-in callers, rtnl_register_many() guarantees
all rtnetlink types in the passed array are supported, and there is no
chance that a part of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add __initconst and __initconst_or_module
  * Use C99 initialisation
---
 net/ipv4/ipmr.c  | 22 +++++++++++++---------
 net/ipv6/ip6mr.c | 13 +++++++++----
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 7a95daeb1946..b4fc443481ce 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3137,6 +3137,17 @@ static struct pernet_operations ipmr_net_ops = {
 	.exit_batch = ipmr_net_exit_batch,
 };
 
+static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
+	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETLINK,
+	 .dumpit = ipmr_rtm_dumplink},
+	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_NEWROUTE,
+	 .doit = ipmr_rtm_route},
+	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_DELROUTE,
+	 .doit = ipmr_rtm_route},
+	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETROUTE,
+	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute},
+};
+
 int __init ip_mr_init(void)
 {
 	int err;
@@ -3157,15 +3168,8 @@ int __init ip_mr_init(void)
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
index 9528e17665fd..437a9fdb67f5 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1367,6 +1367,12 @@ static struct pernet_operations ip6mr_net_ops = {
 	.exit_batch = ip6mr_net_exit_batch,
 };
 
+static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
+	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
+	 .msgtype = RTM_GETROUTE,
+	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute},
+};
+
 int __init ip6_mr_init(void)
 {
 	int err;
@@ -1389,9 +1395,8 @@ int __init ip6_mr_init(void)
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
@@ -1408,7 +1413,7 @@ int __init ip6_mr_init(void)
 
 void ip6_mr_cleanup(void)
 {
-	rtnl_unregister(RTNL_FAMILY_IP6MR, RTM_GETROUTE);
+	rtnl_unregister_many(ip6mr_rtnl_msg_handlers);
 #ifdef CONFIG_IPV6_PIMSM_V2
 	inet6_del_protocol(&pim6_protocol, IPPROTO_PIM);
 #endif
-- 
2.39.5 (Apple Git-154)


