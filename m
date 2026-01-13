Return-Path: <netdev+bounces-249319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFFD1697D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9AF33017EF1
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3634F261;
	Tue, 13 Jan 2026 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0B9DCA7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AB2FF14C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768277258; cv=none; b=A+ZQf1YZLYQluqIcsS6DXdKfs8zzJ+5PQfLMesb8jZo677WSRiTxR87N8iwFpEEH4gIkv0MRvdG9k6zI1vJc5V3lNqqQL2C2ZsVdeMdPiYMQAa4VsgJMF4X0fOwKJCQ98W8sZhmRKzAeV9f/Liwf09J+8cP+0nzIMNjkbY3rRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768277258; c=relaxed/simple;
	bh=h+iFRHUyhXQa6VGT9xAuOhQz3LEOOF0xJl6dugW1ojw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPmC+AsSHbybH6Rlg8Q7zuJkJXrgDJ0vVaE0TL2Xkx03GP1LaLhREyHOWceXmNHNE/ASl3VW99mT+qBzkzequDS16LCY+8HCACCTZ0sdVe5BkRER10Ybx9oTEnSFPqQUKMb74l24o+3xiFsfCxle/mJJvHsBtPmM3tdEwVy2I10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0B9DCA7; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b05fe2bf14so11013700eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768277255; x=1768882055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf2GiBrDhJ3d3fFqZYGBsdQPl9857Ibwncbf+eD3xlE=;
        b=K0B9DCA7TnNMyH+nM0QSLPJeeOcwCdeQeC8ycb2vlctacVru00Kmd8i5M1cqybhxqP
         1VTCfxV/tPsO1bXz5kv370BSVROeb0W9Fsol1wwJVe8gVDT8et1cc4Ht56mDC8s8KizZ
         MR4LO3t/iTvDpYd2tY3afFk/tOrURKFKywqv5MKYLRbBZtzCLoTe00GPVUhrx2D4Xj2r
         dG7p3aKaEcPrNDMkgGvPILQbZGwBAZ8MaS5WdOuDp2yJcJiIb5aAvRKJK4/Fw3iJEAiD
         je0KYDXwLJEokTrhYh2TgAStsPyCn+3OuxYnB7aTvZN+prw59ah8shaGwiLjx3AMFgoo
         +iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768277255; x=1768882055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf2GiBrDhJ3d3fFqZYGBsdQPl9857Ibwncbf+eD3xlE=;
        b=CX8tCN61hxEZgcpspaIdFTGXrYZyhj4hdoCo1ElQst+6P34BgM0TcjDhVjwx6hJcvY
         b8dnjnxk0Sp01MIFjezOWRSxXHJi0Wlz0KIAg9WnIaplIU4YCYp7ob540nZujtREAvsz
         b+XqFtW8YE6hxR4t73Oity2R/8vfJfaGSFVhOifnK/ht4gK9COqNJdUTJ/bBpU8LSzVm
         +OWc7HIziWc9iHbm+OPlTH7BTl00u8/txckCL0Dc7mpsKYqQ5NK3d0vE1/KHOTS8inqb
         F/cVG3IcY4+htoMHp5VDyIpb3SQkCVH9NVxkwJApKIGrzBvoQDnbpL23YPdAfWsPhn8K
         mPxQ==
X-Gm-Message-State: AOJu0YyXl3D4uaGhAEJ7mIkmpDIcfk5VuRPJUmEVQGB95K0QC5CC0OJl
	6M9RBqnhwQRZv0CXWjT6HS0O2bNRqc/5QaE3/VnfU4czijCg/JXXQS+sjGRPVKJT
X-Gm-Gg: AY/fxX7NPdmfs9LzE0L0lanzVUSCe/TCkZ4rhWSqVI39hFiFtBQmqLHidzUuX29O0PW
	DEFs5dRTdhO9lZiz2NHS/5Q/w3g/ppfD0C1OCIWd2cRKU1O9ww7X1o/X/Bk2OHiEEeRWowBtfEe
	oQMufFxt3EqP91Cqz3cwYaO/Ua7ARGts9q9l2XrBd/nj9FK0UE65zTdpNv0gRe+kQU8IVI4h3jj
	7wQZrQOpOThvELHFIsFHKJplcBMrL4Alde8hIAzbS6a3LI5oPV0frwE1YBwsl/XnTvwPBBDvC/j
	FB/mxpNdF9ar10/0F00m+Lof2kic1Z6uaIDqPIXZt9byjuKQvbQXWkE2U/yCaPiacDda/AnJQCi
	Ij2DhemFAlkeikf4yMl1lbLF7hBlJbo32F5jdkRpeBAxIm5AqCezZ3gF3nBZHsQdZTYl5Pyge81
	0IRsgXP/uNATFx2IsuOYGkiGNSuEtaor7stYnsP9zT8yBZ1Caab2n+BL6HpyerDNNr+XTLEbmBQ
	iyrqq5Pfrr25WNApycXArlnEZ+JcwyaEv1YTJDdT0+0Xx8ELyMqfdRxD3O3tnLu5TqyPbgu+B6O
	QVkOGeUXeakSBv4=
