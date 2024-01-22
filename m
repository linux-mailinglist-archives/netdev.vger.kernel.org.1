Return-Path: <netdev+bounces-64772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9183715B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3AD291E37
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C684EB2F;
	Mon, 22 Jan 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1A6tPhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB594E1D8
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948038; cv=none; b=aip8pi4f6QuYHlLlweQZBvFKAFhXUHaWRuGFgo1/7GtNpDufrEJj6iaovC19I4RfixvPP+M68UFgzmkYBN76lmPfVA0lCRVu1kNd1gFt7QuJe24JSsLddrzLb9brwP3/DhQy7CkRzU5PHhspCvyEGUVy7ie+K0kptNDmP9bV6wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948038; c=relaxed/simple;
	bh=sPf3mycb6RY8IyzINb597l9tzKNCJy5eZVlBIyZSsZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2evOg2JrItdgK9N5Hp4PBx/MMD2b10JsN2L90ksdVGewql8EzO7ACzlR9WMa0+AVjjPskh4gFze1r2qxBJqEc0wRpnbyKpJhjf4C7ku2p4RgqY3LQmewBlpSS2cTvXceba9g613gBIyCTKA2tSaA9d2L5me+DmPm92U5E484XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1A6tPhE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so1282579276.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705948036; x=1706552836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1mFMGUtcMeHcpNS7KvYStwC+KPwCUVfqYIGCF0vLyQ=;
        b=p1A6tPhEudAx8RdZp7AONId3Gfj+REcEYczxTWaJo1Z2eWGPSnW/vGse0FSNAsKL6G
         vivjjd+PLwI3YIgxuti+DH274ftvBMQ/pHXs4eN8WDN75aFIN8Bg8rXsjoDM51IJ6lyZ
         OpnqUMZtV2rYYkpObM48poXc0L/yPgKzBkN2JdJxMLk2xE40sjG+x7A0/orW9kahKAub
         V9u6WSkpKpkdruXKgW4NRB7uSG9sYHdisUQLFwN2Ov1og9RRIq+XHFxjrWeCavredraG
         EOM9FVe4BABJQlw1QHaK34RgKhou0HbMdYzKzlEUjfm4klPSvzzTzu6y2WavFtk0Gji1
         6zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948036; x=1706552836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1mFMGUtcMeHcpNS7KvYStwC+KPwCUVfqYIGCF0vLyQ=;
        b=P40qjq6SR3Od8wmWnk7S3YTfSCkmYbuVaT0UKR3yI0gbHFIKBIppXTu2tbiVk7gVsW
         QO9+uUqhU+cWLpbrPZZuXlBwn8OrAQcUr+6aitaHrN7x8CT/lUNyJo6f1YGAXimExEmX
         xoVsrGNqpKpxghUfp4FH1iosIK7e/YCh9O8nhvJBk+f0SfAAEA/DXoGUQlGjukKLNVcX
         62yGG2kO6wmiUpd8scUq/+QFTbt2ZVW2LE8uSRJGD/QlPnK0D3tx6k5a/kiTaTvGHHdN
         M99pbagMXruhGLgYA6niykPbMsR/4YVPPf7jBJRzqTlQD203xG5wYPouu68qlV4xt9NF
         HaZg==
X-Gm-Message-State: AOJu0YxbIMXmt93/AavMxKtBaEmHisIF00raVJnPKEfbAuBwXCo0x5zo
	p70lC+TEXBHXOlqreZ60xaeAmhFeYXa/fk3VFMHkwiYTnLdARXV1cjWDZeGZvRpbh4lcJOLlvGG
	574H58tuNXx1w2pNM5F3FigVpdNbVgB5VXqkX7Zdb810KF3tEe5l/6RU9F1pO3bzMvNiP8/kByd
	3KDSCN6o5hl2tM6um4gUg+6lyfdZtuxhhwbGeFzF0QKZs=
