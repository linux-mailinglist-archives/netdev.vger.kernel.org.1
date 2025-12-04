Return-Path: <netdev+bounces-243583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7ACA4186
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B66AD3007D79
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB07257854;
	Thu,  4 Dec 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCtDPez3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6D2192EA;
	Thu,  4 Dec 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859798; cv=none; b=Dj3Cpgu6ASHsfh70/jjYPWmGo1SA05Lu8G1Wn2VuC5n4izP43kVfOAMIGUkHZnq66guicqAGIcct2WleLMqaZ9Ug4jFKX2mstZUwCQdjygWze7lFykf//xA9Cpr0hZlkxTSl/lVNQr832Odyd92dAp43H/E+nITW87PeEpYcUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859798; c=relaxed/simple;
	bh=045RnNNUYkWW1jM7ti+CfPLbw9aH62wfhNUabYoIIuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mE9GGGgKTCnL+GhHHxlzsH3UDSwUuQdp7Li9gsT8oCOHu0eVu+G8xr5qINKFE30nYcXKr1MfNMtWCyo8eTMCGf/WBUsvLduGS7FKWGjGt8pAs6jg7n7ImS8qaSZ08tTZL5Kb5qlmA6jxW09HFdwoVHUaCSK7Yf61uv0qSD0LG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCtDPez3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7FEC4CEFB;
	Thu,  4 Dec 2025 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764859797;
	bh=045RnNNUYkWW1jM7ti+CfPLbw9aH62wfhNUabYoIIuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TCtDPez35F869rE7BJlP8tOsej+8LpHWTUsKb36awDxXqkViX6yj1vALGeDZusdbD
	 HH3dhniHuVGhAcyYF4Y3qWmjEZd87oz2HaaeACMAOw9jD9QaOu7J0tSEty5WQht4OE
	 dbOJPGegsUB3Nh2yzh8cvCPyDTLwIDQ7swYcPYx5U7OObM2vFmFrxL9XUuGCdIe3N8
	 GA8l1tUjcTkR2ffj5Mk/nHidQHmk99uVZzFG65uqE71pO8CJBXhSXz5vPyuX7G8nYL
	 2HmcwxEXveJ5ionjnCjbdUHBsea7PLs6nbxWkdQBOFj3AnCQrEzs1hXpFotSDKXm5Q
	 /5Sh9QvJXAtCg==
Message-ID: <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
Date: Thu, 4 Dec 2025 15:49:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
To: Vladimir Oltean <olteanv@gmail.com>, Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <frankwu@gmx.de>, Andrew Lunn <andrew@lunn.ch>,
 Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org> <20251204131626.upw77jncqfwxydww@skbuf>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251204131626.upw77jncqfwxydww@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 14:16, Vladimir Oltean wrote:
> On Tue, Dec 02, 2025 at 12:20:31PM +0000, Daniel Golle wrote:
>> On Tue, Dec 02, 2025 at 12:52:44PM +0100, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> Am 01.12.25 um 08:48 schrieb Krzysztof Kozlowski:
>>>> On 30/11/2025 21:17, Andrew Lunn wrote:
>>>>> On Sun, Nov 30, 2025 at 10:07:31AM +0200, Vladimir Oltean wrote:
>>>>>> On Sun, Nov 30, 2025 at 02:11:05AM +0100, Andrew Lunn wrote:
>>>>>>>> -		gpiod_set_value_cansleep(priv->reset, 0);
>>>>>>>> +		int is_active_low = !!gpiod_is_active_low(priv->reset);
>>>>>>>> +		gpiod_set_value_cansleep(priv->reset, is_active_low);
>>>>>>> I think you did not correctly understand what Russell said. You pass
>>>>>>> the logical value to gpiod_set_value(). If the GPIO has been marked as
>>>>>>> active LOW, the GPIO core will invert the logical values to the raw
>>>>>>> value. You should not be using gpiod_is_active_low().
>>>>>>>
>>>>>>> But as i said to the previous patch, i would just leave everything as
>>>>>>> it is, except document the issue.
>>>>>>>
>>>>>>> 	Andrew
>>>>>>>
>>>>>> It was my suggestion to do it like this (but I don't understand why I'm
>>>>>> again not in CC).
>>>>>>
>>>>>> We _know_ that the reset pin of the switch should be active low. So by
>>>>>> using gpiod_is_active_low(), we can determine whether the device tree is
>>>>>> wrong or not, and we can work with a wrong device tree too (just invert
>>>>>> the logical values).
>>>>> Assuming there is not a NOT gate placed between the GPIO and the reset
>>>>> pin, because the board designer decided to do that for some reason?
>>> jumping in because i prepare mt7987 / BPI-R4Lite dts for upstreaming when
>>> driver-changes are in.
>>> With current driver i need to define the reset-gpio for mt7531 again wrong
>>> to get it
>>> working. So to have future dts correct, imho this (or similar) change to
>>> driver is needed.
>>>
>>> Of course we cannot simply say that current value is wrong and just invert
>>> it because of
>>> possible "external" inversion of reset signal between SoC and switch.
>>> I have to look on schematics for the boards i have (BPI-R64, BPI-R3,
>>> BPI-R2Pro) if there is such circuit.
>>
>> I'm also not aware of any board which doesn't directly connect the
>> reset of the MT7530 to a GPIO pin of the SoC. For MediaTek's designs
>> there is often even a specific pin desginated for this purpose and
>> most vendors do follow this. If they deviate at all, then it's just
>> that a different pin is used for the switch reset, but I've never
>> seen any logic between the SoC's GPIO pin and the switch reset.
>>
>>> Maybe the mt7988 (mt7530-mmio) based boards also affected?
>>
>> There is no GPIO reset for switches which are integrated in the SoC,
>> so this only matters for external MT7530 and MT7531 ICs for which an
>> actual GPIO line connected to the SoC is used to reset the switch.
> 
> I get the feeling that we're complicating a simple solution because of a
> theoretical "what if" scenario. The "NOT" gate is somewhat contrived

You downplay this case and suggest (if I get it right) that NOT gate is
something unusual.

 I mentioned "line inverter" but it's not about NOT gate. There is no
need for NOT gate at all, like some magical component which no one puts
to the board. The only thing needed is just to pull the GPIO up or down,
that's it. It's completely normal design thus it CAN happen.

Of course "can" does not mean it actually does, because certain
configurations like powerdown-fail-safe are more likely and I am not an
electric circuit designer to tell which one is better, but that
downplaying does not help here.

Just to clarify: I expect clear communication that some users will be
broken with as good as you can provide analysis of the impact (which
users). I only object the clame here "no one can ever pull down a GPIO
line thus I handled all possible cases and made it backward compatible".

And that claim to quote was:
"Therefore, regardless of whether a DTS is old or new, correct or
incorrect, the driver now generates the correct electrical reset pulse."

which is 100% false and I am surprised how one could claim that.


> given the fact that most GPIOs can already be active high or low, but OK.
> 
> If this is blocking progress for new device trees, can we just construct,
> using of_machine_is_compatible(), a list of all boards where the device
> tree defines incorrect reset polarity that shouldn't be trusted by the
> driver when driving the reset GPIO? If we do this, we can also leave
> those existing device trees alone.

Works for me. You can also print fat warning for every unusual case.
Nothing like that was here in the original patch...


Best regards,
Krzysztof

