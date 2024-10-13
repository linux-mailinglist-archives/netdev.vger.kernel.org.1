Return-Path: <netdev+bounces-134901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087499B89F
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31481C20D3D
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22012FF9C;
	Sun, 13 Oct 2024 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qzQaR4ew"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F91311B5
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802008; cv=fail; b=kM5MfgGQRMqOF3CSOav938lfGBBMDxhOTCWrv0tp5t1JpAZhKv8eqLbvKsso9yRW7I3+PmZaGUj02CI0PYLA7hWBonVK/aiQmveHErCy2opFyYgWxYhGuJx/s4FP5NNj/+5EbXGYGFZoX/D1llhEIGNTvsLSraFasHUP92/TJAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802008; c=relaxed/simple;
	bh=gne4HbOWRdvfzMerhuljgp4drublCHnUQSr4o1bnYX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOaH+a0E8K1Q7HvZlkmR34lK0aelK1cK24S8UXOHolwbVq9e3NcZR2W9HyR+XIFc93Piw81sqF2adfc+cbbyKS1w9WE1g3Ih8XXQeZSsaVzJEYQAIKdOwazqwG1LSyVDwJfbuXN06pRR+di5sOrFNQTzvbH236CFTCnk/SX1Hb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qzQaR4ew; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsGU5lWdPT+f9zuKuyou8CoLOjnGrilKKqNnPe4Or9xDtIfzTVBzsZXBB+hNujrNrnofFTxQ/eo/Ypgyjv6IENowJhJvFxvgXj83xUpHt07l78WkMqNJc2ZM0ff8NQVb1w02sN/V2jedjjCK4LvVj1UbvNCfB5Y6+8BP9+UZXDmP5xMvHrvHiKIXTv43SHdsvMSaTPG0sDwvjDmwvfyElth48Xt9WDBPFvMTmKQeJ+JSkUoCbbVSkCbD5iAcJDQYKjKn8SAQNwde2dM6evITPbNX91cUygPGSG32p0oZeVK2YRHc+z6UqBLZdfrbbNztKozn48Vkq50kbWVcikTnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl7/RjmojJ5wX6lOUOU9w+82A7KPvQVosGIyHRUoC8Y=;
 b=pu/2aziUR7ClSJDMVN0I0IWdAueLi17+/Wk2qqBt22Oq9GZ7ZSwy8ofE6+kJKwtW36vx/BGsQLHZz/W1Z7DXKq/qVnsQxEJI+cKlL1Z0KUMfqoqkvAeZ+l2a6g9C71MlGnTz4+iWC0OExVPhcOX4GCL32nzHgrhTkW+tFy/sjW85t0o/Cx01DYsc8T6G2OdTG4InfLZQW+s6zorTRK2aV0JXHzJRqrnygZ1UWLzO9Pk/ECzfUjOLjODw/IeE8yI6uO1HBleg0P65xYFQfTOUCsJ4XWNIM7YvcnEYcy6HnnCGYJruyRRsldaRWPvRCsMOzSxlHbTW9K4YmRcYSt/qMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl7/RjmojJ5wX6lOUOU9w+82A7KPvQVosGIyHRUoC8Y=;
 b=qzQaR4ewWazTtc4oiRAD2I92Dg7RlJVGgIPmoowAqYJVyIwXSJgUz/bs5XTk1ZG7ORD8g0M5AIIY39fhTjmhPupSzHV2KNBewU3qo9bwOPk+54ShLE8pQJRcHZk+UApPXt0UpDJjh0zBFheW1c2SWRqmR09nURfk+08BmrTITJ4txzBlb5dTfbWzwBLdAumcsP3nwNJdk8wG/YKMHZJsKpUbfWf8lBLyrByT9e+Ht30a6aox+QMCzuCTrY7+ADkvvyGMQYDTL5SFT9DnPjpsJpA9wGjvG+CW4W14go9zmgFVQMgMET1irLBqoOoQOlBmqY4nxzEFu9eaLOMj6VQ4XQ==
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sun, 13 Oct
 2024 06:46:41 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::b8) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/15] net/mlx5: Restrict domain list insertion to root TSAR ancestors
