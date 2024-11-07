Return-Path: <netdev+bounces-143004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4179C0DE7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5E21C223B9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81162170C9;
	Thu,  7 Nov 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gR6ubaoU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FB217329
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004605; cv=fail; b=GfKgcVMSttbVuTZIHb3DShhrMeVIe11Cr450wAM8jleyMXd3w9WoW8m/4Di/LK1GnRKy0UYCnYesPYUlgWzgYM+05GqQ1/CER7MXv4SKCPulisrJcmP8GtoNe/4nLd7oXn1KtuRLL1PhDYJs/wHhsoDB0J66kacc3m9oGNaz88A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004605; c=relaxed/simple;
	bh=NHmKcbBISDqDUhNKnZnDYoiONK25Pix5gRBLAbmOumg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxiyJrfh/0v+MRmPKBMjiv3tk9Ye5Y0XWjhgBWxlvHO1WI0G9iFwzQTIo5GQNWOZCh+TrzCAfpYP7oU0D5BQwxW6sJzYzoDbASRKLYNZQL2Vx3MU+Sg/Kxw3uPj4H8f9IlmXV2MHLn3Gt9mqideTj1YrQGu3QDPJBrT9jfwIxJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gR6ubaoU; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZE0Bi9p/s5sN7JSpVU17YvywZpMl7ZEtM/qX67HwT/7/+FIngOlsCk721uEP1ogZIPq3kZ/G47MLoguCQPgI5s4hRoUQW6hWANge9wtY3nDQnXmreh6Ma9dTtHxvHE/vXOrGSgCKk/l1t6rfIrngoI3hrFgAw7M9LplpLVodOysrLsdFjMuot1bzmQCrlsJ5MvDQkZOHPVe9FXaNwPBwXrwsjqS+Bc5zFRdQfTobdLsGJV3qf0zX70ZkclLuEHgZx/8XAleej9nyM2R5fjOO0Wc75YiP74D/8yMGCRMGFNBrqBDNbrOpqeqi/Ku0wxiJOOT78g97PCo3XQSDBHZ1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIvJwyN3dWmZ7cEjkHWHWzb2p9bBIHn+6DD2u8NNvJA=;
 b=NYg6Foxr1k+DTHfU7povrkA36iSPRtfWyCKFq3V60Wab62tC4VAS5EywvJ9CDTx+BnhdiyyCjNxs18L9B0YL0GNi55ZoJn8n6xraffkHYJp3T6mr1z1M8HUt3Q+UPy8SgSavrH0kCQmJqWHtpPlRIT8BMVSe7oMRFtR80VbsuQBhBRih/JLncIiUMu9qc8cttrpZ/BOeLKXeTPeaJaIGz7DEL4dmpx56K0h+v3QCKIp3vL/yJ1qAWV2GtpGYtS2xBB17Ew6BFjXwJ72x6jjlBmcZEB+ahoqtPpuCBue2I290Q+ZI24NpmltffzzyOK24ipJ/1b5sDpOCzsfEOjEEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIvJwyN3dWmZ7cEjkHWHWzb2p9bBIHn+6DD2u8NNvJA=;
 b=gR6ubaoU/FnwAbws/a3p63SAjDG6o61/nP02dUUwXdAyX3/SOERdzRf4Cp2BsXzOjVXEJSei5bDqyHcn3LNlM75i9oYDeAaFE8/i0lqbr1r8MrGBN7zpcgMctRU+Mg55IO4ZNS20BkuwAmTGeLBqW+jlopWosrkyMrpOxFwREYLTne/k7bm8v8wcJht8THaPygr5cwT1PaZS0C01Qmt3n/l5I409FP9Try/tsOzO2HLSGEeorJsp0y2wLN8OBrcCbvbPxzygtomdkeJ8donqWJf+PM7nQMGWARy1j5ZtomUSVIfX6UjQ8pvGrihf0O8nncpQ/5DMzepBcJTZXT0M3A==
Received: from SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 18:36:40 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::e6) by SN7PR04CA0052.outlook.office365.com
 (2603:10b6:806:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:23 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:20 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/7] net/mlx5e: kTLS, Fix incorrect page refcounting
