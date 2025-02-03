Return-Path: <netdev+bounces-162269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1AA265C1
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28773162A0D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0796210F42;
	Mon,  3 Feb 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gXKAmoRI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4801F4275
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618611; cv=fail; b=bpf7zWfWl8Ih02OEiHRUMV5tlSbjgUkXWtuJ+vT3FJoMNTZocGcLZK/ySPxlueUxQ3jM5JeR4ulZSfR+RuUqMozonni7aOCJhU1+WsJLcQlgfwprgoaXsXs0us2Q3O80JcoEqxU/z7Q9mI59WyL+7iTG8s0ufFsjxmKsAdfJ5qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618611; c=relaxed/simple;
	bh=ZPO5bztxd3BhUt62xpe4mDWcfoXNUyCVakfTG6N3cow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o2OAW01yujw/7E3eQD/zH5fUqanfpylUGphTQaNoYpb5WOF3VS6KfLeASmLbcMBfCCdmQZfdR6YN118lNGYq2tBbpksuONk/gBEEze8m3dqrtvIYZ4FuugRmm/+fxGXg1et0DY/jATobqNt/gZq86FJNGqV2RxcKLj51K9PvWjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gXKAmoRI; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXBShtO/LtbmEXHBaAH3g0xadSoJY3cKrwoE929MN8hqlm7VdPkyisNrG5Qfi4tzypBlcN60Yg551gXzCQsCHIYYWLKEK30nRMnN5uNivZ7+u+tNH9LW77uMyENWqycnOzNDYQs1iNWh6uO2AwnWRcVaZCT/Rc92LAS06n2nCejy4Q1ZsHo1rroLvQZwATQBh1kmNGLaqpSC+G9yN2Q6eioQQTW1e1SX5BWfJKlttSXUn+WIliaRvBXt7Ax8Ior+bEe4FRyyBffaMUkJCbfJCo7V58lCjpaTeetXNCqnj+yxYbC+ZTxdW/c/OCB0iejI4HWZondZc3dqubW3K4LmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0QzIqnD2HPbdzC3IECb4TDmJwuKO3kU4iZqlzBQfs4=;
 b=LdpFBCOMQuosxEnQ8EYbdVRLux4H3gk2sbLXK6efArpPp9hRc7eOGiSEOeBVruh3iw4wZ7E3F5SPHdqEWBjea2aVaiwJY/eapF2d7LZTw/r0+rBzywYzhOlU7/zs+a9MRV7WMiC3Rstahtl0hhTqah9cGc9yhk/Gp8bz7wnLiWIdfOQG1DHJntGlC8jAFKH69dYCtwsm4MgvCsKwsQiJ7GZ7XjgafasHfwRfmKU+dpFoPZtrbxVXNbuUh6HK3eJejiSlCs7abIlBorSYpdrO91QwGtdHDI6KfYXkELEQv4cOVzxVKLjJoQkxFLXZmgUCHRSxWFfZ4fiwj6EDOkJ+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0QzIqnD2HPbdzC3IECb4TDmJwuKO3kU4iZqlzBQfs4=;
 b=gXKAmoRI7GEZxiRBuQu1C+kaluE/bAZDSGjn6MFgPPuk2ziBr673oV4V0KKQeiXDZvvc8c3xTlnU6KRVPpatiDV4xNlcFeXbzUm95Iq/qTn74fhWQqiC4mzOJN+YpbmHisIGbXNrUPWLSl0cJuqyp67vJoY1OFzIH9l5T0BYZMwb/AMvStHLrLJd/tWST9PxaMdxYnrTu9iuTiEtTUjWwGQa+fGcYsm+TAegE+u/hyd4GQ1f9gEwBTxX4Wxucqwvrwsc8VSTR04xSKyY+kt8KMDlur3oHU/XU74CpcPkPt7b/MQKvQPHEAyOkQekhPS8qQymRyrmlC+WBc1ZwpRvAw==
Received: from SA1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:2ce::16)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:36:23 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::71) by SA1PR04CA0010.outlook.office365.com
 (2603:10b6:806:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 00/15] Support one PTP device per hardware clock
