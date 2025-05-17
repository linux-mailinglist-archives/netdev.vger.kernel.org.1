Return-Path: <netdev+bounces-191230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1883ABA724
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ABA16ED1D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9CC4B1E7D;
	Sat, 17 May 2025 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B66/8Qa7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB31876
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440683; cv=none; b=pvj4WaCBAxTbV0Su6dlUFcIznqy8RHfuKO1vWd0Lp6ImrWAoJEwcCNqAPaZCONvYz+ygvKlg9/psrGOg0eJJaeWcohOFxrMsrK5I0oNXIQiSPJFa/BvCRRegUTRC7SF/4mj1uq75nEBjGw4M6pPp/8uFk3fESSzf3lhYBVZ2NC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440683; c=relaxed/simple;
	bh=mOmbj+5vSH7IyrCyn8tyERKZSDH4D2zlgi/NZ8vo9X4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jPFL0a6I+pAT1KKRAxAnwrrE9IB0Nx4qYakiTerGjN4JCErfNQEZYww4ovwwFUfTPsRdZ6AWk4uww5geyqO68FcjSiHoS+Zzyl+4MEmxeq8XW/Syls8XPZZgG1GyPrZUH2up2bN7VFNS+898Zg1ZSSZtwvv+ahe3HKhhGqoSVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B66/8Qa7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7425fc3357aso3427178b3a.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747440681; x=1748045481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCb7mTxdjxlA9jLhrMDPySv3BcuUTjIV604os16Gf6s=;
        b=B66/8Qa7kIEHQcX+miaFIYOCstuAdbP7t+PW7XITsL4s8tBvXhZrfF8PoOvykKzFVr
         7b0v/LmufC0MtOzibXsStRPqXlpVgBa175kA4UscE5rQhm/KnUQCDv2ohGp5bq1Oykbf
         aIKjDyLeKIYvy6oHaIAY3fQyyr9PK6h0OezBj6zcG9dCDkeWbEufwN7n1f1VGjZp49qa
         5ZAQCB6mp4sbzOS8yQTwJvTpMI9VIY9g19zdP5Ptz0MIOWv+VCjSfrEZeRdU6e7jn82z
         U+Sk0d76hpO/CVOJ/4vP0k/8bgiVRBIW1SE6wT8ze6YW+wvgUfSvCCviuhOQNQEFvhRM
         2U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440681; x=1748045481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCb7mTxdjxlA9jLhrMDPySv3BcuUTjIV604os16Gf6s=;
        b=P7cY0qel0C8gCf1GI75UXoIRLhAFC3Kqd2NR+f5M0dNYXNv30hyZGdscw0xxh0+WzN
         awAtF3ReaLuKqczRGv1vpO/bRFGTIOMe67cvkWxwTvNLm0/wmeLWw3cdHcy7/0WTPre7
         tvYfd+X0wxdXlcINBlU6Vr+HPQ376ukhqZrJNAmvhHKrqzS4DCYmREiJ1ecnDhb6KF0m
         VUXJgRk3ozyCPkrj842rPnCGqOgcSsFB6octFJIh6TzIY1obd+16e0ZHuA8U3W8sFuGW
         ry2wH+e13NmcUWgERRcm5A+BESodBT50OUHfgt4iQdRUn9MT7fAS/gMPhOi2MDGTCW+n
         M+Fg==
X-Gm-Message-State: AOJu0YxiDS6F7afOjn/y3tWWGgBKTD7MuN9SCgsbgMpUcMqBdRQKISG1
	2RbYavrVpB0LUPUg1vfyU2awPBI7GHDbtgJIJjLH8vuKGCqQXdiZLNHVPnuKlAsq3+aZjgdUgMG
	LPO6xrwTHjt9ChbTj5mlkCqP6kysewWD0pS5yvtHwGjtriyaHirCUcSSn1OSor+mk7INI6vhlfg
	SI35klXUBDx0u70DjQGmCxYzuLrdJLnJf50lLbQKSmX8BmFMcbgqM2ipRlFp0r5to=
