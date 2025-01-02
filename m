Return-Path: <netdev+bounces-154822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F59FFDA6
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C579918837F9
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C921B413B;
	Thu,  2 Jan 2025 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJm6Fovf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D511B2188
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841784; cv=fail; b=P8UH5PB5lwyIhV+XTftlO9AG017s4og7wTlvmp71FgJMQYDepOtNOUI7jNe7QKEOG4XnrOUvnyaWqPgQJVbkXWv+W+Z146KnW6EA22NZeGGCeTUrfvJgV2BexnudJ2Y0kpaINOg5MOBdia3PzStCEt3VxleXlg9fHV7QqrCITe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841784; c=relaxed/simple;
	bh=w019SdJDaEqthcBBwuZOdvQm2ugKCsnFwGqhOGLnzRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAcbEi86I/4uNfs20aB9kSTPOByQdIAFhQIDUnJMqbRAbeFnhtgeTl3wpRW1f68KzsaTzwVjCWJ2MwsKzByYFByaNQEfma6wEXv8RjPNHho5CDtG+9XgAJWzLYm/7lXIg6aVD7ezxZg76J9kXRRRE2ggEDBjNRS/L+k1HQmbqWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJm6Fovf; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR0c5LCvJlQg2pr2955uVsFKlkvH/fXq7yKOp8wYmDvQ1k2ZzLKAw0EeplNfEforXYncqA3ZYLwnWE+31Ij/ZK/x/BDa3k/+7TFjjkTFMeV7Zra9nmADXiS6/2A+Gul4wxCJg4n5EBKttYGk4Limh6FLUGO1uTb53P4wj3KeTSSRk4HjHzPSDDlmWrAurd7OD/jWjrn/TGgqGI4Y1UTzf7701KJ4LJ9IklWYwpYspdyuLoZyHURlvs4BpvMSAwiF+wtBPLtI6gF1mj4kqWte+OWoLK1Ch/e25sIFoh9m+t1FWMKE9pUOmzPG8I6bASVfDA9TuaBkd/UOKaapvI5V5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZwAa55NklJ1y9F55EZVgsdAJEC9fceIVMBjM3iO3kE=;
 b=CrJZxy7tuFSj/xBy9zPSBSsflnKYkcb52+LMdUl662TqMK3Ov4kjaKvhKWb+XC4bWbjzMECloPUUq8SmSCPDa5NccC5JJBcKfXb25twodT2XHZYdXkawwBqq03b1/tZTyoI46UMpy4D8JR5vzPswFTJxWsb5jSjctOvyDwR9EDp0Srp1sonfL0i7Ag3T8/ecvHEjLp3aeTuQZXZw494yCqwPzTreGIaZ+57akFbL8uxtbhvkMb1nuOhfF4XdfHIxF7of1cAoiO9mHdbm5cBQOnD7PbBS70lY9aXr1tQ4sQdZJtTigYJAvf7MBeDIkyEbrvjJVTA1GorQuMhERjqJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZwAa55NklJ1y9F55EZVgsdAJEC9fceIVMBjM3iO3kE=;
 b=YJm6Fovf/syDTXfa8pzf4a3Tvo38iA6q2fCZXP6wADsXcC3GYEy+aE6yB91PoptR2+G2cdyCfW/EPe6KXtZtNs5ZcpRjbaEdqxKRqmioatboxZTQ04a69/lZhnzcL/A8Hg7jReu3GPWWodMY9dmusjjtXTCzkcM5QfEUCAsv28R7ykk45KJAn/wHqfAZKP+D03XCNAkUB2maqXeFUdCcT4kqHLnthHFJdKKBAxm2UxIsvQ3tNuMvN47cZJ2ipA6mSAAe7TnTeGdAOqKpTsntw8p9w0lGYQ3c12Ju4pfg6dxHoQP/Drt7D40YIpvU5SG5DBV/zC2Wbv6IEw5qCf77oA==
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:16:12 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::2c) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:16:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 14/15] net/mlx5: HWS, support flow sampler destination
Date: Thu, 2 Jan 2025 20:14:13 +0200
Message-ID: <20250102181415.1477316-15-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: d3db3bbb-e39c-4613-b960-08dd2b5989e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxJm1U0lGhz0/tP1NGem67tKHK05QpbUaCeSPk9tHDM0rAdJtLP60/cC9Dei?=
 =?us-ascii?Q?rRtfLkYtb3bEPKrciSKymms3M7WyUlKJjcp/rFcER78ffD/PJg/ULnGR8Fhh?=
 =?us-ascii?Q?ZJQPt9D4Vr/3i9BfwIuR57fXBypDAZOTYcXd4POs/lVffE4YeGvP5/CSk9J6?=
 =?us-ascii?Q?8NEy2uhYDpWe8F/vrjeQ2zWmdRI3b9MfLW62EA7PpKHd4QG1qbrbtztYjoJM?=
 =?us-ascii?Q?tYdLUj7M2FxPOqFpoJzR7biK45fo+i9b/XHgbe28j6XLXT7IYZoJFXMs2rMa?=
 =?us-ascii?Q?T/AhpnXjWWTDLtj9m88AkFnP9TYo6mODPcIshS3Hm1FZZEbtZU1GuztlGayP?=
 =?us-ascii?Q?ly6IOf/KSwAcuZ1XynPQLhXdvbYHWnouZCvJaguNTv6isSaqT9ZwK1sQpLzy?=
 =?us-ascii?Q?s+nZ0sCNRu9Zx+xLcruNXx8eSMYoNQMkzyOv5Zovt0i/yNv/Om1H8B7Q+K80?=
 =?us-ascii?Q?3uc0Cirj2uH9S33Zz6d/s/1l7OAfbhB3kNC5LkCMeRyt4TdWfPclIWPJXu/Y?=
 =?us-ascii?Q?ReCWqq1QdPpWbuEq5T/KqtVaFM8INi+lZ4ouWNl/rymeVmileeeoEl2lKcEZ?=
 =?us-ascii?Q?gAReaL6zkkpbERwR/D76mfUe0ZUT5uVn5WuSgOv+DOmaHy0BWptCh8kneLpJ?=
 =?us-ascii?Q?sC7RIBkxZbxYXc18BlxKIhSJ9AibrvyVPanRetSWuZ9VRlMdujzTKez87LXh?=
 =?us-ascii?Q?b32ho39Aw4LQGSO/+fonhz64pjrs+QyxUxZoR9bBPsbYVscq3epw6KJY1QMf?=
 =?us-ascii?Q?IYprzyQn6kMcWQyZOIjL3rros6wtWcBL84AqaOr+38VKbGZ1P7qKDwXShBrg?=
 =?us-ascii?Q?oZcZkbGVbFO4JeZc+sbkRFTBSzUlhSYtcmp3nQz8R9j/gtbV7AOoswxHfRXH?=
 =?us-ascii?Q?KRwSGVRIFyBMCZYxeAmblqBkrnMaL7WqtzfA6XV4U9Yfhe1BMQvU0dWBhi3t?=
 =?us-ascii?Q?so9EJVuJrCHX8JvMRmn5I41tcBwYeIteEeVLVWeG8X3qjgwgse+nDQFxWFcw?=
 =?us-ascii?Q?78etVp2IUVD4YSe6o0Zj/L7s5MBos29XjCTk+vyE3jJTi4WnKD5vuuEeuflA?=
 =?us-ascii?Q?UkakY4z6EIYfn4GeO36pIKa2bBxtvTR//g33PXhDHfAnq3oBKhRXUo2K4rek?=
 =?us-ascii?Q?d5cKLPV0oNoqcyNG6sCbInNg30m7jm3unYl/SqCie7xITBWxb4+5Uf/CvO1B?=
 =?us-ascii?Q?lqnWODljTYYEy/07VSXIty3s2qt11nPMYDi8SVFscCO1zvzPXsQcoTspmeSb?=
 =?us-ascii?Q?Dlrws4kbsbGRKju0CfZ4iPi10Aw21v8rYNwGRGcN71UGM7oiQy4jfYZzJeyk?=
 =?us-ascii?Q?a82indo+6olEBVkS6OTSdNON7yxTq4TPOrN0iB/un8Cmt6cf/FRmgSnp5TZe?=
 =?us-ascii?Q?c9WuB4mYPQiNxmKBb3fLIyfZk5tlKM121o8ueW9HrzuslHDe1UUEz85GWjlr?=
 =?us-ascii?Q?HCDITMK3RXuYeXXCVAsPhbLpOiW2yYsS+yTscLq3qkWcg/xEl1DVEy6fMHaA?=
 =?us-ascii?Q?GchiB6MjgwfHphQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:16:12.0064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3db3bbb-e39c-4613-b960-08dd2b5989e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

