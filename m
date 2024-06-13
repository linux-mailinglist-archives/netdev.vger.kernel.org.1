Return-Path: <netdev+bounces-103396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F15907DC6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83501C22B63
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9930C143743;
	Thu, 13 Jun 2024 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jb5Zs5oR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BF13B5A5
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312544; cv=fail; b=ldAXQoaB9OUGxyVhdLiJV++YiXB4IHb+0Rz5vyAvPefDWTblhnxIY34tOscPWR3ohzUno0bWlVlLsMXr2cjW3jgORsRPwmgTWHt4veCeWmyFE/tpJhXlKm7Ni9JXLXRb624mqHbylfEoCFg9JybalCGpgkdOOuU+Hw8j7FyHyXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312544; c=relaxed/simple;
	bh=jTTRYhe7YPR2fZ3LOB3YP/CLGcArVlr9gd1bdCCPILg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQfB88ZjNjQUQ6WdkmHHO8jgzhs7yg2ToAT9/EAiwDSfFoMoJG0rp6s9FAOtL5TKCfdBgrsiJUdfw7I58mwTH3wJHj7njGifKA8q6/zyq3nVBxI58xn5pgRFATMGf9BUXfqT5GJvaSmxfaOB7OGkMkE02U8HPTIVBQzscfyGtIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jb5Zs5oR; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6clTkJ7rX+k1G/8/IWs1XUB0unbMfHK7jjVsgLTzgOWBqp2TO7I+Q6ykYfShBT5Rsdia1ZUKpkaPDmobVh0h09rFYgPhC0/+cRvBvps+LAjxg0kG8pEqK49yrPrUVYLypak66JLdoSQKPALECvbjlHTlLRXccX2vZovAqgA/8WXnEXwOrQiwzn02JqWZ3WKs6XKGvitwBqt8LTP6SDZXZRsHY/FzYHmGOAil/SnDxOmUAd3InHmRyRrKROpiku7j/6o0r4GC7wCCsllz2LScZ15FbH1TlX/xDiQWTyzOChDBwrEEeLyvpXKUatXZr1zLB1ZJFrFILtWL/xduXdgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMiDFskUebmfLzh9g6mtNchMKor8xNGWqDpX2cvyXsc=;
 b=UGuhGqVAr8Poi+WptlEgjPNLE8dQsz7A+/t+czEbS8XlJ+VU/q4mWTvJml60ktB42gaWx3csnqtF0JRUOva2S9L04TFNDjmhdx9i5F3rbyfvED9pcGYpzPTJfVqaE4xXZzZVpIuSfd6AY6CbejshGvMZfwRPVhTea2KkDqvpjKBeXF1w6qNWycmXFboXWL6cDUNVP7+KWfzzO1It0EQLrQ4Ni+WYgq6o0HYg0G4gleGQOn/71+WWKhp7RHY0/kVpqBsu4D7M8I4nGqw+Ebr1oefU+38kcCGAaGgIyH0MeL9eUuYIHSfqHfh7rKRejcnRPaZVFJu407MUsbqqGDoqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMiDFskUebmfLzh9g6mtNchMKor8xNGWqDpX2cvyXsc=;
 b=jb5Zs5oRJzW8Y/3pI25PgyRoEZiS8Kl3QvlI+/x55dU7+dWw/vu90e+rz8LsdA/scXqG/grhCj6+N63P8FlmcxG5oVYK0yBEdfpYVRtPJ0nWDzwIbHrcrvBRYMzF833+SsWNAekGhiqZidNLjSQBxgnP/JA85tkq2Y8E17pU8xfxukMhy+wItOSV5iqkYpLqhbfSb9KgX57B0N8ktelvF2EQ8hy/DJ6cS23fP++rj4HLxBtIBvh0hbqRytRLKEqhvdBnK8KB2bHcINgcZa44nyx6aHoFObZqxmtXB710TlmWogRd+zXcNOK4b2/sqVEgBjXY34fJUbFSTG/lLrEkag==
Received: from BN9PR03CA0267.namprd03.prod.outlook.com (2603:10b6:408:ff::32)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.26; Thu, 13 Jun 2024 21:02:19 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::17) by BN9PR03CA0267.outlook.office365.com
 (2603:10b6:408:ff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:01:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 3/6] net/mlx5: Replace strcpy with strscpy
