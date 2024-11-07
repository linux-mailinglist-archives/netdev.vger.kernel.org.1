Return-Path: <netdev+bounces-142617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD999BFC8A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933921F22203
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152017C60;
	Thu,  7 Nov 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JIBgZhcf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E3D268
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946557; cv=none; b=lBBey2xTZMDzzZuEj7l/oTuRE/j1fVWRUM8W6OzwrsVHtDGOVIcScBAmudY6n01jg+cwcalxy1vVjI2CbFuq7UfriWbzFktx42aE/ic7E/esLXuKt+pqhnqV5cEStmc1se/3KVP+JDahmB4nf77M9G49Cd3C35wq6WynCsFnnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946557; c=relaxed/simple;
	bh=cRgDMfvkc7Nb86ciKqveB54i6/hUGrIgDhBhIfOJFIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BftiGXNcGnvAaYEVnsmD9Y6TWV/ommk58f/TeNLV4p247yx9vXlpNDuLufu6lIwoem9Zj2/6MT89ap0lRZtvuJU6w/Y6PgsarXXPzP+RW9Zk/J2bjix6vrC/ykBupgNgT8wCytBnAXVbUgn9mflSZ+zioP/w2NeDoUZtgJwbjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JIBgZhcf; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946556; x=1762482556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SHkIaaRYlyD5HX8rt/bMYJCxmlDotLc4AfMc28Ry50s=;
  b=JIBgZhcfV77XYJK9nI0R2kP2zsjNiYI3NgX3+Vn6XP9589zvzQSPe/Di
   JWqxZfHkL4lR9i+xaOtecxN3xJASZp4exML/e9s3KbcCNAY58hHumgghH
   UZkVkBjy0hAIiEJk6qBLyPmhby9n36fooEE9v2G5/BpRoAzVun19t3/mM
   c=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="437827331"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:29:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:2837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.80:2525] with esmtp (Farcaster)
 id e210b339-c57f-452c-949c-fa52893473e3; Thu, 7 Nov 2024 02:29:11 +0000 (UTC)
X-Farcaster-Flow-ID: e210b339-c57f-452c-949c-fa52893473e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:29:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:29:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 00/10] rtnetlink: Convert rtnl_newlink() to per-netns RTNL.
Date: Wed, 6 Nov 2024 18:28:50 -0800
Message-ID: <20241107022900.70287-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 - 3 removes __rtnl_link_unregister() and protects link_ops by
its dedicated mutex to move synchronize_srcu() out of the RTNL scope.

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
  v3:
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