From: Vlad Dogaru <vdogaru@nvidia.com>

Since sampler isn't currently supported via HWS, use a FW island
that forwards any packets to the supplied sampler.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  | 52 ++++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/action.h  |  3 ++
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  6 +++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 67d4f40cbd83..b5332c54d4fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -471,6 +471,7 @@ static void hws_action_fill_stc_attr(struct mlx5hws_action *action,
 		break;
 	case MLX5HWS_ACTION_TYP_TBL:
 	case MLX5HWS_ACTION_TYP_DEST_ARRAY:
+	case MLX5HWS_ACTION_TYP_SAMPLER:
 		attr->action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
 		attr->action_offset = MLX5HWS_ACTION_OFFSET_HIT;
 		attr->dest_table_id = obj_id;
@@ -1873,7 +1874,50 @@ struct mlx5hws_action *
 mlx5hws_action_create_flow_sampler(struct mlx5hws_context *ctx,
 				   u32 sampler_id, u32 flags)
 {
-	mlx5hws_err(ctx, "Flow sampler action - unsupported\n");
+	struct mlx5hws_cmd_ft_create_attr ft_attr = {0};
+	struct mlx5hws_cmd_set_fte_attr fte_attr = {0};
+	struct mlx5hws_cmd_forward_tbl *fw_island;
+	struct mlx5hws_cmd_set_fte_dest dest;
+	struct mlx5hws_action *action;
+	int ret;
+
+	if (flags != (MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED)) {
+		mlx5hws_err(ctx, "Unsupported flags for flow sampler\n");
+		return NULL;
+	}
+
+	ft_attr.type = FS_FT_FDB;
+	ft_attr.level = ctx->caps->fdb_ft.max_level - 1;
+
+	dest.destination_type = MLX5_FLOW_DESTINATION_TYPE_FLOW_SAMPLER;
+	dest.destination_id = sampler_id;
+
+	fte_attr.dests_num = 1;
+	fte_attr.dests = &dest;
+	fte_attr.action_flags = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	fte_attr.ignore_flow_level = 1;
+
+	fw_island = mlx5hws_cmd_forward_tbl_create(ctx->mdev, &ft_attr, &fte_attr);
+	if (!fw_island)
+		return NULL;
+
+	action = hws_action_create_generic(ctx, flags,
+					   MLX5HWS_ACTION_TYP_SAMPLER);
+	if (!action)
+		goto destroy_fw_island;
+
+	ret = hws_action_create_stcs(action, fw_island->ft_id);
+	if (ret)
+		goto free_action;
+
+	action->flow_sampler.fw_island = fw_island;
+
+	return action;
+
+free_action:
+	kfree(action);
+destroy_fw_island:
+	mlx5hws_cmd_forward_tbl_destroy(ctx->mdev, fw_island);
 	return NULL;
 }
 
@@ -1912,6 +1956,11 @@ static void hws_action_destroy_hws(struct mlx5hws_action *action)
 		}
 		kfree(action->dest_array.dest_list);
 		break;
