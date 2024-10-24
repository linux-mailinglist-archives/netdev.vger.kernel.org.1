Return-Path: <netdev+bounces-138765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBAE9AECD0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C49B285639
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E221F8EE5;
	Thu, 24 Oct 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HsY91AWM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945111F81B9
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789102; cv=fail; b=RN0VCyf9bnNsef4lTtspdIYDuGuA2ug0hoYtB7qmxwdUiUeLgLOed8NuYUTvKxm1jB/gNMgdGA8kLf8iVTgPTS0Qg/mrH9iTNny8fH2F5fJniFl/Q/P5lIL3HY86h2Lj24P2k5WPiZ0ByoUgTwfr04ttlJ2cliySUARgyUd5JjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789102; c=relaxed/simple;
	bh=/TxRBAsLwiTvKwl7yqogfik72flC9PmV/g7Qm0U6650=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qGw/tpy/0YtAGqxheTUQrW1lNoEB4cT1grEb3ktfMcvy+FyFoDv5S9CE9IErLhYLfwTmHSrB4eH2d0reJZxlNPDDKHSlzwtFvlAE5w2ZHx1ujLVjcWqZEXRrAPlcKITaUEvjz1641yIJGRzmAs/VSdKaaUzwkMTlIw9nNh7cz7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HsY91AWM; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz8naYSNV4K8D1xICC+Q4eMtpe/YfC7Fi6LO+FqZCdfLn53+sG86J1HFPBxvrgF6t5513o2Yo+XuGCAEBLLtX/Mpz5Qmhj8rnDoVrtPoOwtcYXBJQ9zYUZSOKnP7/QFGefeKMxOs6nSP7wh8ed5hf+oZqby0se9UHnG4o0Rhlc3ssQLHiGwUo1Rk/z+s/AFn6ZUGWLcmR5nBEIsozbfs2kOce5dx1y/e53HfTZulDgPlljPfu3Rb1IfL++7zlY/hGhxJ031IFOGaJSmcVyGum67WjkAAJ0/V/eExJ3XFuuZpZkz5Pc+5K1CE/7gGiDU8M+T1rp2Z52T8RfZUxyoD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu5eqNmBCF6JcOsRUvKCX/YhUPBqx3+/5jRrA0PS0AQ=;
 b=N94qWUyrbXiH357DEzbfW6M8m/Qx3+Weg6Xo4i2xrjW4H2y/YcizfYQPuFE1n2TELxQlo+mi2AUA6ZLAUv/DbVqKAg4EJ+3OJP4M96h3yIYXUPySBjfN7v+BWwJhyEBcdbjqWD87dT0JDAlypXfE6UN1kjohjK1Xxavvmz0ivyWVf0UtNR0r1hpHKaetKjKFp8pMiu3nyPaxXGC3efOnwHVi3KINLzsaTtQGujH3h2K14m8gbu/QQwlTQEIzv6EVOzzR1PPn6mcjNfdO6N/kqaBZDUir1gMDeZ6xc3iV06DiFJc0yAmWufCY4Qmn8aWpbc4njus5KexVmz4eKXDm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu5eqNmBCF6JcOsRUvKCX/YhUPBqx3+/5jRrA0PS0AQ=;
 b=HsY91AWMgysJ9bDMZ11e+DuDa12TZRNe5x3A1vM4CNwTc25N9IaW+kVdhrDFNYs22uc6dntXLudCi/rguL6a5RMy8v9jJT3vm406nRpg9F5Eu+lhtbC5TvYAoG5SmjoGTu87IRBDnB2P6fuuAtmjRBGqF3um0x7sKf+O5zWwac2H3meWgFgUheCEvWchK9AyZD9bOVZrq3WxgHFuAxXK6uck55eedTAOjKw2RwB2Af6k+CMaCMwRNo3DkRsbOjxzpKEeZr83KSN8uIcbXiitL8IL2KY9uxcvByIjZS9ks09Rc0qPQOvb7sFOTFfj+BKTcdGKVYuPGGRqSbJOyV3m8w==
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Thu, 24 Oct
 2024 16:58:15 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::d9) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 16:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:58:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:57:59 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:57:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 0/8] net: Shift responsibility for FDB notifications to drivers
