Return-Path: <netdev+bounces-162278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320AA265CA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A09162A77
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD1211485;
	Mon,  3 Feb 2025 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lHFIFck8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF0211466
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618642; cv=fail; b=tM9xD7fA+2cxP60JJxRhpZLjncehAtxS9Vm6SgTiRiMwWB2ACDTofkrGDYAdDfM1cJ4JDtJIwaAQ5UiTR3qR7/iELi8d8sBurTrH+dRPm9yODXokYQVBsr1/bIgAPDRITX91JxS3QGExXf40nub+tAB9EvrgoGkTsotw8UqaWNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618642; c=relaxed/simple;
	bh=bmvDntj2+dd9TpQkLXOQGnYehseNvG0nBFbQGERRwFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC6HQ03b1pBh6DoT8K8ihbgEclBtVflZ7gHkfrLbr5kA4DtRNDq+ItdyPOvIHZoxuAIpi79qQFWCJyfug3NzRCySsWU3sMXgzOOV0vt2j+fUEo6Rne7iw2pZ1IgTH/6ddzRBTlJXTKkOP25MfP3eMYGQXhKjEpSpwIb4NkTXcNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lHFIFck8; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytFYWEX5qObGAUvXomNIhEtPEv9blUV41QqZgxkNcf+niCzRzeAPHFwjV5TQxftrcDT/l3BIEU8khBjy8PFVP6LZQf1+dwLhIu0cPEBXC2LM6TkbS1jCYBg3j7iadVUNOCuazuqA2/XdQ21ZzqHJM6B3vC8Z+WEleOlh+/ms4LBq8PQWTNOChZsMjbZTgxvNBrbkvkLV6UQxsq65UENUfuttEghU20fIYUM1o5g8RFt8vdUgLz7RjdgmpfjEvgz2QtYHTrRmMD2ck2A5xjvWi1mSSnNF5C3RH6X6liyu8M5VM6LiuSUroFbSInwqAgLg7ZRPadZGIWFrZqbxxKzMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2bmWb0vdl3i/JOG8UTHtxGSZkIMem6+WQx0iPo1vlU=;
 b=bblSdP5S1ukWAMSEO7DENn2nevdbenSCGGM6YvBLW0kMwQPa8ZlSqNUMy1+1F6VpjnGv69iBY1hRWTW31Zk2rkVKpHoBQtNLazO8qS6yLeKaKOgf2K7MmtjiFFC80OmQwDgmhppkUVq67SjIs3Xjlu/VVQ+HjEfcq9e8i/wpypsCaHFU3BDzKpXtepmKYD8StmSNiJrBElH4vY2WHFUSKZqfSKM9Hk1q1ui00vcdYbv3HCVfHiLDtYUqc7IBTp4U97SKoZUG4SwthfzbvunEN65ih27b1Pf+9WdX3orDk0wCjGMJaTgTwe8TcvgkDqEriSX88saweJJ2S1TCQceHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2bmWb0vdl3i/JOG8UTHtxGSZkIMem6+WQx0iPo1vlU=;
 b=lHFIFck8RJFWfNDChENhQE/0vfIlM04vzB9E9m5dKrOpOFQqZZVgc7PZrO8gZ4uoSV6qakHNRIuy2e+lkLSYD7Hr7T5U8ihO2ZZtebCqMb1xCtOaMoE0u6PkFrexk2u0yMzjoo3b2uyGxciDeZaJjPMbYVn9U9Yg2+sMQNmIv9IJ0RaO9jByiOPMEeXxj0S0o58PvRPkWbpTU7YsYcgAMPwSfbhYzpDYbNrkpkWANSinciGaBmcw7i6cLYTDfLmu1jyFrDFsAxbseDWNVK4ks7TH0pB69Vemg3SZNX8e0r0J3E6Dkh5+Z4fmTfx5/okLsgT0BS/x3z4afsO1USfqNg==
Received: from SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:37:07 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::57) by SJ0PR05CA0199.outlook.office365.com
 (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Mon,
 3 Feb 2025 21:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:37:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 10/15] ethtool: Add support for 200Gbps per lane link modes
