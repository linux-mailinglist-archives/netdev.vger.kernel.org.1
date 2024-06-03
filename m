Return-Path: <netdev+bounces-100353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298988DAF19
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F06A1F23759
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC913B59C;
	Mon,  3 Jun 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLNgcVTD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3645028C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449811; cv=fail; b=W8XDqS7eDxToixLA7qHCNScUzjhWfVOWrVidwgAimNNPyuQYy1IbfCnFCE8UZcuhTkXnBa+Jzk9Zwd6yEyTu2CrnWew+5Wo8WY78AVS/kBqkg0QVqon6Auiex7U9bbg/aX11E5JM2h4k4E55TDt5MoQHoFRrRxnG0RUsWewVFpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449811; c=relaxed/simple;
	bh=DBjpFUkNHVYcwMZ0J/AC35897cStKP1IJfHC+xx1Lb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3ynRL+ObSBxzdFoxCdjBSp8w5/AeWFCIKSCHyiI04rVeRIq/YtCHP7dXYgpeyNwtg6BdwXz9wKcIPROBBEdv8JCiTSq30Q0sYu/upblG1eHOfQMyBe2i35Zp+2hsb0aTrZUjoarQ5Xqgkcy4GNdqARYcujw4iEiRCVQEsowULU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BLNgcVTD; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asRvX+gdC4rQjb8WWf7dEyP+BwfDFLvzFWWYSr15FTi2qJ2hPufEUdOIL/bYROS1OBMEWKptLrqXpQlogBfdjkScTYisf1cn7M0JSVMtIb0PTURR7Sd2mFRvhJYZqIki9zkYf25zBoPKthZT/xJkSdfNhX6P6Bip7nNq7u+2qS3kRikc7fDjScuIlAuOA0Oy0MPI/O5IF8iIcn4Aao8/3QXyLQWiyTdGtiqLEmQeBfmbbTxOmT4UgFxv3RbI3qPBbJLEaknpEOiuIC/gcRBFqiPNK1k/0zyIBtMMxf/uINEhOv7W+h+rI/c+64Fk9XFq5SjtGaF95/qm6MtRYc1mpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUe7ctXuD8fo4n9j3PMl9mEgRayeYaK6QnSbshQRmuc=;
 b=HBEvMmz46gaeGv02G8IMP2+YNOh2U/EMLybJ/VXChTkSnJypzVJE5SB+aJ+au1Z8Xyp91iJbXRA0b8nmWojsWA8Ph/+E4+2PIoW+XEQ8XWEqaJDL77FrdFpJSXWl9zxVju37HkZnT6+Ox561lYGp37KEHWl5LxKsyCEQ9jK14ID7safaearVfH1g97p9VgIo1G8CV2ETYGU4w3L2sDMAY+oNO/AoKOEV2pgq+lSqiU7VEFv83xyHO9DhnEJ30jZ69CHzg5FdyBICVlTEEG9DqqWNKeVrNnkppwQiuc8whka7zgiPMK0KQeG5qG8RnIZ4armXYofxX+m5SYYkbV60Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUe7ctXuD8fo4n9j3PMl9mEgRayeYaK6QnSbshQRmuc=;
 b=BLNgcVTDa+ynYfMTZYbMgTAovhn3mJRvekWHQUOCmM3ImHnmjqJ9qWQ6n7zEQLs3O/gpbTE1fTlHMcNTlFTSC1Zf/Vx7LNifaL72T6TU/vRf/o/mzFej7ZbMCea74eApWx7+L+i26ghhhw29vn13JG5PARjvOT/KtbODQKJ/KHpPB/VFVukbe+jRk/armHSg5CdUDkUv4NL6BBjia4JV9HxC0v85b1kCTwGNvtYKQqQ1S23+OSknCoLbVYQcrlXtpUuaebx2ojRxUsNVcPwNC/oK+g6aRBd97COaI+Ndwnh+4hMts+C1pKf13fdA70N09squcFbCr2xvt3iZdfRk6Q==
Received: from BYAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:a02:a8::38)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 3 Jun
 2024 21:23:27 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::bf) by BYAPR03CA0025.outlook.office365.com
 (2603:10b6:a02:a8::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/14] net/mlx5e: SHAMPO, Enable HW GRO once more
