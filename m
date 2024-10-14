Return-Path: <netdev+bounces-135328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E599D89C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B4CB21CB3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EAF1D1726;
	Mon, 14 Oct 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBBIXq41"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741031D0BA4
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939286; cv=fail; b=s9QF0GlCLFP53UXcHEznRTIGSySRKkbtWbYMyrPrvwOf4v6Jl8bh5EQa8GKIs9hq2BCuNqr8qlR5yeaNMGwOxckJw4GWcSpXOEXlPiBOlr5HCnn/2KNE93RlF+anVtS2G78kUx2V6+OdFF+wEBdMqwIaPlEUslSl9lpN3vUTfrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939286; c=relaxed/simple;
	bh=iO3n3eCf0wXnvJTRXjp8+S6dm6NSXTEj+bIzWNI6QGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwlcSwfM5UaRr9dSLLLX8edXSetjTl7fTH5AlpHrAzCBqgm3nWMJYfhh3Dn7tVcj/v3fl7Larcnj1EDPlR1prmE5weCzhb3DntBeKzMmU2mfBK8+6KqpIiB7Jr0KaVoM3EdusX4nQ0axOJxEFBCqagrpSWQOlrgOq3eFUwot80E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBBIXq41; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tq3gzoNy6j1tjLMxBDqGRUWJLn3IrZ4aJ094EumFTRI2MAHPjKBmTbsFTICYB6nhOe528/K1YecSiBx4q5ZLX2L1dGq6zPWCjBaGdYcJnKfcde/1VKb990O9baeQ1ryhe4fB1utwUQx527OZ8qcTRuh2qkHFFuLnQYcuRCkdUamq6GYuxpDYUULkpvdXjGUH7DMD5Xe7tSuwJyLFrX8vSfy8IgNkPzkLl1u2LQskbT8OZiMKJ4V0hVjsiLZWybJQ4sA2qu0Hw2spL2ewHqsUbIuCROuVzS7YhSxAmvYh7HlOwyllerBV4Gys25v+da7B82nToIzo7eqXKB8XKRQ5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5iZhoTp8eIfTaOOOShh1XgljUrHSSFrPvfngojSvOA=;
 b=qWCETMGD41XD0g69rYPibuq1vHA0NmX4By/PsPjghONnasf/6XxKxauAy+hFfPpUxHa9P+08SxyOuCy7mGzfYSKUOYEglz4ZBxcXplApHLFXuV7I6qe4LR1VV+m/5ofWzRG2i68BCKRMkVKwP3GXsdebLrjD8fGMR3RE51XbtxgaSiqPwomFz9P4HYx3c7fZTFzDcktGDEF9FWmcdcC+SdMudeWUljzRjhj8H5DHgX4pA3ZbaJt7W/TlyF0JNCe1ys46+pzJ0dg/H/cjB1QWKzcfZeSss+g572SXnUeE728b0jB8cupAn/UNjgzq7J31i0nY+LAmRSAWP5BxMcmt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5iZhoTp8eIfTaOOOShh1XgljUrHSSFrPvfngojSvOA=;
 b=tBBIXq41Eg+RLp+aQG1QkKGpbzWlhzCgo1GMfkdAxpJJJnlP4m05TLqbJG7AeHU9Y+ayq5q5ojPWmtjjpEmYAs7e4sCsYvIXsTrpLWbUsRxb6z+r5gE9IyCTrBEeUfqOWiUahKQXqGmEpqY7P5w+PzhS5fOL4bpOiD5jJpjtFJ7t21avHI8M+ClDdrSid+e1SpObGqRccuQ1NrWT1t4XS7wh9x0skRtEL0w6MuwaqjIQyc1PiuWJ4Hp/zplan/dD4SpyUKN8wcJDIqDJ8Nh5pEngPoVgWgMcGyEmkwfIyke3ZEUFShiGJ5Hb50z03B+pphbJBdE6XZFpgHJlREg7Kg==
Received: from BYAPR08CA0064.namprd08.prod.outlook.com (2603:10b6:a03:117::41)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 20:54:38 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::a3) by BYAPR08CA0064.outlook.office365.com
 (2603:10b6:a03:117::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/15] net/mlx5: Refactor vport QoS to use scheduling node structure
