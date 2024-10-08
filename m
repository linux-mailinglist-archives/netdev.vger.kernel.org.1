Return-Path: <netdev+bounces-133272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071339956AB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB881C247FA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBDD212D2C;
	Tue,  8 Oct 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bq6PQoI6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252D212D0E
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412440; cv=fail; b=sSnlO/DXcyCm42avTKfUj36+jjQDZ5I38yLNOrPn57euWBzXX7lXWJWbJQhv36ieZikVhrFVhI2sYB0dvD9+R0UN2RIuECXZeKuxNcu+Z6zq1M4WaPPceLn3JlhsJ1NCBdBXBiEGoQpkRvRJsOfsDEizKyut9ci4SkeHZhxObiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412440; c=relaxed/simple;
	bh=bp0gg4Bzq03AS4brawSAXuTXC0E/6RiGHxvmPnqSUF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d81DTZOwpY3WNIPhDmhxoNfXWkXJ7fgMHAPR6InKiYFTLJED6SqNuFHfsA3VzIa5KQCT55HvoaCYlX2EiTLTf5Pd51XOUxw0GfeCBjAAcMRnNbYlycrxD/pduzGKG6dqsVWqq1+XXKh4db1597+Wh0ldO87PY0cRxqCLBPhkbkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bq6PQoI6; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqaDUd3ORIPywdXcgrberHiNctHxlBJA6lrxJ1DK3NcxJyIdDGSZ1/4Yosdh1RyXpdyqWoq4/8Iml5ce7u6UMSHqM4ttOFNbMO4V47P77TuimfXEh7ZRqn7kic5BEzbFdyk88V3pnZbDqx8Ae1lGxm8OW6hdGMd38olaDoJZ+nqDvkR36QC+SZfpIryFjE4Wt2Ta/0xfGxPRGBt//iX5GAnpK7ORsq0S3Oe7lvkV4v1la+uXpbAPw+EJLqecU6pU1zFs4yAvZONCEcPJ7rZQynycwUGGyPp0trUVxvXpO5OXBajG/qMI49Eoc7qE3ZuVCZj8AtKKQ7Xrq9Y+xubxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg/zUas8Z7Gkmit8xaAEY4bPvTzTLWQF/W/ttWDpJHg=;
 b=oFQ0FQtgry87U/sVh32yLa3huBBfqSwBuLiwo73cmJfDd5pyKcVAm10bbEuCmsrW+gorp1U96ZVztiELER+u+8DOl+wb9CniYMGZnysJTC49on/DpunY0SoMgk4nGYMwnOAzq7rGg69vF/5zjiFr2c0eeilJn7Gn0N+u9D5GQxd1IjMPWFRVnkAijgY904nZSDjyN1lX4K8u3l/99iowSo8sD+nImX62Hk612aZ+PRLJj6mLnypIe6k0ZzsWiN4MPcEIFZzGOf3B7dcyKveZD9s+UDDVG16qgX8qrq3540usAXeqd0VYtwyLOtnqahGQXUXT/AF4emjdkR9tbgcqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg/zUas8Z7Gkmit8xaAEY4bPvTzTLWQF/W/ttWDpJHg=;
 b=Bq6PQoI6jxeIeaH3Zyw0t+DvkMKhl+eyXSpEBiWiqhyzhAfymRCVNnrYXbfZl6bCtK7gdbQX+xvB0sYISKOlgfuygTT82VZcPilM1fWWCWSEKF4rvAAmPnGwD+2Y5iTDQ6PFEvsdZyso/PfdReC/PE6gQuuO0uZQXWwZ2xsMYDkyDlppO27Q8Bhrs6kPiscvtPNCu8xZ3IHWfXflCMAmQXBCrB2WmyeQOrt8y1+sXGIt/SP97AqkUrZanmSkHC7qjtHC27IkDnNQdDq0q6TnG7bFJ5Qk0eEFuqW/IaylYLqz1gQ+bnU1yOovVtgCKbbzKiHF/HHqH4AZtJeDWZGvIw==
Received: from CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::29)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 18:33:54 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::8d) by CH5P222CA0018.outlook.office365.com
 (2603:10b6:610:1ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 13/14] net/mlx5: Unify QoS element type checks across NIC and E-Switch
