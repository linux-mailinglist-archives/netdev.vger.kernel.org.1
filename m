Return-Path: <netdev+bounces-50043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED697F4763
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F37281123
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19A4C623;
	Wed, 22 Nov 2023 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAku3V2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AE7468
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3C5C433C8;
	Wed, 22 Nov 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700658606;
	bh=dkIU5IEXrA7RD3zIsXILtI5hnsR7Usk30FVXYR19dyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OAku3V2MZRR+lvSbO6CRYzbzUd/KyKk9Slp+61MLkLd2HK9DU0kWXdMkUaiXrsGKQ
	 samCY50xo6HrdvhHfTSyPC1hlxbb/UR4ydNb+h8xKk/4G+JC03m5eUWVedwFrUpU0o
	 n5oiSaPqMsylfAEvgVXot7d4Mf5wGYB54kVbr5xP4mcuGNF5q3fkRYuPs74NDgs7ty
	 dilQsSv+qD4GRkmcyzS9wWmPRRITOXYCwc3ig4P/fUbWTL39hLhZ4Dp/BtPz0N85uq
	 p/aLKAKnkovGvT8rvDA3dYZqWHBqJytma1jPG73B635YQONt+L/ydIMUTDU0W4lXEO
	 OCUZD2TGpjgRw==
Message-ID: <df267967-74ed-4d8a-a86c-8e7b23897356@kernel.org>
Date: Wed, 22 Nov 2023 23:10:01 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: require supported_interfaces to be
 filled
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1q0K1u-006EIP-ET@rmk-PC.armlinux.org.uk>
 <13087238-6a57-439e-b7cb-b465b9e27cd6@kernel.org>
 <650f3c6d-dcdb-4f7e-a3d4-130a52dd3ce9@lunn.ch>
 <c7c8b15d-cb4e-4c5f-8466-293b437f04e6@kernel.org>
 <ZV3JcCx8uyM5J691@shell.armlinux.org.uk>
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <ZV3JcCx8uyM5J691@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/11/23 19:27, Russell King (Oracle) wrote:
> On Wed, Nov 22, 2023 at 02:12:44PM +1000, Greg Ungerer wrote:
>> So I am thinking that something like this actually makes more sense now:
>>
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -577,6 +577,18 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
>>          config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
>>   }
>> +static void mv88e6350_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
>> +                                      struct phylink_config *config)
>> +{
>> +       unsigned long *supported = config->supported_interfaces;
>> +
>> +       /* Translate the default cmode */
>> +       mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
>> +
>> +       config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
>> +                                  MAC_1000FD;
>> +}
>> +
> 
> Looks sensible to me - but I do notice that a black line has been lost
> between mv88e6250_phylink_get_caps() and your new function - probably
> down to your email client being stupid with whitespace because it's
> broken the patch context. Just be aware of that when you come to send
> the patch for real.

Oh, yes, for sure. The above was a cut and paste into email client.
I'll send proper patches via git send-email soon.

Regards
Greg


