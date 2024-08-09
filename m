Return-Path: <netdev+bounces-117324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DD94D952
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42825B21A4F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465B16D4D6;
	Fri,  9 Aug 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PI8b2B1r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B016B381
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247739; cv=none; b=clwBHOeJeNqA8KJpgvZfkthxxdqh76opT1bZSY9orfXZBAGLs0FK7+xlyrf9iDdntM5Xv/H9ApTX9MOVWeUTlvTL+oYrXn6sWkLrik2kY0OYjxnCN6ganRFpSj6xdwuvP/msfjYHRBfm2XOUzAclHVVWLcKvUbQ5wwmUvlZ/EnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247739; c=relaxed/simple;
	bh=GuS0yFhxPQXy+ME1cyTBPYnTSSvm9aIkUUr0rMECVW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+zHncYj8wjRwUeykYRVdp+A5s/AoOBDE1wc6RIp3xIe/CBOFg0tn1myinwpyBfKoogXdUrm0yvy1IG1ZO6jlRFQNepBv8pSnHvnjN7C/EFPhmt7MCBdaAy/KlE5qAq5/v0RAZwj0CG0xkTiGGeGNwwRsJatmRe3E4qGYPWtrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PI8b2B1r; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723247738; x=1754783738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycHMY+zdhO4Vj9Dizb3zkIWvaHW7Rh/A1UQcuQ5lSno=;
  b=PI8b2B1rsOv9RMuVMKtJ6xgbM2cfZW1D9iNJgpQVeu13YsB3HgMSwuLb
   aUxQcJGfENTGe9c1WhqAfXW67PbYMengDkuOwhqnkVVN0SysxOWtsrvio
   7sYAMDf/yPCrEwh8g6v/ytpsNtcKZ/2psWiZm1GLvS5T1mb/pLzlGer+y
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="18103379"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 23:55:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:53265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.16:2525] with esmtp (Farcaster)
 id 0e648992-f3bf-4dd7-b4ca-accc58bbfaff; Fri, 9 Aug 2024 23:55:33 +0000 (UTC)
X-Farcaster-Flow-ID: 0e648992-f3bf-4dd7-b4ca-accc58bbfaff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:55:33 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:55:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Manish Chopra
	<manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
	<PGR-Linux-NIC-Dev@marvell.com>
Subject: [PATCH v1 net-next 3/5] ipv4: Remove redundant !ifa->ifa_dev check.
Date: Fri, 9 Aug 2024 16:54:04 -0700
Message-ID: <20240809235406.50187-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809235406.50187-1-kuniyu@amazon.com>
References: <20240809235406.50187-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now, ifa_dev is only set in inet_alloc_ifa() and never
NULL after ifa gets visible.

Let's remove the unneeded NULL check for ifa->ifa_dev.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
CC: Manish Chopra <manishc@marvell.com>
CC: Rahul Verma <rahulv@marvell.com>
CC: PGR-Linux-NIC-Dev@marvell.com
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 5 ++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c     | 2 +-
 net/ipv4/devinet.c                                   | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index ed24d6af7487..9cff0a8ffb2c 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -3185,8 +3185,7 @@ netxen_list_config_ip(struct netxen_adapter *adapter,
 	struct list_head *head;
 	bool ret = false;
 
-	dev = ifa->ifa_dev ? ifa->ifa_dev->dev : NULL;
-
+	dev = ifa->ifa_dev->dev;
 	if (dev == NULL)
 		goto out;
 
@@ -3379,7 +3378,7 @@ netxen_inetaddr_event(struct notifier_block *this,
 	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
 	unsigned long ip_event;
 
-	dev = ifa->ifa_dev ? ifa->ifa_dev->dev : NULL;
+	dev = ifa->ifa_dev->dev;
 	ip_event = (event == NETDEV_UP) ? NX_IP_UP : NX_IP_DOWN;
 recheck:
 	if (dev == NULL)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 90df4a0909fa..b3588a1ebc25 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -4146,7 +4146,7 @@ qlcnic_inetaddr_event(struct notifier_block *this,
 
 	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
 
-	dev = ifa->ifa_dev ? ifa->ifa_dev->dev : NULL;
+	dev = ifa->ifa_dev->dev;
 
 recheck:
 	if (dev == NULL)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 9f4add07e67d..baf036bfad76 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -234,8 +234,7 @@ static void inet_rcu_free_ifa(struct rcu_head *head)
 {
 	struct in_ifaddr *ifa = container_of(head, struct in_ifaddr, rcu_head);
 
-	if (ifa->ifa_dev)
-		in_dev_put(ifa->ifa_dev);
+	in_dev_put(ifa->ifa_dev);
 	kfree(ifa);
 }
 
-- 
2.30.2


