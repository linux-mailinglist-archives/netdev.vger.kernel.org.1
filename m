Return-Path: <netdev+bounces-135518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8D99E2E0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918991F22CB9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57D1DE88A;
	Tue, 15 Oct 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omcIE7eI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A421DE2CE
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984801; cv=fail; b=EN1HvaBdWdn83lEoxZmj+DzdqK/U5LNPoP/8d8tjhYrEw2wGUTUBx8zJROhz+UY7mhNNflCIQwqvw0X2cLKYMj79R5q4dx56+gIekT+f2TMzl1FGe+vTS0HcGzMKBR4fThCMAW9DeSe8tJ9lrt/YX2PiA+5n47rvPYfTlT3HJz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984801; c=relaxed/simple;
	bh=h4SBvKqh0csXw5x0ih7TmcIj/ZVhkXNuq8xwBv8f9Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ts3DYe5apOJV1Psd0CvK4+5cHaHNfOV1SyUkBtez+HA257gMLkPmEPyk3saErFCXD2woTJVon0mN6f4ocYT1NJhUEI+ei/tsyGR7lz/vWzh7LD+JpZf6z0fjuDPraHo97NxaqVI6aNAkh4pN/O6L2g0eHR1KFfxSdrWNs1uo2ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omcIE7eI; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWGORxCEKY3uhfrUHjTFte8VRJQ2wUfvkuBp1z6sHpFDwqhRtwDAouBfsO1P3nfGd8uGLVQ7mjvPUQVP3KcmTWVb7l4JL0i7dcG19SChKeRl3FCRiE89+AUxifdIUL5JcX++SoozCDXbgtSHXH4t9z5qvPEojYEYarbWSbzbOGprzrpP2wxJydVjpxKI0PfVtCQ4JBwrN6poI+VsOy1cNOvlgJ++iVUYjhP6LWtkN1Xb3TKwIqYPmsV/p0/m6h9Uc+OD7ABxWa6N5PWfgdoQ2t15iOgU++ZBeW/EQoqcnP/cnXPZUmdFAMijzv2wWiYo8Ro/W6Jy4MJPWiW2K0e5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QRpRKzOk6Z5AM2krmjSrA78W4K89O6nh3Cra52YaUE=;
 b=MkADJv7tKVRcZnS4Tt8q/6agZYcC5RLLwz9xgIvw3vRSmBNJ/ILPJzcxKa2ENQpxMItA8s53xphhFXSosgL5SWkbi1a6X+t4H0WOf344j6wqVy5CUz0iPKXFB4v8FKqYCWgw3/D1Rx8a3DLRo6/MqRHy4qGX1ksvzcTghLzCC0dHYStms3bbx7KZUEzD1shxsg6gOEt9iQGKn8UqQdes/g8hK+kfsnGmmA30Jaw+bK/y8tB5bFWRgB60jfr03tH7sAYiS2AvLCY9JP0pST9kYRXyuEsV3xe/rdCTwfgl9Ob1tOF8Z3O9ZCGVP6x6iXolqzjNlRz+T3NSXWn4zyoW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QRpRKzOk6Z5AM2krmjSrA78W4K89O6nh3Cra52YaUE=;
 b=omcIE7eIm46Vyrpaul7TEe9LwFHJxtvzVrn4YdZjqLkqyFXT4r9IdVGku/jgSYCE77TyUGKtKNyLYLZotR56Y9W6/VGbPAdfDfkkkAseuw8Qi8glmZHQugxM/TYu18lFbmKoyDHs6ujxa1U+N+jKh7AnhKuaq7DA/rBkFIMiRP58wIX9qsVimKhK/AIMB0hp28qo0eL20ObsKLsU/Hh+S6o7t309auJ+b39TA7GkoicvIG5QrokFIQxGSlC8Kz8TsUxcwSt7oKu6VGPoAVZeJzOrmPaCMCKGZ1lMkDHtfUknUo0Q0tHPyDI5Stmo6iJuOiH6lPncQb1NJBcC4v9j0w==
Received: from MW4PR04CA0147.namprd04.prod.outlook.com (2603:10b6:303:84::32)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 09:33:16 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::cd) by MW4PR04CA0147.outlook.office365.com
 (2603:10b6:303:84::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:32:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 4/8] net/mlx5: HWS, use lock classes for bwc locks
