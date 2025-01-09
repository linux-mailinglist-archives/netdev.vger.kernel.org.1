Return-Path: <netdev+bounces-156762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD377A07CE0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606BE188C67A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5C21E091;
	Thu,  9 Jan 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqQU5t9W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A749220697
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438853; cv=fail; b=LU/y+gjjJ3y6O+oRVfUkXy/6Y50w0mKuXMfU26TUHikwyhyN9dXPP1bdM2rOqG3LcdNPNBPyKIAi1AM87Cg1xHbV2IhfezUSqmVoxrar1oiL9sboXsM2G9Dd+W5TTEgPQADAMjPgAYr3V/f+fNh/6zUzvpKNWTm9dZnGOB0h7H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438853; c=relaxed/simple;
	bh=GSit8TEa72aICYZs6LO3+jRnScvJRZGZ/sQbxOLjajM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDF0w2giFYy2ytgRUtsDro+o4Qt2S7a+fMJI7peOIv2oH1Ybpr1ze/KNDc4TCnsBbBrHyHbtbWClqjnZCUQ5COpdmsko6+M4PueOvGAGnamt8ySPzk8hoGTGGVktGg/nQOT+mNIAYAPwU8KU2yoxmES4vaBeh5souJhnGuZ17zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqQU5t9W; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ziuhk2DNIZBKA3G8NWtxud2ihbKnzxiegbG8fTnSHqul4tbrMny7DGuU6HXCIln6vA04B4nGf91NWtN81djP85V0eKe3nOCUKuhmEstcRzTvXeboBVwjSw/H5MKGQzS2C1+Gd6FQfukU08+yFZnxwqJJ4vYVjTufL8FJogt+qF2AyXPzDGrQMbjxL6Etvu8Rp11QfHMovola+2NTIs/QBPoKM14ka9O/LPo/uOlbmzKlVYuXP63zCaI9jcVkHXJRKr7+XfzcVCSNeo82yi270PEeW0fY5mMIdZ0BNcvss9/SlL24O6JlUwqNZ6BVh4PnvEAqsYxSMFmsoALhv3vloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi9v/v8s+YKUxanEBU41agBsKAdCpnMtf+j84CZkFMM=;
 b=DiL1ZzWUNWAgimUq7Vm8eaiE1srZeO02rce92hzJHGe29sAsoDqGvXIRibDJwXPchomviTTY9HhGRdXKy8u2jlFTojm+KmULq5bZceY4ULE0LVIW/hvUpamQLRC/4acG77K5YlYY8MOvNAEfR2HhpKDDx2C1JmzZVpzSW9uOv9mCe7AilqpDLckNOb//aOA2EKmZ4hSbssbEVeHymJ+LgA1wmqNaU2BNgY+R0iOOCMjNaBPWH2nVy7zYbdNy+cjHbx+rTwQGuvo+4UVO68iAvBW3pjGUEc13UUkOORoH3vBi23a8nVnwXneHeDgL15tTqi3IKQwmIjGnbkbZJUyeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi9v/v8s+YKUxanEBU41agBsKAdCpnMtf+j84CZkFMM=;
 b=bqQU5t9WpeaFVaKPF9wWB6+ptaCHpYEOmT2fjs4XYebyc09EhPgPUb/mImZ9y0cIjfWb8DXSCpTRpEiQSpEf+3z9s9eXdkmi/lBShrbqwaETlsoNpBoCyVmdBviHW1YUDTl4rsyhPLd9Q5yIZnrLIY//XGI93Plj3FlNXC3zh00IdljMkGxNIYSuKSnE23mrqnERMk/HMJ4dNleLzNsuS0JsMbyb/WErOCsf/Wn/D6sOoYE4lRyZqK0zM5s9aZYL8ipkYjDdpkDAG51mvFEcLUCCOgUv6Ooo4NVTQeqVD33TFHUSWCGMSXxFPPLFJzXiTkYTiik5++2eN/7Uzeyhig==
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:07:26 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::5f) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Thu,
 9 Jan 2025 16:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 16:07:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:03 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:06:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 03/15] net/mlx5: fs, add HWS flow group API functions
