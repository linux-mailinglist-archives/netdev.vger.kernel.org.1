Return-Path: <netdev+bounces-109368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FB928290
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50F62876DE
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F18B144D37;
	Fri,  5 Jul 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EzPhWY5n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A1144D24
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163752; cv=fail; b=a2kZDC0Eal8fjOVCE4x+h5/dwLZ0gRgwtHHU2R0+WYRWhSGUZKf9XwhazCJtJBskwWHsS2Xadufrkd5uA7iPDbco43Vu8G1dyuxRjpssGDcikVtoZEAtXqMHCuM4jiiVEGDI3ArV7awPix5tVxAS46LCC74isUXfji54ZD1W+T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163752; c=relaxed/simple;
	bh=AvCqdlCiJXHWyT9b5mhi9d3ljkSK3B9qSsSGUF/1QRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNQl08PpyNCHcODWMbsBHgNaNQbN5zA5Z1hfJPFz8pB1lWkwDx1oYcRkE5tCP2mjx8IZ5v3zQteL/YVpIq9UVKqtMzpe6CJReaIivEGEJs/Q3sTfvc4EtoVc3hHB+/+4UWa7q2Nu+ZL8+WoLl5etmrPihgRLgg51ORSHd0b3C9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EzPhWY5n; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOh2nogq9UpjytY5W3rbRCjohXqm2IvGw30nU+28s5aoKjGdanRiBgHoeQVFCmvwILe+RAeYf3ULv2R3ZDrPDSMezsmGzFlI/WNtixBVeQVZ2i9TmMZzOeWcpFRolaCthP1vc6GgpoQxxL6Bsr7T98vD8FOcJmDz7XMX2WeUYF/S/y/vIRtBZjqiYbwaU6cRPh1eNdSyqtjONd0IFY+zSw1HiAcrdkbyzAVePNnPbIpNcFJBk/mU2tL1VWkKAT/4TY9LM4VYiLThcyCdVY67hAG8+9zkpuwGxnfjPuQCMZLdft0yPwLTZU5MhFkfVH66P+LfICgWlCr2OpNpFxdL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoIPinypRkgaCuUF6f31Slu3AfSCGOy1lXRq3AJaOA0=;
 b=l4j880iJgJiJNKc+euKFP0kjxagb5Tua2KFkvCOUzU5a0V21Lk1MsPHbvCmTpA/YvVJAvRmnw7fmqr+zZ/KjgDOgmbDUWcqIYgFkq05qQOMe/V63QHOnROF4b2/xiWVSpeDPEuX13BrU/UhfehqAHu4RJ8X9QpaKOqLSY9EwFK9sdE7mdgpTCXhRyCXQ0AOkygikzlLEkao/roqK/iQZND+A8iZ3WHHbahp4AJnLARRUDwLd7jVGZJQXFqdSeMqantqGSqhLd4juHjAqn5K02fGLzvnxFCnYgnpvku6Vm9VPKkut/kPJ2Wt993/t66jp9YnzsIipNdc2nDDMC5GdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoIPinypRkgaCuUF6f31Slu3AfSCGOy1lXRq3AJaOA0=;
 b=EzPhWY5n0UOhIoRuS1X6QupGMuSvXl9JkI6BhxqWFaL1SnQJy5EoqvxweHhL6VgIpv3H9ZzQNWw6DeGemRaehU0IaORQGRyO3gd2tYAIJUehWgE/vP/WvG6kEuTAiGi7YD6rrcDTgVWoQFZ4Yrsuva04//Gr5ljC4OvyPZCY8TaHC7f0TLCIDP/woY7P5tdbRdJ6RVryZKKqVCBURyUm+5tj5wnHMkEczqmQUDPDYnTAFORX1Sv3U3Qb4MhtbDMd3oiplpHh0JQM6m4hahU4hH3kmiyRa7xyF7aAcEehMrcgHQzZ7aUuzsxJzCyWhk2AJxNgdfM+8PhgKbctBr1EYQ==
Received: from PH7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::34)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 07:15:48 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::bd) by PH7P222CA0013.outlook.office365.com
 (2603:10b6:510:33a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/10] net/mlx5: Add support for enabling PTM PCI capability
