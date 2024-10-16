Return-Path: <netdev+bounces-136213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E19A10C9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038E81C2225C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B282139A4;
	Wed, 16 Oct 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQHYAW1F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC212D0A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100264; cv=fail; b=P/yeUi5Gdq0FOusLGOlokk8ahEvw4W8eP+1I6/f3Gpjuah4maQaro/fFGj15U9lEPtLyp8rq1W6oAyOBUJnjTRwWQfKlI6RusrdMHpgCNid/zqEuPcytHk818jaRQG4+KJHjEnBaagA6T80k9HqpCXPx8MO3gg1G/JI6zL/a3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100264; c=relaxed/simple;
	bh=/qmFPBdQ8nsWXF/vdbPqocuO3D3DsYbxgRR+jX67xRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+Dw1d1wzkKreGq9rciyjPV8E9keBQG6XJ93kAA1xZ/t5iU2q+Y6nGlCVOvgrOO5f9rPrQAxnhSNzpf8ngyzjjT/3FVqM5FQuJyMuEm7n/Kee3Vpq89YSv87DC8Eva/qTGLmQ0K518usbMeFXR6TwtF++3XRBfoaoSUSGUtZdCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQHYAW1F; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFyYjZqWmHMmVe7pna67JqqfMugMdFoccwUoTslZoasM2AH5rOFdWKxx7SmFnfYFt9SSyZrhrY4OAnhG/z9S31GbiIJJsd4Xp2jTSYCdHbA9Xy5cqz4P/qTAK+3rrvOM/q6yOjoXDyXKPwNstuUNZK0Ul2Pnbon5iva+GE6t3M23L5JEJcKbS47e07tw4nR8B+yW0ODBMSWE0+8PLFYVMqiaDbganWy8ldJ99QFX0FaFkaK+tGH9xLa07Fl5Xby+OlOiRcCib/m0tHU9Ai4Ce369vDcB2XbFbqbBVy9AtFpOh0OvRIZ35F3fo81teT1R/vbVaDVLyH5BNGTNA8x9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4XuQC+bQjDsbbpmrjq4JrPHpUlshQfEG3amK5TzFJw=;
 b=WWg0dIldzN2w/+lEze8rkZLqWgmbiFEbHJMSxvHaqIA6VO7ReL7qh2QFfUElOsjw3EZx5/T8b6FyqAtPyyCQR/3yKg+wYY63OD9O5DeYHBivcZFBoP3WiUZjOhlc5+FQjb0ZHuogfTbBWxopWnPpqcA+4QBUMlN89FN6USukVmKh+XbM4gNQrzRVGPQ3vwYJ34mzR4y61P9v60ENbIMuitN0N64arsYj3Rn31g3uDreSJwXnb8bC38M2UKAQWSpf4Yt/26VFBOcFIH+X5/8hLAJhqkDXA7vpdyUIoqdRsA4PP/nLCSrFsYukeQiOjQ2O7yaeuGrotPFEgTvndqxkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4XuQC+bQjDsbbpmrjq4JrPHpUlshQfEG3amK5TzFJw=;
 b=RQHYAW1FVATfXHLIpJNwaAHG2Uh+j2forwJJc0ZkFbKN5AmkgHSKqMRVaUSoeRI2vZxwNwTJ0nIXi7CGD1AXgInPh65cXT46mbs2NaDDEMjUuRGZqxdfaWN+iEvfPXXP1os0qflyVK+mb8NDjMkCxkv7Qh+8R6DYkQePmpvYjkoy0QI+nMddOI//vH6MWPPxg8VjpnFPxR9q3mZufgipEVGYPEX8j30WDoh2hURQR+cgZ2/raOic/tNsjNrhtHDbqMkvOHTbL9pLJtv/LheUV4BLBRiZseWxmUJxtvYUoRlxUf+IeMH7d+9cHsZDhOpj0xfTzTEUiYIszgFXfzYmAw==
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:37:32 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::bd) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 06/15] net/mlx5: Introduce node struct and rename group terminology to node
Date: Wed, 16 Oct 2024 20:36:08 +0300
Message-ID: <20241016173617.217736-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: da79ea1b-9933-42db-ded0-08dcee093732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grhxk+o5TIcO6OdoFt/FepI4sM11X630zZE+gMFmQawFx8EoFMc/S8CihdfR?=
 =?us-ascii?Q?Tw7/cKxb2ssRv5swYX2mcx0GpMZjH0iPWMakXY+b1cpFkTp9sd0q9anMJ/9M?=
 =?us-ascii?Q?5kDp0k+XpMI2OT+Jew+K3fyUbZtcJgASeBB3uweH/y6MHoBq2BHOtB4Iifmu?=
 =?us-ascii?Q?TC4YpfekmDQOgyK0gAY9KoxHtFqk3OEVqhf3WDtwC/rrbFM+WBsjqUlpx0qS?=
 =?us-ascii?Q?HH/jvfzElf+Fq8xp+WVbp26MpWxsUYwT4sXBgADAmw3YCfkUXGFKUxfBCtC+?=
 =?us-ascii?Q?8AGgyBfFwdFUTNZ5d7t1wMOj5xf2lPxlajxMRZ8xq2dhHB24YXDyqTiGvUV9?=
 =?us-ascii?Q?bMst30Wkq67IDIvN4l6DGdL+fqrdaLaY3z5La6okAAtDUcgC/q+904Q6rllM?=
 =?us-ascii?Q?yq9KWxY1Dp1xTHMlJ6yoFfjyKR5ojJIKkWuvYrgey1b/5/VQquJnGPSx+7Dd?=
 =?us-ascii?Q?VRz7Dp3jspPySEINN1jGgl/LfSgw0tEhY0y0ca5xJyMxm9Kd8XmyrTVvdLAb?=
 =?us-ascii?Q?dJ/wI/Tu7xmFdJrPGo09oCKyRI/+RQt/W6mXgSky+JQ0dfg08qu/ukwyMkAG?=
 =?us-ascii?Q?W3ldqcS37+Xp+TjHYsvbGF9SpVcKkpGZdxwV9COv3lSjS3ZlSzz8krDVPUGB?=
 =?us-ascii?Q?QK2tlaj+kfxTh1wnbiY+Osh9vztWiIQzNmCZge17rzGL8zed6we5CIn4YWNl?=
 =?us-ascii?Q?Klzl2MFi6vlLYqZ21h1+R/hepyL2o+Osk102TzUy8ZrDbzl5xkU57jRQNMjU?=
 =?us-ascii?Q?zh3yIf0tr9jAMlW3wK8DDqq1RMc2IiF/Ax10F3QF2CJ45C20VndZWvxkTrPc?=
 =?us-ascii?Q?gezlnF08reauRbZktX6tAmE+JZhF7enhTTHHmH3ACdTTrRSod052YBM6z37y?=
 =?us-ascii?Q?zp+da3sfzmLpcFrbxaihnODB9hOhBwHy+VYJspkKSq+98UHGfYfbUAMqbNXX?=
 =?us-ascii?Q?a6SrVt9iUJ6xvPhErzio0wyUr/429SpBj70F9qXET4oudcn6MF/UMANSmvvf?=
 =?us-ascii?Q?PwTBCfFs2wgMjbDfXs/8Gu3a4FsLLtkz5PaFHq3RULedbkn8Rdn/l22nf0d9?=
 =?us-ascii?Q?GDnEI/hvXXb1FPxD5Ucfo508xtujKvQU8lm9f3g4YQGcjQD23VS9kqys8J9j?=
 =?us-ascii?Q?2cCCT4AURN1cGvxN2l7DsQiqXqYsW2UxjpCDKX6WU1jNIUmvUOtMteJRyCYM?=
 =?us-ascii?Q?8p7vZI6QR8BVAfKw4hps4T5qzbPnBlu+EDa9gz2ISItcVAT+0s5OCmxLJzKL?=
 =?us-ascii?Q?oGCQRnXU4XYsXWwLBP1QPNPb9LLjTWgKwene0MkakYWlNAXMes+PqANC7fUU?=
 =?us-ascii?Q?PpbhwdKa2/sUF27BZj56LROliPltmaxZGEDHSeWoc/i7iq0bxn+o5wSnZu3K?=
 =?us-ascii?Q?6C0NMEc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:32.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da79ea1b-9933-42db-ded0-08dcee093732
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315

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
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../mlx5/core/esw/diag/qos_tracepoint.h       |  40 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 374 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  16 +-
 4 files changed, 217 insertions(+), 215 deletions(-)

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
index 837c4dda814d..840568c66a1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,12 +11,12 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate groups associated with an E-Switch. */
+/* Holds rate nodes associated with an E-Switch. */
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
@@ -458,129 +459,129 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
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
+__esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
+		     struct mlx5_esw_sched_node *parent)
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
+static struct mlx5_esw_sched_node *
+__esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	u32 tsar_ix;
 	int err;
 
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
+	node = __esw_qos_alloc_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
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
 						tsar_ix))
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
 	return ERR_PTR(err);
 }
 
 static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack);
 static void esw_qos_put(struct mlx5_eswitch *esw);
 