Date: Mon, 14 Oct 2024 23:52:53 +0300
Message-ID: <20241014205300.193519-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf233b1-8fc1-4360-aa2d-08dcec926b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FSAzjfGjgXIKahh4IuRcplkywFwV/WxS/ucfyTcCdh7M3hbKDKtJGWyvp3/B?=
 =?us-ascii?Q?l4aOQK+Rpm91tpxg4/KJoDvFoi1FVxoRq8e1F3gzBODEHDhZu4NSKWTBMMrt?=
 =?us-ascii?Q?2JW5uZLLYbxJy2sJBPs8ge5ezwEtJgslRtfIClza9SMExLGbe464tVHFE6Hz?=
 =?us-ascii?Q?lUMyy5Zvhj/dhufIebtnJHZR8BvuuPMS+eqYBYeOzAWxK5p6eIcho6JpIdEp?=
 =?us-ascii?Q?1RKukF3AOMXlXoGIZ96OlAQ4kX5WAQre4MJHJKkQQJDlsWQwH9+DlEafDG7Z?=
 =?us-ascii?Q?P5jhdS8e1sbivgIPkIqIo6TF3B1RiKqVN6mm+oZVz31PeJlzleDx+7vuvKSt?=
 =?us-ascii?Q?KCueYKk6LM6bCdDUBZVa9LupnJjhI8gIA6JVnWlOvHoqxqobZEKg5RMNieeg?=
 =?us-ascii?Q?e4eLhqPceOukNQBUJWjMyz7g+ks4nkaaG77Oqnl1YmF5QCjW7phRhD3TvBKX?=
 =?us-ascii?Q?vZx1KM+0S+xVNKyEU9Jb/MxDttt2aJ2FT/y8Sd5IOOUY5669boM3JPCUlZNB?=
 =?us-ascii?Q?AlaLcXjnnHEP3LaPTi2lUyfiwUzjjOLdqLoZLjWCbfNBb2mYj0KKu4cCbcyU?=
 =?us-ascii?Q?ilRo6e8QBypGDg3NpvDKQOp+XE7A+uWJX6j+TKcHRe7v6XJMC+nfO/brUjPt?=
 =?us-ascii?Q?vlm9aWxr6j2A5siMhtwnCqdfJZiX7b2npzd43cjWB0VpJh9q11SRKfLnoqR/?=
 =?us-ascii?Q?9y48mpxVNZDo+vUmSvzrjfS01bwQrQEJiTVzxqOOxVJS8eoCO1Krp+GSvwbA?=
 =?us-ascii?Q?7J7QhyZoFb9Q+ST5FQK3x2SGiWTiBijJNkTxANqaRXm97bJz2vqvNnIf/jto?=
 =?us-ascii?Q?GMUf/upK8NXoGnHPBMiSeSKCeC/qDAYl4FutAoLHslRYKo+/Y9igkY/SbQvX?=
 =?us-ascii?Q?vSMd7Az3zJbpB2FtsaFTLJyGKg0q01AGlFNQQjmrLjzUzYjdJlH9jZxz0fZJ?=
 =?us-ascii?Q?Fs5b4FCkL91mNK+4n1mLnD1ft1aJ1+Zs42dwyZm2K4XFQ+UVhqKbfvleRLse?=
 =?us-ascii?Q?iyWBGdSEW21IQjhB/qOnmIweFez3y/lrgFHb5sIJn762zi4IJT7osof/tmSi?=
 =?us-ascii?Q?SpppMrPap1QNmer+KGMytaylauQ347f/wwzxDajjiUnDQwbF9xKkCc/v2uqz?=
 =?us-ascii?Q?Wq0RbfogdKbDxtJXaDjjZAf4mfWvKXycpFTldwS4SO+Rj1o2jYQPVqG4OKuW?=
 =?us-ascii?Q?Tjln1ha5SgUCL6d/rfsTYb+izw9gor/VET0lqbxbZMzGxPm6aQcSeGrfP2Aa?=
 =?us-ascii?Q?rQdOFGHPerM9mWzkkLWpxSsyQvJx5yPVEb8dRTv7mKFVSb2zZrg6iNanppk3?=
 =?us-ascii?Q?MbN2NlbGL1KWicKdaejXfGOrK6L9o9p+ZjNIm8zHQLvIR+bWtUg1a6i6qZHU?=
 =?us-ascii?Q?iRox2q03/JAa/IyUwLwTOirWxqoQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:38.4545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf233b1-8fc1-4360-aa2d-08dcec926b16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

