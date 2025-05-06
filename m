Return-Path: <netdev+bounces-188308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F3AAC10F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95453AD1A5
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378652750EB;
	Tue,  6 May 2025 10:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB502749FA
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526433; cv=none; b=KR4B2BsAEG1LKHzeSjlRjt7upflmL0UxXi931zMPmt9v1qA9751b0z1QoDcrw9toHFetASGRKbhmu40Js83HY5C6NHKKdss25liCpcYUVfYbe2EYwWJ0HbCCeqs4331RvchvQsIt/SDG/djYcRoSdtTGw9AvLa9XsS1NAmZesi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526433; c=relaxed/simple;
	bh=s0Sn9shh2OdtQ1A6mVl68Za//3NVUY5JIadoaSrHycY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw2pC7Fkn7ZweiWKfSkQOmZtuV5Kq85sA++NPTvf6e/XCKWHmEbUWRFGri9oA/y16mq2GeOc2n84SgrkTWMCtQBDPKA0ujt2kkY7jmQ5r1p6DseKhnxvQAQxvUa5+i7gTF3YuPg2t+7zHQtNmK1M1E6eJULd01x6T9UhHnfceH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uCFIp-0002e5-1m; Tue, 06 May 2025 12:13:31 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCFIn-001NTM-1n;
	Tue, 06 May 2025 12:13:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCFIn-006WxM-1K;
	Tue, 06 May 2025 12:13:29 +0200
Date: Tue, 6 May 2025 12:13:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Thangaraj.S@microchip.com
Cc: andrew+netdev@lunn.ch, rmk+kernel@armlinux.org.uk, davem@davemloft.net,
	Rengarajan.S@microchip.com, Woojung.Huh@microchip.com,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v8 3/7] net: usb: lan78xx: refactor PHY init to
 separate detection and MAC configuration
Message-ID: <aBngyYuyyXqV18G4@pengutronix.de>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
 <20250505084341.824165-4-o.rempel@pengutronix.de>
 <c1b45ed298748aafbe3557d637707820bc37e2d2.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1b45ed298748aafbe3557d637707820bc37e2d2.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Thangaraj,

Thanks for the review!

On Tue, May 06, 2025 at 05:31:30AM +0000, Thangaraj.S@microchip.com wrote:
> Hi Oleksj.
> Thanks for the patch.
> 
> On Mon, 2025-05-05 at 10:43 +0200, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > Split out PHY detection into lan78xx_get_phy() and MAC-side setup
> > into
> > lan78xx_mac_prepare_for_phy(), making the main lan78xx_phy_init()
> > cleaner
> > and easier to follow.
> > 
> > This improves separation of concerns and prepares the code for a
> > future
> > transition to phylink. Fixed PHY registration and interface selection
> > are now handled in lan78xx_get_phy(), while MAC-side delay
> > configuration
> > is done in lan78xx_mac_prepare_for_phy().
> > 
> > The fixed PHY fallback is preserved for setups like EVB-KSZ9897-1,
> > where LAN7801 connects directly to a KSZ switch without a standard
> > PHY
> > or device tree support.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v6:
> > - this patch is added in v6
> > ---
> >  drivers/net/usb/lan78xx.c | 174 ++++++++++++++++++++++++++++------
> > ----
> >  1 file changed, 128 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index 9c0658227bde..7f1ecc415d53 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> > @@ -2508,53 +2508,145 @@ static void lan78xx_remove_irq_domain(struct
> > lan78xx_net *dev)
> >         dev->domain_data.irqdomain = NULL;
> >  }
> > 
> > 
> >  static int lan78xx_phy_init(struct lan78xx_net *dev)
> > @@ -2564,31 +2656,13 @@ static int lan78xx_phy_init(struct
> > lan78xx_net *dev)
> >         u32 mii_adv;
> >         struct phy_device *phydev;
> > 
> > -       switch (dev->chipid) {
> > -       case ID_REV_CHIP_ID_7801_:
> > -               phydev = lan7801_phy_init(dev);
> > -               if (IS_ERR(phydev)) {
> > -                       netdev_err(dev->net, "lan7801: failed to init
> > PHY: %pe\n",
> > -                                  phydev);
> > -                       return PTR_ERR(phydev);
> > -               }
> > -               break;
> > -
> > -       case ID_REV_CHIP_ID_7800_:
> > -       case ID_REV_CHIP_ID_7850_:
> > -               phydev = phy_find_first(dev->mdiobus);
> > -               if (!phydev) {
> > -                       netdev_err(dev->net, "no PHY found\n");
> > -                       return -ENODEV;
> > -               }
> > -               phydev->is_internal = true;
> > -               dev->interface = PHY_INTERFACE_MODE_GMII;
> > -               break;
> > +       phydev = lan78xx_get_phy(dev);
> > +       if (IS_ERR(phydev))
> > +               return PTR_ERR(phydev);
> > 
> > -       default:
> > -               netdev_err(dev->net, "Unknown CHIP ID found\n");
> > -               return -ENODEV;
> > -       }
> > +       ret = lan78xx_mac_prepare_for_phy(dev);
> > +       if (ret < 0)
> > +               goto free_phy;
> > 
> >         /* if phyirq is not set, use polling mode in phylib */
> >         if (dev->domain_data.phyirq > 0)
> > @@ -2662,6 +2736,14 @@ static int lan78xx_phy_init(struct lan78xx_net
> > *dev)
> >         dev->fc_autoneg = phydev->autoneg;
> > 
> >         return 0;
> > +
> > +free_phy:
> > +       if (phy_is_pseudo_fixed_link(phydev)) {
> > +               fixed_phy_unregister(phydev);
> > +               phy_device_free(phydev);
> > +       }
> > +
> > +       return ret;
> >  }
> 
> Could see as per implementation, this case might hit on normal phy
> other than fixed-phy too. Should we not add any cleanup for phydev
> here?

You're right to ask — but in this case, we don't need to clean up
non-fixed PHYs, since we only probe them using phy_find_first(), and do
not allocate, register, or attach them in lan78xx_get_phy(). So no extra
cleanup is needed in the error path for those cases.

If we ever call phy_connect_direct() earlier in the flow, we would need
to add a corresponding phy_disconnect(), but that's not the case here
yet.

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

