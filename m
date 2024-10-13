Return-Path: <netdev+bounces-134904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1C99B8A2
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E71F21D5D
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1223132106;
	Sun, 13 Oct 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSrEXsAg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314F130499
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802016; cv=fail; b=tN9xffs6bmzBccsfSjOZ1+HHBPEiOTAqM/W6QBcBu8TM8mCLuMzkZ70i4YQF75unhjLUl1rL9Zi9IXHzYhcEGknpzI4ez1g5MlVvkyfbt8F19PXrc7Ks0kBcZ3+6hs23oQSjh2rc/I/ilQM6QvzMKqq8k9VlwtE5XH+EcG3Tgzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802016; c=relaxed/simple;
	bh=zDjJ7+0xs7IgII2zX2JoYN1Bt5avYrW3IQ5xHVOWLcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1nWbpot0DA/EMl9Yb1+sCAmIhPV8JQwGkNr0MpomhCLOfNn0bclp9kwkDvkXaRLVCno76SDq3veZaUhyuRnhHckFSYCKXpvHhVx+4R65b2jzRany1mw/hxpeBb/MEs9bmQXf9HH2SlGhu785BWJT0ksAMsKzlpZlQ58aLPUPGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSrEXsAg; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNZwTvOgvqFoFbQNMkwujcNAtuudrqMVjcm6Ttb3Z1yugVeIwLusyMzkkcLx8SdSRoAGs1cgVojHm6c6X5VylDiZobGWyp24Rls0Ak8Dg4phq+nxRhtfzuL8L3fwVNzWcbPTgpQjsvsXjVcVJ+nL6a65n0aIQgkMK6sgno8dK5634AJEmqRljc24EGUudg6Xs0BXr5I1V5Dv63M6AkF7J7zv9ztWS5/O+ArMYUI0thP8QhgGNwhey5V+89Ul5GZghKkK22aO9+qZWiltEJn3lkl8VHyvSCxVfv7Ye54qUBk8VhZ6KWID5LeBTBwR5eCQX9O2rE8m+Y1MblrNd65s7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMM2EQjsaaD77icFzdowU/DeOZKwb4ThTVuY7J17xr0=;
 b=NWNm27kFMRQGOwTRbiI0DEl/YiWmEd7tIp4B6ZwoA8Ejmdht24/BKoEDb/Ia2D0NOLvYFvwrQXe/rySNJmYjLZn89hdAtOE09+3w3Cbga8gk+BDdBqXMaPAllnM9ydlMkhMUsscNU6DUZcMyoHfTQxpQ/WjIjLkOAEsXLHn0sPITPjLrl9i0gjWawW7YbvLNyjx2QeDCGOwTeVubO49lK0wULY0tY8n69Z1zv1fljyey46pthWmHDs5cfWhazBRm9zPN4QxN3H5rUgp9acIVlyIs8023ietZf7zrEiKL9qcrkDsJhyX5E0cXC7I84lf3+FowUimS9zGcBs6lQGcZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMM2EQjsaaD77icFzdowU/DeOZKwb4ThTVuY7J17xr0=;
 b=DSrEXsAgOwZf+uhEOBCpc2piy2fmKK14LP5X1jhKr4ED+wXrDN0cS3PzJa2Uw1R0FAct9zWfJXMuN/kEqS+qiMmvaUzQ4raKbSkHMv743t2kvVYddAmf+R1F16jSrwIxBgHhJb1HXpQ4O7cCkRvfD93dOfi2VRUINEkuVKZNns3DHqUehdnb3A6qI2cE6RLsJIEPR0QMajIS1YJbubFrSpcuQlGikwmPQ5vGGpHSMfbaNC8NYNH61YM5knNiCbgjmyqelt8A+FF/+yOP27obmoMvb66HGO7vTGHHVjPK+GyYMUFZd/ehu/cBMmymlyDQJ/XQBAbl3H6QpVIQvyU5hQ==
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sun, 13 Oct
 2024 06:46:46 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::29) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/15] net/mlx5: Introduce node struct and rename group terminology to node
