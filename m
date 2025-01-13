Return-Path: <netdev+bounces-157891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D8A0C358
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A893A1835
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A501CDFC1;
	Mon, 13 Jan 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsRfVHne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC81BEF6F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802717; cv=none; b=K31OOGrR/DojuFKkJhH5qrZRVsQeTp8QNREM3uc0KtNFYbj48ugKnhdm5DuF0lVXvXhJY8QvBRMiLYlYclBP9uM4MoCXhVHOR94+1gO1cJ7Vqtlg6WNg1snqDapnBdSMDX6UJ6llqWLWAf1BPiMZZ03uR2GfC/H1+J44QwdxD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802717; c=relaxed/simple;
	bh=qdO/0bOg+/jX44dtwOJZcGqQS/R4iHvgJcGrGuAQCUw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B51QjCVRoBhDvDmJoQWntfUzEwWN13X4vreH92w/iCcZUopJnZYDMU6n1VbaYIInmJsYE+F0OBQ6lMrYVeGLh4rXgdMUdAZyFSamvGp2gvZLr9inWdtTOQqpccnQkJqaMBiR6Thf8zBKryi3PfzLgUHq4eOvWP5iAAuv6CGW9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsRfVHne; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso8371905a91.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736802715; x=1737407515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D9PvUos5HGCUMQIxLBTXs46v5JHGasjCvjJrxmTJgo8=;
        b=dsRfVHnenePdEn0p7N0qHg084V0m/r2EjvpLKZtC3M02xA6g9Vi/XJx1wOr8/wl9MA
         vsaYBZXmzqGcFwOuGM8vvmRN8icl7cROgUJW7zdEJSW1n0dIIZZc0N21w3bqvJCL1Z0Z
         8cTLq9NOYYG4TzJ5lXYI/gwG/yxRYIuB7RPuHsD6OQBpSBC8RzYU5QnWymtOGP8cvnay
         aP1q8cazB7ac+ptekc7trJkx5r2NZcA6ybzcHBD2eKLQoSk1FaccWLvcHwVIaEhA75D+
         B9nWfRemNIgdgj6VeBUmFI+fM5sk7Wb2yRDCkrbnNBF3aF2qGV+UImi0ZqpAaOh2rT13
         p5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802715; x=1737407515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9PvUos5HGCUMQIxLBTXs46v5JHGasjCvjJrxmTJgo8=;
        b=APuFKWlQobldA8fHZ2e4XM4axPCD+/vRHBA0RO9sNxHO4Mb4nsufT63Uizy0R3AFcI
         JvQjGGuah7wKB9E4y4btgXNA1FFDFJ0jc9o73pbLIYWdmOiJqTSG57PNUMOM5UQWdaLW
         O54kXVl/JEKv07TG1QUPCYjaC6Z6CACy0fcjUEG1Dsgpq7I6nPItX60EfPwQOaMRlv0I
         QCe8m0rQfZuAWOW+7cI8UcaTVTrYfwXpEHl7gIEplR8RgycXxANxbjo1AiTFJVrnVFCV
         gpOGDCqKxIZhO+2E4RipI/WIbJgFmz3N153okaJCKlvqX5HJvirPB3h0rv+jU4x/BGYh
         u3wA==
X-Gm-Message-State: AOJu0YzwSIsWdc8jHC38ATvg8+nIGnoDKTD1UY8zwItE67wKrqIhNbaY
	bSO5ttiDjhRk7EtWUKxIFdBjUwXB4S3nw6rGl4Ug4j/SuH5f8VrSm9tXU87ODAKTdbHbMK1iQXV
	Dh9pkE4PwUi32hV8HyJ4uhG2tPShYWNR4+46+bMH+QcFOWMA+JYXi/GZQKR0BD7RlFKIszwDYNR
	Ct9RzwE6koVL4/Q1DDQOLoTFvewTiW4LfMizdb2Smlq7Mz0RlvZ7foTVe9KGUc76KK
