Return-Path: <netdev+bounces-153481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3289F82C9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AEF1635C4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB41A9B47;
	Thu, 19 Dec 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nWgoBISp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7241A9B2D
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631217; cv=fail; b=Vr0rHD5EVpK7howIfnqKFYtuguPE5+u6rHhIRkxaApjAIJRoD4qDfMg1a0wLtDxWym2QiqnQuaPR9F2GQz+xYl9+4YVYkZmdi/xWb0M2UAh7TeOwde2cF+Cn1cuSAmFkRM88Q4uPSR3CkMnHkLkX6K9FYETDFEa68HzRiDFDCCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631217; c=relaxed/simple;
	bh=D++pqIKqidNsD3DcO5Lz8wswBedt7aL62M4STsJ+Bns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlrGWlNcg5eeS26dnKZ2vMo7DNQgyvJVV7dnnrah3IZURy+mKBttQe+x6T85a+nW1xXEdto5mlZoKWx6I94wPaRMF6l7yc7/zMB2RfwPioghdReYDoQIMq5ZT5LdwrA3biSDVzgDvOVGQEo92yi64wGCM+XWDwj+10PRyFadRIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nWgoBISp; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+WzDi6IrtUZn3k4Is8KzfuEDXBwbxVzp2A/8+qcfslW32a+/YKej832LmqqjED0jrFjpl47mC2GfGZP3J5acAz1mApf3wQV53m0shdZKrAXatgwYC0sIe7Kn0kF1dbTXngOgTKraT0/K/YtMhsSSR1eWgHumrOQ2DXrsJsZJCPs/+v7023rN8q5CA653/T5WUQtibLE2S3pe7sTmY2qSpwefXbr6Sa5BmfnQs/endb8hlxlHegyjmmSyPwbwO6N+tnRKkFPGdSD5e4W01URw12stmZZ0ypYPT+gKBNGwSPxApLIshVNJ4gQTHXu0po8jpInvYHiSd/coTVX8k92sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtsahyL/KZvkitthfk3NMjLH7aEapcFTS+VQ+BFZaVo=;
 b=K4MDn3JkPeFA1ZDfoTSwDpLxg/79aFN66jejN9I6uvd6I0WJT1zUsiDTRmc9+yiMW730/WWUnCwZ3218Y0a6KFOMGgR7ufr89wpFNt/La5IRxSk3T00/FT4cUl4sMsVMuQzlEIfrYj0cmzblxamKSemwoJvlZ0Xe/fDTwQh0gkrAmqU9X9eurAOY4TE3CMbthKITHu/NiQf4Pc+TxI7M9S+DXsxaEQ+AJTcYR6FFpxqgY1uNNdnmDD4YTqrmv92XRxVRU/pKc+e40FJHt63sZvcu2C0ll5TTHLkr0yhxaMSLphlDCMbCHFLwNaLwijOOh36ttxBheGptvzVKiif3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtsahyL/KZvkitthfk3NMjLH7aEapcFTS+VQ+BFZaVo=;
 b=nWgoBISpnyJWlFzvQg10XCnB8xAhrfTU5HPtUs1c59zK68VD1e0PBCa4bBpPo24H5SHWxlTWq4+EOVP4GJBbm8al9sLS5kMcGPp107oebsRtO/WRqKzhvx1tCZczKzviXVw+40l3OIH13PzOW/d1NZm5C+tPmKf2WlwWoRTNlcJAt4rHPlt7N7DQB91W7Th41MWrxnukp8SeP5GrG0XQM4zjfzkq0uuYZexp214F7XSRKw1yKgUBd14n+/ADoNIiKZ5VmGoNfo3DBOTdmHxzvt4dQhi68ld7F2X1PBo/PQbeJB+MjG3RZNAo0ZWL+GfKnyTnhuIjufvseP7AhCrMLw==
Received: from CH0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:610:b2::6)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 18:00:12 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::72) by CH0PR13CA0031.outlook.office365.com
 (2603:10b6:610:b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Thu,
 19 Dec 2024 18:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 18:00:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 10:00:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Patrisious Haddad <phaddad@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V4 11/11] net/mlx5: fs, Add support for RDMA RX steering over IB link layer
