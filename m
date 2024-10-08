Return-Path: <netdev+bounces-133268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9C9956A7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E854B2796F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501021501F;
	Tue,  8 Oct 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uCQxt8+2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AC212D1B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412426; cv=fail; b=P+ZLReMD93GlJRBq4c9zo0Xs7Pa+nmTxOYde33elq6VzZ5BNb6iYh3Ra3RLgv9iiCS2ISmvrp93O7ZMoqfcCwnUExMDmNhNJqch7OPzArnEmJ/P4A1H2xsC1RT9sYH7MRqi9P75BS3nLPBYxLGHAqKOJ61ChNz0dUWmHNyaMntQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412426; c=relaxed/simple;
	bh=krpfjcBoUR4bnslxtdDQ9r9NDqpcU1stij6QrK05gQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGNclg1r9vuN+hvZ1wN4UR9bp2HcSPZsmekEASn6XHd01wixH0yjuXcaiFnK+r6aLfsqGE5ONZ1q+TtNMoj7yluVEPzz1CFUYCzpfoqCUvahlWUdD/hupQCKZMkgVSnx+wgqS1PJGWY5dP8RcgNsj4y6qAO68CVx0ln0pNN396M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uCQxt8+2; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZOTCum6zeexxwHg+UzTwIVKn2cgTupHr07zZ0jVxrog6KN3qRWzvCiDyP8x7tWvu3O6uawiwlAp3AjnIk9i/w4uK9vIX4xFer+yTMD5QiYgjHP6snci+pCb4wMr7S71Q6pdYlTYrQtkbL+FQ3hjGAsIHE4aJAr/Tf3Ov3Y2gHAwyUcyCZeX1+Z0TWjTkK7RC6yBHZYKxoVbko16zzjSnyoi+JKWtL07HzUa9bnqWCn1tk/nmnKS2EVRjYROolLRZD1iQtuWRsa+m7c7HP8J7abG8pxB6+xh4SbTiB4ydNLilhFkc41n4Ep6VHkaDDjoMeqxodwzFN/JcCPJ8bXaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPDp/quHVB2MrQI1nv0mfkrt4kxUzXCPTE+c+MAsfIg=;
 b=EL1CK4CWfNKD6UjszwjDVIPMKn/hZAG0BkHUkhvS4F2RThKlBnwAm1LS4OhVSIeyekQEheu7LJ8ar45gCImEZKMEXVwAV3cSy8MuoklNHP45KTOYn71zcX2IvxGRrCbp/osmc5LFFrOGgW+0+7A9q5AjvyU+nDXZlqrubC+81imuzpsFCV8mRo6zyKuDV/6MYZaD8+LVfwqYmg8s9wLjeav/+jWtEKFZQJLBZs9xEvhvRu/IBfZmpaKQGp98O2P/Hyt0uCNppyeDEj+ACgdK6fAa7x9SrvANImF2vCoimMNtkI3dt/i+AOpaKqoqUze7Qbir5lL9BK3pImaaSkveLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPDp/quHVB2MrQI1nv0mfkrt4kxUzXCPTE+c+MAsfIg=;
 b=uCQxt8+2AB5dIokcfFLwnZD3tbbj/yBSnqzE5KM0dLNlQaYwxZ/jl69lFwb82gvF7XibDUHwl0cXxHEZOhtCM4H4swzrhMrWaD8ghVez84ZY0hf450F6lKkUX1Jd1fWD7UTFfhyO6BK9Ch+iNPwmYy4R66oYM1tz22DXrxuU/YVSTKOwYkEhi1eq/9tS0GY+G7Poho7kGdquBjyAJURYxuYDiZu5eMubqy+kqh9neHbKe30uPWXFyINFzZsOsQNwuE60v+kXIMBTQnS9djVNog2lQ+f1fga19slQCXf8bqUYu7Fe0bqqGWdwcVYjMSMdT6JqQESlqAVNzm0bDEI6gA==
Received: from DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) by
 CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 18:33:36 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::1) by DM6PR01CA0001.outlook.office365.com
 (2603:10b6:5:296::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/14] net/mlx5: qos: Drop 'esw' param from vport qos functions
