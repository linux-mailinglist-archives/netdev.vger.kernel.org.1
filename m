Return-Path: <netdev+bounces-134905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C699B8A3
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F43B210C1
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF6113AA31;
	Sun, 13 Oct 2024 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRe16dWM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25212EBDB
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802017; cv=fail; b=cDM0JBqFNzLqMgrMaOfkkW5BZI3Ov6yIusMdg/xzX6+YSANhgFHYcQKdCiHdzfu9USHegGmIfBp+OAspqxmiULAi6JhGYc4nYV+mACoTp1jy3YWvkVgWjQuy7ahSVstBZ0WaS8V7Vnnk6klvbpEiXgwxwxIUahpRgiIKxnT4s+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802017; c=relaxed/simple;
	bh=rkSSs/oG+6p89mO3aP3EgiRRlbbZ3QR/JhzCL6NGSao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io04fSrcQm+vBTinMlq36ScIjBGW3erKUZ5VDlfplL7frw2jHVvuQRTQnIB5N59vl4RhcXQ7kXBP1F3PVJZdWc6rHdUv/lKWjgAPbkjPxb6tnqBrsR1QqBQLhtT7KP0p5TztzpSOLmkech6mlO2lBORYmyAeAnVDCI9HKFgTqFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRe16dWM; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIBI/8DAUDU4EQhzs/iY/MosMJnZ+h76S70OjFujThLtBpusRSwCajZhgAe0QnHDNbrCub9erLZ8qD9vNqm+cxWqYDVagLskTMuxOudynLUT2pO0DSDo8L8n5opBN0FmpeJS0tIb0yTt6zt6QYFmTy3vsWUEta07V97YeNDEix6X5uP+fML3Z+UMyEasMdCEm7ADfIHYa/+fCx2CEN3xA3++S+lo17o+FGm+cJ0HKBthPN4cfMIh7S3POOYFQ2KUwjH7V5du3h6QtaAJojG2jta2Af3jAmLpiwgm/jm8JoUW1RrcnM0863H7279S5CwB9phHrxKzdVYeI/cf1fzZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e204qgw/qshW1jpAtBHAzHi7pcE/tgNlAC0whY+ulU=;
 b=d4eq9CKggudT+Qgo1L2DCTHPaQ/CgBzUSWU93OPHQbKLb/NUmWsRFV1M0kkE5bkPXfNYM8KA9Dbt3v3lAKVUjaHVCpPMsllIPP8+0feBa2eJ+4Py3iipbtJhHOHDYYo0jFeyajZctkKYDqyMAObTjWcVqq9+UZYDZij5H2ykKCOUHX+b8dla3hmCi5V88n9bkFFsmHAlEOoZ4kcgYfP12dc+MGsO6RTDsooZUsI4TB6xfDRSpr6BF9nEAreAi/y5oQqPVXdMnF5LN7nQOr/rfYKUAL5pNU2y9PrASCfn9/l2JOa4gcA7AbEskbZOVa1qW7pz/Lt0GwPiaYWULZZc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e204qgw/qshW1jpAtBHAzHi7pcE/tgNlAC0whY+ulU=;
 b=HRe16dWM9mMRCjTkAJb1TBMYxraDezjNFrt2sqVdDffy12SK1+d1KhWvMg/TWaAOInpiTsvvnGXGXb99kjDSm1A2JryJUSqLXbVOZhPSlw0NaIHQebtFCt4I9C6lQ6JmFt5PXQEtBg8uI9DC6/C14iilUmBherulSiFhHwnFSfCeese00KR0FRj/i/F1iNc73vIj2Y3rCRhheOUWWAZCi9VNOxUYgADb8V4R3S+ceBTcXdk3e2J2+gDdpNA5iNmsEOxoM5/AeON25QgPr9nfOKxBsHiAFT8xIPL9YnSatov71t1XYdmo3DMDninhZkDjz47TDIJMYNDubi/vLPOydg==
Received: from CH2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:59::21)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Sun, 13 Oct
 2024 06:46:49 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::29) by CH2PR03CA0011.outlook.office365.com
 (2603:10b6:610:59::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/15] net/mlx5: Refactor vport QoS to use scheduling node structure
