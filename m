Return-Path: <netdev+bounces-199228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B49ADF7D9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8308B3BE558
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BC21D3EE;
	Wed, 18 Jun 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahjt1Roe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E417721D3E4
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279147; cv=none; b=mNML9Da8ynHwFFLZSuVEIYTMTKDlbcV8fC5K9CrDKSxhAZnNSp9F64IxWcfOZDWohGxdkaR01F8xKhCj81K6IlLv4JGMzJIXBIry+BPpuplpwV0lPTdoriEGbGKsCRV3Tj79yM+jnjTBYZDnJoLsVoA0S9E2mHb2n0eiRLzxKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279147; c=relaxed/simple;
	bh=GCFn9g5mQidsmxhAEuSbFi/Dz3+B4spfJZfZmEenCCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJepFpB8gUBQXULz2WG2vA+vhBVbGIjzcj8KmoeOvMrHxgdR/rV6AyziqhbeIvkf7GHfkEVU5ixjB1ymRa7ujthBObMGFa62Yu4eFPtml7S6QPA/JinBo+Tw/Xpw4IPDAvH8MOyLMRr4RNY8xnHXGdw2to0/vTYKckxpjismcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahjt1Roe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEA8C4CEEF;
	Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279146;
	bh=GCFn9g5mQidsmxhAEuSbFi/Dz3+B4spfJZfZmEenCCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ahjt1RoepOUAzs1EOZHMUbjzCoaGZvqJLzSaUJxZvm+EP3tqpcbpCCSpxNVFyHFoG
	 psIVNmaVVfPkLCbWKfeMigLSbHBUqhydlRD2+L2vJbUU0+HBrx25FQTJSxjpt8dh4N
	 xgir4T7eftiLFXTv+8qnNfEfr+CXbdNq5hIAYWJtV91PLtKSl1SHjne0InfviWpIbB
	 zEqlFLudRf3CLPBeY8mj5da/k9TvGEDPoXUmx3sfUYLPnCYlwQVdfpTeNOY9oHR5Z1
	 C8qNo/NuMoegSsLKwFLo3V9PVBLeJrAjcfNA/I+7TcCDL5WIiGPs7tbfTEuLP1WXtZ
	 Mj1tEKnSBM5AQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/10] eth: mlx5: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:19 -0700
Message-ID: <20250618203823.1336156-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../mellanox/mlx5/core/en/fs_ethtool.h        | 14 +++++++++++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 19 ++++++++++++++
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 25 +++++++------------
 .../mellanox/mlx5/core/ipoib/ethtool.c        | 19 ++++++++++++++
 4 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_ethtool.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_ethtool.h
index 9e276fd3c0cf..c21fe36527a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_ethtool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_ethtool.h
@@ -11,6 +11,11 @@ int mlx5e_ethtool_alloc(struct mlx5e_ethtool_steering **ethtool);
 void mlx5e_ethtool_free(struct mlx5e_ethtool_steering *ethtool);
 void mlx5e_ethtool_init_steering(struct mlx5e_flow_steering *fs);
 void mlx5e_ethtool_cleanup_steering(struct mlx5e_flow_steering *fs);
+int mlx5e_ethtool_set_rxfh_fields(struct mlx5e_priv *priv,
+				  const struct ethtool_rxfh_fields *nfc,
+				  struct netlink_ext_ack *extack);
+int mlx5e_ethtool_get_rxfh_fields(struct mlx5e_priv *priv,
+				  struct ethtool_rxfh_fields *nfc);
 int mlx5e_ethtool_set_rxnfc(struct mlx5e_priv *priv, struct ethtool_rxnfc *cmd);
 int mlx5e_ethtool_get_rxnfc(struct mlx5e_priv *priv,
 			    struct ethtool_rxnfc *info, u32 *rule_locs);
@@ -20,6 +25,15 @@ static inline int mlx5e_ethtool_alloc(struct mlx5e_ethtool_steering **ethtool)
 static inline void mlx5e_ethtool_free(struct mlx5e_ethtool_steering *ethtool) { }
 static inline void mlx5e_ethtool_init_steering(struct mlx5e_flow_steering *fs) { }
 static inline void mlx5e_ethtool_cleanup_steering(struct mlx5e_flow_steering *fs) { }
+static inline int
+mlx5e_ethtool_set_rxfh_fields(struct mlx5e_priv *priv,
+			      const struct ethtool_rxfh_fields *nfc,
+			      struct netlink_ext_ack *extack)
+{ return -EOPNOTSUPP; }
+static inline int
+mlx5e_ethtool_get_rxfh_fields(struct mlx5e_priv *priv,
+			      struct ethtool_rxfh_fields *nfc)
+{ return -EOPNOTSUPP; }
 static inline int mlx5e_ethtool_set_rxnfc(struct mlx5e_priv *priv, struct ethtool_rxnfc *cmd)
 { return -EOPNOTSUPP; }
 static inline int mlx5e_ethtool_get_rxnfc(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 35479cbf98d5..995eedf7a51a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2399,6 +2399,23 @@ static u32 mlx5e_get_priv_flags(struct net_device *netdev)
 	return priv->channels.params.pflags;
 }
 
