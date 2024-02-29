Return-Path: <netdev+bounces-76361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2417286D615
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1D628AEEB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2316FF5B;
	Thu, 29 Feb 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFkuWX1s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891F16FF58
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241825; cv=none; b=ednpbfnJJoJQYgSqRb8jvlz/+hFYhyxsneeOSBOvmHNEVK8m78YMH+kZuom3DUYSfkKPgG1rxN1cAn/U97kvnmOQUTlpxO8OqEi213EAf/NGfBhCL3UBMw49Ifeu6NLiElilHMoBTvCd982xMlEagcnFzggeNf/9fZhfdwaxyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241825; c=relaxed/simple;
	bh=m0DOK2OvkQRSX7AzySErtR+aXRrKWap5v5cgIEElomo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HT/VtPTgY8cAh3pR70W7iMrYEEyPn4NKoLaDtvkzXq+a/helDSWKIL3wdTmSO/V8Xb4OcJ3KGdcxFvR0yGsx4wWJE1jhnBOcV4PHYqxIr6vHZCJeu4mZC0ubCpcvzvm3QUToqcn/bdNeQfp9SlJn5coea1I4RjxHfX725XmlxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFkuWX1s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2995baae8b4so1211272a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709241823; x=1709846623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8qmDvwC15IGXRa5Pi6idDC6aBrAS3VuKlnExrEFlW8=;
        b=BFkuWX1sXU7/7he8BTVmiASdkM8VUOTwEY8e+EN3GWpfBPaUJ8r/s1YUvqP7Jds9rR
         DTl7aVuma2CSuDivW6zza6HVeowQnDTHs8/cyPV4+VkCuJFXDagTQFmaXrgMxXVRqjF4
         T9Ha3nyNfuhm8CkRomUOOZHE03x4L0+KGBNjrdsJN487Nk8fXf/062oyz8zrsf0taJ+t
         Du66Y/hu1yQgnz1UtrXLAuv4C06dWDQI1JzvXQtV7bSa1VDkuXdZOy4/TGD2R4mBeTwE
         82lAbxLrNJCc73HY8B7hVcG87A8kelKEpsUImV3sACfNPATl0TpIj0vQjsY4F9UrcHze
         nKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241823; x=1709846623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8qmDvwC15IGXRa5Pi6idDC6aBrAS3VuKlnExrEFlW8=;
        b=HMv/cyV2R3F6dblBPZVQ/D5/fF8m80u3MhJBATIG9xeaxkHdKTgl4+9pwlgmjZ+Aq0
         21mIc7oFWAmOLtNSRocSzbaJSgNhYH8A1/SIFbyLDtDTpd5Ix6dBmwrq7efOATvziWcg
         xaWhG6wJhvhrmBWT89I9LYItanLaH6GhP/YjXaozE0K2nMxSSJvkEbrrmFXPvXUeiksQ
         CpxTqCDrcJMPbtXzs2cG0Q2WuRCtTyvMO5OSgCG62dN1fraWQg9CP4Ww2iN5ctLTxLSn
         KX6FJWcrflizhGAkMCDHoXOsO7NZYZKEmyNlUgDkK965X7CsJFZ1FAv+vgqDnXbBjHPf
         R++w==
X-Gm-Message-State: AOJu0YyMfklXEPbOud7HLiGI60gQIdTHADcPRhk3/NlquzU3c/NXlCt/
	48NoByyu/eWz8grBp5pifuMzzUM/z+61/cTIcn/F/qhllE9YFuUaOquSewwmRkCozp7mK+dp24U
	QGhN5LTYYo71iwtv4+cKw7oilYVmpsmfq7ygWK1mQ5/osx1Mwp5FzREfAOm/srWFziVBeAsdD/B
	npXY7JilKTluumDAZYUTvDQzRmoYTh7E+atpxdYOl5p/V88EDI
X-Google-Smtp-Source: AGHT+IFUrxw1rIroiBKlZkXIYVa24d/JnhcsZ0NrnJ6iLNEVVV3mPIf6w1UbRBVyTXqJq9H94dZNpYiTsWev74o=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:43b5:fdf3:8395:a655])
 (user=ziweixiao job=sendgmr) by 2002:a17:90b:38c7:b0:299:58b0:a4be with SMTP
 id nn7-20020a17090b38c700b0029958b0a4bemr626pjb.8.1709241822240; Thu, 29 Feb
 2024 13:23:42 -0800 (PST)