X-Google-Smtp-Source: AGHT+IHQl8uYc2PSKtKlxx9HfzexHbeoEC8RWdyImZgBxnJk5RRQX5ipLIZIfbPyySetp1pAeMxE1pxtTerHjb7NGIE=
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:2ef:973a:3caf])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:270d:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2f548eae587mr33065075a91.10.1736802714653;
 Mon, 13 Jan 2025 13:11:54 -0800 (PST)
Date: Mon, 13 Jan 2025 13:11:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113211139.4137621-1-pkaligineedi@google.com>
Subject: [PATCH net-next] gve: Add RSS cache for non RSS device option scenario
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, shailend@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, hramamurthy@google.com, 
	ziweixiao@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

Not all the devices have the capability for the driver to query for the
registered RSS configuration. The driver can discover this by checking
the relevant device option during setup. If it cannot, the driver needs
to store the RSS config cache and directly return such cache when
queried by the ethtool. Currently, the RSS is only enabled when
requested.

At this point, only keys of GVE_RSS_KEY_SIZE and indirection tables of
GVE_RSS_INDIR_SIZE are supported.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 13 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  | 64 ++++++++++++----
 drivers/net/ethernet/google/gve/gve_ethtool.c | 59 ++++++++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 75 ++++++++++++++++++-
 4 files changed, 196 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8167cc5fb0df..3bc458f3ded5 100644
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
@@ -722,6 +725,11 @@ struct gve_flow_rules_cache {
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
@@ -842,6 +850,9 @@ struct gve_priv {
 
 	u16 rss_key_size;
 	u16 rss_lut_size;
+	bool cache_rss_config;
+	bool rss_cache_configured;
+	struct gve_rss_config rss_config;
 };
 
 enum gve_service_task_flags_bit {
@@ -1217,6 +1228,8 @@ int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *cmd, u32
 int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_flow_rules_reset(struct gve_priv *priv);
+/* RSS config */
+int gve_init_rss_config(struct gve_priv *priv);
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
index bdfc6e77b2af..cf27d46fd80a 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -855,6 +855,25 @@ static u32 gve_get_rxfh_indir_size(struct net_device *netdev)
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
@@ -862,18 +881,56 @@ static int gve_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rx
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
+
+	priv->rss_cache_configured = true;
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
+	if (priv->cache_rss_config && !priv->rss_cache_configured) {
+		err = gve_init_rss_config(priv);
+		if (err) {
+			dev_err(&priv->pdev->dev, "Fail to init RSS config\n");
+			return err;
+		}
+	}
+
+	err = gve_adminq_configure_rss(priv, rxfh);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Fail to configure RSS config\n");
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
index 533e659b15b3..170f2f41ec2d 100644
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
@@ -611,6 +657,14 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		}
 	}
 
+	if (priv->rss_cache_configured) {
+		err = gve_init_rss_config(priv);
+		if (err) {
+			dev_err(&priv->pdev->dev, "Failed to reset RSS config");
+			goto abort_with_ptype_lut;
+		}
+	}
+
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
 				      priv->stats_report_bus,
 				      GVE_STATS_REPORT_TIMER_PERIOD);
@@ -629,6 +683,8 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_free_notify_blocks(priv);
 abort_with_counter:
 	gve_free_counter_array(priv);
+abort_with_rss_config_cache:
+	gve_free_rss_config_cache(priv);
 abort_with_flow_rule_caches:
 	gve_free_flow_rule_caches(priv);
 
@@ -669,6 +725,7 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	priv->ptype_lut_dqo = NULL;
 
 	gve_free_flow_rule_caches(priv);
+	gve_free_rss_config_cache(priv);
 	gve_free_counter_array(priv);
 	gve_free_notify_blocks(priv);
 	gve_free_stats_report(priv);
@@ -1786,6 +1843,22 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+int gve_init_rss_config(struct gve_priv *priv)
+{
+	struct gve_rss_config *rss_config = &priv->rss_config;
+	struct ethtool_rxfh_param rxfh;
+	u16 i;
+
+	for (i = 0; i < priv->rss_lut_size; i++)
+		rss_config->hash_lut[i] = i % priv->rx_cfg.num_queues;
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
-- 
2.47.1.688.g23fc6f90ad-goog


