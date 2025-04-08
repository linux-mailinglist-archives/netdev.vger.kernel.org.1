Return-Path: <netdev+bounces-180113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63238A7FA26
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7517AA844
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC44265601;
	Tue,  8 Apr 2025 09:44:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39720CCD8;
	Tue,  8 Apr 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105483; cv=none; b=BYQCKboPikDqGJTX+F4f5iyGNwv0lxUELLw4moQLsdh6kG4utVluXOIhNcogJE1H+IpWZo3tM3RqFidCTnpxlY46VZZ7W4ClVL9oGHrpZTeCbsJVWSw7qVeD3mw3WeDmXD8AyiXLAzouECCQLGUo8NXPJEPpsy64Be3O8XxnBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105483; c=relaxed/simple;
	bh=Nyb8mM2xXUopM5kALImywKmrNjSRFGJvrQRmyaklwUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJ9NKWSyq6LRsougFXIUAOb3UH+SqTuebklpBK3saiwmeDm1Prp/47zLIreEY7eXmfuL/EpZt8mYykTWGMKMwNIoq7t5MYt13eomFP5ntZlts9w3ha1RMuTsAd8SjiY/Mr95JD8cpu1i6zO/6laieh5YL/5xNsbERFq0v1ssbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Jn_1744104531 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:52 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 02/14] yt6801: Implement mdio register
Date: Tue,  8 Apr 2025 17:28:23 +0800
Message-Id: <20250408092835.3952-3-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the mdio bus read, write and register function.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 86 +++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   |  8 ++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 10d63a8ed..39f03b4a4 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -20,6 +20,92 @@
 #include <linux/module.h>
 #include "yt6801_type.h"
 
+#define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
+static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
+{
+	u32 val;
+	int ret;
+
+	fxgmac_io_wr(priv, MAC_MDIO_DATA, data);
+	fxgmac_io_wr(priv, MAC_MDIO_ADDR, PHY_WR_CONFIG(reg_id));
+	ret = read_poll_timeout_atomic(fxgmac_io_rd, val,
+				       !FIELD_GET(MAC_MDIO_ADDR_BUSY, val),
+				       10, 250, false, priv, MAC_MDIO_ADDR);
+	if (ret == -ETIMEDOUT)
+		dev_err(priv->dev, "%s, id:%x ctrl:0x%08x, data:0x%08x\n",
+			__func__, reg_id, PHY_WR_CONFIG(reg_id), data);
+
+	return ret;
+}
+
+#define PHY_RD_CONFIG(reg_offset)	(0x800020d + ((reg_offset) * 0x10000))
+static int fxgmac_phy_read_reg(struct fxgmac_pdata *priv, u32 reg_id)
+{
+	u32 val;
+	int ret;
+
+	fxgmac_io_wr(priv, MAC_MDIO_ADDR, PHY_RD_CONFIG(reg_id));
+	ret = read_poll_timeout_atomic(fxgmac_io_rd, val,
+				       !FIELD_GET(MAC_MDIO_ADDR_BUSY, val),
+				       10, 250, false, priv, MAC_MDIO_ADDR);
+	if (ret == -ETIMEDOUT) {
+		dev_err(priv->dev, "%s, id:%x, ctrl:0x%08x, val:0x%08x.\n",
+			__func__, reg_id, PHY_RD_CONFIG(reg_id), val);
+		return ret;
+	}
+
+	return fxgmac_io_rd(priv, MAC_MDIO_DATA); /* Read data */
+}
+
+static int fxgmac_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
+				 int phyreg, u16 val)
+{
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return fxgmac_phy_write_reg(mii_bus->priv, phyreg, val);
+}
+
+static int fxgmac_mdio_read_reg(struct mii_bus *mii_bus, int phyaddr,
+				int phyreg)
+{
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return fxgmac_phy_read_reg(mii_bus->priv, phyreg);
+}
+
+static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
+{
+	struct pci_dev *pdev = to_pci_dev(priv->dev);
+	struct phy_device *phydev;
+	struct mii_bus *new_bus;
+	int ret;
+
+	new_bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!new_bus)
+		return -ENOMEM;
+
+	new_bus->name = "yt6801";
+	new_bus->priv = priv;
+	new_bus->parent = &pdev->dev;
+	new_bus->read = fxgmac_mdio_read_reg;
+	new_bus->write = fxgmac_mdio_write_reg;
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "yt6801-%x-%x",
+		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
+
+	ret = devm_mdiobus_register(&pdev->dev, new_bus);
+	if (ret < 0)
+		return ret;
+
+	phydev = mdiobus_get_phy(new_bus, 0);
+	if (!phydev)
+		return -ENODEV;
+
+	priv->phydev = phydev;
+	return 0;
+}
+
 static void fxgmac_phy_release(struct fxgmac_pdata *priv)
 {
 	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 1);
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
index bb6c2640a..b43952981 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -34,6 +34,14 @@
 #define EPHY_CTRL_STA_DUPLEX			BIT(2)
 #define EPHY_CTRL_STA_SPEED			GENMASK(4, 3)
 
+#define MAC_MDIO_ADDR			0x2200
+#define MAC_MDIO_ADDR_BUSY		BIT(0)
+#define MAC_MDIO_ADDR_GOC		GENMASK(3, 2)
+
+#define MAC_MDIO_DATA			0x2204
+#define MAC_MDIO_DATA_GD		GENMASK(15, 0)
+#define MAC_MDIO_DATA_RA		GENMASK(31, 16)
+
 struct fxgmac_resources {
 	void __iomem *addr;
 	int irq;
-- 
2.34.1


