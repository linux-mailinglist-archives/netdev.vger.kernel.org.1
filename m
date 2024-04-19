Return-Path: <netdev+bounces-89537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AEE8AA9BD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D00B23E36
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D1537E4;
	Fri, 19 Apr 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ld2TK5YI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193853807
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514000; cv=fail; b=c+4UykfuvPuB5m8TeOnzTsd/JwLiCNq+7I1/gTlLaVsoZReVatuPJUyyzYZFM0G3YGwa8DKA0D7VcWiXq/xVDRM+WM6q051iiwfPScIVlfn/8Mk5zMtO1tEjWJ4QhwZ6avFoPhuTndbll0ZToe6KJhCdob/MxeKyd7sRvIDbNoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514000; c=relaxed/simple;
	bh=AaajvvsGUnpCIfYRdASkbKf/3rkkqmClr7xOhMFj1SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFdL9+dNRCID20iOXtm6RU4q9Hhweit3qiBNH+9XrTPz4NGJWdzath4e+xEobUePYZJFJ92XU7DtyR8Upcef1m97ifhUk11IvHTtNhI21jdOFjbyCYKK+lcLYo1i/FjiOoVe+/uq54bxmPVFrRnr2hwRgUOm/as56cf8UYAbEY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ld2TK5YI; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJIioaF+Q10+1OzbTcciplNvEwjFxG7PPUwqcQeRj7AYCt7Z5jjvG8E9I0YbHhpyqVSJI8z0cssOZB7uHUgJODVg6Tq8ChiaifCYcV1/JcnK5y/arASUUl4RHHpB6Vx42CGfhZv3KMhtoJUXcFTYkdceMPazciYqUOpL+CgilXGiDFVt2k2FJfiEzh+4szL045PONfwLE9fc1XNfm7L7gVgI4v131gKm83fs25QKQU4eOxcKQ3Y1BP2O0v2bSeL8dfIvxojl6ZQqn5l52i8nhnKpfnGhCaVwC3sRyeMTDNRcmdAFHnkQxkyRZW+Hy1279QB328XrBnhCM3scEsla4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KLzHZAK8jxjuPalSP3pkqUhHtToHUv4Mv898zZEXvI=;
 b=Syqu8KB/4P7A66MlXi9gyshZnwZ4HkESHp4wtgNMCjsHQXTb/erhtEMb4ONPab+0+Ru6RIZFfAkAh7NQWkRHYH57rQVX2oX4vDLH8PbqLxCeOUmytajj5B6YXNoURRbnCTtVQnNWpmTj/U8xIKEcgOKW/cG9Ur/3CrT+/cvVKUdPP83zPmStgKKzpqH3EgMd0gY5NB2388Oi+Wq4GtZC4IxzBRr2xAqrdUD3geGcn2SX9A/snXlynoj0NnFVTsmMMdz3aRyOGhFxOrphS+WwU6/1AGvIj+Sq77S1soxOmfc1YDn7ii/9Ml3Mqnn8HbwT8Gtapj/muWBQDS45Q5zktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KLzHZAK8jxjuPalSP3pkqUhHtToHUv4Mv898zZEXvI=;
 b=Ld2TK5YIkPSPvXyzJLoKFUIgtldxgRMxA3iHYTwPQlXNSXE+7RVOE+zwrGMhbe8ooxE/EBbliWhaYbzXIz3WQrAZwKDKsaBBNRzdFgVd5GehfLUPWaxH2mQrEb0KTP0aqKzI+/UH5m1V1N4jSLoyHFHN5uK7XzBlVQbkNyUz5kJcxVwfPNiT0m9X1Fl6GGghWDklN0T9qAVFxjRIK/U+JJ1BZrKfxVuMYhxUQOXz1GLkXAVzUJDlHcL6ktXSuD90vQolVoIiYAQzE2rm4x0sJn9I2EG0GmnYgbv3UTkulU707aRYdl6qOiWn0DBkDuZConSMbBot0ndO8RVEFqQg2A==
