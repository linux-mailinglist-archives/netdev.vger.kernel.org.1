Return-Path: <netdev+bounces-82284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9988D0B4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AC71C2B9AC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918413DDC7;
	Tue, 26 Mar 2024 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUl/e6s/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982B13DDC9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491703; cv=fail; b=MTVE1TnBFTEgZibm+0tKp+ll2Zpw6yNSPQnBx+zfGoqv0yZ1yMmcNyxB8sUBCef3nCCyf0ADb921qhmJCz9oEvEAEy/LiZpwOmTyO4Pj2jUhq8La+dBI6lleUjQeI+GSUi05EqL+3GQtDT6T5D2K/ddBQYJ5QJs+tho7s1+a3o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491703; c=relaxed/simple;
	bh=XkS/qTSz89aepNf43yAH3SpTq5KzSKBUPLlSNoy/1II=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGyWBPhN+IfN4SEQCUSAb8jL5ydNDO5gkLYkiJQSMzndHZo8MZRnfrO11tOmjMLU+ZSKyx/LkPbYutSyOh03gQ8KipaxAAiGQKMOm4h72fNW9NziVwwyQDL3BQaYbNiXKBoiQGmQb6b/MEs078hGAjx8Noo6x1RrcaZ+xUASZww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUl/e6s/; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbY/wqUa+LtBUPhvmyLquJZKXRgPTB6R4Uy4rWvvD5lMvQW9ddyU5ywLffdGVO7Fw+QOIJMKPMKBzNgXIYgIQ/2l1niUqwFvOImiwoe2IqcwDXc3rNX1S4QqAagCJ/ceGskqCgqEji3i0PZRFcFpW2AM+JyDczCQg8PllLDwXtcw1k1GP5kMNmEgbLCfki9eZtsgoKwM90u7Ullv1+YOPvpbLnf2CQYQmgr72y99UFOmaJsoWdEzB6we7/JCXYs+s/NUxTr4/9dR9XAM57Vv6TvPcFNzz7Q1uDtJloPVkunAxhHA2fHj89z8MP4fc8wxTcsfyaXjXfwrVv2khCRD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b86l+xgqIvZjUS3Xgh8tSCkcZwEqZ+xDxEMV1ZZcVYk=;
 b=h9hTUWa0OqEJjiWF5cOYmTBExIJ1ZvIbFwtWkIs1l7Nd7q1QOS7py5pMb1JxQ1RHY986AA0aYMbux3jTfLOmiEQwHoJBvZy6zUrZGpU1yZF6uTkadt2ZkRL6KEyPIiTMKO1mqh7YDqsDK8x1pwfRZLq8TBlNBdLwG6YLvEgJheCKjOlM5PCVVT7zOyg0E6vo5V1ncqPXFHNT1WTmKUtyDKs23wi2i5Bl0YMQgdrQziWTI6jOpQglQWuSzsYJWj4Ib+J0NwR6CqtkU0IRIu7q27IlrezLN8kOnOPf5sRqssDpycg3Av2kszn54iWB4ZIfJ9F9PzA3hbKKYQqb+fXqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b86l+xgqIvZjUS3Xgh8tSCkcZwEqZ+xDxEMV1ZZcVYk=;
 b=UUl/e6s/zaP2GPKGkIDW9atNlBB5h73Xh70NN2OF3kqVAxZoi2TaHajup/5H0wi9rf/bWaRCjOiHuJSKNaEBa6ZAJD8VOImO3WO2/g0bFHRlRTsmCiVqYBb5UffBCLpnRs+/g50pJBpcmHWyE5EAXtn5WzIJKBjTMtNxpi5ygYLTVhnjNR86nZkenwYeD9tNHq4Y9BU5xLh6zT+YQe4u0KzZ4sQqdWSoDNNJDhjQIHPEZz09aAMh0ODIwtmyBr1jSY+xGl9XcykzX+BXkhQg9nSvvVLE46rOhovpIqto5ZpqaxPiha05N7ugX4vMkjTcaSvW4Qr8UY213Qq/mBXwlw==
Received: from CH0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:610:32::16)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 22:21:35 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::2d) by CH0PR07CA0011.outlook.office365.com
 (2603:10b6:610:32::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 22:21:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 8/8] net/mlx5: Convert uintX_t to uX
