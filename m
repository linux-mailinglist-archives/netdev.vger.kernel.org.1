Return-Path: <netdev+bounces-197188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4DAD7C24
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8F61884494
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39C2D8762;
	Thu, 12 Jun 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="isiIDJUY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E372D6611
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759167; cv=fail; b=l+dw3JcM8qg+MgAXz8cwTEFtb+3FH+yFX3Be8felzF4qfFhYWcI1GNk3LU+ItEpziwyB1aPPBlXJS1u37Al/EcIrylw/5BOgaC1dJJowFc/b80RMyyRoxaZcZglcmaWa/9XCJDvpCMSnRZeFdi4OgIQp4qH6FpV9x2B07OfC4f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759167; c=relaxed/simple;
	bh=AJPC7Ma3iy/L/kp1rQyTMsg4KVoqk6Zn6YiT2Go07pI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pktivsa8wWxvWjO5uL86XmnrhP6wkG0pVZnPTWUovnrvAhhkGutiHNqaRnHLFqOIl2+33F2eRPwUu4zuXPjFlz/b+Nr5zWosMuDPAbfDi6PRBy3vrkult9ugSLeIM7n2L4wHYrhGoiWJxXXArqXZJMEwQroU+lZgpW0a7wofXxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=isiIDJUY; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvFlBnxlPPCgDiS6N4JBhZNA78GDddaEX5mOvyAeS0rJ3FKjdoEJNnVcFT8JJIwwSlRl4KC2ajtDo65TnLAO8vTkYyzUApos/PL1MRGHa+LEYu3Lbxqs1vSJUttQk5n5fp7vWkiJR2ueCLFyVbGMGk26DjFn+0j8a9hNLBcZv2A81MJhhHJFfZA2KxaM2q5teZuM4seLdPdA/NMhG26iISnkanswvH1q9rFXEL9Dzc/1jHlaarW0ZCIxRN6VhYZQl54d37Op0ldlbfABpiAeyMtBHgNmjxp3W30sO8PoZKzmNi51ciNAdqOHZtBnvcF9UPPahEVv5shxL6qP3HGVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz7svfsxVdwJqfFOrzm4kZGqzRBS76caLvDfczOPmpQ=;
 b=tbAxFNHEhJSlWd2P6Vjzb8eXOc3oGa2JqdDbQEwemXED5jPtmUZ68gTm1HMcguvury72nabVNsd3Z1vLrrEHGgG9N3zNsbxT7aLQXRr5lThYpBtMeRx7tlkKWhJc2CN4qg4tDN6dqTkmpWWHdWTL8l7Ufav7ChD27pkxeEHdfuJoiyU+awlMbQVoMfUmekN++InIT1rwXucWn4VGJ/znuE1w9fTqQxiuaN8X0PZ/hCX3dO6uxkE6A2+zZgHWZIOlWLZFPMPziz6NQPvE7gljLXfjXqqPs0SZwoxFGoleQIiB3tLfkSRG4qUgogBmMvfiQKpwXlkDD91BDVUj2KCM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz7svfsxVdwJqfFOrzm4kZGqzRBS76caLvDfczOPmpQ=;
 b=isiIDJUYxoJQCxWCCntKmBdyb1EeRlgwJrEllFQpu/LB95xK31XR1gJiSxxdyh0QZfAAqfqcyep8EPzXN+wow+93+/NIzk6PX/N+AnBiKVvQjM6KK8/j5cL3wJxCKf+UEdl6XO4xyyBnhB3gzQz6kxNgwsUx1Gvz6xhRa0tnuy3S7ZltC/220c/U/x/XZxR6aLKbb4ZDznZhi7k5lxGd6c3xsEFRPsQzN/aEt3Da9SK6dqyII81fQQKTgp8rNfTbfOewAnRt4n8oPhnpj+XJe/ZGBWziXIQOUOmYGZhlpDH+89DJqDd7gjYDCx40O3CX+46t8ShbGreAggL5H8PtCA==
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 20:12:40 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6b) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Thu,
 12 Jun 2025 20:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:12:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:12:24 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:12:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 00/14] ipmr, ip6mr: Allow MC-routing locally-generated MC packets
