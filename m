Return-Path: <netdev+bounces-116710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05BB94B672
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E31F2475B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E750186285;
	Thu,  8 Aug 2024 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMuQAF27"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4C139D07
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096911; cv=fail; b=D90JuTIx9hspcqQ2qoDRk/LRsSDbH9Yl2onl+0svqXL76/vhQz2lGMyT8JQtK+xNNgsf9EqHBi3f60FmitLkYbXxXV9V74cBiEWyp12iH5ZeDZ7gfWv/wSBfyoLbgOcuqiZJJ/RWRcEZTGnS6KIh2cPhJivo7KfZr0g57pt570M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096911; c=relaxed/simple;
	bh=xoa/q1Hva07Iljfvhn70kdzpD3ol6I3E+eH00TzPzGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSArwBfCnJxlzjjr+tiDYSPARrBKHOGABfZ+71UaV2U+Qb/GUvfhVjC4miqYeqTWBF2rUldBJ4wQU0ruSuUMegnwUbyD/Zt350GlU++pH2NvJVe/x6IO7+fxr6i1BkPifdBN8kH/dkSucc48NHtazoVnxfOhEqFMWg6VNggp12c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMuQAF27; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5rvGOR/j5FKDGEHpPr3AdyMdty5QqBlnl1LwNHfUMXtcLf4zxAZLEdRgr4ZZD4vOGVkzXP9L6ZtWgrz7GRfccFgJkOA9Pd118bDgYyJxjeH/YlpshKHP+KmdgVsWk5Z1XJ6T5GGTF0FABn2d8le618+949InFouWUiMJWmRqW3l3EYhcJMQVpEFr/gHDDZLdQ634jw7M3OkZePzQ1oHb8UyOlK3waXkEe/3J6TWgo7Uj9VsKIyCAWZuDNI4KoyGOMgmwlOFkvpZTwFH/9jED+xysMsCsm3zqO0MM5N9aLdzzGFlCVDeTTyrSJAM/D6RDNKl9TFWBkcOHBIYvCIzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR0LopwZyL18Yjvdh7yJet4HutiLKk7yji6+N9wfNno=;
 b=Ph1YEh/aZAr/nFIzUyfiTKokx86fkDkx7wesyOR1XCXcTNLmU5lxZR8kYjwK+0xzA5CN540ypk6OqgLuvA43eNPeXaR5hU4b8fErZZOpAhV6bAOexiUcet1S0xx+xixUVYZetmeWToR+JJeol2LuQ4sVEwSAANPudiZ/0IkWGEvfm8I46ivASnfc6pIjIwsQ2XvkwK1EJys+QqyPmLaM6vHjbcO1TDRnNnq4c4p1ZVrLd54C4Ay3aVkmXgfsaa+4/SaN32ZyzeIEdsPnrFzZG2vUf3U9gmZtp+g6B7VHTJrJ7HBYqxhaig+3dypdWGn6LRtZ8lLnv29+3ZwBVHFSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR0LopwZyL18Yjvdh7yJet4HutiLKk7yji6+N9wfNno=;
 b=HMuQAF27jdHOLU3tlMdPYiE6yHEbtm8cY2jXpFXfx5/eKviG/zGXaryYlX3SL28sWXTxyRvMcEdDqyM4duCF+S6a/QtHiMDsc+F6poGN1tlxbFeQTLs1Ata36ceC7jZko+966L2gwMtkvBr2TiI2tZLJD95GTickdXPOYcmWRUBivyrBttti26zrTUHZWrW4f9ucGUtFSWtuiDj+ifz07zSBz0Wye8DWi/hTDh/q2+4N5CSYM6i2svJDb8c3xK1dZxV3J1N1LHvlcpOQGRqC6ymVagwAAZlVPxAyZqF1FOyrZ2vCYHn1gf5+TTzPyv1esUMGmy83w3Adl5pk/+RgQA==
Received: from BYAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:a02:a8::28)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 06:01:45 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::7d) by BYAPR03CA0015.outlook.office365.com
 (2603:10b6:a02:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/11] net/mlx5e: Use extack in get module eeprom by page callback
