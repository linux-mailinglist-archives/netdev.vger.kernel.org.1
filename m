Return-Path: <netdev+bounces-155732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30579A037B9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E5B164BA3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AF1E04B8;
	Tue,  7 Jan 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mnguo3EF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE51DFD8B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230172; cv=fail; b=atzlOVHitGokXQEjoG2Hrr/6J/DnjQVc8UvsAqHfLIq0DjZchhpeGNHtura+nX7Y89NjScGWqYSgikfTH2WcoRxm98SjZSq/v/Cu2vbDiFsIM0WeYHqZ8R66/3rASy1wjcWS5EfTIqw06r8dho38HsuvhyvycXkm3948TW4xXn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230172; c=relaxed/simple;
	bh=St/XKmC09DsKhG33hRYvmY4g6oAgSJX1fPkKsgDw+vA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar4yZpMfwkDzyRIW/eJQ9xLS2Om/mm5WZvDJGnyajcQ/ZCftFoCQP5MOVBhflARUbSNwUVsJTnsxVzqhMt52jAaLnooR8bf4qAEDBiDCjHOLHhoVj+LdOOS/56nL5Bu8CZspQNxmaY2eh39VkqiydXKLsRuRMOhiQq5a9blPYIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mnguo3EF; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5knAWz7w3W1lvFVg2XJo2IiEGVI+3+X8MzNV9W6+XfVnjnavoGlmTxGH2U8BqhMQ2L+5+uhA6jk/H7s1VppTn/2dSpa0pmepfCpsj8hq8LV79Lf2nkRtqv22g8t9BC2gPS2JH2O9YxO2aZyEJksNQTrpyVVFwpIgs9Igtv8fbhC4+rH0YDlkxGBNKf1ffoSw6sFkUL5rj8V4tqg/93/rtn0CE5a/SoVCGaF0TP7mf/prgQ70iSqgp3FhtvUX+y5ff44YHx34CQUY+K1YXbnltopQt1dnXnrRmWWAoOg47LiCplOrTpiPMLWd8YrAr58fCSJrdHTuweOyrI7mE2eyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEITPoxTvNQq1KsjqshK/3xfEL6dPLzdIF7Y/9fNBMM=;
 b=RoVJEJLLwlhnsMIYJDtmf+OnsFS9C1oUQ22QocSWWMYgy/1sQIGNIdGS87XrL5irkg8kqFNrFq/JbcFrbA6EYjo886oAk8UghLcZLAwTRA6awSr2mtGJp/zzxvCq7fDrTEIkSoFjrgclQ5aIz6hwDbztBhm6l7zkpE2O8wZ24Sw6Fvg33hl8RecRd/QUZenP3/tspFyTCok+WrL+0CZygT/NxbJhdwtllI6YZYRqFx7LRJuwKggGCXIKMxYDEJ/RXW8OnCnbvI1l4AcqgF6S3LZhlmGAQylGWNuAUNxBMP4okkuigzf8fxcgq5tpLt2/X3ePi6x4ojuBtCY1HKhZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEITPoxTvNQq1KsjqshK/3xfEL6dPLzdIF7Y/9fNBMM=;
 b=Mnguo3EFRRRXCKJv72uUvTUXlsinNCemX5cdkmy8lODCDzLiRntUPjUQUW5CNv1jfwlvgp75LyZxY8/n6JMjnIUjvPJjls/GegTrBtybXB6XX74t7eHKz0KtLfLVfcnM9bvNATulHmIW9j0Lw8ORSyVy/B2DcOkQX/1Wt4udTMOCuNd/sdr/zxSrwyz1tpa8qSURJN/rJ0H/xbBLTYaSPAwDEvH1K5nt8rhZd5KeuqJYsvu3hCM8Sbl1bZ4bXQBj2MekIID0ay4s0DbObwcElf7g42tXwRjOZXOxnQw8vSsRRMgBgQH54s3g4rshvbOa+9fabyDNTDGY8+SFkDb1iQ==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:09:21 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ea) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:09:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:09:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:09:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:09:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 13/13] net/mlx5: fs, add HWS to steering mode options
