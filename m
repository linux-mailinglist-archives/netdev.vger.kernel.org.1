Return-Path: <netdev+bounces-216283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F93B32E44
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203C9440416
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61E26B955;
	Sun, 24 Aug 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KboCr+LY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D726A0B3;
	Sun, 24 Aug 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024848; cv=fail; b=HpC8CNqFKnRHfdLO/BAN/dT1MKrRJ3miVY3F8Nw3vKmH11SuNBsyo9ngYxOIzHVrNkDNyBT9g1KXDeq9p91M2D1ASp1PSKNmfApY2IXRj1FgjhHCSpL9cMEYhnBmYrKliBkIYb2U2c/ZCBvI5uGEcN8SkAPotSF3Dbnqf1wbrmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024848; c=relaxed/simple;
	bh=wG3F75iWSSdU6h8xSzGqEc0JVUoC45WBRCIwSqVa714=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRBYADtncHTw5piSumcTZOeFFBgtAhNQ1/WmCLXQsLT9WHXP9krd3gZgNPKOXBQXicPvZwwh2K0nymOlSyOJGVuiMYAbKdJlxPEZf9a7OhWvql3qxgPNNh3m6WHKrA8VYIyeX+Gdfm4gvcBtUOD/V0azP6JcGY9r0cNCcmIOQtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KboCr+LY; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJNFG95jky30nShFqZ7NgtM+F8ti9qxmLK43przahj5V9TrfvM6KIvVkIxQ7lFtsXkqfC2orwyd1AvIES5vSgGOSiKygljnZX7yfROXKfiQNZrWBP+MpYZPUYeA27cjKjemYyAGEzCRjiIIEkyVGOS3kaNHjq5qp9rruG6Gs/DIyT5CraqrCHK+XIja3b0yiCCdoK1Vz4eEqgLz1AGtVxTgA18+cHRY29Fdy0ktwP6csL1ChhF3+sn5wcLNQocG+vqhltWPItAmi9ME4wMI1IINU2Gmgq0OY+BHDk7PW/YQNZ6D8xJfPyOiIFIdPpHVeJf3bl93EAWj2FP+L/L/P8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoaeTIlm5Hd4gDlAKTRUQB3kvcECjTJ7y8aAuzPSRRY=;
 b=TmXZPnymHuVZ4CnRxDX2UnRNXK3E1/cm6yQuZ4m1Y7cclJQy8YbR4LeC55r/DPh1nn+cG8Jk/E8MI6X4EH3/yZrfp/Z0xXo9frKH1EKPpjXsNaG/k7o0kBKOGcy5R7kj9kaKGODoP+5a7XoRtIXPKiU0NawVefGVgn9pdmqZanxJuBpVDTzWXyhVGhZk8bij9Cq2EWSHdevYoToAdNY5mvROPjYsh8of9JpDb5jGqV7e8+0jZesR2mRyaqdtw1UCoLKreOMwp2owYLjgcz/PWu+Wzi5PDZDtYAHiF8t1Xh7aaalcQfrp5sNBNYxo2Ds2lKXuVfnDpUon4sg+Ke4lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoaeTIlm5Hd4gDlAKTRUQB3kvcECjTJ7y8aAuzPSRRY=;
 b=KboCr+LYKkSKQpLK9crGOwofJIlmJVGIi2wpSjvvlXILkuaAeu04N9chb+rK7pQaKUDMkoID+cCD241p4ZTU8eq3XowrxRDEuBLig8rhDuT3I96MFsBDXTD1SsLQtyp8MBUGcQgNhrKdlXOCSjS6QLeI6UZ/tDZ/tdujgx76SVE0P6c0wYTjtOKJu/e/kWgk238KiM9ixkyPESx9SWXkYQGuyg8C/lgW6ohtELsn5M2OrYb1lyaSFccpOwoFqno8RWjR7BjJPPT9voaFC3ueZlhDwpxHnK3eFVJiVSQ22V2hQwPrR6i6AvpDN+RxXOz1Mhidff3hlcRjRnvZqqulgA==
Received: from CH0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:610:e7::6)
 by SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Sun, 24 Aug
 2025 08:40:43 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::c2) by CH0PR03CA0211.outlook.office365.com
 (2603:10b6:610:e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:25 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 08/11] net/mlx5: Prevent flow steering mode changes in switchdev mode
