Return-Path: <netdev+bounces-179649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECAA7DFB6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C105E3B62D8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B451531C5;
	Mon,  7 Apr 2025 13:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6F18C02E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033095; cv=none; b=MWK5U5bq0VShEiK6FRfmEs5w94/Z0rtxYaXrIaQG46H4qhztRcTmyxrO/Q/OYLnVPzz67qqhDPlArHHdGGcPVM3pLGLuGP61Gh3gWfCGgQ1cqkKkbX7nw8QW4on4f7zWYsomTksXyRuz/z8RC9tkeRlYuhx+erR+5a+dSwJ8+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033095; c=relaxed/simple;
	bh=YZ24IjoPPIZZv1j6ya2Q6y1c3Lyezek/7soV2rHdK2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thjbRXQWPFC9xIS0sB9IzEsap2zIc/RxjMhmgZhLUQoZahos1STfExPrO6jtM5A6v/3A6ARNvDbO6BOXDDsj9fqIh3DFeJFBFfjFLpwnhytq1gcVAqMts5toh9XCPKg/A5RuUvH+0tdXqI49JP/Um3lpjPRQO/rawHCRCMmK6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u1mfq-00070I-WC; Mon, 07 Apr 2025 15:38:03 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u1mfp-003lrS-1W;
	Mon, 07 Apr 2025 15:38:01 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u1mfp-004hsE-1A;
	Mon, 07 Apr 2025 15:38:01 +0200
Date: Mon, 7 Apr 2025 15:38:01 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH REPOST] usbnet: asix: leave the carrier control to phylink
Message-ID: <Z_PVOWDMzmLObRM6@pengutronix.de>
References: <m35xjgdvih.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m35xjgdvih.fsf@t19.piap.pl>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Krzysztof,

On Mon, Apr 07, 2025 at 02:08:22PM +0200, Krzysztof Hałasa wrote:
> [added Oleksij - the author of the phylink code for this driver]
> 
> ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
> up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
> indication. The internal PHY is configured (using EEPROM) in fixed
> 100 Mbps full duplex mode.
>
> The primary problem appears to be using carrier_netif_{on,off}() while,
> at the same time, delegating carrier management to phylink. Use only the
> latter and remove "manual control" in the asix driver.

Good point, this artifact should be partially removed, but not for all
devices.  Only ax88772 are converted to PHYlink. ax88178 are not
converted.

> I don't have any other AX88772 board here, but the problem doesn't seem
> specific to a particular board or settings - it's probably
> timing-dependent.

The AX88772 portion of the driver, is not forwarding the interrupt to
the PHY driver. It means, PHY is in polling mode. As long as PHY
provides proper information, it will work.

On other hand, you seems to use AX88772B in 100BASE-FX mode. I'm sure,
current PHY driver for this device do not know anything about FX mode:
drivers/net/phy/ax88796b.c

Which 100BASE-FX PHY  capable device do you use? Is it possible to buy
it some where?

> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
> 
> diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
> index 74162190bccc..8531b804021a 100644
> --- a/drivers/net/usb/asix.h
> +++ b/drivers/net/usb/asix.h
> @@ -224,7 +224,6 @@ int asix_write_rx_ctl(struct usbnet *dev, u16 mode, int in_pm);
>  
>  u16 asix_read_medium_status(struct usbnet *dev, int in_pm);
>  int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm);
> -void asix_adjust_link(struct net_device *netdev);
>  
>  int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm);
>  
> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index 72ffc89b477a..7fd763917ae2 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -414,28 +414,6 @@ int asix_write_medium_mode(struct usbnet *dev, u16 mode, int in_pm)
>  	return ret;
>  }
>  
> -/* set MAC link settings according to information from phylib */
> -void asix_adjust_link(struct net_device *netdev)
> -{
> -	struct phy_device *phydev = netdev->phydev;
> -	struct usbnet *dev = netdev_priv(netdev);
> -	u16 mode = 0;
> -
> -	if (phydev->link) {
> -		mode = AX88772_MEDIUM_DEFAULT;
> -
> -		if (phydev->duplex == DUPLEX_HALF)
> -			mode &= ~AX_MEDIUM_FD;
> -
> -		if (phydev->speed != SPEED_100)
> -			mode &= ~AX_MEDIUM_PS;
> -	}
> -
> -	asix_write_medium_mode(dev, mode, 0);
> -	phy_print_status(phydev);
> -	usbnet_link_change(dev, phydev->link, 0);
> -}
> -
>  int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
>  {
>  	int ret;
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 57d6e5abc30e..af91fc947f40 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -40,22 +40,6 @@ struct ax88172_int_data {
>  	__le16 res3;
>  } __packed;
>  
> -static void asix_status(struct usbnet *dev, struct urb *urb)
> -{
> -	struct ax88172_int_data *event;
> -	int link;
> -
> -	if (urb->actual_length < 8)
> -		return;
> -
> -	event = urb->transfer_buffer;
> -	link = event->link & 0x01;
> -	if (netif_carrier_ok(dev->net) != link) {
> -		usbnet_link_change(dev, link, 1);
> -		netdev_dbg(dev->net, "Link Status is: %d\n", link);
> -	}
> -}
> -
>  static void asix_set_netdev_dev_addr(struct usbnet *dev, u8 *addr)
>  {
>  	if (is_valid_ether_addr(addr)) {
> @@ -752,7 +736,6 @@ static void ax88772_mac_link_down(struct phylink_config *config,
>  	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
>  
>  	asix_write_medium_mode(dev, 0, 0);
> -	usbnet_link_change(dev, false, false);
>  }
>  
>  static void ax88772_mac_link_up(struct phylink_config *config,
> @@ -783,7 +766,6 @@ static void ax88772_mac_link_up(struct phylink_config *config,
>  		m |= AX_MEDIUM_RFC;
>  
>  	asix_write_medium_mode(dev, m, 0);
> -	usbnet_link_change(dev, true, false);
>  }
>  
>  static const struct phylink_mac_ops ax88772_phylink_mac_ops = {
> @@ -1309,40 +1291,36 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
>  static const struct driver_info ax8817x_info = {
>  	.description = "ASIX AX8817x USB 2.0 Ethernet",
>  	.bind = ax88172_bind,
> -	.status = asix_status,
>  	.link_reset = ax88172_link_reset,
>  	.reset = ax88172_link_reset,
> -	.flags =  FLAG_ETHER | FLAG_LINK_INTR,
> +	.flags =  FLAG_ETHER,
>  	.data = 0x00130103,
>  };
>  
>  static const struct driver_info dlink_dub_e100_info = {
>  	.description = "DLink DUB-E100 USB Ethernet",
>  	.bind = ax88172_bind,
> -	.status = asix_status,
>  	.link_reset = ax88172_link_reset,
>  	.reset = ax88172_link_reset,
> -	.flags =  FLAG_ETHER | FLAG_LINK_INTR,
> +	.flags =  FLAG_ETHER,
>  	.data = 0x009f9d9f,
>  };
>  
>  static const struct driver_info netgear_fa120_info = {
>  	.description = "Netgear FA-120 USB Ethernet",
>  	.bind = ax88172_bind,
> -	.status = asix_status,
>  	.link_reset = ax88172_link_reset,
>  	.reset = ax88172_link_reset,
> -	.flags =  FLAG_ETHER | FLAG_LINK_INTR,
> +	.flags =  FLAG_ETHER,
>  	.data = 0x00130103,
>  };
>  
>  static const struct driver_info hawking_uf200_info = {
>  	.description = "Hawking UF200 USB Ethernet",
>  	.bind = ax88172_bind,
> -	.status = asix_status,
>  	.link_reset = ax88172_link_reset,
>  	.reset = ax88172_link_reset,
> -	.flags =  FLAG_ETHER | FLAG_LINK_INTR,
> +	.flags =  FLAG_ETHER,
>  	.data = 0x001f1d1f,
>  };
>  
> @@ -1350,10 +1328,9 @@ static const struct driver_info ax88772_info = {
>  	.description = "ASIX AX88772 USB 2.0 Ethernet",
>  	.bind = ax88772_bind,
>  	.unbind = ax88772_unbind,
> -	.status = asix_status,
>  	.reset = ax88772_reset,
>  	.stop = ax88772_stop,
> -	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR | FLAG_MULTI_PACKET,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
>  	.rx_fixup = asix_rx_fixup_common,
>  	.tx_fixup = asix_tx_fixup,
>  };
> @@ -1362,11 +1339,9 @@ static const struct driver_info ax88772b_info = {
>  	.description = "ASIX AX88772B USB 2.0 Ethernet",
>  	.bind = ax88772_bind,
>  	.unbind = ax88772_unbind,
> -	.status = asix_status,
>  	.reset = ax88772_reset,
>  	.stop = ax88772_stop,
> -	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
> -	         FLAG_MULTI_PACKET,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
>  	.rx_fixup = asix_rx_fixup_common,
>  	.tx_fixup = asix_tx_fixup,
>  	.data = FLAG_EEPROM_MAC,
> @@ -1376,11 +1351,9 @@ static const struct driver_info lxausb_t1l_info = {
>  	.description = "Linux Automation GmbH USB 10Base-T1L",
>  	.bind = ax88772_bind,
>  	.unbind = ax88772_unbind,
> -	.status = asix_status,
>  	.reset = ax88772_reset,
>  	.stop = ax88772_stop,
> -	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
> -		 FLAG_MULTI_PACKET,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
>  	.rx_fixup = asix_rx_fixup_common,
>  	.tx_fixup = asix_tx_fixup,
>  	.data = FLAG_EEPROM_MAC,
> @@ -1390,11 +1363,9 @@ static const struct driver_info ax88178_info = {
>  	.description = "ASIX AX88178 USB 2.0 Ethernet",
>  	.bind = ax88178_bind,
>  	.unbind = ax88178_unbind,
> -	.status = asix_status,
>  	.link_reset = ax88178_link_reset,
>  	.reset = ax88178_reset,
> -	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
> -		 FLAG_MULTI_PACKET,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
>  	.rx_fixup = asix_rx_fixup_common,
>  	.tx_fixup = asix_tx_fixup,
>  };
> @@ -1412,10 +1383,8 @@ static const struct driver_info hg20f9_info = {
>  	.description = "HG20F9 USB 2.0 Ethernet",
>  	.bind = ax88772_bind,
>  	.unbind = ax88772_unbind,
> -	.status = asix_status,
>  	.reset = ax88772_reset,
> -	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
> -	         FLAG_MULTI_PACKET,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET,
>  	.rx_fixup = asix_rx_fixup_common,
>  	.tx_fixup = asix_tx_fixup,
>  	.data = FLAG_EEPROM_MAC,
> 
> -- 
> Krzysztof "Chris" Hałasa
> 
> Sieć Badawcza Łukasiewicz
> Przemysłowy Instytut Automatyki i Pomiarów PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

