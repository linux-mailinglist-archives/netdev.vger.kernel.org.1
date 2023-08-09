Return-Path: <netdev+bounces-26078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57773776BDC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F9C281E54
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D11DDD2;
	Wed,  9 Aug 2023 22:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106D1DDD1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:06:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003EF2132
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rjaCtvaOV60nxelceMCRpjKmzZl4PEr7sGDOWIslcYs=; b=WTrJ7tCqXOsm3Th+kRbenHKhE7
	8eVNXuEHd5WidjP6vqY1r22zkIPRGQPHNIs6aifQ/4/P3pqo0ksRRRUlW6QtY/N5l2zcyLTiRr58a
	36BHg3udBxvxo2GOzbERNO249gMZykXeyp0gvFi8e3GCW0RPiGg2SJKgcDznsEtsWr3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTrJc-003ciM-Od; Thu, 10 Aug 2023 00:06:04 +0200
Date: Thu, 10 Aug 2023 00:06:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: Wei Fang <wei.fang@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> On 8/9/23 15:40, Andrew Lunn wrote:
> > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > PHY automatic hibernation as long as clock is acquired?
> > > > 
> > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > will be more changes if we use clock provider/consume mechanism.
> > 
> > Less changes is not always best. What happens when a different PHY is
> > used?
> 
> Then the system wouldn't be affected by this AR803x specific behavior.

Do you know it really is specific to the AR803x? Turning the clock off
seams a reasonable thing to do when saving power, or when there is no
link partner.

     Andrew

