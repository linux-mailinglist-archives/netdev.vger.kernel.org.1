Return-Path: <netdev+bounces-238530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28305C5A8BB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0BFE4E56E6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B361328B5E;
	Thu, 13 Nov 2025 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A61XuFFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC0328630
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076378; cv=none; b=VP305p2i1D/Vnw6gVtAPt6xVae0CgGZzoK6kegu2buH3RF60Q8nVTEGtY0gHzCglH/ozA8ttLiyOhDSQN7x8LzfTFsTjWlw9Huw9iYomUd6d5XV8LM38jSNAuQ5J7BrVjuNyr/vWM2uKL2ywSZmqEr8NXgIytwl+1AsouDOn9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076378; c=relaxed/simple;
	bh=s52FN6kZnvVR6k2YzgW8Df7RSitafE5fmZp21pzkkog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/tqI9suRb8Xjk0jov2IdWVY4p9BxsTdvPFM7llnVwM47SAlZ86n2OfDE6tXmqgJ8fvWNpkFJBpFXry+58P6aCoRGlt6WfdCPn4wajNW7apE53LnVkudyl1SBSK6lLJTHOyzYArt9wpnyix54qfEDqMH+k2gFtG+ZxDIgFP7J/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A61XuFFM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775ae77516so14972465e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763076374; x=1763681174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRZeUmOPXFyDZUBPpLy6olifz91y1yIEQNkQRF4A6eM=;
        b=A61XuFFMko4Y/+ofYf1Z6bKwuKs3U29XbdlTihlOL6Ss42JtbNMn0dRkhA3GUCZ9JO
         nDJLkwg25u5+upXwYIP7V5ufLGMowUAp1Vle+E4JI1UIl2oaU4ZnRvhROqW9U7ouNL+y
         QYgOJAdoUSjGb7+ZtlOas3TLJhxTnfRTQpWewFODcOLxz+8fSDF2HHSGMAMql/G5aspv
         2nbFbLmZETEbn55TwS+hqeAZPAOsuSy/vMynmv54yrurAbbb4vZTXu0HBjYKY2jBMKZr
         B5J1eBnxOidlFSjuIt5QdvHzyoNdyGJ2X/tmxqBy/V7fbtvi0KOuojE37VQKduN9VV6x
         majw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763076374; x=1763681174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRZeUmOPXFyDZUBPpLy6olifz91y1yIEQNkQRF4A6eM=;
        b=Ql5mVlC8lz6zDhUh5zbyArEbUwU8YOiziK0iWHd8eXUwwHAkZ7uhHHNIdxGafPQm+C
         3xoKIXs1EPkX7snMt8am+C2XnktgX5klJXMMYvLEhGbnfI2XSTaQ53ib7cwJAArqAMip
         oRYPWiLipfqge8B7SVDshMQ2dxHds4oX+y3AqdGCKaVWnpUPxmQ0j22fr7b9c54mqXnR
         Gga+GES1mV/AcgA+ruVC0AFxNWFDZ4Gx4h5am7hTmwUm1hWb2HCNoktuePDduF5U44YX
         XzSzFYErARpqmPhEPpkAraIHp9jCtvvAMPKvxD9zzW98RsDdH581I1KVoIqCsl0N0Qam
         2d0g==
X-Gm-Message-State: AOJu0YxIzvfJNUL76gIbg5KblnBw3dmGDrOIC8AcpPBCCCjJauMgl1Cf
	KpLVyVCKGnifhB8/pbDIDFXNZoXBSmu4gKcJLl6C9khmUaiDha+rNy6AUKHuvTIQ
X-Gm-Gg: ASbGncvPXYRFzZoT3kPqc4qPxzq73VRq0YSv3p2pN8QggR5lSCV63xODrjrAaLFCZln
	6hYprBhPqOep2lYIvCkzq97BcvtSlnuUn/Fo9XH1c8zUVbmqvDZ3yxbaSzYA/D17mDh9DF30ljO
	6RNj6sVztOW/YB19SkAL3ES4Avb4ArGF+Hy/VxPAXbZr3akmVatw4TfVpbUcmPlztbdZ8lmc3aY
	KYJjch3RrtMFYFgREMIIPN9+ri5gFP8YjHThVgPpwNeohN3pjPeETDIDo7llR0AdBQeoF5szp4f
	tPsOmXExL0DaDX/MHbjpqXbjKJLQsdpPR3PN9OCMpmsxf6k9Dahh6wUJ8SQ7srepDr4q7vhLZ0f
	pOkKIfUaHwVZMiPhH3Yrj0TnEG0S31KiS5m68T/OCYDn9SwOs6tc+76RgNC7S73foI0h23nLl
