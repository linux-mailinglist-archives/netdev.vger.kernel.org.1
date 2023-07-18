Return-Path: <netdev+bounces-18596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC3757CEE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC05C1C20CCA
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DFC8F7;
	Tue, 18 Jul 2023 13:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60184C8C6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:10:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6AC170D;
	Tue, 18 Jul 2023 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZObdJe8z/FH7zyHM59qxcKSRiK8MNQZG6bz1KjetFWc=; b=bGSb5YgyK1ofKeyANqnrfWiqLC
	DunnFcwfGSxCdPLD3qDwwGLCxZscB1JWxVai2j/EBpGbjtLA1LxBqwnuMz9Fuj14fatVofdQGOcXR
	Hwf2ATdxNjd+iLwFzCe7lKFiw7Zeeg/tdGOC6wda1EHC3F4y4XN0A9BjoTzEXPyXXK8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLkT1-001cvq-KC; Tue, 18 Jul 2023 15:10:15 +0200
Date: Tue, 18 Jul 2023 15:10:15 +0200
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
Message-ID: <9214ae14-b501-4d94-9d52-fd7dab2a86af@lunn.ch>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
 <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
 <20230718083841.p67wflhjlwnu56j4@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718083841.p67wflhjlwnu56j4@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 10:38:41AM +0200, Marco Felsch wrote:
> On 23-07-18, Andrew Lunn wrote:
> > > +static int stmmac_phy_power(struct platform_device *pdev,
> > > +			    struct plat_stmmacenet_data *plat,
> > > +			    bool enable)
> > > +{
> > > +	struct regulator *regulator = plat->phy_regulator;
> > > +	int ret = 0;
> > > +
> > > +	if (regulator) {
> > > +		if (enable)
> > > +			ret = regulator_enable(regulator);
> > > +		else
> > > +			regulator_disable(regulator);
> > > +	}
> > > +
> > > +	if (ret)
> > > +		dev_err(&pdev->dev, "Fail to enable regulator\n");
> > 
> > 'enable' is only correct 50% of the time.
> 
> You mean to move it under the enable path.

Or don't use the word 'enable'. 'modify' ?

> Good point didn't consider WOL. Is there a way to check if WOL is
> enabled?

Yes, plenty of MAC drivers do this. Look around.

     Andrew

