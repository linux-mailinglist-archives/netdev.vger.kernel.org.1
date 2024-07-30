Return-Path: <netdev+bounces-113925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2323940656
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D708280FE1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79A918FC89;
	Tue, 30 Jul 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g4jDBGMu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5731667C7;
	Tue, 30 Jul 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312630; cv=none; b=lSYIXF73EhgWN+CReGfXDHoNaeqO6b8zyvajMMr3GHFhakDUtEmjL0u6EXCW9uU6WXMbfvIWmATLJrLw8Bszdh3PVt1EplgzCf6icuT4FZumAGg2FJBHhAShrK7RQ631XiCJ6CpeNTTvLZlvQloW6o1djvlbZKdIZCSSzv4AZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312630; c=relaxed/simple;
	bh=I5H+DCO9/fGkdq9xMaXHhtiR+lVrD1mPFooeaufi5s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Edj29o1EzkW+kuwnqfrLwr2emu6aJ5FP43Q3jry65DT4pJM/WiCPA2bUI07HO7B8OnZDTPQBitob+C+VBv7Ga10zO7a5mL++TffOwfyR44KzNX5k2CMubtezcGUHcKERJUoYktQ4RAYiurZWAIkCAz+xp9vnvMIKagwpFvTwHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g4jDBGMu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722312629; x=1753848629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5H+DCO9/fGkdq9xMaXHhtiR+lVrD1mPFooeaufi5s0=;
  b=g4jDBGMuN9Cs9l7KWaEF0jexyn1Ux0dHWnJV806vJ2emeJQvKgUeTsSt
   7YO6NUwhXb89xPx4tzuG9eg+PDEWqJkOO66VxhRwE11YPPUNtM5VmqcdJ
   8U35yG8V4Cw7F3N7t/4VTkAKvrQbXMKZ18kgP2OQXg5gY6IcgXR6lj6FA
   uhtcUo5ZgivaB+kPtDTRGKaEB0KPnJrnRLT7Z09LajRj7otYVTGiwoxcV
   DZxzBUbK4J05NZ5uociEegd2Vuvf/cJMNoqybNbflGPJQRHLBNUqR5zVR
   I6W6FXKCjVvq43tZAMvkxrrZuKWxP07U7QG3Aamvs5dLCxHDL4S5eW/1D
   w==;
X-CSE-ConnectionGUID: WJ+vg2u7QzaTB4lakkgXmA==
X-CSE-MsgGUID: UagRmPm5QiGiKhDsBO8nGQ==
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="197261878"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 21:10:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 21:10:01 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 21:09:51 -0700
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
Subject: [PATCH net-next v5 08/14] net: ethernet: oa_tc6: enable open alliance tc6 data communication
Date: Tue, 30 Jul 2024 09:39:00 +0530
Message-ID: <20240730040906.53779-9-Parthiban.Veerasooran@microchip.com>
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


