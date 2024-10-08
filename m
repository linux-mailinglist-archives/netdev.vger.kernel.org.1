Return-Path: <netdev+bounces-133263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB89956A2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC16D1F25B75
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81D213ED1;
	Tue,  8 Oct 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ri0VqNx9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A28213EFE
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412411; cv=fail; b=dVh0ZTDADUGr8amyWiF756JGbkqMlAWvRFWWahFYaC6BSN1KlQdLtA51J/7zKiU3eS6Cl5cCz8OX2W2iQ8+csNcuxYpSCEy18JpIq4UnV0b1H7lRsPHzx3PCSaEtonpZ47Gi+m3y96kYmAFjgtZxKVZp8vjzQw3yAY7duX3ZMYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412411; c=relaxed/simple;
	bh=Mtfz4zXMaFpZJhOzpw7xif/mWEK3K2tGVr3qdLx9SC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwAcD8dcRKmzx5gGXsYEssbXSnnSYYVtEEI12DL2rfe/L3KRyDf3BQmyxKBnJoGsGu6vdjSEoapMvFX6DCmmkAW9QBlhyW7785Wc1HAVvH6W3LqWn7tDl/b1hb6/4dO7WaUFFP0TyQiLlFnMxg9PU/kotbp39Da0KkIBVSZE+Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ri0VqNx9; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlGBusjZBP5vNJQj4D7hVFHmHYhPWMGIyX83K0zoKRA3938fLEwuNIFYb8y8FHnjoPNuUaVTFSYOKdxBtn8JGk37tY7jx/w4AliMozHMLvq2ocdyHAryiNgQFVc142JjqtoKbaa9Zxqk1XUCmzcBe1U+MNyj7vH9JAWOJPwuO7Ss+uqY/RYeI2ajjsJcKVBpvmM2WZRCbLYCpQ07wvhehVd91imA0c3fTkD33DtfDnlBQqFsVD5KgT81/7AEixbilJMAvjE1BlNXuGihT+JlDYd83FzYwaCFl8WT0msyD3Df+Fqmz3/Zvmbgvd9L8jHNoerxGXGOQ1VPKyDxkfRK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWgY10692yxidj2M5/1VaQ8/XE1lo5yllzVLXHqyMKQ=;
 b=ZupRoX4bpNWylzF4f0+ckh+DDXPpe3dCDRp9+z8QClgMEc4DXZmphyl2dBxnGaQWMbD2cPb8EZGE7wphXJz48j7A0fLqoqsa6T0nwQqsAjRlkh9gQ9kKKTNbGEHWlTJI/OSAVNPluG1Bozlfwd/EcCPLspw3NaN0VvYkeixr23GAyRjCQoqFRjcmM2SAGPa5Wv6fGoAA6TiUgQOyZM4CjlQqPWWATV7HNemc19ldw3riA/CVo5VrGQZvKpl1f2WcpvdjM4b12Hmmx3G2opeR7GyXFvSRSHV+vyqr2gJxNB7IuFnp0noW5R3EPy1665z6FJZnEzIV6yqr85R0eEXzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWgY10692yxidj2M5/1VaQ8/XE1lo5yllzVLXHqyMKQ=;
 b=ri0VqNx9vNMhUrLsGjrYAypBXrL4MgE073NZ+GQOtK0MQZO39Y2nJYg8Im7GzBUu0E74MJa6aZSrGP+c5MpHnaGtNXfohZ4+9pcaQtSaTIuG6LQNMjUx2nr+C/jRa6uksUEk6T50FxMb4QdnX/3XwNb/LRPLCUxs6xbZchiM8tQHwgpyGM+8pdqmLZ1NlIE6M6V1wbK7WJvD6NyYPvNyJnCOdjVTeIdeDvqaIAnI5NSg3LsR6Acc7C+F5mL24b3FLDWeQ9ZcqWNT7igtVGvky0ITf1fFVw0fjypBRBYtfwPgzkVG1uN4xkX3Q9OOwzYyE3Cur+3x8dSubsDfD0dAzg==
