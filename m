Return-Path: <netdev+bounces-44890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F47DA354
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72ACB21531
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9268F405DA;
	Fri, 27 Oct 2023 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chs5F/cs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663E41231
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07DBC433C7;
	Fri, 27 Oct 2023 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698445223;
	bh=5wtdBZaFOHq7jHOb4PElCA9QD4YsDCAYHt/ImbFAEf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chs5F/cs/Fs73NHis8L+b6pVNhG8l59JJtqycy1CfyrmIZkWz0JTd6EKOE9GLNoTB
	 fENYsRCx0D5xhLfhcCqET70k7ZDQMceoA5p17VztD/ZeXMrjZMI9NbSb8CqoNRNHr/
	 OCxTXmW3asRXu+FBGglhfjaRlE/nqL5qjFwpJ+9Nu0NGISsKqYFbRuLfPGKL3xu3HP
	 5O6nrhavm9SS11yNDkMI3LWdk1c0BYGgUE7gd0AYqSW4P3wVFqpJjfAUZnEmDt/PhI
	 7WHbZ1D2mVR4dvTSPU2+5La8rqXygGXTNXiHq7ND+s2k1msbXqGJrhSA3SCVvRvHFK
	 ER1A1JvqLICTg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Amir Tzin <amirtz@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [net-next 07/11] net/mlx5e: Some cleanup in mlx5e_tc_stats_matchall()
Date: Fri, 27 Oct 2023 15:20:02 -0700
Message-ID: <20231027222006.115999-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027222006.115999-1-saeed@kernel.org>
References: <20231027222006.115999-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Tzin <amirtz@nvidia.com>

Function mlx5e_tc_stats_matchall() is only called from one file:
drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
Move it there and make it static as exposing it is unnecessary. Also
variable cur_stats is redundant. Remove it and avoid superfluous copy.

This patch does not change functionality.

Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c  | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c  | 16 ----------------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h  |  2 --
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
index b12fe3c5a258..a55452c69f06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
@@ -147,6 +147,20 @@ mlx5e_rep_setup_tc_cls_flower(struct mlx5e_priv *priv,
 	}
 }
 
+static void mlx5e_tc_stats_matchall(struct mlx5e_priv *priv,
+				    struct tc_cls_matchall_offload *ma)
+{
+	struct mlx5e_rep_priv *rpriv = priv->ppriv;
+	u64 dbytes;
+	u64 dpkts;
+
+	dpkts = priv->stats.rep_stats.vport_rx_packets - rpriv->prev_vf_vport_stats.rx_packets;
+	dbytes = priv->stats.rep_stats.vport_rx_bytes - rpriv->prev_vf_vport_stats.rx_bytes;
+	mlx5e_stats_copy_rep_stats(&rpriv->prev_vf_vport_stats, &priv->stats.rep_stats);
+	flow_stats_update(&ma->stats, dbytes, dpkts, 0, jiffies,
+			  FLOW_ACTION_HW_STATS_DELAYED);
+}
+
 static
 int mlx5e_rep_setup_tc_cls_matchall(struct mlx5e_priv *priv,
 				    struct tc_cls_matchall_offload *ma)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9a5a5c2c7da9..25743a7eda26 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5007,22 +5007,6 @@ int mlx5e_tc_delete_matchall(struct mlx5e_priv *priv,
 	return apply_police_params(priv, 0, extack);
 }
 
-void mlx5e_tc_stats_matchall(struct mlx5e_priv *priv,
-			     struct tc_cls_matchall_offload *ma)
-{
-	struct mlx5e_rep_priv *rpriv = priv->ppriv;
-	struct rtnl_link_stats64 cur_stats;
-	u64 dbytes;
-	u64 dpkts;
-
-	mlx5e_stats_copy_rep_stats(&cur_stats, &priv->stats.rep_stats);
-	dpkts = cur_stats.rx_packets - rpriv->prev_vf_vport_stats.rx_packets;
-	dbytes = cur_stats.rx_bytes - rpriv->prev_vf_vport_stats.rx_bytes;
-	rpriv->prev_vf_vport_stats = cur_stats;
-	flow_stats_update(&ma->stats, dbytes, dpkts, 0, jiffies,
-			  FLOW_ACTION_HW_STATS_DELAYED);
-}
-
 static void mlx5e_tc_hairpin_update_dead_peer(struct mlx5e_priv *priv,
 					      struct mlx5e_priv *peer_priv)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index adb39e30f90f..c24bda56b2b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -203,8 +203,6 @@ int mlx5e_tc_configure_matchall(struct mlx5e_priv *priv,
 				struct tc_cls_matchall_offload *f);
 int mlx5e_tc_delete_matchall(struct mlx5e_priv *priv,
 			     struct tc_cls_matchall_offload *f);
-void mlx5e_tc_stats_matchall(struct mlx5e_priv *priv,
-			     struct tc_cls_matchall_offload *ma);
 
 struct mlx5e_encap_entry;
 void mlx5e_tc_encap_flows_add(struct mlx5e_priv *priv,
-- 
2.41.0


