Return-Path: <netdev+bounces-133261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9F9956A0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528E0B20B6A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8C212D38;
	Tue,  8 Oct 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2hn3F6L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D8212D3F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412399; cv=fail; b=dY1ytBfaZD6QLbp9pilvngKDfoA6YpD7B4rVU/a+qC/LTUAjveBNHwNw1aNhb0dF/3Oe/YJPxuTQ+/7dzSp52DaOKiegVHEJD/1lGYLZdR3AUI5yC/zQNZNNdvTohYKtjT3XvzuKsCrBCqbFLLTsjs2Ps3b7uDn8Ypzy6ujbUaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412399; c=relaxed/simple;
	bh=//qYrnhUvNz8H4i99vBYhXHPEb0fEcIa6X+wLf7sliA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7kGg2xx9+ogAMgGvkqAxpY1O7TMYFZqJcFzhy/0FzDV0/V5RXDXyxbFtUBxJ2g10sJtejxlmol4fMgsmqOIVWpKuSEp1j9oUSnpnSUUNcPTtfpsRco2XiAhy2PmX4YPu1wqHFBvE/6NBUhX4psRcTaw3LlobrrWfVsUuGFkdfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f2hn3F6L; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saQQcHJDCVuLXmRRYI03eH9r9Yf0tLZONqFAboCt6jZqOOmyuXlLPLD7bQlNdB/OLaNn9OJaRNNC4QwtSsFWtQByucp6Vu9ZmPdQPQ1585c5wRY8cCvXPjT34MjZJbAUbNLmv2hKHvz9PNqBtUIMV/yTYnh7JbhyjL5hnoKeWkd7n5kTjzIsisMRPAhbgdh0G6oGEY+CuulLvU74UcUoLAsIoRw9v1XwU+sov6YjTeDo/LT4AwvvIfb5w3aRYJ7LNF3sy6E/jSbFuDjHJJiJmOaP/30dBmBX2yKsxTiiAtdIjesWvp1JYbybAf6dDr0eiQjzFBrHsQ9Qiaq7BchWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDLVhTgRfXfdma4BKzVztYkU3ugJUF28Vp8kwVGjAoA=;
 b=xgCci/3rReCuDZ9Bs2dNEvYeBGneXFCxp+kBlBRcLqo0YociPpPiz77IdRsFgUKG3yqmQ6Tb+3YlRwb31XSF3k0q0Y2kLirTnqbPTCbw1mUd6vozPwJHjO4R4RKnXdmq5h/rgCYUnmdk203rZD4edJItOC4sAKsBDAZ4ZyYjQIwqA6pxcvfNR6k17l3Pi3qrr9qOd4PC2CAenHkGs2Xi+itP8D2m2+lup+g60cA+TuW/YKuaVCPmWujQnEz5+HrmjnLO26otod6yq3DEVuxMEBNKffqEdVvpS4Dhd7f+LpqdhA76eUe6NgsYxtTyg+SPq+QOpVopg++vuHsJiqgGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDLVhTgRfXfdma4BKzVztYkU3ugJUF28Vp8kwVGjAoA=;
 b=f2hn3F6LsqUFEOULvt4svWRqIzwQ+qr4FXXzIJtTx+BNcxBq6tJiasFErjoj5Vqfw1MVrXfzP9ZtjVs93c/a3zl7Mv8kMRmaNtyxQUkGzaf7NzcjLcZCmqy4DDgHuLmLOTYJ5+0+auZW1QEBTe3xYXdqzBZt0PT4euqqV2+1c26gmK6o8/DmP+GIMwjvZZ1YoTWnDmgYFPT/yvDn+oh0UKkU0etumoE4csmn+0SdWFXPypoE1h4qA5qsMi7I0iMiszHfpOwt8Yd2+mA1KjMNr1oy8YEesmA20wd6LFD6+afRYZEqkCLRpeCW1kWDp8+F3SMBvJuZ9yukkbkJhL3bHQ==
Received: from CY5PR22CA0080.namprd22.prod.outlook.com (2603:10b6:930:80::19)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 18:33:12 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::ac) by CY5PR22CA0080.outlook.office365.com
 (2603:10b6:930:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:32:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 01/14] net/mlx5: qos: Flesh out element_attributes in mlx5_ifc.h
