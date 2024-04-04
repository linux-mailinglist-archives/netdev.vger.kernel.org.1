Return-Path: <netdev+bounces-84967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B795898D45
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F5F1F2BE09
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3F12DD9B;
	Thu,  4 Apr 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bkO3kZ+J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8FB12D770
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252087; cv=fail; b=tuFp7Qas9GBplWCPe8byoeFT1cAzYCeuV4/IXLMJ5rw3FPkvQkhrgjVlTsfL8dkiUpFaKnwgAW2zxaLn2xlMg3CHHE+DG3kjU2nY4K4mMOZ6dCd9YC0mevE6lqMlsTYyJftLJkrbfZvh/cVhDjibYczH3SeaGGhPns//U030ZJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252087; c=relaxed/simple;
	bh=LROBprR8dKMFkyHgmaesSg7ro815O0EroKKVkZ9A2Fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NV/4AjkTfUhCI2t42vFby/X4uuXn7/3D/duoNbA+0WNYFWyF0bZpDuu4CRtM/aBFXhJ3LxQ+dWig/1LI6W9ajo3Vy57UdMPnrNINyiX30ulToGdu98+xHxpmtAScVMtbtcVKfeUoNNnck7bao2O0LJbnKRuPC1LPuVpiX8g9fnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bkO3kZ+J; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6oy4Zsqu4qdCCXyw7lIfsTYzhP4E8BaFccb2NxPKn3QVuA9pOz1/eUQV3Njm3ymo8xymPflV7Uts+TyVu7f0KBuTQdgERp6+utPnX9WquOdUDPhnXm44IDOdcZdNiyahJH76CH8xxZ42CpjcTska6xaRFU6s1im7+ZNfAkN0WjY+4wAbzDhdFA4R5wCHlpmcAFaVWMxBn7yqIByIVv+2IdDjt6csVrvvWjkJzCstmrXS6+jyHKc3PwwKxMg6Hod7If1juMH0jdVaLSj9wvmb2ZKOPM1wFwTYBXvgo5M6h3uhrpuX+rnch0YOLI+o7Tgzb+w5vtd7dV2xk8/IsF2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLkxbFEbAZPGnbRGASeheiMPIADWbQDzLpPCeQmFmrc=;
 b=OmR0rLhk53VOiwzwwbTPOkL9U9CxFcR4pPeeaXq1UXmcCkBvGwH3VlmLQBoGEHmir1w8jEnzo8QoruCPUvZzodiswupc2ScaeI+iEG/PVNNelpHMf9xdaIMj9AVwc7dr7zlYdcz4H2M+DU59b5w1YyOSZTAvglicoXl44m9JhrM8ypIjyOUa6SOljdljuRJttYcS1D6UJyKU4PAzTe2WX4xdg4cnq7gdVQbZ6Jvik7IVmtyQ27T19Od3PV39G4JnwQjgpsSOt5RBV6I5FSZAfVa2kjRxfL3B1hQ1yX2nxWDMNrrg4WIZAv0lqnIMfKOW5miOROoNFyXhmW0tTOoFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLkxbFEbAZPGnbRGASeheiMPIADWbQDzLpPCeQmFmrc=;
 b=bkO3kZ+JYcc0nfM9dQO1rcB9J6LlpmBt/MAh6SCLB9Tn8JSRonlDLb51QQKR1P2TegT0g571gTznrGREqpq9w3tgTpj6kKmo3UZ2SfP2Cj12MILnmVr9OOpqwqgJJZxfntyM4tAMLny7LuFA662hMyhtD8FC/yPxhGvZQd0ZNzqKSRrxNow7Lzy0+Z1ldazscCnjjytPbsg54XvZaTsnKzIxKe9WWs5N1nyd1vDBAnp8nTXpF/N47UZdvrSO0fZSfRYRGQqTv140YROCftcFmmj7+EF+CouzpPhRcjbVbhtVJHBRZGWPFbVMoHie6mq1BwXI5E2DDstgRAfVsWPC9Q==
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:34:39 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::c1) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 17:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 17:34:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 10:34:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 10:34:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 4 Apr
 2024 10:34:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5e: Extract checking of FEC support for a link mode
