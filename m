Return-Path: <netdev+bounces-116707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D1394B671
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2C281CC3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725111862B8;
	Thu,  8 Aug 2024 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVG7uQMM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5A18629C
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096898; cv=fail; b=gdGlyT7HEns7cqc15fQV6O0Sw37cYjiTN/rI4S+TLtyGw8njVI2Do+mqww6dxRP8R7k3Gkvc+VxfXBrbOYsGZO+/RfQi1/WOQ3afSgKCuTjyRi3UWHBtVF+4PcY+WwWUi85a6wiG8HAkdLuxM4kuDeoQgMBv14K69cQXPm9e2QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096898; c=relaxed/simple;
	bh=iPWqiGATDiJrnc5jka4NQyTmbRxkEhEVJn6wj733bbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twvehAfU3EH0TQQD3Fya2/kQE1j53Vewq32OOkVK53SpIQV8Co6Y3qkHlMyIPo53J/nrr+mf/SPNhg8VX+e7y6lq3n0EjWkqCEgYfzpqAKpcJah8NHegxCj92USkC7CaADdtc58Lz621UNUQJQ6HNpppw/aH+4N5wLcXMb/Pic8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVG7uQMM; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAETnwfztpxo4p7r58IZvXU49KzhTCcekWEuF8oc+3A54h0Z1x3XEGjhKiH5K/idJiMi6p+wbLho2VmlBMD/9nN6FIjat27+6R99xF+/BcXulfvbzfY6ESDk/gO7AN56uN9sQqvSvhJtXdgmV0fJbDBO5+GpaSnXEv6OZmLF1/1JDb7c6wG+sVCDcITRf9aD3UfgVLugFFwALSh5QbHbMQdVKTF1Ap3DpfgTtU3AH/pofY8YDt4kpxzzOPoHSKzIex/glnB2fojwmQnLkY/9PpbhxRTcyqoPuigXsVSHWEle2sj/U3cfOS7ore3MZj3WYrYh+INqjbVuXmqa//wDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrB9R4qAMr79k1w7qBpIVigR5lEYuJU82VeMTLLKn58=;
 b=M5K3BTcW6n6uzmhqc4Nw2yu5msHltrWMRcxkm6sQvFyUmuCWx9HRxN6Trao3osl4qWkbHHHRlUCPo9npOA731yekLpyoPmznvCjZkkkM5ri4wmDvXP0Krm9xFP78vGqv4Nb6sAM5U3f5aXEWZpP6gAc82HKdImneW3xaQBeFW886FKAAv9O3Zvz5fJ9BSFiqp9C33ula5Y9INTcU1SMFI7dv6lN+SFgUpbZdjN4MMhatYfwT97N7IRQRysyqujt5dTM9IajErIQbE7yqxMlPSv2g+cLYycm9U3tEgvJrUqvg+efaf1AcBxksI3TebLzrFB5Ivk4VXHqxQQAa6oaRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrB9R4qAMr79k1w7qBpIVigR5lEYuJU82VeMTLLKn58=;
 b=hVG7uQMM5LeptT8BCAxtr+cjHPA9X3qnjtfKD2RsQ1OXppkM8wXUK63CHC0WNsWZAgnOwns/TUVbjTSCltMuMYUvV3uJTrEhaqZSNQha2v2e83vyhtihFkngxRlSnn2QprtrIKlzsWSJrzYxyhYxOR554lzIg0TcUEuP6VPXKeiiM+EMB//2Ec5jq+CGPivTJP6Yk67Sti+STIGDHzZRW/EDFcYN2oTvy+xD17vS7o9YUHul02WGpIhFPFky4v0OQGnTJTpCI6aDbBB9pZpAtk0hWe/hWlc7JFCHBJYkM7lSarC0L/C1pDB1VQjQ9orEAtDB8fjcxzFYzddc6P2dMg==
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 06:01:33 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::6a) by BYAPR03CA0010.outlook.office365.com
 (2603:10b6:a02:a8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 05/11] net/mlx5e: Be consistent with bitmap handling of link modes
