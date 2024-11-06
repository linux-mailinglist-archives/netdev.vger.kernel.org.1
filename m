Return-Path: <netdev+bounces-142205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6079BDD00
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0385828592D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7F190667;
	Wed,  6 Nov 2024 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G1G1OKkU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0D18FC85
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859886; cv=none; b=OAiDDhgsRkeDQltUPOgNpKwaqA3r0DUCy7M7pBn+dPU/gKDTQwK6XXdlhezqwH7U8Zh68pCJBLVFDUUOwEiDsxEUNvsGd19k9+VRtCePXkzM/9sB42m4e2S67dX2EgvqIeaWc3NjnOQXvFt1hiWFUG+Wgm1kzwQVZKxfPAlMCy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859886; c=relaxed/simple;
	bh=dibvedS43Teimxg5ATuNFanfCk3VkHVA+UUZ6WcuiCs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgAB21apkWwG++qykxClpLBaraL9+f2W06x5rok8ugDJrlCKMrJHLLB1iwNsHbZOBms4nEunDqfEbmBOuWw23q5d4zKhdDwKmCnYVeqMA2N6OZpXSKQ4N3+B4llPjPmIO2IwerqlHjNabPYtrVpWTYngYT9kc+rY7UfX82n/E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G1G1OKkU; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859884; x=1762395884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6RPX8HMEcCwwbf+BOW/kRBAA7eKZSPX8kshfO/ougiY=;
  b=G1G1OKkUPbH8YkCSZ9DAIP6iSTysjq1y311bjVCK9v50/o3RtQmW/AxB
   RJaWGk6rAy1jDHH5FdFyCr+79GbkyTx/hHlA5Sq+EP2GX+p7PdobDA5jC
   cK1QKiBGALmpXJouI7z1Cqmg5ejGQl/26mFd+wc1PhvZrEddn1P1yKPe0
   U=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="245223894"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:24:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:27237]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.16:2525] with esmtp (Farcaster)
 id 758342a5-2a56-4fda-ae69-152d7cec5554; Wed, 6 Nov 2024 02:24:40 +0000 (UTC)
X-Farcaster-Flow-ID: 758342a5-2a56-4fda-ae69-152d7cec5554
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:24:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:24:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/7] rtnetlink: Convert rtnl_newlink() to per-netns RTNL.
Date: Tue, 5 Nov 2024 18:24:25 -0800
Message-ID: <20241106022432.13065-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 introduces struct rtnl_nets and helper functions to acquire
multiple per-netns RTNL in rtnl_newlink().

Patch 2 - 5 are to prefetch the peer device's netns in rtnl_newlink().

Patch 6 converts rtnl_newlink() to per-netns RTNL.

Patch 7 pushes RTNL down to rtnl_dellink() and rtnl_setlink(), but
the conversion will not be completed unless we support cases with
peer/upper/lower devices.


Changes:
  v2
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


Kuniyuki Iwashima (7):
  rtnetlink: Introduce struct rtnl_nets and helpers.
  rtnetlink: Add peer_type in struct rtnl_link_ops.
  veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
  vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
  netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
  rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
  rtnetlink: Register rtnl_dellink() and rtnl_setlink() with
    RTNL_FLAG_DOIT_PERNET_WIP.

 drivers/net/can/vxcan.c |  12 +--
 drivers/net/netkit.c    |  11 +--
 drivers/net/veth.c      |  18 +----
 include/net/rtnetlink.h |   3 +
 net/core/rtnetlink.c    | 171 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 170 insertions(+), 45 deletions(-)

-- 
2.39.5 (Apple Git-154)


