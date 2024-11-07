Return-Path: <netdev+bounces-143036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B5D9C0F39
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBB81F2483C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A4196D9A;
	Thu,  7 Nov 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyQKAx8Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5B217F4A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008740; cv=fail; b=STSrV8ynP9f1pmWlGWe3EO2GtScUySWr5aiQcYPd9I1tYG6CwpZQMciN17cQW9oE3yYJ7WA1jUTZ+thE09htKKLXoRPUv6XtF8NdWsEb3Kx/hcpbUjQrBc7UtpNeT4vMBsDi0vxMtx9B2n8vTKcuHC8aIFZDsjveiCGJmdRKuHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008740; c=relaxed/simple;
	bh=ZFyJyB6HM007UNUkfKlg7ZwJYr1YTEfuCebEDi/2fjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJg35NsZ3wHXGrJbkU+wiSacbpOZtK3/oj7TSL8G8RWCFb/lDdGDgUUP9r2ovKiJN15Le84i94Rs37k2Y2AaHcFBNMsIa28jklGf4OpDpqgo+BJrS01l/cVkhrva/vlttDarbAxx25+15fF5sKuU44S/we5113Jk4tdsA6lgVwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TyQKAx8Q; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWNRHgBiMujhBFNucPcXc3nL7dig1H2eqje4mZHTkUifVNLTgCGlY74iMl/lM3OkF5qYdaJ5h1uOkMvifOEjvfkfibnJkm+PAePEOB68QqWyjTpfNMO2QNhOP+vgUU09BecLOO9v/vtYC5Y+zQMqp8ELcIVjom6Ma8elspA3xi6JrCaGErS/9bskbyB7UqaENAma60CYZ+25blK920x1E4mrM6agUHA3ThxMpp+VmGMm0RgzTwlFVGbtQt8Irp5697xY3PSCvrbP2PXgxim+wpc6lZYb39w6otKafXVerROtJMJSHyrsqm9l4ASfjcK/6wWMuFIPvXneGU3bior51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFqiu2CMiX+4YaWrnLZzCFxo99Kj6pDqPr5I981o0Ms=;
 b=nDv4c/L6eZTb5QIFdGJjZh4FceBctiOqahUIWx/Y2/JYGXh3oSntlk4fFUbnBLsMcGDfQ6Y1U3rDyYPi9ln/EGiVDGqLj5htsevoB+Ola19Yknanon7jw6GkQNDZfrK6TL4bNB7YLk7i4K24FR80l8+LZmQPajuWCS9TRMyTm824Xrh4hV02OWQVgfMo8O7VJFp4MmtFTsYB8FIAcTo2UC+Raarnj6YPGiA25j/urANrgN5ukGfqZgtou3X6UPSFR+BwmtaqmSAhKSdObXQWxL5B/DOH0qKzSWkzwn9ercFqy0zATHPHMzqjUko1tJg4qUrzOwtXx5mDtE+L2lXy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFqiu2CMiX+4YaWrnLZzCFxo99Kj6pDqPr5I981o0Ms=;
 b=TyQKAx8QnjA0Inckd/PIifArhFV6/cV3NtHFf60TzqjHZcTT25SNJigkY63YJdzy+2lWazTBqG1DbEOGDcbMoNV2WsQiXdOzOrUuz+uA3jmEVtxmB+w3y3hfALwuVZ835FRC+Y/dlrIaSex7P/9HFhRKDhWEMMdv4YU1ZLjZa51zOTmsagqzR7b20ESQfAPZ4lgJnl8KLKB6mMQ/59/g7QMzzgj+xv4I0tdHZAcyqJfl2qw7DPRtpkMI5anC0JxZwDxlM+IFAdZ5h1WN2GsBOREKPRirX7mAy89W6jhDMOX7PGUNnGGoAJ7ao8y3v4rxuonGML6bmpIwtv2IQv/0SA==
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.26; Thu, 7 Nov 2024 19:45:33 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::92) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:11 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:11 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:08 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 05/12] net/mlx5: Generalize scheduling element operations
Date: Thu, 7 Nov 2024 21:43:50 +0200
Message-ID: <20241107194357.683732-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5cd9e8-6aff-4feb-f281-08dcff64be26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiDYQLo/JsbYhMzXGFgrrvqdSAZB/opk4WuUhFwV0eZptbBOsNVQ0o1NSg/K?=
 =?us-ascii?Q?kldVvOS60axfkWEcbxYdrrZA6q4fspIp/kB9Gh9EVasU0XAVW8vqHSJ8mcRV?=
 =?us-ascii?Q?3gum/4BMIneUZD9gxSHQMh2jf1fU35v7A6ATjf/hgfMPHcTmNRyrBn3DESK+?=
 =?us-ascii?Q?E56MmXn4VjUzH/9uFt1Wit/8pDZSGI8v7MQe4GED16xq0yifPnNEf36of3wj?=
 =?us-ascii?Q?9ijoep0pWlEb1bHcnj5kYA+hvIN48sIHEXfy5V97ufHkL3m+9bfxFtcpsJUR?=
 =?us-ascii?Q?9WD4XufsETJT95MzymITSLHwbMBJqyOPrJHnqDPliSQ/NUNbmCDdHFoAl4LX?=
 =?us-ascii?Q?iI/XdngFWSwX4qquXGWmRRjeoDy2oak+CoeAYiZzNVJ0eG8SmmLq9FPlrCKE?=
 =?us-ascii?Q?G5Mj5+1mjIjvf2lgc9wFNbh/bWQKdLsfm5a15jcwP+35QC++kkpEd8JhslI3?=
 =?us-ascii?Q?uKi4AcaI7RxybXKRjY0YZOtmV2tshB+gZSL04pjVRL4myiGvh+Q866/mQh6A?=
 =?us-ascii?Q?vP2EzEhaFFM+Rdjw4c0VoyKGowcXL+KAsQCT+wOqMoo125TsE9yW9ENCwS25?=
 =?us-ascii?Q?2LMVQFmZUvxbkatG03bKpZ5O8y96pf/lGKVyE90oUFnhPtNpqnHHc2UitqhJ?=
 =?us-ascii?Q?GjJKhxJe2FBxYHwNLdaD8Ja+EiXG0Dq700qsv+uFD037PW1OOFSFPZUCRxAZ?=
 =?us-ascii?Q?28d0QwwZLkDGW/PwVrSFB0yF04IxZKkag2fR58NriwklERRZOauv6FezPCrL?=
 =?us-ascii?Q?xt/kL7csGaZRqkDhEultvkf/gREjzDLIvGZLmpGK7ZWPwZVPurJ9apV4bRqt?=
 =?us-ascii?Q?v2sVuk5Z7WhXnDgKEU1YNotjamXop+SsGhQHDfkn0DJIar/XXiobuaSu8Gdx?=
 =?us-ascii?Q?Ype6+TKWVBaa8zw4BEhorYgelur1eYeufEHIdhIQdxn6D2TXgPcPkPPu9RwO?=
 =?us-ascii?Q?9TzRBjW+uviGBuqUJ3a/te1auBdRMtVBhTtw2UTV6jeIXY0S45PYSoOixKCm?=
 =?us-ascii?Q?U0RfGAfmgUC57pUBjzvdFjnaBEuDrJ6J+DDpQknSYj4jm/v1+fOvgKCemTgZ?=
 =?us-ascii?Q?KN6+nq5xbPRFOlGiHT9v+wVNJiFPrboXh28RpZXZKx5cpk5hGCU0039M19+E?=
 =?us-ascii?Q?Yr0c/yPfJCsQtTCDPSv5yw2oqgTrS3Wa4tHjPE1pLtml+0HHbPYxuZlkiQac?=
 =?us-ascii?Q?eH19j4llTY8krxhz1Iyx6irVlcNF6VD9E4g3v6eNGprSfWkbm1Gx8eFyibIQ?=
 =?us-ascii?Q?QxBh9hbA4bkHOzsosh92SqoJblkOjEufdD0ty6CPdNQjWm1PzSRLAFK53P2u?=
 =?us-ascii?Q?L7C9xSWdzAWJMb2QUjbcMFF1d8y3Jpgk62PEpK2ugyW5PhQKbanDuNv0o7KK?=
 =?us-ascii?Q?kwdhRPsmuG91xBmO98ZXClOhe3b2hDpAIMjkdaNpv+cjePtTEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:32.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5cd9e8-6aff-4feb-f281-08dcff64be26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

