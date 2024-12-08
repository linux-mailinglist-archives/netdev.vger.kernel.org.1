Return-Path: <netdev+bounces-149936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8769E82E2
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE06188043C
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63F13DB9F;
	Sun,  8 Dec 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtN9nKmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6613B592;
	Sun,  8 Dec 2024 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617319; cv=none; b=TYLH0WqU8TyuqsgJK/aDikyQm12zVqt4gWAV8PtIBTm+bx2KtnS5jjaXFPRSyxGXKkpQ2YbtYg/zwJ7oFr4p6lDlzlKbeGDS/eGTv4StNJagomg0D19NZi1Z2jF66H7XAyNH4AlsewTEUp0fnsZfI/TcDmS6BcdQD9Q2l8MYnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617319; c=relaxed/simple;
	bh=gHyJZkC7MwNkiAQsy3Qs9LPD2Z+4dsXwRyjD4ANEKUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRiPyPkaZlnMrSjwkQtir2WZ0sPimEwaQoBS8WK8VlcXkQneyb6yHCO170aM7f8Dz3k9aA9Sp0w1yBiBnQODh6Lt10k/Nv+5LvOkq5kxhNXEs4/qIQr2tYNo7CNFCE31yUwum2bE1sjOnsJwG7qEaKCd3AaTe+y1Of8gGki0VMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtN9nKmY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a044dce2so35012195e9.2;
        Sat, 07 Dec 2024 16:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617316; x=1734222116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tn1cpZ2Y5hoUhR23cd+RDNcfycsdmg0+/7hxNHZhHck=;
        b=jtN9nKmYAwQX5/yQvhyzKd4y/PyHEA9lLR+8Ws+UyBFF6aC7gvzXKiQ6oMZwDIBbBF
         YPbi1aOwahOW3UPdSYWkBJf6LyY8T2o01FSEjNX7tAAZ1DRQ9elw467v5pRSrcd2BsFk
         T7IxJtAEIfxxFK4RLJXAjPAReVZGhlE2pT4sK1RNgCLB9uw1kveC04hBSkKU+VTzRYK6
         tNmGe0xSObQOXGP6gqlEgIFGzJfDB7ViQjUs31BRNbC5HDKGeHJ9TMlHT3jnpClK4iV/
         wCsEJwxvHgAM6F8/i2xR+YJbCIqND14cgKmi0dX4yU6UwnZ6JleE3fyWbfbr8DH17Cqh
         nE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617316; x=1734222116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn1cpZ2Y5hoUhR23cd+RDNcfycsdmg0+/7hxNHZhHck=;
        b=ceLrb9RagvlExFITUdI+SXrvmnfSofF/Q53YM0mofAksX/v52c4v3HqOF0pToiKmV6
         dRAbmju6oFsxZCUQlmN1OcT1DdY+NXifVdVhKrDBCMqFcIN2YMnX6IxWsolT6fbzum7p
         p/yqkt346keybW/Ew15psJkzwU8KvCdBi72O4RPlt/ri0Lfi4hC9HnoqPyyUDi6fzEbz
         CRjarxDQXTHre/wM+scWHPtW1b4yX0P9tG99HUNoYziGdxN9P3h1nNoakKm1XpGPIXZZ
         SencnePh6fnVCp0QRzbHtIxQuKgLEpTgrAmiTvdEcIl1t5VqOqFmypQb7aB6xt+ptySu
         2Lkg==
X-Forwarded-Encrypted: i=1; AJvYcCUriXG4jOs/VI5HnwNWZU1S05OpcXNTQloJ4qOi7FSKrchk/J6QpYwsCAa2YyVe2xC8DlYYnpp65MFa@vger.kernel.org, AJvYcCWx4QkUeikz6resNnmSro/DklGpraWy5BzQi0EF6/rlGGuFUoxDgfxeV0nG6Bz5GOpuDejEyzNn@vger.kernel.org, AJvYcCXuQXp59gLZ5Wuov+H0Azdye2XxW74WSfCoTuofICaPsl7tfJVo5yTzNH6WeMniJTo7YLpAfDhuwy2R+agw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx097hP8mNiu1jHsiBKlH5Phpc1NHWONKed3A7APXdV1zlvO2am
	r0nM+nQWzvFwjdB3zz8BAyhiVsU8Xkg9R0iB2YKBsZn0cA47xAGw
X-Gm-Gg: ASbGncsk18eoyvj+FAHbcOmPsqRyTwEv8Xmd/7R3w8r9eRe1dMAvQ2BlTUrx+OKFB3J
	3It4SfVSIpJFGDPwHaLarDctbFM9rrzbCktnNjOygYbPxPE4EvbI2QnBIYp0k8aQbNndHMQwk2M
	YNt0XYec1QPlNOJyLmhv5LKh6EfASu+SBoLOahk4blTFgnU/p98RuED3JQXpabb2CxmueQKE5eP
	XiEIrtyY+cBui0ZRABkBNIh7h3iFuC/Tf3XEt3B0o+GkgDBCnrVXFu4OxMqXw1namPwWQOvpgLL
	DX4mn6wlx0XVlY0yt90=
