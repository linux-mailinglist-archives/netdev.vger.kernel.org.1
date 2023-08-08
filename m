Return-Path: <netdev+bounces-25540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFE77479A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4591C21041
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36A168C1;
	Tue,  8 Aug 2023 19:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD415ADC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B37C433C9;
	Tue,  8 Aug 2023 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691522106;
	bh=NZkx3SGVX7iWh61ENgbXJPh73u4CMTJKAyjKIKzyz94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iux94AOJvGEq3hFpcC/nyAGO2SkQg+9L1efxlLe975AloIXrmKb/H+e3MTV2dQmZ0
	 NtRIbaYUsZsvB+Tym2BCrRc60VM21rf57GQec+Bq/oUTE316zqkmRKm1GUMY0e/EJe
	 sdAkOc8nWflWVeD5Gz09eWyt4EoKW+Pdc0KndvbdqBBvrL/P4gm49/7FdSwrmfE9qv
	 ohprZcZUc1fzinnlF4uSz53UFfptOGR/+QJygQmoPsyzbaD9MkNJhnY4DJ/S3Y5cDD
	 zXMIRqtBWsWkoSXg7xIp3SxV8GMID/hLdQhNExkflVBGD45coT+G2EwI5kZ0F1xyr4
	 iGG4Cq2h2Y/uQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Support IPsec upper TCP protocol selector
Date: Tue,  8 Aug 2023 22:14:55 +0300
Message-ID: <189e078717ad628fcb37ab8a2d09be4faf777811.1691521680.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691521680.git.leonro@nvidia.com>
References: <cover.1691521680.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Support TCP as protocol selector for policy and state in IPsec
packet offload mode.

Example of state configuration is as follows:
  ip xfrm state add src 192.168.25.3 dst 192.168.25.1 \
	proto esp spi 1001 reqid 10001 aead 'rfc4106(gcm(aes))' \
	0x54a7588d36873b031e4bd46301be5a86b3a53879 128 mode transport \
	offload packet dev re0 dir in sel src 192.168.25.3 dst 192.168.25.1 \
	proto tcp dport 9003

Acked-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 11 +++--
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 43 +++++++++++++------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 9ee169b72d9d..6f21694c7b13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -442,8 +442,9 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 
-	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP");
+	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP &&
+	    x->sel.proto != IPPROTO_TCP) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
 		return -EINVAL;
 	}
 
@@ -999,8 +1000,10 @@ static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 
-	if (x->selector.proto != IPPROTO_IP && x->selector.proto != IPPROTO_UDP) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP");
+	if (x->selector.proto != IPPROTO_IP &&
+	    x->selector.proto != IPPROTO_UDP &&
+	    x->selector.proto != IPPROTO_TCP) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index f5e29b7f5ba0..a1cfddd05bc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -936,23 +936,42 @@ static void setup_fte_reg_c4(struct mlx5_flow_spec *spec, u32 reqid)
 
 static void setup_fte_upper_proto_match(struct mlx5_flow_spec *spec, struct upspec *upspec)
 {
-	if (upspec->proto != IPPROTO_UDP)
+	switch (upspec->proto) {
+	case IPPROTO_UDP:
+		if (upspec->dport) {
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria,
+				 udp_dport, upspec->dport_mask);
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_value,
+				 udp_dport, upspec->dport);
+		}
+		if (upspec->sport) {
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria,
+				 udp_sport, upspec->sport_mask);
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_value,
+				 udp_sport, upspec->sport);
+		}
+		break;
+	case IPPROTO_TCP:
+		if (upspec->dport) {
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria,
+				 tcp_dport, upspec->dport_mask);
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_value,
+				 tcp_dport, upspec->dport);
+		}
+		if (upspec->sport) {
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria,
+				 tcp_sport, upspec->sport_mask);
+			MLX5_SET(fte_match_set_lyr_2_4, spec->match_value,
+				 tcp_sport, upspec->sport);
+		}
+		break;
+	default:
 		return;
+	}
 
 	spec->match_criteria_enable |= MLX5_MATCH_OUTER_HEADERS;
 	MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, spec->match_criteria, ip_protocol);
 	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, ip_protocol, upspec->proto);
-	if (upspec->dport) {
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_dport,
-			 upspec->dport_mask);
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_dport, upspec->dport);
-	}
-
-	if (upspec->sport) {
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_sport,
-			 upspec->sport_mask);
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_sport, upspec->sport);
-	}
 }
 
 static enum mlx5_flow_namespace_type ipsec_fs_get_ns(struct mlx5e_ipsec *ipsec,
-- 
2.41.0


