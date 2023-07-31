Return-Path: <netdev+bounces-22796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4C7694E5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F5280A64
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C1182D2;
	Mon, 31 Jul 2023 11:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F43182A1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8616DC433C9;
	Mon, 31 Jul 2023 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802937;
	bh=6T5rz0L86Aeh+S54bbIHiK0HGmw90EeqCP5SxUBbYk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njAbskVLdbtcOg4YA/uczz1o/3spnZnOLRH513Cdl35iWJyxLSr6KHgN5+d+2ciw5
	 32Hb7Sippz0pCgAzHMjflhAIbfXbxiZFASZdpI/OaYWJKyzV33oVGnwCzlwTdAiWaz
	 Td7eRpBIR50CX0WDWm0ISMOoq8qBTkb4f2T+nyUsA8B+0VUbV5Qm8QftONY4ZP1RI1
	 CAjiXGJWoBJ4l16lUAADlUdYYttdYcDdbhNObWc3Wips+COF+k4QiPyqY6dwlMLOVO
	 NFZLynid//ZvvqD5AAOKcq7RMD2nRtxRuhSWnlWu+AQY1TDz9mMQqqs4sgPrtDnoVq
	 p3+dICW605ZaQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 04/13] net/mlx5e: Refactor IPsec RX tables creation and destruction
Date: Mon, 31 Jul 2023 14:28:15 +0300
Message-ID: <87478d928479b6a4eee41901204546ea05741815.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
References: <cover.1690802064.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Add attribute for IPsec RX creation, so rx_create() can be used by
eswitch in later patch. And move the code for TTC dest
connect/disconnect, which are needed only in NIC mode, to individual
functions.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  11 ++
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 100 ++++++++++++------
 2 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index e12154276666..03d83cdf1e20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -169,6 +169,17 @@ struct mlx5e_ipsec_aso {
 	spinlock_t lock;
 };
 
+struct mlx5e_ipsec_rx_create_attr {
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_ttc_table *ttc;
+	u32 family;
+	int prio;
+	int pol_level;
+	int sa_level;
+	int status_level;
+	enum mlx5_flow_namespace_type chains_ns;
+};
+
 struct mlx5e_ipsec {
 	struct mlx5_core_dev *mdev;
 	struct xarray sadb;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 0f0c48f5f620..52e382948c13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -249,13 +249,19 @@ static int ipsec_miss_create(struct mlx5_core_dev *mdev,
 	return err;
 }
 
+static void ipsec_rx_ft_disconnect(struct mlx5e_ipsec *ipsec, u32 family)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
+
+	mlx5_ttc_fwd_default_dest(ttc, family2tt(family));
+}
+
 static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		       struct mlx5e_ipsec_rx *rx, u32 family)
 {
-	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
 
 	/* disconnect */
-	mlx5_ttc_fwd_default_dest(ttc, family2tt(family));
+	ipsec_rx_ft_disconnect(ipsec, family);
 
 	if (rx->chains) {
 		ipsec_chains_destroy(rx->chains);
@@ -277,41 +283,78 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family);
 }
 
