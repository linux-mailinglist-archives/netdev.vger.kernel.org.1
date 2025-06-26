Return-Path: <netdev+bounces-201425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852BAE96C3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E653B1045
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1058C23314B;
	Thu, 26 Jun 2025 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XjMMHmpz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E4E33993
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923189; cv=fail; b=mn1TDumPMYl5Ge6T2kQuwQiXqelAipbsU6lJNlTjsqudAejW72hvxXPYhqgm4Ai/slvTFw18Ezutcn2LeG+ReMyZlhgROq5mL1kP4y/DyNU8nd1ZdWUSJlKeL2HjmlkCFHJyMHO4w4mAMK/bVgjldTG9fARLNdoSUuXGmsxLAL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923189; c=relaxed/simple;
	bh=Sts9hTimND5qnpaoaNW9jl+3qQRsKPX0a2khbCaQMxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egu6MA+jFwNAAGHeER+qeV8gDtpXTVsP0NrOOry4qSq8CezPC5koGe4OqSQzOg6wkhUEaAKnp4hFgbpu2G0zczoumkrGE8huQBEEq1sAx9V2GXc6gxATnxjYcxZvs3sH95lBbNIrEOHnnzJRmHw4JJDKLxMZIuJLyLL2WmX6HIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XjMMHmpz; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/uKRbXCrVX6xK7K/ZjbEpepDr33Ss/MjFRMaL8lh5uq3FQE2+EBeb+/PzDpwVWn1WDcSCy6cxEYWYeQxflW+UhrqUyn2tEHI6g9d6n7mrNczxRqFk2LUdYfUdfifk3ktXOxpReeH8WH6zC5oDl1fwxZr7D753PohPLczCKzwgAz+OU68ip2l5scSrKearAKymDpAezoDmj8XtcbUBinuXVc5MgbbG8vBOfahc3vz5sPeFRm6Z+LiQHu9d2sLWljTXrRl6N62ClRRg4qA3RkVA9PRI2LwuOCimMOYVLFkeUfEozXM/hfB3bZOhviSyl0YGHxexS6wpQ1p8riS/Hb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys6DmNQbEErA71SyXJDXLx5DUS3IX4J38HGUY2eRKc0=;
 b=PxYjuTd11ZzBqhY2yPqA/zE65KzIuKMZ++2qTeBR2t7qDM5QCFId2po3O/OTLn5uIjbKyGZTejcUEbhLc266kKmogfkR6JoCxY07JXTZGaV8cZMFhaJR3whtqaWixlDcYSuXuK5kx+uXfcDauLoqra22OpVOmed5VAsHjzhimYhjJJm2ZOKRgYyJQE2VaMOxXcfP4PBnfke0DOsAOSODX6j5jKAN+sajUYibbfBLQLFMf1YlDtucuYONlkkUWwVrjy9XX6IzEA3ZJKay7K61H/9r1vWu1tBY4B9ehPKEbN07kviVQF2ezjaSXO/pkYrJgCOwoJFLFKMnAZo77xrNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys6DmNQbEErA71SyXJDXLx5DUS3IX4J38HGUY2eRKc0=;
 b=XjMMHmpzu2VflHNGLv8n5dOhFQkv5JFSR1Dw4wAMNXMSNaWYi9Bzdzy4HtpR39eVeWrjXgukDGQuWyToQ5SYnLjRMvSdB3adpGYPpidhro14k1kI0ZBKHYahWgZ+EGti8xCUmYpWwEqCd/6GteZSysU08rGPvJZPC2zA9ICKKhTR2DnFqgEIRtfiinOISeK0m5ElC8jRtrisGfJzVvkGyBrro/2/GTKyw/NrjDxo3x2mEVH/Kv/eJDAAHXixN+QOso1gTUd4IEwVZA83kUVZ5hp1FRlQbwd9zK8TBChDN3J3ZNu7U9D/TTOlBmkzRTWvz+rEAb5EhSBjaz8JbD/Ntg==
