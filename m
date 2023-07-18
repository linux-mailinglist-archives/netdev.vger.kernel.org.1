Return-Path: <netdev+bounces-18595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C33757CD7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56858280EED
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67FC8F4;
	Tue, 18 Jul 2023 13:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8CC2F3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:09:04 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC5D1722;
	Tue, 18 Jul 2023 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VQkzO/POrP/pHMh//7Dpmps4+dX6EJ9ax9BemZSO0H4=; b=r4eeY35zsbMpVS+HYlGbkMH+sx
	ZPY2ZolPXOioWG4hvfJ3qCQZXo+TltBBLCuqc9i00wCbBoBSlljYoZQ21E1mKT+fRpnl+Re+RpZVy
	NzzMIrhLe+BKO1XUmn3Mdma6sv34F18hNCML/18V6OmxGqvYq/CrwgX4O3fYYzbJlSpA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLkRa-001cuI-OB; Tue, 18 Jul 2023 15:08:46 +0200
Date: Tue, 18 Jul 2023 15:08:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 2/2] net: stmmac: platform: add support for
 phy-supply
Message-ID: <427214fb-6206-47b3-bf5b-8b1cfc8b7677@lunn.ch>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
 <accc8d89-7565-460e-a874-a491b755bbb8@lunn.ch>
 <20230718083504.r3znx6iixtq7vkjt@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718083504.r3znx6iixtq7vkjt@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 10:35:04AM +0200, Marco Felsch wrote:
> On 23-07-18, Andrew Lunn wrote:
> > On Mon, Jul 17, 2023 at 06:43:07PM +0200, Marco Felsch wrote:
> > > Add generic phy-supply handling support to control the phy regulator.
> > > Use the common stmmac_platform code path so all drivers using
> > > stmmac_probe_config_dt() and stmmac_pltfr_pm_ops can use it.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 51 +++++++++++++++++++
> > >  include/linux/stmmac.h                        |  1 +
> > >  2 files changed, 52 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > index eb0b2898daa3d..6193d42b53fb7 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > @@ -10,6 +10,7 @@
> > >  
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/module.h>
> > >  #include <linux/io.h>
> > >  #include <linux/of.h>
> > > @@ -423,6 +424,15 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> > >  	if (plat->interface < 0)
> > >  		plat->interface = plat->phy_interface;
> > >  
> > > +	/* Optional regulator for PHY */
> > > +	plat->phy_regulator = devm_regulator_get_optional(&pdev->dev, "phy");
> > > +	if (IS_ERR(plat->phy_regulator)) {
> > > +		if (PTR_ERR(plat->phy_regulator) == -EPROBE_DEFER)
> > > +			return ERR_CAST(plat->phy_regulator);
> > > +		dev_info(&pdev->dev, "No regulator found\n");
> > > +		plat->phy_regulator = NULL;
> > > +	}
> > > +
> > 
> > So this gets the regulator. When do you actually turn it on?
> 
> During the suspend/resume logic like the rockchip, sun8i platform
> integrations did.

So you are assuming the boot loader has turned it on?

You also might have a difference between the actual state, and what
kernel thinks the state is, depending on how the regulator is
implemented.

It would be better to explicitly turn it on before registering the
MDIO bus.

     Andrew

