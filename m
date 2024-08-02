Return-Path: <netdev+bounces-115180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D379455F2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62CD2858C7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F51C156;
	Fri,  2 Aug 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HympwHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FB175AE
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562150; cv=none; b=m+YonYMb7sxUQkw1edG5ylw0WWsp2/qYyALGOxMTIGyfBtZCqhitJTXGnT29rKKgTTcjtXdVdtKg7e4W4CLy0tgbKxVd8fkLMKEazUG05YNB8sUljMfBjm/77BiIOGmIVrlrcLedL9olPS9B7HeeswlgeTWgtizxmJd4w2MSCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562150; c=relaxed/simple;
	bh=t6VUpmhm7CtyXbpQOV33YVKB2WlVbnaDL/IcDC8xxB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bhd2ZKH98HtfPwtJdFXRePHmliB4fau8bfeMLgcpt55O5BWp31EJDNPI7mgNURWU2zvv3/hRXo1Sj6t8DepfhkupVEPnkpSdYjlRKWYbN49FctQHNRAde4pUhuaLVsSDZJiYcNGpwIA/OP0g1NECInws9IHtgLQgf71Uk0dCbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HympwHf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19c63so166698377b3.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 18:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722562148; x=1723166948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=erbWsRrQH6jGRfmnGnF2ms0yAboS2s6IRJ3irFzxjRI=;
        b=1HympwHfWyxdWn6nQb3N+JRi6gHjMW/eRAT2ul/fBROEmNCo1PDP0wPFazqnKmNFvG
         sL9cgNb2Cc39+nGOoDDGTbR9Z8y50LHaoa6kZofcR/vIsgKnOSpqyEd+4Jyl63yObysw
         FEe0NZUXl2jr46j70cDpy+zlK+zAYxeP4TaYCTt64iOvqKEOv0tVh7Uk3JgUXHIvssRE
         ujoS9UGqvr2ABRhPnHqtwKV8Hcyl7XxdukgR0snlYxfZBvJhfi/mRJPCEa3pq0WJwYhS
         GkDkd/NZfq+shNGEyQkAmegdN9MLiZYLEU6bo7uhYxbtQmzDVtJu7o+YFpKHCnGaw8hc
         crCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722562148; x=1723166948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erbWsRrQH6jGRfmnGnF2ms0yAboS2s6IRJ3irFzxjRI=;
        b=mjH8l6TLoIDU3Nkls9MP2BpDGRvlolsGSNc4em4PFaxDZPsf/QDlX8YELL9QXsezsQ
         uSyOZiHSxSDh/AnWRP8CE5chXs85J4mQYeUvG9GpgLDfNIYD7l/uloG1I5o+dZoPKX1u
         umuwaWnK7+V6NiUP6A1jwju49UOu6RgQkzqksFAoHXSitJzd+blEJ/ZusXgX1yhzoCFW
         2OU0HlhY/hb9X6zWr09b5zXrGQwNZ56K2xKO1vDiJOTvpqo9ItAMap0p0j6eMGX6Eirb
         /Y5vMXRzVNgpAFRsprWOAYs7f+HhEeewcOJgWzZOUWP8/eR4iA7hXMDIovFugCsrPhXF
         6/nA==
X-Gm-Message-State: AOJu0YwYeT7HLcl7IR89KtR5EJQCJwyLmW1f8Kj8rE1jVkKJ9vmUwMy+
	cypss5FBbKnfneVghrZluvTW4f9jZD92p5NjtAQ3SowkTWsAjr40ldvDh82uyzGnp5eqHcTb7qQ
	ZN4JKu78Oy+cXe1t0PL279yy1RiQsVUN5TiDFgCC1uyOpEWl2dNoYhDDIf7glMDGt/MaHouOoVl
	LQVmFjOXA9IipRdEo3EUHy+tnmzjesK5Jgk6veoVs4feKqepcdvBlNZqKaQaDf87sF
X-Google-Smtp-Source: AGHT+IEt4dXguL0AOyFmwGk3qiCNrT/6Cf5SM/jctxyfY8PCfSqe1TiNjQaZ9489P3KjCdqB1hGTiKQjzSz0DrhDR0s=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:fe4c:233c:119c:cbea])
 (user=pkaligineedi job=sendgmr) by 2002:a05:690c:17:b0:667:8a45:d0f9 with
 SMTP id 00721157ae682-68959f03f34mr412907b3.0.1722562147740; Thu, 01 Aug 2024
 18:29:07 -0700 (PDT)