Date: Thu, 8 Aug 2024 08:59:25 +0300
Message-ID: <20240808055927.2059700-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c14b4ba-fcf3-4a85-b602-08dcb76f94d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30PYg2hJ66ROk/VQQmVckA9MzF+6cdLu2VZveJQdoPmBxkEls1c31xHeHG0e?=
 =?us-ascii?Q?5uNN69hPllOHYDHBW3eh0cZGCW6c3VTPGCSqDO8vbfof64toOqPQ4ui2Kx0j?=
 =?us-ascii?Q?NUX7GEJB/Y0XuNh80V1qGuvHeNcoq67LoWo0wpBPHAGS223pbCnRGObrk/tw?=
 =?us-ascii?Q?wFp3cP8rM1km422FJwVqHwHp8HhwTtELje9uZuQ7xfcaC3OKfAiFcv7WvUEk?=
 =?us-ascii?Q?gcJO7iODmWlbdx6gUiVXQuygQP6rmQnIc84+o5GnJVi5Ma2YVTLy/76pC7Pa?=
 =?us-ascii?Q?ukjGXWiscmp6FwHDio88GKJ2w4CmpyEnx6Q1WdgogwB4asCyV3J79g1QkNnm?=
 =?us-ascii?Q?U/hj0xeh/QyOrdhamxNVzhelX6MWNITVcH1eFW951Oe3bRJ7uzY96mfSs+9m?=
 =?us-ascii?Q?92bvsph/qKuigHAU9bUsQmCg2wwtcMu0NbW1atwVRa+q2Gr3HCH70n/BgYgf?=
 =?us-ascii?Q?je/JzXtOEJCmEhhM65LPt9I2LDnXyKYE5GDZO0oqmeWX3XqkYCQ5rBG5bp1g?=
 =?us-ascii?Q?zC+nceZ5vnoxilR1m+P0g3FIlhGe5IizWe0vpSwsOB+W/LAP3qipbaW6WwnV?=
 =?us-ascii?Q?Sp1YVseG5yOqYjSn7knwdYcJXLg+X+LAs45al7RJP9ad9eqicW3GN9S/CNic?=
 =?us-ascii?Q?UHjPOR1A8885WhWpPIzk0hFJc/mh6wYpViAPML5gkw34mQ44Iiq9G2ldrnj1?=
 =?us-ascii?Q?Dm4gVFjYuybh6+NHcMs4V/xjYYsEz4xG6DQ5HbEK5TkM61DV4G6vyOa0q7cN?=
 =?us-ascii?Q?lFdyuqm//yL1fmCmXhmZqNNql2CmubznF9bOZ410HRsXPYCmXVhvr9w/THJ4?=
 =?us-ascii?Q?6nyUDu38I9G9npp4FGTTw8DlzKvqBTKpdoUnqpbpLFUgRNTC2h1aM0iZqTC5?=
 =?us-ascii?Q?f16K7v76g23OxFjv+nW0O2E/ui5bEATXZfQJChttmumJG3XMKPR9xELV5YD8?=
 =?us-ascii?Q?FibYDYbKCCxkDpCfHzD8tnrm0VDK3SFKZck4c4NmcTJGqh0hl8ygH/ATmmgu?=
 =?us-ascii?Q?Ahj5dogBL/C11dD5mFk55qNBl6d5tbfNmIn5eakLesQhxqzigS8czgPkKKtS?=
 =?us-ascii?Q?rftXyXiMYIGo/07dpbARDFsDs2pW3L5EJ2BeBICr/uVg/vHwIrZfXIHuOJPt?=
 =?us-ascii?Q?4VcpoIwc9xZXfK6ahOudApfH6fY72jWz1J14QvLXsIMrXPr5wkspcT/TqfvO?=
 =?us-ascii?Q?bUTJbQm/D+aZ9GRIpv9Edmqw7j02+Q606EtCx+6FGQcDfjg2WAlfn3zjImwi?=
 =?us-ascii?Q?yZH5LtXaiQmfOSmchHbLkZWY9tX8XhbMwu11AYT7mzMmo8pyPOXbiUnFYNVL?=
 =?us-ascii?Q?BX/N+us+q/Fm4vx+vOBW8u+2VOTb8/WpELcQpyK3NjfWbz2Qox5wkd3/Ye9o?=
 =?us-ascii?Q?iMT8VqNX7vTr3poInVpFbA6ZHql0pLR3JLpCGmih4qW9qiNsIdAu0oPnYzke?=
 =?us-ascii?Q?lhT/NMTGe5GXt7yq1oErb+stKet5qyvX?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:44.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c14b4ba-fcf3-4a85-b602-08dcb76f94d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479

From: Gal Pressman <gal@nvidia.com>

In case of errors in get module eeprom by page, reflect it through
extack instead of a dmesg print.
While at it, make the messages more human friendly.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index c14a5542ae9c..56bdb4d07b7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2015,8 +2015,10 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 		if (size_read == -EINVAL)
 			return -EINVAL;
 		if (size_read < 0) {
-			netdev_err(priv->netdev, "%s: mlx5_query_module_eeprom_by_page failed:0x%x\n",
-				   __func__, size_read);
+			NL_SET_ERR_MSG_FMT_MOD(
+				extack,
+				"Query module eeprom by page failed, read %u bytes, err %d\n",
+				i, size_read);
 			return i;
 		}
 
-- 
2.44.0


