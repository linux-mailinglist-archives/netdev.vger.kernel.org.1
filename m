Return-Path: <netdev+bounces-84968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD378898D46
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C201F2BE74
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93912CDB0;
	Thu,  4 Apr 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pG0dzBV3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245871734
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252092; cv=fail; b=hjQUOqpvr+ZS0wPjz6U+0helcMmcGs7OjSqKmOzQEhrqi9yYq3ls2HF/En19Ld4AjeeYjnzu0jY3lLjU7iTOV93IgEOmji1wYcjNNiBttu8fc+mfoGhK2mFTvIp33ZPsXqWyM+DNhHxQpNFA44bJv1oF7iHtZlo/erjBLmbJeCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252092; c=relaxed/simple;
	bh=bsV99rYDBlX2q1DrcvjmMJQxO5RX/cWTgF+kkhIi6ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLNlJ5UktZzqIuWGa6VbMgVt7o1DQUcpySfGHtVVxjV+stdW3vP7bqxHo9H7wIV0cUNNjcY1bDtCSKRpuvAFMkqP/lh38F5jr3qyjWgf2yA4T3q2BzaRhnCC6xnyRrriyel0kfRxMinR0joVi6AmC+ds5R6DrERO8RtiHT7voys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pG0dzBV3; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu4aqsrDji6kHsO5IEOQrrhkpVp3ybL+pZ6Y/REoVYQQc+UpZ1hGVNzDT2SDlo4ujEvFxdYOQIXL8DWU24+EctfL4TKJUcS/yKnlYSQr1yDzU+smUuO8T4+8iKXGBP0ChNrJVUVfbYw156evnuwpUKxzB57vruZmhIxqbqISOf+fZpVt9+0W7iUF4cdJT6BjV/Bv35N0IqqOHN07imnaS3Y+2wRgkN9rqs77nHoi6X+9k0iRBtMChKcRubH7TlrhbLUGiDykd4OP0FEnekjCyIarSikfuDgR7aa9Oviz4wJQUqGFbHwb9qq8umL1r9a+VDq1vIxl/k3SqRox85Wqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKE98Uvc5xb9frwEMiGd7NhXIxeRWCA5bVYrAgRJv2c=;
 b=DoOO4JYz7nrxl1CnlLwp1JS2C00z9BSJwxYJcnjWLt9R0DbS2O7v5YmKt/ETMszf2mnDM09m+jQ9dEvTOmN3V8giizV5Aw8reZAo1a7IVb3ZfrUOoHOff/p+J8/Ba3LkcJrSSryCio4ADLHLwURK1I2I7KYQebEah8HL+dOOnSI/e6gxs63ntEM5gF8h0fgR3l5dxDduq0UEIlYVANe6VRJfpsM+hd7j2WTWaHlQWGItsXL4TjVK/cW7VV6YEW6QD0paWgeUo2q1yXlAstKwU57/0Ai7Nb88o6kvtwAy1mFbv4QnIgIXvDYeeHUxhHR4hkKe0qpdPcMxji0hvTF5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKE98Uvc5xb9frwEMiGd7NhXIxeRWCA5bVYrAgRJv2c=;
 b=pG0dzBV3e+5fp/4BH4GPtYUKraNRy46lmH733y/U/nSd3okkUAUWvv7bo7nyMOuKWeZKvN/wpAb9ge1eLXeF9BJrqRKUI83dI/arVJhD/kxcd4Ztwr2InP+ARzClJvNzFqM5P+TaYuBp6OZxgMpdwCqM0xbLEk+T94V/R6i2ic1YVjIzO+SbpSge6t0U+O/ANL/2oVNezOKgr/di0ySQWQ6GGxn6LEF1hdvX7ACLnMfb2QREntpmo8M6MthPNwtzs+pIeZFzjj7qcZ2WubfDlDaJc19nH+D3eebcTX14hC9ZC2tsJeVLX1vvNuSQTJzpXK/S5vTVAyPIzT2TZoFgGg==
