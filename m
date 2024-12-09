Return-Path: <netdev+bounces-150326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF09E9DFE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16071887B6F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1617B427;
	Mon,  9 Dec 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b="UaZKVZH5"
X-Original-To: netdev@vger.kernel.org
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD515820C;
	Mon,  9 Dec 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.145.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768546; cv=none; b=lK72yQ17qQj2Cc1yOtJLxhru4rhltLeQtjTWopW3vmiicoZZbR1EVkJOt4ZsJDLOy2z4RAKFwn9Qve8Ib3sx4EHec8a/YaHbRa6UUsY9qjkcZDChC9RLlLNFXuIVPJTtTQSOkTf4MaZ/ddcfRT6bq9RO8/B3Ap/l6dfqc3TOyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768546; c=relaxed/simple;
	bh=va6KQ6fg6+4pePZiXAcMh5tjrhXgNGFnKfVDcKnT7fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CEq2ZySBpAMbJ39GEF5Op1D+gDFsNve1CzlVwWOqoNq22BTU4DoSQcdd1LzmzpQsPD6A0sassV1/AYC4rqeiMHDkNtF0HbjRBxRwBKfGPhXz5wJIMupMkl7IHJNgextGy/l5RXkK6fzLi8I2o0riQ+tyQXECGoXsps3yZ3J4JBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com; spf=pass smtp.mailfrom=ifm.com; dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b=UaZKVZH5; arc=none smtp.client-ip=132.145.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
	by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 4B9GKEXG031083;
	Mon, 9 Dec 2024 18:59:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps;
 bh=ANz80lwx+vllLEbzfRTuYpYF6Snm/gnwOr11NdB56cU=;
 b=UaZKVZH57aI8hFfGm02adzFqM267nDdcCTkvDZXOCpQClY4Ov42vmpEY3hFN7VMYOk/R
 2Yn+ZUlKz+4mB1zVvAno2rrhECn2O0UcTYlfxhysGZTTH45Gbf6G0uUJAdj1CxXLbTE9
 FwCssDkm2iaoNgKIQdAD+4gPxbp2gVW+fY5QuqSDuTVeYNciZIwGKYNVHAAAt6t2qCAf
 Hxp8v49t3gqfp+Zs4Od0yzYSrEJkwJzyqOUWXPKoo9aoNfQ1WuJihDGUIRmcCOzf862C
 kuVGuqOinL46ixL03fbgowBEUrGbZR78H4cjeqSfNp+OqEkY72wwSx8OG0ud1GsiDWDg JA== 
From: Fedor Ross <fedor.ross@ifm.com>
Date: Mon, 9 Dec 2024 18:58:51 +0100
Subject: [PATCH net-next 1/2] net: dsa: microchip: Add of config for LED
 mode for ksz87xx and ksz88x3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241209-netdev-net-next-ksz8_led-mode-v1-1-c7b52c2ebf1b@ifm.com>
References: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
In-Reply-To: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Woojung Huh
	<Woojung.Huh@microchip.com>, <devicetree@vger.kernel.org>,
        Tristram Ha
	<tristram.ha@microchip.com>,
        Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733767148; l=3006;
 i=fedor.ross@ifm.com; s=20241209; h=from:subject:message-id;
 bh=va6KQ6fg6+4pePZiXAcMh5tjrhXgNGFnKfVDcKnT7fM=;
 b=S0OlkYm5f8Pq82ohXtFjF3EycdDgTeMv9RewosLf1X1MkJ+SqPCqZ9t+9BFQusQ3DGttdInCY
 P/Rfx1yN5FrDbTiwwqxTl4HeFwmpX47zwO/F3ESDcwZte5XM23/cJmU
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=0Va3CWt8QM1HKXUBlspqksLl0ieto8l/GgQJJyNu/ZM=
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=43cyfjur6a QID=43cyfjur6a-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01

Add support for the led-mode property for the following PHYs which have
a single LED mode configuration value.

KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
LED configuration.

KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
configuration.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 9 +++++++++
 drivers/net/dsa/microchip/ksz8_reg.h   | 1 +
 drivers/net/dsa/microchip/ksz_common.c | 2 ++
 drivers/net/dsa/microchip/ksz_common.h | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index da7110d675583dfb7c9be876d5ec5d12cddcf9b4..6bac134b1ccd9cadf6f878d0e0e73f17ed23b45a 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1898,6 +1898,15 @@ int ksz8_setup(struct dsa_switch *ds)
 	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_1,
 			   SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
 
+	/* Configure LED mode */
+	if (dev->led_mode > 3)
+		dev_warn(dev->dev, "Invalid LED mode %d, supported modes 0..3.\n",
+			 dev->led_mode);
+	else if (!ksz_is_8895_family(dev))
+		ksz_cfg(dev,
+			ksz_is_ksz88x3(dev) ? REG_SW_PWR_MGMT_LED_MODE : REG_SW_CTRL_9,
+			dev->led_mode << 4, true);
+
 	/*
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 329688603a582b7f9dddc774327036edb54435f7..d04ae01c29b398414739e425d2c401ccbcfdac32 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -589,6 +589,7 @@
 /* 88x3 specific */
 
 #define REG_SW_INSERT_SRC_PVID		0xC2
+#define REG_SW_PWR_MGMT_LED_MODE	0xC3
 
 /* PME */
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 920443ee8ffd02380da64cd9e14e867d6210e890..22eb882c7335001aa545c1abe65f25f4586e2d7f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -5090,6 +5090,8 @@ int ksz_switch_register(struct ksz_device *dev)
 			}
 			of_node_put(ports);
 		}
+		of_property_read_u32(dev->dev->of_node, "microchip,led-mode", &dev->led_mode);
+
 		dev->synclko_125 = of_property_read_bool(dev->dev->of_node,
 							 "microchip,synclko-125");
 		dev->synclko_disable = of_property_read_bool(dev->dev->of_node,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b3bb75ca0796d208f232455677d338209bdaa97d..906f62b9cdb3677c3f8ece468d6ae93a3031db6d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -175,6 +175,7 @@ struct ksz_device {
 	u32 chip_id;
 	u8 chip_rev;
 	int cpu_port;			/* port connected to CPU */
+	unsigned int led_mode;
 	int phy_port_cnt;
 	phy_interface_t compat_interface;
 	bool synclko_125;

-- 
2.34.1