From: Carolina Jubran <cjubran@nvidia.com>

Introduce helper functions to create and destroy scheduling elements,
allowing flexible configuration for different scheduling element types.

The new helper functions streamline the process by centralizing error
handling and logging through esw_qos_sched_elem_op_warn, which now
accepts the operation type (create, destroy, or modify).

The changes also adjust the esw_qos_vport_enable and
mlx5_esw_qos_vport_disable functions to leverage the new generalized
create/destroy helpers.

The destroy functions now log errors with esw_warn without returning
them. This prevents unnecessary error handling since the node was
already destroyed and no further action is required from callers.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 157 +++++++++---------
 1 file changed, 76 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index c1e7b2425ebe..155400d36a1e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -118,18 +118,49 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 	return vport->qos.sched_node->parent;
 }
 
-static void esw_qos_sched_elem_config_warn(struct mlx5_esw_sched_node *node, int err)
+static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	if (node->vport) {
 		esw_warn(node->esw->dev,
-			 "E-Switch modify %s scheduling element failed (vport=%d,err=%d)\n",
-			 sched_node_type_str[node->type], node->vport->vport, err);
+			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->vport->vport, err);
 		return;
 	}
 
 	esw_warn(node->esw->dev,
-		 "E-Switch modify %s scheduling element failed (err=%d)\n",
-		 sched_node_type_str[node->type], err);
+		 "E-Switch %s %s scheduling element failed (err=%d)\n",
+		 op, sched_node_type_str[node->type], err);
+}
+
+static int esw_qos_node_create_sched_element(struct mlx5_esw_sched_node *node, void *ctx,
+					     struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = mlx5_create_scheduling_element_cmd(node->esw->dev, SCHEDULING_HIERARCHY_E_SWITCH, ctx,
+						 &node->ix);
+	if (err) {
+		esw_qos_sched_elem_warn(node, err, "create");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch create scheduling element failed");
+	}
+
+	return err;
+}
+
+static int esw_qos_node_destroy_sched_element(struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = mlx5_destroy_scheduling_element_cmd(node->esw->dev,
+						  SCHEDULING_HIERARCHY_E_SWITCH,
+						  node->ix);
+	if (err) {
+		esw_qos_sched_elem_warn(node, err, "destroy");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroying scheduling element failed.");
+	}
+
+	return err;
 }
 
 static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_rate, u32 bw_share,
