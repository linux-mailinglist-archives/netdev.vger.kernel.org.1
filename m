Return-Path: <netdev+bounces-107418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A191AEC0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BD31C22152
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CB19D071;
	Thu, 27 Jun 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fo5Es72t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2E17C7F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511491; cv=fail; b=YUfJKO2l36zT0xSHA8PNvfUPPwXqS2LBXrgkRulsqBjoIlH6Nzm1BrpwVgfA8oajeQPGDNhffY/RMo5lEo25N+tvVOAhftzz/h8rnBu7pne8MKPcFFxLkAy107s1sh3C/bhgV+zQxxQki7ADIiXjJUuZQQufXHKh7IwhQKsXU7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511491; c=relaxed/simple;
	bh=gc44tr8pAmuCHu5S38frOz+OdmkR5BKLYN/f9Va3dx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHUDw+k+B4pQJgbCR9xscBNSzmGTkqyMp2WXSp0LMyu2B0zurpos2eIHz2RV3pfdg64uZyP1p+dS+qq7z3i6VFudFhAj7DF3iX972QmpmxuB/mQWxWPQM7x7N+DKXPeFMnyldpISiZdToJhlX9NlsHr/3K0Tn6mCgpCUD6VZOfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fo5Es72t; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei0tsAT50HK0LhH8RangZR7RnJUO6G9WWgNloIJ3mGZjNcJzh8jWuIOn/hLjMekoyTgw/8pX+4WqblDlu9X0wkeUAKe6rEal77wPydSDpz6X/3fr34CWyZIGpxaU67MvVVXOTZpAgQs+hUGnY5brcUEbIi+5z0EiPJNJmLG2K8lZ5Br9BYaMuFZyGgm022ZjFkWIYfUgD6J4y0DG8Pta5c73g1KxZ0mniQXCuD65Hug0o1k9SJj8ekTp+tpxgWqabA2HpP1t50NJNo2tjFkmrJ7mKK59o2rY9vW8+AchmGGQhLcsLKPBXwUCXGnbhaHe2laZ0WEvHPbt+WA4zYcy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoxrZLa2ctm62Dz5uhfaZK0zyU/XLEqwFPff4PpkMdI=;
 b=VA6Imm6ZipKnwzADhbMJDWGa41bzAAlKhaiUDCw0mhI+r0IxVIKeJCNxbYQMXRaT57THAbAMcp+rXRvNXSHyakM5GSuMH8BleQSkN41O/rnGTOJq6XQCvtm/eoV0jSVv1kcZql6gwQ8TvBRI7rY29cgZE1d+l9lhEEW08EOtktg+T65EvaLAa1nuFTncR1ztCX89IlVqiKDjIQsi3Np1M7O9x5DluJLPLFeg5PimNPyeJmXzqki2N0B9eBvIJck8rnoKr5Ndfb8V2RHi2R+yyMgLOVn28PDWfPgHzvnLtbgJtfVbJoqo7T5jClJlX63acCGPwx28q27ttM5JJo5+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoxrZLa2ctm62Dz5uhfaZK0zyU/XLEqwFPff4PpkMdI=;
 b=fo5Es72tVzj3Jw3qcRvp92VyK/5sY2Vll8ndPzD9FbOihiGzsF4qm7MlFrRHKV77Xk9BdZKjTj7DuHR7sc6G8EVxnpL/C36qYg55UpOTj9DJ0rYqZjHu5IzHJ9zVGdyohptrMjCVlm2mrhZ2635XQUxBzpbMR8KZ9kpl2PtHnc6ep6pnOrHFb2w5mMFXWJUYlQoTMtPDe2Ixp5lkvqSZd1oj174pOfAZBcAsBmi9COmIVP6FFZAIeLzth/PhxO93wd7Jvz8uxBNQqFSmHYrfrbNSlbKcJtVDc7BViarXnIBZdkR4s2PlNYtjQh6baiaOm2sV/xTE/OinYqy80hIDpg==
Received: from PH7P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::30)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 18:04:42 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::f5) by PH7P220CA0035.outlook.office365.com
 (2603:10b6:510:32b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:04:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:04:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:04:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 6/7] net/mlx5e: Present succeeded IPsec SA bytes and packet
