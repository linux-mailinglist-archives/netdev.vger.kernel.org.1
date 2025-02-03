Return-Path: <netdev+bounces-162275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCEA265C8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E263A5F12
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7608920FA9A;
	Mon,  3 Feb 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lTG3FR03"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27D1E0B9C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618633; cv=fail; b=YAAt7tZ4xB4Wy1xCxNDl3wGiwEEHPMcXMRhwBDp+gSgJXsK2NE8bhN+IfrQC71I+qa4d3jQuG0zPjTHKL7Dz4CR008pB2CkB8Lp1DHMpGxeYkz/4tC8wzZ/oA6puZzzVeSS52Ag756yAu+Ri6tT6YKnibjx4jb3h3cbVIfi2R8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618633; c=relaxed/simple;
	bh=W+faaMVrBNxgSk7OqIfGIwFfBAHxY0/2C4Fh6WdFgE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeJyfNpe1bev6QPAJDYCP1CC0Ed6A3mI/911tC2bE0c7cltmH3MujlfnEO7O8Rx8MNSXDLV4V5VfFyCLrlu+bSZtzVfxJ4kZLNvCnSxMeDxrRopp10f+FiVuzbzPcU0sEhHZRNjT3KObviKssk9y/heOeAjFH5TGZmXTD14qKPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lTG3FR03; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgBK58UNd5e7My0DTDZEwNSrlq6B4WanG7mPE0r3SUbSyKN7MJlY+9DBLH7FBTt927F2NQMidahSMl66Vk2jrzBPk6Qkb0KWvkjSmt9dEsn1iagMjDzIC3tQ8R50uIts37eKSVCTUJuqYlK5FNrBJBdRXtREPrjrX6XrKUPV16K1G9nmeVA94J9B3WmV2o4TToMP6m7T1fivuU5ko/X+dOBDksbbpe45+m27+X54POzgUR0wMAW5/wsNtwM2zb0MyMDxQfylXDiKhliU9BCK9lurS/Kswp/5iMdCicAKzEKsdOWpzB3x1kNWTXVwaqwT1eSc6UjhHvOHpfKF46QpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhrZH4P7BpEE8WhEHN5yilkOujXpX3h5KalxDOO6+Lw=;
 b=gDBTtbElkeeGPmDPheTtcHpAYij7KmRUp9gVIzJ55Ppvd9LK7itSjm5qhlGJcuMHDm3+kKijD+Ni6HoYXOYvEf+0PHZ0XP6TA7661PeerUqwZYo1h+2XdHAxUXNa/hvavlG7adpUVRdVWpAa5ua6XQwM6RXX1Kkv2ah4TSCBUXRUpUz1vv7SaVbtaAIFxmcc6figS6V1aV1jXbVUv9/tuZcVpe4U4oT6ziANvvS0VFw6+vIeIeG1XQZooSHhCkH9gmcrhX0IKLupuRqzC1PmY/xmBGe4Cz3VNwSh2KUZo2Nii24DbExLWQ5JdhLPqxflK/EOGlYHLjd55k1/e9EYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhrZH4P7BpEE8WhEHN5yilkOujXpX3h5KalxDOO6+Lw=;
 b=lTG3FR03r3z/7FZVJ9pcy9cn8XUp93kFzVlu1fxZoLol2GHvh01Q9Pt047Zi0/EGW218R1dQ1axbESyYO5J6PDMVWyKVNT0jlN1g9cFTiJEWtPaa6OxrIdtVeDT13vb3u+7iDX/9lgCgwwKI4M5Lsi0c108TVVhdw5qGCA1HM155veHCBanHz1izWWeVhuy2JV4C5/Fn5wqlFShDZLfb74ofXgcbAxbEpr0BwDrBGcrwFgW5FGAep/29eJaKSjiEr1DIwZ0jNYyuV9XFygsLqQUQBqw0bPZcYSzWbIFGXK3MBcW5++92N9hIVJ6PB9R28cvbsjnq6S0NsTcjx95cuA==
