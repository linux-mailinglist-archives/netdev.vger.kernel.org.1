Return-Path: <netdev+bounces-142620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA689BFC8E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18751C20C15
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A20101F2;
	Thu,  7 Nov 2024 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SO1XLOZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07A3D64
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946618; cv=none; b=QTQgy7qkos0HUQyBZlSxr9E+FpU+cv49dGhhd1icD8g3MGueIqLzzf7DZZKxWZcHfAzJUwTuhpxtJAjOpCum6qrsYCKiwfYG2DuTvmq/Ualyv7JggF161HmKrDTleUDW2Qk5fowCJNQeZtkLULudLal3+BzzOb8Oh2Iel56J4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946618; c=relaxed/simple;
	bh=XSOnrtsCaK64Pb+d5voj4SXFSBXeLCaq1ypTtWsT2oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXpfx1UdwFpxes1Nep1g7HAb2vT2FcFlHsE/G/sJoLwBwENpkSL+QCpyIcuUAZWs8ueDndQtxBwHeshyhbdxrx3hyDozvpoCFQQhVcIjboXhEpH9NtANSKHlqATiNsS0vQiMBLM4JIE1ShWhd/uwYI6JVmEE9P8CdM7CfPW+osY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SO1XLOZr; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946616; x=1762482616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OyXAaoIylgoHdkd4qYGrncSlJdlOp4KDDXaNaR16NGI=;
  b=SO1XLOZrKxVh1HOmhZ4OL4FMGfUR5okCSaiy5tgKbTFUX/4RAFPzj2cI
   HmAjGV/qJV3N2783EYLqyGjLh9nrFS1nXUBpecDnMh41IS3HsV+Nip/09
   CMU9s/an36aAz/JOF9pFO9hlrL0a0Ij0i8ZYE8c/1wdlcwgm6SKk+igbW
   8=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="145048066"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:30:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:21323]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.86:2525] with esmtp (Farcaster)
 id 4f4bd4d4-6926-4a1e-83e4-b8ec39c73cc2; Thu, 7 Nov 2024 02:30:14 +0000 (UTC)
X-Farcaster-Flow-ID: 4f4bd4d4-6926-4a1e-83e4-b8ec39c73cc2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:30:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:30:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 03/10] rtnetlink: Remove __rtnl_link_register()
Date: Wed, 6 Nov 2024 18:28:53 -0800
Message-ID: <20241107022900.70287-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107022900.70287-1-kuniyu@amazon.com>
References: <20241107022900.70287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

link_ops is protected by link_ops_mutex and no longer needs RTNL,
so we have no reason to have __rtnl_link_register() separately.

Let's remove it and call rtnl_link_register() from ifb.ko and
dummy.ko.