Received: from MW2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:907:1::39)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:34:41 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:907:1:cafe::f7) by MW2PR16CA0062.outlook.office365.com
 (2603:10b6:907:1::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 17:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 17:34:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 10:34:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 10:34:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 4 Apr
 2024 10:34:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5e: Support FEC settings for 100G/lane modes
Date: Thu, 4 Apr 2024 20:33:54 +0300
Message-ID: <20240404173357.123307-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404173357.123307-1-tariqt@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 7772bbc1-9b79-408b-70ff-08dc54cd8233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b4Ind7iNQ02BMmW33BN4tKZX9BsbZ2oSZS+ZX0c7V3rNAAqyHFYLdhKq7S5ZqykmurHRxfOpF0Eglvfj9p+RNtsO/psVby+QUfsDNHFFaefYXqUkwLHAL6m96m+st+4bmRehceDFQ+QqGYwjybJl/QioAbEIIzff2LCpFz4bo+7qnt6mnzjoV0W8T7xBLY8vmWn/Ac3B2YiqiLMvLaxf8vGRQP34+7ndnTk/LlohqvZoGvjbccsVoE/CkVxLdv8actzyBKDe0KSSsYFL0OJ7fvF8mZI1wsgrFHKpssdRAh3bSYnFNpdOSNJsZg/Vc+CgkRw5/bORfj3V5vX1YpsjTNPk4dpri3iYoqu7qmsMLA4BrTiLTlIfG0kDRsiiViUhIaS7Ii/skCnwolzADldyn4cZqUfRW4+SqF+RpbFkK+ahmeMppd5naeSAwTa+q64LBH8dKOIITyG/XAkHMc/n8+kuU3xjlqCFQ+iXCaOcomGKHr/25XFKxPuc0QFEFzRbIF7OIuHh/dBb/TrFdp25XSCRR1/XnXDKb+3QB0dc7VnLGiAcNBNJfsiKYuGwdSdIwJ69Zc4BCTBvBEJ+c+dx1GKO7MopkFWyuqgZy2EBtVcdyZaphiXNL3FXjMuS6/Vw9AMms9mnD1FH1fTSZA1Kw/6B2RWzuS8E5whur8i2rl92I6iY44HK9F4TbZyNZiojz9E6rj6DnTjusW3OJVViknm+HRuSLS4oXxuCgY/t4Xy1S1v8YcoxG+BtmKYRTCt+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:34:40.7643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7772bbc1-9b79-408b-70ff-08dc54cd8233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

From: Cosmin Ratiu <cratiu@nvidia.com>

This consists of:
1. Expose the 100G/lane capability bit in the PCAM reg.
2. Expose the per link mode FEC capability masks in the PPLM reg.
3. Set the overrides according to ethtool parameters.
FEC for new modes is set if and only if the PCAM 100G/lane capability is
advertised and the capability mask for a given link mode reports that it
can accept the requested FEC mode.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/port.c | 36 +++++++++++++++++--
 include/linux/mlx5/mlx5_ifc.h                 | 20 +++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index b4681a93807d..b4efc780e297 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -292,10 +292,15 @@ enum mlx5e_fec_supported_link_mode {
 	MLX5E_FEC_SUPPORTED_LINK_MODE_100G_2X,
 	MLX5E_FEC_SUPPORTED_LINK_MODE_200G_4X,
 	MLX5E_FEC_SUPPORTED_LINK_MODE_400G_8X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_100G_1X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_200G_2X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_400G_4X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_800G_8X,
 	MLX5E_MAX_FEC_SUPPORTED_LINK_MODE,
 };
 
 #define MLX5E_FEC_FIRST_50G_PER_LANE_MODE MLX5E_FEC_SUPPORTED_LINK_MODE_50G_1X
+#define MLX5E_FEC_FIRST_100G_PER_LANE_MODE MLX5E_FEC_SUPPORTED_LINK_MODE_100G_1X
 
 #define MLX5E_FEC_OVERRIDE_ADMIN_POLICY(buf, policy, write, link)			\
 	do {										\
@@ -313,7 +318,10 @@ static bool mlx5e_is_fec_supported_link_mode(struct mlx5_core_dev *dev,
 					     enum mlx5e_fec_supported_link_mode link_mode)
 {
 	return link_mode < MLX5E_FEC_FIRST_50G_PER_LANE_MODE ||
-	       MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm);
+	       (link_mode < MLX5E_FEC_FIRST_100G_PER_LANE_MODE &&
+		MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm)) ||
+	       (link_mode >= MLX5E_FEC_FIRST_100G_PER_LANE_MODE &&
+		MLX5_CAP_PCAM_FEATURE(dev, fec_100G_per_lane_in_pplm));
 }
 
 /* get/set FEC admin field for a given speed */