+static int mlx5e_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *info)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_ethtool_get_rxfh_fields(priv, info);
+}
+
+static int mlx5e_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *cmd,
+				 struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_ethtool_set_rxfh_fields(priv, cmd, extack);
+}
+
 static int mlx5e_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 			   u32 *rule_locs)
 {
@@ -2666,6 +2683,8 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.get_rxfh_indir_size = mlx5e_get_rxfh_indir_size,
 	.get_rxfh          = mlx5e_get_rxfh,
 	.set_rxfh          = mlx5e_set_rxfh,
+	.get_rxfh_fields   = mlx5e_get_rxfh_fields,
+	.set_rxfh_fields   = mlx5e_set_rxfh_fields,
 	.get_rxnfc         = mlx5e_get_rxnfc,
 	.set_rxnfc         = mlx5e_set_rxnfc,
 	.get_tunable       = mlx5e_get_tunable,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index d68230a7b9f4..79916f1abd14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -894,17 +894,17 @@ static int flow_type_to_traffic_type(u32 flow_type)
 	}
 }
 
-static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
-				  struct ethtool_rxnfc *nfc)
+int mlx5e_ethtool_set_rxfh_fields(struct mlx5e_priv *priv,
+				  const struct ethtool_rxfh_fields *nfc,
+				  struct netlink_ext_ack *extack)
 {
 	u8 rx_hash_field = 0;
 	u32 flow_type = 0;
-	u32 rss_idx = 0;
+	u32 rss_idx;
 	int err;
 	int tt;
 
-	if (nfc->flow_type & FLOW_RSS)
-		rss_idx = nfc->rss_context;
+	rss_idx = nfc->rss_context;
 
 	flow_type = flow_type_mask(nfc->flow_type);
 	tt = flow_type_to_traffic_type(flow_type);
@@ -941,16 +941,15 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 	return err;
 }
 
-static int mlx5e_get_rss_hash_opt(struct mlx5e_priv *priv,
-				  struct ethtool_rxnfc *nfc)
+int mlx5e_ethtool_get_rxfh_fields(struct mlx5e_priv *priv,
+				  struct ethtool_rxfh_fields *nfc)
 {
 	int hash_field = 0;
 	u32 flow_type = 0;
-	u32 rss_idx = 0;
+	u32 rss_idx;
 	int tt;
 
-	if (nfc->flow_type & FLOW_RSS)
-		rss_idx = nfc->rss_context;
+	rss_idx = nfc->rss_context;
 
 	flow_type = flow_type_mask(nfc->flow_type);
 	tt = flow_type_to_traffic_type(flow_type);
@@ -986,9 +985,6 @@ int mlx5e_ethtool_set_rxnfc(struct mlx5e_priv *priv, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXCLSRLDEL:
 		err = mlx5e_ethtool_flow_remove(priv, cmd->fs.location);
 		break;
-	case ETHTOOL_SRXFH:
-		err = mlx5e_set_rss_hash_opt(priv, cmd);
-		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -1013,9 +1009,6 @@ int mlx5e_ethtool_get_rxnfc(struct mlx5e_priv *priv,
 	case ETHTOOL_GRXCLSRLALL:
 		err = mlx5e_ethtool_get_all_flows(priv, info, rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		err =  mlx5e_get_rss_hash_opt(priv, info);
-		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 9772327d5124..4b3430ac3905 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -238,6 +238,23 @@ static u32 mlx5i_flow_type_mask(u32 flow_type)
 	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
 }
 
+static int mlx5i_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *cmd,
+				 struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = mlx5i_epriv(dev);
+
+	return mlx5e_ethtool_set_rxfh_fields(priv, cmd, extack);
+}
+
+static int mlx5i_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *info)
+{
+	struct mlx5e_priv *priv = mlx5i_epriv(dev);
+
+	return mlx5e_ethtool_get_rxfh_fields(priv, info);
+}
+
 static int mlx5i_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);
@@ -283,6 +300,8 @@ const struct ethtool_ops mlx5i_ethtool_ops = {
 	.get_coalesce       = mlx5i_get_coalesce,
 	.set_coalesce       = mlx5i_set_coalesce,
 	.get_ts_info        = mlx5i_get_ts_info,
+	.get_rxfh_fields    = mlx5i_get_rxfh_fields,
+	.set_rxfh_fields    = mlx5i_set_rxfh_fields,
 	.get_rxnfc          = mlx5i_get_rxnfc,
 	.set_rxnfc          = mlx5i_set_rxnfc,
 	.get_link_ksettings = mlx5i_get_link_ksettings,
-- 
2.49.0