+static void ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
+				     struct mlx5e_ipsec_rx *rx,
+				     u32 family,
+				     struct mlx5e_ipsec_rx_create_attr *attr)
+{
+	attr->ns = mlx5e_fs_get_ns(ipsec->fs, false);
+	attr->ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
+	attr->family = family;
+	attr->prio = MLX5E_NIC_PRIO;
+	attr->pol_level = MLX5E_ACCEL_FS_POL_FT_LEVEL;
+	attr->sa_level = MLX5E_ACCEL_FS_ESP_FT_LEVEL;
+	attr->status_level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL;
+	attr->chains_ns = MLX5_FLOW_NAMESPACE_KERNEL;
+}
+
+static int ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx,
+					 struct mlx5e_ipsec_rx_create_attr *attr,
+					 struct mlx5_flow_destination *dest)
+{
+	struct mlx5_flow_table *ft;
+	int err;
+
+	*dest = mlx5_ttc_get_default_dest(attr->ttc, family2tt(attr->family));
+	err = mlx5_ipsec_fs_roce_rx_create(ipsec->mdev, ipsec->roce, attr->ns, dest,
+					   attr->family, MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL,
+					   attr->prio);
+	if (err)
+		return err;
+
+	ft = mlx5_ipsec_fs_roce_ft_get(ipsec->roce, attr->family);
+	if (ft) {
+		dest->type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+		dest->ft = ft;
+	}
+
+	return 0;
+}
+
+static void ipsec_rx_ft_connect(struct mlx5e_ipsec *ipsec,
+				struct mlx5e_ipsec_rx *rx,
+				struct mlx5e_ipsec_rx_create_attr *attr)
+{
+	struct mlx5_flow_destination dest = {};
+
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = rx->ft.pol;
+	mlx5_ttc_fwd_dest(attr->ttc, family2tt(attr->family), &dest);
+}
+
 static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		     struct mlx5e_ipsec_rx *rx, u32 family)
 {
-	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(ipsec->fs, false);
-	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
-	struct mlx5_flow_destination default_dest;
+	struct mlx5e_ipsec_rx_create_attr attr;
 	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_table *ft;
 	u32 flags = 0;
 	int err;
 
-	default_dest = mlx5_ttc_get_default_dest(ttc, family2tt(family));
-	err = mlx5_ipsec_fs_roce_rx_create(mdev, ipsec->roce, ns, &default_dest,
-					   family, MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL,
-					   MLX5E_NIC_PRIO);
+	ipsec_rx_create_attr_set(ipsec, rx, family, &attr);
+
+	err = ipsec_rx_status_pass_dest_get(ipsec, rx, &attr, &dest[0]);
 	if (err)
 		return err;
 
-	ft = ipsec_ft_create(ns, MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL,
-			     MLX5E_NIC_PRIO, 1, 0);
+	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 1, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft_status;
 	}
-
 	rx->ft.status = ft;
 
-	ft = mlx5_ipsec_fs_roce_ft_get(ipsec->roce, family);
-	if (ft) {
-		dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-		dest[0].ft = ft;
-	} else {
-		dest[0] = default_dest;
-	}
-
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter_id = mlx5_fc_id(rx->fc->cnt);
 	err = ipsec_status_rule(mdev, rx, dest);
@@ -323,8 +366,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (rx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
-	ft = ipsec_ft_create(ns, MLX5E_ACCEL_FS_ESP_FT_LEVEL, MLX5E_NIC_PRIO, 2,
-			     flags);
+	ft = ipsec_ft_create(attr.ns, attr.sa_level, attr.prio, 2, flags);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft;
@@ -337,9 +379,9 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PRIO) {
 		rx->chains = ipsec_chains_create(mdev, rx->ft.sa,
-						 MLX5_FLOW_NAMESPACE_KERNEL,
-						 MLX5E_NIC_PRIO,
-						 MLX5E_ACCEL_FS_POL_FT_LEVEL,
+						 attr.chains_ns,
+						 attr.prio,
+						 attr.pol_level,
 						 &rx->ft.pol);
 		if (IS_ERR(rx->chains)) {
 			err = PTR_ERR(rx->chains);
@@ -349,8 +391,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		goto connect;
 	}
 
-	ft = ipsec_ft_create(ns, MLX5E_ACCEL_FS_POL_FT_LEVEL, MLX5E_NIC_PRIO,
-			     2, 0);
+	ft = ipsec_ft_create(attr.ns, attr.pol_level, attr.prio, 2, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_pol_ft;
@@ -365,10 +406,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 connect:
 	/* connect */
-	memset(dest, 0x00, sizeof(*dest));
-	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest[0].ft = rx->ft.pol;
-	mlx5_ttc_fwd_dest(ttc, family2tt(family), &dest[0]);
+	ipsec_rx_ft_connect(ipsec, rx, &attr);
 	return 0;
 
 err_pol_miss:
-- 
2.41.0


