Return-Path: <netdev+bounces-234601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31474C23CDE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0709C3A74D6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C62DF15A;
	Fri, 31 Oct 2025 08:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0922AE45;
	Fri, 31 Oct 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898953; cv=none; b=T7hWSw4vcTg8+tWbMRAUVNKPlGSGn7Yr1Kwevr30gqRYwsUbjT2RVyvxkQR6wO301YV1of5VaPM6hXDsFTLrxOc9KbZyDVeoRIQ89DnRCllvQ1oTHawyqB3blLSEOAg4HCTarawEUSgEn7ng0hux/FHzDdNIzey1IAI0oRjTQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898953; c=relaxed/simple;
	bh=2WMFc0Mx4Ya24QgLOF43oRD/fHWGNVLwN0tCGFbBbRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KmpivfMo+ge+m/TIaqwm1mCombwmqSSziwgbl1aeG+veFiqv0+zotVpRYGeQJQj6IZj3gY4mTDhdutV0J90f+mSc+2BLUTtxtAiX3ZYk6AB6TCGPcQJKPuXEfKt+BHnO4WuPK3yykzEF9mxKuOUfOXRGWsCn4PopYHL4BkmKCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowADHROyocQRpUDO+AA--.4150S2;
	Fri, 31 Oct 2025 16:22:01 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 31 Oct 2025 16:21:53 +0800
Subject: [PATCH net] net: spacemit: Remove broken flow control support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-k1-ethernet-remove-fc-v1-1-1ae3f1d6508c@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAKBxBGkC/y2N7QrCIBSGb0XO705MI7PdSiwwPTYJt3W0EQzvP
 al+Pu/nBpk4UoZebMC0xhznqYHcCXCjne6E0TcG1amj7A4SHxKpjMQTFWRK80oYHBoVvD55Y85
 WQ+suTCG+v7sXaFEYfiLT89U+yt+52Uzo5pRi6cWq99IgO3ndKgy1fgCm9C0SnAAAAA==
X-Change-ID: 20251031-k1-ethernet-remove-fc-82fd67d889a6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowADHROyocQRpUDO+AA--.4150S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry8Kw17JF18ur1rWFWxWFg_yoWxCw1fpF
	W5X3s2yFWDJFsYgFs7Jr4UAFy3Ga4xtr17uFyfC3yFq3ZIyryxZFy8Ka17CFykurW8uryY
	gw4jk3W8GF4DX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Currently, emac_set_pauseparam() will oops if userspace calls it while
the interface is not up. The reason is that if the interface is not up,
phydev may be NULL, but is still accessed in emac_set_fc() and
emac_set_fc_autoneg().

Since the existing flow control implementation is somewhat broken in
general (for example, it doesn't handle autonegotiation properly),
remove it for now to fix the more urgent oops problem. A better
implementation will be sent in future patches.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
This more urgent problem was discovered while trying to fix
emac_set_pauseparam() (v1 of that has already been sent to the mailing
lists [1], but it was still bad), so I decided to send this patch for
the net tree now so that this oops will not happen on 6.18. A future
version of the proper flow control implementation will be sent to
net-next.

[1]: https://lore.kernel.org/spacemit/20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn
---
 drivers/net/ethernet/spacemit/k1_emac.c | 107 --------------------------------
 1 file changed, 107 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index e1c5faff3b71..c85dc742c404 100644
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
@@ -1425,39 +1358,6 @@ static void emac_ethtool_get_regs(struct net_device *dev,
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
@@ -1631,8 +1531,6 @@ static void emac_adjust_link(struct net_device *dev)
 		}
 
 		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
-
-		emac_set_fc_autoneg(priv);
 	}
 
 	phy_print_status(phydev);
@@ -1712,8 +1610,6 @@ static int emac_phy_connect(struct net_device *ndev)
 		goto err_node_put;
 	}
 
-	phy_support_asym_pause(phydev);
-
 	phydev->mac_managed_pm = true;
 
 	emac_update_delay_line(priv);
@@ -1883,9 +1779,6 @@ static const struct ethtool_ops emac_ethtool_ops = {
 	.get_sset_count		= emac_get_sset_count,
 	.get_strings		= emac_get_strings,
 	.get_ethtool_stats	= emac_get_ethtool_stats,
-
-	.get_pauseparam		= emac_get_pauseparam,
-	.set_pauseparam		= emac_set_pauseparam,
 };
 
 static const struct net_device_ops emac_netdev_ops = {

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251031-k1-ethernet-remove-fc-82fd67d889a6

Best regards,
-- 
Vivian "dramforever" Wang


