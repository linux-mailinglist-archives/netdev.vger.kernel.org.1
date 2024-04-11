Return-Path: <netdev+bounces-86985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1D8A13A6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75099287602
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F814AD2E;
	Thu, 11 Apr 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UDiw+h7p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3F14A4E7
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836545; cv=fail; b=vAmPE/KaujHgKSaocFL8EKJqmpLusBCI+qo1jV44JzB17gNxPCbvedPVKb+CfiZmwlsZ9EsZhfqCj65Ibm5+IGz8y/nQ+SoXnsejuNSpLJj0iAuqWyUQut5MIB7fMbjalt2G14DWPN2pntqDReCLzN8m90SMW52vJ9Rm5WDzYmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836545; c=relaxed/simple;
	bh=9QGt6Of58IJ1oGuu+3j1zs4vy0aVl35OB8M3OcDZvvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+rQ//8tXZ18WdA5WrP5Q63AjXz8cx7yuQnQ58eU9DtiLQGuo2YvAKOy0JBGjaDTh+H5sIz88f9UzPUJHmoWrKBIEgB6wVnV4uxTOyfPDfbNEumjbEVDyfr0XSdR4qpkY603NIT/K7W0rn7SmRKApqqoqY5vRjv4hN1H+wTBnlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UDiw+h7p; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEo/b+qKaJ+UebAHBxl9+oJYMMkAI2LMEOLWz2ql0KEZF8MZ1PRP41ppi8SIlduDJF8zS0LfuO4+I9p6TJjUzIEL+UIkF/xVDG7g53tGfsQMV2xWuHCDMyz6pNmqFvmKrAk8LJ3kCgy1PJ51iQsw1kOPaOE6XT/i+wm2TqHbB1wQJRTdSGobelOkP4RwTUkzlKsL0FYXaJFOt3eij8RxlBopvwmeOf98dih1ywuHwh3Ec2CkFeHrkEEHm2tjvEe+5qAzQxk2M6AJTxGiX+ECazRa2YltdI14fp1bDu6QFeYiHY3Cy0k2Vq+yc8T+FuANgRuDO9Q7eg02qJCrQjNVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsP6d+ycmK+jE168ZjOnkwWEGLbZU9tYG3tGuU9k/0I=;
 b=dsPxKysQO3y+a/OpXtH6JuyMPAZEtjvDptwfxqRlC+kzImy6A9eA3dBcwhpWpCnj22QJBkGrINufM/MmWx8cYuyw4luhEgyfiBrTdJDDGx2kd4NY35OtGqyf+/PZgEgfG0/KdvBsI/umBqHtiuenGN42C2b6mHYzsyTptYSzNTVWbUBS+gA21Byf9Dg3FHZYzkOqCbTOCunI3H9n0HYkXo75nsCy4FPiEGnFNHpMqfvcLUYhUtajiNCAJfGVoJubOFwDIpS+n6gbsGTQRV7Vao78d5he7kCf2lJZo6J41nqBtvR7d18sNmOIzye4YSWQHOOu5UCXlboisFWKIptw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsP6d+ycmK+jE168ZjOnkwWEGLbZU9tYG3tGuU9k/0I=;
 b=UDiw+h7p9MpAnkf+TZZ4Aw+sf6MLeZV9+mwISZFWuhBrOVmDgGGZZqTb6ee1h1GFcyRahspPVF4m7wGhDsGLmyzgPWeRc+DASuu6pnxxtlqrsO8d/xqhT0HCDSTjoE74VY/AWoxtpdjf8Q7pXSOXtF3Aix/hpjHUoeb3ba6pFiZICCTurvsnfJIRGU9tPm8vELOp73wcMSxbMhKHmE0nBRJkXU/aT4IUuFXwF3FFitUVb9aOBgPXtFDI0rvcrFr6QZdTRr4B4nMRe8PTuNAvoY3a/+yhBsjNnFe2xa7zgmfnrtjwqSOXYv9kmYqJXhVxdqbwSADEZ8oDrmOctSwtIw==
Received: from CH2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:610:58::27)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:55:40 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::1f) by CH2PR20CA0017.outlook.office365.com
 (2603:10b6:610:58::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/6] net/mlx5: Lag, restore buckets number to default after hash LAG deactivation
Date: Thu, 11 Apr 2024 14:54:39 +0300
Message-ID: <20240411115444.374475-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411115444.374475-1-tariqt@nvidia.com>
References: <20240411115444.374475-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: dea5e423-6a16-4f47-8104-08dc5a1e4e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	np1VIxbmMReTZils+wyS7kyEaplac7f2K7mui/VBzeWqrYarnrnO7ML/FAu7IGyRvV12DoxDrqJNR8gQuMeWs7WHGXcedMfqgljgGbIlUU2UI9R4E+twEFONNQj7hw3gbIJ/pF99ITHEOj2WJTlIuliVcFYfY/HMO6JPVM64OvvqCHROjMaYJPlEr/vLk5QQ8tt/JrGh+lP2tr6WK07y4qhzhFM26OEpUI3claN4ffKCrtOE7KtmNFueUpLYBPSTlxh9rhGxzunCXLx2n47HO/YLGX+wxx22t9STusP1vOx+bVM/wQZDCaZNm9i44svTIsSWJWHaIGtNsnJ+hUwgWcV8fivRZO8zStxLFxaAtnk3AJhSv5Fszxj3yD0Z224cv2OKq+/GMHX5+N4YkiYr3TN297mr8UXeziVcKuwpChgvP+sxW1BchI8/gPJ3qRcqFAaYgFvPTco5IornUFmneqv/zf9mcj5RAqWI+nQwlBAlQu5bL6vKFqfhgVU/2xbZFuwDG0iXwGr/i39jEH2VgZcpjKTx7WIAB2hq+Kn4pqj0zGYWI3dYxoSYTLU23KVpt2v37Nk3YBmcf2caKNb1zPLzck/+462skZyRy6VqYK/4hgmRuvW0QVJcEVUJmrJ8GyAsuvEMThPJYy2jldKwuKHjXSD1WYtRr4OpN3E+AkK9w1bsYjvq9e1Io6pez+KsXRtm/J0byjnZDz+ovrE2AaL83f1usYdKRFJtys3jUzfCLKxXPndNhFZAuOwuJGoV
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:39.0834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea5e423-6a16-4f47-8104-08dc5a1e4e81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

From: Shay Drory <shayd@nvidia.com>

The cited patch introduces the concept of buckets in LAG in hash mode.
However, the patch doesn't clear the number of buckets in the LAG
deactivation. This results in using the wrong number of buckets in
case user create a hash mode LAG and afterwards create a non-hash
mode LAG.

Hence, restore buckets number to default after hash mode LAG
deactivation.

Fixes: 352899f384d4 ("net/mlx5: Lag, use buckets in hash mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index d14459e5c04f..69d482f7c5a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -703,8 +703,10 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 		return err;
 	}
 
-	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &flags))
+	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &flags)) {
 		mlx5_lag_port_sel_destroy(ldev);
+		ldev->buckets = 1;
+	}
 	if (mlx5_lag_has_drop_rule(ldev))
 		mlx5_lag_drop_rule_cleanup(ldev);
 
-- 
2.44.0


