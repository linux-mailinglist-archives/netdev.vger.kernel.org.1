Return-Path: <netdev+bounces-153026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D19F69A1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A687A4279
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B21E0DED;
	Wed, 18 Dec 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZEZPm9S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E81E9B0F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534676; cv=fail; b=FkYhC+0HwH33XdCB2QdMslwVaXrQRKQZyObGDk5ABZrv4o8EZ39O7PdY10qWSnFAsnMmrNtV4YFYJamrgVyMOv+E84W6s8FSCqKPc848H/1IDfc/3kT+kpQEjJEJtC9gDSeIEpexu9S6tP6+iGwE1SHsS351KrnrUvjtCsfZae8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534676; c=relaxed/simple;
	bh=IY7BqUWuuIOLFMdm/QGyk9z0dhhJCOH+l8RO9lDzNI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oej1Ia3/C6DeqO+oYO+TFv005HRqeSERwhoEfQ83Z1n9DYudlwO6Q4OiU2rJepVbePHnuEg7iIzU7xbwze/UUDj46su9Re2FBCzmYXuCjpeB/bpip+VDO63fpoJD0Iwnqapex4Xq7CSBm3ECBa+QIsYTLvVPxEv4Ie9lmhDywqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZEZPm9S; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLRkueRMC0j0/Po3z1l64Cs4BrcD9eBlGFKOnPUneiIeNHcS5G1K0N9LR/lAe6XLUk889CAetB8DdeiYmyHBRKL5I22J2nbdttV/AvHVTpyveTmG+HdEgqrj4ConC+9r/PBwgKausHQVzEfZZBlSZJ0bLPgXOxV97P00/7lhk26VLmVuZnXw1FU+9e6WgWEarDQ4TyWmXhvobH/hQZUqUhyu0W7gVo/3xVGfzNsEgJa27MSMMhsGM4pGSPuO5j++7yvxBlbT6Ig0OBbI0uvC86MHAjApFyCqHflteIv9yslPSzqOmYN6DiBr3FRMWfyP40JPLm19oAXvKCffqbTU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ8mWKMnB+KKoKq1c5YinX1TmJt18/Xsd+pKgMrA65k=;
 b=OV0CYGBbwkakaUr2Ll3WEgEUWQVsLLT/N5SL0pc52LM7DtSFU4KNuqrV5kFtmdMAkFPHyu3+QbVb0cPqJwU8QVPkm7rfM3vUt4y1jNU/Cgc5ktxEP7hzel0X2O4ghRZwfw2hfVS3hyigB+tGpjIJX5IL1u8uvOBNeoBjHAdkkxaLxltgZRu2ohGdM5FDmtJ/s2+CaubqCe+LWsFMcU13k+gn3DLhk4lhyXl3DcDCaWduP6WRzZYxBXmhm57PlVlC/ZLRnkPdRZOrxBaZqd4CsJpux5KMp04QGL5pszMEK0OKDoAfy229mN9+4f74f8hcvpC80CPMbyXPHKyqZwDPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ8mWKMnB+KKoKq1c5YinX1TmJt18/Xsd+pKgMrA65k=;
 b=qZEZPm9SkfQxZYIHKOuoV341U3LIbLmcBnCbx2VPcugQUhPrr30oZiFnIbyn0H2aOPPsk/6tzxuPEkzBIggjOofgNAtq6E5wGe6aPWhda4+psAFRvX450d55bBuRiQyfM9c0rYGmlofYpbghY4au5c9iU589ld6P/o0FbIQyuXR0DkzbTGO1D/sKnLgAR298V8sdTWlp0ORheXYH2pahf9M0fKmC2gq215cwXRF1/meFv+uSBgoxIWSW+iradh7wsmId8156guh4HX2lsUIqH2Mhi2CB5w3BtifnlQ+9zGPvR0LfthdW5nTzDLfp7o4xDupDaAg7e07RXse44i2TlA==
Received: from SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) by LV3PR12MB9215.namprd12.prod.outlook.com
 (2603:10b6:408:1a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:11:10 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:803:41:cafe::eb) by SN4PR0501CA0037.outlook.office365.com
 (2603:10b6:803:41::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Wed,
 18 Dec 2024 15:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:00 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:10:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 06/11] net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
