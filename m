Return-Path: <netdev+bounces-166818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999ECA37687
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884533AFBF1
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7419DFA2;
	Sun, 16 Feb 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ix26ZGZp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97931154C05;
	Sun, 16 Feb 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730327; cv=fail; b=hmUCB8GTzcUrdR4uZWLIytaseVV70HH/tp/Rn3KPLepNFGIdH21S0Z0TQ7d5iYpNBrVnT+EdKAzmD8r+nl2gAFvzhaOoo3+Ou351XOjAdbQ/gXEbcv/ma2etBVj5f4hhXzrfmOdRRnJe+JxMFAAsbNsGbPNcNOitkLPda5DjZAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730327; c=relaxed/simple;
	bh=1AwDE9keZRzcDbLzmvNLc0k9aPS+U76DQGlx5dIFxfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qg+DH4h8g0rvePwdZ11EJ24S94OKf1QDf3NPOavCYa82lvgn04wKpxCNz0aS8os7o1elHligserPsQonh4dH/QNC9jas7UZR0+qeU1p3F7e0ktFe9xXM6xr9V4B/wO/Sbhs2GUHLRgAZ3TrXgfuaK/yxors3vcY+7LucBLXu/PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ix26ZGZp; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST9010/ruwT5onZPSRVA32uj6tEtCreJ4v6QwJ+wWRjF1lX8AiHe4fXWgy4wyrDttt7t84BW346aEooNtHE3uobv/hcmqLK/sqbafFRIaB6YhStxbtzdzcPjzdN57d+oekXi1f+/IrVzl9QnOn8pAQCICW5E2V+GXAbA+idyKzsniqxnwf5hGqQCWlEA3zQ45yRSNpVot7OqsDyRhvXcKVHqs4qW5GDWnW3GaHwKzeKaKVsCwSVUhSefcL5pJHeJS7ivZG1KinjnDpBEYvQGTo0nW22fUekG9MfsVTj8RtP4xH25s8y3rzRzrLpSqnHtiD5yHblIVKzh/IPN2wthEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bjvLjtpubhcxkFawv5eUv9mFul1EUxUT1+jZ0iZv9E=;
 b=yBGNJn/001qNm+W+YuVuKUjH9/KNl5/F79Rkjtm671Wf/WmJyBN5CBahtD+FrSBtRFhicH08gTJURkXJCUD9eM25mJVhcvCbKBjTgWkG2ddRLmmauXHEYro3vzkg8CBtuGGFAKDKxOqDSfVUEMdNWriTvRLSsmbOINQE4VnwIVC+yf65xQB2yUisqRTVKyIPkFRVse2hxD7VWJGXhakm62UzISsTTHbJaXG6pa07wT1m4Ze6ELnD9btyiowT3PbfDAcUWA/36EWnhsyhv2AB0z6vFswTyWMxZrsF45bkRZ9D6BuxB1cr7FvMxE3hEdfvdtN4ZZJwj+ivfzS0UMY5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bjvLjtpubhcxkFawv5eUv9mFul1EUxUT1+jZ0iZv9E=;
 b=Ix26ZGZpKwJ/gu9otoYlyd5EJW0M2FrToPaVlcIiR41vMnLad4f7pk1WlPKMsxfjs8eIPSAB3vM6/qA0DIe9GJAoBpq6L1U1wqVfHupi1VblJX59K018RtEVHbKB6FGNzCcHjC83TJUao8VNSGFw6q/LB3Qd35ul/AifU6A+WB/E07dhz9K7YS3BOcjbY8DPWCPJP4CL08fonxk7RPxn5ydgyniG09CQYag/FWFRjrqCQbbq2PnVEYbyL6R8bEWVzn/ZDD9fIyqBZUv6WXY753FF5pyI9rCbuw4wriZRAEJzgQH2XzMHw9dBrZuo2LzqAjX+pE/Tu2yat0Xhyezz2Q==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 18:25:17 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::a7) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Sun,
 16 Feb 2025 18:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 18:25:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 10:25:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 10:25:02 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 16
 Feb 2025 10:24:59 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v3 0/5] Symmetric OR-XOR RSS hash
