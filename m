Return-Path: <netdev+bounces-154816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C019FFD9C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC11C1881A69
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEE1AC892;
	Thu,  2 Jan 2025 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gs0oEJIF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63E13C9A6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841751; cv=fail; b=hSBagHDKukHTJLWw7PhLYrp6cWskz055uvrMVU5Mv2etLL4rnr6cNk0vNRW2su0JH5hZpOTSC4JvhZybu/mItqRS2lJyGPiRyb0o8W5csFmjuSf1ncnjVusW2NlEL+FI+hZ8N9fTsMB3kSUjoSDt8T8Yapg0BWszhCUhpJDT7a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841751; c=relaxed/simple;
	bh=qk0gWB3Q4B2Gw0zbmMzi7Q40mKdRnryar7xfBVbvBIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQi7W6OR82mQsAJEvWDHGqehmZlyJAVUtNxzoouYc7sTVhlDWKz+gJM+/J0/BfOesNYADrdhv32FHwz20v/9VOHXThOJNhSGPfCNKCFs9z8gzMqvBu+M10fpKrxxF2/Qvbz4wE4bYC9KwgdvRTbWa4UpFMxuBJySOLM6LMz649g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gs0oEJIF; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5396uf+zWIXUw6tU8gRK1/H/nrbHaWUV8ao9GoU4uuR6AFX4CaRdndx/YZOFvOQB9LNi/T/IkOcy8/Y7q5/9E5pRJ9QXxNOdsQA8p50f5hLpYJzzNKrDGLK+09O3VP/XUHw+vRA8jCFMYYrhZTJLgws4xMiVviLaCOD4uL4DnVE/9bZU8/AzWkR39n/oIuL9OvCph7rZIDwo6Q2ViMCpFFwRa/LBETUgNFoEuHmfgTPi0e484TuMr6hAbLzlbr5T6A6tXbusoOmufX6Qp/B6hlcIVKzCydepWHo093hS07DvisvX7ONSoWCPkj4AXwiq4986ptVQruB5UNd+9SbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuwRRBEuOhz93IeLv8r7gTHe1MAjupioDCMcYw2d25c=;
 b=qzjefOQrHLofkx0qylQzlzaq4AR4ke6/UypCgVZUuOaJo42EoqcWVTLsDpzJx3jI++amo1OjGXpSYVvlyjvT8JEGKoV3yGu3WSxk2bRmxJtu1ETEKzZ3dQy5DVB4xIxRK/Bna6d0RPYMgHxE9csZ2Ge20OV96GzcPMRDtyW6TAPCAOiJISbjFfl8sw6hRbrSHJAS7n9mnRVgSW6so6/9DIxVvlZV3YZCKMoPp0nZ6LZZyEKkmAm2W70Q5oU/12sY3jhRIF6QIRI0AQ4Q19PCPcT2v1ZWn7KNOMlxwQgZ7k/7JfxzD+Y3RsC6jkWvvE3E7iUMmnL942jWOkYWjKAs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuwRRBEuOhz93IeLv8r7gTHe1MAjupioDCMcYw2d25c=;
 b=gs0oEJIF90CeqnoiW8OFFgk3fM4qQwnwE/zzy065P6f2HGTxUOVchLw3uTRzy+PqEx37ZO0BSWN9dBj/3TisO52frvGCfpIHbUq6SJ5fbraK0Kt6d357WIwGqjWniwBkmKVgwJ7gHuuevjHK8W7GEHSFVdCEmesYgOxk1gwzRMPU+LYjjQ9dteMvQKGx5Nz6T7TyhIRHKp+kpGfJnHoD2Ub5FxUrvDug/lcBMKo7cnAuihd7Oz8MLDrAk37tLnn8StAW6FO4te9f33WBvuY1+YpRSjKN4F2kRNZSBLv0ZglxxEsc1oMtXOUBVcE+n0FELvddML+9aX+Cv7xYYVRKaQ==
Received: from CH2PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:52::26)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:39 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::a3) by CH2PR04CA0016.outlook.office365.com
 (2603:10b6:610:52::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 18:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:22 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/15] net/mlx5: HWS, change error flow on matcher disconnect
