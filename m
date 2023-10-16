Return-Path: <netdev+bounces-41206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E47CA3D4
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6305DB20E04
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C31C2BE;
	Mon, 16 Oct 2023 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4XxuTiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37A1C285
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944BDC433C8;
	Mon, 16 Oct 2023 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697447734;
	bh=DWYN3ZNXGpZazBL7AG0GH5JKLapsM0nlZ5hmBUAT26o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4XxuTiO86GIjQYCCUJ9dVNC6eO+R/7iRZ6sGuaqschO1HZRNwuXJtx2AWKyneMES
	 ezTBOVjtekmZRKasTEEPSPHglGeCoC/kJxRaMdm5lJ3hXpLNlBZheYmSr7OmOIfqqZ
	 ff5Z6JuF+RGK180A8kkVsal2uJwahKax/QxcUlbtCUVw1Q/DMzyPcW0v/55YbyJVYj
	 nxa4SPZ+FTKBMnJzpCak2nYTcCaXdCRpFZO9lziBIe6txFrXuP921xwENilTXfi02G
	 nIcXorYe00uMfj6mEBCExiogbyk3UCv4y1upa+augmMYL1ORnjfM/0pPeQecNszDah
	 oVLXH9iM2QE9w==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH xfrm-next 3/9] net/mlx5e: Honor user choice of IPsec replay window size
Date: Mon, 16 Oct 2023 12:15:11 +0300
Message-ID: <7ccb58e49acabc433281c79c29358dff182c7f95.1697444728.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697444728.git.leon@kernel.org>
References: <cover.1697444728.git.leon@kernel.org>
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
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 21 +++++++++++++++++++
 .../mlx5/core/en_accel/ipsec_offload.c        |  2 +-
 include/linux/mlx5/mlx5_ifc.h                 |  7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 9bfffdeb0fe8..ddd2230f04aa 100644
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
index 4df6d1c12437..6ceafbd8edc5 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -11995,6 +11995,13 @@ enum {
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
2.41.0


