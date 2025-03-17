Return-Path: <netdev+bounces-175168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CAA63C9F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 04:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF916DC52
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976A1A3152;
	Mon, 17 Mar 2025 02:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98B1A2380;
	Mon, 17 Mar 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180382; cv=none; b=uyskXR8Sd/HXXMLgNmpA55TVKN23u4MjOZ0EOWJRQEKofcWMHZc6lC/p+//MK5x5TYct/hsTOMtiJTUKAwMBRc7HktVhJTn3+Iw3sRlEc77/PEHcHl04rBm6kFeDkluS7ns0YTg7vJPXktS+dWF0QZhQ7+pkWDahbCwb7/5G57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180382; c=relaxed/simple;
	bh=XSyYJ75R9Rc3SDBDuB8CZtXABWuY8O5VgKqquNhvM2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhUrW4xEO/BkkL1zSiY1St8bqQeQ5TiJLYZ1C71veqW7439JLVWVatowBpu5781d59YZcXXEfIfJRMhT+5oRgsNP8y6me2SNsuZQ8URyBKIP5jaOdDJMLYAEEL9uXXdH3CyoAE7qd6pEHLFAvaJmXhw/AGJ1FLg4sun6SFXosWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Date: Mon, 17 Mar 2025 10:59:22 +0800
Message-ID: <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use rx-internal-delay-ps and tx-internal-delay-ps
properties to configue the RGMII delay into corresponding register of
scu. Currently, the ftgmac100 driver only configures on AST2600 and will
be by pass the other platforms.
The details are in faraday,ftgmac100.yaml.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 88 ++++++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h | 12 ++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 17ec35e75a65..ea2061488cba 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -27,6 +27,9 @@
 #include <linux/phy_fixed.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
 
 #include "ftgmac100.h"
 
@@ -1812,6 +1815,88 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static void ftgmac100_set_internal_delay(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct net_device *netdev;
+	struct ftgmac100 *priv;
+	struct regmap *scu;
+	u32 rgmii_tx_delay, rgmii_rx_delay;
+	u32 dly_reg, tx_dly_mask, rx_dly_mask;
+	int tx, rx;
+
+	netdev = platform_get_drvdata(pdev);
+	priv = netdev_priv(netdev);
+
+	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
+	rx = of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay);
+
+	if (of_device_is_compatible(np, "aspeed,ast2600-mac")) {
+		/* According to mac base address to get mac index */
+		switch (priv->res->start) {
+		case 0x1e660000:
+			dly_reg = AST2600_MAC12_CLK_DLY;
+			tx_dly_mask = AST2600_MAC1_TX_DLY;
+			rx_dly_mask = AST2600_MAC1_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC1_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC1_RX_DLY, rgmii_rx_delay);
+			break;
+		case 0x1e680000:
+			dly_reg = AST2600_MAC12_CLK_DLY;
+			tx_dly_mask = AST2600_MAC2_TX_DLY;
+			rx_dly_mask = AST2600_MAC2_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC2_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC2_RX_DLY, rgmii_rx_delay);
+			break;
+		case 0x1e670000:
+			dly_reg = AST2600_MAC34_CLK_DLY;
+			tx_dly_mask = AST2600_MAC3_TX_DLY;
+			rx_dly_mask = AST2600_MAC3_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC3_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC3_RX_DLY, rgmii_rx_delay);
+			break;
+		case 0x1e690000:
+			dly_reg = AST2600_MAC34_CLK_DLY;
+			tx_dly_mask = AST2600_MAC4_TX_DLY;
+			rx_dly_mask = AST2600_MAC4_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC4_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC4_RX_DLY, rgmii_rx_delay);
+			break;
+		default:
+			dev_warn(&pdev->dev, "Invalid mac base address");
+			return;
+		}
+	} else {
+		return;
+	}
+
+	scu = syscon_regmap_lookup_by_phandle(np, "scu");
+	if (IS_ERR(scu)) {
+		dev_warn(&pdev->dev, "failed to map scu base");
+		return;
+	}
+
+	if (!tx) {
+		/* Use tx-internal-delay-ps as index to configure tx delay
+		 * into scu register.
+		 */
+		if (rgmii_tx_delay > 64)
+			dev_warn(&pdev->dev, "Get invalid tx delay value");
+		else
+			regmap_update_bits(scu, dly_reg, tx_dly_mask, rgmii_tx_delay);
+	}
+
+	if (!rx) {
+		/* Use rx-internal-delay-ps as index to configure rx delay
+		 * into scu register.
+		 */
+		if (rgmii_tx_delay > 64)
+			dev_warn(&pdev->dev, "Get invalid rx delay value");
+		else
+			regmap_update_bits(scu, dly_reg, rx_dly_mask, rgmii_rx_delay);
+	}
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1977,6 +2062,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
+
+		/* Configure RGMII delay if there are the corresponding properties */
+		ftgmac100_set_internal_delay(pdev);
 	}
 
 	/* Default ring sizes */
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..d464d287502c 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -271,4 +271,16 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
 
+/* Aspeed SCU */
+#define AST2600_MAC12_CLK_DLY	0x340
+#define AST2600_MAC1_TX_DLY		GENMASK(5, 0)
+#define AST2600_MAC1_RX_DLY		GENMASK(17, 12)
+#define AST2600_MAC2_TX_DLY		GENMASK(11, 6)
+#define AST2600_MAC2_RX_DLY		GENMASK(23, 18)
+#define AST2600_MAC34_CLK_DLY	0x350
+#define AST2600_MAC3_TX_DLY		AST2600_MAC1_TX_DLY
+#define AST2600_MAC3_RX_DLY		AST2600_MAC1_RX_DLY
+#define AST2600_MAC4_TX_DLY		AST2600_MAC2_TX_DLY
+#define AST2600_MAC4_RX_DLY		AST2600_MAC2_RX_DLY
+
 #endif /* __FTGMAC100_H */
-- 
2.34.1