Date: Thu, 2 Jan 2025 20:14:05 +0200
Message-ID: <20250102181415.1477316-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c492ec1-9b7e-49b7-1736-08dd2b597651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/mSB807/tF6bcBWZF6acfxqZpauJ1dcgxOhSLhGBQPtMjIDpw/Fvgbcqgtd?=
 =?us-ascii?Q?yczf1uzhNfXrG1PlFMhD/PIfZ+UgHDmdbzU/Y43hfMu/OYX2qnc8LTPnKQgQ?=
 =?us-ascii?Q?0KdlXLjcVqn3XbzYGTXv8Vz71yDYc3SHm04kIHrkUPPFGFbZaUBs9JYC+Xnp?=
 =?us-ascii?Q?o1JiXLaH5w2RJmoH2p6KjSg3FHhvthYMCMcUEja9aMZ9qWcZMs4O8suhxbwG?=
 =?us-ascii?Q?EaUPbpqxC3/WfpQwm+vs2GNkRhOsKuO6QZbMIAI/zcqf7j9za2fIeovVLJ99?=
 =?us-ascii?Q?c9Y729r2wKA7NuXVSqadqhjHzJVQcODwvQYZOk9rygxE/HpjEk9DfNbKFh4h?=
 =?us-ascii?Q?WBPuYK0R3/tko4Jr00t3IfLsHbO6lTIphNslnRxoRmWNVR9lkY08Y0u8wYB3?=
 =?us-ascii?Q?6DTFAcGBAf/D+NjFxEGWygt6FyHAu/2PIRsUzqtgj3ax9836lDhQjnZyCHqC?=
 =?us-ascii?Q?MdCcxYbbmaHTRZWzOvufiATGdKTpWoj+TpKxZC4ibTHRXjC2FcVL/YWULLIm?=
 =?us-ascii?Q?ZxtCeFVQ4TSq6AqkY1OvWaVaLuBBl22A2AWcYmHaVV4O/grAO+BNiy3jiqq/?=
 =?us-ascii?Q?a1bnlxkqOSytCPU6TaZ/tAOM/YESLQH29QYxooGVOZsBefdir2hj3TXF/Qep?=
 =?us-ascii?Q?0AZpznE1nxkzziDR/yGdvGSziCRH03AyBL/HaSD9rtYgkodIjIEgcXLd1MOt?=
 =?us-ascii?Q?W7Z1xO7fTDLhYXTZCpsVezfWAb4NW/fJ20TCztsjEt2Fdim4d+n2Ui3e6+GO?=
 =?us-ascii?Q?kalbpr4vS1hJJTeOdN5IwQWCcEEdVQoEC+1SLZeOg+W2tEpx1v/H4VRWtsVt?=
 =?us-ascii?Q?L+3SmjZ0DIH+ebQId/4LSt4LZSP+eflNpu6DmBpasqvh4dUMs2Z8yZIn2+uo?=
 =?us-ascii?Q?xVC4WBa1LpO9NoJ1sXBPCwz/K4R3tHzs0dh/BQBFPo7f5I8fJO1Im4yFyIs5?=
 =?us-ascii?Q?E4Dl5hke9+NflqXzOSDnkOjXg1X0DM8scz1fO2CFTJk1DKUAx2KqWG94kG0M?=
 =?us-ascii?Q?I7NMdrD/rnR6rmTjb5rc6hEYHQFeSZQG7Og3qyntVIBnxgoGf7snmF0soP1n?=
 =?us-ascii?Q?2g9F5HoXAPIWyHHIofNnuouAWP/ZB+3x3Is7UoEm3N5Ji5IfWV5KNawyCm8A?=
 =?us-ascii?Q?wr/1N4YrRW1g7cmd1edZKytzmjjtD7RzklQD5lT0pyk0Pplp+udCbcfv52pF?=
 =?us-ascii?Q?URsU8fXmcBNX+iPUd+6/pVlmU3KbPdZKmaqf8z5BWjY0YqQ2bDEcuVb6Yalp?=
 =?us-ascii?Q?FNiaC8Nn/7SU0HUW1TVYcjQK5R4EArly4l7174tTrvmPP44PxYZRapJAmII+?=
 =?us-ascii?Q?NjkWLQO6epHoENnq+f8mhtorxzlCdi1jFe6TqQOSxcsj9u0qB6uG72D1Usof?=
 =?us-ascii?Q?U68KFhDkiseV5UEA5sjAsSKCpGNEphhWteobhIPDMs3sojm+dpePGo77cKLv?=
 =?us-ascii?Q?upBTejigqB9e0nMgnhoNZ86XWR22x8vzQL4OGRZFRImDz8MB0MQRyuefAFyp?=
 =?us-ascii?Q?Ux4yCvZ8hO4Kf8M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:39.2025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c492ec1-9b7e-49b7-1736-08dd2b597651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Currently, when firmware failure occurs during matcher disconnect flow,
the error flow of the function reconnects the matcher back and returns
an error, which continues running the calling function and eventually
frees the matcher that is being disconnected.
This leads to a case where we have a freed matcher on the matchers list,
which in turn leads to use-after-free and eventual crash.

This patch fixes that by not trying to reconnect the matcher back when
some FW command fails during disconnect.

Note that we're dealing here with FW error. We can't overcome this
problem. This might lead to bad steering state (e.g. wrong connection
between matchers), and will also lead to resource leakage, as it is
the case with any other error handling during resource destruction.

However, the goal here is to allow the driver to continue and not crash
the machine with use-after-free error.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/matcher.c | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index e40193f30c54..fea2a945b0db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -165,14 +165,14 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 						    next->match_ste.rtc_0_id,
 						    next->match_ste.rtc_1_id);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Failed to disconnect matcher\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect matcher\n");
+			return ret;
 		}
 	} else {
 		ret = mlx5hws_table_connect_to_miss_table(tbl, tbl->default_miss.miss_tbl);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Failed to disconnect last matcher\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect last matcher\n");
+			return ret;
 		}
 	}
 
@@ -180,27 +180,19 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 	if (prev_ft_id == tbl->ft_id) {
 		ret = mlx5hws_table_update_connected_miss_tables(tbl);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Fatal error, failed to update connected miss table\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx,
+				    "Fatal error, failed to update connected miss table\n");
+			return ret;
 		}
 	}
 
 	ret = mlx5hws_table_ft_set_default_next_ft(tbl, prev_ft_id);
 	if (ret) {
 		mlx5hws_err(tbl->ctx, "Fatal error, failed to restore matcher ft default miss\n");
-		goto matcher_reconnect;
+		return ret;
 	}
 
 	return 0;
-
-matcher_reconnect:
-	if (list_empty(&tbl->matchers_list) || !prev)
-		list_add(&matcher->list_node, &tbl->matchers_list);
-	else
-		/* insert after prev matcher */
-		list_add(&matcher->list_node, &prev->list_node);
-
-	return ret;
 }
 
 static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
-- 
2.45.0