Date: Sun, 13 Oct 2024 09:45:29 +0300
Message-ID: <20241013064540.170722-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 40df5ff8-2a81-4f14-0bf4-08dceb52cb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljQ6CceWTEKDzEbcshPg7H1gu3ZkyWe0gphFCgTfbVf45dvWG6t716jGttru?=
 =?us-ascii?Q?se/pi5VD6xdIrj0ILpDdRVlKNAExgiqm8pYz301oZ+3J3Q3JMfIvYdbu6r+m?=
 =?us-ascii?Q?9pDvvL/nTo+ZmpemmF4TVtj3/XT0ftvJ3YZ66HYAcO3g1byZYgZeYIMRoNEg?=
 =?us-ascii?Q?NexZmZGfG1W7FtW/6FyIxC3cExAMV0HTNkzrTXm8VF1fh7IAdIxdPWrdud2e?=
 =?us-ascii?Q?s2lnFYLbl9hq8pDINHtAieLdAdAvmEq4sn4jptiU/TjdBqjFCu6UD9rVeCHT?=
 =?us-ascii?Q?kYOwW53FSQbMAoMkZbbhHmWH10mhu4VjqhgnS5GZSYHR6CZgBvlmngSbPHnt?=
 =?us-ascii?Q?xihAxC6l1vcKXRu7aXOd+WdtJJsB1mUzgRrhgw6uNh2Pd+QQyj691rFURELt?=
 =?us-ascii?Q?wIQX9tdwC6Drs3mvkiAt/qzkuHaeV0pYCHzV7irXXrFLzjAKggMYDpWKjsP3?=
 =?us-ascii?Q?wxoT58VhwO/S7abURUlJPNW/F2mtny1zk6yAVsbE8Mc7TtOvFbJwteWzrPJq?=
 =?us-ascii?Q?nZfUJvYjJHzj2yhXyAcDpkug7UVs7XVZo55ZEmmbv0PwzEpwO2BhanMfXH3k?=
 =?us-ascii?Q?h3Iex7TyLZ1uT/eZBEpiEbVjF0jpiFlVA4LTpKr2IEJ2ovUITXTt9ATbkejn?=
 =?us-ascii?Q?18sMQUoUVPD6GHcXd59iXn3yjS3lPwJsGxE5vsSL9ngu+1N4AW2ckVNaf8FI?=
 =?us-ascii?Q?OZyZf9P5Tq8Ldk8ymVx66xHjfcGi+oBcdDm4MwMpd2ycfj68ny38XhcQymKe?=
 =?us-ascii?Q?96PDt8nnIyp5korgKGP/miLasV5i/eOhe6RcK3uNcOHyScQWGyH0eAlnqjWg?=
 =?us-ascii?Q?JYri4wvN7BtkbBIMHQP0nfYA7QCM3Dwcoq9XT31lESCKn3BmDXCooNrSZhJt?=
 =?us-ascii?Q?SW5DebjNS+I4ns7lEBaB+vwoOgoNon78Sk0xMr52ooHwQI5zefY5O2/Jpx3s?=
 =?us-ascii?Q?z9RvfSYJrXlyh+Vd6cGzwH0rWhYkWt6SA3M3gCh3U9dNJD3tVNCwuK/6uv0v?=
 =?us-ascii?Q?3QORHWW/eb4GVEsfHvlxWL+xFgD3y/mz3omnafMHS2Eb/+tLUekEROQdXEhA?=
 =?us-ascii?Q?APSGoN3PkgT1iQuMH1lcKbhG8jWXaqaXkoZfVVK+Tny3e0hFcWTZ1FXMmleq?=
 =?us-ascii?Q?JG4m5RywgYuHzzs5qkt4iGsDPvlOEHwwN8KhjFQN+OvTiWK2zM45PPUAurPU?=
 =?us-ascii?Q?Ac2V0VWYIS/jkEsAq6QsD0lp/21vmBCRl43I0X73LB/1Al3nsm3Sno26h2WT?=
 =?us-ascii?Q?JR/mC1nAaD5T1SscZi2v7BZ1tWxZnA14kgNDY/4UMnJWUwDsBxR0w/AO1sB1?=
 =?us-ascii?Q?+xfQYXwKTz0hh0KLY7a+lfTxs+zmGRWeNS3gCCuKBiE82QAzfXMccy4sRUW7?=
 =?us-ascii?Q?MyX/MTg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:40.7367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df5ff8-2a81-4f14-0bf4-08dceb52cb36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923

From: Carolina Jubran <cjubran@nvidia.com>

Update the logic for adding rate groups to the E-Switch domain list,
ensuring only groups with the root Transmit Scheduling Arbiter as their
parent are included.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index e9ddd7f4ac80..65fd346d0e91 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -511,6 +511,7 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_nod
 			   struct mlx5_esw_rate_group *parent)
 {
 	struct mlx5_esw_rate_group *group;
+	struct list_head *parent_list;
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group)
@@ -521,7 +522,9 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_nod
 	group->type = type;
 	group->parent = parent;
 	INIT_LIST_HEAD(&group->members);
-	list_add_tail(&group->parent_entry, &esw->qos.domain->groups);
+	parent_list = parent ? &parent->members : &esw->qos.domain->groups;
+	list_add_tail(&group->parent_entry, parent_list);
+
 	return group;
 }
 
-- 
2.44.0


