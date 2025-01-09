Return-Path: <netdev+bounces-156766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF7CA07CE9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F9F168518
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACAE21C193;
	Thu,  9 Jan 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxCfqHl3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826321A430
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438868; cv=fail; b=W3gH6T0Bm/yiNdKSE37XtQ7Iw5ePSa5KnilzKrgUsQVtF8vSRg3GCx+ti7sGaLD1YiAzdeTtK9Kq994y/phYE4vtX+72wNzs2UDpYyUR9kEzIFJZ+QnBTCkWzEsQS26A0TvNRD1mkjjHeMrEE+vxFSZaJzdvtJv/Oax+9TELw7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438868; c=relaxed/simple;
	bh=r7zLLTl0Ti/EMHWEdn4tS7cjeHxCA9xGVzRV4yBvtlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRZSif4qA+8QB4cX7zW+I8Sg+4dOUe1V8JnWLlWVnZFe1cdJLfMIRawofVxYXcxprkumM+/eaPh4PC/nr0R4rHQh/ctghEkzUxXehlRRHzY7Qw3JFBEdMfnmPC5XCSOygWZbDvZCJHsZbkFI64fTqdQeHMFu7N0rtIThMAQWU8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxCfqHl3; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHWAP53Q5A1BNSRGHY/yFpAYb54+mwTHvzeoyYDpcLmiGenJajSqRsGQIx8G6yzEPwbswSlnQrih3VjEsYaRAxC8ongoKQhK3Xw4HiYkWJAEI73SyqO0ilop4gwpJ6cQjcktKPrzk4+krA2Yo3ba8AKJ53xDS/it+ZQq8e1t+oB6l9ndm6osW+UhUVPFnQ2fglQXaRFEAqnXO/M96C8XODY1R72mUZJdbiAUaNGhnp1PvvzzLLD5BH4EL1F8MGJJzN80W6nWWd0JIUx1sfjCoq6W9W9RgeOCoh+NYbJXasDlC7q4klglJFUUEL1p4w8vygMh8JmfrqRs0557hGHz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B8HNam9u2jmId9Kxtv2Mboui9q1xJ69jqwej0dPxrk=;
 b=GbFDLdTHwfzCiqgNj1jiJnC3mqp5Tg1pjf7HXP33/EyneOdFNViBKNekf2SInKprWn5T/LnHFQxGNqvbjBYu4PvtpRomSVO3IJabKcZIZgdAjNjEmaPA11bDTVVgHlsQOT3EU/oL2L7WJZisESv+tgHBm6g/kVAtrjsc1SRCtIlleRIFJHkEccsJJcugKJyM01LhVJJze8taA4dKQ8HICfNjjje2IImWoX3dwLwTD1rvmRyoylVAWNV60qwtyzg7x66J/t7kPI6uFTma0YdZ3erObs+ogNAWyZr2UuKe4j+6paN+vv7yO+EU7STG9rvSBlx1o4mPVSPObe1nRUDuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B8HNam9u2jmId9Kxtv2Mboui9q1xJ69jqwej0dPxrk=;
 b=GxCfqHl3EOb+dFwuu6PI4FvDu76eJdzbaWsaYwTs6Dsi0blVdvcUMOtDxxPC+4BzO8srNE7bsOel92PkLDw1M8zRz28PBN3kYR/cXz/PQLwjQWATsU0cElFxrhZCSoAuQYbAA3JD/hU6wv7S5kPLgjsKaI0wyLKAuYTcVsPiM4Fgy5w2dYe0EtoV6zX/9qTK0IECIhS/njGe2WIgyJj8oBaSnMAvIArKywW4tKpMnA1RgPdhU5z5UoGIw+F3jO8mkRfuIdXCBVm5EUtijtNhjeVbOkZlTizqEldGKmGit4DdoI7DzUt0p53vMikqKtTiyXyJLJw24UOA4Yqcio0ypw==
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:07:43 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::3a) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:33 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 11/15] net/mlx5: fs, set create match definer to not supported by HWS
Date: Thu, 9 Jan 2025 18:05:42 +0200
Message-ID: <20250109160546.1733647-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0f6d4c-2eca-4643-4d74-08dd30c7bfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u8sMzlyn5Aa2SrB7Lv9eJu6j3D8m9TJpHFZJfAkNKIWnETeS2gQuOyECrpPK?=
 =?us-ascii?Q?MCEJ91InHVuuSJNFkECqdFMBu35X3M81+GTgwKbVjMrRPoO9/VLWl8Mfs80e?=
 =?us-ascii?Q?O8Hngq8KOI9+PHoJnsDA2vWNYu8pB4pTtfqloDn/T4H5F74CVVpv7a/aik/C?=
 =?us-ascii?Q?kgcV8k58t/IgsChtrNyPgW02ZtZtw6afLqnQsfe/eVUm4/ZgP3Ze4Sn1T+7V?=
 =?us-ascii?Q?DBsyqxFz6Z31CkVWxgA59DLtM6W57ntY3U7tY8Mpxn9JwJuLFZNPVlnvsA1N?=
 =?us-ascii?Q?03Ap2PaJsVJAPKVN4vivTHJErGKPOigjvP62TUraMlcdoj+Ne3lDPfNyUbGz?=
 =?us-ascii?Q?2mvJvDv51j+Doa5CpWQ+D7SWmt+cZQu9M/uP/fxNyTkGL4EHcloC0ffG4Dru?=
 =?us-ascii?Q?p1ooziFoiWC4kvmzf5h3P+lVY/HSQ4yga4WivUz1nqZhrE0lrRdvVCgwziUc?=
 =?us-ascii?Q?QNRa47L9QRM445ojCeOU1zqeMVXV+r3gWCv95JzprtIJ2GSXA0M3l0qoscOb?=
 =?us-ascii?Q?hKIoAhDamPpoyxSbmWzKXRjzZ1agSId5SJDm//rax3rq/zp5GaVVqY7TGkBe?=
 =?us-ascii?Q?i/Fc+efmwLSMcAs5LQ7Py4A+qWKOGkVYkmvKeJz+0sWLZwlPN2h/g/AuvEYL?=
 =?us-ascii?Q?9KgiUTseKyM5uwNtsg6ekpKmeEmv4vlrKIFlPxxzFCyzbXXOWWgYLL5LohXg?=
 =?us-ascii?Q?W7aiiyVXTgDR6O1/A4fD20H0jcokXoN2V2f31lUY95M+hL79EuJDkkNIU5kc?=
 =?us-ascii?Q?u1II3oZQ70r+Xo8MemGDMZvCRe2OaDMwyErgQCF20NvvTApYVWxJVQDF5QNm?=
 =?us-ascii?Q?fxVJlw9qg6MJKSlveCDWYiEnXj+iR0Ll2hTYgT81TE2gd9h/53erwdfsTjuW?=
 =?us-ascii?Q?pLuZggrve14Ym9ujkXPbzPWIH1E7d19N6JtOlavTdCAXBriMG1HztFxUblig?=
 =?us-ascii?Q?gv3XcHhNswfSTJzbeMlH9GIG2eaeoyuYmDdJ9E02zcAk5PxVBwgUcHBEEQ+A?=
 =?us-ascii?Q?7/VplcTsHXuOmzNEcT+j0CHr6xLpNfoGQljiHfWy4eUD8TtDCu9mULhDPvMv?=
 =?us-ascii?Q?neskdmYcFUGArUeEgMGcXs1zKCWWnOUtThVy+eRBFhmPkc/pVWFYx9MXfS8k?=
 =?us-ascii?Q?So/V6Xi4SIJBbbQZDYhzrSWoKYtDa+VopzQXHxxya8wcV8QcoHPd8taflJN4?=
 =?us-ascii?Q?NQK8ZRoYLfUfZjpTMulkedE+c04askgzAuss9PSrnl2sY/RtK5sADxRSfEW+?=
 =?us-ascii?Q?i1e6Se59g3vu1yoE8jkkIjBSHcyYm6/E84uY0jlGAhPegR1zasnOWzEjnhn6?=
 =?us-ascii?Q?GHIQvbqCbAhRZdrM8dKbJWI3otvUk7ITLq8fqX/r02UpTiRpSwKlpacSepC2?=
 =?us-ascii?Q?afHGwvKbVnauaMc5r5ykqQn8hjr2q8eQPfZkx+fC6arkCeU6JNXbfwcL3C+8?=
 =?us-ascii?Q?Axf+J7sxZ4xlStXjuGp4oUoVBWBEboYGr8C/7q4Yza6NN0ppdEVMoKXfz6r7?=
 =?us-ascii?Q?zLfze9Ry7Qd+nNY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:42.7503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0f6d4c-2eca-4643-4d74-08dd30c7bfad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

