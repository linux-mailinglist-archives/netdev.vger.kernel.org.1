Return-Path: <netdev+bounces-103050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA8906149
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B682831B9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66D839FC;
	Thu, 13 Jun 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKv7Ntd8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BA81721
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243282; cv=none; b=n7H/Ii3jtOMA3KdijV+LixAxrzv4UfZVFoD+mmhyaGoFdTiC9bgmMDVEDQLCHYu681DiTaR2hESEk8/XBCd+smKabtX1Prum/T4b7cjMwBwYEuF5zeIsus0V0R+SHMnwcSNZv4c/gugufgpDPecXYEPSk0lRDlzWENrCRYgYOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243282; c=relaxed/simple;
	bh=gh0HQuZAngvZfzLE1wR/GMROqBRDnjLW9HbkbDIqD18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dZGum/sEQa7BcBxF8m48oixFWRctPpDLM5+21YADhZXeTIDWO79A1I+hZoWb8C5481jvGeWZ/m+C56T5TgrefEzROgWN+UemwYwYmd0ZmXqS03lPbmV/p34gFVWkX0EFaoWt0fEZG2j3sWM7BKAdrnScuRsVFPjKIThWKpJTOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKv7Ntd8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df771b5e942so725580276.2
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718243279; x=1718848079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnYZp09xUmUjNmmV7+APJyr9ngUCpcMdPhPqR97z/us=;
        b=ZKv7Ntd8cyOKzcotjfnU72qyr078GCEnMu7fLMxZI0xg5GtzHLVyzwIljpfDdrNcsS
         h7nv2EyK33SNzl7YCnNAOkxdzmtcNfb6KvOI575w0hH+MpyU13M3f/4aNt8HLEODVXH9
         oEbvGBHjpbDImuGmr0FXdNAAGBLZRQZUe6Ld8o6kjZGbR3ZFM6ENDmZ4fAwrY7KJbdW0
         1QqPf3wNkvXtkLF3ZJpl34haeWLa1WeO7Vv+o/e9XrW0nee/BXcd7oAQlzAcEllTN9Gw
         FvVd2QNRq52lxcwkZABLAB46+jBwvHH0Vfg3Mywl824mq4uXubokfpa8yhODpBDzhe/p
         iD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243279; x=1718848079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnYZp09xUmUjNmmV7+APJyr9ngUCpcMdPhPqR97z/us=;
        b=p68SKbG4NNEZh5vF4339l/wdEU8f/MpTQWpGISb7q9mDj4FCCQKUOCJ9ODqLwBaTiw
         2GJLrVwHAWcM7r+D3GeSOk3qbxq25IhJVxTDxOImvs0PGGt07H6ZVQ0y6pl3qUj09iEz
         ssLfooH0YCriuuveLrNDn7KRmIrfnleTlrzDX9ZvmhPN4UzYauSI71a137mNQKSDlp8s
         v67b0o+7FALETsgfKEEl9wHXffvG7x3OAl19GUHTwz6RfiLZLuKCIa6jJqQWCuFMO+FA
         ZE7h/8yHXsFzHnOcc6LAO+BfL0uR3SLSBmuUPbwUl9IsiS/Qobl13OM36RlOdnUelI1w
         81Fg==
X-Gm-Message-State: AOJu0Yy9yWSeH2//uKTnYpN+IILkUNiB9WFH653OU17/Zp1OKtuMtOT3
	GMBRGP+JT+ateR5/YYXMVvt8WrGPDQybz2Djo9c7L+ll5j7B49xY38s38rCkxnha8eKEynTaEkx
	TB/conxGucTzoIosYpXPtW6ebuqZeNPTVyE2WDEtWA7jHlLerMr9GyPbBLQKXwFJNqD6h9QtTf2
	EBrl7G5gxPm0YvXMYOYrPeBLJaUrbeBvFK62PXFo3XkIauuJh+
X-Google-Smtp-Source: AGHT+IFi9eo010l/FCDdQl/heF3deioeTlWOz0m/vJrf43OpjvjIgD7rIYXGGpbxarFlDXL3+9RE43zTq5dAP8M=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:1108:b0:df4:8ecb:ae57 with SMTP
 id 3f1490d57ef6-dfe68142daamr273783276.10.1718243279053; Wed, 12 Jun 2024
 18:47:59 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:47:42 +0000
