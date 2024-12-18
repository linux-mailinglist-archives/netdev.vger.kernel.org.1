Return-Path: <netdev+bounces-153032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3679F69AD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21238163FA7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE01F5421;
	Wed, 18 Dec 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SxZcJiMM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466B189F37
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534691; cv=fail; b=l3HalH6lrF+5cRA6OlfNgSWfGy+WJ+ACOqiq0gKndJWRIytp1k+wUfS8hZbAKvP+ovBq1PT0rv+CkSSrPa6EOMa7V2pAwfatshoyRB3Jv/aPCwvEtsaLpARzwMyp2rcs4Sh9h7RPdAKnRVQf2D6Hoqi8U5zUVo2TLDajm++HLuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534691; c=relaxed/simple;
	bh=BM0oVkwsYDP/lLKPNpnIvhUQosLNqXsnIAF0MyCO0/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUIqtA+LXGf9g6zxscrOgvxsZmshTOnzaG+XcJp9ArVh+ASBAXjbJ19WgSNd3wfSiJvrpm//EiwNT+weVYQbfVLfOQh5meiTTDITdX86UWRBxcx1FPdrfVwbrZF0ABdeeFd+7eBhxbpmkFE39AQuQ7teRUir/7ML4NUy0TMLtYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SxZcJiMM; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF8JOZXVg8G80yp1DkrYpxwkpC6ktjaRMRDSeHvwXTPDxRqJuIDf8shhOLL0hFBPYitLwK6JKpuJYrSbQMJBlm8LFRR7PaEbe78jDdMspNod9huteRZo3pIeN1H1JZ5qxHpaJPc+40ZEt7pfDIY8cs35ii8V1Ex3vF+CGQeRq/iABSHZwbathFTI6fuUTocqVAvNp7aYp/uPE8qefTskAhOZOW/b4E0bQAfNKZOhHji81R+0mrfTFuHgNrSP3d1zAx3BWaN2A8EFMoNLlo6DLEzACIx7vGmS9OVsYAETEqh4Wd72RTjhF0j60RWjmmuLRvtAy7iQMCTi3ndzrel/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfBRJjtoRGXxPiP4uv96aFYlMm0j5MZHdZV6dO1O6qE=;
 b=qnZBhuQm55HX287S0Ggpl6eLScdm8SQHhNG3qdqltG140t/h/rPPGTKpmEAFAoTL5NsoBIuaIODOKlQnNxeLi01Vr7kIzqhlYfiHvHITK/7F/njOuGGdTB4szJuhkZsdRTxUllFgLTrPreyo2NHtkg6CorNZ7hxHNadZqUhZ9qorKNPEfGkkTrEyjgY+DbsKKQhiojxktLFUuhZIMP1X6Ct9guyqVd/ih4ckZhK8aX8audjhNGCO3geB+TwE7Tg/7opybVPGBJwUxCo3nh0ctjCkHKk5dHNGO8/EoWKjTOIreKHSSrktlgolXLeGbkphDyKiRKFguUH20h18Am1XWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfBRJjtoRGXxPiP4uv96aFYlMm0j5MZHdZV6dO1O6qE=;
 b=SxZcJiMMKzVyHjbX/z0qdyxExAdIlL88AfWRR750vQRt/oP2uLSPm5P76UmOJPxCEPyG6EBFklZDLVnYqDeiWqEEoFaWdvlDKwmHz+e1T3RNEzNk2doMNrtY+tzp8aotJYurYUwqaY/qx4AzJATNYaM56+j3MF1w+FhLQgS211cSozuZhMSN9mQo65uDLkPuzufIw219imNEfjsDgjbM+Vy5TjZHmj366RRmBwf7DjAgviNYVh1rToYfk0/UPf/4xXn8XMwvNb1zektS/m2qylnP63HjFzgas/5NE9FLKma7jKE0czGJ4Nggj7KhYVLlIKBMvq2izH4vxID4o9ST/A==
Received: from BN9PR03CA0106.namprd03.prod.outlook.com (2603:10b6:408:fd::21)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:11:25 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::bd) by BN9PR03CA0106.outlook.office365.com
 (2603:10b6:408:fd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Wed,
 18 Dec 2024 15:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:04 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:11:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 07/11] net/mlx5: HWS, do not initialize native API queues
