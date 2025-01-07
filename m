Return-Path: <netdev+bounces-155722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C96A037AE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7553A5428
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C611DED6E;
	Tue,  7 Jan 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="asdOT7Or"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF21DE4D6
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230132; cv=fail; b=V4zUygvU5GUk1FsZ7fDB4I8BOxwktApn7mspPeU9O6/OezK/ydWurY4Z4Ew8rixpUMl280z0XkswvB7GrFPi0JvMra0VLkhS0H1CN38WQrfwJnCh3eCmEhuAWLdoEZ2T4EVSFdsTWc1x3/Nh7jKPoq5qHfmaZ9xuCdznmcqFF/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230132; c=relaxed/simple;
	bh=piw0xziaMd1gzppogfHr5ShqSPU4TRbfwt7ilORshvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBroFIr66zS4wzkP5d5EZLUg/a204+XyBosQ8/OXfwMv64xk81k+Z4ib+Qr1sGGD2yac0MF5+OFeFN8GRUvaYAWS4+DBVf7CVkv6r7dQf7+1ed2bXz8K+OHz2VjAbhpnmMGuUBjYBBCuzwJvez95baDR4D2Qu3rl7iIKf+bdmUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=asdOT7Or; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTPnD3a/692Z50yoO0/r+2PeR755WHlk+MV+tIC0m2Dljj5rGNN0+xyMrrwpJ7qoBvRKxVypBt7GBhvD4MigSUOrzoRppSA/hMgrW/+WQ/5RzmPSdFEyaiijsUXKfaf3Z30o2spk3DPS9Iw5XwlqnNciQcH19fJfsyGr6OvBOzb5kASJvL/G1KSfQdIsqT1/Ih+xD2juGLwH6DivoLyj1JkB1vyLeIJjUdRw8PLNaabaquSyKZBWwHKYqCCGxaMy2BbZ3CSVuxHyJNFAT8/XVqfDPGP+2lzUgNU1N9NLHkGx+QfkWkCDYaqkzOk3Hd512wQPgHQ8mq/nGNBBjZvHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLpaJXcYjK1G7xPtNEsJTRTSzb7c8IIpG8c4WUNMpJ4=;
 b=urNk6MrB+lkaD8thKVSGcLeXVI5jOiw0c2IujBFLcQgQQjzHpilI92VZe9R3fWISoK1F9gThXgF7O+27pziGUTVmW8e7D1evgWKVFz4tQTpgbtM/okEZ9kKyov/PJJHteiCCav+PDiml3IKSwqv4tj3CNMIATsiHrLX8nMXYevP0Wq5MJAjlH7ag5zPf+KrxBeNFBB071BYMBpyX/4ipqAGJKKOZ8pouZM0MfXDXWXD1c3Z2n7CjWniRz31RqIymj4TusLNYPTCYq23OZZ2AxWwPNNvhqBkZGNkgUrn711IDi9Jt30MeYi0cAnjl0cvfv0herf88uQ00C3yuCwyo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLpaJXcYjK1G7xPtNEsJTRTSzb7c8IIpG8c4WUNMpJ4=;
 b=asdOT7OrsNQ+o9M2iy418KfpT/QW7HvCcAHkLN1wlCgFronr1su7RdDocaL2OTifiFo5IHMVM4dTYSGrzCEBUiNSLgkizZ7XTvhwjW9C+DS4Nu/0H0fJzfgQcAInTd/L3CMbveNwBUZrgl7iUjKoPMdUNVyie6+8M1Ok6/fppLus40g3C8is8uoS1FQdFZfofgEm7RC5F1DfIOxiMFf2touza2244CT9vgwjXKv4xuaxeYDj4POpxJHrW2ei4cYF5eaA01f7uUCIy3Xtk8iy8RuJTZGFWsD9IaCaJEA/8lc21UGPXoOq/hKm0dRrMT0aHNa4vmrRtNJxGdQurD9XhQ==
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 06:08:45 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::45) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 06:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/13] net/mlx5: fs, add HWS flow group API functions
Date: Tue, 7 Jan 2025 08:06:58 +0200
Message-ID: <20250107060708.1610882-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: b76123aa-3929-48c5-8217-08dd2ee1be77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfySD68AVX6HhbYH2bd0VFdgoa4LqxQZIL7ZwnDE3Y9hX3zM+lGnUcZsB6kb?=
 =?us-ascii?Q?qDEwL8djc0Jg9BSlvB8aCm+X1P4za1qrTBllMl3SP7cFGtaMHb248R9PZNex?=
 =?us-ascii?Q?Q33CTv7qP9PgIfro8VxaUG3ed1fEUOVikkKEQ9A5suhuI3yDtPURwMfV4oMm?=
 =?us-ascii?Q?vC2Spygb9zAHKo+GVTfGd7K8ghPwqhLTKp4v1pwmHtINYQdhPVh9ahuV+f+e?=
 =?us-ascii?Q?cizjJ/bNQrUEe3IbOJBskWVeiKxqby/Yis12Gf+xM9Kh4YbP8Qy6aU6tokBD?=
 =?us-ascii?Q?ts9eiZ+rDCG1VCQppMTk4/+buHQ19WSqyeCJjRw/PzSFBk5DfQJLj/IOki+i?=
 =?us-ascii?Q?KKat+7P/s/Yu8BJf7Qc9f72iz1L5bTZ+nICy8x1wP79Ns5u5WoPKazXAmShD?=
 =?us-ascii?Q?Uz3TNI7Kj6Lckt9jPC0D1H0tfpVZ1f9smqWzH4X0cuj4j/kwqdv7p+gjt50V?=
 =?us-ascii?Q?G15mjcWveeCoB2l+3v0wFfvbDoGU6MdHzzk9yCupynRMjMzDwYm47CX+zb+O?=
 =?us-ascii?Q?vO2cfeDfR+eX6b5RDYoXA+KWhuthpsEXi4ncWfOZtnf59ohzPGGBtNVee1SD?=
 =?us-ascii?Q?tyvnL7YwT+NsNydxcMZ5Mua01NqgbfxUQi5lhdFLw6n2btUE8zOn7otQdMBJ?=
 =?us-ascii?Q?buxD56ZWY4yFFrrfUmSv3WQXcE2Vt5I9CBJT1uqtVk4NAy+jRvxE/jWzcsgs?=
 =?us-ascii?Q?F0hNRviopiJcdiw+lQcuF/5iml/1PKtKXBxT4qo8teJkFgKWvUXchvHsPtxZ?=
 =?us-ascii?Q?32IytUfF2CsFtFAVRnWUER8jT7amsXZEI8vgNQDbs/vrbHsq5yWWQ1/G67xW?=
 =?us-ascii?Q?5jqrwT0c4NUBzoClQDEtlSLeCIxWlhCWZm1F7Rb6Am4kHSDvyG+fKng4NxAQ?=
 =?us-ascii?Q?dbnJbHJNxPGdCP9ZnyRYI7RWANwGgrfKrVRdJJFv4B1quSyD+DwVVrM6G1Wi?=
 =?us-ascii?Q?cB3bOx3JfvoaDJR+a0J2EtpuuoCCBFSUq+857YdgGz4AC5IxoBudHshqnqA9?=
 =?us-ascii?Q?Ulat/AmVuTlL7KVtC/rMPURhczd7Rv6huLFemHhmOfY1x0fFQ2/TfZ9dU/kZ?=
 =?us-ascii?Q?2mzEjyA24K+aqH/mDorM6DUW1pQXeMHgrS8rm19LGbbh+S4FxYDze/5pQFeR?=
 =?us-ascii?Q?GFrGjIPELXPMnVCGLZWjYU7ULjjI9C8OrMv8/GO6COy4RyV8a6LzAuR9Cc23?=
 =?us-ascii?Q?6BiQe/OQE+AmRiovm771LXvG4tjHJuTbMybup15xUg9k9kqVe37X2dP1J0K4?=
 =?us-ascii?Q?0J7hYMBV+ax5rPaHSbxhIK27+tZ+sWiLtaUh9simR1NUAdG5SpkrE7nKkF+M?=
 =?us-ascii?Q?QiZC/5GZ4TfFoE/RfxxBbGzmVReBnb20RP/37OZ8LrFyvcPghDIikh7LwvPP?=
 =?us-ascii?Q?7wrJM0nDfEHq95Ev0JIBYrWVzVdFYcGwqvL2rcgeoJ19mfq2rbyBxU11nFsa?=
 =?us-ascii?Q?lTZPAjH7xZTV2/FIBRs26y52a5JqqhCelNFSMFgy19OgS4buK8a8s7djITlB?=
 =?us-ascii?Q?hpfeoypQa/EoAY4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:45.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76123aa-3929-48c5-8217-08dd2ee1be77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912