Note that both modules' init() work on init_net only, so we need
not export pernet_ops_rwsem and can use rtnl_net_lock() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/dummy.c      | 17 ++++++-----------
 drivers/net/ifb.c        | 17 ++++++-----------
 include/net/rtnetlink.h  |  2 --
 net/core/net_namespace.c |  1 -
 net/core/rtnetlink.c     | 35 +++++++----------------------------
 5 files changed, 19 insertions(+), 53 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index 72618b6af44e..005d79975f3b 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -166,27 +166,22 @@ static int __init dummy_init_one(void)
 
 static int __init dummy_init_module(void)
 {
-	bool need_unregister = false;
 	int i, err = 0;
 
-	down_write(&pernet_ops_rwsem);
-	rtnl_lock();
-	err = __rtnl_link_register(&dummy_link_ops);
+	err = rtnl_link_register(&dummy_link_ops);
 	if (err < 0)
-		goto out;
+		return err;
+
+	rtnl_net_lock(&init_net);
 
 	for (i = 0; i < numdummies && !err; i++) {
 		err = dummy_init_one();
 		cond_resched();
 	}
-	if (err < 0)
-		need_unregister = true;
 
-out:
-	rtnl_unlock();
-	up_write(&pernet_ops_rwsem);
+	rtnl_net_unlock(&init_net);
 
-	if (need_unregister)
+	if (err < 0)
 		rtnl_link_unregister(&dummy_link_ops);
 
 	return err;
diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index a4b9ec4e8f30..67424888ff0a 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -424,27 +424,22 @@ static int __init ifb_init_one(int index)
 
 static int __init ifb_init_module(void)
 {
-	bool need_unregister = false;
 	int i, err;
 
-	down_write(&pernet_ops_rwsem);
-	rtnl_lock();
-	err = __rtnl_link_register(&ifb_link_ops);
+	err = rtnl_link_register(&ifb_link_ops);
 	if (err < 0)
-		goto out;
+		return err;
+
+	rtnl_net_lock(&init_net);
 
 	for (i = 0; i < numifbs && !err; i++) {
 		err = ifb_init_one(i);
 		cond_resched();
 	}
-	if (err)
-		need_unregister = true;
 
-out:
-	rtnl_unlock();
-	up_write(&pernet_ops_rwsem);
+	rtnl_net_unlock(&init_net);
 
-	if (need_unregister)
+	if (err)
 		rtnl_link_unregister(&ifb_link_ops);
 
 	return err;
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 7559020f760c..ef7c11f0d74c 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -164,8 +164,6 @@ struct rtnl_link_ops {
 						   int *prividx, int attr);
 };
 
-int __rtnl_link_register(struct rtnl_link_ops *ops);
-
 int rtnl_link_register(struct rtnl_link_ops *ops);
 void rtnl_link_unregister(struct rtnl_link_ops *ops);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 809b48c0a528..157021ced442 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -56,7 +56,6 @@ static bool init_net_initialized;
  * outside.
  */
 DECLARE_RWSEM(pernet_ops_rwsem);
-EXPORT_SYMBOL_GPL(pernet_ops_rwsem);
 
 #define MIN_PERNET_OPS_ID	\
 	((sizeof(struct net_generic) + sizeof(void *) - 1) / sizeof(void *))
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fcccb916e468..61bf710f97b8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -495,20 +495,21 @@ static void rtnl_link_ops_put(struct rtnl_link_ops *ops, int srcu_index)
 }
 
 /**
- * __rtnl_link_register - Register rtnl_link_ops with rtnetlink.
+ * rtnl_link_register - Register rtnl_link_ops with rtnetlink.
  * @ops: struct rtnl_link_ops * to register
  *
- * The caller must hold the rtnl_mutex. This function should be used
- * by drivers that create devices during module initialization. It
- * must be called before registering the devices.
- *
  * Returns 0 on success or a negative error code.
  */
-int __rtnl_link_register(struct rtnl_link_ops *ops)
+int rtnl_link_register(struct rtnl_link_ops *ops)
 {
 	struct rtnl_link_ops *tmp;
 	int err;
 
+	/* Sanity-check max sizes to avoid stack buffer overflow. */
+	if (WARN_ON(ops->maxtype > RTNL_MAX_TYPE ||
+		    ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE))
+		return -EINVAL;
+
 	/* The check for alloc/setup is here because if ops
 	 * does not have that filled up, it is not possible
 	 * to use the ops for creating device. So do not
@@ -536,28 +537,6 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(__rtnl_link_register);
-
-/**
- * rtnl_link_register - Register rtnl_link_ops with rtnetlink.
- * @ops: struct rtnl_link_ops * to register
- *
- * Returns 0 on success or a negative error code.
- */
-int rtnl_link_register(struct rtnl_link_ops *ops)
-{
-	int err;
-
-	/* Sanity-check max sizes to avoid stack buffer overflow. */
-	if (WARN_ON(ops->maxtype > RTNL_MAX_TYPE ||
-		    ops->slave_maxtype > RTNL_SLAVE_MAX_TYPE))
-		return -EINVAL;
-
-	rtnl_lock();
-	err = __rtnl_link_register(ops);
-	rtnl_unlock();
-	return err;
-}
 EXPORT_SYMBOL_GPL(rtnl_link_register);
 
 static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
-- 
2.39.5 (Apple Git-154)


