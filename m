Return-Path: <netdev+bounces-175410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26528A65B08
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D51C7A5B47
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8E71AB528;
	Mon, 17 Mar 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ESY4Gloi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92E1ABEA5
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233213; cv=fail; b=PN+iy5+7PZ2vUgYPxAvhMYO5cnIr+I5RTE5emJWbNER7g6jyTsMWaWFho4lNVWDHmqNZ4j0YrQCTPn1cJ1rmnr17yBrRSsXm8XkqSpu+7PVMnT/d3pcuT0YWNoI3jQhqyLQmEi8pp54T5nJOEsrcEnGnQ0HOrR47Oj1uN2D9jcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233213; c=relaxed/simple;
	bh=XhRKXI8308n+wxjJEtmX90Csm61/j2FqyQoC0Ptvd/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+YuDnOQF9cYyQ+KbL/VhziPpeTcrbv8coKM7BfKIu83qfTwEWOpuMBVn2Zte5MRY5VYcef1ZMVa327Nt7+lvLu/pBnILT0W+PQgsQ7R6lwsNMAg8UrJtkXEZobu7dY8yeUUTvvQ71c/m2Cvbdv4YF0C2bgZZa57kDJKIX2J9+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ESY4Gloi; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA6/8S+tNfJ7vvNNvBM6qFZ8+V70Ad4nA9prmVTR9GbH6E/zoT/rfeZxLk2vDx+I0IwIfBJg3g8QEwfMCzC0zn8iAabh3JPVS02R9Wj800FJPfA6Pe7S2q5RyrvcyZozdXwVOEfndhxvDrkuMFzoZ9+3s+0kB7rLmTq0qKgSsuy3yBHEAiH3bwqlj4eJxuQNePVJbe48NzdckqbCs2io/8Tke2+xsrQD+8Q8enRZkb4fpKzwMDf3AIgkXKv5kW1KA0NuIm5rWyw31ZzZStQcQ506W4NjR13iqNAOp/D7MbphXLNn9On/B7tdbSs9Zs4s+r7KIbKHgB989qmysrs4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxIibQjoW3EMlK+d0B6tgPDqBrLiWdEKqMyLGGFXf74=;
 b=lJb6UxUfZBu4De7DoW1mZhtBZ2AwQJO0uxRc9X0utrOiceVy3IE6YKpuQ29Dgy5EK6JRqck7aJfWPp6RelbdU9J8U1KnTezhZ14E0RBIEcoVurI/4JlSrwaKEG0N6T3jsRhqcW09H+LOwacFFXLz762el4AiLs03OCEzOFLjao4dBBKw0eyPF+5LDsBIdJTeyPjRGrSMi6UGDYA6TDD+0TwBmAAEmcz7pUSG5XxGqtOdQek2vQSLopo0PfGxCYJEz/7Db7KLYE6zXOo8hS2Jg6KuBkMSvXw9z0vE7gTOVuPq4uz3sFsbPw2lTWN53z9WWHfRhxkGUGc+7Z8x4E6e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxIibQjoW3EMlK+d0B6tgPDqBrLiWdEKqMyLGGFXf74=;
 b=ESY4GloiFu/yQUEv1AlZHi2a03qQNO5tOc66lGl3tp5U3p1cmbqLe2m6jWKW/QPIqacilPGxYjGtjYEMMf+5rdNcVxjZYmAVpfiU8TRtCGFbfAVRu66+Adpak9MSxk2czoW5tceG22J9Ylze6VqHXFRSPhnh5tDQ69GVesiooiJvaITA0vvhewDjcC0YIH+grusah/rHxY9r8VcTMd5HQmMy+HKH/Xs9djhQJThnZ9vNGEEqsyt0/vCh1dicCvF/IhokkNzLmGSLMTD0DyPCjWhj9H+RwN9Y+nzmBbdi5C5sRUOzB5Tp8Iu0DSWGL/37XkLNVuzwUizZ8KGxYei4cA==
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:40:08 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::86) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 17:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:40:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:39:54 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:39:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/6] mlxsw: Add VXLAN to the same hardware domain as physical bridge ports
Date: Mon, 17 Mar 2025 18:37:25 +0100
Message-ID: <cover.1742224300.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3ceeed-7238-4d7b-195a-08dd657ac2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3l0TdcKi/Lw34EP90xAr26aC9wFYOSjGmc1I4/iCPgB0aHrho4TvubUnqP+S?=
 =?us-ascii?Q?OKFGv5klJf5BPmCFDFPMbWgA+aph7sD/lZzbtm0MNpr9nNB99RlRPz0srWGp?=
 =?us-ascii?Q?8ODNH/bKUU5Xa1LyK0LvV2f3Vbfh1L1jVE7CgO+mKfc42Ma1pNoGr/TUVSwt?=
 =?us-ascii?Q?coc6MzYcc+3Kl8GRDgTGa0EcAGLI/wtauT4fB3gofAX1/BTpyMCKb68mT5Vc?=
 =?us-ascii?Q?zsGb0z8/BYJTmEvLVJHMeXKAJvJE5Q7iDcKVWnWh98Bx1x9d97o3I1zFKHyS?=
 =?us-ascii?Q?Z45jM0fTsewQL1ZvIiUbM6QCgF4vZGybpbSE2jSe3pPzbzDA5guC3kI8rDlC?=
 =?us-ascii?Q?AAbVmjYDWZSlGROK4mDC/wLkGjSuPVLSmaocY+7E7cajhqFMXKrxb5z2nBPi?=
 =?us-ascii?Q?yuhejSX3fAdA9jE+uYs3O/x4tUwnohIqn/OA17BtMW5s1PGpwfr1J4+Hhzc0?=
 =?us-ascii?Q?8DLY0PDRwX/sYSlUG9U5k1zLfRIoKR8yB2XSxrdVR5IqkpPgZgipWwKut3R7?=
 =?us-ascii?Q?C+ekUodgmRuqYBEb3OlVOfCv6HZPxyk6DuxXqoZIgAIWJGh/CxPWPD8vV7QO?=
 =?us-ascii?Q?V/My1x01aqMr0/zm0ll/teoFaG3/OAOyk5i33rYYiL7Nq0mJateYPb8VwaqR?=
 =?us-ascii?Q?l44MuE7ZANZ9OZHZuXM4/uhyzA88AYa0kstkDfs/TG9cba9guLTM4quIg/0d?=
 =?us-ascii?Q?U9/r37eDOgmCooEYuA2+ILAIrzaCmcL9tBcvgijriLU7B89LP/BXV5dUJYJN?=
 =?us-ascii?Q?BWABJ96Pg4J17sU5SE3z58uQagKOJQngnhrcVPB1ZfKU0ivhnu3dYqahD9Fd?=
 =?us-ascii?Q?QaBr4m0nX0QXaT7n2kFZSrUZPGRJSgrqWVlNZ25CyWKm4XWu/prkA7kIKO6j?=
 =?us-ascii?Q?itdGwVmLVK6Dq6UsVUPpKk12fUKKq9D1QxhER+UnIHnmdDpQkuf8nHbs++rX?=
 =?us-ascii?Q?nBXfxEB46LFtGTnrcBuu7PXeSRiEQv5sZcyKXIbjVUQHuZPJiv7qeOdCMnxb?=
 =?us-ascii?Q?L8jXVc4tPg3/YludGVcVwE9cQCQW0nAKWvUJRwmKD6LBI8D/XqWt7jetcIkU?=
 =?us-ascii?Q?b9ZZNNhGHf7USCYODLQq1iRVuUmlkVPgHo/7CdGKcyLTaT6XPCEO16okFEWu?=
 =?us-ascii?Q?xlAwIHKN4RVy7uwUrTJ86rzFd/S3DlE8946Jvz2ZqOTL4BhSUltbpaqIR+AV?=
 =?us-ascii?Q?06SmlM0DjcAwMW+55nYMOcYB9B14g2Ynwwk1axxSg4jbG9IRFThslpHtQJeP?=
 =?us-ascii?Q?VnbE5gKsvXz3dt4G34UeA78HTI/59jRlcW56+UvB4KfqLLabo3Kg3VuYz4Se?=
 =?us-ascii?Q?tLWCxq+n1jDpTAPAK6FwUcAxgX2e6lEahu3pau9QCbwMDTK3EOzg0hZVBA5m?=
 =?us-ascii?Q?5n7YpJD+iphrgbKz0imdzfSA2ZUB51n9omYevM5VLCW2z6sUYQ0IbOU8wlWZ?=
 =?us-ascii?Q?i8BZmojcvdI77cP2jHkg99CkFcYmHHTy11S0oRmPPL8Fm/jaGfg+Ms59wFL1?=
 =?us-ascii?Q?Wu6s5OG3jwZAym0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:40:08.2232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ceeed-7238-4d7b-195a-08dd657ac2c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

