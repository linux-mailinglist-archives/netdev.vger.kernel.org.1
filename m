Return-Path: <netdev+bounces-54140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971E8060FC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3631281DD2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF896EB67;
	Tue,  5 Dec 2023 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFnVv/ao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230276EB7D
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7FC433C7;
	Tue,  5 Dec 2023 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812745;
	bh=DgdpZP7HfWSjHLe0/4veOtRw/mTKBaoDCHkHZgy2K8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFnVv/aoYn/5W4HxedlQypV6JS4dQAMYpbi72YGnI04JJn3gcR6NElDeusnhjOzyv
	 jKKnH1/M+JNXv8qj+HDk2yG0tDkhLTm4ENl8na15pRJpKJebrT2cBzJKwBkWh0w/2d
	 iST6CpG+x4Wpyz0Idp+nv58rhUkQcP9wSfkG29RbIJh9NzlAmyzDlk2gCmMsylpHUf
	 qImQroOVbd2f5WxKKkrr3TmyN/GokwGUSUOwgmjZMBH1NkEW6M40UaJEskRAbHOHJp
	 WC9GNiW6+hZxo3gSCZjO0hHCe0jEUsqDyhd9+COZ8GDv+jqFfNjHGmD5D9RT9ZgyNM
	 jqr6HV8a60pDA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net V3 08/15] net/mlx5e: Disable IPsec offload support if not FW steering
Date: Tue,  5 Dec 2023 13:45:27 -0800
Message-ID: <20231205214534.77771-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205214534.77771-1-saeed@kernel.org>
References: <20231205214534.77771-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mi <cmi@nvidia.com>

IPsec FDB offload can only work with FW steering as of now,
disable the cap upon non FW steering.

And since the IPSec cap is dynamic now based on steering mode.
Cleanup the resources if they exist instead of checking the
IPsec cap again.

Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 26 ++++++++-----------
 .../mlx5/core/en_accel/ipsec_offload.c        |  8 +++++-
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 914b9e6eb7db..161c5190c236 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -935,9 +935,11 @@ void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv)
 		return;
 
 	mlx5e_accel_ipsec_fs_cleanup(ipsec);
-	if (mlx5_ipsec_device_caps(priv->mdev) & MLX5_IPSEC_CAP_TUNNEL)
+	if (ipsec->netevent_nb.notifier_call) {
 		unregister_netevent_notifier(&ipsec->netevent_nb);
-	if (mlx5_ipsec_device_caps(priv->mdev) & MLX5_IPSEC_CAP_PACKET_OFFLOAD)
+		ipsec->netevent_nb.notifier_call = NULL;
+	}
+	if (ipsec->aso)
 		mlx5e_ipsec_aso_cleanup(ipsec);
 	destroy_workqueue(ipsec->wq);
 	kfree(ipsec);
@@ -1046,6 +1048,12 @@ static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
 		}
 	}
 
+	if (x->xdo.type == XFRM_DEV_OFFLOAD_PACKET &&
+	    !(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PACKET_OFFLOAD)) {
+		NL_SET_ERR_MSG_MOD(extack, "Packet offload is not supported");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1141,14 +1149,6 @@ static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_free	= mlx5e_xfrm_free_state,
 	.xdo_dev_offload_ok	= mlx5e_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = mlx5e_xfrm_advance_esn_state,
-};
-
-static const struct xfrmdev_ops mlx5e_ipsec_packet_xfrmdev_ops = {
-	.xdo_dev_state_add	= mlx5e_xfrm_add_state,
-	.xdo_dev_state_delete	= mlx5e_xfrm_del_state,
-	.xdo_dev_state_free	= mlx5e_xfrm_free_state,
-	.xdo_dev_offload_ok	= mlx5e_ipsec_offload_ok,
-	.xdo_dev_state_advance_esn = mlx5e_xfrm_advance_esn_state,
 
 	.xdo_dev_state_update_curlft = mlx5e_xfrm_update_curlft,
 	.xdo_dev_policy_add = mlx5e_xfrm_add_policy,
@@ -1166,11 +1166,7 @@ void mlx5e_ipsec_build_netdev(struct mlx5e_priv *priv)
 
 	mlx5_core_info(mdev, "mlx5e: IPSec ESP acceleration enabled\n");
 
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PACKET_OFFLOAD)
-		netdev->xfrmdev_ops = &mlx5e_ipsec_packet_xfrmdev_ops;
-	else
-		netdev->xfrmdev_ops = &mlx5e_ipsec_xfrmdev_ops;
-
+	netdev->xfrmdev_ops = &mlx5e_ipsec_xfrmdev_ops;
 	netdev->features |= NETIF_F_HW_ESP;
 	netdev->hw_enc_features |= NETIF_F_HW_ESP;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 4e018fba2d5f..6e00afe4671b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -6,6 +6,8 @@
 #include "ipsec.h"
 #include "lib/crypto.h"
 #include "lib/ipsec_fs_roce.h"
+#include "fs_core.h"
+#include "eswitch.h"
 
 enum {
 	MLX5_IPSEC_ASO_REMOVE_FLOW_PKT_CNT_OFFSET,
@@ -38,7 +40,10 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 	    MLX5_CAP_ETH(mdev, insert_trailer) && MLX5_CAP_ETH(mdev, swp))
 		caps |= MLX5_IPSEC_CAP_CRYPTO;
 
-	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload)) {
+	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload) &&
+	    (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS ||
+	     (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS &&
+	     is_mdev_legacy_mode(mdev)))) {
 		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
 					      reformat_add_esp_trasport) &&
 		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
@@ -559,6 +564,7 @@ void mlx5e_ipsec_aso_cleanup(struct mlx5e_ipsec *ipsec)
 	dma_unmap_single(pdev, aso->dma_addr, sizeof(aso->ctx),
 			 DMA_BIDIRECTIONAL);
 	kfree(aso);
+	ipsec->aso = NULL;
 }
 
 static void mlx5e_ipsec_aso_copy(struct mlx5_wqe_aso_ctrl_seg *ctrl,
-- 
2.43.0