Date: Wed, 18 Dec 2024 17:09:44 +0200
Message-ID: <20241218150949.1037752-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218150949.1037752-1-tariqt@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac43f59-853e-469f-0ae8-08dd1f763435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lPlIS/hYJq6Nz3YZlAFQk3XmluBpfvuBIEmlwlmQ8hrvlz79OJELAeg+7ke?=
 =?us-ascii?Q?zDBA9tztUT5bSHOARRcPYPdCpOHGQhwYhXXSOYOU8rzUAjF8lx/tFAtSMyki?=
 =?us-ascii?Q?vFur3QfXngywHZICFsHcxxd953qyzDpiRX6j/QzBArGXaDQYaPm+MMse8Tpq?=
 =?us-ascii?Q?GTl9sCOIbhsPAAjqFAvczKxQwK0CpdJf1gd2adI0a4pzBKMyyX8xqCp9sP0V?=
 =?us-ascii?Q?+/u3Ou+fVtn+9+HtJHqJQplFnDb7V4/YxxSvsNobgU3obS8VCLdnpVZM1Aok?=
 =?us-ascii?Q?pdho11XfeQbDZIsVowvyXkuNXq31PauVxnnME1Fw54IWxhzo7NdDAkOedrFD?=
 =?us-ascii?Q?MUWcuMRvCCV9nqhdcJvowsMqEQftDj4xJrgteBDMCD309qt/dPfvfo0l5zXX?=
 =?us-ascii?Q?jJOhiFuxX8OtCz+5YJXGwHWe8xa10WVQT34kdg67nRJEocv+ztbr+hOJb7IF?=
 =?us-ascii?Q?A4eVItwfBI+1n4tGby6L+X7rlfHdFIF6QSEcsNHJFYM/vkkZt5G27KhkcRA6?=
 =?us-ascii?Q?c9sR0x/trXmXiZLjpBep9bL5GeTH8QrHc0Ih1aFUk2o42oKFaEXLP8ZTDkjo?=
 =?us-ascii?Q?W3BHKrt+NtCddHv+j2zKMaiEIn2ILsm2CUhZmZR7NyczSG7d9IPyRTJBsakr?=
 =?us-ascii?Q?yr7i6PqIO/hTZDXh2yHFGniyEYleTqBFo7Rgbh8rE+438ovC8bypTL9kaekL?=
 =?us-ascii?Q?YpupKUgNpjK5rURemSR9xXnwxHmFXbBAlWwwNN+4P/B3KTEj+86hUlGYkP1p?=
 =?us-ascii?Q?tN1uBJx6NrYULfd3lyb1xzF3McRF+sVQ2prkzeG2K8XzG2thaULCMF2PysKJ?=
 =?us-ascii?Q?qJWPF7+9wKEFKjCTrnEQAwlbC5olGEoItyX59Cpxtfddn0JP2a9EmxGOG6N+?=
 =?us-ascii?Q?2z+fQHex14zCE1959EdSQGLEmf2X8h+S4ncAS5eO0vU2RFsmlLck+VYsHrou?=
 =?us-ascii?Q?Za1F9y3ZDKFFedyJ3WqRJfSAMOarATx01EIfKkUu1hnml5l5Ns8V1WsO/jF+?=
 =?us-ascii?Q?V6F56auXz8nwjtgz84fe4wH/qFeoi6bubQKtQUFqnpjitLXYRuKHe5Sc/JrC?=
 =?us-ascii?Q?O/RddagTl795bSd96mBhQXZvK3vK/jA6YYGXAJk17G9GdRLBvXZBYYeX2SkA?=
 =?us-ascii?Q?G1rHWdTenbUf0Frk2Q2RFQ2iYLu2z2MtmYm5whbtjSGdIfSnJw7oH5zA2paC?=
 =?us-ascii?Q?uJuIVuA/iWFbrq2cpbp79P1Ayz3DHyu5bcEhZnvHrRIl2bzPrbIGQFfEy0Ed?=
 =?us-ascii?Q?077aQ3RjQ+tma6hLwqyoxww1uFKzX5UT1cKLTPzETAeNj6y+0t/n92w2KyFV?=
 =?us-ascii?Q?B2GdmLBAQKhU7xJjnRCZ59Rak/jUrR3i8XnS9Cmhg9fNkWBN+pHibl2RQ9JT?=
 =?us-ascii?Q?Cvz2hwT+Qk9z/15D+8mFLe+aMOLpZMoXzCsxxlx7L6fD4nipnOH3sbseNEoL?=
 =?us-ascii?Q?23WOfOWDGLJDe3M6/1r+i2m/O7pkMGSGnKPbY3EGsAtJPzdwWYYMdqTIUzB+?=
 =?us-ascii?Q?OoPU4SIVzpWiMu0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:09.7409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac43f59-853e-469f-0ae8-08dd1f763435
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

No need to have mlx5hws_send_queues_open/close in header.
Make them static and remove from header.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/send.c  | 12 ++++++------
 .../ethernet/mellanox/mlx5/core/steering/hws/send.h  |  6 ------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 883b4ed30892..a93da4f71646 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -896,15 +896,15 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 	return err;
 }
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
+static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
 
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size)
+static int hws_send_queue_open(struct mlx5hws_context *ctx,
+			       struct mlx5hws_send_engine *queue,
+			       u16 queue_size)
 {
 	int err;
 
@@ -936,7 +936,7 @@ int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
 static void __hws_send_queues_close(struct mlx5hws_context *ctx, u16 queues)
 {
 	while (queues--)
-		mlx5hws_send_queue_close(&ctx->send_queue[queues]);
+		hws_send_queue_close(&ctx->send_queue[queues]);
 }
 
 static void hws_send_queues_bwc_locks_destroy(struct mlx5hws_context *ctx)
@@ -1022,7 +1022,7 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 	}
 
 	for (i = 0; i < ctx->queues; i++) {
-		err = mlx5hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
+		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
 		if (err)
 			goto close_send_queues;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
index b50825d6dc53..f833092235c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
@@ -189,12 +189,6 @@ void mlx5hws_send_abort_new_dep_wqe(struct mlx5hws_send_engine *queue);
 
 void mlx5hws_send_all_dep_wqe(struct mlx5hws_send_engine *queue);
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue);
-
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size);
-
 void mlx5hws_send_queues_close(struct mlx5hws_context *ctx);
 
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
-- 
2.45.0


