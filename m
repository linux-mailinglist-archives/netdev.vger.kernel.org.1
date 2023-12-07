Return-Path: <netdev+bounces-54823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E908086B5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E49C283F1C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A637D27;
	Thu,  7 Dec 2023 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hKmLcNgG"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9110C3;
	Thu,  7 Dec 2023 03:27:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67271E0002;
	Thu,  7 Dec 2023 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701948438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkhKb9cna+Ui8j44O1HcDJ/iUVeFsHwWP3sKQpboDq8=;
	b=hKmLcNgG1Wz6oLkUF3olTFFphoSS+buonhnO6I+jekfB43jFFCevz8DZoyWcmaWlHAK/qI
	L/ldUATCqbPpsyUN/Ohb8Uz+3JtmVslehv80JbA//Ievye4Dl8GDy6w7Qi2im+HBbZDNIY
	xm0HYQRIoYBN3Is5ao/Zv2lZGQtibOQNf7Kx15ts649aNZOVfp5i9LXeVqBDxyc6E1bVKf
	VRCBgapMc21RwnrjhKYWY9q11ttKWmWAAQ77Z2fs2TpCkhXknmZlVgRLPsKgeU0uejHGof
	hN2+wZ2ZMlaOdQnCRIMjH1LFrJpLrZdKRMmZGtpx05rt9AQ5tWHODd0UuvCgHg==
Date: Thu, 7 Dec 2023 12:27:16 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: add support for mii
Message-ID: <20231207122716.7ff58c91@device.home>
In-Reply-To: <ZXGJXIK3cl/9lfKi@eichest-laptop>
References: <20231206160125.2383281-1-eichest@gmail.com>
	<20231206182705.3ff798ad@device.home>
	<ZXGJXIK3cl/9lfKi@eichest-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Stefan,

On Thu, 7 Dec 2023 10:01:08 +0100
Stefan Eichenberger <eichest@gmail.com> wrote:

> Hi Maxime,
> 
> On Wed, Dec 06, 2023 at 06:27:05PM +0100, Maxime Chevallier wrote:
> > > @@ -6973,6 +6988,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
> > >  				  port->phylink_config.supported_interfaces);
> > >  			__set_bit(PHY_INTERFACE_MODE_SGMII,
> > >  				  port->phylink_config.supported_interfaces);
> > > +		} else if (phy_mode == PHY_INTERFACE_MODE_MII) {
> > > +			__set_bit(PHY_INTERFACE_MODE_100BASEX,
> > > +				  port->phylink_config.supported_interfaces);  
> > 
> > Can you explain that part ? I don't understand why 100BaseX is being
> > reported as a supported mode here. This whole section of the function
> > is about detecting what can be reported based on the presence or not of
> > a comphy driver / hardcoded comphy config. I don't think the comphy
> > here has anything to do with MII / 100BaseX
> > 
> > If 100BaseX can be carried on MII (which I don't know), shouldn't it be
> > reported no matter what ?  
> 
> I missunderstood that part, I thought it is a translation from interface
> type to speed but it is obviously not. I already verfied that everything
> works without this part and will remove it in version 2 of the patch.
> Thanks a lot for the review!

No problem, thanks for the patch :)

Maxime