@@ -165,7 +196,7 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 						 node->ix,
 						 bitmask);
 	if (err) {
-		esw_qos_sched_elem_config_warn(node, err);
+		esw_qos_sched_elem_warn(node, err, "modify");
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify scheduling element failed");
 
 		return err;
@@ -295,14 +326,12 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 						  tsar_ix);
 }
 
-static int
-esw_qos_vport_create_sched_element(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				   u32 max_rate, u32 bw_share, u32 *sched_elem_ix)
+static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node, u32 bw_share,
+					      struct netlink_ext_ack *extack)
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
-	struct mlx5_core_dev *dev = parent->esw->dev;
+	struct mlx5_core_dev *dev = vport_node->esw->dev;
 	void *attr;
-	int err;
 
 	if (!mlx5_qos_element_type_supported(dev,
 					     SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT,
@@ -312,23 +341,12 @@ esw_qos_vport_create_sched_element(struct mlx5_vport *vport, struct mlx5_esw_sch
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
-	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
+	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, vport_node->max_rate);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
 
-	err = mlx5_create_scheduling_element_cmd(dev,
-						 SCHEDULING_HIERARCHY_E_SWITCH,
-						 sched_ctx,
-						 sched_elem_ix);
-	if (err) {
-		esw_warn(dev,
-			 "E-Switch create vport scheduling element failed (vport=%d,err=%d)\n",
-			 vport->vport, err);
-		return err;
-	}
-
-	return 0;
+	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
 
 static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
@@ -339,30 +357,22 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	int err;
 
-	err = mlx5_destroy_scheduling_element_cmd(curr_node->esw->dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  vport_node->ix);
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy vport scheduling element failed");
+	err = esw_qos_node_destroy_sched_element(vport_node, extack);
+	if (err)
 		return err;
-	}
 
-	err = esw_qos_vport_create_sched_element(vport, new_node, vport_node->max_rate,
-						 vport_node->bw_share,
-						 &vport_node->ix);
+	esw_qos_node_set_parent(vport_node, new_node);
+	err = esw_qos_vport_create_sched_element(vport_node, vport_node->bw_share, extack);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport node set failed.");
 		goto err_sched;
 	}
 
