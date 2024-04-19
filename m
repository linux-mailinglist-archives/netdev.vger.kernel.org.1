Return-Path: <netdev+bounces-89536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143128AA9BC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA73284326
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119414317A;
	Fri, 19 Apr 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N8ekTF33"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16376537E4
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513997; cv=fail; b=WmSRSh8GSs8bM96bMDlPgeGhvyzVPLPImViMqWyQE8bwDMAdliVzy8sNUmVowD79XowbQulYSJ1LKZULJjB7+nKmJKzzRJKXLQccGBnne0P/fnX27yGGlzQbuakCUhEQlDi/IBPGObUNNqXYbBZLfEZgbpELi9xnjATedHXj3Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513997; c=relaxed/simple;
	bh=FLX8br62BYYeclXN3deLFw2yMqfdUwJFg9nJZk42Zw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4dFoQ2EVKE3u5I/ERnhwU2CRQLxWzliYVDLsCBxuhhYsbO8hounmzs8HZ1UzeSVtt+SiibPRJhFzDA6y+5UwYz4e4UHWdTeN/17MHO+Im0R91aBuS9jpCrXDvEPSC9UQgjZOjeoN9ofuF8aZcbDJ9jsXAaVUR75Dvd52tchkdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N8ekTF33; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7S9ESaVm+RhodslVTlXQwg97REuX1/HoQwQLbhn9zRxk0oxW/0uepZgTfjVBv3emX9AVyphu0LKzDaFx41cRk0Pw0QYabSie+tUO6wMw3i5rWPi70r+fyL8ixOS8gXk7+skY+W5hVGj9ugKD9rsv9Kn2ubn0AwjESktLWF351qVTYL6tUM1g3GxA37rnlmTrFDXxpWCxLsRegX0ZSH8GLskTSWHvAqiPP9vKhRjQOZ5BqNQQBHuLn9qllyA//3DwP3MxowVsAbjhmWlJBIBH917COYGXf1LNFtDaDBato5PctokfNyR428/MtqwpPEIG0slBGDuzb0gXG6f1SDqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue/4v9nN62+TQEGIKiqOe5OG788hJTwuHADWC/zjpUo=;
 b=TZ4kshvasZ+QcvLzC4E0WXhruOYl3LSgH1Hb9Lk8V+KxvIbzQsRtZqpIQE1xJ5bDAbcKqujJBInykKaVbMom2+jnUuP8Jf1BNJtohS65jTmr4ItrYOGoyngPglNk5aH0fxljNBRRKQJ+hmMw2sgg+87AKAgfgzan/WLeKKXc3aOfu98Jbh+U/l+cEjaeDYSCTf8EBL5cng2RnZK+oWmVtCFLLwyX0xGoNYRUFkK2cOOqW5CZs0iHa7+G7FkkO/tvJbImv8/puOgGR2LfNckLblzBMKG7ZDULbO4a+PMhm4JAtRFRHEzdDRN/RyH77hU4lT8h7pUnQ8fPVLZar+lgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue/4v9nN62+TQEGIKiqOe5OG788hJTwuHADWC/zjpUo=;
 b=N8ekTF33fo7fHZBpGvOORSvBqu/XTkzRwz/bluACDmOOs7GaUQ0dU8ZTX630yalz4Vuoo6YfhaJZg5KOZPqkfVm0bCf9r+N4fQydtUReaMyAtz/TdQaA7dX+PVgNfmX2xYZ0QXWjZ/Z/al0lr/197q5nC3JMHwK2NI03CbhWm5aA0T3vpKwYowYBxABFEtiW3Tuurd4WALPAst1bTGLpptQUjeKOeb6NUbldwAh8EJU/sm91g+ahcm3rsvw5+EGzeDN37P2we2env/9/XzkC0u285RkgZAZavE7DNPy4AHcMXj1aIPJpsKUzoDr7Imdd8M1UKy3deUHFXKtN4ak/Tg==
