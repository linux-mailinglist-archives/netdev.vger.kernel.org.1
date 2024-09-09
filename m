Return-Path: <netdev+bounces-126416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8C971201
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4701C2291C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7251B2519;
	Mon,  9 Sep 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MUp2pJnv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F31B1D65;
	Mon,  9 Sep 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870442; cv=none; b=AOa/Un8UbgANQCjG7on0Z/rQLp+0T2Cglwq2g3wH0RV803eJsHmn/CmZf3prq+2KDk/uxisBRv1JBUxC6E6xjLydXnTPtI56QrIVnp7xCcF9eoDbqvwzPZMMO5z3R8qZY2KO73N2m5UHZXcJBOVk/21LXurKI4g8dAW7ZjjsB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870442; c=relaxed/simple;
	bh=I5H+DCO9/fGkdq9xMaXHhtiR+lVrD1mPFooeaufi5s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKJIhX/2svN4sYH0+pX5hbuNh9zj+WOkI3lE1tUXteqnDqJz3ZutHcI1ztNzGayoyeVNBi9hhM5q+3BZhT2o92xsKHbShZ0pwJuYSKExnJGxCZAB00kx7ln9LTuuugjIKau4NZsozjkOJGLxT+iHRCwzG2yYUOSqU6HwztLvjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MUp2pJnv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870440; x=1757406440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5H+DCO9/fGkdq9xMaXHhtiR+lVrD1mPFooeaufi5s0=;
  b=MUp2pJnvFyRv67pPMOjiyw2XsRAtqAHxXQAjO8/zhLfZ6lYTf4Rl3n5A
   B72Nnsk42q1u09Cm6K5/nZeeAX6SEIFSAgL/UPnjT7vMY/rbiNpOjtno1
   Jfb3ugmlBbUvzyaf6wO+EUUYC2JprzfMKzgT/KfwXwgiiGgpjJRG+eD3T
   ZuS+wozV2Z1nGmCuJCgpge19nZ55XlrvDHhgaUwhmnyhQ9uM9yXKJYTaq
   UKAfuWigjML3TnFBbe7ftULNOijOWYykirNv6uMHnj3vpIWJjAU9WDb+/
   ucXZXjuqSEvpebWQmJSsSiaZvmdQSTbWq/dugMjOBUr14fUI/X9Db6f6H
   w==;
X-CSE-ConnectionGUID: w4Dqm4EATAOwW8L/8a3sNg==
X-CSE-MsgGUID: BmAF43ZXTu+ngaw6MfnJQQ==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="31409626"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:27:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:26:54 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 01:26:43 -0700
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
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v8 08/14] net: ethernet: oa_tc6: enable open alliance tc6 data communication
Date: Mon, 9 Sep 2024 13:55:08 +0530
Message-ID: <20240909082514.262942-9-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
References: <20240909082514.262942-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enabling Configuration Synchronization bit (SYNC) in the Configuration
Register #0 enables data communication in the MAC-PHY. The state of this
bit is reflected in the data footer SYNC bit.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index fc276d881dc9..8958af863b6e 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -20,6 +20,10 @@
 #define OA_TC6_REG_RESET			0x0003
 #define RESET_SWRESET				BIT(0)	/* Software Reset */
 
+/* Configuration Register #0 */
+#define OA_TC6_REG_CONFIG0			0x0004
+#define CONFIG0_SYNC				BIT(15)
+
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
 #define STATUS0_RESETC				BIT(6)	/* Reset Complete */
@@ -559,6 +563,21 @@ static int oa_tc6_unmask_macphy_error_interrupts(struct oa_tc6 *tc6)
 	return oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
 }
 
+static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
+{
+	u32 value;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &value);
+	if (ret)
+		return ret;
+
+	/* Enable configuration synchronization for data transfer */
+	value |= CONFIG0_SYNC;
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
+}
+
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
  * @spi: device with which data will be exchanged.
@@ -618,7 +637,18 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 		return NULL;
 	}
 
+	ret = oa_tc6_enable_data_transfer(tc6);
+	if (ret) {
+		dev_err(&tc6->spi->dev, "Failed to enable data transfer: %d\n",
+			ret);
+		goto phy_exit;
+	}
+
 	return tc6;
+
+phy_exit:
+	oa_tc6_phy_exit(tc6);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
 
-- 
2.34.1


