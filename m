Return-Path: <netdev+bounces-166493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E6A362DB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A39A16A25A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D92676CD;
	Fri, 14 Feb 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lo1yky13"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA502753FD
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549957; cv=fail; b=hHQDtAffXNireICb57sbm4A05PZbRbejEGOUapqFyjGs/Oy9gIlNc76bogX1uoNsLBxYreakc/AYQ37hkC/dCtlXqO/9O3HZp0vfS6uOVmysNocAxPjb3ByHKWlazyJJpl7SD5pXOQn4WdAKrPq4PJUgLcnDfQX95cmSSEpqFf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549957; c=relaxed/simple;
	bh=P1uja2UOKV/DcraNRckMCKEmbT06qx+MgPSw5KPGAiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkPTdXUBRpSJuF5HQF+MwP1SWNsydb64pXNXNYmj+Yqp3xFM07fAcbmpUt2rDBx4ZGyTDrJ5hbT4mhFXGZO3AdKfoWH1DCTIANFTeghusGPa1sFidjRLkBWDyhBXAMVhHA3n/USsZzHc2a7nLHuHoUVN7AkpdKytQ6luyOOulFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lo1yky13; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqbuAky2TeK9cRsYffV2uTnlH7tDPf6LPknNqN8Tg2VkPNxvR1qbnI53KuAbUJp0bYUgNsSC6bqHbM4Or3K/Oh8yVfc/6zd+OAa7Npss2F+gyW4oW0BZmhL9a1hKQp4vAS6Drc0LN3lnPT+sqMx5M5xLZeqIduVFIgou4RJsbK8LxF4dU5BkPCRUkZujza2ttBnggKaRjMiprYlrkELenwk96BWYBTM/zFUEWZeYMq141G7KnV5Y0yXXB987Dtf+wY2MK7pkVSjJwN5Vc64qSx1v0mW9eMqd8xtu4S6UurFFJY6qJo7/XiKxwifY8YBMiYid1a+si6CwIskLjUaecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b++yg5eou2hJR7eOZxPbmePjxzbFOBE+QaD7S3Z10lU=;
 b=YmTGEmgS1epQg8INYoKn8aQZ3hg6Rm1GVYeyajEgtMCslAiSR5FQQyMTOJFqSRs63k/onZNzS2chMcBgXj9yqGRxYSNz96/wrZymJF5QIcXVkQofHF7bHO3X2S581+JGzZVF/q4wISGkho++3i7LnC/SdSNVCo1i2OswJ+Zmv+LiemXe+S9kfMcsHSAfWro3jNQzwnGMvRUVwzXCqQSPd/8wydKP1CoYJ2OdJjaO7iDU5S8mofwaj+rKp4v5SCYSjNC3SX8XKmM7Ue7RFY2LGfXWzhUJv5OemWYNmrPDDcijKzMqAauawm5TLCohloWpyYvU1JolU2hQp/PeTLmyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b++yg5eou2hJR7eOZxPbmePjxzbFOBE+QaD7S3Z10lU=;
 b=Lo1yky138J2DtsUQJdgrjPJIwdhYIrXZqvqn1W+GUT7yUuuwDJSmp/CJDxIuxEAweqbmXjUWqZBLr+SIdxiX0pmIqqV24/GJHBBGmIEuBUZFXYqlLKRUTh5e0ac5GbqPcJwpuAR32jJFbI9CmAmyDXv0Hg7+CWeCS6E2vhpo9q4GS4nUX89if0d54/f0QolaO0vs8Cq2XLOYnyV75A25iteboWiIN3FrA6Y7nLH+j8SQ0t7VobVpYhNZ2xKZWYFzVV9eFvlrXYeXuySr8pwnDz3xjKn09VaMgbDLKP7rQVyBetYP050Tzi4lhHQQ6LAjxGNVi0ZrbQCdpDqxOnbDew==
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 16:19:11 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::32) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 16:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 16:19:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Feb
 2025 08:18:53 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 08:18:48 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next v2 0/5] vxlan: Join / leave MC group when reconfigured
