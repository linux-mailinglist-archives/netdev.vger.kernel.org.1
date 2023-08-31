Return-Path: <netdev+bounces-31556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB4078EBE8
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE371C20A64
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D768F78;
	Thu, 31 Aug 2023 11:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6C8F5E
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:23:53 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4481FCE4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:23:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbfm3-0000KS-J6; Thu, 31 Aug 2023 13:23:43 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbfm2-0000FF-LD; Thu, 31 Aug 2023 13:23:42 +0200
Date: Thu, 31 Aug 2023 13:23:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1] net: phy: micrel: Correct bit assignment for
 MICREL_KSZ8_P1_ERRATA flag
Message-ID: <20230831112342.GD17603@pengutronix.de>
References: <20230831110427.3551432-1-o.rempel@pengutronix.de>
 <ZPB3cYMnFq1qGRv0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPB3cYMnFq1qGRv0@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 12:20:17PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 31, 2023 at 01:04:27PM +0200, Oleksij Rempel wrote:
> > The previous assignment of the phy_device quirk for the
> > MICREL_KSZ8_P1_ERRATA flag was incorrect, working only due to
> > coincidental conditions. Specifically:
> > 
> > - The flag MICREL_KSZ8_P1_ERRATA, intended for KSZ88xx switches, was
> >   mistakenly overlapping with the MICREL_PHY_FXEN and
> >   MICREL_PHY_50MHZ_CLK flags.
> > - MICREL_PHY_FXEN is used by the KSZ8041 PHY, and its related code path
> >   wasn't executed for KSZ88xx PHYs and other way around.
> > - Additionally, the code path associated with the MICREL_PHY_50MHZ_CLK
> >   flag wasn't executed for KSZ88xx either.
> > 
> > Fixes: 49011e0c1555d ("net: phy: micrel: ksz886x/ksz8081: add cabletest support")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  include/linux/micrel_phy.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
> > index 8bef1ab62bba3..0cedbeb9167c3 100644
> > --- a/include/linux/micrel_phy.h
> > +++ b/include/linux/micrel_phy.h
> > @@ -43,7 +43,7 @@
> >  /* struct phy_device dev_flags definitions */
> >  #define MICREL_PHY_50MHZ_CLK	0x00000001
> >  #define MICREL_PHY_FXEN		0x00000002
> > -#define MICREL_KSZ8_P1_ERRATA	0x00000003
> > +#define MICREL_KSZ8_P1_ERRATA	BIT(3)
> 
> Please can you also convert the other two flags to use BIT() as well to
> make the entire thing explicitly bit-orientated? Thanks.

Ack. This patch is for the net. The cleanup will got to the net-next.
Except clean up will be accepted for the net too?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

