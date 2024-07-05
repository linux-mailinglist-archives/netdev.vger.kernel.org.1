Return-Path: <netdev+bounces-109373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A35C928295
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11167287CB4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C87B144D07;
	Fri,  5 Jul 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ScQqmwZ/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223DF145325
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163765; cv=fail; b=qpkZ33lsUl/7VEDE5H53V3bVIf2voal1Dzg0tYgQHPMdns0Py9NlZZzfeW5zDu7SEd9J+lZQjCD7KjG3gUHcPM6l/Ns+b17Y5wzojciidR+288oPDYl76zIZehxn9O+JZHKLJI+CQCZ4b7RmXaEVWrK4Am2ykAOYPehxw8llH3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163765; c=relaxed/simple;
	bh=NXqyCbm3M/3uO/LJkiD7zifcUf2AiOp4RcMoh8yHr44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzCeVxpSuV2Gin0m1hIEj3wT1QwlK0m+YxgLKEOhPuEDfCFjRWP9Jxoa+qhEL0hoLrnJAsIU+lOA3VGQBfzgoFQggNP6EC6SrA1uvU0ObQRhVYJfL652N9wF+iim1eZuyUzNgVclvJ7GJEFYfhWZrd9XVX4f9BSjuVyiu/2z5wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ScQqmwZ/; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2KnaeHHYpgnYaxhdiB/qByeL6QDxF0Z8VrwcODr+y+VeZvpzUxNzj7pXfaEExUg1VLHI/iwheG6Dp94qVoinyLdZWoy9wOo3X2D1rqY2qJhEs31Kc9q8FbTsadGUMYPIXOCx2r+MVcJlWL/DdG+PcghnQmOyLKDltQ5MHxq0O5qgqM4CM0dru6NfKdi67zDzrj2iHDAXj3ayujkUA209BT5UUwyeh1MRE5JBtbPifHj15Aa1vli1sgzEG2YgtC3mm1JIE9lPskmj24VdqxQ6qwsPmyL7K0L8eG0iov3ljevUY7FwI+tOYScHwnUkVfteshtfiS7RrnHnXaM8OhC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJarBeswd38mN62Mm6QnYaddXOnpgbyw7M7umv68Qr0=;
 b=Fi49Z+nCnSPQJuj5na/oTd8tqyeU62W58IAeEZYwsBeUP4kdrK/VAV6E6f1Gyv/itRyzmdUYR52Li9i6mQXEBytShGG91LVZ18UJA5sJztEgLC9iIYaGl40wOx2Zy9nfVU34PzuRJ+2hoUA9WIIW/MnMTpesdN8bc5WCH7Z6sogkXo+uqi3vJ5bdO/hoxVOIH1TOql6y52GFwKbbnQHup8OGlFvv/gMbML+Oq3zM/wrhS6M5BKkVIcx4QwIiYGkHy9qIpQhAI2N1FR+qfz1RrR4rv6dbwR+HASf5tpXOUJRWqM/0Q6xc18vDFqB5YQUXfMmsTmMv9O3FkwJyda765w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJarBeswd38mN62Mm6QnYaddXOnpgbyw7M7umv68Qr0=;
 b=ScQqmwZ/AzjIKp7Dy9V4mXpZUh8w4o6D9H/v+wQFnj6c52UJn/GkLZhLHM1IjfjyH/CGEnsBV2JUzei/tdQvPLTDTxkZ4cteLsExCv9sC2F7sd1tXnp1EQ85Y4dT+51jdBv3/aOsnPOKj8CKTCm/dWtGxWwoWxG+YGxCczhkSLd21n79EqFn1yDHoVmmEPhihsS5Qfa4oCYpkmcL6Iantxklwyx72KeI2x33NkowXUkUrJL0CWjGriibE7Rk0CPglmKiXN+N5hk/lwpatNY/1EiQw2axo8YmEGilPCFqCbTnl0wce4San+Z1CnhU7mx/xK+4+84ZG8IVUjQi1nqM/g==
Received: from SA9P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::31)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 07:15:55 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::4d) by SA9P221CA0026.outlook.office365.com
 (2603:10b6:806:25::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/10] net/mlx5e: SHAMPO, Add missing aggregate counter
