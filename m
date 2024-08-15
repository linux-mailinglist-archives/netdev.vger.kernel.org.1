Return-Path: <netdev+bounces-118746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E844D9529C1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C17281C7B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87763CF5E;
	Thu, 15 Aug 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQY43B3v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D215CD52
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706329; cv=fail; b=XMTg/egQsLMMV0CP7+Jup8WXaguNF+mQMLwoNzmzIoLe9iAOI8ZNZU+XSgRDJkU62HLmOUi5uy+qZTABENcr52CCHs1MCSusbWXYJfUkprt1UvWJWYHnc5f7VPSpQdXfF2N1A/RfuU57E09zXVl5jN9DG0AQ5go069w05QOmNWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706329; c=relaxed/simple;
	bh=O7vmnGIS4SPReWKZNSYqFZtOdiwkyEYqK37ZtxSpeh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvSryp03yuStJSXMDoiteMPeAeuwhT30zpVRNcizTBjRODqVFT2pIeuq7IJeLE1NcjwotwfOuyDLKdIpsISKW/Ezw882+ADIldtbjBxpspNFGjtCu5uPoh8irhVKj3bw3KqWq+oJZK50LaANFctcYTT42R4LNJxO30RshY2sLGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQY43B3v; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnKQsrrcskGSTfwaVElGUcN5+T3FtuqgHt7cCiIl7DBTkygkTrmIiSxUseFJNJ2LHAQy+qZYOLds2yIlcTZAmnbpZldtYcsHhh6nb1HKYGDCNZ5UtFCKfVsusTEL/3oQdCk5MznYkF9/51kdaLZBko/DO3ioNAtn/ZUSC8CGulvLroMmHMvgYT0jsQNZ/ZvQCmG/DBbKb/o3vPD4O5mGWGjTaCEDiq2CyJiHnN/KbcPTVGrxpdWyYCoJG5jRvLUDz6jWw08gbPwT2rVLuf4mfh9JTVu4Q0Y5jBl9icIj9X1yR9h5Z6AQpGX5J/nr1V3wz9Wo8dndrNPBHQezruedtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WFyNHw7wOLWDPQZ37Y22w92LnMFS84dUjyofzxsSDI=;
 b=DobMVhJzt5tEA/gKxTURWtmkkk6Exs2BtHyhXJsUv9rZRPPZ9yPPxNVeirfB+nWrXykeAYk1X6SOMrJhYQeomc+YHtpmOJXKkFUFtbTIz8D/bqjrnfY9RSdamfRzl2y/kAfafwgLhQE/BiQuZW/iofK8HC1nBb2G+MKyEdIqZq5pPJ7OOzHq/5wR0cQJKNKdePbbLPfrWET3wkcmpLZEor2WXPcEyJ5rPpyBi+09o3JT0RKWNVS5vD7IMaqPArAqmznZx/AmTJQuzW8aXepvVpNAOyEv4SHLtmDLRgAWYuagZVdBnXFzVNJND+x3XCB0KeBdxXj6zX1dLoqjYmkDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WFyNHw7wOLWDPQZ37Y22w92LnMFS84dUjyofzxsSDI=;
 b=fQY43B3vJ+UMFsWeApKKPdC9Z7fU/qNMOVI6yaqGTPBowDNI5JSGh8i7bq5SvkVD50HgJAOOU0FObq8LTrw9C6dG7NEjQi7hHjtzgxm+9l/T3kQBQKymS5UI5AlOBo1U8wLAlCxzeFjtvDOYTqV0atzUzufrsC9bYnvVOFVQfe8mo1RKwQ2xKSYr0pySSqADfYpucIaAVRYzWN6C4T8sXGudqkpd5oEI8v55lHb443nT3Lw8qRcW1bTFZ6XGoY36vmY2kxZwzttEoWov6kaEoWZnyVt2+21Bz9ca/dE9dkjZOa5WgqZ7jrreFTrB4imyNzaYLOEksDoY/ZD7RQnUIw==
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 07:18:43 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::73) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 07:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:18:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 00:18:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 2/4] net/mlx5e: SHAMPO, Release in progress headers
Date: Thu, 15 Aug 2024 10:16:09 +0300
Message-ID: <20240815071611.2211873-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815071611.2211873-1-tariqt@nvidia.com>
References: <20240815071611.2211873-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a67dbe1-1bda-4db2-1cf4-08dcbcfa7e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?texUlLMeTL+CEI+RxbG90hgvBdoLy8uJqPD767zpWrmZGOIDQ5dlqH4UPida?=
 =?us-ascii?Q?0eivacAyuDwUKPZwhi4fyyMAdrQjEJI702jBxntdEDWdCOEXRRG6PBaR85ei?=
 =?us-ascii?Q?qvZ0eF6y2G4Ka8vl7OsBe8onoXS7zISEdmofq2A/MfkTwleFrL4NFdD5l3l3?=
 =?us-ascii?Q?R/3jBkW89kPiVobdLNNQ+/4pQh7Kt0zEIQFoD3T6O06SfqMlnNrYyewQSkCW?=
 =?us-ascii?Q?SesojDfFXlYgPWn6FwcUfSiOaoox1+/yMSPg20fDrmNFu+TTdUIQdJRxkfNb?=
 =?us-ascii?Q?rfaKRmoM7u2wGU3bsKnqqg5Ysd+WI5SGZWLdaqU71HJe5q/efzu0vwhKrRHn?=
 =?us-ascii?Q?5pHuzcFncabvIQRqm5jpNSMW1VddgFNqaNT9bUVj73jD3zISgSEsuLL1KG67?=
 =?us-ascii?Q?L3ddDX2XQOWp64XTq56kbsW1Asa4v5HbbekZj27H3LgrqMqiLoR8wfgc6RjY?=
 =?us-ascii?Q?BsgAoNSMJNr2Yy+DHx2KaNCX/JBSRbK9z0ewjVZqJxxGbA5f8kcRCSBPLN+k?=
 =?us-ascii?Q?vg1Ze1dwU0MVKIx22A3MqEIWcEigYY44YHdyD+c40Nc6HGWJ/9+OpmTp4PqR?=
 =?us-ascii?Q?8j8zo+spyup7p69lg2hJkqs1XuJuVngacmjk5XuXtGl+mz3wMhYSEHLXObox?=
 =?us-ascii?Q?7WLrNs1wppvjphywuKOpycAg710F+r1ijRAsq8HsqtNL6ir6zjMNgLBTCnGB?=
 =?us-ascii?Q?dDUhEgJvw8HuAh96yxxNKfcuowaaH3Of7GmTyK0pX+kMloK6UT7s6o9sRjd+?=
 =?us-ascii?Q?IycDlf3iRlpCp2GVsO7uaxbW71+FQRl8YxGP016TDFReH6HVGVSexsKY1DFM?=
 =?us-ascii?Q?RpYzTLeITUsPEslWZ5is8oM/VyqVGSgZjtA6i07yPUWBurK42PabgS0iWJIC?=
 =?us-ascii?Q?IwZd4+L3Qu5xbenJkCNBuEPU2RxEsY0HeJ5xh1qvdh4asn7mYG1u0Z7/sPWz?=
 =?us-ascii?Q?A6TgrLz43FUYy+X9OY0t0e/4PdnURjjHhLBj8F+iwp8dX8XtJSAD2k/wV2cV?=
 =?us-ascii?Q?EIl5DXlMf2pr3GxOtNuWD1I5SkBlb72GqFDTtoAn2sRI8yjSp8MhKDP08KxH?=
 =?us-ascii?Q?3+dtiIms1Q7/hMfxf7jboUUs/j9n2uNDnxdesT+QI1uxe9gj8GCvjvc45Ii0?=
 =?us-ascii?Q?rHKdbzHJHri57IyMl5I5YoKyDulKnI2v9yCRXaEee23TUBr8mNsWi1CBU5gY?=
 =?us-ascii?Q?Yg+iDOYQa5ENWy0kJ+uBq8obS2pMrzNSZdML/egLIO+O3OfXSXgn/rCrb49Y?=
 =?us-ascii?Q?Ch/O6LFs4c55W1H4agCGAo+sV8RXPoh4SeZvGFH7WDK+65UboHdhWqW705UW?=
 =?us-ascii?Q?REErAM+bLK08gcTw2mqsCEdZr+CaqPeZnTSzMPnWl+f+N5zbjE6aBp/qe5o+?=
 =?us-ascii?Q?2EBaK2HyyM0d3Z+fKsOJevryGmLCYz3u5yqdiOF6sAoJMjSAlBPILguY1NmR?=
 =?us-ascii?Q?etIqymi3kgs41M2qAP0lkzyxlHuLn5PI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:18:42.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a67dbe1-1bda-4db2-1cf4-08dcbcfa7e84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154

