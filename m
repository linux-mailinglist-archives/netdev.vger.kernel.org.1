Return-Path: <netdev+bounces-143043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A59C0F40
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A5C1C2221D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE910217F4E;
	Thu,  7 Nov 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFIJ+jwH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C321731F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008772; cv=fail; b=VW5KsCGtNN0/YsuVX9xoVnLxbyvDivmhECd14PTJZFAgKJSaKpkd2Njoiw9t4hUqpYBCNdaOEIGcP4WSD0q/cjwlZ3sj4XBfz87fSthZra++i9W3GzRna9+mXtfBtDozPodj8RrH869rojChf6lfZ1aQYEk8euRBY3cTegjUhl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008772; c=relaxed/simple;
	bh=IgBda9qh9ykbPc8MTnsIZkhLGhar4f45XoJZTXWZ7a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDfwuXEJahndk46JivkdxhWJb4zGH1G16dKGmFacM5M0U0fX5iBBvvDn8mecORz9+zn1dzzVWzm2im8Xh55UJTtWgadoPF1pqbWiBDPSTnBEe07YNVG6j7BnFgqUz/5mOrQzBQNF7qzD131EvuGLZCqF3+Zh/PqcSQpwUwP17Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFIJ+jwH; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqWhuqPVyLMFIheqWzjsDyoEEAtFgEomQiUiPi5bCUl4uAwajxEGlSh/2vBVv5K3MHWxtOC/yW0F5/m0ysCF9MgbEnkemvVTUHKiVyn2tqzGLd8srIvx3ccTEXyBLSoM2JOSuy6Vvl4wV4CVCXv8pc3bMNSeUF3wSjJ3M95DanxeS1MVSMoFoEOq8E5YbTykI8WCIns78BhDUHvpp2DGtCyyHymMH/MvUsaiMe+60cbGpza6faiBs2n2JzjLTQkOLC5m20t3Tbli6a0wak7ojyvMIrMhdHg9lbPjJmUQjvWIhTfKYQmsmraRCq2gFPsrtc9JBfFjlgmDC4riBReqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON3ziYp1nS6433urhoK2lIdDaTf8mpHJN7IuogC88ZI=;
 b=AtLUdYKW93txXbZa0PAl/t+UaaJmgf+VRpajeYx8/njN/qQrHIAfdnc8aiFrhyHPKjuKHPSTBX0g8R44EfsE1DORGTSie0W343Rrh1AQlV540UzeU4oHHBgN4pzVe64gOdflCVeciM68jborKhgxOP30m9l1arV2q2uy/Vo/bQPKuXsQeoCIvwzrw3wFgoTidc5sARzZUU47iV0FHqwQxnOek0P9kB3w6/Go44q0dCgJOS+miQaGDnf0gNp61C6oQchO0tgABPFYKAPzsbIrfKoRLmtPrrunjABvL/i6T+tKqNKIQMli+plIVCquPilB/6NpDkpC4CsCp1oHAUPMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON3ziYp1nS6433urhoK2lIdDaTf8mpHJN7IuogC88ZI=;
 b=BFIJ+jwHrCXE7dUa8aXiUXcWiUZoY0XDFDa0Mn6shGMbRbHrHhcLL6J+wt8ArTzyERLkeGp9mKJLS21V/LbV+Qr5LdyRfwo6iQpWxyo5KfPt+tVyoZgJm1B2b1vjDtf/6MIoA4GgbfrMh4BOWnm1POufEixeXcRRAzkUIdvXihuqg4Hx4O0GItno3CuhSFaE8VpfF1UOadMIIR2SrF8kxfE5dMOz/cHkneKSUdpPZRqj4SI+UcB+637m6nRo2yqD+gVPCacr5YqFibQ1tfmJaYWsrCV01ODhs9yZwBLzJf5hTer4GM2GcmtHusPIEL9Pmn/eH1BQb7E2s3pWIJV4pA==
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:46:01 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::48) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 19:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:46:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/12] net/mlx5e: SHAMPO, Drop info array
Date: Thu, 7 Nov 2024 21:43:56 +0200
Message-ID: <20241107194357.683732-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 678e9c03-7740-4f03-b6fa-08dcff64ce78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2riPm3rLyTxjgYh8vGKR62MKqgagHkfK8l2Vc/vWIXO7tYvAUsWJmOL2ZG5O?=
 =?us-ascii?Q?lfVzXo+LcjwD88xYwrp4Gqvc7CDOycNQQPcFdK+ot20TIwOMOWd0AsE3fENb?=
 =?us-ascii?Q?feGQi4w4sAv4WmHx7xpCfK+uTdPwtBMH1KvTYt/TjY8CEo8Udxu5MYLCVQvc?=
 =?us-ascii?Q?W9lagtMJ4BddvNQQZbxKYdm9KtCCHPAjB/2CQRlb6qsEWWPc0tv+el3R4lMJ?=
 =?us-ascii?Q?lXojTeZgWFMxoJnVsPj3H0nsm2UIS9jafq5g9lzX+UrLCGzoyJ2WU/IgVzY6?=
 =?us-ascii?Q?6kFtuA3BLi2FZmucjHxQyjVvMHfw7gxAMpiKMOx97zd0uA2Jql7lHvKF2qBj?=
 =?us-ascii?Q?24JmX6545NLYYM7SobPP8ssqEb6TW0P4OeDE49YxKvlDzNlBc9iqLHZNHXF8?=
 =?us-ascii?Q?DtqsO5p1+rgXdICO6m+7bQx42pG6o2JsoytWhOovldmURN7skgmGZxMD8a3f?=
 =?us-ascii?Q?RBcuV3mq7msXbH0hIf3rp7tUwOt7VwAnpSjQGFBVzQbDm9I1jNQpgfk3TiUf?=
 =?us-ascii?Q?IAHsdfHQM1NRQSEJDS/44f0zT/kCwGItsrPWEFtlzNqATzUl0dd9wfgxvWLw?=
 =?us-ascii?Q?/hhbf/TZ7pAD0yTR6LdDsCdm6keckwU6DFkVIwQrW4WW/wONkpJRHaRVSjCI?=
 =?us-ascii?Q?ghe5ChhQSJsBJXsmfsOci9/2lR79SpH3bma7ur4VDvhG+dQSxiMB1tgYE3RT?=
 =?us-ascii?Q?8vXHOKV9oFV29REoXKHvPgNrIoeQT/FeztHLhJNMXw4nIJ1ujCA5ic6qUkDI?=
 =?us-ascii?Q?RJfLugOpcFlZqcCLt74nbzojZwYctpQ581XdkolYXlpNwM8saCiMHG5bWB/J?=
 =?us-ascii?Q?dKmxl2llpR14hzzxrpPJmb4+/ZjlRC1jXEodi53K4uvujYlJqBGRNjDqYn87?=
 =?us-ascii?Q?jWx3faQ0efaRiIj3dK5lhjx0a39pIuuunKUOc7s7BsJ+PFWQN+YGf8G6wuog?=
 =?us-ascii?Q?1vo/KDSKQbkURFAm0xXJ9JpwESl38jUDYj3GFDCOBfMrpFyPIrd+qRXmev2p?=
 =?us-ascii?Q?oM1DAxss/10NI6a2cY4LIipOZQF7jfdfCkKj98Fppn0l9XvzollLPSwO6HCj?=
 =?us-ascii?Q?H0d3NeyO5lPvZoh1seYEaIO3fi/z2NavpzZNkZotbNZGmDgPd1e72JV+h4YJ?=
 =?us-ascii?Q?qwsR3PKnYr7o3zPfY5urzokOZr/nyZy3cBi3YdlO7GFfCczRO6VY1JGgYiQ1?=
 =?us-ascii?Q?SLYSmX9LJRp90rwjcBDU9TAJAOlah1RXeEzhY8w/xJohZj095pLgI1bP+ZlM?=
 =?us-ascii?Q?sjnwPzMNr5bSS5BAhqfGjry1Ub+HOu6fp65NPUzIQGzWGrPil88VimfAjnv2?=
 =?us-ascii?Q?73l9ccbn4koXSmfltXTViCC6/TWWjMumoWe0yEOoHncJb0O9We0bx8DMurom?=
 =?us-ascii?Q?Rde1kBXRPt/NY0TRCnQExexB76KsUxNoHjO9W0bgAifjBZtPtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:46:00.4035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678e9c03-7740-4f03-b6fa-08dcff64ce78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283

