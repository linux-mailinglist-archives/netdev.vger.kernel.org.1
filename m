Return-Path: <netdev+bounces-53774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550F8049D7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D936D1C20DD5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB4DDD1;
	Tue,  5 Dec 2023 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXpq7Um3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A728DDBE
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC2CC433C7;
	Tue,  5 Dec 2023 06:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756819;
	bh=4PgUMoGVne7aBA4o7WC9ZMJbLtzQD8r/PWGvA1lplSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXpq7Um3pRXGllGDEySmQsau7/SWXbDtQBs9HE6/XlncecNRNRDr2TJwYwNApf+A5
	 FFHj/G5AkKoutyXL3F2GtxzcF2S37Qxs87fSYyXLWWA8S66MhP4IYVM20EgxAEsmHP
	 OAsEOArhMOkcdmtGFGaXToT0DbLH2ymEbVraEsyCZmADJuLoHHh9SeoqxlMSSNdfgE
	 JaastQVGAubCxQ+GzYVahW/R8o50LmcXx3fWpkECQV7UfxMIV+g+8g8TfuhkLK+uAn
	 lpjpBCbXDLoRGXed4LUyCWCkfbHnf/Ro0MhPQfYXw5CtKF3J0yt6T9MGWl/IvIU79I
	 INMePNOC++4Iw==
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
Subject: [net V2 01/14] net/mlx5e: Honor user choice of IPsec replay window size
Date: Mon,  4 Dec 2023 22:13:14 -0800
Message-ID: <20231205061327.44638-2-saeed@kernel.org>
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


