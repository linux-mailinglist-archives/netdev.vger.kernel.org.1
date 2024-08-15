Return-Path: <netdev+bounces-118734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C660952955
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB00D285F32
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023D177980;
	Thu, 15 Aug 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJK9uc/Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D853365
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703106; cv=fail; b=K1KvN5b5dLnjsSzW5I3TNtqiYLYP8dbhIICm5ojb42d7AqczDAUgKDfL4MKE4Rgnz6X/76iLGIsUvdF8j3wWXkCKmRxZ4/erIpsmrc/JgzOmCJfFFvezNw1CGWhTH3c3zSKUCRd11FOp6sP3XUjrihGT6reWt9ahnHhNVUS0Py8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703106; c=relaxed/simple;
	bh=3qLR1HOzA7KXGPzPHs9IllVyCNzs+3ovsPUATPBYLJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjK/2ggGiH3NnpAnnTOlRSKLFmT5PBgMteiJINvzdJYjDBEKUnyvquRFVIno+m/MDNnHXnSYfGilFT4sf8ymeqZkL0mpGukOmFvqpNwWWfkqlHu+ZXSyrc+15SlKMd9WwjQCwD7x5nHD1Y4b5e/y4Un7bm6BtlC/kyAlhQcGhrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJK9uc/Q; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHf2TCvkU8Wy0XfgfnCjE8tZyAjNPG2dZq6uJ5DwVh6wetXBE5CVgdKiMEDY9hUe6HcPDuPnc/mbsAeoVx8CKMk7v2+VvFFx9W2jCVdRl3sBcFI2ejb271cyljHATpdQ81v10/v63/7/yhz8TOYrS8546mGym3YEgO7g8WC63BX9u591vcUI/C/J4SIh9jc5j6lJuE3GUCD5U3T7lGuLfw1qA7bRKa/R1PZlWHahsDSNtU54SRKK43rs6ld8z+gPIGzR2gupKcsQytLrUqMrKCtcDnjT7WEWE0cbEiIwtUHJ9WauII1IE1fFEQMe/buZ2ck+k5e0/PHhbAWb8jwEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqdNv4xduBCzwabNZTwSsZsQNC6fZXLLBnCrxvKFGwQ=;
 b=oeS2yyVf8DB+qmLPd/WZ4HjW/eF9Xjo0yJWhmKPHSZWv67gaUVDsxO3xMmaTdw67aeckotdy0JDprprOBuuII/Qdkc3S1HSMlC3nKhD63duEsSmBYKITFlwyHeOJ3wnm9Qh2k94nQoQ5B9AFffp457mfS1okCl5uB2UKk09uA9BOjcutl9iIVh0CWbTnJvaCUoJvTyAL2PToKfHNeySOYOgJQnVt36eKY1efK8RskuV7nR6WIoN8zSdTwD5gYelTtoMYebKyWgf0400S6wwf5ZGGr/7AQu+gV2rmaJY8ft3zyDQvpbBjTFKe1Y3L2KGUyd2/L4uUZHn2qCCw6S5U8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqdNv4xduBCzwabNZTwSsZsQNC6fZXLLBnCrxvKFGwQ=;
 b=pJK9uc/QZJs2fZJPTbC6jk4fCZMDKR0hyT0PVSC3oO8skjVErihKaVUvPUa6eE+rTgrMsFRRe6pKrqus8FS9GcMUJOP8NnpmWrge8DALx4OIN6/NyKvQPImeZ0MpL9uiu4yEyrGMzeQxKtEWoRdASv1VdFRs02EuQA+kf7AqgaZB74msTUYmJQJ8slZc8n12aF1os88xihNG2HEtyzdxJuDDQ1R6YGWr5NGvcUXccXMbIXn0BpQD2PcVbdNn3msMkg3Td7kVSZREhYXPGdWFlmG4+M2sZUMckwansaXpz1YdNvJ9gymGgGUXzR+DKmPDs8CQi1RwvD0XeK7jK4mUNQ==
