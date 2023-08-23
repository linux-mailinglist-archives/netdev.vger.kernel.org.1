Return-Path: <netdev+bounces-29877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6E784FE6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF922812F0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B6AD3F;
	Wed, 23 Aug 2023 05:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB48AD29
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA14C433B8;
	Wed, 23 Aug 2023 05:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767442;
	bh=spx1Jr80EJFEs9Ervl65X1pIt4x1MTz4NYpc/7PfCT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffSxbqLvn3ceBs2Nbdk/9YugN9gi4EY6jD1C3h/WrKbo6LgGwUoiQsb9/qOP1o1bo
	 dvPRsI+jEVT3rcPHoc+A6fDVcSRPoiw0y52tVPl5SQyd3zMUrltOT8JlE2su4gienS
	 NUDLc2GJ0C9rAAcKO0eti4CRtj7ETiSM4r33MCY7ATlhFSsXhR8eFqJiFE400Y9LFI
	 ssi50J93fhe9XgnnHhYft1lY9Mua3807DjCr4RSTdLW5Nw/2j7My7E/ZBZCYG6H6KB
	 6QqYiRqFkPWhfJY5cTj7IFHo9PcacAGnyQxyXXDdF0tAkd8ca/h575Q03LhdRkWCyJ
	 2p4FcoqB5uF9g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [net-next 15/15] net/mlx5e: Support IPsec upper TCP protocol selector
Date: Tue, 22 Aug 2023 22:10:12 -0700
Message-ID: <20230823051012.162483-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823051012.162483-1-saeed@kernel.org>
References: <20230823051012.162483-1-saeed@kernel.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 11 +++--
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 43 +++++++++++++------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 2bbe232c2ffa..3b88a8bb7082 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -440,8 +440,9 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 
-	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP");
+	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP &&
+	    x->sel.proto != IPPROTO_TCP) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than TCP/UDP");
 		return -EINVAL;
 	}
 
@@ -982,8 +983,10 @@ static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
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