X-Google-Smtp-Source: AGHT+IHwzd/z6ogl58mRDQxE2emLhy9y2lPyOrhz1WRpKTCPXCbO4o8Y1Rsg46//Z7nAte4RfXnlBg==
X-Received: by 2002:a05:693c:3101:b0:2b0:4ae9:efb9 with SMTP id 5a478bee46e88-2b17d30f834mr18932620eec.43.1768277254469;
        Mon, 12 Jan 2026 20:07:34 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-28.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.28])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17067327csm16587659eec.7.2026.01.12.20.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 20:07:34 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: usb: sr9700: remove code to drive nonexistent MII
Date: Mon, 12 Jan 2026 20:06:38 -0800
Message-ID: <20260113040649.54248-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device does not have a MII, even though the driver
contains code to drive one (because it originated as a copy of the
dm9601 driver). It also only supports 10Mbps half-duplex
operation (the DM9601 registers to set the speed/duplex mode
are read-only). Remove all MII-related code and implement
sr9700_get_link_ksettings which returns hardcoded correct
information for the link speed and duplex mode. Also add
announcement of the link status like many other Ethernet
drivers have.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 170 ++++++++++++---------------------------
 drivers/net/usb/sr9700.h |  11 +--
 2 files changed, 56 insertions(+), 125 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 820c4c506979..4c9ad65ea4ca 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -16,7 +16,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/mii.h>
 #include <linux/usb.h>
 #include <linux/crc32.h>
 #include <linux/usb/usbnet.h>
@@ -69,11 +68,11 @@ static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
 			       value, reg, NULL, 0);
 }
 
