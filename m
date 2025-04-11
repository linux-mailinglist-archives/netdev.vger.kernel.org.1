Return-Path: <netdev+bounces-181791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20FDA867AB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B01763D6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB12857E3;
	Fri, 11 Apr 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WDv835vG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866C280A43
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404799; cv=none; b=YAX4n3Osn40xpXvkiNB4sJmiMMbV/NOsTsCNl8TYBEe24/Sep9i1o/b8dYKpIRnxiFQL9HcmYCLgGExCVB/U++msWKJvk63mWLPQ7zVYjHPAK+xBzzczgndUO/R5imIHesBZCYyF5ndCVorqTeadsTLhKK9HaJDStMic+6Sd2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404799; c=relaxed/simple;
	bh=rUv5qxbAsH0Jzm9QzPAQNzjDqodg7e5viuHVwg95WPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ob4W5U18v/ipmxYu19t3HM00cSnXU5VAdF7a3sPQmSIuZVaSDcYEG+SvwVT+/YVr0UUGzhefULA7Qy8q76d2m+RgPCwz+TiwtvnICzwpXJh3BjBm4pbfPNhXFiP2epqpnAJyUfbQM3ljHUjOQx4gzzIgCNX4fw1sT0jf9vY+/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WDv835vG; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404794; x=1775940794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ZPHPjt93fuS8JzjgkdEghQJwq/1t+S4O/hc77h20Hc=;
  b=WDv835vGIQC2Lr/zDoeGhSabviCBeZrZSIp4EM6hhiZrFMF/rnQJMvcO
   MVyxsQBFv+9KpbOaZc7BSDfwC2BIGi3Z7KoTHfbuujNwdSksyqoI9lQtk
   m/XcK+d+gvZgDRsBSYCnzcehDpAMsnC6DwqfDQB7a+zn/X0Dd2LZ4I2LZ
   w=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="186717007"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:53:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:15081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 4313290b-5956-4147-9a28-a6ca2d6f982b; Fri, 11 Apr 2025 20:53:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4313290b-5956-4147-9a28-a6ca2d6f982b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:53:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:53:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/14] net: Convert ->exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:29 -0700
Message-ID: <20250411205258.63164-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While converting nexthop to per-netns RTNL, there are two blockers
to using rtnl_net_dereference(), flush_all_nexthops() and
__unregister_nexthop_notifier(), both of which are called from
->exit_batch_rtnl().

Instead of spreading __rtnl_net_lock() over each ->exit_batch_rtnl(),
we should convert all ->exit_batch_rtnl() to per-net ->exit_rtnl() and
run it under __rtnl_net_lock() because all ->exit_batch_rtnl() functions
do not have anything to factor out for batching.

Patch 1 & 2 factorise the undo mechanism against ->init() into a single
function, and Patch 3 adds ->exit_batch_rtnl().

Patch 4 ~ 13 convert all ->exit_batch_rtnl() users.

Patch 14 removes ->exit_batch_rtnl().

Later, we can convert pfcp and ppp to use ->exit_rtnl().


v2:
  * Collect tags
  * Patch2
    * Convert free_exit_list() under CONFIG_NET_NS=n

v1: https://lore.kernel.org/all/20250410022004.8668-1-kuniyu@amazon.com/


Kuniyuki Iwashima (14):
  net: Factorise setup_net() and cleanup_net().
  net: Add ops_undo_single for module load/unload.
  net: Add ->exit_rtnl() hook to struct pernet_operations.
  nexthop: Convert nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
  vxlan: Convert vxlan_exit_batch_rtnl() to ->exit_rtnl().
  ipv4: ip_tunnel: Convert ip_tunnel_delete_nets() callers to
    ->exit_rtnl().
  ipv6: Convert tunnel devices' ->exit_batch_rtnl() to ->exit_rtnl().
  xfrm: Convert xfrmi_exit_batch_rtnl() to ->exit_rtnl().
  bridge: Convert br_net_exit_batch_rtnl() to ->exit_rtnl().
  bonding: Convert bond_net_exit_batch_rtnl() to ->exit_rtnl().
  gtp: Convert gtp_net_exit_batch_rtnl() to ->exit_rtnl().
  bareudp: Convert bareudp_exit_batch_rtnl() to ->exit_rtnl().
  geneve: Convert geneve_exit_batch_rtnl() to ->exit_rtnl().
  net: Remove ->exit_batch_rtnl().

 drivers/net/bareudp.c           |  16 +--
 drivers/net/bonding/bond_main.c |  23 ++--
 drivers/net/geneve.c            |  16 +--
 drivers/net/gtp.c               |  18 ++--
 drivers/net/vxlan/vxlan_core.c  |  18 ++--
 include/net/ip_tunnels.h        |   7 +-
 include/net/net_namespace.h     |   4 +-
 net/bridge/br.c                 |  17 ++-
 net/core/net_namespace.c        | 181 +++++++++++++++++---------------
 net/ipv4/ip_gre.c               |  27 +++--
 net/ipv4/ip_tunnel.c            |  25 ++---
 net/ipv4/ip_vti.c               |   9 +-
 net/ipv4/ipip.c                 |   9 +-
 net/ipv4/nexthop.c              |  13 +--
 net/ipv6/ip6_gre.c              |  22 ++--
 net/ipv6/ip6_tunnel.c           |  24 ++---
 net/ipv6/ip6_vti.c              |  27 ++---
 net/ipv6/sit.c                  |  23 ++--
 net/xfrm/xfrm_interface_core.c  |  34 +++---
 19 files changed, 213 insertions(+), 300 deletions(-)

-- 
2.49.0