Date: Sun, 13 Oct 2024 09:45:33 +0300
Message-ID: <20241013064540.170722-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a736fe8-80f0-4d67-36c8-08dceb52d010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2CVzUNaVSDbVoxLjtbrSSyQ2KAyMqs36wfaddeRe7L3bUx0BsztgXJdNjHW?=
 =?us-ascii?Q?90c+24yBzNiCFxkzEtRDqAYGUvbCIpbTaBuwQpeGm48e/YXj6F1t8SO/6Ndo?=
 =?us-ascii?Q?VAY5o+zZRd5wh0OZ+Fec/MI7iL/lnRaivzrcP0cNSw62GdeZdYrv7NE2dRO+?=
 =?us-ascii?Q?xT6jisfoKS08uSvxSIFqtEMsA/QvhKxZ0Qe/768xbQuZWYyUSt7UvEoNyQv5?=
 =?us-ascii?Q?GFpXa7m3w7mo/UKt+zmegYM71RAfnE0Ch+2murqy1hZBA0CsYdJU8iT2epBs?=
 =?us-ascii?Q?DKQMG6pkJ55HpFgJXHkHBbfxvkCTSIA1X9n3Kfzxn8BxGlJERVWJ3B5UFmar?=
 =?us-ascii?Q?trnT/NSI1TWf1UPn7AkReYIymR/H+NNGM9H393Aqvpb8WkrOIIP4qTOaVQlB?=
 =?us-ascii?Q?Rdpk/dRtEkrSNpiAFUK8WKcySv+36rzUKWcwv4ZeTa1fC0zD/HMbFhM9lcKv?=
 =?us-ascii?Q?/yonJi/abdQbUA/eJORT7wJj/LS9pPIEKYBLPf5Nztz70HtaSljc8eoGScrI?=
 =?us-ascii?Q?swsS5Y5SD3GVq6FAJfsXVsimzIkKP7JDa5unH8eUfaQQ6MV20OVNT5NK+kNS?=
 =?us-ascii?Q?SCqxgRxB89IxFDyGjPyy0vQ6hljaCYKUPrOX/Wt36PfYpL0tEip4s1nl/aOa?=
 =?us-ascii?Q?OqrMoeJDNpfEPl7oHFZ0fhuW1Qt/T0U0odBFe33NAgMK40PqoAWafJylpN8r?=
 =?us-ascii?Q?WUj45XuM8e5QdLOl+jk4Z6SfSACeAHD4jS5r0aU1w3DXDA3+AvuiRJjawK/P?=
 =?us-ascii?Q?TJopEygPz/vX3Iz6jSuLFCaiulrRdvYwXxXXEvE4kbqsc49pljnXmKyyPFqg?=
 =?us-ascii?Q?A70cLWXjHvCEwDcb4L0vhB8/42ZlAXgabVQ+Bi72KpVsVfSuBAYp44aKvKNX?=
 =?us-ascii?Q?Ug8Qt4wQZdCymaozKkqGalzGTMu0n8NJLCCpD7LAIreMXNEmQOQN+aJbHJHb?=
 =?us-ascii?Q?9db7l+jIq1U7MnFmFsx3ojmzRXIDhf47J6ePmAjatHq0OXRDTZFfxm+WmR1R?=
 =?us-ascii?Q?GmnvvOXLjDAPooI793AfV3iuMU3dIzFvifVDPhiZrOiV0qZnSfllmXb0YNQR?=
 =?us-ascii?Q?dLt3MqwENwtph4e2sEUE2JBWXTPaWFJ5y3vnF+Fb3aa7q5sIb9sqwbmDiI+v?=
 =?us-ascii?Q?YES4jyB5SMirCXJv7btDGD4IcXJgxXZCqJReyEdSVpF08PYVzhpJV2pHojGq?=
 =?us-ascii?Q?UnKUkqoLQojmDVOJ8TS/ga4ZFrpnz+N/SpYGR91BqHa7T55+h9lGqSrnZ++r?=
 =?us-ascii?Q?WZaCOzc6T81KiucKHk7UKlhfKzr8CIbckAqeMUxxPGt+e97P9XGVOIbOGaAH?=
 =?us-ascii?Q?RNN1MOvGp3Amx5mitVtMj8NcYC3MUqVJXbW9UMHaCL3c8v4H86YdJ3KHfnra?=
 =?us-ascii?Q?jpDBpkLN6+2H9yocZc+KUIhyogfW?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:48.8930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a736fe8-80f0-4d67-36c8-08dceb52d010
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

