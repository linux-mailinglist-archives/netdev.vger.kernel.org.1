Return-Path: <netdev+bounces-154814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4F9FFD99
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C561883678
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3B1A2543;
	Thu,  2 Jan 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZLxfZh4E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E714F9F7
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841749; cv=fail; b=EBxubFsaYUm9eTHqp0roymrWyZuFwwZgcW5OSkE2C96eJQwPLDx3el1RAJ0jo5uHnk7706mftI7iOsI8jelNxgz1iGdz8DA1Ly7h/j2UT23//WbJY/FGlX7QB3UhS21hxvqf1aWn/yyZRK9PZ0J4IYyj9sGL7RMN1FY+Sa7/Yg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841749; c=relaxed/simple;
	bh=SB2WdVJlVVPWK9re1wZVLaX3MFUqwln2COZtTkVmEyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvbpza8lsAhXW8S0mOMq+K6nf3+GguXWUFZdJXAXphqPZXrAD+JeVU6LCaEjnBIVCUp184LFHO/ZJWlBhC5TDN6JqWg78vAhXlPg7kUKUDrghSC7c6ab5NtLVsQBVdoRwBdbzZJSpJp2U5b2599TmoeweDLeAfK1P4mIsr6pyBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZLxfZh4E; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmartNultRlLEISyp8jYG834sLP7P8i0dCX2XK3p27i6uJlGau8SFmoWxLp/38ELYRn0mjT3hvOiECt39Y2fGKgDxvlFoVFP19odyZOMOzIyJwBYRxH2nIneccR9uqqNPRGzj+8OdsgfAmgGqoFIUjOHqSCapH6x86r54ADsD8ViHE5SQ7po87fMqKGJSGOk/Lca/nh7zojhTEcx9Q9Pq0PUwGFU9SKIN8jNUAc1NibEPjk1vdZfl3LOw9+zBkM9jFhqQQB+MKXXd86oVVL5RlsguWVXbRER9QOTus0upWHZBZGHEDM1/YFP5fc9qQjWjp53c/f8Oa+8R1LJmmh2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4brdImwoM+Imxcy5n2ObR/VsT7KNr4EpSAa2UwAShg=;
 b=doqU/dp0wMh2Syaq5EMi/SU2NQpHASA/5RRDGcZCaqUDepeSkRXSg0hTiQhjRr+eMtdjRVUFuORX3uTNzPzlGuonhp064H94zUX0xqkrLdhFGzQRegrxMMajEbelbjt0/yuA1OsvkiBfV7xGQvdUjS2N+jvis1AOwEJQUxFizlkfu3yNGprXyynJJ/eCkxujRDtdAXGO6ulrJ293tyhCE7KTybTN4fng6bVpDSyl5WaW49UTZ03OatUIDagNfPjeo7vHkMrPjzv3dbqFjNv4TFvH+TK7htIFvqjW4br50PEz36rPlG/C19LiuCrjhSe6Q3K6jkBws1+fbhvwRmP2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4brdImwoM+Imxcy5n2ObR/VsT7KNr4EpSAa2UwAShg=;
 b=ZLxfZh4Euht3mGdndnVZnyfxJvn+LbcnckS0DI661JEpaN3z8b8g3BHuqEvkSyEymVjA2D+yVLLbkij/oa0zlI0FmVno01EniK6Z4gKcM7Mxyyy3W6cd0iDRQ3/j9ShVJJXupMBsxL6jrkhCiLXRi2yB6PPmAcerVm836wIqoHx/+XM2gQBhojoU0gG/vDJwj5oKjpwWJhFeJUroEXdvPpubcFcDhNTYMBLh1ZI6Er83nTqwGLTZJyhboaMBZkfuvglLLsbM5bxdOgLQNuFEbRyWhAVJAh/kc+KHAY1+EvX4lc3SxfrOgd4xk2BzD+zaeL/WaG8PYgJA+qoOmH87PA==
Received: from MN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:52f::19)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.22; Thu, 2 Jan
 2025 18:15:33 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::48) by MN0PR03CA0030.outlook.office365.com
 (2603:10b6:208:52f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 18:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/15] net/mlx5: HWS, simplify allocations as we support only FDB
