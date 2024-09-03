Return-Path: <netdev+bounces-124416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6396958C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820411F24931
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C01C62B1;
	Tue,  3 Sep 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXxeDwCI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6E21C17E;
	Tue,  3 Sep 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348605; cv=none; b=D92J3wn7VijBSvZkEOLOWktHXRCK2iYwZZvYeQm7yzCnwD3/cKhKLFAMMwF1akJpS14eOCjQ40+CMy6u2syEdRPHvHmfUbcqxvNKjJGXyU/01S3lh5Zy4aWkwYQfQw6ZDDBf2L9cGVKXfE5AOakYGCeIwnvrk1vTIiHlWXmjlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348605; c=relaxed/simple;
	bh=XFNdJxjyz/eJhlajmac/JXrM3eG3at89iVTnAGFMeew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMQWpqlN0FhdAlFHhMUuHf44g5nB0njPP60lnTSmn9JqbxgStUoYOONN6rTCee2k4Tj8L9WD0HPJJqutfwDU9kouDWG6UU4cUmzQ7u1BGAHgIJ8TfsdVeFP0vIfuYo1Fl2BIK06J61x+2HEoZLgmdCgaDGunZdS4/q0osGfMi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXxeDwCI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c218866849so5173931a12.0;
        Tue, 03 Sep 2024 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348602; x=1725953402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YExANa6JHEGeFZoWy12GGz2iAP6FIVZ1vVudXnGmUE=;
        b=AXxeDwCIU5/Pv8E2XYTJWBJKL38qS/8ToJpI5E5tniKTmElQXp18RJvatSkTLopIL4
         namBlqx3in20HqcvN/UA8sde72OKJjpKcMZrNRhpiKC/nJ0feMkCJdy3HqWyYmO/0afi
         kae16FvPS5a/wc1QvSbnjM08bzcLMvsJQNmPa/aSJZa7KOSkcT/s0NR+6d5JgbrVRg2u
         jz/jAJBdIG2ymTF8xBf1gdRIrUBGQaRhqmV55uw46kZ/eeod/cnXc/zpRLnl+M7kbGhq
         NTHJQMFV57LIAiovJLubmHX6Fz0gL6z33hK9ngHelBB/9Ap7qXdE7eBPHwkRtjdzaT4F
         8r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348602; x=1725953402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YExANa6JHEGeFZoWy12GGz2iAP6FIVZ1vVudXnGmUE=;
        b=TrVqQHjvvoywB89LCAu/SUJaV4ypmg0Swl427oTCK8ddIwMagtXlz5Dhu0UNqwjoRn
         IDGJ+V00s92Qn5DWyolRAqv6HAtu/kxZ9cYUYfxbml9oOP8xqw6A5+aFyEVJJkNr0Bab
         Au5Sa8q1zdbTRwdRKE1lsYiEfjeAvYDAhn1MZ82NpD0p71/nk5wvfrdDhoVbF/h35Bot
         g9sxLKu8Utwi0cTcDzxZwrKRneZPxx3QmiRz2EyIVa48qNSWTYZBtcF5zzoI6XQedRj+
         oOxcD6xoGkj8QnQxWC7ipXRyLYViTeGbURx/hJM23bX2mQ3+ZB0Hc+kOklvTDuonPVga
         J37g==
X-Forwarded-Encrypted: i=1; AJvYcCWRz8WsvYSSNd830l4glQBHfpV0kvQQqJl1B2DXhW9CrdFwLrOZt4GK3yRO+JUbFWPDRvYaZ5I79J8gjFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxuX1p/b6PsVP84YXynXvIca9IY6C74S76ANa8f7HtW0APl/e
	zTBwDF07Twvi3Fym5YzUWlKRiwyI74Sfm00PELj+EtFAnQj17yJU
X-Google-Smtp-Source: AGHT+IFd1bXru9SLF721XhmSfJFVRaJQ8u7VjUWTZCYrS1dGYRDl6O0EKLrHuYY9AKkDJPBdZh8zSQ==
X-Received: by 2002:a50:8dc8:0:b0:5a1:c43:82ca with SMTP id 4fb4d7f45d1cf-5c242f21e9emr5559629a12.26.1725348601939;
        Tue, 03 Sep 2024 00:30:01 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a37asm6121947a12.1.2024.09.03.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:30:01 -0700 (PDT)
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
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 3/3] net: dsa: microchip: replace unclear KSZ8830 strings
Date: Tue,  3 Sep 2024 09:29:39 +0200
Message-ID: <20240903072946.344507-4-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903072946.344507-1-vtpieter@gmail.com>
References: <20240903072946.344507-1-vtpieter@gmail.com>
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