From: Moshe Shemesh <moshe@nvidia.com>

Add API functions to create and destroy HW Steering flow groups. Each
flow group consists of a Backward Compatible (BWC) HW Steering matcher
which holds the flow group match criteria.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  5 ++-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 42 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  4 ++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index e98266fb50ba..bbe3741b7868 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -285,7 +285,10 @@ struct mlx5_flow_group_mask {
 /* Type of children is fs_fte */
 struct mlx5_flow_group {
 	struct fs_node			node;
-	struct mlx5_fs_dr_matcher	fs_dr_matcher;
+	union {
+		struct mlx5_fs_dr_matcher	fs_dr_matcher;
+		struct mlx5_fs_hws_matcher	fs_hws_matcher;
+	};
 	struct mlx5_flow_group_mask	mask;
 	u32				start_index;
 	u32				max_ftes;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index e24e86f1a895..c8064bc8a86c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -153,11 +153,53 @@ static int mlx5_cmd_hws_update_root_ft(struct mlx5_flow_root_namespace *ns,
 							 disconnect);
 }
 
+static int mlx5_cmd_hws_create_flow_group(struct mlx5_flow_root_namespace *ns,
+					  struct mlx5_flow_table *ft, u32 *in,
+					  struct mlx5_flow_group *fg)
+{
+	struct mlx5hws_match_parameters mask;
+	struct mlx5hws_bwc_matcher *matcher;
+	u8 match_criteria_enable;
+	u32 priority;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->create_flow_group(ns, ft, in, fg);
+
+	mask.match_buf = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
+	mask.match_sz = sizeof(fg->mask.match_criteria);
+
+	match_criteria_enable = MLX5_GET(create_flow_group_in, in,
+					 match_criteria_enable);
+	priority = MLX5_GET(create_flow_group_in, in, start_flow_index);
+	matcher = mlx5hws_bwc_matcher_create(ft->fs_hws_table.hws_table,
+					     priority, match_criteria_enable,
+					     &mask);
+	if (!matcher) {
+		mlx5_core_err(ns->dev, "Failed creating matcher\n");
+		return -EINVAL;
+	}
+
+	fg->fs_hws_matcher.matcher = matcher;
+	return 0;
+}
+
+static int mlx5_cmd_hws_destroy_flow_group(struct mlx5_flow_root_namespace *ns,
+					   struct mlx5_flow_table *ft,
+					   struct mlx5_flow_group *fg)
+{
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_group(ns, ft, fg);
+
+	return mlx5hws_bwc_matcher_destroy(fg->fs_hws_matcher.matcher);
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
 	.modify_flow_table = mlx5_cmd_hws_modify_flow_table,
 	.update_root_ft = mlx5_cmd_hws_update_root_ft,
+	.create_flow_group = mlx5_cmd_hws_create_flow_group,
+	.destroy_flow_group = mlx5_cmd_hws_destroy_flow_group,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 092a03f90084..da8094c66cd5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -15,6 +15,10 @@ struct mlx5_fs_hws_table {
 	bool miss_ft_set;
 };
 
+struct mlx5_fs_hws_matcher {
+	struct mlx5hws_bwc_matcher *matcher;
+};
+
 #ifdef CONFIG_MLX5_HW_STEERING
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
-- 
2.45.0