Date: Thu, 9 Jan 2025 18:05:34 +0200
Message-ID: <20250109160546.1733647-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: cab299b0-e05a-453b-55f3-08dd30c7b55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6ZWLOTUx/KDlzASWz/jf2CIM0ltpF7Y6FCqU+4xGRojKriCb8MHqpVVSxj+?=
 =?us-ascii?Q?ab/FD0dgDjH1NUyLh2CHeJhtSpMVGI+pHh2ZeAlB1ZUrMiBnx5Q5OrckAIz5?=
 =?us-ascii?Q?GeX9dmxEGoZYhRWQ9wJvD+3zxlfskkIW7KxO2fvdzml9sOQnwLDrOzzoOwvi?=
 =?us-ascii?Q?1zvdSjOhTI10SIfCpLgTdIzLte4lEIkl1SNGaJid1YUtZKjQiRlPfK7iVFGa?=
 =?us-ascii?Q?L8COyFfYfyQ0mLz8QLktSfhTaqdxS+xPUyRAl99d0ofQckIC0zNPfOZbcpYb?=
 =?us-ascii?Q?cyL+vaHBakq74wsp8hj4nOPSwVN6Ln4rwR19qOne6/TNmuo24bRFR2juj4EY?=
 =?us-ascii?Q?poS4erb7vfpKvs8PeUFPqUBRMwtqpQooi3fedpYm/1lQgyf1D8EDeSPEN5eR?=
 =?us-ascii?Q?nWHEiVeFsf2r6SI4Oz/TAJXryZzFUnCp4Ayqj4ZSuPEY1EkV346hFcGtXHdT?=
 =?us-ascii?Q?850g/uaV/Mg21riL3qT2iZsOzrIb04SKPIypREknOOcnGdIMuO9CDOPlRZDn?=
 =?us-ascii?Q?pr+xdsTD82nrjJp6x4xk0F+QKPyCR4EN1r/5XGl0JzO6CBZtMHtQ2ifqch7J?=
 =?us-ascii?Q?eFo1I8wpMpliku2ogJ4RvwBEcfGhl1clLQUkj1jdeNnxBPEzdbiMO7Hn04hD?=
 =?us-ascii?Q?6WBgHcLcbnWw54hm6B5E3x9XOU62aAS2tZR5XyqKoRLFUzBoqARN1N1eDOZb?=
 =?us-ascii?Q?uwGd5UCxdq2KJ9OBk2zTRFHqvf4gSgdy9x4bGSmy/knFS2TVJ2yvaWNrbbKe?=
 =?us-ascii?Q?p8gt1uyG19NAyslP1Ln00gabXL3SKqMepqW65s96o5YIP+jw2Y2jNV2QKUsU?=
 =?us-ascii?Q?pnJNW1a5Jy9rp0EGFpUenwMhWfDI5QGEZJQdwNaxDQf3EjxVr7bnDzZ1t6tz?=
 =?us-ascii?Q?kGubz1n1A+3uiwCH80ImPPonw0E47I5RcbSyHfqM1OTazwK210DPyWPjSklG?=
 =?us-ascii?Q?poB8U22tdyERqMSyUUYhZ2O+qursLTj0/5G1OUHGKdZcobR4u+TD3x0aBL5u?=
 =?us-ascii?Q?LDKHpJRNKS+mC1E1RckVR+kZNjosbqpfSH8qUn43IsAssxjFmXNmvdp0u8Eb?=
 =?us-ascii?Q?cHz5ExHDOt+4KDfbCcQT8DtII09ZBIftDGkpIVhtyHjQIjHWDGdCzBskunHO?=
 =?us-ascii?Q?z9NZReItRWUtoG4Uecvvf/HCoGgetbKGsE36Cs9XtQzzAEDTULyWFR4OF3an?=
 =?us-ascii?Q?heyMwapAUvCiTqJp47k85E41AeamgqT+74MMU0jxxoyWYa1+TJUZTj3py1bT?=
 =?us-ascii?Q?OkwwegUPAJ9+NSIcz+u0ibdl/ZbTa7nuoihp7MRqt/fJtbE+nuKAx0GOk3E8?=
 =?us-ascii?Q?vYsl/Nw0DPaxr5neGUqwDzAgGd/PwTiCM91lCYvSy/4LC8YyEz5bmm1GYjM1?=
 =?us-ascii?Q?NPOv78T10Zunstt+NLLml+lAEE9mumJx/YxYkLpctb+ywlBrreztIlaOZelP?=
 =?us-ascii?Q?KrUMpr0Wmp/qoKmwxgyneXClScKLNIEcBZiv5MDgqver2AMujs42evxe9/yY?=
 =?us-ascii?Q?b1h99U7HFtJSRRE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:25.4490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab299b0-e05a-453b-55f3-08dd30c7b55d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

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
index 7fd480a2570d..915cd3277dfb 100644
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
index 57d88088e18b..f0cbc9996456 100644
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
index c4af8d617b4d..a54b426d99b2 100644
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