Received: from CH2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:5a::16)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Thu, 26 Jun
 2025 07:33:00 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::75) by CH2PR08CA0006.outlook.office365.com
 (2603:10b6:610:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 07:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 07:33:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 00:32:46 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 00:32:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next v2 1/2] neighbor: Add NTF_EXT_VALIDATED flag for externally validated entries
Date: Thu, 26 Jun 2025 10:31:10 +0300
Message-ID: <20250626073111.244534-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626073111.244534-1-idosch@nvidia.com>
References: <20250626073111.244534-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4778081f-cf10-438b-cded-08ddb483addd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QOsVzHTwXqGah5vMtc0y38/fI87bfrlnVUZ61kS33dkrQHuDPLzVQPLmF3DD?=
 =?us-ascii?Q?1MStbugUT09V+akc65nGq8r/LpOdIkAqpr5zjxvGvmxwQlR+Ktu/8cP3C1vG?=
 =?us-ascii?Q?5AQAW2fEeHN+XhIWka7W5+pi1yzMuWV43bzkQoFozATawXv/GWehrFvrQC29?=
 =?us-ascii?Q?6vf5eZu2cQ+rRcKolTPyc7RBHrjEfXlRAvyltwUJUQGWQTsN/7NbsNnEGV0o?=
 =?us-ascii?Q?kaoK7BQGl2ghBCVMK4hOpyJ8W3oXOE5gNn3UqMMwlyEDDLlWR8UcRJP8bvWU?=
 =?us-ascii?Q?T/e13yOTFt6dThYgy04rAxZAoBqaOy+GAlSAu1y+rJaympejr88usq9m96S1?=
 =?us-ascii?Q?IyLIjD5kCbRSPxBgU0/thsahuGoUPkFzDaKLlV1od7Cw7FKtqix3K7qb5/3h?=
 =?us-ascii?Q?tK+4n5byVimXI2daWCkS6EYX1z5w/ACl1IK4rQ9BMiS+xbGEFzcUPk49GYfP?=
 =?us-ascii?Q?jyXvU5AdNS6UL/tJdgJxstplPyltns4M/1C4h8sBEMJrdofcOE6a6nOWSz7U?=
 =?us-ascii?Q?5yjioDh7t2cvJn4Cp+aJWFMDfJ0jJS2lEzVYDhNp8xYgbxZda2vTRa95xLhZ?=
 =?us-ascii?Q?1UFfWH2lLdcVHY/i7skH8qo1BNTfit7sqJUUTkSLcmTwQ18jO5L2cUODGqx1?=
 =?us-ascii?Q?qpn/lRaRuZdB8UaBoLEOiM+dMSanP0oavW2h0lPDvpNLSvLe2y9Pz8y5uTLr?=
 =?us-ascii?Q?apxIyeruEPsioInArc6bLs87fUr9fNaKz6PZYRjje/kOvgboFINgYtjaTiGl?=
 =?us-ascii?Q?4kqRj+PX60bsezWveEWKYyMjh1CmtDiaIp6bk8Orm907xOCZY6eeDMY0PpIh?=
 =?us-ascii?Q?6CXoRZt8YwvMF4f0B5rjpDbdlGhjMLwj4rmPIE6itRMZfWwf6klPWciXVAAR?=
 =?us-ascii?Q?iIMS9wqsZtX4DxzuO0CnllZCDoPuC85PtU4hBSxJN9v0owfii3ZL1YakEGZi?=
 =?us-ascii?Q?usw5lwxoYNfoDZwpYvuqR8VteAQTJtdZmKFx4fWtQgT+1Z594i6D0P/IrmeK?=
 =?us-ascii?Q?6kX2YhEo7RTB6uAEt+I1X+5RPozB9xiEUMT4eY5zoK0GpS9+Ai7HPX7IbMK5?=
 =?us-ascii?Q?odrK9nvzkgq+d3s9AOq+zM+Tj2Lkk5JbCSq8w0jVsyx7S5BdeM2Mfw9kEY4V?=
 =?us-ascii?Q?r1S4zsGqE2CPatqJDXXIHHl/TmgAFb+nlavtD1H3rlUeRKp2SIDHGd4R6yDE?=
 =?us-ascii?Q?lHwNLXiiuGFIoo6rjcnsmQW4JkrQ0GSUV4FbJfXLKFTKy2SoSkcdw9tTSDYh?=
 =?us-ascii?Q?5aIWbP6k/zvyXJ5IPcjJso3PrR8MqT1qLFKqmKAsRKz4D1hkifbPsX7uOblf?=
 =?us-ascii?Q?36YppnWoLha3sI5iwGKonB5+t8l/fxUY32cabBSNKsOaJkHWdhquTcyFxpxR?=
 =?us-ascii?Q?rYZqG2V4IiRJwiqNaufbVLw8LH3wJD/hQHacHweXuwcHpnsknkAwGXj4zaXy?=
 =?us-ascii?Q?FMPkKyYWkpGwIt8LtQflAcE0SlzBV0QI12w/Y/iHNfTt6uRFyxy/Uv0CvoDE?=
 =?us-ascii?Q?IB1qjsvSg+e/FXV1gwp+3jCzrDCB8veM2dLqF54zLXuIIfZPzxra/plEcg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:33:00.5624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4778081f-cf10-438b-cded-08ddb483addd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708

