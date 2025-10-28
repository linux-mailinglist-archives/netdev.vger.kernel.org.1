Return-Path: <netdev+bounces-233399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FFC12BC1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516CF1887FFD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D38241695;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+DcDe/t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106211713;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621546; cv=none; b=clb486wFq6JuEqNtqaA1UAsnStNU9i+aziyD3b8XEjA2AjCv7irlOmKJcIWhDbUlb22cZCBY/Fno0YfkRdW65hsI9YwYfi+V2RzSHVuDClKIfFUQqrmnzQpiCjHVUOWXp19/knv6DzHNzD66YQVrikB+2QZAanzhNQUz9acCYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621546; c=relaxed/simple;
	bh=0hWKqbgkN+hfhvJMeOStqFbwoig9LbU901FZt559fFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJ0OFbXIo8wF9lx51rHjzk1SaJCuGmcFgSdSNtAbgTH57daII9xspcQVwaUFxGEM1B7tay6tJWellQyUQKHOJ4d1x56SES4bOl5BMGvDmdcA4cbhhx0J9XWxove8wYnOLnUR2U8Mm5qx5X/Q4hLUM5u/plgpTU9O2Wu+vyI93+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+DcDe/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BBB5C113D0;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761621546;
	bh=0hWKqbgkN+hfhvJMeOStqFbwoig9LbU901FZt559fFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l+DcDe/t57UWPX8sp+jxMaek3cJ1i01vvq/Zx5no+ZxZ5SdKXwoQSA99qM2CuiLVd
	 sk+bLhNBmzXHUaYaHF44JPu+2OYIELnuLkNJGtKdXNwavSZSN7GiKAEwUK+iE5ivYA
	 ynTRlYYIKPc7pKwDVT5rGb+pUW0qNSjtbqxeZcOsqCZ8w4QngxSxqp7ip0rzL6Wgpn
	 bQ2c598itrqznbx/i+H0AO4PixDqriWCuHfu3SrMqjoEI49W2S6c9Z4P4984ltQfp+
	 SWx9AcM8DJVyRW5zXGuLJX1lYwKfjojOSxD0fAJMCzhM0gECfhgHwP7wDAMjanz61n
	 DhnjOJchFJmrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295FCCCF9E0;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Tue, 28 Oct 2025 11:18:43 +0800
Subject: [PATCH net v4 1/3] net: stmmac: vlan: Disable 802.1AD tag
 insertion offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-qbv-fixes-v4-1-26481c7634e3@altera.com>
References: <20251028-qbv-fixes-v4-0-26481c7634e3@altera.com>
In-Reply-To: <20251028-qbv-fixes-v4-0-26481c7634e3@altera.com>
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
 Rohan G Thomas <rohan.g.thomas@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761621544; l=4277;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=rxibg18Dd61H1Ewfb91EvrT+ppl8EDLCs85ERja28NM=;
 b=+KObgtYWGuAQEnejsbqZRVuMV8R5bTJyIFYA4j6CPeGH4Kxqv3NFjXxFbBTqvLPxZsH4XcU4o
 P7wzCNwvpIWDrcvoNBDxfNBEO+1643HG2WoSbbw1vjDe7HVtAd0Y+c3
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

The DWMAC IP's VLAN tag insertion offload does not support inserting
STAG (802.1AD) and CTAG (802.1Q) types in bytes 13 and 14 using the
same MAC_VLAN_Incl and MAC_VLAN_Inner_Incl register configurations.

Currently, MAC_VLAN_Incl is configured to offload only STAG type
insertion. However, the DWMAC IP inserts a CTAG type when the inner
VLAN ID field of the descriptor is not configured, and a STAG type
when it is configured. This behavior is not documented and leads to
inconsistent double VLAN tagging.

Additionally, an unexpected CTAG with VLAN ID 0 is inserted, resulting
in frames like:

Frame 1: 110 bytes on wire (880 bits), 110 bytes captured (880 bits)
Ethernet II, Src: <src> (<src>), Dst: <dst> (<dst>)
IEEE 802.1ad, ID: 100
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 0 (unexpected)
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 200
Internet Protocol Version 4, Src: 192.168.4.10, Dst: 192.168.4.11
Internet Control Message Protocol

To avoid this undocumented and incorrect behavior, disable 802.1AD tag
insertion offload. Also, don't set CSVL bit. As per the data book,
when this bit is set, S-VLAN type (0x88A8) is inserted in the 13th and
14th bytes of transmitted packets and when this bit is reset, C-VLAN
type (0x8100) is inserted in the 13th and 14th bytes of transmitted
packets.

Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")
Fixes: e94e3f3b51ce ("net: stmmac: Add support for VLAN Insertion Offload in GMAC4+")
Fixes: 1d2c7a5fee31 ("net: stmmac: Refactor VLAN implementation")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++--------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c |  2 +-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fd51068801928e138c3b483a1115b59b5ffa955a..0e2dc0a464d5516b8aabe2f9afc60c6e37f0209e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4107,18 +4107,11 @@ static int stmmac_release(struct net_device *dev)
 static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 			       struct stmmac_tx_queue *tx_q)
 {
-	u16 tag = 0x0, inner_tag = 0x0;
-	u32 inner_type = 0x0;
 	struct dma_desc *p;
+	u16 tag = 0x0;
 
-	if (!priv->dma_cap.vlins)
+	if (!priv->dma_cap.vlins || !skb_vlan_tag_present(skb))
 		return false;
-	if (!skb_vlan_tag_present(skb))
-		return false;
-	if (skb->vlan_proto == htons(ETH_P_8021AD)) {
-		inner_tag = skb_vlan_tag_get(skb);
-		inner_type = STMMAC_VLAN_INSERT;
-	}
 
 	tag = skb_vlan_tag_get(skb);
 
@@ -4127,7 +4120,7 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 	else
 		p = &tx_q->dma_tx[tx_q->cur_tx];
 
-	if (stmmac_set_desc_vlan_tag(priv, p, tag, inner_tag, inner_type))
+	if (stmmac_set_desc_vlan_tag(priv, p, tag, 0x0, 0x0))
 		return false;
 
 	stmmac_set_tx_owner(priv, p);
@@ -7591,11 +7584,8 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
 	}
-	if (priv->dma_cap.vlins) {
+	if (priv->dma_cap.vlins)
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_TX;
-		if (priv->dma_cap.dvlan)
-			ndev->features |= NETIF_F_HW_VLAN_STAG_TX;
-	}
 #endif
 	priv->msg_enable = netif_msg_init(debug, default_msg_level);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index 0b6f6228ae35db3d855d8d386c3806a007a9d176..ff02a79c00d4f52a458edde1bcc08a0895b2c1c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -212,7 +212,7 @@ static void vlan_enable(struct mac_device_info *hw, u32 type)
 
 	value = readl(ioaddr + VLAN_INCL);
 	value |= VLAN_VLTI;
-	value |= VLAN_CSVL; /* Only use SVLAN */
+	value &= ~VLAN_CSVL; /* Only use CVLAN */
 	value &= ~VLAN_VLC;
 	value |= (type << VLAN_VLC_SHIFT) & VLAN_VLC;
 	writel(value, ioaddr + VLAN_INCL);

-- 
2.43.7



