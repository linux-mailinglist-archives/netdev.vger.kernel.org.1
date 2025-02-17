Return-Path: <netdev+bounces-167082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F47A38C21
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A7C3AD923
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A759D236421;
	Mon, 17 Feb 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p2TTIRKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082D1922FA
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819514; cv=none; b=iCory5AT7/Jmml0WTULboPb4BTs+ggni2ZXhEqLc8On8394Hz0eW/yYtyh4cj6Asn+cBSUz3MJuL1RI3vvdDuuAgMrT01KKCwZtESk9lyErvBPC6Pwpni7s8DlQ7CMdwOjW6si2wrksq4oRCSbvN3ry49vObaIs6Jsyj+4e8MsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819514; c=relaxed/simple;
	bh=pwT1yz+HrYPAml0LG93TUa1+7fyoH8TXkOcTDwdZnTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XkL8eqCSILMSi1NyNCAVtgWXG3PVjWtLB8mNQgnNZilmbOvdAa8jSm91CFaWZEyjMf/bBm+CFFg11noj5G4xSpBmCJgRAZ8k9htTTT44Y9iA0fCM1KvlusxL84wmIMukY+/G77/4/ef6J5Cd3fRxjNTOMWPKcB0WcRPtpS88El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p2TTIRKQ; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739819514; x=1771355514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V0Oy//rJSnMo4DDnP+ceOWJ/3oRH6FbuNVOZUZVtSdQ=;
  b=p2TTIRKQAzozOy9OsXoQZDUzesUElHIEylkf8e+ZAglNLJpvZGl1a45G
   MvbKrX5xrjwsY3TkwLCheIj3w9NlZBq9+g3HpWeCUltNo7V/7Y3hUkl/Z
   igJljoM01Ffz8C2810EbMfh/8Paq7nLbR4eLAoG1Gd0FrHRDnceM9+sRK
   4=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="409369643"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:11:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:27032]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.181:2525] with esmtp (Farcaster)
 id 2f0b56ac-70bc-42c6-a6fc-bb8d2feebe6a; Mon, 17 Feb 2025 19:11:47 +0000 (UTC)
X-Farcaster-Flow-ID: 2f0b56ac-70bc-42c6-a6fc-bb8d2feebe6a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 19:11:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 19:11:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net 0/3] net: Fix race of rtnl_net_lock(dev_net(dev)).
Date: Mon, 17 Feb 2025 11:11:26 -0800
Message-ID: <20250217191129.19967-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Yael Chemla reported that commit 7fb1073300a2 ("net: Hold rtnl_net_lock()
in (un)?register_netdevice_notifier_dev_net().") started to trigger KASAN's
use-after-free splat.

The problem is that dev_net(dev) fetched before rtnl_net_lock() might be
different after rtnl_net_lock().

The patch 2 fixes the issue by checking dev_net(dev) after rtnl_net_lock(),
and the patch 3 fixes the same potential issue that would emerge once RTNL
is removed.


Changes:
  v5:
    * Use do-while loop instead of goto

  v4: https://lore.kernel.org/netdev/20250212064206.18159-1-kuniyu@amazon.com/
    * Add patch 1
    * Fix build failure for !CONFIG_NET_NS in patch 2

  v3: https://lore.kernel.org/netdev/20250211051217.12613-1-kuniyu@amazon.com/
    * Bump net->passive instead of maybe_get_net()
    * Remove msleep(1) loop
    * Use rcu_access_pointer() instead of rcu_read_lock().

  v2: https://lore.kernel.org/netdev/20250207044251.65421-1-kuniyu@amazon.com/
    * Use dev_net_rcu()
    * Use msleep(1) instead of cond_resched() after maybe_get_net()
    * Remove cond_resched() after net_eq() check

  v1: https://lore.kernel.org/netdev/20250130232435.43622-1-kuniyu@amazon.com/


Kuniyuki Iwashima (3):
  net: Add net_passive_inc() and net_passive_dec().
  net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
  dev: Use rtnl_net_dev_lock() in unregister_netdev().

 include/net/net_namespace.h | 11 ++++++++
 net/core/dev.c              | 54 +++++++++++++++++++++++++++++++------
 net/core/net_namespace.c    |  8 +++---
 3 files changed, 61 insertions(+), 12 deletions(-)

-- 
2.39.5 (Apple Git-154)


