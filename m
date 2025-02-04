Return-Path: <netdev+bounces-162751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53805A27D6C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD3C3A2F51
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF75212D83;
	Tue,  4 Feb 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfN63upc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2C2045B8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704714; cv=none; b=CgYyP+jtsVivMk/Pw6gErNSK1w4LbmNO9AN09pNMl7O8z9ereSNOO13WJRwWlQCGCd52bYDaIkeZ9mnTG+bvH/q9GPOyhHeOtTBZwlAhmx3fr4fv2nEiF1uJtfEyBPXRHKdZF4UJsDi//b48nJk2Ye4xrS7WCkXeAjXOeLvLYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704714; c=relaxed/simple;
	bh=4PgO2JDZDmFpkzm+YcaLkEKhzIgqLZPZbVkr9gMXoWw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kM5Zid1uhtz2W+iC39stNnqcVbzWcdIqdHCqLlJI39qG/W+XTx0ZuaLLzwnGGIUuDQhQn43cxaF6PxDaxlAOoe1O+xv9QnY8o6Q6Skd61QgDB0mYlF2BCpNQqx2zK+wGrGiryGnc1AdsImZZWcI0ISS9cm8fmNCwu7D6SUlYMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfN63upc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f09d89718so14733735ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738704712; x=1739309512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EFkwgyb5BuJX+usrePYvrQhplJIen5/ak4VjfBuAK7s=;
        b=UfN63upccwg+YeZqStt69W2YmiFO3RhEVkfmvPSH3/7j5aN9y6+cQzjAgKPlbE8Vfn
         +oltMGB+yVZ/0OpZ3zMF5Q3lcO774dxakQhKOriEtQKxOmfVo8Ne7u3DRJj7ZhWa5t5A
         9jyDglj8CdIqVhno2yvmbSH6lNnkJOmDqGe0SBOBCE1P9CsS/DMQPYSVkhsnEmj2A0zE
         7eQhGXQY/oDD2Oe7LByrIzTNl8PFoWdYX2+FHysyDP4NGLoa9Fenfzo9MZEdctpUf6rk
         nxYDivLp/8WWct7gpfzs7ml3vOMt94gqSHIRWxNsZwmul3uxd4wiZctU9tIq7JUIRZDi
         p2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704712; x=1739309512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFkwgyb5BuJX+usrePYvrQhplJIen5/ak4VjfBuAK7s=;
        b=tf32epyga0MtUfPMomDhsbjfwMSs56h4z6HO3ogCYcj/dMaWxMwmCgRyFtxQKbNWbv
         8Ap48ZcXAkRZbfUgyQKDR9SmOVokewkA3WAftr+I/bGIu2uBBAJzcmv6yLIjIlGEcZIR
         KUfmc2C1GzonSnHRYdZc4ZbprJOL9bqfmZZZ/A9dtGXUacRES0drId8C9G0GZV3b89Ve
         Ub9nOwhmjMJWhIURe7rSO+CGmKG7c5XbQ+zvMCs/MUeQAEX5H8WxneE177Nvf5mMrSHw
         gpblDNQq4UJYleHuOGruTi9fqtP3WU/WW7j9cKOkt7sugj+Ww4lYZuBkUCO/L1INJ6G9
         ZRRg==
X-Gm-Message-State: AOJu0YwZXG1Mx0sNudtoQ1r08sD1KXDFq48mlDOmB/N1Bx/fmHWedn9q
	L98G77FY7ZPOupRwGEfPNixDirfspOMxxO2pje75kxZ22Z8zUIt91bM0brRYw7TXBU75prGDqlP
	N3+02jOSPAeLeYp4X6LmBFLBfc9x0kS+2tbmEm0WivubayPsQ0uyUu+3a8Fdhop29l5M/QjshxW
	aO0QPd+YINktWPNdyeayxn5jnjG0peElzYnVokSLsj5no=
X-Google-Smtp-Source: AGHT+IGTHqGz5CcupDUeSXfjtOEk7P9lR3OQh80lrd2rVsUgvzrm2apzh8gkPPz+FxlD8Svs5aHZZdkYd+mjyA==
X-Received: from pgbcv3.prod.google.com ([2002:a05:6a02:4203:b0:7fe:ffa9:4e54])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6f09:b0:1e8:bd15:6819 with SMTP id adf61e73a8af0-1ede88461d2mr530588637.22.1738704711639;
 Tue, 04 Feb 2025 13:31:51 -0800 (PST)
