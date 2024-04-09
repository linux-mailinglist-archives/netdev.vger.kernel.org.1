Return-Path: <netdev+bounces-86244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E710889E30C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C800286DB5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759F157489;
	Tue,  9 Apr 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SEsEkRHz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D05157A4A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689756; cv=fail; b=FC3ZYruqFe5iTtbxLZn+vFsgA2Y/ntQNS6TSvcSXFJpF8dc8ONjv7N5/YgnCFRE5tH57idaVyxeF9aJXcWasiqA+6VR3ur2iHpJoF8gbmrGX0iFs0ivtVrRWHBZATQQa8+5uEwyb9P4IW+n7fN6Vz1PxSfp1RUHppIk3hb8ot8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689756; c=relaxed/simple;
	bh=LrLVdpif73/P9yECTZCyE1R3fjA0k5Kr7DKSM312ebQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfsZeC/F+v1iPEQ4MPwh/EVmkEywzPkkuRn5fzmtjhgtXQ2hL7QZ5U+jBibZNefEpdcGt4OlfXajGAlbrg5T3VGx8PDpT9NDzwr0x/uFC37ZXBxquF1PhIk92yOWJSsNCe0ohw6p4HiYifXbUrgGEbQ0Dul0rESFjMJZA+qIpSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SEsEkRHz; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFmLt5CUHGVu79D3KCc5yxMHe9HCvaVYZP4lcSbDSp2cGiHstlFBqY8m249DWSeIet36703i3iidcGyBpfzWGmezm1ISjp7aiCWARgiDe/XZQIKVIgJ/Err4BjgblhW3Du2VzDPOhCRUPXkn5h2I9Ymoh1xgKPDlOz4RRLBt+p47GQeWyOGJrGb6QlDEB07Q04MwnYFYvJLpXtAzgjWk946ij8hQMLbZp8RKzx5PmyWnLMSOcyqKjtXJsXbKIpAg5vYgE+rqwpThX7ADlYNwmiqiJEskY/oC8pV5wJFFOmR5n1VybnKfjFG2aAKWPv8BilTTDlVDr0Ykq/jAOMH4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2tU07MfajrKYL3NPKOFAwbXTNHEqvJ2RBi82n/ZbhA=;
 b=HbeBidR5l1Qsn43IJ7NVzD8xKXNBf9TIOH2GcbstqXxQPUW5HIMQHD9mZqYlXDiMitlE6b5G+4DgFanXD9Hy/+fq/V29P8UMJUi2rs0L3MjSwNKL8Pr/s/QzDI5uPAuDAS3dAU3wGdJ5u2v3AHyGJ/yyh0Fm0VXp5FwNpd/7mobSh80LIer0BmqQrceVBmo33jYpq1Rjw3qRdnvVM1eQZ9FNDLTEwkMhHzAL4lkbEWq2wAg4O7m84aMNXIkyOVqE1sUH/lu5h6uYZnEgRPcO41/yO2EY82d6c8TECxA0uyP1pwApBVsI/w4jCf+Ml4if6s2ydLZ+igsaq5GSSoal1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2tU07MfajrKYL3NPKOFAwbXTNHEqvJ2RBi82n/ZbhA=;
 b=SEsEkRHzMYDU7U6r7KibCD1Lldsu6TLw/hxloY6ftbvPdUGMiY+WpJnSbzCmoTafJ01hBNhUkePvIi88PzhiC8pjh0XSF2u1PScHpsGMZwtLpMjQi8ePWzazgUMtNUOwiEz0ZFYPrBW2izM38pmDUXE68sNat6CRh/asVCo6TDo3I9myMsvL6P1FhCojTOcYnSEvxKBUFFOcXJTyB0l57nljWl4k4rO2GQ5ml9fOpAvgOG0/WzKMI0j8KxCvzcjShCzoXchMoxk57PCH7+6wb+a39EXcBlE/t7bJT9rLCcqD841/IPtGSpkNdOfvCxdq/6tJWYYYJRNPJF/6QkBfSg==
Received: from CH0P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::29)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:11 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::26) by CH0P221CA0048.outlook.office365.com
 (2603:10b6:610:11d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Tue, 9 Apr 2024 19:09:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:08:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:08:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 01/12] net/mlx5: E-switch, store eswitch pointer before registering devlink_param
