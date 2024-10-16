Return-Path: <netdev+bounces-136217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250A9A10CF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A669F1C223F9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C22141CB;
	Wed, 16 Oct 2024 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QeTMLdHg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47B212631
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100282; cv=fail; b=NBGIqEiGY6ehLvf3iDJOeUMlvDtxQ2QFDY/DFMd4CRB29v39PZowYnJ033ErJ0SbFwMlfc4Hheyv245t9t0iLkNf26BA2mTHZ54Ro5ClG2cNlRUtVeT94K0DVH7Gq2QJ9xDcBOlal31jskoo24zOsnjVYc1iCEXGLrWOundBa+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100282; c=relaxed/simple;
	bh=cSV71b4sQKtypIo05wIkUh++IxTBkf7PcSxG1vwzHY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iU3/5Qj5bHEFKU924fbLCEWV/ghblA4BKpfA+NN8NuTQfEzpopD+R1rWqoXI8aPX8iY6+O7GTCMTk+9b+GYDlbBZMr5LBbIHHIpirxn8lNL8gkqYhbjok2bdQzZpXFZjDE7vRQDs8PZNNkxbQvx2TK23/v3T9vUgQY++2HfTNX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QeTMLdHg; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDeGx2rzTzJt0j7KOVA/Mp7p2qW6Sfh0mWl79uITrBwIbIgjElygSR1I/X96Vq8a7Mxx/BYIV7QIhYwtLdS9oajM57xS//mjiPmT/+pd0M7/iqqoFIODI9f0Pz6QTESou3jg3GnobENfNOFBWpuhwsf2APd0T19jmSecfXXh/yix+suC4hlIoaXMuXbVzSTQ+0YDbg51gyyPLKL3Jyw9gcIVYtNSAPkQHewvrKZOFphjtFTb//2pjiPGou9NGBLB7wX6XcdQA7skmcZtK1BDKQ14bqFaRsYGRV6DHb6S4NtKNZXayMypoYKTJWJuUbmeTxRp1Hv/MgVIEFAU4A1wXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAPlYHSkGx0aJjcR7Zwk5b0HFSRoqLRDP24jYkE8FMs=;
 b=jMVeKHWVd+NSeKlNamkSPQrr6Wd4pNGJH+zzjmDelBHUEKImItnFpQAaysZYjSzMSiQaQr8Mqf0DneLaasSH9Mij1RR0Cvs52g1SDXIVV1q5eQZtLVAgIAt99XZk57jD66eJYmNX9UxKSDojuRvr21ezHt5XBcw6o7F/2jmY6gDJIu7LxQgJSdpa1OoPOluRfjo0zWVV7Xcr96esd62iO9k56V2eSuIFFkHSEDIpq/FDdfhntnSTuQjedVoFDPyP8QrKioJG3HKqL78/zZgZMyBtSRTC5umoTc03UXVDxV7cO5wlX2GEAEwe6r8mIyRjshV1zCKz9wwq2Nn3gRYrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAPlYHSkGx0aJjcR7Zwk5b0HFSRoqLRDP24jYkE8FMs=;
 b=QeTMLdHgHvFAnmD7P7jOVj/UFfnXQbDmleK5xrPxaq6rmThUpTffuvMR7CWEP1PQulMN2HRtluhZrB7qKfVl0Wll/Avy2L/Lc2MDdmkSTSP0hrAGe6/2vngMCeCmHfEVqznVvnYkdP7k3PPxDd4I7Nupj432bO3r0BtKqN7pnvmIczKTdWBNvm4Guiny0lIOLz/zwyquuQZvQhdZTwBfQWdt+3IWLTNvMnr/Tp+HDHJnF1uZ7q4ZV1WqBHd768MmcDbd2lePqqmzC6hQtMPHWZSntdWJW8wN+wxG7uWyEdtt2uSkYZ6LWSZEW2HEoLJcx9K72v3VW9zF6sPr/D3Cng==
Received: from BL1PR13CA0394.namprd13.prod.outlook.com (2603:10b6:208:2c2::9)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:37:56 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::bf) by BL1PR13CA0394.outlook.office365.com
 (2603:10b6:208:2c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 09/15] net/mlx5: Remove vport QoS enabled flag