Received: from BYAPR07CA0014.namprd07.prod.outlook.com (2603:10b6:a02:bc::27)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Fri, 19 Apr
 2024 08:06:28 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::94) by BYAPR07CA0014.outlook.office365.com
 (2603:10b6:a02:bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 08:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 08:06:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 19 Apr
 2024 01:06:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Nabil S . Alramli"
	<dev@nalramli.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5e: Use DIM constants for CQ period mode parameter
Date: Fri, 19 Apr 2024 11:04:42 +0300
Message-ID: <20240419080445.417574-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419080445.417574-1-tariqt@nvidia.com>
References: <20240419080445.417574-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9d0dff-3601-4888-8efa-08dc60479d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HJNwD/0d3sJbMJO+i9K8SkhXR0mV127OVD8AV6vdlmU8jNHYeoJfFIinHqBOdEhCueLxgIiVaLiJOWAfm4TLybZ5KzKZuIfq/tUrdIUymmFyimCVjafdZLOXBKv6vxpmKUeKpUERwCbGfsAWxpM99UpdNc7EY8bc7QYwSjC1z7AUqLzpx/sCPdVcsotNcxErcpOd/18C0POxQutTwS0sNPjrBvEcY1FSDj+A+cRJ4jYJ15wwaQg4xMrctGMW7jPS3jIRueTstywNR8y6ap0BZXW8h1Ka/tz/Zq0Mce119zUQrYnvWJnIMNilVzedm+2WtgjbLbHlHdTwdz6tEyRJRQIEZzqsebQTPT4mu2PA/0LLASxc3pE1xuAZZ1XlZI3gWuQ4Szawhf3EFMq5Rzk7MUnOUY1U0d+Ef91x3GsGcutualjho30y2MwsgOCQl4Jx91n2fa1xhEengOVtrsqdSo5wG3qtNsxLK7oowHXhnu7zPXaiRN+F3nhhVL0BQZDaLDUfo7TC9RgiiZ6yff7XRra/mqV9TCH1k0eSJuyfyd0cdxAGVfFrQMzylgEq6i+2HJho5uNWbZVJkM+eiRMkksSShABCgLKan76Jk0YwJvAX3gdMuHvAyQzyKLetGIRVc5SU2si4RzNDuZhCefGWLLCsjlmE1mGWPc3db8vdpX+EYisI0+5IFRLPX/tcl34ev/kDMEx3nZeY/SW3Sq+Jl9SS506XWYS/V9ZufiYg1748kZ0FeHn4EBqXMc+Xdtb1
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:06:27.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d0dff-3601-4888-8efa-08dc60479d59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Use core DIM CQ period mode enum values for the CQ parameter for the period
mode. Translate the value to the specific mlx5 device constant for the
selected period mode when creating a CQ. Avoid needing to translate mlx5
device constants to DIM constants for core DIM functionality.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/dim.h  | 26 ++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/params.c   | 34 ++++++-------------
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 16 +++------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 20 ++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  7 ++--
 include/linux/mlx5/mlx5_ifc.h                 |  4 +--
 6 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
index cd2cf647c85a..6411ae4c6b94 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
@@ -4,11 +4,37 @@
 #ifndef __MLX5_EN_DIM_H__
 #define __MLX5_EN_DIM_H__
 
+#include <linux/dim.h>
 #include <linux/types.h>
+#include <linux/mlx5/mlx5_ifc.h>
 
 /* Forward declarations */
 struct work_struct;
 
+/* convert a boolean value for cqe mode to appropriate dim constant
+ * true  : DIM_CQ_PERIOD_MODE_START_FROM_CQE
+ * false : DIM_CQ_PERIOD_MODE_START_FROM_EQE
+ */
+static inline int mlx5e_dim_cq_period_mode(bool start_from_cqe)
+{
+	return start_from_cqe ? DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+		DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+}
+
+static inline enum mlx5_cq_period_mode
+mlx5e_cq_period_mode(enum dim_cq_period_mode cq_period_mode)
+{
+	switch (cq_period_mode) {
+	case DIM_CQ_PERIOD_MODE_START_FROM_EQE:
+		return MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	case DIM_CQ_PERIOD_MODE_START_FROM_CQE:
+		return MLX5_CQ_PERIOD_MODE_START_FROM_CQE;
+	default:
+		WARN_ON_ONCE(true);
+		return MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	}
+}
+
 void mlx5e_rx_dim_work(struct work_struct *work);
 void mlx5e_tx_dim_work(struct work_struct *work);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index a3f31d9d527e..0424628405e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include <linux/dim.h>
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
 
@@ -520,7 +521,7 @@ static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
 	moder.cq_period_mode = cq_period_mode;
 	moder.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS;
 	moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC;
-	if (cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE)
+	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
 		moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE;
 
 	return moder;
@@ -533,39 +534,26 @@ static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
 	moder.cq_period_mode = cq_period_mode;
 	moder.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS;
 	moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC;
-	if (cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE)
+	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
 		moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE;
 
 	return moder;
 }
 
-static u8 mlx5_to_net_dim_cq_period_mode(u8 cq_period_mode)
-{
-	return cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE ?
-		DIM_CQ_PERIOD_MODE_START_FROM_CQE :
-		DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-}
-
 void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
 {
-	if (params->tx_dim_enabled) {
-		u8 dim_period_mode = mlx5_to_net_dim_cq_period_mode(cq_period_mode);
-
-		params->tx_cq_moderation = net_dim_get_def_tx_moderation(dim_period_mode);
-	} else {
+	if (params->tx_dim_enabled)
+		params->tx_cq_moderation = net_dim_get_def_tx_moderation(cq_period_mode);
+	else
 		params->tx_cq_moderation = mlx5e_get_def_tx_moderation(cq_period_mode);
-	}
 }
 
 void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
 {
-	if (params->rx_dim_enabled) {
-		u8 dim_period_mode = mlx5_to_net_dim_cq_period_mode(cq_period_mode);
-
-		params->rx_cq_moderation = net_dim_get_def_rx_moderation(dim_period_mode);
-	} else {
+	if (params->rx_dim_enabled)
+		params->rx_cq_moderation = net_dim_get_def_rx_moderation(cq_period_mode);
+	else
 		params->rx_cq_moderation = mlx5e_get_def_rx_moderation(cq_period_mode);
-	}
 }
 
 void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
