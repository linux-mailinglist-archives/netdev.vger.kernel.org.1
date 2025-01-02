Return-Path: <netdev+bounces-154812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E79FFD98
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091D8162874
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4413C9A6;
	Thu,  2 Jan 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sp79Qzmr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6D13AA5D
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841738; cv=fail; b=Wx4mcgzo3ty9MkO1mFPUy+I1Asu+xNeQOwKj58/NAsnLAponSPCJGyNx5NtBDobZmlpUdx+PnIBvEbs7KUFh6O/EsXDJ4KxcHNGVVUCh1bm0+ES9Zmkiy6TPhcUyeR3A7BJbHTfgqQT1Tsv86++HVuNxz6UEHPAM3ADS2u6N5Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841738; c=relaxed/simple;
	bh=VLw59UFxM2Z7AqecKqAuBYw7nktCnlp2cMnjctUiJ/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxLDwWP3IM26IF+1u5iDXFbp1FD71sLc9PfoqblPFiy/+xq6ZNz56DuECg/qL7xLI6Hje8ccHBnK6pa13jT3W7yPRoDl6tg2eN4xXCc4QiyJ9cwFVzRXTJjT7y9MdDyntxNtLGV+cb+dqOXBxf3iGqvO+GhpOso+pHICbHfWMg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sp79Qzmr; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xakodUT6oUsantTT0f4ukedpNX13g72E50lx+xGXXrNOU9lZURHV890ILNrk9arP8hmP0i8hY1VA5rd1ySB9IMyVI/93dzMCejQLCZlO++LDjB1Zv4wroojgrTlO1WAvLpE4POKHajD8UUan7NYe24WTxGA5KM3DjaRgkG/3vn7uqvceNmWqBNdKkOZ/QXmZA4brVVZ6A2B02PjT3dQOfH/hZ1hmBZMcp71UyQe9GF1nLozgIR7mc6FNg1V8IWoYz9v5VrJO65AYy8XuulvjTUtrQT9hmzeqkB9SgagKiBLzKoBqPDlqvNVyqm0r8bbw+txgUw+QZClDQXlDNi29Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7qRG6XIa6LEczcgxRNXSkHnCDuGtxo37C+Ktw3qkD4=;
 b=YLdXuFpMH2hUzpQ3d/kVQodVJGY8cef4NB4xzpGpjf19OzVwuBIXlLvNlS0XXeTyvNEQBtC/LyoxXtS+unU+inQ5hqqBFGj2CBQnYAm50EkCX68ZBztNGak2/M2LvCglN9psM0shkeXvq8Zh6ZgkWJ7O7XfP4gn08N96mhmij3kBBmd0i85V9Mr5RqnIXbIkiQNi9q8o7MibzuQPObsZ+FjRf6Hscy40Z9hb5gFwvWixTkZ3Yf/7IiiAzSnFFbwg52/ZEIs1szBSL+8XBt/Wp1oORgFLHHHeJWF4R710IXPJW7JgXvP4jSSuMTgMsAv/fULydJ42eTOS02LCo7Dq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7qRG6XIa6LEczcgxRNXSkHnCDuGtxo37C+Ktw3qkD4=;
 b=sp79Qzmr98H1hcxl0ps42rSqRcU4pqh7Buc01WPKMPWS1NglOVRTztIkW4dTFdxs+X2ejpmfKxc7o4jmmUoPtxZerFO384hHvxyX4XS5wwE1ipE5NrYDPfhv3IkSq2KvY4v4k5teJUqihk7psXr2o6WMwTp+csmoaNdS3E4K3dmsbfYpBYRuDreBIvPZ/7FQfUtFHv342v3UySjxgb5cjm089R2rABCzDmfZGJHtdWIVcSuPzvxNYQgBrvR9FR9oSUrhS3parEzAz8AGT5PAAJ5hj14Sg0FESHjXLe6b7F6ndIcExBkA8e/9ye53JAvZ6dU2uIp6kAsQe0AexzLFYw==
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:26 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::b4) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 18:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/15] net/mlx5: HWS, denote how refcounts are protected
Date: Thu, 2 Jan 2025 20:14:02 +0200
Message-ID: <20250102181415.1477316-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2649af-b602-4f6f-3f8a-08dd2b596ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXTjEiEKt0PZosvdOAZOJ43+rk1FEIzpbMofUeeIegWx9NHwQz65QTpJd08c?=
 =?us-ascii?Q?Ltp5Y/QgQkP1anQFXNXX/uDA4yc1Ulw1c0t/FvG0wjd7IydBdn/vcHrTB1nj?=
 =?us-ascii?Q?GQCTIQkr0UP66jvo+F5+Ymdv+J9vZmXp1xyDxewGbJD/8dvirOR/Vr4PrL0K?=
 =?us-ascii?Q?lp5+p2ONT4g2CZvHp7K6BZ9r6lK//RxgsDWj31sPkYmz+ZFqRSbfqyze065u?=
 =?us-ascii?Q?jvwvlMzt5rChcQIMD/vnyuaTZLdVXaZ9INcYDyq5WcuroDXZinBBsO5FtkBh?=
 =?us-ascii?Q?+MMmtoJNCktOjR9cP3721abO6VscbaqTNwgcrbXEbZKX9BKqpoRfyyOo6Aif?=
 =?us-ascii?Q?QbKNjNOM5xTzzoxUuiGz91jMytyqRdvO8N6DQR3wbxpTUeObTUCu+oBOo8RK?=
 =?us-ascii?Q?VX/MzDbE5BsyfAPa+ufWQF269z1wj3hGpNPJeJtmAF4G0Ds6afUDgFY85eRk?=
 =?us-ascii?Q?zVkCjki0jsirQtNcXg71aonN0tPNclqtOmZJRR0g+UnS6W1F/0yuYx6VFrTC?=
 =?us-ascii?Q?svKISrubBPxQHHcrv1EXG2u6plWkiSZgu+OUEsoH6q3+O1VKSvTYomyqma2N?=
 =?us-ascii?Q?2QGV7iWAaL/IJu3PKCKARTOCrzsryF08R8tZjVxiyQG4vyn65D6oBwE2+SPr?=
 =?us-ascii?Q?LY9mwYH3XhtqZ5dM+J1gon2Jj1chF4kLX5QI3baAJw5yG9GPulF+dzVNeoXE?=
 =?us-ascii?Q?c+W5hT9BbCDU5W99NPGvjik3VYvKS+vOrynMiktEQqswD2OAchpsjcKPbE4U?=
 =?us-ascii?Q?r+XMI2Vt34PhqWdGC5sxFp/ykv8hg5FGZkaXg16F2GNEMEbGEHUbJW75o9MG?=
 =?us-ascii?Q?rMffmrR+RYK/UmE4FWJC7dTNQILVp/6Uxgaw3kIr2yDEh65U73Z+2RaZyQ6S?=
 =?us-ascii?Q?IeI5XPkhrobxCWDboAQmtL2vmDBC2X59n3GCPMUdPbYa5B+OGgCvFOOZI4zp?=
 =?us-ascii?Q?RNaK3Pe1ezCPQTDXFyEiYHZVBtOMJNq0K1Wc0tuGJyyD0Pu0K9vAvsW0Ms2S?=
 =?us-ascii?Q?d7Z4pJC4f/DJwp08mJEyScaqSSTo66NBdHcKXmqu5qWsCIuhMLN/o5zJ9Bix?=
 =?us-ascii?Q?lZ8Rw+qdQ6hnkyT+N8f1y17Tf7odcrrI4Ub3FdQ/G9wWSH73a+/waN/XTe0O?=
 =?us-ascii?Q?IgE6ajccZceeg7eEJaGQmCKNq4whnkTatbOr24j7cOD0Lif9Biy3Gd4h8JeC?=
 =?us-ascii?Q?9WtWhbjsufDAwXfVlpCt9nMFFuXChRtIzYcY6jFp5qGp5fMbmq7hbOBIX2rX?=
 =?us-ascii?Q?RBgqdodQqtGxud7UWJPryEPDtpEsLv/CFHqbSqoYxurHrpqV1HCdHMOULrWW?=
 =?us-ascii?Q?XWFm9cBTe4E6ldydp7viwHvTsrk1wo3yKnp+JiZy7nPfDcaiBE0rI54DUzD0?=
 =?us-ascii?Q?eTuz8ihDNGPgcmDwIS5jXktkd5r0ekDf3FueB9XhU13ij5BhBJCgTh7v/nXd?=
 =?us-ascii?Q?Dyh5IunphShQec52sbqs03n1ZRTivSKXXr/6D3W/Ee8MYOXIMEWOh5/4VA2n?=
 =?us-ascii?Q?r7malqeWcJmhpKo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:26.3257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2649af-b602-4f6f-3f8a-08dd2b596ea4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Some HWS structs have refcounts that are just u32.
