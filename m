Return-Path: <netdev+bounces-94303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B228BF0DC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A32C1F21DA0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CBF138486;
	Tue,  7 May 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apkpJ7bh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FE137C41
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122841; cv=none; b=qXWTjfGWeK4rNsoDoOuVuNg8GcSpPKB3pLR3q1cf2zSyxOCC5ciUhTpv6tfT9dnh/GV+jCx/8OLS+Cm5yvUETQtq0KtBm82IeV80vuwEvlCkH1nQGitQjmQ0AN2OalRcIzsmLG4Ejp15qzkls56549CB5DRLDmMzfnNI6vR6qWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122841; c=relaxed/simple;
	bh=KeZsDpfjg4fkDLKYyRjiHJ3K9hAB8B5iQZNvvFpcmuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=urmp4fXyG/lrVfUBIBKUdJs0MhRtSXIafnMEeoB+GhUeLOWFCEVtiFA7OWYri6Bd5kumnUW+43Przz9WaoDgc/lhuqzqXm2345LQnsWi0wjXkUEHTvsvHVKVVkKeIdqMvbK31qjJkk5h1lEhGP4zlvFUF8cxLVyo8c810ND4NxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apkpJ7bh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bb09d8fecso67388807b3.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715122838; x=1715727638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXnPdU94aA87037a+0BxFlWOvSqs9PYhPyi24QbUuRY=;
        b=apkpJ7bhPGzkY87rVcN/lpNo1rNhlVA19qkVxWiptsph7CFq/Yk5EE/wfLTEIYNMkh
         Uf/0qekupgT0JTENSpXxdcC+QICCjQ1ciuicPO8N3Hw4Rg1rKQdbxfAtx3RmaPtgRk+S
         Fh1gVTNPp2Lq+7G9Hr3IVRkaH5dkmfLxzzAPNupKNAVMtLq2miHwJakAWQd6tDXLfdaN
         QIQsVqRounpnKoTxSOYARHgtd191pJdu+qK3Pqjxl4iDecNFJ+zNpgy8+TBRrGElS/4u
         AasBLxY7bkAGb2m7h/RJj+JH3Ji0jq5gaIncdX6PpScf4Rj6TRsWgYKXorE1otY8jYnZ
         JRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122838; x=1715727638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXnPdU94aA87037a+0BxFlWOvSqs9PYhPyi24QbUuRY=;
        b=gybE/c3udOMBIRAnVjCpa9X0Qnv//TY7Gssy5REa07tPcrjnaoM7nPSpXfn6VUR3/L
         zsTEq9q9zSyMc2vM4SiuAu2/cDl6fs8iqcHg601IdjgB7RwmA3Jd4PEnvZzKf2gQRM6S
         lcyH5p2ZCVmI0PRJQo6TorRiCgtJN+3xgPOzz7Fr2dZ4Turd9fzwN8yqGS5BDl+1xJrx
         TD+2WJWXZs6Qa+AwLaED3DMpQ5vPQq3u1XMGnoXCZn0ofz0OaNIQJAUmb78yil4PHYTC
         CgSD66szEhLmVV1eeem/o0L5Z9MdOnbk4TqWaEa2StFdsYb4m1TMTk9pi3CmH1ZzONTL
         PmRw==
X-Gm-Message-State: AOJu0YwY7v9D2GukBGyEV78Jicj2UgiaxkkIG8qVVsxWIIprakKJSFl9
	A4hezTNpOI705wmN94CL33hAJ0FfN4U5lm0uoBmX1Yg57ICJC5PY+kRpqPyhSu08IXS+Oj5wumf
	jgI3MO5bpXjUEqm0uqZ832WnnCf5S8hWhBZV7WlQy5XAJRur/h38l/sGK/cYCCiGo6sS3fmlfKf
	drcsMWxiXiiE0CqlD0SCeq+8k6AO1HhyFpssG8v2j9JSWSMInD
X-Google-Smtp-Source: AGHT+IGzCKQ58FIDrrek79xK7RMi6FEGG6enmakGDSgrqxx2MG5LqtgQktPivYcc2rX+1V0P7Y4exlKxHcHmtEM=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a81:4e83:0:b0:61b:1d66:61c4 with SMTP id
 00721157ae682-62085c83b68mr2735537b3.10.1715122838443; Tue, 07 May 2024
 16:00:38 -0700 (PDT)
Date: Tue,  7 May 2024 22:59:43 +0000
In-Reply-To: <20240507225945.1408516-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507225945.1408516-4-ziweixiao@google.com>
Subject: [PATCH net-next 3/5] gve: Add flow steering device option
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, rushilg@google.com, 
	ziweixiao@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
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
index 514641b3ccc7..85d0d742ad21 100644
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
2.45.0.rc1.225.g2a3ae87e7f-goog


