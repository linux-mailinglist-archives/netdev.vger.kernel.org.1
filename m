Return-Path: <netdev+bounces-40476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA87C776A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E2B1C21242
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A853D96E;
	Thu, 12 Oct 2023 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFklREM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5213D96D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996FC433C7;
	Thu, 12 Oct 2023 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140397;
	bh=BpwSHoCzWrx3k7ZY6ysA4trLoy9KbB+YZT8eu6DcJvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFklREM3vTvqBhul3UcZJeUMBPJu+bKuxhFlyFPo58oLIwNskpON7Y4/hNBKm5SMH
	 iKcMn7GZVmga295RcPvseO0+GqbzzA0unQ8R0jvSQGLAi+TWnf5DjHLKDVWnlau8Oe
	 43jWUAYCDW8zV5Sr3CylD8q+S4BEjxoIZJnICjRAXtIoBu8OUfhIQof1lnrcjmNlft
	 0xaYylXFnAaW2X9aX9V2+lYC4/TeO/rUxW560MhCAk5d8OV3piZcwXm2IeYnBuV/RW
	 XON3Lmo7gSb8FErmtSRrGGrnoxvpOfljFhB/1IEH1JVQMfxOwagr1slWwQyBKzWcVL
	 c9QtXfP06UbNA==
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
Subject: [net 10/10] net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command
Date: Thu, 12 Oct 2023 12:51:27 -0700
Message-ID: <20231012195127.129585-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012195127.129585-1-saeed@kernel.org>
References: <20231012195127.129585-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Tzin <amirtz@nvidia.com>

Although vf_vport entry of struct mlx5e_stats is never updated, its
values are mistakenly copied to the caller structure in the VF
representor .ndo_get_stat_64 callback mlx5e_rep_get_stats(). Remove
redundant entry and use the updated one, rep_stats, instead.

Fixes: 64b68e369649 ("net/mlx5: Refactor and expand rep vport stat group")
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 11 ++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  5 +++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 5ca9bc337dc6..fd1cce542b68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -701,7 +701,7 @@ mlx5e_rep_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 	/* update HW stats in background for next time */
 	mlx5e_queue_update_stats(priv);
-	memcpy(stats, &priv->stats.vf_vport, sizeof(*stats));
+	mlx5e_stats_copy_rep_stats(stats, &priv->stats.rep_stats);
 }
 
 static int mlx5e_rep_change_mtu(struct net_device *netdev, int new_mtu)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 176fa5976259..477c547dcc04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -484,11 +484,20 @@ struct mlx5e_stats {
 	struct mlx5e_vnic_env_stats vnic;
 	struct mlx5e_vport_stats vport;
 	struct mlx5e_pport_stats pport;
-	struct rtnl_link_stats64 vf_vport;
 	struct mlx5e_pcie_stats pcie;
 	struct mlx5e_rep_stats rep_stats;
 };
 
+static inline void mlx5e_stats_copy_rep_stats(struct rtnl_link_stats64 *vf_vport,
+					      struct mlx5e_rep_stats *rep_stats)
+{
+	memset(vf_vport, 0, sizeof(*vf_vport));
+	vf_vport->rx_packets = rep_stats->vport_rx_packets;
+	vf_vport->tx_packets = rep_stats->vport_tx_packets;
+	vf_vport->rx_bytes = rep_stats->vport_rx_bytes;
+	vf_vport->tx_bytes = rep_stats->vport_tx_bytes;
+}
+
 extern mlx5e_stats_grp_t mlx5e_nic_stats_grps[];
 unsigned int mlx5e_nic_stats_grps_num(struct mlx5e_priv *priv);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index c24828b688ac..c8590483ddc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -4972,7 +4972,8 @@ static int scan_tc_matchall_fdb_actions(struct mlx5e_priv *priv,
 			if (err)
 				return err;
 
-			rpriv->prev_vf_vport_stats = priv->stats.vf_vport;
+			mlx5e_stats_copy_rep_stats(&rpriv->prev_vf_vport_stats,
+						   &priv->stats.rep_stats);
 			break;
 		default:
 			NL_SET_ERR_MSG_MOD(extack, "mlx5 supports only police action for matchall");
@@ -5012,7 +5013,7 @@ void mlx5e_tc_stats_matchall(struct mlx5e_priv *priv,
 	u64 dbytes;
 	u64 dpkts;
 
-	cur_stats = priv->stats.vf_vport;
+	mlx5e_stats_copy_rep_stats(&cur_stats, &priv->stats.rep_stats);
 	dpkts = cur_stats.rx_packets - rpriv->prev_vf_vport_stats.rx_packets;
 	dbytes = cur_stats.rx_bytes - rpriv->prev_vf_vport_stats.rx_bytes;
 	rpriv->prev_vf_vport_stats = cur_stats;
-- 
2.41.0


