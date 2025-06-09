Return-Path: <netdev+bounces-195782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A3FAD2361
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC211189125B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD72163BD;
	Mon,  9 Jun 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kORLqh3l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6B182BD
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485275; cv=fail; b=SjigEnfbNA4WgtPy7B24UlQgClNDJ3tBGSzCeA1rEnD9gNhgp3mRPkyITbfR4kgawfLfK6ZvbVOFXPNJnlQ5UztCWi7YHjHCwzVxph5EVR/175edBN3k7+3dJo/l/lHhX0AaiVImkOSzQL8clSDHZRt9ok2zmK+xYfqN4ZvaYp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485275; c=relaxed/simple;
	bh=ohDw29hl/9HH4h5AHP4/9z22lL71IS2LOa4WZ7PU7HI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CLQnBFIBbgo42vUhvI3do/a/GxEQyNE4p0938EeyhkjXGc5kwJ5mvJ01FhZ/UXFtGZNSyL/bb7b2qcKTpViMzox5TGS8kfE45qAe1psmt3Zz0pbi7P0wjbY6cLiOHBRNnt2OHzH2ObIRTewN0yw4QNWEwdH2mWj+i0EZ0g5Kd9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kORLqh3l; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLolq1awQJnyPFzW5v9MgV6cSdA99WPuzqeU3L5B1VwzoDjCJ5nzoKbSpu8R4dTaa1t1PNSybeHOc2l+7XzfDOpLLSSI83bF+yHyFj2hT9pevNEGeTu65kxM+LSRqdXl1UruVe4kYkVmcmpYarRDlDwbgMPXlEFH7FV9JtfPZI5bVtPjseCgawjWj5i8UsjGX+NNjlAQdSwXpHwDd2lGv4up341gfuDNN0ebIsysqYNc5w6ouhAQ3kfkRNdFitcCVHPu+E7Uy9JukA8BonNRPwWFgC3B5vHW/eDyiJ7AF5M9leEh7T0KhGYUv4aT1g+95ShU9dY98xqzpz0AvqCvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMoVJQJFr8Eainl1u0bOilD6SrdrigbyHMU9OpM098I=;
 b=bZoM/6Q7sbOeS3w4no9Ox/WmlXkxNq0uMhnWsAIRFeNCPtlZMLBt/QCxT6JSRRC058w1c7exFu3Fdl/CzJWVIxHYrA2uQKQoS9l2g/SuydQTCNYdJCjgT/tA31IwiwRvGZ/8g2cCYBOaynvk2XqYe+8jLsqXkKDPgPkCWgEWAqsH/zsFA49HL0mtVCarqpEbMYyfdceU5F9PzmChRO884/DiPWXoQNNzGH1bqdgVzGTr8uCpgs9G4fhuC+Wu9u7mVqqp+HGscchM+SYgf21g+RCari3GqOcWvImbVOnvxIJoHTzov0ftPD5jv3sO1/aRnvfBAuUh9FOhkwU/sYWJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMoVJQJFr8Eainl1u0bOilD6SrdrigbyHMU9OpM098I=;
 b=kORLqh3l1J1cD2Oox4O4MDCAh9fBoVpHaUyfkv16xQMX7P+IXD1hxtcf+HQC+BtQYOhcEFXnCwkVjyy56msspV2+lB1Gkv6Pm+mDTwlye2/Y8eX/GcSO3WqM0bkhWrbBEQxBjSeUFiCJByqyeHUyL5f9GKzb/lo76YkXMv6GYDRjjANtjZOEsJE2rmzgOincUdgsxYOrQat8YiSxC3uVp5a8fFHpmn2Z834vDaEnrftfKhx2N8MO+oTuxxIqu/eKZ3/wItwna6dGTOoEbKJMRziLa7ohliG2IayvkV8VLtpbuco2Pkm6SUT5c5zo//imGA+DoYuwbW78t9rP/zFJeg==
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 9 Jun
 2025 16:07:50 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::94) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Mon,
 9 Jun 2025 16:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 16:07:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 09:07:38 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 09:07:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 0/4] ip: Support bridge VLAN stats in `ip stats'
Date: Mon, 9 Jun 2025 18:05:08 +0200
Message-ID: <cover.1749484902.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d63545-57c9-4d42-c12d-08dda76fc887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SXxvza/aN36ZE/YUcHYLKY4WypEsR0O/uuu5weBfaN70KJVvJyyh0X3y6pN/?=
 =?us-ascii?Q?au1jfI2f2yxosKeeH2zVG9XbSIGDcuctodpvvXrzsFWUy1vsIwCuG+6AADzA?=
 =?us-ascii?Q?vgPJvXtkzWcn9EJtLDFLtgG+yYl80zIyMim9/FbFRkbYQjrndlWG40hgePRs?=
 =?us-ascii?Q?s/LWHEVifu/G30Te+ODR+1TypwbGiyVsUr/wEDT541QadqLyAJNHIflXQrDW?=
 =?us-ascii?Q?BmPlc2TdYb6BB3hGjItXQsyyOUsefC+wtBtuj1aLqEO4MUz/+GN85AXfpxdF?=
 =?us-ascii?Q?fJpwR5XmlS1tjOupspzil5twFKvJemo0sU5IiatvpK75jCdZq8mOweGrO1go?=
 =?us-ascii?Q?o8ichhN7xDLHavl+2BSq5/9oR4arMaN3ij7GbGRtxhAokhepVEgBQZ8H7kQe?=
 =?us-ascii?Q?sndmd4Y+xm1R+nuS9Y1NKSrHMxgS5VVRTLVir3WU8THuHVAsnjLozTACQHhn?=
 =?us-ascii?Q?4hG2Z7jTAigtWquR8irjl7g+nh3LcgFjSCI6zIE7i4TdoxjpfSI975UoMZ6X?=
 =?us-ascii?Q?L6yqKTDiIM5frSnAUAL9/5R2qSwakH5XgYe/kiunsGJtuVMlO905hHE+hfEh?=
 =?us-ascii?Q?BkfdDyl35eTUsORxKIjeJjQ1oEro3StOVD0MYBXLLjDA/oFcx0j5T+raL6RF?=
 =?us-ascii?Q?cpypi84a9irq9ylvFJ3G4da6+VHutYPCdFX7DZ65LaSx3kuG7e/zat7exIxA?=
 =?us-ascii?Q?qyBV3FSkynCfhivDX0gpmgT+yiGWdlo0xB3/dJmNUVyJ2MhF1ggbpkWbY0a7?=
 =?us-ascii?Q?2YGcaUk4uxd9iPl0HhxIDuyWYER6flaXwmEZfXi6+Nn9V38JE9cqzX4EwCc5?=
 =?us-ascii?Q?M5oD7C5X31ZyrA6N0jx5gTqpIeDK8ZhOqS2Axuaaq8SnbSkvn/cWc1XIwDxn?=
 =?us-ascii?Q?pKVmuiLetiCgK/o1Kp+C2vgcXkbndHb67JzONUVm3+phQ56NBPButIsG61CV?=
 =?us-ascii?Q?1kYkZ6kQOkGdE9tewbXDIPdHlj3DesUMaOCW1UEyfim/tgTZEknVaLg8ecXH?=
 =?us-ascii?Q?LPCtdXrzBsthNUAd3WdZZKtJSEx1EB16RUE2uNCzwA3+vNopcV0TTQqlYgBA?=
 =?us-ascii?Q?vD0c/YZ1NrH0hgcxyHfWx5Ns3z3HX2B9kbuRj+qW9rNTZCU9/wFL+Vy5pDdT?=
 =?us-ascii?Q?iRVHrhkrBojkP8HaU9UtjHVGFiWcXIqBJ4R8l5vfyNprloA5rfRkbgGRmmj+?=
 =?us-ascii?Q?BqnaS1Mkcp/vbiAN4bxEb3pV0+qQenvEMP6hE7ageWs+khciVL+Dsb50a/cf?=
 =?us-ascii?Q?G7kxq9sl7TQZ1T495QsRBlhMym9Hsf6iD0PALualyQ7BrGD5+Mn+wYYR5nmg?=
 =?us-ascii?Q?GYir532uCMgQcclJ9u1oRiA3d/RlnpnKexUBo5N4/dTQ9hpSo7+XC/FAmQMc?=
 =?us-ascii?Q?E5Nd5Zk+RSh1bn/cIAjvbllhD68W7W6pbxOp29pjWCpi7hZg1Bz2g9q7lAYZ?=
 =?us-ascii?Q?t7pi0UTL+yfK2okIzaKCZ6ApdNqiC+JahIZk3EJdIstIL/qDJxyzrK4isUF5?=
 =?us-ascii?Q?ia7xELK82vYI806x5SEcZY0MGkfiBoUs/r71?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:07:50.2951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d63545-57c9-4d42-c12d-08dda76fc887
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791

ip stats displays bridge-related multicast and STP stats, but not VLAN
stats. There is code for requesting, decoding and formatting these stats
accessible through `bridge -s vlan', but the `ip stats' suite lacks it. In
this patchset, extract the `bridge vlan' code to a generally accessible
place and extend `ip stats' to use it.

