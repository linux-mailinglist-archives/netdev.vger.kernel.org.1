Return-Path: <netdev+bounces-124832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8796B193
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6666EB268C3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EB13212B;
	Wed,  4 Sep 2024 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWuUjlj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADA12FF9C;
	Wed,  4 Sep 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431286; cv=none; b=jwVSZgysb7TJGTGcufN+A5e8W3JjNv4+7C+K1OZuRN91Rh7HvePpfv+DXDXNFnqHz0m2asu2YrS7NiYRYzc7fYCnI9KpIXgBVPqPRVc/7li9gAxh6Sir+J/eNvH+eEqfM4XD8CSfp3hxwNa42z6sEAVa0BuLnGPo/Ac4cXRCiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431286; c=relaxed/simple;
	bh=zMMT5+DbOampsFcX5H1ixwm6s0F5yXjKj1eW0lcoHdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9icyyC1pgx0AQFLoejBnZq99uO3p8HMiHoMBCVHt+b8oDWQCnfsaLvQSlQNeWbxudGE90g/beoX0BhmSvqB1T2iYs5ciGG0Hz4T9bQ8w1OlagBY0mbjz8VOWahoiQcUUXQrYSc2guvS5ifF344LPl7WwblWUvR/urFVgBt9M2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWuUjlj8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334c018913so5839684e87.0;
        Tue, 03 Sep 2024 23:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725431283; x=1726036083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a+gMxbI979G9nZ/VWTAp+MczbRAr3v0zN8HLEFJfPs=;
        b=FWuUjlj8UvzMhV1qchh3laTxFMtNLi+LHfILj1B4ssLbai67KfCnio+FnlpopdyJMX
         3vAnaNnUJlqfxh8bcdN6kM1eb6zgg3Rzw2wS/9kHeox39frMjBYzsPqhrjmycVhuZ/Ih
         jh0L/WEHPL31UE2+cmC7esygyK/PVj6bzuEAthRurxRlh0pdiwGwbyQqvvn4Njqi4SYV
         9XrPRmhU4gVChI27VhFZrj0kvfQEXj1q+mkqVBrHw2KBMFUK/O8wcLgd0buDcbdJjapp
         MG6OxxI3sgf5SNNP2MzgXnM0eP/pdl6MToHpBo+A8CxpOmMskNn1OINfmOAgPqJJ1aAM
         XnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431283; x=1726036083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4a+gMxbI979G9nZ/VWTAp+MczbRAr3v0zN8HLEFJfPs=;
        b=LTtO+3SQC8GgXc18hyg22sbCF8/ZLwqwDrfXaHuUqxf2U0MFFMUl82GitLw6wzJPGl
         OwSN9Gk0MtZmWZQ7QrXqvm0nlP6dvvsUAsyWMo1NHAH4lk9SAJZxIxXEWGIA10DzrP0D
         8IoZec/xHEceJB+f4I7Nd8MS7YSCO5JrFH++65xV5hHISmbRT+JL0mkoq0dVYVL0l16X
         MTySddF7GqVDhcB4kkDOgliWmojOweMyclznBCMY+/N2RI8lW1+r/BTBnRjildCR9Bgv
         jV7Z25CSRU9OSoK1SYSpgSbRzzWIBt63nLJRb6ZjH9b/MSEqTBOH1PCUhljHuT7D4oug
         WV8g==
X-Forwarded-Encrypted: i=1; AJvYcCUPh07vyFM7fCid3p5mG2AIWpdaOR5F/3UWLroCWzPIJ4Rp3Ex5e4vg+cw4QZTD703pT4RE08LXb+QuvVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwL8o0KZmKbl143xvkWGM7u4+J6u7KSXOuSKHbnjiFBtISK+8j
	NLs5haZpPfqejdcfJeJgU3pUYEH7lmyBE9j925msycE1Na5h7gtX
X-Google-Smtp-Source: AGHT+IE3pfoT/gWXkiaxcQf3OXmKnZypUUTfbZgc4tcaTXO8lKPOtfZfKUllGSq4U0Ck5tp82w2Qhg==
X-Received: by 2002:a05:6512:3da9:b0:52c:dcd4:8953 with SMTP id 2adb3069b0e04-53546b4a1e5mr11049647e87.36.1725431282723;
        Tue, 03 Sep 2024 23:28:02 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm768659666b.29.2024.09.03.23.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:28:02 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Arun.Ramadoss@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net-next v4 3/3] net: dsa: microchip: replace unclear KSZ8830 strings
Date: Wed,  4 Sep 2024 08:27:42 +0200
Message-ID: <20240904062749.466124-4-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904062749.466124-1-vtpieter@gmail.com>
References: <20240904062749.466124-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Replace ksz8830 with ksz88x3 for CHIP_ID definition and other
strings. This due to KSZ8830 not being an actual switch but the Chip
ID shared among KSZ8863/8873 switches, impossible to differentiate
from their Chip ID or Revision ID registers.