Date: Tue, 7 Jan 2025 08:07:08 +0200
Message-ID: <20250107060708.1610882-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9a0080-db33-455a-e0cc-08dd2ee1d3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?453Rwn+0VHeljqwopIe8RiihC69oCPox7vBTeig36JjvGMz91XTk05KBhH8V?=
 =?us-ascii?Q?2FvPS0VasjcutM0ifTkxshw03xJDERn1QgErioPOAsv4RURftVXCACZAhRMs?=
 =?us-ascii?Q?H7rkNxQc1dWxUahMjY0ZmeXGWtcT9vQFjmzMcpXnXjSgcIegwQMdOsatXqDj?=
 =?us-ascii?Q?KRXwzNmh+EXWxwxrMzsVRQujMMy91x0aK8RicMnMObVSAYPV/mGSNwFrjvpv?=
 =?us-ascii?Q?Fbuutu0iuC/46M8ms0vbHOjYLBFzArrzHdPjwVWqEawgOQG1p2gRmOUbvl11?=
 =?us-ascii?Q?dQDFCUpnuFIolxeRhje3mNeON8d97pKP02nIZ5QVpy+Zau4AMGByoEygFeRB?=
 =?us-ascii?Q?u5HzA3KvXaDN2KSK+7A/RdU37z3EODD89cQh7KIpZRGeEK+9K6mX7QkmAfBG?=
 =?us-ascii?Q?bxGg9eE3TpQzYI4uzo+lNQvXqlzOb+QQAXUh/dr2HU48kLaDgM2JGV6PE+6H?=
 =?us-ascii?Q?z9E+oUYtlCO6kEcfl1Admy9MJUKsTyJLg1AMMcFO8NuhlYmr2YiyBHXzg0i0?=
 =?us-ascii?Q?tQl0/cHMJxMATbYjV8v/BRduZwNZ58ZF9JPhjdAB23a9XRFCGBELOYatuSUW?=
 =?us-ascii?Q?S5Yp4zETm+iKTpwAGbqxS9OcrMg1LvlF0PaaYLcDkfJCrC5GQg0QAhvfOT/I?=
 =?us-ascii?Q?UP3xCL1bz/a02PKFinbbYHRwXmkUePz6naKpGaB0To/pxBQsI88HhVslfdCv?=
 =?us-ascii?Q?G1Vy/vdQ8UrvCqTXtYHXmUBG5gOKBACO51JLr/N768sosGdQvzhxWgHiRqqI?=
 =?us-ascii?Q?J/OlkDOhAmEn7NQXZw6f5B1aI8sktwjBy9yTU2skygo1IV0c8BrQE2ctMNGW?=
 =?us-ascii?Q?ZWyDEcWmXFpcJKh+IjeN86YGOXUBScQeyn2QeS/EtxgcIi/snNTUL2Z48DPk?=
 =?us-ascii?Q?4SDOr9Jq6lHrvEilw5cnU7lZPnmuKKSMuyWllAocBK+BMbfhxLyfRcuBpEai?=
 =?us-ascii?Q?DQSzgyZMBCVhLPw1rvcgOyliyqUYCAbBP6/FtBBaYCXIZvFC2A+hsGavi7db?=
 =?us-ascii?Q?A41kjvgP/yTEM6KPPnFlEHqFtz5j4AmzMIZ3RoSevsa4EGB5KHxKiOc5Dpiz?=
 =?us-ascii?Q?xaY4iwNtBilKqNp2mxZfHsJiR8uMtA8Z20N2jrMz9KFpeoV/2Ixh7hHigHl8?=
 =?us-ascii?Q?51Zl2VD2wbGY2BgU6iracJe0FpbQWc8Uq9EuRrmGX/NIvJol0dXBL8fXvgMw?=
 =?us-ascii?Q?uYWRl3zANVhPwbuuayJdZrWitMlkPTF96GugeMJb20faNmxFE6wKc36rqVqV?=
 =?us-ascii?Q?Yzz/GOWp5aZUsSwtDT99luKgtDpiq76UGpl+UDweTzaVesaOF/I38ajkIvWw?=
 =?us-ascii?Q?oSFud5UC5gD5xci1KyYrZLj5FDC//VhBXW3km89ajM4EY7lkZ6SYmmEz3NzU?=
 =?us-ascii?Q?P+Svx0+OPw+U6jdJ4K37eJDNLRinMpd82K2xvWcBLvZHXT4gsO6GOeYwQKvJ?=
 =?us-ascii?Q?wvxmlDp7ndh8tGGaOk5IphB7+wLUiBEVG1SrMrEu+fjJR2PXgSFhzz/rpQHk?=
 =?us-ascii?Q?roY2ECIv7y9EZHk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:09:20.9740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9a0080-db33-455a-e0cc-08dd2ee1d3bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645