Received: from CY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:930::19) by
 MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 18:33:17 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::2f) by CY5PR13CA0005.outlook.office365.com
 (2603:10b6:930::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/14] net/mlx5: qos: Rename vport 'tsar' into 'sched_elem'.
Date: Tue, 8 Oct 2024 21:32:10 +0300
Message-ID: <20241008183222.137702-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b9abc1-449b-4776-a91c-08dce7c7ace4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GrT9J/gfVEbxBhC/ZsETYfMc+QEPFywHfzBxEWyeMM2E/vbIabR/nRjO9um+?=
 =?us-ascii?Q?uZ9wx9YDt2JTI5U0Vh+bBhsdOUWJaEe7EaPtXq52YnLmrIJqhrmc8Lm3WVW/?=
 =?us-ascii?Q?2ZuLakYC9wGszcYsF+f8zsXUq4SzIdRCV7NdteAU9H7wxT7meph7gYkB0HbR?=
 =?us-ascii?Q?LD0UiJdl0qq6qt8Nf49Iz7DseT+Qq2vv7Y+t2Z1GGYuclzm2ycEoFi5VPV9M?=
 =?us-ascii?Q?nOItLtxuGIEiZnec4xwSR8mAzX+OWpi/GmL/4n4g5nwGZlWUUge4OAgW1ObI?=
 =?us-ascii?Q?082T93S/aeTMkDZEWzVLMUpoGh2zlZnQ4BaJ/4kuOrGNe/JNzELVwUEAJDSJ?=
 =?us-ascii?Q?vNExD/jRqmqJZbObHqZyTZBITRYFTyZe5hHW5pBFvyQw7NA80bPC2S354k9E?=
 =?us-ascii?Q?UF8/TX7EnT78dMJZFnzIFNYFuVqN3b4mH0Kk6RABX8WOtabyjDuoN3+0nlo/?=
 =?us-ascii?Q?H/0r1C5JItjC7kAuTd+JwxWua3cc30VbzFrkl6QVCyXG9kCMVPtjrxrCSPFc?=
 =?us-ascii?Q?x+fqOl290oDQ3DaEz+T3/F8xHRXtLeVwTX6i9Og56JjHZIAnujdlWfyJqmrf?=
 =?us-ascii?Q?N25HvD9NGIqGcDnMhvijawsZLfACw4pfBvwA29AONEl+0izgVjwsGhTcDuSv?=
 =?us-ascii?Q?THIFu0ytZwMAWIdwoq+EnY5mV5l+KLqYhJJjGjlVHRBCdPlYzSc9mUI9aBp4?=
 =?us-ascii?Q?fXU3eznsGmeUkooapO1CVJRLME3FfqTQFVarnoIvY0sjw3FchQi+hgc/IAaf?=
 =?us-ascii?Q?Fj60M+3Svt8BGEjuc9lxJIFNv/km+9kRgAXWXWf8zTFF1qyXKo4clAgk1Nev?=
 =?us-ascii?Q?nnRutsj7efjmXtEO1mMPiRfyvhcMWBv7CTHm2EZWbJeD9V66Ukd2iX9a1tWQ?=
 =?us-ascii?Q?cW0T2oIAiGWuKPae8LNEVyPvnDaZS4PD1j+51XFezjj24ygDmElHxc48/lHb?=
 =?us-ascii?Q?p+AajOb6jy15HCFMAYvXbXigw/TWNXUIT+Q1SrnjLGop+soII9sycov5DSFV?=
 =?us-ascii?Q?I1JwEs1rv4wuFpPPObe4Es9kWmGDARl8XIYUoMahgCjFpbO5KAVshoOpDvfU?=
 =?us-ascii?Q?ydNxpngLGU4Kqe3JvK/KIpJQW78omApjCRTETuYt4rWCaaKsH00wuVdiHMFQ?=
 =?us-ascii?Q?LGBcoEinepf9oPP+YMnNcOhdZtbHZlq44q2dmpoiYx3dK3buRe20/dlOYZ8A?=
 =?us-ascii?Q?hp76ZjQWN8iOei92xeHEvJa/4oVuB4UbGdIjCHaXhSQGZ4FdKkWF4eF78ST7?=
 =?us-ascii?Q?tVb4D0PGVIoIUw0jrYqqbbclQRT2hf/Rn9KQqibXkYrzb2pra3tfaogJZoGe?=
 =?us-ascii?Q?BNoBYMjFzdtA8jdmfKxmYo36Rimzjagi8mJE2hV/wawmSfes/7ks1PY9SbNY?=
 =?us-ascii?Q?r1iO2AKYAGVu2f9U0vlkfMehAeA6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:16.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b9abc1-449b-4776-a91c-08dce7c7ace4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342