Date: Tue, 8 Oct 2024 21:32:21 +0300
Message-ID: <20241008183222.137702-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2a494e-c216-4f79-e81a-08dce7c7c364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAd7WYuBs78WCuNWjzxRyIqc+saI/viL9Gb4MXi9m4zgZEmxwCf//bd+U74q?=
 =?us-ascii?Q?lm8FuRn+EeiLbzeLrDQnw/We+cDfHdcmmc7+wbumPeXq1VB7D9jED5JvAKo/?=
 =?us-ascii?Q?l6q3q35ko5dumm1aJhTosuH2x+nQgP23nno8EKNCD9JPIk8q3UqiMb7121pY?=
 =?us-ascii?Q?SozbZfvATuOhIRyBWGCBvvE0p447gPjqodVLN8W0duMWjDtAGuhdKM6Lfp+7?=
 =?us-ascii?Q?ifW+RX5RO1RH0KUZSgx96ibcNNSNs563B5e+wHyRpjKv4Src1GlfErf9kGct?=
 =?us-ascii?Q?K4WlcdwBCQD83VBVbv/Q+R9Elau4s+Y67+SX+Kv2qT8zDh9Q7bkX+/phcapH?=
 =?us-ascii?Q?9zorr7cC8DBroieBrzoDcdK6jHfpZVTEi858Iw+jkbe9DNYCIEFgq++lwOz/?=
 =?us-ascii?Q?4LJMDTUSCQTza6o6nbc4Py+9SYx4RGJPjqu+ljRyWZ1LSHtrObJ2oTNkkHpy?=
 =?us-ascii?Q?B+v4JBoRyyTnsGiXN9MK/zmVYjdzVPD+zT85tu4rSW2e4/ZHfP8Fn6QEFpHc?=
 =?us-ascii?Q?Hivb+t18YTo+c8kfQwiCWPx8wPP8ta0gEhTgEsISqQOmt5QU6lI0waPZTCfk?=
 =?us-ascii?Q?B+bd39eQ7Kdn6Xc/MvwSPAN6U/kqzfgkHifm2e4izeM42MtTbmwmmJ19qiiz?=
 =?us-ascii?Q?VHUdFZ1KGoJLvrzR1okGd5ZQAc7+o2Vfm1ShevMPdm8z1S5mzophEYoRnoXM?=
 =?us-ascii?Q?U0ZTcbZOGnm1tWASpj5I5cFcgW/t3DAr5qizkhCAyjm5GZd9Jni4VDvZk1sp?=
 =?us-ascii?Q?7T6M+Zs6uR9Q5HETKscNwFNkt9uKTS1o0zRXH7uAnQSqeGETRRoGtELm3OTQ?=
 =?us-ascii?Q?ofKBovvkgs7XuEVyBIXFyTOclXeGOWaveWmfMAaakyiAMDGdI5e8TrUvPOS4?=
 =?us-ascii?Q?6J1JU6/okeLqxTiXeWf/vDF5VgmhHXRph2Ue1affoV+V1+lVKR9thUZWgY8A?=
 =?us-ascii?Q?NvlYVD2NxR/Nox8GFdZg4IR537TB9sxqfi9BOmK1jPcDVOpkLIrFuBTW9x/D?=
 =?us-ascii?Q?ohdXS3zF/DPpZz3uPCoZ67gXkbm8xJ4mjQcWFRSL/bwG5hB0JEQV73cQrm1b?=
 =?us-ascii?Q?xKoNytN1Gcl9L5OGDj9jUnAWZA1O3rR+c1UKGh6c3wZbBsrflbN97tqv1Cwq?=
 =?us-ascii?Q?Ep3aCguBE9mUBnu21GIk7+pzRNyGYMaRX5DellfudmfCEMbKFy6mmudXktm8?=
 =?us-ascii?Q?CJUlhmxd9P/bmBJoTTM8M2OWdsHuO4XaRjxQ73DXONNUBUTcHhwfSWnqhe33?=
 =?us-ascii?Q?qc0X06wX46iHGoxZzM4vBrBc30sSowkonTrHxJ5G8AEvZrz62nSud63hxyVd?=
 =?us-ascii?Q?ayXdim3Y/bCOrUk2kHRjr3XNb08lQz360+D9/xIcgUwoDdrvV4FhhzOsHKO9?=
 =?us-ascii?Q?IGnlTc3kosEwD231N4WIFy0xq0Gt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:54.1039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2a494e-c216-4f79-e81a-08dce7c7c364
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555