Date: Mon, 3 Feb 2025 23:35:01 +0200
Message-ID: <20250203213516.227902-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: cda8d495-3e09-422d-7012-08dd449ace2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFF28etWnj5w+bLh5yFvsbykUoT+s9RDLp3GhHEVoybbgaB3RFCnB6FwJoCb?=
 =?us-ascii?Q?ycXFcVgwlDMUuldPOJEqnccywXvqK+eW53RxMRXQ1MQYEFgUMyjhU/j4MtCc?=
 =?us-ascii?Q?x6KWzHWF6dCTxwuZoDFg+6vlc9eoDRIn6LL1plqfbyogfO3nWtMkSspXWp4k?=
 =?us-ascii?Q?5BJ/VXU+SQDDdBlc2LxiQruG6IREqvOtTyZYOfGnuYsZNEgWiPkWgmbLHJtT?=
 =?us-ascii?Q?Xcvc+WAyMSLrE7+fDKWM8u4fgfklUUZXZ9O6GkVH6QcKjQ4FnVG7d+2YosJt?=
 =?us-ascii?Q?xf76g3ZkUNQudD8jmSAhx31+EvwPQv3zEY3diwpVJeZwMy/OCveWR0QOY5nU?=
 =?us-ascii?Q?eaAbV0k2qam1HBneLnm1H26zd2lnGLD+5cMWS1E4ZK1rtWYnsIAShybx+miK?=
 =?us-ascii?Q?8LaHOFSV1xRED6cooUr1UzGAzopQ9obFzC7ctnN3YJfYTS/RRYD5lsHK65w5?=
 =?us-ascii?Q?o8GX4tM7YAg+rkSJ6d8Xw2NrZeZJ3H77K2qKcOQTItxZZGrG6qR26FVxmCaK?=
 =?us-ascii?Q?uD57/4CsrNlHMU9PY5wD8LQ1Ijm5xv1GSsDiFZaOaw3BAPf65sfoJX0nXH42?=
 =?us-ascii?Q?hOfKmPaOrwQjwBhW3HiMZScZYJk9DvG9Y6ylidW/3Xcn6zYhTW831dYeqjRj?=
 =?us-ascii?Q?yDu2yO3lZz6Rnv4ClnZZI1/bRhlLzuCgTzkggNIVXyvve2yir2L26FNUOYKj?=
 =?us-ascii?Q?Emxlk6l45LDE7fU3APX/HLI8qFcPoM4V6V7D1rNKzDQQ/AZ6IUMvSsNpiVkA?=
 =?us-ascii?Q?6VsJJP+ICsucW0PQIuCaiY07KkOc7FrcdIMa3jwa1xCB1Bp7SBU8QYY/FIhM?=
 =?us-ascii?Q?gdoRO5mMWhRDjz0748V9TuveKIlrGwPHqnDZERf0uEXkC+MUklM3dkMqdrq5?=
 =?us-ascii?Q?XljTmjehNiVaPP68xR8YQ95PyfEDpBbp90WqgMItwxo1u8Cta3pcvLrKv9qs?=
 =?us-ascii?Q?hOHENsC+QkUxZ4eGTp+DUo1RqTI3YfLXDta1mBG1uEmptze2TtkRls9v+0Z+?=
 =?us-ascii?Q?A2f7PzOGXux6EM7FZcZcns3SpfZ4FHqxJX/hHrh5n4XEDHjr/ryHZDQYQj6E?=
 =?us-ascii?Q?SA1odxo6ifZC43KhvCbZzuKY7y3OsPJrGTOzf+JDn1Vt+ggvBeUyRw3kfhtl?=
 =?us-ascii?Q?5gObZcvZRiqDHqcGeW+HbzP/83Bvl6yUsbGznzO9pNuS2QfxJuLYbjrisWZy?=
 =?us-ascii?Q?SXYGxP2+CL33NqzKPTBMPRHc2rVsmxbz37EDNtv10opbaC+vqAprrAIinEyy?=
 =?us-ascii?Q?IZl+LtnkiZ2FdUcXzZrCTmvdkFJ/DxuLugvwGVwBIdshClIdYQHw7yl4sAAn?=
 =?us-ascii?Q?ueXOnW7a7adH9vHJajIPptJhfQSIflLCtGU854v8Sm8UF1fMCto7Rw52RvAv?=
 =?us-ascii?Q?KTU/h3Hrb2VVziXtR3tPS+mOrwlsNYiqifCEs8rSXMgQXIa/r8gw6xZBrbIE?=
 =?us-ascii?Q?ETphkTiAjzZfzcDkWqvi3iU/s/23R1hCDxB40Ez+fmO4tY1YoKbtZYM/tjcY?=
 =?us-ascii?Q?Wa/T7ZK/jbcGIO4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:22.9768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda8d495-3e09-422d-7012-08dd449ace2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225