Date: Tue,  4 Feb 2025 13:31:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204213121.14195-1-jeroendb@google.com>
Subject: [PATCH net-next v2] gve: Add RSS cache for non RSS device option scenario
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, andrew+netdev@lunn.ch, willemb@google.com, 
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, Jeroen de Borst <jeroend@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

Not all the devices have the capability for the driver to query for the
registered RSS configuration. The driver can discover this by checking
the relevant device option during setup. If it cannot, the driver needs
to store the RSS config cache and directly return such cache when
queried by the ethtool. RSS config is inited when driver probes. Also the
default RSS config will be adjusted when there is RX queue count change.

At this point, only keys of GVE_RSS_KEY_SIZE and indirection tables of
GVE_RSS_INDIR_SIZE are supported.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Jeroen de Borst <jeroend@google.com>
---
Changes in v2:
 - Change to initialize RSS config when the driver is up instead of
   doing that when the user setting the RSS.(Jakub Kicinski)
 - Use NL_SET_ERR_MSG_MOD to log errors when there is extack
   available.(Jakub Kicinski)
 - Use ethtool_rxfh_indir_default to set default RSS indir
   table.(Jakub Kicinski)
 - Adjust the default RSS config when there is RX queue count change to
   ensure the default RSS config is correct.

 drivers/net/ethernet/google/gve/gve.h         | 16 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 64 ++++++++++---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 60 ++++++++++--
 drivers/net/ethernet/google/gve/gve_main.c    | 92 ++++++++++++++++++-
 4 files changed, 209 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8167cc5fb0df..8e1e706c6f5e 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -68,6 +68,9 @@
 #define GVE_FLOW_RULE_IDS_CACHE_SIZE \
 	(GVE_ADMINQ_BUFFER_SIZE / sizeof(((struct gve_adminq_queried_flow_rule *)0)->location))
 
+#define GVE_RSS_KEY_SIZE	40
+#define GVE_RSS_INDIR_SIZE	128
+
 #define GVE_XDP_ACTIONS 5
 
 #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
@@ -672,6 +675,7 @@ struct gve_rx_alloc_rings_cfg {
 	u16 packet_buffer_size;
 	bool raw_addressing;
 	bool enable_header_split;
+	bool reset_rss;
 
 	/* Allocated resources are returned here */
 	struct gve_rx_ring *rx;
@@ -722,6 +726,11 @@ struct gve_flow_rules_cache {
 	u32 rule_ids_cache_num;
 };
 
+struct gve_rss_config {
+	u8 *hash_key;
+	u32 *hash_lut;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -842,6 +851,8 @@ struct gve_priv {
 
 	u16 rss_key_size;
 	u16 rss_lut_size;
+	bool cache_rss_config;
+	struct gve_rss_config rss_config;
 };
 
 enum gve_service_task_flags_bit {
@@ -1210,13 +1221,16 @@ int gve_adjust_config(struct gve_priv *priv,
 		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_queue_config new_rx_config,
-		      struct gve_queue_config new_tx_config);
+		      struct gve_queue_config new_tx_config,
+		      bool reset_rss);
 /* flow steering rule */
 int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *cmd, u32 *rule_locs);
 int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_flow_rules_reset(struct gve_priv *priv);
+/* RSS config */
+int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
 /* report stats handling */
 void gve_handle_report_stats(struct gve_priv *priv);
 /* exported by ethtool.c */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index aa7d723011d0..a9ae094456cb 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -885,6 +885,15 @@ static void gve_set_default_desc_cnt(struct gve_priv *priv,
 	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
 }
 
+static void gve_set_default_rss_sizes(struct gve_priv *priv)
+{
+	if (!gve_is_gqi(priv)) {
+		priv->rss_key_size = GVE_RSS_KEY_SIZE;
+		priv->rss_lut_size = GVE_RSS_INDIR_SIZE;
+		priv->cache_rss_config = true;
+	}
+}
+
 static void gve_enable_supported_features(struct gve_priv *priv,
 					  u32 supported_features_mask,
 					  const struct gve_device_option_jumbo_frames
@@ -968,6 +977,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			be16_to_cpu(dev_op_rss_config->hash_key_size);
 		priv->rss_lut_size =
 			be16_to_cpu(dev_op_rss_config->hash_lut_size);
+		priv->cache_rss_config = false;
+		dev_dbg(&priv->pdev->dev,
+			"RSS device option enabled with key size of %u, lut size of %u.\n",
+			priv->rss_key_size, priv->rss_lut_size);
 	}
 }
 
@@ -1052,6 +1065,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	/* set default descriptor counts */
 	gve_set_default_desc_cnt(priv, descriptor);
 
