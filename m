Return-Path: <netdev+bounces-117865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2794F987
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0CB1C21805
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D16B1953B9;
	Mon, 12 Aug 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9LsJ2DY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063414A4DF
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501276; cv=none; b=qkbSIlJpCotIYh16x6NNYHxU30DOUm1brr4jVx0+Ll9IqPfDIaAYa96KEp/nmhrGcOfflP6c0HX0DB52g0PAkwAaTek/bAhn4/uqLzDgj6P5rmT4/WW7Rpy37yaQiNwnx5zP4owlYm7urMQNPPw9z2sDSkcf+Wqc5ziEsxMf3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501276; c=relaxed/simple;
	bh=6gQoeLNdUmoGRP2RC7VFDBqGizozUQetaLuO7SFW658=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=geY+bWGkZw6LWGk/my9ZF2bNodWkfjntmAIkUBfd1rAxvJG9H5qTeuj/kRJEf7uQkvyZor8DNlElIkTGUePsipBcVmnP9G/J72yxqRGDsFAyxVEhnUw8rTYvjIzhwhZExcFJtb33Qji9tF7eLh+aVvPYwdrxZrsrQKyYxDGZ5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9LsJ2DY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0e6c47daf7so9139187276.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723501273; x=1724106073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlRslA5uJqM6VInbXgpLNgto9m04oXjvnbFi7K7mJCk=;
        b=K9LsJ2DYcsFaqxgJm5KXHlEkOlcOsKIMQhepOfDtN26+i63z2U/IObxznmyl1shEZv
         8YrQEGlbxpYgc+v+2+4Rano0aQPoz12l6mYK20/I8PD8vGlGAk2ukKWh4O3dJePWGk8g
         zVuDpo6uLHe6ENbRNqE2RlO+0C6eL/WfevIpjmK8MGUp9/uW1sgc+kWB3dH0MTr43U30
         ORujsnTGqDGKTMvYGUubIjLWKyWf4WSPqZ+kTOnT7KSEWUg77gzetpxhgXRowELq7Qs+
         4TjfEfOox3x4tjhnaIsXePa2vQH4/EyPbzTLUnyYVykDMQywebwN0i0Sk6yzVlGk46aY
         0PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501273; x=1724106073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlRslA5uJqM6VInbXgpLNgto9m04oXjvnbFi7K7mJCk=;
        b=U0bUMXKMcPlgfGu6NdMA2dFdLrjOy1/1Td6iP0XoV6BbKg/7Bz2Z6RdG8RpwvIDRxq
         5QogBZd1xy4yqb1vJFTlV2BPSID2lgUXt/HeffFpayt2+/1vv+XKYDm1vwN1OH9sJ6lj
         ADbQ7eMoXsv5a+NBCbpllsVOmf/Wl/niL8WeJL6BHOmY8eZUvOvzEfrYIq9esWy6oPFL
         9feJEpylXM86tmkVQ2M5dUm5VB745HsPu20qJM2CGxKGjAIvMdMGHQHlc4wVnmh46Ltn
         XpYlpAK+HoCpvnMxfO+EtGhJyUtfEXS8s5IX4ep3rvRIjhrlvhHgQEn5DXMl8xjhLQ74
         OSmw==
X-Gm-Message-State: AOJu0YwlLFSb1lBS1OZeS215+y3Bu31YVa+8iljFth43qNXyyZE/GgtZ
	ynkInzrC51VbI+tt8uJimygVkpJgm9StNFaWEeeOj2zF8BVqhzr5LlHptwvN1ztQieVXVe5mmaF
	jCg9w5hXZg5n4EoecXMzJLiUaLo/QezmJxrVnCy1xR/NFw/wHu8BXOLre6h3ZStnhQE9O26tD8n
	z6a+Zg0/yPrk+AOEIDLxE5JQhORppjRstomr10+NpppOLFvBMHlnL1bujvLrwMxxSt
X-Google-Smtp-Source: AGHT+IH9QktVubgMS5ZWyueDnxigUgebpiEaEQz6VKXaWpSvy8uvEMxPhhqz435aj9Xo97tSVAR7KaIKkcZz2/AakUo=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:8c4a:afa1:7322:951c])
 (user=pkaligineedi job=sendgmr) by 2002:a25:6fc5:0:b0:e0b:ab63:b9c7 with SMTP
 id 3f1490d57ef6-e113cf5e921mr2387276.7.1723501272620; Mon, 12 Aug 2024
 15:21:12 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:20:13 -0700
