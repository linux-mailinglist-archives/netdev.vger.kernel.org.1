Return-Path: <netdev+bounces-43509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122C7D3B41
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E9D1C20A1D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948061C29E;
	Mon, 23 Oct 2023 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XZL6pm63"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F91BDFD;
	Mon, 23 Oct 2023 15:48:05 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD4CD78;
	Mon, 23 Oct 2023 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076084; x=1729612084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zMQDhCf+BgR+OEM7pXSPI1V2CELpCiJL5Et7roC/YbA=;
  b=XZL6pm63Wx6w2FoVwYVTvE6W4WlycBVFKKrCG1VnrL3tZOgUW0Tb7ddI
   fBS7iHxHTcNHR6cHznwiEFJ2DBrEzgSK18F/hJgaMqNlGG9bKCkZ0a6SF
   oPnzp5yg2zNvVznmtZSVBRU9pYsK9roTprRGVS0jAJIQzDXbDUSY+XlX7
   m+z2wsEJeILVS/YUl3109pNboDTgIJMKjHp5dtGKW3EFgHYB0OqcyM6Kt
   MxCfekxYuH2yyJx784cpj79i5wzcOqAINx78bUyK7DfhNFDJeImfDDz7d
   YjwPMllfjxQhKNSLdGvw4G7Mw4Q0vUUSXcEEg+gdop7EVZC1p9MuOlt9B
   A==;
X-CSE-ConnectionGUID: klqWPg5QRmSazEzEhLffbg==
X-CSE-MsgGUID: uFGpmiGxSa+ChhZCPsoW3g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="241208147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:48:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:47:49 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:47:35 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
	<steen.hegelund@microchip.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
	<casper.casan@gmail.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
	<Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 3/9] net: ethernet: oa_tc6: implement OA TC6 configuration function
Date: Mon, 23 Oct 2023 21:16:43 +0530
Message-ID: <20231023154649.45931-4-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Read STDCAP register for the MAC-PHY capability and check against the
configuration parameters such as chunk payload, tx cut through and rx cut
through to configure the MAC-PHY. It also configures the control command
protected/unprotected mode.

In cut through mode configuration the MAC-PHY doesn't buffer the incoming
data. In tx case, it passes the data to the network if the configured cps
of data available. In rx case, it passes the data to the SPI host if the
configured cps of data available from the network. Also disables all the
errors mask in the IMASK0 register to check for the errors.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 86 ++++++++++++++++++++++++++++++++++-
 include/linux/oa_tc6.h        | 24 +++++++++-
 2 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index e4457569135f..9a98d59f286d 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/oa_tc6.h>
 
 /* Opaque structure for MACPHY drivers */
@@ -16,6 +17,7 @@ struct oa_tc6 {
 	u8 *ctrl_tx_buf;
 	u8 *ctrl_rx_buf;
 	bool prote;
+	u32 cps;
 };
 
 static int oa_tc6_spi_transfer(struct spi_device *spi, u8 *ptx, u8 *prx, u16 len)
@@ -198,6 +200,81 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
 	return ret;
 }
 