From: Dragos Tatulea <dtatulea@nvidia.com>

The change in the fixes tag cleaned up too much: it removed the part
that was releasing header pages that were posted via UMR but haven't
been acknowledged yet on the ICOSQ.

This patch corrects this omission by setting the bits between pi and ci
to on when shutting down a queue with SHAMPO. To be consistent with the
Striding RQ code, this action is done in mlx5e_free_rx_missing_descs().

Fixes: e839ac9a89cb ("net/mlx5e: SHAMPO, Simplify header page release in teardown")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 ++++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 25 +++++++++++--------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index bb5da42edc23..d9e241423bc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -998,6 +998,7 @@ void mlx5e_build_ptys2ethtool_map(void);
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode);
 
+void mlx5e_shampo_fill_umr(struct mlx5e_rq *rq, int len);
 void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq);
 void mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats);
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5df904639b0c..583fa24a7ae9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1236,6 +1236,14 @@ void mlx5e_free_rx_missing_descs(struct mlx5e_rq *rq)
 	rq->mpwqe.actual_wq_head = wq->head;
 	rq->mpwqe.umr_in_progress = 0;
 	rq->mpwqe.umr_completed = 0;
+
+	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
+		struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+		u16 len;
+
+		len = (shampo->pi - shampo->ci) & shampo->hd_per_wq;
+		mlx5e_shampo_fill_umr(rq, len);
+	}
 }
 
 void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 23aa555ca0ae..de9d01036c28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -963,26 +963,31 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 	sq->cc = sqcc;
 }
 
