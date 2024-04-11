Return-Path: <netdev+bounces-86992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C408A13AD
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF531C21A0C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD314BFB4;
	Thu, 11 Apr 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pCw9QWwR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47214B07F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836563; cv=fail; b=jsA49TQtC5twtvVDukPS6MaBLUmvSBDhkqxB6LhFXAnlzcA+Iw/w9aTPv8vyGi8yZFvKb5BMl1xQ/5HTWJk5A0XfJPQrO8qIGFUuGPmEEeHTvpLaPCFTm0mDz9GxVSx+0fpWqs0nUrSo30JRZr2qLcy0EhhZJiyyC1S6b+wRvrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836563; c=relaxed/simple;
	bh=yAO09qqiR7vluIOUPxjvWBLiU5aCnf3y1VE0HwrlnnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chvrSyntxklc8DDkYGWOJJsbI6PN9v2ov+PTAtTbF7YNHrafhM+o6NfxWWJxlimqIE7cScwGVKK4Z77q15SDzUmKzGDaTXWqDj0FJXlb14xPl6ApvX2kHCKmT0Uk99EAt+scHQ9OozkNQnVSRnPzkmlexC9Z4XuDtfXSR3xg2yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pCw9QWwR; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnRVC2JKp8ntJmBh/iUFZeyQ8dFzRzpE0o2qcusKwuDLCN+CxT6tu8bCMoE+W9TZVF5Z2Mq+IntbTfnPSbXgsHuJ/SkLwd2E7IVIYkVcGO8SI5WFICMZln//UtJpkEo8yc9Tw3XKOqunUzdxshATIe/RmtgEtutjfnkL32D5RsOnis2Tz6ghjxwdoBzMi5zdfHqEaNal3YWsnOLORE4VdcbMeCDYMhR3vDvCX0JRZbkY6qxW8C/ZcXgWf+Hn3lTVgL/bO9exhqbXYT5LS9e91NmUh9KOyk3B+39inrG9AQh16Xa8U7tnUSQbEJu0JaWl1t+Ar9kpMiKc2cGx8cG9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N1GJ3WKsV+XQ5nfVIAhQmdvrYFMRk7cHqvusRmH2Xw=;
 b=Z1zMTRuDh1E051ik9xwuZ8RWXD/8uuEfkZDbpnPv29/GBzMO/66/WKcg2G3a6a4BHeWKX7jNnZQjK7mds+W/FzunPr7bBBwNs0rywNKw8XfRiGPGcgIYO84zhfR2uuIyPrhzEAqChBzuCGWJlSPMqA1ecW4ThZbUJO90h/xwlEsa2ocSyjQeTGdDg9whWTQsNvBiCZ0k+P8tUg4jXRJQYDuUmT3+H6BS/izihljZ79AUVsadtVUPNjxSGvrxijN18qav/oUEwGQXBwdC0qZ2VEVkoOyhlrvE8TTS/ZcUYQDyOhJEtG4z1EDwrQz03Byws9zxDEZGyhK567WntRxrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N1GJ3WKsV+XQ5nfVIAhQmdvrYFMRk7cHqvusRmH2Xw=;
 b=pCw9QWwRjFxG3uotu9lcrylVoia2OYSaT7DFo74Wqad2OQyF0zzi8LpKsdHehLbKQ9L2yvgKSdCPXGPFX3+dQvw8HiOhClRSH2MCESHL59OaENnH+l87N5+0M9LUuV8bsz9TjjnhzFjfN06yxBkr5dYOMCEjhkL0TyiErr3NcNaxkvGjn228NekXbClrYKJi4cIo7Ij+vC26ogknZL5u0lwvqGtPVO1UpuDSitqBDw1TfVjaendQFvNRev4MCVAFTs/Y7u53zPgRZ0pj1mYxQonWWMarhGxQTZ2L6aRvo0VKyz553DoNSlnkCPZqyJXJSZlBj88fT/teMIsI9Dc7QA==
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 11:55:59 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::43) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 3/6] net/mlx5: Restore mistakenly dropped parts in register devlink flow
Date: Thu, 11 Apr 2024 14:54:41 +0300
Message-ID: <20240411115444.374475-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: a995bca6-4ad2-4982-8f29-08dc5a1e5a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q7BvgCjAtu0/oU8Aaq4EwwBVebE033QQqN630A1BYDDmzO9z7k3LTk3rctWYarOsXgZ+OW/cjCZiHCZqo1Kz0NCFYomqOuGNWZeLkp9D8AsZQJ28u1s0Rl7AwZMlFDnR+ZNXEZReZXcjmdkVPR2/8g9FNQ6PyxM1vMU8ibU3nIBa3zaYYwBsoNZiLzg2zuuZjO/8qe7ZUIOhfwPvTJumG7kLbC2TuOjZvg7Q52ySZ0QPe76uM8yN3T9uzVYIeV8Gsy1YMs4q80CdPMiYXVwQcZ5EEDXQZe+Ty+HEuwoLbZbaIHLvgpwD1h+Lox99lWUwJ+ah9b1fuwCc4cFEs7iJoRCpLCJ22HYTwPd2S4R+5H5y833JgspQnHbHW6icSue4XTmVZ78zMt4esBMeznisdxhn5jFbfWW6gLZgg6kKLTV6QVM504d8ExPNF93xdcia8aT4tAjtqvoC3B5NGSmSfwY3C8hXDGYTO8sk+TNfXyeIdKK5mYXCoa9HPOiBWyJebVKOE+feOwMvzQqUDNz82nVSv4FK6RM06geqScXBLP6+j7pu2dAFMoVd6Z5nNFoQHQNhvQEbQWG+2aRrDoU428X17tG2BlJOwIk4Vp8dI3wjxi47gk6TahHauneM7Jeu+/iFREiwioBeI5JWlFiA2KzZIIiRla0COecBgMC8zsDV/2LquhuARK1WQlDFIcH/Tl92YfjVpLs9Uw1BVotBRxvPBrrqYSdAgJSp065ae9tybOLbo6iC6DBkTy0TaOjM
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:58.8821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a995bca6-4ad2-4982-8f29-08dc5a1e5a4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

From: Shay Drory <shayd@nvidia.com>

Code parts from cited commit were mistakenly dropped while rebasing
before submission. Add them here.

Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c          | 5 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index a39c4b25ba28..331ce47f51a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1699,12 +1699,15 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	err = mlx5_devlink_params_register(priv_to_devlink(dev));
 	if (err) {
 		mlx5_core_warn(dev, "mlx5_devlink_param_reg err = %d\n", err);
-		goto query_hca_caps_err;
+		goto params_reg_err;
 	}
 
 	devl_unlock(devlink);
 	return 0;
 
+params_reg_err:
+	devl_unregister(devlink);
+	devl_unlock(devlink);
 query_hca_caps_err:
 	devl_unregister(devlink);
 	devl_unlock(devlink);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index e3bf8c7e4baa..7ebe71280827 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -75,7 +75,6 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto peer_devlink_set_err;
 	}
 
-	devlink_register(devlink);
 	return 0;
 
 peer_devlink_set_err:
-- 
2.44.0