Date: Fri, 14 Feb 2025 17:18:19 +0100
Message-ID: <cover.1739548836.git.petrm@nvidia.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5cac53-0102-4db5-164d-08dd4d135067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSEVOM/fngu0e5Ymmaf4IKCOyij+UhG97nE1/Zw4miiFseDdw9aj+N2AYBEW?=
 =?us-ascii?Q?lEfkIVHJ32tEQ1jB9ZXHHa3f9jtVkjGlbeDWkD5qZXAfgCHGozo73R0Ma2jz?=
 =?us-ascii?Q?l9JqpgjIS572Js2k2cU2nYVS91pDwSHrr7kCfGzVVJowBB/5GyQahlJEmM/W?=
 =?us-ascii?Q?pSQyfoVM4hGPC4jR+UpEhF1MhhQ+M10HRlu1WkH79hUMYHAz2pV3nIDdEaqg?=
 =?us-ascii?Q?NjVcPLW/D7y9yyKO7F6MvfiLQHC8Dg0+E37sje7UuWHXznsVzcSS8tz1htrJ?=
 =?us-ascii?Q?07x3QVSAy2yBZUPT5QMnO3OpbV6qkQU25GZQGOCzQtCRoVovN47fofOLP50M?=
 =?us-ascii?Q?Z+LPCwGs/2BmyQh96gsC8lhEgm4TOosiS0WmXtBJahDtGmAFDcdYo/HFszW4?=
 =?us-ascii?Q?TtkygEJ6ce5pb7IstD133c9czbJLB5dtwtz5np/YhuBGjsDw/h9VfXip1e8P?=
 =?us-ascii?Q?7a4VnxMYp1RNlkfDRX0WjUB08S7OHAvVoP3VWkc8700fqRE5JnaI6ScvGrkQ?=
 =?us-ascii?Q?ZuhoccTbhKOxR9GHs9r/zyrg3Ct218mXfBP/TlwAjXQkS8CxdMEnuwU/VYdS?=
 =?us-ascii?Q?EDxpM1Y5ao7LTbJGrp/Je7eFr13Q5OYwUZGmVx0pr3sDg1MnpKZffHdFXOtN?=
 =?us-ascii?Q?LDwLI1YCr+XGobpNZ8Z0s+7ISez8nJEXLvgp+n+Ev6zdCuxEG77aE7XBCYbb?=
 =?us-ascii?Q?TtZoqAiZlmtNKbjJr7rNikQErmo64oW1Pp/UONvKsksf+j7r8NrJR6L7htna?=
 =?us-ascii?Q?bUe+yTCn3SPA3qhiGdlJOP5IFIHzKvv+rUsQIDkFPedhLyQ4uAZZ2g8mqKyh?=
 =?us-ascii?Q?2DyQN6O+A0eEhV0sghFBZeOXGCFKGi1V3zWEKsMYYtOicRZt8LWNoagj2bde?=
 =?us-ascii?Q?coVcOUX4qU6X5XMSHrZ6OHCav4VEyDnb12ypl/ZQpTDGufH5vRPC2haS6zR5?=
 =?us-ascii?Q?6GaeybdXeOl7mBwWbg10b5FaSTJUM4txtevcpmNhWqSurAbuCqTiUKaQn+pR?=
 =?us-ascii?Q?X0IdhLaHEEslNpJYv1oenEl/Xj7EQSWfqCUlslIKQzwFZTQaCkOK7pvY8lv4?=
 =?us-ascii?Q?3zO7DifrTOHOXcXKyRF4Uj1SKZH6YGLkLGGlrYJQbrDp3725rllPp9lS0LIT?=
 =?us-ascii?Q?XEqHe/m/RlLoSUzuDYNY1m6RqyAxD6kuuliG2v0nw21b2plWT3WJypazejal?=
 =?us-ascii?Q?3vImK7aRvFH48AjWRxO7M17MMHbx0BAlzohMRvcf/cZs6a5+6vHh+Ko9KoTv?=
 =?us-ascii?Q?ARx3E6mt6O0efFOcVmi7Qp9E3aW6fT2Xn5xiZOgmLhGN0gsykWnZEVKh4H++?=
 =?us-ascii?Q?BwL3YMsdp/1RoWKp76lG0IPeC6bYI0YIzjVexsKhz2r51ZK5g9/rqCkZJnIg?=
 =?us-ascii?Q?TBKv6QnREqX61w2aKI4bgepv5RviCmDz0ds9WYIKG+T8llkHXnSmsLw5Dmwl?=
 =?us-ascii?Q?34+zBQuTkeFnJ2Nt1HgtOLIuSwEJeP9NWIOuF8bOJMu0MIHEwiTqXQg577gr?=
 =?us-ascii?Q?2291uaF70jqBGBg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:10.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5cac53-0102-4db5-164d-08dd4d135067
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

When a vxlan netdevice is brought up, if its default remote is a multicast
address, the device joins the indicated group.

Therefore when the multicast remote address changes, the device should
leave the current group and subscribe to the new one. Similarly when the
interface used for endpoint communication is changed in a situation when
multicast remote is configured. This is currently not done.

Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
possible that with such fix, the netdevice will end up in an inconsistent
situation where the old group is not joined anymore, but joining the
new group fails. Should we join the new group first, and leave the old one
second, we might end up in the opposite situation, where both groups are
joined. Undoing any of this during rollback is going to be similarly
problematic.

One solution would be to just forbid the change when the netdevice is up.
However in vnifilter mode, changing the group address is allowed, and these
problems are simply ignored (see vxlan_vni_update_group()):

 # ip link add name br up type bridge vlan_filtering 1
 # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
 # bridge vni add dev vx1 vni 200 group 224.0.0.1
 # tcpdump -i lo &
 # bridge vni add dev vx1 vni 200 group 224.0.0.2
 18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 # bridge vni
 dev               vni                group/remote
 vx1               200                224.0.0.2

Having two different modes of operation for conceptually the same interface
is silly, so in this patchset, just do what the vnifilter code does and
deal with the errors by crossing fingers real hard.

v2:
- Patch #1:
    - New patch.
- Patch #2:
    - Adjust the code so that it is closer to vnifilter.
      Expand the commit message the explain in detail
      which aspects of vnifilter code were emulated.

Petr Machata (5):
  vxlan: Drop 'changelink' parameter from vxlan_dev_configure()
  vxlan: Join / leave MC group after remote changes
  selftests: forwarding: lib: Move require_command to net, generalize
  selftests: test_vxlan_fdb_changelink: Convert to lib.sh
  selftests: test_vxlan_fdb_changelink: Add a test for MC remote change

 drivers/net/vxlan/vxlan_core.c                |  24 +++-
 tools/testing/selftests/net/forwarding/lib.sh |  10 --
 tools/testing/selftests/net/lib.sh            |  19 +++
 .../net/test_vxlan_fdb_changelink.sh          | 111 ++++++++++++++++--
 4 files changed, 136 insertions(+), 28 deletions(-)

-- 
2.47.0