Date: Wed, 27 Mar 2024 00:20:22 +0200
Message-ID: <20240326222022.27926-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: d78c9674-e711-4598-d9a9-08dc4de318ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Xnqrsj2BjoF4sIMhopDUonJuFjGeMfRX938dqrnpnwXicxI3BL+641ZRj2/oXrEf0/1kapZqbU/lj6KBtrZ5TtGwwiEOBoFK6hULEV/T6mED5DeZOixRPC4fCegsxqnY/t8Pgy3KWU0U7dpm1gYycqUVYw85h1d8XdFfBLPQ5f1NIoq6xCox825+YilziEpuncxezfc3B6dBRW6IzE3DfQqP3bB4n//FnBYdA7YGrrC33uxZ6MqWZfSEfN59b1/buWs6nctdy8xu5SxJeJg2g0l8dSghFNkd6xd9HbwxVLOfY1Y0bppamQbYu3+LfyAHNBy0ngK9n6gp9YD0Bpx9nQegBHnQ134BjyOa45ehz51EvZjC4iPj0RjbF6BAZ5N8zgCTZcG6CE0OEYMVUR/yeEAghhBG0ir5FyvCNMbWKSA/TT0npK4jUc0Ql8Fvu519Iy2TABu70UZTpZgivZ88IReV+8oTUlx6lNj9ICICc810XBr1/4SJOr2N+xvc8cDuPDLBQgCQipmpKgBJBBF0t3hkEqG6NqrRxZi7CkruuoJHzm49NGJI8/96ZHDRVFgYx5CVEtjX2e6qPJpJuuBCPKUq3pCzCX05NHeq4xfcaxdHuaQOh1uxwRwP+hqU2cGFoNDsgj9NJUuErJ+ZGFG8/wTn4Pl4YMEslkU99MFqjW8u8XTNoDnVEtSTgnTltDPwh1ZM+HU1fFh2i2BEQj6PF8A0YQmWVJjPRVf6+Ypq0eU7sN3G4PZDhoYR+5ljGWg
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:34.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78c9674-e711-4598-d9a9-08dc4de318ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

From: Gal Pressman <gal@nvidia.com>

In the kernel, the preferred types are uX.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c     | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h     | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h       | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c              | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h           | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c  | 4 ++--
 include/linux/mlx5/device.h                                   | 2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 84db05fb9389..f5a3ac40f6e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1160,7 +1160,7 @@ void mlx5e_vxlan_set_netdev_info(struct mlx5e_priv *priv);
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo);
 void mlx5e_ethtool_get_strings(struct mlx5e_priv *priv,
-			       uint32_t stringset, uint8_t *data);
+			       u32 stringset, u8 *data);
 int mlx5e_ethtool_get_sset_count(struct mlx5e_priv *priv, int sset);
 void mlx5e_ethtool_get_ethtool_stats(struct mlx5e_priv *priv,
 				     struct ethtool_stats *stats, u64 *data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index c7d191f66ad1..4f83e3172767 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -73,7 +73,7 @@ void mlx5e_accel_fs_del_sk(struct mlx5_flow_handle *rule)
 
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 					       struct sock *sk, u32 tirn,
-					       uint32_t flow_tag)
+					       u32 flow_tag)
 {
 	struct mlx5e_accel_fs_tcp *fs_tcp = mlx5e_fs_get_accel_tcp(fs);
 	struct mlx5_flow_destination dest = {};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index a032bff482a6..7e899c716267 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -11,14 +11,14 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 					       struct sock *sk, u32 tirn,
-					       uint32_t flow_tag);
+					       u32 flow_tag);
 void mlx5e_accel_fs_del_sk(struct mlx5_flow_handle *rule);
 #else
 static inline int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs) { return 0; }
 static inline void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs) {}
 static inline struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 							     struct sock *sk, u32 tirn,
-							     uint32_t flow_tag)
+							     u32 flow_tag)
 { return ERR_PTR(-EOPNOTSUPP); }
 static inline void mlx5e_accel_fs_del_sk(struct mlx5_flow_handle *rule) {}
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index c1844128effa..07a04a142a2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -95,7 +95,7 @@ int mlx5e_ktls_init(struct mlx5e_priv *priv);
 void mlx5e_ktls_cleanup(struct mlx5e_priv *priv);
 
 int mlx5e_ktls_get_count(struct mlx5e_priv *priv);
-void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data);
+void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, u8 **data);
 void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data);
 
 #else
