Return-Path: <netdev+bounces-106022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF29143BF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FE9281FD9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F744C68;
	Mon, 24 Jun 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jeU7yswF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DE3EA71
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214307; cv=fail; b=dttgKX0uoWIE0h2DT9hqpgS6ROWfBpiR6SO/Y24EYu87thkXz0w20GUWWNZ82WHML24O5vvVWlsIb5tgKsC8eBiVF8+dDnQUegjkeQP/DQY7VcPkGReb8Pnz5lRJb+i6uEDVZCpuawCol/F9rbej2KbcSEHD2jzJRSzEil+eRyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214307; c=relaxed/simple;
	bh=uXiXgBWavQfx5rFULz7Zix4z+xfMh+jTb0lcYEWa+fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZw+J0XtlSoHkEOpnr74ZeQECDnk+p4E7wsAIwFhtP4BZ2/sB9aWl2yJvuIi03IQJlZlqhR8KFWKOEVb1Iy3OWIqn2+4VotRjtFtMQ0JJhdey4BULe7MRvbMsd08FI1hFvB9cjknZF+zh+5wEwK8UrCHV8g8uTPokrzL33b5I9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jeU7yswF; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFH5JvaqAGvxMMPWC2xK3/DGESTtRN11H4NR3Dfq9x0rWhbS1mxnwBY72hjasxemlTs9/7JoQhUJWQiGtLN76ansShze+4Xvy9eBLZAUrmLt42oIEXTG+6trfN4FNVKFyo8DXBK4dabvjriZuCgrwZyQxKjgGlS++wc9QT3f35IuFnkAnuFC4jWZG3PnWcGM2gnjA9tXCtC4xWGOgBTzO4+yeu9/iHVFNIDGYRH+mcF4LAG0/WC0ZjylPwc1etmhEy1cxedsYJBXCTE1rqPrPi0Fy1Zg2lJIIUnM5i9XFbtLgqAV4sSMN+SbsCwcjIpW4xudw7UtsQ6RiDrUUxiohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjLZV6FP8Qdodoo3W8eteYT5S6aCSJMiDR1sTazVJvc=;
 b=ftEI9ul6YiPZdtYcPEx3cW5+Hz/5YB0DSrByDx5r7SUmF9Erp7/ucELxe2V2NG5Qje0qH1uW1XEJometdo+BeLAxK5GjlHExrUmz/bf0Urf55tYY4AoVi/z9snWmK8JZ6ji1Gb697k08cb2UVIfH0NjchVwB1HD9Pbc1hYgBcd/F2xFlLyKxzhezdn5HwuojbXJ174moeBZoznaJv2M6YkCa5VJoz2cSGpN946EO6w84hO0JHoEXTRjwYfV3yktRiCr4kxY0Hyhlb62ode9fV4Sqyf68CyV4TiQ62P8uKkLhZKfEtvTbHCjWi8uxULiUkltSpUzNL0TrVaEMXTvMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjLZV6FP8Qdodoo3W8eteYT5S6aCSJMiDR1sTazVJvc=;
 b=jeU7yswFMBNaCClLlpdxYxhpHirBxGg5w2Ix7uhk112vWk5w6KbOR3d1wZkIE7efZOnyCRua86tTbDPPp6oz7MpXXrp8NBIXWQFpVWMAYMzsTkzjxVB5SDaPHq+/lgeBmy2MWD9/hrhqzA2kRctAcw9Ap4mNRgM6LtXrRp5rIQenPfuhWOv6Qn0iZ360yUfSsZPgXoMolpx59hLjoSC1fngaBnhC9MEbl+PvDZZYrc4kxyFcov4TE9h22KxeEAsJGK8ANFLhk95sAluqFzT0yJwjQNnhLmOa2U46MSFW5C5k5qJkkWyf+fhJLKJcPD5AOjQUn8BmsCTyDqpZCiDueg==
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 07:31:42 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::e0) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.15 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 6/7] net/mlx5e: Present succeeded IPsec SA bytes and packet
Date: Mon, 24 Jun 2024 10:30:00 +0300
Message-ID: <20240624073001.1204974-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e8affe-4f11-4a16-89df-08dc941fb082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSwfqBTUzPB1N5M211rQ/u3hJagdRNEu5kKhQfg7R9IgDA/XXHmwsCG0Mhd0?=
 =?us-ascii?Q?woVSQ5RFQtoyJ0nZ81FAYUHCG9ICaDQlVA6CnOVLTsQIMGm/mH/WmgyHqoKs?=
 =?us-ascii?Q?45rTerpCr+ihtElIo3avgJdAsmrbU1W/V3uK9vsePYpAqWmT4nuacdWxhTKh?=
 =?us-ascii?Q?9/mUEWJiOxCnf75E2SlqGRXzi0XaDPg8yBu1QivypZ6qVCrPX4V7xcuMDqXI?=
 =?us-ascii?Q?G01ht468uYrH8sGJI5Duos+FgOhAMj0yLRqpcF4Is5w0TFevSMozhXcVJfWB?=
 =?us-ascii?Q?UPv3Gi7hGJ86u59lGqQLLCaxORIFdp7F4XfhGEh/8eRKPRMM4OjhCbtxpKB+?=
 =?us-ascii?Q?KWWBi039kU/S8n/oaAU/efiSENvbg90+A2FVV1gCap2kvunQjkSfqp4fe+0N?=
 =?us-ascii?Q?X8/mxg9MJiSA/ICzlWaYzT2jl38VmPltl+hIWyH7t+lJB8Xs3X21dTb6rPqa?=
 =?us-ascii?Q?g7lXIwTepEq1ExOW3xI93gd6LVQaOy28ULGWonZI0cM55D74JqYgqK9Ad8Hv?=
 =?us-ascii?Q?2KnujHmHJTNu+oDPtbTRNLum5s/bL5SNxcdMRpvNf9wUTkXJF/L4YN8kfCZe?=
 =?us-ascii?Q?khrRrRvu0pq8v5rDGE5ed7brn/NQMOAJ741XRR0hYzYqk2YgK7wTm8QLZNyf?=
 =?us-ascii?Q?1Rhdf7O+PH6k5o01I68ko2jNIyXChRwYfgemTQDBzHH60vGIljO4eOCBb6dq?=
 =?us-ascii?Q?Wxk4Qo54iApc+BbjJ4IvBC00UjH+2S3z6Xtkm25xwaVmweE84kWPjqAuxSCO?=
 =?us-ascii?Q?OErpweYjPDrcGbCL0hlIRqND8hWRGCJlCnTUT/FgrdZKSAsggpdcYNH0bMyE?=
 =?us-ascii?Q?OzN5IhJIsNPDhVNuhZeOQ+d0v/UnRe5ImYST8w3Et9OuHiVFYhFLT4vqDyx/?=
 =?us-ascii?Q?g/LQaaV/QyHmub5kqQXQ3Omhk13yaY+w1/oCA5RoFFzeoKeqBSR48m7P2cSG?=
 =?us-ascii?Q?wHAAdRbYy8LVivbzqfL1uTLsla84L8PyldQSnTRB4ppjygCRIYT6KOZqwO6Y?=
 =?us-ascii?Q?HGK82StWv2jSSEosq3fLFmS4UpQ9Em1q1hblwARaY8jhIbxAQv43R5E9DtsI?=
 =?us-ascii?Q?pyWPGDSxVjbRtZiRuJGTrBbDegcn1adwjmgNcnPu757sPA+TRzx4ZZiFg0g9?=
 =?us-ascii?Q?INOiqIF7gEmTbe9gmDxalPX59k39/jkqQbiT+IH7+hTgUoprSf8B8fgFiVT4?=
 =?us-ascii?Q?KG12nAGcgdCXm6O+NTBj6QMrir8ZSoWq7kCTEQNfHdudOGBWKQJB1Bmka65S?=
 =?us-ascii?Q?Vl1LwjwmeHn/g+AX0wWQNaewV3AIMiIpOdJBxgX1cYgOsExnRlNc81K+67GH?=
 =?us-ascii?Q?FPcmkA1mYv5cV+rv91hpvYBFt4VRNpLkCgrHoWqvjX6G0fIf0pXuDFjZ6hdH?=
 =?us-ascii?Q?zJN52oiThulvN8ZvO+InsAPVy74rjfYKCY4hsMjXganBa6aknQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:40.5228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8affe-4f11-4a16-89df-08dc941fb082
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