In-Reply-To: <20240812222013.1503584-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812222013.1503584-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812222013.1503584-3-pkaligineedi@google.com>
Subject: [PATCH net-next v3 2/2] gve: Add RSS adminq commands and ethtool support
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, jfraker@google.com, 
	Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Introduce adminq commands to configure and retrieve RSS settings from
the device. Implement corresponding ethtool ops for user-level
management.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v2:
	- Update the GVE's get/set_rxfh functions to send the
	  ethtool_rxfh_param directly to related adminq functions so
	  that it can avoid the extra copy between ethtool and the
	  local gve_rss_config struct(Jakub Kicinski)
	- Remove the struct gve_rss_config that becomes unused
	- Add a comment in the gve_adminq_configure_rss function to
	  describe the device expections for the configure_rss adminq
	  command

 drivers/net/ethernet/google/gve/gve.h         |   2 +
 drivers/net/ethernet/google/gve/gve_adminq.c  | 146 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  |  44 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  44 +++++-
 4 files changed, 235 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 6c21f3c53619..09a85ed59143 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -784,6 +784,8 @@ struct gve_priv {
 	u32 adminq_verify_driver_compatibility_cnt;
 	u32 adminq_query_flow_rules_cnt;
 	u32 adminq_cfg_flow_rule_cnt;
+	u32 adminq_cfg_rss_cnt;
+	u32 adminq_query_rss_cnt;
 
 	/* Global stats */
 	u32 interface_up_cnt; /* count of times interface turned up since last reset */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b5c801d2f8b5..e44e8b139633 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -309,6 +309,8 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt = 0;
 	priv->adminq_query_flow_rules_cnt = 0;
 	priv->adminq_cfg_flow_rule_cnt = 0;
+	priv->adminq_cfg_rss_cnt = 0;
+	priv->adminq_query_rss_cnt = 0;
 
 	/* Setup Admin queue with the device */
 	if (priv->pdev->revision < 0x1) {
@@ -554,6 +556,12 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	case GVE_ADMINQ_CONFIGURE_FLOW_RULE:
 		priv->adminq_cfg_flow_rule_cnt++;
 		break;
+	case GVE_ADMINQ_CONFIGURE_RSS:
+		priv->adminq_cfg_rss_cnt++;
+		break;
+	case GVE_ADMINQ_QUERY_RSS:
+		priv->adminq_query_rss_cnt++;
+		break;
 	default:
 		dev_err(&priv->pdev->dev, "unknown AQ command opcode %d\n", opcode);
 	}
@@ -1280,6 +1288,81 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv)
 	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
 }
 
