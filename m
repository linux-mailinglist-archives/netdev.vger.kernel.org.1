Return-Path: <netdev+bounces-98625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D78D1ECB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE29B1F22F66
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814816F917;
	Tue, 28 May 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mv1Cwv+w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4E16F8F7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906573; cv=fail; b=cWlBRpiad/Zw359Pt9qiLlX6nPK9SQtOnGdKV6GkKQ0UzlJJGztyBx9Es1pLs67k7hu86FboBWlvCohzScelmpESb7PU48GUSLYYvKra97+2T0y+kURe150sTUAw3ZS3HEkVqVbK4rjTuph2AMzLn+fZuhy02G4lP7Pyi+krE3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906573; c=relaxed/simple;
	bh=t4QU9HWC4PODKG5t6nLrzQLrMpoOO65LCU9kefyKs4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk58WlhqT2T1UNgg/bBraCDpUVcEPgjaMd1YL+Z2CMwaM0o/H7sikYo827Xms5TkKKMvK+Yw7V3NuwTbQN8QUo7odzcNB5F25IxxXnSqieLt18VHxRwPvvroQxklBk8qqohHytwDDkmHjNhyTg1MdSSaH+mdHQRfNGPpBn2I8ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mv1Cwv+w; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVAsz9VUZzmdvr8wl20Ro5dAfR6xSVHYBUPwblNe3i/iyTfz0Y6Hx7v6bF61CTffrdHvsLv+qe7GHmwvA3SOmdpcZ2xeJ1FfesTv2f0DuY8E4VSa1EqKX4EtNVm/t/MxMzDitNddPAFF0G9b2ZbnQixnySZMcLqQCr8oeoW9kF2bidyG2RdU7hKxRAuiXd/syxkI/X7h6Bneylo+wFTZX8R/mpZh57ATs1KRI0pHsa7SL9UTtgMDM0flLrlh4kMtVUibTrO4vixUa4xY0w+dq3yaOMFGZr/coJXxLbH1kX+mj5l9i2b4U5w0tanal8/C6r0qZB1JvQWbJ27FtYEEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9Kr24ZY24F1R8v7g3jKht2MX5C5mpcLWShweLOajH4=;
 b=HyYfUhn40n1tRPs3NDGKBh4BTc3fwwvuI4i9nK0XMjiFtzl+uKuoRooDsCWNo08Bhqp2DTNdRkYiBVKOa8M28nFzgqy41YulGHkkZcWZgjZBGCJUbFASd7lxe2YF2CYVJLqWr4jH9vQAw3VehtPYH8G0SQixr/q7EP1n1vwaTRM+aNwJPPBar5wzW6Tue5tMOvNbDVt2muSGgB8LsX2W8X+SYOyIX9p1cxuWdOMF3s4TPZeECLvoAEymwOjPFL001SmvfgOyxXsDcJ7IBGI1mzwIGpvkRWzVcW3mrRQElGfGHJXPAy292SDGgeq3znIeQUNjCEfp2rTnvcPmAzINMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Kr24ZY24F1R8v7g3jKht2MX5C5mpcLWShweLOajH4=;
 b=Mv1Cwv+wGvsfz3fSdBQgwCNEYFnHPRfWooJUhJL3g8jpZEekks5P3b7rOYjysQUCoXt9it6Gj8MKD1K8fl2xtJgbybUT4V2imgbVdFO1fzT9JdVlCfhXkgMNgG0PQ4IsJLSNYFTLvQ6k2mPxe9JwwPmAOMLeCas1uWXuffUv8Lah4tMbKyQc11vlK13vNDZoUn5Z6+heuIjpR4WXRxEWLrBFYP/2aI3Tc+mqrk89PZ5/MWWIN7ijKncS3Y1THMM3nCHOYRNrjDMCfdFCqnLspi8XWKJe+f4QmjoTfCwZL7H2j8y1yFpV2ptPllIur9o1dIXZ5WoQ4Iz3Ar/KPWEXDg==
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:29:28 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::44) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 14:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/15] net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
Date: Tue, 28 May 2024 17:27:55 +0300
Message-ID: <20240528142807.903965-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfa8b49-22e3-4e02-2bee-08dc7f2294db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+KwGwie92TLeXfN2SqQpRi4qTIGv/0m8hL4H2Zwa5R4xNx6Y8NKFgQq/eQNb?=
 =?us-ascii?Q?S4kP51vJadXqxOV4SBnJBVHg4AarPvGLI3yl2xqUFF+IxunuGkCfDVHm2M8d?=
 =?us-ascii?Q?spiR5ofL+fAg3mq9+sLCKRQb7B5HaiMA7Z5vFWY9vfNwIxkEiRdgRux7tCzv?=
 =?us-ascii?Q?8b2RFmG9fp3O3SynDnlVlLeYG+Nyv9/Yjz7nHKvyDUZ8gYLs9JILsFHRBICx?=
 =?us-ascii?Q?AO6JDfeNbdfXDey/jHNKvOGEIXaefhghZtzVDILD4Pp8/P4QqZXEx2Rx+l0p?=
 =?us-ascii?Q?OB4sQbPDWeyYqfXJPORCw+i5N1WFS4JgaeCsiGHjljMRS94PpB/7xl5XMxVt?=
 =?us-ascii?Q?fLWjtxxCYes6iRKu+43pGyHiYHArtRChnvPHSfCHCVIzbALtroqCw26Z75ET?=
 =?us-ascii?Q?AN+hPEnVQbYKN+oXZ7Vjm14gODbDnPqx9xvd/VT2Uh/NgLoqd4QUTtw08vdm?=
 =?us-ascii?Q?+NZ7Gkrj8Ww7eF0BkGJ0o0IqXEHcMm7LtAMqSfzzdFRBEuhwuQVSWNuA98eH?=
 =?us-ascii?Q?66NMbxEkMOYJEdu4Pu0k819TjBKOyvx6cD9/EmJbFpYw9iwbqNsBvErFUdkK?=
 =?us-ascii?Q?4RUz9gXJB8vR2tTbWh4lZOlZQA5o4XMnWjjQR351/9XTFzyg2rchgb9MxRwe?=
 =?us-ascii?Q?WU/Je1ZM6jr4+IYR+1xX5dSoyuuYvz2m93a3ih6EFAZH6IqZkb86IcoLDgkk?=
 =?us-ascii?Q?QdtAR5BAQe3sMcNyjbdnBe9D0uNFtfKEIvKEc+c7/F9hD8PisN1FyVviT765?=
 =?us-ascii?Q?pznsCVRiuBwqpbdmKNCagYkXzsiMOhj3EFPATWKjMXA0FAhTwHgPv79NMnxz?=
 =?us-ascii?Q?78lCFLZw6ELBlddntLOt9vkGwUJioGFmsxy4tetpEYl/FXUEQ28DQxiqOTjA?=
 =?us-ascii?Q?OWFFzFf64EDlmb6alEP9PWxRwxysFnv4S/bNrK2LR1lakaV768gq/if146Xp?=
 =?us-ascii?Q?uXKzFVkmO8hDU3kyvW+QbWXMRI62W5aibaAHQCqwAoKbU9MJ87COkwwi/kxx?=
 =?us-ascii?Q?bz1++rHwvq4f3LyaCc7EaBuBhhKxtHA0hFR1HD9y7bwVLLlkI4fu9TL5unLw?=
 =?us-ascii?Q?SyAZS2uXxmn+xohOxn5OG2XZonLVs3NlUoPIzTyBied78csYPR0tjlnbxAEF?=
 =?us-ascii?Q?r1VwAir/EAoJodIj1J2KtAb3JYpIbn21b44FwWXl3u12z4HixopqVdnj/Qb2?=
 =?us-ascii?Q?2z3wFa5AfMO+nUaDCi02WsvQv48sg/U55D75mlscMyddou/xHiB7uK4HvZqa?=
 =?us-ascii?Q?LHU6bzdSjZtVM0WSjjsa9UPADTtihUaXC0Wkt9vJfVxRdQkbFQZtmuVG1+AF?=
 =?us-ascii?Q?2ZIu03nMSoioPBChCSp+P8wn6p+KJ429/27s1pe781bkXUlsiWKjUvHR0G+8?=
 =?us-ascii?Q?PJbvgDeDGm7ie8XP669jgAjrjrrW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:28.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfa8b49-22e3-4e02-2bee-08dc7f2294db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

From: Dragos Tatulea <dtatulea@nvidia.com>

When all the strides in a WQE have been consumed, the WQE is unlinked
from the WQ linked list (mlx5_wq_ll_pop()). For SHAMPO, it is possible
to receive CQEs with 0 consumed strides for the same WQE even after the
WQE is fully consumed and unlinked. This triggers an additional unlink
for the same wqe which corrupts the linked list.

Fix this scenario by accepting 0 sized consumed strides without
unlinking the WQE again.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1ddfa00f923f..b3ef0dd23729 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2375,6 +2375,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;
 
+	if (unlikely(!cstrides))
+		return;
+
 	wq  = &rq->mpwqe.wq;
 	wqe = mlx5_wq_ll_get_wqe(wq, wqe_id);
 	mlx5_wq_ll_pop(wq, cqe->wqe_id, &wqe->next.next_wqe_index);
-- 
2.31.1


