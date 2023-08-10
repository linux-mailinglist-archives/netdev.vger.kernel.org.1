Return-Path: <netdev+bounces-26110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE804776D38
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 02:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A884B281899
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74756632;
	Thu, 10 Aug 2023 00:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946737B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 00:49:59 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA051C9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:49:58 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 180FC84698;
	Thu, 10 Aug 2023 02:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1691628596;
	bh=OMIIFFJqxb1PVgbx8QdhZiu6Hzg8Gi3gJ1SPfK5eysk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=poIZaVlAUSUCRQOB/EARUHUL3+R+WBT9MJoK1RUKto+YeR3Vjx3nDKURA6DAVQ7UK
	 Jafp1FaWRMdU6XmdSrpaw0NwWK7eo2RKs4LWoUOBGT8dsofgStTNrtINSll38TK4jA
	 YNGdaC7cQevib2Gnzqm+yvdhBkYd5N4MWArHac7+s4d25EqBReBkm2pjbZoMbYFjUW
	 vbmf+IFyEaXLougJ7q0Wnpj1G3wFcVLoRhVgHufElnPm6cVTiv/XaslQ2aIvLRGTlu
	 ol3dCS8zmJmf544Y4FrjefZyaycX2sEyZb6m0JBdffVS7LawafVAI+8rDgc/IncU5k
	 iSBF5PUaBknog==
Message-ID: <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
Date: Thu, 10 Aug 2023 02:49:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
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
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 00:06, Andrew Lunn wrote:
> On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
>> On 8/9/23 15:40, Andrew Lunn wrote:
>>>>> Hm.. how about officially defining this PHY as the clock provider and disable
>>>>> PHY automatic hibernation as long as clock is acquired?
>>>>>
>>>> Sorry, I don't know much about the clock provider/consumer, but I think there
>>>> will be more changes if we use clock provider/consume mechanism.
>>>
>>> Less changes is not always best. What happens when a different PHY is
>>> used?
>>
>> Then the system wouldn't be affected by this AR803x specific behavior.
> 
> Do you know it really is specific to the AR803x? Turning the clock off
> seams a reasonable thing to do when saving power, or when there is no
> link partner.

This hibernation behavior seem specific to this PHY, I haven't seen it 
on another PHY connected to the EQoS so far.