From: Moshe Shemesh <moshe@nvidia.com>

Currently HW Steering does not support the API functions of create and
destroy match definer. Return not supported error in case requested.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 58a9c03e6ef9..dd9afde60070 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1321,6 +1321,18 @@ static void mlx5_cmd_hws_modify_header_dealloc(struct mlx5_flow_root_namespace *
 	modify_hdr->fs_hws_action.mh_data = NULL;
 }
 
+static int mlx5_cmd_hws_create_match_definer(struct mlx5_flow_root_namespace *ns,
+					     u16 format_id, u32 *match_mask)
+{
+	return -EOPNOTSUPP;
+}
+
+static int mlx5_cmd_hws_destroy_match_definer(struct mlx5_flow_root_namespace *ns,
+					      int definer_id)
+{
+	return -EOPNOTSUPP;
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
@@ -1335,6 +1347,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.packet_reformat_dealloc = mlx5_cmd_hws_packet_reformat_dealloc,
 	.modify_header_alloc = mlx5_cmd_hws_modify_header_alloc,
 	.modify_header_dealloc = mlx5_cmd_hws_modify_header_dealloc,
+	.create_match_definer = mlx5_cmd_hws_create_match_definer,
+	.destroy_match_definer = mlx5_cmd_hws_destroy_match_definer,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
-- 
2.45.0