This reuses the existing display and JSON format, and plugs it into the
existing `ip stats' hierarchy:

 # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
 2: v2: group xstats_slave subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
 [ {
         "ifindex": 2,
         "ifname": "v2",
         "group": "xstats_slave",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Similarly for the master stats:

 # ip stats show dev br1 group xstats subgroup bridge suite vlan
 211: br1: group xstats subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev br1 group xstats subgroup bridge suite vlan
 [ {
         "ifindex": 211,
         "ifname": "br1",
         "group": "xstats",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "flags": [ ],
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "flags": [ ],
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

v2:
- Patch #1:
    - Use rtattr_for_each_nested
    - Drop #include <alloca.h>, it's not used anymore
- Patch #3:
    - Add MAINTAINERS entry for the module
- Patch #4:
    - Add the master stats as well.

Petr Machata (4):
  ip: ipstats: Iterate all xstats attributes
  ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
  lib: bridge: Add a module for bridge-related helpers
  ip: iplink_bridge: Support bridge VLAN stats in `ip stats'

 MAINTAINERS        |  2 ++
 bridge/vlan.c      | 50 +++++---------------------------------------
 include/bridge.h   | 11 ++++++++++
 ip/ip_common.h     |  1 -
 ip/iplink_bond.c   |  2 --
 ip/iplink_bridge.c | 52 ++++++++++++++++++++++++++++++++++++++++++----
 ip/ipstats.c       | 17 +++++++--------
 lib/Makefile       |  3 ++-
 lib/bridge.c       | 47 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 122 insertions(+), 63 deletions(-)
 create mode 100644 include/bridge.h
 create mode 100644 lib/bridge.c

-- 
2.49.0