Received: from BN9PR03CA0774.namprd03.prod.outlook.com (2603:10b6:408:13a::29)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:25:01 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::40) by BN9PR03CA0774.outlook.office365.com
 (2603:10b6:408:13a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 06:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:25:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/10] net/mlx5: Add NOT_READY command return status
Date: Thu, 15 Aug 2024 08:46:54 +0300
Message-ID: <20240815054656.2210494-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: c345f131-d35d-46ca-5fc6-08dcbcf2fdf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JHMAg9jrtjmHIyLwF2xtj2JbVMv6b0kHVaA6xlt/5jIff9yYlmsY67E9k/7?=
 =?us-ascii?Q?bNSHGVhF2s5OIxiXvz31FMGVea8kU0vwtda9XSbHyD79NjV+Yg9AIvB881QT?=
 =?us-ascii?Q?AjDji/ks2jGZmUveWqTEij5rcsHSJn6rLsaR9cXGkMy5BgNVHg4J+3ZbdMUM?=
 =?us-ascii?Q?+leHTi5cIGJQGtgD5uhWUhKGNo+DS3mcWI2OKbzZPSxYufVI/6d75mlybbQO?=
 =?us-ascii?Q?64nVrp5+x1XPLQC9SLgshwnX6/YN6o+ZlegJsTicpI4cp+RQ+h0jNYbP4Z8p?=
 =?us-ascii?Q?+cOoqZsUPB0POep1cClPGxK/WA+D43qyZiHSLmYIvJmTy0jDfdd4vBzRbabH?=
 =?us-ascii?Q?5fdKY9RlRlsnceP1MmADdGyPjOYhKkg/onmnxoWZSLHTEMacVtMsXGg7XX35?=
 =?us-ascii?Q?xx+KrQNYoV63RNmlTUVmB6IdLIQlP4Qn6LhZeBtSoNA/f/TGYRowNFJZY7i1?=
 =?us-ascii?Q?sUHQvOmwEdsJJ8c1On+vJXsZ8o7wwZRsOc7skdCAsyvf5AeWFloRuS6s+7c9?=
 =?us-ascii?Q?mmSueifdE72fsu0AnxAc43KgQxdD+MEPvT3ZFVoAqHBPpXFRBoanPFKG+ul+?=
 =?us-ascii?Q?76vnEi3YUuxszRxbkGeMdEfUoxaKKx64jDI1St6Lh09XgX2OBiUnqQDH6Swy?=
 =?us-ascii?Q?TOphysuSqc7FvfuLMcs5t4TaHsfGwXhblelM+tKgfMd1enZqBFGnHu+XMPpt?=
 =?us-ascii?Q?XuuD4p1pvOJvQPlbLJIRBfdqCederco0bK7IrAuvvigIhT5MLTqAYaFhu5Cb?=
 =?us-ascii?Q?4snZ3mh9ja1DWKomSxmBjKi1feGcCmEnlkir898bJmQy0FzlQnjo4l0IBFk8?=
 =?us-ascii?Q?xAi0YmgUrso1bHzJ8/LtJKO4FWW8GEMo1aEwS2ZBRx2Gv8nCfuB+aJ2UoaOa?=
 =?us-ascii?Q?vvb/u0td44QXff/QAOTJrlHqmpjbq3obqBFCLSiskZ8YN6tIUu9ehbCboatX?=
 =?us-ascii?Q?BqJxoocSfaXomzhvWT6Vt9eMjTHuHlypW8Asm3w2gf0TvlBOxTfqJwQFQviz?=
 =?us-ascii?Q?xkJHBt1/3WKz9gcsJF6oqE67krJ47ZM1UkCLfeH9dWea0xAB3YBXoj/ema1W?=
 =?us-ascii?Q?ARoS0nkRRMhsk35oxzoCq+2lrZ2kfyY0m9jEHBXQ0wkJGXe/ZT04D+JIoHPr?=
 =?us-ascii?Q?YJ7Fhpn7FLrBVKcf4X3DwM8TNCdCJldc2WuEGU24ZGN7FuD0B+okCmWDkdsL?=
 =?us-ascii?Q?cgolbWjbYxd0sajcadHxXNshJ1UzJSVVnGxoCC97dxRjT12FxP+eGJf3izGC?=
 =?us-ascii?Q?42Gb6xuCbZKuswnZ8mtnFxMKo3wTdDdOTlDwXfmhPqGVhp6vqcMZYjLEMea2?=
 =?us-ascii?Q?11P8hRR092iGBzNG/HYvrK1Hpnb4GO1GoCWpJBS5l3UJheXzcQdGKvC394if?=
 =?us-ascii?Q?RkOeHgCMvYlRQxgFrH1XntC9449mBVJ3pHNJGjKr5UBopft5sfgYiCewnj2f?=
 =?us-ascii?Q?1FbBscw/PFbRGWWCmMFFe7vL+PoD9Dwz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:25:00.6444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c345f131-d35d-46ca-5fc6-08dcbcf2fdf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281

