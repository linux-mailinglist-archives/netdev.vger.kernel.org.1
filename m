Return-Path: <netdev+bounces-12859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A17392BF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A837B1C20F77
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E81D2A1;
	Wed, 21 Jun 2023 23:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B8EDC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:00:17 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC019AC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687388415; x=1718924415;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5WS84+/l5o+rT7lWZcqQv03YZY5YLL53MsulDC2iWLg=;
  b=nduGcDqri3Kpc0GZ72oCxUF+V4tZxgGXMyfSQAPERc4tCk8WXnozU8vm
   LnadwhArxdFfchaoqDv7TmxGxH0pxYg6g6CzhTVJs0b5fvL5p3zOksOMT
   0UPAK9HUhrJhfnCQZybCKqhSKdL16DVmc/d2XorPGznjM1ERe1a/9Vmka
   279XVo/pEsufRyEwR5PDxbewentdU+pKO2z265CQ9OuQ3Ef5HzY+cTjii
   SKZ7lMoSwgnwFmDnMsZh1KKrY06cqwpnieuVCxEcT4Bc2CQBAKFcVHtZO
   xmilR5Uic66mcVKj/wUHE7i/1eFZH5O8L9/nZa5QjlUfAAD/qaCtwwH+g
   A==;
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="219816272"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 16:00:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 16:00:11 -0700
Received: from hat-linux.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 21 Jun 2023 16:00:10 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>, Tristram Ha
	<Tristram.Ha@microchip.com>
Subject: [PATCH v3 net-next] net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs
Date: Wed, 21 Jun 2023 16:00:43 -0700
Message-ID: <1687388443-3069-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tristram Ha <Tristram.Ha@microchip.com>

Microchip LAN8740/LAN8742 PHYs support basic unicast, broadcast, and
Magic Packet WoL.  They have one pattern filter matching up to 128 bytes
of frame data, which can be used to implement ARP or multicast WoL.

ARP WoL matches any ARP frame with broadcast address.

Multicast WoL matches any multicast frame.

Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
---
v3
- Do not try to get IPv4 and IPv6 address from the driver
- As a result only generic ARP and multicast support are provided

v2
- use in_dev_put() only when IP support is enabled

v1
- use in_dev_get() to retrieve IP address to avoid compiler warning
- use ipv6_get_lladdr() to retrieve IPv6 address
- use that function only when IPv6 support is enabled
- export that function in addrconf.c
- program the MAC address in a loop
- always set datalen in lan874x_chk_wol_pattern()
- add spaces around "<<"
- select CRC16 in Kconfig as crc16() is used in driver

 drivers/net/phy/Kconfig |   1 +
 drivers/net/phy/smsc.c  | 262 +++++++++++++++++++++++++++++++++++++++-
 include/linux/smscphy.h |  34 ++++++
 3 files changed, 295 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 78e6981650d9..c59fb072343b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -344,6 +344,7 @@ config ROCKCHIP_PHY
 
 config SMSC_PHY
 	tristate "SMSC PHYs"
+	select CRC16
 	help
 	  Currently supports the LAN83C185, LAN8187 and LAN8700 PHYs
 
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 692930750215..70460aaee8b1 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -20,6 +20,12 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/netdevice.h>
+#include <linux/crc16.h>
+#include <linux/etherdevice.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <net/if_inet6.h>
+#include <net/ipv6.h>
 #include <linux/smscphy.h>
 
 /* Vendor-specific PHY Definitions */
@@ -51,6 +57,7 @@ struct smsc_phy_priv {
 	unsigned int edpd_enable:1;
 	unsigned int edpd_mode_set_by_user:1;
 	unsigned int edpd_max_wait_ms;
+	bool wol_arp;
 };
 
 static int smsc_phy_ack_interrupt(struct phy_device *phydev)