Date: Sun, 13 Oct 2024 09:45:31 +0300
Message-ID: <20241013064540.170722-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1321c7cc-0878-4bf8-52a2-08dceb52ce14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92caekNz0DdI+PiZ7ZlQ0RcQWaydyZvkScUvGFCH+YDVQnMkPKfuy4APz2Ti?=
 =?us-ascii?Q?UGHL8O9POuoZ5ii1xY93jQj+KHzT5vFAQAoUNgESTF0EFMJ+MyfFi+hiaWde?=
 =?us-ascii?Q?Dd9QtHWIReL/hH9K/1zGC9ENga6t7VfG/BGSuC1TVYElVt2urVJYKdM75xZA?=
 =?us-ascii?Q?RZVLa7cpAaeL0gAbt9Q5KTX2uRbec+yvdNkr/k7DUAvPjEh6/2qz8Z7tpUWy?=
 =?us-ascii?Q?H8idR69z2TRFv2FIXY1OUBLS2YO77DKFz9gCTvk5XshsP1Tn9YtjKdw6gywY?=
 =?us-ascii?Q?TaHQjRtmYNXetLO9gOvr+OGq76VhlfgvyI9QTCIHmEsFeabZNLfJOzpBvJ/i?=
 =?us-ascii?Q?0mfg+ZFou2Wp+bQq2c2DBioIgNg4FrdLU6tODiaD0s3paA4J5rt9SFhKogRd?=
 =?us-ascii?Q?xYCIOrIFfFldIQYS5Y5OyPNkWP2cmilyIyT9qi0AcZNJlUOgPCNyh08hRPmf?=
 =?us-ascii?Q?iauNLn5xTr57hKDjN9Dn04f6gnySaA2YTlF6vWXTUrkqNrggjddIY6QNLIo9?=
 =?us-ascii?Q?xP0axKIg+oZAPXyf7npqhpeVzQnJ9qc9jeChSAdYLY3AWNZVaiWXsmKOyhvZ?=
 =?us-ascii?Q?LuEhV+x++4fMBL3MEPNQ7zjQUNA9qD3rYfObkj2Nu7wkrGjOc2z44HhPJIU8?=
 =?us-ascii?Q?F3MrYiR87QcPCOA28nxxqUSOqWTFk+qMglV47onhT1ZEUg0klpww0vwt6eJD?=
 =?us-ascii?Q?b1Er0WqxUhzm4gOxCR9lhRmD3wvYVISk23QSpNoKJKL6ukGaos9MRRg8AXhB?=
 =?us-ascii?Q?WMkhDkGRE6HlGBAdnYsFBJnL4ObHcpcSKQlA22CmVtfsLDXuhKY6sQPRfCNv?=
 =?us-ascii?Q?XesV9y0T690n659u9nxjy+lwt8GTIqIgxsHKwo3jVu9oUMiz1cakxhTqO6dl?=
 =?us-ascii?Q?vQDiL8U/AZqbMwqK8t8hp+DuKnqSyHsJwv42zhymN+az2lw2crU7DP9lOqPm?=
 =?us-ascii?Q?ASzNOvOrM0OSyzyxoEfZv26bycy8Yk3NNk1Bh1UnHwoAq7F8BRzOj0euWmrB?=
 =?us-ascii?Q?Ef9mVTfMOybFgDRIi0k9clvD5VOTxMo+iuRFXAFcxypZjXvsr0FhR0dK0Qzv?=
 =?us-ascii?Q?99i/899HGQti6+DaC0bNiKaJaqrho1VQ59u5+fCvkYD3pgJySBCG782fhOmR?=
 =?us-ascii?Q?9WDIK3AE73f//mvACNHRXfqfOUmt/j+xa8ZvBpa7MqFOyEENTmoKGBXlyojm?=
 =?us-ascii?Q?jZis3FuiZQMfiGMfogEDOw0jFMVpOS68zKY6s0phJmO86FWqLqThtD1gkhna?=
 =?us-ascii?Q?EnZbZ2Z0tTUndv4C9MiHRPI7reLy3xCNRAsoaRxL+niRoqykgFpk9sxSSuWE?=
 =?us-ascii?Q?GiVf3Y0ReBzbY24i87S2JTTGqx83JVjYWALiaapUIzRxTHqrvQxH6jFHAPb4?=
 =?us-ascii?Q?foa2MU4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:45.5645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1321c7cc-0878-4bf8-52a2-08dceb52ce14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

From: Carolina Jubran <cjubran@nvidia.com>

Introduce the `mlx5_esw_sched_node` struct, consolidating all rate
hierarchy related details, including membership and scheduling
parameters.

Since the group concept aligns with the `mlx5_esw_sched_node`, replace
the `mlx5_esw_rate_group` struct with it and rename the "group"
terminology to "node" throughout the rate hierarchy.

All relevant code paths and structures have been updated to use the
"node" terminology accordingly, laying the groundwork for future
patches that will unify the handling of different types of members
within the rate hierarchy.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../mlx5/core/esw/diag/qos_tracepoint.h       |  40 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 377 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  16 +-
 4 files changed, 218 insertions(+), 217 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 86af1891395f..d0f38818363f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -195,7 +195,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_group(vport, NULL, NULL);