Date: Tue, 8 Oct 2024 21:32:15 +0300
Message-ID: <20241008183222.137702-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9566f065-22bf-4e06-2041-08dce7c7b874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9WXxHbQsB6mE9uKT/RPsadjKhqYON2HhlLOW7w5xNpK+FmxcQdLUsKwv61bG?=
 =?us-ascii?Q?Mu+mxTIbq9YjUetMQVLhFQwOWKPzyJidR6djGcvFznL3CRrkR8Hdv+76PQwn?=
 =?us-ascii?Q?QqEAVPKXjq67RFtM35sLscETpGrodSJzNyPRWqtbGkwa+BEZZdRJr/OllUSL?=
 =?us-ascii?Q?xdCElBME3xzfJragMGiFKKoDyYYvjHoaQA5Ech4ychf1Vphrjbl513HmJx6P?=
 =?us-ascii?Q?FYtpsTkubOVMr2EcpjMMmpSbeq5404wLk6P3CidK5JiKZWJSdVhJutKjeTT5?=
 =?us-ascii?Q?qvft9CQjJNAIQozoO2IdxcjAOcdHLj7+ILVuj0J3RKj0XnzDF68y48KFdEHP?=
 =?us-ascii?Q?xJazA0oimm2JBCSit3QrjuM/sl8F8xMZbRJLICHkMuYmI7rIrhX2HHP7uLzD?=
 =?us-ascii?Q?015kYPJmx/Ndb20CC1AtXgGPJIlZjpfwqKUV3UobP7SDJdyzuxwGfIl0zTfa?=
 =?us-ascii?Q?JUsQpsIAY+r2bSKVDtgBCN9kwh69mPioDbTvcO8DhWIdiVSugU4ye5azcsfp?=
 =?us-ascii?Q?QS6UoDpiTLPy+rF3GUxfR1HYbPbBIAvGlAAp3BBCuFN97SiVT/qoRY+ehBQQ?=
 =?us-ascii?Q?NVZCIUuvo1X0pt1fNmutbG41u/qBEnZj/qkotCrrDhkf3RnddbuBcD1rjNzT?=
 =?us-ascii?Q?ptQFvxQB2Sj2iWDF9Wp9Dk9fGOcdOOgwvpgZJAEqVAN7+IM9lIibC4NpD/g1?=
 =?us-ascii?Q?sRW9IyRVfJinCc1mA3F/I8aVQUne35X8iGl3Pp9p/ZDJg1FLdniWOQDV8Tdn?=
 =?us-ascii?Q?8gAWMU83aewq2zHgB8aDF8psKHdhV3KXM5rGFxrVCYHZUh0StAPWf5uDiSzM?=
 =?us-ascii?Q?uGSebd+dQwCZnF+WqsDmVrMp0UAZsS24qtTWDzYJI5PYE43f1M7bhSG4uStb?=
 =?us-ascii?Q?oYz5J0pkjraopgKkXv90fDauzKxPiA91VaZvMq7O+mtQA/+L9O80zPe/gq3l?=
 =?us-ascii?Q?0Ox8BW8s+Livu6ntPZqEiL03gEFMufvFoPVQ3Q0YWbMWf2Okhqs7EXbNjXK/?=
 =?us-ascii?Q?diJ3tH+9MBkux82UL8DvZEmKzJ9rdkpCI36Rq5yFGeiNut95lxvEWisOQ91c?=
 =?us-ascii?Q?y9at6MyYOI9vIVRnYi1CTZ6vfgtzcwymk0dU/Rcqh/5RxdnQKaTsOucznXn7?=
 =?us-ascii?Q?FfNpx3GZYi9AldB6lgAyWAhx0XWZQCEpEqgiDGC/iMH+4M9qgo17gRgM7Fbl?=
 =?us-ascii?Q?5aw/53lmgFaU9ftDM19AYfUYzH+zOF6vbBuFRRQ7KMSQw7QznV0+dV+CxN8g?=
 =?us-ascii?Q?JyOw2Z0XSdwdjacKD/EXQ0ML5U1YPPr89rWn9FKbRXYi17dJdKAbxxMSIZnw?=
 =?us-ascii?Q?ffI+fcKTnkF9hJP0Rm1RIKJPkKT32PGvk5pWPsOs3zqQjP60BcZHwE0M23Ef?=
 =?us-ascii?Q?0XpOvPRDSEFK8FWCToajldsYdFP6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:35.7487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9566f065-22bf-4e06-2041-08dce7c7b874
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

From: Cosmin Ratiu <cratiu@nvidia.com>

The vport has a pointer to its own eswitch in vport->dev->priv.eswitch,
so passing the same eswitch as a parameter to the various functions
manipulating vport qos is superfluous at best and prone to errors at
worst.

More importantly, with the upcoming cross-esw scheduling changes, the
eswitch that should receive the various scheduling element commands is
NOT the same as the vport's eswitch, so the current code's assumptions
will break.

