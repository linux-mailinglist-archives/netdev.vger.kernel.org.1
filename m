Return-Path: <netdev+bounces-118736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D53952958
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4231C21CC1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE46176FA2;
	Thu, 15 Aug 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOrO7esS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432017839E
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703115; cv=fail; b=lcTmC9IKJlJeJMCNI4lI8h08n0wFXwYwMa/pPBfNPrXsAX8XknKPS+FuPvbr0qoEWVrTHrLDXyzG/ZYQP4Bx4HMDWeEBVD4nCWsYbYlDMg0IAp6T90s++SvYhgeaOxGq4V0ZprivxkGytAm8xqzZsdHTbxPzeU4S4Y7haO1hz/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703115; c=relaxed/simple;
	bh=lDSA8zofTDjkLDuvb4aaybMz3vkifkcOjUdKsX7dg2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA3IMmdKV/6e41GcjgwedcYYIZXkTOWZhcRWEpAY0XRE5r4zGw6OmspchZ0MJFdEJ5+e8YKueTukyLz5pbuuN71a2XqkCau3U8gj4iwfwvWo0PXNM0i/2osOQFz2tHRhFQQ5F08whC04R+MWd9WqCT1TGPyIfFRfbOMQ/4EVqsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOrO7esS; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwV/FVUdbvHdJCRzSMyvixLqvFILIqANeCso9pCQDZfw/G6eLJ0D3igII+doy5rMmIamF070b/ZgpVBcFrBbNXbs8iXL1TYtIxM8BR7XjNhZv4Pw23FInGPi7SsCxc5GQ4bwxSWYksqRnPmHEKk+HtKZaMkfVpg6QyLUqDVm6q39RAABtlAxrKgusRsv1VQsdJIq2aywh3X7VuQ+yXGITqo4ZvyYKBluXuAHpVxN/U9DxiN2Mwe9AjMHBS5JMySyTKeyk2oW4cXImivZdYWQ2dE5YT3pVNNGEel7MZY6iwCBnlgNGaU5Ho0wYGTXQmizzBM9n0AUMRkrJjKRZIISog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwIfJ8S7YR3M0nLfI0R4TNtWeYB2JD7dzT9mfDP1m+g=;
 b=paRk0hhPipKxfpuA7+2JJc++CbmrawOUcmxMGyVHQCfJ83MUJ/3fBEXJLotpEObPgAbdXIclwRqHTQq0ohLu09G/R7fHJs8CAFVbGdISY8nxzFmwL3vupCT9HzRaIC2MuiL3ZnnNJEJQz/64dN7/WNtY74z3O9MjNdUktVjCiGXmnLa7B7x1AD84FE2LeCMi+GAHEUUzl+J3MC1P+UGfYaTo9OoN/I6qTRpTJPAOVM4BTQXoOE3kqlH4F5Doh8x0zBZVSBl25+oyd1BqpXml92yOWIoThWyub6u/AgTSxb/K0VGFVILk+1yjRaMBjB4vem424T5XNbKMndIw7IBJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwIfJ8S7YR3M0nLfI0R4TNtWeYB2JD7dzT9mfDP1m+g=;
 b=JOrO7esSI1WwARihfmfyrhFDlujGf9udxgNGnVekOu4n3ZJgBhfhdvLOgqasQYdxy8Sin7DVrgJJEYntqLiPu2iEWHvXrtMDvTGWveG8+a/Wk0y2U+dvqSGvXUt02VuMLLKzg0n6fdDcJkychzcHg9bPpqa50MiMbJryHt2pRgPRvvhe+nXrUFlJEbjm6sMJrolOUmQunAGOoFQKtYCBdFKViJ95W4Va42TaHKXDZHr4xBCOa2aZXY2WuWxIRwriA4iAZxmTEefmxBnm7/p9+oJgldwcwmjTsn6p1emAid9Hx5VZIWfC30DY0HisajE3li08DD4/uhhENfsFLVSgkw==
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:25:08 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::a3) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 06:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:25:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/10] net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of mlx5e_alloc_rq
Date: Thu, 15 Aug 2024 08:46:56 +0300
Message-ID: <20240815054656.2210494-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 03302f0c-593b-42e4-b535-08dcbcf3023e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ST9UaXYeZsK/F32EvLaRTICPAvDkk1yZwwm+M++kzCHwsEhbZczg6bULIvqU?=
 =?us-ascii?Q?M8EuJYR9UzJuznpUA4RW0NDiYD9QyTt6xotYT2NBzwkZnHjwvYK8QK6ntZfg?=
 =?us-ascii?Q?v7E1tBH7lHsMZNXAaGcMARUt2BYSiQyX+T4uCBnemUDNzR1eFKlG8gRCCOxC?=
 =?us-ascii?Q?wvEo2zIBfRVLAgn2qU52u07jBWjTYziWlGH2RJ6TkDZQ+FR/WWPtbUt/9UPc?=
 =?us-ascii?Q?r6P9gG91zKrR717D3rofYkYtfI4DLGfKPZRyGSoz113TkkR7oMJntu19vgye?=
 =?us-ascii?Q?nH9lTe/TUFWrsnR74fS3ok6mQdUg9hbgVU+7pDQ8dHGE9cnmGM/TYd3BBTrp?=
 =?us-ascii?Q?+48mLU84wmqZbiNo+NgYRQaICnIuDr8V+ltD1ywv536LswM7a4xpaLLKDWsX?=
 =?us-ascii?Q?q+EuM7iYk3wHIHX/lz3hhvSc/93zfVSi5g4z0YAPDCOVavIqM+ehlmLeY5Bf?=
 =?us-ascii?Q?it477wMgrHBvE/W/ro88HalnaTvSjJXBf2sXu4ctaNASmy6pMs9SimkrDpLU?=
 =?us-ascii?Q?NbGRsYTq5FJktdTqwcz0Lm1+95PR3v1mNArdROccIcV5+iupW8DfraJtl7FJ?=
 =?us-ascii?Q?hqLoZZVYrXrz9NNAGFZv1POupIF4pYj2VwuMnv/Dkrjv8zIRIiUqWNLf3RMM?=
 =?us-ascii?Q?AwCxNcCuYy+CkIgj8l+EdC4ax8Z5Qpl7XEqyOapHcqxouTzetJJdPw214WDo?=
 =?us-ascii?Q?oBeQQpw4UyPJ8e0qJsdGwAfbyMYRaefAYdPqggG0b9RXuTD4iJp1eZTawyj3?=
 =?us-ascii?Q?KVEdKXy/+qQ0HknYjbJ6LIdf0NMaZ0dCwASJ3Ej+YHeBvWlhrF70snYAL+7g?=
 =?us-ascii?Q?d9+1U6rQA3kGFByW+nKM1SGdl773fBzCOlHJ1Jb5DuHdoY797b8HKyvUF1l4?=
 =?us-ascii?Q?iC6kHasujAcrNIejNX5z756UGC/et3GyQyT1l32giaG/6gXynqZod43wUM3P?=
 =?us-ascii?Q?bHWIcFCqvovUsdfr7XObUehmeWI3oujkPrrDe2nZtht6pFXFc62hDJO5KXFC?=
 =?us-ascii?Q?LSeuVfIWGE3qQMsZmMq1kvcjADk602KhQdOSPApb8l+2vrcFBH7o5I4egfBl?=
 =?us-ascii?Q?kGtzVkwDPuAFRaHcYzmnt8CmEXZplOvznvOPJboKRFtNTQfPUPutAhsNuOvf?=
 =?us-ascii?Q?ewZ4J+HyLa+xIdEiP5jNj/z3AlxKfAsKtvF6snUlZpLpGQIoWXCSqtYBj2Jy?=
 =?us-ascii?Q?uy40R0L23dDBKfCSBwrCVgc7SSAVFy7EOuTjkuwvuQdBbrIYT63RFylO70Pm?=
 =?us-ascii?Q?nYZ7y2H8lbFHp7ENfb2a6AqaCtl/410YdDQPTJNs26onBz2Bi/UjYWFfMnjh?=
 =?us-ascii?Q?+uJun15VQRlYKnspS5WJSd5XC5X3vlzXQk2F5BaGvqZmWkbWDr3DbNhEPcvM?=
 =?us-ascii?Q?eWCl3qOSW6M6Dzrpd52E6zNibyQS86CBiglmJC548l/lGKVAuWju8FrD2q0Q?=
 =?us-ascii?Q?pYiyGeIJC72dkvhmIHU89Q/VAcoVvQLa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:25:07.7694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03302f0c-593b-42e4-b535-08dcbcf3023e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

