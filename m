Return-Path: <netdev+bounces-131260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE198DE87
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E72F283610
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5011D04B4;
	Wed,  2 Oct 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CJkG4dM8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C01D014A
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881980; cv=none; b=jArzfu74U54f1YUVfumTzqmQJDFDnUWXLe0n/zf/H7qUlip0VMmJ1rYKHWLTVmbiQLEKH4fR+wcXtv/V4nm9W2sUf52iufn1Bb1olhAP6aMMxquz4B8IPn9o44oriPBSH8S79I7gCbbynT57IxQDBrHu4J+8trU85PmYCQU1Bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881980; c=relaxed/simple;
	bh=vgcjhVxJVl73PL9RG2isI7rO5WSqI2uEn0lRMU1KhtA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gyJFPMs8MC2smkX2Df8RuxjREhGdN7Tv4waTYQ5Zcbcn7cOJU5mEuYeowdq0Nvt4VQQlwdj3jiZ5A+MRpMe1NRq8OsjnUByOxQGQfWGIASFCiYMHH4bc1/WltYOP2fefNd1bWmvffl150MVEn6aSVSjXEZbu2svPxkHLvg7cBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CJkG4dM8; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727881978; x=1759417978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=718qmvSjJrSzXkKi9xJV/OZKvbgsl4o5QBoYQRODLbA=;
  b=CJkG4dM8lC7JnctSlnaWduYYtBLeUFmSpYMwYy9+osliciTIm8nqu1SH
   CUWQfQTeyxAECufuumde0F71SdrDtz7YkLmRdvPBtZ96lrN/vOxOAZ/Q7
   UdDqY1dIa7cjv6a9z2YcRhMpH7SZxmp2HQFOSu7XJy3yVfKFx5qDRINsC
   c=;
X-IronPort-AV: E=Sophos;i="6.11,171,1725321600"; 
   d="scan'208";a="684543448"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:12:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:13576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 9a235452-98f1-4972-b139-29348f72086d; Wed, 2 Oct 2024 15:12:54 +0000 (UTC)
X-Farcaster-Flow-ID: 9a235452-98f1-4972-b139-29348f72086d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 15:12:54 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 15:12:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/4] rtnetlink: Per-netns RTNL.
Date: Wed, 2 Oct 2024 08:12:36 -0700
Message-ID: <20241002151240.49813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
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
RTM_NEWLINK, RTM_DELLINK, and RTM_SETLINK.  (See [0])

This series is the first step of the per-netns RTNL conversion that
gradually replaces rtnl_lock() with rtnl_net_lock(net) under
CONFIG_DEBUG_NET_SMALL_RTNL.

[0]: https://lpc.events/event/18/contributions/1959/


Changes:
  v2:
    * Add revert of 464eb03c4a7c
    * Fix Kconfig dependency for arch with no lockdep support

  v1: https://lore.kernel.org/netdev/20240930202524.59357-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  Revert "rtnetlink: add guard for RTNL"
  rtnetlink: Add per-netns RTNL.
  rtnetlink: Add assertion helpers for per-netns RTNL.
  rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.

 include/linux/rtnetlink.h   |  39 ++++++++++-
 include/net/net_namespace.h |   4 ++
 net/Kconfig.debug           |  15 +++++
 net/core/Makefile           |   1 +
 net/core/net_namespace.c    |   6 ++
 net/core/rtnetlink.c        |  70 +++++++++++++++++++
 net/core/rtnl_net_debug.c   | 131 ++++++++++++++++++++++++++++++++++++
 7 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 net/core/rtnl_net_debug.c

-- 
2.30.2


