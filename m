Return-Path: <netdev+bounces-303476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MM2DNhurRGrqygoAu9opvQ
	(envelope-from <netdev+bounces-303476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 735AA6E9F9E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:52:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=Fn5OcRaQ;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=OC8GMah0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303476-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054DE3025732
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF73955C4;
	Wed,  1 Jul 2026 05:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9930392825;
	Wed,  1 Jul 2026 05:52:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885126; cv=none; b=e5u8xfJwdxvahKuYLJaZfzfDMkfi/hkZ0birrIIcLtDM8kbMjDDLAgN7dA7RI+9rT6Dk+N0VvFdzgEV5PY7he6Kk5EmyfkZrf5KmG4CkAXB91uZPlG6KFOkPtvpXfmLTUD396V1zBzldq5PHADlBTNI1RIKMAPWPt6YTNYudObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885126; c=relaxed/simple;
	bh=QJ3DqbnEjLc9syBgVS8xDr1CkYAEVo36iER8tltwc8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCZAxMnkL6wnpjgzvmUpplfDRzujpZFWScVkK7ZBLJlePcPnDI5tmd9yD69YLnJzr3CA44GG+TQF68gaz8tBRgTmVT0kl2825GtW6VIfsfxQojZeAAUUs5gubBGrg7ZMzJXk+Ss5+04fwQXDD2TuF31VV555Q4kjl7+z6dRuWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Fn5OcRaQ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=OC8GMah0; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884575;
	bh=QJ3DqbnEjLc9syBgVS8xDr1CkYAEVo36iER8tltwc8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fn5OcRaQ+X+2vxj4VADeOmjer3/lTjt3I5Yb81+FXGuySazMfWpa0smpsnUwwiiea
	 rL1Y6VBkouCOF/hggHtjsZJyZMY9G9skoO3Gf/+j584aT56oC3jtaO7SBqoQXhQ5F8
	 Dhs4QYGdHkXe0zRP5US25u4JySRr0MSohsa30Bj8ZFbZ/ep8lzZqPvkxr2iWWxFgKi
	 HCFy82+cRuACvByBS1yHvWfE7TmkrRIXRamaTFj9LzgF1V8h1VFZ96Xe8NOWYXtVU2
	 x7d37wqlr3dC2A7mKvqb9gr/jm88C+p9B9v0rg+1lk6IxNNqu74ze7lGe87CjImF04
	 ydGSxSTcNHr/Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 6723449365; Wed,  1 Jul 2026 05:42:55 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884571;
	bh=QJ3DqbnEjLc9syBgVS8xDr1CkYAEVo36iER8tltwc8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OC8GMah0uOH5EiPH5iKajF6poO7vB5Qap7I5czid2im3wtRFmWe+6TuWMnefZRs4P
	 Mfdy1KLrhE4Tc7e4UUQ/JcVDEA1Z7R3aVwg0rSfnythgYXMM8OfTlMJm7mi3RCFYEO
	 mOh4btLsCnoVN+pRONUeHEIIXYbfuMhVZywfXOj1juHJJs9ozsNpghPSff9cZVPipc
	 JHpJB8vZ7RvfKxW2lJfVPi99KzF5+hzkQCPw6mP45DbCXu56a2OPUJZJxCECdo6ULH
	 PYo9U760FpG5mNQ302JIKIpAabYmpunkqp86pIJzFj0XjTzT7QTRUtoUknPtr0xlMl
	 /ytE2cqkHUSTA==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 182A849341;
	Wed,  1 Jul 2026 05:42:51 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:49 +0200
Subject: [PATCH 3/9] ax88179_178a: Add support for AX88179A MMD access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-3-13685df67515@birger-koblitz.de>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
In-Reply-To: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 735AA6E9F9E

The AX88179A uses a much simpler Clause-45 MMD access interface,
make use of this interface and abstract MMD read/write operations
for the AX88179 and AX88179A architecture by introducing
ax_read_mmd() and ax_write_mmd(), which in turn call the chips'
respective implementation.

Make use of the MMD read/write functions in the link-speed and EEE
configuration settings via ethtool in order to support the
AX179A-based chips. The AX88279 supports EEE only at 1000MBit speed,
the other chips require full duplex.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 238 +++++++++++++++++++++++++++--------------
 1 file changed, 155 insertions(+), 83 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index c6945e131e63fd053a23bf14ab5d5948456ce4a5..fadf449fa5df70d4aed706b7488ac61d4cdf4cc9 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -35,8 +35,10 @@
 #define AX_RELOAD_EEPROM_EFUSE			0x06
 #define AX88179A_WAKEUP_SETTING			0x07
 #define AX_FW_MODE				0x08
+#define AX_GPHY_CTL				0x0F
 #define AX88179A_FLASH_READ			0x21
 #define AX88179A_FLASH_WRITE			0x24
+#define AX88179A_PHY_CLAUSE45			0x27
 #define AX88179A_ACCESS_BL			0x2A
 #define AX88179A_PHY_POWER			0x31
 #define AX88179A_AUTODETACH			0xC0
@@ -113,6 +115,9 @@
 	#define AX_PHYPWR_RSTCTL_AT	0x1000
 
 #define AX_RX_BULKIN_QCTRL			0x2e
+
+#define AX_GPHY_EEE_CTRL			0x01
+
 #define AX_CLK_SELECT				0x33
 	#define AX_CLK_SELECT_BCS	0x01
 	#define AX_CLK_SELECT_ACS	0x02
@@ -559,6 +564,32 @@ ax88179_phy_write_mmd_indirect(struct usbnet *dev, u16 prtad, u16 devad,
 	return 0;
 }
 
+static int ax_read_mmd(struct usbnet *dev, u16 dev_addr, u16 reg)
+{
+	struct ax88179_data *priv = dev->driver_priv;
+	u16 res;
+	int ret;
+
+	if (priv->chip_version >= AX_VERSION_AX88179A) {
+		ret = ax88179_read_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &res);
+		if (ret < 0)
+			return ret;
+		return res;
+	}
+
+	return ax88179_phy_read_mmd_indirect(dev, reg, dev_addr);
+}
+
+static int ax_write_mmd(struct usbnet *dev, u16 dev_addr, u16 reg, u16 data)
+{
+	struct ax88179_data *priv = dev->driver_priv;
+
+	if (priv->chip_version >= AX_VERSION_AX88179A)
+		return ax88179_write_cmd(dev, AX88179A_PHY_CLAUSE45, dev_addr, reg, 2, &data);
+
+	return ax88179_phy_write_mmd_indirect(dev, reg, dev_addr, data);
+}
+
 static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
