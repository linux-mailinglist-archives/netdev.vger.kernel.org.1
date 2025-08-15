Return-Path: <netdev+bounces-214194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A5DB28728
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B074B565FEB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085B2BDC24;
	Fri, 15 Aug 2025 20:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF524469B;
	Fri, 15 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289277; cv=none; b=XIf/L83ZxJGWNuB7D0o2+eakJDeHLPCiwihBUewL68O0V6BGppTMpmdWS1D4HPlwyjV0zSCohe3led/PpbMWM81CPcvrsnU36o1stY9J2lPol3yyWWiqC7eFXP65F/B9S5cHggmPa/Ot5u6wKfIWP/hmXxU/2yZUXKIC127ftME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289277; c=relaxed/simple;
	bh=a56J/hX0dvx3XXQ5qITo7PJAzDEu7G1nh8NjTUz9lGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moCVe5/jkqVPnTI6qC8sQRxhwT3RTJueF8bA3jvAM6IvsrE76crLH2H/fZR6Tdg42l/rxe2ZDmZeG/WTRV6RvwO5mEGmKbxIkUuhN1DychdfN4GEbWULZGU6wC3wvqclff1dpvT/69cJBCrkJnyjC1Bu4DNOxq+PlPxnBMXlZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 933F1586B48;
	Fri, 15 Aug 2025 19:49:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65EC6442AF;
	Fri, 15 Aug 2025 19:49:45 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Rob Landley <rob@landley.net>,
	Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Date: Fri, 15 Aug 2025 21:48:06 +0200
Message-ID: <20250815194806.1202589-4-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194806.1202589-1-contact@artur-rojek.eu>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetrhhtuhhrucftohhjvghkuceotghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghuqeenucggtffrrghtthgvrhhnpeegtdeiveejffdvheffieeiheejtddutefhgffhfedvveefteetvefhteeltdduhfenucfkphepfedurddufedtrddutdefrdduvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurddufedtrddutdefrdduvdelpdhhvghlohepphgtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepu
 ggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: contact@artur-rojek.eu

Add support for the Ethernet Media Access Controller found in the J-Core
family of SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/net/ethernet/Kconfig      |  12 +
 drivers/net/ethernet/Makefile     |   1 +
 drivers/net/ethernet/jcore_emac.c | 391 ++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+)
 create mode 100644 drivers/net/ethernet/jcore_emac.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..0d55d8794f47 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -159,6 +159,18 @@ config ETHOC
 	help
 	  Say Y here if you want to use the OpenCores 10/100 Mbps Ethernet MAC.
 
+config JCORE_EMAC
+	tristate "J-Core Ethernet MAC support"
+	depends on CPU_J2 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	help
+	  This enables support for the Ethernet Media Access Controller found
+	  in the J-Core family of SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called jcore_emac.
+
 config OA_TC6
 	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
 	depends on SPI
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 67182339469a..e1e03a1d47a6 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
 obj-$(CONFIG_NET_VENDOR_I825XX) += i825xx/
 obj-$(CONFIG_NET_VENDOR_MICROSOFT) += microsoft/
 obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
+obj-$(CONFIG_JCORE_EMAC) += jcore_emac.o
 obj-$(CONFIG_JME) += jme.o
 obj-$(CONFIG_KORINA) += korina.o
 obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