Received: from PR2P264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::14) by
 LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 08:06:33 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10a6:101:0:cafe::56) by PR2P264CA0002.outlook.office365.com
 (2603:10a6:101::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43 via Frontend
 Transport; Fri, 19 Apr 2024 08:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 08:06:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 19 Apr
 2024 01:06:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Nabil S . Alramli"
	<dev@nalramli.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: Support updating coalescing configuration without resetting channels
Date: Fri, 19 Apr 2024 11:04:44 +0300
Message-ID: <20240419080445.417574-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 832210ff-be04-47a3-75df-08dc60479f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1G97yPEAkNaDmPyTPgqCVFa9dWsy9wnPvf1socC5RTPiIRgrM8k/dH5oYlSv8sXjY1YSVzoGQNzcg3NadTNm9iNzk95jZjbmgdoT0RPFic7SeONdq6o4/cnLpuFbceV9FCDOPWUD14phkMTQs4yd+yrqQE4tHb5I+Lpu5hnsoaCxA1eDEkl8HJkk01fNSPNyKAsHNMDerf/FXH0G12UcCDCeOBytAEEr9W/oapzUI+0c+/ZPxd8L2XmNLHt36xKpRmo2bC90I2fUIoYXBFXJnI42X0ptVVBWJLkqzS1mFTBXwY+u2squiN/lESXs/huceWZNyp1jyD3nxDQ3lt9S/9nC+CMbezdPDZP1hOirPGqnXRSA/kN0DWyvxoCLgBDfcA2J7rteBA8XY6SAhjITP/UvZCt+IedO7i7WTXCq8FruACTJ7gGfVOVUIJFG4VfCeqCR/P0eOAySH+GkwjbPZPDo990FJXG2TBxb9b1c93pUbwHIqJj59t3dW3hK3rJjCFio4SHsNcAXQRplCPMvgr2qXDVmjwbd8v9BaCbze/Hnil3v52UFSQK2i2v1BD5BGMnsZQ1kB62LJn0uB97W9BSWX/XN1GGspwVgkMCRwkra2a4bM9ThzPKnASvpIYNkagBcwWcC83HzH1t8NLr1Nhg4XUVjDXCSbhH5Os9ngAtAr9lanAQH9qYDMqf711gdNOBI4WquaYPi71/m9ko+mO/hKKBu+rUiqG/xlGtZmsPJazEeKWN+i/COp6cTig17
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:06:31.2425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832210ff-be04-47a3-75df-08dc60479f75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

When CQE mode or DIM state is changed, gracefully reconfigure channels to
handle new configuration. Previously, would create new channels that would
reflect the changes rather than update the original channels.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  20 ++
 .../ethernet/mellanox/mlx5/core/en/channels.c |  83 +++++++
 .../ethernet/mellanox/mlx5/core/en/channels.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/dim.h  |   4 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |  58 -----
 .../ethernet/mellanox/mlx5/core/en/params.h   |   5 -
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  89 +++++++-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 141 +++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 210 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   5 +-
 include/linux/mlx5/cq.h                       |   7 +-
 include/linux/mlx5/mlx5_ifc.h                 |   3 +-
 12 files changed, 460 insertions(+), 169 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c8c0a0614e7b..eb09778327cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -320,6 +320,8 @@ struct mlx5e_params {
 	bool scatter_fcs_en;
 	bool rx_dim_enabled;
 	bool tx_dim_enabled;
+	bool rx_moder_use_cqe_mode;
+	bool tx_moder_use_cqe_mode;
 	u32 pflags;
 	struct bpf_prog *xdp_prog;
 	struct mlx5e_xsk *xsk;
@@ -797,6 +799,10 @@ struct mlx5e_channel {
 	int                        cpu;
 	/* Sync between icosq recovery and XSK enable/disable. */
 	struct mutex               icosq_recovery_lock;
+
+	/* coalescing configuration */
+	struct dim_cq_moder        rx_cq_moder;
+	struct dim_cq_moder        tx_cq_moder;
 };
 
 struct mlx5e_ptp;
@@ -1040,6 +1046,11 @@ void mlx5e_close_rq(struct mlx5e_rq *rq);
 int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_counter);
 void mlx5e_destroy_rq(struct mlx5e_rq *rq);
 
+bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled);
+bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state);
+
 struct mlx5e_sq_param;
 int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 		     struct mlx5e_sq_param *param, struct xsk_buff_pool *xsk_pool,
@@ -1060,6 +1071,10 @@ int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
 		  struct mlx5e_cq_param *param, struct mlx5e_create_cq_param *ccp,
 		  struct mlx5e_cq *cq);
 void mlx5e_close_cq(struct mlx5e_cq *cq);
+int mlx5e_modify_cq_period_mode(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+				u8 cq_period_mode);
+int mlx5e_modify_cq_moderation(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+			       u16 cq_period, u16 cq_max_count, u8 cq_period_mode);
 
 int mlx5e_open_locked(struct net_device *netdev);
 int mlx5e_close_locked(struct net_device *netdev);
@@ -1118,6 +1133,11 @@ int mlx5e_create_sq_rdy(struct mlx5_core_dev *mdev,
 void mlx5e_tx_err_cqe_work(struct work_struct *recover_work);
 void mlx5e_close_txqsq(struct mlx5e_txqsq *sq);
 
+bool mlx5e_reset_tx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled);
+bool mlx5e_reset_tx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state);
+
 static inline bool mlx5_tx_swp_supported(struct mlx5_core_dev *mdev)
 {
 	return MLX5_CAP_ETH(mdev, swp) &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
index 874a1016623c..66e719e88503 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
@@ -3,6 +3,7 @@
 
 #include "channels.h"
 #include "en.h"
+#include "en/dim.h"
 #include "en/ptp.h"
 
 unsigned int mlx5e_channels_get_num(struct mlx5e_channels *chs)
@@ -55,3 +56,85 @@ bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn)
 	*rqn = c->rq.rqn;
 	return true;
 }
