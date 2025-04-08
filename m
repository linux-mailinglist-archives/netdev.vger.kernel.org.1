Return-Path: <netdev+bounces-180196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066AA8040D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2552F1B61063
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B843269899;
	Tue,  8 Apr 2025 11:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FCA94A;
	Tue,  8 Apr 2025 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113586; cv=none; b=P890LR9UQ3KH1xrqM5lBeKZviw4eNz6uKScc8pk2H8IYq32cZ70bzpad8YxLssGLzDhYbWkJFX9nyMe+1SqEWCfkZ4jMHm6wxy6OnmwV2qVjHdZKG0U2TU4a5C62FvmWxzS9upwMW7O31G36jTEom5r4pyMUk+AtVMrwk/SQ+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113586; c=relaxed/simple;
	bh=H+sEWRoi0KMWTJdhw9CdKZg4wP0qGCG0W3QopnKON+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PACFX++k+GCNHpRcQt39GezqrACQel2Qt6nvtVPtTr9r5uPF8KcIKX7qfg8se8hG+c0/QmyxzAQlGlhHwh9K7FPTaEvfxOdoEA6rSVToV7SkmrVu7ElUy5MJ2MtzDQ1vljNmRWyAh9MjzNWnrrkG2ED+PMlZJXpSu0OcmHOi12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 89C76C408283;
	Tue,  8 Apr 2025 13:59:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 89C76C408283
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev <netdev@vger.kernel.org>,  Oliver Neukum <oneukum@suse.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  <linux-usb@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  Jose
 Ignacio Tornos Martinez <jtornosm@redhat.com>,  Ming Lei
 <ming.lei@redhat.com>
Subject: [PATCH v2] usbnet: asix AX88772: leave the carrier control to phylink
In-Reply-To: <m3tt6ydfzu.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
	"Tue, 08 Apr 2025 13:55:49 +0200")
References: <m35xjgdvih.fsf@t19.piap.pl> <Z_PVOWDMzmLObRM6@pengutronix.de>
	<m3tt6ydfzu.fsf@t19.piap.pl>
Sender: khalasa@piap.pl
Date: Tue, 08 Apr 2025 13:59:41 +0200
Message-ID: <m3plhmdfte.fsf_-_@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
indication. The internal PHY is configured (using EEPROM) in fixed
100 Mbps full duplex mode.

The primary problem appears to be using carrier_netif_{on,off}() while,
at the same time, delegating carrier management to phylink. Use only the
latter and remove "manual control" in the asix driver.

I don't have any other AX88772 board here, but the problem doesn't seem
specific to a particular board or settings - it's probably
timing-dependent.

Remove unused asix_adjust_link() as well.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

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
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
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


