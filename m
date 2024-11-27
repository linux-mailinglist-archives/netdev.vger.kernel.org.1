Return-Path: <netdev+bounces-147568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1019DA41F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74251282C40
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD71155389;
	Wed, 27 Nov 2024 08:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3414E2C2;
	Wed, 27 Nov 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697143; cv=none; b=h6DSGDM7PnuOYDuJMiicy3+5z5DwWryg56TdbQgBv56xg8mevfkWOeNBIPfHMYHbCTnSOTmRGu4witoyaW8VrlxrmEK8d3BiogyGP7C0zIYGOABkvAN+fisFKlg3Hdn/LYmVWOqQ0siK2eFcffcP5Vx0nqWy3x5tzZ+DalVwAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697143; c=relaxed/simple;
	bh=Gp1I9/44pp5WmMuj6xkLksDdsCW2D38Y89zaBNJUSu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ob1csiDqpmITFoDQhOp8tr4uLDAx/LhB7Uu11njITwSVNkehkPiSv3fYQJCAiwFmyyDyzlPwG95ClqmZPW55CvvKZpL91VT8oPObg6rNmkesbyUsjcht9I3vURip7Wpiyf6LwZdlhFDBHY7vi/lCkaEWevERAh1tucBC/H05Vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 72F0EC3EEACB;
	Wed, 27 Nov 2024 09:45:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 72F0EC3EEACB
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: netdev <netdev@vger.kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric  Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org, Jose Ignacio Tornos Martinez
 <jtornosm@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] USBNET: Fix ASIX USB Ethernet carrier problems.
Sender: khalasa@piap.pl
Date: Wed, 27 Nov 2024 09:45:30 +0100
Message-ID: <m3v7w9hxp1.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
indication. The internal PHY is configured (using EEPROM) in fixed
100 Mbps full duplex mode.

The primary problem appears to be using carrier_netif_{on,off}() while,
at the same time, delegating carrier management to phylink. Use only the
latter and remove "manual control" in the asix driver.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
index 74162190bccc..8531b804021a 100644
--- a/drivers/net/usb/asix.h
+++ b/drivers/net/usb/asix.h
@@ -224,7 +224,6 @@ int asix_write_rx_ctl(struct usbnet *dev, u16 mode, int=
 in_pm);
=20
 u16 asix_read_medium_status(struct usbnet *dev, int in_pm);
 int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm);
-void asix_adjust_link(struct net_device *netdev);
=20
 int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm);
=20
diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 72ffc89b477a..7fd763917ae2 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -414,28 +414,6 @@ int asix_write_medium_mode(struct usbnet *dev, u16 mod=
e, int in_pm)
 	return ret;
 }
