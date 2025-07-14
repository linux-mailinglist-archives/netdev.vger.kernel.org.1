Return-Path: <netdev+bounces-206763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E6B04512
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54F51A63E72
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0648260562;
	Mon, 14 Jul 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdPHwRjw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0825EFBE
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509109; cv=none; b=glzVohBN9nP2KgB4LNcj8pkk2gVZR1W9XdxZgmRQgCviEwd/BNoE2LanGQFmQJw6xWoaTiGz/y5Gmuij55aaz0Izj2GJn6J7mqUr5VF2t9ML2yzU7n61Smb2OZpO+sciZ7mBjXDf4axFL4UO+sUgcWstnrtQJJIio9c43VbujQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509109; c=relaxed/simple;
	bh=Ul+lJparVW8g98jFj+bXmuD+92Vc2EjV8Aj6uFvEMko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yxw5O/nNaemDVxaH/IEmyzv8J+arZh68m1Yz/+Ln0HN4LkQgl6p470GUo+LaQc+MF8ADVfuFBcdAcYkTI+eCfMqrBATyGfT2zFxO5RnSXsKA0JIdQxn+SKXr/DnMT2tROGFPRJBZs4F4KJ54lwmqFi2lq8j6LbnBUsDkKjbulmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdPHwRjw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so4571145a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509107; x=1753113907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wR+0l+f1n4TdTGFevJn9Ubw6wlD96gT/Oev6hk6iwg=;
        b=MdPHwRjw132wWcYwA+XEPeC+gMG0eohd5pb852csu5KsAk7S+LvxrRMbOsPS8EInln
         iu4uPC+c1CMdtHd01X1kahNKikF+aej+GbapEjrRTpTO8eXsMyw25fvmzBXxMyp8CPVU
         wb6CMfLDu4ejArlSl86u12tpGoaSdgwIylINy4dubDxVuoJiHsqoNLS4vnsKHiofYSNz
         mDB5G5VLMWjJa0MyIP0P7IfIgFpWd9kz37JAEFDARytLar9v1eSzZPS9iV7E8EN1MOgc
         jvZZShqLGztXhIRac7ioNLByf1R0cE9+TyoR7D2/03Xg6R1piAdXADJaNfa9PftJ4CUn
         ZabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509107; x=1753113907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wR+0l+f1n4TdTGFevJn9Ubw6wlD96gT/Oev6hk6iwg=;
        b=UAEJ+ca70Ifl6242VJfKUYHysVVbdJvbihi//McUPW4LVNv0JqGh5c1rHzkUiJQ2XH
         A15bhbc3sYnZNofZzs3PHzRS4X4/HEajcaxRO27RdzGqcJ4E6CdU3ryqdV98Z2qHJpp4
         2R1xdfTLtMXZXB/qKexnHeCfHp3TnNTqu0SB6ZIolebz5xwihHvsgQG2UEf/uSP8Nh8x
         WAI9dAhkPZgZWpW5RuH25xfWGRX3h6W3HCc+hGYdLemR9BK/cgd7ALm/SnCotSB/yo6E
         a0sV+3Ium8JfgPtT0fW7t7Fv2GrFcof0E5JIVzFX0svawGT+10/tqScxOYx2GOTUmWIi
         Z11w==
X-Gm-Message-State: AOJu0YweeFY+lEb4aMEQ7WJ4OW1/kytItDJlBDqF0MuxYlVt4GAYUBYe
	8QnVGyJwQIE9Uuwkl7r6wFBbQ2GQk8kshNXpdROKuUqo/XjLUcepGe7Ae8G/JDGFZKznT3oUzDo
	eljeRNEU46j8cyAAwGzViZgGzNQg6KN1YnktnOSM1j0WoKKL2YhXIwUFARGxU5OINvCDKp1N/6M
	wweFoMk+kg4PFcy78l0VeZ+kqwUkZX6lLqIQWFk5eZqaZicew=
