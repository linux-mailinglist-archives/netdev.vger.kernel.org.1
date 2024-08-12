Return-Path: <netdev+bounces-117864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025594F986
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B021F22AE1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD0197A7E;
	Mon, 12 Aug 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dh0nkoM1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C114A4DF
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501271; cv=none; b=NaMYrTLArlHjQKHWD9Llz/IkFOudHDieZlY4KRf64kPGk0ul7X+pSPwv5B1uDN2NkOwubAuAb9zmvMERJozuzAGPjVqrU9qK7PgSzxMKBjpJfATb+oWqVuqwYYyAbatrMgVAGMjZ+MYgX+xne84jCcZzs8tU3335ihtZh9Il/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501271; c=relaxed/simple;
	bh=dgjwV5zlV23JklHcX0bEVbu5QwINvAvwGtHUlusLedk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yeow1i4HQIGMLlRMT9i8EieBqkwUHRN9mNitvCvVw50G2YfT/sC9K2KpafkShgltee+pgIEVa5ZZIj9Vd2qmA8nkLa/Tj9eknSKbNiQR4V5mqrEs3BOOa9o+MrohtU+AdFsyv0MnCQI1gPIS5JcbfpE+sbNGe8w+p8OdxscBidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dh0nkoM1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-666010fb35cso76372327b3.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723501268; x=1724106068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1XAcsw1x953Wat59Xf2NEMXIYr0sReqdtvGGiRYfL0=;
        b=Dh0nkoM1Qppxl+wYp+yELceb/QOT+ZG7XKqwskoQK97ndK8DwByXG5efbtEMMzkqWm
         1Wj3xBuixpV54wQMXy/v0zyCHykgtXD+DICQCrz9/ZMYrydVEvn+u9uuelwPBHL50maW
         OG/ljew6Xbr2ro2B+26ht61PENen7dpXC1OaZVYIw0a2DM5mN3dU/ih7bA0JmxpWI3Wm
         baPxX8H6rUqF5kkQFNCJP/DGHWZvOef7SZLD0V+j80BZGh1lYG7yjIz9yL4noS9d4M72
         BqDnlpt6pe8aB0k5haS7urkHoVbllpxEw9uOFod+9orNuOlZFrwoz+B+hl0Bh49um6ZJ
         Um8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501268; x=1724106068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1XAcsw1x953Wat59Xf2NEMXIYr0sReqdtvGGiRYfL0=;
        b=IfgqEMxVNKpjTZQ2wwdjiJwB0XgRlG8LIiHlAmL0Fjr/xgBx9D5/SHaGNXdODk+CxT
         JCkuBmO324TokvBFQbGNhc0ZC3kIdU4ROsUjcI6unNNUbOfDZOs+DeqRQkQLEdcPU4qz
         RsxeLIJs2wmPiWTVKAhHqsySCiWoU6vtwDqWfVekH4AomJiQStetOQ2UgkVvOMemth49
         J5sJVKMB+PUOsw6+snU2rvu7Ge3bNFOUBCUAcvj+8gBUMRZQ2E8G/3Q+tbu/ehyxDsLY
         7TDNVtXLUsWrk6MlbirsygYZGZ8hOJzMMmvGCOfYXzIGaudAM/YdaIW4L6fu2huYJEJW
         78WA==
X-Gm-Message-State: AOJu0Yx7rgx0K3aMXBpOm5EfHsvCpphGtmg8Ok0Ozvu9q3+N9UeAH/Bz
	7Zh/j+r5QMpRIzZBZF5F2KLs/WrRqiCKL5lUkOKnOWrFYy0Khft91PBgRbral7ngOhoQ0Vq0HLx
	bDvpxwcqv0mDwr8sm2LDbn80NKwMhDbbQUgHdhfs6tjkZIwzSF2R6XQaAsRzLenR4XNGLO1SITx
	LNZpv8LqcdVnIkQQdp2zQQCLTCgngDE+ZZJ5DrKOQWKur+LqmyQd3VZ+kmpByNjsQ3
X-Google-Smtp-Source: AGHT+IF2Tlm5r6vRWo+WIZva+lEOyOrtgo08rZXSbAqOrNQqq8ihvUfvk43qKmtp08Cv/z5o3UmlRypCSDeT5L3OuuM=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:8c4a:afa1:7322:951c])
 (user=pkaligineedi job=sendgmr) by 2002:a0d:ed07:0:b0:6a9:5953:a652 with SMTP
 id 00721157ae682-6a9e77555c6mr254017b3.4.1723501267870; Mon, 12 Aug 2024
 15:21:07 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:20:12 -0700
In-Reply-To: <20240812222013.1503584-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812222013.1503584-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812222013.1503584-2-pkaligineedi@google.com>
Subject: [PATCH net-next v3 1/2] gve: Add RSS device option
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, jfraker@google.com, 
	Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

