Return-Path: <netdev+bounces-143111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D39C1346
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFA01C218C1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD61BD9CA;
	Fri,  8 Nov 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P3O8vLnE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C79EBE
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026918; cv=none; b=is93WLanoZi07iG9SE6wCeOPIRGy7vSA13yrPG0t9hJzpSmQDNDc/KfVD82WNb7IKYS1O7M2M4KmaORd8w87B8ELAkWaX+jkcTNG9+iONEPZ+yjEWDNHsihyALTS5yTIuyLLe10VAM+3Xwf7GXR93UYT3kPFBQV1n8a/oGmxU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026918; c=relaxed/simple;
	bh=zH+xJ/uIDBu6IjbqfMESuu1NVAoJyGOJ0cDvbFQ7hQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uzc6YuBySJ4A1NosX82sVgPChCCn4jdL0BK/zcIMY8ZMPmIryLYLrc0TB4Zc2oOtWYPaNGPDl/CFitJmYfklP8YM0ClpUrj10x0TlvY0eNeGlpWgwkTWzJzm3UtFtxQS8sYmbBNqayix3ZHqG1leIYJprGlExGSF6kixswdSoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P3O8vLnE; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731026917; x=1762562917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mGx2oLNuSBdqA4G1vy+ZVU7tcPKoOJ3DSN+eh8dxaQ0=;
  b=P3O8vLnEU+r5ZZpXL6xdyp8rzsCp7XFZKKxbl8WqZyFX8RlAU63hWhTE
   T8/tLBMsQq5aQ7tJ2UB76dix7GOJxRNHSQCnOag2qj4RZqpzpJaWaKtUK
   kg6Zq/ylV70n7nOPWdkF0qQY+tThNbbVp5p5hq4rPb/hrtejcWT14jDZm
   g=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="468177417"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:48:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:48558]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.42:2525] with esmtp (Farcaster)
 id 4f94bd1e-8b4b-4de8-bdbe-405d6cd5e453; Fri, 8 Nov 2024 00:48:31 +0000 (UTC)
X-Farcaster-Flow-ID: 4f94bd1e-8b4b-4de8-bdbe-405d6cd5e453
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:48:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:48:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 00/10] rtnetlink: Convert rtnl_newlink() to per-netns RTNL.
Date: Thu, 7 Nov 2024 16:48:13 -0800
Message-ID: <20241108004823.29419-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 - 3 removes __rtnl_link_unregister and protect link_ops by
its dedicated mutex to move synchronize_srcu() out of RTNL scope.

Patch 4 introduces struct rtnl_nets and helper functions to acquire
multiple per-netns RTNL in rtnl_newlink().

Patch 5 - 8 are to prefetch the peer device's netns in rtnl_newlink().

Patch 9 converts rtnl_newlink() to per-netns RTNL.

Patch 10 pushes RTNL down to rtnl_dellink() and rtnl_setlink(), but
the conversion will not be completed unless we support cases with
peer/upper/lower devices.

I confirmed v3 survived ./rtnetlink.sh; rmmod netdevsim.ko; without
lockdep splat.


Changes:
  v3 (resend)
    * Resend because patch 5 didn't make it to lore

  v3: https://lore.kernel.org/netdev/20241107022900.70287-1-kuniyu@amazon.com/
    * Add patch 1~3 to avoid SRCU & RTNL deadlock

  v2: https://lore.kernel.org/netdev/20241106022432.13065-1-kuniyu@amazon.com/
    * Patch 1
      * Move struct rtnl_nets to rtnetlink.c
      * Unexport rtnl_nets_add()
    * Patch 2
      * Rename the helper to rtnl_link_get_net_ifla()
      * Unexport rtnl_link_get_net_ifla()
      * Change peer_type to u16
    * Patch 6
      * Remove __rtnl_unlock() dance

  v1: https://lore.kernel.org/netdev/20241105020514.41963-1-kuniyu@amazon.com/


Kuniyuki Iwashima (10):
  rtnetlink: Remove __rtnl_link_unregister().
  rtnetlink: Protect link_ops by mutex.
  rtnetlink: Remove __rtnl_link_register()
  rtnetlink: Introduce struct rtnl_nets and helpers.
  rtnetlink: Add peer_type in struct rtnl_link_ops.
  veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
  vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
  netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
  rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
  rtnetlink: Register rtnl_dellink() and rtnl_setlink() with
    RTNL_FLAG_DOIT_PERNET_WIP.

 drivers/net/can/vxcan.c  |  12 +-
 drivers/net/dummy.c      |  17 ++-
 drivers/net/ifb.c        |  17 ++-
 drivers/net/netkit.c     |  11 +-
 drivers/net/veth.c       |  18 +--
 include/net/rtnetlink.h  |   8 +-
 net/core/net_namespace.c |   1 -
 net/core/rtnetlink.c     | 257 ++++++++++++++++++++++++++++-----------
 8 files changed, 217 insertions(+), 124 deletions(-)

-- 
2.39.5 (Apple Git-154)