From: Dragos Tatulea <dtatulea@nvidia.com>

The info array is used to store a pointer to the
dma address of the header and to the frag page. However,
this array is not really required:
- The frag page can be calculated from the header index
  frag page index = header index / headers per page.
- The dma address can be calculated through a formula:
  dma page address + header offset.

This series gets rid of the info array and uses the above
formulas instead.

The current_page_index was used in conjunction with the info array to
store page fragment indices. This variable is dropped as well.

There was no performance regression observed.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  7 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 76 ++++++++++---------
 3 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b4abb094f01a..979fc56205e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -83,6 +83,7 @@ struct page_pool;
 #define MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE (8)
 #define MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE (9)
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
+#define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
 #define MLX5E_SHAMPO_WQ_RESRV_SIZE (64 * 1024)
 #define MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE (4096)
@@ -624,9 +625,7 @@ struct mlx5e_dma_info {
 
 struct mlx5e_shampo_hd {
 	u32 mkey;
-	struct mlx5e_dma_info *info;
 	struct mlx5e_frag_page *pages;
-	u16 curr_page_index;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
 	u16 pages_per_wq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3ca1ef1f39a5..2e27e9d6b820 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -350,19 +350,15 @@ static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
 
 	shampo->bitmap = bitmap_zalloc_node(shampo->hd_per_wq, GFP_KERNEL,
 					    node);
-	shampo->info = kvzalloc_node(array_size(shampo->hd_per_wq,
-						sizeof(*shampo->info)),
-				     GFP_KERNEL, node);
 	shampo->pages = kvzalloc_node(array_size(shampo->hd_per_wq,
 						 sizeof(*shampo->pages)),
 				     GFP_KERNEL, node);
-	if (!shampo->bitmap || !shampo->info || !shampo->pages)
+	if (!shampo->bitmap || !shampo->pages)
 		goto err_nomem;
 
 	return 0;
 
 err_nomem:
-	kvfree(shampo->info);
 	kvfree(shampo->bitmap);
 	kvfree(shampo->pages);
 
@@ -372,7 +368,6 @@ static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
 static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 {
 	kvfree(rq->mpwqe.shampo->bitmap);
-	kvfree(rq->mpwqe.shampo->info);
 	kvfree(rq->mpwqe.shampo->pages);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 637069c1b988..3de575875586 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -643,6 +643,21 @@ static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
 	umr_wqe->uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
+static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq, int header_index)
+{
+	BUILD_BUG_ON(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE > PAGE_SHIFT);
+
+	return &rq->mpwqe.shampo->pages[header_index >> MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE];
+}
+
+static u64 mlx5e_shampo_hd_offset(int header_index)
+{
+	return (header_index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
+		MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
+}
+
+static void mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index);
+
 static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 				     struct mlx5e_icosq *sq,
 				     u16 ksm_entries, u16 index)
@@ -650,9 +665,6 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 	u16 pi, header_offset, err, wqe_bbs;
 	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
-	u16 page_index = shampo->curr_page_index;
-	struct mlx5e_frag_page *frag_page = NULL;
-	struct mlx5e_dma_info *dma_info;
 	struct mlx5e_umr_wqe *umr_wqe;
 	int headroom, i;
 	u64 addr = 0;
@@ -665,29 +677,20 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 
 	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
 	for (i = 0; i < ksm_entries; i++, index++) {
-		dma_info = &shampo->info[index];
-		header_offset = (index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
-			MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
-		if (!(header_offset & (PAGE_SIZE - 1))) {
-			frag_page = &shampo->pages[page_index];
-			page_index = (page_index + 1) & (shampo->pages_per_wq - 1);
+		header_offset = mlx5e_shampo_hd_offset(index);
+		if (!header_offset) {
+			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
 			err = mlx5e_page_alloc_fragmented(rq, frag_page);
 			if (unlikely(err))
 				goto err_unmap;
 
 			addr = page_pool_get_dma_addr(frag_page->page);
-
-			dma_info->addr = addr;
-			dma_info->frag_page = frag_page;
-		} else {
-			dma_info->addr = addr + header_offset;
-			dma_info->frag_page = frag_page;
 		}
 
 		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
 			.key = cpu_to_be32(lkey),
-			.va  = cpu_to_be64(dma_info->addr + headroom),
+			.va  = cpu_to_be64(addr + header_offset + headroom),
 		};
 	}
 
@@ -698,20 +701,22 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	};
 
 	shampo->pi = (shampo->pi + ksm_entries) & (shampo->hd_per_wq - 1);
-	shampo->curr_page_index = page_index;
 	sq->pc += wqe_bbs;
 	sq->doorbell_cseg = &umr_wqe->ctrl;
 
 	return 0;
 
 err_unmap:
-	while (--i >= 0) {
-		dma_info = &shampo->info[--index];
-		if (!(i & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1))) {
-			dma_info->addr = ALIGN_DOWN(dma_info->addr, PAGE_SIZE);
-			mlx5e_page_release_fragmented(rq, dma_info->frag_page);
+	while (--i) {
+		--index;
+		header_offset = mlx5e_shampo_hd_offset(index);
+		if (!header_offset) {
+			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+
+			mlx5e_page_release_fragmented(rq, frag_page);
 		}
 	}
+
 	rq->stats->buff_alloc_err++;
 	return err;
 }
@@ -844,13 +849,11 @@ static void
 mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u64 addr = shampo->info[header_index].addr;
 
 	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
-		struct mlx5e_dma_info *dma_info = &shampo->info[header_index];
+		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
-		dma_info->addr = ALIGN_DOWN(addr, PAGE_SIZE);
-		mlx5e_page_release_fragmented(rq, dma_info->frag_page);
+		mlx5e_page_release_fragmented(rq, frag_page);
 	}
 	clear_bit(header_index, shampo->bitmap);
 }