Date: Thu, 12 Jun 2025 22:10:34 +0200
Message-ID: <cover.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: eea47f70-bb14-4b5d-a26e-08dda9ed7b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+o+zYd2NZHqWYjkka7m+fKtZ+LMTrnbrlrWgIyyyQgWGRJXYhiIgi87MYgI?=
 =?us-ascii?Q?149fVhzi7XcX0XliJk1pkFVVGyTna4MiuNOxIDsXwlMu2fPCj3G05GswPPfm?=
 =?us-ascii?Q?8K/1eepGW/mgW8+nuFk2pP+OdwjPBrpebJmnRU+cJmj9+6qnI1yyI9+rON5v?=
 =?us-ascii?Q?z1vApx1GQ6vVASMHNeeDJ2WCVAJV9DIQBdalnQXIn/AyNFQ8/yh5EIRC/rDg?=
 =?us-ascii?Q?vwtIkS+ySducfLp9F8D9Qs1FwceqrwCHM/E1OoiyIQKHZh0grctxinZm79Q8?=
 =?us-ascii?Q?fH9d6aAhFr3BquzQNoS+/kYAHWGR875raUj4JeYqmO6gRC49PS0bmd1Whxbs?=
 =?us-ascii?Q?yB0soDzN1UHpvL52ngZvkP0EWAPCizALNaGg6+JxYkQGamNktcQrlbeuLcKU?=
 =?us-ascii?Q?6On7hqKNMdsqh+S0PUOmezGUcavVm7HL8EhoapmV4GA4ohRwpCBrDQgu3bDg?=
 =?us-ascii?Q?B+jgev2y5nManVfiotovOWTCptS5ZV4ITByoZd3J+DFTpIEswQP2vcMeVd8L?=
 =?us-ascii?Q?6ysueJ35gi94ez7rVowgY/cu+KcU/k9yoi8e2dLnFJcX8AGWsXafwQR5MWgo?=
 =?us-ascii?Q?/B44Gs4Ms5bkZlBxnAT2kNSsF7rEngMAOhI3aT7NhAg3nTfHZLIF08GuxAZk?=
 =?us-ascii?Q?lrQXXF7vOv18YL6CXNXM2wspjurmXHA162oPWms2GtVGUie3EYwe09ui6oWc?=
 =?us-ascii?Q?ySqN9sbGWKHQZmpgqP6KJ8u994r7bz33mGXxlP4NCDBZ8PxCqDgIq/P85Aon?=
 =?us-ascii?Q?G6GuopQSFZzIE+r09OVu22/gxqwSVMf/cb/lqbHUNWhhxcWJzdqutgqCFlET?=
 =?us-ascii?Q?cAJR8c+n4KbAYImpJSmDLwHVqXmlgJc6y7Ht/FOr4rGhCVMF3QcWP4/Nt/3/?=
 =?us-ascii?Q?lTddM7B2ndgPuBBaq998/hNNfQgb0hJTFEXc1yLDz7sIiH319b12g65Gq9FV?=
 =?us-ascii?Q?8MyEgCjjkpXcocd7F/V0HycfziIBrK/0xOg0HkZGZm/BZP0VmQbxmYQhPJgf?=
 =?us-ascii?Q?8RF2M06uqbycnFrJrh2pi5Bl7XGDRb0tBhsgSsziigNjyNvZr8Z5ld0wmT7p?=
 =?us-ascii?Q?RQwetR/nSi6P8E+R6/fj7e8+HtbGwRSSgmH2HCkABg8xkqm3YN6y0l9mv11B?=
 =?us-ascii?Q?xqcF0KwuqWns01xEQYqKCMgr+2NGiNc6BpL+D/CEM5eNawVkIXzActLvMnHN?=
 =?us-ascii?Q?XhcQos14Jbt3PBaLdlORUgBpEkplszQkz2JvLgIIJzg5lKrswI6cJAB9ve+2?=
 =?us-ascii?Q?RMMD5grApqkIobOEtf18M0IxJrYn/A1vpbaLGny7ad8Xxg0idIZBRXog/cX4?=
 =?us-ascii?Q?IyWFRp/yYgK199MAarbnCGI9BCHxa1Iwm5FkCOnpiMxClLxmvgxA1Tf9D09p?=
 =?us-ascii?Q?cUzCN0HoHuUHI4Y0dgvaJl8z+rKPZjrf3webNVigviauZBx2yMp8db/KHLmY?=
 =?us-ascii?Q?1qc5Ath47Q5ReuGj1OrAB3cvwGb5Kvqxeu5gUO124tOvAZogAs2ZGTG8NSTi?=
 =?us-ascii?Q?fn70KY++UjUSUFUyz1TaNnh1O0E+IuSOhRYP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:12:39.3962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea47f70-bb14-4b5d-a26e-08dda9ed7b26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

Multicast routing is today handled in the input path. Locally generated MC
packets don't hit the IPMR code. Thus if a VXLAN remote address is
multicast, the driver needs to set an OIF during route lookup. In practice
that means that MC routing configuration needs to be kept in sync with the
VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
routing code instead.

To that end, this patchset adds support to route locally generated
multicast packets.

However, an installation that uses a VXLAN underlay netdevice for which it
also has matching MC routes, would get a different routing with this patch.
Previously, the MC packets would be delivered directly to the underlay
port, whereas now they would be MC-routed. In order to avoid this change in
behavior, introduce an IPCB/IP6CB flag. Unless the flag is set, the new
MC-routing code is skipped.

All this is keyed to a new VXLAN attribute, IFLA_VXLAN_MC_ROUTE. Only when
it is set does any of the above engage.

