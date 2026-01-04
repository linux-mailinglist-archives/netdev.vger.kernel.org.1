Return-Path: <netdev+bounces-246716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C64CF0A2B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 07:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1729A3000EBC
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE832165EA;
	Sun,  4 Jan 2026 06:00:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EA191;
	Sun,  4 Jan 2026 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506450; cv=none; b=M3Zm9Rg1OJiPrhk0y1MAn3+GsAjENou6WmpAakrepU4B81Oc8G2eF8TKIhTxVMy7avMWjct/f8lQl5rgBm6nauY64FyQ1gpMYOgGHPVABnYttxgNC5iO6tXm4DuMvGjaptLFLlND1IhRNmwV0M+AjQuxeu8voFMQ3MI7BfCH+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506450; c=relaxed/simple;
	bh=pxDgtE8DhvzZK71HNp6zF525hyAyalNTpqUMKI/MXQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gwcONioRZESxKGGohg1M9ApJjEgrO8r1vV1WS/LNGvsvAyxU6bBOkRgBZ5+D3wkfoTbzA40tYTt+lsyJN0PMzvWW6jO0M5cEBb5/XhVMNyGJocUUq8wRFaLBbjP9AewHyMOKgrMoTDYk0IOIsmVYMOQnkG9W+xZEmw0sU2RwK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.82.145])
	by APP-01 (Coremail) with SMTP id qwCowAD3oGzmAVppu3AIAw--.1340S2;
	Sun, 04 Jan 2026 14:00:08 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Sun, 04 Jan 2026 14:00:04 +0800
Subject: [PATCH net-next v3] net: spacemit: Remove broken flow control
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-k1-ethernet-actually-remove-fc-v3-1-3871b055064c@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAOMBWmkC/42OQQ7CIBREr9L8tb8pqKV05T2MJhS/lthSBSSap
 ncX0QO4nMy8mZnBkzPkoS1mcBSNN5NNYr0qQPfKXgjNKWngFd8yxjd4ZUihJ2cpoNLhoYbhhY7
 GKRKeNYqqbtZMiGrTSEglN0dn88wDe/gwlp4BDl/H0f2RFsPP7pQn1NM4mtAWsS6ZRKfZcV5yv
 jc+TO6Vn0aegX9PRY4MtySE6mrZCcl2xmvlS6VLbeGwLMsbNQdpkQgBAAA=
X-Change-ID: 20251124-k1-ethernet-actually-remove-fc-706831770489
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:qwCowAD3oGzmAVppu3AIAw--.1340S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr43Gr1rWr4xtw43Cw4kJFb_yoWxAr4rpF
	45X3s2kFWUXFsYgFs3Cw4UAFy3Ga4xtrnrua4fCw4Fg3ZIyrn7AFy0k3W7CFyDurW8ury5
	Kw4UA3W8GFsrX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The current flow control implementation doesn't handle autonegotiation
and ethtool operations properly. Remove it for now so we don't claim
support for something that doesn't really work. A better implementation
will be sent in future patches.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Changes in v3:
- Remove Fixes since this is for net-next, not for backporting (Andrew)
- Link to v2: https://lore.kernel.org/r/20251124-k1-ethernet-actually-remove-fc-v2-1-5e77ab69b791@iscas.ac.cn
---

My employer has switched focus somewhat so I'm unlikely to prioritize
the proper implementation of flow control etc with phylink for now.
Sorry. This is just a little bit of polish for Spacemit K1 ethernet
support on 6.20/7.0 to go with the other peripheral support.
---
 drivers/net/ethernet/spacemit/k1_emac.c | 110 --------------------------------
 1 file changed, 110 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..c85dc742c404 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -46,8 +46,6 @@
 #define EMAC_RX_FRAMES			64
 #define EMAC_RX_COAL_TIMEOUT		(600 * 312)
 
-#define DEFAULT_FC_PAUSE_TIME		0xffff
-#define DEFAULT_FC_FIFO_HIGH		1600
 #define DEFAULT_TX_ALMOST_FULL		0x1f8
 #define DEFAULT_TX_THRESHOLD		1518
 #define DEFAULT_RX_THRESHOLD		12
@@ -132,9 +130,6 @@ struct emac_priv {
 	u32 tx_delay;
 	u32 rx_delay;
 
-	bool flow_control_autoneg;
-	u8 flow_control;
-
 	/* Softirq-safe, hold while touching hardware statistics */
 	spinlock_t stats_lock;
 };
