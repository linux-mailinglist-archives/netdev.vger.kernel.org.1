Return-Path: <netdev+bounces-262603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFMiB/JnpWmx+wUAu9opvQ
	(envelope-from <netdev+bounces-262603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2351D69E6
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A3C309BB43
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179C3AE6E5;
	Mon,  2 Mar 2026 10:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624713A0B1A;
	Mon,  2 Mar 2026 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447087; cv=none; b=q1E235eqa7txHQGQcs2nDCCrU6Im7s0ORRwiFES+TM7EXTqFoeg+lohe0HKn7bxuY3yJ6ztSgx40/9RbXUfWcZ3okED8UMM9SyUz9ej9kRZKWzsoItpkjBIGh/GnC8RtdG5coF1sD1zio0D6YcjNT/ZMqXepWhNUBVzN2mgR4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447087; c=relaxed/simple;
	bh=UqUrbBeIvhqRy5zO6BS/+j9eXsnua0SQu5iczuiSWSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CVWrTfKwZzftSXpn6aonZzE1+VbdCRUWAOlBVOjjtsh3tJZ7EBjTidktAzC9sBIeDBdowCaa92lrUzNEbICZ1v0lLRKpvno+TMD4B0sxRh7z0kgDdeqplDUSpfJJYdQ7m/y67BnAI+wPIsnafDYbu1K/342wCJrDjKduWjHMvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Mar 2026 18:24:30 +0800
Subject: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support
 for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=9482;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=UqUrbBeIvhqRy5zO6BS/+j9eXsnua0SQu5iczuiSWSw=;
 b=Hyr5u52113fwYtjR+T2Fm/3UsyYDONXJfpqXEsy8g25AktaHUXp+Pcu8OMkaETISqf6d1pcm7
 athTal752XkDnVYQaARVK5Gve5sWto8CrQ21396tYPhVQJqjnpLvAxA
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262603-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: AC2351D69E6
X-Rspamd-Action: no action

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
 drivers/net/ethernet/faraday/ftgmac100.c | 162 ++++++++++++++++++++++++++++++-
 drivers/net/ethernet/faraday/ftgmac100.h |  20 ++++
 2 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1e91e79c8134..0b2a0bb8a4a9 100644
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
 
@@ -42,6 +45,7 @@ enum ftgmac100_mac_id {
 
 struct ftgmac100_match_data {
 	enum ftgmac100_mac_id mac_id;
+	bool rgmii_delay_conf;
 };
 
 /* Arbitrary values, I am not sure the HW has limits */
@@ -1919,10 +1923,148 @@ static int ftgmac100_probe_dt(struct net_device *netdev,
 	return 0;
 }
 
+static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
+					     u32 rgmii_tx_delay,
+					     u32 rgmii_rx_delay,
+					     phy_interface_t phy_intf)
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
+	/* Please refer to ethernet-controller.yaml. */
+	if (phy_intf == PHY_INTERFACE_MODE_RGMII &&
+	    (rgmii_tx_delay == 2000 || rgmii_rx_delay == 2000)) {
+		dev_warn(dev, "RX/TX delay cannot set to 2000 on 'rgmii'\n");
+		return -EINVAL;
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
+static int ftgmac100_config_rgmii_delay(struct ftgmac100 *priv)
+{
+	struct device_node *np = priv->dev->of_node;
+	phy_interface_t phy_intf;
+	u32 rgmii_tx_delay;
+	u32 rgmii_rx_delay;
+	int err = 0;
+
+	/* Because some old dts using NC-SI mode does not include phy-mode
+	 * property, here need to skip RGMII delay configuration and prevent
+	 * of_get_phy_mode() from returning error.
+	 */
+	if (of_get_property(np, "use-ncsi", NULL))
+		return 0;
+
+	err = of_get_phy_mode(np, &phy_intf);
+	if (err) {
+		dev_err(priv->dev, "Failed to get phy mode: %d\n", err);
+		return err;
+	}
+
+	/* RMII does not need to configure RGMII delay */
+	if (!phy_interface_mode_is_rgmii(phy_intf))
+		return 0;
+
+	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay))
+		rgmii_tx_delay = 0;
+	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay))
+		rgmii_rx_delay = 0;
+
+	if (priv->mac_id == FTGMAC100_AST2600)
+		err = ftgmac100_set_ast2600_rgmii_delay(priv,
+							rgmii_tx_delay,
+							rgmii_rx_delay,
+							phy_intf);
+
+	return err;
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	const struct ftgmac100_match_data *match_data;
 	enum ftgmac100_mac_id mac_id;
+	bool rgmii_delay_conf;
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
@@ -1936,8 +2078,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		if (!match_data)
 			return -EINVAL;
 		mac_id = match_data->mac_id;
+		rgmii_delay_conf = match_data->rgmii_delay_conf;
 	} else {
 		mac_id = FTGMAC100_FARADAY;
+		rgmii_delay_conf = false;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -2006,6 +2150,12 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		priv->txdes0_edotr_mask = BIT(15);
 	}
 
+	if (rgmii_delay_conf) {
+		err = ftgmac100_config_rgmii_delay(priv);
+		if (err)
+			return err;
+	}
+
 	if (priv->mac_id == FTGMAC100_FARADAY ||
 	    priv->mac_id == FTGMAC100_AST2400 ||
 	    priv->mac_id == FTGMAC100_AST2500) {
@@ -2100,19 +2250,23 @@ static void ftgmac100_remove(struct platform_device *pdev)
 }
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {
-	.mac_id = FTGMAC100_AST2400
+	.mac_id = FTGMAC100_AST2400,
+	.rgmii_delay_conf = false
 };
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2500 = {
-	.mac_id = FTGMAC100_AST2500
+	.mac_id = FTGMAC100_AST2500,
+	.rgmii_delay_conf = false
 };
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
-	.mac_id = FTGMAC100_AST2600
+	.mac_id = FTGMAC100_AST2600,
+	.rgmii_delay_conf = true
 };
 
 static const struct ftgmac100_match_data ftgmac100_match_data_faraday = {
-	.mac_id = FTGMAC100_FARADAY
+	.mac_id = FTGMAC100_FARADAY,
+	.rgmii_delay_conf = false
 };
 
 static const struct of_device_id ftgmac100_of_match[] = {
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


