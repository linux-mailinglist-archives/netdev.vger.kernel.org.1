Return-Path: <netdev+bounces-247224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE17CF5F98
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6A363032CE6
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985B2EFD98;
	Mon,  5 Jan 2026 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1KfrNlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330C312802
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655520; cv=none; b=p45b/MuR7x0S7qeDoiUaYv7Uc0uWhr0EN/vp9Ob4yuyikj+QECUXSTOgdoKwiJ9iiUQE8HUK/Y/4VpkgkFkqN9yiNpMXYy/nwAkATfDby6upgcIA3CSbxX1qIHlF6LWUWxnk2YaoSovIy4Dp/IDDOeiLtev3kk2q591PfdmkogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655520; c=relaxed/simple;
	bh=js80mMuNlBOELx5P2UoLJmgXleXwUwNvjgLX75BgXhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KfdlEKFhy7ZbVdu1s/sOJiRI8HMAlJmTUBNlNIVM3mftLK0/M+/n39O5xQm1dU0mupUpLYcEVPZzPRhdUrjqb+nmPTYuOiDIYn9ZPiLiq/NSuBeuz8NJ+4c8X7uZbUdRdOA9gykpyxpDdA5ucXZjIHwXA7Wym+M3IfXZhqO88nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1KfrNlL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a31087af17so15546525ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767655518; x=1768260318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaBC/zjYASseD43BuH+r33jZDmmTVbBGwAo1c95yI+w=;
        b=e1KfrNlL5iJhICSoJX19mnFU/cQ4b1WQT8j8QD0lNGLmt1W+qNr2Cc3yODwY9qr1IG
         Ozaz+MA29a39UvOiprKDeTPGNOmztMuk+dCmM/HyXaTgi8Mabd2kp0Kq3SJboS7drEen
         OL9Pihz0tRzjjHQiS+KZ4rbyvPyB6rQTiuUgQnOKXvwNGvN+erRoszBaAQi5Df6PZVVe
         DtnAT+FJbmlbHj7+ntedsBdH7kWqMA2zzwMbNSUQlmoWwW51v7uV+hhczCFg4hQ9wLNE
         juOeRHnzCEYtY4wnCxkj52ACAYvy11JQdcKYRV2/gquUQxta5HzjyrCciemFFEe9ePVh
         GwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655518; x=1768260318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaBC/zjYASseD43BuH+r33jZDmmTVbBGwAo1c95yI+w=;
        b=wH3LknJXTP27I+APKsPXs2JM2QOZsDgnfYcLhPkq0+G+CZxMgzLSkCN1YHgIMvAYc2
         Oi7PVciD3iDERySCTT48O9qZg1wl6Xf7y09X6r+H21jYiqPCpdkJKTkUiXWBfZK2LTC/
         A2egKoml4C0HMx+1mywLraJccNnvMz5eyZMoTYpF0qhMea4KeeuS4GxJAsCmG91sxWoi
         3nX5NSYynxZCHwKTjgrzix3px4n8mdLPvDuM3weRIP0v/EdBKut4AnDwsEsK+Pu2W4Kk
         Nv/dSET5nZtfcpNVW3fP4rIh81+gM9XQhoIF+VOrcJZ6+3oIDT4dtVn2MsgPDCIj2+xG
         3gOA==
X-Gm-Message-State: AOJu0YyAM8li9BkVNEcyaVDGs8CpALQbz8fLZXXj0Fw5nPI2DhsJ5fKA
	6hrFPecXxmoFDw8nQbMo2PLAG7N5zptN1X7YIdyYgTR8GBY+a46+L4Acd9nX7DeEeapg0ZiOLJa
	t3eMey1LGR9OJJ7Pzj1C5VV8KGegmhRKAdjuPkkdk//F65ipW+lcdl4ppTf2RnnqOP8ciTVfSnQ
	/qErgNoSyFTZl7+VPEGqfX21Dpe8djHKjstBUmyhN6C4+puvE=
X-Google-Smtp-Source: AGHT+IHXpHpj9+WxYW0qaP3FdAeMzFc4rHpm9LwJDeBgnInJ161+oTAeH7D0fibEzqWpHxxkCLrrXNQTPtnIug==
X-Received: from plht14.prod.google.com ([2002:a17:903:2f0e:b0:295:50ce:4dd])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1cc:b0:2a1:325b:2cba with SMTP id d9443c01a7336-2a3e2e1e6b0mr10915985ad.53.1767655517984;
 Mon, 05 Jan 2026 15:25:17 -0800 (PST)
Date: Mon,  5 Jan 2026 15:25:04 -0800
In-Reply-To: <20260105232504.3791806-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105232504.3791806-3-joshwash@google.com>
Subject: [PATCH net 2/2] gve: drop packets on invalid queue indices in DQO TX path
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

In DQO format, driver doesn't perform any validation and continues to
dereference tx array, potentially causing a crash like below (trace is
from GQI format, but how we handle OOB queue is same in both formats).

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
Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 40b89b3..8ebcc84 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -1045,9 +1045,16 @@ static void gve_xsk_reorder_queue_pop_dqo(struct gve_tx_ring *tx)
 netdev_tx_t gve_tx_dqo(struct sk_buff *skb, struct net_device *dev)
 {
 	struct gve_priv *priv = netdev_priv(dev);
+	u16 qid = skb_get_queue_mapping(skb);
 	struct gve_tx_ring *tx;

-	tx = &priv->tx[skb_get_queue_mapping(skb)];
+	if (unlikely(qid >= priv->tx_cfg.num_queues)) {
+		net_warn_ratelimited("%s: skb qid %d out of range, num tx queue %d. dropping packet",
+				     dev->name, qid, priv->tx_cfg.num_queues);
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	tx = &priv->tx[qid];
 	if (unlikely(gve_try_tx_skb(priv, tx, skb) < 0)) {
 		/* We need to ring the txq doorbell -- we have stopped the Tx
 		 * queue for want of resources, but prior calls to gve_tx()
--
2.52.0.351.gbe84eed79e-goog


