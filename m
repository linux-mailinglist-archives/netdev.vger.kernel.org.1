Return-Path: <netdev+bounces-200865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E6AE724A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D7A1BC3738
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646525B677;
	Tue, 24 Jun 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f3gcbDz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38025A320
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804170; cv=none; b=QvOyFxyujMzCiby4Oz7YXAd9do9HDC8zsU5nmSlM0SI60m7QJf3yk6gPZsE+nSvgPDsgtBGpEQt0bGjlaMnjZeWHcryTASJ3C4kMUBmwbabw79M472YsSKH7mgF+yvq5N0eBhmUF+ypgpXNzmmpUQEvHaKIKfOIEaEjd1i14Fo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804170; c=relaxed/simple;
	bh=TSTVEjhlAnfsWMaIdJt0sf5EQ4mgHKnzQHC6rn2eg7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KfvjRfiLxdy4WucTF/TE7DwMSy9KNCbWBVJkX/42hV8dYZVSRIvMZnEIf+mAwA7WYtpN6ZH+MWMAOc6X+S4MPg7XT90Nif8vpAcQh161ta68S5RmdHbp/yxT9dxCPgtqTHa5SowyM/tcdfB8b9L8Vkehqs335uKoAru9ZlTWk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f3gcbDz3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311a6236effso4192700a91.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750804168; x=1751408968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CgDhJkr9NQtq58HPxNz6h/rMOa9nnSbFLJIANgxKQ0g=;
        b=f3gcbDz34Yh6FjZlO4zKeapAJZgdlEQhqYm5+bBr2AAo4VwRlC34japGu7VhFn4GFp
         9OjeofA0S9kNVVvc5TYKj9W75s3Z7+XH9w3yF41mYhqfF6JcnrMFguzo5EMSeEMlZQP9
         NVwB0QiNXJNiIwzwH1vmZQHX/PeEWcX2jvpsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750804168; x=1751408968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgDhJkr9NQtq58HPxNz6h/rMOa9nnSbFLJIANgxKQ0g=;
        b=gw4Bzhy8h5LE7tFO6VxVcttPoxOP5R/pML/jSXaFDXuGnERBvaPvvLZhstPdREDxn6
         SXp5rHMBKLcim1ku580HhD+SLXn4aHQ6KXi8cGu8fGD5zPv2ctjdurCHwTI2qblbYDwg
         JCRTyhzj0KG7OCUZJFkkH7WXQ0WLLav22MDqKli1RSQYfO9B1wDw6W7W/wYspx2PGcYT
         2qkLJSLDicwLMtVUGSbgj9teqn6EqRIz6wcMf0xb1LesIKCDNE4Ik0LhgQY0uW2Qa8Xz
         TkmWAFij+5YXtGP7RGYk4VSMXz6GVan3+mN03ZylO8f4z/iNAX4TKxWxLW6vNSHadjwG
         +DCg==
X-Forwarded-Encrypted: i=1; AJvYcCWFy238p0i7M2CCFGXmRArWdb0r9TuiwFZQ8+GQ3Wr5ZEoVdSRldzjtYUMY1Kwr3TLiGIp6ekc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9l/NfQn69xOVMFrUGI5Y3D/ET5PViwkhMcCMHXt4+HIIi0U+
	k5HRA2fPZznRfCZGwognR3/EUhcf/N4dnCLx4GLthsACKjfi81GQ2hCLoGiTbUjJ6bRwiwDVmUa
	Iw0KYDA==