diff --git a/drivers/net/ethernet/jcore_emac.c b/drivers/net/ethernet/jcore_emac.c
new file mode 100644
index 000000000000..fbfac4b16d6d
--- /dev/null
+++ b/drivers/net/ethernet/jcore_emac.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ethernet MAC driver for the J-Core family of SoCs.
+ * Based on SEI MAC driver by Oleksandr G Zhadan / Smart Energy Instruments Inc.
+ * Copyright (c) 2025 Artur Rojek <contact@artur-rojek.eu>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/etherdevice.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define	JCORE_EMAC_CONTROL		0x0
+#define	JCORE_EMAC_TX_LEN		0x4
+#define	JCORE_EMAC_MACL			0x8
+#define	JCORE_EMAC_MACH			0xc
+#define	JCORE_EMAC_MCAST_MASK(n)	(0x60 + ((n) * 4))
+#define	JCORE_EMAC_RX_BUF		0x1000
+#define	JCORE_EMAC_TX_BUF		0x1800
+
+#define	JCORE_EMAC_ENABLE_RX		BIT(1)
+#define	JCORE_EMAC_BUSY			BIT(2)
+#define	JCORE_EMAC_MCAST		BIT(3)
+#define	JCORE_EMAC_READ			BIT(4)
+#define	JCORE_EMAC_ENABLE_INT_RX	BIT(5)
+#define	JCORE_EMAC_ENABLE_INT_TX	BIT(6)
+#define	JCORE_EMAC_PROMISC		BIT(7)
+#define	JCORE_EMAC_COMPLETE		BIT(8)
+#define	JCORE_EMAC_CRC_ERR		BIT(9)
+#define	JCORE_EMAC_PKT_LEN		GENMASK(26, 16)
+
+#define	JCORE_EMAC_RX_BUFFERS		4
+#define	JCORE_EMAC_TX_TIMEOUT		(2 * USEC_PER_SEC)
+#define	JCORE_EMAC_MCAST_ADDRS		4
+
+struct jcore_emac {
+	void __iomem *base;
+	struct regmap *map;
+	struct net_device *ndev;
+	struct {
+		struct u64_stats_sync syncp;
+		u64 rx_packets;
+		u64 tx_packets;
+		u64 rx_bytes;
+		u64 tx_bytes;
+		u64 rx_dropped;
+		u64 rx_errors;
+		u64 rx_crc_errors;
+	} stats;
+};
+
+static irqreturn_t jcore_emac_irq(int irq, void *data)
+{
+	struct jcore_emac *priv = data;
+	struct net_device *ndev = priv->ndev;
+	struct sk_buff *skb;
+	struct {
+		int packets;
+		int bytes;
+		int dropped;
+		int crc_errors;
+	} stats = {};
+	unsigned int status, pkt_len, i;
+
+	for (i = 0; i < JCORE_EMAC_RX_BUFFERS; i++) {
+		regmap_read(priv->map, JCORE_EMAC_CONTROL, &status);
+
+		if (!(status & JCORE_EMAC_COMPLETE))
+			break;
+
+		/* Handle the next RX ping-pong buffer. */
+		if (status & JCORE_EMAC_CRC_ERR) {
+			stats.dropped++;
+			stats.crc_errors++;
+			goto next;
+		}
+
+		skb = netdev_alloc_skb_ip_align(ndev, ndev->mtu +
+						ETH_HLEN + ETH_FCS_LEN);
+		if (!skb) {
+			stats.dropped++;
+			goto next;
+		}
+
+		pkt_len = FIELD_GET(JCORE_EMAC_PKT_LEN, status);
+		skb_put(skb, pkt_len);
+
+		memcpy_fromio(skb->data, priv->base + JCORE_EMAC_RX_BUF,
+			      pkt_len);
+		skb->dev = ndev;
+		skb->protocol = eth_type_trans(skb, ndev);
+
+		stats.packets++;
+		stats.bytes += pkt_len;
+
+		netif_rx(skb);
+
+next:
+		regmap_set_bits(priv->map, JCORE_EMAC_CONTROL, JCORE_EMAC_READ);
+	}
+
+	u64_stats_update_begin(&priv->stats.syncp);
+	priv->stats.rx_packets += stats.packets;
+	priv->stats.rx_bytes += stats.bytes;
+	priv->stats.rx_dropped += stats.dropped;
+	priv->stats.rx_crc_errors += stats.crc_errors;
+	priv->stats.rx_errors += stats.crc_errors;
+	u64_stats_update_end(&priv->stats.syncp);
+
+	return IRQ_HANDLED;
+}
+
+static int jcore_emac_wait(struct jcore_emac *priv)
+{
+	unsigned int val;
+
+	return regmap_read_poll_timeout(priv->map, JCORE_EMAC_CONTROL, val,
+					!(val & JCORE_EMAC_BUSY),
+					100, JCORE_EMAC_TX_TIMEOUT);
+}
+
+static void jcore_emac_reset(struct jcore_emac *priv)
+{
+	regmap_write(priv->map, JCORE_EMAC_CONTROL, 0);
+	usleep_range(10, 20);
+}
+
+static int jcore_emac_open(struct net_device *ndev)
+{
+	struct jcore_emac *priv = netdev_priv(ndev);
+
+	if (jcore_emac_wait(priv))
+		return -ETIMEDOUT;
+
+	jcore_emac_reset(priv);
+	regmap_set_bits(priv->map, JCORE_EMAC_CONTROL,
+			JCORE_EMAC_ENABLE_RX | JCORE_EMAC_ENABLE_INT_RX |
+			JCORE_EMAC_READ);
+	regmap_clear_bits(priv->map, JCORE_EMAC_CONTROL, JCORE_EMAC_BUSY);
+
+	netif_start_queue(ndev);
+	netif_carrier_on(ndev);
+
+	return 0;
+}
+
+static int jcore_emac_close(struct net_device *ndev)
+{
+	struct jcore_emac *priv = netdev_priv(ndev);
+
+	netif_stop_queue(ndev);
+	netif_carrier_off(ndev);
+
+	if (jcore_emac_wait(priv))
+		return -ETIMEDOUT;
+
+	jcore_emac_reset(priv);
+
+	return 0;
+}
+
+static int jcore_emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct jcore_emac *priv = netdev_priv(ndev);
+	unsigned int tx_len;
+
+	if (jcore_emac_wait(priv))
+		return NETDEV_TX_BUSY;
+
+	memcpy_toio(priv->base + JCORE_EMAC_TX_BUF, skb->data, skb->len);
+
+	tx_len = max(skb->len, 60);
+	regmap_write(priv->map, JCORE_EMAC_TX_LEN, tx_len);
+	regmap_set_bits(priv->map, JCORE_EMAC_CONTROL, JCORE_EMAC_BUSY);
+
+	u64_stats_update_begin(&priv->stats.syncp);
+	priv->stats.tx_packets++;
+	priv->stats.tx_bytes += skb->len;
+	u64_stats_update_end(&priv->stats.syncp);
+
+	consume_skb(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static void jcore_emac_set_rx_mode(struct net_device *ndev)
+{
+	struct jcore_emac *priv = netdev_priv(ndev);
+	struct netdev_hw_addr *ha;
+	unsigned int reg, i, idx = 0, set_mask = 0, clear_mask = 0, addr = 0;
+
+	if (ndev->flags & IFF_PROMISC)
+		set_mask |= JCORE_EMAC_PROMISC;
+	else
+		clear_mask |= JCORE_EMAC_PROMISC;
+
+	if (ndev->flags & IFF_ALLMULTI)
+		set_mask |= JCORE_EMAC_MCAST;
+	else
+		clear_mask |= JCORE_EMAC_MCAST;
+
+	regmap_update_bits(priv->map, JCORE_EMAC_CONTROL, set_mask | clear_mask,
+			   set_mask);
+
+	if (!(ndev->flags & IFF_MULTICAST))
+		return;
+
+	netdev_for_each_mc_addr(ha, ndev) {
+		/* Only the first 3 octets are used in a hardware mcast mask. */
+		memcpy(&addr, ha->addr, 3);
+
+		for (i = 0; i < idx; i++) {
+			regmap_read(priv->map, JCORE_EMAC_MCAST_MASK(i), &reg);
+			if (reg == addr)
+				goto next_ha;
+		}
+
+		regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(idx), addr);
+		if (++idx >= JCORE_EMAC_MCAST_ADDRS) {
+			netdev_warn(ndev, "Multicast list limit reached\n");
+			break;
+		}
+next_ha:
+	}
+
+	/* Clear the remaining mask entries. */
+	for (i = idx; i < JCORE_EMAC_MCAST_ADDRS; i++)
+		regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(i), 0);
+}
+
+static void jcore_emac_read_hw_addr(struct jcore_emac *priv, u8 *addr)
+{
+	unsigned int val;
+
+	regmap_read(priv->map, JCORE_EMAC_MACL, &val);
+	addr[5] = val;
+	addr[4] = val >> 8;
+	addr[3] = val >> 16;
+	addr[2] = val >> 24;
+	regmap_read(priv->map, JCORE_EMAC_MACH, &val);
+	addr[1] = val;
+	addr[0] = val >> 8;
+}
+
+static void jcore_emac_write_hw_addr(struct jcore_emac *priv, u8 *addr)
+{
+	unsigned int val;
+
+	val = addr[0] << 8 | addr[1];
+	regmap_write(priv->map, JCORE_EMAC_MACH, val);
+
+	val = addr[2] << 24 | addr[3] << 16 | addr[4] << 8 | addr[5];
+	regmap_write(priv->map, JCORE_EMAC_MACL, val);
+}
+
+static int jcore_emac_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct jcore_emac *priv = netdev_priv(ndev);
+	struct sockaddr *sa = addr;
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(ndev, addr);
+	if (ret)
+		return ret;
+
+	jcore_emac_write_hw_addr(priv, sa->sa_data);
+	eth_hw_addr_set(ndev, sa->sa_data);
+
+	return 0;
+}
+
+static void jcore_emac_get_stats64(struct net_device *ndev,
+				   struct rtnl_link_stats64 *stats)
+{
+	struct jcore_emac *priv = netdev_priv(ndev);
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->stats.syncp);
+		stats->rx_packets = priv->stats.rx_packets;
+		stats->tx_packets = priv->stats.tx_packets;
+		stats->rx_bytes = priv->stats.rx_bytes;
+		stats->tx_bytes = priv->stats.tx_bytes;
+		stats->rx_dropped = priv->stats.rx_dropped;
+		stats->rx_errors = priv->stats.rx_errors;
+		stats->rx_crc_errors = priv->stats.rx_crc_errors;
+	} while (u64_stats_fetch_retry(&priv->stats.syncp, start));
+}
+
+static const struct net_device_ops jcore_emac_netdev_ops = {
+	.ndo_open = jcore_emac_open,
+	.ndo_stop = jcore_emac_close,
+	.ndo_start_xmit = jcore_emac_start_xmit,
+	.ndo_set_rx_mode = jcore_emac_set_rx_mode,
+	.ndo_set_mac_address = jcore_emac_set_mac_address,
+	.ndo_get_stats64 = jcore_emac_get_stats64,
+};
+
+static const struct regmap_config jcore_emac_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = JCORE_EMAC_MCAST_MASK(3),
+	.fast_io = true, /* Force spinlock for JCORE_EMAC_CONTROL ISR access. */
+};
+
+static int jcore_emac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct jcore_emac *priv;
+	struct net_device *ndev;
+	u8 mac[ETH_ALEN];
+	unsigned int i;
+	int irq, ret;
+
+	ndev = devm_alloc_etherdev(dev, sizeof(*priv));
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+
+	priv = netdev_priv(ndev);
+	priv->ndev = ndev;
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->map = devm_regmap_init_mmio(dev, priv->base,
+					  &jcore_emac_regmap_cfg);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	platform_set_drvdata(pdev, ndev);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, jcore_emac_irq, 0, dev_name(dev),
+			       priv);
+	if (ret < 0)
+		return ret;
+
+	ndev->watchdog_timeo = usecs_to_jiffies(JCORE_EMAC_TX_TIMEOUT);
+	ndev->netdev_ops = &jcore_emac_netdev_ops;
+
+	/* Put hardware into a known state. */
+	jcore_emac_reset(priv);
+	for (i = 0; i < JCORE_EMAC_MCAST_ADDRS; i++)
+		regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(i), 0);
+
+	jcore_emac_read_hw_addr(priv, mac);
+	if (is_zero_ether_addr(mac)) {
+		eth_random_addr(mac);
+		jcore_emac_write_hw_addr(priv, mac);
+	}
+	eth_hw_addr_set(ndev, mac);
+
+	ret = devm_register_netdev(dev, ndev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to register netdev\n");
+
+	return 0;
+}
+
+static const struct of_device_id jcore_emac_of_match[] = {
+	{ .compatible = "jcore,emac", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, jcore_emac_of_match);
+
+static struct platform_driver jcore_emac_driver = {
+	.driver = {
+		.name = "jcore-emac",
+		.of_match_table = jcore_emac_of_match,
+	},
+	.probe = jcore_emac_probe,
+};
+
+module_platform_driver(jcore_emac_driver);
+MODULE_DESCRIPTION("Ethernet MAC driver for the J-Core family of SoCs");
+MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
+MODULE_LICENSE("GPL");
-- 
2.50.1