X-Google-Smtp-Source: AGHT+IFJ7mKysKsKOPwh7ai0stwsOyGRvHm+SxtTPB2Sd02mJGzCNzOAllBD3b8C4HAyiXZqFffnMQ==
X-Received: by 2002:a05:600c:4695:b0:477:7b9a:bb1b with SMTP id 5b1f17b1804b1-4778fea681fmr11438215e9.32.1763076374096;
        Thu, 13 Nov 2025 15:26:14 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm6254002f8f.9.2025.11.13.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 15:26:13 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	almasrymina@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk
Subject: [PATCH net-next V2] eth: fbnic: Configure RDE settings for pause frame
Date: Thu, 13 Nov 2025 15:26:10 -0800
Message-ID: <20251113232610.1151712-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic supports pause frames. When pause frames are enabled presumably
user expects lossless operation from the NIC. Make sure we configure
RDE (Rx DMA Engine) to DROP_NEVER mode to avoid discards due to delays
in fetching Rx descriptors from the host.

While at it enable DROP_NEVER when NIC only has a single queue
configured. In this case the NIC acts as a FIFO so there's no risk
of head-of-line blocking other queues by making RDE wait. If pause
is disabled this just moves the packet loss from the DMA engine to
the Rx buffer.

Remove redundant call to fbnic_config_drop_mode_rcq(), introduced by
commit 0cb4c0a13723 ("eth: fbnic: Implement Rx queue
alloc/start/stop/free"). This call does not add value as
fbnic_enable_rcq(), which is called immediately afterward, already
handles this.

Although we do not support autoneg at this time, preserve tx_pause in
.mac_link_up instead of fbnic_phylink_get_pauseparam()

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
Changelog:
- Move preserving tx_pause from fbnic_phylink_set_pauseparam() to .mac_link_up

V1: https://lore.kernel.org/netdev/20251112180427.2904990-1-mohsin.bashr@gmail.com/
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  2 ++
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 26 ++++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index b0a87c57910f..e6ca23a9957d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -73,6 +73,8 @@ struct fbnic_net {
 
 	/* Time stamping filter config */
 	struct kernel_hwtstamp_config hwtstamp_config;
+
+	bool tx_pause;
 };
 
 int __fbnic_open(struct fbnic_net *fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 7ce3fdd25282..62701923cfe9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -208,6 +208,9 @@ fbnic_phylink_mac_link_up(struct phylink_config *config,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
 
+	fbn->tx_pause = tx_pause;
+	fbnic_config_drop_mode(fbn, tx_pause);
+
 	fbd->mac->link_up(fbd, tx_pause, rx_pause);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 57e18a68f5d2..c2d7b67fec28 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2574,11 +2574,15 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 }
 
 static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
-				       struct fbnic_ring *rcq)
+				       struct fbnic_ring *rcq, bool tx_pause)
 {
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 drop_mode, rcq_ctl;
 
-	drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+	if (!tx_pause && fbn->num_rx_queues > 1)
+		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+	else
+		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
 
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
@@ -2588,6 +2592,21 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause)
+{
+	int i, t;
+
+	for (i = 0; i < fbn->num_napi; i++) {
+		struct fbnic_napi_vector *nv = fbn->napi[i];
+
+		for (t = 0; t < nv->rxt_count; t++) {
+			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
+
+			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, tx_pause);
+		}
+	}
+}
+
 static void fbnic_config_rim_threshold(struct fbnic_ring *rcq, u16 nv_idx, u32 rx_desc)
 {
 	u32 threshold;
@@ -2637,7 +2656,7 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	u32 hds_thresh = fbn->hds_thresh;
 	u32 rcq_ctl = 0;
 
-	fbnic_config_drop_mode_rcq(nv, rcq);
+	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause);
 
 	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
 	 * be split at L4. It would also result in the frames being split at
@@ -2700,7 +2719,6 @@ static void __fbnic_nv_enable(struct fbnic_napi_vector *nv)
 						  &nv->napi);
 
 		fbnic_enable_bdq(&qt->sub0, &qt->sub1);
-		fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
 		fbnic_enable_rcq(nv, &qt->cmpl);
 	}
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index ca37da5a0b17..27776e844e29 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -184,6 +184,7 @@ void fbnic_reset_netif_queues(struct fbnic_net *fbn);
 irqreturn_t fbnic_msix_clean_rings(int irq, void *data);
 void fbnic_napi_enable(struct fbnic_net *fbn);
 void fbnic_napi_disable(struct fbnic_net *fbn);
+void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause);
 void fbnic_enable(struct fbnic_net *fbn);
 void fbnic_disable(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
-- 
2.47.3


