Return-Path: <netdev+bounces-113201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B193D331
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DB281C90
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B517C23A;
	Fri, 26 Jul 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bs/83qSh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44117B51E;
	Fri, 26 Jul 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997587; cv=none; b=EVgXDPAXaZraH7aAAaYWChFawVxH1wp5rZkw1fT1wdgsd3dIyRSC7ZSVI567k7R1aaYPUyWFsXe/Tm6duyGegnh2CxfFciaMtAUFbNWnfTUFcA/WsCjM8mfl5m+5tDh+Uqs5B6J/QPtQ6MZBnHl96wMPHPfqR05Q58OPDSh4R5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997587; c=relaxed/simple;
	bh=7r0hGPchYNf5SeF4aVGShXvreNLAnj/tG7dq/eXQlRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUFE6jXj9//6wGbwr/+CcpgddLTRjT9tE3cVQl+PqFE+saLu/tZAhwgYlSxJjMKSDXzhGsQfIFZX/HBDmHSME9/gTiC/Wrn0Z+TYSeFpHgUwRWtS9J0lPaaGYI55EeLrWhD5A0bEuxaKD9oI6/BEvmsl/RTJqYe6/2kdHshFg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bs/83qSh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721997586; x=1753533586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7r0hGPchYNf5SeF4aVGShXvreNLAnj/tG7dq/eXQlRE=;
  b=bs/83qSh20rHuE3GvNDrzxB1Ft5KW9QoV2x4QXh2D++sc7wvY0Vljvf0
   YzPg8z8KfgmGcHat9o1S+bxMCIJkUXZglk2IzacpHZIiJHV/S5WJO5Ios
   ai83rrdvXVH9pSKWUFMEs+Q9r9pfS/WpglCrzBbS5bwx5yD5txF2QeuYB
   0MmaHnWtUGvGRRBSTmAl+x2DWGcQes6pg85Lse6cqPvdOHkF1yLBm4GJO
   8gAMcq0ek59c26W/ddBYiT+Ap7g8N20fYeg4wtObkNulHmrBugEEerleL
   44Iwb7bkURtv1PwahjWrui1CCXrUFyLqp2B9qtvt4tbmlQmJXkyYhd31A
   g==;
X-CSE-ConnectionGUID: Z0ZRY1iBSJuTZIUmLX6uJg==
X-CSE-MsgGUID: zdbJ7iEYQIehco5Yb4dVlQ==
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="260629579"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2024 05:39:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jul 2024 05:39:23 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jul 2024 05:39:15 -0700
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
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v5 05/14] net: ethernet: oa_tc6: implement error interrupts unmasking
Date: Fri, 26 Jul 2024 18:08:58 +0530
Message-ID: <20240726123907.566348-6-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
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
index 15db24d87a00..5fd7c0735af8 100644
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
@@ -367,6 +391,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
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


