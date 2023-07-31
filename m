Return-Path: <netdev+bounces-22815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C196769565
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765EA1C20C04
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704FC182CF;
	Mon, 31 Jul 2023 11:59:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D1182A9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2354C433CD;
	Mon, 31 Jul 2023 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690804739;
	bh=fLgxM78UsVGuP3jeEUhoDupE2dLeAwnzdpX49p+vjik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmA3ENO/F7L0qZmojSH4y1GN2WQ9DuDLhz3zurgqBGwVb6ybxeT+2eSHEjhIg2xEn
	 lxIphQu7KDE4t1WgNom8x9QBApTUCdANc6JnrcX4nMFdA+aQPGR0V4DPoR/b0WNQyl
	 pR3+l+xeqL/Z0Gqe0r9P39eyvl0/YMR31GOtjcwdP+jYX77U12ENF2jc4v1ZPkKIXN
	 YNWSkDpaHm4GuZVCbrqhYLCGupSUUKfgk71lSCnJjms/E6BAAm+aHu1QR2doOUIO5J
	 hJvnmW+ble7Qpc9pN8J8g76Afxofh2AuBflEwVzgBek58DroGhbNxiV2w6vSNyDxDe
	 fqzUo9/7yewVw==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Eric Dumazet <edumazet@google.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Paul Blakey <paulb@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net 3/3] net/mlx5e: Set proper IPsec source port in L4 selector
Date: Mon, 31 Jul 2023 14:58:42 +0300
Message-ID: <ffc024a4d192113103f392b0502688366ca88c1f.1690803944.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690803944.git.leonro@nvidia.com>
References: <cover.1690803944.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Fix typo in setup_fte_upper_proto_match() where destination UDP port
was used instead of source port.

Fixes: a7385187a386 ("net/mlx5e: IPsec, support upper protocol selector field offload")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index dbe87bf89c0d..832d36be4a17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -808,9 +808,9 @@ static void setup_fte_upper_proto_match(struct mlx5_flow_spec *spec, struct upsp
 	}
 
 	if (upspec->sport) {
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_dport,
+		MLX5_SET(fte_match_set_lyr_2_4, spec->match_criteria, udp_sport,
 			 upspec->sport_mask);
-		MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_dport, upspec->sport);
+		MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, udp_sport, upspec->sport);
 	}
 }
 
-- 
2.41.0