In-Reply-To: <20240613014744.1370943-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613014744.1370943-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613014744.1370943-4-ziweixiao@google.com>
Subject: [PATCH net-next v2 3/5] gve: Add flow steering device option
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Add a new device option to signal to the driver that the device supports
flow steering. This device option also carries the maximum number of
flow steering rules that the device can store.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 42 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h | 11 +++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ca7fce17f2c0..58213c15e084 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -786,6 +786,8 @@ struct gve_priv {
 
 	u16 header_buf_size; /* device configured, header-split supported if non-zero */
 	bool header_split_enabled; /* True if the header split is enabled by the user */
+
+	u32 max_flow_rules;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 5b54ce369eb2..7481661df72d 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -44,6 +44,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
 			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
+			     struct gve_device_option_flow_steering **dev_op_flow_steering,
 			     struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
@@ -189,6 +190,23 @@ void gve_parse_device_option(struct gve_priv *priv,
 		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
 			priv->default_min_ring_size = true;
 		break;
+	case GVE_DEV_OPT_ID_FLOW_STEERING:
+		if (option_length < sizeof(**dev_op_flow_steering) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "Flow Steering",
+				 (int)sizeof(**dev_op_flow_steering),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_flow_steering))
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				 "Flow Steering");
+		*dev_op_flow_steering = (void *)(option + 1);
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -208,6 +226,7 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
 			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
+			   struct gve_device_option_flow_steering **dev_op_flow_steering,
 			   struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
@@ -230,7 +249,7 @@ gve_process_device_options(struct gve_priv *priv,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
 					dev_op_dqo_qpl, dev_op_buffer_sizes,
-					dev_op_modify_ring);
+					dev_op_flow_steering, dev_op_modify_ring);
 		dev_opt = next_opt;
 	}
 
@@ -838,6 +857,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  *dev_op_dqo_qpl,
 					  const struct gve_device_option_buffer_sizes
 					  *dev_op_buffer_sizes,
+					  const struct gve_device_option_flow_steering
+					  *dev_op_flow_steering,
 					  const struct gve_device_option_modify_ring
 					  *dev_op_modify_ring)
 {
@@ -890,10 +911,22 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			priv->min_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
 		}
 	}
+
+	if (dev_op_flow_steering &&
+	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
+		if (dev_op_flow_steering->max_flow_rules) {
+			priv->max_flow_rules =
+				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
+			dev_info(&priv->pdev->dev,
+				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
+				 priv->max_flow_rules);
+		}
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
 {
+	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
 	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
@@ -930,6 +963,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
 					 &dev_op_buffer_sizes,
+					 &dev_op_flow_steering,
 					 &dev_op_modify_ring);
 	if (err)
 		goto free_device_descriptor;
@@ -969,9 +1003,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	/* set default descriptor counts */
 	gve_set_default_desc_cnt(priv, descriptor);
 
-	/* DQO supports LRO. */
 	if (!gve_is_gqi(priv))
-		priv->dev->hw_features |= NETIF_F_LRO;
+		priv->dev->hw_features |= NETIF_F_LRO | NETIF_F_NTUPLE;
 
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
@@ -991,7 +1024,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
-				      dev_op_buffer_sizes, dev_op_modify_ring);
+				      dev_op_buffer_sizes, dev_op_flow_steering,
+				      dev_op_modify_ring);
 
 free_device_descriptor:
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e0370ace8397..e64a0e72e781 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -146,6 +146,14 @@ struct gve_device_option_modify_ring {
 
 static_assert(sizeof(struct gve_device_option_modify_ring) == 12);
 
+struct gve_device_option_flow_steering {
+	__be32 supported_features_mask;
+	__be32 reserved;
+	__be32 max_flow_rules;
+};
+
+static_assert(sizeof(struct gve_device_option_flow_steering) == 12);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -163,6 +171,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_DQO_QPL			= 0x7,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
 	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
+	GVE_DEV_OPT_ID_FLOW_STEERING		= 0xb,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -174,12 +183,14 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING		= 0x0,
 };
 
 enum gve_sup_feature_mask {
 	GVE_SUP_MODIFY_RING_MASK	= 1 << 0,
 	GVE_SUP_JUMBO_FRAMES_MASK	= 1 << 2,
 	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
+	GVE_SUP_FLOW_STEERING_MASK	= 1 << 5,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
-- 
2.45.2.627.g7a2c4fd464-goog


