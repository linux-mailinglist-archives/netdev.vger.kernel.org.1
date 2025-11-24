Return-Path: <netdev+bounces-241095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711DC7EFEF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 06:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6B2B344A45
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 05:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C062BDC1C;
	Mon, 24 Nov 2025 05:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAA28850B;
	Mon, 24 Nov 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763962167; cv=none; b=Iqf6Qe6JoeqCFkO7uKYOLqaBIlpd+40X8Kh1JCl/tIny/UcQaPx1+lHczJ3N0jJness14Pol4D+uhfPKLLxUMsP7sZ0tVv7X06j+oOipJ6YnoHN2DpHo/zr8yrPSl/GpzsRrDVZYE7ufeeKC6TtWtA9OLKNBjsEFlN6QJG1oz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763962167; c=relaxed/simple;
	bh=4Ar0Ce/7CI/bXhZYfPTIVvbKKA37/EI2x/2Kuj07W4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bBnPCCW1tU9S2iw7vinm0wE0NIfLo0pRoXSZIUWKsElChKeonExpNJmQdLYMKnCktcJ3OHYEHIy35QvgJTYySbzseulRkTS4MLblZmPYKczgHNIrkatm2HzJ86IXJU3c8ildJQQ+IbXVNMiYowvPjnml49vgUnQYYVVJXp5CJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowACXnW4E7SNpt23VAQ--.20861S2;
	Mon, 24 Nov 2025 13:28:38 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 24 Nov 2025 13:28:27 +0800
Subject: [PATCH net-next v2] net: spacemit: Remove broken flow control
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-k1-ethernet-actually-remove-fc-v2-1-5e77ab69b791@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAPrsI2kC/y2N2w6CMBAFf4Xss2toxYL8isGk1kUaoeC2NBjCv
 1svj5PJObOCJ7bkoc5WYIrW29ElkLsMTKfdndDeEoPM5VEIWeBDIIWO2FFAbcKs+/6FTMMYCVu
 DZa6qgyjLvKhOkE4mptYu38AZPhtHS4DmZ5iecyqGv75qT2jGYbChzqLaiwrZqMu6QbNtbxBH/
 XGqAAAA
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
X-CM-TRANSID:zQCowACXnW4E7SNpt23VAQ--.20861S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4rKr48Zw48GFy7AFW7twb_yoWxGw4kpF
	W5X3s2yF4UXFsYgFs3Jw4UAFy3Ga4xtrnruFyfCw4Fg3ZIyr97CFy0k3W7CFykurW8WryY
	gw4jy3W8GF4DX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The current flow control implementation doesn't handle autonegotiation
and ethtool operations properly. Remove it for now so we don't claim
support for something that doesn't really work. A better implementation
will be sent in future patches.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Starting at v2 as this is the net-next successor of:

  https://lore.kernel.org/spacemit/20251031-k1-ethernet-remove-fc-v1-1-1ae3f1d6508c@iscas.ac.cn/
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
base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
change-id: 20251124-k1-ethernet-actually-remove-fc-706831770489

Best regards,
-- 
Vivian "dramforever" Wang