X-Google-Smtp-Source: AGHT+IFzJpA8K9EvKqV1C9cCyyeyWFGq2HK5XNv8kAYHobekq7oqEJFOkPV3vXdYjdQHhRGE6/OqLw==
X-Received: by 2002:a05:600c:6a12:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-434f13124b5mr11896925e9.8.1733617315532;
        Sat, 07 Dec 2024 16:21:55 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:54 -0800 (PST)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v10 6/9] net: mdio: Add Airoha AN8855 Switch MDIO Passtrough
Date: Sun,  8 Dec 2024 01:20:41 +0100
Message-ID: <20241208002105.18074-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208002105.18074-1-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 Switch driver to register a MDIO passtrough as switch
address is shared with the internal PHYs and require additional page
handling.

This requires the upper Switch MFD to be probed and init to actually
work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                    |   1 +
 drivers/net/mdio/Kconfig       |   9 +++
 drivers/net/mdio/Makefile      |   1 +
 drivers/net/mdio/mdio-an8855.c | 113 +++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-an8855.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f4d7c48b6e1..38c7b2362c92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -722,6 +722,7 @@ F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/mdio/mdio-an8855.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 4a7a303be2f7..64fc5c3ef38b 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -61,6 +61,15 @@ config MDIO_XGENE
 	  This module provides a driver for the MDIO busses found in the
 	  APM X-Gene SoC's.
 
+config MDIO_AN8855
+	tristate "Airoha AN8855 Switch MDIO bus controller"
+	depends on MFD_AIROHA_AN8855
+	depends on OF_MDIO
+	help
+	  This module provides a driver for the Airoha AN8855 Switch
+	  that require a MDIO passtrough as switch address is shared
+	  with the internal PHYs and require additional page handling.
+
 config MDIO_ASPEED
 	tristate "ASPEED MDIO bus controller"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 1015f0db4531..546c4e55b475 100644
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
index 000000000000..d8a856352842
--- /dev/null
+++ b/drivers/net/mdio/mdio-an8855.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MDIO passthrough driver for Airoha AN8855 Switch
+ */
+
+#include <linux/mfd/airoha-an8855-mfd.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/platform_device.h>
+
+static int an855_phy_restore_page(struct an8855_mfd_priv *priv,
+				  int phy) __must_hold(&priv->bus->mdio_lock)
+{
+	/* Check PHY page only for addr shared with switch */
+	if (phy != priv->switch_addr)
+		return 0;
+
+	/* Don't restore page if it's not set to switch page */
+	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
+					    AN8855_PHY_PAGE_EXTENDED_4))
+		return 0;
+
+	/* Restore page to 0, PHY might change page right after but that
+	 * will be ignored as it won't be a switch page.
+	 */
+	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
+}
+
+static int an8855_phy_read(struct mii_bus *bus, int phy, int regnum)
+{
+	struct an8855_mfd_priv *priv = bus->priv;
+	struct mii_bus *real_bus = priv->bus;
+	int ret;
+
+	mutex_lock_nested(&real_bus->mdio_lock, MDIO_MUTEX_NESTED);
+
+	ret = an855_phy_restore_page(priv, phy);
+	if (ret)
+		goto exit;
+
+	ret = __mdiobus_read(real_bus, phy, regnum);
+exit:
+	mutex_unlock(&real_bus->mdio_lock);
+
+	return ret;
+}
+
+static int an8855_phy_write(struct mii_bus *bus, int phy, int regnum, u16 val)
+{
+	struct an8855_mfd_priv *priv = bus->priv;
+	struct mii_bus *real_bus = priv->bus;
+	int ret;
+
+	mutex_lock_nested(&real_bus->mdio_lock, MDIO_MUTEX_NESTED);
+
+	ret = an855_phy_restore_page(priv, phy);
+	if (ret)
+		goto exit;
+
+	ret = __mdiobus_write(real_bus, phy, regnum, val);
+exit:
+	mutex_unlock(&real_bus->mdio_lock);
+
+	return ret;
+}
+
+static int an8855_mdio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct an8855_mfd_priv *priv;
+	struct mii_bus *bus;
+	int ret;
+
+	/* Get priv of MFD */
+	priv = dev_get_drvdata(dev->parent);
+
+	bus = devm_mdiobus_alloc(dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->priv = priv;
+	bus->name = KBUILD_MODNAME "-mii";
+	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d",
+		 priv->switch_addr);
+	bus->parent = dev;
+	bus->read = an8855_phy_read;
+	bus->write = an8855_phy_write;
+
+	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
+	if (ret)
+		dev_err(dev, "failed to register MDIO bus: %d", ret);
+
+	return ret;
+}
+
+static const struct of_device_id an8855_mdio_ids[] = {
+	{ .compatible = "airoha,an8855-mdio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_mdio_ids);
+
+static struct platform_driver an8855_mdio_driver = {
+	.probe	= an8855_mdio_probe,
+	.driver = {
+		.name = "an8855-mdio",
+		.of_match_table = an8855_mdio_ids,
+	},
+};
+module_platform_driver(an8855_mdio_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for AN8855 Mdio passthrough");
+MODULE_LICENSE("GPL");
-- 
2.45.2