Date: Thu, 29 Feb 2024 13:22:34 -0800
In-Reply-To: <20240229212236.3152897-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229212236.3152897-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229212236.3152897-2-ziweixiao@google.com>
Subject: [PATCH net-next 1/3] gve: Add header split device option
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, jrkim@google.com, 
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

To enable header split via ethtool, we first need to query the device to
get the max rx buffer size and header buffer size. Add a device option
to get these values and store them in the driver. If the header buffer
size received from the device is non-zero, it means header split is
supported in the device.

Currently the max rx buffer size will only be used when header split is
enabled which will set the data_buffer_size_dqo to be the max rx buffer
size. Also change the data_buffer_size_dqo from int to u16 since we are
modifying it and making it to be consistent with max_rx_buffer_size.

Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  9 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c | 47 +++++++++++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.h | 20 ++++++++-
 drivers/net/ethernet/google/gve/gve_main.c   |  8 +---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  2 +-
 5 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index fd290f3ad6ec..5305404516fc 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -51,12 +51,16 @@
 
 #define GVE_DEFAULT_RX_BUFFER_SIZE 2048
 
+#define GVE_MAX_RX_BUFFER_SIZE 4096
+
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
 
 #define GVE_XDP_ACTIONS 5
 
 #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
 
+#define GVE_DEFAULT_HEADER_BUFFER_SIZE 128
+
 #define DQO_QPL_DEFAULT_TX_PAGES 512
 #define DQO_QPL_DEFAULT_RX_PAGES 2048
 
@@ -778,13 +782,16 @@ struct gve_priv {
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Must be a power of two. */
-	int data_buffer_size_dqo;
+	u16 data_buffer_size_dqo;
+	u16 max_rx_buffer_size; /* device limit */
 
 	enum gve_queue_format queue_format;
 
 	/* Interrupt coalescing settings */
 	u32 tx_coalesce_usecs;
 	u32 rx_coalesce_usecs;
+
+	u16 header_buf_size; /* device configured, header-split supported if non-zero */
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 12fbd723ecc6..e2c27bbb56e6 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -40,7 +40,8 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
-			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
+			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
+			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
 	u16 option_length = be16_to_cpu(option->option_length);
@@ -147,6 +148,23 @@ void gve_parse_device_option(struct gve_priv *priv,
 		}
 		*dev_op_jumbo_frames = (void *)(option + 1);
 		break;
+	case GVE_DEV_OPT_ID_BUFFER_SIZES:
+		if (option_length < sizeof(**dev_op_buffer_sizes) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "Buffer Sizes",
+				 (int)sizeof(**dev_op_buffer_sizes),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_buffer_sizes))
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				 "Buffer Sizes");
+		*dev_op_buffer_sizes = (void *)(option + 1);
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -164,7 +182,8 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
-			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
+			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
+			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
 	struct gve_device_option *dev_opt;
@@ -185,7 +204,7 @@ gve_process_device_options(struct gve_priv *priv,
 		gve_parse_device_option(priv, descriptor, dev_opt,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
-					dev_op_dqo_qpl);
+					dev_op_dqo_qpl, dev_op_buffer_sizes);
 		dev_opt = next_opt;
 	}
 
@@ -755,7 +774,9 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  const struct gve_device_option_jumbo_frames
 					  *dev_op_jumbo_frames,
 					  const struct gve_device_option_dqo_qpl
