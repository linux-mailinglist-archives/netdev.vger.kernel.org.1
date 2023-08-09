Return-Path: <netdev+bounces-25893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE35776166
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A19281BC0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0494018C21;
	Wed,  9 Aug 2023 13:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C75612D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:40:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774B62109
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jcvsC6enBq1FXz4Pj6fUIeo6RCQqqeW3btRiWTDZ3tk=; b=vsw/2m7KFgk8wQeVp3dgxb9YIa
	bo9OgIOmUZ3Sn9HWldU0bEiGp1QmGzkL1qTKxY+amJmW8Z+VxH3vQOeOU6GQm0kg3Ps6FYFAyGO7p
	oR/RKwPduClgJ6YRMoUcF2FMCNutJLVm8ASkW1Zo1qU3Nl7lWOitO6s8QivNMIg46X94=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTjQe-003aJp-RZ; Wed, 09 Aug 2023 15:40:48 +0200
Date: Wed, 9 Aug 2023 15:40:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Hm.. how about officially defining this PHY as the clock provider and disable
> > PHY automatic hibernation as long as clock is acquired?
> > 
> Sorry, I don't know much about the clock provider/consumer, but I think there
> will be more changes if we use clock provider/consume mechanism.

Less changes is not always best. What happens when a different PHY is
used? By having a clock provider in the PHY, you are defining a clear
API that any PHY needs to provide to work with this MAC.

As Russell has point out, this is not the first time we have run into
this problem. So far, it seems everybody has tried to solve it for
just their system. So maybe now we should look at the whole picture
and put in place a generic solution which can be made to work for any
PHY.

    Andrew