+static int oa_tc6_configure(struct oa_tc6 *tc6)
+{
+	struct spi_device *spi = tc6->spi;
+	struct device_node *oa_node;
+	u32 regval;
+	u8 mincps;
+	bool ctc;
+	int ret;
+
+	/* Read and configure the IMASK0 register for unmasking the interrupts */
+	ret = oa_tc6_perform_ctrl(tc6, IMASK0, &regval, 1, false, false);
+	if (ret)
+		return ret;
+
+	regval &= ~(TXPEM & TXBOEM & TXBUEM & RXBOEM & LOFEM & HDREM);
+
+	ret = oa_tc6_perform_ctrl(tc6, IMASK0, &regval, 1, true, false);
+	if (ret)
+		return ret;
+
+	/* Read STDCAP register to get the MAC-PHY standard capabilities */
+	ret = oa_tc6_perform_ctrl(tc6, STDCAP, &regval, 1, false, false);
+	if (ret)
+		return ret;
+
+	mincps = FIELD_GET(MINCPS, regval);
+	ctc = (regval & CTC) ? true : false;
+
+	regval = 0;
+	oa_node = of_get_child_by_name(spi->dev.of_node, "oa-tc6");
+	if (oa_node) {
+		/* Read OA parameters from DT */
+		if (of_property_present(oa_node, "oa-cps")) {
+			ret = of_property_read_u32(oa_node, "oa-cps", &tc6->cps);
+			if (ret < 0)
+				return ret;
+			/* Return error if the configured cps is less than the
+			 * minimum cps supported by the MAC-PHY.
+			 */
+			if (tc6->cps < mincps)
+				return -ENODEV;
+		} else {
+			tc6->cps = 64;
+		}
+		if (of_property_present(oa_node, "oa-txcte")) {
+			/* Return error if the tx cut through mode is configured
+			 * but it is not supported by MAC-PHY.
+			 */
+			if (ctc)
+				regval |= TXCTE;
+			else
+				return -ENODEV;
+		}
+		if (of_property_present(oa_node, "oa-rxcte")) {
+			/* Return error if the rx cut through mode is configured
+			 * but it is not supported by MAC-PHY.
+			 */
+			if (ctc)
+				regval |= RXCTE;
+			else
+				return -ENODEV;
+		}
+		if (of_property_present(oa_node, "oa-prote")) {
+			regval |= PROTE;
+			tc6->prote = true;
+		}
+	} else {
+		tc6->cps = 64;
+	}
+
+	regval |= FIELD_PREP(CPS, ilog2(tc6->cps) / ilog2(2)) | SYNC;
+
+	return oa_tc6_perform_ctrl(tc6, CONFIG0, &regval, 1, true, false);
+}
+
 static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
 {
 	u32 regval;
@@ -310,7 +387,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_read_registers);
  * Returns pointer reference to the oa_tc6 structure if all the memory
  * allocation success otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote)
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 {
 	struct oa_tc6 *tc6;
 
@@ -327,7 +404,6 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote)
 		return NULL;
 
 	tc6->spi = spi;
-	tc6->prote = prote;
 
 	/* Perform MAC-PHY software reset */
 	if (oa_tc6_sw_reset(tc6)) {
@@ -335,6 +411,12 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote)
 		return NULL;
 	}
 
+	/* Perform OA parameters and MAC-PHY configuration */
+	if (oa_tc6_configure(tc6)) {
+		dev_err(&spi->dev, "OA and MAC-PHY configuration failed\n");
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 8a838499da97..378636fd9ca8 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -22,15 +22,37 @@
 #define TC6_CTRL_BUF_SIZE	1032	/* Max ctrl buffer size for 128 regs */
 
 /* Open Alliance TC6 Standard Control and Status Registers */
+/* Standard Capabilities Register */
+#define STDCAP			0x0002
+#define CTC			BIT(7)	/* Cut-Through Capability */
+#define MINCPS			GENMASK(2, 0)	/* Minimum supported cps */
+
 /* Reset Control and Status Register */
 #define RESET			0x0003
 #define SWRESET			BIT(0)	/* Software Reset */
 
+/* Configuration Register #0 */
+#define CONFIG0			0x0004
+#define SYNC			BIT(15)	/* Configuration Synchronization */
+#define TXCTE			BIT(9)	/* Tx cut-through enable */
+#define RXCTE			BIT(8)	/* Rx cut-through enable */
+#define PROTE			BIT(5)	/* Ctrl read/write Protection Enable */
+#define CPS			GENMASK(2, 0)	/* Chunk Payload Size */
+
 /* Status Register #0 */
 #define STATUS0			0x0008
 #define RESETC			BIT(6)	/* Reset Complete */
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote);
+/* Interrupt Mask Register #0 */
+#define IMASK0			0x000C
+#define HDREM			BIT(5)	/* Header Error Mask */
+#define LOFEM			BIT(4)	/* Loss of Framing Error Mask */
+#define RXBOEM			BIT(3)	/* Rx Buffer Overflow Error Mask */
+#define TXBUEM			BIT(2)	/* Tx Buffer Underflow Error Mask */
+#define TXBOEM			BIT(1)	/* Tx Buffer Overflow Error Mask */
+#define TXPEM			BIT(0)	/* Tx Protocol Error Mask */
+
+struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 *val);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len);
-- 
2.34.1