+
+int mlx5e_channels_rx_change_dim(struct mlx5e_channels *chs, bool enable)
+{
+	int i;
+
+	for (i = 0; i < chs->num; i++) {
+		int err = mlx5e_dim_rx_change(&chs->c[i]->rq, enable);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int mlx5e_channels_tx_change_dim(struct mlx5e_channels *chs, bool enable)
+{
+	int i, tc;
+
+	for (i = 0; i < chs->num; i++) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			int err = mlx5e_dim_tx_change(&chs->c[i]->sq[tc], enable);
+
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int mlx5e_channels_rx_toggle_dim(struct mlx5e_channels *chs)
+{
+	int i;
+
+	for (i = 0; i < chs->num; i++) {
+		/* If dim is enabled for the channel, reset the dim state so the
+		 * collected statistics will be reset. This is useful for
+		 * supporting legacy interfaces that allow things like changing
+		 * the CQ period mode for all channels without disturbing
+		 * individual channel configurations.
+		 */
+		if (chs->c[i]->rq.dim) {
+			int err;
+
+			mlx5e_dim_rx_change(&chs->c[i]->rq, false);
+			err = mlx5e_dim_rx_change(&chs->c[i]->rq, true);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int mlx5e_channels_tx_toggle_dim(struct mlx5e_channels *chs)
+{
+	int i, tc;
+
+	for (i = 0; i < chs->num; i++) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			int err;
+
+			/* If dim is enabled for the channel, reset the dim
+			 * state so the collected statistics will be reset. This
+			 * is useful for supporting legacy interfaces that allow
+			 * things like changing the CQ period mode for all
+			 * channels without disturbing individual channel
+			 * configurations.
+			 */
+			if (!chs->c[i]->sq[tc].dim)
+				continue;
+
+			mlx5e_dim_tx_change(&chs->c[i]->sq[tc], false);
+			err = mlx5e_dim_tx_change(&chs->c[i]->sq[tc], true);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
index 6715aa9383b9..eda80f8c6c02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
@@ -15,5 +15,9 @@ void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix,
 void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn,
 				u32 *vhca_id);
 bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn);
+int mlx5e_channels_rx_change_dim(struct mlx5e_channels *chs, bool enabled);
+int mlx5e_channels_tx_change_dim(struct mlx5e_channels *chs, bool enabled);
+int mlx5e_channels_rx_toggle_dim(struct mlx5e_channels *chs);
+int mlx5e_channels_tx_toggle_dim(struct mlx5e_channels *chs);
 
 #endif /* __MLX5_EN_CHANNELS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
index 6411ae4c6b94..110e2c6b7e51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
@@ -9,6 +9,8 @@
 #include <linux/mlx5/mlx5_ifc.h>
 
 /* Forward declarations */
+struct mlx5e_rq;
+struct mlx5e_txqsq;
 struct work_struct;
 
 /* convert a boolean value for cqe mode to appropriate dim constant
@@ -37,5 +39,7 @@ mlx5e_cq_period_mode(enum dim_cq_period_mode cq_period_mode)
 
 void mlx5e_rx_dim_work(struct work_struct *work);
 void mlx5e_tx_dim_work(struct work_struct *work);
+int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enabled);
+int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enabled);
 
 #endif /* __MLX5_EN_DIM_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 0424628405e0..ec819dfc98be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -514,64 +514,6 @@ int mlx5e_validate_params(struct mlx5_core_dev *mdev, struct mlx5e_params *param
 	return 0;
 }
 
-static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
-{
-	struct dim_cq_moder moder = {};
-
-	moder.cq_period_mode = cq_period_mode;
-	moder.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS;
-	moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC;
-	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
-		moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE;
-
-	return moder;
-}
-
-static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
-{
-	struct dim_cq_moder moder = {};
-
-	moder.cq_period_mode = cq_period_mode;
-	moder.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS;
-	moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC;
-	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
-		moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE;
-
-	return moder;
-}
-
-void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	if (params->tx_dim_enabled)
-		params->tx_cq_moderation = net_dim_get_def_tx_moderation(cq_period_mode);
-	else
-		params->tx_cq_moderation = mlx5e_get_def_tx_moderation(cq_period_mode);
-}
-
-void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	if (params->rx_dim_enabled)
-		params->rx_cq_moderation = net_dim_get_def_rx_moderation(cq_period_mode);
-	else
-		params->rx_cq_moderation = mlx5e_get_def_rx_moderation(cq_period_mode);
-}
-
-void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	mlx5e_reset_tx_moderation(params, cq_period_mode);
-	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
-			params->tx_cq_moderation.cq_period_mode ==
-				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
-}
-
-void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	mlx5e_reset_rx_moderation(params, cq_period_mode);
-	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
-			params->rx_cq_moderation.cq_period_mode ==
-				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
-}
-
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
 {
 	u32 link_speed = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 9a781f18b57f..749b2ec0436e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -77,11 +77,6 @@ u8 mlx5e_mpwrq_max_log_rq_pkts(struct mlx5_core_dev *mdev, u8 page_shift,
 
 /* Parameter calculations */
 
-void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode);
-void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode);
-void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode);
-void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode);
-
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev);
 int mlx5e_mpwrq_validate_regular(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index 106a1f70dd9a..298bb74ec5e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -37,7 +37,8 @@ static void
 mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
 			struct mlx5_core_dev *mdev, struct mlx5_core_cq *mcq)
 {
-	mlx5_core_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts);
+	mlx5e_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts,
+				   mlx5e_cq_period_mode(moder.cq_period_mode));
 	dim->state = DIM_START_MEASURE;
 }
 