+int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh)
+{
+	dma_addr_t lut_bus = 0, key_bus = 0;
+	u16 key_size = 0, lut_size = 0;
+	union gve_adminq_command cmd;
+	__be32 *lut = NULL;
+	u8 hash_alg = 0;
+	u8 *key = NULL;
+	int err = 0;
+	u16 i;
+
+	switch (rxfh->hfunc) {
+	case ETH_RSS_HASH_NO_CHANGE:
+		break;
+	case ETH_RSS_HASH_TOP:
+		hash_alg = ETH_RSS_HASH_TOP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (rxfh->indir) {
+		lut_size = priv->rss_lut_size;
+		lut = dma_alloc_coherent(&priv->pdev->dev,
+					 lut_size * sizeof(*lut),
+					 &lut_bus, GFP_KERNEL);
+		if (!lut)
+			return -ENOMEM;
+
+		for (i = 0; i < priv->rss_lut_size; i++)
+			lut[i] = cpu_to_be32(rxfh->indir[i]);
+	}
+
+	if (rxfh->key) {
+		key_size = priv->rss_key_size;
+		key = dma_alloc_coherent(&priv->pdev->dev,
+					 key_size, &key_bus, GFP_KERNEL);
+		if (!key) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(key, rxfh->key, key_size);
+	}
+
+	/* Zero-valued fields in the cmd.configure_rss instruct the device to
+	 * not update those fields.
+	 */
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_CONFIGURE_RSS);
+	cmd.configure_rss = (struct gve_adminq_configure_rss) {
+		.hash_types = cpu_to_be16(BIT(GVE_RSS_HASH_TCPV4) |
+					  BIT(GVE_RSS_HASH_UDPV4) |
+					  BIT(GVE_RSS_HASH_TCPV6) |
+					  BIT(GVE_RSS_HASH_UDPV6)),
+		.hash_alg = hash_alg,
+		.hash_key_size = cpu_to_be16(key_size),
+		.hash_lut_size = cpu_to_be16(lut_size),
+		.hash_key_addr = cpu_to_be64(key_bus),
+		.hash_lut_addr = cpu_to_be64(lut_bus),
+	};
+
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+out:
+	if (lut)
+		dma_free_coherent(&priv->pdev->dev,
+				  lut_size * sizeof(*lut),
+				  lut, lut_bus);
+	if (key)
+		dma_free_coherent(&priv->pdev->dev,
+				  key_size, key, key_bus);
+	return err;
+}
+
 /* In the dma memory that the driver allocated for the device to query the flow rules, the device
  * will first write it with a struct of gve_query_flow_rules_descriptor. Next to it, the device
  * will write an array of rules or rule ids with the count that specified in the descriptor.
@@ -1357,3 +1440,66 @@ int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 sta
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
+
+static int gve_adminq_process_rss_query(struct gve_priv *priv,
+					struct gve_query_rss_descriptor *descriptor,
+					struct ethtool_rxfh_param *rxfh)
+{
+	u32 total_memory_length;
+	u16 hash_lut_length;
+	void *rss_info_addr;
+	__be32 *lut;
+	u16 i;
+
+	total_memory_length = be32_to_cpu(descriptor->total_length);
+	hash_lut_length = priv->rss_lut_size * sizeof(*rxfh->indir);
+
+	if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length != total_memory_length) {
+		dev_err(&priv->dev->dev,
+			"rss query desc from device has invalid length parameter.\n");
+		return -EINVAL;
+	}
+
+	rxfh->hfunc = descriptor->hash_alg;
+
+	rss_info_addr = (void *)(descriptor + 1);
+	if (rxfh->key)
+		memcpy(rxfh->key, rss_info_addr, priv->rss_key_size);
+
+	rss_info_addr += priv->rss_key_size;
+	lut = (__be32 *)rss_info_addr;
+	if (rxfh->indir) {
+		for (i = 0; i < priv->rss_lut_size; i++)
+			rxfh->indir[i] = be32_to_cpu(lut[i]);
+	}
+
+	return 0;
+}
+
+int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh)
+{
+	struct gve_query_rss_descriptor *descriptor;
+	union gve_adminq_command cmd;
+	dma_addr_t descriptor_bus;
+	int err = 0;
+
+	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL, &descriptor_bus);
+	if (!descriptor)
+		return -ENOMEM;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_QUERY_RSS);
+	cmd.query_rss = (struct gve_adminq_query_rss) {
+		.available_length = cpu_to_be64(GVE_ADMINQ_BUFFER_SIZE),
+		.rss_descriptor_addr = cpu_to_be64(descriptor_bus),
+	};
+	err = gve_adminq_execute_cmd(priv, &cmd);
+	if (err)
+		goto out;
+
+	err = gve_adminq_process_rss_query(priv, descriptor, rxfh);
+
+out:
+	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
+	return err;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 7d9ef9a12fef..863683de9694 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -20,12 +20,14 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_DESTROY_TX_QUEUE		= 0x7,
 	GVE_ADMINQ_DESTROY_RX_QUEUE		= 0x8,
 	GVE_ADMINQ_DECONFIGURE_DEVICE_RESOURCES	= 0x9,
+	GVE_ADMINQ_CONFIGURE_RSS		= 0xA,
 	GVE_ADMINQ_SET_DRIVER_PARAMETER		= 0xB,
 	GVE_ADMINQ_REPORT_STATS			= 0xC,
 	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
 	GVE_ADMINQ_QUERY_FLOW_RULES		= 0x10,
+	GVE_ADMINQ_QUERY_RSS			= 0x12,
 
 	/* For commands that are larger than 56 bytes */
 	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
