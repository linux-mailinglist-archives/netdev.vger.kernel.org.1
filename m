Return-Path: <netdev+bounces-132686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF783992C59
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A3A1C22860
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7311D3183;
	Mon,  7 Oct 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r5P0G8/o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997A1D318A
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305240; cv=none; b=aoAGNwIa14CjJuazi8FdLlXVxd1AG9Eh6HjSP4RE32UnCCaO5e7NmIwzSaFbeuiOCJEFOVaAtpGuXUvwLFkcCSaVZ4t4lBdQCobFZE7j+skq9D+qUaOwiwqZ/BEQOUnvy612izutK8QBrm6LDZtEYuYndxwfLwwyaY3nLbEUus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305240; c=relaxed/simple;
	bh=JoYARv2KqGfsjKJaVGUP9VF10iQdltyt/0qmyuBLsMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWQoe1oL1n+6ZxKWb0BDPFxiZHJ/Y1vlVNIsbaUiOQiGO5onK7HSDCzKa5YVEJ9FmIZSwOtBteglwL3+3nGxTH63aa4GF+Mq+6TV+xVklplszrmJFHtjVfL3uR8dFOZI2HOA6HCr7vzh2mKU6EiaCM6yjgK79vuyvrUrj8ZfxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r5P0G8/o; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728305239; x=1759841239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oUHhH85iEg+UOU9cWbYRKt+xOND+qfTvOZ3ssvpUSs=;
  b=r5P0G8/o92NSlSzSL2HsEWcSEftNH6F+CMsE3i74BVF1rbYkx/9SJHAS
   ahzfgJRYM1XyBzymP7HMOq1jRg0xWhdTjtP++wlJnSACXECIFcUzMOXV4
   MISVYlAXdB/N4ZrjhO2a/kAbV0QQ/GGXS1VKYEdrN76MeedNzr17q1BTY
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="429420408"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:47:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:21185]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id e4c6902b-f904-43f4-8045-ee951b8254c2; Mon, 7 Oct 2024 12:47:15 +0000 (UTC)
X-Farcaster-Flow-ID: e4c6902b-f904-43f4-8045-ee951b8254c2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 12:47:14 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 12:47:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Eric W. Biederman"
	<ebiederm@xmission.com>
Subject: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 05:44:58 -0700
Message-ID: <20241007124459.5727-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007124459.5727-1-kuniyu@amazon.com>
References: <20241007124459.5727-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, mpls_init() has been ignoring the returned
value of rtnl_register_module(), which could fail.

Let's handle the errors by rtnl_register_many().

Fixes: 03c0566542f4 ("mpls: Netlink commands to add, remove, and dump routes")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 net/mpls/af_mpls.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index aba983531ed3..df62638b6498 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2728,6 +2728,15 @@ static struct rtnl_af_ops mpls_af_ops __read_mostly = {
 	.get_stats_af_size = mpls_get_stats_af_size,
 };
 
+static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_module = {
+	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
+	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
+	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
+	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
+	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 static int __init mpls_init(void)
 {
 	int err;
@@ -2746,24 +2755,25 @@ static int __init mpls_init(void)
 
 	rtnl_af_register(&mpls_af_ops);
 
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_NEWROUTE,
-			     mpls_rtm_newroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_DELROUTE,
-			     mpls_rtm_delroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETROUTE,
-			     mpls_getroute, mpls_dump_routes, 0);
-	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
-			     mpls_netconf_get_devconf,
-			     mpls_netconf_dump_devconf,
-			     RTNL_FLAG_DUMP_UNLOCKED);
-	err = ipgre_tunnel_encap_add_mpls_ops();
+	err = rtnl_register_many(mpls_rtnl_msg_handlers);
 	if (err)
+		goto out_unregister_rtnl_af;
+
+	err = ipgre_tunnel_encap_add_mpls_ops();
+	if (err) {
 		pr_err("Can't add mpls over gre tunnel ops\n");
+		goto out_unregister_rtnl;
+	}
 
 	err = 0;
 out:
 	return err;
 
+out_unregister_rtnl:
+	rtnl_unregister_many(mpls_rtnl_msg_handlers);
+out_unregister_rtnl_af:
+	rtnl_af_unregister(&mpls_af_ops);
+	dev_remove_pack(&mpls_packet_type);
 out_unregister_pernet:
 	unregister_pernet_subsys(&mpls_net_ops);
 	goto out;
-- 
2.30.2