@@ -60,3 +61,89 @@ void mlx5e_tx_dim_work(struct work_struct *work)
 
 	mlx5e_complete_dim_work(dim, cur_moder, sq->cq.mdev, &sq->cq.mcq);
 }
+
+static struct dim *mlx5e_dim_enable(struct mlx5_core_dev *mdev,
+				    void (*work_fun)(struct work_struct *), int cpu,
+				    u8 cq_period_mode, struct mlx5_core_cq *mcq,
+				    void *queue)
+{
+	struct dim *dim;
+	int err;
+
+	dim = kvzalloc_node(sizeof(*dim), GFP_KERNEL, cpu_to_node(cpu));
+	if (!dim)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_WORK(&dim->work, work_fun);
+
+	dim->mode = cq_period_mode;
+	dim->priv = queue;
+
+	err = mlx5e_modify_cq_period_mode(mdev, mcq, dim->mode);
+	if (err) {
+		kvfree(dim);
+		return ERR_PTR(err);
+	}
+
+	return dim;
+}
+
+static void mlx5e_dim_disable(struct dim *dim)
+{
+	cancel_work_sync(&dim->work);
+	kvfree(dim);
+}
+
+int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enable)
+{
+	if (enable == !!rq->dim)
+		return 0;
+
+	if (enable) {
+		struct mlx5e_channel *c = rq->channel;
+		struct dim *dim;
+
+		dim = mlx5e_dim_enable(rq->mdev, mlx5e_rx_dim_work, c->cpu,
+				       c->rx_cq_moder.cq_period_mode, &rq->cq.mcq, rq);
+		if (IS_ERR(dim))
+			return PTR_ERR(dim);
+
+		rq->dim = dim;
+
+		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
+	} else {
+		__clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
+
+		mlx5e_dim_disable(rq->dim);
+		rq->dim = NULL;
+	}
+
+	return 0;
+}
+
+int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enable)
+{
+	if (enable == !!sq->dim)
+		return 0;
+
+	if (enable) {
+		struct mlx5e_channel *c = sq->channel;
+		struct dim *dim;
+
+		dim = mlx5e_dim_enable(sq->mdev, mlx5e_tx_dim_work, c->cpu,
+				       c->tx_cq_moder.cq_period_mode, &sq->cq.mcq, sq);
+		if (IS_ERR(dim))
+			return PTR_ERR(dim);
+
+		sq->dim = dim;
+
+		__set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
+	} else {
+		__clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
+
+		mlx5e_dim_disable(sq->dim);
+		sq->dim = NULL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index c07785e675bc..c968874569cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -34,6 +34,7 @@
 #include <linux/ethtool_netlink.h>
 
 #include "en.h"
+#include "en/channels.h"
 #include "en/dim.h"
 #include "en/port.h"
 #include "en/params.h"
@@ -567,16 +568,13 @@ int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 	coal->rx_coalesce_usecs		= rx_moder->usec;
 	coal->rx_max_coalesced_frames	= rx_moder->pkts;
 	coal->use_adaptive_rx_coalesce	= priv->channels.params.rx_dim_enabled;
+	kernel_coal->use_cqe_mode_rx    = priv->channels.params.rx_moder_use_cqe_mode;
 
 	tx_moder = &priv->channels.params.tx_cq_moderation;
 	coal->tx_coalesce_usecs		= tx_moder->usec;
 	coal->tx_max_coalesced_frames	= tx_moder->pkts;
 	coal->use_adaptive_tx_coalesce	= priv->channels.params.tx_dim_enabled;
-
-	kernel_coal->use_cqe_mode_rx =
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODER);
-	kernel_coal->use_cqe_mode_tx =
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODER);
+	kernel_coal->use_cqe_mode_tx    = priv->channels.params.tx_moder_use_cqe_mode;
 
 	return 0;
 }
@@ -595,7 +593,7 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
 
 static void
-mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
+mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct dim_cq_moder *moder)
 {
 	int tc;
 	int i;
@@ -603,28 +601,34 @@ mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
 		struct mlx5_core_dev *mdev = c->mdev;
+		enum mlx5_cq_period_mode mode;
+
+		mode = mlx5e_cq_period_mode(moder->cq_period_mode);
+		c->tx_cq_moder = *moder;
 
 		for (tc = 0; tc < c->num_tc; tc++) {
-			mlx5_core_modify_cq_moderation(mdev,
-						&c->sq[tc].cq.mcq,
-						coal->tx_coalesce_usecs,
-						coal->tx_max_coalesced_frames);
+			mlx5e_modify_cq_moderation(mdev, &c->sq[tc].cq.mcq,
+						   moder->usec, moder->pkts,
+						   mode);
 		}
 	}
 }
 
 static void
-mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
+mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct dim_cq_moder *moder)
 {
 	int i;
 
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
 		struct mlx5_core_dev *mdev = c->mdev;
+		enum mlx5_cq_period_mode mode;
+
+		mode = mlx5e_cq_period_mode(moder->cq_period_mode);
+		c->rx_cq_moder = *moder;
 
-		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
-					       coal->rx_coalesce_usecs,
-					       coal->rx_max_coalesced_frames);
+		mlx5e_modify_cq_moderation(mdev, &c->rq.cq.mcq, moder->usec, moder->pkts,
+					   mode);
 	}
 }
 
@@ -635,13 +639,14 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5_core_dev *mdev = priv->mdev;
+	bool rx_dim_enabled, tx_dim_enabled;
 	struct mlx5e_params new_params;
 	bool reset_rx, reset_tx;
-	bool reset = true;
 	u8 cq_period_mode;
 	int err = 0;
 
-	if (!MLX5_CAP_GEN(mdev, cq_moderation))
+	if (!MLX5_CAP_GEN(mdev, cq_moderation) ||
+	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify))
 		return -EOPNOTSUPP;
 
 	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
@@ -664,60 +669,70 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
+	tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
+
 	mutex_lock(&priv->state_lock);
 	new_params = priv->channels.params;
 
-	rx_moder          = &new_params.rx_cq_moderation;
-	rx_moder->usec    = coal->rx_coalesce_usecs;
-	rx_moder->pkts    = coal->rx_max_coalesced_frames;
-	new_params.rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
+	reset_rx = mlx5e_reset_rx_channels_moderation(&priv->channels, cq_period_mode,
+						      rx_dim_enabled, false);
+	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_BASED_MODER, cq_period_mode);
 
-	tx_moder          = &new_params.tx_cq_moderation;
-	tx_moder->usec    = coal->tx_coalesce_usecs;
-	tx_moder->pkts    = coal->tx_max_coalesced_frames;
-	new_params.tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
+	reset_tx = mlx5e_reset_tx_channels_moderation(&priv->channels, cq_period_mode,
+						      tx_dim_enabled, false);
+	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_TX_CQE_BASED_MODER, cq_period_mode);
 
-	reset_rx = !!coal->use_adaptive_rx_coalesce != priv->channels.params.rx_dim_enabled;
-	reset_tx = !!coal->use_adaptive_tx_coalesce != priv->channels.params.tx_dim_enabled;
+	reset_rx |= rx_dim_enabled != new_params.rx_dim_enabled;
+	reset_tx |= tx_dim_enabled != new_params.tx_dim_enabled;
 
-	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
-	if (cq_period_mode != rx_moder->cq_period_mode) {
-		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
-		reset_rx = true;
-	}
+	/* Solely used for global ethtool get coalesce */
+	rx_moder = &new_params.rx_cq_moderation;
+	new_params.rx_dim_enabled = rx_dim_enabled;
+	new_params.rx_moder_use_cqe_mode = kernel_coal->use_cqe_mode_rx;
 
-	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
-	if (cq_period_mode != tx_moder->cq_period_mode) {
-		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
-		reset_tx = true;
-	}
+	tx_moder = &new_params.tx_cq_moderation;
+	new_params.tx_dim_enabled = tx_dim_enabled;
+	new_params.tx_moder_use_cqe_mode = kernel_coal->use_cqe_mode_tx;
 
 	if (reset_rx) {
-		u8 mode = MLX5E_GET_PFLAG(&new_params,
-					  MLX5E_PFLAG_RX_CQE_BASED_MODER);
+		mlx5e_channels_rx_change_dim(&priv->channels, false);
+		mlx5e_reset_rx_moderation(rx_moder, new_params.rx_moder_use_cqe_mode,
+					  rx_dim_enabled);
 
-		mlx5e_reset_rx_moderation(&new_params, mode);
+		mlx5e_set_priv_channels_rx_coalesce(priv, rx_moder);
+	} else if (!rx_dim_enabled) {
+		rx_moder->usec = coal->rx_coalesce_usecs;
+		rx_moder->pkts = coal->rx_max_coalesced_frames;
+
+		mlx5e_set_priv_channels_rx_coalesce(priv, rx_moder);
 	}
