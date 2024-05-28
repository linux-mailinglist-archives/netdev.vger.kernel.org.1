Return-Path: <netdev+bounces-98631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C28D1ED4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92A4B23542
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F814170859;
	Tue, 28 May 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBWuIuhh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636216F911
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906596; cv=fail; b=ABm+PYbFBnDMks0gMtktyICVTgVjhvPGdDXXoAzBQ0r2EjoljYryOKCECTDeq+Ob4fydVat4G9WrBm4Acoqqs0wyGxNU+7GbmsOBLOh/Zl4AWgYnzNLMvrEjyc0jwRviLlqojUaU9yA7k0EdSO11ddPn8irHDdVKXY3k3bYGMRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906596; c=relaxed/simple;
	bh=WTf2aDuwWspbP38UU25EylJvPAnuJGfZPuIjYmE4D2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhGC6b2r0zuDwuTS9g1LvXFsABakBA/XorhYa92ZkOlNZlFksaCAYWapS1VUgzhqs0dGH4CofaPSP/5g1xt1fCYCDIZ+GMSLS4Pplk0ixlNBvnkm1BzVmc2q3N+vKZNimt2Qnoi+RYLTQvp+jHaCALhTUGmjIqnFbmHxP5LE4xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TBWuIuhh; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXWv3y91wmgmOctnB0Jv5eo7KPLXUppVpRl9y7bHbqCKimgK1G92N2kG/H0X/yoET0M8iln50tZBsys05Sfulfv11kdxJCjd/pHtDvsJ4yy6EwtPEWrp4LWSjnap6OQfglyLvwOGujCeSSEQrJKKYjQL8p4CVdeC2X325olRtez1BfY0wjjWZI/RWVN5Ji7scFTU1xOumc/h3hA2HUnsqyQJSGi0noDLTc6c3swdIsQqVOKxoGWjFyvCIfIvTgpzP7H5mzsNqQkJ7jWJ8yLwVRqdQQy8GmMf6WKHjO6yNAl4ZT068PBQr60F96nfNekxFO3bGi1MtCitAy9ow/bQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxK+rDNhbg7sv4iJ84PnZbRffvN+0NMnlFcC0kGTYvQ=;
 b=abYu0+KtgpZ+p3Hf63ejdJySP8TexoMU2qX0USLJ63A1QZyhKuBHrDxPLhdgkjuzkd+FBMUIlOLrpKBpXRy0RqlsyoUGDq5pThJpX8pagTuQTipNlyodvJxIeENBf70xcpIgnceynktec5JPnGl7v2vQiTB6zSLD0RjRRlY1pX1RhVKkBbKDYFK1Wy/6rMSDv8BUmdld+0LFxM48XNLz5gIDdKmFtfVwi1Cd5ZGeLPGqCrIJb54attzHOVQYh26YtUI3xQERhlQ5sb8CQnpAmOu7OuStc9sjAwI2zF864dr0j6zBdZj7IzWYuA5j0xkscnFzIBlyrJldHelSXWMY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxK+rDNhbg7sv4iJ84PnZbRffvN+0NMnlFcC0kGTYvQ=;
 b=TBWuIuhhly7vUGA4NwWO5+EAYwWvSZxDFtxioc5nABz3n/BleBv8mY6PLwD9iIfBPmBYdRLA5buRpcs1hGDSr+PvVkWB3jP8eFknadv+ltDAzROI5lwYEBimkWQD4uL93PemYhdsGvYpvkldSsdVRIeWPsWo9r7WM8g2HmMwtHMJU8tuZwmk+D0EZsCbQNmX3eVS4K6kjk9SyDgxjn8AGhzWz5RNeNv9Ff9V8fBYcbepM8qkBSC65hzQQiVqXFZp8MHUA2s/qWmndZBF1kHjvqMmONRovBrXxB0f7VIgAGVB4M1ErjpXT6aU+YF51pLotpMuc1hgkTSzJq8Gl4xqvA==
Received: from BYAPR08CA0036.namprd08.prod.outlook.com (2603:10b6:a03:100::49)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 14:29:50 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::28) by BYAPR08CA0036.outlook.office365.com
 (2603:10b6:a03:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 14:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/15] net/mlx5e: SHAMPO, Simplify header page release in teardown
