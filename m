Return-Path: <netdev+bounces-59944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748781CD5B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139EF1F22F0C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2A24B5D;
	Fri, 22 Dec 2023 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="PfLQvdsF"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3F28DA5
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBEC7E0002;
	Fri, 22 Dec 2023 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703264217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhhqAqsBJwBedqKyVQRdHpU7N9vMH9jiJb/eK7IItZo=;
	b=PfLQvdsF9otELgB7RsMok7cCa9drXWub1ro0EPMft0gqFAYyAZFjCI6p3/1X2zY8mC/tQf
	an2PtC3DUF70USlGBVxNK18pnnXE6vXzQbXXlVIK0tvD+mVvHR/nCmvU7uRT+M6QcsWjiz
	WjgcNt/sYkSIztsAe3WYGwIO72pf+nKTbrNohUbsXWYPOS136sXiy2o2Qb2r+c0qPChhbq
	+KvfKLh+GsAyOr5fSYkqWqRCRzJTTFbWS9dnlckfyjw7gRtcY5JwyNyxgNIRp/Rr/R/6se
	9rcUQIsoczQBzR47ED/8naTz/NasWbkeGl7RA2nELxX9v0aNxwQ1EkQ/+NUrHA==
Message-ID: <461d86e8-21db-47fc-a878-7c532a592ac7@arinc9.com>
Date: Fri, 22 Dec 2023 19:56:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231222104831.js4xiwdklazytgeu@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 22.12.2023 13:48, Vladimir Oltean wrote:
> On Thu, Dec 21, 2023 at 09:34:52PM +0300, Arınç ÜNAL wrote:
>> On 21.12.2023 20:47, Vladimir Oltean wrote:
>>> ds->user_mii_bus helps when
>>> (1) the switch probes with platform_data (not on OF), or
>>> (2) the switch probes on OF but its MDIO bus is not described in OF
>>>
>>> Case (2) is also eliminated because realtek_smi_setup_mdio() bails out
>>> if it cannot find the "mdio" node described in OF. So the ds->user_mii_bus
>>> assignment is only ever executed when the bus has an OF node, aka when
>>> it is not useful.
>>
>> I don't like the fact that the driver bails out if it doesn't find the
>> "mdio" child node. This basically forces the hardware design to use the
>> MDIO bus of the switch. Hardware designs which don't use the MDIO bus of
>> the switch are perfectly valid.
>>
>> It looks to me that, to make all types of hardware designs work, we must
>> not use ds->user_mii_bus for switch probes on OF. Case (2) is one of the
>> cases of the ethernet controller lacking link definitions in OF so we
>> should enforce link definitions on ethernet controllers. This way, we make
>> sure all types of hardware designs work and are described in OF properly.
>>
>> Arınç
> 
> The bindings for the realtek switches can be extended in compatible ways,
> e.g. by making the 'mdio' node optional. If we want that to mean "there
> is no internal PHY that needs to be used", there is no better time than
> now to drop the driver's linkage to ds->user_mii_bus, while its bindings
> still strictly require an 'mdio' node.

"There is no internal PHY that needs to be used" is not the right statement
for all cases. The internal PHYs can be wired to another MDIO bus or they
may be described as fixed-link which would mean using the MDIO bus to read
link information from the PHYs becomes unnecessary. These may be very rare
hardware designs to come across but they are valid hardware descriptions in
OF. So "the MDIO bus of the switch is not being used for the purpose of
reading/writing from/to the PHYs (and not necessarily internal PHYs)" is
the correct statement.

> 
> If we don't drop that linkage _before_ making 'mdio' optional, there
> is no way to disprove the existence of device trees which lack a link
> description on user ports (which is now possible). So the driver will
> always have to pay the penalty of mdiobus_register(ds->user_mii_bus),
> which will always enumerate the internal PHYs even if they will end up
> unused, as you say should be possible. Listing the MDIO bus in OF
> deactivates bus scanning, which speeds up probing and booting in most
> cases.
> 
> There are other ways to reduce that PHY enumeration pain, like manually
> setting the bus->phy_mask and moving code around such that it gets
> executed only once in the presence of -EPROBE_DEFER. This is what Klaus
> Kudielka had to go through with mv88e6xxx, all because the Turris Omnia
> device tree lacks phy-handle to the internal PHYs, his boot time shot up
> by a wide margin.
> https://lore.kernel.org/lkml/449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com/
> commit 2c7e46edbd03 ("net: dsa: mv88e6xxx: mask apparently non-existing phys during probing")
> commit 2cb0658d4f88 ("net: dsa: mv88e6xxx: move call to mv88e6xxx_mdios_register()")
> 
> We support device trees with 'hidden' switch internal MDIO buses and it
> would be unwise to break them. But they are a self-inflicted pain and it
> would be even more unwise for me to go on record not discouraging their use.
> Honestly, I don't want any more of them.

Looks like with the direction you're suggesting here, we can enforce link
descriptions and, at the same time, support device trees with undescribed
switch MDIO bus on DSA. So I see all this as a step in the right direction.

So yeah, let's keep ds->user_mii_bus for switch probes on OF without the
switch MDIO bus defined, provided these switches have an MDIO bus.

We should also align all DSA subdrivers with this understanding. I will
modify the MDIO bus patch I submitted for the MT7530 DSA subdriver
accordingly.

I was wondering of moving the MDIO bus registration from DSA subdrivers to
the DSA core driver but probably it's not generic enough across switch
models with multiple MDIO buses and whatnot to manage this.

Arınç