Date: Thu, 2 Jan 2025 20:14:03 +0200
Message-ID: <20250102181415.1477316-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 199bbce1-6e91-4e25-3b5c-08dd2b597217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmQfQ1PTrvP9OjJmTm0BJNv0ue9MXlo6V5eecaNatFrWA3kPuHbAbSI8wN5K?=
 =?us-ascii?Q?/FUkyp4cf80W8AJMalXL5NmRkdctdX9xYa009NK7GYRsgquKXffwoCmwSUqo?=
 =?us-ascii?Q?pCcctqwl8j5UqafNXxydSRPS0HjiPXAVkA8p2EPSu12asvzLJ5H5djTrBCXF?=
 =?us-ascii?Q?oL13F+naPZw0U3b29ceJww4lmUj+Qhd7DYN4pneKsOkYP2M6qSi/2qX9dSht?=
 =?us-ascii?Q?lWMRZMdxFYvJ/9geBYXh3QXb/DNncuD/sptB5jjIZj2gQ/SlYL3OZ/cOpcCD?=
 =?us-ascii?Q?Xui1KHRzEZT7W6JB3m1OWShXgrNVj70v3+Z8nw/uSXjMWPfrdeOvD48czwGw?=
 =?us-ascii?Q?p7gu4UYsL0mNHJsQQn0Hdjgg4u4z7ISScEdbfHyF7Y34GQPtNjNVNWGiSBes?=
 =?us-ascii?Q?d2iYOBv6L7kw6s4V/vcBQWFRBl4GbyRjVG9H8pMT1BI+ALK+rWmKstQqhGZc?=
 =?us-ascii?Q?HmIo5/FSev7T2y4Q7qnfp3MHz33h6MOKtleC/q3FSg+cYxE2XuGuAPyPmuG6?=
 =?us-ascii?Q?+/Gi9JlaVCp+rGHpE5+2jCD1AEcoG+CSJ+Ru1bWvAhbkgU43qyy9/BpGoRki?=
 =?us-ascii?Q?hv4Q1zUIEBC+7tFrOMhF645zKOxX+caIJsUESHP0hEFB14F07f8vBudxpijD?=
 =?us-ascii?Q?xAQB40QrCgjOjNYCXyNt/bXow0taRBdZZLOk9ye9odRFswtV7GpFI16w8PLD?=
 =?us-ascii?Q?Z4Yde4VKdxbk+b0kFJPW5dVlVGxprvLxEsGOafZexHKdmy/jqxc2Qh7PpFyC?=
 =?us-ascii?Q?vjvpoewqmTJfKK5AnT0oDk01mLObMrsshOleLkznlUVru9drNc4xYsyQoQTQ?=
 =?us-ascii?Q?IEUAi1Krk05hDw8/9qYouq3VbdN2tgiNiDRpFx9v2BkjVyuR352WDESndrL2?=
 =?us-ascii?Q?06EVh85NWNhl2FOtwYV6ZEKXtM+ghNEJO4I9yqfjKaGh1M7rPqL1fx7dAm/Q?=
 =?us-ascii?Q?DbKYBbocyGixxnbXt4r+z6u6BceuXTvdflFAKNbAWiUM3b/mOfxoyewety8c?=
 =?us-ascii?Q?/zA8Clpsw3qYlopqVKscEgx/dnyzBnPzGBjYARd92lzwb4BoFL6P3MmxCPUE?=
 =?us-ascii?Q?g00OgzZOZcppRUSmBw9J5qdNFNopGycUEbBCt+83N/uDOcVtOUx+Q/rWUKTK?=
 =?us-ascii?Q?X9n7CZjhASbtWFBHg5zB2+j1aYOY4g8IW1vtl5tM1WKXB2u5cJp3cEsIQDIV?=
 =?us-ascii?Q?H1NkmSU7kUF1/BUX5SDNA2B1jAkO5OzQYQAL9J5+WWTt0P96bmDREX98fESe?=
 =?us-ascii?Q?xJW335rcQiXGZtF3ScVvglCkKKuWZU1b5NNZ08gltKUncOQHnEtJMohkxKxm?=
 =?us-ascii?Q?FxsyHOJoen8OFPKScz8GEfXIispIhbx4YRQEGqgz21lqSM0EmAnasLSdP3Sm?=
 =?us-ascii?Q?b/z+/mBIq1+0Afj4T3VOBmjsXqjn6LE8tNsvbBQLo11MYd/uPZ9VAGVv3cCn?=
 =?us-ascii?Q?AwuYp9FJR1Ln0I4Qvam9NHV147I7a9DQIFEdHET0ymtRznWP6A3voa1UHprg?=
 =?us-ascii?Q?s1NropzvA5xMPAg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:32.0656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 199bbce1-6e91-4e25-3b5c-08dd2b597217
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In pools, STCs and actions: no need to allocate array for various
table types, as HWS is used to manage only FDB flow tables.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  | 107 +++++++++---------
 .../mellanox/mlx5/core/steering/hws/action.h  |   2 +-
 .../mellanox/mlx5/core/steering/hws/cmd.c     |   2 +-
 .../mellanox/mlx5/core/steering/hws/context.c |  29 ++---
 .../mellanox/mlx5/core/steering/hws/context.h |   4 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  36 +++---
 .../mellanox/mlx5/core/steering/hws/matcher.c |   4 +-
 .../mellanox/mlx5/core/steering/hws/rule.c    |   2 +-
 .../mellanox/mlx5/core/steering/hws/table.c   |  13 +--
 9 files changed, 87 insertions(+), 112 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index a897cdc60fdb..67d4f40cbd83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -11,31 +11,29 @@
 /* This is the longest supported action sequence for FDB table:
  * DECAP, POP_VLAN, MODIFY, CTR, ASO, PUSH_VLAN, MODIFY, ENCAP, Term.
  */