Date: Tue, 8 Oct 2024 21:32:09 +0300
Message-ID: <20241008183222.137702-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 362af8cd-5e39-4f64-4191-08dce7c7aa6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVeYIY5evGXYUZhNZ82osCk1BjsMPSluNXiqL9P6903t0D3MDVM5R9/eX3mi?=
 =?us-ascii?Q?QPNEEmnKUsFT+OJY1srnYFHOLBDkst9huXYChhYZkdR68KiOCUs+CdSpoRkM?=
 =?us-ascii?Q?fru+WtJ+1iAZRL1XDvJ8mZNkOTgrHy5I3AoH4Y9YzRFadD94hVrUAJQbNTAF?=
 =?us-ascii?Q?enCj6tHUHgecb/5jlTzjzGGurnJaxRudLt2qtV7+bjIdiietfN2VZMYxGGNt?=
 =?us-ascii?Q?4TlqwbFA1D8wHFR9MYJumIdPNbwfPEWKG+ajo4s9osSAZj3B5kgmLhHqNSt4?=
 =?us-ascii?Q?xy4PxOb39D8gujDRD//iHHH0wi7wjrFjCY77KVw10FCl24Fhj8Hi5KftixmM?=
 =?us-ascii?Q?gMZfwk/ZhEs7AeeKl8srgqM8ocnxrtguuLlGl+YCBOcKYUDabfi8HXMAQs+f?=
 =?us-ascii?Q?RsdqRh2fPhGcV7+P9ikUgu0oEurSP2szgJ70gQCManoTx/EdT3iKTS0zZGIM?=
 =?us-ascii?Q?h+L/MaybyZKtCMXiDwipZGMu4MZEWMzL4RePKqLTiHepH/ZdGXP2mFZskEIF?=
 =?us-ascii?Q?Nqlk5hPXM8zfJqSfHCRatfHICVuXJz3N1YP0arXW6ZxeCRmkLrMO0f32J16T?=
 =?us-ascii?Q?dsmAil8MYV4zBeNGnNguRqti6XtnEuN6RMfvvYCvQX0DP+2zyANPz+yzLJ/v?=
 =?us-ascii?Q?MqVVvym6K2MbSgbBBRQnMRH/m74cYoT39WwUYYOgYsZ5sFdwWF43kZfDulRG?=
 =?us-ascii?Q?wRgSGUaNv6xD56GDPCJoL0zPV6puyWjiv5givtzZuqNO2+5fXX5UF2u3jd1+?=
 =?us-ascii?Q?xO7+zo7xT6DR/UmfhKDC4pIECCSx7YiEYU9OPUGPFJ07FAP9Z//M2IIvIIKj?=
 =?us-ascii?Q?KoCdzGpsCNwE1ULBQc5bkoTrD+Rpzupq1+cgdXp+sLavXGhFdpPDJd+i/cD4?=
 =?us-ascii?Q?/EgXh6IWkn2bzw2yWwlNz4Ofi6Z6TXE5/cn8AVzyLfCkT7Nb4zB9u8pUkvWm?=
 =?us-ascii?Q?86EAsnSxfiGiZcbbXvZzfx0Ubs9MlfbhfnnM1R0Y1fDxsAShnzasn4DGDLqE?=
 =?us-ascii?Q?Q3Y/9nWY6fTYEkCOGfzNmeR5tBhJY4Sas96SBRq3EBybRHCHCf2SnR/NdADw?=
 =?us-ascii?Q?ayVZ2X2gLMGGkNsnsmt8rF4UEGxrB5v6YP9NOz2JPnpRJOP0ssEA8HH9ywZi?=
 =?us-ascii?Q?/V/sYkwnNH6sdhZXz3AZ1UbJ02AIFRep3nvUOW3nxtHjvGLRfu/eVzajuIJq?=
 =?us-ascii?Q?5llsMl3CvN2KEbIX/W9P7fO+7obJwqtdt6FkZy5FyBcxb40gjACg70hcQ4vh?=
 =?us-ascii?Q?Mkwxmcm5KzGTo9/wlQGg6SaZppfjwq3Vu8kdJ2nkgEL4DMFTT+XDR2zWfCZL?=
 =?us-ascii?Q?1JkzJvC/wZ0UeMyrOxJA5qaAixGXRIEVZn3glwi2IFNtY7ZAJh/b4iAKi5q8?=
 =?us-ascii?Q?2RHy3p612dsGelsT5tl6LqD7Z8xS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:12.2559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362af8cd-5e39-4f64-4191-08dce7c7aa6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

From: Cosmin Ratiu <cratiu@nvidia.com>

