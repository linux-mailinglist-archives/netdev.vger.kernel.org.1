Return-Path: <netdev+bounces-135324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93299D896
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E69A28272A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA11D12EC;
	Mon, 14 Oct 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMfc5QLk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732661D14FF
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939271; cv=fail; b=EfFcar3ea8FpDGPkrcHXsHTjhLDeMY6Sl8Q46I1G7kfkLdTydUdjDc9xPr2PbPkxkzpGlzPijBPM23zSjm6P2AfhZu4atVSDMFV+WCGGyoXU/0ISDAa4fgadPT/bheWQ5VPVjp5LvV8HK5Ck9KTflQwp6eyoxM4NbISDwhZKY+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939271; c=relaxed/simple;
	bh=yi/WAt4FKeVEnwXWY1D8NLSIx9Oan8PLGgZu5Fa+NCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da1eMxGSb7zeLRjb0uYFFOmyFGdNf4Fsg2pqXv38nlt2qzXCVhjAI3UF5Nt4gDmfSJbYA1tqSRzlLnhIO8lks4N0WbiEqgBBk4blrJYVn4YtGX+M564OVf4T7ESB+5OQzpxHCIJfQqK1xcJcKfpeBJRxRAxiKd1XvpahvlyXDB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMfc5QLk; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Rxd1+LXj+iolV/b/yKue2tRfPAtpp7d+jqf08e2Sm/ZSgSTyYfAjI9IvqZ+lOx4mNawuZtB1kv2sesOQw9F95X5NLGThiS+OJbAgnjx7cgWoCa3v+9Mw9Sjd4R3Tl1XeSkyjvCXQxPRC3U+0iw5svvdCqzWOLJ+PVo5DCgULQPTiLgwU4Luurk0PG8BGtlBmKrpRycySlbYwEBSdMnek5d6RdswlLZaEnbnp9NHJHa+1j1rw/1W0qQtx4FUXpoPH1f17uFFoHlPiCBzE5djNudlme2f7+LQNlEaFoG8xb4Uz3lo78n3Zpx9MxvCzWueIecxHKzojFuWuPoNlQFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVui3GmxpBP9JDLQnPyA7x/QTjiKuC95ERIXJuNgd78=;
 b=G7SV9GONd4rP6cHNkx0/ESYCI0M6BLU7krgXUfA76uLhMK4rKfVK6RlHxiA1/mzJ4OIsyulDS30TUroX6enXKTg8qLYaBCTFG/pGUlApJAlvgK8l19ldH0X2rDi7L2iL4v+QZs+4ukBOkti6Ha4jo8XTfDc3ZMAgpVcDkl4RWEJOoiF3HJyIDF3+qKUgWP++J9/lqu5Ad4U0SoPmIJL8Vtlr1Cvy3WjgKgcD/eYHOONTThLmldm4UKWCocuXhte+P94Pe5oGLFmf53KdW9wSeKRRpeywRn7BnTEUfpDW5EA/rB4pNC7MzO3wGv7sRaDuw9tJJBJaDBpAPen799HwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVui3GmxpBP9JDLQnPyA7x/QTjiKuC95ERIXJuNgd78=;
 b=eMfc5QLk2v3qEWpd5/eJ6Lu5RwCYaIAwYw3Iud9+qkgs8dGOiKmut2AGdjQMMwHxtNF7qIhnRdNMHZmnidtJ2ymD/k1pRsvbHf+YXaUCmDQACnBj/PLbYzGWQKtwqZXdMRjRNvlzB5nH7P6tGyhUTH30NHAly476hXzpmA2p7sTg/KYTwWynTbKk+rgTpilkh8I6UKBpMD5UuT1IO8XwJ7hnz80SPhbedWGVQF6rcPp9m0rLLxuvgvlapxDNekm5gkkppMtTVpnsM7tQ19XW/Z45gM9YtTjLE+PRLZeXLtSX/i8kpbkyswf1ZRId8ePKsjHfFomJFqrWot8TzRqsyA==
Received: from BYAPR08CA0044.namprd08.prod.outlook.com (2603:10b6:a03:117::21)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:25 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::99) by BYAPR08CA0044.outlook.office365.com
 (2603:10b6:a03:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 04/15] net/mlx5: Restrict domain list insertion to root TSAR ancestors
