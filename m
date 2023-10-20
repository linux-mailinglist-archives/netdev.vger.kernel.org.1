Return-Path: <netdev+bounces-42854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C97D06B3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37CFB214F3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80920FB;
	Fri, 20 Oct 2023 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtyJJVnm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9EC20F5
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA77C433C8;
	Fri, 20 Oct 2023 03:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771075;
	bh=E9JHTihSYuhe5GZfFWwLZj713F4Dl0s5G2Wg63KxX6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtyJJVnmkRwWd9B9RRU1hQqXOEmUBttgMIkE3V9cIJ2dHbT46fp4gKEvKWXdWKAbe
	 dkCzFT6qoniHrAOcNpcbD5SB9fj5kIq+TIMagWeOuwpOEyz5hqGMvbnew1SO4IRkx6
	 arQJbBVgzx/bie1Geq4TvNS+4YhD2JxHjqezolFia1YRaCOa526za/yief1bQRk32c
	 ewpMQCz6vIu5PRzvhuu2Ln0o1QzntO94sA4CGDzkH86jEg6alyApLr/RGA0kydJJkp
	 FySEwZW5pi0lbO7wBTbDiq7+I/onoPSXyaoLr1Sjv1X83EfEWz/h6jRb5VMJWNw+r5
	 X5B4J5Sjr3ZHA==
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
Subject: [net-next 03/15] net/mlx5e: Honor user choice of IPsec replay window size
Date: Thu, 19 Oct 2023 20:04:10 -0700
Message-ID: <20231020030422.67049-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
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

Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
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


