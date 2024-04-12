Return-Path: <netdev+bounces-87351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A258D8A2D64
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589992821CB
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923255C26;
	Fri, 12 Apr 2024 11:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29E5490C
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921311; cv=none; b=a9Hp+/+nptw7k1a4ilxw9W2GoLwBuX5qf7pBbHolAcU8OSOb7uuY9jvLRxxG72rMiZwXCKZiovx2bOAukPp48IZKR8GqIoMnS/zimUEmGht0JoYvSqRmlf6+h0DDMfx1W3KOqY2R7VQq2KZAx85+zba2NnLW/VFz5C0TeqviO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921311; c=relaxed/simple;
	bh=5RlX3Q2SYgheCypPECkURVz+mLexLIiwQ+Pm3OKzYlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3nUasEhwAEbrQhWNLbX3jNfYexf/lQj+zNsawAPPIk48UfbUwYE0AX1apxgtNEv6oM6FF7n7OGBUY6bWpw/yKMz3bdT3DGaFqs/jWzUjgP15T2GTRbduyk+TCstYcukx/SwK413DvukEszeaTEkv3pA9PUBem5LvX6nGF6c8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxqrraGhlmY14mAA--.6646S3;
	Fri, 12 Apr 2024 19:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhPSGhlmSLV4AA--.45677S3;
	Fri, 12 Apr 2024 19:28:22 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com,
	Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH net-next v11 1/6] net: stmmac: Move all PHYLINK MAC capabilities initializations to MAC-specific setup methods
Date: Fri, 12 Apr 2024 19:28:06 +0800
Message-Id: <df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1712917541.git.siyanteng@loongson.cn>
References: <cover.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxrhPSGhlmSLV4AA--.45677S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ZrWftry7Jry7JFy7uF4Dtrc_yoWkWry8pw
	4UAayDur1kJFsxXa1kAw4kZFy3Wa48KF47u3WxG393uFsF9ryqqryY9ay2yF17urWDXay3
	tr40kw1qkFnxJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==

From: Serge Semin <fancer.lancer@gmail.com>

Seeing the Tx-queues-based constraint is DW QoS Eth-specific there is
such reason. It might be better to move the selective Half-duplex
mode disabling to the MAC-specific callback.

But there are a better option to implement the MAC capabilities
detection procedure. Let's see what MAC-capabilities can be currently
specified based on the DW MAC IP-core versions:

DW MAC100: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
	   MAC_10 | MAC_100

DW GMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
         MAC_10 | MAC_100 | MAC_1000

DW QoS Eth: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
            MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD
but if the amount of the active Tx queues is > 1, then:
	   MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
           MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD

DW XGMAC: MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
          MAC_1000FD | MAC_2500FD | MAC_5000FD |
          MAC_10000FD | MAC_25000FD |
          MAC_40000FD | MAC_50000FD |
          MAC_100000FD

As you can see there are only two common capabilities:
MAC_ASYM_PAUSE | MAC_SYM_PAUSE. Seeing the flow-control is implemented
as a callback for each MAC IP-core (see dwmac100_flow_ctrl(),
dwmac1000_flow_ctrl(), sun8i_dwmac_flow_ctrl(), etc) we can freely
move all the PHYLINK MAC capabilities initializations to the
MAC-specific setup methods.

After that the only IP-core which requires the capabilities update will
be DW QoS Eth. So the Tx-queue-based capabilities update can be moved
there and the rest of the xgmac_phylink_get_caps() callback can be
dropped.

We can go further. Instead of calling the
stmmac_set_half_duplex()/stmmac_set_mac_capabilties() methods on the
device init and queues reinit stages, we can move their bodies into
the phylink:mac_get_caps() callback.