Now all KSZ*_CHIP_ID macros refer to actual, existing switches which
removes confusion.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c            |  2 +-
 drivers/net/dsa/microchip/ksz8863_smi.c     |  4 +-
 drivers/net/dsa/microchip/ksz_common.c      | 48 ++++++++++-----------
 drivers/net/dsa/microchip/ksz_common.h      |  4 +-
 drivers/net/dsa/microchip/ksz_spi.c         |  6 +--
 include/linux/platform_data/microchip-ksz.h |  2 +-
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 7af3c0853505..da7110d67558 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -194,7 +194,7 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
-	case KSZ8830_CHIP_ID:
+	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
 		return ksz8863_change_mtu(dev, frame_size);
diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index 5711a59e2ac9..a8bfcd917bf7 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -199,11 +199,11 @@ static void ksz8863_smi_shutdown(struct mdio_device *mdiodev)
 static const struct of_device_id ksz8863_dt_ids[] = {
 	{
 		.compatible = "microchip,ksz8863",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ88X3]
 	},
 	{
 		.compatible = "microchip,ksz8873",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ88X3]
 	},
 	{ },
 };
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 6609bf271ad0..972ccb84bd53 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -246,16 +246,16 @@ static const struct ksz_drive_strength ksz9477_drive_strengths[] = {
 	{ SW_DRIVE_STRENGTH_28MA, 28000 },
 };
 
-/* ksz8830_drive_strengths - Drive strength mapping for KSZ8830, KSZ8873, ..
+/* ksz88x3_drive_strengths - Drive strength mapping for KSZ8863, KSZ8873, ..
  *			     variants.
  * This values are documented in KSZ8873 and KSZ8863 datasheets.
  */