From: Shay Drory <shayd@nvidia.com>

Add a new command status MLX5_CMD_STAT_NOT_READY to handle cases
where the firmware is not ready.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 ++++++-
 include/linux/mlx5/device.h                   | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 20768ef2e9d2..9af8ddb4a78f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -754,6 +754,8 @@ static const char *cmd_status_str(u8 status)
 		return "bad resource";
 	case MLX5_CMD_STAT_RES_BUSY:
 		return "resource busy";
+	case MLX5_CMD_STAT_NOT_READY:
+		return "FW not ready";
 	case MLX5_CMD_STAT_LIM_ERR:
 		return "limits exceeded";
 	case MLX5_CMD_STAT_BAD_RES_STATE_ERR:
@@ -787,6 +789,7 @@ static int cmd_status_to_err(u8 status)
 	case MLX5_CMD_STAT_BAD_SYS_STATE_ERR:		return -EIO;
 	case MLX5_CMD_STAT_BAD_RES_ERR:			return -EINVAL;
 	case MLX5_CMD_STAT_RES_BUSY:			return -EBUSY;
+	case MLX5_CMD_STAT_NOT_READY:			return -EAGAIN;
 	case MLX5_CMD_STAT_LIM_ERR:			return -ENOMEM;
 	case MLX5_CMD_STAT_BAD_RES_STATE_ERR:		return -EINVAL;
 	case MLX5_CMD_STAT_IX_ERR:			return -EINVAL;
@@ -815,14 +818,16 @@ EXPORT_SYMBOL(mlx5_cmd_out_err);
 static void cmd_status_print(struct mlx5_core_dev *dev, void *in, void *out)
 {
 	u16 opcode, op_mod;
+	u8 status;
 	u16 uid;
 
 	opcode = in_to_opcode(in);
 	op_mod = MLX5_GET(mbox_in, in, op_mod);
 	uid    = MLX5_GET(mbox_in, in, uid);
+	status = MLX5_GET(mbox_out, out, status);
 
 	if (!uid && opcode != MLX5_CMD_OP_DESTROY_MKEY &&
-	    opcode != MLX5_CMD_OP_CREATE_UCTX)
+	    opcode != MLX5_CMD_OP_CREATE_UCTX && status != MLX5_CMD_STAT_NOT_READY)
 		mlx5_cmd_out_err(dev, opcode, op_mod, out);
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index a94bc9e3af96..d0f7d1f36c5e 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1449,6 +1449,7 @@ enum {
 	MLX5_CMD_STAT_BAD_SYS_STATE_ERR		= 0x4,
 	MLX5_CMD_STAT_BAD_RES_ERR		= 0x5,
 	MLX5_CMD_STAT_RES_BUSY			= 0x6,
+	MLX5_CMD_STAT_NOT_READY			= 0x7,
 	MLX5_CMD_STAT_LIM_ERR			= 0x8,
 	MLX5_CMD_STAT_BAD_RES_STATE_ERR		= 0x9,
 	MLX5_CMD_STAT_IX_ERR			= 0xa,
-- 
2.44.0