In addition to that, and as is the case today with MC forwarding,
IPV4_DEVCONF_MC_FORWARDING must be enabled for the netdevice that acts as a
source of MC traffic (i.e. the VXLAN PHYS_DEV), so an MC daemon must be
attached to the netdevice.

When a VXLAN netdevice with a MC remote is brought up, the physical
netdevice joins the indicated MC group. This is important for local
delivery of MC packets, so it is still necessary to configure a physical
netdevice -- the parameter cannot go away. The netdevice would however
typically not be a front panel port, but a dummy. An MC daemon would then
sit on top of that netdevice as well as any front panel ports that it needs
to service, and have routes set up between the two.

A way to configure the VXLAN netdevice to take advantage of the new MC
routing would be:

 # ip link add name d up type dummy
 # ip link add name vx10 up type vxlan id 1000 dstport 4789 \
	local 192.0.2.1 group 225.0.0.1 ttl 16 dev d mrcoute
 # ip link set dev vx10 master br # plus vlans etc.

With the following MC routes:

 (192.0.2.1, 225.0.0.1) iif=d oil=swp1,swp2 # TX route
 (*, 225.0.0.1) iif=swp1 oil=d,swp2         # RX route
 (*, 225.0.0.1) iif=swp2 oil=d,swp1         # RX route

The RX path has not changed, with the exception of an extra MC hop. Packets
are delivered to the front panel port and MC-forwarded to the VXLAN
physical port, here "d". Since the port has joined the multicast group, the
packets are locally delivered, and end up being processed by the VXLAN
netdevice.

This patchset is based on earlier patches from Nikolay Aleksandrov and
Roopa Prabhu, though it underwent significant changes. Roopa broadly
presented the topic on LPC 2019 [0].

Patchset progression:

- Patches #1 to #4 add ip_mr_output()
- Patches #5 to #9 add ip6_mr_output()
- Patch #10 adds the VXLAN bits to enable MR engagement
- Patches #11 to #13 prepare selftest libraries
- Patch #14 includes a new test suite

[0] https://www.youtube.com/watch?v=xlReECfi-uo

v2:
- Patches #11, #13 and #14:
    - Adjust as per shellcheck citations
    - Retain Nik's R-b at patch #13, the changes were very minor.

Petr Machata (14):
  net: ipv4: Add a flags argument to iptunnel_xmit(),
    udp_tunnel_xmit_skb()
  net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
  net: ipv4: ipmr: Split ipmr_queue_xmit() in two
  net: ipv4: Add ip_mr_output()
  net: ipv6: Make udp_tunnel6_xmit_skb() void
  net: ipv6: Add a flags argument to ip6tunnel_xmit(),
    udp_tunnel6_xmit_skb()
  net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
  net: ipv6: ip6mr: Extract a helper out of ip6mr_forward2()
  net: ipv6: Add ip6_mr_output()
  vxlan: Support MC routing in the underlay
  selftests: forwarding: lib: Move smcrouted helpers here
  selftests: net: lib: Add ip_link_has_flag()
  selftests: forwarding: adf_mcd_start(): Allow configuring custom
    interfaces
  selftests: forwarding: Add a test for verifying VXLAN MC underlay

 drivers/net/amt.c                             |   9 +-
 drivers/net/bareudp.c                         |   7 +-
 drivers/net/geneve.c                          |   7 +-
 drivers/net/gtp.c                             |  12 +-
 drivers/net/ovpn/udp.c                        |   4 +-
 drivers/net/vxlan/vxlan_core.c                |  23 +-
 drivers/net/wireguard/socket.c                |   4 +-
 include/linux/ipv6.h                          |   1 +
 include/linux/mroute6.h                       |   7 +
 include/net/ip.h                              |   2 +
 include/net/ip6_tunnel.h                      |   3 +-
 include/net/ip_tunnels.h                      |   2 +-
 include/net/udp_tunnel.h                      |  17 +-
 include/net/vxlan.h                           |   5 +-
 include/uapi/linux/if_link.h                  |   1 +
 net/ipv4/ip_tunnel.c                          |   4 +-
 net/ipv4/ip_tunnel_core.c                     |   4 +-
 net/ipv4/ipmr.c                               | 169 +++-
 net/ipv4/route.c                              |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/ip6_tunnel.c                         |   2 +-
 net/ipv6/ip6_udp_tunnel.c                     |  18 +-
 net/ipv6/ip6mr.c                              | 137 +++-
 net/ipv6/route.c                              |   1 +
 net/ipv6/sit.c                                |   2 +-
 net/sctp/ipv6.c                               |   7 +-
 net/sctp/protocol.c                           |   3 +-
 net/tipc/udp_media.c                          |  12 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |  46 ++
 .../net/forwarding/router_multicast.sh        |  35 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 769 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  12 +-
 33 files changed, 1216 insertions(+), 117 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh

-- 
2.49.0


