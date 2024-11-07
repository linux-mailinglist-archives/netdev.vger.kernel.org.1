Return-Path: <netdev+bounces-143042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABFD9C0F3F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE72F1F23D84
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6690217F39;
	Thu,  7 Nov 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMkNtybj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811E216A20
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008769; cv=fail; b=uCv9epljUni5t0pAmUCKGgnfUBomE/8jigIouGF8xpKp6cU0EEaYgrplj3fvHjH+qC/9sHInZ708ZJw7/gICD5uN+eJ8TJAXZA6Fe3zF7EG0RRMmeAU6DKlTkNus8Ff7Zqo+qMa0sHwNojFR4bHogCvPzFF7Av+z3qIgjeOYX/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008769; c=relaxed/simple;
	bh=WvXQkeWdC1mp2B16wmllqQtitvjvaHg3znZMTepqj9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXiM+Dhqhvvo63IC6rL93bXBzruXFOEOvsBIbqqJpfeK853pOhQnpFywJy3kRc7ZwRJY/qmXF8RlNCtfvJIAL1iDWOtEHbjgHtRt5H05UX7+2rZ++zhTnbfzE/is/tiqqSoNZNosZ9tPsbQZnBn2M07eh3jNYoIz+BN2cqG6RSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMkNtybj; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbqiOAQGFq7b2SfhXVWavkcdT6Jt0OQtjPgBG0RXa1lyE8wVnYlZsa6XnG1Tc//i1s1F3Blqyk2NjasXGSiMBsQ5A/MVqQptloBaRdO1fNcMUxRlxQ2Bg4ls/ZnGs4stXrTxY3XeEWFFKXh0cEtsI/ZFdPn9pVq2+PhwvBNs75FbUr/iiTqxynP5mA3OR9EBQ0wX0hQzN6kxiJ0CD0BqGInVgiwr9dBS9DBkvkVbKHfLw5ij6OAitx7su4M+fZN7H2oslR+8dYbBpPH40O1GQ5MVhJsCssMnrBBrB1xZakCxLUQX7v31facx7YOu4z5Oi4hL/MEWbQ9ppiXZLY3fMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fngkzKAStpMOntV+jr+gOrvTVqEaGlolR4Oo1OBYkWk=;
 b=qFlQkwJkeJ+0UeoTxErhYBP9hu0jUwo2FOsmmp6egRHK9zempbYF0Q3Kdr2NAKYTQatjcWjbx+yiVi4A3qlquyliLzrcgpl8by+9v4Lpdldqadod9hwFdzKTg6N03MxvXAgybtnBCqs1fCiNQ80IJHFaRHfmAod3RiY4mcQZAusrOJms1DdcVpdWbxGVTRzzTE/2D+Y3jcZUXxc+XXrE9I2ClWxBGO/OWMEtOa0q0guAlMKbe/uz+SYFcqm6jy7C5knRrVWkm8g7SNwSoqZLp6wWEoOyb4sJ9NkOkwnOC6WDmo2wqzrJEd14eLVob7Dn2jRP/y4ouFKMPJhp6qfQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fngkzKAStpMOntV+jr+gOrvTVqEaGlolR4Oo1OBYkWk=;
 b=RMkNtybj7ASi+R8y8ITFO5E/SJrbt+JlRlmSgxw1AE/mwOqyWqpab/shvMCYlL1QGBzNh7x9g9AIpw0/0SzGLeDp596+TxNkA/C1gQGdqB2qnljvMUvdCJR7DHdbEt7bBVwxpnSl5ocecQSICZIVEhlbvTNYlZDizBM0zGL9jMcOC7IU4y7wCx6dSLzELd1hcwIp/m+m90c6ck4gCK78/1Rj2jW3lM2ktt+xVFqObrVBwvgpnVB/ahsPrWWahXEEF5vJEPAvyguuqvny6FM3LqYZa/HN+6MCHgTsGVazqOREk3EWaJ8Cmpbfgyvn1RKMimGtovilC9GNZJlk2iArUw==
Received: from DS7PR03CA0160.namprd03.prod.outlook.com (2603:10b6:5:3b2::15)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:46:02 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::df) by DS7PR03CA0160.outlook.office365.com
 (2603:10b6:5:3b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 19:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:46:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:34 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:31 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 12/12] net/mlx5e: SHAMPO, Rework header allocation loop
