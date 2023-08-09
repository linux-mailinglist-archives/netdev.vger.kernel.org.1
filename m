Return-Path: <netdev+bounces-26057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E86776B05
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA07C281D9F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889C1DA3E;
	Wed,  9 Aug 2023 21:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77324512
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:34:24 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC81BD9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:34:23 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 35D6D847D9;
	Wed,  9 Aug 2023 23:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1691616861;
	bh=SQ2gMbZkFtP4ProycxTU4dLT6hG6sGL/5lHN3vzhHGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BPASzPw+AlNTg7SkTts0EmR+WCiXleKLpYLAio8ftvbK9LdYbODBkd0efFS8hu1D4
	 3yc4iyl/rYBDCanSc2Oea92+heqtbPQYkCFIssVDvAS8l4qjA/MoqUkct8EaRaY/P3
	 b01mv5HnxA4YKbEVQtJTiv3YWlsQqZsF4es4Yj267Ly9+rpaP6qo43Y+dDTSHe4sVj
	 aF4O2aFlaIqDQlNNfMub3vR5MKIZ1cG6T7Zx0YVROBlVQ8I8IDpEQMhgfDHrd5z47I
	 VnqHN3z4/8rxuY6YpRevqum4yUceyaCN0YkxjhQVdQMDIb+PDn068BoNb8qQEdJU4K
	 GDUKUGfGb06VQ==
Message-ID: <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
Date: Wed, 9 Aug 2023 23:34:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 15:40, Andrew Lunn wrote:
>>> Hm.. how about officially defining this PHY as the clock provider and disable
>>> PHY automatic hibernation as long as clock is acquired?
>>>
>> Sorry, I don't know much about the clock provider/consumer, but I think there
>> will be more changes if we use clock provider/consume mechanism.
> 
> Less changes is not always best. What happens when a different PHY is
> used?

Then the system wouldn't be affected by this AR803x specific behavior.

> By having a clock provider in the PHY, you are defining a clear
> API that any PHY needs to provide to work with this MAC.
> 
> As Russell has point out, this is not the first time we have run into
> this problem. So far, it seems everybody has tried to solve it for
> just their system. So maybe now we should look at the whole picture
> and put in place a generic solution which can be made to work for any
> PHY.

I'll see what I can do, it might take a while though.