X-Google-Smtp-Source: AGHT+IFmLUg86t3IArsUmQXgslvksmN6u50KeZiAelsNGBFTGnmpp6Kt8S+ellDuf/0i1kWs2KGQqIw7oIqCFg==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:cec4:0:b0:dc2:1cd6:346e with SMTP id
 x187-20020a25cec4000000b00dc21cd6346emr2349540ybe.8.1705948036101; Mon, 22
 Jan 2024 10:27:16 -0800 (PST)
Date: Mon, 22 Jan 2024 18:26:28 +0000
In-Reply-To: <20240122182632.1102721-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122182632.1102721-1-shailend@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122182632.1102721-3-shailend@google.com>
Subject: [PATCH net-next 2/6] gve: Refactor napi add and remove functions
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

This change makes the napi poll functions non-static and moves the
gve_(add|remove)_napi functions to gve_utils.c, to make possible future
"start queue" hooks in the datapath files.

Signed-off-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h       |  3 +++
 drivers/net/ethernet/google/gve/gve_dqo.h   |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c  | 20 +++-----------------
 drivers/net/ethernet/google/gve/gve_utils.c | 15 +++++++++++++++
 drivers/net/ethernet/google/gve/gve_utils.h |  3 +++
 5 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 00e7f8b06d89..ba6819ac600e 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1085,6 +1085,9 @@ static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
 	return gve_xdp_tx_queue_id(priv, 0);
 }
 
+/* gqi napi handler defined in gve_main.c */
+int gve_napi_poll(struct napi_struct *napi, int budget);
+
 /* buffers */
 int gve_alloc_page(struct gve_priv *priv, struct device *dev,
 		   struct page **page, dma_addr_t *dma,
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index c36b93f0de15..8058b09f8e3e 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -93,4 +93,6 @@ gve_set_itr_coalesce_usecs_dqo(struct gve_priv *priv,
 	gve_write_irq_doorbell_dqo(priv, block,
 				   gve_setup_itr_interval_dqo(usecs));
 }
+
+int gve_napi_poll_dqo(struct napi_struct *napi, int budget);
 #endif /* _GVE_DQO_H_ */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 619bf63ec935..e07048cd249e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -22,6 +22,7 @@
 #include "gve_dqo.h"
 #include "gve_adminq.h"
 #include "gve_register.h"
+#include "gve_utils.h"
 
 #define GVE_DEFAULT_RX_COPYBREAK	(256)
 
@@ -252,7 +253,7 @@ static irqreturn_t gve_intr_dqo(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int gve_napi_poll(struct napi_struct *napi, int budget)
+int gve_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct gve_notify_block *block;
 	__be32 __iomem *irq_doorbell;
@@ -302,7 +303,7 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
+int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 {
 	struct gve_notify_block *block =
 		container_of(napi, struct gve_notify_block, napi);
@@ -581,21 +582,6 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	gve_clear_device_resources_ok(priv);
 }
 
-static void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
-			 int (*gve_poll)(struct napi_struct *, int))
-{
-	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
-
-	netif_napi_add(priv->dev, &block->napi, gve_poll);
-}
-
-static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
-{
-	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
-
-	netif_napi_del(&block->napi);
-}
-
 static int gve_register_xdp_qpls(struct gve_priv *priv)
 {
 	int start_id;
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 26e08d753270..974a75623789 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -81,3 +81,18 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 		page_ref_add(page_info->page, INT_MAX - pagecount);
 	}
 }
+
+void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
+		  int (*gve_poll)(struct napi_struct *, int))
+{
+	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
+
+	netif_napi_add(priv->dev, &block->napi, gve_poll);
+}
+
+void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
+{
+	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
+
+	netif_napi_del(&block->napi);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index 324fd98a6112..924516e9eaae 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -23,5 +23,8 @@ struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 /* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
 
+void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
+		  int (*gve_poll)(struct napi_struct *, int));
+void gve_remove_napi(struct gve_priv *priv, int ntfy_idx);
 #endif /* _GVE_UTILS_H */
 
-- 
2.43.0.429.g432eaa2c6b-goog


