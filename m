Return-Path: <netdev+bounces-130604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7C98AE55
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B059B25A6A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370061A3022;
	Mon, 30 Sep 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lqUW2PD4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC721A2C20
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727996; cv=none; b=BybsOseyfDf1cGgl39OxuQlB34x8xRWfcLZZ7NvwF9EwtFFuNM6/7jMXiEQs+67FroANFzwC7LssD3hRhO1r3QB2kuvEfQscgym6tqoqpLmYhU5oKie5qbttuURz9P6RMaxEGY/B0QOhT60PyjxcANbtL5YtfsYBS1cqt3915gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727996; c=relaxed/simple;
	bh=avI7CbtSgYT3PZ0zrv09fSqPIFyEElTG6BUZsGpiXno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8YGH1xh3ET1yHBe+LrmVV67nR7HibnJD5wjuS633skCFyQePDGC6/BRiaXwOmcn4MsPdjCenISfEycv2Hmh+O7N5xdRNbAc2pDS7QYQobn7zKK1MO/EcG2XRP5hRToV8casJhj3OJ/8iK3sgllHNHgkrFzQCOV9oo9xTnDTQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lqUW2PD4; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727727994; x=1759263994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iN8/k4enU7wM92j6dtYpU+KNp+iXsbY8xMcV516k7WA=;
  b=lqUW2PD4P14duH5ZjG5zok0l3SD2V9jGcwgzhRMld6xyjtk4Np26lYCU
   6sS0wB7rA3D4jVsWKp89s5y/HYE7bPmtFMPkxyKMWTQLuN482Pz8cQKkw
   cmR2aTYaoPDcuSXx4gx6GDoDDLTCd4wt0GoFKkIA7UeKtIusnBA8C5uob
   c=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="132604465"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 20:26:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:56877]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.191:2525] with esmtp (Farcaster)
 id 561f2e7c-5ed0-4b10-a8f1-9ce9ae0cf5c0; Mon, 30 Sep 2024 20:26:31 +0000 (UTC)
X-Farcaster-Flow-ID: 561f2e7c-5ed0-4b10-a8f1-9ce9ae0cf5c0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 30 Sep 2024 20:26:31 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 30 Sep 2024 20:26:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/3] rtnetlink: Per-net RTNL.
Date: Mon, 30 Sep 2024 23:25:22 +0300
Message-ID: <20240930202524.59357-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_lock() is a "Big Kernel Lock" in the networking slow path and
serialised all rtnetlink requests until 4.13.

Since RTNL_FLAG_DOIT_UNLOCKED and RTNL_FLAG_DUMP_UNLOCKED have been
introduced in 4.14 and 6.9, respectively, rtnetlink message handlers
are ready to be converted to RTNL-less/free.

15 out of 44 dumpit()s have been converted to RCU so far, and the
progress is pretty good.  We can now dump various major network
resources without RTNL.

12 out of 87 doit()s have been converted, but most of the converted
doit()s are also on the reader side of RTNL; their message types are
RTM_GET*.

So, most of RTM_(NEW|DEL|SET)* operations are still serialised by RTNL.

For example, one of our services creates 2K netns and a small number
of network interfaces in each netns that require too many writer-side
rtnetlink requests, and setting up a single host takes 10+ minutes.

RTNL is still a huge pain for network configuration paths, and we need
more granular locking, given converting all doit()s would be unfeasible.

Actually, most RTNL users do not need to freeze multiple netns, and such
users can be protected by per-net RTNL mutex.  The exceptions would be
RTM_NEWLINK, RTM_DELLINK, and RTM_SETLINK.  (See [0])

This series is the first step of the per-net RTNL conversion that
gradually replaces rtnl_lock() with rtnl_net_lock(net) under
CONFIG_DEBUG_NET_SMALL_RTNL.

[0]: https://lpc.events/event/18/contributions/1959/


Kuniyuki Iwashima (3):
  rtnetlink: Add per-net RTNL.
  rtnetlink: Add assertion helpers for per-net RTNL.
  rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.

 include/linux/rtnetlink.h   |  38 +++++++++++
 include/net/net_namespace.h |   4 ++
 net/Kconfig.debug           |  14 ++++
 net/core/Makefile           |   1 +
 net/core/net_namespace.c    |   6 ++
 net/core/rtnetlink.c        |  70 +++++++++++++++++++
 net/core/rtnl_net_debug.c   | 131 ++++++++++++++++++++++++++++++++++++
 7 files changed, 264 insertions(+)
 create mode 100644 net/core/rtnl_net_debug.c

-- 
2.30.2