Date: Mon, 14 Oct 2024 23:52:49 +0300
Message-ID: <20241014205300.193519-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5daf1027-9f9c-4b7d-898d-08dcec926360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?brat3whFHg0zlFc0fmnP20gMrtOia0kw+wPkGtrH4bk3VIxmmPq657D3QV0i?=
 =?us-ascii?Q?fXghtRfWuAup8IABPd6WRkBCjBZAmkc18B/+y7m+cr18rGfS51q6vy6GMeXy?=
 =?us-ascii?Q?jNaUfpEcPhvLOGkO9S/uSSnJZUQ3ei8o4aQSeIM4snVcHi57GN8jCgfYrju3?=
 =?us-ascii?Q?ifTCshVpiCVZ+/HWSvlnYT5KysPqmmruItWj+aPOzMqDNzft1DbVsjIqMzHC?=
 =?us-ascii?Q?EJVTn+Gh5YgfHQ6OqcnFrCsjX7sy/V+J/NgvZ9iy4XALbGe4PdxwIrnGCnb1?=
 =?us-ascii?Q?WaHSdjDQeeI6DS/2SoZAV9SnBvApJkP9RvaB7aNMfenb720/nidussZnNQpo?=
 =?us-ascii?Q?ZElbGtPFsq8wroL3Bzdot3+A9VtPBpgNEM9wlaDvuVQwUErIpKZ1yZ2EEFMT?=
 =?us-ascii?Q?p7/nZ6lnVQ6/uVidWMNLkfniFKXfxzDMIru7/ggMNf3qPy89FY2YWpjZNrdd?=
 =?us-ascii?Q?JUnbaG8GCgL9gIZmI6eFX5r4kvNlSJ8TF4es4GM8Cm2mMlpwDDvJOTc5CaQ7?=
 =?us-ascii?Q?7Z2uf037zOC76pSqDVO9GweOhkMcWIAeb6cE3BJBqMoeYy51Di6ZqtHURDO0?=
 =?us-ascii?Q?AzlyqptJCsdWr/kf1lQA+JQQcoq4nHZkDMc643s9sXGDC10HGFzvKg200CbX?=
 =?us-ascii?Q?/YNO5OoHuWsZvI3Qag+vxU6+DIJAlVCyCdKxISFnarzAWb5gkAp/PVfCgL2V?=
 =?us-ascii?Q?NNOp7bibfGPo46fVAuau1i40xwrRKcPS7t0xroKVJST5NFpy74Zx3pKCXoNw?=
 =?us-ascii?Q?sp3If9kqvA9qpkKp+/0lTr2blSzsdpTb5fXkwx3Z88WmFeghA6bPA4HTZbl3?=
 =?us-ascii?Q?CfSeZYwFw1thxxcuqdFT8UDNlFFGyZ+wWRA4aDerp/MuwFnhibgRPYv+N4rY?=
 =?us-ascii?Q?fcGRNU2SK+3zVrMWCHqQmsSrf8+yGebolkK9dnLyTaMsGRnY4d3Vu6qjHvWW?=
 =?us-ascii?Q?FfQlyLQ2GMwC2ztZwNo8iBSqzdLw3PrCTGRyCdw8yL6hQI711pQ5td24TV9+?=
 =?us-ascii?Q?4Z75dmTz3M5tDuT1k177FhOiGf+xEr53Yub8hxW0u8yM1M03fUwy5/378PfB?=
 =?us-ascii?Q?Kayv1nNMZoLrWcZFC1uTpI6Vf7T9ar2GUdpqrynp8gwalIbl8Lbdf7susQhW?=
 =?us-ascii?Q?tNrXac/m/OB6gdY4cKhwGt3nHcrtgWJZPBd+prsIX0SIbjZ0uziBVhS3nrzh?=
 =?us-ascii?Q?rAq22JW3wcGww4idx1dgsA4H59AHwyAeKITJurKVpNOVZZprxj0pqsKB1Rs6?=
 =?us-ascii?Q?HuYUXL/KCdCMKzrxviOcelXQQOjQ0xhtt9z5F1cN36kKpNFUxOY+R2c96RRq?=
 =?us-ascii?Q?xWU3cRAeBts2WBT8b4Nz9MWoImmbNbrSDcEYfpOCOWQe6vUMJNqH/XWn08Ro?=
 =?us-ascii?Q?Zn/0ABY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:25.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daf1027-9f9c-4b7d-898d-08dcec926360
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

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
index f2a0d59fa5bb..dd6fe729f456 100644
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