Date: Thu,  1 Aug 2024 18:28:34 -0700
In-Reply-To: <20240802012834.1051452-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802012834.1051452-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802012834.1051452-3-pkaligineedi@google.com>
Subject: [PATCH net-next 2/2] gve: Add RSS adminq commands and ethtool support
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
 drivers/net/ethernet/google/gve/gve.h         |   8 ++
 drivers/net/ethernet/google/gve/gve_adminq.c  | 131 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  |  44 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 118 +++++++++++++++-
 4 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 6c21f3c53619..b838a135b320 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -643,6 +643,12 @@ struct gve_ptype_lut {
 	struct gve_ptype ptypes[GVE_NUM_PTYPES];
 };
 
+struct gve_rss_config {
+	u8 hash_alg;
+	u8 *hash_key;
+	u32 *hash_lut;
+};
+
 /* Parameters for allocating resources for tx queues */
 struct gve_tx_alloc_rings_cfg {
 	struct gve_queue_config *qcfg;
@@ -784,6 +790,8 @@ struct gve_priv {
 	u32 adminq_verify_driver_compatibility_cnt;
 	u32 adminq_query_flow_rules_cnt;
 	u32 adminq_cfg_flow_rule_cnt;
+	u32 adminq_cfg_rss_cnt;
+	u32 adminq_query_rss_cnt;
 
 	/* Global stats */
 	u32 interface_up_cnt; /* count of times interface turned up since last reset */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b0b7ef8a47d5..9ed4ab6c2809 100644
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
@@ -1280,6 +1288,69 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv)
 	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
 }
 