Date: Mon, 3 Feb 2025 23:35:11 +0200
Message-ID: <20250203213516.227902-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c435356-0963-4030-4139-08dd449ae80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tKD5rMlZ7afo5GNIh05bQzDMRb8/rtgHyisJ7ej4thWP82qqkHtszClc7Yef?=
 =?us-ascii?Q?RNZzmZXnqBpfnKISd2wNyBrqL0N26Fb449K6fo7Rli4vhfeAGFruvW51wc3U?=
 =?us-ascii?Q?OG3ALIWRC94P1O/HoH5Fm4I4XgqwCqqnHjEzW7Jtkp2isvXSskqh8l6vD39m?=
 =?us-ascii?Q?wPgnAhgrxpYF6rd66icH7FugcoNcPaf2ns9lsLTvKd4EjBxmI89P+rRMqF30?=
 =?us-ascii?Q?tjZenUNjSzdyjqZkXiof+gjjZWc2t1paOAXTdxxUEuwH/kej+1L59oJjnTSY?=
 =?us-ascii?Q?o0MU8hEeyGnVTOtudq7ymHUpxLIWGLFpO5Q8Jq28LnZ3pt8kQkepIPURaY2x?=
 =?us-ascii?Q?kF3Sl7PDX+N2I5tPANIpYcojpc0WdPTDQKwhTlV9sF4aagvI/F9ukSALMluY?=
 =?us-ascii?Q?tuV2hfTUZupy3duNu2lMyBfqhvkjPdpeNLkv9yFEZwxkdntUgJLB/OGmKtoY?=
 =?us-ascii?Q?s03A5jk8ZNbL0yqmVPwHIonL4lUhuz1Q+Tiolu60CgGgxmcPDRuajla4rTpZ?=
 =?us-ascii?Q?R8G0kaJ6RklvygmlRT8YvjoiCrHcrgzwTxAzl5+C6Obp8E6lj4rIKVJH4wCg?=
 =?us-ascii?Q?Cvf4h5MFS4S8SditING+o0PvPPPKAqTmP5oKqSajpF7LHeJOjFQRfn6X4vKw?=
 =?us-ascii?Q?qpuQkdPt/XVhp4k6uo980uhiUqFX5t7E2gZFdxm8HaXevxU7n+5sPl+3beEq?=
 =?us-ascii?Q?L4JzhV5bBsNJf+1RF2jXqEfGlORBHPZ28Vj8g+A5RchuGecZgcAzddyR5RQz?=
 =?us-ascii?Q?3n0nJk10erEMWqr94CTu5F8N6GFMZ+QmvdBdFqe/9KA8zDUCqx4Ij93MyPeC?=
 =?us-ascii?Q?9rayDolsb7wHBLUwGaJjlrZh1BQM3vu45qtPG1VlFoNhyaBL/KaVf8noQtaC?=
 =?us-ascii?Q?AYqYivH1ftQA4GCZAFLZLR/+uSvi2Uwf0bgPfxO62Y8Q6p5i4V0Q5av5qeVi?=
 =?us-ascii?Q?+hTYFyqblhuZWAtPHaexgVEPtRrAz4sDD1/POk/paWOu6r2xDZoDuCd5HnJe?=
 =?us-ascii?Q?seT01cxvoHQUWOjBTHVMw0rIzwMVBWplj2mjRQJpIzaLXnnpb03JEZpz63IM?=
 =?us-ascii?Q?isxqIBQCFJYsqklbk+tLeQGgwnnrjZUYNSsCNf+1Hrsdr0y3xjv8Hp+njNJx?=
 =?us-ascii?Q?o4MkP7RINw/H13bgxHfZg5ub0E9PmuHfsee0oVgYQkr50O7wAUY3HTFYgXQt?=
 =?us-ascii?Q?sskpN2ew1h2dCF9MoZKYpZI+ZhsLsYeEagWhejQmNqYdl7V/0Hd4XtypeT7u?=
 =?us-ascii?Q?iAoZ27qieejfVKpMLr/4W8FezwJyge7X98r+bvejEaa9LsVWmInF1MMvx3NH?=
 =?us-ascii?Q?XZlGutKA4RxR9SKA3Esrhhg+omxsl3BDm5bAX69a5TEMnM6r9x2RXwH9kKTK?=
 =?us-ascii?Q?SyFCgA/rnaTMVtgPQPY+Cuhgs2vCkdrXxlzR3g3JeL/rsXCRIacc4wiZzsEf?=
 =?us-ascii?Q?UDEDXnIdPoFqZo0KdIvU/r3CFvpXrsOmGkSw9l8Xco5y7PeEz22VoqgX2xkP?=
 =?us-ascii?Q?hK58wBaT/UoBNf0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:37:06.5157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c435356-0963-4030-4139-08dd449ae80d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

From: Jianbo Liu <jianbol@nvidia.com>

