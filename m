Return-Path: <netdev+bounces-133280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C399571B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3AA1C24C04
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522D212D10;
	Tue,  8 Oct 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R/7sItxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387D212D02
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413325; cv=none; b=kxcrLzYYOARQhlgjm+xzG1K4Ul7bddXlF6BJN2YKmRuDkoVTQpKBmnUnh500no5ljJx7+MeLuY3J8YEcnH2vFBYTokpchCJbMsqOSxs/rKbcw0eWkjRDDWsX/Sbf1fjXyRkFaepaeJBcWx57EMfPS034ISBBr6zfe07Rqr0Wo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413325; c=relaxed/simple;
	bh=qWqvrszZNbm1oaW6wamKsQUr1q6kUoobHMtKmpGLuPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fleN7i+hA8BgefJgLsCAXpx2exUcIMCLAX1/xbSYsN2246cFfu++FUq+Q3bn0xsT8394J/qmZ4R0Z/rY6+XSuGzb/Kgkb41YCDuu8Ap0gpD2Ld9p2c9ug1WyqtMgbG8I89WiFlocnKdf2Lq0e7EqM3yjp7rEodeOxZdgC7qng1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R/7sItxf; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728413325; x=1759949325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=duiP52iqBfqkt1lZxGigdNOPuKbiOY7pLy8WTdV2uyg=;
  b=R/7sItxfMnwUu7+zcr2zZ/XBuONROJd3DfIHNrsscOKzyzhkgxLBU66N
   eQKmqTQ05zAifoqoOaF4/gNWDanHtyYTcxs+Du2bhk+Lpc5/N220LIvL1
   8KX6qhMttl+UwHFb3KQWL/zDWDX1znTsvsv4O8HZWIdMZhm0vJD2kawoY
   A=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="374393082"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:48:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:31891]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id 809f5fe6-4298-4220-8458-20646f0f6c99; Tue, 8 Oct 2024 18:48:37 +0000 (UTC)
X-Farcaster-Flow-ID: 809f5fe6-4298-4220-8458-20646f0f6c99
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 18:48:37 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 18:48:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH v4 net 2/6] vxlan: Handle error of rtnl_register_module().
Date: Tue, 8 Oct 2024 11:47:33 -0700
Message-ID: <20241008184737.9619-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008184737.9619-1-kuniyu@amazon.com>
References: <20241008184737.9619-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, vxlan_vnifilter_init() has been ignoring the
returned value of rtnl_register_module(), which could fail silently.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's handle the errors by rtnl_register_many().

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Cc: Roopa Prabhu <roopa@nvidia.com>

v3: Add more context in changelog
v2: Make rtnl_msg_handler const
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


