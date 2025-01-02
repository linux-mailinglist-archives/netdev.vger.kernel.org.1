Return-Path: <netdev+bounces-154811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E779FFD97
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905A23A1D11
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813C1925AF;
	Thu,  2 Jan 2025 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jpJ3ECEi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C49137C35
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841732; cv=fail; b=n+AzBPMrZvw1Gt1X87w9230G+cBYB9yvqEcnaEUqreQym6FqobDoN0Rif62qK7GC+xchuiEOOo0pSnMM/thILwaj7jpHclgYWd3w+D/vRVXvEAcZ2jqUQYC9lK/QpSut/u1hNhZ98hWXVTUQY3qxmdsOf2KAgQMxZnuggp5wa6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841732; c=relaxed/simple;
	bh=BRQYffMGJhEje3SyDbQHBatJGjpBcitvP9GlNJ+alS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3AnXtA5l7lc+nn5DRZkMpB5y5kgs/3vd3s0YMb/HZc1yL/acBON9C7J9sHpWdiZhtmuEjznsY3gr2mk+oNn2CsDGYJKGXK6HvAoe6DTevzoGUOqJXdmkFr4yaHfTby8oQTq/NmJTGJjE+8z1GlIqRHhefj4In/Y+hkNuBWeuFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jpJ3ECEi; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9S1zKygl9QWGhC9N0ooxZupx7NciyR2AgLfFniXTpiKNFXWJtvjSSqAim3ibIOkPh5xeHcnTFjNQeBBigjotZbOnbzyVuKaeK8kbyi+OZTARZq2YWt6HP7VG8S/KV2PjCV3sDtFlFFY4eQghy7WLZTUrPXiicpmKh3WILUF7u80JWTCmu7dyFooSmNfb3TCMhjn8I4sRkr62xx1v4AfXeLjBoM3ufiWc7HsN+bx6x3IAsMH5xOt2tREglchK9LCAQk4l+LmPr4k5ZGwtTxNmDyPnDv6ZuOsiI2COfgO7xxjvKKH+xGjKk7N8+sWQ7OVEW2A/UEyDNr698cL7mFOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4QPN/3vd95A6EA63Tf59ft81bAk1/SPjJwMCkCsIGs=;
 b=UAD0lUhyekFMVtVibtX/OAcTvzgavPsHZwyC9LIVyCc30JikwnSbQ9TZJRFVOJ/KsbBpX5Ug2EfnVeQi7VZvTf5b0RgdZ0VSYh0XIv4w7V2NQRaEWxSI+MXwf1oxqqzSIHwAj4WX0faxzbJAyb8Ju9VAYhTCSrqPLQ+l7U09khoL/EOrIx0rSxGpDWiZlNUbV8mXg4vNmoHXEXn21wbE8qtBpf5sdpXimtddgH/mSwLAkid57IQFZ448FcKFWEwuvKE2r6TkmjYcmvNffLB5Uy3s49PBmuL1jZTSj7SPlE8vmUU1pLLFdT2A/djjv1TJpDzf8/qe/xt0VAYQTflY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4QPN/3vd95A6EA63Tf59ft81bAk1/SPjJwMCkCsIGs=;
 b=jpJ3ECEib5a3gmgBkch54irfFqM4RW8tQc3blCQS6k6/2aLbwXXugmEXxiJUY/B30m1TqvbkeN+BBJ2xVAg5rAm+neIwtxV+cDGKBEtx3jwd8NDivASUcjUN5EoQVZcJ0O9SXyVtLRl0jLBfBqlj2QOQiN8EoCUogcjxJXcwmzNRw6KNDGIuMS3QhV6yBM0/wld3G3uJHQVhepXq+8itlEJ1yBsWn1fijTuH7ciUpADu4Ajiz4n4RnheyOxG5qq1b29JF2cZVdac+h2j64gfucbMgBj7NoInwbBW8GN09nNEpUzJPPdA3gIQe3v+pDwvvj+/qvJsH7/rLwVBsdNGeQ==
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:20 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::d6) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 18:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:06 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/15] net/mlx5: HWS, remove implementation of unused FW commands
Date: Thu, 2 Jan 2025 20:14:01 +0200
Message-ID: <20250102181415.1477316-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9a72eb-ef15-4aa9-3577-08dd2b596a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WeafaYGj/LqF0zcxXuhLUuBAicZJOm4BHvKuI26oMIKQiqkPX6t7SxIFnP9v?=
 =?us-ascii?Q?CB+7Nl39GHN/oGq1POh6EgZg3mRNM1I0aX1bJIhdx56NVaQ/ZU439kdTA1fv?=
 =?us-ascii?Q?8T5aOo9PI3GnX68JLOryC7vTwc5eXp5EaxjBJukc5odsk1pLphnPmXkuIDKW?=
 =?us-ascii?Q?2x5sJ9EP9IdjvR3mINcm6GyiGAar/pBNQPkbP4QB/cbJy3/JZRzrb81L+E4U?=
 =?us-ascii?Q?lvob8rJ9Y0tC7lzpmuo/guGMblABUC3w9U6TojCJ4c1hAZZywnvNE4c7aGsX?=
 =?us-ascii?Q?XVbiaw/asBMJuLuuQaobYxL8CMfM/HV7GJH5TPqb4NNev9Kw/oHMCmXF2rIS?=
 =?us-ascii?Q?7KIJd+Ds7nspkTUORJ4r4krV0fOWY64uq4lbpWoDfXn4gOBz8KNDqOBi71FI?=
 =?us-ascii?Q?kBMv6gKpK90FCtkf6sCSIYnHz5Nm6C0j/CiKGblAauhw05ERsKr+62ZqMB7T?=
 =?us-ascii?Q?b0KHoE2xuQbtVvFfUmMRnuoCJnQR3dc7ZYKGiN6EAgUW+xWjLRReAg/1Ve4M?=
 =?us-ascii?Q?RGU+Hy8R7/dmLDkvXS9sd6yFlQYG839y3pTnMWg9upYh1BzBFMRCEBmhb84P?=
 =?us-ascii?Q?m4nU6e7OuF+zh6Ic29pwV41QK0l5IsQiVRH8UVnIJTi+rAvv5eB2kmxDZRnZ?=
 =?us-ascii?Q?KyESFnuMy/HaycqVWS1ujzQq4kHLv0hM5Wzz9PP3Gu3aRiFkFg9HTtOxVvm9?=
 =?us-ascii?Q?R2UWBZaSivkPGJx52ZqDDzJuuuEfMqMyeTRKnIWON2L4Pk7OX0/g4HCpIJtR?=
 =?us-ascii?Q?x7blqtmO8qR8l1b1uGEPyNv9IlREjWXnfIcDq1hhyXD6lFoAddone3haZ5Gj?=
 =?us-ascii?Q?3kofoyrGemQhMtQfGs18m/Vb1yHEtzeP4ioEUwVohUan79icxf+i3uofM7JI?=
 =?us-ascii?Q?QB2OJo78BwEhXLh94RJ+qeoa0z1w1M/3nuGrAInRllOM7/FwLwZhkC/NOgQP?=
 =?us-ascii?Q?X1WoU8kpCr+egc5D3dANVJXo9XmjdUGd7x4koW51OAWVgqajXDIyCuZrZSTX?=
 =?us-ascii?Q?YGuXu/oaKHR0Oq8zMwc+dpNSbxN53lnY+5wRfpL4ojIqJ1YBK7oYR0I95L5D?=
 =?us-ascii?Q?lR9sJCXz9otiyud/5Iiu9aq8erB/sFZdpOepnaWCNtjJKh360J6EdkVDRJNK?=
 =?us-ascii?Q?7ofLDvPPp7jCeq3ERK9fnbJDUWlyPam6r2NGFMDj/fDR7HqxNf2UXL0Dypmz?=
 =?us-ascii?Q?7rRo8QPjmwj9ADtHDv09pYV3FV528xIpfZhq2f3sNCGvWVtz93Ky97oTGE5I?=
 =?us-ascii?Q?wDrY7MLuq9/O+GACPHJikWJw4p/A8b6dZSzR5sxTuo6wmlHriJwShnRioZpT?=
 =?us-ascii?Q?n/AzbDEaSx5l84mZ7jtIajH7MOh+mEKR5bwBaK9RQthHyYg8hdjE4DYopRN5?=
 =?us-ascii?Q?SZvfdtMtecnNXZexxjoBOcGfNSnSPoGtIE4jLTpkZ4q8G87xy7zoy6nivVAE?=
 =?us-ascii?Q?su6bYk/+OvdQvIXXbTQ7D6FDIyW4eFnsXWc4S29RSsYD3hUOX20z9yvo6NIg?=
 =?us-ascii?Q?9yf3Of8K1XpfrY0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:19.4664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9a72eb-ef15-4aa9-3577-08dd2b596a8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Remove functions that manage alias objects - they are not used.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/cmd.c     | 67 -------------------
 .../mellanox/mlx5/core/steering/hws/cmd.h     | 11 ---
 2 files changed, 78 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 13689c0c1a44..6fd7747f08ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -889,73 +889,6 @@ int mlx5hws_cmd_sq_modify_rdy(struct mlx5_core_dev *mdev, u32 sqn)
 	return ret;
 }
 