-static const struct ksz_drive_strength ksz8830_drive_strengths[] = {
+static const struct ksz_drive_strength ksz88x3_drive_strengths[] = {
 	{ 0,  8000 },
 	{ KSZ8873_DRIVE_STRENGTH_16MA, 16000 },
 };
 
-static void ksz8830_phylink_mac_config(struct phylink_config *config,
+static void ksz88x3_phylink_mac_config(struct phylink_config *config,
 				       unsigned int mode,
 				       const struct phylink_link_state *state);
 static void ksz_phylink_mac_config(struct phylink_config *config,
@@ -265,8 +265,8 @@ static void ksz_phylink_mac_link_down(struct phylink_config *config,
 				      unsigned int mode,
 				      phy_interface_t interface);
 
-static const struct phylink_mac_ops ksz8830_phylink_mac_ops = {
-	.mac_config	= ksz8830_phylink_mac_config,
+static const struct phylink_mac_ops ksz88x3_phylink_mac_ops = {
+	.mac_config	= ksz88x3_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz8_phylink_mac_link_up,
 };
@@ -1442,8 +1442,8 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 	},
 
-	[KSZ8830] = {
-		.chip_id = KSZ8830_CHIP_ID,
+	[KSZ88X3] = {
+		.chip_id = KSZ88X3_CHIP_ID,
 		.dev_name = "KSZ8863/KSZ8873",
 		.num_vlans = 16,
 		.num_alus = 0,
@@ -1453,7 +1453,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz88xx_dev_ops,
-		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1487,7 +1487,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz88xx_dev_ops,
-		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -1510,7 +1510,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 4,
 		.num_ipms = 4,
 		.ops = &ksz88xx_dev_ops,
-		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
 		.reg_mib_cnt = MIB_COUNTER_NUM,
@@ -2724,7 +2724,7 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 	struct ksz_device *dev = ds->priv;
 
 	switch (dev->chip_id) {
-	case KSZ8830_CHIP_ID:
+	case KSZ88X3_CHIP_ID:
 		/* Silicon Errata Sheet (DS80000830A):
 		 * Port 1 does not work with LinkMD Cable-Testing.
 		 * Port 1 does not respond to received PAUSE control frames.
@@ -3050,7 +3050,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
-	if (dev->chip_id == KSZ8830_CHIP_ID ||
+	if (dev->chip_id == KSZ88X3_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3162,7 +3162,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
-	case KSZ8830_CHIP_ID:
+	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
@@ -3334,7 +3334,7 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 	return interface;
 }
 
-static void ksz8830_phylink_mac_config(struct phylink_config *config,
+static void ksz88x3_phylink_mac_config(struct phylink_config *config,
 				       unsigned int mode,
 				       const struct phylink_link_state *state)
 {
@@ -3518,7 +3518,7 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		break;
 	case KSZ88_FAMILY_ID:
 		if (id2 == KSZ88_CHIP_ID_63)
-			dev->chip_id = KSZ8830_CHIP_ID;
+			dev->chip_id = KSZ88X3_CHIP_ID;
 		else
 			return -ENODEV;
 		break;
@@ -4592,24 +4592,24 @@ static int ksz9477_drive_strength_write(struct ksz_device *dev,
 }
 
 /**
- * ksz8830_drive_strength_write() - Set the drive strength configuration for
- *				    KSZ8830 compatible chip variants.
+ * ksz88x3_drive_strength_write() - Set the drive strength configuration for
+ *				    KSZ8863 compatible chip variants.
  * @dev:       ksz device
  * @props:     Array of drive strength properties to be set
  * @num_props: Number of properties in the array
  *
- * This function applies the specified drive strength settings to KSZ8830 chip
+ * This function applies the specified drive strength settings to KSZ88X3 chip
  * variants (KSZ8873, KSZ8863).
  * It ensures the configurations align with what the chip variant supports and
  * warns or errors out on unsupported settings.
  *
  * Return: 0 on success, error code otherwise
  */
-static int ksz8830_drive_strength_write(struct ksz_device *dev,
+static int ksz88x3_drive_strength_write(struct ksz_device *dev,
 					struct ksz_driver_strength_prop *props,
 					int num_props)
 {
-	size_t array_size = ARRAY_SIZE(ksz8830_drive_strengths);
+	size_t array_size = ARRAY_SIZE(ksz88x3_drive_strengths);
 	int microamp;
 	int i, ret;
 
@@ -4622,10 +4622,10 @@ static int ksz8830_drive_strength_write(struct ksz_device *dev,
 	}
 
 	microamp = props[KSZ_DRIVER_STRENGTH_IO].value;
-	ret = ksz_drive_strength_to_reg(ksz8830_drive_strengths, array_size,
+	ret = ksz_drive_strength_to_reg(ksz88x3_drive_strengths, array_size,
 					microamp);
 	if (ret < 0) {
-		ksz_drive_strength_error(dev, ksz8830_drive_strengths,
+		ksz_drive_strength_error(dev, ksz88x3_drive_strengths,
 					 array_size, microamp);
 		return ret;
 	}
@@ -4685,8 +4685,8 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 		return 0;
 
 	switch (dev->chip_id) {
-	case KSZ8830_CHIP_ID:
-		return ksz8830_drive_strength_write(dev, of_props,
+	case KSZ88X3_CHIP_ID:
+		return ksz88x3_drive_strength_write(dev, of_props,
 						    ARRAY_SIZE(of_props));
 	case KSZ8795_CHIP_ID:
 	case KSZ8794_CHIP_ID:
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index e08d5a1339f4..bec846e20682 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -200,7 +200,7 @@ enum ksz_model {
 	KSZ8795,
 	KSZ8794,
 	KSZ8765,
-	KSZ8830,
+	KSZ88X3,
 	KSZ8864,
 	KSZ8895,
 	KSZ9477,
@@ -628,7 +628,7 @@ static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
 
 static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 {
-	return dev->chip_id == KSZ8830_CHIP_ID;
+	return dev->chip_id == KSZ88X3_CHIP_ID;
 }
 
 static inline bool ksz_is_8895_family(struct ksz_device *dev)
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index f4287310e89f..e3e341431f09 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -54,7 +54,7 @@ static int ksz_spi_probe(struct spi_device *spi)
 	if (!chip)
 		return -EINVAL;
 
-	if (chip->chip_id == KSZ8830_CHIP_ID)
+	if (chip->chip_id == KSZ88X3_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
 	else if (chip->chip_id == KSZ8795_CHIP_ID ||
 		 chip->chip_id == KSZ8794_CHIP_ID ||
@@ -137,7 +137,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 	},
 	{
 		.compatible = "microchip,ksz8863",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ88X3]
 	},
 	{
 		.compatible = "microchip,ksz8864",
@@ -145,7 +145,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 	},
 	{
 		.compatible = "microchip,ksz8873",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ88X3]
 	},
 	{
 		.compatible = "microchip,ksz8895",
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index d074019474f5..2ee1a679e592 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -27,7 +27,7 @@ enum ksz_chip_id {
 	KSZ8795_CHIP_ID = 0x8795,
 	KSZ8794_CHIP_ID = 0x8794,
 	KSZ8765_CHIP_ID = 0x8765,
-	KSZ8830_CHIP_ID = 0x8830,
+	KSZ88X3_CHIP_ID = 0x8830,
 	KSZ8864_CHIP_ID = 0x8864,
 	KSZ8895_CHIP_ID = 0x8895,
 	KSZ9477_CHIP_ID = 0x00947700,
-- 
2.43.0