Amit Cohen writes:

Packets which are trapped to CPU for forwarding in software data path
are handled according to driver marking of skb->offload_{,l3}_fwd_mark.
Packets which are marked as L2-forwarded in hardware, will not be flooded
by the bridge to bridge ports which are in the same hardware domain as the
ingress port.

Currently, mlxsw does not add VXLAN bridge ports to the same hardware
domain as physical bridge ports despite the fact that the device is able
to forward packets to and from VXLAN tunnels in hardware. In some
scenarios this can result in remote VTEPs receiving duplicate packets.

To solve such packets duplication, add VXLAN bridge ports to the same
hardware domain as other bridge ports.

One complication is ARP suppression which requires the local VTEP to avoid
flooding ARP packets to remote VTEPs if the local VTEP is able to reply on
behalf of remote hosts. This is currently implemented by having the device
flood ARP packets in hardware and trapping them during VXLAN encapsulation,
but marking them with skb->offload_fwd_mark=1 so that the bridge will not
re-flood them to physical bridge ports.

The above scheme will break when VXLAN bridge ports are added to the same
hardware domain as physical bridge ports as ARP packets that cannot be
suppressed by the bridge will not be able to egress the VXLAN bridge ports
due to hardware domain filtering. This is solved by trapping ARP packets
when they enter the device and not marking them as being forwarded in
hardware.

