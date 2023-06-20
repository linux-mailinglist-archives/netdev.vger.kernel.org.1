Return-Path: <netdev+bounces-12301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD77370C0
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A981C20C24
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80634174ED;
	Tue, 20 Jun 2023 15:43:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BA154B4
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:43:42 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA28129
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ym4vE040mto0m2IZmNVAlHUJZIJP2cK7eZvJXllAq9c=; b=s5F3zmSEay3hUOo7hbqpKRzZRD
	CFVu9Em9mVHXsfPFKKOH7gJurzl0gjt8G+6LF5Tx9olLtrJv2Hw30TMA6W9CmXhJxmT07j3zSTWyE
	n4t9DLs8Sr9M7sXkJU93cEkButF3TsMD5iG88w/YkHujNuZmQP8Gg/SVL3fj/sUary+9JQ15s46DB
	UpAdRKJp0AIyQ529WBxsX3XWpGYljAR4ecdnyzroXjBRVO+BlIdn+K6pGyc8EbxOTY8l0Uj5GrlX6
	pr60Edcrq0fvB8APk+EqnjdZH/EhbINDzdcQC7fLMm50IJt9M9pVUHv68OP9vNCNvmtzWikWpOA4+
	X8DUp59A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54892)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qBdVd-0001IJ-9R; Tue, 20 Jun 2023 16:43:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qBdVS-0006pB-Pn; Tue, 20 Jun 2023 16:42:58 +0100
Date: Tue, 20 Jun 2023 16:42:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cc@web.codeaurora.org:Claudiu Beznea <claudiu.beznea@microchip.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 01/15] net: phylink: add PCS negotiation mode
Message-ID: <ZJHJAtkEvQ2dAXux@shell.armlinux.org.uk>
References: <ZIxQIBfO9dH5xFlg@shell.armlinux.org.uk>
 <E1qA8De-00EaFA-Ht@rmk-PC.armlinux.org.uk>
 <20230620113429.mc4p4y6mny5cm4ih@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113429.mc4p4y6mny5cm4ih@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 02:34:29PM +0300, Vladimir Oltean wrote:
> On Fri, Jun 16, 2023 at 01:06:22PM +0100, Russell King (Oracle) wrote:
> > PCS have to work out whether they should enable PCS negotiation by
> > looking at the "mode" and "interface" arguments, and the Autoneg bit
> > in the advertising mask.
> > 
> > This leads to some complex logic, so lets pull that out into phylink
> > and instead pass a "neg_mode" argument to the PCS configuration and
> > link up methods, instead of the "mode" argument.
> > 
> > In order to transition drivers, add a "neg_mode" flag to the phylink
> > PCS structure to PCS can indicate whether they want to be passed the
> > neg_mode or the old mode argument.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> > index 0cf07d7d11b8..2b322d7fa51a 100644
> > --- a/include/linux/phylink.h
> > +++ b/include/linux/phylink.h
> > @@ -21,6 +21,24 @@ enum {
> >  	MLO_AN_FIXED,	/* Fixed-link mode */
> >  	MLO_AN_INBAND,	/* In-band protocol */
> >  
> > +	/* PCS "negotiation" mode.
> > +	 *  PHYLINK_PCS_NEG_NONE - protocol has no inband capability
> > +	 *  PHYLINK_PCS_NEG_OUTBAND - some out of band or fixed link setting
> 
> Would OUTBAND be more clearly named as FORCED maybe?

I don't see how FORCED would improve anything.

> > +	 *  PHYLINK_PCS_NEG_INBAND_DISABLED - inband mode disabled, e.g.
> > +	 *				      1000base-X with autoneg off
> > +	 *  PHYLINK_PCS_NEG_INBAND_ENABLED - inband mode enabled
> > +	 * Additionally, this can be tested using bitmasks:
> > +	 *  PHYLINK_PCS_NEG_INBAND - inband mode selected
> > +	 *  PHYLINK_PCS_NEG_ENABLED - negotiation mode enabled
> > +	 */
> > +	PHYLINK_PCS_NEG_NONE = 0,
> > +	PHYLINK_PCS_NEG_ENABLED = BIT(4),
> 
> Why do we start the enum values from BIT(4)? What are we colliding with,
> in the range of lower values?

I want to make sure that they can't be confused with MLO_AN_* values,
especially since we pass them through the same interface that MLO_AN_*
was using.

> > @@ -79,6 +97,70 @@ static inline bool phylink_autoneg_inband(unsigned int mode)
> >  	return mode == MLO_AN_INBAND;
> >  }
> >  
> > +/**
> > + * phylink_pcs_neg_mode() - helper to determine PCS inband mode
> 
> I think you are naming it "neg_mode" rather than "aneg_mode" because
> with OUTBAND/NONE, there's nothing "automatic" about the negotiation.
> However, "neg" rather than "aneg" sounds more like a shorthand form of
> "negation" or "negative". Would you oppose renaming it to "aneg_mode"?

I want to try to get away from "auto-negotiation" for this because
that has connotations of there being some kind of agreement reached
between both ends, like what happens with baseT links. However, that
is not the case with the SGMII family, which are more a form of
inband signalling.

I can't find any other term for the inband signalling that covers
all cases. "Negotiation" on its own covers both "negotiation result"
for SGMII as well as in-band negotiation for base-X cases. I don't
think "auto-negotiation" covers SGMII, and "in-band signalling"
wouldn't really cover base-X.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