Date: Thu, 8 Aug 2024 08:59:21 +0300
Message-ID: <20240808055927.2059700-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c333ba3-065c-48fc-41a6-08dcb76f8e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YJs0f/jgvwlJNSEjFTQwnI79iyZMgqK4fzb9ji/HM2tYr4s7J8WsCal5G/2?=
 =?us-ascii?Q?OwVa+DCn6G8OxOzF2KW8QwgyHoncJwG3URJylO7oq7i/R2g69g+Ufjba6ZQO?=
 =?us-ascii?Q?b82ZcIuGRxsMULo4SaU7Ffj7qyzkIBU3hvoyQNUDRLge82jUrC7u+i8rjUns?=
 =?us-ascii?Q?qTaztLJo5vj+SOWWnSRh6Brg4T8YPG5ZKgQNrA1TObq+2fPp8MyKTn0+nygw?=
 =?us-ascii?Q?NWqb5nnIHfi13p0Z891LOxm6ip8soIGddiE3mmRQGqhqEHrdfj2qRo9tcZtE?=
 =?us-ascii?Q?+q+5hnXI7Pd00tubX6I7UT4n9xEwyco+0jLmmpv7N15FUaJhGbzECdqPH+jm?=
 =?us-ascii?Q?b9SHk4nStAwkA7DwNXdJQGUVvb/n9ALxztRnGqnmA7zYxAhjjejJcD/DSP1c?=
 =?us-ascii?Q?ZMMD0wutXn+rL+zTVnCBjgHEQwbyhxcwxTLSjC4KwubIrIwOwf1YqiPx1SXr?=
 =?us-ascii?Q?t+RF0YDWO7qdM994AxGr5+b7PDNRqoAnVl1juNv5NPagK15ZLsyAZQclnbS2?=
 =?us-ascii?Q?XTl2aWf6L36u0YVJSmIno9nPkxoof+2kg5y5j8J/Kk3w3PenC0pPC0ZHUqax?=
 =?us-ascii?Q?o5hsOpued59Q/PtdJgy+u7rmU4bG9uuyBmrCEAhZ8aFxvvUadZXUeUGBqTZZ?=
 =?us-ascii?Q?wyRrzwhgnF0J2B7fvWL98/qf/4yKgSxeDoPmUzlwMsn1b40jyJG18kZJGfQX?=
 =?us-ascii?Q?AoYyl0nUExA3ewjEMpUHOD+tZJu5RUjDRB9p+ipJ7odP8qDXS0nARilu6VdE?=
 =?us-ascii?Q?58HkhhUls80T2hW/wXqVE3KfTA66KCBotWiDbWANREz5YCmk/hHAgHK47kou?=
 =?us-ascii?Q?pmpoP5Kv8e/WdId6Nz7sDD61atgYYZgXSzCsvtVNWgvWACycUA+2oJmKiuEU?=
 =?us-ascii?Q?2Zq6KRjU49cMipP6FBb+X3LS9WQYwz9mU8uJSLtRGPmWuKhJ0fZXzs2nlIaY?=
 =?us-ascii?Q?XnZPOx+cbJFpr2bj1Trp3exiWqp4EbrvWJEmEiHGX9s+gjy9+iJj3ljGWQ0R?=
 =?us-ascii?Q?fe+7Ay19VM/1mIwzoptAYNC6jJ6XszlQQuFa6ZukvK+TTcEifDjwQOdSCH2V?=
 =?us-ascii?Q?ta0rWjjaQvTzqKSIpttfXkxdKdkP3JdIi50aD75F5QNkAi8aRVMuPp8D2XoU?=
 =?us-ascii?Q?CtAfoa2xl2pdqygm/68DYe+CPZGb8FNYO4DDO9th+SB+XC1RbQLhw0mIMRa0?=
 =?us-ascii?Q?6nfzXIYmXMpHBfPytrDxoeA4+yFGQqv8jCFePyhBv6Wuqd5O+fPI/AjT4bvo?=
 =?us-ascii?Q?fhpPPaZWZOAkG52xkbBfJwSEAtm77s7K1O+jTF99et7PmfR/zuMET3GwX2XB?=
 =?us-ascii?Q?hpaKqMO6i7lvdm1dbifbpaCuTGw9RPSptX2bPOezWLX+Zh1/X7F9Yv3nfGRf?=
 =?us-ascii?Q?E0nL6BGt6BniqdnW0A7fpTtJ7fNKN1e2iJXqHLOgyn/LsPUDo/6g7BRDPmRp?=
 =?us-ascii?Q?R1+NM9zT/2S2ieDq/xwKg6lbgKXo968y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:33.0752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c333ba3-065c-48fc-41a6-08dcb76f8e02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803