Date: Wed, 16 Oct 2024 20:36:11 +0300
Message-ID: <20241016173617.217736-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: e99683b0-7122-477f-ea40-08dcee094532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pLc7SROrYJkjwBSTFlAI8EmCtZgV0SJN0IzlPI7tC89qOUCBWgtb9e8usECi?=
 =?us-ascii?Q?sW+2qKTB2/Uq/EzjXVWG7CHGv2x1XHvoTIAo4TfzyWnWSo3++I2908+mbPa5?=
 =?us-ascii?Q?bZIqNW3m76ICaYWJyzoZ8yR8ojMjXGBO127pxRvlAInBkR47WMULUPUsA6je?=
 =?us-ascii?Q?BUR09uA7PcfcmgDwoCY2x3H8qOjW1acsmcI+3QdyTTfup7vcW/RO4RvWbmEb?=
 =?us-ascii?Q?cNScnlZ3aQg9snSYcx9EJlJiVp2Rf44KGoHGG8CkNFraH77hWKwBlKe2Isof?=
 =?us-ascii?Q?8Z52i16Wj4Mn3EBBTO2pTfIv9IS4Z7OCHBFRa2ouShdl0E0anxq7Zu4IdZ0y?=
 =?us-ascii?Q?WTnfoWwODmBnh6LxgF4tdn9K+qPSRVedmWD/xBLAUqdWzfHY63Px7lFLGnZO?=
 =?us-ascii?Q?/+dtfQf1j+Vpi/KURLVE8o/HaD8OOQhCfDCOyGwq4ZFFaERBw4AROLLUK/8q?=
 =?us-ascii?Q?nLxXHtLSrZ5RUfkMiJ+0YDauTHFRM+tF6rmGbSIU7BLxVOWZBfrd8ZzJ0NGl?=
 =?us-ascii?Q?3ZAodSJfv8C+/WFJYyThlKrVCRzeRiusCXc57tRLjylwFWZHXyfH4YPTc0Fc?=
 =?us-ascii?Q?S+u7X1pi5FMOgwFFQtnptKKLvxcazIgl0bKFucp+054jcfjcZ9CGq8e0yYxO?=
 =?us-ascii?Q?ECI47YOgN70RBP6KyaQFUa/blLy17Fc92o+4MDZH7JU7QF7gt8vZPZY5ZG9D?=
 =?us-ascii?Q?ASgJkV4EHz4tS+3QK3zI4yPZMP+QAX8pO4wk70T3TU6BECrCcWOwHycucv0M?=
 =?us-ascii?Q?zPquselsKOSTSZ+aP3hjfbR5EQKFQ0aAcRVgg/ku1tjUQ3MtHXsCIunMHXBI?=
 =?us-ascii?Q?lMPqrFYSr+0WL2EYyetxq0KHQuTqPW8S2YKsnBijnqCnaXZlec4L3YH2OoYQ?=
 =?us-ascii?Q?UjJeLNFuqNVnzUc1VOhkbzi5w51QwLej1lgS506cdLTAJvu8LU3xAJotyLa8?=
 =?us-ascii?Q?OAVx9to8ETt/d28K/LvvBspcpuIWzwCluhcYQQrI1x9Mz+aG//HR9f5FErKA?=
 =?us-ascii?Q?N4tHarK5dq0qdQIdogjOk/ZbocBSNxf/8m66tSfZuuwNGrD8iPQztIX6gY9B?=
 =?us-ascii?Q?BmbdSshGkI7h0y3kyDgd9F0V7oXxQLh7+8nEwW19vT82qbGf+CNmc+Z1ZfnQ?=
 =?us-ascii?Q?1jzGpZq7WPoGlB6yCXPRgMe9nUeVz/AAKE4qXAdQ7TLmRSnjVOR5vCMNRzUJ?=
 =?us-ascii?Q?RM6qj9/Yjksz2aKlEYEdoRh7HjJuWeREPX+FuV7RKxq30Hc8trKyQpH5Ouiz?=
 =?us-ascii?Q?pvtahwWCzvGmvQOiq2+0cm5bAX8PgJspq/DDnetL4q8FMvO/tPl8C3cwCFNa?=
 =?us-ascii?Q?G//3ZcS3pCKliuJ48kL+rzuzAB/PRYPYpP/TxYs2Vetyhh8GLbDpRcruCUBk?=
 =?us-ascii?Q?5oViCN79HDOeMo/yOyIeXu8vruop?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:56.0817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99683b0-7122-477f-ea40-08dcee094532
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367

From: Carolina Jubran <cjubran@nvidia.com>

Remove the `enabled` flag from the `vport->qos` struct, as QoS now
relies solely on the `sched_node` pointer to determine whether QoS
features are in use.

Currently, the vport `qos` struct consists only of the `sched_node`,
introducing an unnecessary two-level reference. However, the qos struct
is retained as it will be extended in future patches to support new QoS
features.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 ++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 --
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 2d10453afc8a..77e835fd099d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -742,7 +742,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	if (vport->qos.enabled)
+	if (vport->qos.sched_node)
 		return 0;
 
 	err = esw_qos_get(esw, extack);
@@ -761,7 +761,6 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		goto err_alloc;
 	}
 
-	vport->qos.enabled = true;
 	vport->qos.sched_node->vport = vport;
 
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
@@ -787,9 +786,9 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 
 	lockdep_assert_held(&esw->state_lock);
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled)
-		goto unlock;
 	vport_node = vport->qos.sched_node;
+	if (!vport_node)
+		goto unlock;
 	WARN(vport_node->parent != esw->qos.node0,
 	     "Disabling QoS on port before detaching it from node");
 
@@ -836,7 +835,7 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	bool enabled;
 
 	esw_qos_lock(esw);
-	enabled = vport->qos.enabled;
+	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
@@ -933,7 +932,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled) {
+	if (!vport->qos.sched_node) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
 		err = esw_qos_vport_enable(vport, rate_mbps, 0, NULL);
 	} else {
@@ -1142,7 +1141,7 @@ int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled && !node)
+	if (!vport->qos.sched_node && !node)
 		goto unlock;
 
 	err = esw_qos_vport_enable(vport, 0, 0, extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e77ec82787de..14dd42d44e6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -214,8 +214,6 @@ struct mlx5_vport {
 
 	/* Protected with the E-Switch qos domain lock. */
 	struct {
-		/* Initially false, set to true whenever any QoS features are used. */
-		bool enabled;
 		/* Vport scheduling element node. */
 		struct mlx5_esw_sched_node *sched_node;
 	} qos;
-- 
2.44.0


