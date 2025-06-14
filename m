Return-Path: <netdev+bounces-197674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF495AD98E4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B90189E852
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593653FFD;
	Sat, 14 Jun 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMLRXheB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5917F7
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859682; cv=none; b=bc0S5uRgltWxjT2ZdGLf/sn2eiXQ7ZO65PYWyh44noawLlB18DE0MHCh1oRnnaWZP9x6XY2nGIOpYQgYwsAwZqGvEfg8+vmyjuTp76skWlV//PQUqkO+kMA3EjuJie43EN3J5b0g5jvMBtv5RbUHP1M2uJoIf1UOp5TfuAl3Z2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859682; c=relaxed/simple;
	bh=P+r33BM95lXvy3aHPCffH0ckZbdssMqAaDe419PJDcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kI9/ehwjsPU6f0k+7N9mnrTDZPQxiQni6EL9LROWaOpuXwxAK20yohDeF78M0kG+5AgJOSrWX7c9TnFooFVQ0TKAkf3vKPfb9q2XCibvDKHsdplUczJa/CikZ+T/6dhnzq3iqodRleoUe68hnBsb8uhTER37D60OSV1ifqGx5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMLRXheB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311f4f2e761so2488818a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859680; x=1750464480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn8hjzPb35igu4zEY7kLsSMXrtnd3322tmgcv2Zk8OA=;
        b=lMLRXheB1/Tj6mL80FEVkmr0VHTX7ZIsNmqXmidf/t7bZBCkm/PhcIrvIomnWr+oPy
         y6iOlvaCs2uXcWBZdkQuo9KUHwmpkirKvFBfsnSEt5XHSO7glQ1ISBJzQfrQEj6TgWKj
         lo3CQwDFqHplNFlI8A1TxdTUgyBLELwti/uSMFsuyWSbxQnO0492ELL2t+vXie7KnLF3
         HDh4F4GC4T1KSaA4D86pYuya2BRrdqqO0rViDHSqfD+MQD/XaRjPY5Nx2RnxIf7mZoHW
         63AtN8nP+gBwFvOKYbBx8kL7UYfuUhhwE/SDC3vDj2t7V3axOX8/H9t9kYiCc4dfE+5w
         D3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859680; x=1750464480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pn8hjzPb35igu4zEY7kLsSMXrtnd3322tmgcv2Zk8OA=;
        b=Q/d+KdZIWmEM+hJxLmG2qhw/HjIxNNVJDrgh8CAputAkplQsqzYvLkBmYJzqDxJCxN
         t04iFvmmDwDz6I0AF8zMrIguBF8Yq/CNc4YuD3UCkRHUeUimcZZbEvZUlsFquFE/TVnO
         BOHsKI6hSNZpxih2lxdvuXP/BEs+AWzLD8Uko0oZCxFVplkctHDrTY+JYsMEoXOooNx9
         8LrKuK1OCHpkU9g/1J+TKz7wASM3fvMqhoWSV2MlosGxx0v48Z2YKyj9fFxb1s6lvvaH
         E2VZJelA5+/Ch/S5dDLyqzDG2UdNNPR3cra71UUpbGzHpLmA7q44/Xo5XoPgaSn0nQx9
         dufg==
X-Gm-Message-State: AOJu0Yyi1Zbsv25xnuumxRCznepVGjBEcZ94tBDj7RS3JYeMqY2Nq+Zl
	VsNwemoecGVKgsXIePigp3Ws5ZOFDbGcjxUDW27rLv2YE1TJvAJtiJe70SFzRKDeXiUjpd3Q6oa
	LMc1CAn15WEgaIm+laIKB0mY3Q4Le4K5nf08X14wjhz2urLyxbRhZvY0GXaKvxhxnvKJ/rvyCWr
	iN2n6le6OjvLytKcfj9fG0m7JsBTN4RshWNNYc22UiBMwk5g9/qlXuXnozTTtRGAI=
X-Google-Smtp-Source: AGHT+IFPPqwo/ib/6iHhdFQpnYOxYX553xbEvMX3+/syUaWiG6Qt1e1ANWxkF+7vthtX/z2qDuwLmDKfPWjXPA9Lsg==
X-Received: from pjbhl8.prod.google.com ([2002:a17:90b:1348:b0:2fc:e37d:85dc])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:55d0:b0:311:e731:523a with SMTP id 98e67ed59e1d1-313f1c02fe1mr2411816a91.11.1749859679948;
 Fri, 13 Jun 2025 17:07:59 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:47 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-2-hramamurthy@google.com>
Subject: [PATCH net-next v5 1/8] gve: Add device option for nic clock synchronization
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
2.50.0.rc1.591.g9c95f17f64-goog