+	mlx5_esw_qos_vport_update_node(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
index 2aea01959073..0b50ef0871f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
@@ -62,57 +62,57 @@ DEFINE_EVENT(mlx5_esw_vport_qos_template, mlx5_esw_vport_qos_config,
 	     TP_ARGS(dev, vport, bw_share, max_rate)
 	     );
 
-DECLARE_EVENT_CLASS(mlx5_esw_group_qos_template,
+DECLARE_EVENT_CLASS(mlx5_esw_node_qos_template,
 		    TP_PROTO(const struct mlx5_core_dev *dev,
-			     const struct mlx5_esw_rate_group *group,
+			     const struct mlx5_esw_sched_node *node,
 			     unsigned int tsar_ix),
-		    TP_ARGS(dev, group, tsar_ix),
+		    TP_ARGS(dev, node, tsar_ix),
 		    TP_STRUCT__entry(__string(devname, dev_name(dev->device))
-				     __field(const void *, group)
+				     __field(const void *, node)
 				     __field(unsigned int, tsar_ix)
 				     ),
 		    TP_fast_assign(__assign_str(devname);
-			    __entry->group = group;
+			    __entry->node = node;
 			    __entry->tsar_ix = tsar_ix;
 		    ),
-		    TP_printk("(%s) group=%p tsar_ix=%u\n",
-			      __get_str(devname), __entry->group, __entry->tsar_ix
+		    TP_printk("(%s) node=%p tsar_ix=%u\n",
+			      __get_str(devname), __entry->node, __entry->tsar_ix
 			      )
 );
 
-DEFINE_EVENT(mlx5_esw_group_qos_template, mlx5_esw_group_qos_create,
+DEFINE_EVENT(mlx5_esw_node_qos_template, mlx5_esw_node_qos_create,
 	     TP_PROTO(const struct mlx5_core_dev *dev,
-		      const struct mlx5_esw_rate_group *group,
+		      const struct mlx5_esw_sched_node *node,
 		      unsigned int tsar_ix),
-	     TP_ARGS(dev, group, tsar_ix)
+	     TP_ARGS(dev, node, tsar_ix)
 	     );
 
-DEFINE_EVENT(mlx5_esw_group_qos_template, mlx5_esw_group_qos_destroy,
+DEFINE_EVENT(mlx5_esw_node_qos_template, mlx5_esw_node_qos_destroy,
 	     TP_PROTO(const struct mlx5_core_dev *dev,
-		      const struct mlx5_esw_rate_group *group,
+		      const struct mlx5_esw_sched_node *node,
 		      unsigned int tsar_ix),
-	     TP_ARGS(dev, group, tsar_ix)
+	     TP_ARGS(dev, node, tsar_ix)
 	     );
 
-TRACE_EVENT(mlx5_esw_group_qos_config,
+TRACE_EVENT(mlx5_esw_node_qos_config,
 	    TP_PROTO(const struct mlx5_core_dev *dev,
-		     const struct mlx5_esw_rate_group *group,
+		     const struct mlx5_esw_sched_node *node,
 		     unsigned int tsar_ix, u32 bw_share, u32 max_rate),
-	    TP_ARGS(dev, group, tsar_ix, bw_share, max_rate),
+	    TP_ARGS(dev, node, tsar_ix, bw_share, max_rate),
 	    TP_STRUCT__entry(__string(devname, dev_name(dev->device))
-			     __field(const void *, group)
+			     __field(const void *, node)
 			     __field(unsigned int, tsar_ix)
 			     __field(unsigned int, bw_share)
 			     __field(unsigned int, max_rate)
 			     ),
 	    TP_fast_assign(__assign_str(devname);
-		    __entry->group = group;
+		    __entry->node = node;
 		    __entry->tsar_ix = tsar_ix;
 		    __entry->bw_share = bw_share;
 		    __entry->max_rate = max_rate;
 	    ),
-	    TP_printk("(%s) group=%p tsar_ix=%u bw_share=%u max_rate=%u\n",
-		      __get_str(devname), __entry->group, __entry->tsar_ix,
+	    TP_printk("(%s) node=%p tsar_ix=%u bw_share=%u max_rate=%u\n",
+		      __get_str(devname), __entry->node, __entry->tsar_ix,
 		      __entry->bw_share, __entry->max_rate
 		      )
 );
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 67b87f1598a5..d3289c1cb87a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,12 +11,12 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate groups associated with an E-Switch. */
+/* Holds rate node associated with an E-Switch. */
 struct mlx5_qos_domain {
 	/* Serializes access to all qos changes in the qos domain. */
 	struct mutex lock;
-	/* List of all mlx5_esw_rate_groups. */
-	struct list_head groups;
+	/* List of all mlx5_esw_sched_nodes. */
+	struct list_head nodes;
 };
 
 static void esw_qos_lock(struct mlx5_eswitch *esw)
@@ -43,7 +43,7 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 		return NULL;
 
 	mutex_init(&qos_domain->lock);
-	INIT_LIST_HEAD(&qos_domain->groups);
+	INIT_LIST_HEAD(&qos_domain->nodes);
 
 	return qos_domain;
 }
@@ -65,30 +65,30 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 };
 
-struct mlx5_esw_rate_group {
-	u32 tsar_ix;
+struct mlx5_esw_sched_node {
+	u32 ix;
 	/* Bandwidth parameters. */
 	u32 max_rate;
 	u32 min_rate;
-	/* A computed value indicating relative min_rate between group members. */
+	/* A computed value indicating relative min_rate between node's children. */
 	u32 bw_share;
-	/* The parent group of this group. */
-	struct mlx5_esw_rate_group *parent;
-	/* Membership in the parent list. */
-	struct list_head parent_entry;
-	/* The type of this group node in the rate hierarchy. */
+	/* The parent node in the rate hierarchy. */
+	struct mlx5_esw_sched_node *parent;
+	/* Entry in the parent node's children list. */
+	struct list_head entry;
+	/* The type of this node in the rate hierarchy. */
 	enum sched_node_type type;
-	/* The eswitch this group belongs to. */
+	/* The eswitch this node belongs to. */
 	struct mlx5_eswitch *esw;
-	/* Members of this group.*/
-	struct list_head members;
+	/* The children nodes of this node, empty list for leaf nodes. */
+	struct list_head children;
 };
 
-static void esw_qos_vport_set_parent(struct mlx5_vport *vport, struct mlx5_esw_rate_group *parent)
+static void esw_qos_vport_set_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent)
 {
 	list_del_init(&vport->qos.parent_entry);
 	vport->qos.parent = parent;
-	list_add_tail(&vport->qos.parent_entry, &parent->members);
+	list_add_tail(&vport->qos.parent_entry, &parent->children);
 }
 
 static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_ix,
@@ -112,17 +112,17 @@ static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_i
 						  bitmask);
 }
 
-static int esw_qos_group_config(struct mlx5_esw_rate_group *group,
-				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
+static int esw_qos_node_config(struct mlx5_esw_sched_node *node,
+			       u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = group->esw->dev;
+	struct mlx5_core_dev *dev = node->esw->dev;
 	int err;
 
-	err = esw_qos_sched_elem_config(dev, group->tsar_ix, max_rate, bw_share);
+	err = esw_qos_sched_elem_config(dev, node->ix, max_rate, bw_share);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify group TSAR element failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify node TSAR element failed");
 
-	trace_mlx5_esw_group_qos_config(dev, group, group->tsar_ix, bw_share, max_rate);
+	trace_mlx5_esw_node_qos_config(dev, node, node->ix, bw_share, max_rate);
 
 	return err;
 }
@@ -148,16 +148,16 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 	return 0;
 }
 
-static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_esw_rate_group *group)
+static u32 esw_qos_calculate_node_min_rate_divider(struct mlx5_esw_sched_node *node)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(group->esw->dev, max_tsar_bw_share);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
 	struct mlx5_vport *vport;
 	u32 max_guarantee = 0;
 
-	/* Find max min_rate across all vports in this group.
+	/* Find max min_rate across all vports in this node.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(vport, &group->members, qos.parent_entry) {
+	list_for_each_entry(vport, &node->children, qos.parent_entry) {
 		if (vport->qos.min_rate > max_guarantee)
 			max_guarantee = vport->qos.min_rate;
 	}
@@ -165,13 +165,13 @@ static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_esw_rate_group *
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
 
-	/* If vports max min_rate divider is 0 but their group has bw_share
+	/* If vports max min_rate divider is 0 but their node has bw_share
 	 * configured, then set bw_share for vports to minimal value.
 	 */
-	if (group->bw_share)
+	if (node->bw_share)
 		return 1;
 
-	/* A divider of 0 sets bw_share for all group vports to 0,
+	/* A divider of 0 sets bw_share for all node vports to 0,
 	 * effectively disabling min guarantees.
 	 */
 	return 0;
@@ -180,23 +180,23 @@ static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_esw_rate_group *
 static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	u32 max_guarantee = 0;
 
-	/* Find max min_rate across all esw groups.
+	/* Find max min_rate across all esw nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(group, &esw->qos.domain->groups, parent_entry) {
-		if (group->esw == esw && group->tsar_ix != esw->qos.root_tsar_ix &&
-		    group->min_rate > max_guarantee)
-			max_guarantee = group->min_rate;
+	list_for_each_entry(node, &esw->qos.domain->nodes, entry) {
+		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
+		    node->min_rate > max_guarantee)
+			max_guarantee = node->min_rate;
 	}
 
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
 
-	/* If no group has min_rate configured, a divider of 0 sets all
-	 * groups' bw_share to 0, effectively disabling min guarantees.
+	/* If no node has min_rate configured, a divider of 0 sets all
+	 * nodes' bw_share to 0, effectively disabling min guarantees.
 	 */
 	return 0;
 }
@@ -208,16 +208,16 @@ static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
 	return min_t(u32, max_t(u32, DIV_ROUND_UP(min_rate, divider), MLX5_MIN_BW_SHARE), fw_max);
 }
 