+	gve_set_default_rss_sizes(priv);
+
 	/* DQO supports LRO. */
 	if (!gve_is_gqi(priv))
 		priv->dev->hw_features |= NETIF_F_LRO;
@@ -1276,8 +1291,9 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv)
 
 int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh)
 {
+	const u32 *hash_lut_to_config = NULL;
+	const u8 *hash_key_to_config = NULL;
 	dma_addr_t lut_bus = 0, key_bus = 0;
-	u16 key_size = 0, lut_size = 0;
 	union gve_adminq_command cmd;
 	__be32 *lut = NULL;
 	u8 hash_alg = 0;
@@ -1287,7 +1303,7 @@ int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *r
 
 	switch (rxfh->hfunc) {
 	case ETH_RSS_HASH_NO_CHANGE:
-		break;
+		fallthrough;
 	case ETH_RSS_HASH_TOP:
 		hash_alg = ETH_RSS_HASH_TOP;
 		break;
@@ -1296,27 +1312,44 @@ int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *r
 	}
 
 	if (rxfh->indir) {
-		lut_size = priv->rss_lut_size;
+		if (rxfh->indir_size != priv->rss_lut_size)
+			return -EINVAL;
+
+		hash_lut_to_config = rxfh->indir;
+	} else if (priv->cache_rss_config) {
+		hash_lut_to_config = priv->rss_config.hash_lut;
+	}
+
+	if (hash_lut_to_config) {
 		lut = dma_alloc_coherent(&priv->pdev->dev,
-					 lut_size * sizeof(*lut),
+					 priv->rss_lut_size * sizeof(*lut),
 					 &lut_bus, GFP_KERNEL);
 		if (!lut)
 			return -ENOMEM;
 
 		for (i = 0; i < priv->rss_lut_size; i++)
-			lut[i] = cpu_to_be32(rxfh->indir[i]);
+			lut[i] = cpu_to_be32(hash_lut_to_config[i]);
 	}
 
 	if (rxfh->key) {
-		key_size = priv->rss_key_size;
+		if (rxfh->key_size != priv->rss_key_size)
+			return -EINVAL;
+
+		hash_key_to_config = rxfh->key;
+	} else if (priv->cache_rss_config) {
+		hash_key_to_config = priv->rss_config.hash_key;
+	}
+
+	if (hash_key_to_config) {
 		key = dma_alloc_coherent(&priv->pdev->dev,
-					 key_size, &key_bus, GFP_KERNEL);
+					 priv->rss_key_size,
+					 &key_bus, GFP_KERNEL);
 		if (!key) {
 			err = -ENOMEM;
 			goto out;
 		}
 
-		memcpy(key, rxfh->key, key_size);
+		memcpy(key, hash_key_to_config, priv->rss_key_size);
 	}
 
 	/* Zero-valued fields in the cmd.configure_rss instruct the device to
@@ -1330,8 +1363,10 @@ int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *r
 					  BIT(GVE_RSS_HASH_TCPV6) |
 					  BIT(GVE_RSS_HASH_UDPV6)),
 		.hash_alg = hash_alg,
-		.hash_key_size = cpu_to_be16(key_size),
-		.hash_lut_size = cpu_to_be16(lut_size),
+		.hash_key_size =
+			cpu_to_be16((key_bus) ? priv->rss_key_size : 0),
+		.hash_lut_size =
+			cpu_to_be16((lut_bus) ? priv->rss_lut_size : 0),
 		.hash_key_addr = cpu_to_be64(key_bus),
 		.hash_lut_addr = cpu_to_be64(lut_bus),
 	};
@@ -1341,11 +1376,11 @@ int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *r
 out:
 	if (lut)
 		dma_free_coherent(&priv->pdev->dev,
-				  lut_size * sizeof(*lut),
+				  priv->rss_lut_size * sizeof(*lut),
 				  lut, lut_bus);
 	if (key)
 		dma_free_coherent(&priv->pdev->dev,
-				  key_size, key, key_bus);
+				  priv->rss_key_size, key, key_bus);
 	return err;
 }
 
@@ -1449,12 +1484,15 @@ static int gve_adminq_process_rss_query(struct gve_priv *priv,
 	rxfh->hfunc = descriptor->hash_alg;
 
 	rss_info_addr = (void *)(descriptor + 1);
-	if (rxfh->key)
+	if (rxfh->key) {
+		rxfh->key_size = priv->rss_key_size;
 		memcpy(rxfh->key, rss_info_addr, priv->rss_key_size);
+	}
 
 	rss_info_addr += priv->rss_key_size;
 	lut = (__be32 *)rss_info_addr;
 	if (rxfh->indir) {
+		rxfh->indir_size = priv->rss_lut_size;
 		for (i = 0; i < priv->rss_lut_size; i++)
 			rxfh->indir[i] = be32_to_cpu(lut[i]);
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index bdfc6e77b2af..efcafc607b2a 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -482,6 +482,7 @@ static int gve_set_channels(struct net_device *netdev,
 	struct ethtool_channels old_settings;
 	int new_tx = cmd->tx_count;
 	int new_rx = cmd->rx_count;
+	bool reset_rss;
 
 	gve_get_channels(netdev, &old_settings);
 
@@ -498,16 +499,14 @@ static int gve_set_channels(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (!netif_running(netdev)) {
-		priv->tx_cfg.num_queues = new_tx;
-		priv->rx_cfg.num_queues = new_rx;
-		return 0;
-	}
+	if (new_rx != priv->rx_cfg.num_queues &&
+	    priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
+		reset_rss = true;
 
 	new_tx_cfg.num_queues = new_tx;
 	new_rx_cfg.num_queues = new_rx;
 
-	return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg);
+	return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss);
 }
 
 static void gve_get_ringparam(struct net_device *netdev,
@@ -855,6 +854,25 @@ static u32 gve_get_rxfh_indir_size(struct net_device *netdev)
 	return priv->rss_lut_size;
 }
 
+static void gve_get_rss_config_cache(struct gve_priv *priv,
+				     struct ethtool_rxfh_param *rxfh)
+{
+	struct gve_rss_config *rss_config = &priv->rss_config;
+
+	rxfh->hfunc = ETH_RSS_HASH_TOP;
+
+	if (rxfh->key) {
+		rxfh->key_size = priv->rss_key_size;
+		memcpy(rxfh->key, rss_config->hash_key, priv->rss_key_size);
+	}
+
+	if (rxfh->indir) {
+		rxfh->indir_size = priv->rss_lut_size;
+		memcpy(rxfh->indir, rss_config->hash_lut,
+		       priv->rss_lut_size * sizeof(*rxfh->indir));
+	}
+}
+
 static int gve_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
@@ -862,18 +880,46 @@ static int gve_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rx
 	if (!priv->rss_key_size || !priv->rss_lut_size)
 		return -EOPNOTSUPP;
 
+	if (priv->cache_rss_config) {
+		gve_get_rss_config_cache(priv, rxfh);
+		return 0;
+	}
+
 	return gve_adminq_query_rss_config(priv, rxfh);
 }
 
+static void gve_set_rss_config_cache(struct gve_priv *priv,
+				     struct ethtool_rxfh_param *rxfh)
+{
+	struct gve_rss_config *rss_config = &priv->rss_config;
+
+	if (rxfh->key)
+		memcpy(rss_config->hash_key, rxfh->key, priv->rss_key_size);
+
+	if (rxfh->indir)
+		memcpy(rss_config->hash_lut, rxfh->indir,
+		       priv->rss_lut_size * sizeof(*rxfh->indir));
+}
+
 static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 			struct netlink_ext_ack *extack)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
+	int err;
 
 	if (!priv->rss_key_size || !priv->rss_lut_size)
 		return -EOPNOTSUPP;
 
-	return gve_adminq_configure_rss(priv, rxfh);
+	err = gve_adminq_configure_rss(priv, rxfh);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Fail to configure RSS config\n");
+		return err;
+	}
+
+	if (priv->cache_rss_config)
+		gve_set_rss_config_cache(priv, rxfh);
+
+	return 0;
 }
 
 const struct ethtool_ops gve_ethtool_ops = {
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 533e659b15b3..d726a4d39b45 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -184,6 +184,49 @@ static void gve_free_flow_rule_caches(struct gve_priv *priv)
 	flow_rules_cache->rules_cache = NULL;
 }
 
+static int gve_alloc_rss_config_cache(struct gve_priv *priv)
+{
+	struct gve_rss_config *rss_config = &priv->rss_config;
+	int err = 0;
+
+	if (!priv->cache_rss_config)
+		return 0;
+
+	rss_config->hash_key = kcalloc(priv->rss_key_size,
+				       sizeof(rss_config->hash_key[0]),
+				       GFP_KERNEL);
+	if (!rss_config->hash_key) {
+		dev_err(&priv->pdev->dev, "Cannot alloc rss key cache\n");
+		return -ENOMEM;
+	}
+
+	rss_config->hash_lut = kcalloc(priv->rss_lut_size,
+				       sizeof(rss_config->hash_lut[0]),
+				       GFP_KERNEL);
+	if (!rss_config->hash_lut) {
+		dev_err(&priv->pdev->dev, "Cannot alloc rss lut cache\n");
+		err = -ENOMEM;
+		goto free_rss_key_cache;
+	}
+
+	return 0;
+
+free_rss_key_cache:
+	kfree(rss_config->hash_key);
+	rss_config->hash_key = NULL;
+	return err;
+}
+
+static void gve_free_rss_config_cache(struct gve_priv *priv)
+{
+	struct gve_rss_config *rss_config = &priv->rss_config;
+
+	kfree(rss_config->hash_key);
+	kfree(rss_config->hash_lut);
+
+	memset(rss_config, 0, sizeof(*rss_config));
+}
+
 static int gve_alloc_counter_array(struct gve_priv *priv)
 {
 	priv->counter_array =
@@ -575,9 +618,12 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_alloc_flow_rule_caches(priv);
 	if (err)
 		return err;
-	err = gve_alloc_counter_array(priv);
+	err = gve_alloc_rss_config_cache(priv);
 	if (err)
 		goto abort_with_flow_rule_caches;
+	err = gve_alloc_counter_array(priv);
+	if (err)
+		goto abort_with_rss_config_cache;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
 		goto abort_with_counter;
@@ -611,6 +657,12 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		}
 	}
 
+	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Failed to init RSS config");
+		goto abort_with_ptype_lut;
+	}
+
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
 				      priv->stats_report_bus,
 				      GVE_STATS_REPORT_TIMER_PERIOD);
@@ -629,6 +681,8 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_free_notify_blocks(priv);
 abort_with_counter:
 	gve_free_counter_array(priv);
+abort_with_rss_config_cache:
+	gve_free_rss_config_cache(priv);
 abort_with_flow_rule_caches:
 	gve_free_flow_rule_caches(priv);
 
@@ -669,6 +723,7 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	priv->ptype_lut_dqo = NULL;
 
 	gve_free_flow_rule_caches(priv);
+	gve_free_rss_config_cache(priv);
 	gve_free_counter_array(priv);
 	gve_free_notify_blocks(priv);
 	gve_free_stats_report(priv);
@@ -1390,6 +1445,12 @@ static int gve_queues_start(struct gve_priv *priv,
 	if (err)
 		goto stop_and_free_rings;
 
+	if (rx_alloc_cfg->reset_rss) {
+		err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
+		if (err)
+			goto reset;
+	}
+
 	err = gve_register_qpls(priv);
 	if (err)
 		goto reset;
@@ -1786,6 +1847,26 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
+{
+	struct gve_rss_config *rss_config = &priv->rss_config;
+	struct ethtool_rxfh_param rxfh;
+	u16 i;
+
+	if (!priv->cache_rss_config)
+		return 0;
+
+	for (i = 0; i < priv->rss_lut_size; i++)
+		rss_config->hash_lut[i] =
+			ethtool_rxfh_indir_default(i, num_queues);
+
+	netdev_rss_key_fill(rss_config->hash_key, priv->rss_key_size);
+
+	rxfh.hfunc = ETH_RSS_HASH_TOP;
+
+	return gve_adminq_configure_rss(priv, &rxfh);
+}
+
 int gve_flow_rules_reset(struct gve_priv *priv)
 {
 	if (!priv->max_flow_rules)
@@ -1834,7 +1915,8 @@ int gve_adjust_config(struct gve_priv *priv,
 
 int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_queue_config new_rx_config,
-		      struct gve_queue_config new_tx_config)
+		      struct gve_queue_config new_tx_config,
+		      bool reset_rss)
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
@@ -1847,6 +1929,7 @@ int gve_adjust_queues(struct gve_priv *priv,
 	tx_alloc_cfg.qcfg = &new_tx_config;
 	rx_alloc_cfg.qcfg_tx = &new_tx_config;
 	rx_alloc_cfg.qcfg = &new_rx_config;
+	rx_alloc_cfg.reset_rss = reset_rss;
 	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
 
 	/* Add dedicated XDP TX queues if enabled. */
@@ -1858,6 +1941,11 @@ int gve_adjust_queues(struct gve_priv *priv,
 		return err;
 	}
 	/* Set the config for the next up. */
+	if (reset_rss) {
+		err = gve_init_rss_config(priv, new_rx_config.num_queues);
+		if (err)
+			return err;
+	}
 	priv->tx_cfg = new_tx_config;
 	priv->rx_cfg = new_rx_config;
 
-- 
2.48.1.362.g079036d154-goog


