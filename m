Return-Path: <netdev+bounces-230331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA3BE69B0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFAEE35A62E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32716323411;
	Fri, 17 Oct 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV9GcW2B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1D310631;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681493; cv=none; b=FBZ+EVLcOYFCRu5Ad6OPJuYD1lsMu9YtYaKkUOOXgv5mKOqjhZGGc0xJzozIU4Hgd/UbtkaYjHHzq72HeD84ghtEp0QrO//UJZoobBszHGtlitqyUeFLp5pFXhDvmaAPnlrkwEMH3E04/4voyBQIXuuiXzxRbsFoMaqKRfv6Y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681493; c=relaxed/simple;
	bh=kiZ/E3EReHUX0M1b+8d/q62Wo1VPS2A4vlagRzx83LQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Misui6HJmGOB7zqXMzNwYuEe7Mq5tEF1YyMgPsN4HqogaGKyY/5w/HCKUsMSl3zzBd4HaOUUvb+ZodyRp2Y+gasw82Vjp5khjn6JH8wsNTeOGlatWPZQT4/tIXVTh6LXdVpet5PenGpj7sf38f+txFZbsAsOcU1xcwaQCaVVY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV9GcW2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99E9FC4CEE7;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760681492;
	bh=kiZ/E3EReHUX0M1b+8d/q62Wo1VPS2A4vlagRzx83LQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VV9GcW2BRCikIQ/H/scyfCtOqIlylreOp9hSMMar9qBsNRDjR2FfDavrq1orN+xUv
	 iDCpag2j+5thSXgq8CSbVvzzcinNNVzIk82q0zKtQ3cyVB2pTSvpWQJjVyX4MWZy/o
	 HNgAKnmZ3qTn9bWZ2myXJoSqNdYI2u9QKeQxFS+krIxmS5NgT9U9QkYdjIKPQmzIpj
	 hNqxD7jMhVq1QR1w3YKWdo5tju09UCubQaZVxyhaKcQmIDcgDxkVp7LM3yZ+3nPHj/
	 oe3PykmzNnrpP7ysKNuMLGCfHgC9khHuDejK+58Fy54bDqVb2+zUsQiNreIyHP88nX
	 i3PNqg0ah3WdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A87CCD199;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Fri, 17 Oct 2025 14:11:20 +0800
Subject: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
In-Reply-To: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760681491; l=2216;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=jcxjbVsIAOtq9pkhXrGNK9OcxDQoYMmKdVWnGqUpw8w=;
 b=Sf2ajyE8ADotRUn+QZuwv0vYNgHn1PxaIwhGA+1sNu7EqNI5uMqNDQLYoGjwMAydQpYdRHBmB
 cWANmRpfenMDn0Q5bBFAHqTWti0xS4jdZW2KTBb06OTgtKIwsk+KSni
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

On hardware with Tx VLAN offload enabled, add the VLAN tag length to
the skb length before checking the Qbv maxSDU if Tx VLAN offload is
requested for the packet. Add 4 bytes for 802.1Q tag.

Fixes: c5c3e1bfc9e0 ("net: stmmac: Offload queueMaxSDU from tc-taprio")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dedaaef3208bfadc105961029f79d0d26c3289d8..23bf4a3d324b7f8e8c3067ed4d47b436a89c97d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4500,6 +4500,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool has_vlan, set_ic;
 	int entry, first_tx;
 	dma_addr_t des;
+	u32 sdu_len;
 
 	tx_q = &priv->dma_conf.tx_queue[queue];
 	txq_stats = &priv->xstats.txq_stats[queue];
@@ -4516,13 +4517,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -4535,8 +4529,18 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
+	sdu_len = skb->len;
 	/* Check if VLAN can be inserted by HW */
 	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
+	if (has_vlan)
+		sdu_len += VLAN_HLEN;
+
+	if (priv->est && priv->est->enable &&
+	    priv->est->max_sdu[queue] &&
+	    skb->len > priv->est->max_sdu[queue]){
+		priv->xstats.max_sdu_txq_drop[queue]++;
+		goto max_sdu_err;
+	}
 
 	entry = tx_q->cur_tx;
 	first_entry = entry;

-- 
2.43.7



