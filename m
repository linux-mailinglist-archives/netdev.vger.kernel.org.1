Return-Path: <netdev+bounces-106021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F139143BE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB91C21A71
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD7481C4;
	Mon, 24 Jun 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIVj68De"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DD45BE3
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214300; cv=fail; b=nGss6geI1NedvhF5dRNhyI/+OX1ohSUtouqyMYYmV0a+dP9HbFVIUf7pq+f2k1TDAJ7ZPhi857gwl1H8FVR8ol/Uf+2q7lqVgPIvmv++j0N1sw8naBdWF8ZVfdLOfzPy2LFOj3kS2XBkZwY/xo/hKSiAvogNRSBiPe8EC9pdj64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214300; c=relaxed/simple;
	bh=ktNUg8sBL1IQRMOYkdZYmH7PptDXUxImEn2vACZ+Xp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcJ7j4C2wiYHyzZKescTh102j7F8IrYsvESDz8ODJi/6GaxFIxCwzfKm0+yL1EtDZaxSpAbLVShcS7gOFPkvSPtRapkA7oh8QtddYDdq/3vPizdBjh3+nRsvHTNWneo4gQr1AOQ1RS45OC+P3he0DdomtKuit122zQfmAjtz4CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIVj68De; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+isnIJOPmlRVprPjAe3Aybeqw22KsWNIcT4Wz40NNOC1SQtxcYS5bVJ4H0ozPkHfzKVpqrN9ltaWfylwYrvdbui5JbpBvacZX9l20QGPjKbFar9RHcQzWGJR9z/9bC3S7rI8GwR4M8/CyOdRyhd0Efot+fkT/DSVtbo6ZV8ODs/f8KuB5TT8Y67a0HBfDTlUg3MqJxgxECY+FQZ/Jal2EA9jRCNhMrjAZCZaUExO6y58x9QT6+8RVWeHiGOBIsIuJ3bP+RNguLwYhyExeG8EVKSU06K3jywawjAImw/fhwHE7EQwjiIZDV9eWGM2/h7YjF8xZAm9ZvwzkKplQufbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi91PzOyihEku1JhtFU+H65pLIgENBcLD0FuZZr99QA=;
 b=QMxxqtq46x+uZ2z2xFAORhz50JybTRUWpNxyQDleIdwYUfDP9bkyE9BwuRVkF2aqHVkhbHU2TkGh/dfMS/BsZ3iXhwayCv1ymOkXgjVKA68mvZUwWJG08yJ/GHe4Ng7Eq/94zEVS0GvmiBdMMBCMx3wCkgG2Smi0L5ZHeTFje0T982K6LoF0eLIkBZzCI3HKRVoc3b6nWfhcFtsJnhmRZEZPy84ctTWoDuQMoRQEJJ0DZG+oCtuQjlGWhi+wzExtFpBEuMISjEYx29RcZJ7DIpAuy8KZoUZYrkCJnx8IEHQdDH2P0HK9WUy0054kaK9gx6ZmyfF8WPYuN6AeNOLaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi91PzOyihEku1JhtFU+H65pLIgENBcLD0FuZZr99QA=;
 b=kIVj68DeFN68VoTKaY10OSRQLIyC9nEw/dJV78jMkLe3V12Zt/cvqnjWnNLhfL79YDxB32jR0nJdHK6yvndTJ80gcO8u5ZbOZSGBcoM0ZRW/eMDdD2ATXc68KbAo6CAYSK6BwetshqJw/C7UlSX9LbkWjJuok60gtvsMdoHTtcq5mfCNp4xIE4NK0f9gikHxYnuWDemgOeU1csG/4BGxYv+rK+Z35C5tbnxkLihRoncrdVbbYLNaAz3Y4MktsyGw5d9NsV4F6X/NrZddRMBp4RIFAqIfdxRhIs1J5+jL6L2+hymebJy96Pr2YIrp54X4YEHruRS1AKIsiZPTuzA/Ug==
Received: from CH2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:610:4e::35)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 07:31:37 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::d9) by CH2PR02CA0025.outlook.office365.com
 (2603:10b6:610:4e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 5/7] net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()