This is used for multiple purposes, depending on the scheduling element
created. There are a few helper struct defined a long time ago, but they
are not easy to find in the file and they are about to get new members.
This commit cleans up this area a bit by:
- moving the helper structs closer to where they are relevant.
- defining a helper union to include all of them to help
  discoverability.
- making use of it everywhere element_attributes is used.
- using a consistent 'attr' name.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 18 +++--
 include/linux/mlx5/mlx5_ifc.h                 | 67 ++++++++++---------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 02a3563f51ad..7154eeff4fd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -339,7 +339,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	struct mlx5_esw_rate_group *group = vport->qos.group;
 	struct mlx5_core_dev *dev = esw->dev;
 	u32 parent_tsar_ix;
-	void *vport_elem;
+	void *attr;
 	int err;
 
 	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT))
@@ -348,8 +348,8 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	parent_tsar_ix = group ? group->tsar_ix : esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
-	vport_elem = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, vport_elem, vport_number, vport->vport);
+	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_tsar_ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
@@ -443,8 +443,8 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
-	__be32 *attr;
 	u32 divider;
+	void *attr;
 	int err;
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
@@ -453,12 +453,10 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
-
-	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
-	*attr = cpu_to_be32(TSAR_ELEMENT_TSAR_TYPE_DWRR << 16);
-
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 esw->qos.root_tsar_ix);
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
 	err = mlx5_create_scheduling_element_cmd(esw->dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
 						 tsar_ctx,
@@ -559,7 +557,7 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = esw->dev;
-	__be32 *attr;
+	void *attr;
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
@@ -573,7 +571,7 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
-	*attr = cpu_to_be32(TSAR_ELEMENT_TSAR_TYPE_DWRR << 16);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
 
 	err = mlx5_create_scheduling_element_cmd(dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 96d369112bfa..c79ba6197673 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4105,11 +4105,47 @@ enum {
 	ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP	= 1 << 4,
 };
 
+enum {
+	TSAR_ELEMENT_TSAR_TYPE_DWRR = 0x0,
+	TSAR_ELEMENT_TSAR_TYPE_ROUND_ROBIN = 0x1,
+	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
+};
+
+enum {
+	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
+	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
+	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
+};
+
+struct mlx5_ifc_tsar_element_bits {
+	u8         reserved_at_0[0x8];
+	u8         tsar_type[0x8];
+	u8         reserved_at_10[0x10];
+};
+
+struct mlx5_ifc_vport_element_bits {
+	u8         reserved_at_0[0x10];
+	u8         vport_number[0x10];
+};
+
+struct mlx5_ifc_vport_tc_element_bits {
+	u8         traffic_class[0x4];
+	u8         reserved_at_4[0xc];
+	u8         vport_number[0x10];
+};
+
+union mlx5_ifc_element_attributes_bits {
+	struct mlx5_ifc_tsar_element_bits tsar;
+	struct mlx5_ifc_vport_element_bits vport;
+	struct mlx5_ifc_vport_tc_element_bits vport_tc;
+	u8 reserved_at_0[0x20];
+};
+
 struct mlx5_ifc_scheduling_context_bits {
 	u8         element_type[0x8];
 	u8         reserved_at_8[0x18];
 
-	u8         element_attributes[0x20];
+	union mlx5_ifc_element_attributes_bits element_attributes;
 
 	u8         parent_element_id[0x20];
 
@@ -4798,35 +4834,6 @@ struct mlx5_ifc_register_loopback_control_bits {
 	u8         reserved_at_20[0x60];
 };
 
-struct mlx5_ifc_vport_tc_element_bits {
-	u8         traffic_class[0x4];
-	u8         reserved_at_4[0xc];
-	u8         vport_number[0x10];
-};
-
-struct mlx5_ifc_vport_element_bits {
-	u8         reserved_at_0[0x10];
-	u8         vport_number[0x10];
-};
-
-enum {
-	TSAR_ELEMENT_TSAR_TYPE_DWRR = 0x0,
-	TSAR_ELEMENT_TSAR_TYPE_ROUND_ROBIN = 0x1,
-	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
-};
-
-enum {
-	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
-	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
-	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
-};
-
-struct mlx5_ifc_tsar_element_bits {
-	u8         reserved_at_0[0x8];
-	u8         tsar_type[0x8];
-	u8         reserved_at_10[0x10];
-};
-
 enum {
 	MLX5_TEARDOWN_HCA_OUT_FORCE_STATE_SUCCESS = 0x0,
 	MLX5_TEARDOWN_HCA_OUT_FORCE_STATE_FAIL = 0x1,
-- 
2.44.0