-static const u32 action_order_arr[MLX5HWS_TABLE_TYPE_MAX][MLX5HWS_ACTION_TYP_MAX] = {
-	[MLX5HWS_TABLE_TYPE_FDB] = {
-		BIT(MLX5HWS_ACTION_TYP_REMOVE_HEADER) |
-		BIT(MLX5HWS_ACTION_TYP_REFORMAT_TNL_L2_TO_L2) |
-		BIT(MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2),
-		BIT(MLX5HWS_ACTION_TYP_POP_VLAN),
-		BIT(MLX5HWS_ACTION_TYP_POP_VLAN),
-		BIT(MLX5HWS_ACTION_TYP_MODIFY_HDR),
-		BIT(MLX5HWS_ACTION_TYP_PUSH_VLAN),
-		BIT(MLX5HWS_ACTION_TYP_PUSH_VLAN),
-		BIT(MLX5HWS_ACTION_TYP_INSERT_HEADER) |
-		BIT(MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2) |
-		BIT(MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3),
-		BIT(MLX5HWS_ACTION_TYP_CTR),
-		BIT(MLX5HWS_ACTION_TYP_TAG),
-		BIT(MLX5HWS_ACTION_TYP_ASO_METER),
-		BIT(MLX5HWS_ACTION_TYP_MODIFY_HDR),
-		BIT(MLX5HWS_ACTION_TYP_TBL) |
-		BIT(MLX5HWS_ACTION_TYP_VPORT) |
-		BIT(MLX5HWS_ACTION_TYP_DROP) |
-		BIT(MLX5HWS_ACTION_TYP_SAMPLER) |
-		BIT(MLX5HWS_ACTION_TYP_RANGE) |
-		BIT(MLX5HWS_ACTION_TYP_DEST_ARRAY),
-		BIT(MLX5HWS_ACTION_TYP_LAST),
-	},
+static const u32 action_order_arr[MLX5HWS_ACTION_TYP_MAX] = {
+	BIT(MLX5HWS_ACTION_TYP_REMOVE_HEADER) |
+	BIT(MLX5HWS_ACTION_TYP_REFORMAT_TNL_L2_TO_L2) |
+	BIT(MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2),
+	BIT(MLX5HWS_ACTION_TYP_POP_VLAN),
+	BIT(MLX5HWS_ACTION_TYP_POP_VLAN),
+	BIT(MLX5HWS_ACTION_TYP_MODIFY_HDR),
+	BIT(MLX5HWS_ACTION_TYP_PUSH_VLAN),
+	BIT(MLX5HWS_ACTION_TYP_PUSH_VLAN),
+	BIT(MLX5HWS_ACTION_TYP_INSERT_HEADER) |
+	BIT(MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2) |
+	BIT(MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3),
+	BIT(MLX5HWS_ACTION_TYP_CTR),
+	BIT(MLX5HWS_ACTION_TYP_TAG),
+	BIT(MLX5HWS_ACTION_TYP_ASO_METER),
+	BIT(MLX5HWS_ACTION_TYP_MODIFY_HDR),
+	BIT(MLX5HWS_ACTION_TYP_TBL) |
+	BIT(MLX5HWS_ACTION_TYP_VPORT) |
+	BIT(MLX5HWS_ACTION_TYP_DROP) |
+	BIT(MLX5HWS_ACTION_TYP_SAMPLER) |
+	BIT(MLX5HWS_ACTION_TYP_RANGE) |
+	BIT(MLX5HWS_ACTION_TYP_DEST_ARRAY),
+	BIT(MLX5HWS_ACTION_TYP_LAST),
 };
 
 static const char * const mlx5hws_action_type_str[] = {
@@ -83,8 +81,8 @@ static int hws_action_get_shared_stc_nic(struct mlx5hws_context *ctx,
 	int ret;
 
 	mutex_lock(&ctx->ctrl_lock);
-	if (ctx->common_res[tbl_type].shared_stc[stc_type]) {
-		ctx->common_res[tbl_type].shared_stc[stc_type]->refcount++;
+	if (ctx->common_res.shared_stc[stc_type]) {
+		ctx->common_res.shared_stc[stc_type]->refcount++;
 		mutex_unlock(&ctx->ctrl_lock);
 		return 0;
 	}
@@ -124,8 +122,8 @@ static int hws_action_get_shared_stc_nic(struct mlx5hws_context *ctx,
 		goto free_shared_stc;
 	}
 
-	ctx->common_res[tbl_type].shared_stc[stc_type] = shared_stc;
-	ctx->common_res[tbl_type].shared_stc[stc_type]->refcount = 1;
+	ctx->common_res.shared_stc[stc_type] = shared_stc;
+	ctx->common_res.shared_stc[stc_type]->refcount = 1;
 
 	mutex_unlock(&ctx->ctrl_lock);
 
@@ -178,16 +176,16 @@ static void hws_action_put_shared_stc(struct mlx5hws_action *action,
 	}
 
 	mutex_lock(&ctx->ctrl_lock);
-	if (--ctx->common_res[tbl_type].shared_stc[stc_type]->refcount) {
+	if (--ctx->common_res.shared_stc[stc_type]->refcount) {
 		mutex_unlock(&ctx->ctrl_lock);
 		return;
 	}
 
-	shared_stc = ctx->common_res[tbl_type].shared_stc[stc_type];
+	shared_stc = ctx->common_res.shared_stc[stc_type];
 
 	mlx5hws_action_free_single_stc(ctx, tbl_type, &shared_stc->stc_chunk);
 	kfree(shared_stc);
-	ctx->common_res[tbl_type].shared_stc[stc_type] = NULL;
+	ctx->common_res.shared_stc[stc_type] = NULL;
 	mutex_unlock(&ctx->ctrl_lock);
 }
 
@@ -206,10 +204,10 @@ bool mlx5hws_action_check_combo(struct mlx5hws_context *ctx,
 				enum mlx5hws_action_type *user_actions,
 				enum mlx5hws_table_type table_type)
 {
-	const u32 *order_arr = action_order_arr[table_type];
+	const u32 *order_arr = action_order_arr;
+	bool valid_combo;
 	u8 order_idx = 0;
 	u8 user_idx = 0;
-	bool valid_combo;
 
 	if (table_type >= MLX5HWS_TABLE_TYPE_MAX) {
 		mlx5hws_err(ctx, "Invalid table_type %d", table_type);
@@ -321,8 +319,8 @@ int mlx5hws_action_alloc_single_stc(struct mlx5hws_context *ctx,
 __must_hold(&ctx->ctrl_lock)
 {
 	struct mlx5hws_cmd_stc_modify_attr cleanup_stc_attr = {0};
-	struct mlx5hws_pool *stc_pool = ctx->stc_pool[table_type];
 	struct mlx5hws_cmd_stc_modify_attr fixup_stc_attr = {0};
+	struct mlx5hws_pool *stc_pool = ctx->stc_pool;
 	bool use_fixup;
 	u32 obj_0_id;
 	int ret;
@@ -387,8 +385,8 @@ void mlx5hws_action_free_single_stc(struct mlx5hws_context *ctx,
 				    struct mlx5hws_pool_chunk *stc)
 __must_hold(&ctx->ctrl_lock)
 {
-	struct mlx5hws_pool *stc_pool = ctx->stc_pool[table_type];
 	struct mlx5hws_cmd_stc_modify_attr stc_attr = {0};
+	struct mlx5hws_pool *stc_pool = ctx->stc_pool;
 	u32 obj_id;
 
 	/* Modify the STC not to point to an object */
@@ -561,7 +559,7 @@ hws_action_create_stcs(struct mlx5hws_action *action, u32 obj_id)
 	if (action->flags & MLX5HWS_ACTION_FLAG_HWS_FDB) {
 		ret = mlx5hws_action_alloc_single_stc(ctx, &stc_attr,
 						      MLX5HWS_TABLE_TYPE_FDB,
-						      &action->stc[MLX5HWS_TABLE_TYPE_FDB]);
+						      &action->stc);
 		if (ret)
 			goto out_err;
 	}
@@ -585,7 +583,7 @@ hws_action_destroy_stcs(struct mlx5hws_action *action)
 
 	if (action->flags & MLX5HWS_ACTION_FLAG_HWS_FDB)
 		mlx5hws_action_free_single_stc(ctx, MLX5HWS_TABLE_TYPE_FDB,
-					       &action->stc[MLX5HWS_TABLE_TYPE_FDB]);
+					       &action->stc);
 
 	mutex_unlock(&ctx->ctrl_lock);
 }
@@ -1639,8 +1637,8 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(MLX5HWS_TABLE_TYPE_FDB, false);
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
-	stc_pool = ctx->stc_pool[MLX5HWS_TABLE_TYPE_FDB];
-	default_stc = ctx->common_res[MLX5HWS_TABLE_TYPE_FDB].default_stc;
+	stc_pool = ctx->stc_pool;
+	default_stc = ctx->common_res.default_stc;
 	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, &default_stc->default_hit);
 	rtc_attr.stc_base = obj_id;
 
@@ -1731,7 +1729,7 @@ hws_action_create_dest_match_range_fill_table(struct mlx5hws_context *ctx,
 	ste_attr.used_id_rtc_0 = &used_rtc_0_id;
 	ste_attr.used_id_rtc_1 = &used_rtc_1_id;
 
-	common_res = &ctx->common_res[MLX5HWS_TABLE_TYPE_FDB];
+	common_res = &ctx->common_res;
 
 	/* init an empty match STE which will always hit */
 	ste_attr.wqe_ctrl = &wqe_ctrl;
@@ -1750,7 +1748,7 @@ hws_action_create_dest_match_range_fill_table(struct mlx5hws_context *ctx,
 	wqe_ctrl.stc_ix[MLX5HWS_ACTION_STC_IDX_CTRL] |=
 		htonl(MLX5HWS_ACTION_STC_IDX_LAST_COMBO2 << 29);
 	wqe_ctrl.stc_ix[MLX5HWS_ACTION_STC_IDX_HIT] =
-		htonl(hit_ft_action->stc[MLX5HWS_TABLE_TYPE_FDB].offset);
+		htonl(hit_ft_action->stc.offset);
 
 	wqe_data_arr = (__force __be32 *)&range_wqe_data;
 
@@ -1843,7 +1841,7 @@ mlx5hws_action_create_dest_match_range(struct mlx5hws_context *ctx,
 	stc_attr.ste_table.match_definer_id = ctx->caps->trivial_match_definer;
 
 	ret = mlx5hws_action_alloc_single_stc(ctx, &stc_attr, MLX5HWS_TABLE_TYPE_FDB,
-					      &action->stc[MLX5HWS_TABLE_TYPE_FDB]);
+					      &action->stc);
 	if (ret)
 		goto error_unlock;
 
@@ -1970,8 +1968,8 @@ __must_hold(&ctx->ctrl_lock)
 	struct mlx5hws_action_default_stc *default_stc;
 	int ret;
 
-	if (ctx->common_res[tbl_type].default_stc) {
-		ctx->common_res[tbl_type].default_stc->refcount++;
+	if (ctx->common_res.default_stc) {
+		ctx->common_res.default_stc->refcount++;
 		return 0;
 	}
 
@@ -2023,8 +2021,8 @@ __must_hold(&ctx->ctrl_lock)
 		goto free_nop_dw7;
 	}
 
-	ctx->common_res[tbl_type].default_stc = default_stc;
-	ctx->common_res[tbl_type].default_stc->refcount++;
+	ctx->common_res.default_stc = default_stc;
+	ctx->common_res.default_stc->refcount++;
 
 	return 0;
 
@@ -2046,9 +2044,7 @@ __must_hold(&ctx->ctrl_lock)
 {
 	struct mlx5hws_action_default_stc *default_stc;
 
-	default_stc = ctx->common_res[tbl_type].default_stc;
-
-	default_stc = ctx->common_res[tbl_type].default_stc;
+	default_stc = ctx->common_res.default_stc;
 	if (--default_stc->refcount)
 		return;
 
@@ -2058,7 +2054,7 @@ __must_hold(&ctx->ctrl_lock)
 	mlx5hws_action_free_single_stc(ctx, tbl_type, &default_stc->nop_dw5);
 	mlx5hws_action_free_single_stc(ctx, tbl_type, &default_stc->nop_ctr);
 	kfree(default_stc);
-	ctx->common_res[tbl_type].default_stc = NULL;
+	ctx->common_res.default_stc = NULL;
 }
 
 static void hws_action_modify_write(struct mlx5hws_send_engine *queue,
@@ -2150,8 +2146,7 @@ hws_action_apply_stc(struct mlx5hws_actions_apply_data *apply,
 {
 	struct mlx5hws_action *action = apply->rule_action[action_idx].action;
 
-	apply->wqe_ctrl->stc_ix[stc_idx] =
-		htonl(action->stc[apply->tbl_type].offset);
+	apply->wqe_ctrl->stc_ix[stc_idx] = htonl(action->stc.offset);
 }
 
 static void
@@ -2181,7 +2176,7 @@ hws_action_setter_modify_header(struct mlx5hws_actions_apply_data *apply,
 	rule_action = &apply->rule_action[setter->idx_double];
 	action = rule_action->action;
 
-	stc_idx = htonl(action->stc[apply->tbl_type].offset);
+	stc_idx = htonl(action->stc.offset);
 	apply->wqe_ctrl->stc_ix[MLX5HWS_ACTION_STC_IDX_DW6] = stc_idx;
 	apply->wqe_ctrl->stc_ix[MLX5HWS_ACTION_STC_IDX_DW7] = 0;
 
@@ -2240,7 +2235,7 @@ hws_action_setter_insert_ptr(struct mlx5hws_actions_apply_data *apply,
 	apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW6] = 0;
 	apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW7] = htonl(arg_idx);
 
-	stc_idx = htonl(action->stc[apply->tbl_type].offset);
+	stc_idx = htonl(action->stc.offset);
 	apply->wqe_ctrl->stc_ix[MLX5HWS_ACTION_STC_IDX_DW6] = stc_idx;
 	apply->wqe_ctrl->stc_ix[MLX5HWS_ACTION_STC_IDX_DW7] = 0;
 
@@ -2272,7 +2267,7 @@ hws_action_setter_tnl_l3_to_l2(struct mlx5hws_actions_apply_data *apply,
 	apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW6] = 0;
 	apply->wqe_data[MLX5HWS_ACTION_OFFSET_DW7] = htonl(arg_idx);
 
-	stc_idx = htonl(action->stc[apply->tbl_type].offset);
+	stc_idx = htonl(action->stc.offset);
 	apply->wqe_ctrl->stc_ix[MLX5HWS_ACTION_STC_IDX_DW6] = stc_idx;
 	apply->wqe_ctrl->stc_ix[MLX5HWS_ACTION_STC_IDX_DW7] = 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
index 4669c9fbcfb2..6d1592c49e0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
@@ -124,7 +124,7 @@ struct mlx5hws_action {
 	struct mlx5hws_context *ctx;
 	union {
 		struct {
-			struct mlx5hws_pool_chunk stc[MLX5HWS_TABLE_TYPE_MAX];
+			struct mlx5hws_pool_chunk stc;
 			union {
 				struct {
 					u32 pat_id;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 6fd7747f08ec..9b71ff80831d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -359,7 +359,7 @@ void mlx5hws_cmd_set_attr_connect_miss_tbl(struct mlx5hws_context *ctx,
 	ft_attr->type = fw_ft_type;
 	ft_attr->table_miss_action = MLX5_IFC_MODIFY_FLOW_TABLE_MISS_ACTION_GOTO_TBL;
 
-	default_miss_tbl = ctx->common_res[type].default_miss->ft_id;
+	default_miss_tbl = ctx->common_res.default_miss->ft_id;
 	if (!default_miss_tbl) {
 		pr_warn("HWS: no flow table ID for default miss\n");
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index 4a8928f33bb9..9cda2774fd64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -23,7 +23,6 @@ static int hws_context_pools_init(struct mlx5hws_context *ctx)
 	struct mlx5hws_pool_attr pool_attr = {0};
 	u8 max_log_sz;
 	int ret;
-	int i;
 
 	ret = mlx5hws_pat_init_pattern_cache(&ctx->pattern_cache);
 	if (ret)
@@ -39,23 +38,17 @@ static int hws_context_pools_init(struct mlx5hws_context *ctx)
 	max_log_sz = min(MLX5HWS_POOL_STC_LOG_SZ, ctx->caps->stc_alloc_log_max);
 	pool_attr.alloc_log_sz = max(max_log_sz, ctx->caps->stc_alloc_log_gran);
 
-	for (i = 0; i < MLX5HWS_TABLE_TYPE_MAX; i++) {
-		pool_attr.table_type = i;
-		ctx->stc_pool[i] = mlx5hws_pool_create(ctx, &pool_attr);
-		if (!ctx->stc_pool[i]) {
-			mlx5hws_err(ctx, "Failed to allocate STC pool [%d]", i);
-			ret = -ENOMEM;
-			goto free_stc_pools;
-		}
+	pool_attr.table_type = MLX5HWS_TABLE_TYPE_FDB;
+	ctx->stc_pool = mlx5hws_pool_create(ctx, &pool_attr);
+	if (!ctx->stc_pool) {
+		mlx5hws_err(ctx, "Failed to allocate STC pool\n");
+		ret = -ENOMEM;
+		goto uninit_cache;
 	}
 
 	return 0;
 
-free_stc_pools:
-	for (i = 0; i < MLX5HWS_TABLE_TYPE_MAX; i++)
-		if (ctx->stc_pool[i])
-			mlx5hws_pool_destroy(ctx->stc_pool[i]);
-
+uninit_cache:
 	mlx5hws_definer_uninit_cache(ctx->definer_cache);
 uninit_pat_cache:
 	mlx5hws_pat_uninit_pattern_cache(ctx->pattern_cache);
@@ -64,12 +57,8 @@ static int hws_context_pools_init(struct mlx5hws_context *ctx)
 
 static void hws_context_pools_uninit(struct mlx5hws_context *ctx)
 {
-	int i;
-
-	for (i = 0; i < MLX5HWS_TABLE_TYPE_MAX; i++) {
-		if (ctx->stc_pool[i])
-			mlx5hws_pool_destroy(ctx->stc_pool[i]);
-	}
+	if (ctx->stc_pool)
+		mlx5hws_pool_destroy(ctx->stc_pool);
 
 	mlx5hws_definer_uninit_cache(ctx->definer_cache);
 	mlx5hws_pat_uninit_pattern_cache(ctx->pattern_cache);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 1c9cc4fba083..38c3647444ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -38,8 +38,8 @@ struct mlx5hws_context {
 	struct mlx5_core_dev *mdev;
 	struct mlx5hws_cmd_query_caps *caps;
 	u32 pd_num;
-	struct mlx5hws_pool *stc_pool[MLX5HWS_TABLE_TYPE_MAX];
-	struct mlx5hws_context_common_res common_res[MLX5HWS_TABLE_TYPE_MAX];
+	struct mlx5hws_pool *stc_pool;
+	struct mlx5hws_context_common_res common_res;
 	struct mlx5hws_pattern_cache *pattern_cache;
 	struct mlx5hws_definer_cache *definer_cache;
 	struct mutex ctrl_lock; /* control lock to protect the whole context */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 5b200b4bc1a8..60ada3143d60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -368,9 +368,10 @@ static int hws_debug_dump_context_info(struct seq_file *f, struct mlx5hws_contex
 
 static int hws_debug_dump_context_stc_resource(struct seq_file *f,
 					       struct mlx5hws_context *ctx,
-					       u32 tbl_type,
 					       struct mlx5hws_pool_resource *resource)
 {
+	u32 tbl_type = MLX5HWS_TABLE_TYPE_BASE + MLX5HWS_TABLE_TYPE_FDB;
+
 	seq_printf(f, "%d,0x%llx,%u,%u\n",
 		   MLX5HWS_DEBUG_RES_TYPE_CONTEXT_STC,
 		   HWS_PTR_TO_ID(ctx),
@@ -382,31 +383,22 @@ static int hws_debug_dump_context_stc_resource(struct seq_file *f,
 
 static int hws_debug_dump_context_stc(struct seq_file *f, struct mlx5hws_context *ctx)
 {
-	struct mlx5hws_pool *stc_pool;
-	u32 table_type;
+	struct mlx5hws_pool *stc_pool = ctx->stc_pool;
 	int ret;
-	int i;
-
-	for (i = 0; i < MLX5HWS_TABLE_TYPE_MAX; i++) {
-		stc_pool = ctx->stc_pool[i];
-		table_type = MLX5HWS_TABLE_TYPE_BASE + i;
 
-		if (!stc_pool)
-			continue;
+	if (!stc_pool)
+		return 0;
 
-		if (stc_pool->resource[0]) {
-			ret = hws_debug_dump_context_stc_resource(f, ctx, table_type,
-								  stc_pool->resource[0]);
-			if (ret)
-				return ret;
-		}
+	if (stc_pool->resource[0]) {
+		ret = hws_debug_dump_context_stc_resource(f, ctx, stc_pool->resource[0]);
+		if (ret)
+			return ret;
+	}
 
-		if (i == MLX5HWS_TABLE_TYPE_FDB && stc_pool->mirror_resource[0]) {
-			ret = hws_debug_dump_context_stc_resource(f, ctx, table_type,
-								  stc_pool->mirror_resource[0]);
-			if (ret)
-				return ret;
-		}
+	if (stc_pool->mirror_resource[0]) {
+		ret = hws_debug_dump_context_stc_resource(f, ctx, stc_pool->mirror_resource[0]);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 1bb3a6f8c3cd..e40193f30c54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -318,8 +318,8 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, rtc_type, false);
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
-	stc_pool = ctx->stc_pool[tbl->type];
-	default_stc = ctx->common_res[tbl->type].default_stc;
+	stc_pool = ctx->stc_pool;
+	default_stc = ctx->common_res.default_stc;
 	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, &default_stc->default_hit);
 	rtc_attr.stc_base = obj_id;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index e20c67a04203..14f6307a1772 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -315,7 +315,7 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 
 	/* Init default action apply */
 	apply->tbl_type = tbl->type;
-	apply->common_res = &ctx->common_res[tbl->type];
+	apply->common_res = &ctx->common_res;
 	apply->jump_to_action_stc = matcher->action_ste[0].stc.offset;
 	apply->require_dep = 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index 5b183739d5fd..967d67ec10e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -49,8 +49,8 @@ __must_hold(&tbl->ctx->ctrl_lock)
 	if (tbl->type != MLX5HWS_TABLE_TYPE_FDB)
 		return 0;
 
-	if (ctx->common_res[tbl_type].default_miss) {
-		ctx->common_res[tbl_type].default_miss->refcount++;
+	if (ctx->common_res.default_miss) {
+		ctx->common_res.default_miss->refcount++;
 		return 0;
 	}
 
@@ -71,8 +71,8 @@ __must_hold(&tbl->ctx->ctrl_lock)
 		return -EINVAL;
 	}
 
-	ctx->common_res[tbl_type].default_miss = default_miss;
-	ctx->common_res[tbl_type].default_miss->refcount++;
+	ctx->common_res.default_miss = default_miss;
+	ctx->common_res.default_miss->refcount++;
 
 	return 0;
 }
@@ -83,17 +83,16 @@ __must_hold(&tbl->ctx->ctrl_lock)
 {
 	struct mlx5hws_cmd_forward_tbl *default_miss;
 	struct mlx5hws_context *ctx = tbl->ctx;
-	u8 tbl_type = tbl->type;
 
 	if (tbl->type != MLX5HWS_TABLE_TYPE_FDB)
 		return;
 
-	default_miss = ctx->common_res[tbl_type].default_miss;
+	default_miss = ctx->common_res.default_miss;
 	if (--default_miss->refcount)
 		return;
 
 	mlx5hws_cmd_forward_tbl_destroy(ctx->mdev, default_miss);
-	ctx->common_res[tbl_type].default_miss = NULL;
+	ctx->common_res.default_miss = NULL;
 }
 
 static int hws_table_connect_to_default_miss_tbl(struct mlx5hws_table *tbl, u32 ft_id)
-- 
2.45.0