@@ -853,12 +884,39 @@ ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 }
 
 static int ax88179_get_link_ksettings(struct net_device *net,
-				      struct ethtool_link_ksettings *cmd)
+				       struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	int v;
+
+	data = dev->driver_priv;
 
 	mii_ethtool_get_link_ksettings(&dev->mii, cmd);
 
+	if (data->chip_version >= AX_VERSION_AX88279) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 cmd->link_modes.supported);
+
+		v = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_ADVERTISE);
+		if (v >= 0 && v & ADVERTISE_RESV)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					 cmd->link_modes.advertising);
+
+		v = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+		if (data->speed == ETHER_LINK_2500) {
+			cmd->base.speed = SPEED_2500;
+			/* MDIO_AN_10GBT_STAT_LP2_5G is broken, but we can deduce that
+			 * the link-partner advertised 2500M if remotely AN succceded
+			 * for link speed > 1000M and we locally have a link speed of
+			 * 2500M
+			 */
+			if (v >= 0 && v & MDIO_AN_10GBT_STAT_REMOK)
+				linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+						 cmd->link_modes.lp_advertising);
+		}
+	}
+
 	return 0;
 }
 
@@ -866,34 +924,63 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 				      const struct ethtool_link_ksettings *cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	int v;
+
+	data = dev->driver_priv;
+
+	/* mii_ethtool_set_link_ksettings handles unknown bits in MII_ADVERTISE
+	 * transparently, so for the 2.5GBit link speed of the AX_VERSION_AX88279
+	 * we just set up ADVERTISE_RESV before calling mii_ethtool_set_link_ksettings
+	 * at least for speeds < 2500
+	 */
+	if (data->chip_version == AX_VERSION_AX88279) {
+		v = ax88179_mdio_read(net, dev->mii.phy_id, MII_ADVERTISE);
+		if (v < 0)
+			return v;
+
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				      cmd->link_modes.advertising))
+			v |= ADVERTISE_RESV;
+		else
+			v &= ~ADVERTISE_RESV;
+		ax88179_mdio_write(net, dev->mii.phy_id, MII_ADVERTISE, v);
+		if (cmd->base.speed == SPEED_2500)
+			return mii_nway_restart(&dev->mii);
+	}
+
 	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
 }
 
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
+	struct ax88179_data *priv = dev->driver_priv;
 	int val;
 
 	/* Get Supported EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
-					    MDIO_MMD_PCS);
+	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->supported, val);
 
 	/* Get advertisement EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
-					    MDIO_MMD_AN);
+	val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
 
 	/* Get LP advertisement EEE */