-static int esw_qos_normalize_group_min_rate(struct mlx5_esw_rate_group *group,
-					    struct netlink_ext_ack *extack)
+static int esw_qos_normalize_node_min_rate(struct mlx5_esw_sched_node *node,
+					   struct netlink_ext_ack *extack)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(group->esw->dev, max_tsar_bw_share);
-	u32 divider = esw_qos_calculate_group_min_rate_divider(group);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
+	u32 divider = esw_qos_calculate_node_min_rate_divider(node);
 	struct mlx5_vport *vport;
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(vport, &group->members, qos.parent_entry) {
+	list_for_each_entry(vport, &node->children, qos.parent_entry) {
 		bw_share = esw_qos_calc_bw_share(vport->qos.min_rate, divider, fw_max_bw_share);
 
 		if (bw_share == vport->qos.bw_share)
@@ -237,28 +237,29 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	u32 divider = esw_qos_calculate_min_rate_divider(esw);
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(group, &esw->qos.domain->groups, parent_entry) {
-		if (group->esw != esw || group->tsar_ix == esw->qos.root_tsar_ix)
+	list_for_each_entry(node, &esw->qos.domain->nodes, entry) {
+		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
-		bw_share = esw_qos_calc_bw_share(group->min_rate, divider, fw_max_bw_share);
+		bw_share = esw_qos_calc_bw_share(node->min_rate, divider,
+						 fw_max_bw_share);
 
-		if (bw_share == group->bw_share)
+		if (bw_share == node->bw_share)
 			continue;
 
-		err = esw_qos_group_config(group, group->max_rate, bw_share, extack);
+		err = esw_qos_node_config(node, node->max_rate, bw_share, extack);
 		if (err)
 			return err;
 
-		group->bw_share = bw_share;
+		node->bw_share = bw_share;
 
-		/* All the group's vports need to be set with default bw_share
+		/* All the node's vports need to be set with default bw_share
 		 * to enable them with QOS
 		 */
-		err = esw_qos_normalize_group_min_rate(group, extack);
+		err = esw_qos_normalize_node_min_rate(node, extack);
 
 		if (err)
 			return err;
@@ -286,7 +287,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 
 	previous_min_rate = vport->qos.min_rate;
 	vport->qos.min_rate = min_rate;
-	err = esw_qos_normalize_group_min_rate(vport->qos.parent, extack);
+	err = esw_qos_normalize_node_min_rate(vport->qos.parent, extack);
 	if (err)
 		vport->qos.min_rate = previous_min_rate;
 
@@ -309,7 +310,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 	if (max_rate == vport->qos.max_rate)
 		return 0;
 
-	/* Use parent group limit if new max rate is 0. */
+	/* Use parent node limit if new max rate is 0. */
 	if (!max_rate)
 		act_max_rate = vport->qos.parent->max_rate;
 
@@ -321,10 +322,10 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 	return err;
 }
 
-static int esw_qos_set_group_min_rate(struct mlx5_esw_rate_group *group,
-				      u32 min_rate, struct netlink_ext_ack *extack)
+static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
+				     u32 min_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_eswitch *esw = node->esw;
 	u32 previous_min_rate;
 	int err;
 
@@ -332,17 +333,17 @@ static int esw_qos_set_group_min_rate(struct mlx5_esw_rate_group *group,
 	    MLX5_CAP_QOS(esw->dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE)
 		return -EOPNOTSUPP;
 
-	if (min_rate == group->min_rate)
+	if (min_rate == node->min_rate)
 		return 0;
 
-	previous_min_rate = group->min_rate;
-	group->min_rate = min_rate;
+	previous_min_rate = node->min_rate;
+	node->min_rate = min_rate;
 	err = esw_qos_normalize_min_rate(esw, extack);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch group min rate setting failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch node min rate setting failed");
 
 		/* Attempt restoring previous configuration */
-		group->min_rate = previous_min_rate;
+		node->min_rate = previous_min_rate;
 		if (esw_qos_normalize_min_rate(esw, extack))
 			NL_SET_ERR_MSG_MOD(extack, "E-Switch BW share restore failed");
 	}
@@ -350,23 +351,23 @@ static int esw_qos_set_group_min_rate(struct mlx5_esw_rate_group *group,
 	return err;
 }
 
-static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
-				      u32 max_rate, struct netlink_ext_ack *extack)
+static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
+				     u32 max_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport;
 	int err;
 
-	if (group->max_rate == max_rate)
+	if (node->max_rate == max_rate)
 		return 0;
 
-	err = esw_qos_group_config(group, max_rate, group->bw_share, extack);
+	err = esw_qos_node_config(node, max_rate, node->bw_share, extack);
 	if (err)
 		return err;
 
-	group->max_rate = max_rate;
+	node->max_rate = max_rate;
 
-	/* Any unlimited vports in the group should be set with the value of the group. */
-	list_for_each_entry(vport, &group->members, qos.parent_entry) {
+	/* Any unlimited vports in the node should be set with the value of the node. */
+	list_for_each_entry(vport, &node->children, qos.parent_entry) {
 		if (vport->qos.max_rate)
 			continue;
 
@@ -379,8 +380,8 @@ static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
 	return err;
 }
 
-static int esw_qos_create_group_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
-					   u32 *tsar_ix)
+static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
+					  u32 *tsar_ix)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	void *attr;
@@ -409,7 +410,7 @@ static int esw_qos_create_group_sched_elem(struct mlx5_core_dev *dev, u32 parent
 static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
 {
-	struct mlx5_esw_rate_group *parent = vport->qos.parent;
+	struct mlx5_esw_sched_node *parent = vport->qos.parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = parent->esw->dev;
 	void *attr;
@@ -424,7 +425,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->tsar_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
 
@@ -442,15 +443,15 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 	return 0;
 }
 
-static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
-						   struct mlx5_esw_rate_group *curr_group,
-						   struct mlx5_esw_rate_group *new_group,
-						   struct netlink_ext_ack *extack)
+static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
+						  struct mlx5_esw_sched_node *curr_node,
+						  struct mlx5_esw_sched_node *new_node,
+						  struct netlink_ext_ack *extack)
 {
 	u32 max_rate;
 	int err;
 
-	err = mlx5_destroy_scheduling_element_cmd(curr_group->esw->dev,
+	err = mlx5_destroy_scheduling_element_cmd(curr_node->esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  vport->qos.esw_sched_elem_ix);
 	if (err) {
@@ -458,128 +459,128 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
 		return err;
 	}
 
-	esw_qos_vport_set_parent(vport, new_group);
-	/* Use new group max rate if vport max rate is unlimited. */
-	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_group->max_rate;
+	esw_qos_vport_set_parent(vport, new_node);
+	/* Use new node max rate if vport max rate is unlimited. */
+	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_node->max_rate;
 	err = esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport group set failed.");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport node set failed.");
 		goto err_sched;
 	}
 
 	return 0;
 
 err_sched:
-	esw_qos_vport_set_parent(vport, curr_group);
-	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_group->max_rate;
+	esw_qos_vport_set_parent(vport, curr_node);
+	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_node->max_rate;
 	if (esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share))
-		esw_warn(curr_group->esw->dev, "E-Switch vport group restore failed (vport=%d)\n",
+		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
 			 vport->vport);
 
 	return err;
 }
 
-static int esw_qos_vport_update_group(struct mlx5_vport *vport,
-				      struct mlx5_esw_rate_group *group,
-				      struct netlink_ext_ack *extack)
+static int esw_qos_vport_update_node(struct mlx5_vport *vport,
+				     struct mlx5_esw_sched_node *node,
+				     struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	struct mlx5_esw_rate_group *new_group, *curr_group;
+	struct mlx5_esw_sched_node *new_node, *curr_node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	curr_group = vport->qos.parent;
-	new_group = group ?: esw->qos.group0;
-	if (curr_group == new_group)
+	curr_node = vport->qos.parent;
+	new_node = node ?: esw->qos.node0;
+	if (curr_node == new_node)
 		return 0;
 
-	err = esw_qos_update_group_scheduling_element(vport, curr_group, new_group, extack);
+	err = esw_qos_update_node_scheduling_element(vport, curr_node, new_node, extack);
 	if (err)
 		return err;
 
-	/* Recalculate bw share weights of old and new groups */
-	if (vport->qos.bw_share || new_group->bw_share) {
-		esw_qos_normalize_group_min_rate(curr_group, extack);
-		esw_qos_normalize_group_min_rate(new_group, extack);
+	/* Recalculate bw share weights of old and new nodes */
+	if (vport->qos.bw_share || new_node->bw_share) {
+		esw_qos_normalize_node_min_rate(curr_node, extack);
+		esw_qos_normalize_node_min_rate(new_node, extack);
 	}
 
 	return 0;
 }
 
-static struct mlx5_esw_rate_group *
-__esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
-			   struct mlx5_esw_rate_group *parent)
+static struct mlx5_esw_sched_node *
+__esw_qos_alloc_rate_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
+			  struct mlx5_esw_sched_node *parent)
 {
-	struct mlx5_esw_rate_group *group;
-	struct list_head *parent_list;
+	struct list_head *parent_children;
+	struct mlx5_esw_sched_node *node;
 
-	group = kzalloc(sizeof(*group), GFP_KERNEL);
-	if (!group)
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
 		return NULL;
 
-	group->esw = esw;
-	group->tsar_ix = tsar_ix;
-	group->type = type;
-	group->parent = parent;
-	INIT_LIST_HEAD(&group->members);
-	parent_list = parent ? &parent->members : &esw->qos.domain->groups;
-	list_add_tail(&group->parent_entry, parent_list);
+	node->esw = esw;
+	node->ix = tsar_ix;
+	node->type = type;
+	node->parent = parent;
+	INIT_LIST_HEAD(&node->children);
+	parent_children = parent ? &parent->children : &esw->qos.domain->nodes;
+	list_add_tail(&node->entry, parent_children);
 
-	return group;
+	return node;
 }
 
