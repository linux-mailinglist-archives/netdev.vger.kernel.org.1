Return-Path: <netdev+bounces-116115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D41949219
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B082815B9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F91B200123;
	Tue,  6 Aug 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SuoI6EPr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B91E7A5F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952234; cv=fail; b=oRLwy9I6czKygCpsysb+vbS59/lKZ7faCreGUEdYh9BXZ+y5FxTGmcdcbi9o66h3B9tOUsIoh7i2x0suhbZ3Lu25zPJklA03b+DNgnrz3xRfOcPYFQ00HMGz4bz8Cdap+QqP5fMitqPxJZS/FWtUhYFPvk4bbzoQ/+eRc9AA1Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952234; c=relaxed/simple;
	bh=iPWqiGATDiJrnc5jka4NQyTmbRxkEhEVJn6wj733bbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlXSgk2jlNJSb8AVRz4Mxphc2DtT7OMTy18hy+o9SISxy6EITCs9fG9XfNU27COg/zf8D91z7yNMECNOQUQMzce9L+EWjzLYb6FMIE4UZlrsu21sPnGQlH9/UfBViXWuzQ1ryAmDPcl1ClVaer3jFD2rqpImuRkGzXTmyV8oje0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SuoI6EPr; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch3IcQCIHdyHqDNGqLNf48fnWvDTEbgkH2SKQRoX9gu15PqJTQ1qNlzHLbKf7XIr80GvJH2wPRqc0fua5t33GLQDcIPSjdJU92TBqQgXTtLwBDGZsilaZ2CLxDslJq/cWtWdSKO/5i3VIZjkpBq006AQPbZ6obLw/nm30Hn2DI5rfWvAag5Hr6iz1aIkS1SOuoo8Yjl6c4XRezLzK6FcRHphq3Jcxkn/NyXEuTSE9EVsk/09Alo6COvTjWZRyEZUsGvfX2M9yFd9OnMWF3PweUAACWVvdUCnsLXmIq4iuemx1LZOzS7ti0XG0omb2fUVbe2jwb50Mj0jzqdnxENKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrB9R4qAMr79k1w7qBpIVigR5lEYuJU82VeMTLLKn58=;
 b=JnWd1QMv2ZJ23YcK3m5Rf7vXFcVmClpzo1wel/zkq/ZfE0J74EUuRnRVqwGtyukl4DMiPEKhcpU9zkB/TNYOeiNBZSvuO6aBkq6NlmIQuDJu+G4wAKpCHiPMty0782KCzqGC1OmS2uo9FyTJYoHI3Dv6Brs25zBjaxnqX8/syzdhZlihgn/87g+mfPdF49TLHy0tuqgCMMZNq8xBR3bGeYAKTpMemOxVQz7Cfnnnq9z0nTahmCsSoc9tkKEvXa1zHuagxpATgg0RjmwrhLleC5Psfe9/3F/IeoElFf2BwcgxINDghMDEirBe+XmMDMjV1f0cFzgX8itjqb8ZlDn88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrB9R4qAMr79k1w7qBpIVigR5lEYuJU82VeMTLLKn58=;
 b=SuoI6EPrdJ+4eaBDNmR2OJvet+XaLG/IzCnkgX7HcIb/oZ+Qd1iN98YIygV5ZtVD2FwSLJgyIRm9DtO6YREyTL1pphOshKQzcjlIgxMwykT4CDfTBmK67frzxEj5PcPzOpHo8KIN0QLXNqiHTzMaB+jwzOd9eKk03THfV1lnSnWhMm5jZIKhgYJ0VbMcB/WAMVgQd3IA6Eyrmnii8p3gb4ARgxLLZgZOcIuNYeJZhZWC6LwoK6DXDShrRmN8I3fz1OOWK/U4unWBfzYgxZd0agdAc/pOQHSPB1HNHd/OnWgDjnq39gFIwyG2fVm+vj9sHfNGRy3onUCIY/mcPHopnA==
Received: from CH2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:20::41)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:50:29 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::e1) by CH2PR07CA0028.outlook.office365.com
 (2603:10b6:610:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/11] net/mlx5e: Be consistent with bitmap handling of link modes
