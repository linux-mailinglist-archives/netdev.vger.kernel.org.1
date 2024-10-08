Return-Path: <netdev+bounces-133269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DA9956A8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2822871D3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002E215023;
	Tue,  8 Oct 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdbRMpsX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D608213EEE
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412426; cv=fail; b=gtGb7VVhe595FDUD/+e6tipcv40diQBFRbS9CN7uoznXp+z73kugnrWQkWAZm7OGJruyF6cIIbVZhiRfvGxN1jdyPGiiK8+j4pvIM8Qmy1XYFYd5sIXaohZkzm2oeBFnVbueiwNMUPe7FsMIS6kfPBVivyzHmLVK0xF6G+vy1pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412426; c=relaxed/simple;
	bh=DzKGIHyutrb3uOP1R4ZDX/oOoZvAdZv+O79e+avooZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrVl7SruYj9aIPDTn/PkBsKSpJBUQyzyGY5CvrrPpJLrxVMK2/f5jBbB1mrz4WHWMEt6sk2btSVAbxlesD8YGPmGtPUE6NBvOwfzGCRRHKsvdCI07Q0YoDd2pVpXA/j02GaSgBYV5uHejr5PtsOad8l1TEll4k3mVClOubh1MPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdbRMpsX; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKjSmHwplr/WsTJ2WkSCNsfczy71GhNpeiA/AC9KoTGL6t8Z7pPFLLIou7YGKAsPF6sBq2Lw3W+k9TBz7HRtTfnhSJTes9fzrxJOCAimzdWaF5kpScm7H4KXgBimwR6riOZh1TZg5qwYS+/1iPyKusFlt1pfWqkDnhNQQ94Ho90eAlH5EG42vnGWKkdioBUfhEBLgzIDdRR8Ng7ys4GNPTZ/rrAKJiw7M55QSWUg459AqIF/wgOBX9OpTyJPeFEaprjtjOpvoFXZBzJGN8NetAMaSlfg8tN3IaodBxiICtlmg+672JEiHK39mMt/+wmWXHp6mBuok3yAW37wyoIi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afruZfTST3sZdZxLdav2JsIwo1WK6mbliBVNEv2uu80=;
 b=JuQ6La1m27F++PqyAXIkJU7fDjhCgLRSqaWei2c+nE9VJN8tu4XAUo0+3NU2igXliEoY9F4jd4Lsn14TK16qbN/UwbROLbqsqFHXYPZ6ADyquQfs15KbHZnqX8qaVNj2uCdIVJOms/6kvma4M6GCtYe5mTkBu1jv553Dkj9sq1m14+5oEUX0b9Uq75BIO9KhFcPaUUxP5TzJWDtQIuLO264gVM11gQGpd4ZrGNjTsH4uxdm8wfw15KQV4/DDhw0tBR1dnISTIzSKBCXaFEYKD2Zy0DiMyJzWHJFksmbfjkzVOdDuAS68LEWskeQu49FcAzscYW44kWvcJ2iloV3Ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afruZfTST3sZdZxLdav2JsIwo1WK6mbliBVNEv2uu80=;
 b=PdbRMpsXl3LRU2F8Ngx3+zmRpiVY8shXl94iYW5CapA41czfu6Cu3hbDmg2BX1amV80gpjK8/xeI+Q9FHWmfBTuqwbNxe4unSS2LoZHQ672ZZYu3uK/NHyLejQxywkO2Vsu7acAd6hGoQ9l8yElPmwWwHikQs/xxWO6iS+JlcTcl6La8rAqRjnb2+O+WZe4LKdotHtNkSSK5G74UMXdmIe9reYEPJn5LBWXGZRhjlA7AcYgl1xuNYGJIyeJtyMsLWMytRLFEpKPh6c1MfyXhHW4fmbTGSf174YGfvRWB6BMH7tmUVuTNeMkzcJ856xbMlF8n100IcJ0au5ccWDnkhQ==
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 18:33:41 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7d) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/14] net/mlx5: qos: Add an explicit 'dev' to vport trace calls
Date: Tue, 8 Oct 2024 21:32:17 +0300
Message-ID: <20241008183222.137702-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfdb0ff-b892-48ba-71fb-08dce7c7baf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rb8xhoOpq4TVY4Ubx9vdt4LugNlImutoRjsiRztvz0q04ls9FG1XdEiEkoZX?=
 =?us-ascii?Q?4DEmfp45GueZNE+NHGeEAPO1/myoQbpZaW+sxUpDmKMIddDCAXgz4CYZHlHd?=
 =?us-ascii?Q?Z+ldV9oT/q2xUZTes6xX/1/IkQP94eLJW5XGzgDNjyonoGuDICSsBPlMfKwf?=
 =?us-ascii?Q?nMfNlJGz+ihm6XD48aPedqguABFmoJYRF58q8/soyFx/673LblotaYL7JTQz?=
 =?us-ascii?Q?r2Ys6Ixi8Oj9fUa/JgfET1v7w4Uu+DVWVOu+sCI2YO1E0QF1E9ZQCbwkFAHy?=
 =?us-ascii?Q?oGtlrSbg6HMjfEGHnzG0G8dAcrHcfGqa7fmMYqNkHRdnvmWUUAXFNz/3+iLP?=
 =?us-ascii?Q?/qRajWEni8lTE1uMzE/0hAoZgH16dUFPVG9Nb6S061kOcd73cgBQZj21v7cj?=
 =?us-ascii?Q?WVkN/7lTRosGlktYFbn6pcMkq0qDGvHnzjUhOFNeWo8S6gI1XKxTHBzDi1QF?=
 =?us-ascii?Q?6siVa4/nC3nzHeWZwE+Y1DpIlJsvzbJAruuWPzrkZL1fvK+mf3v/ixPTOY/J?=
 =?us-ascii?Q?6CfsymSm8WMYRhK6XxkRoPJc4MUi800ILDBeqYiLf0C7V6w7ONL0o1KAubRv?=
 =?us-ascii?Q?4hTgKDJ6rjpe3M2/MmnZ5wjWgUQhGVoPyh2A38QXv/F/0425MPhKYW60JKpL?=
 =?us-ascii?Q?kN+e61kBoTtvSOougV99pSPzAV/WrSwViftaXRHXWm2L8d3Y1+4ABR7cnxtm?=
 =?us-ascii?Q?G+2D2w4qTsM8WWgDAUf/7EGN2XFd3KFPog2yc8B4u+grLVd9QOJa+l0WCCGi?=
 =?us-ascii?Q?v78ZC38dTEO9uaW0tNUyvkOHO6MdYY5LjUGC9JjEmHHIxyBsKFtVyBvhqCi2?=
 =?us-ascii?Q?5KShLTnUxjG9SIUnCrGvXPl4piyQPFVo+Yj8HAGyL/NQdve8shjYos8Jht4K?=
 =?us-ascii?Q?tSEBHGTqB9WolA4byK53wlEcH08OWMs0CArzii1BFa79gX9q6mBnYe/grIzE?=
 =?us-ascii?Q?0JaFOSP6+fV7WEJ7g6DBmm6wmxBN3/XflYb5w/MLO/FD2YD5gQjXdOihBUDq?=
 =?us-ascii?Q?IHMNtHGiQ4QFy7P9ee9slhrCSlZy2v/Q7Kp4m/qI+QRkDLPY5Ps7raIzuuD1?=
 =?us-ascii?Q?8BNk1G7ZoneUFEO1jcPNe4Cw20Oz93MeMW29MpzcuqGJcVzcW853pj1OWGBt?=
 =?us-ascii?Q?Z67P5Auz2fKoBegFeNIPPhYKPfa8z9y+RxrLhr584rJdT3e5MnFJhyE2Z93v?=
 =?us-ascii?Q?8szu+/7KbdKOoRyU+HZr1Sv/oIAFWYIsmJ3RkIO8Ufh9waR0FY8fzVUQVHpX?=
 =?us-ascii?Q?lqg7nI/90URAjaC3emvNtFdoRnL1NCy/AJmbCeNYdYlX7ZtWfhHnS73VV9Cy?=
 =?us-ascii?Q?it0WVcx2zC8ew/uXQIpJnqvNFSRZfbilHLmzfknxpysD5ocFrhFeCJ9uQgR5?=
 =?us-ascii?Q?DraSXmKV6JYcGJeOdnKcAZhiOpnk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:39.9477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfdb0ff-b892-48ba-71fb-08dce7c7baf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

