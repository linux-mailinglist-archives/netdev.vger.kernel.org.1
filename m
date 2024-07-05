Return-Path: <netdev+bounces-109365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7592828D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429641F24ABA
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A29143748;
	Fri,  5 Jul 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AlHaWprj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD113C9CD
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163736; cv=fail; b=ZFtmtyAIDEmg36gFCPDv36WrLnlwQ4OmRxd6l/WYlzql34AhjAd6gd5DRX4o2Ff0AwApZLqS7YghzcUdGqmFOfKQatKMR7besHd12qIILaI0ijeA64boqbFauy+Wkh+u9IJ2jjQXoYF6FhOwiXrJsv67hvDGNhz4bM2+r+DYkpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163736; c=relaxed/simple;
	bh=qLW87sf90SxjtLcIOWhTe8TqRhMRydL5V7X1kg52cG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUYBBD2bU/FPEi0CrujGd0YfGtQk2FKZ/ycyvyRG+uKMHFjLFsBvwIJHjpwJyky1zdjT+Pli9Lr0FLk1OTD73G4a9AkoUfu6CPUhJOINIZ6HVEfgt0JQmxRq+WxuA1FUW/TVcKWH36yeelwwjYCYVQztsv97g1I/BB0I805Z0PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AlHaWprj; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XayU6WQjqnabkHF0Klp5YS5+HhG6VKeVPBUM+OSXYRuNAu12yvSG8o/sBJk1SwI9o3o74Qvu3+BegpaG14TkkV+K+JtXmxfHVPS8dl9Dp2ufyONe2t/z4mqHdFDPRwdBLAjZdfgAzMjdujuRXgwVPCokntmvTXkJofGpB0RHtkJv3KQ7lLI3gV+nDVPCmylOzlqlvUZQ8UZHo59t1YX2E83YaD4J51b8kMngX8fltJOS5Pows0rNkLI/76YClUfnz1F3Uvulqr/FOry6zzSzqItbaIl6m3mZr8/wTqmcKdUU5Jz6TzG3KK5A3xfugq+kab3lI6eCYSGtv7hFkIS83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qDoyakM3nv53e9IIBozTjfPT6bA8ClYVo6mzNpuJzM=;
 b=YwjaTNeAhXZ154wKn4rrLvtKxN4wRZ3FNg3ruJ6XDaZnawRhxF3ztt45qB+jr3eIXfSsNUQfK2U38Q4S/7H6cRqLBxaDsvMPC6QzLiZ9mGk8R2xfIN36FhTB4cDgTWRkHK769r+x8el6bg0JYc+wjoJLU3ktVMV9ku/LuYgrDv+oGs4wTBVRTsmXLffKJtAkXjoXc37tJjFHUnFZ6t4lSZ2JmlNX82a4ajMebD3irXEawBDQvQiYv+aGRh2DoPQL0rInFdLg3P9l7A4I7knvww6ALbSDmKYGh6wPS1dbl8ZrSisB6nOV4PJ8oPpSiyeYDo6oru1DBEBU902gC2JgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qDoyakM3nv53e9IIBozTjfPT6bA8ClYVo6mzNpuJzM=;
 b=AlHaWprjDTozUllqDwlpKCpnWeKJM9MgQ3tjYl+zwuz2hunK3uKaCuoKoXXj9zJY0dDqYALMwVkZFpPkk6lrECe25KIzNV7GLPqTdlmyd2VkNDs4+GZpX9/CkwLA89MShrfDAP1omyXXxI0MK0iNCUP2hqOD8xl6mhCsIKahtzhqrWrXLZ/7gcOi6hqfesdEKPfbXEkEF8vWZpWkeIDoyeE5Syw9+ta5nIb14JrCOctPX8dOxbIL6OZlqsOj365Xaf9yj5yhRVUkbPS941iNYtLnzDzN9btwXhy9l6ERyGERh2u+KYrhT1jq+FlamYaYPrDwvNIXu49oiflECPL1Dw==
Received: from SN4PR0501CA0119.namprd05.prod.outlook.com
 (2603:10b6:803:42::36) by SA1PR12MB8164.namprd12.prod.outlook.com
 (2603:10b6:806:338::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 07:15:31 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::a4) by SN4PR0501CA0119.outlook.office365.com
 (2603:10b6:803:42::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.14 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 02/10] net/mlx5: Set sf_eq_usage for SF max EQs
