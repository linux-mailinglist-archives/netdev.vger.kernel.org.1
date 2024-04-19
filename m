Return-Path: <netdev+bounces-89534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCE8AA9BA
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820701C21DEB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143B4DA0D;
	Fri, 19 Apr 2024 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ucOjJm46"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022F4D9F7
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513989; cv=fail; b=RWD7XekTY/FUYN+0YlJpH4sieNOAH+p+JWaolUEBBeWCJ+P4kf5NGIgmHpG0qiduiWD3iymjkMuQraZz6roXCzoLVAea0Xt7JhSCK0D0qWbibpibbC8UPMhqcAzfR2Mm7yPlEfNQ8fxtk5YDVL5vdcZCXEH1uQ2fMlvrENsTDDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513989; c=relaxed/simple;
	bh=Qer9leMjedAJipLYR0wmIMKXKZp/8asIA2BRHJCASm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0UKYg3oa9dIe50lR50/s5Ta/NFdyeMqI6fDSuWDfkbw3bbX0M0eYuA8dZteSYsfNwUcvypQmZadXLFjwXGdWTgh1ZzBxDY8WZOiRzN2DzKjRPJysdUtbJMqMK9MSw6ydtqprJzfgkLxMtZr35ObPn7qY9tmPmAkgiv9DEn/NK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ucOjJm46; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7Yrj0gYDxarkHIX351OvrI8xAwioJei8/jaTUubAo0Pz0CRYiaxeKsaOD8TuJFnwZ8gs0Vj5RJPmJT6jeYOd4MBCBajqSRSrjOP+invZXPCfVZN8p7/98MNDk+klbdddDtd4hRo7S+x0JRMM/7FVeceeDEFJrDsUSwRslAjpz7M246odqu7AxJuHtYqLVzEi0RTm/gmJ7EDgLHHYvWhH5gLaRIKAIabeIbJxEmiioLMAUW2gQt8WHQ2j7oiwApSQXr4MczhDMgHA5ooDKFyx6NW8DLxuYowkGx+6cwp74uvtZ1v/cJ8Bc462/Cl5LY7DjmnFGAwpRAw4oBu04Aqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvBaK9tSzieVU86v88c4z5gVx2fnkbbR11s1Udok6+E=;
 b=mrASiq1M7ZG5paTLNo0y7C7BzE0TfXL/zbfdPSsHVEZRRtmOZenAv6nsBYLZi/mL9whitS29EYGJMo6XyEgusth9rDHPWgoL5bmIlvFLRcnEijL+OyGoo7sAjDliZtYnvw3T51lhopOq4twg5XLYHQnF5oiGYWMu2hEUrV8b68QJ6o1UYcRr3vl/PJ+BM3wlSWyK8k0nddY+IDMP6h+hqm2jRLru4zh/TqVaHdda4AdiY/lZa8ChNupQlUeoWm1onIAzZZo4X0deULN1RPPi7Pn8rNvE7vIgdU540LF/pJCbuNKw4kdGGTmpU+2BZ/1KCFGQ89NzGVM0PVo/jfNgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvBaK9tSzieVU86v88c4z5gVx2fnkbbR11s1Udok6+E=;
 b=ucOjJm46027xGiDqOAnBQjPqij2ZY8b/BpstW1DJf3o/vlTvUg6MNeWK49dlfELye6Zmel5zOmAcia9iY2fAbwpXIhIZHJ/RX7XiD37xa3esDDL+eFLC1xGJw1TCusMTV61+QA6ApAwnR9+NNPXHQHJl3mbJc7HsH8acRV/pax1Tz5OfqBi7Ui6EqXLzjqCt6GokI6Kh4v+w4yxqIIzWsqulYtcicGVKpAWgjGeDtMBkgOMqinU6qCX+Zk0cSozwDcfFUTmtV7YHwlrHErUZmTk/hkHshb717WC+yM1e0NB8d+waVpwe+pg0WEbb4ZrHz5dOBe+82WazhcU4FOaXDw==
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 08:06:24 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::89) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Fri, 19 Apr 2024 08:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 08:06:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 19 Apr
 2024 01:06:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Nabil S . Alramli"
	<dev@nalramli.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5e: Move DIM function declarations to en/dim.h