Hi,

This series contains two features from Jianbo, followed by simple
cleanups.

Patches 1-9 by Jianbo add support for one PTP device per hardware clock,
described below [1].

Patches 10-12 by Jianbo add support for 200Gbps per-lane link modes in
kernel and mlx5 driver.

Patches 13-15 are simple cleanups by Gal and Carolina.

Regards,
Tariq

[1]
PHC (PTP hardware clock) is normally shared by multiple functions
(PF/VF/SF). mlx5 driver currently creates a separate PTP device for each
network interface that shares one PHC.

PHC can be configured to work as free running mode or real time mode.
In this series, only one PTP device is created for the shared PHC when
it is running in real time mode.

To support this feature,
* Firmware needs to support clock identity. When functions share a
  PHC, the clock identities they query are same.
* Driver dynamically allocates mlx5_clock to represent a PHC.
* New devcom component is added for hardware clock. Functions are
  grouped by the identity, and one mlx5_clock is allocated and shared
  by the functions with the same identity.
* When PTP device accesses PHC by its callbacks, the first function
  in the clock devcom list is selected to send commands to firmware.
* PPS IN event is armed on one function. It should be re-armed on
  the other one when current is unloaded.


Carolina Jubran (1):
  net/mlx5e: Avoid WARN_ON when configuring MQPRIO with HTB offload
    enabled

Gal Pressman (2):
  net/mlx5: Remove stray semicolon in LAG port selection table creation
  net/mlx5e: Remove unused mlx5e_tc_flow_action struct

Jianbo Liu (12):
  net/mlx5: Add helper functions for PTP callbacks
  net/mlx5: Change parameters for PTP internal functions
  net/mlx5: Add init and destruction functions for a single HW clock
  net/mlx5: Add API to get mlx5_core_dev from mlx5_clock
  net/mlx5: Change clock in mlx5_core_dev to mlx5_clock pointer
  net/mlx5: Add devcom component for the clock shared by functions
  net/mlx5: Move PPS notifier and out_work to clock_state
  net/mlx5: Support one PTP device per hardware clock
  net/mlx5: Generate PPS IN event on new function for shared clock
  ethtool: Add support for 200Gbps per lane link modes
  net/mlx5: Add support for 200Gbps per lane link modes
  net/mlx5e: Support FEC settings for 200G per lane link modes

 .../net/ethernet/mellanox/mlx5/core/en/port.c |  64 +-
 .../net/ethernet/mellanox/mlx5/core/en/port.h |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |   4 +-
 .../mellanox/mlx5/core/en/tc/act/act.h        |   5 -
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   4 +-
 .../mellanox/mlx5/core/en/xsk/setup.c         |   2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  22 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  11 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |   2 +-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 582 ++++++++++++++----
 .../ethernet/mellanox/mlx5/core/lib/clock.h   |  39 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |  15 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    |   3 +
 drivers/net/phy/phy-core.c                    |  20 +-
 include/linux/mlx5/driver.h                   |  33 +-
 include/linux/mlx5/port.h                     |   3 +
 include/uapi/linux/ethtool.h                  |  18 +
 net/ethtool/common.c                          |  42 ++
 20 files changed, 701 insertions(+), 172 deletions(-)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.45.0