Date: Sun, 24 Aug 2025 11:39:41 +0300
Message-ID: <20250824083944.523858-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: c08a82fd-b8f2-4d3a-281b-08dde2e9e9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V4AWfvfevwFs9ASS27a/nUxqKq5PZV23v5FI1JlUlXhodt6PvwIECXa6v6XE?=
 =?us-ascii?Q?AUc+0d6eg4pgtoEuWmxHokvA5LDiSAFuLW4BjYSvEd1aw4/+A/p5GyW4SRdH?=
 =?us-ascii?Q?w05MmKF0C70iysVL3arA3EQuZlTzpKUZ95/5Xe2pRmMQDDrc7evlUfG7Df9E?=
 =?us-ascii?Q?pEXJGN47qKQzanhW7rwVJaklE6qk06nNcwn50m6SFv7EmHKU2yclb5Ns8Yff?=
 =?us-ascii?Q?YsLrkueHKk4S/ZJRIrv8y2a29n3j69J6ko1Tc4FHDhEWGfzszQboDORS4Ck2?=
 =?us-ascii?Q?TzdXDE5O780OUvKfsudjCUKYJLzE1xxhZyIEJsGT2eFci3fIpp120i6jzVZl?=
 =?us-ascii?Q?nbK0Q9rTiKhxRnWv0jQuJOzcUY++SPmMtCMFuheVItzZ8EvewnMSt36JiYRB?=
 =?us-ascii?Q?nrYElvOvhNjw53qVjarjKp4GGvPJW+IfaLI8kK98Eqtp4SnqDjyk/YkWRDBs?=
 =?us-ascii?Q?rPhEuhk2TYItQPnCv+GEbVBPcwyZkUgMcLKyOpoS0qbCRDAeKI+ropR+RaG0?=
 =?us-ascii?Q?dFrz4wFi88FfmDDG/grRcYQ/RhTv7KMqPZYAiMsls65xmEzmmjkIrIE7w3Zk?=
 =?us-ascii?Q?g/aSam3bjT07frTHXHHSi7kQd2LjTLzAygyKm+uIc0rWhw88bxaiY0kW0L/O?=
 =?us-ascii?Q?z63pkkAIfAr3xjJWPI+P1r+fNbIIWkeCRTWnaLAoOmzDSYS5BJMMp77IT8i5?=
 =?us-ascii?Q?DMyYf9Pk4FESepSgHHHGSQNgyr6DzZbAld8qb4eX0kwBnPQ/sJsEDkaB+Wnv?=
 =?us-ascii?Q?kq/0bFRadShhCYS5TtiaFvV2A7wuH16eTcdswupYx1lLdA5xqTw2ftdy5guK?=
 =?us-ascii?Q?n9roiAtUAxVzo9fmwiu3UCGItoTJVi2ZQFZCed8xka1oPJkXRIzMXPZCqJHa?=
 =?us-ascii?Q?sQdBr8YRsrGG00ABO6aXcQMRNVuIOaIuOYquJenMC7YtUsytj/FoM0HCZUrz?=
 =?us-ascii?Q?PgB2SD5twbnWzlSZVS5mj/4E5j9zyedogMpITr2G56O+O/45KeEpVtNI1VFY?=
 =?us-ascii?Q?1PTxNmQ7OWQ02lzH2ruiHLkGL0maQpEV4zadsttd/PE9Zg8xQ+3yQ7yLiYTP?=
 =?us-ascii?Q?iwFSjqIsVo3H4FCJ+0IhcfMj3MK/OngVIWxinvjsV0sma9jnz7C8Ufo/8EFC?=
 =?us-ascii?Q?ud50XDa7oBf8gJuFeXId74yxzDi7+75WbtiTD/SQwKIJx9SA06m08wR6bmUr?=
 =?us-ascii?Q?6ihxzYzsbsf8fx5xmtsmwbv1k4agq5ZoOBuvMBNIaSZbdb9oUGC5FuLtEimg?=
 =?us-ascii?Q?FXhOEX+e2/SyDLau3/7OnZ/Ujx4/OJzl9hN7UNpNJki1KbsfeMs3hX7LCIdQ?=
 =?us-ascii?Q?pxAAJ/RMt+FUsnQ+Pk9PCmQntZsY8jrCGYDixm9Ja7xCgvMzEKhHrI5laNrT?=
 =?us-ascii?Q?+mMDExYTmEqHhH3U4cU3sICx+vBGVYGscrS0Hks4mwRLoE9fC0V5JpxKqWt3?=
 =?us-ascii?Q?ks0RQEP82k2q0Tq/xEVn6Zxh0uMV3nXaOrMPXy4Prvn+zsf0xqWB2h4MHnhS?=
 =?us-ascii?Q?fK1bUFpGh2UP+IIG1i2oDfj8fA2/nHYSBc0S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:43.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08a82fd-b8f2-4d3a-281b-08dde2e9e9d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448

From: Moshe Shemesh <moshe@nvidia.com>

Changing flow steering modes is not allowed when eswitch is in switchdev
mode. This fix ensures that any steering mode change, including to
firmware steering, is correctly blocked while eswitch mode is switchdev.

Fixes: e890acd5ff18 ("net/mlx5: Add devlink flow_steering_mode parameter")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index d87392360dbd..cb165085a4c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3734,6 +3734,13 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 	char *value = val.vstr;
 	u8 eswitch_mode;
 
+	eswitch_mode = mlx5_eswitch_mode(dev);
+	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Changing fs mode is not supported when eswitch offloads enabled.");
+		return -EOPNOTSUPP;
+	}
+
 	if (!strcmp(value, "dmfs"))
 		return 0;
 
@@ -3759,14 +3766,6 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 		return -EINVAL;
 	}
 
-	eswitch_mode = mlx5_eswitch_mode(dev);
-	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
-		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Moving to %s is not supported when eswitch offloads enabled.",
-				       value);
-		return -EOPNOTSUPP;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


