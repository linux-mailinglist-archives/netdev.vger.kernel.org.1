Return-Path: <netdev+bounces-53777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B48049DA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6861C20E45
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567A11CA3;
	Tue,  5 Dec 2023 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryw9ybmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC211708
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111A0C433C7;
	Tue,  5 Dec 2023 06:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756823;
	bh=6mI26fIy1eQzjeC1EGM43oqmycLRfNe8yE/0UbafE+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ryw9ybmQhQl88a15fZsnJVI4cle0qef+JPJRhfJxDkVqX41Ztm0IZ/DHn/LhtfY6o
	 nDNRTKGrwcvxWlOyqxIG0YowdER5UzajEpf+NECVqAvD/7HanzxRPBQ2CIf6k1sa+j
	 TSbjuAl8II5Sediz0sRyfEw/YdTeVsNkHlwoPMOhjtWVcd5laf8+3p3+qgxhYlk5KA
	 5N1fVxASB8J3EF0/p7iI2rwiF+Zn87WWeQCLoJTrJkHtgqF0LTUfe57qZU0nS/JiJW
	 5buBaWQZ1NiDzd2mRP5+OfnyZ6fl9dyMCQq4Eu1xYBwHuqs5zfQkZJ0HlwZRIF47dA
	 fzYyJ4wpdkAIw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net V2 04/14] net/mlx5e: Remove exposure of IPsec RX flow steering struct
Date: Mon,  4 Dec 2023 22:13:17 -0800
Message-ID: <20231205061327.44638-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205061327.44638-1-saeed@kernel.org>
References: <20231205061327.44638-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After previous commit, which unified various IPsec creation modes,
there is no need to have struct mlx5e_ipsec_rx exposed in global
IPsec header. Move it to ipsec_fs.c to be placed together with
already existing struct mlx5e_ipsec_tx.

Fixes: 1762f132d542 ("net/mlx5e: Support IPsec packet offload for RX in switchdev mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h | 14 +-------------
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c       | 16 ++++++++++++++--
 .../ethernet/mellanox/mlx5/core/esw/ipsec_fs.c   |  8 ++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 8f4a37bceaf4..c3a40bf11952 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -201,19 +201,6 @@ struct mlx5e_ipsec_miss {
 	struct mlx5_flow_handle *rule;
 };
 
-struct mlx5e_ipsec_rx {
-	struct mlx5e_ipsec_ft ft;
-	struct mlx5e_ipsec_miss pol;
-	struct mlx5e_ipsec_miss sa;
-	struct mlx5e_ipsec_rule status;
-	struct mlx5e_ipsec_miss status_drop;
-	struct mlx5_fc *status_drop_cnt;
-	struct mlx5e_ipsec_fc *fc;
-	struct mlx5_fs_chains *chains;
-	u8 allow_tunnel_mode : 1;
-	struct xarray ipsec_obj_id_map;
-};
-
 struct mlx5e_ipsec_tx_create_attr {
 	int prio;
 	int pol_level;
@@ -248,6 +235,7 @@ struct mlx5e_ipsec {
 	struct mlx5_ipsec_fs *roce;
 	u8 is_uplink_rep: 1;
 	struct mlx5e_ipsec_mpv_work mpv_work;
+	struct xarray ipsec_obj_id_map;
 };
 
 struct mlx5e_ipsec_esn_state {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 85ed5171e835..aa74a2422869 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -32,6 +32,18 @@ struct mlx5e_ipsec_tx {
 	u8 allow_tunnel_mode : 1;
 };
 
+struct mlx5e_ipsec_rx {
+	struct mlx5e_ipsec_ft ft;
+	struct mlx5e_ipsec_miss pol;
+	struct mlx5e_ipsec_miss sa;
+	struct mlx5e_ipsec_rule status;
+	struct mlx5e_ipsec_miss status_drop;
+	struct mlx5_fc *status_drop_cnt;
+	struct mlx5e_ipsec_fc *fc;
+	struct mlx5_fs_chains *chains;
+	u8 allow_tunnel_mode : 1;
+};
+
 /* IPsec RX flow steering */
 static enum mlx5_traffic_types family2tt(u32 family)
 {
@@ -2052,7 +2064,7 @@ void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec)
 	kfree(ipsec->rx_ipv6);
 
 	if (ipsec->is_uplink_rep) {
-		xa_destroy(&ipsec->rx_esw->ipsec_obj_id_map);
+		xa_destroy(&ipsec->ipsec_obj_id_map);
 
 		mutex_destroy(&ipsec->tx_esw->ft.mutex);
 		WARN_ON(ipsec->tx_esw->ft.refcnt);
@@ -2115,7 +2127,7 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec,
 		mutex_init(&ipsec->tx_esw->ft.mutex);
 		mutex_init(&ipsec->rx_esw->ft.mutex);
 		ipsec->tx_esw->ns = ns_esw;
-		xa_init_flags(&ipsec->rx_esw->ipsec_obj_id_map, XA_FLAGS_ALLOC1);
+		xa_init_flags(&ipsec->ipsec_obj_id_map, XA_FLAGS_ALLOC1);
 	} else if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ROCE) {
 		ipsec->roce = mlx5_ipsec_fs_roce_init(mdev, devcom);
 	} else {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 13b5916b64e2..5a0047bdcb51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -50,7 +50,7 @@ int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
 	u32 mapped_id;
 	int err;
 
-	err = xa_alloc_bh(&ipsec->rx_esw->ipsec_obj_id_map, &mapped_id,
+	err = xa_alloc_bh(&ipsec->ipsec_obj_id_map, &mapped_id,
 			  xa_mk_value(sa_entry->ipsec_obj_id),
 			  XA_LIMIT(1, ESW_IPSEC_RX_MAPPED_ID_MASK), 0);
 	if (err)
@@ -81,7 +81,7 @@ int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
 	return 0;
 
 err_header_alloc:
-	xa_erase_bh(&ipsec->rx_esw->ipsec_obj_id_map, mapped_id);
+	xa_erase_bh(&ipsec->ipsec_obj_id_map, mapped_id);
 	return err;
 }
 
@@ -90,7 +90,7 @@ void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry)
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
 
 	if (sa_entry->rx_mapped_id)
-		xa_erase_bh(&ipsec->rx_esw->ipsec_obj_id_map,
+		xa_erase_bh(&ipsec->ipsec_obj_id_map,
 			    sa_entry->rx_mapped_id);
 }
 
@@ -100,7 +100,7 @@ int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 	struct mlx5e_ipsec *ipsec = priv->ipsec;
 	void *val;
 
-	val = xa_load(&ipsec->rx_esw->ipsec_obj_id_map, id);
+	val = xa_load(&ipsec->ipsec_obj_id_map, id);
 	if (!val)
 		return -ENOENT;
 
-- 
2.43.0