Date: Wed, 18 Dec 2024 17:09:45 +0200
Message-ID: <20241218150949.1037752-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3ef811-357b-4264-1555-08dd1f763da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2svJH4SNLxiAVQpmrQ/1HR1X2bPgkP/hS1Jl1iXfJkYy9yLdTsiXpqwNpXBA?=
 =?us-ascii?Q?4wEzGOKF7WTMT9wVCRmgIEzO0WmmBDsupaunDHd4KO2uuYVdsDVdJlD2O4Y6?=
 =?us-ascii?Q?tq30jkjmirtIGlohsdkTg3cQgCo0oYIEYWHDs3bYVOjF34jjZgTVts2gzfjb?=
 =?us-ascii?Q?nkzVybLfUOGctWiWlaHQCvbxQ/NqmSP0JgQ09V8xQpbXGtfe2AxsQ9qzC1Bi?=
 =?us-ascii?Q?PGdyijkFcjk4GAI33gwjjB9EqYd0sEZskEQ9JOzZSDYnyRb4E4Q9c3RO4iuq?=
 =?us-ascii?Q?PWb2N96MDcUGCc0VIhIY3mfFEwpfl1MW2td8XLAgMssJxrJMM040+u+84uaY?=
 =?us-ascii?Q?Vwlm5OobMseMma08NNgoxuR5deUNpqJMH5w8Ch+oAjf/damMrGn63edWphpR?=
 =?us-ascii?Q?D9Y+BWeEpRcJ6ks3QDDply+vHClc25M0ZROiQ4C9cJ1VjJUAziBWh/OvzAaf?=
 =?us-ascii?Q?GjpOM/zbszgNE6/YttzCmBT7rKoiBy7ZzcPF5YI2UzBIW6FtE/mhXzqyQybx?=
 =?us-ascii?Q?soDNe5Lp9uGRxpZ0rDZi658u3aMlXT9vLv0F7eSQsD5W1FcEIZowuiizyQs6?=
 =?us-ascii?Q?vLlFczz6BXQRKdhSSUF3Gcnzo49j4W3DrpATx0u8kjZoGViznK4EXVbuv7CD?=
 =?us-ascii?Q?PGCVHljScXhNI9ZEmEEXUjUBs8piaMcHihhaxuyYSaMtsYNwvSfSJnRXscpU?=
 =?us-ascii?Q?tZne+NS8DhNGMvoorrMX84pkTOFkVD/17wEpIxJoXx2FDMB50MAKDwuGj5sv?=
 =?us-ascii?Q?841KF9VoJ6JdZuHwKZ/ID43OZJ9J2gWrx6YfMIz14peKFxYZT3/6tY1hJqNs?=
 =?us-ascii?Q?SmdkyUvrvcVx4i3lM/Ok9QWUQCqc682/+gshSv0OcYmgPsde8gtgpthTGHR8?=
 =?us-ascii?Q?9Hi32ayMIh6cGEIdGbk0CnCTC9qKKgirc/npAexz7qOyXMHQorFP6Pf6JaPk?=
 =?us-ascii?Q?h71ndWsU/4DbtJiKItypbdN/ntJBjIgZaD71Y0zQFYg9wK84UfkQzDyGkKcc?=
 =?us-ascii?Q?hy3Ug8nGl0QwKJvjq7241GPKm8LG5BeZpA3bwooAMv9Z4+s+B/GTRKaN/zx3?=
 =?us-ascii?Q?lkdrciIe/2Lpo/EKGWGdy/I/lIPkzZXcwAaUkWeEBknFVrhucGkwPD1ubjik?=
 =?us-ascii?Q?VVgteE2D4vg5fiB4pZeItz1wDJbFiupD4tEx1/seYoSYtrju9SXqsFH4BlXF?=
 =?us-ascii?Q?uzDmCRIMcvtZs3d4+bP9kj0AItbLUiXelfO9NwOl9ysMiMuYHwuWehfjs3Xd?=
 =?us-ascii?Q?j0OjlU24D8d9WNK3gh/e/N7mo0F8ol1SRYn9ZHUFcmN93r4Ss5AsuWqpvYlz?=
 =?us-ascii?Q?3jLZDDjctzx8GFsuzSGdrcKFcfQZjIIq4kAuwxmZFKWvZyi8gCB5bT01/rTU?=
 =?us-ascii?Q?h6NxXhreAP2W2NSImT1WkQo4c0kSsb71RKt0F3zZMQK83ixSEJUYgLjqWo1V?=
 =?us-ascii?Q?d9FuRjHfT8b5+E6ZFUlBk9hZQG/oV0bXQK04OEA5G0UNiANIOVZ7PilyrLWQ?=
 =?us-ascii?Q?BDFoJB6gvkGb6As=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:25.5121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ef811-357b-4264-1555-08dd1f763da5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

HWS has two types of APIs:
 - Native: fastest and slimmest, async API.
   The user of this API is required to manage rule handles memory,
   and to poll for completion for each rule.
 - BWC: backward compatible API, similar semantics to SWS API.
   This layer is implemented above native API and it does all
   the work for the user, so that it is easy to switch between
   SWS and HWS.

Right now the existing users of HWS require only BWC API.
Therefore, in order to not waste resources, this patch disables
send queues allocation for native API.

