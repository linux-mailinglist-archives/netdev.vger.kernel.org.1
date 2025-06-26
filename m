Return-Path: <netdev+bounces-201684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FCAEA8C5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B514E3C2C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20B27EFFE;
	Thu, 26 Jun 2025 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMJ4lX3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E0270EBB;
	Thu, 26 Jun 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973045; cv=none; b=hm2Ponh75nNTvcjf2D9EKBDXragY3unmtwBLZHmIErqPV3zOmpZkqYK+hj0cMUf3EFgxdfVI8RZPQ1XrThsq1RY8NHBZsFewhxgN55dJ35r83ISjYUUovSQNOLvkUGcC88+FSYAp2KPMjjr1cITR8v8WvNpsXdHkAhAopXXf9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973045; c=relaxed/simple;
	bh=VgK/NIhUXE0D/v0L2JOAxu2iW9zQf8L4zbbGLAyyORk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2/GL6wspWO25ZwWjZzQjL1dx5rrzJ1Vq+axKa5TBVznYigOA85/fB3w26HSguFqypYUJMy4+XuuXFBcIhkeRk9YC/sMMKHFvkJ0K5Fy6v0BoL1j9x+hjh39fnWxrIIcxZp6Hje2XTr+Tpppl4y9lFchKKuWg62BCx2xDheWKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMJ4lX3a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so8414445e9.2;
        Thu, 26 Jun 2025 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973041; x=1751577841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDI29+q7HlJ7MkSmIREKY4LqDtP09HQBgq1hjSUYkAM=;
        b=WMJ4lX3aD1i4yKuo0WZ8pH+f9Y/rkvWLgNjGA1AZfDDO3zthcxUqAzyIbjNvSRhyTJ
         0HwIXGNKnX28kJrd4NMG+QWHA7OMZNlgEsvZBbG5zBsr3N26nwIfjWrZPAubPIouCeKN
         F8jsEruc4J5DQkK5KB9p3kKXUEnFSyUWP+jO2pzWrGYKf2SZdqVU3BsTQJfGqmwaEgyB
         DzHSKagNLuQDqwdb0Jniysk2mwOMNN7Xu3v86ynPBZLe3Aox2By+1BcXrIRFxvIRNe9W
         2+z9t8+OcAPjpdO+Cc3B3qJKjPIn2H95RrmhXur4Az9nYBc720NpQrH6nizQhGLQfwOK
         w8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973041; x=1751577841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDI29+q7HlJ7MkSmIREKY4LqDtP09HQBgq1hjSUYkAM=;
        b=cZQJRx8THv9k9PbcdV7U9vkftXCewxnQimrkEe4cEpWtesrcwGr1G3yJ3GQJ/cHPmR
         lDrNjL8//lskS6Ol4C+MM3M6ufEVy0ZL2BWQuVvp4GXoWG/8DLfDy4rxE5epPMqwm9IY
         yEkws13UtgDLB/J0zSgt1lRPucNU+BffiwwsauKr8qRFjXLDVVFkvEA20TsyH12YChx9
         UKcoSxiIG22kRzq6RReLRNJ7z+rvVtx1ZKOR20N80C4IXn6PIa94OQMDHQ2ylpEbcSI0
         BoaDxm4DHeBkDF/nRuRWjJZy7EfrUzy9xv0W450KI8cTMLl/K6Tqc2QfKzAsge1GKxSH
         q09A==
X-Forwarded-Encrypted: i=1; AJvYcCWMyFQh/rjDeJd59eU/dLRUz3Td9kVpE2ZPPFnxk7FRjSBYn6MHQjynr8MxqTnD7XmdMMol7C1EYekV@vger.kernel.org, AJvYcCWTbwfmIcGypvnyMz5/7UAgcKpgpdRvMjXz3arzg1aaUAzg7BwOgvG1VPYobrvwL8oBswylwG7GVRWXPjBq@vger.kernel.org, AJvYcCWfP+DiRwYeNbfzImqd24iT2yrORHeqkh+9ZESU+PvllkrtYxJx4+/XKR6Si5A5iIFJpPMVcdr7@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfVHX38jTjxIU6MPrzbl6JGdMj8KXIgY7pKgDkQYfDCzja3Pf
	hpfjms3PJD2MdjlSu65lb1cfcvWi2D7LxkAukivtHGPKNJYh40AqYzAZ
