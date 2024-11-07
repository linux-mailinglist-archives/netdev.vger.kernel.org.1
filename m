Return-Path: <netdev+bounces-143041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A59C0F3E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708DE1F24867
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFE2178E3;
	Thu,  7 Nov 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="okX1E7/u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF71822E5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008762; cv=fail; b=LGB35HsqSZCUHfRBVABxZrz4SxXgT+kNqfTxnBK5iIOHfEm3TYQhP4TYJW1RoITZ6n1N1qvvLmaRo8wqxx+HbAf1M33xDffiuS9LlKtgR4l+ufT+al7EAb43ALrfCahkZhek5nNOx35olgy0cyH/XTHvQynn3PXRt2aSwbub7JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008762; c=relaxed/simple;
	bh=QvMaBh6pl44Mlj5vxF/L0+/Qz8fbj31k5608Mq4n2v4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgE5ROHuK43FD56KlEeMDthjdG24bAC8dJBIDkEsYqta2A48GTmCr+d1+xJZuq9rqdGBv7WMRGTHZhSIi3iAyDJtmkmRVi+m0QoNH9/cC6fn5KSIc8vtDurCHUa84tfBbAXSPT+ju6XXgoVrGFRT/SD2svOdBdUwOPqKY4Qqay4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=okX1E7/u; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEspMr2zPP2za00/oqI3QNZilIxyDrQr8xkMNeqXunEUf5iAKa5Xl+isNiH3QU6vdoPP5mdMHqzc0wiI8bf+SjDd/leU7e1NWfFFbJe2PPC9MBFIR8+5ANmDVPHPulf7fDGV0fnSssYY26ITJoBH9w26IErMcjJxUmVd5JLIYBQzzguB3548JAjqFHTjbcPEhI1VYOZCGaGd94Iua/pXafDVc5eDqb8HtqgB4UqSHF/sqkBAi2nOzX9HYbV7miytx7YlVlzpryEWzfquhFpQlznc0C06KXMpgRMKAy49XAMtQTLcI3DZBhljF2IbFVo+vkv6zP8z2RAUT3ZLAR89rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhwMnB1+1u3uanFUuzdgeAsR9/uKBLF7sWlcV4eC0ho=;
 b=eY6sPWa9Dkb94GIWEUtJ+CQ6j/KL3srKbq6aqm0KYWrEo8XmB1daeP6kIRQn6PfAASL9dDsPHAPLj1ImVqGpSsxxxitFlb2ZyZX2LU9Rm/xk9TKu1w+3RqXJlVBezf7qDka1E5YfNtmJ2hCvdvizKqvDk83JxrQBzzVdh1iKGqKyZgF0O78z67EiY0ZnjT3iZ6bsEAHRH0VLucxL5luS6a5CMPjJ0cJ6Oio/YG/XIZso3nHaxRok2eLuvxa5yJ5QkB2+JP3W7B1o498Gztz/q2HAwuNVXi6tYGgLzTVsPk/kx36qbzVhK6+PRm0LnydJTSxkU7yaIhO0iZGJSboFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhwMnB1+1u3uanFUuzdgeAsR9/uKBLF7sWlcV4eC0ho=;
 b=okX1E7/uKlkp1PKAc6w9hGJ15FOLK9mO0qkbApbLjMsws1H3pkQxBJstT8c6muXdeEhEL1zgJV6+Ve5q5wPUzPfaA4K6DPFHkIfLTcCumlm4DxqlA2gqJ/i+O9inOwqzMyXaMT7zL5BxUfuE93oqaE1aYCZdsfiIk0d+nCsBm/LFtZBeLoeU51IseVe+7FWQ66lfi3lMTxRt3jF9ldYScc762pOw4vPYepUWt65uM4jp9ADiHNm7wWxCl9dfHLilsicfm3n//KttXY3qc1FL0GLikq8WJKOjeZ0FqTgu1McC4z6lgMH8urrm/LOD79IMfCpLWagT3tc82FjH6o3Sog==
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 19:45:57 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::bb) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/12] net/mlx5e: SHAMPO, Change frag page setup order during allocation
Date: Thu, 7 Nov 2024 21:43:55 +0200
Message-ID: <20241107194357.683732-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: dde3378a-4f64-439c-669a-08dcff64cc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFWaMje6ES5CssiRImALpFNBNRhGUT2/bXWmr9V8e437qb/SDIL4svvazpXn?=
 =?us-ascii?Q?T9Kpm2N3nSRVWw8YkuC26V0fSd8IdSZydyI84KjWIYWJy+9R6SGnTiqYC9uO?=
 =?us-ascii?Q?7OR5bSIIGubA/CsnHhcYVOUZ0g+QING76bi/jD2wwWNqozhpYWfh4YG7pU+/?=
 =?us-ascii?Q?zFcdPqForRDcoF6q38Q5ZhhsbXv6bCIEta2NFSeD5ZEjVL9bHwMFGa+TEgLe?=
 =?us-ascii?Q?NvPYWuIizu0UBmiFZLYj+O3AZCtgtl7rkrrvLvhxDEk1kMAnANUYcwd5hDzy?=
 =?us-ascii?Q?FRM0bD0bI/9ZjqDUWOBKAShDMofji5KkB7dSh5zIQvtDPvENhXFWrI56t7QB?=
 =?us-ascii?Q?lU0rE3+0AfznNlIgJcNw946ExwCrsfI6J1ADZYRSTO7mm+Hp6w9nmj6BZJfv?=
 =?us-ascii?Q?U49syu1jppkcBeqE4uasaRjVDKSG9v5J7s/sqC93HAzUNK04Xg2kZvarp6/J?=
 =?us-ascii?Q?1hfIEHVqgKDnLR787YyMCIB9xi0XlqIbgD7nkjN3hg786AIyZxdL6UwGz6XM?=
 =?us-ascii?Q?0MMRszKJy5BTE0LyqJHVaI3UO4swsi/k/a74Nq/jdALA9UTm0BDpuokfBBwm?=
 =?us-ascii?Q?trbQf1DeOsRnMBytmJ5M1/x06aMfnbAv2chcjaDqxPo/i3V4O9lm85sCIx2I?=
 =?us-ascii?Q?e6cu3Odz325UTLeMejSdX1WdjHKWAHN8UuQ/d9CxNJUF5nLCQmQPDA0eVh2s?=
 =?us-ascii?Q?WjZHzAahuKlzIobUeRC1k5WaWVBMYGGqNFCamf9SyUAF/Ar1mZgFWQDAtnQW?=
 =?us-ascii?Q?BMijnx0HhvvfLNuxMjBpNYUySa+5vcBTM0h9joPo1QXsJaOUZ6m417l2gWWs?=
 =?us-ascii?Q?UGZKM+aRR0+Kjpx3Q9iwU9yJ/Me1AiJYvi73QStEMgaYgMIYNzm2VzAHuDmG?=
 =?us-ascii?Q?kq/2V9DWG4/PCcH0Uvhhi0Sr0J9JISRjhgA5QzMQlWtdNH9VmdFPsBcdh70x?=
 =?us-ascii?Q?Bt8UuvVP1ZFpEq0Z/5jb4PqQS8bjdvBvB6VX59QJuJFkMRmIbRCjf88kgxDP?=
 =?us-ascii?Q?Q6FQbNRWkHHDpYZu8TfQ/eHIK+KvCP6YaCIJnK4JeVr4CgTyXj0JeGqR1+oO?=
 =?us-ascii?Q?pILfPxrfeK9RLQgOvONklv4TgG3expbpbqjc1z5J3pxhXKXk0AVqqDvcrjZf?=
 =?us-ascii?Q?TwHbXWZNI7irTJq1NH0RXG/y4WZvl1qID4E8Ajcq6SPd+cAvxFh1mkC8FwJh?=
 =?us-ascii?Q?dOQhiGVb94iMX7e/kPyQMVnF92jgnL/vwNhx+e5IWtGVRQ+mOygJsIpbalRy?=
 =?us-ascii?Q?O/wwUHh2mZOc4SWNEV8R6nAg6iNWxxotBUQrID5Iz+tzKccTn3S7YiWVrnN9?=
 =?us-ascii?Q?WqGs9hN6/wA08npijSiDPEU0mfjoMHzgyynwm/h4zGJYr28jvgU1v0OCdPJG?=
 =?us-ascii?Q?2vw1UyDy8TGafMnAiB/tEzNrSSm03Haf/ujjz+25s+pI/R6cRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:57.0223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde3378a-4f64-439c-669a-08dcff64cc72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