From: Cosmin Ratiu <cratiu@nvidia.com>

vport qos trace calls used vport->dev implicitly as the device to which
the command was sent (and thus the device logged in traces).
But that will no longer be the case for cross-esw scheduling, where the
commands have to be sent to the group esw device instead.

This commit corrects that.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/esw/diag/qos_tracepoint.h       | 23 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  6 ++---
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
index 0ebbd699903d..645bad0d625f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
@@ -11,9 +11,9 @@
 #include "eswitch.h"
 
 TRACE_EVENT(mlx5_esw_vport_qos_destroy,
-	    TP_PROTO(const struct mlx5_vport *vport),
-	    TP_ARGS(vport),
-	    TP_STRUCT__entry(__string(devname, dev_name(vport->dev->device))
+	    TP_PROTO(const struct mlx5_core_dev *dev, const struct mlx5_vport *vport),
+	    TP_ARGS(dev, vport),
+	    TP_STRUCT__entry(__string(devname, dev_name(dev->device))
 			     __field(unsigned short, vport_id)
 			     __field(unsigned int,   sched_elem_ix)
 			     ),
@@ -27,9 +27,10 @@ TRACE_EVENT(mlx5_esw_vport_qos_destroy,
 );
 
 DECLARE_EVENT_CLASS(mlx5_esw_vport_qos_template,
-		    TP_PROTO(const struct mlx5_vport *vport, u32 bw_share, u32 max_rate),
-		    TP_ARGS(vport, bw_share, max_rate),
-		    TP_STRUCT__entry(__string(devname, dev_name(vport->dev->device))
+		    TP_PROTO(const struct mlx5_core_dev *dev, const struct mlx5_vport *vport,
+			     u32 bw_share, u32 max_rate),
+		    TP_ARGS(dev, vport, bw_share, max_rate),
+		    TP_STRUCT__entry(__string(devname, dev_name(dev->device))
 				     __field(unsigned short, vport_id)
 				     __field(unsigned int, sched_elem_ix)
 				     __field(unsigned int, bw_share)
@@ -50,13 +51,15 @@ DECLARE_EVENT_CLASS(mlx5_esw_vport_qos_template,
 );
 
 DEFINE_EVENT(mlx5_esw_vport_qos_template, mlx5_esw_vport_qos_create,
-	     TP_PROTO(const struct mlx5_vport *vport, u32 bw_share, u32 max_rate),
-	     TP_ARGS(vport, bw_share, max_rate)
+	     TP_PROTO(const struct mlx5_core_dev *dev, const struct mlx5_vport *vport,
+		      u32 bw_share, u32 max_rate),
+	     TP_ARGS(dev, vport, bw_share, max_rate)
 	     );
 
 DEFINE_EVENT(mlx5_esw_vport_qos_template, mlx5_esw_vport_qos_config,
-	     TP_PROTO(const struct mlx5_vport *vport, u32 bw_share, u32 max_rate),
-	     TP_ARGS(vport, bw_share, max_rate)
+	     TP_PROTO(const struct mlx5_core_dev *dev, const struct mlx5_vport *vport,
+		      u32 bw_share, u32 max_rate),
+	     TP_ARGS(dev, vport, bw_share, max_rate)
 	     );
 
 DECLARE_EVENT_CLASS(mlx5_esw_group_qos_template,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 3de3460ec8cd..8b24076cbdb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -85,7 +85,7 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 		return err;
 	}
 
-	trace_mlx5_esw_vport_qos_config(vport, bw_share, max_rate);
+	trace_mlx5_esw_vport_qos_config(dev, vport, bw_share, max_rate);
 
 	return 0;
 }
@@ -675,7 +675,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		goto err_out;
 
 	vport->qos.enabled = true;
-	trace_mlx5_esw_vport_qos_create(vport, bw_share, max_rate);
+	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
 
 	return 0;
 
@@ -707,7 +707,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 			 vport->vport, err);
 
 	memset(&vport->qos, 0, sizeof(vport->qos));
-	trace_mlx5_esw_vport_qos_destroy(vport);
+	trace_mlx5_esw_vport_qos_destroy(dev, vport);
 
 	esw_qos_put(esw);
 }
-- 
2.44.0


