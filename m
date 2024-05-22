Return-Path: <netdev+bounces-97632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7638CC730
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11057281AB2
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC731487C9;
	Wed, 22 May 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jloxYV0V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E2148309
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406113; cv=fail; b=O+4mDIfs8xL1O1iMzbwFMA819g4/McKBkpTUtsrWGXMo+PYG8WfEkvRapog1asKvUYb4To3sEiUfrLp0210wboIyAzO/tkF3utKI2rBiVCfGenoECSYyDj1gGxNwdCVbu2EHpOlano1BAxjFhGcTG4T/y/OcejAD9ESywasTqE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406113; c=relaxed/simple;
	bh=PDnyrYVCbzA//5s8siNUiDM2UB6P98Y7HJWXbfwUXVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgFZR0e7K5DLALU8htcvB7kwPf1PzXLG5+9xbQ2f91th5OqykEOSrJ3O20Yf/Ih/g/soGFEoYK09aCP3yIGFaKDrbwmTF7M/wBGRvGXCkjrhhw//P1lSk2uwpUpxGjEIYZzQEjL77ABmBgjbXlNStCZBMO5W9RDdZ8Ex2tpe0PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jloxYV0V; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmKK7umEUTVPfESVsO0EdYyYOKiqou4+156yuodhTcMApAvkBwglHTxMVQ1BVy1J1AbUnp2MEUlAqqXt40Xh3cRiJs9eS0U0wrPu+sVwski6EgDbpUnJCBHSvW4arI3QV2sI1gZ4d1Xo9L+2elQh9VEnyEPgihM/9sdfC0Xhvmt4oddeOuNeQc1F3WWNXBtYh/6d70nKaiJrTW+sF9p2vj0WTKeSLT/qeWIRP8frFKMwyHUzZ69U2Pm1XlPE771SsRrTD14HE8UfSUwFVHT3IVo+vf1pbqsERTj4ZLJrd0RUtVHQhHrVIqhp23tij+IFrPJMXs50lNBIKhrUUG/gFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZMN9K8V9Myw2cAB8P5rUfMrSsF2h0upHX5fRIUb308=;
 b=C0DxE5LQoY6ruKikgumlvkUfD1vzbLNi0m6nbovn7svG18B4qrjbLadaSXD0DwuiS/1GW79vc7ssnAEYxINkxumZQcyQdgFzigj+c21Ys7k+QohXqGwZ+4eONToYT62QCWlYfVEAVg3B+rtHh4p0d4n/+coTNO6rXeVQ33ikdu9qKvhvz8dflm2ZuIGNBoI1h/BrpXBHXEPXjJWkpsvuVoq6VpKn973eOIivYuf9/IUr3z0jeHKJ14SRz1xq3aCpu9XiSspL1366Q6YOwvKq8Wq5fOmHtLiXhvGeDqvlGhS2hGuxsRLNBObVqTcN0bA+gk7srKjDrtYX+CpsjlcLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZMN9K8V9Myw2cAB8P5rUfMrSsF2h0upHX5fRIUb308=;
 b=jloxYV0VkVHXcl8k9kNgC4RP2Xn/81axNn4WbzyHdI+dok5OEP/SCtZxaU0SQIiNPFwhdl67UxwNcSb8Nzbx3Q/DK9TBlcfQO9i1YNSztpCJRkpnjwPepv9TA6PhnTn2dlrKjSF4DSf2tV6ujFaUBjew9hF09QNqjAaWD8ZhmVsDxxNkdtrT8jKMA13/9L91Xgb1FJ7GOXxNFXUkgv/UQ31JCRXFe+bbI7O4eFSaa4GrC04hRHNcwLTP5iiwlOyP3CdlODDBe9IwAzaeQVMXbgkbkxbRkTmqkopEnRkJ33ZGyMmIfZP/cDeyJ8bpJ+nDJCTMeB4W9gtCbG/YhfX8qg==
Received: from SA1P222CA0105.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::13)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:28:28 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::cb) by SA1P222CA0105.outlook.office365.com
 (2603:10b6:806:3c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 19:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:28:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:28:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 7/8] net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion
Date: Wed, 22 May 2024 22:26:58 +0300
Message-ID: <20240522192659.840796-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: d42a6fe7-a218-4a5f-7352-08dc7a955b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KudAWJyoAbd2RkZ4aD8h3Ob8K/9wDbZ0CtytSJa2C97DGjTX41U3A9N1M3i4?=
 =?us-ascii?Q?0Bz+A9ALPKMIZrGiybQX4DFFu4vP3epnI5H7CMTb2Ef9xHKSlAiou4/ZAHW5?=
 =?us-ascii?Q?umVrK4qzgkN7mFnxF/WMRXoO1UI4vsds8+iyaArauMDTjFTeJKl1j7J0tkFL?=
 =?us-ascii?Q?PiGEYwB6uyvCY8/GuzZLTHy1bwKkXhq1VsuLAD2FVWx8IYA3n3HPftYbFBw0?=
 =?us-ascii?Q?4Tzp1USVO2mKCjggJa96zMHT7+rLNh0TSs0fswpZhqVg59nQ3oAtEEh3wHxH?=
 =?us-ascii?Q?aaIyYRkDHX2bSylkrUHy/U8snAQHQgEFUzzGDmJ38Nx/s6BHZl7Cesjj+mIJ?=
 =?us-ascii?Q?hAsjoDsIPLMwB00r8ulJKIwFlx9SECuHH9DXSwS0UfYzkIRd9c5vcMCz6Lzq?=
 =?us-ascii?Q?WpuSNU0FLrcWbSU4mtPU8fikKtlA0c7vZSsVrIce8rwCc/Jya1Vu+2yRwv8j?=
 =?us-ascii?Q?zZHpI0TtW33kQlKT6yeliqTTV+EgXPE2JkxM3Gy3FzsUpB/HmPR/SzGVq2Qc?=
 =?us-ascii?Q?eVycNrbDzQc58zUvJyv5oe6wcLt2eNIyYeGL29bFqsgpg/tUoR8Fvc7HaGVF?=
 =?us-ascii?Q?QMmapgrv0pOLRKntU2cLOroaAWpcPKIMir8SJttEL7f4DeDNNK4/DdXjY5Zw?=
 =?us-ascii?Q?oKqkedviO2gnGgE+2Ox3evtjRSgVJ3W+y3uYhj2b/phAPSlUpwGK5fYoxOp2?=
 =?us-ascii?Q?pRiwPzR0WUhtbRxebiljd0Y5LLJnIbmNgqD9r5brSft4tKRJh4+TDAEUtDMg?=
 =?us-ascii?Q?DMxElOWouIYnyCvXYgFU8g0UDdF6H04Ty9jn0y1YtrSB8IcFOuHysGL2UTSP?=
 =?us-ascii?Q?zKUHRbkiZJkfi+N4I7Boc1MCkXL+rndQZIANY1kJzlMqNovXV+txUxzDdZ66?=
 =?us-ascii?Q?+Iy9erxuvWCRP/QYfLY1oIM0HG9Z+bZSXqA3rfwDCu2YtshJfk6JRNqTOS5r?=
 =?us-ascii?Q?JY1UyGS07yn/7frbHiP7cNs8IcoL/kBAQF2UCh1/F4wL0PpeT9qiTIS9n2Ri?=
 =?us-ascii?Q?gFZriV8Tpwgv8lXYuQARGuj1rUJl4ZRHEOMIooFZ2X3dfqTXIdfRY/osfJjV?=
 =?us-ascii?Q?dHVuCMU+SV3u/tWojF6KyTTTpiP8YIccNeHtntCiJ89qAIjtCGE8frtRiA/E?=
 =?us-ascii?Q?EcladNrL2mnA1yUsExUjGkNDJK78tw7hmCnrczcodMPI/2X+8MjfNDv8eFga?=
 =?us-ascii?Q?3GsmnzL7v6RLDk+RcS9YKkW3E0M1XxjCGDHAncl4bUOEozApQW82mefbfC6G?=
 =?us-ascii?Q?TscZt/VICDfsxVn5//MMigHTqXwFQScmNmD6vtvskyulXkEQl2ehSUdOw1h1?=
 =?us-ascii?Q?NRJRM0MyzRkWWj1KNBnXw+xBlgU7U4OTZYbn5j0ewuE0PAgK25sD+WTWAypQ?=
 =?us-ascii?Q?taxqng6x+8I8FwduIxDFVevKIXQL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:27.9303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42a6fe7-a218-4a5f-7352-08dc7a955b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

From: Carolina Jubran <cjubran@nvidia.com>

Previously, the driver incorrectly used rx_dropped to report device
buffer exhaustion.

According to the documentation, rx_dropped should not be used to count
packets dropped due to buffer exhaustion, which is the purpose of
rx_missed_errors.

Use rx_missed_errors as intended for counting packets dropped due to
buffer exhaustion.

Fixes: 269e6b3af3bf ("net/mlx5e: Report additional error statistics in get stats ndo")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b758bc72ac36..c53c99dde558 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3886,7 +3886,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_dropped = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
-- 
2.44.0