-static struct mlx5_esw_rate_group *
-esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+static struct mlx5_esw_sched_node *
+esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -591,31 +592,30 @@ esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	group = __esw_qos_create_vports_rate_group(esw, NULL, extack);
-	if (IS_ERR(group))
+	node = __esw_qos_create_vports_sched_node(esw, NULL, extack);
+	if (IS_ERR(node))
 		esw_qos_put(esw);
 
-	return group;
+	return node;
 }
 
-static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
-					struct netlink_ext_ack *extack)
+static int __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlink_ext_ack *extack)
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
@@ -629,32 +629,34 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
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
+		esw->qos.node0 = __esw_qos_create_vports_sched_node(esw, NULL, extack);
 	} else {
-		/* The eswitch doesn't support scheduling groups.
-		 * Create a software-only group0 using the root TSAR to attach vport QoS to.
+		/* The eswitch doesn't support scheduling nodes.
+		 * Create a software-only node0 using the root TSAR to attach vport QoS to.
 		 */
-		if (!__esw_qos_alloc_rate_group(esw, esw->qos.root_tsar_ix,
-						SCHED_NODE_TYPE_VPORTS_TSAR, NULL))
-			esw->qos.group0 = ERR_PTR(-ENOMEM);
+		if (!__esw_qos_alloc_node(esw,
+					  esw->qos.root_tsar_ix,
+					  SCHED_NODE_TYPE_VPORTS_TSAR,
+					  NULL))
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
@@ -666,11 +668,11 @@ static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
 	int err;
 
-	if (esw->qos.group0->tsar_ix != esw->qos.root_tsar_ix)
-		__esw_qos_destroy_rate_group(esw->qos.group0, NULL);
+	if (esw->qos.node0->ix != esw->qos.root_tsar_ix)
+		__esw_qos_destroy_node(esw->qos.node0, NULL);
 	else
-		__esw_qos_free_rate_group(esw->qos.group0);
-	esw->qos.group0 = NULL;
+		__esw_qos_free_node(esw->qos.node0);
+	esw->qos.node0 = NULL;
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
@@ -716,7 +718,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	INIT_LIST_HEAD(&vport->qos.parent_entry);
-	esw_qos_vport_set_parent(vport, esw->qos.group0);
+	esw_qos_vport_set_parent(vport, esw->qos.node0);
 
 	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
 	if (err)
@@ -743,8 +745,8 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	esw_qos_lock(esw);
 	if (!vport->qos.enabled)
 		goto unlock;
-	WARN(vport->qos.parent != esw->qos.group0,
-	     "Disabling QoS on port before detaching it from group");
+	WARN(vport->qos.parent != esw->qos.node0,
+	     "Disabling QoS on port before detaching it from node");
 
 	dev = vport->qos.parent->esw->dev;
 	err = mlx5_destroy_scheduling_element_cmd(dev,
@@ -1004,8 +1006,8 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group = priv;
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_share", &tx_share, extack);
@@ -1013,7 +1015,7 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_set_group_min_rate(group, tx_share, extack);
+	err = esw_qos_set_node_min_rate(node, tx_share, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1021,8 +1023,8 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group = priv;
-	struct mlx5_eswitch *esw = group->esw;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_max", &tx_max, extack);
@@ -1030,7 +1032,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_set_group_max_rate(group, tx_max, extack);
+	err = esw_qos_set_node_max_rate(node, tx_max, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1038,7 +1040,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 				   struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_rate_group *group;
+	struct mlx5_esw_sched_node *node;
 	struct mlx5_eswitch *esw;
 	int err = 0;
 
@@ -1054,13 +1056,13 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 		goto unlock;
 	}
 
-	group = esw_qos_create_vports_rate_group(esw, extack);
-	if (IS_ERR(group)) {
-		err = PTR_ERR(group);
+	node = esw_qos_create_vports_sched_node(esw, extack);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
 		goto unlock;
 	}
 
-	*priv = group;
+	*priv = node;
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1069,36 +1071,36 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
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
+	err = __esw_qos_destroy_node(node, extack);
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
@@ -1109,12 +1111,12 @@ int mlx5_esw_devlink_rate_parent_set(struct devlink_rate *devlink_rate,
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