+int gve_adminq_configure_rss(struct gve_priv *priv, struct gve_rss_config *rss_config)
+{
+	dma_addr_t lut_bus = 0, key_bus = 0;
+	u16 key_size = 0, lut_size = 0;
+	union gve_adminq_command cmd;
+	__be32 *lut = NULL;
+	u8 *key = NULL;
+	int err = 0;
+	u16 i;
+
+	if (rss_config->hash_lut) {
+		lut_size = priv->rss_lut_size;
+		lut = dma_alloc_coherent(&priv->pdev->dev,
+					 lut_size * sizeof(*lut),
+					 &lut_bus, GFP_KERNEL);
+		if (!lut)
+			return -ENOMEM;
+
+		for (i = 0; i < priv->rss_lut_size; i++)
+			lut[i] = cpu_to_be32(rss_config->hash_lut[i]);
+	}
+
+	if (rss_config->hash_key) {
+		key_size = priv->rss_key_size;
+		key = dma_alloc_coherent(&priv->pdev->dev,
+					 key_size * sizeof(*key),
+					 &key_bus, GFP_KERNEL);
+		if (!key) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(key, rss_config->hash_key, priv->rss_key_size * sizeof(*key));
+	}
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_CONFIGURE_RSS);
+	cmd.configure_rss = (struct gve_adminq_configure_rss) {
+		.hash_types = cpu_to_be16(BIT(GVE_RSS_HASH_TCPV4) |
+					  BIT(GVE_RSS_HASH_UDPV4) |
+					  BIT(GVE_RSS_HASH_TCPV6) |
+					  BIT(GVE_RSS_HASH_UDPV6)),
+		.hash_alg = rss_config->hash_alg,
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
+				  priv->rss_lut_size * sizeof(*lut),
+				  lut, lut_bus);
+	if (key)
+		dma_free_coherent(&priv->pdev->dev,
+				  priv->rss_key_size * sizeof(*key),
+				  key, key_bus);
+	return err;
+}
+
 /* In the dma memory that the driver allocated for the device to query the flow rules, the device
  * will first write it with a struct of gve_query_flow_rules_descriptor. Next to it, the device
  * will write an array of rules or rule ids with the count that specified in the descriptor.
@@ -1357,3 +1428,63 @@ int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 sta
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
+
+static int gve_adminq_process_rss_query(struct gve_priv *priv,
+					struct gve_query_rss_descriptor *descriptor,
+					struct gve_rss_config *rss_config)
+{
+	u16 hash_key_length, hash_lut_length;
+	u32 total_memory_length;
+	void *rss_info_addr;
+	__be32 *lut;
+	u16 i;
+
+	total_memory_length = be32_to_cpu(descriptor->total_length);
+	hash_key_length = priv->rss_key_size * sizeof(*rss_config->hash_key);
+	hash_lut_length = priv->rss_lut_size * sizeof(*rss_config->hash_lut);
+
+	if (sizeof(*descriptor) + hash_key_length + hash_lut_length != total_memory_length) {
+		dev_err(&priv->dev->dev,
+			"rss query desc from device has invalid length parameter.\n");
+		return -EINVAL;
+	}
+
+	rss_config->hash_alg = descriptor->hash_alg;
+	rss_info_addr = (void *)(descriptor + 1);
+	memcpy(rss_config->hash_key, rss_info_addr, hash_key_length);
+
+	rss_info_addr += hash_key_length;
+	lut = (__be32 *)rss_info_addr;
+	for (i = 0; i < priv->rss_lut_size; i++)
+		rss_config->hash_lut[i] = be32_to_cpu(lut[i]);
+
+	return 0;
+}
+
+int gve_adminq_query_rss_config(struct gve_priv *priv, struct gve_rss_config *rss_config)
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
+	err = gve_adminq_process_rss_query(priv, descriptor, rss_config);
+
+out:
+	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
+	return err;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 7d9ef9a12fef..a4390b60f9fc 100644
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
+int gve_adminq_configure_rss(struct gve_priv *priv, struct gve_rss_config *config);
+int gve_adminq_query_rss_config(struct gve_priv *priv, struct gve_rss_config *config);
 
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 3480ff5c7ed6..0148274c0bbb 100644
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
@@ -838,6 +841,115 @@ static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u
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
+	struct gve_rss_config rss_config = {0};
+	u32 *indir = rxfh->indir;
+	u8 *hfunc = &rxfh->hfunc;
+	u8 *key = rxfh->key;
+	int err = 0;
+
+	if (!priv->rss_key_size || !priv->rss_lut_size)
+		return -EOPNOTSUPP;
+
+	rss_config.hash_key = kvcalloc(priv->rss_key_size,
+				       sizeof(*rss_config.hash_key), GFP_KERNEL);
+	if (!rss_config.hash_key)
+		return -ENOMEM;
+
+	rss_config.hash_lut = kvcalloc(priv->rss_lut_size,
+				       sizeof(*rss_config.hash_lut), GFP_KERNEL);
+	if (!rss_config.hash_lut) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = gve_adminq_query_rss_config(priv, &rss_config);
+	if (err)
+		goto out;
+
+	if (hfunc)
+		*hfunc = rss_config.hash_alg;
+
+	if (key)
+		memcpy(key, rss_config.hash_key, priv->rss_key_size);
+
+	if (indir)
+		memcpy(indir, rss_config.hash_lut,
+		       priv->rss_lut_size * sizeof(*rss_config.hash_lut));
+
+out:
+	kvfree(rss_config.hash_lut);
+	kvfree(rss_config.hash_key);
+	return err;
+}
+
+static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
+			struct netlink_ext_ack *extack)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+	struct gve_rss_config rss_config = {0};
+	u32 *indir = rxfh->indir;
+	u8 hfunc = rxfh->hfunc;
+	u8 *key = rxfh->key;
+	int err = 0;
+
+	if (!priv->rss_key_size || !priv->rss_lut_size)
+		return -EOPNOTSUPP;
+
+	switch (hfunc) {
+	case ETH_RSS_HASH_NO_CHANGE:
+		break;
+	case ETH_RSS_HASH_TOP:
+		rss_config.hash_alg = ETH_RSS_HASH_TOP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (key) {
+		rss_config.hash_key = kvcalloc(priv->rss_key_size,
+					       sizeof(*rss_config.hash_key), GFP_KERNEL);
+		if (!rss_config.hash_key)
+			return -ENOMEM;
+
+		memcpy(rss_config.hash_key, key, priv->rss_key_size * sizeof(*key));
+	}
+
+	if (indir) {
+		rss_config.hash_lut = kvcalloc(priv->rss_lut_size,
+					       sizeof(*rss_config.hash_lut), GFP_KERNEL);
+		if (!rss_config.hash_lut) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(rss_config.hash_lut, indir, priv->rss_lut_size * sizeof(*indir));
+	}
+
+	err = gve_adminq_configure_rss(priv, &rss_config);
+
+out:
+	kvfree(rss_config.hash_lut);
+	kvfree(rss_config.hash_key);
+	return err;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -851,6 +963,10 @@ const struct ethtool_ops gve_ethtool_ops = {
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
2.46.0.rc1.232.g9752f9e123-goog


