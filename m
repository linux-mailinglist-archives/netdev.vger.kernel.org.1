Return-Path: <netdev+bounces-154810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6939FFD96
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83FB3A1A9C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B241885B4;
	Thu,  2 Jan 2025 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0tc9NF2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC4191F91
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841726; cv=fail; b=IeA8mmwP7d+8UwytZdSnIgpwe5YnKM3hPfoedUqSewe4aR1kW/2H1rLt5lhQurYvZKkMplnN8j2dwxYEb9kNqNC3PZ3YcCeEVXih4cAHPcbaNCKyP9XvwOTNkFRnC7ikzpHWYF7I6YXxBccp0CdxzOMif9/kQ+Wfec4kKK+Q4XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841726; c=relaxed/simple;
	bh=J1GwrxAXeBz7Fql2GvntBXRlTWu/xBIVtSRLt1hngr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xf530vznmKX2kbxzLNnLhnjf5jj4k4sLXh39ZauaansDTielKMSbLla+85W7wVX8LpqhO3cU8Du0niuV8Z4NyDExJRykJhDjOwXezKkd99rxgWssy9ugvnfIwmHiN4tMf+5+yJcs6jtn60LjGVLxpuDmLYsv1D94VSVe8CVLnlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0tc9NF2; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOIA+R+ni9tYw9GIsdMO8Du2VN88ElcbZrM81ZFHM88cxUCg2hPqTmVTEAuA6BoAoShLBnUKi64qcgKFlilouLDi6vCzuSCXNNN2qpe5/eGkWy02ootdwhQ0+IPfagcEs+SoPTvfailsxlsw4PFQaoy6QvLit5VE5+KlDMezHwONfzh2gaO54JEwvyTXJUrC7lhz3Cv2QeEFjvmzmn71lMhDnRHgVM17yhQtVyrmImsDDxzCgt3uGgfkJa1gS+U3xRtTcB/7iNwzyU87Z3UoeGbiHtRt6tS5tOC1ojBqySiwgBecbgdx4ondnXcs5W2GOapjsN8FlzrChb8VzoJqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw7Q8mS0zCUUAAzC4KJGsPkZb07iui1UY6rZYypwWQw=;
 b=bW0s1Y/+O7+5MXLZaUbSTAi7GP+zaEXHn0vPC0yP8YupiM9t+R5eNUhNczeTt1rJms+429keG8fChy0NAwU5+4pkFZ7HhIENrtcKmTVmW0OA4oSjVc8GluKj17+J1YWs8xhyuJnNkxU1nTsA9JziyTE/ls2x6j/gzPN3J5jxPnVweJsUSlBymevyD+ZIVNL6FuJtsAF5Slkr7M46lPuiMK8qS/JJTsIJWNmREoU99OisM8DP+mnERCjm0vgXsNrkxOKCB6BvTaxIxh3RCrXg43jfSW7WBFQTjJWDHTWODQFmSsG2NVbato9aPhDAjkpkS5QmiUTjaiHyBlDT5JIEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw7Q8mS0zCUUAAzC4KJGsPkZb07iui1UY6rZYypwWQw=;
 b=Z0tc9NF251ZbqE/ngbpvqZuqOdYJ6tJsZOd9U7OlT8CgA9OFG8B51qemUNMFnAU05AEWY5C7N1uTKfIT/kxZsJ/glA244qpzmzgZt1xBVy1P9cRQH8WjvN89QcDk8OmJLboIEsX59O80wRVLg/9RI9eG3G2byDlCB48pO1bPSVoWoeII4pjCK8t+S1QzAd+RVSo9vKEk/7uQBdBF1W6gntvekrjWWy1TAMDQjsxzIeZ0GeKF9zqgRy1M7x47S1oZHAQ7X1/VdmPylqaoa8egiP1wdMYH6LsrmiOMjh2bgLb0EKNCs+aQKoHOujEEWe/RXuTCPPJfo0GpS2qZ6YbB5g==
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 18:15:13 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::d7) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:14:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 01/15] net/mlx5: HWS, remove the use of duplicated structs
Date: Thu, 2 Jan 2025 20:14:00 +0200
Message-ID: <20250102181415.1477316-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ef7390-96e0-41a8-8796-08dd2b596647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrxaFAFRNUx+rBuv+WRg69Dh/NCwS4O8Bu8nzixLhtt88EeedDpZgzaeBn1E?=
 =?us-ascii?Q?f2hE1b8ZaT9AxMZjOEsGcnLLE7YaUa8snL3vTARj+e9Ipu/BSSxYvxcEn4X3?=
 =?us-ascii?Q?zfsUskq08y5CxMEE4cD18JeNPyUK08WVUwiwbpT/c+arPCt6vPoPTiP7X++u?=
 =?us-ascii?Q?cAjded9Ygs06BVwHsA65IPEoSazKHGSo/O6R3BqsNJKNcLy4r3MG/FdHiVaU?=
 =?us-ascii?Q?5g8iKeTwGm6EIvVgZcjXHF3yPoXoLQVz7kJFHxSoGQ5XFEsuG5/E2K1pfS4d?=
 =?us-ascii?Q?KpKIYWEBccwuIek6OmaFkhHe2y3bL4AKx81U313NuNr7BR7UgJVqHQNEAJJG?=
 =?us-ascii?Q?uVUips9LPABQW4CFPDKGXcS1bWJe1ZiXGzuMr9FDaXmuPCn6HMZvVm8VuAuG?=
 =?us-ascii?Q?D5+0cLgtECf4YldK+bPrWAtCXj7CWCpD2c/lbFOeofKOR35ck9Wl8dEU+RLo?=
 =?us-ascii?Q?iIq/rlYCUboOo0co3N3jJTD+8hm7eYrA/DVWRuY3Ka8cY5y7aHywKROBkW8E?=
 =?us-ascii?Q?j7DbXr9eAiI68ojNwoUanINw6D1Qj4Qhg2Yh/YCa2q1mwmuNQHPRU7gJEyuc?=
 =?us-ascii?Q?joI09KfgutLKlwmwex+jign5Cngj+hZDeEKXV/hFNXmdbImdnluoN0II73VA?=
 =?us-ascii?Q?VY5tIdgjGYN5d5I4wiSKXzrrniQnRVZgybQbS5WI70KkAE1w8q0X3ynTKKMC?=
 =?us-ascii?Q?D5bqsxQE9pRHUlCv/8Wje6l5aVPN3Jtpf6v4BY/MweU/f461nO43FSA4Lsuz?=
 =?us-ascii?Q?ygal8uIEW1e0aCILSMqhCy2g1cgjoLzK49osiBakO3RHCKYXBH1IvBbanFDN?=
 =?us-ascii?Q?EoQbXJ4UPFt+xmnI6jDp7NapQQoePl+F8GPLo8mfT4iPZ/epoXaA63KYYdYk?=
 =?us-ascii?Q?x+PTUXAFsedSQPTfgE44k8EDnf8pc70f1zo0Haewb+c+TogG4oA5lhAHPzDf?=
 =?us-ascii?Q?X2r9BWy+AjBou4OY82i0fQcYnUjjVjKeC8Wbj6+QTTvX3qNvJWsoglT4mix0?=
 =?us-ascii?Q?ttwULvyGvWxzb6LKZRGtpfagcWB0ix14PBJP8A4BsrSfUlnI+nAxOMWqVG9d?=
 =?us-ascii?Q?mm0zZJiVVE3xRQJJ8lFvvOIoewK87g50ELm2y/9w4TuSYDNyUVXJwYpaHmM5?=
 =?us-ascii?Q?KS7ccWRvs1EpmLqBshUKszEsQ9pz2YioV4gIPBrePVB3aZcckw4hb1F6RURC?=
 =?us-ascii?Q?6JC1W5P7+NYjDqKOC78CDWFvobZfVl56gDENnYzXPkLS74tbSVK5WzrGyTn+?=
 =?us-ascii?Q?p4uy1Sc2cIzJ0WMLRZubNnob5edCUzQjwO4jpHCYkx0FxYywYCSKrzjTjpSB?=
 =?us-ascii?Q?zjr7MUSPK+RLuhq7JaPdEHwWtFD6d/7ORRiuPFaE9H+eYpdVQYA0DWecOHTk?=
 =?us-ascii?Q?4KDe721gAGmU0axm1y5WlIJKWk2fogmV9g0RWXF3BhTAnknCG8HAN14ph8J2?=
 =?us-ascii?Q?0nNBUT51R7ffitRhj1jb5BWi0TW+v8BK9Lcequz59a8oF8zR/ldt22T3f57P?=
 =?us-ascii?Q?me31vbyTDcsGIwk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:12.3119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ef7390-96e0-41a8-8796-08dd2b596647
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Remove definition in HWS of structs that are already defined
in mlx5_ifc.h, and fix the usage of these structs.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/cmd.c     | 20 ++++-----
 .../mellanox/mlx5/core/steering/hws/prm.h     | 42 -------------------
 2 files changed, 10 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index c00c138c3366..13689c0c1a44 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -622,12 +622,12 @@ int mlx5hws_cmd_arg_create(struct mlx5_core_dev *mdev,
 			   u32 pd,
 			   u32 *arg_id)
 {
+	u32 in[MLX5_ST_SZ_DW(create_modify_header_arg_in)] = {0};
 	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
-	u32 in[MLX5_ST_SZ_DW(create_arg_in)] = {0};
 	void *attr;
 	int ret;
 
-	attr = MLX5_ADDR_OF(create_arg_in, in, hdr);
+	attr = MLX5_ADDR_OF(create_modify_header_arg_in, in, hdr);
 	MLX5_SET(general_obj_in_cmd_hdr,
 		 attr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
 	MLX5_SET(general_obj_in_cmd_hdr,
@@ -635,8 +635,8 @@ int mlx5hws_cmd_arg_create(struct mlx5_core_dev *mdev,
 	MLX5_SET(general_obj_in_cmd_hdr,
 		 attr, op_param.create.log_obj_range, log_obj_range);
 
-	attr = MLX5_ADDR_OF(create_arg_in, in, arg);
-	MLX5_SET(arg, attr, access_pd, pd);
+	attr = MLX5_ADDR_OF(create_modify_header_arg_in, in, arg);
+	MLX5_SET(modify_header_arg, attr, access_pd, pd);
 
 	ret = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 	if (ret) {
@@ -812,7 +812,7 @@ int mlx5hws_cmd_packet_reformat_create(struct mlx5_core_dev *mdev,
 				       struct mlx5hws_cmd_packet_reformat_create_attr *attr,
 				       u32 *reformat_id)
 {
-	u32 out[MLX5_ST_SZ_DW(alloc_packet_reformat_out)] = {0};
+	u32 out[MLX5_ST_SZ_DW(alloc_packet_reformat_context_out)] = {0};
 	size_t insz, cmd_data_sz, cmd_total_sz;
 	void *prctx;
 	void *pdata;
@@ -845,7 +845,7 @@ int mlx5hws_cmd_packet_reformat_create(struct mlx5_core_dev *mdev,
 		goto out;
 	}
 
-	*reformat_id = MLX5_GET(alloc_packet_reformat_out, out, packet_reformat_id);
+	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
 out:
 	kfree(in);
 	return ret;
@@ -854,13 +854,13 @@ int mlx5hws_cmd_packet_reformat_create(struct mlx5_core_dev *mdev,
 int mlx5hws_cmd_packet_reformat_destroy(struct mlx5_core_dev *mdev,
 					u32 reformat_id)
 {
-	u32 out[MLX5_ST_SZ_DW(dealloc_packet_reformat_out)] = {0};
-	u32 in[MLX5_ST_SZ_DW(dealloc_packet_reformat_in)] = {0};
+	u32 out[MLX5_ST_SZ_DW(dealloc_packet_reformat_context_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(dealloc_packet_reformat_context_in)] = {0};
 	int ret;
 
-	MLX5_SET(dealloc_packet_reformat_in, in, opcode,
+	MLX5_SET(dealloc_packet_reformat_context_in, in, opcode,
 		 MLX5_CMD_OP_DEALLOC_PACKET_REFORMAT_CONTEXT);
-	MLX5_SET(dealloc_packet_reformat_in, in,
+	MLX5_SET(dealloc_packet_reformat_context_in, in,
 		 packet_reformat_id, reformat_id);
 
 	ret = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/prm.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/prm.h
index de92cecbeb92..271490a51b96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/prm.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/prm.h
@@ -390,11 +390,6 @@ struct mlx5_ifc_definer_bits {
 	u8 match_mask[0x160];
 };
 
-struct mlx5_ifc_arg_bits {
-	u8 rsvd0[0x88];
-	u8 access_pd[0x18];
-};
-
 struct mlx5_ifc_header_modify_pattern_in_bits {
 	u8 modify_field_select[0x40];
 
@@ -428,11 +423,6 @@ struct mlx5_ifc_create_definer_in_bits {
 	struct mlx5_ifc_definer_bits definer;
 };
 
-struct mlx5_ifc_create_arg_in_bits {
-	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
-	struct mlx5_ifc_arg_bits arg;
-};
-
 struct mlx5_ifc_create_header_modify_pattern_in_bits {
 	struct mlx5_ifc_general_obj_in_cmd_hdr_bits hdr;
 	struct mlx5_ifc_header_modify_pattern_in_bits pattern;
@@ -479,36 +469,4 @@ enum {
 	MLX5_IFC_MODIFY_FLOW_TABLE_MISS_ACTION_GOTO_TBL = 1,
 };
 
-struct mlx5_ifc_alloc_packet_reformat_out_bits {
-	u8 status[0x8];
-	u8 reserved_at_8[0x18];
-
-	u8 syndrome[0x20];
-
-	u8 packet_reformat_id[0x20];
-
-	u8 reserved_at_60[0x20];
-};
-
-struct mlx5_ifc_dealloc_packet_reformat_in_bits {
-	u8 opcode[0x10];
-	u8 reserved_at_10[0x10];
-
-	u8 reserved_at_20[0x10];
-	u8 op_mod[0x10];
-
-	u8 packet_reformat_id[0x20];
-
-	u8 reserved_at_60[0x20];
-};
-
-struct mlx5_ifc_dealloc_packet_reformat_out_bits {
-	u8 status[0x8];
-	u8 reserved_at_8[0x18];
-
-	u8 syndrome[0x20];
-
-	u8 reserved_at_40[0x40];
-};
-
 #endif /* MLX5_PRM_H_ */
-- 
2.45.0


