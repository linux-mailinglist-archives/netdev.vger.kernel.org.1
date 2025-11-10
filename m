Return-Path: <netdev+bounces-237151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74FC4628A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198031895D72
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104430C60B;
	Mon, 10 Nov 2025 11:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461630BB8F;
	Mon, 10 Nov 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773016; cv=none; b=krhPY4LiiO9d+1kXdgA3x1xcjVmo5fx0KuPFDmZRvJBT5g1ICXmpvosgEE5WbBrlnGnC05z4KG1lF+1ApJ62PnHNYce7lAMLxYbL63joma8IPYlHf6kevEuFLTx6JSH3SLcYjhMLQmURntI/8r82oEG97yIr5vWWPrFCmJw4qFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773016; c=relaxed/simple;
	bh=86E1tmDnqxW676P46rlqb0ZTP5Jjau+psLSHnvkWES8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Boo8zuH/awJG4bZVlKyYw3UkdvvhXN/6Q8n3Aqrsis5sg3JoF79mVEy8xIH3+BjY0bDjgTDdLmU30QyfUBTTyTZc06ibubaPwtM0k/3M0icsdTtKbfnO9DR6Z/XhViVCDbn5qIteA391ZqPhMcJrDkrmcTy0MaNaTB3TjoOO528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 10 Nov
 2025 19:09:56 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 10 Nov 2025 19:09:56 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 10 Nov 2025 19:09:28 +0800
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
In-Reply-To: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762772996; l=8377;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=86E1tmDnqxW676P46rlqb0ZTP5Jjau+psLSHnvkWES8=;
 b=r8e9agtlYPZOR9Iz4O2IGKSeJbhLQRq18IOsxKQeLXKYnb84azuu3jZdwOdDhVHfZU5J60eg/
 VP5/pAt6HQdCvTHqNSo3Mdu/ZeXcdEo4MYs3Dd1OPt0e5Nu9IIb83HL
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

On the AST2600 platform, the RGMII delay is controlled via the
SCU registers. The delay chain configuration differs between MAC0/1
and MAC2/3, even though all four MACs use a 32-stage delay chain.
+------+----------+-----------+-------------+-------------+
|      |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
+------+----------+-----------+-------------+-------------+
|MAC0/1|     45 ps|        32 |           0 |           0 |
+------+----------+-----------+-------------+-------------+
|MAC2/3|    250 ps|        32 |           0 |          26 |
+------+----------+-----------+-------------+-------------+
For MAC2/3, the "no delay" condition starts from stage 26.
Setting the RX delay stage to 26 means that no additional RX
delay is applied.
Here lists the RX delay setting of MAC2/3 below.
26 -> 0   ns, 27 -> 0.25 ns, ... , 31 -> 1.25 ns,
0  -> 1.5 ns, 1  -> 1.75 ns, ... , 25 -> 7.75 ns

Therefore, we calculate the delay stage from the
rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel
to or bigger than 32, the delay stage will be mask 0x1f to get
the correct setting.
The delay chain is like a ring for configuration.
Example for the rx-internal-delay-ps of MAC2/3 is 2000 ps,
we will get the delay stage is 2.

Strating to this patch, driver will remind the legacy dts to update the
"phy-mode" to "rgmii-id, and add the corresponding rgmii delay with
"rx-internal-delay-id" and "tx-internal-delay-id".
If lack these properties, driver will configure the default rgmii delay,
that means driver will disable the TX and RX delay in MAC side.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 148 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h |  20 +++++
 2 files changed, 168 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a863f7841210..5cecdd4583f6 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -26,6 +26,9 @@
 #include <linux/if_vlan.h>
 #include <linux/of_net.h>
 #include <linux/phy_fixed.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
 