Date: Thu, 4 Apr 2024 20:33:53 +0300
Message-ID: <20240404173357.123307-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 110ee02a-aca1-4e01-a447-08dc54cd80bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VbfdCOj4COpa82vfniKV6GTIRgpL7p3m/ZorfDiiz3QeKxRcuBsTWC593TVe++UIPyYPhfWQgVjFTKnnUA4fIuR25/AOlKhrRZrJzmWsKv7LqrhoWXYP4XUFjG/bw3rc/gDqZtVjvzNQha68hRNLBWCBKVag1aNVw+cTbpZDiQH7VIafdG6TMEWNGrZ/JWY2yflZMu9PKXMTkCny7tzIMbv3Js/9cY+sNgOfHPhVn4zMMBqBPgfwAQpLbDRu6vCUOxnCgS2i3dwpq6yyiE76xwtjIvat/5RSB3YGyI6gS6ZgSviI4NPMnw9aJ0CFiUM1C/hb/PSVgsml7kuTaQJ2JLV5IzFGRbBsbpJDALIyRHlNOZZcRwjXBTOvN1HPBu7NnczEurPAgiCeGelJ3ATKKKhEahgfUCChVNbGRn2fbDxry8vQb3Qs3Cbqh3sHyb+z/cGdxlj+AR/zRq6rfzKKRxYuJpZcVLpUlxo6qRuy7t6spOHQH7BMqeO1vJgnXqPE7IOk9khOpNQ+/+Nm83jY389mjTovGdQUwOkiJYbtVjhJuK9TpmpYkWfiwlZmDyXQKYqJ6BsPU9EtnVSXitKjMuGCFfUqEX4VUjXaHeduXT/rQ81LDLUXqGnlcbLnKZiofB5E51OnJerjlYzlczxzforLiLyGd2nFoc9wi8vKdO5KOriBM8CPmKw7e2Hwjm6KRbGDm/f1VJToN7Hd61Y7uf9H+9MYL29xzGvOUgdkjd6fYf8fuCW/kDnE2bo7XI5d
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:34:38.2677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ee02a-aca1-4e01-a447-08dc54cd80bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

From: Cosmin Ratiu <cratiu@nvidia.com>

The check of whether a given FEC mode is supported in a given link mode
is about to get more complicated, so extract it in a separate function
to avoid code duplication.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/port.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index dbe2b19a9570..b4681a93807d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -308,6 +308,14 @@ enum mlx5e_fec_supported_link_mode {
 			*_policy = MLX5_GET(pplm_reg, _buf, fec_override_admin_##link);	\
 	} while (0)
 
+/* Returns true if FEC can be set for a given link mode. */
+static bool mlx5e_is_fec_supported_link_mode(struct mlx5_core_dev *dev,
+					     enum mlx5e_fec_supported_link_mode link_mode)
+{
+	return link_mode < MLX5E_FEC_FIRST_50G_PER_LANE_MODE ||
+	       MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm);
+}
+
 /* get/set FEC admin field for a given speed */
 static int mlx5e_fec_admin_field(u32 *pplm, u16 *fec_policy, bool write,
 				 enum mlx5e_fec_supported_link_mode link_mode)
@@ -389,7 +397,6 @@ static int mlx5e_get_fec_cap_field(u32 *pplm, u16 *fec_cap,
 
 bool mlx5e_fec_in_caps(struct mlx5_core_dev *dev, int fec_policy)
 {
-	bool fec_50g_per_lane = MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm);
 	u32 out[MLX5_ST_SZ_DW(pplm_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(pplm_reg)] = {};
 	int sz = MLX5_ST_SZ_BYTES(pplm_reg);
@@ -407,7 +414,7 @@ bool mlx5e_fec_in_caps(struct mlx5_core_dev *dev, int fec_policy)
 	for (i = 0; i < MLX5E_MAX_FEC_SUPPORTED_LINK_MODE; i++) {
 		u16 fec_caps;
 
-		if (i >= MLX5E_FEC_FIRST_50G_PER_LANE_MODE && !fec_50g_per_lane)
+		if (!mlx5e_is_fec_supported_link_mode(dev, i))
 			break;
 
 		mlx5e_get_fec_cap_field(out, &fec_caps, i);
@@ -420,7 +427,6 @@ bool mlx5e_fec_in_caps(struct mlx5_core_dev *dev, int fec_policy)
 int mlx5e_get_fec_mode(struct mlx5_core_dev *dev, u32 *fec_mode_active,
 		       u16 *fec_configured_mode)
 {
-	bool fec_50g_per_lane = MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm);
 	u32 out[MLX5_ST_SZ_DW(pplm_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(pplm_reg)] = {};
 	int sz = MLX5_ST_SZ_BYTES(pplm_reg);
@@ -445,7 +451,7 @@ int mlx5e_get_fec_mode(struct mlx5_core_dev *dev, u32 *fec_mode_active,
 
 	*fec_configured_mode = 0;
 	for (i = 0; i < MLX5E_MAX_FEC_SUPPORTED_LINK_MODE; i++) {
-		if (i >= MLX5E_FEC_FIRST_50G_PER_LANE_MODE && !fec_50g_per_lane)
+		if (!mlx5e_is_fec_supported_link_mode(dev, i))
 			break;
 
 		mlx5e_fec_admin_field(out, fec_configured_mode, 0, i);
@@ -489,7 +495,7 @@ int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 		u16 conf_fec = fec_policy;
 		u16 fec_caps = 0;
 
-		if (i >= MLX5E_FEC_FIRST_50G_PER_LANE_MODE && !fec_50g_per_lane)
+		if (!mlx5e_is_fec_supported_link_mode(dev, i))
 			break;
 
 		/* RS fec in ethtool is mapped to MLX5E_FEC_RS_528_514
-- 
2.44.0