@@ -573,7 +561,7 @@ void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
 	mlx5e_reset_tx_moderation(params, cq_period_mode);
 	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
 			params->tx_cq_moderation.cq_period_mode ==
-				MLX5_CQ_PERIOD_MODE_START_FROM_CQE);
+				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
 }
 
 void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
@@ -581,7 +569,7 @@ void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
 	mlx5e_reset_rx_moderation(params, cq_period_mode);
 	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
 			params->rx_cq_moderation.cq_period_mode ==
-				MLX5_CQ_PERIOD_MODE_START_FROM_CQE);
+				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
 }
 
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 75bf7f3d9f25..c07785e675bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/dim.h>
 #include <linux/ethtool_netlink.h>
 
 #include "en.h"
@@ -627,15 +628,6 @@ mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 	}
 }
 
-/* convert a boolean value of cq_mode to mlx5 period mode
- * true  : MLX5_CQ_PERIOD_MODE_START_FROM_CQE
- * false : MLX5_CQ_PERIOD_MODE_START_FROM_EQE
- */
-static int cqe_mode_to_period_mode(bool val)
-{
-	return val ? MLX5_CQ_PERIOD_MODE_START_FROM_CQE : MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
-}
-
 int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
@@ -688,13 +680,13 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 	reset_rx = !!coal->use_adaptive_rx_coalesce != priv->channels.params.rx_dim_enabled;
 	reset_tx = !!coal->use_adaptive_tx_coalesce != priv->channels.params.tx_dim_enabled;
 
-	cq_period_mode = cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_rx);
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
 	if (cq_period_mode != rx_moder->cq_period_mode) {
 		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
 		reset_rx = true;
 	}
 
-	cq_period_mode = cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_tx);
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
 	if (cq_period_mode != tx_moder->cq_period_mode) {
 		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
 		reset_tx = true;
@@ -1915,7 +1907,7 @@ static int set_pflag_cqe_based_moder(struct net_device *netdev, bool enable,
 	if (enable && !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe))
 		return -EOPNOTSUPP;
 
-	cq_period_mode = cqe_mode_to_period_mode(enable);
+	cq_period_mode = mlx5e_dim_cq_period_mode(enable);
 
 	current_cq_period_mode = is_rx_cq ?
 		priv->channels.params.rx_cq_moderation.cq_period_mode :
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index cf529f07faf1..12d1f4548343 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/dim.h>
 #include <net/tc_act/tc_gact.h>
 #include <linux/mlx5/fs.h>
 #include <net/vxlan.h>
@@ -962,15 +963,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	}
 
 	INIT_WORK(&rq->dim.work, mlx5e_rx_dim_work);
-
-	switch (params->rx_cq_moderation.cq_period_mode) {
-	case MLX5_CQ_PERIOD_MODE_START_FROM_CQE:
-		rq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
-		break;
-	case MLX5_CQ_PERIOD_MODE_START_FROM_EQE:
-	default:
-		rq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-	}
+	rq->dim.mode = params->rx_cq_moderation.cq_period_mode;
 
 	return 0;
 
@@ -2090,7 +2083,7 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
-	MLX5_SET(cqc,   cqc, cq_period_mode, param->cq_period_mode);
+	MLX5_SET(cqc,   cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
 	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
@@ -5059,13 +5052,12 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
 	params->packet_merge.timeout = mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_LRO_TIMEOUT);
 
 	/* CQ moderation params */
-	rx_cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
-			MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
-			MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	rx_cq_period_mode =
+		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
 	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
 	mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
-	mlx5e_set_tx_cq_mode_params(params, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
+	mlx5e_set_tx_cq_mode_params(params, DIM_CQ_PERIOD_MODE_START_FROM_EQE);
 
 	/* TX inline */
 	mlx5_query_min_inline(mdev, &params->tx_min_inline_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 6acecf2e7cf6..309771300581 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/dim.h>
 #include <linux/debugfs.h>
 #include <linux/mlx5/fs.h>
 #include <net/switchdev.h>
@@ -40,6 +41,7 @@
 
 #include "eswitch.h"
 #include "en.h"
+#include "en/dim.h"
 #include "en_rep.h"
 #include "en/params.h"
 #include "en/txrx.h"
@@ -836,9 +838,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_params *params;
 
-	u8 cq_period_mode = MLX5_CAP_GEN(mdev, cq_period_start_from_cqe) ?
-					 MLX5_CQ_PERIOD_MODE_START_FROM_CQE :
-					 MLX5_CQ_PERIOD_MODE_START_FROM_EQE;
+	u8 cq_period_mode =
+		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
 
 	params = &priv->channels.params;
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 35ffc9b9f241..8c7ddb22bf20 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4385,10 +4385,10 @@ enum {
 	MLX5_CQC_ST_FIRED                                 = 0xa,
 };
 
-enum {
+enum mlx5_cq_period_mode {
 	MLX5_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
 	MLX5_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
-	MLX5_CQ_PERIOD_NUM_MODES
+	MLX5_CQ_PERIOD_NUM_MODES,
 };
 
 struct mlx5_ifc_cqc_bits {
-- 
2.31.1