From: Carolina Jubran <cjubran@nvidia.com>

Refactor the vport QoS structure by moving group membership and
scheduling details into the `mlx5_esw_sched_node` structure.

This change consolidates the vport into the rate hierarchy by unifying
the handling of different types of scheduling element nodes.

In addition, add a direct reference to the mlx5_vport within the
mlx5_esw_sched_node structure, to ensure that the vport is easily
accessible when a scheduling node is associated with a vport.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/esw/diag/qos_tracepoint.h       |   7 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 154 +++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
 5 files changed, 110 insertions(+), 67 deletions(-)

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
index bcdb745994d2..a665b8990dda 100644
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
 {
-	list_del_init(&vport->qos.parent_entry);
-	vport->qos.parent = parent;
-	list_add_tail(&vport->qos.parent_entry, &parent->children);
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
+{
+	if (!vport->qos.sched_node)
+		return NULL;
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
@@ -271,25 +295,25 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 				      u32 min_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	u32 fw_max_bw_share, previous_min_rate;
 	bool min_rate_supported;
 	int err;
 
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(vport_node->esw);
 	fw_max_bw_share = MLX5_CAP_QOS(vport->dev, max_tsar_bw_share);
 	min_rate_supported = MLX5_CAP_QOS(vport->dev, esw_bw_share) &&
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
@@ -297,27 +321,27 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 				      u32 max_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	u32 act_max_rate = max_rate;
 	bool max_rate_supported;
 	int err;
 
-	esw_assert_qos_lock_held(esw);
+	esw_assert_qos_lock_held(vport_node->esw);
 	max_rate_supported = MLX5_CAP_QOS(vport->dev, esw_rate_limit);
 
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
@@ -354,7 +378,7 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 				     u32 max_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_vport *vport;
+	struct mlx5_esw_sched_node *vport_node;
 	int err;
 
 	if (node->max_rate == max_rate)
@@ -367,11 +391,12 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
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
@@ -448,34 +473,37 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
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
 
@@ -486,12 +514,13 @@ static int esw_qos_vport_update_node(struct mlx5_vport *vport,
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
@@ -501,7 +530,7 @@ static int esw_qos_vport_update_node(struct mlx5_vport *vport,
 		return err;
 
 	/* Recalculate bw share weights of old and new nodes */
-	if (vport->qos.bw_share || new_node->bw_share) {
+	if (vport_node->bw_share || new_node->bw_share) {
 		esw_qos_normalize_node_min_rate(curr_node, extack);
 		esw_qos_normalize_node_min_rate(new_node, extack);
 	}
@@ -709,6 +738,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	u32 sched_elem_ix;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -720,18 +750,28 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
-						 &vport->qos.esw_sched_elem_ix);
+						 &sched_elem_ix);
 	if (err)
 		goto err_out;
 
-	INIT_LIST_HEAD(&vport->qos.parent_entry);
-	esw_qos_vport_set_parent(vport, esw->qos.node0);
+	vport->qos.sched_node = __esw_qos_alloc_node(esw, sched_elem_ix, SCHED_NODE_TYPE_VPORT,
+						     esw->qos.node0);
+	if (!vport->qos.sched_node) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
 
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
 
@@ -741,6 +781,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_core_dev *dev;
 	int err;
 
@@ -748,20 +789,23 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	esw_qos_lock(esw);
 	if (!vport->qos.enabled)
 		goto unlock;
-	WARN(vport->qos.parent != esw->qos.node0,
+	vport_node = vport->qos.sched_node;
+	WARN(vport_node->parent != esw->qos.node0,
 	     "Disabling QoS on port before detaching it from node");
 
-	dev = vport->qos.parent->esw->dev;
+	dev = vport_node->esw->dev;
+	trace_mlx5_esw_vport_qos_destroy(dev, vport);
+
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
@@ -794,8 +838,8 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
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
@@ -891,16 +935,16 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
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


