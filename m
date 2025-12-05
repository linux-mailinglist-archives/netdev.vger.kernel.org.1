Return-Path: <netdev+bounces-243773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D02A0CA7047
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 10:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4541F3039791
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DD330318;
	Fri,  5 Dec 2025 09:53:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0732571F;
	Fri,  5 Dec 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928435; cv=none; b=eqYEhJWVJLv0xvriDMQ+NkKxRRm5D0597+GY8rJJ8Qublhs+8DtnQ1Dqe19JRp/7zOggDKziPevltR431j+h1dGSai3jzujgYieO8CxOLmEXUpnPcuwgEiDEFJsONNbrq6vmwm2Ssp0CDtgvfsT/MjgY0xumdDY4O9G9kLyvvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928435; c=relaxed/simple;
	bh=F8KLqImEZAalXrga1YI1cCa2EOaywG6k/v7O4jfo6/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fCOcRmFF61NqKgPVzTk/E/LsviDy07YTHuVvtU/6Bk6lrvY59mqI7DSblMGPVk4VTh5lU0UFpJxeburL90GSe/45NDOgWyXw7urud9aibjAXEAmY4CkZLMEUomXhUDnE25bh4LJ7qflZzj6y/dGV5D9OsQR1n02ftjkzvhxcqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 17:53:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 17:53:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 5 Dec 2025 17:53:17 +0800
Subject: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
In-Reply-To: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764928395; l=13022;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=F8KLqImEZAalXrga1YI1cCa2EOaywG6k/v7O4jfo6/o=;
 b=rnP/GgBKTUUSxJrv5/TuF57nqPsUUmikDiFm1G0PEdQda1YTYXrGgksW29GAncDuBSgp7IR3o
 c0umxQpYBcADIAX9kljMVtQdTVo8pCDQig6IHe2AfbuP47mpDJOJ+HT
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
"phy-mode" to "rgmii-id, and if necessary, add small
"rx-internal-delay-ps" and "tx-internal-delay-ps.
If lack the two properties, driver will accord to the original delay
value from bootloader to disable RGMII delay and to change the phy
interface to phy driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 288 ++++++++++++++++++++++++++++++-
 drivers/net/ethernet/faraday/ftgmac100.h |  25 +++
 2 files changed, 311 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a863f7841210..bf92dc0b7260 100644
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
 
