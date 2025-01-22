Return-Path: <netdev+bounces-160208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014EA18D7A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313443AA8E1
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13E1C4A3B;
	Wed, 22 Jan 2025 08:16:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38017BB6
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533808; cv=none; b=tIGqiayVVmIw4M65yF7gu3z4LvkNJpOeZ4NMwkIiIg0YB13YLTM7tLBXa4jY2tpJvDOTh+FZSScvyiMfncQpSg8uATuyftlPfEW1x2/Skfx98Mh9c/DIMJvS/bLkt8UpDX9+iy4ps0qidnZUkPQBoM+BKRzTZTmPDb5Tl3JRoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533808; c=relaxed/simple;
	bh=xXphXCFzmyCylljfxJ2f+4S+nvDKoUDTNJweNl32ry8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeaz4feiN1K9GwOfxqH6PFYH3LwGEyDTWX5v5XZE8zYZqUTP/rW3lmQyNtKrIkoMntalQcjvF5UzWvii4Wp9Kyg56s9Tek9ZK2VFzsKM8pFucr6rc+P2DhQ2a3RkaUeqZ5Wk68g9fV4ATa4fotO8t6BiBrw1KWTb4ZyH9DnybgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1taVuZ-00048I-Gn; Wed, 22 Jan 2025 09:16:31 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1taVuX-001For-2T;
	Wed, 22 Jan 2025 09:16:29 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1taVuX-007dwC-24;
	Wed, 22 Jan 2025 09:16:29 +0100
Date: Wed, 22 Jan 2025 09:16:29 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rengarajan.S@microchip.com
Cc: andrew+netdev@lunn.ch, rmk+kernel@armlinux.org.uk, davem@davemloft.net,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, phil@raspberrypi.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z5CpXXNQrtmxuxaF@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-2-o.rempel@pengutronix.de>
 <0328797731d5ec0af580cf2f4f7e000212befa69.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0328797731d5ec0af580cf2f4f7e000212befa69.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Rengarajan,

On Fri, Jan 17, 2025 at 10:50:48AM +0000, Rengarajan.S@microchip.com wrote:
> Hi Oleksji,
> 
> On Wed, 2025-01-08 at 13:13 +0100, Oleksij Rempel wrote:
> > +static int lan78xx_configure_usb(struct lan78xx_net *dev, int speed)
> > +{
> > +       int ret;
> > +
> > +       if (dev->udev->speed != USB_SPEED_SUPER)
> > +               return 0;
> > +
> > +       if (speed != SPEED_1000)
> > +               return lan78xx_update_reg(dev, USB_CFG1,
> > +                                         USB_CFG1_DEV_U2_INIT_EN_ |
> > +                                         USB_CFG1_DEV_U1_INIT_EN_,
> > +                                         USB_CFG1_DEV_U2_INIT_EN_ |
> > +                                         USB_CFG1_DEV_U1_INIT_EN_);
> > +
> > +       /* disable U2 */
> > +       ret = lan78xx_update_reg(dev, USB_CFG1,
> > +                                USB_CFG1_DEV_U2_INIT_EN_, 0);
> > +       if (ret < 0)
> > +               return ret;
> > +       /* enable U1 */
> > +       return lan78xx_update_reg(dev, USB_CFG1,
> > +                                 USB_CFG1_DEV_U1_INIT_EN_,
> > +                                 USB_CFG1_DEV_U1_INIT_EN_);
> 
> Since, in the all the above cases we update the USB_CFG1 based on the
> mask and value depending on various speeds, have a variable for mask
> and value and use them to represent enabled flags instead of passing
> the flags directly for better readability.
> 
> For Eg: have mask = USB_CFG1_DEV_U2_INIT_EN_ and val = 0 and pass them
> as arguments.

ok.

> +
> > +       if (duplex == DUPLEX_FULL)
> > +               mac_cr |= MAC_CR_FULL_DUPLEX_;
> > +
> > +       /* make sure TXEN and RXEN are disabled before reconfiguring
> > MAC */
> > +       ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_SPEED_MASK_ |
> > +                                MAC_CR_FULL_DUPLEX_ |
> > MAC_CR_EEE_EN_, mac_cr);
> 
> The auto-speed and duplex are disabled in lan78xx_mac_config is it
> necessary to disable this again here. You can disable it once to 
> avoid redundancy.

ok.

> > +static const struct phylink_mac_ops lan78xx_phylink_mac_ops = {
> > +       .mac_config = lan78xx_mac_config,
> > +       .mac_link_down = lan78xx_mac_link_down,
> > +       .mac_link_up = lan78xx_mac_link_up,
> > +};
> 
> If possible, have MAC and phy related APIs in seperate patch.

I'll think about it, but I ques it will be not so good.

> > @@ -2609,18 +2701,7 @@ static int lan78xx_phy_init(struct lan78xx_net
> > *dev)
> >                 return -EIO;
> >         }
> > 
> > -       /* MAC doesn't support 1000T Half */
> > -       phy_remove_link_mode(phydev,
> > ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> 
> Since MAC doesn't support 1000Base-T half-duplex does phylink handle
> its removal from the advertised link modes. Previously, it was done
> using phy_remove_link_mode. If not, ensure that the phy doesn't end
> up advertising an unsupported mode.

Yes, it is done by following line:
  dev->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
    MAC_10 | MAC_100 | MAC_1000FD;

Thank you,

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

