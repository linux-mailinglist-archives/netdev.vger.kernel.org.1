Return-Path: <netdev+bounces-48187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75C7ECDB0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2F61F28375
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D23C491;
	Wed, 15 Nov 2023 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffSe66sU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B213C468
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7C1C433C9;
	Wed, 15 Nov 2023 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077022;
	bh=93ct7+uTiqQVQG/hDgf1o8V+mmekjdtKO/EYRnte8aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffSe66sUQvwixPJV+Py0q348CVVn6b0HFCYSmExuuCBXOz8zNX2IE8+QUdV7qv3lJ
	 fT13Kvx+et1YG7r48eRdfzPcurtRHHVNmuO/Wnr/zZh67pwWgM4+u5XSDwAk/QB00O
	 ekbHSjneFdlIs+BcFZctNePwqDxigLgQ23wyCmT1GRlvbzl+etPON93ARszmhtur5U
	 z5bXLAIBLpWCp59SdCc0pNWbOC4JvFGoJSLAZpNcPLqBTK68ibY2KzqHq/h2I9JHI1
	 qF4WnGKqq1ZTk4b8YVqnpmtKQvVaAkR36MsqF/Q5NsSl0Rouk4zZNeVjbpWglA3zgw
	 exp8wBHZKn2uA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [net-next V2 12/13] net/mlx5e: Add local loopback counter to vport rep stats
Date: Wed, 15 Nov 2023 11:36:48 -0800
Message-ID: <20231115193649.8756-13-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115193649.8756-1-saeed@kernel.org>
References: <20231115193649.8756-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Add counter for number of unicast, multicast and broadcast packets/
octets that were loopback.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 26 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  2 ++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 693e55b010d9..2fd96471554b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -108,8 +108,18 @@ static const struct counter_desc vport_rep_stats_desc[] = {
 			     tx_vport_rdma_multicast_bytes) },
 };
 
+static const struct counter_desc vport_rep_loopback_stats_desc[] = {
+	{ MLX5E_DECLARE_STAT(struct mlx5e_rep_stats,
+			     vport_loopback_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_rep_stats,
+			     vport_loopback_bytes) },
+};
+
 #define NUM_VPORT_REP_SW_COUNTERS ARRAY_SIZE(sw_rep_stats_desc)
 #define NUM_VPORT_REP_HW_COUNTERS ARRAY_SIZE(vport_rep_stats_desc)
+#define NUM_VPORT_REP_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_GEN(dev, vport_counter_local_loopback) ? \
+	 ARRAY_SIZE(vport_rep_loopback_stats_desc) : 0)
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(sw_rep)
 {
@@ -153,7 +163,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw_rep)
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(vport_rep)
 {
-	return NUM_VPORT_REP_HW_COUNTERS;
+	return NUM_VPORT_REP_HW_COUNTERS +
+	       NUM_VPORT_REP_LOOPBACK_COUNTERS(priv->mdev);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(vport_rep)
@@ -162,6 +173,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(vport_rep)
 
 	for (i = 0; i < NUM_VPORT_REP_HW_COUNTERS; i++)
 		strcpy(data + (idx++) * ETH_GSTRING_LEN, vport_rep_stats_desc[i].format);
+	for (i = 0; i < NUM_VPORT_REP_LOOPBACK_COUNTERS(priv->mdev); i++)
+		strcpy(data + (idx++) * ETH_GSTRING_LEN,
+		       vport_rep_loopback_stats_desc[i].format);
 	return idx;
 }
 
@@ -172,6 +186,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vport_rep)
 	for (i = 0; i < NUM_VPORT_REP_HW_COUNTERS; i++)
 		data[idx++] = MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
 						   vport_rep_stats_desc, i);
+	for (i = 0; i < NUM_VPORT_REP_LOOPBACK_COUNTERS(priv->mdev); i++)
+		data[idx++] = MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
+						   vport_rep_loopback_stats_desc, i);
 	return idx;
 }
 
@@ -243,6 +260,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_rep)
 	rep_stats->tx_vport_rdma_multicast_bytes =
 		MLX5_GET_CTR(out, received_ib_multicast.octets);
 
+	if (MLX5_CAP_GEN(priv->mdev, vport_counter_local_loopback)) {
+		rep_stats->vport_loopback_packets =
+			MLX5_GET_CTR(out, local_loopback.packets);
+		rep_stats->vport_loopback_bytes =
+			MLX5_GET_CTR(out, local_loopback.octets);
+	}
+
 out:
 	kvfree(out);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 477c547dcc04..12b3607afecd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -476,6 +476,8 @@ struct mlx5e_rep_stats {
 	u64 tx_vport_rdma_multicast_packets;
 	u64 rx_vport_rdma_multicast_bytes;
 	u64 tx_vport_rdma_multicast_bytes;
+	u64 vport_loopback_packets;
+	u64 vport_loopback_bytes;
 };
 
 struct mlx5e_stats {
-- 
2.41.0