From: Carolina Jubran <cjubran@nvidia.com>

Refactor the vport QoS structure by moving group membership and
scheduling details into the `mlx5_esw_sched_node` structure.

This change consolidates the vport into the rate hierarchy by unifying
the handling of different types of scheduling element nodes.

In addition, add a direct reference to the mlx5_vport within the
mlx5_esw_sched_node structure, to ensure that the vport is easily
accessible when a scheduling node is associated with a vport.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/esw/diag/qos_tracepoint.h       |   7 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 146 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
 5 files changed, 106 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
index 0b50ef0871f2..43550a416a6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
@@ -9,6 +9,7 @@
 
 #include <linux/tracepoint.h>
 #include "eswitch.h"
+#include "qos.h"
 
 TRACE_EVENT(mlx5_esw_vport_qos_destroy,
 	    TP_PROTO(const struct mlx5_core_dev *dev, const struct mlx5_vport *vport),
@@ -19,7 +20,7 @@ TRACE_EVENT(mlx5_esw_vport_qos_destroy,
 			     ),
 	    TP_fast_assign(__assign_str(devname);
 		    __entry->vport_id = vport->vport;
-		    __entry->sched_elem_ix = vport->qos.esw_sched_elem_ix;
+		    __entry->sched_elem_ix = mlx5_esw_qos_vport_get_sched_elem_ix(vport);
 	    ),
 	    TP_printk("(%s) vport=%hu sched_elem_ix=%u\n",
 		      __get_str(devname), __entry->vport_id, __entry->sched_elem_ix
@@ -39,10 +40,10 @@ DECLARE_EVENT_CLASS(mlx5_esw_vport_qos_template,
 				     ),
 		    TP_fast_assign(__assign_str(devname);
 			    __entry->vport_id = vport->vport;
-			    __entry->sched_elem_ix = vport->qos.esw_sched_elem_ix;
+			    __entry->sched_elem_ix = mlx5_esw_qos_vport_get_sched_elem_ix(vport);
 			    __entry->bw_share = bw_share;
 			    __entry->max_rate = max_rate;
-			    __entry->parent = vport->qos.parent;
+			    __entry->parent = mlx5_esw_qos_vport_get_parent(vport);
 		    ),
 		    TP_printk("(%s) vport=%hu sched_elem_ix=%u bw_share=%u, max_rate=%u parent=%p\n",
 			      __get_str(devname), __entry->vport_id, __entry->sched_elem_ix,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index d2bdf04421b0..571f7c797968 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -63,6 +63,7 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 
 enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
+	SCHED_NODE_TYPE_VPORT,
 };
 
 struct mlx5_esw_sched_node {
@@ -82,13 +83,34 @@ struct mlx5_esw_sched_node {
 	struct mlx5_eswitch *esw;
 	/* The children nodes of this node, empty list for leaf nodes. */
 	struct list_head children;
+	/* Valid only if this node is associated with a vport. */
+	struct mlx5_vport *vport;
 };
 
-static void esw_qos_vport_set_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent)
+static void
+esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
+{
+	list_del_init(&node->entry);
+	node->parent = parent;
+	list_add_tail(&node->entry, &parent->children);
+	node->esw = parent->esw;
+}
+
+u32 mlx5_esw_qos_vport_get_sched_elem_ix(const struct mlx5_vport *vport)
+{
+	if (!vport->qos.sched_node)
+		return 0;
+
+	return vport->qos.sched_node->ix;
+}
+
+struct mlx5_esw_sched_node *
+mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 {
-	list_del_init(&vport->qos.parent_entry);
-	vport->qos.parent = parent;
-	list_add_tail(&vport->qos.parent_entry, &parent->children);
+	if (!vport->qos.sched_node)
+		return 0;
+
+	return vport->qos.sched_node->parent;
 }
 
 static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_ix,
@@ -131,10 +153,11 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share,
 				struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = vport->qos.parent->esw->dev;
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_core_dev *dev = vport_node->parent->esw->dev;
 	int err;
 
-	err = esw_qos_sched_elem_config(dev, vport->qos.esw_sched_elem_ix, max_rate, bw_share);
+	err = esw_qos_sched_elem_config(dev, vport_node->ix, max_rate, bw_share);
 	if (err) {
 		esw_warn(dev,
 			 "E-Switch modify vport scheduling element failed (vport=%d,err=%d)\n",
@@ -151,15 +174,15 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 static u32 esw_qos_calculate_node_min_rate_divider(struct mlx5_esw_sched_node *node)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
-	struct mlx5_vport *vport;
+	struct mlx5_esw_sched_node *vport_node;
 	u32 max_guarantee = 0;
 
 	/* Find max min_rate across all vports in this node.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(vport, &node->children, qos.parent_entry) {
-		if (vport->qos.min_rate > max_guarantee)
-			max_guarantee = vport->qos.min_rate;
+	list_for_each_entry(vport_node, &node->children, entry) {
+		if (vport_node->min_rate > max_guarantee)
+			max_guarantee = vport_node->min_rate;
 	}
 
 	if (max_guarantee)
@@ -213,21 +236,22 @@ static int esw_qos_normalize_node_min_rate(struct mlx5_esw_sched_node *node,
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
 	u32 divider = esw_qos_calculate_node_min_rate_divider(node);
-	struct mlx5_vport *vport;
+	struct mlx5_esw_sched_node *vport_node;
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(vport, &node->children, qos.parent_entry) {
-		bw_share = esw_qos_calc_bw_share(vport->qos.min_rate, divider, fw_max_bw_share);
+	list_for_each_entry(vport_node, &node->children, entry) {
+		bw_share = esw_qos_calc_bw_share(vport_node->min_rate, divider, fw_max_bw_share);
 
-		if (bw_share == vport->qos.bw_share)
+		if (bw_share == vport_node->bw_share)
 			continue;
 
-		err = esw_qos_vport_config(vport, vport->qos.max_rate, bw_share, extack);
+		err = esw_qos_vport_config(vport_node->vport, vport_node->max_rate, bw_share,
+					   extack);
 		if (err)
 			return err;
 
-		vport->qos.bw_share = bw_share;
+		vport_node->bw_share = bw_share;
 	}
 
 	return 0;
@@ -271,6 +295,7 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 				      u32 min_rate, struct netlink_ext_ack *extack)
 {
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	u32 fw_max_bw_share, previous_min_rate;
 	bool min_rate_supported;
@@ -282,14 +307,14 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 				fw_max_bw_share >= MLX5_MIN_BW_SHARE;
 	if (min_rate && !min_rate_supported)
 		return -EOPNOTSUPP;
-	if (min_rate == vport->qos.min_rate)
+	if (min_rate == vport_node->min_rate)
 		return 0;
 
-	previous_min_rate = vport->qos.min_rate;
-	vport->qos.min_rate = min_rate;
-	err = esw_qos_normalize_node_min_rate(vport->qos.parent, extack);
+	previous_min_rate = vport_node->min_rate;
+	vport_node->min_rate = min_rate;
+	err = esw_qos_normalize_node_min_rate(vport_node->parent, extack);
 	if (err)
-		vport->qos.min_rate = previous_min_rate;
+		vport_node->min_rate = previous_min_rate;
 
 	return err;
 }
@@ -297,6 +322,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 				      u32 max_rate, struct netlink_ext_ack *extack)
 {
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	u32 act_max_rate = max_rate;
 	bool max_rate_supported;
@@ -307,17 +333,17 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 
 	if (max_rate && !max_rate_supported)
 		return -EOPNOTSUPP;
-	if (max_rate == vport->qos.max_rate)
+	if (max_rate == vport_node->max_rate)
 		return 0;
 
 	/* Use parent node limit if new max rate is 0. */
 	if (!max_rate)
-		act_max_rate = vport->qos.parent->max_rate;
+		act_max_rate = vport_node->parent->max_rate;
 
-	err = esw_qos_vport_config(vport, act_max_rate, vport->qos.bw_share, extack);
+	err = esw_qos_vport_config(vport, act_max_rate, vport_node->bw_share, extack);
 
 	if (!err)
-		vport->qos.max_rate = max_rate;
+		vport_node->max_rate = max_rate;
 
 	return err;
 }
@@ -354,7 +380,7 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 				     u32 max_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_vport *vport;
+	struct mlx5_esw_sched_node *vport_node;
 	int err;
 
 	if (node->max_rate == max_rate)
@@ -367,11 +393,12 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 	node->max_rate = max_rate;
 
 	/* Any unlimited vports in the node should be set with the value of the node. */
-	list_for_each_entry(vport, &node->children, qos.parent_entry) {
-		if (vport->qos.max_rate)
+	list_for_each_entry(vport_node, &node->children, entry) {
+		if (vport_node->max_rate)
 			continue;
 
-		err = esw_qos_vport_config(vport, max_rate, vport->qos.bw_share, extack);
+		err = esw_qos_vport_config(vport_node->vport, max_rate, vport_node->bw_share,
+					   extack);
 		if (err)
 			NL_SET_ERR_MSG_MOD(extack,
 					   "E-Switch vport implicit rate limit setting failed");
@@ -448,34 +475,37 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 						  struct mlx5_esw_sched_node *new_node,
 						  struct netlink_ext_ack *extack)
 {
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	u32 max_rate;
 	int err;
 
 	err = mlx5_destroy_scheduling_element_cmd(curr_node->esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  vport->qos.esw_sched_elem_ix);
+						  vport_node->ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy vport scheduling element failed");
 		return err;
 	}
 
 	/* Use new node max rate if vport max rate is unlimited. */
-	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_node->max_rate;
-	err = esw_qos_vport_create_sched_element(vport, new_node, max_rate, vport->qos.bw_share,
-						 &vport->qos.esw_sched_elem_ix);
+	max_rate = vport_node->max_rate ? vport_node->max_rate : new_node->max_rate;
+	err = esw_qos_vport_create_sched_element(vport, new_node, max_rate,
+						 vport_node->bw_share,
+						 &vport_node->ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport node set failed.");
 		goto err_sched;
 	}
 
-	esw_qos_vport_set_parent(vport, new_node);
+	esw_qos_node_set_parent(vport->qos.sched_node, new_node);
 
 	return 0;
 
 err_sched:
-	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_node->max_rate;
-	if (esw_qos_vport_create_sched_element(vport, curr_node, max_rate, vport->qos.bw_share,
-					       &vport->qos.esw_sched_elem_ix))
+	max_rate = vport_node->max_rate ? vport_node->max_rate : curr_node->max_rate;
+	if (esw_qos_vport_create_sched_element(vport, curr_node, max_rate,
+					       vport_node->bw_share,
+					       &vport_node->ix))
 		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
 			 vport->vport);
 
@@ -486,12 +516,13 @@ static int esw_qos_vport_update_node(struct mlx5_vport *vport,
 				     struct mlx5_esw_sched_node *node,
 				     struct netlink_ext_ack *extack)
 {
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *new_node, *curr_node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	curr_node = vport->qos.parent;
+	curr_node = vport_node->parent;
 	new_node = node ?: esw->qos.node0;
 	if (curr_node == new_node)
 		return 0;
@@ -501,7 +532,7 @@ static int esw_qos_vport_update_node(struct mlx5_vport *vport,
 		return err;
 
 	/* Recalculate bw share weights of old and new nodes */
-	if (vport->qos.bw_share || new_node->bw_share) {
+	if (vport_node->bw_share || new_node->bw_share) {
 		esw_qos_normalize_node_min_rate(curr_node, extack);
 		esw_qos_normalize_node_min_rate(new_node, extack);
 	}
@@ -707,6 +738,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	u32 sched_elem_ix;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -718,18 +750,26 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
-						 &vport->qos.esw_sched_elem_ix);
+						 &sched_elem_ix);
 	if (err)
 		goto err_out;
 
-	INIT_LIST_HEAD(&vport->qos.parent_entry);
-	esw_qos_vport_set_parent(vport, esw->qos.node0);
+	vport->qos.sched_node = __esw_qos_alloc_rate_node(esw, sched_elem_ix, SCHED_NODE_TYPE_VPORT,
+							  esw->qos.node0);
+	if (!vport->qos.sched_node)
+		goto err_alloc;
 
 	vport->qos.enabled = true;
+	vport->qos.sched_node->vport = vport;
+
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
 
 	return 0;
 
+err_alloc:
+	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
+						SCHEDULING_HIERARCHY_E_SWITCH, sched_elem_ix))
+		esw_warn(esw->dev, "E-Switch destroy vport scheduling element failed.\n");
 err_out:
 	esw_qos_put(esw);
 
@@ -739,6 +779,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_core_dev *dev;
 	int err;
 
@@ -746,20 +787,23 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	esw_qos_lock(esw);
 	if (!vport->qos.enabled)
 		goto unlock;
-	WARN(vport->qos.parent != esw->qos.node0,
+	vport_node = vport->qos.sched_node;
+	WARN(vport_node->parent != esw->qos.node0,
 	     "Disabling QoS on port before detaching it from node");
 
-	dev = vport->qos.parent->esw->dev;
+	trace_mlx5_esw_vport_qos_destroy(dev, vport);
+
+	dev = vport_node->esw->dev;
 	err = mlx5_destroy_scheduling_element_cmd(dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  vport->qos.esw_sched_elem_ix);
+						  vport_node->ix);
 	if (err)
 		esw_warn(dev,
 			 "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 
+	__esw_qos_free_node(vport_node);
 	memset(&vport->qos, 0, sizeof(vport->qos));
-	trace_mlx5_esw_vport_qos_destroy(dev, vport);
 
 	esw_qos_put(esw);
 unlock:
@@ -792,8 +836,8 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	esw_qos_lock(esw);
 	enabled = vport->qos.enabled;
 	if (enabled) {
-		*max_rate = vport->qos.max_rate;
-		*min_rate = vport->qos.min_rate;
+		*max_rate = vport->qos.sched_node->max_rate;
+		*min_rate = vport->qos.sched_node->min_rate;
 	}
 	esw_qos_unlock(esw);
 	return enabled;
@@ -889,16 +933,16 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	esw_qos_lock(esw);
 	if (!vport->qos.enabled) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
-		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.bw_share, NULL);
+		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.sched_node->bw_share, NULL);
 	} else {
-		struct mlx5_core_dev *dev = vport->qos.parent->esw->dev;
+		struct mlx5_core_dev *dev = vport->qos.sched_node->parent->esw->dev;
 
 		MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);
 		bitmask = MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
 		err = mlx5_modify_scheduling_element_cmd(dev,
 							 SCHEDULING_HIERARCHY_E_SWITCH,
 							 ctx,
-							 vport->qos.esw_sched_elem_ix,
+							 vport->qos.sched_node->ix,
 							 bitmask);
 	}
 	esw_qos_unlock(esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index b4045efbaf9e..61a6fdd5c267 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -13,6 +13,9 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
 
+u32 mlx5_esw_qos_vport_get_sched_elem_ix(const struct mlx5_vport *vport);
+struct mlx5_esw_sched_node *mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport);
+
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 2bcd42305f46..09719e9b8611 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1061,6 +1061,7 @@ static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
 	unsigned long i;
 
 	mlx5_esw_for_each_vf_vport(esw, i, vport, esw->esw_funcs.num_vfs) {
+		kfree(vport->qos.sched_node);
 		memset(&vport->qos, 0, sizeof(vport->qos));
 		memset(&vport->info, 0, sizeof(vport->info));
 		vport->info.link_state = MLX5_VPORT_ADMIN_STATE_AUTO;
@@ -1073,6 +1074,7 @@ static void mlx5_eswitch_clear_ec_vf_vports_info(struct mlx5_eswitch *esw)
 	unsigned long i;
 
 	mlx5_esw_for_each_ec_vf_vport(esw, i, vport, esw->esw_funcs.num_ec_vfs) {
+		kfree(vport->qos.sched_node);
 		memset(&vport->qos, 0, sizeof(vport->qos));
 		memset(&vport->info, 0, sizeof(vport->info));
 		vport->info.link_state = MLX5_VPORT_ADMIN_STATE_AUTO;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 38f912f5a707..e77ec82787de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -216,15 +216,8 @@ struct mlx5_vport {
 	struct {
 		/* Initially false, set to true whenever any QoS features are used. */
 		bool enabled;
-		u32 esw_sched_elem_ix;
-		u32 min_rate;
-		u32 max_rate;
-		/* A computed value indicating relative min_rate between vports in a group. */
-		u32 bw_share;
-		/* The parent group of this vport scheduling element. */
-		struct mlx5_esw_sched_node *parent;
-		/* Membership in the parent 'members' list. */
-		struct list_head parent_entry;
+		/* Vport scheduling element node. */
+		struct mlx5_esw_sched_node *sched_node;
 	} qos;
 
 	u16 vport;
-- 
2.44.0