Patch set overview:
Patch #1 sets hardware to trap ARP packets at layer 2
Patches #2-#4 are preparations for setting hardwarwe domain of VXLAN
Patch #5 sets hardware domain of VXLAN
Patch #6 extends VXLAN flood test to verify that this set solves the
packets duplication

Amit Cohen (6):
  mlxsw: Trap ARP packets at layer 2 instead of layer 3
  mlxsw: spectrum: Call mlxsw_sp_bridge_vxlan_{join, leave}() for
    VLAN-aware bridge
  mlxsw: spectrum_switchdev: Add an internal API for VXLAN leave
  mlxsw: spectrum_switchdev: Move mlxsw_sp_bridge_vxlan_join()
  mlxsw: Add VXLAN bridge ports to same hardware domain as physical
    bridge ports
  selftests: vxlan_bridge: Test flood with unresolved FDB entry

 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 22 ++-----
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  4 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 66 +++++++++++++------
 .../ethernet/mellanox/mlxsw/spectrum_trap.c   | 12 ++--
 drivers/net/ethernet/mellanox/mlxsw/trap.h    |  5 +-
 .../net/forwarding/vxlan_bridge_1d.sh         |  8 +++
 .../net/forwarding/vxlan_bridge_1q.sh         | 15 +++++
 7 files changed, 83 insertions(+), 49 deletions(-)

-- 
2.47.0


