Return-Path: <netdev+bounces-50695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0F7F6BA2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 06:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA3D1C20A20
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 05:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E710F7;
	Fri, 24 Nov 2023 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kjA1bjt2"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ABFD67;
	Thu, 23 Nov 2023 21:19:46 -0800 (PST)
Received: from [192.168.1.107] (89-186-112-232.pool.digikabel.hu [89.186.112.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1FC5C86784;
	Fri, 24 Nov 2023 06:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700803185;
	bh=cbGSSLqzCpPuOWvJ0QPwkBshw6fJciT5hJmiJ3Px9vc=;
	h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=kjA1bjt2yZ4b1H6I96ceqcWX5ID+LD8AzoVzoVrsC/nocmeG6PwHsroQqxiYuVKC+
	 DIzR/Rc8UDkjm6mHWmpnxxIX1bKCS6GaCJVtEFJ84i6SLvSwQz9BJdypQTyhIpWm0H
	 ErsJVdwUGUSyLGeQjML+0hJmfbdAhm9FlwhjiBz8a1Iuo5JYkQNStgVutFcHtrm7P8
	 NqBAGnUxX4zo2nrOOKTr7RR3xNyqKO1EZ5U05D2YaBP2+jlPPj06PGr019nVLBID9X
	 UMFa2j3J25QdH0SWyRTVu+kInZCz6FvgS84azzkW5+elCtEvnTYSup15UxJwmNyL49
	 cA/+jEi4Ed+Lg==
Reply-To: hs@denx.de
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
To: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiko Schocher <heiko.schocher@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
References: <20231123132744.62519-1-hs@denx.de>
 <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
 <AM5PR04MB313982936800424F9B2E660688B8A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <227dc52c-c555-34e4-d534-1a749af15425@denx.de>
Date: Fri, 24 Nov 2023 06:19:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AM5PR04MB313982936800424F9B2E660688B8A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Wei,

On 24.11.23 03:33, Wei Fang wrote:
>> -----Original Message-----
>> From: Andrew Lunn <andrew@lunn.ch>
>> Sent: 2023Äê11ÔÂ24ÈÕ 4:09
>> To: Heiko Schocher <heiko.schocher@gmail.com>
>> Cc: netdev@vger.kernel.org; Heiko Schocher <hs@denx.de>; Clark Wang
>> <xiaoning.wang@nxp.com>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> dl-linux-imx <linux-imx@nxp.com>; Paolo Abeni <pabeni@redhat.com>;
>> Shenwei Wang <shenwei.wang@nxp.com>; Wei Fang <wei.fang@nxp.com>;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
>>
>> On Thu, Nov 23, 2023 at 02:27:43PM +0100, Heiko Schocher wrote:
>>> it is possible that fec1 is probed before fec0. On SoCs with
>>> FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii from fec0) init
>>> of mii fails for fec1 when fec0 is not yet probed, as fec0 setups mii
>>> bus. In this case fec_enet_mii_init for fec1 returns with -ENODEV, and
>>> so fec1 never comes up.
>>>
>>> Return here with -EPROBE_DEFER so interface gets later probed again.
>>>
>>> Found this on imx8qxp based board, using 2 ethernet interfaces, and
>>> from time to time, fec1 interface came not up.
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>> ---
>>>
>>>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>>> b/drivers/net/ethernet/freescale/fec_main.c
>>> index c3b7694a7485..d956f95e7a65 100644
>>> --- a/drivers/net/ethernet/freescale/fec_main.c
>>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>>> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct
>> platform_device *pdev)
>>>  			mii_cnt++;
>>>  			return 0;
>>>  		}
>>> -		return -ENOENT;
>>> +		return -EPROBE_DEFER;
>>
>> I think this has been tried before.
>>
> Yes, there was indeed a similar patch [1] before. but this issue seems to only exist
> in downstream tree, because there is a local patch which is not in the upstream.
> 
>         /* board only enable one mii bus in default */
>         if (!of_get_property(np, "fsl,mii-exclusive", NULL))
>                 fep->quirks |= FEC_QUIRK_SINGLE_MDIO;

Yes, sorry for overseeing this ... but there are SoCs in upstream which
set FEC_QUIRK_SINGLE_MDIO and so mii bus from for example fec0 is used on
other fecX devices, correct?

And for them probing currently fail, when probed before fec0.

> I will think about how to solve this issue in downstream if I'm free later.
> 
> [1] https://lore.kernel.org/lkml/20230208101821.871269-1-alexander.sverdlin@siemens.com/T/#r6313852054bf12baabe21418584fbb6d58343197

Hmm.. simply deferring the probe to later point solves the problem here.

I added Alexander may he can comment...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

