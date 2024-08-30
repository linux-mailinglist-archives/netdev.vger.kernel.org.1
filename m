Return-Path: <netdev+bounces-123713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902A9663E8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9194284A11
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891671B250A;
	Fri, 30 Aug 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy9w7rvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633751B3B19;
	Fri, 30 Aug 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027193; cv=none; b=HDY18TE4yRvc1Pk3/Q5EQj036Reg3yRGyrSBGl5u/TcUpHpWtrFnMyDT54CCIjbNwym+jela5LLL29mdkcmZMjWuXIyMdSavtAEKthe3/kZJwNdoW4l3enksnBX/QAc7XPQcHVpU2OHSm+XgKlmuv+Xh5z8onM8FdykKX2QRH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027193; c=relaxed/simple;
	bh=IkcIoYmLAgKtTISkzsK4x5e64jwVjAVfW9WAy79vU1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOFs5S3kTmE+OvRP58sPRfp4e4XYSjYHPtFkwEajPz10nSdcIhG+wzM/E04liCTF71YBfCTU0+NuyNBkRyjq8a2qQaqFSdcQQjU5+L+1cxh3gd3+r3RUMioBDwPI1hsf/L599YlxSeqaj9DfYmSgreagp+Wg0xqVmuFpAoJXuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy9w7rvw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a869332c2c2so489744566b.0;
        Fri, 30 Aug 2024 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027190; x=1725631990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDh1L58sJKyioueW76oQ9OUtBcYWhTK18b85GSmBAt0=;
        b=Gy9w7rvwITz6TnmiI9WeHSgD6k9jtypyDFIfFbjBN5/N2cYOZ7R1h+OmlCfMO/bXAA
         NX/Fw+A+b+fNeO1h918gDzQj7qsEVAZdUp3kC1xQArw3Hr1BvF03PYsSTLGpBuBF96nW
         jB1Bqf7LgBZ8NQnvcYuU9rEes1QXjW9Wb2URWkULNJbq9EDDNm0POHXz0GnjUpbSaQnt
         H/DFj1waJTWrlJ+sRYAVILOWNJ7ZXVgIV2gPz34qNGNps9LSF/SQDQncD8Q7Mjh0rELE
         m3lr24smgDzfWcTC3B2AAHBCpFy3DMQT7ZtH+N1K9Hl74oKTFbgVazUCEIkUqzl+6Lze
         3C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027190; x=1725631990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDh1L58sJKyioueW76oQ9OUtBcYWhTK18b85GSmBAt0=;
        b=kzrO7GwkMhhGJpgJEVpOilOaRI1y5Ygj843W2iIBkTulyQ3QUBIbMWBAHj9eMpC//F
         EEXbYeSTRqru9boEtF28Vy+XdclQM3k4L2bz86fzqM3eon5B156aTaicxOkSJn7ENA3a
         ZligS0Go4SPlLkOeimCtkXJwM36QfiOw5yWPWgI7W7s4SvCNrL9cewXVWJJpfioiGryE
         COLzlL6lagfzylA7WynX1zz3xbDSXZ/+NNEBxnjh+vcITeuJCU0iQE7H2gjxGjdFbPdb
         ls4Heve4uL7TdH2TDGUyLe+cp35uc2MwbPW/WQoCqq4NPVkbwL3nb/3WYTtUvZNG9vqc
         AW5A==
X-Forwarded-Encrypted: i=1; AJvYcCWKBjVUrGuzhMQGom7VhqIHQPV0EytNcscrQRp2HRYDZKEl0cycX8heN3tqfQR+6vexgUbuUCbyFF4R4Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AERLiwSRiy8QGhtCn+vKeUUlcQ1urexNG5enhC3GERwZDvhp
	Ms+dVv3OygNqLgPqNE46yDiy08uTHk3+TfrAKZGAG+578Z/ord6xO1k1yggxXZ2xRA==
X-Google-Smtp-Source: AGHT+IHmvj2Sj2gDYESqxEFatv1yTyCvXZqrzuQar3VCEEb2gbrPFdTgy0S/KTpZGp3gD87pyk0G6g==
X-Received: by 2002:a17:907:608c:b0:a7d:8912:6697 with SMTP id a640c23a62f3a-a898231cbe5mr624656166b.3.1725027189485;
        Fri, 30 Aug 2024 07:13:09 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196975sm221304166b.135.2024.08.30.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:13:09 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arun.Ramadoss@microchip.com,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 3/3] net: dsa: microchip: replace unclear KSZ8830 strings