X-Gm-Gg: ASbGncuJ/G4yuseGxO5CwDn8kBYICSroNnr/j8nsblODgzpeOsKaStQf5h9lkNwYZ25
	ZKK9N9OF/ncXJ9sAUzDUoMTC7uJSyVHsCaxmKnkxN2RVvOf8BH54Y0vdijNAAaW6ZQXJavwWylq
	y6W82etaQ8KP8vfl4mAvDrQY3OKl1ZhE1XaVu0ROVhnvTgHNIKuOvyOW9mPmR615mx25c3u4FWz
	dcupsYyXu8lHL63dhe6EoB1O6kYtQh/fmspUF6toX9iu5K/vOLaxq/D81UP1IqslIq4DNdUUSDe
	Sv6hCApLGLc8nwUkHD0aa+cim1GYV+5fck+zHOucBv2+B32mp9mUOYnCuNsjLOelvoY1qDkV3QF
	RsKDGBv9JJKqtYqtSb91iy1GCw6a59FDlZgk3
X-Google-Smtp-Source: AGHT+IEVbZ2d51fzgG98t2wXJTzAYhGkQ7SSqGU2Y1R9CgvLYo/gdKOpJvimKF1r+86shwAPch2uIg==
X-Received: by 2002:a17:90b:33c3:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-315f2688f8fmr641402a91.22.1750804167605;
        Tue, 24 Jun 2025 15:29:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5400c59sm121906a91.49.2025.06.24.15.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 15:29:26 -0700 (PDT)
Message-ID: <24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com>
Date: Tue, 24 Jun 2025 15:29:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting SGMII to 100BaseFX SFP modules, with broadcom PHYs
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Robert Hancock <robert.hancock@calian.com>,
 Tao Ren <rentao.bupt@gmail.com>
References: <20250624233922.45089b95@fedora.home>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250624233922.45089b95@fedora.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Howdy,

On 6/24/25 14:39, Maxime Chevallier wrote:
> Hello everyone,
> 
> I'm reaching out to discuss an issue I've been facing with some SFP modules
> that do SGMII to 100FX conversion.
> 
> I'm using that on a product that has 1G-only SFP cage, where SGMII or 1000BaseX
> are the only options, and that product needs to talk to a 100FX link partner.
> 
> The only way this can ever work is with a media-converter PHY within the SFP,
> and apparently such SFP exist :
> 
> https://www.fs.com/fr/products/37770.html?attribute=19567&id=335755
> 
> I've tried various SFP modules from FS, Prolabs and Phoenix Contact with
> no luck. All these modules seem to integrate some variant of the
> Broadcom BCM5641 PHYs.
> 
> I know that netdev@ isn't about fixing my local issues, but in the odd chance anyone
> has ever either used such a module successfully, or has some insight on what is
> going on with these Broadcom PHYs, I would appreciate a lot :) Any finding or
> patch we can come-up with will be upstreamed of course :)
> 
> Any people with some experience on this PHY or this kind of module may be
> able to shed some lights on the findings I was able to gather so far.
> 
> All modules have the same internal PHY, which exposes itself as a BCM5461 :
> 
> 	ID : 002060c1
> 	
> I know that because I was able to talk to the PHY using mdio over i2c, at
> address 0x56 on the i2c bus. On some modules, the PHY doesn't reply at all,
> on some it stalls the i2c bus if I try to do 16bits accesses (I have to use 8 bits
> accesses), and on some modules the regular 16bits accesses work...
> 
> That alone makes me wonder if there's not some kind of firmware running in
> there replying to mdio ?

Unclear, but that ID is correct for the BCM5461 and its variants.

