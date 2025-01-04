Return-Path: <netdev+bounces-155128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842BA012CC
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19607A12DF
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DABF146A60;
	Sat,  4 Jan 2025 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="THaVfdeN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161235959
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972712; cv=none; b=IMXcpmV/qgVZzaS2GeAxIRXlDX1K5EO8ret13c+B5r+MXPyEGEhw2RriH3qt7c9l5KF4ac+7kOTtTwYcF0HH7c1S2snmZhJhGWkq957l3hHmbUYfNQEaNCFvzxrFkrYLdZA2MZLRocSSJuycJ7HZiK0e+EY5QR7Su8njmhgZmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972712; c=relaxed/simple;
	bh=1KY2nW7mCAO/gQN6+vP4tuWBqSrq7KK/sYxEW/qt3T0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJjwqPAWpHsfbIXZ2oQzBdCo25o8hZaMv1/JC2jpbLgkTxjE//g4U8jiVat30v/ZwznjcTZdjIU5SSe1PELvRU1ch5xW04hlJilMlO1hm7Ry5FXBX+cfMUxdC960v+Jdm5DkHqDiZ0Vmp3rzx5IBc+kbAlWfNqJKCFTKuLLRoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=THaVfdeN; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735972711; x=1767508711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63C6D2JvOmHN8gsZTjW8wLqNNd5ilwpwls75PuN1uI4=;
  b=THaVfdeN0Ut3F032jteop/B4TqBnphYJMPS2JhwdiWnV9+sXrvTsTC4T
   RgAoIHn5rbX5p7T91IOGq027JtWUbuTLWe6hkwVVW8mlE47Xohc9w6nQ3
   6TWH2S8pLqJTk9/PvGZrURrOJnCwxv5M7lBj/CNqys641MFfArROmtxUi
   0=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="161619420"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:38:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:35266]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.171:2525] with esmtp (Farcaster)
 id 2deb9544-7295-49c3-89e4-8eaaf5a1c18a; Sat, 4 Jan 2025 06:38:30 +0000 (UTC)
X-Farcaster-Flow-ID: 2deb9544-7295-49c3-89e4-8eaaf5a1c18a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:38:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:38:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/4] net: Convert netdev_chain to blocking_notifier.
Date: Sat, 4 Jan 2025 15:37:32 +0900
Message-ID: <20250104063735.36945-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250104063735.36945-1-kuniyu@amazon.com>
References: <20250104063735.36945-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once RTNL is converted to per-netns, nothing protects
netdev_chain.

A netdev notifier might disappear while being used by
raw_notifier_call_chain().

Let's convert netdev_chain to blocking_notifier to add
its dedicated rwsem.

Given netdev_chain is touched under RTNL by only one user
at the same time, adding rwsem is unlikely to cause regression.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aa..404f5bda821b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -444,7 +444,7 @@ static void unlist_netdevice(struct net_device *dev)
  *	Our notifier list
  */
 
-static RAW_NOTIFIER_HEAD(netdev_chain);
+static BLOCKING_NOTIFIER_HEAD(netdev_chain);
 
 /*
  *	Device drivers call our routines to queue packets here. We empty the
@@ -1770,7 +1770,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	/* Close race with setup_net() and cleanup_net() */
 	down_write(&pernet_ops_rwsem);
 	rtnl_lock();
-	err = raw_notifier_chain_register(&netdev_chain, nb);
+	err = blocking_notifier_chain_register(&netdev_chain, nb);
 	if (err)
 		goto unlock;
 	if (dev_boot_phase)
@@ -1790,7 +1790,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	for_each_net_continue_reverse(net)
 		call_netdevice_unregister_net_notifiers(nb, net);
 
-	raw_notifier_chain_unregister(&netdev_chain, nb);
+	blocking_notifier_chain_unregister(&netdev_chain, nb);
 	goto unlock;
 }
 EXPORT_SYMBOL(register_netdevice_notifier);
@@ -1817,7 +1817,7 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 	/* Close race with setup_net() and cleanup_net() */
 	down_write(&pernet_ops_rwsem);
 	rtnl_lock();
-	err = raw_notifier_chain_unregister(&netdev_chain, nb);
+	err = blocking_notifier_chain_unregister(&netdev_chain, nb);
 	if (err)
 		goto unlock;
 
@@ -1993,7 +1993,7 @@ int call_netdevice_notifiers_info(unsigned long val,
 	ret = raw_notifier_call_chain(&net->netdev_chain, val, info);
 	if (ret & NOTIFY_STOP_MASK)
 		return ret;
-	return raw_notifier_call_chain(&netdev_chain, val, info);
+	return blocking_notifier_call_chain(&netdev_chain, val, info);
 }
 
 /**
-- 
2.39.5 (Apple Git-154)