@@ -1833,12 +1836,281 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static int ftgmac100_get_ast2600_rgmii_flag(u32 delay)
+{
+	if ((delay > 500 && delay < 1500) ||
+	    (delay > 2500 && delay < 7500))
+		return AST2600_RGMII_KEEP_DELAY;
+
+	return AST2600_RGMII_DIS_DELAY;
+}
+
+static int ftgmac100_check_ast2600_rgmii_delay(struct regmap *scu,
+					       u32 delay_unit,
+					       int mac_id, int dly_reg)
+{
+	u32 delay_value;
+	u32 tx_delay;
+	u32 rx_delay;
+	int tx_flag;
+	int rx_flag;
+
+	regmap_read(scu, dly_reg, &delay_value);
+	if (mac_id == 0 || mac_id == 2) {
+		tx_delay = FIELD_GET(ASPEED_MAC0_2_TX_DLY, delay_value);
+		rx_delay = FIELD_GET(ASPEED_MAC0_2_RX_DLY, delay_value);
+	} else {
+		tx_delay = FIELD_GET(ASPEED_MAC1_3_TX_DLY, delay_value);
+		rx_delay = FIELD_GET(ASPEED_MAC1_3_RX_DLY, delay_value);
+	}
+
+	/* Due to the hardware design reason, for MAC2/3 on AST2600,
+	 * the zero delay ns on RX is configured by setting value 0x1a.
+	 * List as below:
+	 * 0x1a, 0x1b, ... , 0x1f, 0x00, 0x01, ... , 0x19
+	 * Covert for calculation purpose.
+	 * 0x00, 0x01, ... , 0x19, 0x1a, 0x1b, ... , 0x1f
+	 */
+	if (mac_id == 2 || mac_id == 3)
+		rx_delay = (rx_delay + 0x06) & 0x1f;
+
+	tx_delay *= delay_unit;
+	rx_delay *= delay_unit;
+
+	tx_flag = ftgmac100_get_ast2600_rgmii_flag(tx_delay);
+	rx_flag = ftgmac100_get_ast2600_rgmii_flag(rx_delay);
+
+	if (tx_flag == AST2600_RGMII_KEEP_DELAY ||
+	    rx_flag == AST2600_RGMII_KEEP_DELAY) {
+		return AST2600_RGMII_KEEP_DELAY;
+	}
+
+	return AST2600_RGMII_DIS_DELAY;
+}
+
+static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
+					     s32 rgmii_tx_delay,
+					     s32 rgmii_rx_delay,
+					     phy_interface_t *phy_intf)
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
+
+	np = dev->of_node;
+
+	scu = syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
+	if (IS_ERR(scu)) {
+		dev_err(dev, "failed to get aspeed,scu");
+		return PTR_ERR(scu);
+	}
+
+	/* According to the register base address to specify the corresponding
+	 * values.
+	 */
+	switch (priv->res->start) {
+	case AST2600_MAC0_BASE_ADDR:
+		mac_id = 0;
+		rgmii_delay_unit = AST2600_MAC01_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC01_CLK_DLY;
+		break;
+	case AST2600_MAC1_BASE_ADDR:
+		mac_id = 1;
+		rgmii_delay_unit = AST2600_MAC01_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC01_CLK_DLY;
+		break;
+	case AST2600_MAC2_BASE_ADDR:
+		mac_id = 2;
+		rgmii_delay_unit = AST2600_MAC23_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC23_CLK_DLY;
+		break;
+	case AST2600_MAC3_BASE_ADDR:
+		mac_id = 3;
+		rgmii_delay_unit = AST2600_MAC23_CLK_DLY_UNIT;
+		dly_reg = AST2600_MAC23_CLK_DLY;
+		break;
+	default:
+		dev_err(dev, "Invalid mac base address");
+		return -EINVAL;
+	}
+
+	if (of_phy_is_fixed_link(np)) {
+		if (rgmii_tx_delay < 0 || rgmii_rx_delay < 0) {
+			dev_err(dev,
+				"Add rx/tx-internal-delay-ps for fixed-link\n");
+			/* Keep original RGMII delay value*/
+			return 0;
+		}
+
+		/* Must have both of rx/tx-internal-delay-ps for fixed-link */
+		goto conf_delay;
+	}
+
+	if (*phy_intf == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    *phy_intf == PHY_INTERFACE_MODE_RGMII_TXID)
+		goto out_warn;
+
+	if (*phy_intf != PHY_INTERFACE_MODE_RGMII &&
+	    *phy_intf != PHY_INTERFACE_MODE_RGMII_ID)
+		return 0;
+
+	/* Both rx/tx-internal-delay-ps are not existed. */
+	if (rgmii_tx_delay < 0 && rgmii_rx_delay < 0) {
+		int flag;
+
+		flag = ftgmac100_check_ast2600_rgmii_delay(scu,
+							   rgmii_delay_unit,
+							   mac_id,
+							   dly_reg);
+		if (flag == AST2600_RGMII_KEEP_DELAY)
+			goto out_warn;
+
+		if (*phy_intf == PHY_INTERFACE_MODE_RGMII) {
+			dev_err(dev, "Update phy-mode to 'rgmii-id'\n");
+			/* Forced phy interface to RGMII_ID and MAC will disable
+			 * RGMII delay.
+			 */
+			*phy_intf = PHY_INTERFACE_MODE_RGMII_ID;
+		}
+	} else {
+		/* Please refer to ethernet-controller.yaml. */
+		if (*phy_intf == PHY_INTERFACE_MODE_RGMII &&
+		    (rgmii_tx_delay == 2000 || rgmii_rx_delay == 2000)) {
+			dev_warn(dev,
+				 "RX/TX delay cannot set to 2000 on 'rgmii'\n");
+			return -EINVAL;
+		}
+	}
+
+	/* The value is negative, which means the rx/tx-internal-delay-ps
+	 * property is not existed in dts. Therefore, set to default 0.
+	 */
+	if (rgmii_tx_delay < 0)
+		rgmii_tx_delay = 0;
+	if (rgmii_rx_delay < 0)
+		rgmii_rx_delay = 0;
+
+conf_delay:
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
+
+out_warn:
+	/* Print the warning message. Keep the phy-mode and the RGMII delay value. */
+	dev_warn(dev, "Update phy-mode to 'rgmii-id' and add rx/tx-internal-delay-ps\n");
+
+	return 0;
+}
+
+static int ftgmac100_set_internal_delay(struct ftgmac100 *priv,
+					phy_interface_t *phy_intf)
+{
+	struct device_node *np = priv->dev->of_node;
+	s32 rgmii_tx_delay;
+	s32 rgmii_rx_delay;
+	int err;
+
+	err = of_get_phy_mode(np, phy_intf);
+	if (err) {
+		dev_err(priv->dev, "Failed to get phy mode: %d\n", err);
+		return err;
+	}
+
+	if (!(of_device_is_compatible(np, "aspeed,ast2600-mac")))
+		return 0;
+
+	/* AST2600 needs to know if the "tx/rx-internal-delay-ps" properties
+	 * are existed in dts. If not existed, set -1 and delay is equal to 0.
+	 */
+	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay))
+		rgmii_tx_delay = -1;
+	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay))
+		rgmii_rx_delay = -1;
+
+	err = ftgmac100_set_ast2600_rgmii_delay(priv,
+						rgmii_tx_delay,
+						rgmii_rx_delay,
+						phy_intf);
+
+	return err;
+}
+
+static struct phy_device *ftgmac100_ast2600_phy_get(struct net_device *dev,
+						    struct device_node *np,
+						    void (*hndlr)(struct net_device *),
+						    phy_interface_t phy_intf)
+{
+	struct device_node *phy_np;
+	struct phy_device *phy;
+	int ret;
+
+	if (of_phy_is_fixed_link(np)) {
+		ret = of_phy_register_fixed_link(np);
+		if (ret < 0) {
+			netdev_err(dev, "broken fixed-link specification\n");
+			return NULL;
+		}
+		phy_np = of_node_get(np);
+	} else {
+		phy_np = of_parse_phandle(np, "phy-handle", 0);
+		if (!phy_np)
+			return NULL;
+	}
+
+	phy = of_phy_connect(dev, phy_np, hndlr, 0, phy_intf);
+
+	of_node_put(phy_np);
+
+	return phy;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
 	struct phy_device *phydev;
+	phy_interface_t phy_intf;
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
@@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
+		/* Configure RGMII delay if there are the corresponding compatibles */
+		err = ftgmac100_set_internal_delay(priv, &phy_intf);
+		if (err)
+			goto err_phy_connect;
 	} else {
 		priv->rxdes0_edorr_mask = BIT(15);
 		priv->txdes0_edotr_mask = BIT(15);
@@ -1955,8 +2231,16 @@ static int ftgmac100_probe(struct platform_device *pdev)
 				goto err_setup_mdio;
 		}
 
-		phy = of_phy_get_and_connect(priv->netdev, np,
-					     &ftgmac100_adjust_link);
+		/* Because AST2600 will use the RGMII delay to determine
+		 * which phy interface to use.
+		 */
+		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+			phy = ftgmac100_ast2600_phy_get(priv->netdev, np,
+							&ftgmac100_adjust_link,
+							phy_intf);
+		else
+			phy = of_phy_get_and_connect(priv->netdev, np,
+						     &ftgmac100_adjust_link);
 		if (!phy) {
 			dev_err(&pdev->dev, "Failed to connect to phy\n");
 			err = -EINVAL;
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..1b2f79a104ea 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -271,4 +271,29 @@ struct ftgmac100_rxdes {
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
+/* Keep original delay */
+#define AST2600_RGMII_KEEP_DELAY	0x01
+/* Need to disable delay on MAC side */
+#define AST2600_RGMII_DIS_DELAY		0x02
+
 #endif /* __FTGMAC100_H */

-- 
2.34.1