-static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
+static void __esw_qos_free_node(struct mlx5_esw_sched_node *node)
 {
-	list_del(&group->parent_entry);
-	kfree(group);
+	list_del(&node->entry);
+	kfree(node);
 }
 
-static struct mlx5_esw_rate_group *
-__esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *parent,
-				   struct netlink_ext_ack *extack)
+static struct mlx5_esw_sched_node *
+__esw_qos_create_vports_rate_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
+				  struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	u32 tsar_ix, err;
 
-	err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
 	}
 
-	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
-	if (!group) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
+	node = __esw_qos_alloc_rate_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
+	if (!node) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
 		err = -ENOMEM;
-		goto err_alloc_group;
+		goto err_alloc_node;
 	}
 
 	err = esw_qos_normalize_min_rate(esw, extack);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
 		goto err_min_rate;
 	}
-	trace_mlx5_esw_group_qos_create(esw->dev, group, group->tsar_ix);
+	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
-	return group;
+	return node;
 
 err_min_rate:
-	__esw_qos_free_rate_group(group);
-err_alloc_group:
+	__esw_qos_free_node(node);
+err_alloc_node:
 	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
-						tsar_ix))
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
+						node->ix))
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
 	return ERR_PTR(err);
 }
 
 static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack);
 static void esw_qos_put(struct mlx5_eswitch *esw);
 
