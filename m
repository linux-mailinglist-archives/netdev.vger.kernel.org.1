Return-Path: <netdev+bounces-57252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35365812A16
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9471C21494
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B60815EBE;
	Thu, 14 Dec 2023 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iW27MZ1o"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F19B9;
	Thu, 14 Dec 2023 00:13:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24D051BF208;
	Thu, 14 Dec 2023 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702541619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=918QXmxDoYw2xE4vLcNGnBHlNQLb9uIGqiZk+0P2Gb4=;
	b=iW27MZ1oF888oSOq0iGD14rEt/3CBitlyXCxys4w4DVwxopfO5TIwh+YLPKzS0BE3Ud+3e
	J4TK5PvaDsuRIytZjvhydGvnW1/HaZmrhujSTlknOvYyQMkvIfXODO/TL2pQhwJcuq54DY
	eLJSK1YmkjTbGEluoORg9o92kxQD9+sM2MRIZthSTG3GuCY3rAih88Snu6FIQRyTFRO1My
	0ye/8jEVj7bRsl3o4JHaM9hy4ClTUZW08W7x8MBjnVWNW+jr/mZsp2LPpozdm03JkBRRFC
	gHqSu6cYTNqCdBqwKBJ1fBbdlVM2ZcPxm6DD8m5dfdUyIkfY2nQc/XgaCB1FXg==
Date: Thu, 14 Dec 2023 09:13:58 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>, 
    Marek Vasut <marex@denx.de>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
    Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    kernel@pengutronix.de, linux-clk@vger.kernel.org, 
    Stephen Boyd <sboyd@kernel.org>, 
    Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
In-Reply-To: <ZNS8LEiuwsv660EC@shell.armlinux.org.uk>
Message-ID: <7aabc198-9df5-5bce-2968-90d4cda3c244@bootlin.com>
References: <20230804175842.209537-1-marex@denx.de> <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com> <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de> <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de> <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com> <20230809060836.GA13300@pengutronix.de> <ZNNRxY4z7HroDurv@shell.armlinux.org.uk> <ZNS8LEiuwsv660EC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com


Hello Russell,

On Thu, 10 Aug 2023, Russell King (Oracle) wrote:

> > We've had these issues before with stmmac, so this "stmmac needs the
> > PHY receive clock" is nothing new - it's had problems with system
> > suspend/resume in the past, and I've made suggestions... and when
> > there's been two people trying to work on it, I've attempted to get
> > them to talk to each other which resulted in nothing further
> > happening.
> > 
> > Another solution could possibly be that we reserve bit 30 on the
> > PHY dev_flags to indicate that the receive clock must always be
> > provided. I suspect that would have an advantage in another
> ...
> 
> Something like this for starters:
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> ...

I've implemented and tested the general-case solution you proposed to this 
receive clock issue with stmmac drivers. The core of your suggestion is pretty 
much unchanged, I just added a phylink_pcs flag for standalone PCS drivers that 
also need to provide the receive clock.

I'd like to send a series for this upstream, which would allow solving this 
issue for both the DWMAC RZN1 case and the AT803x PHY suspend/hibernate case 
(and also potentially other cases with a similar bug).

I wanted to ask you how you would prefer to be credited in my patch series. I 
was considering putting you as author and first signer of the initial patch 
adding the phy_dev flag. Would that be okay or would you prefer something else?

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

