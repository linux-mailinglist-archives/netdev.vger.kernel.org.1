Return-Path: <netdev+bounces-155131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7729A012CF
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78597164121
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BF13A258;
	Sat,  4 Jan 2025 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zbs6DPkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286221A29A
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972796; cv=none; b=ny+W8ftDbyHXxn/+bw5LxenG726u4IaYALoghL3j0ITqE240to5GX1S4kBdVo+lzW1jxQQUvnA8N6yGBDVCvg0MLxFQDkp6vwesJScrHlcsb44bnNoL0tStPJb0cE739aWwkaHGfVtdzic6gFIxXjxQBYzAgbIiv3m5BsvcJ3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972796; c=relaxed/simple;
	bh=6WENTeKSDRdyEm+fSrgDwuHbeUXmzeZher9/QMzN2wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoXq3vAMpov+R2bjkPjnJTJk9LU1cK0n1PlQs+eA93segzga/FR1jdPOy7TCO5JMruoZveDxOHDKkEIEfRu8oNw0fx6KENV+J974bAvFDKLx1qrCRzVjDPPkw/dQgvxmqZMDOozZvzPrfAVzkmVUE/EQVkN6pOQr5o7DwxVeVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zbs6DPkT; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735972795; x=1767508795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1Z7phS8bZxHyqTW+DXtuHuNTdjBFWacRFAxiPyGEIQ=;
  b=Zbs6DPkTreUV3HZDHkMKxDtJQBdDYjIYEqEQ+DeSHplKpEjavOQGaoPx
   JG/vIDzd/CINKP3vEo/C1VsK+u9+R22P4A3/WYUW0jCh7ilYMcxyA4tqT
   my7cXTvNhLBEFp1NbN1zfBJbWajRq3OlDrakOE1sgf18TM37TnB6gNJQX
   8=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="686778619"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:39:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21143]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.3:2525] with esmtp (Farcaster)
 id d2f1c624-3f0b-4cbc-a323-b8e41a55cbf4; Sat, 4 Jan 2025 06:39:51 +0000 (UTC)
X-Farcaster-Flow-ID: d2f1c624-3f0b-4cbc-a323-b8e41a55cbf4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:39:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:39:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
Date: Sat, 4 Jan 2025 15:37:35 +0900
Message-ID: <20250104063735.36945-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

(un)?register_netdevice_notifier_dev_net() hold RTNL before triggering
the notifier for all netdev in the netns.

Let's convert the RTNL to rtnl_net_lock().

Note that move_netdevice_notifiers_dev_net() is assumed to be (but not
yet) protected by per-netns RTNL of both src and dst netns; we need to
convert wireless and hyperv drivers that call dev_change_net_namespace().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f6c6559e2548..a0dd34463901 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 					struct notifier_block *nb,
 					struct netdev_net_notifier *nn)
 {
+	struct net *net = dev_net(dev);
 	int err;
 
-	rtnl_lock();
-	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
+	rtnl_net_lock(net);
+	err = __register_netdevice_notifier_net(net, nb, false);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);
 	}
-	rtnl_unlock();
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(register_netdevice_notifier_dev_net);
@@ -1960,12 +1962,14 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 					  struct notifier_block *nb,
 					  struct netdev_net_notifier *nn)
 {
+	struct net *net = dev_net(dev);
 	int err;
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
-	rtnl_unlock();
+	err = __unregister_netdevice_notifier_net(net, nb);
+	rtnl_net_unlock(net);
+
 	return err;
 }
 EXPORT_SYMBOL(unregister_netdevice_notifier_dev_net);
-- 
2.39.5 (Apple Git-154)