+
 	if (reset_tx) {
-		u8 mode = MLX5E_GET_PFLAG(&new_params,
-					  MLX5E_PFLAG_TX_CQE_BASED_MODER);
+		mlx5e_channels_tx_change_dim(&priv->channels, false);
+		mlx5e_reset_tx_moderation(tx_moder, new_params.tx_moder_use_cqe_mode,
+					  tx_dim_enabled);
 
-		mlx5e_reset_tx_moderation(&new_params, mode);
-	}
+		mlx5e_set_priv_channels_tx_coalesce(priv, tx_moder);
+	} else if (!tx_dim_enabled) {
+		tx_moder->usec = coal->tx_coalesce_usecs;
+		tx_moder->pkts = coal->tx_max_coalesced_frames;
 
-	/* If DIM state hasn't changed, it's possible to modify interrupt
-	 * moderation parameters on the fly, even if the channels are open.
-	 */
-	if (!reset_rx && !reset_tx && test_bit(MLX5E_STATE_OPENED, &priv->state)) {
-		if (!coal->use_adaptive_rx_coalesce)
-			mlx5e_set_priv_channels_rx_coalesce(priv, coal);
-		if (!coal->use_adaptive_tx_coalesce)
-			mlx5e_set_priv_channels_tx_coalesce(priv, coal);
-		reset = false;
+		mlx5e_set_priv_channels_tx_coalesce(priv, tx_moder);
 	}
 
-	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
+	/* DIM enable/disable Rx and Tx channels */
+	err = mlx5e_channels_rx_change_dim(&priv->channels, rx_dim_enabled);
+	if (err)
+		goto state_unlock;
+	err = mlx5e_channels_tx_change_dim(&priv->channels, tx_dim_enabled);
+	if (err)
+		goto state_unlock;
 
+	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, false);
+state_unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
@@ -1917,12 +1932,22 @@ static int set_pflag_cqe_based_moder(struct net_device *netdev, bool enable,
 		return 0;
 
 	new_params = priv->channels.params;
-	if (is_rx_cq)
-		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
-	else
-		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
+	if (is_rx_cq) {
+		mlx5e_reset_rx_channels_moderation(&priv->channels, cq_period_mode,
+						   false, true);
+		mlx5e_channels_rx_toggle_dim(&priv->channels);
+		MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
+				cq_period_mode);
+	} else {
+		mlx5e_reset_tx_channels_moderation(&priv->channels, cq_period_mode,
+						   false, true);
+		mlx5e_channels_tx_toggle_dim(&priv->channels);
+		MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
+				cq_period_mode);
+	}
 
-	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	/* Update pflags of existing channels without resetting them */
+	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, false);
 }
 
 static int set_pflag_tx_cqe_based_moder(struct net_device *netdev, bool enable)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8b4ecae0fd9f..3bd0695845c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -962,20 +962,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		}
 	}
 
-	rq->dim = kvzalloc_node(sizeof(*rq->dim), GFP_KERNEL, node);
-	if (!rq->dim) {
-		err = -ENOMEM;
-		goto err_unreg_xdp_rxq_info;
-	}
-
-	rq->dim->priv = rq;
-	INIT_WORK(&rq->dim->work, mlx5e_rx_dim_work);
-	rq->dim->mode = params->rx_cq_moderation.cq_period_mode;
-
 	return 0;
 
-err_unreg_xdp_rxq_info:
-	xdp_rxq_info_unreg(&rq->xdp_rxq);
 err_destroy_page_pool:
 	page_pool_destroy(rq->page_pool);
 err_free_by_rq_type:
@@ -1304,8 +1292,21 @@ int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *param,
 	if (MLX5_CAP_ETH(mdev, cqe_checksum_full))
 		__set_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state);
 