-static struct mlx5_esw_rate_group *
-esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+static struct mlx5_esw_sched_node *
+esw_qos_create_vports_rate_node(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -590,31 +591,31 @@ esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	group = __esw_qos_create_vports_rate_group(esw, NULL, extack);
-	if (IS_ERR(group))
+	node = __esw_qos_create_vports_rate_node(esw, NULL, extack);
+	if (IS_ERR(node))
 		esw_qos_put(esw);
 
-	return group;
+	return node;
 }
 
-static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
-					struct netlink_ext_ack *extack)
+static int __esw_qos_destroy_rate_node(struct mlx5_esw_sched_node *node,
+				       struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
-	trace_mlx5_esw_group_qos_destroy(esw->dev, group, group->tsar_ix);
+	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  group->tsar_ix);
+						  node->ix);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR_ID failed");
-	__esw_qos_free_rate_group(group);
+	__esw_qos_free_node(node);
 
 	err = esw_qos_normalize_min_rate(esw, extack);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
 
 
 	return err;
@@ -628,32 +629,32 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_group_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
 	}
 
 	if (MLX5_CAP_QOS(dev, log_esw_max_sched_depth)) {
-		esw->qos.group0 = __esw_qos_create_vports_rate_group(esw, NULL, extack);
+		esw->qos.node0 = __esw_qos_create_vports_rate_node(esw, NULL, extack);
 	} else {
-		/* The eswitch doesn't support scheduling groups.
-		 * Create a software-only group0 using the root TSAR to attach vport QoS to.
+		/* The eswitch doesn't support scheduling nodes.
+		 * Create a software-only node0 using the root TSAR to attach vport QoS to.
 		 */
-		if (!__esw_qos_alloc_rate_group(esw, esw->qos.root_tsar_ix,
-						SCHED_NODE_TYPE_VPORTS_TSAR, NULL))
-			esw->qos.group0 = ERR_PTR(-ENOMEM);
+		if (!__esw_qos_alloc_rate_node(esw, esw->qos.root_tsar_ix,
+					       SCHED_NODE_TYPE_VPORTS_TSAR, NULL))
+			esw->qos.node0 = ERR_PTR(-ENOMEM);
 	}
