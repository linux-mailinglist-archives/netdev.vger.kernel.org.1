Return-Path: <netdev+bounces-57568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2D8136B4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959192811BA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C264460BB2;
	Thu, 14 Dec 2023 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ykNWUMcT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5F8E;
	Thu, 14 Dec 2023 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jpEgcy8NN3HTStEB0Wx38X+kWFgy54/SSxE7weirF/E=; b=ykNWUMcT36CU8ETNnUBdAfU5Di
	DdbbhgKydxhHANMjCciNJr98L8meROJk0TARR4eSpvc0QjNauXChKS9k/5RgLtTgmReaGbOzh/gQs
	UB+HHTwT2uI5MnX919RNy3rtpS0rtfqnAU1OWGoy4D+JdqYWp4AFF+7z3jiTAXaCa8/IkY2WaZ5Kv
	9a/3mNXm+y5GwXuFJVgTJvqJmi/S+p9PB0YwIa2mPnjLD5rdHkQB9TLOJAeT5d9m5Vqzk6aLmANKh
	ANoL90HggfZf6QWBokdy6F/zsFD5mNiv6PdbmO9yG96k/zN3kwqFVaMdCwIvB5vFjK2kGNmGWOoEY
	Ew0OAhsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49794)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDotX-0001hF-1F;
	Thu, 14 Dec 2023 16:49:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDotX-0002h8-FN; Thu, 14 Dec 2023 16:49:07 +0000
Date: Thu, 14 Dec 2023 16:49:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
	Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-clk@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZXsyA+2USrmIaF3u@shell.armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809060836.GA13300@pengutronix.de>
 <ZNNRxY4z7HroDurv@shell.armlinux.org.uk>
 <ZNS8LEiuwsv660EC@shell.armlinux.org.uk>
 <7aabc198-9df5-5bce-2968-90d4cda3c244@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aabc198-9df5-5bce-2968-90d4cda3c244@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 09:13:58AM +0100, Romain Gantois wrote:
> Hello Russell,
> 
> I've implemented and tested the general-case solution you proposed to this 
> receive clock issue with stmmac drivers. The core of your suggestion is pretty 
> much unchanged, I just added a phylink_pcs flag for standalone PCS drivers that 
> also need to provide the receive clock.

So this affects the ability of PCS to operate correctly as well as MACs?
Would you enlighten which PCS are affected, and what PCS <--> PHY link
modes this is required for?

> I'd like to send a series for this upstream, which would allow solving this 
> issue for both the DWMAC RZN1 case and the AT803x PHY suspend/hibernate case 
> (and also potentially other cases with a similar bug).
> 
> I wanted to ask you how you would prefer to be credited in my patch series. I 
> was considering putting you as author and first signer of the initial patch 
> adding the phy_dev flag. Would that be okay or would you prefer something else?

It depends how big the changes are from my patches. If more than 50% of
the patch remains my work, please retain my authorship. If you wish to
also indicate your authorship, then there is a mechanism to do that -
Co-developed-by: from submitting-patches.rst:

Co-developed-by: states that the patch was co-created by multiple
developers; it is used to give attribution to co-authors (in addition
to the author attributed by the From: tag) when several people work on
a single patch. Since Co-developed-by: denotes authorship, every
Co-developed-by: must be immediately followed by a Signed-off-by: of
the associated co-author.

See submitting-patches.rst for examples of the ordering of the
attributations.

Thanks for asking.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