Date: Thu, 19 Dec 2024 19:58:41 +0200
Message-ID: <20241219175841.1094544-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241219175841.1094544-1-tariqt@nvidia.com>
References: <20241219175841.1094544-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: f7123caa-fe34-4f7a-44de-08dd2056fbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A7AUloYv1ky73mOkb9EjzvVfi+sNLBcnQ6RKjtsujEP3bLZ9/+EUnqY+N8y9?=
 =?us-ascii?Q?MyF/+IYLY9USAaQAk7zMFm8M5cvUwFzMZkU7B4nihUH8xD1nKD668m9yoy19?=
 =?us-ascii?Q?e2eyTib9HIfWPNGxuacsvinJQlNPeYOeIgLAHlP2VH4oXlfSzz7wYY67SGgM?=
 =?us-ascii?Q?YFLUvjkEd+UnFd2DdG+0wOSlldeumncW1LgJ/snkyqvPSajArorAcBFHWIHs?=
 =?us-ascii?Q?T7L1UFHTOFireJMEIweXjzz5ipszK7W+gJDfLbNM5VuQ+XlDiusmlcpAoxUF?=
 =?us-ascii?Q?xIzMnTWT1orZhdjFQb8sy5CIRnYssalcwphVU8rRtUCZ4XwM31jg22Xrq5D1?=
 =?us-ascii?Q?utmQxbCfQywh2tobrReoSVG6sTINDSnADYIVXeOcxlujIGabC5oWRCCJfua8?=
 =?us-ascii?Q?ddmFdbP27sxlUJaj4XH7vwj+5tpmrlcSN1V6ZAV36mEcDlqbaem8KgGGSuPB?=
 =?us-ascii?Q?Fl13Bn5RndGz2PiM2I6uUArhiTG9uUeBjz5GqTQHBamObTSn2G92wgAD5NNV?=
 =?us-ascii?Q?Wf5h0X1V8GqUkdheveVWYjwjrY87jOfnJt6NMZLbki0hqBC9Z64X1+AmEN5G?=
 =?us-ascii?Q?+5PDIA9MytQCagGuL7F+S5XiHuaOgcaI6Y36V7N0c5Owx98y89vJkQ8Kzy5Y?=
 =?us-ascii?Q?YSG+NvtMbm3u7PRwkIH7WsBjVHNt2ZQfJBNFzxRQgPpTc5J8JHwgqH+Dsq5k?=
 =?us-ascii?Q?Tt3vtSBmJUldiGrLuNy60H9WzhmZXbD6KN5h3rvrSmhobUVgG7Fn1LaL/q6w?=
 =?us-ascii?Q?Ge1Uwvq+L59LiOLU+Ozs5bnxPdfsgaOzpXWERzAwuItD0c7/ETSmoiEK5EmA?=
 =?us-ascii?Q?rh4Si0O/hbsUZjTENEAa+ZnC443mCsZ7TP/2wUCpdTcut3Ve2b+Ot46qKKWU?=
 =?us-ascii?Q?4t/i6uxm3c7DLAqA0J88q4BmbIE4mPFLSNyfM0j0ZSIx+DO3m22ctYuRO7ri?=
 =?us-ascii?Q?Mb74UD/bCxhbVqGC4Bk4DXhsyRExJNmyUQWMWf2rItQ8u1w5yLjZuVfNu0Su?=
 =?us-ascii?Q?WyqqDvku0t6pqk1OKvf1e0sINy8bh3ENlFR9l79xYQaebBYsZoc00cIktuAN?=
 =?us-ascii?Q?fd8fgQxl8F6NlwlKh9hgvqRJBeQHQtaxRfAW7NEQ0HA6otYUi/+IjKNOdTm9?=
 =?us-ascii?Q?295B+wv0L8900yXLeolczs2K8NBG/8lHt9eFWSzVGurs+m3ch5M7q2FaebV6?=
 =?us-ascii?Q?XqajWQLnZf4yoG0Bna6ywVcfJPDT5CSi1STtrC/zbdk29HzvGaboHFJc8JuV?=
 =?us-ascii?Q?7KaXNeuYX2NVbL3t00+hGue/i0jFjsBY19O7V9StPLMCVMu2Q0MHqXIt5kof?=
 =?us-ascii?Q?NokfGsfGZCNEm1me2NA8AyeFzMb5rZG7FyGWAXYYuUl+gU+nJtCYAUgGs716?=
 =?us-ascii?Q?0ZqQMoyMte0RW8im92USeqkXoc9nR4ubQJzWEduBe5JyZLmoATVn+2rO8DWI?=
 =?us-ascii?Q?wBibSJfR2Z+ifBMDA1pRjGINW7kIDEtxZRmhoOhx1HKxxhSZcWoPOXYzeiyp?=
 =?us-ascii?Q?cD/Y93p2fmVpPR4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 18:00:11.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7123caa-fe34-4f7a-44de-08dd2056fbb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

From: Patrisious Haddad <phaddad@nvidia.com>

Relax the capability check for creating the RDMA RX steering domain
by considering only the capabilities reported by the firmware
as necessary for its creation, which in turn allows RDMA RX creation
over devices with IB link layer as well.

The table_miss_action_domain capability is required only for a specific
priority, which is handled in mlx5_rdma_enable_roce_steering().
The additional capability check for this case is already in place.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 6bf0aade69d7..ae20c061e0fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -217,7 +217,8 @@ static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 	int err;
 
 	if ((MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_IB) &&
-	    underlay_qpn == 0)
+	    underlay_qpn == 0 &&
+	    (ft->type != FS_FT_RDMA_RX && ft->type != FS_FT_RDMA_TX))
 		return 0;
 
 	if (ft->type == FS_FT_FDB &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index ae1a5705b26d..41b5e98a0495 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3665,8 +3665,7 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
 			goto err;
 	}
 
-	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support) &&
-	    MLX5_CAP_FLOWTABLE_RDMA_RX(dev, table_miss_action_domain)) {
+	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support)) {
 		err = init_rdma_rx_root_ns(steering);
 		if (err)
 			goto err;
-- 
2.45.0


