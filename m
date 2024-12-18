Return-Path: <netdev+bounces-152972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E359F6772
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE47E18976C5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152EC1F2C4C;
	Wed, 18 Dec 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfz5QjC+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608221E9B3B
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528876; cv=none; b=peoHf6leUHngOdIrS3qNKIQJsE1g5OTHqAGuFA7b5MMKL0kSu87rOdgdZYTwQdoLrpKXEobv1NBcD5/MnyQo6rPuSWxzBGF2vmWj6+Ny7fe8J2LqyCToMwlBJTcos0nRrIuvxWfjHB5RFYpFj1gglr0ZCkApGyusVzOpVULS8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528876; c=relaxed/simple;
	bh=5nW61vOKeFgt2Ca3diR0gPzoG2D8KLy0Ubznq3j8i3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qd+OJhnW79WVW7tBVthfIJaAdXjZpbS76nzzArLVhrkx0cKbG/ot1bEwK51FtsdDjEfJwLO4ptw9s7c0dXkD3srG+QtSzoun0i706/79VdCiste/LpmLatrzKI/GCx/iUl62+dzFUkHMJYBvTCKHLWEXHbfF45ggrExZ5IpgczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfz5QjC+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so6115474a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528873; x=1735133673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5p6vlUBAsmQyOt8BuyoWsG+1hipC/LRRSVT0CsAjCw=;
        b=xfz5QjC+/jESiv2uFvLF7rUuOSlvdU5UBtL8Zkt4O0ZXCoAZdgPaXDdijcxVsWITru
         HcmSIsWy80R71wgIMCGdjrJeeDRX++FLMrlmeZLjS4oHGnjYypKkni4/blLGJxCEInth
         eip0fZuoxqh/nDopdSQzPsdp6RGkqFaFCbft0UsNrXDW2rUIlNhg+a93nXNc22tB0WcE
         9UGJI/u/6mLWyg61qAA0Zv256zRIRNQtCTVHbg7/A6Gh0mtZ0KikFiDRi5++rsZC1SfX
         hsF4gs0h/yhycSJtQEg/bIWRs/ljOomEIPdn+IAuNv7FMUwJyP37DFdSwcBRpyd0FkU+
         LgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528873; x=1735133673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5p6vlUBAsmQyOt8BuyoWsG+1hipC/LRRSVT0CsAjCw=;
        b=Pd4ulfta90s5U/r2RoXkAuLC3mmyZY5fVmAFyuHTFoSl5pH1g+r0j9sDgO+TQsqo+X
         ozqz4Cog+0lA3I6j1RkqYEAmZPQUf858G5czHXu/SIzIXw+Tn3TFPDu64KLbqGcRgvzQ
         q2NUB2RipkxtPnSn7bwJabBO92yaZivBUhHrrHPO7FF0a6l404Z6WrLXTXomg46wEFFL
         1qXgnH4WrpaQJPzI9R2ci+YJLS3PZ0vhoDriStkAX/B3OfCtnHBBGPQ/sOaMEIKJbkoO
         eRB3ksi9fdWtmoPzHytD/sG1NlAif/YfQ+puVmEZLMFXc7DsOaFukjKJ8teWQC5kpJJZ
         yYZg==
X-Gm-Message-State: AOJu0YyGojA5xj06+PfqQJJJupXYkJhKK9v3occmjigVkipiNqqUxui9
	dyC6/YxeAmTJkdGHN3PB3JuSakWIirn44bzPHUze9DAnrs81WyvJ+r0KIlmJCh6LiU+WpG3WWbo
	i3dvAL1YJ5Q7WHF5s3D1saBzruifC/X3rKnQdlzVs/Ao9lfuI/TpGFXxJopYJZR1+cVfPumHU3L
	JwVvQt/rNDR6gwqQucAfe5HPvdeMKv/ELmcNFhtT0wCIDGdLJ1q4nymAFFRkhRYz8A
X-Google-Smtp-Source: AGHT+IESNBKLCTm0uqLX+DRFxTtWjk+95d5i9mTaDJzn1eicqwfkpRcGBjtCrRCjQo4wMO7Q8jBDvY0A+fhe0GGi+qI=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:2ee:4b69:50e1])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b8f:b0:2ee:df57:b194 with SMTP id 98e67ed59e1d1-2f2e91fef48mr3520473a91.21.1734528873500;
 Wed, 18 Dec 2024 05:34:33 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:15 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-6-pkaligineedi@google.com>
Subject: [PATCH net 5/5] gve: fix XDP allocation path in edge cases
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch fixes a number of consistency issues in the queue allocation
path related to XDP.

As it stands, the number of allocated XDP queues changes in three
different scenarios.
1) Adding an XDP program while the interface is up via
   gve_add_xdp_queues
2) Removing an XDP program while the interface is up via
   gve_remove_xdp_queues
3) After queues have been allocated and the old queue memory has been
   removed in gve_queues_start.

However, the requirement for the interface to be up for
gve_(add|remove)_xdp_queues to be called, in conjunction with the fact
that the number of queues stored in priv isn't updated until _after_ XDP
queues have been allocated in the normal queue allocation path means
that if an XDP program is added while the interface is down, XDP queues
won't be added until the _second_ if_up, not the first.

Given the expectation that the number of XDP queues is equal to the
number of RX queues, scenario (3) has another problematic implication.
When changing the number of queues while an XDP program is loaded, the
number of XDP queues must be updated as well, as there is logic in the
driver (gve_xdp_tx_queue_id()) which relies on every RX queue having a
corresponding XDP TX queue. However, the number of XDP queues stored in
priv would not be updated until _after_ a close/open leading to a
mismatch in the number of XDP queues reported vs the number of XDP
queues which actually exist after the queue count update completes.

This patch remedies these issues by doing the following:
1) The allocation config getter function is set up to retrieve the
   _expected_ number of XDP queues to allocate instead of relying
   on the value stored in `priv` which is only updated once the queues
   have been allocated.
2) When adjusting queues, XDP queues are adjusted to match the number of
   RX queues when XDP is enabled. This only works in the case when
   queues are live, so part (1) of the fix must still be available in
   the case that queues are adjusted when there is an XDP program and
   the interface is down.

Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5cab7b88610f..09fb7f16f73e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -930,11 +930,13 @@ static void gve_init_sync_stats(struct gve_priv *priv)
 static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_tx_alloc_rings_cfg *cfg)
 {
+	int num_xdp_queues = priv->xdp_prog ? priv->rx_cfg.num_queues : 0;
+
 	cfg->qcfg = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->ring_size = priv->tx_desc_cnt;
 	cfg->start_idx = 0;
-	cfg->num_rings = gve_num_tx_queues(priv);
+	cfg->num_rings = priv->tx_cfg.num_queues + num_xdp_queues;
 	cfg->tx = priv->tx;
 }
 
@@ -1843,6 +1845,7 @@ int gve_adjust_queues(struct gve_priv *priv,
 {
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	int num_xdp_queues;
 	int err;
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -1853,6 +1856,10 @@ int gve_adjust_queues(struct gve_priv *priv,
 	rx_alloc_cfg.qcfg = &new_rx_config;
 	tx_alloc_cfg.num_rings = new_tx_config.num_queues;
 
+	/* Add dedicated XDP TX queues if enabled. */
+	num_xdp_queues = priv->xdp_prog ? new_rx_config.num_queues : 0;
+	tx_alloc_cfg.num_rings += num_xdp_queues;
+
 	if (netif_running(priv->dev)) {
 		err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 		return err;
-- 
2.47.1.613.gc27f4b7a9f-goog


