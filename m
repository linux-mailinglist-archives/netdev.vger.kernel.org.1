Return-Path: <netdev+bounces-106293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D9D915ADE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DBD283651
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF218B04;
	Tue, 25 Jun 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3R/Ln7lz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9B179A8
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274366; cv=none; b=C8htst/2jx+H+rahOtCvCB2BiiGc9T90nFuqvMYnIlNppd3gIOI4s/iEI4Nvk7u6NaU2IbHFPO95HKCxaOCTnvjMd9JsgE9HYvdG9W0luaH1ZvMHOmNVjswIvIO/UhPBMcUecKIAwqjqmb2jeXHpCm36I1NZ6XvHhhhhEmlCf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274366; c=relaxed/simple;
	bh=MmVEsjXBcmLv3ahy7KCRgQ1UaitYYNC1aL/kmKXydJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVcJSCNYMVyu8kDF98L0Mrz03c1lpJmN+GqSfHQX+9Zx6k8IhKsjfe/ewBSroul1zVUa4cRBkI032O8MGp6T8A5vH9Ho0o4xgelHnkMvA9ig5rxxtjQ5XiEDBZv+XzYwKP/wMcHInNLyULM1h4mRRhXlkJ6q03uPs5NfE6JfAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3R/Ln7lz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e023e936ac4so10174716276.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274364; x=1719879164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UF/LA5l49cCSyY/ORl++ES/NB8h3whhttxPN3Oux0qU=;
        b=3R/Ln7lz4voUV8X74oG/QO5/8XXShKe6VDvWrk3ZAvmuy0/lnHn2XI9XpfmEb39tCG
         XB5XO2N90jZNcfBy3Bxn5PfDmuWpCFNOxlNFXalgdcUSaaZR3ND+gXwzqEwuTX+kWgfc
         fs2UrqbtGzhtnmqjUCoOqjPj82lvKKxS13UFOdawCZSoHyBxuDX5wlW8AB5gkUwXulvK
         qNTLot+SFX43FILyd4ULobrr0lC9KVb3r2kmsC/XjEnJmxLBJvZnJpqLUZRF6Ua7vjID
         6AF1ZaUIA2NJZNN1avIJaPic8i1mRxUGBU01yuqrMQpDJ1hvWXhLKdtbaF8KKQcRdish
         8idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274364; x=1719879164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UF/LA5l49cCSyY/ORl++ES/NB8h3whhttxPN3Oux0qU=;
        b=qzjrChhMMmMAhoVYVHOnYaRy7QODC27QFgdbEJ87CAAvKyAOFDlDriZKHtMa8XK+21
         clwkbgQAoyq/jcZ373TAHfABxRIHn6zErj9aJC0tHuGAQXV+zqwbRsh8IaGzaIIMzCur
         IgCASe8oaTSccuqF5fuywDxLPvh6anEtXjb7/FbJ82LP8xxBOaITGBnFca+WieFddOAE
         Y6jDoOMWq40jlLwweuXsnNzbOWTYMJpvjFh28iOYfPduLj35f0AAVs3gjYG3YqIvS7rN
         jqwFhgCLinL4H1nak3PpBGwnOmG1N2Z4BSXwZhcgwrIiZcGVjowJ2LgXtJ5wmM5YsDs9
         ASCA==
X-Gm-Message-State: AOJu0YwPWKF6Cs/60Jsm7KA2ObExW3NlsOfW8qe7DdCWL81fKNXpW57Q
	ILI9GndRzs6KZy+V+4hqWSJVhgxcaIz7+2W62eVPxz7w1dKlT7vsb/fSAriys0nI8gGMn+3dA+K
	lShJzhg+PAikk9k5j7/ltp33M/Gmqd89CHTyIhyYOFYzyELnXuf5UAeyngKl9AckJcPGRsnJ0Om
	5ySlTU5XhUYhRcMdj5+4K/IpYlNogasLQN8W3lb1HJRGR2vujO
X-Google-Smtp-Source: AGHT+IEjts80TGjeNg9PqdjcZ5WlTd1WyKlXNuVsz0sNbeNZhg0p7d3HFilnAbDL/fQFqvFR4brINgPRKmkP9AY=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:3625:0:b0:dfd:d6ec:4e3b with SMTP id
 3f1490d57ef6-e0303f2b228mr65305276.7.1719274363172; Mon, 24 Jun 2024 17:12:43
 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:29 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-4-ziweixiao@google.com>
Subject: [PATCH net-next v3 3/5] gve: Add flow steering device option
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
Changes in v3:
	- Move the `priv->dev->hw_features |= NETIF_F_NTUPLE;` to where
	  flow steering is supported when receiving the valid flow
	  steering device option(Jakub Kicinski)

 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 40 +++++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h | 11 ++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

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
index 5b54ce369eb2..088f543f0ba8 100644
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
@@ -890,10 +911,23 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			priv->min_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
 		}
 	}
+
+	if (dev_op_flow_steering &&
+	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
+		if (dev_op_flow_steering->max_flow_rules) {
+			priv->max_flow_rules =
+				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
+			priv->dev->hw_features |= NETIF_F_NTUPLE;
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
@@ -930,6 +964,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
 					 &dev_op_buffer_sizes,
+					 &dev_op_flow_steering,
 					 &dev_op_modify_ring);
 	if (err)
 		goto free_device_descriptor;
@@ -991,7 +1026,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
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
2.45.2.741.gdbec12cfda-goog