-static int wait_phy_eeprom_ready(struct usbnet *dev, int phy)
+static int wait_eeprom_ready(struct usbnet *dev)
 {
 	int i;
 
-	for (i = 0; i < SR_SHARE_TIMEOUT; i++) {
+	for (i = 0; i < SR_EEPROM_TIMEOUT; i++) {
 		u8 tmp = 0;
 		int ret;
 
@@ -87,38 +86,37 @@ static int wait_phy_eeprom_ready(struct usbnet *dev, int phy)
 			return 0;
 	}
 
-	netdev_err(dev->net, "%s write timed out!\n", phy ? "phy" : "eeprom");
+	netdev_err(dev->net, "eeprom write timed out!\n");
 
 	return -EIO;
 }
 
-static int sr_share_read_word(struct usbnet *dev, int phy, u8 reg,
-			      __le16 *value)
+static int sr_read_eeprom_word(struct usbnet *dev, u8 reg, __le16 *value)
 {
 	int ret;
 
 	mutex_lock(&dev->phy_mutex);
 
-	sr_write_reg(dev, SR_EPAR, phy ? (reg | EPAR_PHY_ADR) : reg);
-	sr_write_reg(dev, SR_EPCR, phy ? (EPCR_EPOS | EPCR_ERPRR) : EPCR_ERPRR);
+	sr_write_reg(dev, SR_EPAR, reg);
+	sr_write_reg(dev, SR_EPCR, EPCR_ERPRR);
 
-	ret = wait_phy_eeprom_ready(dev, phy);
+	ret = wait_eeprom_ready(dev);
 	if (ret < 0)
 		goto out_unlock;
 
 	sr_write_reg(dev, SR_EPCR, 0x0);
 	ret = sr_read(dev, SR_EPDR, 2, value);
 
-	netdev_dbg(dev->net, "read shared %d 0x%02x returned 0x%04x, %d\n",
-		   phy, reg, *value, ret);
+	netdev_dbg(dev->net, "read eeprom 0x%02x returned 0x%04x, %d\n",
+		   reg, *value, ret);
 
 out_unlock:
 	mutex_unlock(&dev->phy_mutex);
 	return ret;
 }
 
-static int sr_share_write_word(struct usbnet *dev, int phy, u8 reg,
-			       __le16 value)
+static int __maybe_unused sr_write_eeprom_word(struct usbnet *dev, u8 reg,
+					       __le16 value)
 {
 	int ret;
 
@@ -128,11 +126,10 @@ static int sr_share_write_word(struct usbnet *dev, int phy, u8 reg,
 	if (ret < 0)
 		goto out_unlock;
 
-	sr_write_reg(dev, SR_EPAR, phy ? (reg | EPAR_PHY_ADR) : reg);
-	sr_write_reg(dev, SR_EPCR, phy ? (EPCR_WEP | EPCR_EPOS | EPCR_ERPRW) :
-		    (EPCR_WEP | EPCR_ERPRW));
+	sr_write_reg(dev, SR_EPAR, reg);
+	sr_write_reg(dev, SR_EPCR, EPCR_WEP | EPCR_ERPRW);
 
-	ret = wait_phy_eeprom_ready(dev, phy);
+	ret = wait_eeprom_ready(dev);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -143,11 +140,6 @@ static int sr_share_write_word(struct usbnet *dev, int phy, u8 reg,
 	return ret;
 }
 
-static int sr_read_eeprom_word(struct usbnet *dev, u8 offset, void *value)
-{
-	return sr_share_read_word(dev, 0, offset, value);
-}
-
 static int sr9700_get_eeprom_len(struct net_device *netdev)
 {
 	return SR_EEPROM_LEN;
@@ -174,80 +166,56 @@ static int sr9700_get_eeprom(struct net_device *netdev,
 	return ret;
 }
 
-static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
-{
-	struct usbnet *dev = netdev_priv(netdev);
-	int err, res;
-	__le16 word;
-	int rc = 0;
-
-	if (phy_id) {
-		netdev_dbg(netdev, "Only internal phy supported\n");
-		return 0;
-	}
-
-	/* Access NSR_LINKST bit for link status instead of MII_BMSR */
-	if (loc == MII_BMSR) {
-		u8 value;
-
-		err = sr_read_reg(dev, SR_NSR, &value);
-		if (err < 0)
-			return err;
-
-		if (value & NSR_LINKST)
-			rc = 1;
-	}
-	err = sr_share_read_word(dev, 1, loc, &word);
-	if (err < 0)
-		return err;
-
-	if (rc == 1)
-		res = le16_to_cpu(word) | BMSR_LSTATUS;
-	else
-		res = le16_to_cpu(word) & ~BMSR_LSTATUS;
-
-	netdev_dbg(netdev, "sr_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",
-		   phy_id, loc, res);
-
-	return res;
-}
-
-static void sr_mdio_write(struct net_device *netdev, int phy_id, int loc,
-			  int val)
+static void sr9700_handle_link_change(struct net_device *netdev, bool link)
 {
-	struct usbnet *dev = netdev_priv(netdev);
-	__le16 res = cpu_to_le16(val);
-
-	if (phy_id) {
-		netdev_dbg(netdev, "Only internal phy supported\n");
-		return;
+	if (netif_carrier_ok(netdev) != link) {
+		if (link) {
+			netif_carrier_on(netdev);
+			netdev_info(netdev, "link up, 10Mbps, half-duplex\n");
+		} else {
+			netif_carrier_off(netdev);
+			netdev_info(netdev, "link down\n");
+		}
 	}
-
-	netdev_dbg(netdev, "sr_mdio_write() phy_id=0x%02x, loc=0x%02x, val=0x%04x\n",
-		   phy_id, loc, val);
-
-	sr_share_write_word(dev, 1, loc, res);
 }
 
 static u32 sr9700_get_link(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
 	u8 value = 0;
-	int rc = 0;
+	u32 link = 0;
 
-	/* Get the Link Status directly */
 	sr_read_reg(dev, SR_NSR, &value);
-	if (value & NSR_LINKST)
-		rc = 1;
+	link = !!(value & NSR_LINKST);
 
-	return rc;
+	sr9700_handle_link_change(netdev, link);
+
+	return link;
 }
 
-static int sr9700_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
+/*
+ * The device supports only 10Mbps half-duplex operation. It implements the
+ * DM9601 speed/duplex status registers, but as the values are always the same,
+ * using them would add unnecessary complexity.
+ */
+static int sr9700_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *cmd)
 {
-	struct usbnet *dev = netdev_priv(netdev);
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Half);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10baseT_Half);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
+	cmd->base.speed = SPEED_10;
+	cmd->base.duplex = DUPLEX_HALF;
+	cmd->base.port = PORT_TP;
+	cmd->base.phy_address = 0;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+
+	return 0;
 }
 
 static const struct ethtool_ops sr9700_ethtool_ops = {
@@ -257,9 +225,7 @@ static const struct ethtool_ops sr9700_ethtool_ops = {
 	.set_msglevel	= usbnet_set_msglevel,
 	.get_eeprom_len	= sr9700_get_eeprom_len,
 	.get_eeprom	= sr9700_get_eeprom,
-	.nway_reset	= usbnet_nway_reset,
-	.get_link_ksettings	= usbnet_get_link_ksettings_mii,
-	.set_link_ksettings	= usbnet_set_link_ksettings_mii,
+	.get_link_ksettings	= sr9700_get_link_ksettings,
 };
 
 static void sr9700_set_multicast(struct net_device *netdev)
@@ -318,7 +284,6 @@ static const struct net_device_ops sr9700_netdev_ops = {
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= sr9700_ioctl,
 	.ndo_set_rx_mode	= sr9700_set_multicast,
 	.ndo_set_mac_address	= sr9700_set_mac_address,
 };
@@ -326,7 +291,6 @@ static const struct net_device_ops sr9700_netdev_ops = {
 static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct net_device *netdev;
-	struct mii_if_info *mii;
 	u8 addr[ETH_ALEN];
 	int ret;
 
@@ -343,13 +307,6 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* bulkin buffer is preferably not less than 3K */
 	dev->rx_urb_size = 3072;
 
-	mii = &dev->mii;
-	mii->dev = netdev;
-	mii->mdio_read = sr_mdio_read;
-	mii->mdio_write = sr_mdio_write;
-	mii->phy_id_mask = 0x1f;
-	mii->reg_num_mask = 0x1f;
-
 	sr_write_reg(dev, SR_NCR, NCR_RST);
 	udelay(20);
 
@@ -376,11 +333,6 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* receive broadcast packets */
 	sr9700_set_multicast(netdev);
 
-	sr_mdio_write(netdev, mii->phy_id, MII_BMCR, BMCR_RESET);
-	sr_mdio_write(netdev, mii->phy_id, MII_ADVERTISE, ADVERTISE_ALL |
-		      ADVERTISE_CSMA | ADVERTISE_PAUSE_CAP);
-	mii_nway_restart(mii);
-
 out:
 	return ret;
 }
@@ -484,7 +436,7 @@ static struct sk_buff *sr9700_tx_fixup(struct usbnet *dev, struct sk_buff *skb,
 
 static void sr9700_status(struct usbnet *dev, struct urb *urb)
 {
-	int link;
+	bool link;
 	u8 *buf;
 
 	/* format:
@@ -504,23 +456,7 @@ static void sr9700_status(struct usbnet *dev, struct urb *urb)
 	buf = urb->transfer_buffer;
 
 	link = !!(buf[0] & 0x40);
-	if (netif_carrier_ok(dev->net) != link) {
-		usbnet_link_change(dev, link, 1);
-		netdev_dbg(dev->net, "Link Status is: %d\n", link);
-	}
-}
-
-static int sr9700_link_reset(struct usbnet *dev)
-{
-	struct ethtool_cmd ecmd;
-
-	mii_check_media(&dev->mii, 1, 1);
-	mii_ethtool_gset(&dev->mii, &ecmd);
-
-	netdev_dbg(dev->net, "link_reset() speed: %d duplex: %d\n",
-		   ecmd.speed, ecmd.duplex);
-
-	return 0;
+	sr9700_handle_link_change(dev->net, link);
 }
 
 static const struct driver_info sr9700_driver_info = {
@@ -530,8 +466,6 @@ static const struct driver_info sr9700_driver_info = {
 	.rx_fixup	= sr9700_rx_fixup,
 	.tx_fixup	= sr9700_tx_fixup,
 	.status		= sr9700_status,
-	.link_reset	= sr9700_link_reset,
-	.reset		= sr9700_link_reset,
 };
 
 static const struct usb_device_id products[] = {
diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index ea2b4de621c8..3212859830dc 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -82,19 +82,16 @@
 #define		FCR_TXPEN		(1 << 5)
 #define		FCR_TXPF		(1 << 6)
 #define		FCR_TXP0		(1 << 7)
-/* Eeprom & Phy Control Reg */
+/* Eeprom Control Reg */
 #define	SR_EPCR		0x0B
 #define		EPCR_ERRE		(1 << 0)
 #define		EPCR_ERPRW		(1 << 1)
 #define		EPCR_ERPRR		(1 << 2)
-#define		EPCR_EPOS		(1 << 3)
 #define		EPCR_WEP		(1 << 4)
-/* Eeprom & Phy Address Reg */
+/* Eeprom Address Reg */
 #define	SR_EPAR		0x0C
 #define		EPAR_EROA		(0x3F << 0)
-#define		EPAR_PHY_ADR_MASK	(0x03 << 6)
-#define		EPAR_PHY_ADR		(0x01 << 6)
-/* Eeprom &	Phy Data Reg */
+/* Eeprom Data Reg */
 #define	SR_EPDR		0x0D	/* 0x0D ~ 0x0E for Data Reg Low & High */
 /* Wakeup Control Reg */
 #define	SR_WCR			0x0F
@@ -159,7 +156,7 @@
 #define	SR_REQ_WR_REG	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 
 /* parameters */
-#define	SR_SHARE_TIMEOUT	1000
+#define	SR_EEPROM_TIMEOUT	1000
 #define	SR_EEPROM_LEN		256
 #define	SR_MCAST_SIZE		8
 #define	SR_MCAST_ADDR_FLAG	0x80
-- 
2.43.0