Received: from SA0PR11CA0095.namprd11.prod.outlook.com (2603:10b6:806:d1::10)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 21:37:08 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::17) by SA0PR11CA0095.outlook.office365.com
 (2603:10b6:806:d1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Mon,
 3 Feb 2025 21:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:37:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:53 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 11/15] net/mlx5: Add support for 200Gbps per lane link modes
Date: Mon, 3 Feb 2025 23:35:12 +0200
Message-ID: <20250203213516.227902-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 16497318-e9d2-4e4a-2219-08dd449ae829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrTpa39heH1R5UnVJAoxZJl05eguN66MbNlZDoGpF3FLGfOka82+yXalSo1v?=
 =?us-ascii?Q?zJQLi8F8b/3jGKH/rL26caqu19OPriH94KsOryPy1eLq9f6YDZ3HR5X57ADQ?=
 =?us-ascii?Q?us4RfJEgnYlLpij6XdeHRw8wb1JAUPX624B18dT8KEMiYT709cYzcPv6+TIW?=
 =?us-ascii?Q?wNdYxe1/vZnVPgIvSsIZwZl3HZd2sPK3EOlgGHaLfKpHR8qEesTHbn/nWQGe?=
 =?us-ascii?Q?/q73NIFJYMlL5HxnkGEf59zvv3ADlYQyvpmQIMNibLOeVrK7CCidPlODCrGU?=
 =?us-ascii?Q?iH92qqJQcbGQAPmjFwJ6P9kCez4h+e3FRTW0g9dNMAunfyWKDyJ8Metfiha3?=
 =?us-ascii?Q?HWR/JVFEs2cZQkbcIEZuMYSOj0niLdt7cQyBJE+5l0WYpuOmjz3CEX/6+Lg5?=
 =?us-ascii?Q?fzANd6+h3GSSpCGwFeyYhVMu6J7YaRuMTwUMvFaKsALn21mLph0QEVblRuxm?=
 =?us-ascii?Q?zxDYPfStIlJsbq4b4JERf1ch1/Un//6lD3t4u8dEifqMEYLGo0zc+DLt8yWE?=
 =?us-ascii?Q?e70VfLWyue1jf8C+6sa4LtM75p4menJveF6nJd5D8dUpckwyOXXzJ3hr5RSV?=
 =?us-ascii?Q?aFUH36kHho2ygvD30GRwIzdX13aSOxsEcjxQz+xyCnvBJ9sQfzjRY8nCUyts?=
 =?us-ascii?Q?kKJFdc94sOs4HhMHtCzO4+7pIpdV7HNrEJgnI+6oiCNnn7vUe4GHfddcJPCg?=
 =?us-ascii?Q?qhKMlvB4MdYiNrPlzJ9UWoL7/toBfYQhiqFzFPgizGsxowWlRj5W2Kle+k5Z?=
 =?us-ascii?Q?emVOtKDkoA218Aa+KamOyCrwqnvylKNaV2FqdNfeL3L4fpCQEfnOhyWGBJz3?=
 =?us-ascii?Q?fpszr5/fpkTlJy1n2SfRtYzdMWZhr7lRH+yQ9x928yq8xDD/67RLS+FGKRnR?=
 =?us-ascii?Q?cExsAMCo9ueN/95PjZsJjI0tKiIh331PsLxW14xu9piP7/LzByjfpvR9aLB3?=
 =?us-ascii?Q?rhtcuEzmPBEI/lJz7AKXVgNwjf1ieL/CYNzNwCIUGgeFMq0EijpnLMrIPsJu?=
 =?us-ascii?Q?Pl/2LOjMr1XuCzrlmtzr9tTaRqWbakjP8HQ2q0QhTBLMRmpz3UVsli4kTR+x?=
 =?us-ascii?Q?OY/+7Dar+VHTrE0evMi9kIGwMmzkfNe628u8YGIhjrdb6ESTwpaUnTP80xtJ?=
 =?us-ascii?Q?j33Sx1NUWbvcD+/P0Jli/dUiWJLIeAjwqPez/xufJAVa8CiTCGjzwKui5abM?=
 =?us-ascii?Q?UaFIoGFuDHKrpVz3sWyzRf9TLt+X3vL08g83c2Z8nHiC0igJco0Lwi6L0dtJ?=
 =?us-ascii?Q?9p58s4bSsOkVtLXeXo8RGqATEC3zHoc0u5PI1gaQdApUVwmYor5Azgsjn8JK?=
 =?us-ascii?Q?qJ3g62CsH5N5XeEyeXhuXTn0OXVLwApEredoiQXNUxhKmpYWrSKaL5CJjU3h?=
 =?us-ascii?Q?CaJxIDgjhE7uDQAcW+6+drkhU12teNmrhjjL6iYvJQSWxvi4s5//AFtCLOGx?=
 =?us-ascii?Q?KBjHExHZom3yHmy7GbJfRPhSJ1KNswwYcxG0EoNhy7WAC+xofNMDA5AO09al?=
 =?us-ascii?Q?s1iAAkrA1SnQr+M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:37:06.5890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16497318-e9d2-4e4a-2219-08dd449ae829
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121