@@ -1204,10 +1207,10 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 
 static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 {
-	struct mlx5e_dma_info *last_head = &rq->mpwqe.shampo->info[header_index];
-	u16 head_offset = (last_head->addr & (PAGE_SIZE - 1)) + rq->buff.headroom;
+	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
+	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
 
-	return page_address(last_head->frag_page->page) + head_offset;
+	return page_address(frag_page->page) + head_offset;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -2178,29 +2181,30 @@ static struct sk_buff *
 mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
-	struct mlx5e_dma_info *head = &rq->mpwqe.shampo->info[header_index];
-	u16 head_offset = head->addr & (PAGE_SIZE - 1);
+	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
+	dma_addr_t page_dma_addr = page_pool_get_dma_addr(frag_page->page);
+	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
+	dma_addr_t dma_addr = page_dma_addr + head_offset;
 	u16 head_size = cqe->shampo.header_size;
 	u16 rx_headroom = rq->buff.headroom;
 	struct sk_buff *skb = NULL;
 	void *hdr, *data;
 	u32 frag_size;
 
-	hdr		= page_address(head->frag_page->page) + head_offset;
+	hdr		= page_address(frag_page->page) + head_offset;
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
 	if (likely(frag_size <= BIT(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE))) {
 		/* build SKB around header */
-		dma_sync_single_range_for_cpu(rq->pdev, head->addr, 0, frag_size, rq->buff.map_dir);
+		dma_sync_single_range_for_cpu(rq->pdev, dma_addr, 0, frag_size, rq->buff.map_dir);
 		net_prefetchw(hdr);
 		net_prefetch(data);
 		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0);
-
 		if (unlikely(!skb))
 			return NULL;
 
-		head->frag_page->frags++;
+		frag_page->frags++;
 	} else {
 		/* allocate SKB and copy header for large header */
 		rq->stats->gro_large_hds++;
@@ -2212,7 +2216,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		}
 
 		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, head->frag_page->page, head->addr,
+		mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
 		/* skb linear part was allocated with headlen and aligned to long */
-- 
2.44.0