Date: Mon, 24 Jun 2024 10:29:59 +0300
Message-ID: <20240624073001.1204974-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 17517edd-3ad0-47f6-207a-08dc941fae4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4XY9deu1LDsqzA8CmGOByzYFLFfvGMKlDLOO5INWwfXzrdIijQjOpKgM1l0n?=
 =?us-ascii?Q?IsCtqS9+EEc4+LnMCWjQHqtzXBRXW049APkYJLJrDvU/iye4dOI+kEQSCAGa?=
 =?us-ascii?Q?9T1NXY0bzK0uRGxf1L53k/FPbJkTyMYTdDIfsQvy3lJWj3NB2sb+1KskKUgo?=
 =?us-ascii?Q?2FDl8N2daF2hariLFK9Mx6IYebMZTJnDN3nYSC3T0G4dai/7THPyqTAmOVZR?=
 =?us-ascii?Q?uvpUDDRmoGHN5j2yAlMmqmSbpWRo/e+dNp3iF4Y4dQZeg/I7n0LfldBESGna?=
 =?us-ascii?Q?AhexNgx4WXxtHRumiQRREjr7jJy6T9vKWSE3wE7k9vsYlgNKP4l/FIEe3rHx?=
 =?us-ascii?Q?QjOK4pwuc/ZQ1IL1HkCH1TilzwhR4dy5SXkG7qNToqAbzQfYbB+yvbnpLMO1?=
 =?us-ascii?Q?O3jPasnqEjwVcnF2OeungsJRYXWSh5gXJV4sDYhxif2PiaRi7vItce2ZZ401?=
 =?us-ascii?Q?k5ZscVtkK1/buuMKS75PjjR5u28m3NizxzwZJ1r9LG4tkJBrObvQP3qOJ27u?=
 =?us-ascii?Q?3+ev/A50PsU6fRAwyP9rEW2qpKmdNioLs+b1e25Cx6ArKpabYZJ4O8cb0OfR?=
 =?us-ascii?Q?LpXo1r4sOFQetTi/VyJpqrzZdt7+daFAPCA3jg5PQ0JFyXxUp1veM0/ymprr?=
 =?us-ascii?Q?kia0EDTt/i2l4SwFsAIBV8AVlaDaErL8udtKAXMHLgkYys/3jWOfRMwlcKEz?=
 =?us-ascii?Q?Mb6zd5Blr3MaKUs9y7xi3/5Sx9b4uyo9W4aWZFhlEPUiqV76108B08efuAwa?=
 =?us-ascii?Q?1rKBCcV2lfv6joPETmUzXAxPNSjQhNe8Vc+D9uGnBU33093rVwb4gvOZLQtX?=
 =?us-ascii?Q?r9abEdrhxIOw4LXU89whRFK6ovwnLUfgcpHPD5+owspRIfZgDvVd2P+49bI4?=
 =?us-ascii?Q?PHs6V4Re6YwTwOeaf6osDexK+Cv/3xsANDjg9sOZusjkgZwMF+ttG05r1Htg?=
 =?us-ascii?Q?zZ9f0JLSLZd/UmEcpwgapzgVRX5Doc/URKnap6NEt2iAUI3eHyw9eR+mEVf/?=
 =?us-ascii?Q?W4RMNVPQcUsPSQLDZ2f+CThX4NxVoxC9/hhItQF5ZWF2bPqU8Sa7j6iiEF8b?=
 =?us-ascii?Q?M1HgcLe7ZZYTBY/E9r0q3W2l5SQaezkMcz/wcN23y4ramLxrEAXigIh7MwUQ?=
 =?us-ascii?Q?gVck07c3kK1eaHFoh75SqmB8HnysASwwTQtZERTMxWvchVWJ5zcYdecHwOji?=
 =?us-ascii?Q?RRgEWh1nBSh/9pH7ShNP6cMMeGbO8vp7Q1SrJERioZcMNRWNiUQqcweU/KK0?=
 =?us-ascii?Q?gq/yE3vmjYsT5Lv5C/O3gH9oa4cIl2iSq6diXQNdYVldBkn9vO9BgynwQ3nO?=
 =?us-ascii?Q?q+DSTXIkHzzfGDMo6YadkJUolXKF/9gwctK3d3j6isdNGi/s9LkTNcVODsf1?=
 =?us-ascii?Q?BV45vIERQ3p7+Kvuq4ySXmeqiJSrnegJdL+CnczdQW8FVx2ohw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:36.7458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17517edd-3ad0-47f6-207a-08dc941fae4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, mqprio_rl cleanup and free are mistakenly removed
in mlx5e_priv_cleanup(), and it causes the leakage of host memory and
firmware SCHEDULING_ELEMENT objects while changing eswitch mode. So,
add them back.

Fixes: 0bb7228f7096 ("net/mlx5e: Fix mqprio_rl handling on devlink reload")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a605eae56685..eedbcba22689 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5868,6 +5868,11 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 		kfree(priv->htb_qos_sq_stats[i]);
 	kvfree(priv->htb_qos_sq_stats);
 
+	if (priv->mqprio_rl) {
+		mlx5e_mqprio_rl_cleanup(priv->mqprio_rl);
+		mlx5e_mqprio_rl_free(priv->mqprio_rl);
+	}
+
 	memset(priv, 0, sizeof(*priv));
 }
 
-- 
2.31.1