tl;dr
=====

Add a new neighbor flag ("extern_valid") that can be used to indicate to
the kernel that a neighbor entry was learned and determined to be valid
externally. The kernel will not try to remove or invalidate such an
entry, leaving these decisions to the user space control plane. This is
needed for EVPN multi-homing where a neighbor entry for a multi-homed
host needs to be synced across all the VTEPs among which the host is
multi-homed.

Background
==========

In a typical EVPN multi-homing setup each host is multi-homed using a
set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
switches (VTEPs). VTEPs that are connected to the same ES are called ES
peers.

When a neighbor entry is learned on a VTEP, it is distributed to both ES
peers and remote VTEPs using EVPN MAC/IP advertisement routes. ES peers
use the neighbor entry when routing traffic towards the multi-homed host
and remote VTEPs use it for ARP/NS suppression.

Motivation
==========

If the ES link between a host and the VTEP on which the neighbor entry
was locally learned goes down, the EVPN MAC/IP advertisement route will
be withdrawn and the neighbor entries will be removed from both ES peers
and remote VTEPs. Routing towards the multi-homed host and ARP/NS
suppression can fail until another ES peer locally learns the neighbor
entry and distributes it via an EVPN MAC/IP advertisement route.

"draft-rbickhart-evpn-ip-mac-proxy-adv-03" [1] suggests avoiding these
intermittent failures by having the ES peers install the neighbor
entries as before, but also injecting EVPN MAC/IP advertisement routes
with a proxy indication. When the previously mentioned ES link goes down
and the original EVPN MAC/IP advertisement route is withdrawn, the ES
peers will not withdraw their neighbor entries, but instead start aging
timers for the proxy indication.

If an ES peer locally learns the neighbor entry (i.e., it becomes
"reachable"), it will restart its aging timer for the entry and emit an
EVPN MAC/IP advertisement route without a proxy indication. An ES peer
will stop its aging timer for the proxy indication if it observes the
removal of the proxy indication from at least one of the ES peers
advertising the entry.

In the event that the aging timer for the proxy indication expired, an
ES peer will withdraw its EVPN MAC/IP advertisement route. If the timer
expired on all ES peers and they all withdrew their proxy
advertisements, the neighbor entry will be completely removed from the
EVPN fabric.

Implementation
==============

In the above scheme, when the control plane (e.g., FRR) advertises a
neighbor entry with a proxy indication, it expects the corresponding
entry in the data plane (i.e., the kernel) to remain valid and not be
removed due to garbage collection or loss of carrier. The control plane
also expects the kernel to notify it if the entry was learned locally
(i.e., became "reachable") so that it will remove the proxy indication
from the EVPN MAC/IP advertisement route. That is why these entries
cannot be programmed with dummy states such as "permanent" or "noarp".

Instead, add a new neighbor flag ("extern_valid") which indicates that
the entry was learned and determined to be valid externally and should
not be removed or invalidated by the kernel. The kernel can probe the
entry and notify user space when it becomes "reachable" (it is initially
installed as "stale"). However, if the kernel does not receive a
confirmation, have it return the entry to the "stale" state instead of
the "failed" state.

