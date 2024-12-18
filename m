Return-Path: <netdev+bounces-153031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A09F69B8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F6218837AD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021A1F2C4A;
	Wed, 18 Dec 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QU/0/Zft"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574F1F239E
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534690; cv=fail; b=eMiMe1v0lTAmIrzHdCiEjpsXjLuGbKEAvQceVCJCLN3q0Zrhc62M3G5OU6ZWIs+r6Jb1IXmTWmkByjKf091oKDSFXZNTlGH2K1UCnCgYJh0a88BpiPzMCEkcXwL1X30soLCxyQbeIK4pYU+8vDF+9vX77rR5kXCw9nnEnNo5Pg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534690; c=relaxed/simple;
	bh=6WQCYKvOWuBayD9weVhw3QcE+4/Gj+mhpLh7b5bhoNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qejZb2ZrYM+i6GZ+nFyiv3HaGDTbRN5vzCGGfmVCsLlSXBgsmZ5ZW7vctuiKHruY9DI9IJz8IziaaewDZ7tUbBuu17l171NNOTwTzPNUZUlgaa47tG+8fjpS333c+2j9hQo8h9bjN/zYNfvheqKj2rBXnPUuvhuqU9HnS/rLrSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QU/0/Zft; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llymjJxjeucs24eqesHFP4At9hR7rrG2aa71Q0I/pBN8SRfkIim8YtsckY8aEiIaanecj0Fnz2rgVdjH1GeQTw9l/UbSactp/DAgSN+0zjkSBSSkJo+ObJH9ajUZhzjE+wI7mbnsCf7TyZCJu3HwQBdcDf1VxfKHRREK2Im8it6MYIrelvyPMiIKy4jcIjUdjq04476yFoHGkoJA3EnoYjBWB8h+WGI51yUr//LqVO5lTvNAsvhhxWTJdKIhF1vlt3BEmvZGihYRz4PrlNMF4s8dHscXzxfWbPAQ/ubN4XTNWh8JkLM6osIDvYi3oUH9vjoFP7wJZP3RjNVal2Pvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeT/tOrq/tz8OH+WQo68ck6Tvaxe1t7taN9hwxfDhZc=;
 b=Wk20vDxN9n0I9lGJFdrmA00PBAwyFe2KX96zycH7fWzj6rDvlWkY3FClh519r5HAOH2OQTDPSNgQt80TLZ7c0u1XUJAjCWyIoUFKgqD9C95paCa1rxdYXN5H5vIf+hzM9IBUILazYh7Q793Zsu5RlzAWGOMND2OLL86w030yAiKTRFMglDiP6RDCRZyFU53GP5+DNjwT8JUfDPfXGG4v6YZgCaUL1VCrigU+eW0Nd4MQFRSP/wAicEQJmFmTVwOxdHm9smFRFr2k69ifp4dCGK4F6p4caucWBQnzkPSun+ulVFFiUOajpvhiy20pG0w9Q/+BFMBU15pG9DEL2iIGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeT/tOrq/tz8OH+WQo68ck6Tvaxe1t7taN9hwxfDhZc=;
 b=QU/0/Zft03Wnhu2vIQRSQQbGQu9tun3Nlgl/EDgMMcov0f3a37HzopIshJ3N0ZzMnVGL2a9GsMCn1vEESPlfSZ37EkUaELJO6hPu7SxdY4rsc2JClfY82VRYUFj+6wcytdD6egZc+P9cJ07DaH09+pWLCE0ZKj84umt4ipeVYPV72lNAmSyWWU1HVHN0/WKaNwPYkuTxqtlTs6tKYlgKmrPFWV/6zVkvuzQVqYJOlzN33ZQM52pY35qsHDGM/W8B0kZEdMl0fu2rXcY6sF8NyhvEXpVKAPeQ/aPxolBKGRjK8qZScFTydnbm5eLMj138FaH26Lv+f90srJlpkxNT9w==
Received: from SN7PR04CA0075.namprd04.prod.outlook.com (2603:10b6:806:121::20)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:11:23 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::5c) by SN7PR04CA0075.outlook.office365.com
 (2603:10b6:806:121::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 15:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:15 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:11:11 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 10/11] net/mlx5: Remove PTM support log message
