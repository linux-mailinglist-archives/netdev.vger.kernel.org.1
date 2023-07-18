Return-Path: <netdev+bounces-18597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C7757D0E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8041C20C5D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031CC8FF;
	Tue, 18 Jul 2023 13:15:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB2C8C6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:15:35 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153CB0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 06:15:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qLkXq-00057f-Ex; Tue, 18 Jul 2023 15:15:14 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1qLkXi-0002h3-Rr; Tue, 18 Jul 2023 15:15:06 +0200
Date: Tue, 18 Jul 2023 15:15:06 +0200
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
Message-ID: <20230718131506.ro2o45qhggykwhwc@pengutronix.de>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
 <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
 <20230718083841.p67wflhjlwnu56j4@pengutronix.de>
 <9214ae14-b501-4d94-9d52-fd7dab2a86af@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9214ae14-b501-4d94-9d52-fd7dab2a86af@lunn.ch>
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
> On Tue, Jul 18, 2023 at 10:38:41AM +0200, Marco Felsch wrote:
> > On 23-07-18, Andrew Lunn wrote:
> > > > +static int stmmac_phy_power(struct platform_device *pdev,
> > > > +			    struct plat_stmmacenet_data *plat,
> > > > +			    bool enable)
> > > > +{
> > > > +	struct regulator *regulator = plat->phy_regulator;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (regulator) {
> > > > +		if (enable)
> > > > +			ret = regulator_enable(regulator);
> > > > +		else
> > > > +			regulator_disable(regulator);
> > > > +	}
> > > > +
> > > > +	if (ret)
> > > > +		dev_err(&pdev->dev, "Fail to enable regulator\n");
> > > 
> > > 'enable' is only correct 50% of the time.
> > 
> > You mean to move it under the enable path.
> 
> Or don't use the word 'enable'. 'modify' ?

I changed it but kept the 'enable'.

> > Good point didn't consider WOL. Is there a way to check if WOL is
> > enabled?
> 
> Yes, plenty of MAC drivers do this. Look around.

Yep, checked the code and found the interesting parts :) Thanks for the
hint.

Regards,
  Marco