Comment how they are protected and add '__must_hold()'
annotation where applicable.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h    | 2 +-
 .../net/ethernet/mellanox/mlx5/core/steering/hws/definer.h    | 2 +-
 .../net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c  | 3 ++-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
index e8f562c31826..4669c9fbcfb2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
@@ -70,12 +70,12 @@ struct mlx5hws_action_default_stc {
 	struct mlx5hws_pool_chunk nop_dw6;
 	struct mlx5hws_pool_chunk nop_dw7;
 	struct mlx5hws_pool_chunk default_hit;
-	u32 refcount;
+	u32 refcount; /* protected by context ctrl lock */
 };
 
 struct mlx5hws_action_shared_stc {
 	struct mlx5hws_pool_chunk stc_chunk;
-	u32 refcount;
+	u32 refcount; /* protected by context ctrl lock */
 };
 
 struct mlx5hws_actions_apply_data {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
index 038f58890785..610c63d81ad9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
@@ -63,7 +63,7 @@ struct mlx5hws_cmd_forward_tbl {
 	u8 type;
 	u32 ft_id;
 	u32 fg_id;
-	u32 refcount;
+	u32 refcount; /* protected by context ctrl lock */
 };
 
 struct mlx5hws_cmd_rtc_create_attr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
index 9432d5084def..5c1a2086efba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
@@ -785,7 +785,7 @@ struct mlx5hws_definer_cache {
 
 struct mlx5hws_definer_cache_item {
 	struct mlx5hws_definer definer;
-	u32 refcount;
+	u32 refcount; /* protected by context ctrl lock */
 	struct list_head list_node;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
index 27ca93385b08..8ddb51980044 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
@@ -31,7 +31,7 @@ struct mlx5hws_pattern_cache_item {
 		u8 *data;
 		u16 num_of_actions;
 	} mh_data;
-	u32 refcount;
+	u32 refcount; /* protected by pattern_cache lock */
 	struct list_head ptrn_list_node;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index 9576e02d00c3..5b183739d5fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -37,6 +37,7 @@ static void hws_table_set_cap_attr(struct mlx5hws_table *tbl,
 }
 
 static int hws_table_up_default_fdb_miss_tbl(struct mlx5hws_table *tbl)
+__must_hold(&tbl->ctx->ctrl_lock)
 {
 	struct mlx5hws_cmd_ft_create_attr ft_attr = {0};
 	struct mlx5hws_cmd_set_fte_attr fte_attr = {0};
@@ -70,7 +71,6 @@ static int hws_table_up_default_fdb_miss_tbl(struct mlx5hws_table *tbl)
 		return -EINVAL;
 	}
 
-	/* ctx->ctrl_lock must be held here */
 	ctx->common_res[tbl_type].default_miss = default_miss;
 	ctx->common_res[tbl_type].default_miss->refcount++;
 
@@ -79,6 +79,7 @@ static int hws_table_up_default_fdb_miss_tbl(struct mlx5hws_table *tbl)
 
 /* Called under ctx->ctrl_lock */
 static void hws_table_down_default_fdb_miss_tbl(struct mlx5hws_table *tbl)
+__must_hold(&tbl->ctx->ctrl_lock)
 {
 	struct mlx5hws_cmd_forward_tbl *default_miss;
 	struct mlx5hws_context *ctx = tbl->ctx;
-- 
2.45.0


