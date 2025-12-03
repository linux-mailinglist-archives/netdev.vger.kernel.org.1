Return-Path: <netdev+bounces-243473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29781CA1F5D
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 00:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25B330081B9
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118742EA154;
	Wed,  3 Dec 2025 23:35:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464732E1EE0;
	Wed,  3 Dec 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804928; cv=none; b=ucq46a+TeV2zK77JfxOwrGRrmTRwudqAr9A1CY/osYdM9LYGWrscDEErfKVRvoz+GfAKf9Bh5IRwu2DU1FCidvz4FLdcKSCWvARr6ceytT4QSHrRdDeO1DPbb/uzjjUEqzII6aAGaZWtM67jTpthv7aTTVMxL13Fy9HyZ5XEmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804928; c=relaxed/simple;
	bh=Cym3BY9tSmrn6zkUwrHMaHKx9XbGwGEjaBNljlwFkN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2tcvI1McFEplY5rrXQQnh7aiGzY8BE+0t23hfRG+gDsnRFQc/r6MnMtQphwgPQiMH9ctTTxiioXvlNfUnOaKJ+g3y/6smBDFnUmt+pijb5zysvQibx4ijstM0SzAWSOadsT3E7QgIEo0wEIzlz5LPbJUp6klq5gn6/k5uaq8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vQwNU-000000003oh-2l81;
	Wed, 03 Dec 2025 23:35:20 +0000
Date: Wed, 3 Dec 2025 23:35:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Subject: Re: [PATCH net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
Message-ID: <aTDJNvLR9evdCaDl@makrotopia.org>
References: <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
 <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
 <20251203094959.y7pkzo2wdhkajceg@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203094959.y7pkzo2wdhkajceg@skbuf>

On Wed, Dec 03, 2025 at 11:49:59AM +0200, Vladimir Oltean wrote:
> On Tue, Dec 02, 2025 at 09:57:21AM +0000, Daniel Golle wrote:
> > According to MaxLinear engineer Benny Weng the RX lane of the SerDes
> > port of the GSW1xx switches is inverted in hardware, and the
> > SGMII_PHY_RX0_CFG2_INVERT bit is set by default in order to compensate
> > for that. Hence also set the SGMII_PHY_RX0_CFG2_INVERT bit by default in
> > gsw1xx_pcs_reset().
> > 
> > Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> > Reported-by: Rasmus Villemoes <ravi@prevas.dk>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> 
> This shouldn't impact the generic device tree property work, since as
> stated there, there won't be any generically imposed default polarity if
> the device tree property is missing.
> 
> We can perhaps use this thread to continue a philosophical debate on how
> should the device tree deal with this situation of internally inverted
> polarities (what does PHY_POL_NORMAL mean: the observable behaviour at
> the external pins, or the hardware IP configuration?). I have more or
> less the same debate going on with the XPCS polarity as set by
> nxp_sja1105_sgmii_pma_config().

In this case it is really just a bug in the datasheet, because the
switch does set the GSW1XX_SGMII_PHY_RX0_CFG2_INVERT bit by default
after reset, which results in RX polarity to be as expected (ie.
negative and positive pins as labeled).

However, the driver was overwriting the register content which resulted
in the polarity being inverted (despite the fact that the
GSW1XX_SGMII_PHY_RX0_CFG2_INVERT wasn't set, because it is actually
inverted internally, which just isn't well documented).

> 
> But the patch itself seems fine regardless of these side discussions.

As net-next-6.19 has been tagged by now, should I resend the patch
via 'net' tree after the tag was merged?

> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> > Sent to net-next as the commit to be fixed is only in net-next.
> > 
> >  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> > index 0816c61a47f12..cf33a16fd183b 100644
> > --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> > +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> > @@ -255,10 +255,16 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
> >  	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
> >  			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
> >  
> > -	/* TODO: Take care of inverted RX pair once generic property is
> > +	/* RX lane seems to be inverted internally, so bit
> > +	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
> > +	 * (ie. non-inverted) operation.
> > +	 *
> > +	 * TODO: Take care of inverted RX pair once generic property is
> >  	 *       available
> >  	 */
> >  
> > +	val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
> > +
> >  	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
> >  	if (ret < 0)
> >  		return ret;
> > -- 
> > 2.52.0
> 