Date: Sun, 16 Feb 2025 20:24:48 +0200
Message-ID: <20250216182453.226325-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: c59a4400-2e88-4a9c-1f15-08dd4eb7413c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4LTo0Mv9tZ+f+9DXdvcFvfZ2cRBv0q0V0vdseoshVLH9yvT4zwHHjgjoATr?=
 =?us-ascii?Q?zHn0q1wKVJ3maQBwHpF1+ToCFsK4EQ9vgiMD1gyxIL85iw7pg4S+hzDOhNlA?=
 =?us-ascii?Q?7IsX9xaFpCr6EifbI3QSPZ4I6mYkFGWpjQMM4+2RgrFOL3o4HXe9FhffgY54?=
 =?us-ascii?Q?ojq4gQx3A63C2dYsvYLJ9VoqIjte86ctRD7ib60tvngwpBjta84LEIqGR2Nr?=
 =?us-ascii?Q?xzwaA0aIuDXhUUOqxtl7OorjZEYMbu2M5UjRb5S8Nz9U5yeNtHscXGAw3fVq?=
 =?us-ascii?Q?E8hbONbtWanbW+LjSoR17wQt5fEDULRvrL6VFADlLtReojjnbKJGlU3ra4Sr?=
 =?us-ascii?Q?MM3mQAB+GICPTgicTbA1bYpQ2sfdBBcunJQIH65tGbtev/mE1zlieDVs6/Lq?=
 =?us-ascii?Q?aEOFSNy9aMZeA2FAEp1wk898G/MiaBXMyP85+XzxSdmHHO0UijrYz2SgWMxg?=
 =?us-ascii?Q?BUGiRZNbqRCd8zgzoeIpEbY9kyEFDBPdJ5Eq+S8zby1McuaCiRKIbg6IlNOn?=
 =?us-ascii?Q?IBWH7tO4y/PcAP7VcnQ/kcbK07nGSLkoEq0zVNss1BPHMri9RSSf7LC8fFVv?=
 =?us-ascii?Q?a0nem5lwYpk2DhBB1Xg6CQys6S7IoQ6S769o6nsZybSr3HYkSZzb/VMLEkfT?=
 =?us-ascii?Q?+qU321eY7z1cr9x1mjpftFxQsGveTtuJXpLtTr/SbQ7gzAV3IpKt159c+G/Y?=
 =?us-ascii?Q?IM2tDHHy9LuoxHCfywYA1bMSvO5pxffxUv80F5bTR8UH17pWoBvS2zqD0L2P?=
 =?us-ascii?Q?GfgExqHpwAWt+Gu6Vif91F4gdit7gEN0K4mxnAWscHc6hpw74GwvVPzQiI+t?=
 =?us-ascii?Q?4es9I2KfVIf1b45m97GRhNRGBXWAL2hie/EmmgwsXwrxg/G8rp8TfgMXTp8V?=
 =?us-ascii?Q?B3T5ydvitSANx32mEqoXzD8nknl/kmn9oxRPDqGqJtz7AYjDKlCos22XmjLL?=
 =?us-ascii?Q?byn2J7DYQIu/maPncmMhObXOc/dTLjgymwdS52D3k2ycC5yJ/DE6fFzuzp2T?=
 =?us-ascii?Q?2CGJ5ZU9oxroISsuwrvhNUSpYT2YJlha6pfG4OBfVFcfqD73zfBdXYO+U9aP?=
 =?us-ascii?Q?u7GENNVLWjE2u/DzD8/xwr+a19N/DRMtYPPlB88m/y20xO4kt4BSHnAxrfjy?=
 =?us-ascii?Q?gdXKi3JuP5DXjfMy2VbA2fbEZwkm9a+WCmPIZy+OjdAjO1qz12gRK58pg4vW?=
 =?us-ascii?Q?Kb8gxR7n9eQ/hdtJctc52qvUzKeBMp8DgEEkPr03E54kJ9VE1pVsU8Ne0G9B?=
 =?us-ascii?Q?GkFAAJPryx5pTGyUrLYOCeoGMwH7NpmYtSi3ZFxzckRS2m7k6ETrg57Jxulz?=
 =?us-ascii?Q?+BZZmXPYjP7mmDZTzm9R7CJpSf2VNMbIaYF4z0vx6daTQAE80vV6FW1v+OfY?=
 =?us-ascii?Q?RTgWmPNmTGtlPwKEe/CIRKVq27EYyml/JErOOLzdRa1OvaIY7biaDI+g4TQ1?=
 =?us-ascii?Q?u7nJZDMYetjslQ0zXlXrXTiofSn8DCFXhxijNVvMkkoTj8D19PpInlqGexh7?=
 =?us-ascii?Q?qoczYnBfVeYpBFc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 18:25:13.4888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59a4400-2e88-4a9c-1f15-08dd4eb7413c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335

Add support for a new type of input_xfrm: Symmetric OR-XOR.
Symmetric OR-XOR performs hash as follows:
(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Configuration is done through ethtool -x/X command.
For mlx5, the default is already symmetric hash, this patch now exposes
this to userspace and allows enabling/disabling of the feature.

Changelog -
v2->v3: https://lore.kernel.org/netdev/20250205135341.542720-1-gal@nvidia.com/
* Reorder fields in ethtool_ops (Jakub)
* Add a selftest (Jakub)

v1->v2: https://lore.kernel.org/all/20250203150039.519301-1-gal@nvidia.com/
* Fix wording in comments (Edward)

Thanks,
Gal

Gal Pressman (5):
  ethtool: Symmetric OR-XOR RSS hash
  net/mlx5e: Symmetric OR-XOR RSS hash control
  selftests: drv-net: Make rand_port() get a port more reliably
  selftests: drv-net: Introduce a function that checks whether a port is
    available on remote host
  selftests: drv-net-hw: Add a test for symmetric RSS hash

 Documentation/networking/ethtool-netlink.rst  |  2 +-
 Documentation/networking/scaling.rst          | 14 +++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 13 +++-
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 11 +--
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 17 +++-
 include/linux/ethtool.h                       |  5 +-
 include/uapi/linux/ethtool.h                  |  4 +
 net/ethtool/ioctl.c                           |  8 +-
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../drivers/net/hw/rss_input_xfrm.py          | 77 +++++++++++++++++++
 .../selftests/drivers/net/lib/py/load.py      |  7 +-
 tools/testing/selftests/net/lib/py/utils.py   | 22 +++---
 18 files changed, 155 insertions(+), 42 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

-- 
2.40.1