Date: Thu, 24 Oct 2024 18:57:35 +0200
Message-ID: <cover.1729786087.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b659f3-8cbc-42d3-9ffb-08dcf44d0cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xCO7EHxNhR8QzeyACJP7sfKicPYfnPlbf5lpf31TIgbW6TKbBp3TK0/+xYf9?=
 =?us-ascii?Q?xG31e5QnBbzFZJFsJh2draOdoROiGzgRvYnBrnD+LBT4sUt5GZ6f9owe1CRJ?=
 =?us-ascii?Q?JiUoGSNrO6ZLSEGrJQudyCjonX0pxdOsV+4lNdRF/QVCNZEKa0SRZ687Ui8G?=
 =?us-ascii?Q?Kw+VA0TAEs5RcLJ9biv7TXX+eKg4waYM8Qeef0HIBVAv4V6VWkXPc2rY+11g?=
 =?us-ascii?Q?HpisDfcRlLk083NveY9ag3EQkd2HdsWVLlaAP5iix/VtNGt0PAKxntOFQpFY?=
 =?us-ascii?Q?5cETfF1enLz07EJdjadvpKXPmIkEXmyksVCSsz15X9OPN8gnq2grYMcDKfD/?=
 =?us-ascii?Q?uVN7Q+a6CRlWHbT7inu34XHO7c0Zh5eX/iKZ44qI1gtgIHJ9vprRwqKQWiuL?=
 =?us-ascii?Q?CtpCVg8jkK/pgByWMrQQw9v7ByF9cS4bjnw3LpicaIDLkWZeU6P5a80bDPBU?=
 =?us-ascii?Q?dIzpQPN6jbCiGHr19AhY58ayObyqQqRz3FGSSR86B3VtRQ39tHViQ79j5PNS?=
 =?us-ascii?Q?zneGtSnAxL+0pLF+ZYl7MnDZHmNctGdnV+kRCP/mqWfSyv+FSdbR9Hw7YtRO?=
 =?us-ascii?Q?OfYaukPukzrIDyAzwxuS8ISJs0Sxjv5Xq48j8/CyiE6B0oLGhh49FIFQLi4U?=
 =?us-ascii?Q?dCbrxC1JinlXqOL2vWsoXS5ufRolC3d/LNMP2USgX0p5gRDocNEMcL9QjBqE?=
 =?us-ascii?Q?zzyeG5wMeojxrgdTg4LHHJpRWvN85NoDZ9NGvk+WwuBLoR4QHi5wZuhR0w7d?=
 =?us-ascii?Q?q/kO/zY8OlnIbIUF653caoH51peKh77Wf1vu14pTSBGVMaOAPECu7rfSu8N9?=
 =?us-ascii?Q?Oxq8wTSNb17pJAShJeMYpZrrAiJtv3pffUEjzz4NrW6bsSDtQf6pgYE5KytK?=
 =?us-ascii?Q?ZXO39+zV+3/WwCaCItEvEQ6miE5ZN9p/hBSsvXoP1zRKALwlLe8HlNMDMStu?=
 =?us-ascii?Q?JPp6dTrHDiYX5m7Max1KheRpSRKn+MT9RwzaEN0r9iP2/2m43RPB3Q74YiPZ?=
 =?us-ascii?Q?i74Cda8PgxM8lZahWSJqYgei7U+T1AN6D9zQ1I50K0MMy1tKlwRyjhK1YlEc?=
 =?us-ascii?Q?d9ayCYFCs9IKw9W2jM4xXCx4BimwpXCRwNRtxoLmKOmH6jzVP7aH85/XSVN4?=
 =?us-ascii?Q?OujCh+pdcedmFlWgliVsjL24NVYhUcCl5OsPgkj7WA8rAnH8F7+tQxOxixeD?=
 =?us-ascii?Q?QzN0qCaO6Gp/G/Lj4fNlJ8IX0JLPoYYtRYV32tqA6vOPq/l7r65IoGksaSCb?=
 =?us-ascii?Q?/6yDhTo9oqqtmP0JW11jWikgRoyn61q/5lz6BVgx1BfMikPclOKX3e8L2ptw?=
 =?us-ascii?Q?w+Eq/P25M1+26yDPPAqLm2lN8Z7A9NwCyfuhnf2N3FOUPNo0gtr1tHbcXKpo?=
 =?us-ascii?Q?gzAelRwhRHlcKp9XZeEaWOQ4PqPrfGYWnBp/VtfTkKuZdUAQBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:58:14.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b659f3-8cbc-42d3-9ffb-08dcf44d0cd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

