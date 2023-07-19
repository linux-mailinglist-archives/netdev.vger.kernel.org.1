Return-Path: <netdev+bounces-18928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816D375918D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FEA1C20E97
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535411C83;
	Wed, 19 Jul 2023 09:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCA10784
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F9AC433CB;
	Wed, 19 Jul 2023 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689758841;
	bh=fsIZMZOGXgDaET0uYfpGtgGjOzZdeAhXP0/G1tJt400=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJ75EB4miy2W/Ax7eQ7huWFob9/7MeVOnrh4hSVhYr6NxEEMAm7B8OGP5Q1XY2M6O
	 +DuQPATwpmMQdNM/FML0DjMbDth1to0wCN3scaiUE2nO45uDBWiVuP1U5SdWqZU+Rc
	 8neGlPUa6N/5UGhOMNBSetaFIaaCe9f+V8Fj3Ns8t9Ofus4JczG5w929mC5MJJRfmM
	 Zp1XnLnjaigIFbhGsY1QFM68NlI5RH/piPhF8G7VZ+L277OxJKBkziu+bkn2DiHTZG
	 rfA3gV4LPz5Ufywqu+FeRKMSses8dQW2fXfNyv0LGPC7oR63mQpSIuPqsjLhXD/Gpx
	 Pr21NKlu3KXEQ==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ilia Lin <quic_ilial@quicinc.com>
Subject: [PATCH net-next 2/4] net/mlx5e: Check for IPsec NAT-T support
Date: Wed, 19 Jul 2023 12:26:54 +0300
Message-ID: <7708a771ffa58ff2352317a2153c437c52b277c1.1689757619.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689757619.git.leon@kernel.org>
References: <cover.1689757619.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Set relevant IPsec capability to indicate if flow steering supports UDP
encapsulation and decapsulation of IPsec ESP packets.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h    | 1 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c    | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 4e9887171508..b382b0cad7f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -110,6 +110,7 @@ enum mlx5_ipsec_cap {
 	MLX5_IPSEC_CAP_ROCE             = 1 << 3,
 	MLX5_IPSEC_CAP_PRIO             = 1 << 4,
 	MLX5_IPSEC_CAP_TUNNEL           = 1 << 5,
+	MLX5_IPSEC_CAP_ESPINUDP         = 1 << 6,
 };
 
 struct mlx5e_priv;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index a3554bde3e07..5ff06263c5bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -54,6 +54,12 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
 					      reformat_l3_esp_tunnel_to_l2))
 			caps |= MLX5_IPSEC_CAP_TUNNEL;
+
+		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
+					      reformat_add_esp_transport_over_udp) &&
+		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
+					      reformat_del_esp_transport_over_udp))
+			caps |= MLX5_IPSEC_CAP_ESPINUDP;
 	}
 
 	if (mlx5_get_roce_state(mdev) &&
-- 
2.41.0