Date: Fri, 19 Apr 2024 11:04:41 +0300
Message-ID: <20240419080445.417574-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: f34c456e-7115-4599-0c27-08dc60479b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qr5Nmjn/zdgaAQj5lhQGCFcVFo8vuxkJfzR834PP6rh/bO5eePaIKA4amKTb0WpIxsej1o2SKnF38RO3an4YMniCfDRHHg/GLP2DlJHH9KqZ5fdq4jgZHctcuc/04LIAwThlUt/NRzOhW25wlHq/3pHKTWxanPq5Gwu46W7PsFcSyH6HAhA0zBfJg0h5EE5eqpcC8WCPwrHY+zZ7OvcGGSvrviUJZT3OFX18NVY6AavjzvzTKQp5/0peTENrGx8eB9BXI7jXRX5ITnn1A8cpIiv+EH87Mk4cMgCtgA2XaUiO2VzAyVLXYvm54YPb2kL52e+7tnK/KrUmH+fmu1uywJGzqD8WBVvzuPKrs8M8j/EIjL2qL0Pqta8ojtQG3nsIWHvNxm9vuUFvNEGg9eKY+SBEEHgpCRyysCfN8fA6awUWKcRePTFWA1ULL55p8ehNwN2PFySTNm5MIRRMca8CAmRbclwkc8UTe4cexrQYD9MYM50VAA+bbzvHfva0eVKOObHK3drA9HX7YL5Q5UuWCsXC3exSB8tUGtZjtYSj2qD0CVw1XU8lUkpxyuBUlcNM+tDnWMDYZd65t3Lx9GLADrnQBPL+6jUo8/CD1eb4cI2mXP9m7BEuFsl8OLK3rqpzTf2X/W3fO4+2E0sVJuMARmbZUTg4WlSLGU2UMl+Mq3rt4jA27pBLGGB919LpZEM2tj/DQubDxMEPoc/EpQNatahveM3qzvCNfnMT1w1Ie5+1y/62GEfh+AZQMb1zAP2o
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:06:24.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34c456e-7115-4599-0c27-08dc60479b34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Create a header specifically for DIM-related declarations. Move existing
DIM-specific functionality from en.h. Future DIM-related functionality will
be declared in en/dim.h in subsequent patches.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 --
 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h  | 15 +++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2acd1ebb0888..1c98199b5267 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1210,8 +1210,6 @@ int mlx5e_netdev_change_profile(struct mlx5e_priv *priv,
 void mlx5e_netdev_attach_nic_profile(struct mlx5e_priv *priv);
 void mlx5e_set_netdev_mtu_boundaries(struct mlx5e_priv *priv);
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu);
-void mlx5e_rx_dim_work(struct work_struct *work);
-void mlx5e_tx_dim_work(struct work_struct *work);
 
 void mlx5e_set_xdp_feature(struct net_device *netdev);
 netdev_features_t mlx5e_features_check(struct sk_buff *skb,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
new file mode 100644
index 000000000000..cd2cf647c85a
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved */
+
+#ifndef __MLX5_EN_DIM_H__
+#define __MLX5_EN_DIM_H__
+
+#include <linux/types.h>
+
+/* Forward declarations */
+struct work_struct;
+
+void mlx5e_rx_dim_work(struct work_struct *work);
+void mlx5e_tx_dim_work(struct work_struct *work);
+
+#endif /* __MLX5_EN_DIM_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index ca9cfbf57d8f..df692e29ab8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -30,8 +30,8 @@
  * SOFTWARE.
  */
 
-#include <linux/dim.h>
 #include "en.h"
+#include "en/dim.h"
 
 static void
 mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 5cca04796d74..75bf7f3d9f25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -33,6 +33,7 @@
 #include <linux/ethtool_netlink.h>
 
 #include "en.h"
+#include "en/dim.h"
 #include "en/port.h"
 #include "en/params.h"
 #include "en/ptp.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 78ff737f0378..cf529f07faf1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -43,6 +43,7 @@
 #include <net/xdp_sock_drv.h>
 #include "eswitch.h"
 #include "en.h"
+#include "en/dim.h"
 #include "en/txrx.h"
 #include "en_tc.h"
 #include "en_rep.h"
-- 
2.31.1


