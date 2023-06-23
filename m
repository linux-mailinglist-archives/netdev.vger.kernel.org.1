Return-Path: <netdev+bounces-13434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB4673B9D8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EF5281BD1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BCD524;
	Fri, 23 Jun 2023 14:17:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7DD515
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:17:19 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5F10C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EIbrC/QnC1yWICHK9dA9n6QgBQeW2TU6rE65I9505Hk=; b=pG0qw+b+R/+tpuYsDKwC78PtPc
	/NlZVbFdJ3Kqz9yIA/TSW/IZ66/f9X8/lDdnTXePkQ+gnB1wDfQIIUfDfDehmJLCB57CzBrXoQWZA
	XSQdjgZt5KrhAugZRjP6TgZcsG+di2OoHN7StATxg7EWRarEbtfLczhmY55QftlZeEgYTU8eKFax7
	9FQR+FlsO8T//athWCC213OdbP22LNN4JWiyBio2QUmMo4FlzHDqXr5qxZzFHxOI7wIM5Ll0AtP5V
	NvxkhvmtG/Q1tQM6AcpPFc2CTEL7DU3JRYS1WEz9hCAXtcHWR5LNDgBdu7PRtLUkAcaSdjxIblxvC
	vCAATVow==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44790 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qChb4-0005Ol-33; Fri, 23 Jun 2023 15:17:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qChb3-00Fmrl-DC; Fri, 23 Jun 2023 15:17:09 +0100
In-Reply-To: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
References: <ZJWpGCtIZ06jiBsO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 04/14] net: mdio: add unlocked mdiobus and
 mdiodev bus accessors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qChb3-00Fmrl-DC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 23 Jun 2023 15:17:09 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the following unlocked accessors to complete the set:
__mdiobus_modify()
__mdiodev_read()
__mdiodev_write()
__mdiodev_modify()
__mdiodev_modify_changed()
which we will need for Marvell DSA PCS conversion.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/mdio_bus.c | 24 ++++++++++++++++++++++--
 include/linux/mdio.h       | 26 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 8b3618d3da4a..bc04048de2fa 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1210,6 +1210,26 @@ int mdiobus_c45_write_nested(struct mii_bus *bus, int addr, int devad,
 }
 EXPORT_SYMBOL(mdiobus_c45_write_nested);
 
+/*
+ * __mdiobus_modify - Convenience function for modifying a given mdio device
+ *	register
+ * @bus: the mii_bus struct
+ * @addr: the phy address
+ * @regnum: register number to write
+ * @mask: bit mask of bits to clear
+ * @set: bit mask of bits to set
+ */
+int __mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask,
+		     u16 set)
+{
+	int err;
+
+	err = __mdiobus_modify_changed(bus, addr, regnum, mask, set);
+
+	return err < 0 ? err : 0;
+}
+EXPORT_SYMBOL_GPL(__mdiobus_modify);
+
 /**
  * mdiobus_modify - Convenience function for modifying a given mdio device
  *	register
@@ -1224,10 +1244,10 @@ int mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask, u16 set)
 	int err;
 
 	mutex_lock(&bus->mdio_lock);
-	err = __mdiobus_modify_changed(bus, addr, regnum, mask, set);
+	err = __mdiobus_modify(bus, addr, regnum, mask, set);
 	mutex_unlock(&bus->mdio_lock);
 
-	return err < 0 ? err : 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mdiobus_modify);
 
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index c1b7008826e5..8fa23bdcedbf 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -537,6 +537,8 @@ static inline void mii_c73_mod_linkmode(unsigned long *adv, u16 *lpa)
 
 int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum);
 int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val);
+int __mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask,
+		     u16 set);
 int __mdiobus_modify_changed(struct mii_bus *bus, int addr, u32 regnum,
 			     u16 mask, u16 set);
 
@@ -564,6 +566,30 @@ int mdiobus_c45_modify(struct mii_bus *bus, int addr, int devad, u32 regnum,
 int mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
 			       u32 regnum, u16 mask, u16 set);
 
+static inline int __mdiodev_read(struct mdio_device *mdiodev, u32 regnum)
+{
+	return __mdiobus_read(mdiodev->bus, mdiodev->addr, regnum);
+}
+
+static inline int __mdiodev_write(struct mdio_device *mdiodev, u32 regnum,
+				  u16 val)
+{
+	return __mdiobus_write(mdiodev->bus, mdiodev->addr, regnum, val);
+}
+
+static inline int __mdiodev_modify(struct mdio_device *mdiodev, u32 regnum,
+				   u16 mask, u16 set)
+{
+	return __mdiobus_modify(mdiodev->bus, mdiodev->addr, regnum, mask, set);
+}
+
+static inline int __mdiodev_modify_changed(struct mdio_device *mdiodev,
+					   u32 regnum, u16 mask, u16 set)
+{
+	return __mdiobus_modify_changed(mdiodev->bus, mdiodev->addr, regnum,
+					mask, set);
+}
+
 static inline int mdiodev_read(struct mdio_device *mdiodev, u32 regnum)
 {
 	return mdiobus_read(mdiodev->bus, mdiodev->addr, regnum);
-- 
2.30.2


