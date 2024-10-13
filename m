Return-Path: <netdev+bounces-134908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D700299B8A6
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0413D1C20BA0
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5F13B7A1;
	Sun, 13 Oct 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3oUCq7n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F181AB1
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802025; cv=fail; b=n0d0RQBf3hClHI3WZIDweN18+cjT9qMYyp3d+FeAHYDx9aDNvY2JDX5JuU7ZIggcexw7thtZEH2wP25GanQncVRVVoeuevdEjDyd1sP43i+hqLDsinYdNoM4MPF4kEZyCXDyNVu9cSxPd3ch1jL0lqutcV+kDsw+G14DWYKMRKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802025; c=relaxed/simple;
	bh=2TcKTPp0bKnP/mWG1aiVa/q3LWtt41hAOhsXyxShtXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSiRudUXVu70/a7W2pQmxowQpiCRjPRZB2+sZxhNVSmFnZ4PIxhAm4tdtjbJKS9vdsmSsfcZI+fJck6w+kR2yZ/yuszaCH85AY5fkFoZPUwkUYPc1Yyi0BVs9dmZhZ/ErUKElkau8M/oK0c+Yfm9zQsbFpBZ2gelujUiypwVwMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3oUCq7n; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjZWPtetICRatRxOfERMGB6tYgvnPMq5Z0cRI7LrcjI+Ssq8V0ZZdK7hivvyJbjTsME/0dtIF0Hatwf7V0oVzWuiHUgN8yq0Gb73fdGx8G5oFw4DyMX36Mnf+DciWFE887KCOuhhX4d9rQ7FoFzLuGGUItiWnND+zB7YjG3eRwz545lvuumD1q7YQbv+bHWKbh4icC547HoRsY9SRTzg03AdwgP3eEEmh9UtRWVbLl004DB7ecaB/BgW37+Y/S+NP2CIUpS2yu2ARzqr0i3IhJE3XicA8ulwzPDLCACVsZPr4Zh+4ZeeWHhQHtSJRj4l+MzIK2anZn7k7Kik5o80Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV1/mQR5oVJudf1fDkcVH8tyGjewAHXQXSphYh4Ty+I=;
 b=bGYDsfivV3EdqxB6+bOlZTfKBQx2RzZ+76qiE34gzXtL8CuICcsfFNng4G9Ec43Z/3/49vjPfsv8sXyr0BKoJ/sD24QGq8DkVDDqWKxojndE9JujjMQ1ri+OgtGjDUvbdTmagIVF97m3acmOUQmOcOVTcNFMCbrefnAXbGEdSL77QQbrdsx2id9OxmYmJYlaBV1U+H4hSaYs5LE/QNEBKvr8Yi5SvTloddzA/3CrcXerNdFodvoYvkchplOyZ/H4dP4o7aD8Rog3JWkHrdyLpjHQ02ZbXnczkwtclF6uiWuCqESutC4cRXQy/YE35qUeFfNI7HLs3Eh76UU4XGLubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV1/mQR5oVJudf1fDkcVH8tyGjewAHXQXSphYh4Ty+I=;
 b=F3oUCq7nVhFo20MV3BjOYJXdjJGde5UrYx4JvS7Nk/VAPrg4rhzhd3q8NIzBJ4ekFDQL58D2cUsN8r+th4a5BxzAAd5iP/ajkwYM2wMYQJuFRaoQzz6+z1gmAQ6wppZ1d1unSj7OXYU3npnbTq187iAX7ctoFzKkkfY6lsYe6vHrjpNOxcDuBfg/xI7NNVqjJ1I9TKpOdp/beLJEClWGxQ/VwmorYlo0Ao8kciJOzwAtgC8GV3zEoGNtkqBlqbR2auMrc5/kNXSNZvHL4eTqyRga7ANNrXdok0May67Po1Xp0igaAeQ+vGgCdO/iam4OBqgTmAfuMeLZbikRG0FjwQ==
Received: from CH0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:610:b3::28)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Sun, 13 Oct
 2024 06:47:00 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::1d) by CH0PR03CA0053.outlook.office365.com
 (2603:10b6:610:b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22 via Frontend
 Transport; Sun, 13 Oct 2024 06:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Aya Levin
	<ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 12/15] net/mlx5: Add sync reset drop mode support