@@ -348,6 +356,18 @@ static int mlx5e_fec_admin_field(u32 *pplm, u16 *fec_policy, bool write,
 	case MLX5E_FEC_SUPPORTED_LINK_MODE_400G_8X:
 		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 400g_8x);
 		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_100G_1X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 100g_1x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_200G_2X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 200g_2x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_400G_4X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 400g_4x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_800G_8X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 800g_8x);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -389,6 +409,18 @@ static int mlx5e_get_fec_cap_field(u32 *pplm, u16 *fec_cap,
 	case MLX5E_FEC_SUPPORTED_LINK_MODE_400G_8X:
 		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 400g_8x);
 		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_100G_1X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 100g_1x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_200G_2X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 200g_2x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_400G_4X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 400g_4x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_800G_8X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 800g_8x);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -501,7 +533,7 @@ int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 		/* RS fec in ethtool is mapped to MLX5E_FEC_RS_528_514
 		 * to link modes up to 25G per lane and to
 		 * MLX5E_FEC_RS_544_514 in the new link modes based on
-		 * 50 G per lane
+		 * 50G or 100G per lane
 		 */
 		if (conf_fec == (1 << MLX5E_FEC_RS_528_514) &&
 		    i >= MLX5E_FEC_FIRST_50G_PER_LANE_MODE)
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cc159d8563d1..35ffc9b9f241 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -9817,7 +9817,21 @@ struct mlx5_ifc_pplm_reg_bits {
 	u8         fec_override_admin_100g_2x[0x10];
 	u8         fec_override_admin_50g_1x[0x10];
 
-	u8         reserved_at_140[0x140];
+	u8         fec_override_cap_800g_8x[0x10];
+	u8         fec_override_cap_400g_4x[0x10];
+
+	u8         fec_override_cap_200g_2x[0x10];
+	u8         fec_override_cap_100g_1x[0x10];
+
+	u8         reserved_at_180[0xa0];
+
+	u8         fec_override_admin_800g_8x[0x10];
+	u8         fec_override_admin_400g_4x[0x10];
+
+	u8         fec_override_admin_200g_2x[0x10];
+	u8         fec_override_admin_100g_1x[0x10];
+
+	u8         reserved_at_260[0x20];
 };
 
 struct mlx5_ifc_ppcnt_reg_bits {
@@ -10189,7 +10203,9 @@ struct mlx5_ifc_mtutc_reg_bits {
 };
 
 struct mlx5_ifc_pcam_enhanced_features_bits {
-	u8         reserved_at_0[0x68];
+	u8         reserved_at_0[0x48];
+	u8         fec_100G_per_lane_in_pplm[0x1];
+	u8         reserved_at_49[0x1f];
 	u8         fec_50G_per_lane_in_pplm[0x1];
 	u8         reserved_at_69[0x4];
 	u8         rx_icrc_encapsulated_counter[0x1];
-- 
2.44.0