> 
> Regarding what I can achieve with these, YMMV :
> 
>   - I have a pair of Prolabs module with the ID "CISCO-PROLABS     GLC-GE-100FX-C".
> 
>     These are the ones that can only do 8bits mdio accesses. When the PHY is
>     left undriven by the kernel, and you plug it into an SGMII-able SFP port, you
>     get a nice loop of 'link is up / link is down / link is up / ...' reported
>     by the MAC (or PCS). Its eeprom doesn't even say that it's a 100fx module
>     (id->base.e100_base_fx isn't set). It does say "Cisco compatible", maybe it's
>     using some flavour of SGMII that I don't know about ?
>     
>   - I have a pair of FS modules with the ID "FS     SFP-GE-100FX". These behave
>     almost exactly as the ones above, but it can be accessed with 16-bits mdio
>     transactions.
>     
>   - I have a "PHOENIX CONTACT    2891081" that simply doesn't work
>   
>   - And maybe the most promising of all, a pair of "PROLABS    SFP-GE-100FX-C".
>     These reply on 16bits mdio accesses, and when you plug them with the PHY
>     undriven by the kernel (so relying only on internal config and straps), I
>     get link-up detected by the MAC through inband SGMII, and I can receive
>     traffic ! TX doesn't work though :(
> 
> On the MAC side, I tested with 3 different SoC, all using a different PCS :
>   - A Turris Omnia, that uses mvneta and its PCS
>   - A dwmac-socfpga board, using a Lynx / Altera TSE PCS to drive the SGMII
>   - A KSZ9477 and its variant of DW XPCS.
> 
> The behaviour is the same on all of them, so I'd say there's a very good chance
> the modules are acting up. TBH I don't know much about sourcing SFPs, they
> behave so differently that it may just be that I didn't find the exact reference
> that for some reason happens to work ?
> 
> The link-partner is a device that only does 100BaseX.
> 
> On all of these modules, I've tried to either let the PHY completely unmanaged
> by the kernel, no mdio transactions whatsoever and we leave the default PHY
> settings to their thing. As nothing worked, I've tried driving the PHY through
> the kernel's broadcom.c driver, but that driver really doesn't support 100FX so
> it's also expected that this doesn't work. Unfortunately, I don't have
> access to any documentation for that PHY...
> 
> The driver does say, for a similar model :
> 
> 	/* The PHY is strapped in RGMII-fiber mode when INTERF_SEL[1:0]
> 	 * is 01b, and the link between PHY and its link partner can be
> 	 * either 1000Base-X or 100Base-FX.
> 	 * RGMII-1000Base-X is properly supported, but RGMII-100Base-FX
> 	 * support is still missing as of now.
> 	 */
> 
> Not quite the same as our case as it's talking about RGMII, not SGMII, but
> maybe the people who wrote that code know a bit more or have access to some
> documentation ? I've tried to put these persons in CC :)

Not sure if you can probe the various pins, but those that would be 
interesting to measure would be:

LNKSPD[1] / INTF_SEL[0]
LNKSPD[2] / INTF_SEL[1]
RGMIIEN
EN_10B/SD

You can forcibly enable RGMII operation by writing to register 0x18, 
shadow 0b111 (MII_BCM54XX_AUXCTL_SHDWSEL_MISC) and setting bit 7 
(MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN).

 > > In any case, should anyone want to give this a shot in the future, 
I'm using the
> following patch so that the SFP machinery can try to probe PHYs on these
> non-copper modules - that patch needs splitting up and is more of a hack than
> anything else.
> 
> Thanks a lot everyone, and sorry for the noise if this is misplaced,

For 100BaseFX, the signal detection is configured in bit 5 of the shadow 
0b01100 in the 0x1C register. You can use bcm_{read,write}_shadow() for 
that:

0 to use EN_10B/SD as CMOS/TTL signal detect (default)
1 to use SD_100FX± as PECL signal detect

You can use either copper or SGMII interface for 100BaseFX and that will 
be configured this way:

- in register 0x1C, shadow 0b10 (1000Base-T/100Base-TX/10Base-T Spare 
Control 1), set bit 4 to 1 to enable 100BaseFX

- disable auto-negotiation with register 0x00 = 0x2100

- set register 0x18 to 0x430 (bit 10 -> normal mode, bits 5:4 control 
the edge rate. 0b00 -> 4ns, 0b01 -> 5ns, 0b10 -> 3ns, 0b11 -> 0ns. This 
is the auxiliary control register (MII_BCM54XX_AUXCTL_SHDWSEL_AUXCTL).

It's unclear from the datasheet whether 100BaseFX can work with RGMII.

Good luck!
-- 
Florian


