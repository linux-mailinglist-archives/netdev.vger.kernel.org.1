Return-Path: <netdev+bounces-234969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD5C2A5F0
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 08:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C3BC348BCE
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2932C3274;
	Mon,  3 Nov 2025 07:39:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028A2C21CB;
	Mon,  3 Nov 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155591; cv=none; b=PB5Z2YyaGR9zGeb4aKtuBTObc91PjxA4rxQZ+xLT6ZKooVQ4WEAmdLFgtk9FniA8nxb4cBVoooSNakkknEKNzmIia9jkJZDHkDOu1Nj5FSAcZGKW5i34xJoKYFdKq279hNpn/BCLDdjjh98SClNwHu+MlXGycSgdPUk5tldj3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155591; c=relaxed/simple;
	bh=1wloGNNVsoIOYfApIhEtsrZ4/JcgHz40F3WbPMyHM2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NNKUJq58xR5qS7OP/g5/MRF30vFS7S7qMX5ssM3Fvjyxsg4s5VJC2yC/KmhqJaN8C/jtAiPwMIeS3ZHkO4fBtGGZNW681Asgo+1DGVyNQbiaTvTDGC7AjKkjUDz2yPrFyFwgZz07EPuYY0RQQZpktZoooExM1HfPGWb+9CK/GR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 3 Nov 2025 15:39:19 +0800
Subject: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=6843;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=1wloGNNVsoIOYfApIhEtsrZ4/JcgHz40F3WbPMyHM2I=;
 b=IbTCiNJSMVeN46KAGwM6smmb4SlvlDS0giiLkC2aPV+1ijm2hi8g3hPKPyNwS+BzPaMFHewgh
 B6/atZuzn+DCIYQZTmeRLLALXB3RZ3uAn+VBzZ6POfVsIOBlQi0X5Zn
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

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 110 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h |  15 +++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a863f7841210..bc83ef079095 100644
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
 
@@ -1833,6 +1836,108 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static int ftgmac100_set_ast2600_rgmii_delay(struct platform_device *pdev,
+					     u32 rgmii_tx_delay,
+					     u32 rgmii_rx_delay)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 rgmii_delay_unit;
+	struct regmap *scu;
+	int dly_mask;
+	int dly_reg;
+	int id;
+
+	scu = syscon_regmap_lookup_by_phandle(np, "scu");
+	if (IS_ERR(scu)) {
+		dev_err(&pdev->dev, "failed to get scu");
+		return PTR_ERR(scu);
+	}
+
+	id = of_alias_get_id(np, "ethernet");
+	if (id < 0 || id > 3) {
+		dev_err(&pdev->dev, "get wrong alise id %d\n", id);
+		return -EINVAL;
+	}
+
+	if (of_device_is_compatible(np, "aspeed,ast2600-mac01")) {
+		dly_reg = AST2600_MAC01_CLK_DLY;
+		rgmii_delay_unit = AST2600_MAC01_CLK_DLY_UNIT;
+	} else if (of_device_is_compatible(np, "aspeed,ast2600-mac23")) {
+		dly_reg = AST2600_MAC23_CLK_DLY;
+		rgmii_delay_unit = AST2600_MAC23_CLK_DLY_UNIT;
+	}
+
+	rgmii_tx_delay = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
+	if (rgmii_tx_delay >= 32) {
+		dev_err(&pdev->dev,
+			"The index %u of TX delay setting is out of range\n",
+			rgmii_tx_delay);
+		return -EINVAL;
+	}
+
+	rgmii_rx_delay = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
+	if (rgmii_rx_delay >= 32) {
+		dev_err(&pdev->dev,
+			"The index %u of RX delay setting is out of range\n",
+			rgmii_rx_delay);
+		return -EINVAL;
+	}
+
+	/* Due to the hardware design reason, for MAC23 on AST2600, the zero
+	 * delay ns on RX is configured by setting value 0x1a.
+	 * List as below:
+	 * 0x1a -> 0   ns, 0x1b -> 0.25 ns, ... , 0x1f -> 1.25 ns,
+	 * 0x00 -> 1.5 ns, 0x01 -> 1.75 ns, ... , 0x19 -> 7.75 ns, 0x1a -> 0 ns
+	 */
+	if (of_device_is_compatible(np, "aspeed,ast2600-mac23"))
+		rgmii_rx_delay = (AST2600_MAC23_RX_DLY_0_NS + rgmii_rx_delay) &
+				 AST2600_MAC_TX_RX_DLY_MASK;
+
+	if (id == 0 || id == 2) {
+		dly_mask = ASPEED_MAC0_2_TX_DLY | ASPEED_MAC0_2_RX_DLY;
+		rgmii_tx_delay = FIELD_PREP(ASPEED_MAC0_2_TX_DLY, rgmii_tx_delay);
+		rgmii_rx_delay = FIELD_PREP(ASPEED_MAC0_2_RX_DLY, rgmii_rx_delay);
+	} else {
+		dly_mask = ASPEED_MAC1_3_TX_DLY | ASPEED_MAC1_3_RX_DLY;
+		rgmii_tx_delay = FIELD_PREP(ASPEED_MAC1_3_TX_DLY, rgmii_tx_delay);
+		rgmii_rx_delay = FIELD_PREP(ASPEED_MAC1_3_RX_DLY, rgmii_rx_delay);
+	}
+
+	regmap_update_bits(scu, dly_reg, dly_mask, rgmii_tx_delay | rgmii_rx_delay);
+
+	return 0;
+}
+
+static int ftgmac100_set_internal_delay(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 rgmii_tx_delay;
+	u32 rgmii_rx_delay;
+	int err;
+
+	if (!(of_device_is_compatible(np, "aspeed,ast2600-mac01") ||
+	      of_device_is_compatible(np, "aspeed,ast2600-mac23")))
+		return 0;
+
+	err = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
+	if (err) {
+		dev_err(&pdev->dev, "failed to get tx-internal-delay-ps\n");
+		return err;
+	}
+
+	err = of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay);
+	if (err) {
+		dev_err(&pdev->dev, "failed to get tx-internal-delay-ps\n");
+		return err;
+	}
+
+	err = ftgmac100_set_ast2600_rgmii_delay(pdev,
+						rgmii_tx_delay,
+						rgmii_rx_delay);
+
+	return err;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2004,6 +2109,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
+
+		/* Configure RGMII delay if there are the corresponding compatibles */
+		err = ftgmac100_set_internal_delay(pdev);
+		if (err)
+			goto err_phy_connect;
 	}
 
 	/* Default ring sizes */
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..6a2a9159bee4 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -271,4 +271,19 @@ struct ftgmac100_rxdes {
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
 #endif /* __FTGMAC100_H */

-- 
2.34.1


