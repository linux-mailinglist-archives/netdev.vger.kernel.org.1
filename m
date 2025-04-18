Return-Path: <netdev+bounces-184241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463BBA93FBB
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A97F8A3DD3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C024E4A8;
	Fri, 18 Apr 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIQ9O0Kj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549352417D9
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014381; cv=none; b=MBWhaGpGKtFApMcA0DIs35ac+fZ0lgvtIrJIt1Mx25pHRyKAyffCSAEyhzmRd9qfpNBTeEUTIB2oDwx6UNOjRBTxp6HsjbaNluSCyr1xrPbAQAirZ/WJzpoJdOIOZ5wcxcz5OjkFhR9XV9U84O4gXPLSI6/TkM8GzG95C/Gk3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014381; c=relaxed/simple;
	bh=ItWFSCVDbjxxVUZUdvpMtsCSDAT9b50ItavV7xjaUHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fXzhXS7dF/qH9ki0+SIkGxE2rPgEG/0neFTRu2fJHdQ32Us1zDIIjjMP3j3YRY8xtXslpsGeL2j0SubREFtAB0RuoxRi+wNpUBhqWuYLecTfr+TbuEuFzbhAkSE6afggbB5w9+5B+pCJGkvftmhCkA8E4WbwSbN3ta0kUxXZ6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIQ9O0Kj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224364f2492so19813975ad.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745014379; x=1745619179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yrivYcHNx6L4G6taXJ33jFMolvklY6KDAaHH12BE9E=;
        b=xIQ9O0Kj6TKfjgeNdo4lXLL8wNWMyUYP0AIumWibvd3CqDArRfXk28VKuV0bchZ/nI
         mdOiDAFv7bpPwvk9tYopcmapDIFk/46d3u6vDg9VP82ht0rrJdwnhrmEL3jY95LUx1c9
         Nx3/CyB2t3o61FBUUxO9Rvb6xQZnnrIE7aU7bH9nP2FXUNfbA+708QU08PIqpcztBaa9
         Rir5JIDD7L8R/A6KCs+GX561CBArI5wdZ8EAUyHhpd9Mmlkx3Rsd+Fstqf4Zyrl4CoW9
         upDWFUPokvCl2iXr5L6cjJw+iVm7RQoQjTYzkjAV4+Z7HK56Xc2MfNnP0/ZOBJjzhNu7
         041A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014379; x=1745619179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yrivYcHNx6L4G6taXJ33jFMolvklY6KDAaHH12BE9E=;
        b=bWb1RrfjZ/EBS/NUMXY3ECPSrbC/bQnFNSdukytXwybPEw97c3xxcT+zHo2lMsH1gW
         BIxoVZwt/e+/H+hfwlGdMAfInBvfAkNOtPojJy5wJm5t73g6ytnVBVTvylcvjbC7I3mS
         xYBFY/gE2eavWmn7cXS6edyYApY8mD1fz8PcKbjTmoilNO8tOtye35e/6XqrSzVHjZpW
         Q0IFMCtL/tqtRfEJ1SwW0iLBEOkkV7ISgco3+sqCglC0pXQzLw4XUOTfx8aPlP/aqKZs
         x0WQ3TeNTodkueFoHPz4mwXUM8LPVPMDdqE34JsN+PFy9xU4F0dKjftANxL7+WH4AwhA
         UQAQ==
X-Gm-Message-State: AOJu0YzY8IO7LfHPW3N5ZYUGa2eCNxbo1vAn/v4LGYNj9uJS+qlBwZA1
	XPsxELynSigaPhQSz6GVNCt5SJpgPM6QG5VxS3aI2rasEURgpkLCrtCBOVPVSQvg+YOXI5wTjz7
	rzzuU6UGFlBK1efiMMYZCXmxTrJ+L3ycZuTVO6xyt8OgtbHWRfn3DRFdNHWXkBLPF3rQ9Sfquim
	Kb4Y6Woi9T62suKcJKu+PDHdWpG0i9u10kfV0KnOU4pZ6PnaoTHXZ+1CGzXHQ=
X-Google-Smtp-Source: AGHT+IGgyWTDkf3U+r308vvbDy0CEDYuFNiZtlUp3pJH2R34QleHuKL3B+DestSlhl9Dm/fDOVTumOX7Nb2QaeZaWQ==
X-Received: from pfbhq10.prod.google.com ([2002:a05:6a00:680a:b0:73c:257c:fd5f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:287:b0:223:faf5:c82 with SMTP id d9443c01a7336-22c5337a067mr51930565ad.8.1745014379565;
 Fri, 18 Apr 2025 15:12:59 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:12:49 +0000
In-Reply-To: <20250418221254.112433-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418221254.112433-2-hramamurthy@google.com>
Subject: [PATCH net-next 1/6] gve: Add device option for nic clock synchronization
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Rogers <jefrogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

This patch adds the device option and negotiation with the device for
clock synchronization with the nic. This option is necessary before the
driver will advertise support for hardware timestamping or other related
features.

Co-developed-by: Jeff Rogers <jefrogers@google.com>
Signed-off-by: Jeff Rogers <jefrogers@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
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
2.49.0.805.g082f7c87e0-goog