-	esw_qos_node_set_parent(vport->qos.sched_node, new_node);
-
 	return 0;
 
 err_sched:
-	if (esw_qos_vport_create_sched_element(vport, curr_node, vport_node->max_rate,
-					       vport_node->bw_share,
-					       &vport_node->ix))
+	esw_qos_node_set_parent(vport_node, curr_node);
+	if (esw_qos_vport_create_sched_element(vport_node, vport_node->bw_share, NULL))
 		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
 			 vport->vport);
 
@@ -425,6 +435,12 @@ static void __esw_qos_free_node(struct mlx5_esw_sched_node *node)
 	kfree(node);
 }
 
+static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlink_ext_ack *extack)
+{
+	esw_qos_node_destroy_sched_element(node, extack);
+	__esw_qos_free_node(node);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
@@ -483,23 +499,13 @@ esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	return node;
 }
 
-static int __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlink_ext_ack *extack)
+static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = node->esw;
-	int err;
 
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
-
-	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  node->ix);
-	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR_ID failed");
-	__esw_qos_free_node(node);
-
+	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
-
-	return err;
 }
 
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
@@ -584,11 +590,11 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
-static int esw_qos_vport_enable(struct mlx5_vport *vport,
-				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
+static int esw_qos_vport_enable(struct mlx5_vport *vport, u32 max_rate, u32 bw_share,
+				struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	u32 sched_elem_ix;
+	struct mlx5_esw_sched_node *sched_node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -599,29 +605,28 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
-						 &sched_elem_ix);
-	if (err)
-		goto err_out;
-
-	vport->qos.sched_node = __esw_qos_alloc_node(esw, sched_elem_ix, SCHED_NODE_TYPE_VPORT,
-						     esw->qos.node0);
-	if (!vport->qos.sched_node) {
+	sched_node = __esw_qos_alloc_node(esw, 0, SCHED_NODE_TYPE_VPORT, esw->qos.node0);
+	if (!sched_node) {
 		err = -ENOMEM;
 		goto err_alloc;
 	}
 
-	vport->qos.sched_node->vport = vport;
+	sched_node->max_rate = max_rate;
+	sched_node->min_rate = 0;
+	sched_node->bw_share = bw_share;
+	sched_node->vport = vport;
+	err = esw_qos_vport_create_sched_element(sched_node, 0, extack);
+	if (err)
+		goto err_vport_create;
 
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
+	vport->qos.sched_node = sched_node;
 
 	return 0;
 
+err_vport_create:
+	__esw_qos_free_node(sched_node);
 err_alloc:
-	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
-						SCHEDULING_HIERARCHY_E_SWITCH, sched_elem_ix))
-		esw_warn(esw->dev, "E-Switch destroy vport scheduling element failed.\n");
-err_out:
 	esw_qos_put(esw);
 
 	return err;
@@ -632,7 +637,6 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_core_dev *dev;
-	int err;
 
 	lockdep_assert_held(&esw->state_lock);
 	esw_qos_lock(esw);
@@ -645,15 +649,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	dev = vport_node->esw->dev;
 	trace_mlx5_esw_vport_qos_destroy(dev, vport);
 
-	err = mlx5_destroy_scheduling_element_cmd(dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  vport_node->ix);
-	if (err)
-		esw_warn(dev,
-			 "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
-			 vport->vport, err);
-
-	__esw_qos_free_node(vport_node);
+	esw_qos_destroy_node(vport_node, NULL);
 	memset(&vport->qos, 0, sizeof(vport->qos));
 
 	esw_qos_put(esw);
@@ -974,13 +970,12 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 {
 	struct mlx5_esw_sched_node *node = priv;
 	struct mlx5_eswitch *esw = node->esw;
-	int err;
 
 	esw_qos_lock(esw);
-	err = __esw_qos_destroy_node(node, extack);
+	__esw_qos_destroy_node(node, extack);
 	esw_qos_put(esw);
 	esw_qos_unlock(esw);
-	return err;
+	return 0;
 }
 
 int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
-- 
2.44.0