@@ -1833,6 +1836,146 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
+					     u32 rgmii_tx_delay,
+					     u32 rgmii_rx_delay)
+{
+	struct device *dev = priv->dev;
+	struct device_node *np;
+	u32 rgmii_delay_unit;
+	u32 rx_delay_index;
+	u32 tx_delay_index;
+	struct regmap *scu;
+	int dly_mask;
+	int dly_reg;
+	int mac_id;
+	int ret;
+
+	np = dev->of_node;
+
+	/* Add a warning to notify the existed dts based on AST2600. It is
+	 * recommended to update the dts to add the rx/tx-internal-delay-ps to
+	 * specify the RGMII delay and we recommend using the "rgmii-id" for
+	 * phy-mode property to tell the PHY enables TX/RX internal delay and
+	 * add the corresponding rx/tx-internal-delay-ps properties.
+	 */
+	if (priv->netdev->phydev->interface != PHY_INTERFACE_MODE_RGMII_ID)
+		dev_warn(dev, "Update the phy-mode to 'rgmii-id'.\n");
+
+	scu = syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
+	if (IS_ERR(scu)) {
+		dev_err(dev, "failed to get aspeed,scu");
+		return PTR_ERR(scu);
+	}
+
+	ret = of_property_read_u32(np, "aspeed,rgmii-delay-ps",
+				   &rgmii_delay_unit);
+	if (ret) {
+		dev_err(dev, "failed to get aspeed,rgmii-delay-ps value\n");
+		return -EINVAL;
+	}
+
+	/* According to the register base address to specify the corresponding
+	 * values.
+	 */
+	switch (priv->res->start) {
+	case AST2600_MAC0_BASE_ADDR:
+		mac_id = 0;
+		break;
+	case AST2600_MAC1_BASE_ADDR:
+		mac_id = 1;
+		break;
+	case AST2600_MAC2_BASE_ADDR:
+		mac_id = 2;
+		break;
+	case AST2600_MAC3_BASE_ADDR:
+		mac_id = 3;
+		break;
+	default:
+		dev_err(dev, "Invalid mac base address");
+		return -EINVAL;
+	}
+
+	if (mac_id == 0 || mac_id == 1) {
+		if (rgmii_delay_unit != AST2600_MAC01_CLK_DLY_UNIT) {
+			dev_err(dev, "aspeed,rgmii-delay-ps %u is invalid\n",
+				rgmii_delay_unit);
+			return -EINVAL;
+		}
+		dly_reg = AST2600_MAC01_CLK_DLY;
+	} else {
+		if (rgmii_delay_unit != AST2600_MAC23_CLK_DLY_UNIT) {
+			dev_err(dev, "aspeed,rgmii-delay-ps %u is invalid\n",
+				rgmii_delay_unit);
+			return -EINVAL;
+		}
+		dly_reg = AST2600_MAC23_CLK_DLY;
+	}
+
+	tx_delay_index = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
+	if (tx_delay_index >= 32) {
+		dev_err(dev, "The %u ps of TX delay is out of range\n",
+			rgmii_tx_delay);
+		return -EINVAL;
+	}
+
+	rx_delay_index = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
+	if (rx_delay_index >= 32) {
+		dev_err(dev, "The %u ps of RX delay is out of range\n",
+			rgmii_rx_delay);
+		return -EINVAL;
+	}
+
+	/* Due to the hardware design reason, for MAC2/3 on AST2600, the zero
+	 * delay ns on RX is configured by setting value 0x1a.
+	 * List as below:
+	 * 0x1a -> 0   ns, 0x1b -> 0.25 ns, ... , 0x1f -> 1.25 ns,
+	 * 0x00 -> 1.5 ns, 0x01 -> 1.75 ns, ... , 0x19 -> 7.75 ns, 0x1a -> 0 ns
+	 */
+	if (mac_id == 2 || mac_id == 3)
+		rx_delay_index = (AST2600_MAC23_RX_DLY_0_NS + rx_delay_index) &
+				 AST2600_MAC_TX_RX_DLY_MASK;
+
+	if (mac_id == 0 || mac_id == 2) {
+		dly_mask = ASPEED_MAC0_2_TX_DLY | ASPEED_MAC0_2_RX_DLY;
+		tx_delay_index = FIELD_PREP(ASPEED_MAC0_2_TX_DLY, tx_delay_index);
+		rx_delay_index = FIELD_PREP(ASPEED_MAC0_2_RX_DLY, rx_delay_index);
+	} else {
+		dly_mask = ASPEED_MAC1_3_TX_DLY | ASPEED_MAC1_3_RX_DLY;
+		tx_delay_index = FIELD_PREP(ASPEED_MAC1_3_TX_DLY, tx_delay_index);
+		rx_delay_index = FIELD_PREP(ASPEED_MAC1_3_RX_DLY, rx_delay_index);
+	}
+
+	regmap_update_bits(scu, dly_reg, dly_mask, tx_delay_index | rx_delay_index);
+
+	return 0;
+}
+
+static int ftgmac100_set_internal_delay(struct ftgmac100 *priv)
+{
+	struct device_node *np = priv->dev->of_node;
+	u32 rgmii_tx_delay;
+	u32 rgmii_rx_delay;
+	int err;
+
+	if (!(of_device_is_compatible(np, "aspeed,ast2600-mac")))
+		return 0;
+
+	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay))
+		/* Default to 0 ps delay */
+		rgmii_tx_delay = 0;
+
+	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay))
+		/* Default to 0 ps delay */
+		rgmii_rx_delay = 0;
+
+	err = ftgmac100_set_ast2600_rgmii_delay(priv,
+						rgmii_tx_delay,
+						rgmii_rx_delay);
+
+	return err;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2004,6 +2147,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
+
+		/* Configure RGMII delay if there are the corresponding compatibles */
+		err = ftgmac100_set_internal_delay(priv);
+		if (err)
+			goto err_phy_connect;
 	}
 
 	/* Default ring sizes */
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..d19d44d1b8e0 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -271,4 +271,24 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
 
+/* Aspeed SCU */
+#define AST2600_MAC01_CLK_DLY	0x340
+#define AST2600_MAC23_CLK_DLY	0x350
+#define AST2600_MAC01_CLK_DLY_UNIT	45	/* ps */
+#define AST2600_MAC01_TX_DLY_0_NS	0
+#define AST2600_MAC01_RX_DLY_0_NS	0
+#define AST2600_MAC23_CLK_DLY_UNIT	250	/* ps */
+#define AST2600_MAC23_TX_DLY_0_NS	0
+#define AST2600_MAC23_RX_DLY_0_NS	0x1a
+#define AST2600_MAC_TX_RX_DLY_MASK	0x1f
+#define ASPEED_MAC0_2_TX_DLY		GENMASK(5, 0)
+#define ASPEED_MAC0_2_RX_DLY		GENMASK(17, 12)
+#define ASPEED_MAC1_3_TX_DLY		GENMASK(11, 6)
+#define ASPEED_MAC1_3_RX_DLY		GENMASK(23, 18)
+
+#define AST2600_MAC0_BASE_ADDR		0x1e660000
+#define AST2600_MAC1_BASE_ADDR		0x1e680000
+#define AST2600_MAC2_BASE_ADDR		0x1e670000
+#define AST2600_MAC3_BASE_ADDR		0x1e690000
+
 #endif /* __FTGMAC100_H */

-- 
2.34.1