Date: Tue, 4 Jun 2024 00:22:05 +0300
Message-ID: <20240603212219.1037656-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d50156-1bd0-4f8d-aadc-08dc841367f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YNnJ63B/7R71VjM/tLIHwwjWzzGxd93Iye8P8Yq0VuRlEbwc79EJdyfcLdFq?=
 =?us-ascii?Q?lQ3TOw3QgXABjbYxEITB6I1MCCEzD3+Ef32itPJOkPwM2veEPwdXDKzhJyKU?=
 =?us-ascii?Q?p0WaMy1LaA4F3A5+lRMNwzsn/guMZvhoxm3DGmp8uRsQypdXMnMQKE+WHVUZ?=
 =?us-ascii?Q?vXiqO9UxzVnSXR5Cq+BRQoGh2yelcWm4nFBr9OgKbOQ0yBBg4uTtaVyBtoYD?=
 =?us-ascii?Q?vZ3EOoPIG3bysExJJpNzFvZTFJ92tSTHD4rbxXPRQzWMqFCt7oc5TSUMSt4M?=
 =?us-ascii?Q?Kzk3+A00RfomsWpwkJUHwK003COTvy2jMcXrBDyw4kwH0WvqAWa7s8VS3HeX?=
 =?us-ascii?Q?Rr+jPxfxxbbJhYk9rpSNWsDp09YpImGCKH53Cj8b/cgCnDYONHYNsPz5l3SV?=
 =?us-ascii?Q?3S/m1cyAf0VZipdQQy0CmKO5WJaI7o/FDOEboew42eIobiUJFCoefwuuXBg9?=
 =?us-ascii?Q?3a51UwOW1qGm2quilzqgqCh5KjvU14lMDFbl7/pZ9CR/dMHk6M5c9v45N2hE?=
 =?us-ascii?Q?fRIbiDqVxJpHXUI9tmIQvZYzrqIvwR0CK7Ckgyp/OYjTiG1nZxFg4jY5MVAn?=
 =?us-ascii?Q?EpNISpAGdzx6UHXmwTKc+TCM1+ONM0OdlPdgCyEqvLr7Z9gSW+qhKcPtUTWL?=
 =?us-ascii?Q?MekrEAv6C8HPMh3dnqFdm5xqiDJ2vZDMLc1+Ril+s/wtFCjVy2aS9/tIaX8r?=
 =?us-ascii?Q?cSTv1P7bFrmw1x3O9ceTu9JYlPu80X1DhBk7KmCRH6BwbF+dAIc3/stQwXRQ?=
 =?us-ascii?Q?qaVCMaPJMCFZnj06+tm8N6N9swjMaScdTacdJLf86jiHLuYrzb1UBmfxd7nB?=
 =?us-ascii?Q?OxDWYE9/j51qnPYbmfEh+8NvxvkDsOiBcJYwUBebSUmH3qsDCdXWd8aeTljK?=
 =?us-ascii?Q?Q39chi7oy4tLbM0MNVGDX0vVXT9op0S4iiJ8wQH5y6/c4m3+hN1kRwb87FBk?=
 =?us-ascii?Q?CmUfzAC0JbCiJNEoU2Z8cZpJDckecfUKt3/OWLi38J6QmILoaZQALgzJVf5K?=
 =?us-ascii?Q?abqu6jqk3E/j7ImAyTMM833/x08yVoAAhCizIYcRy7Fz9LJQPGO3LBFy04U5?=
 =?us-ascii?Q?plbI/3ZaSu8b97uvMMTv8wt0lBFG9GCfjYQQk7fXWi1TOK6fxMJDRYExCctX?=
 =?us-ascii?Q?zn8h99mq2hj8y4Nqd0CWGseRJ/T3ZBbbJVH1K4u2q6SnH74PD2NJjzgLWr3X?=
 =?us-ascii?Q?AcH/t429I5Y55wN9jHeM/sM4VCu4NxX9/KH1ycQ+1Z/u89/WXmPM2NCLPxlB?=
 =?us-ascii?Q?EpMzrenJPhsKHClLU7Sn/KpfqnulXIZ8m3sPRQiGoko63kRz9O9rdjMLS7UM?=
 =?us-ascii?Q?77He2ScvH0oUHfc9wukYuMMTySXa49MWZ6Se4YgW6MPB2r7eRFExs5aWmLdL?=
 =?us-ascii?Q?C4d+tqg3V22ZDADq3ab+wpD/q8Lt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:26.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d50156-1bd0-4f8d-aadc-08dc841367f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

This series enables hardware GRO for ConnectX-7 and newer NICs.
SHAMPO stands for Split Header And Merge Payload Offload.

The first part of the series contains important fixes and improvements.

The second part reworks the HW GRO counters.

Lastly, HW GRO is perf optimized and enabled.

Here are the bandwidth numbers for a simple iperf3 test over a single rq
where the application and irq are pinned to the same CPU:

+---------+--------+--------+-----------+-------------+
| streams | SW GRO | HW GRO | Unit      | Improvement |
+---------+--------+--------+-----------+-------------+
| 1       | 36     | 57     | Gbits/sec |    1.6 x    |
| 4       | 34     | 50     | Gbits/sec |    1.5 x    |
| 8       | 31     | 43     | Gbits/sec |    1.4 x    |
+---------+--------+--------+-----------+-------------+

Benchmark details:
VM based setup
CPU: Intel(R) Xeon(R) Platinum 8380 CPU, 24 cores
NIC: ConnectX-7 100GbE
iperf3 and irq running on same CPU over a single receive queue

Series generated against:
commit 83042ce9b7c3 ("Merge branch 'Felix-DSA-probing-cleanup'")

Thanks,
Tariq.

V2:
- Dropped the patch that adds no-split counters, we plan to add in the future
  with detailed documentation.

Dragos Tatulea (9):
  net/mlx5e: SHAMPO, Fix incorrect page release
  net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
  net/mlx5e: SHAMPO, Fix FCS config when HW GRO on
  net/mlx5e: SHAMPO, Disable gso_size for non GRO packets
  net/mlx5e: SHAMPO, Simplify header page release in teardown
  net/mlx5e: SHAMPO, Specialize mlx5e_fill_skb_data()
  net/mlx5e: SHAMPO, Make GRO counters more precise
  net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
  net/mlx5e: SHAMPO, Coalesce skb fragments to page size

Tariq Toukan (2):
  net/mlx5e: SHAMPO, Use net_prefetch API
  net/mlx5e: SHAMPO, Add header-only ethtool counters for header data
    split

Yoray Zack (3):
  net/mlx5e: SHAMPO, Skipping on duplicate flush of the same SHAMPO SKB
  net/mlx5e: SHAMPO, Use KSMs instead of KLMs
  net/mlx5e: SHAMPO, Re-enable HW-GRO

 .../ethernet/mellanox/mlx5/counters.rst       |  24 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  22 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  12 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  19 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  71 ++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 202 ++++++++----------
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   7 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   6 +-
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/mlx5_ifc.h                 |  16 +-
 10 files changed, 202 insertions(+), 178 deletions(-)

-- 
2.44.0