Date: Thu, 7 Nov 2024 21:43:57 +0200
Message-ID: <20241107194357.683732-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cd5288-b863-483e-41f6-08dcff64cf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mW302nAdPMDY+oJZwVOwKaF5XKN+vR+OYa7tgcxuCps1S8lekuMEbdOLLy5P?=
 =?us-ascii?Q?IKs+CHJU3vxby4tnSRInUR5dwhr86AXA02PKwBbnSwj8/FBfnD4MFi8y5gJX?=
 =?us-ascii?Q?p/grfQUaNAqFA+Mz3G4QGb4bJt/Y5D9HGJGtA+JAhQVa8V9FP7TyRbAUS69N?=
 =?us-ascii?Q?kkvg7GA+KWB5BQPoQtetsrZNd8BXd9zBqXSlxo0aiPM04II5H2RfTBN+MLPC?=
 =?us-ascii?Q?mRbwgiA1ljaVmsHSL91a/ifKmy3pN25anY5MzkvrtNmrMWqihb/Geg2ZXv2I?=
 =?us-ascii?Q?7WEl5Hg/eD16SG91N6YGK2W4QtuFmRw2fNdTNbB7gxxYFWGPQyHzM7Olegqn?=
 =?us-ascii?Q?vwbrZ88C67oFezOFadEQDvkQW1k2Fd2WCkAOChjclJ+NKu1i1RqxJEKnByfS?=
 =?us-ascii?Q?yFaxU094NReQW5m+UsyRzY2Ua7fc14QVJekryI+B2++Z67Mv2VRUInOrVH6P?=
 =?us-ascii?Q?aHJvDo3CcROAPy+UTQJQLqbRIVUGO5LWhnIfp1J8yTdVHP4gucod3ccyo8fR?=
 =?us-ascii?Q?I1Qwluv//sSxgiglZvbl2aL7CArhHEo6RcfSGBcujyYY8w+TDj2KApI4e07e?=
 =?us-ascii?Q?XSRRNvR4ieyIO2fZS2Xl8vc4cQPxplW5+UbecrnQ/4bXvOGHNHCOQNWXQtxa?=
 =?us-ascii?Q?/OWDKW2SLOSXUNwg9WzweHJh+5MIlF5IwQAvlHhM8Oyzg3ST8UTFzHHFoGor?=
 =?us-ascii?Q?EMSWtrnywminH/vJ2ysuXVo9F7qawZzBNsD47HstNPorDrQH6Z6UshDNW6JB?=
 =?us-ascii?Q?9uuMzfTA4a4G6w+0EzTW84vq8vWlm8rGa0r+Eq+ihZGTLlYTitrGRNSHkid8?=
 =?us-ascii?Q?nImTUjY4NA9gz0OJh5LH4QHBz6t126CP3nd+qXenWHsFx6bE0TZL9qIVHEB/?=
 =?us-ascii?Q?le/OyPUg1eOELqY5mukRoRk+niS/1dSqti8fPS+0PgonD8c9zfHjjSbz8X19?=
 =?us-ascii?Q?Mlw8BIQNaWOPOk0ouqBAJBQ516RBVwQkv2xUFOOSGtXXMRT9YxelT1g90dXx?=
 =?us-ascii?Q?VKBwVOFfw8Xg9FCWiiMSEX/WBnYJXvKZoVgBID4wL20RrYa6gLlOdK8jcuLg?=
 =?us-ascii?Q?T3aoIm3xtGJKwj9EgjtUdQtHxZGAzjFelXp0wK5NpD+teqX+j0hNqJBzcRsK?=
 =?us-ascii?Q?2B6G/CF3Dch9ePvVvBia7CWF2lRwvg5wGEBaQIeIZlYCVw/HOrjnt9RSa14O?=
 =?us-ascii?Q?969kbv0mxuSgF+ZQQpKqe7T6ZfxiuVLhNa4hqeo4/oBaiPH2VPRllPT81gaF?=
 =?us-ascii?Q?Xlww8w2cYS6V+vRHu7V80aqjfmeBDBpyb5KIowiY015GWPFEbz1FGZ1v5IlE?=
 =?us-ascii?Q?SUKXxtWFf0eIaJvLnLDtfl1+5hknZacRVna8pQqVjkfCF8jNcpBMOvwrP5Wt?=
 =?us-ascii?Q?qPvDueyWwmtZhXW6c3hzUQB/qpctLCpZhOzAmH1iqlFeiqchHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:46:02.1004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cd5288-b863-483e-41f6-08dcff64cf79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525

From: Dragos Tatulea <dtatulea@nvidia.com>

The current loop code was based on the assumption
that there can be page leftovers from previous function calls.

This patch changes the allocation loop to make it clearer how
pages get allocated every MLX5E_SHAMPO_WQ_HEADER_PER_PAGE headers.
This change has no functional implications.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3de575875586..1963bc5adb18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -666,8 +666,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	u16 pi, header_offset, err, wqe_bbs;
 	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
 	struct mlx5e_umr_wqe *umr_wqe;
-	int headroom, i;
-	u64 addr = 0;
+	int headroom, i = 0;
 
 	headroom = rq->buff.headroom;
 	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(ksm_entries);
@@ -676,22 +675,25 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	build_ksm_umr(sq, umr_wqe, shampo->key, index, ksm_entries);
 
 	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
-	for (i = 0; i < ksm_entries; i++, index++) {
-		header_offset = mlx5e_shampo_hd_offset(index);
-		if (!header_offset) {
-			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+	while (i < ksm_entries) {
+		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+		u64 addr;
+
+		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		if (unlikely(err))
+			goto err_unmap;
 
-			err = mlx5e_page_alloc_fragmented(rq, frag_page);
-			if (unlikely(err))
-				goto err_unmap;
 
-			addr = page_pool_get_dma_addr(frag_page->page);
-		}
+		addr = page_pool_get_dma_addr(frag_page->page);
 
-		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
-			.key = cpu_to_be32(lkey),
-			.va  = cpu_to_be64(addr + header_offset + headroom),
-		};
+		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
+			header_offset = mlx5e_shampo_hd_offset(index++);
+
+			umr_wqe->inline_ksms[i++] = (struct mlx5_ksm) {
+				.key = cpu_to_be32(lkey),
+				.va  = cpu_to_be64(addr + header_offset + headroom),
+			};
+		}
 	}
 
 	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
-- 
2.44.0