Date: Tue, 28 May 2024 17:27:58 +0300
Message-ID: <20240528142807.903965-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 14741a7e-9fcd-4683-0424-08dc7f22a144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kx7Yt55Y1qxOz06rNA+wcsFv/dbHZnQaA1jQSz+ZwTDVr3Z8teVEnOqkiRur?=
 =?us-ascii?Q?gx7749hDy64AY4sJaOjyK3M5j1yPwq7Jt+WCXgrrbQjNC+26VQ/lrhObBzUS?=
 =?us-ascii?Q?LDc/VNHMyn2GMgj79u/g1Mt/60wOYUrR6LLxRUh/miiR3hmXQTHNOsHvhEFm?=
 =?us-ascii?Q?TxGdT3ZVtvptwCRlC/fL/9XlypF/3sX4DJSlSC6Zm/PPKcTY0+vtT5/N724M?=
 =?us-ascii?Q?MrRfg8dGdQf8PoOuOzU1jH/oyuoooW8nQ0zfSbLo+FOpmJzFbLwe3oDAQuJY?=
 =?us-ascii?Q?L3/ICqvshAkEv9/TNDjSfd4Ll7+qj2Zy4uyCcVeErlmIKzawMnMxxnNkvMKj?=
 =?us-ascii?Q?MjG2X4Oq7Xb0KYLBfV4zU3AQCINIiXYZbSiblQGVdqgUPl9/PxutkEQJm5dC?=
 =?us-ascii?Q?7XGBmhZRyIh0IW1DOqiLEa8Ytj9SLWr6edOpWsbMlU2aS5vewRramjUHqrd9?=
 =?us-ascii?Q?Spu2K+YwEsLuix+w3hnq1J92jknOatqq9zAgwfpG/EQqRq/zjquchFwE3dVj?=
 =?us-ascii?Q?Fatpo4vl8snL2YmxWDo+WA/wAoP6MthkGEc9krOiBbfkSCEmshwLYkDoMgc5?=
 =?us-ascii?Q?Vy05y2FnQy01cnyQIC6qpFT7qKJmy7c7+2dEIedUgL3bOtgGnLLC67R2mnBm?=
 =?us-ascii?Q?XMy20ejbqFTwq7Nb8mv1gIoSlq9OkG4GJNQk18NXXuIzeVvXWYAbQyy+BtRU?=
 =?us-ascii?Q?QehP4yisfOt8SSPUSzu9TX+gYHO37kxepDlCr9UWhf/FD3c+CsCs4Hq+3XZP?=
 =?us-ascii?Q?JeUwHKgvjDhJB/v2E1cyO15ohTrLkw9xuK7dYgfC/Rlc9g9zIZeVMkQXeSSf?=
 =?us-ascii?Q?mioMz31rHDZMI1C3SPS1tPegPWNKHV9N5YZTNV9kG2R1xbgfuA/rGunDQeX9?=
 =?us-ascii?Q?bLsfqqPgRx7o2iMSgUr4BkPkOCt3rn+yiHN3Wkc9j/wHRlV0GlYYjm9ZZUSq?=
 =?us-ascii?Q?EQdhPi9TudLYFosNz4M7YevCF2kb+WjPop/svKOmPJajExhsF1sES4SjXu8o?=
 =?us-ascii?Q?yQK5q1ELK1kYKEBrlsXp+qE93fu8YWS4tYze9S2BzckrbFeEVf8MYvnDMV3h?=
 =?us-ascii?Q?vgdtlNdn1eh9NOKGyzpIlgre3jrTx4sVrd/JALbPO3K1FiIgnuOVfl1HKbQ3?=
 =?us-ascii?Q?1zeL1HFIBDHvQO8CEoW1IJRLzqt1bObyBGByjmakaybw75uwzu9dy+Fl8VFV?=
 =?us-ascii?Q?UwXRCJtjVjDqRLd+rg0rR9x+SFGqKfPGmyT8JMbFrMQZM+s6WbX7y+UHVjZc?=
 =?us-ascii?Q?yv37K3MAywd7kDKvKepwifDDz9oPwoFFYJKTcW9+A2wIkZnm8clOa+YddQB0?=
 =?us-ascii?Q?4OP/3Vey07mtFXAmdwsRFN4Sr/qXDXKB1MQTX9RZWEOnLcI1OMlx/vuWW4SH?=
 =?us-ascii?Q?6uY0Oow=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:48.9722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14741a7e-9fcd-4683-0424-08dc7f22a144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

From: Dragos Tatulea <dtatulea@nvidia.com>

The function that releases SHAMPO header pages (mlx5e_shampo_dealloc_hd)
has some complicated logic that comes from the fact that it is called
twice during teardown:
1) To release the posted header pages that didn't get any completions.
2) To release all remaining header pages.

This flow is not necessary: all header pages can be released from the
driver side in one go. Furthermore, the above flow is buggy. Taking the
8 headers per page example:
1) Release fragments 5-7. Page will be released.
2) Release remaining fragments 0-4. The bits in the header will indicate
   that the page needs releasing. But this is incorrect: page was
   released in step 1.