Date: Tue, 6 Aug 2024 15:57:58 +0300
Message-ID: <20240806125804.2048753-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c120a9-24da-4441-b661-08dcb61ebb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMdNVcQWRrInZbrm5ia/DPzy8yEiRMmdF1BmDCwLMd0JgMwwmAwdhLUV/uCj?=
 =?us-ascii?Q?tFicQgilToQNzNIPnSIMTscRoDXqsE5l9a6favN/3l2Fsoh3nOIcjfARXuYi?=
 =?us-ascii?Q?1tCNSGRD/3Nhr5KKMiY3Z4aZ+70WQ2MLRplTF4umX9W+q9AOvCeCLuh/uv8g?=
 =?us-ascii?Q?f33gtl0nm4sBhd+5W6u18GfXy/0BgGA3DA4P3C2EV4RrSjMq9h8bIRa/Lsuh?=
 =?us-ascii?Q?otYrhYbaEKiVavJivGIAKP+4gCrB3N+yns+ReEJI1CrOAzrVuwhxDxE8iyDZ?=
 =?us-ascii?Q?CdLVdzQKoQYoJ1M7hoGJHbNkRWwwHaXopKHTXFyOZvpIFIpH2FQpcQRblYMW?=
 =?us-ascii?Q?be3wnhEqRTwafQPnu0HfOtFL7R7Yafgw4qRboGJvlMp3vsko03BYFB2gYYCy?=
 =?us-ascii?Q?N4fe6u7yIYveSBW/8g2r8I3bt9qhZdwPkKjT162QZkKcUltMmYJf8V37xvAu?=
 =?us-ascii?Q?BXFANK2lEXCXIXmcvx4UUz3xJmYS0Dz4RMe0tcWOAx63wIPV2kkJloyIROqV?=
 =?us-ascii?Q?jyQUuMvTEiYpKmr5B0yh2IO3U3++ZTUpKq8X0I8dBsfB1i/Is25BNxdtrxaV?=
 =?us-ascii?Q?KiQSSEFPLOkSrfxU9FkDEZglLZFynBKjb6b0lD5BRcp4rPeXXSSNq6ghwX+E?=
 =?us-ascii?Q?wo9CiWdtxzqKZCZp2/4U8Vcrak4TYGzxAJVXkvRBJFeqvMT7PQUCP+wS9yZi?=
 =?us-ascii?Q?eIdcFrqIBYslL99EtO8HnXBq+ST3ZyMfNrPJde2I3NCK3NBp7dKCwByS6WNc?=
 =?us-ascii?Q?bKbyfYsEwD7VCSSEa68PHT9kxFeG4BzyphDmpnS4JaRRDEWiFkcQwt0bs3Z7?=
 =?us-ascii?Q?8z+xXjl30nni/4zgJ/t+XeQp4++NswixyYcpbqOIQfbfmV+igLXJhdDNzynR?=
 =?us-ascii?Q?jHvxPf6vm4iETHf7Y1oClToNsIoCF8/lgFsYHS41bR7AgmhL23+vpBPcxlMN?=
 =?us-ascii?Q?W5ZQ2vhBHXUOWhl3k35XbGnImC8U1OyAD+8hNlQ5oV0lGagb/HofEzAxCODq?=
 =?us-ascii?Q?IqrJ27qoB0hT0FEd5x6Cy2mM3a0avWvQn69dJ9Sq/cjVOlw1XDy0oIrLg24j?=
 =?us-ascii?Q?dqjyh2IVg/kStjRtwovXJ52Is2GIpAvQmifmZT9LE5FKn4rFX7uu/VFzmZeH?=
 =?us-ascii?Q?szBHhr0TvtW8BzAW9U6Db1M2W5/wnLL5MUtiWB4c8i5iuuGzSLzAPirsahoD?=
 =?us-ascii?Q?nw7AjAZ5Nax9BfURV+0dY4rU4RiaZDDiEB/WA7MKrf64vguSmt05maI1G9lW?=
 =?us-ascii?Q?vbmzh8iULlxVmkla1LzOUrgVd77GL17zrGk9JaYaFz7JLUuWHWrlcHSiqWjV?=
 =?us-ascii?Q?ev1HvUpPBJswc8PvoQaFqDyHFv00//yPaT8Wv59G1MlnIT5CrBspWraKENCY?=
 =?us-ascii?Q?Hb1RHgcOQp9D7MznU26SbmcX9Ac09phE7MheDWnRtTHA2lMDXCPSWWKLSAxC?=
 =?us-ascii?Q?r8oINU9joNpvarGd8TkH1UOqlflGBsyD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:28.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c120a9-24da-4441-b661-08dcb61ebb2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

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


