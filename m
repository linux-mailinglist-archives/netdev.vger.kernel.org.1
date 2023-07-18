Return-Path: <netdev+bounces-18510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C47576C7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB04D281436
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C390F538C;
	Tue, 18 Jul 2023 08:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865C1FA9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:38:56 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E3135
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:38:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qLgEE-0003ai-SD; Tue, 18 Jul 2023 10:38:42 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qLgED-0004fO-Eo; Tue, 18 Jul 2023 10:38:41 +0200
Date: Tue, 18 Jul 2023 10:38:41 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20230718083841.p67wflhjlwnu56j4@pengutronix.de>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
 <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23-07-18, Andrew Lunn wrote:
> > +static int stmmac_phy_power(struct platform_device *pdev,
> > +			    struct plat_stmmacenet_data *plat,
> > +			    bool enable)
> > +{
> > +	struct regulator *regulator = plat->phy_regulator;
> > +	int ret = 0;
> > +
> > +	if (regulator) {
> > +		if (enable)
> > +			ret = regulator_enable(regulator);
> > +		else
> > +			regulator_disable(regulator);
> > +	}
> > +
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Fail to enable regulator\n");
> 
> 'enable' is only correct 50% of the time.

You mean to move it under the enable path.

> > @@ -742,6 +786,8 @@ static int __maybe_unused stmmac_pltfr_suspend(struct device *dev)
> >  	if (priv->plat->exit)
> >  		priv->plat->exit(pdev, priv->plat->bsp_priv);
> >  
> > +	stmmac_phy_power_off(pdev, priv->plat);
> > +
> 
> What about WOL? You probably want to leave the PHY with power in that
> case.

Good point didn't consider WOL. Is there a way to check if WOL is
enabled?

Regards,
  Marco

> 
> > @@ -757,6 +803,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
> >  	struct net_device *ndev = dev_get_drvdata(dev);
> >  	struct stmmac_priv *priv = netdev_priv(ndev);
> >  	struct platform_device *pdev = to_platform_device(dev);
> > +	int ret;
> > +
> > +	ret = stmmac_phy_power_on(pdev, priv->plat);
> > +	if (ret)
> > +		return ret;
> 
> And this needs to balance with _suspend when WOL is being used.
> 
>     Andrew
> 