Date: Fri, 5 Jul 2024 10:13:56 +0300
Message-ID: <20240705071357.1331313-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 618464fa-acd8-44f5-cb01-08dc9cc24f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ax3qrZYfh9P639YGbtBTIrRViDDQULB06oLaOjCi/WkDKvOEvR90rt7pgHXC?=
 =?us-ascii?Q?352LWwHLuEeKXhGIud3kCoPUBxl4QyJ6IBZjVcfmcyUKuWNeyq16KvvDa6GA?=
 =?us-ascii?Q?e0rSRm+rEJguelw7ytHiG6UWOswBKM1fujcKOwhizAscwGnA8Fltf8lC6edQ?=
 =?us-ascii?Q?Utp9aVYd9IwJBIpqIc5GJblyk2ffHh74ASsbeIDy24ThMS1HTFHt5ZxpXQSk?=
 =?us-ascii?Q?tO60B+KiBU1Y5LDGwUSazvyAZVcGfjz8fet/gHhZCNSpIQHs71jhIgWqXxxN?=
 =?us-ascii?Q?yVqwL1z8lQwfjf10KoW3HDvs+A25xIeaP+4Hwg21IeBuaI/bkqGR3fD1Mfob?=
 =?us-ascii?Q?WUHtBDHsTq1LhY+9ZTZgHqUOw2OKEAL05jrpuqk5lKmzDmDJaYUj1hY5p6lB?=
 =?us-ascii?Q?ingW13QBdL+5d+cdomA/arc4cy1+FIt0K//VKrm6cMgJNl2NlvkWih7wLcgL?=
 =?us-ascii?Q?zO23KDqKZdM0cPTcsu2/Uh7KQyTjTOBnv5YHSKwKeDsbiKDlPp/b7eaD5P3V?=
 =?us-ascii?Q?VMN0gom7G5C0+jU622BjCGT13EqIWsKr7fSr+Q64Yv9WnKui1ogM30DLVA9q?=
 =?us-ascii?Q?SatTd62ReC1xju3VVSE41kfMLV4LfuJ9aJ9ofLIkKzFdAn4LpL9J7KbZCr6y?=
 =?us-ascii?Q?NaFtgMDOCtx8wHZRTxxy/naY0i0b40vaqIZjQ35Qua5u3dghz0mQZkuNb1sN?=
 =?us-ascii?Q?cRGbhXL+7JsXr/BqqkLw0YA6e9LY7tUuDKBY5pZbCzFoSq915MCCR4LjYwvf?=
 =?us-ascii?Q?gGc/pPCYgkPhPw4kkJYf0VOUJLUwmOkhpmYx8isyRxxYTD7ntq8655TjUSYr?=
 =?us-ascii?Q?N3ClfnYsnso96jWOY0IhlA8Hi7hDZ37Vd1Ez4DwRSe3uPl02q2yy3dFJsXbi?=
 =?us-ascii?Q?0dAupQJK7WkdqFTn2MemBxzAsxX8e8OL4O2HkU+BC7IYWp/aFTNdoQbaToYo?=
 =?us-ascii?Q?tJ9fSyQmHqlazWDDmK5xUyzzUF8x+GblhFz2+Md72kn/wsamK9AKt9WncfKg?=
 =?us-ascii?Q?5/669E6K6Lkf02gRob6RtuE3XL95ROTDO0B3jWebNZwxq2ZofUD5pZ1UqCUv?=
 =?us-ascii?Q?h8SEVaVD9dUb9juiJ0N4p+l3xdLUVnHULnzSyxe610Pi+EvZcasr1asDp9kD?=
 =?us-ascii?Q?Qc09ZwAa5CNI3T2dn88pLC6obwgXaDZDYXLw7mEkNdrzl/J1RvM2dmjlscG2?=
 =?us-ascii?Q?9BbrTYm9CyjZWzbnHPvLSNkYG9P1yjH3f6obZq0orL/uRRW1rZmJ36l9JSsy?=
 =?us-ascii?Q?RAaVmZQHzCrhUDriXYemact7EV1TwKdlb/7yCStBcEjtYyRc4OAPrNs0BvBC?=
 =?us-ascii?Q?fZU+lhMqFhFx1amxuC2AWvJZoFVMRnJL3qG2ZeOX3SUICptRHES2lrlP9hq5?=
 =?us-ascii?Q?NSL+VLKRLKo4dmQbWvi1AtEi4/GCFlF7ydodPYUjHwkd+g8Hu0qxyoDbtC/a?=
 =?us-ascii?Q?gO5B73KafYaPsrO37jkrrSr9ElVkFW7C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:54.9135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618464fa-acd8-44f5-cb01-08dc9cc24f76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

From: Dragos Tatulea <dtatulea@nvidia.com>

When the rx_hds_nodata_packets/bytes counters were added, the aggregate
counters were omitted. This patch adds them.

Fixes: e95c5b9e8912 ("net/mlx5e: SHAMPO, Add header-only ethtool counters for header data split")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index db1cac68292f..e7a3290a708a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -142,6 +142,8 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_skbs) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_large_hds) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_ecn_mark) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_removed_vlan_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_unnecessary) },
-- 
2.44.0