X-Gm-Gg: ASbGncs8PhLetONKEtRm4/s7quzFn89APD+GyNxjZzKP8IDnYYuV4EOa68ZZts/5ohp
	4FZ6uF8lUNtPyTzJf/zlUC2IsVQBOsY3mJdpX/7tT2glHskhBN0Tolpx5ReKXqa8cEcl108ZV8s
	RXaMwRn9iZBWzOSvhyh31Nm/df2Uu/eKnhuFDE3AJRxAVJFSB05jnJb0LaQJRnXHWYoqrk3M5dW
	vJc0BlcuxGwRhxCbTRSaNfzZGwFHSLMUzYEozuwcjaMFyh2SG2YxXnVsB/i3R0CH/C7csx3ZWqR
	CKXEzmcvM/rS6x3r8gNGD1R0Xg+CjTPKmJrvKDRsZwbLZ+yzN6waepruPV44bYw3iGNjgpnYYqb
	2nU5rHP3Zq+8m5jHUZwhNMHX+OWCe3NclY1AiJRi/mQ==
X-Google-Smtp-Source: AGHT+IHywJBN/nU81F+eHK8T8VpKKa8vo6AdlwewctsWYZguLnQqkjAOXE7zIDslsvuWqLPSKStb0g==
X-Received: by 2002:a05:600c:8506:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-4538ee61ed7mr7479385e9.21.1750973040960;
        Thu, 26 Jun 2025 14:24:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:24:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v15 06/12] net: mdio: Add Airoha AN8855 Switch MDIO PBUS
Date: Thu, 26 Jun 2025 23:23:05 +0200
Message-ID: <20250626212321.28114-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 MDIO PBUS driver that permits to access the internal
Gigabit PHY from the Switch register.

This have the benefits of exposing direct access to CL45 address and
Vendor MDIO pages via specific Switch registers.

Additional info are present in a long explaination in the MDIO driver
and also finding from Reverse-Engineering the implementation.

This requires the upper Switch MFD to be probed and init to actually
work as it does make use of regmap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/Kconfig       |  10 ++
 drivers/net/mdio/Makefile      |   1 +
 drivers/net/mdio/mdio-an8855.c | 262 +++++++++++++++++++++++++++++++++
 include/linux/dsa/an8855.h     |  18 +++
 4 files changed, 291 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-an8855.c
 create mode 100644 include/linux/dsa/an8855.h

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 7db40aaa079d..7f8f0b5caa42 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -42,6 +42,16 @@ config MDIO_XGENE
 	  This module provides a driver for the MDIO busses found in the
 	  APM X-Gene SoC's.
 
+config MDIO_AN8855
+	tristate "Airoha AN8855 Switch MDIO bus controller"
+	depends on MFD_AIROHA_AN8855
+	depends on OF_MDIO
+	select MDIO_REGMAP
+	help
+	  This module provides a driver for the Airoha AN8855 Switch
+	  that requires a MDIO passtrough as switch address is shared
+	  with the internal PHYs and requires additional page handling.
+
 config MDIO_ASPEED
 	tristate "ASPEED MDIO bus controller"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index c23778e73890..2b9edddf3911 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ACPI_MDIO)		+= acpi_mdio.o
 obj-$(CONFIG_FWNODE_MDIO)	+= fwnode_mdio.o
 obj-$(CONFIG_OF_MDIO)		+= of_mdio.o
 
+obj-$(CONFIG_MDIO_AN8855)		+= mdio-an8855.o
 obj-$(CONFIG_MDIO_ASPEED)		+= mdio-aspeed.o
 obj-$(CONFIG_MDIO_BCM_IPROC)		+= mdio-bcm-iproc.o
 obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
