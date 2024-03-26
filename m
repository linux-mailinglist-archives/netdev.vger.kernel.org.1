Return-Path: <netdev+bounces-82277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB0588D0AC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536A12E1247
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA813DBAC;
	Tue, 26 Mar 2024 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RyLJpsnp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8513DBA5
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491679; cv=fail; b=UEYRs6P39XfTLeQjOBfQyRykD6XfgjKi4xdcdPOrv+JhJhVVvcowVjUUykwTuN7IF2dJSQ3Sm6yRUs5EdpNmZtnUHSmn1Vkad1iojWrEChv7G376duUhWobwO8JfU4nPbTlQa41xbtN1w0mCZ1jVOgkK4OmS6KM7kuGuU9jvqFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491679; c=relaxed/simple;
	bh=pQ6QZzGwsIbiKDxiiFD281haSf4XYIfT+6os7uWzKsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m87cIG+/kXyfaJojtaAHD4kCTe//wTsn6ob2QdbrLBMOw3i/t2t3MLJhJwRHYiduPimzSzGC8T1IytrlOaMm2ZWQxqcgPTuK2UOYJvd9ZnDQXe9Lwec6g1Q20ZHSfiWM1TCkfc0HrDPilbdJ+270uWCcog9h2IZb+qJMQ0AwOyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RyLJpsnp; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpZbGCkixCRzurPV5I6XKAtpmNdsJmVVMAjlyzdqUJci+Lm9tBAdqjPF/7NftPkI+m/KzIA+/6XgoBpflBjCzzcAVRY+m6KaR8triRc5wtTYrxhovVtCTJa5g/Uec1ZxOeWLPsiPUE2Y1eWLPN5Xs2d5KRZYZ0d+COEQPrVgLTanPksgXKkkA/nGhGIejNpUPy8aWuZnTye6h0+MeOUymevi2My2lDzIvoKlpMvQoKYrtHePD1DflBPu8IAgor3ALB0927f8yFRgfsVDFn6KOW7H9bPPq8SOnrcaWfX80O9qnGmt7TjSbc7hHFlJKtW6bRMT9B0B87MpEmzW1Ljm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDpJdgzZwKXREC90CLTyXGTF3qSUjMliv72ZMUCWNjE=;
 b=IZ0gONwh9MTt5nwSUmO/z0W9HCQ7sapwRhkhGnMOlPne0GhONGz85boVHLZyWAJYWtYtaU3LOKnJ1yg1Y6F/KNmmrV744X6pAan9HAr3auL0plQXoJ/KXMmLhrbuh5U2PrSwX8oA5HAyVccB1vFTar1o3yVXvQ/2uHfgdgeUh6Vifbk6BdZpJKe153AeCaJpmpi+8Wa+BwL4cNN2+M45Ulny8MIVe+z7bQ568cs88LOVUMmCGuEA8k0yc6raRC6bPD70ItHdu8EQZvLvQqrML0+yC576QcBawSns6ovNikEZbX/M0t39k6II0eosstQMlUWQpXwSXrHwwyX0emULzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDpJdgzZwKXREC90CLTyXGTF3qSUjMliv72ZMUCWNjE=;
 b=RyLJpsnpzBDu2XC3y0cepgRY1eqPcIu+pAfjDFW7w62WIHf+DSug0BnJdUBRJ7wD1d/vZE/EvM0LSxmNrjYjjo6yy6Rjme6GIeGCzprkqigHoZJOH9CDaxQT3KW/Ekj84RfKSyChjw/SIsYUWSlHltxNYaW1tIVtzOLKp5/D/xKyChG0Db9o5qiwahSBJollwZuaQva1RNJtXbpXwcYazWYW2GbtinciB/DKeQ3EiMwZ2LnVwph9lniEGhXASxSeL8jEfE8pBM8r56OGm50CddRlp+uIJkUEDGHRSwLpvce9EtWNLOHLKcgIptszsMa1Kq7tdWwYptdMpkefSJ3ezg==
Received: from CH0P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::29)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 22:21:14 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::2) by CH0P221CA0048.outlook.office365.com
 (2603:10b6:610:11d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 22:21:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 2/8] net/mlx5e: Use ethtool_sprintf/puts() to fill selftests strings
Date: Wed, 27 Mar 2024 00:20:16 +0200
Message-ID: <20240326222022.27926-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a79b40-8f1a-43fc-6de8-08dc4de30c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/bHnuMNkyidm/ajvSWERvaG1yoQMxla455oQMmWEIbTzoQOQcXy+eM5HYO41KFfWeBlXrBrQA65ylHQbG5JoRGXl8zZlElXwNXfsa5F5zWuXrB1Q94oaGQ8jAvSJLbHxOBKDwoXa+cozi3OZrN8pxtLKfvlt9EmyZp68hskQy3D+tIPx4dCQ21NlhZOXRbvMJ/PBVhqID2Fl3OXHDaP/MD4xz9arHyJkStHfYjIxnENY8Tco+3P1edEahRGLsIeHOq34mtOkRQqfzDC/KzbOzxa8sb3DN83afnscfoVyUe0/S8RnIzP8M4KZ/S9iL8UZDGpvP54ew2N771nxlaOhTDTMPYEubgXCXTGkOzCWFQJC3Bnv3RFNYX87GOR+YxOoqGJfWBM1XNaiZgceeQOFWPvPQrUNNacdYc79BWUUE5vO5LdNEd1p1nZkbIcS0lmCNNGUxzDfUSxKHPqCZRLRtKK/2Y6LbnFZJjHgNUm6CzIg8uP0bWhQLA0aAiJG36cruuKpsA9nDRZyhFKOjp72y2fi22yEWl40jeYtXiaVrKay+jGEWhCPkPdm0Tyfy1ysd8mI12kAhzCCYSiib+O6WepiDribQIr0hQ9ew1gmu5BEmh4zpf/8ddAR7KphwJHR95X3a176x61PpDH8WNdb8gB3YrJ6yTI+oS8l7xrmGwCb5TERJem4jSl4uzrC4qBkJflg2BjHcLrj8s7PRk0nf3nCS3my2G+xWaKYQVldGoGVKAlyZSrcVBHeGcmvcsRP
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:13.6906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a79b40-8f1a-43fc-6de8-08dc4de30c46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092

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