@@ -144,7 +144,7 @@ static inline bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 static inline int mlx5e_ktls_init(struct mlx5e_priv *priv) { return 0; }
 static inline void mlx5e_ktls_cleanup(struct mlx5e_priv *priv) { }
 static inline int mlx5e_ktls_get_count(struct mlx5e_priv *priv) { return 0; }
-static inline void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data) { }
+static inline void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, u8 **data) { }
 
 static inline void mlx5e_ktls_get_stats(struct mlx5e_priv *priv, u64 **data) { }
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
index 7bf79973128b..60be2d72eb9e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_stats.c
@@ -58,7 +58,7 @@ int mlx5e_ktls_get_count(struct mlx5e_priv *priv)
 	return ARRAY_SIZE(mlx5e_ktls_sw_stats_desc);
 }
 
-void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, uint8_t **data)
+void mlx5e_ktls_get_strings(struct mlx5e_priv *priv, u8 **data)
 {
 	unsigned int i, n;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index dd74fd82707c..719743ec0d47 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -337,7 +337,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_qcounter_rep)
 }
 
 static void mlx5e_rep_get_strings(struct net_device *dev,
-				  u32 stringset, uint8_t *data)
+				  u32 stringset, u8 *data)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index e7faf7e73ca4..2d95a9b7b44e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -283,7 +283,7 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	return 0;
 }
 
-int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, uint32_t *sw_owner_id)
+int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, u32 *sw_owner_id)
 {
 	u32 in[MLX5_ST_SZ_DW(init_hca_in)] = {};
 	int i;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 58732f44940f..c38342b9f320 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -205,7 +205,7 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev);
 void mlx5_cmd_disable(struct mlx5_core_dev *dev);
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
 			enum mlx5_cmdif_state cmdif_state);
-int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, uint32_t *sw_owner_id);
+int mlx5_cmd_init_hca(struct mlx5_core_dev *dev, u32 *sw_owner_id);
 int mlx5_cmd_teardown_hca(struct mlx5_core_dev *dev);
 int mlx5_cmd_force_teardown_hca(struct mlx5_core_dev *dev);
 int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
index f708b029425a..e9f6c7ed7a7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
@@ -1883,7 +1883,7 @@ dr_ste_v0_build_tnl_gtpu_flex_parser_1_init(struct mlx5dr_ste_build *sb,
 
 static int dr_ste_v0_build_tnl_header_0_1_tag(struct mlx5dr_match_param *value,
 					      struct mlx5dr_ste_build *sb,
-					      uint8_t *tag)
+					      u8 *tag)
 {
 	struct mlx5dr_match_misc5 *misc5 = &value->misc5;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
index dd856cde188d..1d49704b9542 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
@@ -1897,7 +1897,7 @@ void dr_ste_v1_build_flex_parser_tnl_geneve_init(struct mlx5dr_ste_build *sb,
 
 static int dr_ste_v1_build_tnl_header_0_1_tag(struct mlx5dr_match_param *value,
 					      struct mlx5dr_ste_build *sb,
-					      uint8_t *tag)
+					      u8 *tag)
 {
 	struct mlx5dr_match_misc5 *misc5 = &value->misc5;
 
@@ -2129,7 +2129,7 @@ dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_init(struct mlx5dr_ste_build *sb,
 static int
 dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_exist_tag(struct mlx5dr_match_param *value,
 							 struct mlx5dr_ste_build *sb,
-							 uint8_t *tag)
+							 u8 *tag)
 {
 	u8 parser_id = sb->caps->flex_parser_id_geneve_tlv_option_0;
 	struct mlx5dr_match_misc *misc = &value->misc;
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 01275c6e8468..da61be87a12e 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -68,7 +68,7 @@
 #define MLX5_UN_SZ_BYTES(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 8)
 #define MLX5_UN_SZ_DW(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 32)
 #define MLX5_BYTE_OFF(typ, fld) (__mlx5_bit_off(typ, fld) / 8)
-#define MLX5_ADDR_OF(typ, p, fld) ((void *)((uint8_t *)(p) + MLX5_BYTE_OFF(typ, fld)))
+#define MLX5_ADDR_OF(typ, p, fld) ((void *)((u8 *)(p) + MLX5_BYTE_OFF(typ, fld)))
 
 /* insert a value to a struct */
 #define MLX5_SET(typ, p, fld, v) do { \
-- 
2.31.1