-	if (IS_ERR(esw->qos.group0)) {
-		err = PTR_ERR(esw->qos.group0);
-		esw_warn(dev, "E-Switch create rate group 0 failed (%d)\n", err);
-		goto err_group0;
+	if (IS_ERR(esw->qos.node0)) {
+		err = PTR_ERR(esw->qos.node0);
+		esw_warn(dev, "E-Switch create rate node 0 failed (%d)\n", err);
+		goto err_node0;
 	}
 	refcount_set(&esw->qos.refcnt, 1);
 
 	return 0;
 
-err_group0:
+err_node0:
 	if (mlx5_destroy_scheduling_element_cmd(esw->dev, SCHEDULING_HIERARCHY_E_SWITCH,
 						esw->qos.root_tsar_ix))
 		esw_warn(esw->dev, "E-Switch destroy root TSAR failed.\n");
@@ -665,11 +666,11 @@ static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
 	int err;
 
-	if (esw->qos.group0->tsar_ix != esw->qos.root_tsar_ix)
-		__esw_qos_destroy_rate_group(esw->qos.group0, NULL);
+	if (esw->qos.node0->ix != esw->qos.root_tsar_ix)
+		__esw_qos_destroy_rate_node(esw->qos.node0, NULL);
 	else
-		__esw_qos_free_rate_group(esw->qos.group0);
-	esw->qos.group0 = NULL;
+		__esw_qos_free_node(esw->qos.node0);
+	esw->qos.node0 = NULL;
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
@@ -715,7 +716,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	INIT_LIST_HEAD(&vport->qos.parent_entry);
-	esw_qos_vport_set_parent(vport, esw->qos.group0);
+	esw_qos_vport_set_parent(vport, esw->qos.node0);
 
 	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
 	if (err)
@@ -742,8 +743,8 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	esw_qos_lock(esw);
 	if (!vport->qos.enabled)
 		goto unlock;
-	WARN(vport->qos.parent != esw->qos.group0,
-	     "Disabling QoS on port before detaching it from group");
+	WARN(vport->qos.parent != esw->qos.node0,
+	     "Disabling QoS on port before detaching it from node");
 
 	dev = vport->qos.parent->esw->dev;
 	err = mlx5_destroy_scheduling_element_cmd(dev,
@@ -1003,8 +1004,8 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group = priv;
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_share", &tx_share, extack);
@@ -1012,7 +1013,7 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_set_group_min_rate(group, tx_share, extack);
+	err = esw_qos_set_node_min_rate(node, tx_share, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1020,8 +1021,8 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group = priv;
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_max", &tx_max, extack);
@@ -1029,7 +1030,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_set_group_max_rate(group, tx_max, extack);
+	err = esw_qos_set_node_max_rate(node, tx_max, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1037,7 +1038,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 				   struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	struct mlx5_eswitch *esw;
 	int err = 0;
 
@@ -1053,13 +1054,13 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 		goto unlock;
 	}
 
-	group = esw_qos_create_vports_rate_group(esw, extack);
-	if (IS_ERR(group)) {
-		err = PTR_ERR(group);
+	node = esw_qos_create_vports_rate_node(esw, extack);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
 		goto unlock;
 	}
 
-	*priv = group;
+	*priv = node;
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1068,36 +1069,36 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 				   struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group = priv;
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	esw_qos_lock(esw);
-	err = __esw_qos_destroy_rate_group(group, extack);
+	err = __esw_qos_destroy_rate_node(node, extack);
 	esw_qos_put(esw);
 	esw_qos_unlock(esw);
 	return err;
 }
 
-int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
-				    struct mlx5_esw_rate_group *group,
-				    struct netlink_ext_ack *extack)
+int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
+				   struct mlx5_esw_sched_node *node,
+				   struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
 
-	if (group && group->esw != esw) {
+	if (node && node->esw != esw) {
 		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled && !group)
+	if (!vport->qos.enabled && !node)
 		goto unlock;
 
 	err = esw_qos_vport_enable(vport, 0, 0, extack);
 	if (!err)
-		err = esw_qos_vport_update_group(vport, group, extack);
+		err = esw_qos_vport_update_node(vport, node, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1108,12 +1109,12 @@ int mlx5_esw_devlink_rate_parent_set(struct devlink_rate *devlink_rate,
 				     void *priv, void *parent_priv,
 				     struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	struct mlx5_vport *vport = priv;
 
 	if (!parent)
-		return mlx5_esw_qos_vport_update_group(vport, NULL, extack);
+		return mlx5_esw_qos_vport_update_node(vport, NULL, extack);
 
-	group = parent_priv;
-	return mlx5_esw_qos_vport_update_group(vport, group, extack);
+	node = parent_priv;
+	return mlx5_esw_qos_vport_update_node(vport, node, extack);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e789fb14989b..38f912f5a707 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -222,7 +222,7 @@ struct mlx5_vport {
 		/* A computed value indicating relative min_rate between vports in a group. */
 		u32 bw_share;
 		/* The parent group of this vport scheduling element. */
-		struct mlx5_esw_rate_group *parent;
+		struct mlx5_esw_sched_node *parent;
 		/* Membership in the parent 'members' list. */
 		struct list_head parent_entry;
 	} qos;
@@ -372,11 +372,11 @@ struct mlx5_eswitch {
 		refcount_t refcnt;
 		u32 root_tsar_ix;
 		struct mlx5_qos_domain *domain;
-		/* Contains all vports with QoS enabled but no explicit group.
-		 * Cannot be NULL if QoS is enabled, but may be a fake group
-		 * referencing the root TSAR if the esw doesn't support groups.
+		/* Contains all vports with QoS enabled but no explicit node.
+		 * Cannot be NULL if QoS is enabled, but may be a fake node
+		 * referencing the root TSAR if the esw doesn't support nodes.
 		 */
-		struct mlx5_esw_rate_group *group0;
+		struct mlx5_esw_sched_node *node0;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
@@ -436,9 +436,9 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
-				    struct mlx5_esw_rate_group *group,
-				    struct netlink_ext_ack *extack);
+int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
+				   struct mlx5_esw_sched_node *node,
+				   struct netlink_ext_ack *extack);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.44.0


