Return-Path: <netdev+bounces-84024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C482589556A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA531F216FD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7884A2C;
	Tue,  2 Apr 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNsUdYYo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9660B96
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064729; cv=fail; b=lkKw3xSToAL4Bme4wQqMsGZ6d5FuzhMbedMUn7lW5HCMXSYNG5WI/f9x03RDXZnO6ojtTHU844TsvxxG31GUmESR2s7YIQXxvu9w2EdzVPAg9zGYZHheoDXHWfeacGRBjbgn9Xn98b1pf4mVikzaVyorokrbhaqq+n1d+jUO1HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064729; c=relaxed/simple;
	bh=F7QXaHP3mm10Q8OkIKZbzsZD5XkKQX+D5ewDTCswBHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW2ppJkDrnmZtqbIN7TAn+92gpVfVZfh/aJpMoJIL1lX/xQEqpaK0u7xtOKPqP+7XXeezqUsaXKHKjRG7dOcjWJJVRg22nRdl2LC8MHHud4yVm/DMMDbBrm23U+s+dtuGML3fUa14izXVtC796hsa+JpiJ5AKisKziOkBbI8K0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dNsUdYYo; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnpXDy4bOai2Ts/5Wj3dFQBIdsUr3JvLmNOMWbZksvm6VdGmAkY7X8c4/vwYz4t4a871VIzEfLJntLHDZcCAqM+HFjHNRZqow2JLQuuS2TkC3/EZDg3VDpUCBOlYb2YDaFtavnEyG45nwJozuedQvUJAY1aIhS8Pqu8hLwER1FtUxd6BTZLENeGnWFgJGXg/UlDWwBISApoHvLueGj06qHOud0HHTd1fZqV4nBMVUYvO/elSHaePfFX6miMVG2xhITVS1nddnKu6qgPFItgAFOaN1ObXdcMgBR2yIjlgdwXwa/9rRh8SWkbiZFQq3z87jgNQgp8KbPRcTxO7TkqUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaU6E6m9Sjun9fT/K+o7BArjvGja5qR64WxxE9V2EwA=;
 b=GdVnVLJLOrY/TGU6lafY11L+0QXaR2Ni2DlhIWmBIyLJXpoamQQ5QPE+XBDgtVdSjustAo+etM3FmgTVziMRuWb2lwDq0hhnFTZcizUY+y5lAdejlkJ/F/cW5RMF7bAR7Z32xamF6/hLIpFKWCSvBVU+P3l8F0+PJisxHtIuL2i/XNxXU04V4PfP+ITz7bXmv1wbPk+qT4p9Z7MYoktjRE53xPf1kW60ZajZDR/BYfOSAMo3xgZxVjT4+FmdrUCclpTmaHsgw+UUYaX3Ct/JbbB7sLbaqXKJj+DIuMHWxPJLSBjuwd6DaiR3xa0bKZHwUVZf0xEFvSHqpWBw8qFz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaU6E6m9Sjun9fT/K+o7BArjvGja5qR64WxxE9V2EwA=;
 b=dNsUdYYoZaa4SDd53gM1eCUAlAY3ieIkOlq5V5ntmNxFxmmGJiCylgwCrt6JSRd61bnVJqAEkT2LGD56XveM3bBoRCxgAWtyYoIv8u8wvjnVs8aqRjesZYLY2rfztAsAbnvfAQhOrWcwU0i1tSNoysl8u8VbdHvlWp9Kf45ZUY7X7HFNt8U1FrEQTTyex8Q240OM7J5CSS46gi/DLACej9R6ZphxBNQjk/K1o9CzhTwnCkJjbVba+7HnF5q1heYCpjkmBmMRidMWausYXS2X/bXm3bnGVQJjjnf8O8EZJzPkUHpjZ13f0urCZoKHgZXImZm/v1YvkcD0+BnawRIu8A==
Received: from CYZPR17CA0021.namprd17.prod.outlook.com (2603:10b6:930:8c::26)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:04 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::1) by CYZPR17CA0021.outlook.office365.com
 (2603:10b6:930:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:42 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 02/11] net/mlx5e: Use ethtool_sprintf/puts() to fill selftests strings
Date: Tue, 2 Apr 2024 16:30:34 +0300
Message-ID: <20240402133043.56322-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 8668e0d8-b528-4feb-990d-08dc531948a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BKLDr0dOfU2Os3BCTkQqiKQUUZz+9UdtZ14MXkGQom6hwYehpeCrb5SR1fcacTnVH/s61pEtc44DhjvHB69mC0GW2nn7lwUCLXWqygBF8pu5lGGP9Jfo250SbM4qDVW0J5ohrjXGT+gh68ebKh2tM8+kKV0sWmoy8xFFvNmZtB6BJwO+Xyr7ucLFflEob8FYznGKX57gcwqUz3vuUf0Au++FKDra4O9xhVjzO0SvmtTFffp1OWfvLsqUwx55wImoDMo7Hq50VkOvkx6baAC8N8Qx1XPxKlSOp8eSqm14oo0jJjeQaqJMfCPDl9/413jaFPHMaT4tMxVDag3P0WBvMIh4/WTyfmE82R4TXxvGoUn4B5weQmV5R+bDLTP9yu5F59Yp/Sby10r6LvvZ7sZ7bhz7qXLDWmsMRvAAZ7/skcFBtJqX6NVqyP1+Ne9JK/YOEqvcylBSkDK8xn94vuzNISxukHiEwqxZPRXSczhS8Ml9wKPH17iE4fh8e0u6l0QkXAs8zTYF2NaLr46pSyewXU3ZFgHT5zSlP4yxLH+33ZKFaaHfnQ34jgEIEXd523loQatZOSMQYrIyMB1Q8ZH+KwcAvZNhB9p6ASsFYMGMEU48Ku9RDTcp+1kI6J3WB8+SvBliSxbsjhIuUMkj/zdLqZ/fvtcLkVW4+YM24T1cVNFzpR3hZpqTqnHTxmJKdmiMy1OOiNFR54IlBd/bV9r9y2EywUfDEBdDntt5dcebgQuvCbla5EBZPnh5ryeEQRIM
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:03.6577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8668e0d8-b528-4feb-990d-08dc531948a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

From: Gal Pressman <gal@nvidia.com>

Use ethtool_sprintf/puts() helper functions which handle the common
pattern of printing a string into the ethtool strings interface and
incrementing the string pointer by ETH_GSTRING_LEN.

The int return value in mlx5e_self_test_fill_strings() is not removed as
it is still used to return the number of selftests.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 08a75654f5f1..5bf8318cc48b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -359,7 +359,7 @@ int mlx5e_self_test_fill_strings(struct mlx5e_priv *priv, u8 *data)
 		if (st.cond_func && st.cond_func(priv))
 			continue;
 		if (data)
-			strcpy(data + count * ETH_GSTRING_LEN, st.name);
+			ethtool_puts(&data, st.name);
 		count++;
 	}
 	return count;
-- 
2.31.1


