Return-Path: <netdev+bounces-153478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634269F82E1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812DE18854A0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB21A4E98;
	Thu, 19 Dec 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lUetKpz5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DD1A304A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631204; cv=fail; b=IVlQMpxH6yITluIOCGXEuWDF+XDhg9/8XCjEEaSdRwrjkkH6N5iIIsckcZP/kr6JABJd8g64keRcFdpSo56e37Eu+NY3cN/coSf/UOOZPIWV2wqtbMbDGLvZOxGLrZyfVwp5jmGStEz07Y9jxR8aQrkbAvDNzIXpycCqDWHl2dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631204; c=relaxed/simple;
	bh=MxoLpt6DKIYGQkenwk3O+WBmtG9XEjT1znS3k3zFCcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4aAFtT/EbkrP3A9F6dDkD0T0Vu06NPD57m2qKqWbBRVyVJgfd4mLcx8F+rIc1pWhYh97NivOUF59S7TStz6ZfTQrbn8+DE0Qpf0OADnKmsmptf8WDD4GtwYFOPebd0/g0vBJBEwuAIfnGTqc1/579VhhpVOF80/sC/xiP7emdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lUetKpz5; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmxVlml9rEiEWJ0ZWgDbiSAnir2K+uZKDhnFB8vnt7noIwB0P7UXeloYusO1AvjiUlpwWt6UU4drwq5qF0Q9s74moJ1nDQrTvOhCYVbjlljjjecK6oal22BiBUEb5mZon5ay70q3Q6KlIv7mQoDl4EWDY3SJ7ibSPZ/g+xeNIaaIocQgBMqxqqrNObtcX1wLMASFG7yjW6Qh6dMmRl/ye7ZeFXI+G7X9pozqm2q1q3bmuk8DqgqpaiQeygq/SGi5rsbotalH07KuaBMohbTdgGUcjM0LPnnIhh9CA1TTuGO5cE2gDqRugrqDxTkG/y1swUvse35LmgoitNK8BiLBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seN3fCOA1OTqBplv/a0F39bQc7QyZ/kIjP4XlY3zIzU=;
 b=evS6fEBtSnHlMLSGD7xOMmeB0sio35AMcQy8ZwLwqdfNJFW1MbH30pduxflKV6N65aMn+TjPes/XjkcmgHrKh5O+wTEA2lpeApJbyCwHJyMr9Sb3d7DYHW7EA+YrpJR7KiMr9yswKzWQv4kYfXq+O5dc/eF+XT0VT9JkPp5qa+D+evHzgddKob5MkrfeV0OF6xWKlUOUG/uFQvL+QzlIVt5PC7GCh0fDkOM4C46exOxSgoV5ShDPX95F+rbhk3NHtZOea/mpIKhvapyc6ha9x4v60OqT/HLTa2+khBOy4Ok+5o1Kxn0fLaX7P+DX+xVXEV5zKyhxUPH9tbplfGywEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seN3fCOA1OTqBplv/a0F39bQc7QyZ/kIjP4XlY3zIzU=;
 b=lUetKpz5BTVFrypIwgQCViu5jjkYxsRNsruyQ2O5v1F06dVME0NBDxvhQ7AHB2Z7x10P2Rnn9nSod5X8o7qLIGBYPm155WV0g4yMHkICIFwwdpk6H2jmOgNG6P9dwuAGbodKNJs1oSk2nBBRd3qjokhjLxvxuxvb78tFz4iuVxNd2H4CmdwwEqAspknj/i+cWHrkjkWocFK3G5pOR1gieGOXztwODozywjzrx1ciGY3cwDArc5I0YMHxHzhb3uizuUpG1OLGaP2aXLwgaNFRW5qBhBMoYDQbb0hIlzJ+D790xDpwh9/hzrZ30iuXsZw0RibBT67auhjt8sInlvFsOw==
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 17:59:58 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::e7) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 17:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 17:59:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:44 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 07/11] net/mlx5: HWS, do not initialize native API queues
Date: Thu, 19 Dec 2024 19:58:37 +0200
Message-ID: <20241219175841.1094544-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: cf56c2c7-a773-4d59-9ebf-08dd2056f376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RJxobw5v4TrT+RIkwuzK0LyZDy3pfv9ngUZT0y+TFkD1Af2bBk3/zj8yFMjr?=
 =?us-ascii?Q?uemjod70NSQhHK5cFIinI4y9ok1wRBvmAoyWfS6lQ4by3ZkEK7Pk80QrkLTe?=
 =?us-ascii?Q?JmV05xDMvW1iRrihDreAAQtTagOjAd1taQuMUKfXfhMsuElRYyniwoI8pYfJ?=
 =?us-ascii?Q?FSgTNToAenDeNx4xT/3fDEOS5kC+H97kh3GvZatEXI0U6ilAvu/SuntEBzto?=
 =?us-ascii?Q?2F6rrD8kn/hw07CBg8ZOgyPyzGnlzQnSCgdNaJK6YyCXvtFoLgVaTXRiEMPz?=
 =?us-ascii?Q?lh8PXertf8U8Xo1MCP+uExJ+kHx6FVJdXv1Z8eLquRgjzKher5TpL6iWjrP5?=
 =?us-ascii?Q?4K+jn8R+fSvwNBzlKBzqrI5fLKh1QQhBULI8ULzan1J+GL8fV9GSzFBKCHEY?=
 =?us-ascii?Q?ArcHT9PCcr6LoX4aBYOOiu6IAt7Ddu5AcGeeHzboQwvwy0QirTDUksHutat2?=
 =?us-ascii?Q?FTMa42uHQFZlkL57rabVp2ppidDLREB0Bf+m+/JRLISw8kcF8IvLyH6AouF0?=
 =?us-ascii?Q?IMl99UsDuRbey6US0c7WEfDSXjwHyn45pcVN32SVwjadHkAmXPw1Q4KALVqV?=
 =?us-ascii?Q?JeeDVYn3Hsij0/WWf6JITlGdqRCj9rO8NuI0o4Yl213SX8eqkl0lF2Il8k0x?=
 =?us-ascii?Q?TzVktd1SJx13CgEqh3IhB36tfNy6i8WKZAp7ZP2Q3cKROpJgYqNqdZL47BiH?=
 =?us-ascii?Q?R/1oLSEldL0zGwx0g49Z0Cwxu6j2//XBfgmaZ4lmGrhp5SVMrvCbHiJigsOn?=
 =?us-ascii?Q?tYB7bGyu8SbJMyQkSFTdyvS8R6HVl4aNbbTL0aFmsT+ue09IR4TIlVSERC/X?=
 =?us-ascii?Q?9I1j0zbNTrlNVO2VdyRUiuJEnJuoiiWyfg9mzyGvDIh3Pkle85sIyTqHKAbP?=
 =?us-ascii?Q?rlb963TC50rs99NPPZD6GsrXHkwH0by/yHK/7nNx9lmQnjqQDJG6rZUFE5KK?=
 =?us-ascii?Q?hAWcW1fMljB77pxJg4ZxUEGI8MzdaWCUv3kId13xcd8drODRp2K0fdFqqauY?=
 =?us-ascii?Q?K+qDZfRz7QIQAxY8nWiKtWWhiIoq7C7QivtveW3YTvnTzhBiWg8VLRAMJ1ds?=
 =?us-ascii?Q?231aoRjYPhSsfV31dulvKJeR7yJ8kWsx0aKOKTDghX2jhFAuQxdizVUmSja7?=
 =?us-ascii?Q?Ct/c0vlWx+ic2jOYjuB8PdrOFUwWMAHmNK7268gFFyTGbWk3IFmEaUYXRl8o?=
 =?us-ascii?Q?CzpPP3NIleDCIbjtYKRNhKP72Q2AafYe0blKbm+PMbyI2mlMS0yD7Kjti0zo?=
 =?us-ascii?Q?hGjGS1pErpBMrb02D8YclpOUUlmW39oiFq7aTwJao50pV3z0AwjOQpz2GX3D?=
 =?us-ascii?Q?1AUTTc1pBZiNgmFL/ZRrRiDNOnH6DhAltQLsDNDVT38rpBsVCld976SPRcJh?=
 =?us-ascii?Q?rtiIMToTF5f2fpNTTBI+NLxG2MC82wjnN6d2gj8E8VOM8qinEoOw3h3FVFTc?=
 =?us-ascii?Q?ZzgroBurfy+1bskrFskoo+LmA3WqkD4Ta7Z0Zy66qETTMc72/Ni8WE+78DCM?=
 =?us-ascii?Q?jyF8LCh0ULsrUjg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:59:57.8829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf56c2c7-a773-4d59-9ebf-08dd2056f376
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270

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
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.h  |  6 ++++--
 .../mellanox/mlx5/core/steering/hws/context.c       |  6 ++++--
 .../mellanox/mlx5/core/steering/hws/context.h       |  6 ++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h       |  1 -
 .../ethernet/mellanox/mlx5/core/steering/hws/send.c | 13 +++++++++++--
 5 files changed, 25 insertions(+), 7 deletions(-)

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
index b68b0c368771..20fe126ffd22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -898,6 +898,9 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 
 static void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
+	if (!queue->num_entries)
+		return; /* this queue wasn't initialized */
+
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
@@ -1005,7 +1008,7 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 			     u16 queue_size)
 {
 	int err = 0;
-	u32 i;
+	int i = 0;
 
 	/* Open one extra queue for control path */
 	ctx->queues = queues + 1;
@@ -1021,7 +1024,13 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 		goto free_bwc_locks;
 	}
 
-	for (i = 0; i < ctx->queues; i++) {
+	/* If native API isn't supported, skip the unused native queues:
+	 * initialize BWC queues and control queue only.
+	 */
+	if (!mlx5hws_context_native_supported(ctx))
+		i = mlx5hws_bwc_get_queue_id(ctx, 0);
+
+	for (; i < ctx->queues; i++) {
 		err = mlx5hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
 		if (err)
 			goto close_send_queues;
-- 
2.45.0