Date: Sun, 13 Oct 2024 09:45:37 +0300
Message-ID: <20241013064540.170722-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cee998b-db1f-45ca-0700-08dceb52d5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9+Fr0bmzKBqWoJL06GuuyYkl3daOEazF3QlGqxz9PWlc5MptceXS2s8EwNM?=
 =?us-ascii?Q?Boi+wpGksAW7CumMtevc/NhXh11PTDMsDylruTNyFfhsNT4hy7zDC8UXXLc2?=
 =?us-ascii?Q?pxOE4UflODT4b7ZwGKFKmq/A+IUvAVIB9b+CF42ryE7PSbOF4JLoLFIPF8TP?=
 =?us-ascii?Q?7cO2r9M1bTwjfMXnqpkwq9zP4jihyGcPKAXF9P4CTQhBZBBSZz0QspeqA+Zc?=
 =?us-ascii?Q?qJWS0u1FIQRhBzfz1eYb7GblO3rg+qvBYTnUtvLr5BNfyXy4nxsWRAsF7fpu?=
 =?us-ascii?Q?oqIy6XdeapG1sle/9+CudJgr/iJ2iix774zjN3BFgemYHg8AjFUSdcmSu/80?=
 =?us-ascii?Q?MFuLHpWr7DMUjIQc8jD/NzJ99S0djdD/QejiwZw+pyOwxIYAGxrHe3WxslME?=
 =?us-ascii?Q?bjwYNLVeue8QMI6bFe9q1Bs7WbPfej/ry7Sr2t2XrWOUxR2bWE1bNACaW+ZB?=
 =?us-ascii?Q?x/OEk+HAqeRPD3CCuHPHW0XdF9dgeDqRScGSq0L3SCYmcFeN0D1aWWTcPzjT?=
 =?us-ascii?Q?/ezBSA1/XyzsjUkqzLXprVBFKQwL+zKFeDqvuYPoPn5cKLoQrYtSRFqbwyfV?=
 =?us-ascii?Q?3c+HkIw4jUAaD5pQdrN0kt3aY4BcUcBN6daSdFEmxz0mQe1+R6we3oYmM9Z9?=
 =?us-ascii?Q?tqzO0BO14Xj4fNPyoOeM1Csmr+DN92+yh6/u3MBJ6wcoBCE8VfDSSA/tVp/r?=
 =?us-ascii?Q?1A35GaD0yerwNV0+2YlMGCJSjvICRn5NG1xdLlhG71QoFy5wpibUILu7RTz6?=
 =?us-ascii?Q?k/VK4am65uJbCLvUlYLF6ltCp7vhpgL9yRa3mOoSU4r05PR7YJkT8vOGY04k?=
 =?us-ascii?Q?uZiBdtC6yLtl8DOG3HHaYekMDk7iCovJgc+hU7WYnYnxeB+aIRLPHUQNBfzj?=
 =?us-ascii?Q?cQsfnvcr/+qQOoOfvI/UNrAculX4G2GCcfQa71EM0mpoX1OAIoZE7PzdkTpt?=
 =?us-ascii?Q?gQmCmu9JzwCxG4QyA5nKVwUNFL6jOd3/KxlUQ1O58nDs1Rc8c7nfq+Yniaoq?=
 =?us-ascii?Q?AbTBL6dSikwg85aS3NcydO0HlCkExHzvkh/EX2oiM09IXGoWtFBXc2bdDnuX?=
 =?us-ascii?Q?56eLyI4bx+2qNQ+EnSm/V+A+8aAQGVgssYKD37yJcIEkNVgveMmxeptCe9Kk?=
 =?us-ascii?Q?o/9v+li+WLzf3LHJp9isIfvKZtMhFPqJ8FyWkPVvNEth6RMccOpUt6Hz0Wo0?=
 =?us-ascii?Q?ForBgH5vdXd7rNTAwMJxakW1M6kXmw5RTyufYnNKs/3SCVRpqjusMZ+kHZ0A?=
 =?us-ascii?Q?NVZqDeHxlRVvQCkjO6R9DIfB4xg1SbfcwIZebNBS8fGRCw3TEBQJb1w+8PBj?=
 =?us-ascii?Q?UHkjCe2Yg18+YLDsUL93BKtRN+/7U9wn0l/eUKKpIodwvOmddJRuU/wdF7Dn?=
 =?us-ascii?Q?B810Kwx7cjv6emvyQRJXx4om6INP?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:58.7550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cee998b-db1f-45ca-0700-08dceb52d5f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

From: Moshe Shemesh <moshe@nvidia.com>

On sync reset flow, firmware may request a PF, which already
acknowledged the unload event, to move to drop mode. Drop mode means
that this PF will reduce polling frequency, as this PF is not going to
have another active part in the reset, but only reload back after the
reset.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4f55e55ecb55..566710d34a7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -35,6 +35,7 @@ struct mlx5_fw_reset {
 enum {
 	MLX5_FW_RST_STATE_IDLE = 0,
 	MLX5_FW_RST_STATE_TOGGLE_REQ = 4,
+	MLX5_FW_RST_STATE_DROP_MODE = 5,
 };
 
 enum {
@@ -616,6 +617,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	struct mlx5_fw_reset *fw_reset;
 	struct mlx5_core_dev *dev;
 	unsigned long timeout;
+	int poll_freq = 20;
 	bool reset_action;
 	u8 rst_state;
 	int err;
@@ -651,7 +653,12 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 			reset_action = true;
 			break;
 		}
-		msleep(20);
+		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
+			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
+			mlx5_set_fw_rst_ack(dev);
+			poll_freq = 1000;
+		}
+		msleep(poll_freq);
 	} while (!time_after(jiffies, timeout));
 
 	if (!reset_action) {
-- 
2.44.0


