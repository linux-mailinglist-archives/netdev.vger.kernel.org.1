Return-Path: <netdev+bounces-62086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633D825A5E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 19:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B82B20FB4
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747E31A60;
	Fri,  5 Jan 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="NlvAxcEb"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458F35EE1
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58FB11C0002;
	Fri,  5 Jan 2024 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704480216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IucbeToo9eDO0lrvu3QxJEp1bQd5fNc6PePyPtOhF3s=;
	b=NlvAxcEbVUqz8W4gqEiLU7lKIQtvXkry9qvLqUj/Yd/4Obi8WSI1A9dw3qID4bl/tnHd5v
	P8lj1qSRuzok5pa1PswfZj6nKucTZCix+bThtpGNZ9Cru1JFGY2uJGcDKUSzep7f2z1RfF
	nDO/W9lr+msk+Cs7bQRyca1J10CH7i5QgzeC81psMyRSf+k4rBWtoreIsDP//ODn0N63xL
	LDiWJ9EjJ68qQS/n8LvTxsbeaIIjWtGNnYkKLRPtdlBhGGa/ZTQnjpYhZimv8+3bnOlHTO
	ZHQo3DsJpWboGvJE8/S1v87dtmzhnrZVk7XwGzp6jvEhSSCtGHCV1AhnduY4Vw==
Message-ID: <467b56ec-ecc1-4d76-bc00-b78e844b6a61@arinc9.com>
Date: Fri, 5 Jan 2024 21:43:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, linus.walleij@linaro.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
 <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
 <20231222104831.js4xiwdklazytgeu@skbuf>
 <461d86e8-21db-47fc-a878-7c532a592ac7@arinc9.com>
 <20240103184459.dcbh57wdnlox6w7d@skbuf>
Content-Language: en-US
In-Reply-To: <20240103184459.dcbh57wdnlox6w7d@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 3.01.2024 21:44, Vladimir Oltean wrote:
> On Fri, Dec 22, 2023 at 07:56:48PM +0300, Arınç ÜNAL wrote:
>> We should also align all DSA subdrivers with this understanding. I will
>> modify the MDIO bus patch I submitted for the MT7530 DSA subdriver
>> accordingly.
> 
> I began working on this, and I do have some patches. But returns start
> to diminish very quickly. Some drivers are just not worth it to change.
> So I will also respin the documentation patch set to at least advise to
> not continue the pattern to new drivers.

I've seen your patch series regarding this. I like that you've thought to
skip registering the bus if its node is explicitly disabled. I will
implement that on the MT7530 subdriver as well.

> 
>> I was wondering of moving the MDIO bus registration from DSA subdrivers to
>> the DSA core driver but probably it's not generic enough across switch
>> models with multiple MDIO buses and whatnot to manage this.
> 
> Actually this is the logic after which everything starts to unravel -
> "multiple DSA switches have internal MDIO buses, so let's make DSA
> assist with their registration".
> 
> If you can't do a good job at it, it's more honest to not even try -
> and you gave the perfect example of handling multiple internal MDIO buses.

Makes sense. Setting the interrupts is another good example. Currently, DSA
registers the bus non-OF-based but won't set the interrupts, as far as I
can see.

> 
> I just don't want to maintain stuff that I am really clueless about.
> If registering an MDIO bus is so hard that DSA has to help with it,
> make the MDIO API better.
> 
> Where things would be comfortable for me is if the optional ds->user_mii_bus
> pointer could be always provided by individual subdrivers, and never allocated
> by the framework. So that dsa_switch_ops :: phy_read() and :: phy_write()
> would not exist at all.

I agree. Why don't we do this? These are the subdrivers that we need to
deal with before getting rid of dsa_switch_ops :: phy_read() and ::
phy_write(), and the code block for registering the MDIO bus on the DSA
core driver:

drivers/net/dsa/b53/b53_common.c:
- The DSA subdriver lets the DSA driver register the bus.

drivers/net/dsa/microchip/ksz_common.c:
- The DSA subdriver lets the DSA driver register the bus when "mdio" child
   node is not defined.

drivers/net/dsa/realtek/realtek-mdio.c:
- The DSA subdriver lets the DSA driver register the bus.

This won't be the case after "[PATCH net-next v3 0/8] net: dsa: realtek:
variants to drivers, interfaces to a common module" is applied.

drivers/net/dsa/lan9303-core.c:
- The DSA subdriver lets the DSA driver register the bus.

drivers/net/dsa/vitesse-vsc73xx-core.c:
- The DSA subdriver lets the DSA driver register the bus.

All these subdrivers populate dsa_switch_ops :: phy_read() and ::
phy_write() and won't populate ds->user_mii_bus.

Arınç