From: Jianbo Liu <jianbol@nvidia.com>

This patch exposes new link modes using 200Gbps per lane, including
200G, 400G and 800G modes.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 21 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/port.c    |  3 +++
 include/linux/mlx5/port.h                     |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cae39198b4db..9c5fcc699515 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -237,6 +237,27 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_800000baseDR8_2_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseSR8_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseVR8_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_200GAUI_1_200GBASE_CR1_KR1, ext,
+				       ETHTOOL_LINK_MODE_200000baseCR_Full_BIT,
+				       ETHTOOL_LINK_MODE_200000baseKR_Full_BIT,
+				       ETHTOOL_LINK_MODE_200000baseDR_Full_BIT,
+				       ETHTOOL_LINK_MODE_200000baseDR_2_Full_BIT,
+				       ETHTOOL_LINK_MODE_200000baseSR_Full_BIT,
+				       ETHTOOL_LINK_MODE_200000baseVR_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_400GAUI_2_400GBASE_CR2_KR2, ext,
+				       ETHTOOL_LINK_MODE_400000baseCR2_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseKR2_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseDR2_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseDR2_2_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseSR2_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseVR2_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_800GAUI_4_800GBASE_CR4_KR4, ext,
+				       ETHTOOL_LINK_MODE_800000baseCR4_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseKR4_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseDR4_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT);
 }
 
 static void mlx5e_ethtool_get_speed_arr(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 50931584132b..3995df064101 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1105,6 +1105,9 @@ static const u32 mlx5e_ext_link_speed[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_200GAUI_2_200GBASE_CR2_KR2] = 200000,
 	[MLX5E_400GAUI_4_400GBASE_CR4_KR4] = 400000,
 	[MLX5E_800GAUI_8_800GBASE_CR8_KR8] = 800000,
+	[MLX5E_200GAUI_1_200GBASE_CR1_KR1] = 200000,
+	[MLX5E_400GAUI_2_400GBASE_CR2_KR2] = 400000,
+	[MLX5E_800GAUI_4_800GBASE_CR4_KR4] = 800000,
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index e68d42b8ce65..fd625e0dd869 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -115,9 +115,12 @@ enum mlx5e_ext_link_mode {
 	MLX5E_100GAUI_1_100GBASE_CR_KR		= 11,
 	MLX5E_200GAUI_4_200GBASE_CR4_KR4	= 12,
 	MLX5E_200GAUI_2_200GBASE_CR2_KR2	= 13,
+	MLX5E_200GAUI_1_200GBASE_CR1_KR1	= 14,
 	MLX5E_400GAUI_8_400GBASE_CR8		= 15,
 	MLX5E_400GAUI_4_400GBASE_CR4_KR4	= 16,
+	MLX5E_400GAUI_2_400GBASE_CR2_KR2	= 17,
 	MLX5E_800GAUI_8_800GBASE_CR8_KR8	= 19,
+	MLX5E_800GAUI_4_800GBASE_CR4_KR4	= 20,
 	MLX5E_EXT_LINK_MODES_NUMBER,
 };
 
-- 
2.45.0