-	if (params->rx_dim_enabled)
-		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
+	if (rq->channel && !params->rx_dim_enabled) {
+		rq->channel->rx_cq_moder = params->rx_cq_moderation;
+	} else if (rq->channel) {
+		u8 cq_period_mode;
+
+		cq_period_mode = params->rx_moder_use_cqe_mode ?
+					 DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+					 DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+		mlx5e_reset_rx_moderation(&rq->channel->rx_cq_moder, cq_period_mode,
+					  params->rx_dim_enabled);
+
+		err = mlx5e_dim_rx_change(rq, params->rx_dim_enabled);
+		if (err)
+			goto err_destroy_rq;
+	}
 
 	/* We disable csum_complete when XDP is enabled since
 	 * XDP programs might manipulate packets which will render
@@ -1351,7 +1352,8 @@ void mlx5e_deactivate_rq(struct mlx5e_rq *rq)
 
 void mlx5e_close_rq(struct mlx5e_rq *rq)
 {
-	cancel_work_sync(&rq->dim->work);
+	if (rq->dim)
+		cancel_work_sync(&rq->dim->work);
 	cancel_work_sync(&rq->recover_work);
 	mlx5e_destroy_rq(rq);
 	mlx5e_free_rx_descs(rq);
@@ -1626,20 +1628,9 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	err = mlx5e_alloc_txqsq_db(sq, cpu_to_node(c->cpu));
 	if (err)
 		goto err_sq_wq_destroy;
-	sq->dim = kvzalloc_node(sizeof(*sq->dim), GFP_KERNEL, cpu_to_node(c->cpu));
-	if (!sq->dim) {
-		err = -ENOMEM;
-		goto err_free_txqsq_db;
-	}
-
-	sq->dim->priv = sq;
-	INIT_WORK(&sq->dim->work, mlx5e_tx_dim_work);
-	sq->dim->mode = params->tx_cq_moderation.cq_period_mode;
 
 	return 0;
 
-err_free_txqsq_db:
-	mlx5e_free_txqsq_db(sq);
 err_sq_wq_destroy:
 	mlx5_wq_destroy(&sq->wq_ctrl);
 
@@ -1804,11 +1795,27 @@ int mlx5e_open_txqsq(struct mlx5e_channel *c, u32 tisn, int txq_ix,
 	if (tx_rate)
 		mlx5e_set_sq_maxrate(c->netdev, sq, tx_rate);
 
-	if (params->tx_dim_enabled)
-		sq->state |= BIT(MLX5E_SQ_STATE_DIM);
+	if (sq->channel && !params->tx_dim_enabled) {
+		sq->channel->tx_cq_moder = params->tx_cq_moderation;
+	} else if (sq->channel) {
+		u8 cq_period_mode;
+
+		cq_period_mode = params->tx_moder_use_cqe_mode ?
+					 DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+					 DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+		mlx5e_reset_tx_moderation(&sq->channel->tx_cq_moder,
+					  cq_period_mode,
+					  params->tx_dim_enabled);
+
+		err = mlx5e_dim_tx_change(sq, params->tx_dim_enabled);
+		if (err)
+			goto err_destroy_sq;
+	}
 
 	return 0;
 
+err_destroy_sq:
+	mlx5e_destroy_sq(c->mdev, sq->sqn);
 err_free_txqsq:
 	mlx5e_free_txqsq(sq);
 
@@ -1860,7 +1867,8 @@ void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
 	struct mlx5_core_dev *mdev = sq->mdev;
 	struct mlx5_rate_limit rl = {0};
 
-	cancel_work_sync(&sq->dim->work);
+	if (sq->dim)
+		cancel_work_sync(&sq->dim->work);
 	cancel_work_sync(&sq->recover_work);
 	mlx5e_destroy_sq(mdev, sq->sqn);
 	if (sq->rate_limit) {
@@ -1879,6 +1887,49 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
 	mlx5e_reporter_tx_err_cqe(sq);
 }
 
+static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
+{
+	return (struct dim_cq_moder) {
+		.cq_period_mode = cq_period_mode,
+		.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS,
+		.usec = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+				MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE :
+				MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC,
+	};
+}
+
+bool mlx5e_reset_tx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled)
+{
+	bool reset_needed = cq_moder->cq_period_mode != cq_period_mode;
+
+	if (dim_enabled)
+		*cq_moder = net_dim_get_def_tx_moderation(cq_period_mode);
+	else
+		*cq_moder = mlx5e_get_def_tx_moderation(cq_period_mode);
+
+	return reset_needed;
+}
+
+bool mlx5e_reset_tx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state)
+{
+	bool reset = false;
+	int i, tc;
+
+	for (i = 0; i < chs->num; i++) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			if (keep_dim_state)
+				dim_enabled = !!chs->c[i]->sq[tc].dim;
+
+			reset |= mlx5e_reset_tx_moderation(&chs->c[i]->tx_cq_moder,
+							   cq_period_mode, dim_enabled);
+		}
+	}
+
+	return reset;
+}
+
 static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params,
 			    struct mlx5e_sq_param *param, struct mlx5e_icosq *sq,
 			    work_func_t recover_work_func)
@@ -2102,7 +2153,8 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
-	MLX5_SET(cqc,   cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
+	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
+
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
 	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
@@ -2140,8 +2192,10 @@ int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
 	if (err)
 		goto err_free_cq;
 
-	if (MLX5_CAP_GEN(mdev, cq_moderation))
-		mlx5_core_modify_cq_moderation(mdev, &cq->mcq, moder.usec, moder.pkts);
+	if (MLX5_CAP_GEN(mdev, cq_moderation) &&
+	    MLX5_CAP_GEN(mdev, cq_period_mode_modify))
+		mlx5e_modify_cq_moderation(mdev, &cq->mcq, moder.usec, moder.pkts,
+					   mlx5e_cq_period_mode(moder.cq_period_mode));
 	return 0;
 
 err_free_cq:
@@ -2156,6 +2210,40 @@ void mlx5e_close_cq(struct mlx5e_cq *cq)
 	mlx5e_free_cq(cq);
 }
 
+int mlx5e_modify_cq_period_mode(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+				u8 cq_period_mode)
+{
+	u32 in[MLX5_ST_SZ_DW(modify_cq_in)] = {};
+	void *cqc;
+
+	MLX5_SET(modify_cq_in, in, cqn, cq->cqn);
+	cqc = MLX5_ADDR_OF(modify_cq_in, in, cq_context);
+	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(cq_period_mode));
+	MLX5_SET(modify_cq_in, in,
+		 modify_field_select_resize_field_select.modify_field_select.modify_field_select,
+		 MLX5_CQ_MODIFY_PERIOD_MODE);
+
+	return mlx5_core_modify_cq(dev, cq, in, sizeof(in));
+}
+
+int mlx5e_modify_cq_moderation(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+			       u16 cq_period, u16 cq_max_count, u8 cq_period_mode)
+{
+	u32 in[MLX5_ST_SZ_DW(modify_cq_in)] = {};
+	void *cqc;
+
+	MLX5_SET(modify_cq_in, in, cqn, cq->cqn);
+	cqc = MLX5_ADDR_OF(modify_cq_in, in, cq_context);
+	MLX5_SET(cqc, cqc, cq_period, cq_period);
+	MLX5_SET(cqc, cqc, cq_max_count, cq_max_count);
+	MLX5_SET(cqc, cqc, cq_period_mode, cq_period_mode);
+	MLX5_SET(modify_cq_in, in,
+		 modify_field_select_resize_field_select.modify_field_select.modify_field_select,
+		 MLX5_CQ_MODIFY_PERIOD | MLX5_CQ_MODIFY_COUNT | MLX5_CQ_MODIFY_PERIOD_MODE);
+
+	return mlx5_core_modify_cq(dev, cq, in, sizeof(in));
+}
+
 static int mlx5e_open_tx_cqs(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
 			     struct mlx5e_create_cq_param *ccp,
@@ -3973,6 +4061,47 @@ static int set_feature_rx_all(struct net_device *netdev, bool enable)
 	return mlx5_set_port_fcs(mdev, !enable);
 }
 
+static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
+{
+	return (struct dim_cq_moder) {
+		.cq_period_mode = cq_period_mode,
+		.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS,
+		.usec = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+				MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE :
+				MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC,
+	};
+}
+
+bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled)
+{
+	bool reset_needed = cq_moder->cq_period_mode != cq_period_mode;
+
+	if (dim_enabled)
+		*cq_moder = net_dim_get_def_rx_moderation(cq_period_mode);
+	else
+		*cq_moder = mlx5e_get_def_rx_moderation(cq_period_mode);
+
+	return reset_needed;
+}
+
+bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state)
+{
+	bool reset = false;
+	int i;
+
+	for (i = 0; i < chs->num; i++) {
+		if (keep_dim_state)
+			dim_enabled = !!chs->c[i]->rq.dim;
+
+		reset |= mlx5e_reset_rx_moderation(&chs->c[i]->rx_cq_moder,
+						   cq_period_mode, dim_enabled);
+	}
+
+	return reset;
+}
+
 static int mlx5e_set_rx_port_ts(struct mlx5_core_dev *mdev, bool enable)
 {
 	u32 in[MLX5_ST_SZ_DW(pcmr_reg)] = {};
@@ -5037,7 +5166,6 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
 {
 	struct mlx5e_params *params = &priv->channels.params;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u8 rx_cq_period_mode;
 
 	params->sw_mtu = mtu;
 	params->hard_mtu = MLX5E_ETH_HARD_MTU;
@@ -5071,12 +5199,16 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
 	params->packet_merge.timeout = mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_LRO_TIMEOUT);
 
 	/* CQ moderation params */
