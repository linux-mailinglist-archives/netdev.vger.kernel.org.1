Return-Path: <netdev+bounces-25677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B8D775200
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ECE281A45
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E94A63B;
	Wed,  9 Aug 2023 04:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334F4680
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 04:36:34 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBB198D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:36:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qTavu-0002zY-73; Wed, 09 Aug 2023 06:36:30 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qTavq-0003R7-J5; Wed, 09 Aug 2023 06:36:26 +0200
Date: Wed, 9 Aug 2023 06:36:26 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <20230809043626.GG5736@pengutronix.de>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 02:27:12AM +0000, Wei Fang wrote:
> > >> Toggle hibernation mode OFF and ON to wake the PHY up and make it
> > >> generate clock on RX_CLK pin for about 10 seconds.
> > >> These clock are needed during start up by MACs like DWMAC in NXP
> > >> i.MX8M Plus to release their DMA from reset. After the MAC has
> > >> started up, the PHY can enter hibernation and disable the RX_CLK
> > >> clock, this poses no problem for the MAC.
> > >>
> > >> Originally, this issue has been described by NXP in commit
> > >> 9ecf04016c87 ("net: phy: at803x: add disable hibernation mode
> > >> support") but this approach fully disables the hibernation support
> > >> and takes away any power saving benefit. This patch instead makes the
> > >> PHY generate the clock on start up for 10 seconds, which should be
> > >> long enough for the EQoS MAC to release DMA from reset.
> > >>
> > >> Before this patch on i.MX8M Plus board with AR8031 PHY:
> > >> "
> > >> $ ifconfig eth1 up
> > >> [   25.576734] imx-dwmac 30bf0000.ethernet eth1: Register
> > >> MEM_TYPE_PAGE_POOL RxQ-0
> > >> [   25.658916] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:00]
> > >> driver [Qualcomm Atheros AR8031/AR8033] (irq=38)
> > >> [   26.670276] imx-dwmac 30bf0000.ethernet: Failed to reset the dma
> > >> [   26.676322] imx-dwmac 30bf0000.ethernet eth1: stmmac_hw_setup:
> > >> DMA engine initialization failed
> > >> [   26.685103] imx-dwmac 30bf0000.ethernet eth1: __stmmac_open:
> > Hw
> > >> setup failed
> > >> ifconfig: SIOCSIFFLAGS: Connection timed out "
> > >>
> > >
> > > Have you reproduced this issue based on the upstream net-next or net
> > tree?
> > 
> > On current linux-next next-20230808 so 6.5.0-rc5 . As far as I can tell,
> > net-next is merged into this tree too.
> > 
> 
> > > If so, can this issue be reproduced? The reason why I ask this is
> > > because when I tried to reproduce this problem on net-next 6.3.0
> > > version, I found that it could not be reproduced (I did not disable
> > > hibernation mode when I reproduced this issue ). So I guess maybe other
> > patches in eqos driver fixed the issue.
> > 
> > This is what I use for testing:
> > 
> > - Make sure "qca,disable-hibernation-mode" is NOT present in PHY DT node
> Yes, I deleted this property when I reproduced this issue.
> 
> > - Boot the machine with NO ethernet cable plugged into the affected port
> >    (i.e. the EQoS port), this is important
> > - Make sure the EQoS MAC is not brought up e.g. by systemd-networkd or
> >    whatever other tool, I use busybox initramfs for testing with plain
> >    script as init (it mounts the various filesystems and runs /bin/sh)
> 
> It looks like something has been changed since I submitted the "disable hibernation
> mode " patch. In previous test, I only need to unplug the cable and then use ifconfig
> cmd to disable the interface, wait more than 10 seconds, then use ifconfig cmd to
> enable the interface.
> 
> > - Wait longer than 10 seconds
> > - If possible, measure AR8031 PHY pin 33 RX_CLK, wait for the RX_CLK to
> >    be turned OFF by the PHY (means PHY entered hibernation)
> > - ifconfig ethN up -- try to bring up the EQoS MAC <observe failure>
> > 
> > [...]
> 
> For the patch, I think your approach is better than mine, but I have a suggestion,
> is the following modification more appropriate?
> 
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -991,12 +991,28 @@ static int at8031_pll_config(struct phy_device *phydev)
>  static int at803x_hibernation_mode_config(struct phy_device *phydev)
>  {
>         struct at803x_priv *priv = phydev->priv;
> +       int ret;
> 
>         /* The default after hardware reset is hibernation mode enabled. After
>          * software reset, the value is retained.
>          */
> -       if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE))
> -               return 0;
> +       if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE)) {
> +               /* Toggle hibernation mode OFF and ON to wake the PHY up and
> +                * make it generate clock on RX_CLK pin for about 10 seconds.
> +                * These clock are needed during start up by MACs like DWMAC
> +                * in NXP i.MX8M Plus to release their DMA from reset. After
> +                * the MAC has started up, the PHY can enter hibernation and
> +                * disable the RX_CLK clock, this poses no problem for the MAC.
> +                */
> +               ret = at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
> +                                           AT803X_DEBUG_HIB_CTRL_PS_HIB_EN, 0);
> +               if (ret < 0)
> +                       return ret;
> +
> +               return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
> +                                            AT803X_DEBUG_HIB_CTRL_PS_HIB_EN,
> +                                            AT803X_DEBUG_HIB_CTRL_PS_HIB_EN);
> +       }
> 
>         return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,

Hm.. how about officially defining this PHY as the clock provider and
disable PHY automatic hibernation as long as clock is acquired?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