From: Leon Romanovsky <leonro@nvidia.com>

IPsec SA statistics presents successfully decrypted and encrypted
packet and bytes, and not total handled by this SA. So update the
calculation logic to take into account failures.

Fixes: c8dbbb89bfc0 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index c54fd01ea635..2a10428d820a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -989,6 +989,10 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 	struct mlx5e_ipsec_rule *ipsec_rule = &sa_entry->ipsec_rule;
 	struct net *net = dev_net(x->xso.dev);
+	u64 trailer_packets = 0, trailer_bytes = 0;
+	u64 replay_packets = 0, replay_bytes = 0;
+	u64 auth_packets = 0, auth_bytes = 0;
+	u64 success_packets, success_bytes;
 	u64 packets, bytes, lastuse;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
@@ -999,26 +1003,32 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 		return;
 
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
-		mlx5_fc_query_cached(ipsec_rule->auth.fc, &bytes, &packets, &lastuse);
-		x->stats.integrity_failed += packets;
-		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINSTATEPROTOERROR, packets);
-
-		mlx5_fc_query_cached(ipsec_rule->trailer.fc, &bytes, &packets, &lastuse);
-		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINHDRERROR, packets);
+		mlx5_fc_query_cached(ipsec_rule->auth.fc, &auth_bytes,
+				     &auth_packets, &lastuse);
+		x->stats.integrity_failed += auth_packets;
+		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINSTATEPROTOERROR, auth_packets);
+
+		mlx5_fc_query_cached(ipsec_rule->trailer.fc, &trailer_bytes,
+				     &trailer_packets, &lastuse);
+		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINHDRERROR, trailer_packets);
 	}
 
 	if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
-	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
-	x->curlft.packets += packets;
-	x->curlft.bytes += bytes;
-
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
-		mlx5_fc_query_cached(ipsec_rule->replay.fc, &bytes, &packets, &lastuse);
-		x->stats.replay += packets;
-		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINSTATESEQERROR, packets);
+		mlx5_fc_query_cached(ipsec_rule->replay.fc, &replay_bytes,
+				     &replay_packets, &lastuse);
+		x->stats.replay += replay_packets;
+		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINSTATESEQERROR, replay_packets);
 	}
+
+	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
+	success_packets = packets - auth_packets - trailer_packets - replay_packets;
+	x->curlft.packets += success_packets;
+
+	success_bytes = bytes - auth_bytes - trailer_bytes - replay_bytes;
+	x->curlft.bytes += success_bytes;
 }
 
 static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
-- 
2.31.1