From: Gal Pressman <gal@nvidia.com>

Use the bitmap operations when accessing the advertised/supported link
modes and remove places that access them as arrays of unsigned longs
(underlying implementation of the bitmap), this makes the code much more
readable and clear.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 36845872ae94..5fd81253d6b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -83,17 +83,15 @@ struct ptys2ethtool_config ptys2ext_ethtool_table[MLX5E_EXT_LINK_MODES_NUMBER];
 	({                                                              \
 		struct ptys2ethtool_config *cfg;                        \
 		const unsigned int modes[] = { __VA_ARGS__ };           \
-		unsigned int i, bit, idx;                               \
+		unsigned int i;                                         \
 		cfg = &ptys2##table##_ethtool_table[reg_];		\
 		bitmap_zero(cfg->supported,                             \
 			    __ETHTOOL_LINK_MODE_MASK_NBITS);            \
 		bitmap_zero(cfg->advertised,                            \
 			    __ETHTOOL_LINK_MODE_MASK_NBITS);            \
 		for (i = 0 ; i < ARRAY_SIZE(modes) ; ++i) {             \
-			bit = modes[i] % 64;                            \
-			idx = modes[i] / 64;                            \
-			__set_bit(bit, &cfg->supported[idx]);           \
-			__set_bit(bit, &cfg->advertised[idx]);          \
+			bitmap_set(cfg->supported, modes[i], 1);        \
+			bitmap_set(cfg->advertised, modes[i], 1);       \
 		}                                                       \
 	})
 
@@ -1299,7 +1297,8 @@ static u32 mlx5e_ethtool2ptys_adver_link(const unsigned long *link_modes)
 	u32 i, ptys_modes = 0;
 
 	for (i = 0; i < MLX5E_LINK_MODES_NUMBER; ++i) {
-		if (*ptys2legacy_ethtool_table[i].advertised == 0)
+		if (bitmap_empty(ptys2legacy_ethtool_table[i].advertised,
+				 __ETHTOOL_LINK_MODE_MASK_NBITS))
 			continue;
 		if (bitmap_intersects(ptys2legacy_ethtool_table[i].advertised,
 				      link_modes,
@@ -1313,18 +1312,18 @@ static u32 mlx5e_ethtool2ptys_adver_link(const unsigned long *link_modes)
 static u32 mlx5e_ethtool2ptys_ext_adver_link(const unsigned long *link_modes)
 {
 	u32 i, ptys_modes = 0;
-	unsigned long modes[2];
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes);
 
 	for (i = 0; i < MLX5E_EXT_LINK_MODES_NUMBER; ++i) {
-		if (ptys2ext_ethtool_table[i].advertised[0] == 0 &&
-		    ptys2ext_ethtool_table[i].advertised[1] == 0)
+		if (bitmap_empty(ptys2ext_ethtool_table[i].advertised,
+				 __ETHTOOL_LINK_MODE_MASK_NBITS))
 			continue;
-		memset(modes, 0, sizeof(modes));
+		bitmap_zero(modes, __ETHTOOL_LINK_MODE_MASK_NBITS);
 		bitmap_and(modes, ptys2ext_ethtool_table[i].advertised,
 			   link_modes, __ETHTOOL_LINK_MODE_MASK_NBITS);
 
-		if (modes[0] == ptys2ext_ethtool_table[i].advertised[0] &&
-		    modes[1] == ptys2ext_ethtool_table[i].advertised[1])
+		if (bitmap_equal(modes, ptys2ext_ethtool_table[i].advertised,
+				 __ETHTOOL_LINK_MODE_MASK_NBITS))
 			ptys_modes |= MLX5E_PROT_MASK(i);
 	}
 	return ptys_modes;
-- 
2.44.0