-int mlx5hws_cmd_allow_other_vhca_access(struct mlx5_core_dev *mdev,
-					struct mlx5hws_cmd_allow_other_vhca_access_attr *attr)
-{
-	u32 out[MLX5_ST_SZ_DW(allow_other_vhca_access_out)] = {0};
-	u32 in[MLX5_ST_SZ_DW(allow_other_vhca_access_in)] = {0};
-	void *key;
-	int ret;
-
-	MLX5_SET(allow_other_vhca_access_in,
-		 in, opcode, MLX5_CMD_OP_ALLOW_OTHER_VHCA_ACCESS);
-	MLX5_SET(allow_other_vhca_access_in,
-		 in, object_type_to_be_accessed, attr->obj_type);
-	MLX5_SET(allow_other_vhca_access_in,
-		 in, object_id_to_be_accessed, attr->obj_id);
-
-	key = MLX5_ADDR_OF(allow_other_vhca_access_in, in, access_key);
-	memcpy(key, attr->access_key, sizeof(attr->access_key));
-
-	ret = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
-	if (ret)
-		mlx5_core_err(mdev, "Failed to execute ALLOW_OTHER_VHCA_ACCESS command\n");
-
-	return ret;
-}
-
-int mlx5hws_cmd_alias_obj_create(struct mlx5_core_dev *mdev,
-				 struct mlx5hws_cmd_alias_obj_create_attr *alias_attr,
-				 u32 *obj_id)
-{
-	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
-	u32 in[MLX5_ST_SZ_DW(create_alias_obj_in)] = {0};
-	void *attr;
-	void *key;
-	int ret;
-
-	attr = MLX5_ADDR_OF(create_alias_obj_in, in, hdr);
-	MLX5_SET(general_obj_in_cmd_hdr,
-		 attr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
-	MLX5_SET(general_obj_in_cmd_hdr,
-		 attr, obj_type, alias_attr->obj_type);
-	MLX5_SET(general_obj_in_cmd_hdr, attr, op_param.create.alias_object, 1);
-
-	attr = MLX5_ADDR_OF(create_alias_obj_in, in, alias_ctx);
-	MLX5_SET(alias_context, attr, vhca_id_to_be_accessed, alias_attr->vhca_id);
-	MLX5_SET(alias_context, attr, object_id_to_be_accessed, alias_attr->obj_id);
-
-	key = MLX5_ADDR_OF(alias_context, attr, access_key);
-	memcpy(key, alias_attr->access_key, sizeof(alias_attr->access_key));
-
-	ret = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
-	if (ret) {
-		mlx5_core_err(mdev, "Failed to create ALIAS OBJ\n");
-		goto out;
-	}
-
-	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
-out:
-	return ret;
-}
-
-int mlx5hws_cmd_alias_obj_destroy(struct mlx5_core_dev *mdev,
-				  u16 obj_type,
-				  u32 obj_id)
-{
-	return hws_cmd_general_obj_destroy(mdev, obj_type, obj_id);
-}
-
 int mlx5hws_cmd_generate_wqe(struct mlx5_core_dev *mdev,
 			     struct mlx5hws_cmd_generate_wqe_attr *attr,
 			     struct mlx5_cqe64 *ret_cqe)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
index 434f62b0904e..038f58890785 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
@@ -334,14 +334,6 @@ mlx5hws_cmd_forward_tbl_create(struct mlx5_core_dev *mdev,
 void mlx5hws_cmd_forward_tbl_destroy(struct mlx5_core_dev *mdev,
 				     struct mlx5hws_cmd_forward_tbl *tbl);
 
-int mlx5hws_cmd_alias_obj_create(struct mlx5_core_dev *mdev,
-				 struct mlx5hws_cmd_alias_obj_create_attr *alias_attr,
-				 u32 *obj_id);
-
-int mlx5hws_cmd_alias_obj_destroy(struct mlx5_core_dev *mdev,
-				  u16 obj_type,
-				  u32 obj_id);
-
 int mlx5hws_cmd_sq_modify_rdy(struct mlx5_core_dev *mdev, u32 sqn);
 
 int mlx5hws_cmd_query_caps(struct mlx5_core_dev *mdev,
@@ -352,9 +344,6 @@ void mlx5hws_cmd_set_attr_connect_miss_tbl(struct mlx5hws_context *ctx,
 					   enum mlx5hws_table_type type,
 					   struct mlx5hws_cmd_ft_modify_attr *ft_attr);
 
-int mlx5hws_cmd_allow_other_vhca_access(struct mlx5_core_dev *mdev,
-					struct mlx5hws_cmd_allow_other_vhca_access_attr *attr);
-
 int mlx5hws_cmd_query_gvmi(struct mlx5_core_dev *mdev, bool other_function,
 			   u16 vport_number, u16 *gvmi);
 
-- 
2.45.0