From: Cosmin Ratiu <cratiu@nvidia.com>

Vports do not use TSARs (Transmit Scheduling ARbiters), which are used
for grouping multiple entities together. Use the correct name in
variables and functions for clarity.
Also move the scheduling context to a local variable in the
esw_qos_sched_elem_config function instead of an empty parameter that
needs to be provided by all callers.
There is no functional change here.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/esw/diag/qos_tracepoint.h       | 16 ++++-----
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 35 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 ++--
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
index 1ce332f21ebe..0ebbd699903d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
@@ -15,14 +15,14 @@ TRACE_EVENT(mlx5_esw_vport_qos_destroy,
 	    TP_ARGS(vport),
 	    TP_STRUCT__entry(__string(devname, dev_name(vport->dev->device))
 			     __field(unsigned short, vport_id)
-			     __field(unsigned int,   tsar_ix)
+			     __field(unsigned int,   sched_elem_ix)
 			     ),
 	    TP_fast_assign(__assign_str(devname);
 		    __entry->vport_id = vport->vport;
-		    __entry->tsar_ix = vport->qos.esw_tsar_ix;
+		    __entry->sched_elem_ix = vport->qos.esw_sched_elem_ix;
 	    ),
-	    TP_printk("(%s) vport=%hu tsar_ix=%u\n",
-		      __get_str(devname), __entry->vport_id, __entry->tsar_ix
+	    TP_printk("(%s) vport=%hu sched_elem_ix=%u\n",
+		      __get_str(devname), __entry->vport_id, __entry->sched_elem_ix
 		      )
 );
 
@@ -31,20 +31,20 @@ DECLARE_EVENT_CLASS(mlx5_esw_vport_qos_template,
 		    TP_ARGS(vport, bw_share, max_rate),
 		    TP_STRUCT__entry(__string(devname, dev_name(vport->dev->device))
 				     __field(unsigned short, vport_id)
-				     __field(unsigned int, tsar_ix)
+				     __field(unsigned int, sched_elem_ix)
 				     __field(unsigned int, bw_share)
 				     __field(unsigned int, max_rate)
 				     __field(void *, group)
 				     ),
 		    TP_fast_assign(__assign_str(devname);
 			    __entry->vport_id = vport->vport;
-			    __entry->tsar_ix = vport->qos.esw_tsar_ix;
+			    __entry->sched_elem_ix = vport->qos.esw_sched_elem_ix;
 			    __entry->bw_share = bw_share;
 			    __entry->max_rate = max_rate;
 			    __entry->group = vport->qos.group;
 		    ),
-		    TP_printk("(%s) vport=%hu tsar_ix=%u bw_share=%u, max_rate=%u group=%p\n",
-			      __get_str(devname), __entry->vport_id, __entry->tsar_ix,
+		    TP_printk("(%s) vport=%hu sched_elem_ix=%u bw_share=%u, max_rate=%u group=%p\n",
+			      __get_str(devname), __entry->vport_id, __entry->sched_elem_ix,
 			      __entry->bw_share, __entry->max_rate, __entry->group
 			      )
 );
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 7154eeff4fd4..73127f1dbf6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -22,9 +22,10 @@ struct mlx5_esw_rate_group {
 	struct list_head list;
 };
 
-static int esw_qos_tsar_config(struct mlx5_core_dev *dev, u32 *sched_ctx,
-			       u32 tsar_ix, u32 max_rate, u32 bw_share)
+static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_ix,
+				     u32 max_rate, u32 bw_share)
 {
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	u32 bitmask = 0;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
@@ -38,20 +39,17 @@ static int esw_qos_tsar_config(struct mlx5_core_dev *dev, u32 *sched_ctx,
 	return mlx5_modify_scheduling_element_cmd(dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  sched_ctx,
-						  tsar_ix,
+						  sched_elem_ix,
 						  bitmask);
 }
 
 static int esw_qos_group_config(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *group,
 				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
-	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = esw->dev;
 	int err;
 
-	err = esw_qos_tsar_config(dev, sched_ctx,
-				  group->tsar_ix,
-				  max_rate, bw_share);
+	err = esw_qos_sched_elem_config(dev, group->tsar_ix, max_rate, bw_share);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify group TSAR element failed");
 
@@ -65,20 +63,18 @@ static int esw_qos_vport_config(struct mlx5_eswitch *esw,
 				u32 max_rate, u32 bw_share,
 				struct netlink_ext_ack *extack)
 {
-	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = esw->dev;
 	int err;
 
 	if (!vport->qos.enabled)
 		return -EIO;
 
-	err = esw_qos_tsar_config(dev, sched_ctx, vport->qos.esw_tsar_ix,
-				  max_rate, bw_share);
+	err = esw_qos_sched_elem_config(dev, vport->qos.esw_sched_elem_ix, max_rate, bw_share);
 	if (err) {
 		esw_warn(esw->dev,
-			 "E-Switch modify TSAR vport element failed (vport=%d,err=%d)\n",
+			 "E-Switch modify vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify TSAR vport element failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify vport scheduling element failed");
 		return err;
 	}
 
@@ -357,9 +353,10 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	err = mlx5_create_scheduling_element_cmd(dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
 						 sched_ctx,
-						 &vport->qos.esw_tsar_ix);
+						 &vport->qos.esw_sched_elem_ix);
 	if (err) {
-		esw_warn(esw->dev, "E-Switch create TSAR vport element failed (vport=%d,err=%d)\n",
+		esw_warn(vport->dev,
+			 "E-Switch create vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 		return err;
 	}
@@ -378,9 +375,9 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  vport->qos.esw_tsar_ix);
+						  vport->qos.esw_sched_elem_ix);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR vport element failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy vport scheduling element failed");
 		return err;
 	}
 
@@ -683,9 +680,9 @@ void mlx5_esw_qos_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  vport->qos.esw_tsar_ix);
+						  vport->qos.esw_sched_elem_ix);
 	if (err)
-		esw_warn(esw->dev, "E-Switch destroy TSAR vport element failed (vport=%d,err=%d)\n",
+		esw_warn(esw->dev, "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 
 	memset(&vport->qos, 0, sizeof(vport->qos));
@@ -809,7 +806,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 		err = mlx5_modify_scheduling_element_cmd(esw->dev,
 							 SCHEDULING_HIERARCHY_E_SWITCH,
 							 ctx,
-							 vport->qos.esw_tsar_ix,
+							 vport->qos.esw_sched_elem_ix,
 							 bitmask);
 	}
 	mutex_unlock(&esw->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index f44b4c7ebcfd..9bf05ae58af0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -213,9 +213,9 @@ struct mlx5_vport {
 	struct mlx5_vport_info  info;
 
 	struct {
-		bool            enabled;
-		u32             esw_tsar_ix;
-		u32             bw_share;
+		bool enabled;
+		u32 esw_sched_elem_ix;
+		u32 bw_share;
 		u32 min_rate;
 		u32 max_rate;
 		struct mlx5_esw_rate_group *group;
-- 
2.44.0