Date: Thu, 27 Jun 2024 21:02:39 +0300
Message-ID: <20240627180240.1224975-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb151fc-eb90-4043-ad4a-08dc96d39e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4EnkhU2xdWqdX4dP5fCEu0Hh5p8sYcibioK0Bv3O/mfbw5dqAk1vhAFNzyc/?=
 =?us-ascii?Q?oi8osiy+DM5+KAqhPsrwAdMqljzG0p718z35KMmrerhR+q4dFY8AP2yKI4D9?=
 =?us-ascii?Q?Xat9NmtFKmYeoaaX6KBIi3YOYrYO/FvphFEyq5FwV+MBqYhVrlG4Nk8Yt4Ji?=
 =?us-ascii?Q?m7mMzE2scLrm2jLIFtwg1zVYyG5jpIdWbpn2DQLiQNaixf2OT4NcTFR3wx79?=
 =?us-ascii?Q?1Usqcux0qEaB/ntbuvPW6RE8iOhKZby/hBOZys56VNYfregDUGpyWWSWp1ls?=
 =?us-ascii?Q?0htweBS8Bm7+vYhPT8Hsi1vlxqirMQQXj4JLU9s6ACj2Lra1PoT+mESfzxim?=
 =?us-ascii?Q?9jXjjgklXqs7j4kt/nziAxBk5+pzoL8o5c65/iPbkBCnyGxEhESDWTQRwupU?=
 =?us-ascii?Q?dGT1DvNUwpHr06HigVko2OKmjNM5kBKzJEQFlMbw49J6OBRnaa6rZCFrRTon?=
 =?us-ascii?Q?8WcU71Q9SNJI4KfiHvUfDPkpeYfXQ+vBha18qYeDPj6sNl4g7zjl4dAsCQbn?=
 =?us-ascii?Q?FIElEz4MPXXuhlKVUBmtNZ4yhsxMX10qukVbcYNBCKyG+zFGtd7qlZvnD/FX?=
 =?us-ascii?Q?DXN6z6LBwST3Ju4qsglhi1nydu8BSxKYBbCG/kcDG/GGh6CF7C1/g+RwxdHM?=
 =?us-ascii?Q?A+FSVVgOJ1nkxwox+p5RY3w41yTR4j2bSQjZoOKPqD2wL/mRackYBYSZbWpo?=
 =?us-ascii?Q?9ezcj+PiazVL34DgHNMpCEwqiwhZ+tGlPBqdWB8abbEOstnM7VuzcJUa/qiA?=
 =?us-ascii?Q?RRRWJW3pVV/OuZxyBGUF+HH6mXLEs+9t493NCpE/R2xLwKcbQH7dJRcFSj5t?=
 =?us-ascii?Q?3TTghsxnGq6cNvasJwa/FTIchnT+ppQtc1QfjCEyLbs6rUXNuejAcnz7dW+2?=
 =?us-ascii?Q?Kz8Fq8dcUh1vTtAJeD48C7HqqOay6kkB0K+I3zqeFbez6F0BfmhY+iUk6Sbs?=
 =?us-ascii?Q?bMsHJ2CRncSU9b7njSRegKvuQzyF2Iad/YHykSBeclsSfweoDlEQYtxItB81?=
 =?us-ascii?Q?i8KSZhB9R1j9+URwBKrLO9DHYZbxZV3PBAweFWZKjn57xgV5EijOZKiJm4fQ?=
 =?us-ascii?Q?BRHGE1ULzue2AGxYVfnf5zn3GpcMKNHJCIpfNwu53BocTUun7Qap+1VhVRmo?=
 =?us-ascii?Q?fYohR7MlkDoi6pUQGbd9UMPW+8JbIyhkRaLr5azoqc/Hqq0q8DYmvsR9nJpU?=
 =?us-ascii?Q?xqkjHTct1M+ICaTLdRAw/9jUXx0zvo410EaA34iFI/1eiQ7fkmU67zyPfv6g?=
 =?us-ascii?Q?PngHpUDLS2iODCqtNqpLBMScv+usiYAjFnux7mBKEKjCe3bPCxnjBmKC41Dg?=
 =?us-ascii?Q?b/BYe3qGFgKbj53q7Ilpj6Xfv3MUlEMdygwQ8RgyvSEv2tm2iU8s2HVTqIIU?=
 =?us-ascii?Q?8ELG/uVrcFmJqj2rQdN7qQBxpugd6zV3zAXdoPP2ojDmC0ai/I+Zega3Q37E?=
 =?us-ascii?Q?pvkWfyz9Bsn8G46+oActfX+gbTiK+Dpr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:41.5151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb151fc-eb90-4043-ad4a-08dc96d39e31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

From: Leon Romanovsky <leonro@nvidia.com>

IPsec SA statistics presents successfully decrypted and encrypted
packet and bytes, and not total handled by this SA. So update the
calculation logic to take into account failures.

Fixes: 6fb7f9408779 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")
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


