Return-Path: <netdev+bounces-115179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E909455F1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243C0B2152D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A07FC11;
	Fri,  2 Aug 2024 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4MTF9Ic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009D17758
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562143; cv=none; b=Fp2c8vl2Tate/z+PZuG4Ixgy5ivd+q0GBKiW18mhnN5iO43MZwO6zrAE57nG+OqXtty5R64IhD2aNOWb9oXCYHUPSQWr8PaRlPise1HQEoUc7gvPj/Jw/S5ybYeSUJc6+ezHf2aZFDKa/ySWvBMES/FKitdnRzjxLGenly3Otrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562143; c=relaxed/simple;
	bh=xIwOwoAZFuu/Sv2D06iWczD5G7Z19QEqwpURoNG3oF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NP5OjxvmuLhmaXXKYcAzsS5Qvc3n3qaPKkrP38tn6lF9/upEKuIqg9Lm0fnDhFBFsSywUBwtv7/PtbS1+5tx2gZUM5jJmdoKWHZXBQegDFTy4Iz1eQi2cd7Kgq/+plAxCIu52BIjQtYvIp/VWBitd0MHCM63rFed+hc/BSlUENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4MTF9Ic; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664916e5b40so44202287b3.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722562141; x=1723166941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9x7bzNZaAdE5EiFg5zgyvqepOJXj9zosu6SyVl9Kvjw=;
        b=D4MTF9IcfwPVPCc6FotXoQ3H+oJhbDRnol9F3ZCTKy0Y5O4K3falE9pCNmG+om0Ugu
         2BQaBwmI1m5LU8ePVRmyNe1XZca0F/cM/Dzu+iUMuCSRqWOXG2QKUJyTsEwYitoaVhW9
         tpLwyObYZ6XAtPd6n3GCSnvaMfPW1Nf3yOCcz5lejA3z2TeX6khx8lWWD7htWA98GWyf
         muXAhnDONFgHzdSQBEXKNm18G3D5fOrA3p00eBLkmmFlLPL04J4dI4GoC2zGRKolG9k/
         8wfrXvZZEMtGK/ok1hfO4zN5NrJDngkxBN/UxfvgWkWmanw3TIgco/0Wlm4/EsCs6Ofk
         f/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722562141; x=1723166941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x7bzNZaAdE5EiFg5zgyvqepOJXj9zosu6SyVl9Kvjw=;
        b=c8ZfOXDDQsmS+AcBBIZ+n5lnze51o4YMwu0U79B8SDGmmqEd/7fpx42nognKun6wOT
         4a+8OBplJYCfFiHi27zNFSVhhq3d4KWr102BvO+jfcgvu7eTGBY+b3PPyD5JV+43A7uq
         CGMpJrEwSrTl2qOP+sz2mTqe2BQtthGC6z/pYs6/nxlWPr70tXEVMTc3L78hCr61gWyh
         ripo8O7wigX7BFUfvLle06h9mSdcwga2rlmjcgzyWalHUIMJ8XiO8RloxY4hWwiUFaGk
         Dkj/Orm+SGMBDZ1HWgQi5vmcm/iUOOmBjGuML7aRvz7ATrskZnGeNfISqQEeA3r46Ybs
         Ld7Q==
X-Gm-Message-State: AOJu0YyGTDaAXwTgcGFWx+fxI7B3O7CpSKgqCEV0QN2BbRmz0Pm3z1hr
	b/8rT9Rw+QrElCtM3i1DkpKqrcPVnXOwmwxLFaGM+Gx6SXt9QnMp8XXdCLPMKInjgz6/XkuReak
	clQ4OKa6FstuW9QBFtASUuv0152nz3y+GxtzY68g0OXrYfdbwk/EO4Fu2Y0M8/D2XE5Iwk2DIag
	9eantJxEUHkrtxyj/K+lYbGRf9ieZxb5IfkyeKyp8UWZ4jYwLpFHcgCknI4dGoadMN
X-Google-Smtp-Source: AGHT+IE2oOBwxIcXqFpYuW3ofg2zvDe41VE9/2FeV4fGzXdpZw8DzEUgO0FW6pFluEYYZRDUya9wpVn2VoYMAaaj76U=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:fe4c:233c:119c:cbea])
 (user=pkaligineedi job=sendgmr) by 2002:a05:690c:2901:b0:644:c4d6:add0 with
 SMTP id 00721157ae682-6884f7ffdfcmr240157b3.1.1722562140659; Thu, 01 Aug 2024
 18:29:00 -0700 (PDT)
Date: Thu,  1 Aug 2024 18:28:33 -0700
In-Reply-To: <20240802012834.1051452-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802012834.1051452-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802012834.1051452-2-pkaligineedi@google.com>
Subject: [PATCH net-next 1/2] gve: Add RSS device option
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
 drivers/net/ethernet/google/gve/gve.h        |  3 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 38 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h | 15 +++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

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
index c5bbc1b7524e..b0b7ef8a47d5 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -45,7 +45,8 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
 			     struct gve_device_option_flow_steering **dev_op_flow_steering,
-			     struct gve_device_option_modify_ring **dev_op_modify_ring)
+			     struct gve_device_option_modify_ring **dev_op_modify_ring,
+			     struct gve_device_option_rss_config **dev_op_rss_config)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
 	u16 option_length = be16_to_cpu(option->option_length);
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
+					dev_op_flow_steering, dev_op_modify_ring,
+					dev_op_rss_config);
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
2.46.0.rc1.232.g9752f9e123-goog