-	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
-					    MDIO_MMD_AN);
+	val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
 	if (val < 0)
 		return val;
 	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
+	if (priv->chip_version >= AX_VERSION_AX88279) {
+		val = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE2);
+		if (val < 0)
+			return val;
+		mii_eee_cap2_mod_linkmode_adv_t(data->lp_advertised, val);
+	}
 
 	return 0;
 }
@@ -903,8 +990,7 @@ ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
 	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
 
-	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
-					      MDIO_MMD_AN, tmp16);
+	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, tmp16);
 }
 
 static int ax88179_chk_eee(struct usbnet *dev)
@@ -914,40 +1000,27 @@ static int ax88179_chk_eee(struct usbnet *dev)
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
-	if (ecmd.duplex & DUPLEX_FULL) {
+	priv->eee_active = 0;
+	if ((priv->chip_version < AX_VERSION_AX88279 && (ecmd.duplex & DUPLEX_FULL)) ||
+	    (ecmd.speed == SPEED_1000 && (ecmd.duplex & DUPLEX_FULL))) {
 		int eee_lp, eee_cap, eee_adv;
 		u32 lp, cap, adv, supported = 0;
 
-		eee_cap = ax88179_phy_read_mmd_indirect(dev,
-							MDIO_PCS_EEE_ABLE,
-							MDIO_MMD_PCS);
-		if (eee_cap < 0) {
-			priv->eee_active = 0;
+		eee_cap = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
+		if (eee_cap < 0)
 			return false;
-		}
 
 		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
-		if (!cap) {
-			priv->eee_active = 0;
+		if (!cap)
 			return false;
-		}
 
-		eee_lp = ax88179_phy_read_mmd_indirect(dev,
-						       MDIO_AN_EEE_LPABLE,
-						       MDIO_MMD_AN);
-		if (eee_lp < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		eee_lp = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_LPABLE);
+		if (eee_lp < 0)
+			return true;
 
-		eee_adv = ax88179_phy_read_mmd_indirect(dev,
-							MDIO_AN_EEE_ADV,
-							MDIO_MMD_AN);
-
-		if (eee_adv < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		eee_adv = ax_read_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV);
+		if (eee_adv < 0)
+			return true;
 
 		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
 		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
@@ -955,65 +1028,53 @@ static int ax88179_chk_eee(struct usbnet *dev)
 			     SUPPORTED_1000baseT_Full :
 			     SUPPORTED_100baseT_Full;
 
-		if (!(lp & adv & supported)) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (!(lp & adv & supported))
+			return true;
 
 		priv->eee_active = 1;
 		return true;
 	}
 
-	priv->eee_active = 0;
 	return false;
 }
 
