Return-Path: <netdev+bounces-117319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7294D93A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826F5283A6F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7116E894;
	Fri,  9 Aug 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UQgh/xk7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301116D9C7;
	Fri,  9 Aug 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246729; cv=none; b=ouKpMNWmdeviYBMiCQcZwRdgkD53PCqTONFlF46UNM1n6wkHPvPRiMo+qJx2TwZrgYD0URVXGfFtpOV/HAemEaydqOgxW9z6qlZiH2qVQgncuTLR8P7OQbaY0VnBeCSsSxz/410lVjWKB3iyNBzmuj6gc1PQedZJoXFacDMjxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246729; c=relaxed/simple;
	bh=NkvhgPjzxKYORzyblPym5NhvdQaV3EQ3ra5YzKzMTa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4xGB+D4+yG4aMXmqPGi8i/BqzQDE7o4ctrZz8n5GF1PCoyBHfV9fODBudGXMfrTNVco8yqJedboU+mXG9BNg/oOHdJTEH6q3Vm8TPvNylAUAgMgMJ3yDhkuQ2xErfUcipVtIN7wf4x++m/eujROZEiYvpi4yIbmOgxH1s5JN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UQgh/xk7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723246727; x=1754782727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NkvhgPjzxKYORzyblPym5NhvdQaV3EQ3ra5YzKzMTa4=;
  b=UQgh/xk7A88YPU5pNUWIeJzPNF5+apwY84UTrkrsM0U6EWMCNktSDuCJ
   8fJVAt5/7BqyyIcKIBecUlXTrxVoB35/sZGqRnnpNtnoZccN54TrFBPQ9
   FWH6lAXjL1rIOvbagwzzPuWwF1DEXTf5T6oQwgKYf/HBOsY/ayx3eyigD
   SMIyqWa9aRm0BX7p7/cw3MVcJ0ks7iCxhKvSBDLe/icA1f6tTDUsp57yj
   7CGQuM5XxMeVs+AJZsVHroems8SP1pbfl7sZSv8OFUsyoAexNmkkUHJBF
   G6f0hVHxOo6ABP296Vgi4h4exX23tVKf7m0lO/IQaM+ZbqZa9u4B+u41E
   Q==;
X-CSE-ConnectionGUID: zHerXwjfR2qUoEM/PnTZ/A==
X-CSE-MsgGUID: EYA15SPoRRm0AgKSgOevmw==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30988811"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 16:38:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 16:38:42 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 16:38:41 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts in KSZ9477/KSZ9893 switch families
Date: Fri, 9 Aug 2024 16:38:39 -0700
Message-ID: <20240809233840.59953-4-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809233840.59953-1-Tristram.Ha@microchip.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ9477 switch driver can handle most interrupts.  It enables address
learning fail interrupt as SQA would like to see such notification during
testing.

Input timestamp interrupt is not implemented yet as that interrupt is
related to PTP operation and so will be handled by the PTP driver.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c     | 64 ++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h     |  4 +-
 drivers/net/dsa/microchip/ksz9477_reg.h |  5 +-
 drivers/net/dsa/microchip/ksz_common.c  |  2 +
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 425e20daf1e9..518ba4a1e34b 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -1487,6 +1487,68 @@ void ksz9477_switch_exit(struct ksz_device *dev)
 	ksz9477_reset_switch(dev);
 }
 
+static irqreturn_t ksz9477_handle_port_irq(struct ksz_device *dev, u8 port,
+					   u8 *data)
+{
+	struct dsa_switch *ds = dev->ds;
+	struct phy_device *phydev;
+	int cnt = 0;
+
+	phydev = mdiobus_get_phy(ds->user_mii_bus, port);
+	if (*data & PORT_PHY_INT) {
+		/* Handle the interrupt if there is no PHY device or its
+		 * interrupt is not registered yet.
+		 */
+		if (!phydev || phydev->interrupts != PHY_INTERRUPT_ENABLED) {
+			u8 phy_status;
+
+			ksz_pread8(dev, port, REG_PORT_PHY_INT_STATUS,
+				   &phy_status);
+			if (phydev)
+				phy_trigger_machine(phydev);
+			++cnt;
+			*data &= ~PORT_PHY_INT;
+		}
+	}
+	if (*data & PORT_ACL_INT) {
+		ksz_pwrite8(dev, port, REG_PORT_INT_STATUS, PORT_ACL_INT);
+		++cnt;
+		*data &= ~PORT_ACL_INT;
+	}
+
+	return (cnt > 0) ? IRQ_HANDLED : IRQ_NONE;
+}
+
+void ksz9477_enable_irq(struct ksz_device *dev)
+{
+	regmap_update_bits(ksz_regmap_32(dev), REG_SW_INT_MASK__4, LUE_INT, 0);
+	ksz_write8(dev, REG_SW_LUE_INT_ENABLE, LEARN_FAIL_INT | WRITE_FAIL_INT);
+}
+
+irqreturn_t ksz9477_handle_irq(struct ksz_device *dev, u8 port, u8 *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+	u32 data32;
+
+	if (port > 0)
+		return ksz9477_handle_port_irq(dev, port - 1, data);
+
+	ksz_read32(dev, REG_SW_INT_STATUS__4, &data32);
+	if (data32 & LUE_INT) {
+		u8 lue;
+
+		ksz_read8(dev, REG_SW_LUE_INT_STATUS, &lue);
+		ksz_write8(dev, REG_SW_LUE_INT_STATUS, lue);
+		if (lue & LEARN_FAIL_INT)
+			dev_info_ratelimited(dev->dev, "lue learn fail\n");
+		if (lue & WRITE_FAIL_INT)
+			dev_info_ratelimited(dev->dev, "lue write fail\n");
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
 MODULE_AUTHOR("Woojung Huh <Woojung.Huh@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ9477 Series Switch DSA Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 239a281da10b..51252d0d0774 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 series Header file
  *
- * Copyright (C) 2017-2022 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_H
@@ -58,6 +58,8 @@ int ksz9477_reset_switch(struct ksz_device *dev);
 int ksz9477_switch_init(struct ksz_device *dev);
 void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
+void ksz9477_enable_irq(struct ksz_device *dev);
+irqreturn_t ksz9477_handle_irq(struct ksz_device *dev, u8 port, u8 *data);
 void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
 void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
 void ksz9477_get_wol(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index d5354c600ea1..da4ef3eb97c7 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 register definitions
  *
- * Copyright (C) 2017-2018 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_REGS_H
@@ -75,7 +75,8 @@
 #define TRIG_TS_INT			BIT(30)
 #define APB_TIMEOUT_INT			BIT(29)
 
-#define SWITCH_INT_MASK			(TRIG_TS_INT | APB_TIMEOUT_INT)
+#define SWITCH_INT_MASK			\
+	(LUE_INT | TRIG_TS_INT | APB_TIMEOUT_INT)
 
 #define REG_SW_PORT_INT_STATUS__4	0x0018
 #define REG_SW_PORT_INT_MASK__4		0x001C
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f328c97f27d1..7db74e036c3f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -357,6 +357,8 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
 	.exit = ksz9477_switch_exit,
+	.enable_irq = ksz9477_enable_irq,
+	.handle_irq = ksz9477_handle_irq,
 };
 
 static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
-- 
2.34.1