This patch releases all header pages in one go. This simplifies the
header page cleanup function. For consistency, the datapath header
page release API (mlx5e_free_rx_shampo_hd_entry()) is used.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 12 +---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 61 +++++--------------
 3 files changed, 17 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index e85fb71bf0b4..ff326601d4a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1014,7 +1014,7 @@ void mlx5e_build_ptys2ethtool_map(void);
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode);
 
-void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq, u16 len, u16 start, bool close);
+void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq);
 void mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats);
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1b999bf8d3a0..1b08995b8022 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1208,15 +1208,6 @@ void mlx5e_free_rx_missing_descs(struct mlx5e_rq *rq)
 		head = mlx5_wq_ll_get_wqe_next_ix(wq, head);
 	}
 
-	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
-		u16 len;
-
-		len = (rq->mpwqe.shampo->pi - rq->mpwqe.shampo->ci) &
-		      (rq->mpwqe.shampo->hd_per_wq - 1);
-		mlx5e_shampo_dealloc_hd(rq, len, rq->mpwqe.shampo->ci, false);
-		rq->mpwqe.shampo->pi = rq->mpwqe.shampo->ci;
-	}
-
 	rq->mpwqe.actual_wq_head = wq->head;
 	rq->mpwqe.umr_in_progress = 0;
 	rq->mpwqe.umr_completed = 0;
@@ -1244,8 +1235,7 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
 		}
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
-			mlx5e_shampo_dealloc_hd(rq, rq->mpwqe.shampo->hd_per_wq,
-						0, true);
+			mlx5e_shampo_dealloc_hd(rq);
 	} else {
 		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 		u16 missing = mlx5_wq_cyc_missing(wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index a13fa760f948..bb59ee0b1567 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -839,44 +839,28 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	return err;
 }
 
-/* This function is responsible to dealloc SHAMPO header buffer.
- * close == true specifies that we are in the middle of closing RQ operation so
- * we go over all the entries and if they are not in use we free them,
- * otherwise we only go over a specific range inside the header buffer that are
- * not in use.
- */
-void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq, u16 len, u16 start, bool close)
+static void
+mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	struct mlx5e_frag_page *deleted_page = NULL;
-	int hd_per_wq = shampo->hd_per_wq;
-	struct mlx5e_dma_info *hd_info;
-	int i, index = start;
-
-	for (i = 0; i < len; i++, index++) {
-		if (index == hd_per_wq)
-			index = 0;
-
-		if (close && !test_bit(index, shampo->bitmap))
-			continue;
+	u64 addr = shampo->info[header_index].addr;
 
-		hd_info = &shampo->info[index];
-		hd_info->addr = ALIGN_DOWN(hd_info->addr, PAGE_SIZE);
-		if (hd_info->frag_page && hd_info->frag_page != deleted_page) {
-			deleted_page = hd_info->frag_page;
-			mlx5e_page_release_fragmented(rq, hd_info->frag_page);
-		}
+	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
+		struct mlx5e_dma_info *dma_info = &shampo->info[header_index];
 
-		hd_info->frag_page = NULL;
+		dma_info->addr = ALIGN_DOWN(addr, PAGE_SIZE);
+		mlx5e_page_release_fragmented(rq, dma_info->frag_page);
 	}
+	clear_bit(header_index, shampo->bitmap);
+}
 
-	if (start + len > hd_per_wq) {
-		len -= hd_per_wq - start;
-		bitmap_clear(shampo->bitmap, start, hd_per_wq - start);
-		start = 0;
-	}
+void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq)
+{
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	int i;
 
-	bitmap_clear(shampo->bitmap, start, len);
+	for_each_set_bit(i, shampo->bitmap, rq->mpwqe.shampo->hd_per_wq)
+		mlx5e_free_rx_shampo_hd_entry(rq, i);
 }
 
 static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
@@ -2281,21 +2265,6 @@ mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb, u16 data_bcnt)
 	return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 }
 
-static void
-mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u64 addr = shampo->info[header_index].addr;
-
-	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
-		struct mlx5e_dma_info *dma_info = &shampo->info[header_index];
-
-		dma_info->addr = ALIGN_DOWN(addr, PAGE_SIZE);
-		mlx5e_page_release_fragmented(rq, dma_info->frag_page);
-	}
-	bitmap_clear(shampo->bitmap, header_index, 1);
-}
-
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	u16 data_bcnt		= mpwrq_get_cqe_byte_cnt(cqe) - cqe->shampo.header_size;
-- 
2.31.1