Others see:
<https://lore.kernel.org/netdev/cover.1706601050.git.siyanteng@loong
son.cn/T/#m7d724d33faee34fed696e4458d9f6b09b0572e77>

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  2 +
 .../ethernet/stmicro/stmmac/dwmac100_core.c   |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  8 +++-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 15 +++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++-----------
 7 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index f55cf09f0783..9cd62b2110a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -553,6 +553,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
 struct mac_link {
+	u32 caps;
 	u32 speed_mask;
 	u32 speed10;
 	u32 speed100;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index b21d99faa2d0..e1b761dcfa1d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1096,6 +1096,8 @@ static struct mac_device_info *sun8i_dwmac_setup(void *ppriv)
 
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	/* The loopback bit seems to be re-set when link change
 	 * Simply mask it each time
 	 * Speed 10/100/1000 are set in BIT(2)/BIT(3)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 3927609abc44..8555299443f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -539,6 +539,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000;
 	mac->link.duplex = GMAC_CONTROL_DM;
 	mac->link.speed10 = GMAC_CONTROL_PS;
 	mac->link.speed100 = GMAC_CONTROL_PS | GMAC_CONTROL_FES;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
index a6e8d7bd9588..7667d103cd0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -175,6 +175,8 @@ int dwmac100_setup(struct stmmac_priv *priv)
 	dev_info(priv->device, "\tDWMAC100\n");
 
 	mac->pcsr = priv->ioaddr;
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100;
 	mac->link.duplex = MAC_CONTROL_F;
 	mac->link.speed10 = 0;
 	mac->link.speed100 = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cef25efbdff9..70a4ac16d3c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -70,7 +70,11 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 static void dwmac4_phylink_get_caps(struct stmmac_priv *priv)
 {
-	priv->phylink_config.mac_capabilities |= MAC_2500FD;
+	/* Half-Duplex can only work with single tx queue */
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->hw->link.caps |= (MAC_10HD | MAC_100HD | MAC_1000HD);
 }
 
 static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
@@ -1378,6 +1382,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 	mac->link.duplex = GMAC_CONFIG_DM;
 	mac->link.speed10 = GMAC_CONFIG_PS;
 	mac->link.speed100 = GMAC_CONFIG_FES | GMAC_CONFIG_PS;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index e841e312077e..759b9b7a2f3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -47,14 +47,6 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
-static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
-{
-	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
-						 MAC_10000FD | MAC_25000FD |
-						 MAC_40000FD | MAC_50000FD |
-						 MAC_100000FD;
-}
-
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1540,7 +1532,6 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1601,7 +1592,6 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
-	.phylink_get_caps = xgmac_phylink_get_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
@@ -1698,6 +1688,11 @@ int dwxlgmac2_setup(struct stmmac_priv *priv)
 	if (mac->multicast_filter_bins)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD | MAC_25000FD |
+			 MAC_40000FD | MAC_50000FD |
+			 MAC_100000FD;
 	mac->link.duplex = 0;
 	mac->link.speed1000 = XLGMAC_CONFIG_SS_1000;
 	mac->link.speed2500 = XLGMAC_CONFIG_SS_2500;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe3498e86de9..af16efeedf4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
 			priv->pause, tx_cnt);
 }
 
+static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
+					 phy_interface_t interface)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	/* Get the MAC-specific capabilities */
+	stmmac_mac_phylink_get_caps(priv);
+
+	config->mac_capabilities = priv->hw->link.caps;
+
+	if (priv->plat->max_speed)
+		phylink_limit_mac_speed(config, priv->plat->max_speed);
+
+	return config->mac_capabilities;
+}
+
 static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
@@ -1102,6 +1118,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
+	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
@@ -1195,24 +1212,12 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
-static void stmmac_set_half_duplex(struct stmmac_priv *priv)
-{
-	/* Half-Duplex can only work with single tx queue */
-	if (priv->plat->tx_queues_to_use > 1)
-		priv->phylink_config.mac_capabilities &=
-			~(MAC_10HD | MAC_100HD | MAC_1000HD);
-	else
-		priv->phylink_config.mac_capabilities |=
-			(MAC_10HD | MAC_100HD | MAC_1000HD);
-}
-
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *fwnode;
 	struct phylink *phylink;
-	int max_speed;
 
 	priv->phylink_config.dev = &priv->dev->dev;
 	priv->phylink_config.type = PHYLINK_NETDEV;
@@ -1236,19 +1241,6 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
-	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-						MAC_10FD | MAC_100FD |
-						MAC_1000FD;
-
-	stmmac_set_half_duplex(priv);
-
-	/* Get the MAC specific capabilities */
-	stmmac_mac_phylink_get_caps(priv);
-
-	max_speed = priv->plat->max_speed;
-	if (max_speed)
-		phylink_limit_mac_speed(&priv->phylink_config, max_speed);
-
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
@@ -7357,7 +7349,6 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
-	stmmac_set_half_duplex(priv);
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.31.4


