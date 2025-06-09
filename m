Return-Path: <netdev+bounces-195847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B946AD280F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD291892C34
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFEE21CC49;
	Mon,  9 Jun 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dC2t/Jl8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8B8F40
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502290; cv=fail; b=THEpbMXKwomuLvUwj5TfJWS7mcpXHzorKbGMtYSLwo8gh0okTO9aJFG7ko9rVkid9FExpgLoU+AuR9I6ciKvvGfKFtKiTSJJryQgAmlUrmF9gKGkYQNnrsux0sdCvkknaTi6GafDu1dDM9UXcO0rbqYyATCfotwE2J49eXc6F10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502290; c=relaxed/simple;
	bh=/IzOxEAJla6nHLBBFMiwB1oWXkUvl5E2j9Jk3I7+WyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rEfZq2EDOrQZ654bu+Vx5Il5EPB0rPZLRt8QBVarrh95Z3/kEnMMinSXxNd9ozHcz/FOtor+10sgJ2zDQxTCU0vOegjGYAuI9xurpzk8FpVOOSvIYsFRGDvZjLqu2y2wsS2ZTkd9wVMbnYHdv9id3AHOD9iF39+LjQWxKNUvVSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dC2t/Jl8; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOzRu5X4dRUU49nu8wvuhOwH5jC+MZh4depWL0WqrvKlbzrAFMMSMdZzgDRbcLY4tbu26hcHimCwvtWRvIFOqqPt4+0N3X7wM+RRl0PEZ3jh1S68U640/UnzBcoZ2m083ne37xDASbN7y3AxQJ5qPE2qFCLIX0TateTE4w94KvIFwC6hmEXjlkSr5Td61J78uhfI7gfDds3Qglxi+GX/xXjQmUjykG6ZDP8vdPDDCIfHko0F/b7cweqh3aoeDQ0nxwA8Fsd3SJfLPwt0idrrIz738vshvPUN3B7KWfxVdJ4Gv3mIchWTkK1wywYQsG5xypbD2id8IA/eUg2LviG7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj3UzJD3aW3OgEwAWiJzQK3Ttyn9S50k9nkF9Z0MfSA=;
 b=xKT2LDZll5VHAsrbYQjcVBbu2vSE6oaD1XqS9SweRbN1JBdCYDidyZjRPIxxB6B96TuqNMgy09+ZFKZ1Mp3rk5s1HCbLaiVmDK39OP0IOEqvkaFfttOREvsMhACPfsm+rzHKcGZ2e5QXZmfGwDjEHiAt31dKiArYp6H1glAftKHQignZ9aSNSsZXcQ4qrEWc7fcGQYto+K8qwQ7jP2WXYzW2YMJVddXKxV0dulIA+rGVTtyFZ7tsSulTPS/6yqzh0T+MM4XE1Miy0F0GSkcjYpeOlFhogrHg3TIVtaqBhZPVNSSyt4KO1lf5AtQzICW5qS8xb2/TtQdoXEbxt6M5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj3UzJD3aW3OgEwAWiJzQK3Ttyn9S50k9nkF9Z0MfSA=;
 b=dC2t/Jl8vOdCtWu6GX0QCGoj3IOSL05vQwAT+j2/qioVW3xxmsxYEuGm9Yq3w6z+aGVhDfT5Vgf56/nBOdWBqaPlDxjSX+9b8IwVjXObKHCbCq9gTI+g2IJilKPdHUVcHn/P+6OaQrXRHgPaUd0CQs4szg69d+/+dsEN4KgGsbBAHI1H43Z7bqNTTWtLdOeIZjfLjVxQBk5LTkg3JUXIqUbcbIy/r2+aMfXU565uRKfcvmKwuvli0MdqzGG22mvBsyLKmyjlvcRYcGmdIogk8cAoblEGfILwaglbb4ZHDBpbbE17M7E3Gcb490xN8GTgDoPf0JGIyh4o5LTu+eeLdA==
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 20:51:25 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::4c) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 9 Jun 2025 20:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 20:51:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:08 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing locally-generated MC packets
Date: Mon, 9 Jun 2025 22:50:16 +0200
Message-ID: <cover.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a59790-1241-4835-1342-08dda7976629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQ8EWQjfFsXd9Kj/pIKGky4sUpCBGgbB8Qh342Zt9hC3dCOpmPxh5xTDJ+lw?=
 =?us-ascii?Q?qXDF7RpFXBgb1Qsw1LhWK9namcXo7wr+gLYldA5vNBNeHnbeC6F/kqfMXAxz?=
 =?us-ascii?Q?1hYhPw4sbDdy4frFHTibgmHvxAxwE9gSWUb0A58MGA/pNKry7lzRbtBcAaGG?=
 =?us-ascii?Q?EbK4fJZ4kRBrN8FNOv5XTe//rSXaVDH9J/Ng8q9c2B+fvM9KZZFudClS4125?=
 =?us-ascii?Q?fWeVMD+qniaAsYtEEqoFYeuXfGHzPrK52cmJh+S2vP4WrOtNm5yFiD+sQCCX?=
 =?us-ascii?Q?OT2tP48czvlVBng00mHrAnYpsh6nLAlhCfkwn7yYzRW3FPByQxb2CQGaNKtK?=
 =?us-ascii?Q?+1Jgg1GQGDjdHd9JtxyJoDiRnnnynmm8ACWIZYkyZCU2Z3Zv9gQweii8W0lv?=
 =?us-ascii?Q?BoxbHUPUHT+595HW4OGu8YbsZdJIfT/UAsl3jxl+1s54bBZaUxsDt6XRlFAz?=
 =?us-ascii?Q?sqmG2hFABIAM/wBVDf/iWgM7p0T3L5L46dRuIIZ8BlmXr73X4SeZ72dix6/D?=
 =?us-ascii?Q?aArnjsARh7As6e5KD0eflShsOEbrpKh0z7xsnMeT76FqbcAEF8NXmbIdsEsz?=
 =?us-ascii?Q?Dj9W2D4fKMyCkiRlnLuAshJE/j1BtyQcCi3p2VgLuB/LJtlRfvqkXpP92tkS?=
 =?us-ascii?Q?TzNjd2ng8kaVHl8I9ZXiFR+ZFWEFsgPkan2r0T0FpHKTCms03tAEcexWokuR?=
 =?us-ascii?Q?bGoldUVKcfARdI7o1DUXxM8I4NkVUtPwtbmNQBzqaXTxyHW9Sgx5m/skJZ8P?=
 =?us-ascii?Q?4ZLZZHBkmdeFDXP0MQEL6rbyDdJLoRLQCiBFprRvnB9Z/qZfNW+u5lQSMhmM?=
 =?us-ascii?Q?ljcluCbkAKU1g0QLUrVHVAybXGb7NXfof1J/ZeOJXplWkSCR6cDin7dfw5gW?=
 =?us-ascii?Q?FnO95l9p87pdMLINfQLpjsSSfYUaHGMdlMFOTNMt+dKTGlz1ahBWDnVpLst+?=
 =?us-ascii?Q?o4I8C08wURAZKo2ehWmAV79h4OSsTYiWU3dUwjf18K0ao2mrCL+OsYGhVZ3K?=
 =?us-ascii?Q?cQtyYU2qPqsd3eT7bkRo/xalBNNIbCe9aTRrvsSan31lTfBa/AUBJUBedKm8?=
 =?us-ascii?Q?T/LyWCvg3HQJPxekZx5kOX+gF1fvXFIeKX6DU2+fsuRTQHCnU5CLdtNPODMA?=
 =?us-ascii?Q?trDNJDgx6C9plzNNZNjnsg8r6uu6q4ZuXCBtJIIFMYuvyBasbHyr98ZFG4/c?=
 =?us-ascii?Q?wgFHrx9ZImKFFxth/FZ4rqhYp5b6m94cljVIUFR2eP1dXBUtggwU7LKvp11b?=
 =?us-ascii?Q?j9IEq1Vn6TL5w5ylXN73hy76gbINOJr14Tr1kivPHgs2CFotVenrzGWJKPlu?=
 =?us-ascii?Q?E3UHJsX6G7xCVkocMbAfQsVfXY7YKYeTbx9s+/otX5/Gsb46n4oWcOzVbJNh?=
 =?us-ascii?Q?JtU1vXowqUJO63SwzZmgw+HskOrBcrRe7yoGkSdOxhgFvFn+gWm6UxbrSYqp?=
 =?us-ascii?Q?v8El4JmqSvm3jgdSw7Q+fjuQ9PE7g3lXmutOQmUFbQ5cI17GZgUJ2SDbWHqc?=
 =?us-ascii?Q?t9Pf8BS0I22CcFIB40OZZYdGlMBqD2BZUrPK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:51:25.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a59790-1241-4835-1342-08dda7976629
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712

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
 tools/testing/selftests/net/forwarding/lib.sh |  43 +
 .../net/forwarding/router_multicast.sh        |  31 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 757 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  12 +-
 33 files changed, 1199 insertions(+), 115 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh

-- 
2.49.0


