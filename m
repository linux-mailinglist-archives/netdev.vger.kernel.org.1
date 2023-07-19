Return-Path: <netdev+bounces-18925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4888759188
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490662810DD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC5111BB;
	Wed, 19 Jul 2023 09:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6611C8E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729ADC433D9;
	Wed, 19 Jul 2023 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689758829;
	bh=0zUzv0f4PpnT32ij4bNHhEnvK6s3wEKGkNpGdkGei2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5E6iIkHM9jTd7A5bes/NQPWpKUNCdqyCp66r3cFsSneCCCVAKRqyREhcuncVP4AP
	 XM7+U9IRzoLIk/oQGSeFwdfFUKFu8XZyj8n+7mM1vwc7xOG+S4TkB5mvxXGBwOLDdU
	 5IEsn0vvd4i929x/PVNjYmZR++Jm8nebQiqdpDsOQy9+np6QY9a10tIiLaCnu7BhiK
	 x1xO0TuhE88x8Uzn5Rxwm2+opQL0y+6kdb8wl194E6bcoxVUAieEAABTSOW8ol/qgS
	 UzoZDmFLBL4Dv5VZWDJitAvfjNj322vcVQF9dQJkDXRBppQHKuEprBu53vMzJez67o
	 zqo/deun+Y0Zw==
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
Subject: [PATCH net-next 1/4] net/mlx5: Add relevant capabilities bits to support NAT-T
Date: Wed, 19 Jul 2023 12:26:53 +0300
Message-ID: <149153ebf1971231321b5a0ef22c742338e96876.1689757619.git.leon@kernel.org>
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

Provide an ability to check if flow steering supports UDP
encapsulation and decapsulation of IPsec ESP packets.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 33344a71c3e3..b3ad6b9852ec 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -464,10 +464,10 @@ struct mlx5_ifc_flow_table_prop_layout_bits {
 
 	u8         reformat_add_esp_trasport[0x1];
 	u8         reformat_l2_to_l3_esp_tunnel[0x1];
-	u8         reserved_at_42[0x1];
+	u8         reformat_add_esp_transport_over_udp[0x1];
 	u8         reformat_del_esp_trasport[0x1];
 	u8         reformat_l3_esp_tunnel_to_l2[0x1];
-	u8         reserved_at_45[0x1];
+	u8         reformat_del_esp_transport_over_udp[0x1];
 	u8         execute_aso[0x1];
 	u8         reserved_at_47[0x19];
 
@@ -6665,9 +6665,12 @@ enum mlx5_reformat_ctx_type {
 	MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL = 0x4,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV4 = 0x5,
 	MLX5_REFORMAT_TYPE_L2_TO_L3_ESP_TUNNEL = 0x6,
+	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV4 = 0x7,
 	MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT = 0x8,
 	MLX5_REFORMAT_TYPE_L3_ESP_TUNNEL_TO_L2 = 0x9,
+	MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP = 0xa,
 	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6 = 0xb,
+	MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV6 = 0xc,
 	MLX5_REFORMAT_TYPE_INSERT_HDR = 0xf,
 	MLX5_REFORMAT_TYPE_REMOVE_HDR = 0x10,
 	MLX5_REFORMAT_TYPE_ADD_MACSEC = 0x11,
-- 
2.41.0