-static void ax88179_disable_eee(struct usbnet *dev)
-{
-	u16 tmp16;
-
-	tmp16 = GMII_PHY_PGSEL_PAGE3;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x3246;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_PHYADDR, 2, &tmp16);
-
-	tmp16 = GMII_PHY_PGSEL_PAGE0;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-}
-
-static void ax88179_enable_eee(struct usbnet *dev)
+static void ax88179_eee_config(struct usbnet *dev, bool enable)
 {
+	struct ax88179_data *priv = dev->driver_priv;
 	u16 tmp16;
 
-	tmp16 = GMII_PHY_PGSEL_PAGE3;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x3247;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_PHYADDR, 2, &tmp16);
-
-	tmp16 = GMII_PHY_PGSEL_PAGE5;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
-
-	tmp16 = 0x0680;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  MII_BMSR, 2, &tmp16);
+	if (priv->chip_version < AX_VERSION_AX88179A) {
+		tmp16 = GMII_PHY_PGSEL_PAGE3;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+
+		tmp16 = enable ? 0x3247 : 0x3246;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  MII_PHYADDR, 2, &tmp16);
+		if (enable) {
+			tmp16 = GMII_PHY_PGSEL_PAGE5;
+			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+					  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+
+			tmp16 = 0x0680;
+			ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+					  MII_BMSR, 2, &tmp16);
+		}
 
-	tmp16 = GMII_PHY_PGSEL_PAGE0;
-	ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
-			  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+		tmp16 = GMII_PHY_PGSEL_PAGE0;
+		ax88179_write_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID,
+				  GMII_PHY_PAGE_SELECT, 2, &tmp16);
+	} else {
+		ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, enable, 0, NULL);
+	}
 }
 
 static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv;
+
+	priv = dev->driver_priv;
 
 	edata->eee_enabled = priv->eee_enabled;
 	edata->eee_active = priv->eee_active;
@@ -1024,18 +1085,20 @@ static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
 static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv;
 	int ret;
 
+	priv = dev->driver_priv;
+
 	priv->eee_enabled = edata->eee_enabled;
 	if (!priv->eee_enabled) {
-		ax88179_disable_eee(dev);
+		ax88179_eee_config(dev, false);
 	} else {
 		priv->eee_enabled = ax88179_chk_eee(dev);
 		if (!priv->eee_enabled)
 			return -EOPNOTSUPP;
 
-		ax88179_enable_eee(dev);
+		ax88179_eee_config(dev, true);
 	}
 
 	ret = ax88179_ethtool_set_eee(dev, edata);
@@ -2459,11 +2522,20 @@ static int ax88179_reset(struct usbnet *dev)
 	ax179_data->eee_enabled = 0;
 	ax179_data->eee_active = 0;
 
-	ax88179_disable_eee(dev);
+	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
+		ax88179_eee_config(dev, false);
 
-	ax88179_ethtool_get_eee(dev, &eee_data);
-	linkmode_zero(eee_data.advertised);
-	ax88179_ethtool_set_eee(dev, &eee_data);
+		ax88179_ethtool_get_eee(dev, &eee_data);
+		linkmode_zero(eee_data.advertised);
+		ax88179_ethtool_set_eee(dev, &eee_data);
+	} else {
+		ax88179_eee_config(dev, true);
+		ax88179_ethtool_get_eee(dev, &eee_data);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, eee_data.advertised);
+		if (ax179_data->chip_version >= AX_VERSION_AX88279)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, eee_data.advertised);
+		ax88179_ethtool_set_eee(dev, &eee_data);
+	}
 
 	/* Restart autoneg */
 	mii_nway_restart(&dev->mii);

-- 
2.47.3


