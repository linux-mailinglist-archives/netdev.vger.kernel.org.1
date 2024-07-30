Return-Path: <netdev+bounces-113921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C691940644
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6765283470
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E775C15FA73;
	Tue, 30 Jul 2024 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kYSmU0oi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8A18E1A;
	Tue, 30 Jul 2024 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312599; cv=none; b=OCacVlTspAxAsHGocR+38V+83hfWRREmJumcwv6HLAFD+ovJeO8ZBpxwzUktvlUmkKq6Z3eSluSvJkL4t+DMB+dH6422wrSrVVVZS/L/2nZxGvVIS8AKDaoQOUPSTe56UD4kgGcigphKLngSULPCo9n+1tZkCId6S6/MEB+3BNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312599; c=relaxed/simple;
	bh=049uuilb9z/YbFT1C82V6wGOnQJt5Pm3yY/25FZjxCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0y3lhiBtkHNwyUEx0oj8MWLPEfbk6k3YE53BQJdToQfxJBBQRhGTQO7Xh/4EncpO4cucLriW6HK+FSqXF8QLikaU69t3HtBP1RnRtmJWVpE4dCG33Zn2lGCfTcgxxJLW9FiQwq2jMq4Ny6VfKOTJ7V8g+7ExXljjveg1jpKDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kYSmU0oi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312598; x=1753848598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=049uuilb9z/YbFT1C82V6wGOnQJt5Pm3yY/25FZjxCQ=;
  b=kYSmU0oi8hxqLlUzTZQNO0KKev1TqS4/2z5tLGni2p/bGAhfma/E9Uig
   7wA0l5/epUdtNuMXbm0FrBa1SeqRs8ORxvuTN1opyVTxBPl9QOgC3ynPv
   eDNlDQCNKhiChZbSESo8XkjJQMco+5QS0tI1wxR5h9uy4eSPVdr+lUaYg
   mkFH9rvwwh3IOmeKesUZ+9XIl3uNByJLG7lqCLYUzVIvX1ZwP0WYAzKi6
   SGBHpb/vs9m98he7L1p1mGvbzgHfYH42qTwqhbE5QJ9jooTz0ESkSBBtN
   ineSJeHFGJ8YbidHOCb1fTng734VrxeDY4tCupnn2kDTk5nw+5gVsj4xM
   w==;
X-CSE-ConnectionGUID: jdNidrKSQ/GsceCAZwu49g==
X-CSE-MsgGUID: WGV/yke8QiaXT6OLpklqVg==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="197261857"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:09:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:09:28 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:09:17 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 05/14] net: ethernet: oa_tc6: implement error interrupts unmasking
Date: Tue, 30 Jul 2024 09:38:57 +0530
Message-ID: <20240730040906.53779-6-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This will unmask the following error interrupts from the MAC-PHY.
  tx protocol error
  rx buffer overflow error
  loss of framing error
  header error
The MAC-PHY will signal an error by setting the EXST bit in the receive
data footer which will then allow the host to read the STATUS0 register
to find the source of the error.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f774ed397213..86b032cdbee1 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -18,6 +18,13 @@
 #define OA_TC6_REG_STATUS0			0x0008
 #define STATUS0_RESETC				BIT(6)	/* Reset Complete */
 
+/* Interrupt Mask Register #0 */
+#define OA_TC6_REG_INT_MASK0			0x000C
+#define INT_MASK0_HEADER_ERR_MASK		BIT(5)
+#define INT_MASK0_LOSS_OF_FRAME_ERR_MASK	BIT(4)
+#define INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK	BIT(3)
+#define INT_MASK0_TX_PROTOCOL_ERR_MASK		BIT(0)
+
 /* Control command header */
 #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
 #define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
@@ -327,6 +334,23 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);
 }
 
+static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_INT_MASK0, &regval);
+	if (ret)
+		return ret;
+
+	regval &= ~(INT_MASK0_TX_PROTOCOL_ERR_MASK |
+		    INT_MASK0_RX_BUFFER_OVERFLOW_ERR_MASK |
+		    INT_MASK0_LOSS_OF_FRAME_ERR_MASK |
+		    INT_MASK0_HEADER_ERR_MASK);
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -369,6 +393,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 		return NULL;
 	}
 
+	ret = oa_tc6_unmask_macphy_error_interrupts(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev,
+			"MAC-PHY error interrupts unmask failed: %d\n", ret);
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
-- 
2.34.1