In other words, an entry marked with the "extern_valid" flag behaves
like any other dynamically learned entry other than the fact that the
kernel cannot remove or invalidate it.

One can argue that the "extern_valid" flag should not prevent garbage
collection and that instead a neighbor entry should be programmed with
both the "extern_valid" and "extern_learn" flags. There are two reasons
for not doing that:

1. Unclear why a control plane would like to program an entry that the
   kernel cannot invalidate but can completely remove.

2. The "extern_learn" flag is used by FRR for neighbor entries learned
   on remote VTEPs (for ARP/NS suppression) whereas here we are
   concerned with local entries. This distinction is currently irrelevant
   for the kernel, but might be relevant in the future.

Given that the flag only makes sense when the neighbor has a valid
state, reject attempts to add a neighbor with an invalid state and with
this flag set. For example:

 # ip neigh add 192.0.2.1 nud none dev br0.10 extern_valid
 Error: Cannot create externally validated neighbor with an invalid state.
 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
 # ip neigh replace 192.0.2.1 nud failed dev br0.10 extern_valid
 Error: Cannot mark neighbor as externally validated with an invalid state.

The above means that a neighbor cannot be created with the
"extern_valid" flag and flags such as "use" or "managed" as they result
in a neighbor being created with an invalid state ("none") and
immediately getting probed:

 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
 Error: Cannot create externally validated neighbor with an invalid state.

However, these flags can be used together with "extern_valid" after the
neighbor was created with a valid state:

 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
 # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use

One consequence of preventing the kernel from invalidating a neighbor
entry is that by default it will only try to determine reachability
using unicast probes. This can be changed using the "mcast_resolicit"
sysctl:

 # sysctl net.ipv4.neigh.br0/10.mcast_resolicit
 0
 # tcpdump -nn -e -i br0.10 -Q out arp &
 # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 # sysctl -wq net.ipv4.neigh.br0/10.mcast_resolicit=3
 # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
 62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28

iproute2 patches can be found here [2].

[1] https://datatracker.ietf.org/doc/html/draft-rbickhart-evpn-ip-mac-proxy-adv-03
[2] https://github.com/idosch/iproute2/tree/submit/extern_valid_v1

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    
    * s/neigbor/neighbor/ in comment.
    * Do not flush "extern_valid" entries upon carrier down.
    * Reword some parts of the commit message.

 Documentation/netlink/specs/rt-neigh.yaml |  1 +
 include/net/neighbour.h                   |  4 +-
 include/uapi/linux/neighbour.h            |  5 ++
 net/core/neighbour.c                      | 79 ++++++++++++++++++++---
 4 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 25cc2d528d2f..30a9ee16f128 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -79,6 +79,7 @@ definitions:
     entries:
       - managed
       - locked
+      - ext-validated
   -
     name: rtm-type
     type: enum
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index c7ce5ec7be23..7e865b14749d 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -261,13 +261,15 @@ static inline void *neighbour_priv(const struct neighbour *n)
 #define NEIGH_UPDATE_F_EXT_LEARNED		BIT(5)
 #define NEIGH_UPDATE_F_ISROUTER			BIT(6)
 #define NEIGH_UPDATE_F_ADMIN			BIT(7)
+#define NEIGH_UPDATE_F_EXT_VALIDATED		BIT(8)
 
 /* In-kernel representation for NDA_FLAGS_EXT flags: */
 #define NTF_OLD_MASK		0xff
 #define NTF_EXT_SHIFT		8
-#define NTF_EXT_MASK		(NTF_EXT_MANAGED)
+#define NTF_EXT_MASK		(NTF_EXT_MANAGED | NTF_EXT_EXT_VALIDATED)
 
 #define NTF_MANAGED		(NTF_EXT_MANAGED << NTF_EXT_SHIFT)