@@ -179,9 +174,7 @@ static void emac_set_mac_addr_reg(struct emac_priv *priv,
 
 static void emac_set_mac_addr(struct emac_priv *priv, const unsigned char *addr)
 {
-	/* We use only one address, so set the same for flow control as well */
 	emac_set_mac_addr_reg(priv, addr, MAC_ADDRESS1_HIGH);
-	emac_set_mac_addr_reg(priv, addr, MAC_FC_SOURCE_ADDRESS_HIGH);
 }
 
 static void emac_reset_hw(struct emac_priv *priv)
@@ -200,9 +193,6 @@ static void emac_reset_hw(struct emac_priv *priv)
 
 static void emac_init_hw(struct emac_priv *priv)
 {
-	/* Destination address for 802.3x Ethernet flow control */
-	u8 fc_dest_addr[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
-
 	u32 rxirq = 0, dma = 0;
 
 	regmap_set_bits(priv->regmap_apmu,
@@ -228,12 +218,6 @@ static void emac_init_hw(struct emac_priv *priv)
 		DEFAULT_TX_THRESHOLD);
 	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 
-	/* Configure flow control (enabled in emac_adjust_link() later) */
-	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
-	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
-	emac_wr(priv, MAC_FC_HIGH_PAUSE_TIME, DEFAULT_FC_PAUSE_TIME);
-	emac_wr(priv, MAC_FC_PAUSE_LOW_THRESHOLD, 0);
-
 	/* RX IRQ mitigation */
 	rxirq = FIELD_PREP(MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK,
 			   EMAC_RX_FRAMES);
@@ -1018,57 +1002,6 @@ static int emac_mdio_init(struct emac_priv *priv)
 	return ret;
 }
 
-static void emac_set_tx_fc(struct emac_priv *priv, bool enable)
-{
-	u32 val;
-
-	val = emac_rd(priv, MAC_FC_CONTROL);
-
-	FIELD_MODIFY(MREGBIT_FC_GENERATION_ENABLE, &val, enable);
-	FIELD_MODIFY(MREGBIT_AUTO_FC_GENERATION_ENABLE, &val, enable);
-
-	emac_wr(priv, MAC_FC_CONTROL, val);
-}
-
-static void emac_set_rx_fc(struct emac_priv *priv, bool enable)
-{
-	u32 val = emac_rd(priv, MAC_FC_CONTROL);
-
-	FIELD_MODIFY(MREGBIT_FC_DECODE_ENABLE, &val, enable);
-
-	emac_wr(priv, MAC_FC_CONTROL, val);
-}
-
-static void emac_set_fc(struct emac_priv *priv, u8 fc)
-{
-	emac_set_tx_fc(priv, fc & FLOW_CTRL_TX);
-	emac_set_rx_fc(priv, fc & FLOW_CTRL_RX);
-	priv->flow_control = fc;
-}
-
-static void emac_set_fc_autoneg(struct emac_priv *priv)
-{
-	struct phy_device *phydev = priv->ndev->phydev;
-	u32 local_adv, remote_adv;
-	u8 fc;
-
-	local_adv = linkmode_adv_to_lcl_adv_t(phydev->advertising);
-
-	remote_adv = 0;
-
-	if (phydev->pause)
-		remote_adv |= LPA_PAUSE_CAP;
-
-	if (phydev->asym_pause)
-		remote_adv |= LPA_PAUSE_ASYM;
-
-	fc = mii_resolve_flowctrl_fdx(local_adv, remote_adv);
-
-	priv->flow_control_autoneg = true;
-
-	emac_set_fc(priv, fc);
-}
-
 /*
  * Even though this MAC supports gigabit operation, it only provides 32-bit
  * statistics counters. The most overflow-prone counters are the "bytes" ones,
@@ -1425,42 +1358,6 @@ static void emac_ethtool_get_regs(struct net_device *dev,
 			emac_rd(priv, MAC_GLOBAL_CONTROL + i * 4);
 }
 
-static void emac_get_pauseparam(struct net_device *dev,
-				struct ethtool_pauseparam *pause)
-{
-	struct emac_priv *priv = netdev_priv(dev);
-
-	pause->autoneg = priv->flow_control_autoneg;
-	pause->tx_pause = !!(priv->flow_control & FLOW_CTRL_TX);
-	pause->rx_pause = !!(priv->flow_control & FLOW_CTRL_RX);
-}
-
-static int emac_set_pauseparam(struct net_device *dev,
-			       struct ethtool_pauseparam *pause)
-{
-	struct emac_priv *priv = netdev_priv(dev);
-	u8 fc = 0;
-
-	if (!netif_running(dev))
-		return -ENETDOWN;
-
-	priv->flow_control_autoneg = pause->autoneg;
-
-	if (pause->autoneg) {
-		emac_set_fc_autoneg(priv);
-	} else {
-		if (pause->tx_pause)
-			fc |= FLOW_CTRL_TX;
-
-		if (pause->rx_pause)
-			fc |= FLOW_CTRL_RX;
-
-		emac_set_fc(priv, fc);
-	}
-
-	return 0;
-}
-
 static void emac_get_drvinfo(struct net_device *dev,
 			     struct ethtool_drvinfo *info)
 {
@@ -1634,8 +1531,6 @@ static void emac_adjust_link(struct net_device *dev)
 		}
 
 		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
-
-		emac_set_fc_autoneg(priv);
 	}
 
 	phy_print_status(phydev);
@@ -1715,8 +1610,6 @@ static int emac_phy_connect(struct net_device *ndev)
 		goto err_node_put;
 	}
 
-	phy_support_asym_pause(phydev);
-
 	phydev->mac_managed_pm = true;
 
 	emac_update_delay_line(priv);
@@ -1886,9 +1779,6 @@ static const struct ethtool_ops emac_ethtool_ops = {
 	.get_sset_count		= emac_get_sset_count,
 	.get_strings		= emac_get_strings,
 	.get_ethtool_stats	= emac_get_ethtool_stats,
-
-	.get_pauseparam		= emac_get_pauseparam,
-	.set_pauseparam		= emac_set_pauseparam,
 };
 
 static const struct net_device_ops emac_netdev_ops = {

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251124-k1-ethernet-actually-remove-fc-706831770489

Best regards,
-- 
Vivian "dramforever" Wang


