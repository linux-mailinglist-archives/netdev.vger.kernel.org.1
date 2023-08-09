Return-Path: <netdev+bounces-25747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B8775581
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CDF281B21
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5F1800A;
	Wed,  9 Aug 2023 08:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C218AFB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9C0C433CB;
	Wed,  9 Aug 2023 08:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569809;
	bh=+KYaDJrOqox9KPVZcGnFyb4a2uCbGYrl4dYKAm3Z1iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rc3GXkOylyyWtvQ2+Nf+xEytdJ8tD4b9MRJutL2Ia04c9qff8nBRffWlUnlqf/624
	 qeq9hluTR3SDBeHKqRNRmmoXVlSyCdFKMAw1YBqHJn8nh2DIxQmQHBrmUJqCyI0Vau
	 PbwxNW7a4pXNZUDqe24mqBQ82FD5a25Pal86AOweY4duqmstjMgCbV6Q2Zfikg8IUY
	 gDTmP6rNFKTvHkwnxkA0iXbNibHK4QSCACxfX9Dnm0dw1Ey0LouBr6041PxM80Ncsb
	 inpchRe/G0jn8OPCMfFA01bWF8zUx7waC2ol1WTs73SDMGrWhNiYKOcVD2KzKtOOhg
	 4M9YcRgxInvXw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 09/14] net/mlx5: Add MACsec priorities in RDMA namespaces
