Return-Path: <netdev+bounces-132264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B99991247
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF1AB2121E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1E1AE009;
	Fri,  4 Oct 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Dcx5t5km"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8F1474B9
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080701; cv=none; b=D0yRpXioM/D3DA7df7pFJcCiyc5e3ET9Bl5v+h9H0dLdcrD/6QUO7/EWwJg8K6cyKwjUmv6fYkTbfI7DQ/OgX2ZjUPowep8+3SUKrPz5+RZw1Pb6nJFPNX4I2A/eqrQp1c7t5YpFY91Ysrf4IY4EdSYTXo/MCn96Jm6JOFFiq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080701; c=relaxed/simple;
	bh=bYWrwZ3KRdxV/MYkDFB9m2JZ3vPtJUXFMpJYUXiWMS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2TY2JHgFypyEKzultr3I/bj9qG8JZL77VgnvuSdr/Lcahq2Bxu7YjNVgNBDH+XMgc7xtv4WpfgSH3c9xblRfRJIvZoctgfPc78DxIn+8dT5lbCtT6iCN6LgkJU1AOuVwuHN+z/k+eaS/D5MmwEQEJyFgq5g4ichfTpZnVcyI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Dcx5t5km; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728080700; x=1759616700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jaspAmYjxPpjoDdOyJF57w+i/GYV07UYc6SnYI+f5o=;
  b=Dcx5t5kmzLqQoE2Z4E0/nWrxWvGC6gj4NmUcVn+H23YyrdObpUPTr/Jy
   7qcCK7yqgqNLhmAZbqZWcxoSv/6IJRGINCYRBRvnjPOgl5ht+LTvf44O8
   8WcP9Rjn0TnVy2BU8cOSFlqRbAP5A20+jgWajr0hvtgbmZ/1ThY6EJFdU
   k=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="339909139"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:24:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:62166]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id f2e43582-d156-413e-a40a-f6574638161c; Fri, 4 Oct 2024 22:24:58 +0000 (UTC)
X-Farcaster-Flow-ID: f2e43582-d156-413e-a40a-f6574638161c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:24:58 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:24:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>
Subject: [PATCH v2 net 2/6] vxlan: Handle error of rtnl_register_module().
Date: Fri, 4 Oct 2024 15:23:54 -0700
Message-ID: <20241004222358.79129-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004222358.79129-1-kuniyu@amazon.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, vxlan_vnifilter_init() has been ignoring the
returned value of rtnl_register_module(), which could fail.

Let's handle the errors by rtnl_register_module_many().

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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
index 9c59d0bf8c3d..27b4d179a703 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -992,19 +992,18 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void vxlan_vnifilter_init(void)
+static struct rtnl_msg_handler vxlan_vnifilter_rtnl_msg_handlers[] = {
+	{PF_BRIDGE, RTM_GETTUNNEL, NULL, vxlan_vnifilter_dump, 0},
+	{PF_BRIDGE, RTM_NEWTUNNEL, vxlan_vnifilter_process, NULL, 0},
+	{PF_BRIDGE, RTM_DELTUNNEL, vxlan_vnifilter_process, NULL, 0},
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
+	return rtnl_register_module_many(vxlan_vnifilter_rtnl_msg_handlers);
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