diff --git a/drivers/net/mdio/mdio-an8855.c b/drivers/net/mdio/mdio-an8855.c
new file mode 100644
index 000000000000..990cf683b470
--- /dev/null
+++ b/drivers/net/mdio/mdio-an8855.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MDIO PBUS driver for Airoha AN8855 Switch
+ *
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ *
+ */
+
+#include <linux/dsa/an8855.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* AN8855 permit to access the internal GPHY via the PBUS
+ * interface.
+ *
+ * Some piece of this comes from Reverse-Enginnering
+ * by applying the value on the Switch and observing
+ * it by reading the raw value on the MDIO BUS.
+ *
+ * The CL22 address are shifted by 4 left
+ * The CL44 address need to be multiplied by 4 (and
+ * no shift)
+ *
+ * The GPHY have additional configuration (like auto
+ * downshift) at PAGE 1 in the EXT register.
+ * It was discovered that it's possible to access
+ * PAGE x address by increasing them by 2 on setting
+ * the value in the related mask.
+ * The PHY have these custom/vendor register
+ * always starting at 0x10.
+ * From MDIO bus, for address 0x0 to 0xf, PHY
+ * always report PAGE 0 values.
+ * From PBUS, on setting the PAGE value, 0x0 to 0xf
+ * always report 0.
+ *
+ * (it can also be notice that PBUS does NOT change the
+ *  page on accessing these custom/vendor register)
+ *
+ * Comparison examples:
+ *	(PORT 0 PAGE 1)		  |	(PORT 0 PAGE 2)
+ *  PBUS ADDR	  VALUE	    MDIO  |  PBUS ADDR	  VALUE	    MDIO
+ * 0xa0803000: 0x00000000  0x1840 | 0xa0804000: 0x00000000  0x1840
+ * 0xa0803010: 0x00000000  0x7949 | 0xa0804010: 0x00000000  0x7949
+ * 0xa0803020: 0x00000000  0xc0ff | 0xa0804020: 0x00000000  0xc0ff
+ * 0xa0803030: 0x00000000  0x0410 | 0xa0804030: 0x00000000  0x0410
+ * 0xa0803040: 0x00000000  0x0de1 | 0xa0804040: 0x00000000  0x0de1
+ * 0xa0803050: 0x00000000  0x0000 | 0xa0804050: 0x00000000  0x0000
+ * 0xa0803060: 0x00000000  0x0004 | 0xa0804060: 0x00000000  0x0004
+ * 0xa0803070: 0x00000000  0x2001 | 0xa0804070: 0x00000000  0x2001
+ * 0xa0803080: 0x00000000  0x0000 | 0xa0804080: 0x00000000  0x0000
+ * 0xa0803090: 0x00000000  0x0200 | 0xa0804090: 0x00000000  0x0200
+ * 0xa08030a0: 0x00000000  0x4000 | 0xa08040a0: 0x00000000  0x4000
+ * 0xa08030b0: 0x00000000  0x0000 | 0xa08040b0: 0x00000000  0x0000
+ * 0xa08030c0: 0x00000000  0x0000 | 0xa08040c0: 0x00000000  0x0000
+ * 0xa08030d0: 0x00000000  0x0000 | 0xa08040d0: 0x00000000  0x0000
+ * 0xa08030e0: 0x00000000  0x0000 | 0xa08040e0: 0x00000000  0x0000
+ * 0xa08030f0: 0x00000000  0x2000 | 0xa08040f0: 0x00000000  0x2000
+ * 0xa0803100: 0x00000000  0x0000 | 0xa0804100: 0x00000000  0x0000
+ * 0xa0803110: 0x00000000  0x0000 | 0xa0804110: 0x0000030f  0x030f
+ * 0xa0803120: 0x00000000  0x0000 | 0xa0804120: 0x00000000  0x0000
+ * 0xa0803130: 0x00000030  0x0030 | 0xa0804130: 0x00000000  0x0000
+ * 0xa0803140: 0x00003a14  0x3a14 | 0xa0804140: 0x00000000  0x0000
+ * 0xa0803150: 0x00000101  0x0101 | 0xa0804150: 0x00000000  0x0000
+ * 0xa0803160: 0x00000001  0x0001 | 0xa0804160: 0x00000000  0x0000
+ * 0xa0803170: 0x00000800  0x0800 | 0xa0804170: 0x000001ff  0x01ff
+ * 0xa0803180: 0x00000000  0x0000 | 0xa0804180: 0x0000ff1f  0xff1f
+ * 0xa0803190: 0x0000001f  0x001f | 0xa0804190: 0x000083ff  0x83ff
+ * 0xa08031a0: 0x00000000  0x0000 | 0xa08041a0: 0x00000000  0x0000
+ * 0xa08031b0: 0x00000000  0x0000 | 0xa08041b0: 0x00000000  0x0000
+ * 0xa08031c0: 0x00003001  0x3001 | 0xa08041c0: 0x00000000  0x0000
+ * 0xa08031d0: 0x00000000  0x0000 | 0xa08041d0: 0x00000000  0x0000
+ * 0xa08031e0: 0x00000000  0x0000 | 0xa08041e0: 0x00000000  0x0000
+ * 0xa08031f0: 0x00000000  0x0001 | 0xa08041f0: 0x00000000  0x0002
+ *
+ * Using the PBUS permits to have consistent access
+ * to Switch and PHY without having to relay on checking
+ * pages.
+ *
+ * It does also permit to cut on CL45 access and PAGE1
+ * access as the PBUS expose direct register for them.
+ *
+ * The base address is 0xa0800000 and can be seen as
+ * bitmap to derive each specific address.
+ *
+ * Example:
+ *   PORT 1 ADDR 0x2 --> 0xa1800020
+ *			    ^    ^
+ *			    |    ADDR
+ *			    PORT
+ *   PORT 2 DEVAD 1 ADDR 0x2 --> 0xa2840008
+ *				    ^ ^   ^
+ *				    | |   ADDR (*4)
+ *				    | DEVAD
+ *				    PORT
+ *   PORT 3 PAGE 1 ADDR 0x14 --> 0xa3803140
+ *				    ^  ^^^
+ *				    |  |ADDR
+ *				    |  PAGE (+2)
+ *				    PORT
+ *
+ * It's worth mention that trying to read more than the
+ * expected PHY address cause the PBUS to ""crash"" and
+ * the Switch to lock out (requiring a reset).
+ * Validation of the port value is put to prevent this
+ * problem.
+ */
+
+struct an8855_mdio_priv {
+	struct regmap *regmap;
+	u32 base_addr;
+	u8 next_page;
+};
+
+static int an8855_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct an8855_mdio_priv *priv = bus->priv;
+	u32 pbus_addr = AN8855_GPHY_ACCESS;
+	u32 port = addr - priv->base_addr;
+	u32 val;
+	int ret;
+
+	/* Signal invalid address for mdio tools */
+	if (port >= AN8855_NUM_PHY_PORT)
+		return 0xffff;
+
+	pbus_addr |= FIELD_PREP(AN8855_GPHY_PORT, port);
+	pbus_addr |= FIELD_PREP(AN8855_CL22_ADDR, regnum);
+	if (priv->next_page)
+		pbus_addr |= FIELD_PREP(AN8855_PAGE_SELECT,
+					priv->next_page + 2);
+
+	ret = regmap_read(priv->regmap, pbus_addr, &val);
+	if (ret)
+		return ret;
+
+	return val & 0xffff;
+}
+
+static int an8855_mdio_write(struct mii_bus *bus, int addr, int regnum,
+			     u16 value)
+{
+	struct an8855_mdio_priv *priv = bus->priv;
+	u32 pbus_addr = AN8855_GPHY_ACCESS;
+	u32 port = addr - priv->base_addr;
+
+	if (port >= AN8855_NUM_PHY_PORT)
+		return -EINVAL;
+
+	/* When PHY ask to change page, skip writing it and
+	 * save it for the next read/write.
+	 */
+	if (regnum == AN8855_PHY_SELECT_PAGE) {
+		priv->next_page = value;
+		return 0;
+	}
+
+	pbus_addr |= FIELD_PREP(AN8855_GPHY_PORT, port);
+	pbus_addr |= FIELD_PREP(AN8855_CL22_ADDR, regnum);
+	if (priv->next_page)
+		pbus_addr |= FIELD_PREP(AN8855_PAGE_SELECT,
+					priv->next_page + 2);
+
+	return regmap_write(priv->regmap, pbus_addr, value);
+}
+
+static int an8855_mdio_cl45_read(struct mii_bus *bus, int addr, int devnum,
+				 int regnum)
+{
+	struct an8855_mdio_priv *priv = bus->priv;
+	u32 pbus_addr = AN8855_GPHY_ACCESS;
+	u32 port = addr - priv->base_addr;
+	u32 val;
+	int ret;
+
+	/* Signal invalid address for mdio tools */
+	if (port >= AN8855_NUM_PHY_PORT)
+		return 0xffff;
+
+	pbus_addr |= FIELD_PREP(AN8855_GPHY_PORT, port);
+	pbus_addr |= FIELD_PREP(AN8855_DEVAD_ADDR, devnum);
+	pbus_addr |= FIELD_PREP(AN8855_CL45_ADDR, regnum * 4);
+
+	ret = regmap_read(priv->regmap, pbus_addr, &val);
+	if (ret)
+		return ret;
+
+	return val & 0xffff;
+}
+
+static int an8855_mdio_cl45_write(struct mii_bus *bus, int addr, int devnum,
+				  int regnum, u16 value)
+{
+	struct an8855_mdio_priv *priv = bus->priv;
+	u32 pbus_addr = AN8855_GPHY_ACCESS;
+	u32 port = addr - priv->base_addr;
+
+	if (port >= AN8855_NUM_PHY_PORT)
+		return -EINVAL;
+
+	pbus_addr |= FIELD_PREP(AN8855_GPHY_PORT, port);
+	pbus_addr |= FIELD_PREP(AN8855_DEVAD_ADDR, devnum);
+	pbus_addr |= FIELD_PREP(AN8855_CL45_ADDR, regnum * 4);
+
+	return regmap_write(priv->regmap, pbus_addr, value);
+}
+
+static int an8855_mdio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct an8855_mdio_priv *priv;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	priv = bus->priv;
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return -ENOENT;
+
+	ret = of_property_read_u32(dev->parent->of_node, "reg",
+				   &priv->base_addr);
+	if (ret)
+		return -EINVAL;
+
+	bus->name = "an8855_mdio_bus";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-gphy-pbus", dev_name(dev));
+	bus->parent = dev;
+	bus->read = an8855_mdio_read;
+	bus->write = an8855_mdio_write;
+	bus->read_c45 = an8855_mdio_cl45_read;
+	bus->write_c45 = an8855_mdio_cl45_write;
+
+	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register MDIO bus\n");
+
+	return 0;
+}
+
+static const struct of_device_id an8855_mdio_of_match[] = {
+	{ .compatible = "airoha,an8855-mdio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_mdio_of_match);
+
+static struct platform_driver an8855_mdio_driver = {
+	.probe	= an8855_mdio_probe,
+	.driver = {
+		.name = "an8855-mdio",
+		.of_match_table = an8855_mdio_of_match,
+	},
+};
+module_platform_driver(an8855_mdio_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for AN8855 MDIO passthrough");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/dsa/an8855.h b/include/linux/dsa/an8855.h
new file mode 100644
index 000000000000..32ec29b3abb0
--- /dev/null
+++ b/include/linux/dsa/an8855.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_AN8855_H
+#define _NET_AN8855_H
+
+#define AN8855_GPHY_ACCESS		0xa0800000
+#define	  AN8855_GPHY_PORT		GENMASK(26, 24)
+#define	  AN8855_DEVAD_ADDR		GENMASK(23, 18)
+#define	  AN8855_PAGE_SELECT		GENMASK(14, 12)
+#define	  AN8855_ADDR			GENMASK(11, 0)
+#define	    AN8855_CL45_ADDR		AN8855_ADDR
+#define	    AN8855_CL22_ADDR		GENMASK(8, 4)
+
+#define AN8855_PHY_SELECT_PAGE		0x1f
+
+#define AN8855_NUM_PHY_PORT		5
+
+#endif /* _NET_AN8855_H */
-- 
2.48.1


