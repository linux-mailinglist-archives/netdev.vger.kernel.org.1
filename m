Return-Path: <netdev+bounces-243633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA610CA4A85
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EA530380E5
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9921346E63;
	Thu,  4 Dec 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a10rYX0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EC335BB4;
	Thu,  4 Dec 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866893; cv=none; b=Dwiifx87+gKPOQorZFp5F2zVvDL/vQ88LJ5lTDeaQFJYH8E8HjWJS6jUSzfEtHzRoDo6dSgz9LJzh+jKSZE/kMbDiYBjfqWhVETomCxEQiks12NMOk3eb94jNymaIFfGV9RUWdHj7fH14svzHDcZ7WkXw6GZ/LhAOftn50yCHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866893; c=relaxed/simple;
	bh=UkC+QMQ4k9lCMANWG3quk95RKaYDeofbdrxNz9Jdz/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUYmupTFABAnPGNCSeoFyoMjeldHGvH18hP9vMs13j+akvLPe4w4MBFymanWJU/IPBcO4lPQFmV8MMXJaVdeq3e05l7WdF7/2tVF6OR0wlDVHvdnX7TFxwjxGERPX3IvFCFu4A6h1IBvzsF4ufIhg3FL8xm84y/XthYLWcjea+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a10rYX0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59AEC116B1;
	Thu,  4 Dec 2025 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764866893;
	bh=UkC+QMQ4k9lCMANWG3quk95RKaYDeofbdrxNz9Jdz/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a10rYX0xwCL5ATxmQuGOKfiv0qz690sWMLTqCrGvIcebZOvyRvBHwg2VH22vaet03
	 QGl4P+7uvAuCbk/SI4IctgZTbmm55y2uDb+9Y8vPuOW96LDra9PB2Ml0hPDWdpqa56
	 6Wpgu2DyYI9t5gdU/tk0QgNJKlj810pUK7Qcn4RpWs6m5UuZ786A5o26M4sph8vp7K
	 j8Wac6zwZjPpqG0I+oTf+mZ5xXKDGUWIs6ype/4nc5vq7ghHK/hx75mzSN1XMbqOr2
	 Vh0URcOOa9ewEbEx0r/uMU6d9lrUR7ytU+4AFNBM6KlkVHssjOAn01WtqoA3WoEbDH
	 8Og2CEFf1Yf2w==
Message-ID: <66d080f1-e989-451f-9d5e-34460e5eb1b0@kernel.org>
Date: Thu, 4 Dec 2025 17:48:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frankwu@gmx.de>,
 Andrew Lunn <andrew@lunn.ch>, Chen Minqiang <ptpt52@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
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
 <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
 <20251204160247.yz42mnxvzhxas5jc@skbuf>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20251204160247.yz42mnxvzhxas5jc@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 17:02, Vladimir Oltean wrote:
> On Thu, Dec 04, 2025 at 03:49:52PM +0100, Krzysztof Kozlowski wrote:
>> On 04/12/2025 14:16, Vladimir Oltean wrote:
>>> I get the feeling that we're complicating a simple solution because of a
>>> theoretical "what if" scenario. The "NOT" gate is somewhat contrived
>>
>> You downplay this case and suggest (if I get it right) that NOT gate is
>> something unusual.
>>
>>  I mentioned "line inverter" but it's not about NOT gate. There is no
>> need for NOT gate at all, like some magical component which no one puts
>> to the board. The only thing needed is just to pull the GPIO up or down,
>> that's it. It's completely normal design thus it CAN happen.
>>
>> Of course "can" does not mean it actually does, because certain
>> configurations like powerdown-fail-safe are more likely and I am not an
>> electric circuit designer to tell which one is better, but that
>> downplaying does not help here.
> 
> I don't want to dismiss this comment, but I don't really understand it.
> What do you mean by "line inverter", is it the component inside the GPIO
> pin which makes it active low?

I mentioned much earlier "line inverter" and here the "NOT gate"
appeared and both suggest you need some dedicated component.

What I want to say that it is not true. You do not need dedicated
component to have different polarity, because it is as simple as
connecting the wire to ground or to voltage and moving a resistor from
one place to another.

> 
> I thought that the premise of this patch set is that old device trees
> are all (incorrectly) defined as GPIO_ACTIVE_HIGH, but someone familiar
> with the matter needs to fact-check this statement.

Yes, that's most likely true.

> 
> Anyway, you and Andrew are talking about different things, you haven't
> made it clear (or at least it wasn't clear to me) that the inverter you
> are talking about isn't his NOT gate (that isn't described in the device
> tree at all, as opposed to your inverter which would make the GPIO line
> GPIO_ACTIVE_LOW - that's something verifiable).

Both are the same - inverter or NOT gate, same stuff. It is just
connecting wire to pull up, not actual component on the board (although
one could make and buy such component as well...). We never describe
these inverters in the DTS, these are just too trivial circuits, thus
the final GPIO_ACTIVE_XXX should already include whatever is on the wire
between SoC and device.

> 
>> Just to clarify: I expect clear communication that some users will be
>> broken with as good as you can provide analysis of the impact (which
>> users). I only object the clame here "no one can ever pull down a GPIO
>> line thus I handled all possible cases and made it backward compatible".
>>
>> And that claim to quote was:
>> "Therefore, regardless of whether a DTS is old or new, correct or
>> incorrect, the driver now generates the correct electrical reset pulse."
>>
>> which is 100% false and I am surprised how one could claim that.
> 
> Agree, the communication should be better.


Best regards,
Krzysztof