Add a device option to inform the driver about the hash key size and
hash table size used by the device. This information will be stored and
made available for RSS ethtool operations.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v2:
	- Unify the RSS argument order in related functions(Jakub Kicinski)

 drivers/net/ethernet/google/gve/gve.h        |  3 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 36 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h | 15 +++++++-
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 84ac004d3953..6c21f3c53619 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -831,6 +831,9 @@ struct gve_priv {
 	u32 num_flow_rules;
 
 	struct gve_flow_rules_cache flow_rules_cache;
+
+	u16 rss_key_size;
+	u16 rss_lut_size;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index c5bbc1b7524e..b5c801d2f8b5 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -45,6 +45,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
 			     struct gve_device_option_flow_steering **dev_op_flow_steering,
+			     struct gve_device_option_rss_config **dev_op_rss_config,
 			     struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
@@ -207,6 +208,23 @@ void gve_parse_device_option(struct gve_priv *priv,
 				 "Flow Steering");
 		*dev_op_flow_steering = (void *)(option + 1);
 		break;
+	case GVE_DEV_OPT_ID_RSS_CONFIG:
+		if (option_length < sizeof(**dev_op_rss_config) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "RSS config",
+				 (int)sizeof(**dev_op_rss_config),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_rss_config))
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				 "RSS config");
+		*dev_op_rss_config = (void *)(option + 1);
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -227,6 +245,7 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
 			   struct gve_device_option_flow_steering **dev_op_flow_steering,
+			   struct gve_device_option_rss_config **dev_op_rss_config,
 			   struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
@@ -249,7 +268,8 @@ gve_process_device_options(struct gve_priv *priv,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
 					dev_op_dqo_qpl, dev_op_buffer_sizes,
-					dev_op_flow_steering, dev_op_modify_ring);
+					dev_op_flow_steering, dev_op_rss_config,
+					dev_op_modify_ring);
 		dev_opt = next_opt;
 	}
 
@@ -867,6 +887,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  *dev_op_buffer_sizes,
 					  const struct gve_device_option_flow_steering
 					  *dev_op_flow_steering,
+					  const struct gve_device_option_rss_config
+					  *dev_op_rss_config,
 					  const struct gve_device_option_modify_ring
 					  *dev_op_modify_ring)
 {
@@ -931,6 +953,14 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 				 priv->max_flow_rules);
 		}
 	}
+
+	if (dev_op_rss_config &&
+	    (supported_features_mask & GVE_SUP_RSS_CONFIG_MASK)) {
+		priv->rss_key_size =
+			be16_to_cpu(dev_op_rss_config->hash_key_size);
+		priv->rss_lut_size =
+			be16_to_cpu(dev_op_rss_config->hash_lut_size);
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
@@ -939,6 +969,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
+	struct gve_device_option_rss_config *dev_op_rss_config = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
@@ -973,6 +1004,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
 					 &dev_op_buffer_sizes,
 					 &dev_op_flow_steering,
+					 &dev_op_rss_config,
 					 &dev_op_modify_ring);
 	if (err)
 		goto free_device_descriptor;
@@ -1035,7 +1067,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
 				      dev_op_buffer_sizes, dev_op_flow_steering,
-				      dev_op_modify_ring);
+				      dev_op_rss_config, dev_op_modify_ring);
 
 free_device_descriptor:
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index ed1370c9b197..7d9ef9a12fef 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -164,6 +164,14 @@ struct gve_device_option_flow_steering {
 
 static_assert(sizeof(struct gve_device_option_flow_steering) == 12);
 
+struct gve_device_option_rss_config {
+	__be32 supported_features_mask;
+	__be16 hash_key_size;
+	__be16 hash_lut_size;
+};
+
+static_assert(sizeof(struct gve_device_option_rss_config) == 8);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -182,6 +190,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
 	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
 	GVE_DEV_OPT_ID_FLOW_STEERING		= 0xb,
+	GVE_DEV_OPT_ID_RSS_CONFIG		= 0xe,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -194,6 +203,7 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG		= 0x0,
 };
 
 enum gve_sup_feature_mask {
@@ -201,6 +211,7 @@ enum gve_sup_feature_mask {
 	GVE_SUP_JUMBO_FRAMES_MASK	= 1 << 2,
 	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
 	GVE_SUP_FLOW_STEERING_MASK	= 1 << 5,
+	GVE_SUP_RSS_CONFIG_MASK		= 1 << 7,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
@@ -214,6 +225,7 @@ enum gve_driver_capbility {
 	gve_driver_capability_dqo_rda = 3,
 	gve_driver_capability_alt_miss_compl = 4,
 	gve_driver_capability_flexible_buffer_size = 5,
+	gve_driver_capability_flexible_rss_size = 6,
 };
 
 #define GVE_CAP1(a) BIT((int)a)
@@ -226,7 +238,8 @@ enum gve_driver_capbility {
 	 GVE_CAP1(gve_driver_capability_gqi_rda) | \
 	 GVE_CAP1(gve_driver_capability_dqo_rda) | \
 	 GVE_CAP1(gve_driver_capability_alt_miss_compl) | \
-	 GVE_CAP1(gve_driver_capability_flexible_buffer_size))
+	 GVE_CAP1(gve_driver_capability_flexible_buffer_size) | \
+	 GVE_CAP1(gve_driver_capability_flexible_rss_size))
 
 #define GVE_DRIVER_CAPABILITY_FLAGS2 0x0
 #define GVE_DRIVER_CAPABILITY_FLAGS3 0x0
-- 
2.46.0.76.ge559c4bf1a-goog