Date: Tue, 15 Oct 2024 12:32:04 +0300
Message-ID: <20241015093208.197603-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eddb625-df52-455d-9bc3-08dcecfc656b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9EBSuV3bYoMEJjelSWMJJpDF4HXumnTYCY5oFrR17T1m+H9UjA1C9fqFkHK?=
 =?us-ascii?Q?PuRqeVBHnqEkWdRu8esZUii+oCfnejP7UIHqNAO7qA5OrrdPqYZk3wUD29ne?=
 =?us-ascii?Q?hxtMrTnKWMZPiTKP7lmHQ5+Y6tnHSAizVy08s8y17z4EUFigE9OJkVRcEIWG?=
 =?us-ascii?Q?1nwHH6uMcPY2MhsrfZe+XeV27QOpPQjX99hPJ5bR9oqcdSqDTP3U1YN12ogB?=
 =?us-ascii?Q?DYcHCo1uXBK+aqm9jftmSE9jSSlETBJvymy1OK+SHFkvR0+nucMXPXk8M+qg?=
 =?us-ascii?Q?twCd8R0j4dufWnD2DN9UKQ/oPMxjMHjpy0+1iOzZWiEHRVs1FyZW0JZaQLj7?=
 =?us-ascii?Q?u4r0gWbB+pQitq1nHkppZFYonPaD31bzApN133PLKL152mX4FoYXsetoP40Z?=
 =?us-ascii?Q?akocLmRXWADsGepFjH2MiBgnzVO3BG3P9fOTqtgjwOU+LrkIDOSdwcTUgZpN?=
 =?us-ascii?Q?IuszE1mJvFtMVFXQWSGbcoE5rTbmjcEV+7pho/3538dZEnJlb+l7oiyi+Wfy?=
 =?us-ascii?Q?F3DHklt6DqTM7wUk6K5E6G8xQO/zkgID5jROLV+ojuGy71Mux3DPxRrnMbuU?=
 =?us-ascii?Q?VstZQwIEj7XsCGrfQYRfLtUyNH6KcL199eilwWkTiKRWvVv3rMOcgqKIXNAO?=
 =?us-ascii?Q?GEndSsG5F4+urFezxjiN9LIDQQq5AiGfGXxgTH0/EpP2EfdreGL4pxNQSJtK?=
 =?us-ascii?Q?0VvuZVVsFt5AyLGS/BdIQu/6fQFbDtsZtCkEDrD/az7iFdkn6ESz4GBwzAiX?=
 =?us-ascii?Q?9e+XvKus3tPGWqnRdZBZ3y1+Oz3zc9mpIlbbIsXHwJoMPQUyHLtSHpKeweWF?=
 =?us-ascii?Q?afpuCYADvBZP5dP+OyMlKLjLpwa2FahtbMdBT8jOk1J6ccPiizcmGy3xAXqU?=
 =?us-ascii?Q?SdoDc4A1g54+1w6znEw8Pam/qTvpwl3cGzTeQ41TYAI18pQKThj/YRmZmaq9?=
 =?us-ascii?Q?JlPmx6DWJV6floZ2kpwG3yzLEwGOVmbIbXDYaopEVegEIJpEYDLqD64d2+Du?=
 =?us-ascii?Q?IkHUdIvsZJ7emSuHMI2URsLlIDAAsSOQ4OVDzJN5oRv4i7ez0FkwoI6lEwxZ?=
 =?us-ascii?Q?RbMh7CYF6VSyiodZwSpc8XFWct7dHMIskw7ffhn+iS1oIOlkmlN9GyQ0U2eX?=
 =?us-ascii?Q?BLEa/O0TjiK8hxv9uqXYiglafLVNhORbwnCl+ZgfN/dib8fSNd2MX8/rjLUB?=
 =?us-ascii?Q?+dJyGVZr3YjBRgEW8o2BeMPSxnxFcTAwuQBi7V0KKaZUtfayWJMRZr6dZP5q?=
 =?us-ascii?Q?Qwkon+5ObFI8yXIAu+h2yMg6KvKpP4wzBZvmgNemGXuCZ8mvZfq0pbZCg8rE?=
 =?us-ascii?Q?SwbvyyQ5XG82YLa2IdZJF6UAdcyNk1HldnxyD21xfH08D7dCzPa5aB7eHbDa?=
 =?us-ascii?Q?wSN0dt1ivz6im9JSZ5GHlUD5qNX3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:15.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eddb625-df52-455d-9bc3-08dcecfc656b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

From: Cosmin Ratiu <cratiu@nvidia.com>

The HWS BWC API uses one lock per queue and usually acquires one of
them, except when doing changes which require locking all queues in
order. Naturally, lockdep isn't too happy about acquiring the same lock
class multiple times, so inform it that each queue lock is a different
class to avoid false positives.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/steering/hws/mlx5hws_context.h  |  1 +
 .../mlx5/core/steering/hws/mlx5hws_send.c     | 20 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
index e5a7ce604334..8ab548aa402b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
@@ -46,6 +46,7 @@ struct mlx5hws_context {
 	struct mlx5hws_send_engine *send_queue;
 	size_t queues;
 	struct mutex *bwc_send_queue_locks; /* protect BWC queues */
+	struct lock_class_key *bwc_lock_class_keys;
 	struct list_head tbl_list;
 	struct mlx5hws_context_debug_info debug_info;
 	struct xarray peer_ctx_xa;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
index e101dc46d99e..6d443e6ee8d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
@@ -947,8 +947,12 @@ static void hws_send_queues_bwc_locks_destroy(struct mlx5hws_context *ctx)
 	if (!mlx5hws_context_bwc_supported(ctx))
 		return;
 
-	for (i = 0; i < bwc_queues; i++)
+	for (i = 0; i < bwc_queues; i++) {
 		mutex_destroy(&ctx->bwc_send_queue_locks[i]);
+		lockdep_unregister_key(ctx->bwc_lock_class_keys + i);
+	}
+
+	kfree(ctx->bwc_lock_class_keys);
 	kfree(ctx->bwc_send_queue_locks);
 }
 
@@ -977,10 +981,22 @@ static int hws_bwc_send_queues_init(struct mlx5hws_context *ctx)
 	if (!ctx->bwc_send_queue_locks)
 		return -ENOMEM;
 
-	for (i = 0; i < bwc_queues; i++)
+	ctx->bwc_lock_class_keys = kcalloc(bwc_queues,
+					   sizeof(*ctx->bwc_lock_class_keys),
+					   GFP_KERNEL);
+	if (!ctx->bwc_lock_class_keys)
+		goto err_lock_class_keys;
+
+	for (i = 0; i < bwc_queues; i++) {
 		mutex_init(&ctx->bwc_send_queue_locks[i]);
+		lockdep_register_key(ctx->bwc_lock_class_keys + i);
+	}
 
 	return 0;
+
+err_lock_class_keys:
+	kfree(ctx->bwc_send_queue_locks);
+	return -ENOMEM;
 }
 
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
-- 
2.44.0