Date: Fri, 5 Jul 2024 10:13:49 +0300
Message-ID: <20240705071357.1331313-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b99682-dda5-4694-fef2-08dc9cc2418f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9jfLBsN9kXqd7kED6+6ne/QlDJIJDJK5sZaIRXJcUj2r/K1sOF/h0qr5nhWb?=
 =?us-ascii?Q?oFUtsiCNsh2CWNNP5kyb+DqRKeItQXrhVYGMzNcYgAnZ+TzAjLmo/P3FU5zZ?=
 =?us-ascii?Q?llivuiA5kUbVREgBXkq1eDfmcSMCTwKbG/Hzw1mISxhFM9ebOZBNfCvJdBpo?=
 =?us-ascii?Q?b+wat/BuYUW3HXs8w/homsBBTUmvwTtPzXUQZKVwFqbtrgak0aB/64CN+wmc?=
 =?us-ascii?Q?6mHP+RLHxedMrccicEBpkMjnSyQNxA/myh39loQyxxqA0HVP49v79i94gaBa?=
 =?us-ascii?Q?IQj76PaTyJDQQN21QbY3J7vB4elLq+4ZZNu+62rl+5NH1zT21+EiIIebNhRI?=
 =?us-ascii?Q?MxFUE2dmNo6aENROBhdOwZvzEHs0hB7pXP5HKdgdhCjNj5PTiYIm4OjdWal7?=
 =?us-ascii?Q?FqhR7s+t6B1YsLob1omW2UeHsQtqmpj9mIMjEPuABhiN8yu/jAjFJ9E1IuO4?=
 =?us-ascii?Q?tl4vMBzCZFij5rtlONZuXl94HyA+Zk/Y+GAorPQxvw1tzWz2vr4n4JE6qikp?=
 =?us-ascii?Q?PAwoyfZOnvM2Ce1n0hoJTE9bqIZHzmaIPXpKjNCTy4qkFx3ND5ewzYr/6tDp?=
 =?us-ascii?Q?940Ny3qTsCSTwpr1WjVeD0CbtUzaRNcQiGzcYpWuZrCt3StGl4G+1IUR1DUH?=
 =?us-ascii?Q?NXLjYc98MXmYGa5dOEcsPPhMvVJwLWs0ZbzOjoBSzwKj22Nyubb/mZEQtIU+?=
 =?us-ascii?Q?aCuwo/6EKhwGLBbeLiNd2A1EtRrcjhl0bYDFOv4tu7P4aMxOo+A0bS6PxVIs?=
 =?us-ascii?Q?vF2s6EDOvv4G/U0DUsPYNX21KNqOG+ucxxnQvFrvhfPyndywv47pzDAK/p/l?=
 =?us-ascii?Q?ops3FHOLztPWSKdv/oXms4NPsdwIw8ti71awfnMTi8//w48zOAgkaTMGRltX?=
 =?us-ascii?Q?qzqTOr3cqQFb6BXIBeN8u1+pXSplEGB/imIL4rIr0hI5mmzRfUzCpSFLtS6u?=
 =?us-ascii?Q?GRMfokqaXkdAeY5KBJuUW5LeM+jKWDP7A9TMtqnnphU7m/U2qXEiMy/SQltk?=
 =?us-ascii?Q?CJzHAH4iPj7JkL0HfVvdCEMmE239oKHyN1FCa8lrR8pNTkCj9jr41re2j5x6?=
 =?us-ascii?Q?h5f56PKWdbwdnFA7CQrbli9hNtNxPBNskbPn3Z+loQCUV4Iqd6hYXpgiGHbf?=
 =?us-ascii?Q?oH1SYXGiY2ypG3QWq355EVoByVN9jppWTcQfApUHTzxPm5dwHfEUYeWxMcLU?=
 =?us-ascii?Q?PJdDet5fSvlPdR/Fw0XSScpj8hDb2GirgTGzftQEYZrbielu6ZnkEmhroqme?=
 =?us-ascii?Q?kkLkhp6PZ80AjTXpx85hAtQxC6VPoyIMEbdFqVa2OC5EsdJ+zHnrusO4rUnH?=
 =?us-ascii?Q?hn6LB62UBu7Mo60eTyvD5TON8XkjNhgbpJlG2WQVwq/g9Xa6Y2W2yYzJhAHv?=
 =?us-ascii?Q?r2KrrWyA+Z6fJbzO6BnPVzX7+rcIeg/mPU92Mqk9X3eDAzbB8Y713KkKENkX?=
 =?us-ascii?Q?658owN9CapTh+amHFVrSW467ERi/Dc+Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:31.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b99682-dda5-4694-fef2-08dc9cc2418f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164

From: Daniel Jurgens <danielj@nvidia.com>

When setting max_io_eqs for an SF function also set the sf_eq_usage_cap.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 72949cb85244..099a716f1784 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4676,6 +4676,9 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	MLX5_SET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b, max_eqs);
 
+	if (mlx5_esw_is_sf_vport(esw, vport_num))
+		MLX5_SET(cmd_hca_cap_2, hca_caps, sf_eq_usage, 1);
+
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
-- 
2.44.0