From: Dragos Tatulea <dtatulea@nvidia.com>

Now that the UMR allocation has been simplified, it is no longer
possible to have a leftover page from a previous call to
mlx5e_build_shampo_hd_umr().

This patch simplifies the code by switching the order of operations:
first take the frag page and then increment the index. This is more
straightforward and it also paves the way for dropping the info
array.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 76a975667c77..637069c1b988 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -651,7 +651,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	u16 pi, header_offset, err, wqe_bbs;
 	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
 	u16 page_index = shampo->curr_page_index;
-	struct mlx5e_frag_page *frag_page;
+	struct mlx5e_frag_page *frag_page = NULL;
 	struct mlx5e_dma_info *dma_info;
 	struct mlx5e_umr_wqe *umr_wqe;
 	int headroom, i;
@@ -663,16 +663,14 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
 	build_ksm_umr(sq, umr_wqe, shampo->key, index, ksm_entries);
 
-	frag_page = &shampo->pages[page_index];
-
 	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
 	for (i = 0; i < ksm_entries; i++, index++) {
 		dma_info = &shampo->info[index];
 		header_offset = (index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
 			MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
 		if (!(header_offset & (PAGE_SIZE - 1))) {
-			page_index = (page_index + 1) & (shampo->pages_per_wq - 1);
 			frag_page = &shampo->pages[page_index];
+			page_index = (page_index + 1) & (shampo->pages_per_wq - 1);
 
 			err = mlx5e_page_alloc_fragmented(rq, frag_page);
 			if (unlikely(err))
-- 
2.44.0


