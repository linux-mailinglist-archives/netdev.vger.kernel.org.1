Return-Path: <netdev+bounces-222941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1EB572A8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A8160EB7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385A2E9EDD;
	Mon, 15 Sep 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eial+Mne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6C278161;
	Mon, 15 Sep 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924241; cv=none; b=BWsbLJXUPdWh9XZTn0WGmpB94/sBmwvanSVyEE6ZA29iZaZQOajCVEHXYOyOskq3OroBt6TM8uGeTptSRzW8z09ofNvyVApTNdApyXrdcbO7y/jelRrXODovmRyTY+w6LigWiB+oG78MCIhXicStivZpvnbUXh8osUoyvaxjw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924241; c=relaxed/simple;
	bh=CfRwKmWc41Eb4Eo+qu71Ph/IfoEFK4Y9Oi50rGKAmTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJi9WGWjRsolha2UPGFD3rD4cj6/XV3nIAucRNJHBQkHHDp2OtKyhaABmcyplIXojiu3mWMm7J+GcI8xxbeqR8q2y+LEzyaJK10wva3H77S2r0LFyIpza8229mZjZGI2tqS7EV+0WD4xvBFfxUwolUgMADBkGtQRINjqqL6x7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eial+Mne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E3BEC4CEFB;
	Mon, 15 Sep 2025 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924241;
	bh=CfRwKmWc41Eb4Eo+qu71Ph/IfoEFK4Y9Oi50rGKAmTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Eial+Mneq5c2t2JWKpBzGj3AoYS0A+ndPlMb9dRmk34JLeOJdqGeIx5ng1Tq4Zc1/
	 sYCSdOO7slCV+8/iB06JZSIieeteLW3Scq2ezmpgzGqfxe30tQec0L0dYjKAfpYffP
	 /MeTZeqsRYJFv61bhLmHzMyPEYg2zeu2g2LMUJpewiiNuOPbmrmw9st1go5LunPnST
	 pLidiiuFw4x4V8pQocv3Z8YYbsl/I3CaZ8SWvN4lKewznTLgbc1J06MWfXj7t/Ypib
	 Mo2WO+ncOKn6TVXjjZQPcvDmkqoptIgjEyGCsW9iFxDy0zMzTIcoEvL7pjivtRu8ka
	 /aPo7p8fdaIjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD54CAC598;
	Mon, 15 Sep 2025 08:17:21 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Mon, 15 Sep 2025 16:17:19 +0800
Subject: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
In-Reply-To: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757924239; l=2480;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=DoDmPaXfLB/bLZGa1Ixa2bObvDjP8v/PGAMQq76env8=;
 b=wVN5CaLveZl3eMAmOlvIyWdRSXZumm1eMskrSPcGTz7YXY/h4L+qhZTTZMQPOIdDISwNzEbqL
 UIwCGFHliyXBghBeocR0jNjle9uLD5D4HHeaytqLmPo6xajplrlkvQF
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

On hardware with Tx VLAN offload enabled, add the VLAN tag
length to the skb length before checking the Qbv maxSDU.
Add 4 bytes for 802.1Q an add 8 bytes for 802.1AD tagging.

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8c8ca5999bd8ad369eafa0cd8448a15da55be86b..c06c947ef7764bf40291a556984651f4edd7cb74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4537,6 +4537,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool has_vlan, set_ic;
 	int entry, first_tx;
 	dma_addr_t des;
+	u32 sdu_len;
 
 	tx_q = &priv->dma_conf.tx_queue[queue];
 	txq_stats = &priv->xstats.txq_stats[queue];
@@ -4553,13 +4554,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 			return stmmac_tso_xmit(skb, dev);
 	}
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue] &&
-	    skb->len > priv->est->max_sdu[queue]){
-		priv->xstats.max_sdu_txq_drop[queue]++;
-		goto max_sdu_err;
-	}
-
 	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
@@ -4575,6 +4569,23 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Check if VLAN can be inserted by HW */
 	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
 
+	sdu_len = skb->len;
+	if (has_vlan) {
+		/* Add VLAN tag length to sdu length in case of txvlan offload */
+		if (priv->dev->features & NETIF_F_HW_VLAN_CTAG_TX)
+			sdu_len += VLAN_HLEN;
+		if (skb->vlan_proto == htons(ETH_P_8021AD) &&
+		    priv->dev->features & NETIF_F_HW_VLAN_STAG_TX)
+			sdu_len += VLAN_HLEN;
+	}
+
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    sdu_len > priv->est->max_sdu[queue]) {
+		priv->xstats.max_sdu_txq_drop[queue]++;
+		goto max_sdu_err;
+	}
+
 	entry = tx_q->cur_tx;
 	first_entry = entry;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);

-- 
2.26.2