-	rx_cq_period_mode =
-		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
-	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
-	mlx5e_set_tx_cq_mode_params(params, DIM_CQ_PERIOD_MODE_START_FROM_EQE);
+	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation) &&
+				 MLX5_CAP_GEN(mdev, cq_period_mode_modify);
+	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation) &&
+				 MLX5_CAP_GEN(mdev, cq_period_mode_modify);
+	params->rx_moder_use_cqe_mode = !!MLX5_CAP_GEN(mdev, cq_period_start_from_cqe);
+	params->tx_moder_use_cqe_mode = false;
+	mlx5e_reset_rx_moderation(&params->rx_cq_moderation, params->rx_moder_use_cqe_mode,
+				  params->rx_dim_enabled);
+	mlx5e_reset_tx_moderation(&params->tx_cq_moderation, params->tx_moder_use_cqe_mode,
+				  params->tx_dim_enabled);
 
 	/* TX inline */
 	mlx5_query_min_inline(mdev, &params->tx_min_inline_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 309771300581..6477b91ff512 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -838,9 +838,6 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_params *params;
 
-	u8 cq_period_mode =
-		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
-
 	params = &priv->channels.params;
 
 	params->num_channels = MLX5E_REP_PARAMS_DEF_NUM_CHANNELS;
@@ -868,7 +865,7 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	mlx5e_set_rx_cq_mode_params(params, cq_period_mode);
+	params->rx_moder_use_cqe_mode = !!MLX5_CAP_GEN(mdev, cq_period_start_from_cqe);
 
 	params->mqprio.num_tc       = 1;
 	if (rep->vport != MLX5_VPORT_UPLINK)
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index cb15308b5cb0..991526039ccb 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -95,9 +95,10 @@ enum {
 };
 
 enum {
-	MLX5_CQ_MODIFY_PERIOD	= 1 << 0,
-	MLX5_CQ_MODIFY_COUNT	= 1 << 1,
-	MLX5_CQ_MODIFY_OVERRUN	= 1 << 2,
+	MLX5_CQ_MODIFY_PERIOD		= BIT(0),
+	MLX5_CQ_MODIFY_COUNT		= BIT(1),
+	MLX5_CQ_MODIFY_OVERRUN		= BIT(2),
+	MLX5_CQ_MODIFY_PERIOD_MODE	= BIT(4),
 };
 
 enum {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8c7ddb22bf20..f468763478ae 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1686,7 +1686,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         cq_oi[0x1];
 	u8         cq_resize[0x1];
 	u8         cq_moderation[0x1];
-	u8         reserved_at_223[0x3];
+	u8         cq_period_mode_modify[0x1];
+	u8         reserved_at_224[0x2];
 	u8         cq_eq_remap[0x1];
 	u8         pg[0x1];
 	u8         block_lb_mc[0x1];
-- 
2.31.1