If in the future support for faster HWS rule insertion will be required
(such as for Connection Tracking), native queues can be enabled.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  6 ++-
 .../mellanox/mlx5/core/steering/hws/context.c |  6 ++-
 .../mellanox/mlx5/core/steering/hws/context.h |  6 +++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  1 -
 .../mellanox/mlx5/core/steering/hws/send.c    | 38 ++++++++++++++-----
 5 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 0b745968e21e..3d4965213b01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -60,9 +60,11 @@ void mlx5hws_bwc_rule_fill_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 static inline u16 mlx5hws_bwc_queues(struct mlx5hws_context *ctx)
 {
 	/* Besides the control queue, half of the queues are
-	 * reguler HWS queues, and the other half are BWC queues.
+	 * regular HWS queues, and the other half are BWC queues.
 	 */
-	return (ctx->queues - 1) / 2;
+	if (mlx5hws_context_bwc_supported(ctx))
+		return (ctx->queues - 1) / 2;
+	return 0;
 }
 
 static inline u16 mlx5hws_bwc_get_queue_id(struct mlx5hws_context *ctx, u16 idx)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index fd48b05e91e0..4a8928f33bb9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -161,8 +161,10 @@ static int hws_context_init_hws(struct mlx5hws_context *ctx,
 	if (ret)
 		goto uninit_pd;
 
-	if (attr->bwc)
-		ctx->flags |= MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
+	/* Context has support for backward compatible API,
+	 * and does not have support for native HWS API.
+	 */
+	ctx->flags |= MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
 
 	ret = mlx5hws_send_queues_open(ctx, attr->queues, attr->queue_size);
 	if (ret)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 47f5cc8de73f..1c9cc4fba083 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -8,6 +8,7 @@ enum mlx5hws_context_flags {
 	MLX5HWS_CONTEXT_FLAG_HWS_SUPPORT = 1 << 0,
 	MLX5HWS_CONTEXT_FLAG_PRIVATE_PD = 1 << 1,
 	MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT = 1 << 2,
+	MLX5HWS_CONTEXT_FLAG_NATIVE_SUPPORT = 1 << 3,
 };
 
 enum mlx5hws_context_shared_stc_type {
@@ -58,6 +59,11 @@ static inline bool mlx5hws_context_bwc_supported(struct mlx5hws_context *ctx)
 	return ctx->flags & MLX5HWS_CONTEXT_FLAG_BWC_SUPPORT;
 }
 
+static inline bool mlx5hws_context_native_supported(struct mlx5hws_context *ctx)
+{
+	return ctx->flags & MLX5HWS_CONTEXT_FLAG_NATIVE_SUPPORT;
+}
+
 bool mlx5hws_context_cap_dynamic_reparse(struct mlx5hws_context *ctx);
 
 u8 mlx5hws_context_get_reparse_mode(struct mlx5hws_context *ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index f39d636ff39a..5121951f2778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -70,7 +70,6 @@ enum mlx5hws_send_queue_actions {
 struct mlx5hws_context_attr {
 	u16 queues;
 	u16 queue_size;
-	bool bwc; /* add support for backward compatible API*/
 };
 
 struct mlx5hws_table_attr {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index a93da4f71646..e3d621f013f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -898,6 +898,9 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 
 static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
+	if (!queue->num_entries)
+		return; /* this queue wasn't initialized */
+
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
@@ -1000,12 +1003,33 @@ static int hws_bwc_send_queues_init(struct mlx5hws_context *ctx)
 	return -ENOMEM;
 }
 
+static int hws_send_queues_open(struct mlx5hws_context *ctx, u16 queue_size)
+{
+	int err = 0;
+	u32 i = 0;
+
+	/* If native API isn't supported, skip the unused native queues:
+	 * initialize BWC queues and control queue only.
+	 */
+	if (!mlx5hws_context_native_supported(ctx))
+		i = mlx5hws_bwc_get_queue_id(ctx, 0);
+
+	for (; i < ctx->queues; i++) {
+		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
+		if (err) {
+			__hws_send_queues_close(ctx, i);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 			     u16 queues,
 			     u16 queue_size)
 {
 	int err = 0;
-	u32 i;
 
 	/* Open one extra queue for control path */
 	ctx->queues = queues + 1;
@@ -1021,17 +1045,13 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 		goto free_bwc_locks;
 	}
 
-	for (i = 0; i < ctx->queues; i++) {
-		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
-		if (err)
-			goto close_send_queues;
-	}
+	err = hws_send_queues_open(ctx, queue_size);
+	if (err)
+		goto free_queues;
 
 	return 0;
 
-close_send_queues:
-	 __hws_send_queues_close(ctx, i);
-
+free_queues:
 	kfree(ctx->send_queue);
 
 free_bwc_locks:
-- 
2.45.0