X-Google-Smtp-Source: AGHT+IFnPhEgf3hMGnVk5nE76nyxCVm/1wiYowX1QO4lFUbgADc8p1obHBrFOxFLV/uRrdKWvRiUBaeW7Jncmma6Og==
X-Received: from pfblr29.prod.google.com ([2002:a05:6a00:739d:b0:742:925f:bdf7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2442:b0:742:a91d:b2f5 with SMTP id d2e1a72fcca58-742a97f2372mr7197918b3a.13.1747440680893;
 Fri, 16 May 2025 17:11:20 -0700 (PDT)
Date: Sat, 17 May 2025 00:11:03 +0000
In-Reply-To: <20250517001110.183077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517001110.183077-2-hramamurthy@google.com>
Subject: [PATCH net-next v2 1/8] gve: Add device option for nic clock synchronization
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Rogers <jefrogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Add the device option and negotiation with the device for clock
synchronization with the nic. This option is necessary before the driver
will advertise support for hardware timestamping or other related
features.

Signed-off-by: Jeff Rogers <jefrogers@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  3 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 31 +++++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h |  9 ++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 2fab38c8ee78..e9b2c1394b1f 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -870,6 +870,9 @@ struct gve_priv {
 	u16 rss_lut_size;
 	bool cache_rss_config;
 	struct gve_rss_config rss_config;
+
+	/* True if the device supports reading the nic clock */
+	bool nic_timestamp_supported;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3e8fc33cc11f..ae20d2f7e6e1 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -46,6 +46,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
 			     struct gve_device_option_flow_steering **dev_op_flow_steering,
 			     struct gve_device_option_rss_config **dev_op_rss_config,
+			     struct gve_device_option_nic_timestamp **dev_op_nic_timestamp,
 			     struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
@@ -225,6 +226,23 @@ void gve_parse_device_option(struct gve_priv *priv,
 				 "RSS config");
 		*dev_op_rss_config = (void *)(option + 1);
 		break;
+	case GVE_DEV_OPT_ID_NIC_TIMESTAMP:
+		if (option_length < sizeof(**dev_op_nic_timestamp) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "Nic Timestamp",
+				 (int)sizeof(**dev_op_nic_timestamp),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_nic_timestamp))
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				 "Nic Timestamp");
+		*dev_op_nic_timestamp = (void *)(option + 1);
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -246,6 +264,7 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
 			   struct gve_device_option_flow_steering **dev_op_flow_steering,
 			   struct gve_device_option_rss_config **dev_op_rss_config,
+			   struct gve_device_option_nic_timestamp **dev_op_nic_timestamp,
 			   struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
@@ -269,6 +288,7 @@ gve_process_device_options(struct gve_priv *priv,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
 					dev_op_dqo_qpl, dev_op_buffer_sizes,
 					dev_op_flow_steering, dev_op_rss_config,
+					dev_op_nic_timestamp,
 					dev_op_modify_ring);
 		dev_opt = next_opt;
 	}
@@ -904,6 +924,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  *dev_op_flow_steering,
 					  const struct gve_device_option_rss_config
 					  *dev_op_rss_config,
+					  const struct gve_device_option_nic_timestamp
+					  *dev_op_nic_timestamp,
 					  const struct gve_device_option_modify_ring
 					  *dev_op_modify_ring)
 {
@@ -980,10 +1002,15 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			"RSS device option enabled with key size of %u, lut size of %u.\n",
 			priv->rss_key_size, priv->rss_lut_size);
 	}
+
+	if (dev_op_nic_timestamp &&
+	    (supported_features_mask & GVE_SUP_NIC_TIMESTAMP_MASK))
+		priv->nic_timestamp_supported = true;
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
 {
+	struct gve_device_option_nic_timestamp *dev_op_nic_timestamp = NULL;
 	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
 	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
@@ -1024,6 +1051,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_buffer_sizes,
 					 &dev_op_flow_steering,
 					 &dev_op_rss_config,
+					 &dev_op_nic_timestamp,
 					 &dev_op_modify_ring);
 	if (err)
 		goto free_device_descriptor;
@@ -1088,7 +1116,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
 				      dev_op_buffer_sizes, dev_op_flow_steering,
-				      dev_op_rss_config, dev_op_modify_ring);
+				      dev_op_rss_config, dev_op_nic_timestamp,
+				      dev_op_modify_ring);
 
 free_device_descriptor:
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 228217458275..42466ee640f1 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -174,6 +174,12 @@ struct gve_device_option_rss_config {
 
 static_assert(sizeof(struct gve_device_option_rss_config) == 8);
 
+struct gve_device_option_nic_timestamp {
+	__be32 supported_features_mask;
+};
+
+static_assert(sizeof(struct gve_device_option_nic_timestamp) == 4);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -192,6 +198,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
 	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
 	GVE_DEV_OPT_ID_FLOW_STEERING		= 0xb,
+	GVE_DEV_OPT_ID_NIC_TIMESTAMP		= 0xd,
 	GVE_DEV_OPT_ID_RSS_CONFIG		= 0xe,
 };
 
@@ -206,6 +213,7 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP		= 0x0,
 };
 
 enum gve_sup_feature_mask {
@@ -214,6 +222,7 @@ enum gve_sup_feature_mask {
 	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
 	GVE_SUP_FLOW_STEERING_MASK	= 1 << 5,
 	GVE_SUP_RSS_CONFIG_MASK		= 1 << 7,
+	GVE_SUP_NIC_TIMESTAMP_MASK	= 1 << 8,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
-- 
2.49.0.1112.g889b7c5bd8-goog