Date: Tue, 9 Apr 2024 22:08:09 +0300
Message-ID: <20240409190820.227554-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0430a3-8796-4019-780f-08dc58c889d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YbELhrak/966ab9dZnN2mR0CdrD/S9kJrhpryMx96sTD/EybEjAg5M1IxwhdK+Y71RQ9IRPv7AHI93aGXDkS9ViaD+beb3WbGfL8MAUT3UuZjj2waNYAu2I8PmpE83aKDjkOMMwhXdFrKBzZCASco3PN95/nliNwuL/PjPz0VgnCO186hkDQUjY1FrHO9LrduE8rFvlrVPWdI5RiFQ27ZNsLwdB7vqe1j64LdV4RXJVmiTcHDMW3Hpp8HTofGfkNZeczF9GMEsBxNe8NK0apzr9C4Pd57q6p2Bp10hpEGxFyY/Cyh/ETiAcEnALlbPbv1ooIsH60MhaPwqsVFokd6PKq3odSUDJ1L4Ad+M3122taCKVPzVCU/vKsJa9wO8cGLPgx/8RFG8g9vN1l4sRGmP5pjHTJ0wsqe1ZwR7R7e/PAonenT4Mwq3VVDjWT5QKaqURb1s+hM9amsTGzrzqwt78CTkRvOvkAOiTI86m9VQj17vmqYACLV5vGSPvrKFYLTEqqZ3sFWiH5r3fymECgxX/mvT4cgd0O5I8GjdhJZWQ69+dtpg1q2XNLWENKok6qV9QDJ895rZsMm2iDhuRrWWbXkXl+iET4udZ0Xl7guqbf000yYK7XjwZcxcpD91TAsV/T0CeUuocMUuMxBCFCWN6RxahGkeogXGXbgeMo53AyyvpDgs1E0y+4kD4nm2MUlntrAGcNQsEtLCqh34/HWiwtip0arixt/H7hi8clDNQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:10.7377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0430a3-8796-4019-780f-08dc58c889d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

From: Shay Drory <shayd@nvidia.com>

Next patch will move devlink register to be first. Therefore, whenever
mlx5 will register a param, the user will be notified.
In order to notify the user, devlink is using the get() callback of
the param. Hence, resources that are being used by the get() callback
must be set before the devlink param is registered.

Therefore, store eswitch pointer inside mdev before registering the
param.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c        | 9 +++------
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 3047d7015c52..1789800faaeb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1868,6 +1868,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto abort;
 
+	dev->priv.eswitch = esw;
 	err = esw_offloads_init(esw);
 	if (err)
 		goto reps_err;
@@ -1892,11 +1893,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_BASIC;
 	else
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
-	if (MLX5_ESWITCH_MANAGER(dev) &&
-	    mlx5_esw_vport_match_metadata_supported(esw))
-		esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
-
-	dev->priv.eswitch = esw;
 	BLOCKING_INIT_NOTIFIER_HEAD(&esw->n_head);
 
 	esw_info(dev,
@@ -1908,6 +1904,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 
 reps_err:
 	mlx5_esw_vports_cleanup(esw);
+	dev->priv.eswitch = NULL;
 abort:
 	if (esw->work_queue)
 		destroy_workqueue(esw->work_queue);
@@ -1926,7 +1923,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	esw->dev->priv.eswitch = NULL;
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
@@ -1937,6 +1933,7 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 	mutex_destroy(&esw->offloads.encap_tbl_lock);
 	mutex_destroy(&esw->offloads.decap_tbl_lock);
 	esw_offloads_cleanup(esw);
+	esw->dev->priv.eswitch = NULL;
 	mlx5_esw_vports_cleanup(esw);
 	debugfs_remove_recursive(esw->debugfs_root);
 	devl_params_unregister(priv_to_devlink(esw->dev), mlx5_eswitch_params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index baaae628b0a0..e3cce110e52f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2476,6 +2476,10 @@ int esw_offloads_init(struct mlx5_eswitch *esw)
 	if (err)
 		return err;
 
+	if (MLX5_ESWITCH_MANAGER(esw->dev) &&
+	    mlx5_esw_vport_match_metadata_supported(esw))
+		esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
+
 	err = devl_params_register(priv_to_devlink(esw->dev),
 				   esw_devlink_params,
 				   ARRAY_SIZE(esw_devlink_params));
-- 
2.44.0