mlx5e_free_rq previously cleaned resources in an order that was not the
reverse of the resource allocation order in mlx5e_alloc_rq.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6f686fabed44..621c7451d029 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1016,30 +1016,31 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 static void mlx5e_free_rq(struct mlx5e_rq *rq)
 {
-	struct bpf_prog *old_prog;
-
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq)) {
-		old_prog = rcu_dereference_protected(rq->xdp_prog,
-						     lockdep_is_held(&rq->priv->state_lock));
-		if (old_prog)
-			bpf_prog_put(old_prog);
-	}
+	kvfree(rq->dim);
+	page_pool_destroy(rq->page_pool);
 
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
+		mlx5e_rq_free_shampo(rq);
 		kvfree(rq->mpwqe.info);
 		mlx5_core_destroy_mkey(rq->mdev, be32_to_cpu(rq->mpwqe.umr_mkey_be));
 		mlx5e_free_mpwqe_rq_drop_page(rq);
-		mlx5e_rq_free_shampo(rq);
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		mlx5e_free_wqe_alloc_info(rq);
 	}
 
-	kvfree(rq->dim);
-	xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
 	mlx5_wq_destroy(&rq->wq_ctrl);
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq)) {
+		struct bpf_prog *old_prog;
+
+		old_prog = rcu_dereference_protected(rq->xdp_prog,
+						     lockdep_is_held(&rq->priv->state_lock));
+		if (old_prog)
+			bpf_prog_put(old_prog);
+	}
+	xdp_rxq_info_unreg(&rq->xdp_rxq);
 }
 
 int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_counter)
-- 
2.44.0