Date: Thu, 7 Nov 2024 20:35:24 +0200
Message-ID: <20241107183527.676877-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2779b737-efcf-4bf7-49ac-08dcff5b1e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kcDGoQPl/GIKOVOP8ttgWwHXqTAvE6/IVg5rAUEBDr1/Uk3FMRxXUptUiQWJ?=
 =?us-ascii?Q?rW122gPJZ/3glIbpD88dNd5mp7D/qhJxP2SCqlkz8+yxDCusYFhCIycbG+Ri?=
 =?us-ascii?Q?mlOY40YdCGBoEdZUa8NtQOdX+lHuH/ycmLavRyRaIY6CUd0uPuONrGkGfiBE?=
 =?us-ascii?Q?X+RqvgylpG67IYYFMjxm6OSVSPKonJrML4+GQ7ftb4AjqkZPBRrJOyWgtB8h?=
 =?us-ascii?Q?ryGtcqFaBg5iyP9KUDmhbIjdqA77zZh6hW5cs7o1J+2VYaaO4cOiLwYZZBim?=
 =?us-ascii?Q?AmzK+ghcjXClz5u9W4zZCXUNQg7daqQkM9Fm4pVfK0MFCqAHqE1vkEyV+6LL?=
 =?us-ascii?Q?VJTE395ijAj7/iC7nZnW03czjZMPdYT1wNNWWmRKnHvrFCAHQYA89nrdbJak?=
 =?us-ascii?Q?E/if3zk45l681+JX2BXPY6nEztK0+H8CUr7ey5GotHZs34U+l3d8SEvqN0HC?=
 =?us-ascii?Q?DAbeRBntuWiz7SCAozFQENoL0PE53KZ1FqSTjJ1sp492m0g3VdAAguonpp24?=
 =?us-ascii?Q?rF3VwIgFjtA6WvxHAHdtK9nvTsrv/gzTS34FOvIi2pPjUeT997QPe4TbhAuQ?=
 =?us-ascii?Q?kt3t/GSevn9PKVUYFILRAKfDnd0GPv15R4lAzqoiDqi3Ruzy+O7MZWgI/WW/?=
 =?us-ascii?Q?ib18Eu9YMITlrVxTeJPrigNhMCoxdX+BrHKMTDIJ8K+hy16C1gpi6vCDPo92?=
 =?us-ascii?Q?E6oukIGTmS/6TWS6GliizyLqwBdmTvdUmrZZazSVWkn5W5kaNpdLVjoevOv4?=
 =?us-ascii?Q?CkScaIQtgG5rEw525W/z3EvVoH9C8Mb2+bq6rh2nFLz9kXZ3rNdbhhxyBZt5?=
 =?us-ascii?Q?pL5pDM4bkda8Fq8aLclg7Hws10iQcbe0WvOwwn76zkD4vOmWlx8+j1agpnMl?=
 =?us-ascii?Q?a+cV5AP7f/vHDxv3kIIYm+eWsh8W2SM4k6ljIzPW8i797jbQ++JSDCe6J7+d?=
 =?us-ascii?Q?4kliqH9okx4bTpN8iIQRWf2/qvou4fyp02intr9KZXmxSeXro6ukylS1VRve?=
 =?us-ascii?Q?IAEsNM0pVuV4alUHHDC1MqOWRvadMPNCumy8j6vUwZDA//kfg82fi99n2Wut?=
 =?us-ascii?Q?XMiLOGfZpzenQJPja8Ze7qFgzv1pexyaxVDLEB9BILQBhTYVnrgdTGOvPHAv?=
 =?us-ascii?Q?JeS1dvBi+nWXf8pmCr3fDPEakG6P1AV8kmgOG1zKiLdqvHGtdsn0D+aNlorU?=
 =?us-ascii?Q?FA49LcdxL2DBgPFXgF0tRg0EMw6IH2i60K8n4mPDqVgRrIt/BS4RCQ9SuYc7?=
 =?us-ascii?Q?gEkr6v4NQoIwlO+tgoJhgv6uJgxqS9tgpCMZ9+t8/s3dF9d6c+E2iS2CLhs+?=
 =?us-ascii?Q?UkgOqpvde9J4j/QZf3KTij7mGyG3MJ3vl1a2SyYR3hLwn71HwXGkd01nzg+6?=
 =?us-ascii?Q?P3hbKe7E35fErYZ1csVjenKPFX/dMQ+dwaEIqCqyH4bf95xBZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:39.6471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2779b737-efcf-4bf7-49ac-08dcff5b1e75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

From: Dragos Tatulea <dtatulea@nvidia.com>

The kTLS tx handling code is using a mix of get_page() and
page_ref_inc() APIs to increment the page reference. But on the release
path (mlx5e_ktls_tx_handle_resync_dump_comp()), only put_page() is used.

This is an issue when using pages from large folios: the get_page()
references are stored on the folio page while the page_ref_inc()
references are stored directly in the given page. On release the folio
page will be dereferenced too many times.

This was found while doing kTLS testing with sendfile() + ZC when the
served file was read from NFS on a kernel with NFS large folios support
(commit 49b29a573da8 ("nfs: add support for large folios")).

Fixes: 84d1bb2b139e ("net/mlx5e: kTLS, Limit DUMP wqe size")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index d61be26a4df1..3db31cc10719 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -660,7 +660,7 @@ tx_sync_info_get(struct mlx5e_ktls_offload_context_tx *priv_tx,
 	while (remaining > 0) {
 		skb_frag_t *frag = &record->frags[i];
 
-		get_page(skb_frag_page(frag));
+		page_ref_inc(skb_frag_page(frag));
 		remaining -= skb_frag_size(frag);
 		info->frags[i++] = *frag;
 	}
@@ -763,7 +763,7 @@ void mlx5e_ktls_tx_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 	stats = sq->stats;
 
 	mlx5e_tx_dma_unmap(sq->pdev, dma);
-	put_page(wi->resync_dump_frag_page);
+	page_ref_dec(wi->resync_dump_frag_page);
 	stats->tls_dump_packets++;
 	stats->tls_dump_bytes += wi->num_bytes;
 }
@@ -816,12 +816,12 @@ mlx5e_ktls_tx_handle_ooo(struct mlx5e_ktls_offload_context_tx *priv_tx,
 
 err_out:
 	for (; i < info.nr_frags; i++)
-		/* The put_page() here undoes the page ref obtained in tx_sync_info_get().
+		/* The page_ref_dec() here undoes the page ref obtained in tx_sync_info_get().
 		 * Page refs obtained for the DUMP WQEs above (by page_ref_add) will be
 		 * released only upon their completions (or in mlx5e_free_txqsq_descs,
 		 * if channel closes).
 		 */
-		put_page(skb_frag_page(&info.frags[i]));
+		page_ref_dec(skb_frag_page(&info.frags[i]));
 
 	return MLX5E_KTLS_SYNC_FAIL;
 }
-- 
2.44.0