From: Moshe Shemesh <moshe@nvidia.com>

Add HW Steering mode to mlx5 devlink param of steering mode options.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 50 +++++++++++++------
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  5 ++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  7 +++
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 41b5e98a0495..f43fd96a680d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3535,35 +3535,42 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	char *value = val.vstr;
-	int err = 0;
+	u8 eswitch_mode;
 
-	if (!strcmp(value, "dmfs")) {
+	if (!strcmp(value, "dmfs"))
 		return 0;
-	} else if (!strcmp(value, "smfs")) {
-		u8 eswitch_mode;
-		bool smfs_cap;
 
-		eswitch_mode = mlx5_eswitch_mode(dev);
-		smfs_cap = mlx5_fs_dr_is_supported(dev);
+	if (!strcmp(value, "smfs")) {
+		bool smfs_cap = mlx5_fs_dr_is_supported(dev);
 
 		if (!smfs_cap) {
-			err = -EOPNOTSUPP;
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Software managed steering is not supported by current device");
+			return -EOPNOTSUPP;
 		}
+	} else if (!strcmp(value, "hmfs")) {
+		bool hmfs_cap = mlx5_fs_hws_is_supported(dev);
 
-		else if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
+		if (!hmfs_cap) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Software managed steering is not supported when eswitch offloads enabled.");
-			err = -EOPNOTSUPP;
+					   "Hardware steering is not supported by current device");
+			return -EOPNOTSUPP;
 		}
 	} else {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Bad parameter: supported values are [\"dmfs\", \"smfs\"]");
-		err = -EINVAL;
+				   "Bad parameter: supported values are [\"dmfs\", \"smfs\", \"hmfs\"]");
+		return -EINVAL;
 	}
 
-	return err;
+	eswitch_mode = mlx5_eswitch_mode(dev);
+	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Moving to %s is not supported when eswitch offloads enabled.",
+				       value);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 
 static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
@@ -3575,6 +3582,8 @@ static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
 
 	if (!strcmp(ctx->val.vstr, "smfs"))
 		mode = MLX5_FLOW_STEERING_MODE_SMFS;
+	else if (!strcmp(ctx->val.vstr, "hmfs"))
+		mode = MLX5_FLOW_STEERING_MODE_HMFS;
 	else
 		mode = MLX5_FLOW_STEERING_MODE_DMFS;
 	dev->priv.steering->mode = mode;
@@ -3587,10 +3596,17 @@ static int mlx5_fs_mode_get(struct devlink *devlink, u32 id,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
-	if (dev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS)
+	switch (dev->priv.steering->mode) {
+	case MLX5_FLOW_STEERING_MODE_SMFS:
 		strscpy(ctx->val.vstr, "smfs", sizeof(ctx->val.vstr));
-	else
+		break;
+	case MLX5_FLOW_STEERING_MODE_HMFS:
+		strscpy(ctx->val.vstr, "hmfs", sizeof(ctx->val.vstr));
+		break;
+	default:
 		strscpy(ctx->val.vstr, "dmfs", sizeof(ctx->val.vstr));
+	}
+
 	return 0;
 }
 
@@ -4009,6 +4025,8 @@ int mlx5_flow_namespace_set_mode(struct mlx5_flow_namespace *ns,
 
 	if (mode == MLX5_FLOW_STEERING_MODE_SMFS)
 		cmds = mlx5_fs_cmd_get_dr_cmds();
+	else if (mode == MLX5_FLOW_STEERING_MODE_HMFS)
+		cmds = mlx5_fs_cmd_get_hws_cmds();
 	else
 		cmds = mlx5_fs_cmd_get_fw_cmds();
 	if (!cmds)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 460f549cc2da..642f2e84d752 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1330,6 +1330,11 @@ static u32 mlx5_cmd_hws_get_capabilities(struct mlx5_flow_root_namespace *ns,
 	       MLX5_FLOW_STEERING_CAP_MATCH_RANGES;
 }
 
+bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev)
+{
+	return mlx5hws_is_supported(dev);
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index abc207274d89..34d73ea0fa16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -60,10 +60,17 @@ struct mlx5_fs_hws_rule {
 
 #ifdef CONFIG_MLX5_HW_STEERING
 
+bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev);
+
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
 
 #else
 
+static inline bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev)
+{
+	return false;
+}
+
 static inline const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void)
 {
 	return NULL;
-- 
2.45.0


