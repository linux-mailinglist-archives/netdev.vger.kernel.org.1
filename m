Return-Path: <netdev+bounces-166081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBFCA347E6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE55188C643
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAB18DF6E;
	Thu, 13 Feb 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksTt28lf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163E70805;
	Thu, 13 Feb 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460890; cv=none; b=MfjmG/WoWmVZKHloJNaL28kmYglvD1l46IEUft5DH5ZgUAbysBqVm158mmXL0I8n6oWJSVkAoyuQw9csISOGkyGU7dVLA60YxBLeaA2iHcPgm/P+erOxga4J8mBlku9yLfH6P8RmC0edmjgwC2SWJPe48f38hNDud/BnZySBNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460890; c=relaxed/simple;
	bh=L5nffdWdH0LR7Q80jRhjrqzq1DZVr+htRNvDd6KyaNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ei6rOu95drzrvItswF2/vvcpzW6qBiYcFanXiEp0ok+3iTWNj0P714mjHgzLhH327dXFDbStWax4KtFEvhs25FY7TJtWjBfm+KKP/aNBz8HmXNhm+wdr/95iVOkEE2oqtJTK+tzEF/E2l1OhdMIX3bd+XiEme7SZ6yyrtW9+HWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksTt28lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D27C4CED1;
	Thu, 13 Feb 2025 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460889;
	bh=L5nffdWdH0LR7Q80jRhjrqzq1DZVr+htRNvDd6KyaNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ksTt28lfjlRlE/DPAyXk9PTXaabBhNNayZ1h9pQTYfclDNfSzzA4yAjI55wk5rdx1
	 tOQkGijBR8gZUR941+qh9jlYLPNCMNfBwQWaXYjSnXbOZGjw+XMgVy5fbRveeb6/EP
	 SVk0Y1QE1x4I1cpMwdhgS+HjY1KvTJTj63p3uB+/bNEv4oDZEYoqmS4UBmdwF9USrm
	 SxKL8fvj1qzE2WMyidWGZJxhabWjm4OKE6nZoPe54ULXr7Epfh7dfe+tQQXa+lX/iV
	 W+mNqOkeKWgKr/76LZ49XW8ki7muq2tF8TsqvejVqsIXjDgqNvwyoApxiJSr04b9v/
	 naji+f5haUutw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 13 Feb 2025 16:34:20 +0100
Subject: [PATCH net-next v4 01/16] net: airoha: Fix TSO support for header
 cloned skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-airoha-en7581-flowtable-offload-v4-1-b69ca16d74db@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com, Mateusz Polchlopek <mateusz.polchlopek@intel.com>
X-Mailer: b4 0.14.2

For GSO packets, skb_cow_head() will reallocate the skb for TSO header
cloned skbs in airoha_dev_xmit(). For this reason, sinfo pointer can be
no more valid. Fix the issue relying on skb_shinfo() macro directly in
airoha_dev_xmit().
This is not a user visible issue since we can't currently enable TSO for
DSA user ports since we are missing to initialize net_device
vlan_features field.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 09f448f291240257c5748725848ede231c502fbd..aa5f220ddbcf9ca5bee1173114294cb3aec701c9 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2556,11 +2556,10 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
-	struct skb_shared_info *sinfo = skb_shinfo(skb);
 	struct airoha_gdm_port *port = netdev_priv(dev);
+	u32 nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 	u32 msg0, msg1, len = skb_headlen(skb);
 	struct airoha_qdma *qdma = port->qdma;
-	u32 nr_frags = 1 + sinfo->nr_frags;
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
 	void *data = skb->data;
@@ -2583,8 +2582,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		if (skb_cow_head(skb, 0))
 			goto error;
 
-		if (sinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
-			__be16 csum = cpu_to_be16(sinfo->gso_size);
+		if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 |
+						 SKB_GSO_TCPV6)) {
+			__be16 csum = cpu_to_be16(skb_shinfo(skb)->gso_size);
 
 			tcp_hdr(skb)->check = (__force __sum16)csum;
 			msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TSO_MASK, 1);
@@ -2613,7 +2613,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	for (i = 0; i < nr_frags; i++) {
 		struct airoha_qdma_desc *desc = &q->desc[index];
 		struct airoha_queue_entry *e = &q->entry[index];
-		skb_frag_t *frag = &sinfo->frags[i];
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		dma_addr_t addr;
 		u32 val;
 

-- 
2.48.1


