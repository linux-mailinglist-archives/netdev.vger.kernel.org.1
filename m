Return-Path: <netdev+bounces-141748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC49BC2E3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9263D1F212FF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC632943F;
	Tue,  5 Nov 2024 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nWs7oqJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297C1E521
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772327; cv=none; b=j7Pw9Hq8ar6ZUSs4NPmJ0WsDF6uAyBeiWMcDuyVYkSsCqI1nv3h5G3HGde8jCbjG3WZ9ZChGHHSp4h3f8uUOV5kVKM3ig5b56WAew02b7fEInCDNIKNDQsfYS9ADBJJUR/+dyuHi/klucHoQbizo0AyIXITkAzvH5lYn0sR44NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772327; c=relaxed/simple;
	bh=txlNxgiLXkVfwks3OuvbNST+i6qEtZbeMdgsx99W/Ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gg4DG8UaMrqy+5c5hTTsB/x6hv9AhBuMA6HKesjA4LNlOki/QQrQvbqHUAlv686B051O9IyhMM0NS5bkzzJd7bBwtn5d53mo5sihNKJqkfsyOZqkNR0anofb+/iA/P30W0LgEdEKk+SyFHlBR/xhclCI0XwOpr61/Owt9ekpiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nWs7oqJA; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772327; x=1762308327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I39qd4Jyy4sdCpL/+ilN0noROVpoN7I/DaIuuWyxja0=;
  b=nWs7oqJABYorAQd0i5z83l2flfw+R/d0oyZ50uwH//mbu7i3H/U6hc3z
   CU1doh2vuFanKR6ZsQvjE0WG54c3BANrDe6Tn0H6ws9Yd3TTXxn5bU7JV
   /z7QZsnlVSJp6rH4gpUFH5veDELP1kDu9DV14fS1tBNXoq2vkFSVLHYps
   o=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="440286927"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:05:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:12495]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.170:2525] with esmtp (Farcaster)
 id 427af49d-4ec4-49e4-8657-046433ff449a; Tue, 5 Nov 2024 02:05:22 +0000 (UTC)
X-Farcaster-Flow-ID: 427af49d-4ec4-49e4-8657-046433ff449a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:05:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:05:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/8] rtnetlink: Convert rtnl_newlink() to per-netns RTNL.
Date: Mon, 4 Nov 2024 18:05:06 -0800
Message-ID: <20241105020514.41963-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 introduces struct rtnl_nets and helper functions to acquire
multiple per-netns RTNL in rtnl_newlink().

Patch 2 - 6 are to prefetch the peer device's netns in rtnl_newlink().

Patch 7 converts rtnl_newlink() to per-netns RTNL.

Patch 8 pushes RTNL down to rtnl_dellink() and rtnl_setlink(), but
the conversion will not be completed unless we support cases with
peer/upper/lower devices.


Kuniyuki Iwashima (8):
  rtnetlink: Introduce struct rtnl_nets and helpers.
  rtnetlink: Factorise rtnl_link_get_net_tb().
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
 include/net/rtnetlink.h |  14 ++++
 net/core/rtnetlink.c    | 163 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 175 insertions(+), 43 deletions(-)

-- 
2.39.5 (Apple Git-154)


