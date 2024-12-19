Return-Path: <netdev+bounces-153477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF289F82C7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6D816553F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D219F11B;
	Thu, 19 Dec 2024 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQeSNgwS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C019F128
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631198; cv=fail; b=jeRN6cchT8uaKWCnri2GUDooOkygsaEBBsWP7JEGZfk70lrgMlozmuNt6sw+toU+a1zJuNjNb79d4q57uTc8i2Da2Cjg+ej/akCijSjltHVdZAA7q9eiWNCDssuT4FWWQEs8sWpCvHeLKiShT4k77zlpkLTtdtxj8joz6tP4k5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631198; c=relaxed/simple;
	bh=7owLAu3BDShyGNg+I2VB3y9LmelfqjDIDwH/uUcdWWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTaHV9n8iVfqrJDIIKIHOS3xKwrQHXLQ+OGg2cCwanJ98qFmwzd54oN69a1WTAXnmBV4irRefDPmUq5BMtQpZv0Os9xKOmTTRd0UWHhW0v0MjHaeJPy67wZqFsv/4Y0lVrB8ttmqQimb1AoN788KLBegQImTCfLcwOjX/EIGVSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQeSNgwS; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am+wMkP6aI9CDULosV0iQtHNAPYMys+t8OOFfzcLEHylbP8+ej9QCtNoPe1zYx8GnG/xo5axEb+Iorchaej+n2rMgc7WcvCefEUszQDID7RPy9Xazzrw8nvXFZg3WQNQHpKKuZBm8fbwVN4k38E9/wyP9sbmvpnn6r7Wp7tb5KWNI1sDi1+fXy/eprV+Lg8o7U4Q//6jgcY9Yg5H5EHYEOQYcBUc/mD9El5arDrNkIUJp4JLr2m9PIFxiTn5aAn4WwrEAjezu3MRQldCy33lHoYRfbw8R0fzUdLsvQdbPems9+MsgobQAkAFzNJZ9achzuLrR815Dwxo27t34wUpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5t4D6dRarTSUKhyFRR4Z1wi+zTqEQjU935JrFFi0Mk=;
 b=fhwgjWpTi4vY9TQzHY1fKChD8uhHGiM/MbdmME3JV3RbeHfs9hLfLJ5Az7WtETyTEdVr3hSGJcOLC5kkkhes4eugUk2PkoW5xW5TFR5edokJBN8nbSWXcBc9Nj3RF0TB42FAS+78Z8amYR4h9UGTTUzz9Iz8wPvi9YeHTjH8rQDBNpA84TlZjZo3/VeiXHIJkFjTTGM0JzDmhgzU0LojHN2XUaoLazQRwdD8XSqPKlidyjJ5cENysFEJMXYjUI8kJ9pRaSGSl5obxLzfAUZ99udnA1gRERRd0F/zXRc+icA6xTouqekg1jZgIgONbg7UD5oAmDd7HhRFy3uIsPOZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5t4D6dRarTSUKhyFRR4Z1wi+zTqEQjU935JrFFi0Mk=;
 b=VQeSNgwSWE7HegnzfzOUxupF+Y4xoarAoNox3W13pdP1J6BHBl30KwsAFepWr359ureGULCHp1VU25l4l+Q9idlQ2ql5vhiKOK+aHkcrsoj8GVJ+8Rj8EcZrt9uTFB2eGB14mrOvhlJ2RBf5s/hdAw+5aIhCIWvBrdXF9MfhVvYew/toRqG/FRUMa31iCzU9AE8axX9vkB4RlCGwa1zCrp1sFRNfXivX2YR+6+snX5oRAyJ6wObuWmI3K7P5k+29a0agQMDZZ7jG40pR5BxyY/EBYEeEJ8buJa933PM6wjDm9hWAWrViWlccgVRaG2AGH/vNUNb5RjZU5qYVJ/7r6A==
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 17:59:54 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::98) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 17:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 17:59:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:40 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 06/11] net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
Date: Thu, 19 Dec 2024 19:58:36 +0200
Message-ID: <20241219175841.1094544-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241219175841.1094544-1-tariqt@nvidia.com>
References: <20241219175841.1094544-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: aa144869-e4d9-4110-bdd8-08dd2056f0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6qgluQ9+tNuZMvG3Q7lAjorKA79tsHS2ws35GBXqm/m56fR+WpvIeomtsAm4?=
 =?us-ascii?Q?LMpbxrzdV/OomVMPVDgwBZpJr/onlbHXKJNCWPfA3AgclTkYpUm4gQZT1CnM?=
 =?us-ascii?Q?f+E/eB8UpqBo1DFbjO3B6Tes/zjtliaDu/f0nSXjvy79OXpkXsjBp/WIt0l/?=
 =?us-ascii?Q?CqbxogKvuLWgMvlgr7pweOBkkcySWCVCbwq3KzK14oI5XXxMxRY5xQyB3H52?=
 =?us-ascii?Q?67232TrLy/39Gb+pfwqGXtcsjDoIxICwlXszuyACfD7a+wE5wyM8VKNq35kx?=
 =?us-ascii?Q?ggxZNjr2I75MQTduPjzKQW/4lIhtQhJUVWEk1rHh4sfsPhDDjlWgye5u3u6y?=
 =?us-ascii?Q?RVRgtJRlqyZ3xxsAVKd/EeqxG0wn6KXBMvR++yw7k9lXVCUoKGZF/KqPaZe1?=
 =?us-ascii?Q?RtQIhzai9qQyawPtJxEghGlXG2ih6JX8JYf2Ke2t9RN6yK8iwCJrLgc+uwEs?=
 =?us-ascii?Q?VQPnMbxd6GmGtLBPoGg19b2vQW6jdGhHavBxL4dZGKIuVoKDNlw00iShVRAU?=
 =?us-ascii?Q?WJmr3FSHHI29vspGuosuzi0q7gwzzy1xsYui4r1AgF6tRUIfXCrI9V5G34Zy?=
 =?us-ascii?Q?hbvKmlBrkYQnV5seivjPkWD6UbEichHIH6H5yqOXFQobxr0f5JHm3yPnVMSM?=
 =?us-ascii?Q?j4olWsKo9EwHbQT3AY2dEFhsPBE21UcnPTPc11qXE9/EPdZulf/FkT15Obh1?=
 =?us-ascii?Q?prKOtBfmbWhOSS/yflP1Zyk0eoqlPy+LdRbE/0L990RXzT/zSgr88phGBc6z?=
 =?us-ascii?Q?X6BcQ0mjLvuGJDW6QgP5MF+GeQwywkoyNQHaZ7qlK2RLi1KfCYkqpMvo6os+?=
 =?us-ascii?Q?6eq+aI7IR77023r2n64+1Kx9ciXMgXh/K5y8bz+Gh9db6oo0Am9x576Z+l0E?=
 =?us-ascii?Q?VBQ3h3KEwYWvxCEDbruonaNvai6bqhF/V3Jd5EsQ1y7RrmU5n0wzEuA6e9tM?=
 =?us-ascii?Q?8SBjnSHOYuhXIv32l9hTnw3N7npY4m1fOYp7Eb+7cwaxQX7YtEp7xtVwGXQ7?=
 =?us-ascii?Q?mRbLOLm/FtXOqxyHt74w7CbCfSn6+GP+kYpYmq2qLiygfn4ZXhbKRj/BEpPv?=
 =?us-ascii?Q?B/mBbl2y7eFuz+wPU6g/j5lfR7mVtMVq4GG45xcU2PWm4p8fTK8uB1K1OK/Y?=
 =?us-ascii?Q?TKrY5w9A7LxIOUO/neHA3iHUO5kRix2cjtS0B7CREje2E54zxpJo6ISkelAB?=
 =?us-ascii?Q?N1C1cPqNT1Oxh14OD2janWcqh6CThpswvWNrCf2sV0vB6UhMzq1aSxkbzpJD?=
 =?us-ascii?Q?8pv5M/u3WDskrSzw1er2c8VtGmJJLs7t+5Jo4FQyDW4wpbbAjNGAYrYXgWBW?=
 =?us-ascii?Q?kRSrACPT+B6X3sCGXmnRTlXzwTLhRrnPzjZ0QmVQUZpRGgnS93Ljc7Z8BjPt?=
 =?us-ascii?Q?pzF6KW26/WI8aXsFBC/kogR9f7YXid/PczYf0fYQ97UQOmTpJNqxzVPldoSt?=
 =?us-ascii?Q?5haqBgZeJRig15GieFO1bok9y4Xvndc6gAyGpThi/jA4Mxgx3JgEwJbdit/V?=
 =?us-ascii?Q?ja2wrFqBr9my/FU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:59:53.4142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa144869-e4d9-4110-bdd8-08dd2056f0cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

No need to have mlx5hws_send_queues_open/close in header.
Make them static and remove from header.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/send.c   | 8 ++++----
 .../net/ethernet/mellanox/mlx5/core/steering/hws/send.h   | 6 ------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 883b4ed30892..b68b0c368771 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -896,15 +896,15 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 	return err;
 }
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
+static void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
 
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size)
+static int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
+				   struct mlx5hws_send_engine *queue,
+				   u16 queue_size)
 {
 	int err;
 
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