Currently when FDB entries are added to or deleted from a VXLAN netdevice,
the VXLAN driver emits one notification, including the VXLAN-specific
attributes. The core however always sends a notification as well, a generic
one. Thus two notifications are unnecessarily sent for these operations. A
similar situation comes up with bridge driver, which also emits
notifications on its own.

 # ip link add name vx type vxlan id 1000 dstport 4789
 # bridge monitor fdb &
 [1] 1981693
 # bridge fdb add de:ad:be:ef:13:37 dev vx self dst 192.0.2.1
 de:ad:be:ef:13:37 dev vx dst 192.0.2.1 self permanent
 de:ad:be:ef:13:37 dev vx self permanent

In order to prevent this duplicity, shift the responsibility to send the
notification always to the drivers. Only where the default FDB add / del
operations are used does the core emit notifications. If fdb_add and
fdb_del are overridden, the driver should do that instead.

To facilitate upholding this new responsibility, export rtnl_fdb_notify()
for drivers to use.

Besides this approach, we considered just passing a boolean back from the
driver, which would indicate whether the notification was done. But the
approach presented here seems cleaner.

Patches #1 to #3 are concerned with the above.

In the remaining patches, #4 to #8, add a selftest. This takes place across
several patches. Many of the helpers we would like to use for the test are
in forwarding/lib.sh, whereas net/ is a more suitable place for the test,
so the libraries need to be massaged a bit first.

v2:
- Patches #2, #3:
    - Fix qlcnic build

Petr Machata (8):
  net: rtnetlink: Publish rtnl_fdb_notify()
  ndo_fdb_add: Shift responsibility for notifying to drivers
  ndo_fdb_del: Shift responsibility for notifying to drivers
  selftests: net: lib: Move logging from forwarding/lib.sh here
  selftests: net: lib: Move tests_run from forwarding/lib.sh here
  selftests: net: lib: Move checks from forwarding/lib.sh here
  selftests: net: lib: Add kill_process
  selftests: net: fdb_notify: Add a test for FDB notifications

 drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +
 drivers/net/ethernet/mscc/ocelot_net.c        |  16 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  12 +-
 drivers/net/macvlan.c                         |   6 +
 include/linux/netdevice.h                     |   5 +
 include/linux/rtnetlink.h                     |   2 +
 net/core/rtnetlink.c                          |  24 +-
 .../drivers/net/mlxsw/devlink_trap.sh         |   2 +-
 .../net/mlxsw/devlink_trap_l3_drops.sh        |   4 +-
 .../net/mlxsw/devlink_trap_l3_exceptions.sh   |  12 +-
 .../net/mlxsw/devlink_trap_tunnel_ipip.sh     |   4 +-
 .../net/mlxsw/devlink_trap_tunnel_ipip6.sh    |   4 +-
 .../net/mlxsw/devlink_trap_tunnel_vxlan.sh    |   4 +-
 .../mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh   |   4 +-
 .../selftests/drivers/net/mlxsw/tc_sample.sh  |   4 +-
 .../net/netdevsim/fib_notifications.sh        |   6 +-
 tools/testing/selftests/net/Makefile          |   2 +-
 .../selftests/net/drop_monitor_tests.sh       |   2 +-
 tools/testing/selftests/net/fdb_notify.sh     |  95 ++++++++
 tools/testing/selftests/net/fib_tests.sh      |   8 +-
 .../selftests/net/forwarding/devlink_lib.sh   |   2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 199 +---------------
 .../selftests/net/forwarding/tc_police.sh     |   8 +-
 tools/testing/selftests/net/lib.sh            | 223 ++++++++++++++++++
 25 files changed, 411 insertions(+), 246 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

-- 
2.45.0


