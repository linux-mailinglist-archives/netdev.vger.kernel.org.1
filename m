Return-Path: <netdev+bounces-132253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCED991227
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A3283260
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2348A14A4C6;
	Fri,  4 Oct 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P32zm1v8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54A231CAD
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079849; cv=none; b=nbpqxafs7ppIwVvQxBRBsvPBt28g+Le2CqTNLOw8hYYTK76lnoCL24kuPEz+4sujvzoBLoUa90bf9tw8hOyCs7hNns+tmOqmlx1wy2ZOz6CP6dFaMb+ntuWA7ICukul8JfxvsbzQ3rTmvTTuy32yXPIQuwLdfUbLsP3uX5qju5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079849; c=relaxed/simple;
	bh=MajqsNGsvlFQbn8e1faVBun7M+ONZHkGHvB984ioMBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6aCjvSa974cvZrAjWPfcd/M/0fbV4JLk+J+ekfKa4+1m943uPXo9cKFDr1VuH6oS8i1SYIScg85RNSC0gU1Df+TYZqGoBhhPqZeAnod/ZuIjQnToRsmyNzfNGMnq57tqx7Ga6Mxhn5YY6+ID8T+wJBk/zPA/vETQQoZC2+F+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P32zm1v8; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728079847; x=1759615847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8RDFwMb8q3aRURiR3p9BXd6sS7v7H2RzaQjADdx2rS4=;
  b=P32zm1v8+klgi+2+6Vxj1SsUMrq7wMSIEluUQsl9SRHvK2j0cfaNJsMX
   aYvu3uotUD4wHC5M+E+2qgnTPS7sMOJRHwnv4B31iq+QAAGHRpoKmL4oG
   JWULeHjGvCPD4DWnRQumg+Oj+tBMIZPXR+zgR2/G/W7U6G0Xgr2cojkp3
   o=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="685228051"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:10:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:33415]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id ff8a1626-33d3-4143-93ae-bc5712bf91b9; Fri, 4 Oct 2024 22:10:43 +0000 (UTC)
X-Farcaster-Flow-ID: ff8a1626-33d3-4143-93ae-bc5712bf91b9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:10:42 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:10:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/4] rtnetlink: Per-netns RTNL.
Date: Fri, 4 Oct 2024 15:10:27 -0700
Message-ID: <20241004221031.77743-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
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
users can be protected by per-netns RTNL mutex.  The exceptions would be
RTM_NEWLINK, RTM_DELLINK, and RTM_SETLINK.  (See [0] and [1])

This series is the first step of the per-netns RTNL conversion that
gradually replaces rtnl_lock() with rtnl_net_lock(net) under
CONFIG_DEBUG_NET_SMALL_RTNL.

[0]: https://netdev.bots.linux.dev/netconf/2024/index.html
[1]: https://lpc.events/event/18/contributions/1959/


Changes:
  v3:
    * Patch 1 & 4 : Add Eric's tags
    * Patch 2 & 3 : Always evaludate net w/o CONFIG_DEBUG_NET_SMALL_RTNL

  v2: https://lore.kernel.org/netdev/20241002151240.49813-1-kuniyu@amazon.com/
    * Add revert of 464eb03c4a7c
    * Fix Kconfig dependency for arch with no lockdep support

  v1: https://lore.kernel.org/netdev/20240930202524.59357-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  Revert "rtnetlink: add guard for RTNL"
  rtnetlink: Add per-netns RTNL.
  rtnetlink: Add assertion helpers for per-netns RTNL.
  rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.

 include/linux/rtnetlink.h   |  69 +++++++++++++++++--
 include/net/net_namespace.h |   4 ++
 net/Kconfig.debug           |  15 +++++
 net/core/Makefile           |   1 +
 net/core/net_namespace.c    |   6 ++
 net/core/rtnetlink.c        |  70 +++++++++++++++++++
 net/core/rtnl_net_debug.c   | 131 ++++++++++++++++++++++++++++++++++++
 7 files changed, 289 insertions(+), 7 deletions(-)
 create mode 100644 net/core/rtnl_net_debug.c

-- 
2.30.2