+	case MLX5HWS_ACTION_TYP_SAMPLER:
+		hws_action_destroy_stcs(action);
+		mlx5hws_cmd_forward_tbl_destroy(action->ctx->mdev,
+						action->flow_sampler.fw_island);
+		break;
 	case MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2:
 	case MLX5HWS_ACTION_TYP_MODIFY_HDR:
 		shared_arg = false;
@@ -2429,6 +2478,7 @@ int mlx5hws_action_template_process(struct mlx5hws_action_template *at)
 		case MLX5HWS_ACTION_TYP_DROP:
 		case MLX5HWS_ACTION_TYP_TBL:
 		case MLX5HWS_ACTION_TYP_DEST_ARRAY:
+		case MLX5HWS_ACTION_TYP_SAMPLER:
 		case MLX5HWS_ACTION_TYP_VPORT:
 		case MLX5HWS_ACTION_TYP_MISS:
 			/* Hit action */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
index 6d1592c49e0c..64b76075f7f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
@@ -165,6 +165,9 @@ struct mlx5hws_action {
 					size_t num_dest;
 					struct mlx5hws_cmd_set_fte_dest *dest_list;
 				} dest_array;
+				struct {
+					struct mlx5hws_cmd_forward_tbl *fw_island;
+				} flow_sampler;
 				struct {
 					u8 type;
 					u8 start_anchor;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 9b71ff80831d..487e75476b0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -257,6 +257,12 @@ int mlx5hws_cmd_set_fte(struct mlx5_core_dev *mdev,
 						 dest->ext_reformat_id);
 				}
 				break;
+			case MLX5_FLOW_DESTINATION_TYPE_FLOW_SAMPLER:
+				MLX5_SET(dest_format, in_dests,
+					 destination_type, ifc_dest_type);
+				MLX5_SET(dest_format, in_dests, destination_id,
+					 dest->destination_id);
+				break;
 			default:
 				ret = -EOPNOTSUPP;
 				goto out;
-- 
2.45.0


