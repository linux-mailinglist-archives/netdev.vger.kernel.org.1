Return-Path: <netdev+bounces-150211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7599E97A3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536FC282042
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBA1ACEBD;
	Mon,  9 Dec 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpngsF7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2391B4242;
	Mon,  9 Dec 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751951; cv=none; b=RQGHFWN7fBpw4Lmrl62MHoOKIUy/xg/sIsHv3s1C04N34g4brin6CdoYmmsq2CsmXx1GTuUQHZdz1qr1MHjIy1aHtcmJ1+B/vVlCwPEri/w4g8kmqD/IdSqpIoLR8OEa4SIkr9a668uuULgcrJxtKgCzG0VeOKeCC6ZGVYPU+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751951; c=relaxed/simple;
	bh=nVIGsfW7p52b8kpnO2Y8txrjZ93d/lxgqbof9xDJyTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+SISNoEhoJ8PgqzMfccP3WjMfjQ+5SGXcPK17QY5UUI77Npmvla9ZhJQNFPop+m8uz+n3//cWinCdam38x9L3SpT7iCwsBaHPCorob2agxGUr2qU80p8Od0jqnbUWQrhOeZWJ8wL1QlYQyuwiS9IG1LEz6Edk0OiIkLdqGQoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpngsF7H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f9da4e15so5399185e9.1;
        Mon, 09 Dec 2024 05:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751948; x=1734356748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DldiGMf+UNaTXcwD2GR4/Mu9wTXADlrYU7RCMfHqsv4=;
        b=CpngsF7HKNLt8rMtsSswG4K+Zq6YGZ7LD2ct7wPALO9s6wAqzdsPNt2gBxo32IV1Sk
         bJJNpT+9B+Dpizb/JeHzUqh3ekkzuNQXGFbYeAjv2gaRI9eGVllTaP+bgZ5spc/tWS58
         ziL7YsAoxBT/a6uuuNQLmL7DaMJoQQpuS67upl96reTKsjPboe4Klobmqm79mGx2xok0
         Gk0uICYIwwBMmfYfwVAJqtc7LqeYOKn6UXuX2jcOAvL1kE2117gUfmqW4vjRtYN/+Ba0
         RsSixvsmpOu9ds1g3tYXLG+RTxktWVj39jChb4T4MdOjny8YGtuMuk0Zh4aBrqQe5K+N
         B08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751948; x=1734356748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DldiGMf+UNaTXcwD2GR4/Mu9wTXADlrYU7RCMfHqsv4=;
        b=dDro7y1EWXD7oDL9HNt1mzf6S36i13ENWcEx3g5rLP9d85kbEEMC8Apdyx70TlDuJb
         v0zKnSsdM6KFjIFd4RaJNr2gxMG8sbE8gB7Jc3riIWbjM/6Kru2xiKNQpfaJwh0jJSD1
         JgZaTXdTjdkcXhGOscmZ4ahqN49om4RMU2Ox0UYI+xTS70hvYKczVWjXc40pdjRStUE2
         xdF6AVsF92e1GHx/+josa+0N1R916C5iGCWzXD8p9IwAGBs2xMgYGmjMmMPIkD5i0sJk
         NhcBpIndDcniLizhyFSKCXNlmsed0iFan5Uhy5Hzrub0k+GYF/01ufw4xL+dI/uH228N
         Q0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTyRPm9x6uAln1ZwEpyNeG1FZjAiY4zVaXyy7qkJbR5E19JtCMNuQNOIkfcvH/pXlZQHM2A+BX@vger.kernel.org, AJvYcCW1/Fvpzwxn17F1z48AcoDIFcJe1rF5YkjXYtx0utyugwJhBZlerYIwnhyI85roWeZDpDN/2L01mNH7CLPU@vger.kernel.org, AJvYcCW599UZ0IWVM1cJUhg8xPQDaggtzLps0yMp3yMdOJGb0ZO3nbRllDoNgfy83kmZj3BW3dso9/A2u0Z6@vger.kernel.org
X-Gm-Message-State: AOJu0YyhARg1t0I7+jGyagIMpS7sqYLEP2vh7E5rpKw/bvZ/k4Hv5uZI
	olFjXYDSkAYkyIR7GzONTy3y3VcmTLDSRP5BUThDXwYpSUdMZwbu
X-Gm-Gg: ASbGncty0w0PXdUh9REdhWehfY5WsVTgApGuGKWGItBeSPpMrOG2nyp2jE8064cRBTO
	3MmWpHZeb7cUQnZKxTcMUkm3WDkrWJgGWDSWfOJf67kqKtjYS+1yH8enpmB4+oO2tM7OMcEoGqb
	V1b2aljDD+8FGwibfqHBfmnTzU0JFO+gwGZsRdSwOojEzPl8TleBIj8r2gC+ZE0ewT696U6ZEpd
	KB8S3yVAEZICIuKcJFVzGY6A6h3EKvMyBgTeTWnJidzD9/8qzcYGQ1RHqDczECexburC66yQIt8
	0BNzjXCnRgsLSkszz/M=
X-Google-Smtp-Source: AGHT+IHota3qg6SjncGFPW99L4xsi++Tc42l5xWftrvBwDlXV4AR0O6QVOD1U1N5MpkxS/DPc3Baow==
X-Received: by 2002:a05:600c:83c3:b0:434:f230:f4f0 with SMTP id 5b1f17b1804b1-434fff3704fmr4165605e9.1.1733751948054;
        Mon, 09 Dec 2024 05:45:48 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:47 -0800 (PST)
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
Subject: [net-next PATCH v11 6/9] net: mdio: Add Airoha AN8855 Switch MDIO Passtrough
Date: Mon,  9 Dec 2024 14:44:23 +0100
Message-ID: <20241209134459.27110-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
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
index 4a7a303be2f7..3d417948e73a 100644
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
+	  that requires a MDIO passtrough as switch address is shared
+	  with the internal PHYs and requires additional page handling.
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
index 000000000000..5feba72c021b
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
+		return dev_err_probe(dev, ret, "failed to register MDIO bus\n");
+
+	return ret;
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
-- 
2.45.2