From: Carolina Jubran <cjubran@nvidia.com>

Refactor the QoS element type support check by introducing a new
function, mlx5_qos_element_type_supported(), which handles element type
validation for both NIC and E-Switch schedulers.

This change removes the redundant esw_qos_element_type_supported()
function and unifies the element type checks into a single
implementation.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 27 ++++------------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/qos.c |  8 +++--
 drivers/net/ethernet/mellanox/mlx5/core/rl.c  | 31 +++++++++++++++++++
 4 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index be9abeb6e4aa..ea68d86ea6ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -371,25 +371,6 @@ static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
 	return err;
 }
 
-static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
-{
-	switch (type) {
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_TSAR;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_VPORT;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_VPORT_TC;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
-	}
-	return false;
-}
-
 static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
 {
@@ -399,7 +380,9 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 	void *attr;
 	int err;
 
-	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT))
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT,
+					     SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
@@ -616,7 +599,9 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR) ||
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_E_SWITCH) ||
 	    !(MLX5_CAP_QOS(dev, esw_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 62c770b0eaa8..5bb62051adc2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -224,6 +224,7 @@ void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change);
 int mlx5_core_sriov_set_msix_vec_count(struct pci_dev *vf, int msix_vec_count);
 int mlx5_core_enable_hca(struct mlx5_core_dev *dev, u16 func_id);
 int mlx5_core_disable_hca(struct mlx5_core_dev *dev, u16 func_id);
+bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hierarchy);
 int mlx5_create_scheduling_element_cmd(struct mlx5_core_dev *dev, u8 hierarchy,
 				       void *context, u32 *element_id);
 int mlx5_modify_scheduling_element_cmd(struct mlx5_core_dev *dev, u8 hierarchy,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
index db2bd3ad63ba..4d353da3eb7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
@@ -28,7 +28,9 @@ int mlx5_qos_create_leaf_node(struct mlx5_core_dev *mdev, u32 parent_id,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {0};
 
-	if (!(MLX5_CAP_QOS(mdev, nic_element_type) & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP))
+	if (!mlx5_qos_element_type_supported(mdev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP,
+					     SCHEDULING_HIERARCHY_NIC))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_id);
@@ -47,7 +49,9 @@ int mlx5_qos_create_inner_node(struct mlx5_core_dev *mdev, u32 parent_id,
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {0};
 	void *attr;
 
-	if (!(MLX5_CAP_QOS(mdev, nic_element_type) & ELEMENT_TYPE_CAP_MASK_TSAR) ||
+	if (!mlx5_qos_element_type_supported(mdev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_NIC) ||
 	    !(MLX5_CAP_QOS(mdev, nic_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
index 9f8b4005f4bd..efadd575fb35 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
@@ -34,6 +34,37 @@
 #include <linux/mlx5/driver.h>
 #include "mlx5_core.h"
 
+bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hierarchy)
+{
+	int cap;
+
+	switch (hierarchy) {
+	case SCHEDULING_HIERARCHY_E_SWITCH:
+		cap = MLX5_CAP_QOS(dev, esw_element_type);
+		break;
+	case SCHEDULING_HIERARCHY_NIC:
+		cap = MLX5_CAP_QOS(dev, nic_element_type);
+		break;
+	default:
+		return false;
+	}
+
+	switch (type) {
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
+		return cap & ELEMENT_TYPE_CAP_MASK_TSAR;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
+		return cap & ELEMENT_TYPE_CAP_MASK_VPORT;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC:
+		return cap & ELEMENT_TYPE_CAP_MASK_VPORT_TC;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC:
+		return cap & ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP:
+		return cap & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP;
+	}
+
+	return false;
+}
+
 /* Scheduling element fw management */
 int mlx5_create_scheduling_element_cmd(struct mlx5_core_dev *dev, u8 hierarchy,
 				       void *ctx, u32 *element_id)
-- 
2.44.0