Date: Fri, 5 Jul 2024 10:13:53 +0300
Message-ID: <20240705071357.1331313-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: d39ce388-a419-472c-92b6-08dc9cc24aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M6FKk1gRNphB4O0M/eSx0xKEriN6jXlEKOR1HRq7pBcspIPxlvtc6+n5iIPf?=
 =?us-ascii?Q?X9/7NnN6FKHcy0rZIyforboRWfb2ZQ6X846jmg965ZhsR4QQZP9T3O9jASdm?=
 =?us-ascii?Q?id/lrLguMBvL3ED0mRyw66NyAhdKyWmJaXUgil2I/m0/yUV9Y304vVlFXwr1?=
 =?us-ascii?Q?ewrY0Er7oSOSaUtd5YPnxd7W6B4VYnHnlTYVnp7QfbS4kvMVtRJTkstMV0u1?=
 =?us-ascii?Q?7HPrx9SRl15Gpi3TD9FKOtPMnK6XOU6Jxj2L4Az/TZfZ27JrcPdcE4PXrOi0?=
 =?us-ascii?Q?HUOtYzpl2htKvKsmnBwVl5X8hw6AvU2U1sjHnhR4d6VWidZw7bucicKhFm6m?=
 =?us-ascii?Q?gxXoF+rOHuLwiFoKzEtVX+rPH7RjXKu1ZFSlc92bhCKGF2ask8+NMPDQ5770?=
 =?us-ascii?Q?+FZOAU9+iq7x95V0UgFiGSpIZcKY5g86Rcr+z2q4Rt0la835cecwO2OALuv0?=
 =?us-ascii?Q?OuckAoeAQchNPomkLP7D5xO/BEAw/ac7Xr515qePgUJys4Q1WZ61dhZBR7aH?=
 =?us-ascii?Q?QV+hC6agcGd+OX6jPzUy4LMcUBEJvNYg8sBcx0OxvBWO7BQ/OlNQwYt3XtLu?=
 =?us-ascii?Q?e0pjBbga1EiAPUVd2Uo6XvHOUO239ddHTXbWs0Bih9b4qTtd57e/sLsklW0H?=
 =?us-ascii?Q?H7i8/myDeJn94+VxSmdlzCjb2J8TLXlAklWtS7SXvlrhtY0GTN8qz2jB8uZW?=
 =?us-ascii?Q?1+3g+xCCGakmBvmJPVWsZjIaIclpjyboM7661rj3gLyirervOmfhsK62qWqH?=
 =?us-ascii?Q?x0aCJuroTS31UUNeqMbEfaHbwQnP9VN2SHYe1MNmmT8upf/6Xc66djZNBUqv?=
 =?us-ascii?Q?thQuDpdunqTvyycoVuVwYCAYXbMzYJZWw/DnOA38r9OO7QAWjeSMHp81pTSz?=
 =?us-ascii?Q?sGnET4ND735hV3eRuK4EyMFxw4JwgQjshcnpHH9gzQ/1a7IuABfdDhVekRjG?=
 =?us-ascii?Q?+PY7NVxz73uLi5AUIaNwdNNfLFuf55bbIm0rXYGJWPv2jfgSM7FdI2eyIY6c?=
 =?us-ascii?Q?lKgwDBQtkIj6VPqCHkzF08KwH0dYd9NA8sJcJhXp/dbDWGFf+8lpTWoVY6Nk?=
 =?us-ascii?Q?i4sdm8jKg8frqIzbkuoBHfaoYqWuUXGBPM+d/6aKLd+PmrNLJnKiqzk2Kngp?=
 =?us-ascii?Q?dFG+zi7EdxHWbo6SLfHosaiLCWS0PWH3gKt/5RazgwswkXwftkNNhrQQ7gFm?=
 =?us-ascii?Q?bVeCb9OFfU1CjvXwgu19DkA0mC0vZwcV4rLO82iEMJHIUl9lahUgdieFwLJG?=
 =?us-ascii?Q?CdJChmbz1efs425NS6r4aJ7H3zGHAmp1GBHx9W7vpJX/DQ+xN9j1do/YGKbO?=
 =?us-ascii?Q?SDnjSd2r5C2wPtBhLi76L4jAOpGoAgTSPsR6F+wP03rT74JlnZei/KP4FrQr?=
 =?us-ascii?Q?haKgYnHaahL+kgPWJWl8Bvknvs0mL1ESJCU45dVqyVwUei0VskHhps91u6F/?=
 =?us-ascii?Q?UWSHhVeApkiOQbR/eh0BW99EAyOAaHY9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:47.3567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ce388-a419-472c-92b6-08dc9cc24aee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634

From: Carolina Jubran <cjubran@nvidia.com>

Since the kernel doesn't support enabling Precision Time Measurement
for an endpoint device, enable the PTM PCI capability in the driver.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 459a836a5d9c..31a43e0ee57f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -923,6 +923,11 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	}
 
 	mlx5_pci_vsc_init(dev);
+
+	err = pci_enable_ptm(pdev, NULL);
+	if (err)
+		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+
 	return 0;
 
 err_clr_master:
@@ -939,6 +944,7 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 	 * before removing the pci bars
 	 */
 	mlx5_drain_health_wq(dev);
+	pci_disable_ptm(dev->pdev);
 	iounmap(dev->iseg);
 	release_bar(dev->pdev);
 	mlx5_pci_disable_device(dev);
-- 
2.44.0