=20
-/* set MAC link settings according to information from phylib */
-void asix_adjust_link(struct net_device *netdev)
-{
-	struct phy_device *phydev =3D netdev->phydev;
-	struct usbnet *dev =3D netdev_priv(netdev);
-	u16 mode =3D 0;
-
-	if (phydev->link) {
-		mode =3D AX88772_MEDIUM_DEFAULT;
-
-		if (phydev->duplex =3D=3D DUPLEX_HALF)
-			mode &=3D ~AX_MEDIUM_FD;
-
-		if (phydev->speed !=3D SPEED_100)
-			mode &=3D ~AX_MEDIUM_PS;
-	}
-
-	asix_write_medium_mode(dev, mode, 0);
-	phy_print_status(phydev);
-	usbnet_link_change(dev, phydev->link, 0);
-}
-
 int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
 {
 	int ret;
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 57d6e5abc30e..af91fc947f40 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -40,22 +40,6 @@ struct ax88172_int_data {
 	__le16 res3;
 } __packed;
=20
-static void asix_status(struct usbnet *dev, struct urb *urb)
-{
-	struct ax88172_int_data *event;
-	int link;
-
-	if (urb->actual_length < 8)
-		return;
-
-	event =3D urb->transfer_buffer;
-	link =3D event->link & 0x01;
-	if (netif_carrier_ok(dev->net) !=3D link) {
-		usbnet_link_change(dev, link, 1);
-		netdev_dbg(dev->net, "Link Status is: %d\n", link);
-	}
-}
-
 static void asix_set_netdev_dev_addr(struct usbnet *dev, u8 *addr)
 {
 	if (is_valid_ether_addr(addr)) {
@@ -752,7 +736,6 @@ static void ax88772_mac_link_down(struct phylink_config=
 *config,
 	struct usbnet *dev =3D netdev_priv(to_net_dev(config->dev));
=20
 	asix_write_medium_mode(dev, 0, 0);
-	usbnet_link_change(dev, false, false);
 }
=20
 static void ax88772_mac_link_up(struct phylink_config *config,
@@ -783,7 +766,6 @@ static void ax88772_mac_link_up(struct phylink_config *=
config,
 		m |=3D AX_MEDIUM_RFC;
=20
 	asix_write_medium_mode(dev, m, 0);
-	usbnet_link_change(dev, true, false);
 }
=20
 static const struct phylink_mac_ops ax88772_phylink_mac_ops =3D {
@@ -1309,40 +1291,36 @@ static int ax88178_bind(struct usbnet *dev, struct =
usb_interface *intf)
 static const struct driver_info ax8817x_info =3D {
 	.description =3D "ASIX AX8817x USB 2.0 Ethernet",
 	.bind =3D ax88172_bind,
-	.status =3D asix_status,
 	.link_reset =3D ax88172_link_reset,
 	.reset =3D ax88172_link_reset,
-	.flags =3D  FLAG_ETHER | FLAG_LINK_INTR,
+	.flags =3D  FLAG_ETHER,
 	.data =3D 0x00130103,
 };
=20
 static const struct driver_info dlink_dub_e100_info =3D {
 	.description =3D "DLink DUB-E100 USB Ethernet",
 	.bind =3D ax88172_bind,
-	.status =3D asix_status,
 	.link_reset =3D ax88172_link_reset,
 	.reset =3D ax88172_link_reset,
-	.flags =3D  FLAG_ETHER | FLAG_LINK_INTR,
+	.flags =3D  FLAG_ETHER,
 	.data =3D 0x009f9d9f,
 };
=20
 static const struct driver_info netgear_fa120_info =3D {
 	.description =3D "Netgear FA-120 USB Ethernet",
 	.bind =3D ax88172_bind,
-	.status =3D asix_status,
 	.link_reset =3D ax88172_link_reset,
 	.reset =3D ax88172_link_reset,
-	.flags =3D  FLAG_ETHER | FLAG_LINK_INTR,
+	.flags =3D  FLAG_ETHER,
 	.data =3D 0x00130103,
 };
=20
 static const struct driver_info hawking_uf200_info =3D {
 	.description =3D "Hawking UF200 USB Ethernet",
 	.bind =3D ax88172_bind,
-	.status =3D asix_status,
 	.link_reset =3D ax88172_link_reset,
 	.reset =3D ax88172_link_reset,
-	.flags =3D  FLAG_ETHER | FLAG_LINK_INTR,
+	.flags =3D  FLAG_ETHER,
 	.data =3D 0x001f1d1f,
 };
=20
@@ -1350,10 +1328,9 @@ static const struct driver_info ax88772_info =3D {
 	.description =3D "ASIX AX88772 USB 2.0 Ethernet",
 	.bind =3D ax88772_bind,
 	.unbind =3D ax88772_unbind,
-	.status =3D asix_status,
 	.reset =3D ax88772_reset,
 	.stop =3D ax88772_stop,
-	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR | FLAG_MULTI_PAC=
KET,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup =3D asix_rx_fixup_common,
 	.tx_fixup =3D asix_tx_fixup,
 };
@@ -1362,11 +1339,9 @@ static const struct driver_info ax88772b_info =3D {
 	.description =3D "ASIX AX88772B USB 2.0 Ethernet",
 	.bind =3D ax88772_bind,
 	.unbind =3D ax88772_unbind,
-	.status =3D asix_status,
 	.reset =3D ax88772_reset,
 	.stop =3D ax88772_stop,
-	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-	         FLAG_MULTI_PACKET,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup =3D asix_rx_fixup_common,
 	.tx_fixup =3D asix_tx_fixup,
 	.data =3D FLAG_EEPROM_MAC,
@@ -1376,11 +1351,9 @@ static const struct driver_info lxausb_t1l_info =3D {
 	.description =3D "Linux Automation GmbH USB 10Base-T1L",
 	.bind =3D ax88772_bind,
 	.unbind =3D ax88772_unbind,
-	.status =3D asix_status,
 	.reset =3D ax88772_reset,
 	.stop =3D ax88772_stop,
-	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-		 FLAG_MULTI_PACKET,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup =3D asix_rx_fixup_common,
 	.tx_fixup =3D asix_tx_fixup,
 	.data =3D FLAG_EEPROM_MAC,
@@ -1390,11 +1363,9 @@ static const struct driver_info ax88178_info =3D {
 	.description =3D "ASIX AX88178 USB 2.0 Ethernet",
 	.bind =3D ax88178_bind,
 	.unbind =3D ax88178_unbind,
-	.status =3D asix_status,
 	.link_reset =3D ax88178_link_reset,
 	.reset =3D ax88178_reset,
-	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-		 FLAG_MULTI_PACKET,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup =3D asix_rx_fixup_common,
 	.tx_fixup =3D asix_tx_fixup,
 };
@@ -1412,10 +1383,8 @@ static const struct driver_info hg20f9_info =3D {
 	.description =3D "HG20F9 USB 2.0 Ethernet",
 	.bind =3D ax88772_bind,
 	.unbind =3D ax88772_unbind,
-	.status =3D asix_status,
 	.reset =3D ax88772_reset,
-	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
-	         FLAG_MULTI_PACKET,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
 	.rx_fixup =3D asix_rx_fixup_common,
 	.tx_fixup =3D asix_tx_fixup,
 	.data =3D FLAG_EEPROM_MAC,

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