@@ -258,6 +265,249 @@ int lan87xx_read_status(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(lan87xx_read_status);
 
+static int lan874x_phy_config_init(struct phy_device *phydev)
+{
+	u16 val;
+	int rc;
+
+	/* Setup LED2/nINT/nPME pin to function as nPME.  May need user option
+	 * to use LED1/nINT/nPME.
+	 */
+	val = MII_LAN874X_PHY_PME2_SET;
+
+	/* The bits MII_LAN874X_PHY_WOL_PFDA_FR, MII_LAN874X_PHY_WOL_WUFR,
+	 * MII_LAN874X_PHY_WOL_MPR, and MII_LAN874X_PHY_WOL_BCAST_FR need to
+	 * be cleared to de-assert PME signal after a WoL event happens, but
+	 * using PME auto clear gets around that.
+	 */
+	val |= MII_LAN874X_PHY_PME_SELF_CLEAR;
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   val);
+	if (rc < 0)
+		return rc;
+
+	/* set nPME self clear delay time */
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_MCFGR,
+			   MII_LAN874X_PHY_PME_SELF_CLEAR_DELAY);
+	if (rc < 0)
+		return rc;
+
+	return smsc_phy_config_init(phydev);
+}
+
+static void lan874x_get_wol(struct phy_device *phydev,
+			    struct ethtool_wolinfo *wol)
+{
+	struct smsc_phy_priv *priv = phydev->priv;
+	int rc;
+
+	wol->supported = (WAKE_UCAST | WAKE_BCAST | WAKE_MAGIC |
+			  WAKE_ARP | WAKE_MCAST);
+	wol->wolopts = 0;
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0)
+		return;
+
+	if (rc & MII_LAN874X_PHY_WOL_PFDAEN)
+		wol->wolopts |= WAKE_UCAST;
+
+	if (rc & MII_LAN874X_PHY_WOL_BCSTEN)
+		wol->wolopts |= WAKE_BCAST;
+
+	if (rc & MII_LAN874X_PHY_WOL_MPEN)
+		wol->wolopts |= WAKE_MAGIC;
+
+	if (rc & MII_LAN874X_PHY_WOL_WUEN) {
+		if (priv->wol_arp)
+			wol->wolopts |= WAKE_ARP;
+		else
+			wol->wolopts |= WAKE_MCAST;
+	}
+}
+
+static u16 smsc_crc16(const u8 *buffer, size_t len)
+{
+	return bitrev16(crc16(0xFFFF, buffer, len));
+}
+
+static int lan874x_chk_wol_pattern(const u8 pattern[], const u16 *mask,
+				   u8 len, u8 *data, u8 *datalen)
+{
+	size_t i, j, k;
+	int ret = 0;
+	u16 bits;
+
+	i = 0;
+	k = 0;
+	while (len > 0) {
+		bits = *mask;
+		for (j = 0; j < 16; j++, i++, len--) {
+			/* No more pattern. */
+			if (!len) {
+				/* The rest of bitmap is not empty. */
+				if (bits)
+					ret = i + 1;
+				break;
+			}
+			if (bits & 1)
+				data[k++] = pattern[i];
+			bits >>= 1;
+		}
+		mask++;
+	}
+	*datalen = k;
+	return ret;
+}
+
+static int lan874x_set_wol_pattern(struct phy_device *phydev, u16 val,
+				   const u8 data[], u8 datalen,
+				   const u16 *mask, u8 masklen)
+{
+	u16 crc, reg;
+	int rc;
+
+	val |= MII_LAN874X_PHY_WOL_FILTER_EN;
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			   MII_LAN874X_PHY_MMD_WOL_WUF_CFGA, val);
+	if (rc < 0)
+		return rc;
+
+	crc = smsc_crc16(data, datalen);
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			   MII_LAN874X_PHY_MMD_WOL_WUF_CFGB, crc);
+	if (rc < 0)
+		return rc;
+
+	masklen = (masklen + 15) & ~0xf;
+	reg = MII_LAN874X_PHY_MMD_WOL_WUF_MASK7;
+	while (masklen >= 16) {
+		rc = phy_write_mmd(phydev, MDIO_MMD_PCS, reg, *mask);
+		if (rc < 0)
+			return rc;
+		reg--;
+		mask++;
+		masklen -= 16;
+	}
+
+	/* Clear out the rest of mask registers. */
+	while (reg != MII_LAN874X_PHY_MMD_WOL_WUF_MASK0) {
+		phy_write_mmd(phydev, MDIO_MMD_PCS, reg, 0);
+		reg--;
+	}
+	return rc;
+}
+
+static int lan874x_set_wol(struct phy_device *phydev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct net_device *ndev = phydev->attached_dev;
+	struct smsc_phy_priv *priv = phydev->priv;
+	u16 val, val_wucsr;
+	u8 data[128];
+	u8 datalen;
+	int rc;
+
+	if (wol->wolopts & WAKE_PHY)
+		return -EOPNOTSUPP;
+
+	/* lan874x has only one WoL filter pattern */
+	if ((wol->wolopts & (WAKE_ARP | WAKE_MCAST)) ==
+	    (WAKE_ARP | WAKE_MCAST)) {
+		phydev_info(phydev,
+			    "lan874x WoL supports one of ARP|MCAST at a time\n");
+		return -EOPNOTSUPP;
+	}
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0)
+		return rc;
+
+	val_wucsr = rc;
+
+	if (wol->wolopts & WAKE_UCAST)
+		val_wucsr |= MII_LAN874X_PHY_WOL_PFDAEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_PFDAEN;
+
+	if (wol->wolopts & WAKE_BCAST)
+		val_wucsr |= MII_LAN874X_PHY_WOL_BCSTEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_BCSTEN;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		val_wucsr |= MII_LAN874X_PHY_WOL_MPEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_MPEN;
+
+	/* Need to use pattern matching */
+	if (wol->wolopts & (WAKE_ARP | WAKE_MCAST))
+		val_wucsr |= MII_LAN874X_PHY_WOL_WUEN;
+	else
+		val_wucsr &= ~MII_LAN874X_PHY_WOL_WUEN;
+
+	if (wol->wolopts & WAKE_ARP) {
+		u8 pattern[14] = {
+			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x08, 0x06 };
+		u16 mask[1] = { 0x303F };
+		u8 len = 14;
+
+		rc = lan874x_chk_wol_pattern(pattern, mask, len, data,
+					     &datalen);
+		if (rc)
+			phydev_dbg(phydev, "pattern not valid at %d\n", rc);
+
+		/* Need to match broadcast destination address. */
+		val = MII_LAN874X_PHY_WOL_FILTER_BCSTEN;
+		rc = lan874x_set_wol_pattern(phydev, val, data, datalen, mask,
+					     len);
+		if (rc < 0)
+			return rc;
+		priv->wol_arp = true;
+	}
+
+	if (wol->wolopts & WAKE_MCAST) {
+		u8 pattern[6] = { 0x33, 0x33, 0xFF, 0x00, 0x00, 0x00 };
+		u16 mask[1] = { 0x0007 };
+		u8 len = 0;
+
+		rc = lan874x_chk_wol_pattern(pattern, mask, len, data,
+					     &datalen);
+		if (rc)
+			phydev_dbg(phydev, "pattern not valid at %d\n", rc);
+
+		/* Need to match multicast destination address. */
+		val = MII_LAN874X_PHY_WOL_FILTER_MCASTTEN;
+		rc = lan874x_set_wol_pattern(phydev, val, data, datalen, mask,
+					     len);
+		if (rc < 0)
+			return rc;
+		priv->wol_arp = false;
+	}
+
+	if (wol->wolopts & (WAKE_MAGIC | WAKE_UCAST)) {
+		const u8 *mac = (const u8 *)ndev->dev_addr;
+		int i, reg;
+
+		reg = MII_LAN874X_PHY_MMD_WOL_RX_ADDRC;
+		for (i = 0; i < 6; i += 2, reg--) {
+			rc = phy_write_mmd(phydev, MDIO_MMD_PCS, reg,
+					   ((mac[i + 1] << 8) | mac[i]));
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   val_wucsr);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
 static int smsc_get_sset_count(struct phy_device *phydev)
 {
 	return ARRAY_SIZE(smsc_hw_stats);
@@ -533,7 +783,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* basic functions */
 	.read_status	= lan87xx_read_status,
-	.config_init	= smsc_phy_config_init,
+	.config_init	= lan874x_phy_config_init,
 	.soft_reset	= smsc_phy_reset,
 
 	/* IRQ related */
@@ -548,6 +798,10 @@ static struct phy_driver smsc_phy_driver[] = {
 	.get_tunable	= smsc_phy_get_tunable,
 	.set_tunable	= smsc_phy_set_tunable,
 
+	/* WoL */
+	.set_wol	= lan874x_set_wol,
+	.get_wol	= lan874x_get_wol,
+
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 }, {
@@ -566,7 +820,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* basic functions */
 	.read_status	= lan87xx_read_status,
-	.config_init	= smsc_phy_config_init,
+	.config_init	= lan874x_phy_config_init,
 	.soft_reset	= smsc_phy_reset,
 
 	/* IRQ related */
@@ -581,6 +835,10 @@ static struct phy_driver smsc_phy_driver[] = {
 	.get_tunable	= smsc_phy_get_tunable,
 	.set_tunable	= smsc_phy_set_tunable,
 
+	/* WoL */
+	.set_wol	= lan874x_set_wol,
+	.get_wol	= lan874x_get_wol,
+
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 } };
diff --git a/include/linux/smscphy.h b/include/linux/smscphy.h
index e1c88627755a..1a6a851d2cf8 100644
--- a/include/linux/smscphy.h
+++ b/include/linux/smscphy.h
@@ -38,4 +38,38 @@ int smsc_phy_set_tunable(struct phy_device *phydev,
 			 struct ethtool_tunable *tuna, const void *data);
 int smsc_phy_probe(struct phy_device *phydev);
 
+#define MII_LAN874X_PHY_MMD_WOL_WUCSR		0x8010
+#define MII_LAN874X_PHY_MMD_WOL_WUF_CFGA	0x8011
+#define MII_LAN874X_PHY_MMD_WOL_WUF_CFGB	0x8012
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK0	0x8021
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK1	0x8022
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK2	0x8023
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK3	0x8024
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK4	0x8025
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK5	0x8026
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK6	0x8027
+#define MII_LAN874X_PHY_MMD_WOL_WUF_MASK7	0x8028
+#define MII_LAN874X_PHY_MMD_WOL_RX_ADDRA	0x8061
+#define MII_LAN874X_PHY_MMD_WOL_RX_ADDRB	0x8062
+#define MII_LAN874X_PHY_MMD_WOL_RX_ADDRC	0x8063
+#define MII_LAN874X_PHY_MMD_MCFGR		0x8064
+
+#define MII_LAN874X_PHY_PME1_SET		(2 << 13)
+#define MII_LAN874X_PHY_PME2_SET		(2 << 11)
+#define MII_LAN874X_PHY_PME_SELF_CLEAR		BIT(9)
+#define MII_LAN874X_PHY_WOL_PFDA_FR		BIT(7)
+#define MII_LAN874X_PHY_WOL_WUFR		BIT(6)
+#define MII_LAN874X_PHY_WOL_MPR			BIT(5)
+#define MII_LAN874X_PHY_WOL_BCAST_FR		BIT(4)
+#define MII_LAN874X_PHY_WOL_PFDAEN		BIT(3)
+#define MII_LAN874X_PHY_WOL_WUEN		BIT(2)
+#define MII_LAN874X_PHY_WOL_MPEN		BIT(1)
+#define MII_LAN874X_PHY_WOL_BCSTEN		BIT(0)
+
+#define MII_LAN874X_PHY_WOL_FILTER_EN		BIT(15)
+#define MII_LAN874X_PHY_WOL_FILTER_MCASTTEN	BIT(9)
+#define MII_LAN874X_PHY_WOL_FILTER_BCSTEN	BIT(8)
+
+#define MII_LAN874X_PHY_PME_SELF_CLEAR_DELAY	0x1000 /* 81 milliseconds */
+
 #endif /* __LINUX_SMSCPHY_H__ */
-- 
2.17.1