Date: Fri, 14 Jun 2024 00:00:33 +0300
Message-ID: <20240613210036.1125203-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 538597e8-d605-44cc-531f-08dc8bec1ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|36860700008|1800799019|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6G/y9ys2VhPJQIM4hX5qKC8BJi6IAJYZlBAanwXqec5aphYnq0089DLyPgwR?=
 =?us-ascii?Q?MuW++PhvVGBF8olQelgx6hcnqjGBDQ2upigzaf5LvxjDJ9ALX5jQTQZQ5KU1?=
 =?us-ascii?Q?qfRjerghSQ2SCIZqqeX4Y0JDHXvKaD0GV4WeZhYg2urOPW69YlvfIQyy46Lf?=
 =?us-ascii?Q?y6Uk8Y215HyUhBFUTc933A9/ilbcCJTKcHsfWq+LTvQ6drxPamoB906Usvuj?=
 =?us-ascii?Q?HMlMyzW2k0qqxyBY2xrZO94/BC3x2CYp8UtS4YA/JWsOGlUOJnOKnI4Uc/Dm?=
 =?us-ascii?Q?rfbpfLpV5IPp8hfbPfna1KKWxn9nf1MsfOXCXaJQ8b/cb6f1W7Zsq+5r89Z+?=
 =?us-ascii?Q?Lpwt1FjQmyIRaLx31kAszubnACq+1eZgwCmCaYQK80b/6VACtvf8Y/2pqibU?=
 =?us-ascii?Q?oy52xjuLToXPXP5j6RdK2aFv3matv55G3cnY+cEoy3OQMXkTmY5MO+VE0/7w?=
 =?us-ascii?Q?ozDRkRlPjLi5OtJS5wkMBI8WuBka/sbN0XScHQ7m5rZHHdGsOiyeqmfKG4SN?=
 =?us-ascii?Q?S2843gPwwWRB7Q0rIDsFOwUNKvhdwGvNU34DrGrrfw/ChEVrky/6k4uhmjRD?=
 =?us-ascii?Q?xsBeKY/lrF6MCAUMTL/R2RPueLZpraEmMwNMtz4CUb1bmhRHKS+MKigA6Fhq?=
 =?us-ascii?Q?uRJFB0yfEhtnVS6ZbUqybpGTjcRLEVxKxwKFvAjYPt2ZWTetOEHs4MkfYWyK?=
 =?us-ascii?Q?6cTFT2evXPD+33yUvoI7dhIpAhA1K3tGis0snpmD85HmYZsRY+kkEiNNfQ9/?=
 =?us-ascii?Q?M5+oLA7502YmdoF0fgo06vop2HwRnvyf13pq6+ggm+c0G9hvlbA6HkkCghNA?=
 =?us-ascii?Q?4yrmoyhvTa8mpDYgpa9ZsS2QaFpbS0G+F9AKH8JSaO4KbB/zWaYdHWs7YBhy?=
 =?us-ascii?Q?dlHiNOag+rpmZ1EXAJVMW37eCLJiYqKeOspeh1loTEv4KMTPi5+PGIpUxVf2?=
 =?us-ascii?Q?jYTlROA2so/w+YMBBfaw5ahhsQUdSoiAsudXCOPSsxXwREoz3AvaLjQslVTH?=
 =?us-ascii?Q?6ylE9lEK7s2x6uP1w5dS7UMwD0lgkMlrNomLq3AXsClR012fLOlgNcxdmJDY?=
 =?us-ascii?Q?9b6Y5Qpjf4jcxLnCha86JdaOGRNaVbplZE9BmpfC2tq3HXPbVY7T47kqXLI2?=
 =?us-ascii?Q?D7Mbg62oiCItkASmnluVfEKVNJUbRTspoJt0/Iop8dJWjndLjI3OgDkqJVfJ?=
 =?us-ascii?Q?fjvMlJQ/1WDTYG5XqEoHUTz0kUxZ9HYkA4J/F6m94MTPsv+1xFTuAcnWpDZj?=
 =?us-ascii?Q?c7gvYhYHkayiJWyl9cwLerJ46cy6gz8v0BfQr5lzHuF+hsXtbBenQC//tQ3R?=
 =?us-ascii?Q?BodY5gFcKBk0qtALdZdaZMzrW2rn9ZIZoH/wNQoa+Wb+O1tc973pTJk58xVo?=
 =?us-ascii?Q?6Qyw8McNfktHm711EY8fsLh4t9X/B1hQb0hdoi1w/naz/UOZ0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(36860700008)(1800799019)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:18.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538597e8-d605-44cc-531f-08dc8bec1ca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892

From: Moshe Shemesh <moshe@nvidia.com>

Replace deprecated strcpy with strscpy.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 32cdacc34a0d..a47d6419160d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3353,9 +3353,9 @@ static int mlx5_fs_mode_get(struct devlink *devlink, u32 id,
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
 	if (dev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS)
-		strcpy(ctx->val.vstr, "smfs");
+		strscpy(ctx->val.vstr, "smfs", sizeof(ctx->val.vstr));
 	else
-		strcpy(ctx->val.vstr, "dmfs");
+		strscpy(ctx->val.vstr, "dmfs", sizeof(ctx->val.vstr));
 	return 0;
 }
 
-- 
2.44.0


