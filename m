Return-Path: <netdev+bounces-132683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0E992C53
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54A11C22901
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90791D4356;
	Mon,  7 Oct 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YJmxOg3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A331D45F3
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305165; cv=none; b=awGhmykSOBng1PVFCr57kye8QWvq2/DmtXk669n8CFwlB0n+YCfhIHgH7WwAtE3NXd1HG03KAsZ0pnB2umhYet2za+i8el7tGG1iFRgwDkYHJZfCO/1N9i82gMYNJ4rYPn9HW7b2NQ4GGiYSbL1pnLVnnJz7MdEACpbQjlcocbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305165; c=relaxed/simple;
	bh=cpuJ4YppAsmgbh6HDmfwcQSmtFlt6MpqkLGD+ZK9Fms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5og9pGhU8devgipxWD5AwGOy6VQVHUuMIQaff3mglJ367ztyJ9hdYx1H91ntLJGz+IiBvEcsMqOQ9ACWWwZfUHxw4Ac8PPYB4vYrT1xw5X/LF7IFC5PoNy8QjzGnf1+YVG/GfCvapyo/DA9XdcWHErJbKa3sPv0qkNZ0iZHyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YJmxOg3v; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728305164; x=1759841164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pcGz1bAMUO11YQ77zYSzdrt0wEAnYUKQFQTgjNqs4Xk=;
  b=YJmxOg3vN4Y/7ZPWHY+i+7zW1/gjH+JmPPNe4gCPPydcLof0DxrM3zCo
   tesh7MWOBVizlSdA/CCtwIxqZsmjsDd/+Rc4fcjs2GmPBhCHr8H3AgGYk
   UgrML8lwTXRfBjbtqt5ormDf1tJwS/bgA+GjkER5pxyelxwS0ROBguCQY
   s=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="340627099"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:46:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:17832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.223:2525] with esmtp (Farcaster)
 id ab992476-abbb-4b31-9f55-5335193094ec; Mon, 7 Oct 2024 12:46:01 +0000 (UTC)
X-Farcaster-Flow-ID: ab992476-abbb-4b31-9f55-5335193094ec
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 12:46:01 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 12:45:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH v3 net 2/6] vxlan: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 05:44:55 -0700
Message-ID: <20241007124459.5727-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, vxlan_vnifilter_init() has been ignoring the
returned value of rtnl_register_module(), which could fail.

Let's handle the errors by rtnl_register_many().

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Cc: Roopa Prabhu <roopa@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c      |  6 +++++-
 drivers/net/vxlan/vxlan_private.h   |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c | 19 +++++++++----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 53dcb9fffc04..6e9a3795846a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4913,9 +4913,13 @@ static int __init vxlan_init_module(void)
 	if (rc)
 		goto out4;
 
-	vxlan_vnifilter_init();
+	rc = vxlan_vnifilter_init();
+	if (rc)
+		goto out5;
 
 	return 0;
+out5:
+	rtnl_link_unregister(&vxlan_link_ops);
 out4:
 	unregister_switchdev_notifier(&vxlan_switchdev_notifier_block);
 out3:
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b35d96b78843..76a351a997d5 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -202,7 +202,7 @@ int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
 int vxlan_vnigroup_init(struct vxlan_dev *vxlan);
 void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan);
 
-void vxlan_vnifilter_init(void);
+int vxlan_vnifilter_init(void);
 void vxlan_vnifilter_uninit(void);
 void vxlan_vnifilter_count(struct vxlan_dev *vxlan, __be32 vni,
 			   struct vxlan_vni_node *vninode,
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 9c59d0bf8c3d..d2023e7131bd 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -992,19 +992,18 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void vxlan_vnifilter_init(void)
+static const struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},
+	{THIS_MODULE, PF_BRIDGE, RTM_NEWTUNNEL, vxlan_vnifilter_process, NULL, 0},
+	{THIS_MODULE, PF_BRIDGE, RTM_DELTUNNEL, vxlan_vnifilter_process, NULL, 0},
+};
+
+int vxlan_vnifilter_init(void)
 {
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_GETTUNNEL, NULL,
-			     vxlan_vnifilter_dump, 0);
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_NEWTUNNEL,
-			     vxlan_vnifilter_process, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_DELTUNNEL,
-			     vxlan_vnifilter_process, NULL, 0);
+	return rtnl_register_many(vxlan_vnifilter_rtnl_msg_handlers);
 }
 
 void vxlan_vnifilter_uninit(void)
 {
-	rtnl_unregister(PF_BRIDGE, RTM_GETTUNNEL);
-	rtnl_unregister(PF_BRIDGE, RTM_NEWTUNNEL);
-	rtnl_unregister(PF_BRIDGE, RTM_DELTUNNEL);
+	rtnl_unregister_many(vxlan_vnifilter_rtnl_msg_handlers);
 }
-- 
2.30.2