Date: Wed, 18 Dec 2024 17:09:48 +0200
Message-ID: <20241218150949.1037752-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218150949.1037752-1-tariqt@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0eb8e9-d865-4298-29f2-08dd1f763bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xms5X7+pTieJkuHQlizah7kRQnppFok6voVxxNZCfB7qnQ1hy2DU7RJfO42o?=
 =?us-ascii?Q?HwYURuI9x1m7GHqx4KRI8aRCQvA4hJY4oUcvWHFtWx02JeiQHRcctQR5Cw5P?=
 =?us-ascii?Q?MFaEBdu48/tsyen8mfIuNa4R+S3C/znOP9Wu2K7GmFW09IdrONnObFWhfWRB?=
 =?us-ascii?Q?GTSfG0ZZloaJK/vEjaV2be2H/b0YoJkj6xt3ViumGMhjpJWc2tyg3PEt/B5o?=
 =?us-ascii?Q?kXHzOylF1S6abtI9OEnop0OyjEROI5eShsMU4RKKkwmuxpOBYO6t5gLe3yry?=
 =?us-ascii?Q?woV5iwTOcHMLhewsDdUC02Y+7W/A7betcXttLzqe+K9u78D+Dkv4r2ScoZpq?=
 =?us-ascii?Q?1KPiuVP0c+kji1/1667JyRubgftI09VJDc8ND+v9lpPD9TXBp+zlXzjzqeZ+?=
 =?us-ascii?Q?WLW1BrNivp1llQ5I1YddXfo74kSa9GHcVOxLlTLAe1uw2N3Cswcy5Butb/kt?=
 =?us-ascii?Q?qJP2QmZXzxTa0l5oKYvZY8RKeyTg3/8HPWg+fAH0gplybBie4pbLXhnrbjDL?=
 =?us-ascii?Q?gKe4/sIAgBKklw0iLOaqJGL4W/MhGgwM2xpJZmEnsRGbNPp1+/rJ/Q5mDlKB?=
 =?us-ascii?Q?QkOvUeikR1Zsl9cXfpVzgpY//FE+9AM4VbdQ0eIoKhvnkHxgbaOziiSp9sDk?=
 =?us-ascii?Q?RUYD28jX6+AODjXahH4F2UvmWxcDMVlezc32hICIPu34Y4D7wK1fg8zFtzPy?=
 =?us-ascii?Q?wW+dmY3eRmglIsgOe+ixkzJhQgVXVCW0qQKl3UzyVSI529WD7aPdP+0KBPFy?=
 =?us-ascii?Q?IcwCpyPPIbd5ToUChlFdLSti2/h2uMCY9oWT3BsFIEPsT1oCbBpu9dxNNuxf?=
 =?us-ascii?Q?3A4KMl3BpRNk5Usokxde9ol1ByzliQVCTniNXx1Htdj/Foho/N1/z/7a8vlJ?=
 =?us-ascii?Q?NoQFiPukY06ixssUraKONgooHqqN3aaJIUF09CWi4pGk1sG+RAk7fVp4yC+6?=
 =?us-ascii?Q?KBO0FvZlRAV63nZJ8UOlGcpS1USfCc7TDVKo3diC4ie3NC8xAUogtB8RrmHm?=
 =?us-ascii?Q?H77KEAe1K86OeCd4ItsvS33xZq6PY9OQPVDdhApU2pNFASt/GWw5MmZiExKj?=
 =?us-ascii?Q?FDFv+BuZXRoO7kkzADQ7VIL4M/AvK3Ws4YIVr+M0TMFDHNuzseaZaB4evIfE?=
 =?us-ascii?Q?o5cn4oPryoOosPSG133irrJ5ohWj5zVwfQqRmfCktJtK5X3FApkAEFis6DgG?=
 =?us-ascii?Q?l/2LJLAgeIrUdcItSuyacFqAXEXCUsE7ChLtrXirhA3PqbjSXjJK0Q5NPExS?=
 =?us-ascii?Q?9LXeA3Klt4R+nNxCuKjAgG+TdEnaoWFTsEQ5J7pmx2Gf+fPcm4bobLujq5qM?=
 =?us-ascii?Q?sA6pHaiCT2zf1+YS6gx4QFgenRv7O26ykFajWSAj0w5HptIUEfdij9EEPicF?=
 =?us-ascii?Q?+haTk3YULNwm32i0zKVXEbY0QILzNesPS3gJuXgQqYpCOsH1+X2g2Fh71lh6?=
 =?us-ascii?Q?cuie+YptPMeUGdFEHbyKcVFbBA8BJaYqIKpTocAYo3BNmexYoD1N/iO8iC38?=
 =?us-ascii?Q?rERZnFIoELbxwaw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:22.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0eb8e9-d865-4298-29f2-08dd1f763bf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

From: Carolina Jubran <cjubran@nvidia.com>

The absence of Precision Time Measurement support should not emit a
message, as it can be misleading in contexts where PTM is not required.

Remove the log message indicating the lack of PCIe PTM support.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 869bfecdd8ff..a108d8c726f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -945,9 +945,7 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 
 	mlx5_pci_vsc_init(dev);
 
-	err = pci_enable_ptm(pdev, NULL);
-	if (err)
-		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+	pci_enable_ptm(pdev, NULL);
 
 	return 0;
 
-- 
2.45.0


