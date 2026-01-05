Return-Path: <netdev+bounces-247223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D3CF5F9F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A25330640D4
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C5309EE4;
	Mon,  5 Jan 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xM5KiGKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A12E173D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655517; cv=none; b=s9No6yXh6xc0uWcDONHk4EVVLKQM42jV3kry1CnJYGmcQqwQOkpMyhFj5Sb3H6vadO7rGP1rkTm3VPVDO7zaTLCs7UQ97u0enHLHAsdXnPTYj5NekfX39EFqEsN/WOdC6DdMNYeESBH/NKKVt7Zn5XdhpJ0kbhVGVsSAqPJYdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655517; c=relaxed/simple;
	bh=VQ67d+cxAVjhU4M2j8i97cyQAifn3zmTtF/xVJaVNsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=INJ3y8m7GRMxJAefetiYWsKlTDPawkMlz/jV+gtrSch3aissq+sYvC3UvkzfKP2qL2JCXANAAgxsL4KuddB7//E6yEAjWhCeyIXfqLuh/BneIF6xdKpkKttsCAAzjb8DZMCfPjoq/gPKZPrM0o4LwYWjBuQg5of8QkFxSgGI6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xM5KiGKv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29f2b45ecffso5353625ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767655515; x=1768260315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dv/AzMBffbd1t9Mo3netnMTGMz6k1glaV6nzZVsJtVU=;
        b=xM5KiGKvioYCJTgT5oLkNwbiIdp1i0htmbNb5AUgs6R1uZdIRiooStqt8637R4o0k0
         BcetVC/iZ/V79iNHMMYRD0+yEf+TmeKz9vBdZiiFGbvVHrPIqOeiTOpLqMxtCAzELWPx
         U8McOxiGMJrfOKE6JkXJUKbetKWxe/+08DGWQFiQ88TKmkgMOLOGN2lnMVvXgGbhQ0De
         X4q3YCg89AkXiqdw00oUSlW0NDVuQ6X9y1tImc640yls+B+nsMm4QQk8B5E5hh7XvZP2
         3LMFuANtqBDSyERFlOJz5mqgGsCwrh19BiB8rzIGlg4UJra9kfVpF6YecLHwTtlaqcZT
         jSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655515; x=1768260315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dv/AzMBffbd1t9Mo3netnMTGMz6k1glaV6nzZVsJtVU=;
        b=Ue8GyV/XfibMaBnSKGhrwE9phprao5XsZZan5Unz4sRl9A35cUUTxC+RvMRz8FEGlP
         Q6oEDSW7tYs2+qsNaKZbsHBEhu2Y/qZKz0RDrSUS8yKeFf0ZKmooyMoAoKo8iM/AyV5N
         AhWp2VFzSGA8x7NeZN+BwSKilq0Mj6hL9UxPrTvWO9uG5BnQktosX+XC1/yybbfQPn0a
         co+/IoAHnPDKELiHkZzCbEuTUahj9mGI+6bzLjD1webaLN79G1TpSziVdUOtIMX9JE8q
         WQynS28YgEFTyWKXxgRCt4ZJkcMRgm2dIhZuTawLSyJZNXGt0IuOi3kJf5zybfu+8zly
         N4lg==
X-Gm-Message-State: AOJu0YxlzBKyWSal2YELaeVDPkr9qAskD6n8tybxvlVjjw54rQy0aZLX
	MT8WT7KfaUUcmTXAghK5YeNulB7j/nDXbqlEOf6y0GF01J83J6T6CHxsxNS6NbvOvaQkFAOFZDx
	ZXxMLDRnsxNrSsY83nN3esN2Uzr2SDtJgkMbziIbNO7I8mZbWrp9GxktQqtKxOxlaz1ISpwQmrq
	rEju6B+Zi86o/vL/+b3N8Kw0GKXGLPTvxOqSEIzx8bRccjPiA=
X-Google-Smtp-Source: AGHT+IGZZwIyBUX7xyTYXcUilepjhdaGAz/44UQzr7Rgx6T6tVd+plSImOIDqYcmxFSYI3K9hlnpblJwmNDmBg==
X-Received: from plxm9.prod.google.com ([2002:a17:902:db09:b0:29d:5afa:2d5])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4765:b0:2a0:e195:b846 with SMTP id d9443c01a7336-2a3e2df4b9emr9691705ad.54.1767655514648;
 Mon, 05 Jan 2026 15:25:14 -0800 (PST)
Date: Mon,  5 Jan 2026 15:25:03 -0800
In-Reply-To: <20260105232504.3791806-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105232504.3791806-2-joshwash@google.com>
Subject: [PATCH net 1/2] gve: drop packets on invalid queue indices in GQI TX path
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Ankit Garg <nktgrg@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Catherine Sullivan <csully@google.com>, 
	Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, Sagi Shahar <sagis@google.com>, 
	Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

The driver currently assumes that the skb queue mapping is within the
range of configured TX queues. However, the stack may provide an index
that exceeds the number of active queues.

In GQI format, an out-of-range index triggered a warning but continues
to dereference tx array, potentially causing a crash like below:

[    6.700970] Call Trace:
[    6.703576]  ? __warn+0x94/0xe0
[    6.706863]  ? gve_tx+0xa9f/0xc30 [gve]
[    6.712223]  ? gve_tx+0xa9f/0xc30 [gve]
[    6.716197]  ? report_bug+0xb1/0xe0
[    6.721195]  ? do_error_trap+0x9e/0xd0
[    6.725084]  ? do_invalid_op+0x36/0x40
[    6.730355]  ? gve_tx+0xa9f/0xc30 [gve]
[    6.734353]  ? invalid_op+0x14/0x20
[    6.739372]  ? gve_tx+0xa9f/0xc30 [gve]
[    6.743350]  ? netif_skb_features+0xcf/0x2a0
[    6.749137]  dev_hard_start_xmit+0xd7/0x240

Change that behavior to log a warning and drop the packet.

Cc: stable@vger.kernel.org
Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 97efc8d..30d1686 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -739,12 +739,18 @@ drop:
 netdev_tx_t gve_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct gve_priv *priv = netdev_priv(dev);
+	u16 qid = skb_get_queue_mapping(skb);
 	struct gve_tx_ring *tx;
 	int nsegs;
 
-	WARN(skb_get_queue_mapping(skb) >= priv->tx_cfg.num_queues,
-	     "skb queue index out of range");
-	tx = &priv->tx[skb_get_queue_mapping(skb)];
+	if (unlikely(qid >= priv->tx_cfg.num_queues)) {
+		net_warn_ratelimited("%s: skb qid %d out of range, num tx queue %d. dropping packet",
+				     dev->name, qid, priv->tx_cfg.num_queues);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	tx = &priv->tx[qid];
 	if (unlikely(gve_maybe_stop_tx(priv, tx, skb))) {
 		/* We need to ring the txq doorbell -- we have stopped the Tx
 		 * queue for want of resources, but prior calls to gve_tx()
-- 
2.52.0.351.gbe84eed79e-goog


