Return-Path: <netdev+bounces-181017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C808CA83668
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DC4A25A9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A401D63F8;
	Thu, 10 Apr 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IgPOJUle"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6D1C878E
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251622; cv=none; b=kQaC0jJObmQDley4NLXfjqeDFgjeuY+X6TBS9P50gm/ByTKLwCdsEFKF/qo3GI5gXGY7a08EkfIdI5OpsrqM0mtCZ4HK9XfiB3vg60fYVIxpJ7BA9PCeY0d7yOnqxewOSuNhWQfEcHdHo9pVv/VscYu3d9wGPsB/rVoiWGutpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251622; c=relaxed/simple;
	bh=yUf+Fkn9oily11aRvPJBrfIk5yW7mP61C3Fz2XPmG6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcjGuTWHYzdlQxShLaIyNio8CukAgslMCwbWPUcqJVobk6hkjHwYgfO5zIaf7F8J60rWRD2ZDnhsCRJ4w+XbFwmlu5Od7pu4E/RdRqeMcYqqSdw/WfaDENlZ5ziuX0UQjMi4k5mJnMjDIJYhhOqsfUozx36WZXFWQz6kzyRAeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IgPOJUle; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744251621; x=1775787621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TA0Jrx0Bz2FK0dXBWmfMcyDHb1d99UQPzhdujqnHH+E=;
  b=IgPOJUle/vBxVS2vtvx8UHRzWxO/8TZYg2cIfOe7Gg4QJkMae9tfTC2X
   NdekALdbXAzuRX8Fq4fh6u/eY6ZIpIAvAtJJyNAVoSxrsolev2dt7AN1v
   dWcKx7gXu3uuqcCywSpB4uS5NYH66BpcrDVGB9O+lSk6SNEJTTvpA4xz5
   w=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="287189379"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:20:18 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id ae930e8d-a617-4f1c-8137-6e77acf1f710; Thu, 10 Apr 2025 02:20:17 +0000 (UTC)
X-Farcaster-Flow-ID: ae930e8d-a617-4f1c-8137-6e77acf1f710
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:20:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 02:20:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/14] net: Convert ->exit_batch_rtnl() to ->exit_rtnl().
Date: Wed, 9 Apr 2025 19:19:21 -0700
Message-ID: <20250410022004.8668-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
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
 drivers/net/bonding/bond_main.c |  23 ++---
 drivers/net/geneve.c            |  16 +--
 drivers/net/gtp.c               |  18 ++--
 drivers/net/vxlan/vxlan_core.c  |  18 ++--
 include/net/ip_tunnels.h        |   7 +-
 include/net/net_namespace.h     |   4 +-
 net/bridge/br.c                 |  17 ++--
 net/core/net_namespace.c        | 166 +++++++++++++++++---------------
 net/ipv4/ip_gre.c               |  27 +++---
 net/ipv4/ip_tunnel.c            |  25 ++---
 net/ipv4/ip_vti.c               |   9 +-
 net/ipv4/ipip.c                 |   9 +-
 net/ipv4/nexthop.c              |  13 +--
 net/ipv6/ip6_gre.c              |  22 ++---
 net/ipv6/ip6_tunnel.c           |  24 ++---
 net/ipv6/ip6_vti.c              |  27 ++----
 net/ipv6/sit.c                  |  23 ++---
 net/xfrm/xfrm_interface_core.c  |  34 +++----
 19 files changed, 205 insertions(+), 293 deletions(-)

-- 
2.49.0