-					  *dev_op_dqo_qpl)
+					  *dev_op_dqo_qpl,
+					  const struct gve_device_option_buffer_sizes
+					  *dev_op_buffer_sizes)
 {
 	/* Before control reaches this point, the page-size-capped max MTU from
 	 * the gve_device_descriptor field has already been stored in
@@ -779,10 +800,22 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		if (priv->rx_pages_per_qpl == 0)
 			priv->rx_pages_per_qpl = DQO_QPL_DEFAULT_RX_PAGES;
 	}
+
+	if (dev_op_buffer_sizes &&
+	    (supported_features_mask & GVE_SUP_BUFFER_SIZES_MASK)) {
+		priv->max_rx_buffer_size =
+			be16_to_cpu(dev_op_buffer_sizes->packet_buffer_size);
+		priv->header_buf_size =
+			be16_to_cpu(dev_op_buffer_sizes->header_buffer_size);
+		dev_info(&priv->pdev->dev,
+			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
+			 priv->max_rx_buffer_size, priv->header_buf_size);
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
 {
+	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
@@ -816,7 +849,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	err = gve_process_device_options(priv, descriptor, &dev_op_gqi_rda,
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_jumbo_frames,
-					 &dev_op_dqo_qpl);
+					 &dev_op_dqo_qpl,
+					 &dev_op_buffer_sizes);
 	if (err)
 		goto free_device_descriptor;
 
@@ -885,7 +919,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
-				      dev_op_jumbo_frames, dev_op_dqo_qpl);
+				      dev_op_jumbo_frames, dev_op_dqo_qpl,
+				      dev_op_buffer_sizes);
 
 free_device_descriptor:
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 5865ccdccbd0..5ac972e45ff8 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -125,6 +125,15 @@ struct gve_device_option_jumbo_frames {
 
 static_assert(sizeof(struct gve_device_option_jumbo_frames) == 8);
 
+struct gve_device_option_buffer_sizes {
+	/* GVE_SUP_BUFFER_SIZES_MASK bit should be set */
+	__be32 supported_features_mask;
+	__be16 packet_buffer_size;
+	__be16 header_buffer_size;
+};
+
+static_assert(sizeof(struct gve_device_option_buffer_sizes) == 8);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -140,6 +149,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_DQO_RDA = 0x4,
 	GVE_DEV_OPT_ID_DQO_QPL = 0x7,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
+	GVE_DEV_OPT_ID_BUFFER_SIZES = 0xa,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -149,10 +159,12 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL = 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES = 0x0,
 };
 
 enum gve_sup_feature_mask {
 	GVE_SUP_JUMBO_FRAMES_MASK = 1 << 2,
+	GVE_SUP_BUFFER_SIZES_MASK = 1 << 4,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
@@ -165,6 +177,7 @@ enum gve_driver_capbility {
 	gve_driver_capability_dqo_qpl = 2, /* reserved for future use */
 	gve_driver_capability_dqo_rda = 3,
 	gve_driver_capability_alt_miss_compl = 4,
+	gve_driver_capability_flexible_buffer_size = 5,
 };
 
 #define GVE_CAP1(a) BIT((int)a)
@@ -176,7 +189,8 @@ enum gve_driver_capbility {
 	(GVE_CAP1(gve_driver_capability_gqi_qpl) | \
 	 GVE_CAP1(gve_driver_capability_gqi_rda) | \
 	 GVE_CAP1(gve_driver_capability_dqo_rda) | \
-	 GVE_CAP1(gve_driver_capability_alt_miss_compl))
+	 GVE_CAP1(gve_driver_capability_alt_miss_compl) | \
+	 GVE_CAP1(gve_driver_capability_flexible_buffer_size))
 
 #define GVE_DRIVER_CAPABILITY_FLAGS2 0x0
 #define GVE_DRIVER_CAPABILITY_FLAGS3 0x0
@@ -260,7 +274,9 @@ struct gve_adminq_create_rx_queue {
 	__be16 packet_buffer_size;
 	__be16 rx_buff_ring_size;
 	u8 enable_rsc;
-	u8 padding[5];
+	u8 padding1;
+	__be16 header_buffer_size;
+	u8 padding2[2];
 };
 
 static_assert(sizeof(struct gve_adminq_create_rx_queue) == 56);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index db6d9ae7cd78..02d12aa50885 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1448,12 +1448,6 @@ static int gve_queues_start(struct gve_priv *priv,
 	if (err)
 		goto reset;
 
-	if (!gve_is_gqi(priv)) {
-		/* Hard code this for now. This may be tuned in the future for
-		 * performance.
-		 */
-		priv->data_buffer_size_dqo = GVE_DEFAULT_RX_BUFFER_SIZE;
-	}
 	err = gve_create_rings(priv);
 	if (err)
 		goto reset;
@@ -2511,6 +2505,8 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->service_task_flags = 0x0;
 	priv->state_flags = 0x0;
 	priv->ethtool_flags = 0x0;
+	priv->data_buffer_size_dqo = GVE_DEFAULT_RX_BUFFER_SIZE;
+	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 
 	gve_set_probe_in_progress(priv);
 	priv->gve_wq = alloc_ordered_workqueue("gve", 0);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8e6aeb5b3ed4..c3ce819ee5ab 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -458,7 +458,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 				struct gve_rx_buf_state_dqo *buf_state)
 {
-	const int data_buffer_size = priv->data_buffer_size_dqo;
+	const u16 data_buffer_size = priv->data_buffer_size_dqo;
 	int pagecount;
 
 	/* Can't reuse if we only fit one buffer per page */
-- 
2.44.0.rc1.240.g4c46232300-goog