To avoid confusion and bugs, this commit drops the 'esw' parameter from
all vport qos functions and uses the vport's own eswitch pointer
instead.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +-
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 95 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  5 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  4 +-
 7 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index f8869c9b6802..86af1891395f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -187,7 +187,7 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
 	return err;
 }
 
-void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
+void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 {
 	struct mlx5_devlink_port *dl_port;
 
@@ -195,7 +195,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, struct
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_group(esw, vport, NULL, NULL);
+	mlx5_esw_qos_vport_update_group(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 8587cd572da5..3c8388706e15 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -521,7 +521,7 @@ int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 		return PTR_ERR(evport);
 
 	mutex_lock(&esw->state_lock);
-	err = mlx5_esw_qos_set_vport_rate(esw, evport, max_rate, min_rate);
+	err = mlx5_esw_qos_set_vport_rate(evport, max_rate, min_rate);
 	mutex_unlock(&esw->state_lock);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 958b8894f5c0..baf68ffb07cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -67,20 +67,19 @@ static int esw_qos_group_config(struct mlx5_eswitch *esw, struct mlx5_esw_rate_g
 	return err;
 }
 
-static int esw_qos_vport_config(struct mlx5_eswitch *esw,
-				struct mlx5_vport *vport,
+static int esw_qos_vport_config(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share,
 				struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = esw->dev;
 	int err;
 
 	if (!vport->qos.enabled)
 		return -EIO;
 
-	err = esw_qos_sched_elem_config(dev, vport->qos.esw_sched_elem_ix, max_rate, bw_share);
+	err = esw_qos_sched_elem_config(vport->dev, vport->qos.esw_sched_elem_ix, max_rate,
+					bw_share);
 	if (err) {
-		esw_warn(esw->dev,
+		esw_warn(vport->dev,
 			 "E-Switch modify vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify vport scheduling element failed");
@@ -169,7 +168,7 @@ static int esw_qos_normalize_group_min_rate(struct mlx5_eswitch *esw,
 		if (bw_share == vport->qos.bw_share)
 			continue;
 
-		err = esw_qos_vport_config(esw, vport, vport->qos.max_rate, bw_share, extack);
+		err = esw_qos_vport_config(vport, vport->qos.max_rate, bw_share, extack);
 		if (err)
 			return err;
 
@@ -213,16 +212,17 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 	return 0;
 }
 
-static int esw_qos_set_vport_min_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 				      u32 min_rate, struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	u32 fw_max_bw_share, previous_min_rate;
 	bool min_rate_supported;
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
-	fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	min_rate_supported = MLX5_CAP_QOS(esw->dev, esw_bw_share) &&
+	fw_max_bw_share = MLX5_CAP_QOS(vport->dev, max_tsar_bw_share);
+	min_rate_supported = MLX5_CAP_QOS(vport->dev, esw_bw_share) &&
 				fw_max_bw_share >= MLX5_MIN_BW_SHARE;
 	if (min_rate && !min_rate_supported)
 		return -EOPNOTSUPP;
@@ -238,15 +238,16 @@ static int esw_qos_set_vport_min_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 	return err;
 }
 
-static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 				      u32 max_rate, struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	u32 act_max_rate = max_rate;
 	bool max_rate_supported;
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
-	max_rate_supported = MLX5_CAP_QOS(esw->dev, esw_rate_limit);
+	max_rate_supported = MLX5_CAP_QOS(vport->dev, esw_rate_limit);
 
 	if (max_rate && !max_rate_supported)
 		return -EOPNOTSUPP;
@@ -257,7 +258,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 	if (!max_rate)
 		act_max_rate = vport->qos.group->max_rate;
 
-	err = esw_qos_vport_config(esw, vport, act_max_rate, vport->qos.bw_share, extack);
+	err = esw_qos_vport_config(vport, act_max_rate, vport->qos.bw_share, extack);
 
 	if (!err)
 		vport->qos.max_rate = max_rate;
@@ -315,7 +316,7 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 		if (vport->qos.max_rate)
 			continue;
 
-		err = esw_qos_vport_config(esw, vport, max_rate, vport->qos.bw_share, extack);
+		err = esw_qos_vport_config(vport, max_rate, vport->qos.bw_share, extack);
 		if (err)
 			NL_SET_ERR_MSG_MOD(extack,
 					   "E-Switch vport implicit rate limit setting failed");
@@ -343,13 +344,12 @@ static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
 	return false;
 }
 
-static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
-					      struct mlx5_vport *vport,
+static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group = vport->qos.group;
-	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_core_dev *dev = vport->dev;
 	void *attr;
 	int err;
 
@@ -369,7 +369,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 						 sched_ctx,
 						 &vport->qos.esw_sched_elem_ix);
 	if (err) {
-		esw_warn(vport->dev,
+		esw_warn(dev,
 			 "E-Switch create vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 		return err;
@@ -378,8 +378,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	return 0;
 }
 
-static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
-						   struct mlx5_vport *vport,
+static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
 						   struct mlx5_esw_rate_group *curr_group,
 						   struct mlx5_esw_rate_group *new_group,
 						   struct netlink_ext_ack *extack)
@@ -387,7 +386,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 	u32 max_rate;
 	int err;
 
-	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
+	err = mlx5_destroy_scheduling_element_cmd(vport->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  vport->qos.esw_sched_elem_ix);
 	if (err) {
@@ -398,7 +397,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 	esw_qos_vport_set_group(vport, new_group);
 	/* Use new group max rate if vport max rate is unlimited. */
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_group->max_rate;
-	err = esw_qos_vport_create_sched_element(esw, vport, max_rate, vport->qos.bw_share);
+	err = esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport group set failed.");
 		goto err_sched;
@@ -409,18 +408,18 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 err_sched:
 	esw_qos_vport_set_group(vport, curr_group);
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_group->max_rate;
-	if (esw_qos_vport_create_sched_element(esw, vport, max_rate, vport->qos.bw_share))
-		esw_warn(esw->dev, "E-Switch vport group restore failed (vport=%d)\n",
+	if (esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share))
+		esw_warn(vport->dev, "E-Switch vport group restore failed (vport=%d)\n",
 			 vport->vport);
 
 	return err;
 }
 
-static int esw_qos_vport_update_group(struct mlx5_eswitch *esw,
-				      struct mlx5_vport *vport,
+static int esw_qos_vport_update_group(struct mlx5_vport *vport,
 				      struct mlx5_esw_rate_group *group,
 				      struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_rate_group *new_group, *curr_group;
 	int err;
 
@@ -432,7 +431,7 @@ static int esw_qos_vport_update_group(struct mlx5_eswitch *esw,
 	if (curr_group == new_group)
 		return 0;
 
-	err = esw_qos_update_group_scheduling_element(esw, vport, curr_group, new_group, extack);
+	err = esw_qos_update_group_scheduling_element(vport, curr_group, new_group, extack);
 	if (err)
 		return err;
 
@@ -669,9 +668,10 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
-static int esw_qos_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
+static int esw_qos_vport_enable(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
@@ -685,7 +685,7 @@ static int esw_qos_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	INIT_LIST_HEAD(&vport->qos.group_entry);
 	esw_qos_vport_set_group(vport, esw->qos.group0);
 
-	err = esw_qos_vport_create_sched_element(esw, vport, max_rate, bw_share);
+	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
 	if (err)
 		goto err_out;
 
@@ -700,8 +700,9 @@ static int esw_qos_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	return err;
 }
 
-void mlx5_esw_qos_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
+void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
@@ -723,20 +724,19 @@ void mlx5_esw_qos_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	esw_qos_put(esw);
 }
 
-int mlx5_esw_qos_set_vport_rate(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
-				u32 max_rate, u32 min_rate)
+int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_rate)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
-	err = esw_qos_vport_enable(esw, vport, 0, 0, NULL);
+	err = esw_qos_vport_enable(vport, 0, 0, NULL);
 	if (err)
 		return err;
 
-	err = esw_qos_set_vport_min_rate(esw, vport, min_rate, NULL);
+	err = esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
-		err = esw_qos_set_vport_max_rate(esw, vport, max_rate, NULL);
-
+		err = esw_qos_set_vport_max_rate(vport, max_rate, NULL);
 	return err;
 }
 
@@ -830,12 +830,12 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	mutex_lock(&esw->state_lock);
 	if (!vport->qos.enabled) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
-		err = esw_qos_vport_enable(esw, vport, rate_mbps, vport->qos.bw_share, NULL);
+		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.bw_share, NULL);
 	} else {
 		MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);
 
 		bitmask = MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
-		err = mlx5_modify_scheduling_element_cmd(esw->dev,
+		err = mlx5_modify_scheduling_element_cmd(vport->dev,
 							 SCHEDULING_HIERARCHY_E_SWITCH,
 							 ctx,
 							 vport->qos.esw_sched_elem_ix,
@@ -897,11 +897,11 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 		return err;
 
 	mutex_lock(&esw->state_lock);
-	err = esw_qos_vport_enable(esw, vport, 0, 0, extack);
+	err = esw_qos_vport_enable(vport, 0, 0, extack);
 	if (err)
 		goto unlock;
 
-	err = esw_qos_set_vport_min_rate(esw, vport, tx_share, extack);
+	err = esw_qos_set_vport_min_rate(vport, tx_share, extack);
 unlock:
 	mutex_unlock(&esw->state_lock);
 	return err;
@@ -923,11 +923,11 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 		return err;
 
 	mutex_lock(&esw->state_lock);
-	err = esw_qos_vport_enable(esw, vport, 0, 0, extack);
+	err = esw_qos_vport_enable(vport, 0, 0, extack);
 	if (err)
 		goto unlock;
 
-	err = esw_qos_set_vport_max_rate(esw, vport, tx_max, extack);
+	err = esw_qos_set_vport_max_rate(vport, tx_max, extack);
 unlock:
 	mutex_unlock(&esw->state_lock);
 	return err;
@@ -1017,20 +1017,20 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return err;
 }
 
-int mlx5_esw_qos_vport_update_group(struct mlx5_eswitch *esw,
-				    struct mlx5_vport *vport,
+int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
 				    struct mlx5_esw_rate_group *group,
 				    struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
 
 	mutex_lock(&esw->state_lock);
 	if (!vport->qos.enabled && !group)
 		goto unlock;
 
-	err = esw_qos_vport_enable(esw, vport, 0, 0, extack);
+	err = esw_qos_vport_enable(vport, 0, 0, extack);
 	if (!err)
-		err = esw_qos_vport_update_group(esw, vport, group, extack);
+		err = esw_qos_vport_update_group(vport, group, extack);
 unlock:
 	mutex_unlock(&esw->state_lock);
 	return err;
@@ -1045,9 +1045,8 @@ int mlx5_esw_devlink_rate_parent_set(struct devlink_rate *devlink_rate,
 	struct mlx5_vport *vport = priv;
 
 	if (!parent)
-		return mlx5_esw_qos_vport_update_group(vport->dev->priv.eswitch,
-						       vport, NULL, extack);
+		return mlx5_esw_qos_vport_update_group(vport, NULL, extack);
 
 	group = parent_priv;
-	return mlx5_esw_qos_vport_update_group(vport->dev->priv.eswitch, vport, group, extack);
+	return mlx5_esw_qos_vport_update_group(vport, group, extack);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 0141e9d52037..c4f04c3e6a59 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -6,9 +6,8 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-int mlx5_esw_qos_set_vport_rate(struct mlx5_eswitch *esw, struct mlx5_vport *evport,
-				u32 max_rate, u32 min_rate);
-void mlx5_esw_qos_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
+void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 17f78091ad30..4a187f39daba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -894,7 +894,7 @@ static void esw_vport_cleanup(struct mlx5_eswitch *esw, struct mlx5_vport *vport
 					      vport_num, 1,
 					      MLX5_VPORT_ADMIN_STATE_DOWN);
 
-	mlx5_esw_qos_vport_disable(esw, vport);
+	mlx5_esw_qos_vport_disable(vport);
 	esw_vport_cleanup_acl(esw, vport);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index fec9e843f673..567276900a37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -433,8 +433,7 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_group(struct mlx5_eswitch *esw,
-				    struct mlx5_vport *vport,
+int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
 				    struct mlx5_esw_rate_group *group,
 				    struct netlink_ext_ack *extack);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
@@ -812,7 +811,7 @@ int mlx5_esw_offloads_sf_devlink_port_init(struct mlx5_eswitch *esw, struct mlx5
 void mlx5_esw_offloads_sf_devlink_port_cleanup(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
 
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
-void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport);
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index f24f91d213f2..fd34f43d18d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2617,7 +2617,7 @@ int mlx5_esw_offloads_load_rep(struct mlx5_eswitch *esw, struct mlx5_vport *vpor
 	return err;
 
 load_err:
-	mlx5_esw_offloads_devlink_port_unregister(esw, vport);
+	mlx5_esw_offloads_devlink_port_unregister(vport);
 	return err;
 }
 
@@ -2628,7 +2628,7 @@ void mlx5_esw_offloads_unload_rep(struct mlx5_eswitch *esw, struct mlx5_vport *v
 
 	mlx5_esw_offloads_rep_unload(esw, vport->vport);
 
-	mlx5_esw_offloads_devlink_port_unregister(esw, vport);
+	mlx5_esw_offloads_devlink_port_unregister(vport);
 }
 
 static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
-- 
2.44.0