Define 200G, 400G and 800G link modes using 200Gbps per lane.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/phy/phy-core.c   | 20 ++++++++++++++++-
 include/uapi/linux/ethtool.h | 18 ++++++++++++++++
 net/ethtool/common.c         | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 6bf3ec985f3d..f181f05cb429 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -13,7 +13,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 103,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 121,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
@@ -169,6 +169,12 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING( 800000, FULL, 800000baseDR8_2_Full		),
 	PHY_SETTING( 800000, FULL, 800000baseSR8_Full		),
 	PHY_SETTING( 800000, FULL, 800000baseVR8_Full		),
+	PHY_SETTING( 800000, FULL, 800000baseCR4_Full		),
+	PHY_SETTING( 800000, FULL, 800000baseKR4_Full		),
+	PHY_SETTING( 800000, FULL, 800000baseDR4_Full		),
+	PHY_SETTING( 800000, FULL, 800000baseDR4_2_Full		),
+	PHY_SETTING( 800000, FULL, 800000baseSR4_Full		),
+	PHY_SETTING( 800000, FULL, 800000baseVR4_Full		),
 	/* 400G */
 	PHY_SETTING( 400000, FULL, 400000baseCR8_Full		),
 	PHY_SETTING( 400000, FULL, 400000baseKR8_Full		),
@@ -180,6 +186,12 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING( 400000, FULL, 400000baseLR4_ER4_FR4_Full	),
 	PHY_SETTING( 400000, FULL, 400000baseDR4_Full		),
 	PHY_SETTING( 400000, FULL, 400000baseSR4_Full		),
+	PHY_SETTING( 400000, FULL, 400000baseCR2_Full		),
+	PHY_SETTING( 400000, FULL, 400000baseKR2_Full		),
+	PHY_SETTING( 400000, FULL, 400000baseDR2_Full		),
+	PHY_SETTING( 400000, FULL, 400000baseDR2_2_Full		),
+	PHY_SETTING( 400000, FULL, 400000baseSR2_Full		),
+	PHY_SETTING( 400000, FULL, 400000baseVR2_Full		),
 	/* 200G */
 	PHY_SETTING( 200000, FULL, 200000baseCR4_Full		),
 	PHY_SETTING( 200000, FULL, 200000baseKR4_Full		),
@@ -191,6 +203,12 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING( 200000, FULL, 200000baseLR2_ER2_FR2_Full	),
 	PHY_SETTING( 200000, FULL, 200000baseDR2_Full		),
 	PHY_SETTING( 200000, FULL, 200000baseSR2_Full		),
+	PHY_SETTING( 200000, FULL, 200000baseCR_Full		),
+	PHY_SETTING( 200000, FULL, 200000baseKR_Full		),
+	PHY_SETTING( 200000, FULL, 200000baseDR_Full		),
+	PHY_SETTING( 200000, FULL, 200000baseDR_2_Full		),
+	PHY_SETTING( 200000, FULL, 200000baseSR_Full		),
+	PHY_SETTING( 200000, FULL, 200000baseVR_Full		),
 	/* 100G */
 	PHY_SETTING( 100000, FULL, 100000baseCR4_Full		),
 	PHY_SETTING( 100000, FULL, 100000baseKR4_Full		),
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index d1089b88efc7..e0bd726f84c1 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2057,6 +2057,24 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
 	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
