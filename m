Return-Path: <netdev+bounces-165427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748AA31F7B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05221888B4A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5771FF1AB;
	Wed, 12 Feb 2025 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB88eptI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706A1FECDF
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343134; cv=none; b=efiwEZy195MVEVIHhNwucjJl7Wq8fXUEU6dEZg9yG1kzLi7G5W+Kl8jhU5/I+EDFdjdHo3MBojJJYLswzGPjIZt1O5/CZyXZwLiPOekQHeVlzioeunvcUNLGFlEJH5+ltQuW2M/pwTXJS1HLHgMpBq/L+9CKQPIM3wXE8ozqRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343134; c=relaxed/simple;
	bh=ZR5/2ulMQlwhUwl/HtlTLXlzn5sAotIiGMhXEhkdb3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijy+1Bluliw7LmVL1H8I7F0JeAHm9bR7g+joLTQuoJ5rN2uMjGPGey/g4jJ4ZSUyJFqSqpMK7bpMfS8yq3SS5+pLcJCi7r6/UVfak2VpYZiuyVzNpvXJTwheGDd62pu6btqEhKYKccRviH+6WvSda7WvYkqQeeGep8iGQ2iMjHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB88eptI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D355C4CEDF;
	Wed, 12 Feb 2025 06:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739343133;
	bh=ZR5/2ulMQlwhUwl/HtlTLXlzn5sAotIiGMhXEhkdb3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rB88eptIRhWJaqF3WPpr08Ft5KB7I/GhHDFkfLzvTd+lGjkFJJBEfn3C9/jWKDybf
	 3X+Pc3kyzxQSONHBSye6YqFG5jzExQe9QzaSkaZKt13+GhcUNhLwjclwjg2KXDpRGe
	 LsY5GceWC4otQA7u8/GlFtVucBQyUSTwUqq0C+UdMLbdKk1R3f/zMaslE9CDBwE/TB
	 mxy0QqhTWr0xMKr+NshuwevoVXlBBxOz9J9dvAiTdXgS8Y2wJtCBJQmgUPnhnUhFMB
	 UEiVSTtpQAsNVX3e3iNeN6/LRQhZjZprRFFWko7dNsy4bnTm8s65Y3Pwc8ZDqcfMES
	 mZspdKOl19NTg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Feb 2025 07:51:47 +0100
Subject: [PATCH net-next 1/2] net: airoha: Fix TSO support for header
 cloned skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-airoha-fix-tso-v1-1-1652558a79b4@kernel.org>
References: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
In-Reply-To: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

For GSO packets, skb_cow_head() will reallocate the skb for TSO header
cloned skbs in airoha_dev_xmit(). For this reason, sinfo pointer can be
no more valid. Fix the issue relying on skb_shinfo() macro directly in
airoha_dev_xmit().
This is not a user visible issue since we can't currently enable TSO for
DSA user ports since we are missing to initialize net_device
vlan_features field.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
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