Date: Fri, 30 Aug 2024 16:12:43 +0200
Message-ID: <20240830141250.30425-4-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830141250.30425-1-vtpieter@gmail.com>
References: <20240830141250.30425-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Replace uppercase KSZ8830 with KSZ8863 and lowercase ksz8830 with
ksz88x3 strings. This because KSZ8830 is not an actual switch but it's
the Chip ID shared among KSZ8863/KSZ8873 switches, impossible to
differentiate from their Chip ID or Revision registers.

Now all KSZ*_CHIP_ID macros refer to actual, existing switches which
removes confusion.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8.c            |  2 +-
 drivers/net/dsa/microchip/ksz8863_smi.c     |  4 +-
 drivers/net/dsa/microchip/ksz_common.c      | 48 ++++++++++-----------
 drivers/net/dsa/microchip/ksz_common.h      |  5 ++-
 drivers/net/dsa/microchip/ksz_spi.c         |  6 +--
 include/linux/platform_data/microchip-ksz.h |  2 +-
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 7af3c0853505..4c15e0911636 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -194,7 +194,7 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
-	case KSZ8830_CHIP_ID:
+	case KSZ8863_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
 		return ksz8863_change_mtu(dev, frame_size);
diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index 5711a59e2ac9..c28cb84771c1 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -199,11 +199,11 @@ static void ksz8863_smi_shutdown(struct mdio_device *mdiodev)
 static const struct of_device_id ksz8863_dt_ids[] = {
 	{
 		.compatible = "microchip,ksz8863",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ8863]
 	},
 	{
 		.compatible = "microchip,ksz8873",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ8863]
 	},
 	{ },
 };
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 6609bf271ad0..1276d7455e5c 100644
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
+	[KSZ8863] = {
+		.chip_id = KSZ8863_CHIP_ID,
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
+	case KSZ8863_CHIP_ID:
 		/* Silicon Errata Sheet (DS80000830A):
 		 * Port 1 does not work with LinkMD Cable-Testing.
 		 * Port 1 does not respond to received PAUSE control frames.
@@ -3050,7 +3050,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
-	if (dev->chip_id == KSZ8830_CHIP_ID ||
+	if (dev->chip_id == KSZ8863_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3162,7 +3162,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
-	case KSZ8830_CHIP_ID:
+	case KSZ8863_CHIP_ID:
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
+			dev->chip_id = KSZ8863_CHIP_ID;
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
+	case KSZ8863_CHIP_ID:
+		return ksz88x3_drive_strength_write(dev, of_props,
 						    ARRAY_SIZE(of_props));
 	case KSZ8795_CHIP_ID:
 	case KSZ8794_CHIP_ID:
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index e08d5a1339f4..428d2d97faca 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -200,7 +200,8 @@ enum ksz_model {
 	KSZ8795,
 	KSZ8794,
 	KSZ8765,
-	KSZ8830,
+	KSZ8863,
+	KSZ8873,
 	KSZ8864,
 	KSZ8895,
 	KSZ9477,
@@ -628,7 +629,7 @@ static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
 
 static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 {
-	return dev->chip_id == KSZ8830_CHIP_ID;
+	return dev->chip_id == KSZ8863_CHIP_ID;
 }
 
 static inline bool ksz_is_8895_family(struct ksz_device *dev)
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index f4287310e89f..2986274e522b 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -54,7 +54,7 @@ static int ksz_spi_probe(struct spi_device *spi)
 	if (!chip)
 		return -EINVAL;
 
-	if (chip->chip_id == KSZ8830_CHIP_ID)
+	if (chip->chip_id == KSZ8863_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
 	else if (chip->chip_id == KSZ8795_CHIP_ID ||
 		 chip->chip_id == KSZ8794_CHIP_ID ||
@@ -137,7 +137,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 	},
 	{
 		.compatible = "microchip,ksz8863",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ8863]
 	},
 	{
 		.compatible = "microchip,ksz8864",
@@ -145,7 +145,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 	},
 	{
 		.compatible = "microchip,ksz8873",
-		.data = &ksz_switch_chips[KSZ8830]
+		.data = &ksz_switch_chips[KSZ8863]
 	},
 	{
 		.compatible = "microchip,ksz8895",
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index d074019474f5..c7bf8d4b7805 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -27,7 +27,7 @@ enum ksz_chip_id {
 	KSZ8795_CHIP_ID = 0x8795,
 	KSZ8794_CHIP_ID = 0x8794,
 	KSZ8765_CHIP_ID = 0x8765,
-	KSZ8830_CHIP_ID = 0x8830,
+	KSZ8863_CHIP_ID = 0x8863,
 	KSZ8864_CHIP_ID = 0x8864,
 	KSZ8895_CHIP_ID = 0x8895,
 	KSZ9477_CHIP_ID = 0x00947700,
-- 
2.43.0