+	ETHTOOL_LINK_MODE_200000baseCR_Full_BIT		 = 103,
+	ETHTOOL_LINK_MODE_200000baseKR_Full_BIT		 = 104,
+	ETHTOOL_LINK_MODE_200000baseDR_Full_BIT		 = 105,
+	ETHTOOL_LINK_MODE_200000baseDR_2_Full_BIT	 = 106,
+	ETHTOOL_LINK_MODE_200000baseSR_Full_BIT		 = 107,
+	ETHTOOL_LINK_MODE_200000baseVR_Full_BIT		 = 108,
+	ETHTOOL_LINK_MODE_400000baseCR2_Full_BIT	 = 109,
+	ETHTOOL_LINK_MODE_400000baseKR2_Full_BIT	 = 110,
+	ETHTOOL_LINK_MODE_400000baseDR2_Full_BIT	 = 111,
+	ETHTOOL_LINK_MODE_400000baseDR2_2_Full_BIT	 = 112,
+	ETHTOOL_LINK_MODE_400000baseSR2_Full_BIT	 = 113,
+	ETHTOOL_LINK_MODE_400000baseVR2_Full_BIT	 = 114,
+	ETHTOOL_LINK_MODE_800000baseCR4_Full_BIT	 = 115,
+	ETHTOOL_LINK_MODE_800000baseKR4_Full_BIT	 = 116,
+	ETHTOOL_LINK_MODE_800000baseDR4_Full_BIT	 = 117,
+	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
+	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
+	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2bd77c94f9f1..5489d0c9d13f 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -213,6 +213,24 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1BRR, Full),
+	__DEFINE_LINK_MODE_NAME(200000, CR, Full),
+	__DEFINE_LINK_MODE_NAME(200000, KR, Full),
+	__DEFINE_LINK_MODE_NAME(200000, DR, Full),
+	__DEFINE_LINK_MODE_NAME(200000, DR_2, Full),
+	__DEFINE_LINK_MODE_NAME(200000, SR, Full),
+	__DEFINE_LINK_MODE_NAME(200000, VR, Full),
+	__DEFINE_LINK_MODE_NAME(400000, CR2, Full),
+	__DEFINE_LINK_MODE_NAME(400000, KR2, Full),
+	__DEFINE_LINK_MODE_NAME(400000, DR2, Full),
+	__DEFINE_LINK_MODE_NAME(400000, DR2_2, Full),
+	__DEFINE_LINK_MODE_NAME(400000, SR2, Full),
+	__DEFINE_LINK_MODE_NAME(400000, VR2, Full),
+	__DEFINE_LINK_MODE_NAME(800000, CR4, Full),
+	__DEFINE_LINK_MODE_NAME(800000, KR4, Full),
+	__DEFINE_LINK_MODE_NAME(800000, DR4, Full),
+	__DEFINE_LINK_MODE_NAME(800000, DR4_2, Full),
+	__DEFINE_LINK_MODE_NAME(800000, SR4, Full),
+	__DEFINE_LINK_MODE_NAME(800000, VR4, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -221,8 +239,11 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_CR4		4
 #define __LINK_MODE_LANES_CR8		8
 #define __LINK_MODE_LANES_DR		1
+#define __LINK_MODE_LANES_DR_2		1
 #define __LINK_MODE_LANES_DR2		2
+#define __LINK_MODE_LANES_DR2_2		2
 #define __LINK_MODE_LANES_DR4		4
+#define __LINK_MODE_LANES_DR4_2		4
 #define __LINK_MODE_LANES_DR8		8
 #define __LINK_MODE_LANES_KR		1
 #define __LINK_MODE_LANES_KR2		2
@@ -251,6 +272,9 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_T1L		1
 #define __LINK_MODE_LANES_T1S		1
 #define __LINK_MODE_LANES_T1S_P2MP	1
+#define __LINK_MODE_LANES_VR		1
+#define __LINK_MODE_LANES_VR2		2
+#define __LINK_MODE_LANES_VR4		4
 #define __LINK_MODE_LANES_VR8		8
 #define __LINK_MODE_LANES_DR8_2		8
 #define __LINK_MODE_LANES_T1BRR		1
@@ -378,6 +402,24 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1BRR, Full),
+	__DEFINE_LINK_MODE_PARAMS(200000, CR, Full),
+	__DEFINE_LINK_MODE_PARAMS(200000, KR, Full),
+	__DEFINE_LINK_MODE_PARAMS(200000, DR, Full),
+	__DEFINE_LINK_MODE_PARAMS(200000, DR_2, Full),
+	__DEFINE_LINK_MODE_PARAMS(200000, SR, Full),
+	__DEFINE_LINK_MODE_PARAMS(200000, VR, Full),
+	__DEFINE_LINK_MODE_PARAMS(400000, CR2, Full),
+	__DEFINE_LINK_MODE_PARAMS(400000, KR2, Full),
+	__DEFINE_LINK_MODE_PARAMS(400000, DR2, Full),
+	__DEFINE_LINK_MODE_PARAMS(400000, DR2_2, Full),
+	__DEFINE_LINK_MODE_PARAMS(400000, SR2, Full),
+	__DEFINE_LINK_MODE_PARAMS(400000, VR2, Full),
+	__DEFINE_LINK_MODE_PARAMS(800000, CR4, Full),
+	__DEFINE_LINK_MODE_PARAMS(800000, KR4, Full),
+	__DEFINE_LINK_MODE_PARAMS(800000, DR4, Full),
+	__DEFINE_LINK_MODE_PARAMS(800000, DR4_2, Full),
+	__DEFINE_LINK_MODE_PARAMS(800000, SR4, Full),
+	__DEFINE_LINK_MODE_PARAMS(800000, VR4, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
-- 
2.45.0