Date: Wed,  9 Aug 2023 11:29:21 +0300
Message-ID: <268fc32919777ca468453e085bfa36c9abe1f140.1691569414.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691569414.git.leon@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add MACsec flow steering priorities in RDMA namespaces. This allows
adding tables/rules to forward RoCEv2 traffic to the MACsec crypto
tables in NIC_TX domain, and accept RoCEv2 traffic from NIC_RX domain.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 35 +++++++++++++++++--
 include/linux/mlx5/fs.h                       |  2 ++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a3228502f866..815fe6393c4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -224,6 +224,7 @@ static struct init_tree_node egress_root_fs = {
 
 enum {
 	RDMA_RX_IPSEC_PRIO,
+	RDMA_RX_MACSEC_PRIO,
 	RDMA_RX_COUNTERS_PRIO,
 	RDMA_RX_BYPASS_PRIO,
 	RDMA_RX_KERNEL_PRIO,
@@ -237,9 +238,13 @@ enum {
 #define RDMA_RX_KERNEL_MIN_LEVEL (RDMA_RX_BYPASS_MIN_LEVEL + 1)
 #define RDMA_RX_COUNTERS_MIN_LEVEL (RDMA_RX_KERNEL_MIN_LEVEL + 2)
 
+#define RDMA_RX_MACSEC_NUM_PRIOS 1
+#define RDMA_RX_MACSEC_PRIO_NUM_LEVELS 2
+#define RDMA_RX_MACSEC_MIN_LEVEL  (RDMA_RX_COUNTERS_MIN_LEVEL + RDMA_RX_MACSEC_NUM_PRIOS)
+
 static struct init_tree_node rdma_rx_root_fs = {
 	.type = FS_TYPE_NAMESPACE,
-	.ar_size = 4,
+	.ar_size = 5,
 	.children = (struct init_tree_node[]) {
 		[RDMA_RX_IPSEC_PRIO] =
 		ADD_PRIO(0, RDMA_RX_IPSEC_MIN_LEVEL, 0,
@@ -247,6 +252,12 @@ static struct init_tree_node rdma_rx_root_fs = {
 			 ADD_NS(MLX5_FLOW_TABLE_MISS_ACTION_DEF,
 				ADD_MULTIPLE_PRIO(RDMA_RX_IPSEC_NUM_PRIOS,
 						  RDMA_RX_IPSEC_NUM_LEVELS))),
+		[RDMA_RX_MACSEC_PRIO] =
+		ADD_PRIO(0, RDMA_RX_MACSEC_MIN_LEVEL, 0,
+			 FS_CHAINING_CAPS,
+			 ADD_NS(MLX5_FLOW_TABLE_MISS_ACTION_DEF,
+				ADD_MULTIPLE_PRIO(RDMA_RX_MACSEC_NUM_PRIOS,
+						  RDMA_RX_MACSEC_PRIO_NUM_LEVELS))),
 		[RDMA_RX_COUNTERS_PRIO] =
 		ADD_PRIO(0, RDMA_RX_COUNTERS_MIN_LEVEL, 0,
 			 FS_CHAINING_CAPS,
@@ -270,6 +281,7 @@ static struct init_tree_node rdma_rx_root_fs = {
 enum {
 	RDMA_TX_COUNTERS_PRIO,
 	RDMA_TX_IPSEC_PRIO,
+	RDMA_TX_MACSEC_PRIO,
 	RDMA_TX_BYPASS_PRIO,
 };
 
@@ -280,9 +292,13 @@ enum {
 #define RDMA_TX_IPSEC_PRIO_NUM_LEVELS 1
 #define RDMA_TX_IPSEC_MIN_LEVEL  (RDMA_TX_COUNTERS_MIN_LEVEL + RDMA_TX_IPSEC_NUM_PRIOS)
 
+#define RDMA_TX_MACSEC_NUM_PRIOS 1
+#define RDMA_TX_MACESC_PRIO_NUM_LEVELS 1
+#define RDMA_TX_MACSEC_MIN_LEVEL  (RDMA_TX_COUNTERS_MIN_LEVEL + RDMA_TX_MACSEC_NUM_PRIOS)
+
 static struct init_tree_node rdma_tx_root_fs = {
 	.type = FS_TYPE_NAMESPACE,
-	.ar_size = 3,
+	.ar_size = 4,
 	.children = (struct init_tree_node[]) {
 		[RDMA_TX_COUNTERS_PRIO] =
 		ADD_PRIO(0, RDMA_TX_COUNTERS_MIN_LEVEL, 0,
@@ -296,7 +312,12 @@ static struct init_tree_node rdma_tx_root_fs = {
 			 ADD_NS(MLX5_FLOW_TABLE_MISS_ACTION_DEF,
 				ADD_MULTIPLE_PRIO(RDMA_TX_IPSEC_NUM_PRIOS,
 						  RDMA_TX_IPSEC_PRIO_NUM_LEVELS))),
-
+		[RDMA_TX_MACSEC_PRIO] =
+		ADD_PRIO(0, RDMA_TX_MACSEC_MIN_LEVEL, 0,
+			 FS_CHAINING_CAPS,
+			 ADD_NS(MLX5_FLOW_TABLE_MISS_ACTION_DEF,
+				ADD_MULTIPLE_PRIO(RDMA_TX_MACSEC_NUM_PRIOS,
+						  RDMA_TX_MACESC_PRIO_NUM_LEVELS))),
 		[RDMA_TX_BYPASS_PRIO] =
 		ADD_PRIO(0, RDMA_TX_BYPASS_MIN_LEVEL, 0,
 			 FS_CHAINING_CAPS_RDMA_TX,
@@ -2466,6 +2487,14 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 		root_ns = steering->rdma_tx_root_ns;
 		prio = RDMA_TX_IPSEC_PRIO;
 		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_RX_MACSEC:
+		root_ns = steering->rdma_rx_root_ns;
+		prio = RDMA_RX_MACSEC_PRIO;
+		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC:
+		root_ns = steering->rdma_tx_root_ns;
+		prio = RDMA_TX_MACSEC_PRIO;
+		break;
 	default: /* Must be NIC RX */
 		WARN_ON(!is_nic_rx_ns(type));
 		root_ns = steering->root_ns;
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index c302ec34255b..1e00c2436377 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -105,6 +105,8 @@ enum mlx5_flow_namespace_type {
 	MLX5_FLOW_NAMESPACE_RDMA_TX_COUNTERS,
 	MLX5_FLOW_NAMESPACE_RDMA_RX_IPSEC,
 	MLX5_FLOW_NAMESPACE_RDMA_TX_IPSEC,
+	MLX5_FLOW_NAMESPACE_RDMA_RX_MACSEC,
+	MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
 };
 
 enum {
-- 
2.41.0