+#define NTF_EXT_VALIDATED	(NTF_EXT_EXT_VALIDATED << NTF_EXT_SHIFT)
 
 extern const struct nla_policy nda_policy[];
 
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index b851c36ad25d..c34a81245f87 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -54,6 +54,7 @@ enum {
 /* Extended flags under NDA_FLAGS_EXT: */
 #define NTF_EXT_MANAGED		(1 << 0)
 #define NTF_EXT_LOCKED		(1 << 1)
+#define NTF_EXT_EXT_VALIDATED	(1 << 2)
 
 /*
  *	Neighbor Cache Entry States.
@@ -92,6 +93,10 @@ enum {
  * bridge in response to a host trying to communicate via a locked bridge port
  * with MAB enabled. Their purpose is to notify user space that a host requires
  * authentication.
+ *
+ * NTF_EXT_EXT_VALIDATED flagged neighbor entries were externally validated by
+ * a user space control plane. The kernel will not remove or invalidate them,
+ * but it can probe them and notify user space when they become reachable.
  */
 
 struct nda_cacheinfo {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 8ad9898f8e42..e5f0992ac364 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -154,11 +154,12 @@ static void neigh_update_gc_list(struct neighbour *n)
 	if (n->dead)
 		goto out;
 
-	/* remove from the gc list if new state is permanent or if neighbor
-	 * is externally learned; otherwise entry should be on the gc list
+	/* remove from the gc list if new state is permanent or if neighbor is
+	 * externally learned / validated; otherwise entry should be on the gc
+	 * list
 	 */
 	exempt_from_gc = n->nud_state & NUD_PERMANENT ||
-			 n->flags & NTF_EXT_LEARNED;
+			 n->flags & (NTF_EXT_LEARNED | NTF_EXT_VALIDATED);
 	on_gc_list = !list_empty(&n->gc_list);
 
 	if (exempt_from_gc && on_gc_list) {
@@ -205,6 +206,7 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 
 	ndm_flags  = (flags & NEIGH_UPDATE_F_EXT_LEARNED) ? NTF_EXT_LEARNED : 0;
 	ndm_flags |= (flags & NEIGH_UPDATE_F_MANAGED) ? NTF_MANAGED : 0;
+	ndm_flags |= (flags & NEIGH_UPDATE_F_EXT_VALIDATED) ? NTF_EXT_VALIDATED : 0;
 
 	if ((old_flags ^ ndm_flags) & NTF_EXT_LEARNED) {
 		if (ndm_flags & NTF_EXT_LEARNED)
@@ -222,6 +224,14 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 		*notify = 1;
 		*managed_update = true;
 	}
+	if ((old_flags ^ ndm_flags) & NTF_EXT_VALIDATED) {
+		if (ndm_flags & NTF_EXT_VALIDATED)
+			neigh->flags |= NTF_EXT_VALIDATED;
+		else
+			neigh->flags &= ~NTF_EXT_VALIDATED;
+		*notify = 1;
+		*gc_update = true;
+	}
 }
 
 bool neigh_remove_one(struct neighbour *n)
@@ -379,7 +389,9 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 	dev_head = neigh_get_dev_table(dev, tbl->family);
 
 	hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
-		if (skip_perm && n->nud_state & NUD_PERMANENT)
+		if (skip_perm &&
+		    (n->nud_state & NUD_PERMANENT ||
+		     n->flags & NTF_EXT_VALIDATED))
 			continue;
 
 		hlist_del_rcu(&n->hash);
@@ -942,7 +954,8 @@ static void neigh_periodic_work(struct work_struct *work)
 
 			state = n->nud_state;
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
-			    (n->flags & NTF_EXT_LEARNED)) {
+			    (n->flags &
+			     (NTF_EXT_LEARNED | NTF_EXT_VALIDATED))) {
 				write_unlock(&n->lock);
 				continue;
 			}
@@ -1095,9 +1108,15 @@ static void neigh_timer_handler(struct timer_list *t)
 
 	if ((neigh->nud_state & (NUD_INCOMPLETE | NUD_PROBE)) &&
 	    atomic_read(&neigh->probes) >= neigh_max_probes(neigh)) {
-		WRITE_ONCE(neigh->nud_state, NUD_FAILED);
+		if (neigh->nud_state == NUD_PROBE &&
+		    neigh->flags & NTF_EXT_VALIDATED) {
+			WRITE_ONCE(neigh->nud_state, NUD_STALE);
+			neigh->updated = jiffies;
+		} else {
+			WRITE_ONCE(neigh->nud_state, NUD_FAILED);
+			neigh_invalidate(neigh);
+		}
 		notify = 1;
-		neigh_invalidate(neigh);
 		goto out;
 	}
 
@@ -1245,6 +1264,8 @@ static void neigh_update_hhs(struct neighbour *neigh)
 				NTF_ROUTER flag.
 	NEIGH_UPDATE_F_ISROUTER	indicates if the neighbour is known as
 				a router.
+	NEIGH_UPDATE_F_EXT_VALIDATED means that the entry will not be removed
+				or invalidated.
 
    Caller MUST hold reference count on the entry.
  */
@@ -1979,7 +2000,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
-		if (ndm_flags & NTF_MANAGED) {
+		if (ndm_flags & (NTF_MANAGED | NTF_EXT_VALIDATED)) {
 			NL_SET_ERR_MSG(extack, "Invalid NTF_* flag combination");
 			goto out;
 		}
@@ -2010,7 +2031,8 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (neigh == NULL) {
 		bool ndm_permanent  = ndm->ndm_state & NUD_PERMANENT;
 		bool exempt_from_gc = ndm_permanent ||
-				      ndm_flags & NTF_EXT_LEARNED;
+				      ndm_flags & (NTF_EXT_LEARNED |
+						   NTF_EXT_VALIDATED);
 
 		if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
 			err = -ENOENT;
@@ -2021,10 +2043,27 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			err = -EINVAL;
 			goto out;
 		}
+		if (ndm_flags & NTF_EXT_VALIDATED) {
+			u8 state = ndm->ndm_state;
+
+			/* NTF_USE and NTF_MANAGED will result in the neighbor
+			 * being created with an invalid state (NUD_NONE).
+			 */
+			if (ndm_flags & (NTF_USE | NTF_MANAGED))
+				state = NUD_NONE;
+
+			if (!(state & NUD_VALID)) {
+				NL_SET_ERR_MSG(extack,
+					       "Cannot create externally validated neighbor with an invalid state");
+				err = -EINVAL;
+				goto out;
+			}
+		}
 
 		neigh = ___neigh_create(tbl, dst, dev,
 					ndm_flags &
-					(NTF_EXT_LEARNED | NTF_MANAGED),
+					(NTF_EXT_LEARNED | NTF_MANAGED |
+					 NTF_EXT_VALIDATED),
 					exempt_from_gc, true);
 		if (IS_ERR(neigh)) {
 			err = PTR_ERR(neigh);
@@ -2036,6 +2075,24 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			neigh_release(neigh);
 			goto out;
 		}
+		if (ndm_flags & NTF_EXT_VALIDATED) {
+			u8 state = ndm->ndm_state;
+
+			/* NTF_USE and NTF_MANAGED do not update the existing
+			 * state other than clearing it if it was
+			 * NUD_PERMANENT.
+			 */
+			if (ndm_flags & (NTF_USE | NTF_MANAGED))
+				state = READ_ONCE(neigh->nud_state) & ~NUD_PERMANENT;
+
+			if (!(state & NUD_VALID)) {
+				NL_SET_ERR_MSG(extack,
+					       "Cannot mark neighbor as externally validated with an invalid state");
+				err = -EINVAL;
+				neigh_release(neigh);
+				goto out;
+			}
+		}
 
 		if (!(nlh->nlmsg_flags & NLM_F_REPLACE))
 			flags &= ~(NEIGH_UPDATE_F_OVERRIDE |
@@ -2052,6 +2109,8 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		flags |= NEIGH_UPDATE_F_MANAGED;
 	if (ndm_flags & NTF_USE)
 		flags |= NEIGH_UPDATE_F_USE;
+	if (ndm_flags & NTF_EXT_VALIDATED)
+		flags |= NEIGH_UPDATE_F_EXT_VALIDATED;
 
 	err = __neigh_update(neigh, lladdr, ndm->ndm_state, flags,
 			     NETLINK_CB(skb).portid, extack);
-- 
2.49.0