-static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
-				       struct mlx5e_icosq *sq)
+void mlx5e_shampo_fill_umr(struct mlx5e_rq *rq, int len)
 {
-	struct mlx5e_channel *c = container_of(sq, struct mlx5e_channel, icosq);
-	struct mlx5e_shampo_hd *shampo;
-	/* assume 1:1 relationship between RQ and icosq */
-	struct mlx5e_rq *rq = &c->rq;
-	int end, from, len = umr.len;
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	int end, from, full_len = len;
 
-	shampo = rq->mpwqe.shampo;
 	end = shampo->hd_per_wq;
 	from = shampo->ci;
-	if (from + len > shampo->hd_per_wq) {
+	if (from + len > end) {
 		len -= end - from;
 		bitmap_set(shampo->bitmap, from, end - from);
 		from = 0;
 	}
 
 	bitmap_set(shampo->bitmap, from, len);
-	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
+	shampo->ci = (shampo->ci + full_len) & (shampo->hd_per_wq - 1);
+}
+
+static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
+				       struct mlx5e_icosq *sq)
+{
+	struct mlx5e_channel *c = container_of(sq, struct mlx5e_channel, icosq);
+	/* assume 1:1 relationship between RQ and icosq */
+	struct mlx5e_rq *rq = &c->rq;
+
+	mlx5e_shampo_fill_umr(rq, umr.len);
 }
 
 int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
-- 
2.44.0