@@ -522,6 +524,44 @@ struct gve_adminq_query_flow_rules {
 
 static_assert(sizeof(struct gve_adminq_query_flow_rules) == 24);
 
+enum gve_rss_hash_type {
+	GVE_RSS_HASH_IPV4,
+	GVE_RSS_HASH_TCPV4,
+	GVE_RSS_HASH_IPV6,
+	GVE_RSS_HASH_IPV6_EX,
+	GVE_RSS_HASH_TCPV6,
+	GVE_RSS_HASH_TCPV6_EX,
+	GVE_RSS_HASH_UDPV4,
+	GVE_RSS_HASH_UDPV6,
+	GVE_RSS_HASH_UDPV6_EX,
+};
+
+struct gve_adminq_configure_rss {
+	__be16 hash_types;
+	u8 hash_alg;
+	u8 reserved;
+	__be16 hash_key_size;
+	__be16 hash_lut_size;
+	__be64 hash_key_addr;
+	__be64 hash_lut_addr;
+};
+
+static_assert(sizeof(struct gve_adminq_configure_rss) == 24);
+
+struct gve_query_rss_descriptor {
+	__be32 total_length;
+	__be16 hash_types;
+	u8 hash_alg;
+	u8 reserved;
+};
+
+struct gve_adminq_query_rss {
+	__be64 available_length;
+	__be64 rss_descriptor_addr;
+};
+
+static_assert(sizeof(struct gve_adminq_query_rss) == 16);
+
 union gve_adminq_command {
 	struct {
 		__be32 opcode;
@@ -543,6 +583,8 @@ union gve_adminq_command {
 			struct gve_adminq_verify_driver_compatibility
 						verify_driver_compatibility;
 			struct gve_adminq_query_flow_rules query_flow_rules;
+			struct gve_adminq_configure_rss configure_rss;
+			struct gve_adminq_query_rss query_rss;
 			struct gve_adminq_extended_command extended_command;
 		};
 	};
@@ -581,6 +623,8 @@ int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
 int gve_adminq_reset_flow_rules(struct gve_priv *priv);
 int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc);
+int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh);
+int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh);
 
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 5a8b490ab3ad..bdfc6e77b2af 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -75,7 +75,8 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
 	"adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
 	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
 	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt",
-	"adminq_query_flow_rules", "adminq_cfg_flow_rule",
+	"adminq_query_flow_rules", "adminq_cfg_flow_rule", "adminq_cfg_rss_cnt",
+	"adminq_query_rss_cnt",
 };
 
 static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
@@ -453,6 +454,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->adminq_get_ptype_map_cnt;
 	data[i++] = priv->adminq_query_flow_rules_cnt;
 	data[i++] = priv->adminq_cfg_flow_rule_cnt;
+	data[i++] = priv->adminq_cfg_rss_cnt;
+	data[i++] = priv->adminq_query_rss_cnt;
 }
 
 static void gve_get_channels(struct net_device *netdev,
@@ -838,6 +841,41 @@ static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u
 	return err;
 }
 
+static u32 gve_get_rxfh_key_size(struct net_device *netdev)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	return priv->rss_key_size;
+}
+
+static u32 gve_get_rxfh_indir_size(struct net_device *netdev)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	return priv->rss_lut_size;
+}
+
+static int gve_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	if (!priv->rss_key_size || !priv->rss_lut_size)
+		return -EOPNOTSUPP;
+
+	return gve_adminq_query_rss_config(priv, rxfh);
+}
+
+static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
+			struct netlink_ext_ack *extack)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	if (!priv->rss_key_size || !priv->rss_lut_size)
+		return -EOPNOTSUPP;
+
+	return gve_adminq_configure_rss(priv, rxfh);
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -851,6 +889,10 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_channels = gve_get_channels,
 	.set_rxnfc = gve_set_rxnfc,
 	.get_rxnfc = gve_get_rxnfc,
+	.get_rxfh_indir_size = gve_get_rxfh_indir_size,
+	.get_rxfh_key_size = gve_get_rxfh_key_size,
+	.get_rxfh = gve_get_rxfh,
+	.set_rxfh = gve_set_rxfh,
 	.get_link = ethtool_op_get_link,
 	.get_coalesce = gve_get_coalesce,
 	.set_coalesce = gve_set_coalesce,
-- 
2.46.0.76.ge559c4bf1a-goog


