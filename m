Return-Path: <netdev+bounces-54133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C778060F5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A56B21118
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3776E2C0;
	Tue,  5 Dec 2023 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgD5uGtQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C226E2BC
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC4C433C8;
	Tue,  5 Dec 2023 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812738;
	bh=4PgUMoGVne7aBA4o7WC9ZMJbLtzQD8r/PWGvA1lplSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgD5uGtQrpd1LmQfR0vCrwO9mC5f9b5TyTlSZr+4AI/+ScoL6le2PnKOhIMZy1zyL
	 Aw5MBo+VD2C+9bnSs27fbTzdSB1TibHWIzuI0H0oPp1t8Q1zM8B1kOqH9oBP83Fxdu
	 tx2SErt/sv1TEDkSmROMCrgabbC/FKDGeT+NGiv45Wf8o9bLPn28yGlC4yk93hmIae
	 QjEm9LBxaBRTovzVbssbJESyExZEPVhsviLMq+9ypSnR4KOtLSa2nD8Sy2KT/uJ3Wp
	 j31TVZLkIZCp9/ePJBfzbrV9GirJIBn7AZYtWv23fIU0tMYeGLNdw3CyjlwbkAWF3+
	 EnVujjc95KukA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [net V3 01/15] net/mlx5e: Honor user choice of IPsec replay window size
Date: Tue,  5 Dec 2023 13:45:20 -0800
Message-ID: <20231205214534.77771-2-saeed@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

Users can configure IPsec replay window size, but mlx5 driver didn't
honor their choice and set always 32bits. Fix assignment logic to
configure right size from the beginning.

Fixes: 7db21ef4566e ("net/mlx5e: Set IPsec replay sequence numbers")
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 21 +++++++++++++++++++
 .../mlx5/core/en_accel/ipsec_offload.c        |  2 +-
 include/linux/mlx5/mlx5_ifc.h                 |  7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 655496598c68..4028932d93ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -335,6 +335,27 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 		attrs->replay_esn.esn = sa_entry->esn_state.esn;
 		attrs->replay_esn.esn_msb = sa_entry->esn_state.esn_msb;
 		attrs->replay_esn.overlap = sa_entry->esn_state.overlap;
+		switch (x->replay_esn->replay_window) {
+		case 32:
+			attrs->replay_esn.replay_window =
+				MLX5_IPSEC_ASO_REPLAY_WIN_32BIT;
+			break;
+		case 64:
+			attrs->replay_esn.replay_window =
+				MLX5_IPSEC_ASO_REPLAY_WIN_64BIT;
+			break;
+		case 128:
+			attrs->replay_esn.replay_window =
+				MLX5_IPSEC_ASO_REPLAY_WIN_128BIT;
+			break;
+		case 256:
+			attrs->replay_esn.replay_window =
+				MLX5_IPSEC_ASO_REPLAY_WIN_256BIT;
+			break;
+		default:
+			WARN_ON(true);
+			return;
+		}
 	}
 
 	attrs->dir = x->xso.dir;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index a91f772dc981..4e018fba2d5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -95,7 +95,7 @@ static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
 
 		if (attrs->dir == XFRM_DEV_OFFLOAD_IN) {
 			MLX5_SET(ipsec_aso, aso_ctx, window_sz,
-				 attrs->replay_esn.replay_window / 64);
+				 attrs->replay_esn.replay_window);
 			MLX5_SET(ipsec_aso, aso_ctx, mode,
 				 MLX5_IPSEC_ASO_REPLAY_PROTECTION);
 		}
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6f3631425f38..90ca63f4bf63 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12001,6 +12001,13 @@ enum {
 	MLX5_IPSEC_ASO_INC_SN            = 0x2,
 };
 
+enum {
+	MLX5_IPSEC_ASO_REPLAY_WIN_32BIT  = 0x0,
+	MLX5_IPSEC_ASO_REPLAY_WIN_64BIT  = 0x1,
+	MLX5_IPSEC_ASO_REPLAY_WIN_128BIT = 0x2,
+	MLX5_IPSEC_ASO_REPLAY_WIN_256BIT = 0x3,
+};
+
 struct mlx5_ifc_ipsec_aso_bits {
 	u8         valid[0x1];
 	u8         reserved_at_201[0x1];
-- 
2.43.0


