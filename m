Return-Path: <netdev+bounces-57306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF2812D46
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF831F216DD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7783C47C;
	Thu, 14 Dec 2023 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gdJb6R5B"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05810F;
	Thu, 14 Dec 2023 02:46:26 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 30EB287A56;
	Thu, 14 Dec 2023 11:46:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702550784;
	bh=QK41F+nrgWYDV5GWhRCrs+yAIprn1BflMhkQG/nK5OA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gdJb6R5BjXjt8TPGgIRi0CTz68Zf3pEPTs6G5Qg1WnJW7B+pR9+sSbgfXcChFzQmb
	 89QdZOhDqNYwhcoq0SI3325fU8dpDfrmfLgW4LjmNi6vTIrOMtnvmGvKeaAodQGMAf
	 DNPmg1BC/KK+WjIs9T9n0tCa7FvEhXkqfKc3IjK3lZjCVejyFNWhzADlfZZMcgVcUx
	 5NsYfzGr0ogxpddD3NXn7uUc7naj9LUZ79QPSJZnGhBRvMN0tacQmgjxDTt5MQ1Vp7
	 P4XNH+2spgNHFrQtD7x4EajN72Mbm2nUs57TjGfnhX3asRRy0rM9hOTO4rhoDsKR0F
	 KcrHfBKv/wSzQ==
Message-ID: <788c4950-b03b-4a74-85e7-e81e8a815357@denx.de>
Date: Thu, 14 Dec 2023 11:46:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
To: Romain Gantois <romain.gantois@bootlin.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, linux-clk@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7aabc198-9df5-5bce-2968-90d4cda3c244@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/14/23 09:13, Romain Gantois wrote:
> 
> Hello Russell,
> 
> On Thu, 10 Aug 2023, Russell King (Oracle) wrote:
> 
>>> We've had these issues before with stmmac, so this "stmmac needs the
>>> PHY receive clock" is nothing new - it's had problems with system
>>> suspend/resume in the past, and I've made suggestions... and when
>>> there's been two people trying to work on it, I've attempted to get
>>> them to talk to each other which resulted in nothing further
>>> happening.
>>>
>>> Another solution could possibly be that we reserve bit 30 on the
>>> PHY dev_flags to indicate that the receive clock must always be
>>> provided. I suspect that would have an advantage in another
>> ...
>>
>> Something like this for starters:
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> ...
> 
> I've implemented and tested the general-case solution you proposed to this
> receive clock issue with stmmac drivers. The core of your suggestion is pretty
> much unchanged, I just added a phylink_pcs flag for standalone PCS drivers that
> also need to provide the receive clock.
> 
> I'd like to send a series for this upstream, which would allow solving this
> issue for both the DWMAC RZN1 case and the AT803x PHY suspend/hibernate case
> (and also potentially other cases with a similar bug).
> 
> I wanted to ask you how you would prefer to be credited in my patch series. I
> was considering putting you as author and first signer of the initial patch
> adding the phy_dev flag. Would that be okay or would you prefer something else?

Credit it whichever way you see fit, don't worry, better focus on the 
fix. I can test the result on MX8MM/MX8MP, so feel free to CC me on that.