X-Google-Smtp-Source: AGHT+IFMq2pIhLVoEmWGHMkED8FwleRhlMGwT5rwJTc7NkspHBIcYmSLPJZotzVrKooPI8DVvFl3XFptCero1w==
X-Received: from pjz6.prod.google.com ([2002:a17:90b:56c6:b0:2ef:d283:5089])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:312:1ae9:1533 with SMTP id 98e67ed59e1d1-31c4ca67504mr18585127a91.1.1752509107535;
 Mon, 14 Jul 2025 09:05:07 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:04:48 -0700
In-Reply-To: <20250714160451.124671-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714160451.124671-1-jeroendb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714160451.124671-3-jeroendb@google.com>
Subject: [PATCH net-next 2/5] gve: merge xdp and xsk registration
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Joshua Washington <joshwash@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

The existence of both of these xdp_rxq and xsk_rxq is redundant. xdp_rxq
can be used in both the zero-copy mode and the copy mode case. XSK pool
memory model registration is prioritized over normal memory model
registration to ensure that memory model registration happens only once
per queue.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  1 -
 drivers/net/ethernet/google/gve/gve_main.c | 25 +++++++++-------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 53899096e89e..b2be3fca4125 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -331,7 +331,6 @@ struct gve_rx_ring {
 
 	/* XDP stuff */
 	struct xdp_rxq_info xdp_rxq;
-	struct xdp_rxq_info xsk_rxq;
 	struct xsk_buff_pool *xsk_pool;
 	struct page_frag_cache page_cache; /* Page cache to allocate XDP frames */
 };
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5aca3145e6ab..d2797f55ae7c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1167,8 +1167,8 @@ static void gve_unreg_xsk_pool(struct gve_priv *priv, u16 qid)
 
 	rx = &priv->rx[qid];
 	rx->xsk_pool = NULL;
-	if (xdp_rxq_info_is_reg(&rx->xsk_rxq))
-		xdp_rxq_info_unreg(&rx->xsk_rxq);
+	if (xdp_rxq_info_is_reg(&rx->xdp_rxq))
+		xdp_rxq_info_unreg_mem_model(&rx->xdp_rxq);
 
 	if (!priv->tx)
 		return;
@@ -1185,11 +1185,7 @@ static int gve_reg_xsk_pool(struct gve_priv *priv, struct net_device *dev,
 
 	rx = &priv->rx[qid];
 	napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
-	err = xdp_rxq_info_reg(&rx->xsk_rxq, dev, qid, napi->napi_id);
-	if (err)
-		return err;
-
-	err = xdp_rxq_info_reg_mem_model(&rx->xsk_rxq,
+	err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
 					 MEM_TYPE_XSK_BUFF_POOL, pool);
 	if (err) {
 		gve_unreg_xsk_pool(priv, qid);
@@ -1232,6 +1228,8 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 		return 0;
 
 	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
+		struct xsk_buff_pool *xsk_pool;
+
 		rx = &priv->rx[i];
 		napi = &priv->ntfy_blocks[rx->ntfy_id].napi;
 
@@ -1239,7 +1237,11 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 				       napi->napi_id);
 		if (err)
 			goto err;
-		if (gve_is_qpl(priv))
+
+		xsk_pool = xsk_get_pool_from_qid(dev, i);
+		if (xsk_pool)
+			err = gve_reg_xsk_pool(priv, dev, xsk_pool, i);
+		else if (gve_is_qpl(priv))
 			err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
 							 MEM_TYPE_PAGE_SHARED,
 							 NULL);
@@ -1249,13 +1251,6 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 							 rx->dqo.page_pool);
 		if (err)
 			goto err;
-		rx->xsk_pool = xsk_get_pool_from_qid(dev, i);
-		if (!rx->xsk_pool)
-			continue;
-
-		err = gve_reg_xsk_pool(priv, dev, rx->xsk_pool, i);
-		if (err)
-			goto err;
 	}
 	return 0;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


