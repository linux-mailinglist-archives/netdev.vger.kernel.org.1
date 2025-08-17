Return-Path: <netdev+bounces-214408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A9B294CC
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 20:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FED8161733
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D555418BC3D;
	Sun, 17 Aug 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="ii6UXOOG"
X-Original-To: netdev@vger.kernel.org
Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C77367;
	Sun, 17 Aug 2025 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755456362; cv=pass; b=Eu/rV0tKuW04aS6aISpswto6SqYVH7OQIUf/TQmWxiHazUB4kmCDY80ufk/YE+EhRkthB9BHZWuTINGvu/9K9/bT+wJiH7ZTtvqpBmaysJlcnZxe0r04+AvOW0r0wkQ/spFyYGsZcH0hLK9iEStbbJvIya111yKRsblZRR9QOgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755456362; c=relaxed/simple;
	bh=tyyd2OiNNEsh6q1IHk6oSu0GOR1o77NGF6zDEEoSNN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGAcSCyHHTM+dMSR3UrQGuTUCUJI24GOxey+gKfx0cfUfq5yGVr5eAAZHf+nwFNxJz23YHtbpC+BavMfaTAalljc2bKRcH7NIozUSCdzrBtzmBnJLV/ohas0aAS9AFkbIiXyTXj4mUUnjo9YCj38LPuQti1+Sa3L77e1IagpkNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=ii6UXOOG; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4F4A918446E;
	Sun, 17 Aug 2025 18:09:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a266.dreamhost.com (100-96-13-182.trex-nlb.outbound.svc.cluster.local [100.96.13.182])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BF0CE184247;
	Sun, 17 Aug 2025 18:09:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755454183; a=rsa-sha256;
	cv=none;
	b=FLjNbF59G8Bp2KWivesj93u1Ohj76YkLQp4wWUKeVhLPaZhJV4ZNOHnwO9ndxEzDtfcZrx
	eR+PRkjnFtH2bFD/tYA3RrlEomrkU3nohxc1rhXmEapwbUtheU8otDH9DRkntrjTF3QmYm
	WgM7b73E40RXm1dIOojNdQD1X8ieAzu1JrCfz3U59sh7duJCAlk+wyBl512luvXwb2GU1s
	/xgKU7Wy0gUPDlpQtW6XqiWiYrlYDTTPfF7tKd9yHYstMhveha5QHJhvRex9TKY/gUaWLh
	yeIAYaBNK0krmyuZWwb/tby+SH6npzihzgKj4Y8CSh8QCP8zldkYZLx7fAKzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755454183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=s1kwd8lAGoD3xm6BzNQ30fuUst8tccMovgiO7bgl6e4=;
	b=Uk+42mXHxn4dkuG9DzabC7vdycaJeBoyKeFqTETXtR6+bRL3Ju60ZZpKq9RFH+kOX7CGGF
	6QPPlZPmvxShUoV4VhSkC/e5MTNglyQ/b4L3U9CfFzLrgRSVG/NOD0kIByfb9XAsJ5qExN
	MdhzfrvQ6xfgN5Q56sDtCUa9+dtdVSErCX3NwlFpklMMey05C2Sv0tCNY6Zzo5pNGvdqux
	N+nhziYOj8uqdMCi7ST+Mup/U3YhWQdM3Z7557h0n3kPGcsDfy53NjJWV7ae4LShQ7jwar
	hu/CcxOd8EbKVcTa8jme9J15T/LiZI8haguq28v8pEHEbE7AJhuyX2hNZ5p9pQ==
ARC-Authentication-Results: i=1;
	rspamd-8dfc57599-jg78c;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Spicy: 4e838ab81194e47f_1755454184198_154552064
X-MC-Loop-Signature: 1755454184198:754651397
X-MC-Ingress-Time: 1755454184198
Received: from pdx1-sub0-mail-a266.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.13.182 (trex/7.1.3);
	Sun, 17 Aug 2025 18:09:44 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a266.dreamhost.com (Postfix) with ESMTPSA id 4c4kQG3f8wz6q;
	Sun, 17 Aug 2025 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1755454183;
	bh=s1kwd8lAGoD3xm6BzNQ30fuUst8tccMovgiO7bgl6e4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=ii6UXOOGD9brm9/TSns9qPg8MxmmpSMa+B33fwO/vZRAoqm/cEFqax2kfu3DBYqI5
	 M8vEXhHGvKjXNiHQZcoTjrq3K849D3/EExe0omNB/MNc+C148PaqW2maJyIYpHA0v/
	 aI6AXZfZ6fH8we0/yiTlBmVxizc2H+9cg3SFO5ApwvwxrltZW6Uwsm+dKdsUxjijXS
	 zed4SvvankiV0TiY9q0ec1ZnvpcH0jkE/5pxCnTj4imV0FaoB5+HwNeD2vGiW4hnKd
	 kVRP9f5oJLBIzQ/cqmuf/l6yZUqDvonXmDzSgfjfMJbH8Q7UsknXPEBBkRlD7Yu06T
	 nZN9w+Pgq/GSA==
Message-ID: <d4f291e3-9d4f-4724-91de-742f9ace5b86@landley.net>
Date: Sun, 17 Aug 2025 13:09:41 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
To: Andrew Lunn <andrew@lunn.ch>, Artur Rojek <contact@artur-rojek.eu>
Cc: Jeff Dionne <jeff@coresemi.io>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
 <52aef275-0907-4510-b95c-b2b01738ce0b@lunn.ch>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <52aef275-0907-4510-b95c-b2b01738ce0b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/25 10:04, Andrew Lunn wrote:
> On Sat, Aug 16, 2025 at 03:40:57PM +0200, Artur Rojek wrote:
>> On 2025-08-16 02:18, Andrew Lunn wrote:
>>>> Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both
>>>> MDC
>>>> and MDIO pins connected, however I suspect that nothing really
>>>> configures it, and it simply runs on default register values (which
>>>> allow for valid operation in 100Mb/s mode, it seems). I doubt there is
>>>> another IP core to handle MDIO, as this SoC design is optimized for
>>>> minimal utilization of FPGA blocks. Does it make sense to you that a
>>>> MAC
>>>> could run without any access to an MDIO bus?
>>>
>>> It can work like that. You will likely have problems if the link ever
>>> negotiates 10Mbps or 100Mbps half duplex. You generally need to change
>>> something in the MAC to support different speeds and duplex. Without
>>> being able to talk to the PHY over MDIO you have no idea what it has
>>> negotiated with the link peer.
>>
>> Thanks for the explanation. I just confirmed that there is no activity
>> on the MDIO bus from board power on, up to the jcore_emac driver start
>> (and past it), so most likely this SoC design does not provide any
>> management interface between MAC and PHY. I guess once/if MDIO is
>> implemented, we can distinguish between IP core revision compatibles,
>> and properly switch between netif_carrier_*()/phylink logic.
> 
> How cut down of a SoC design is it?

The engineers focused on getting projects done for customers implemented 
what they actually needed, and had a todo list for potential future 
development that mostly hasn't come up yet.

(Most of the boards I worked on aren't actually using ethernet, but 
doing their own derived protocol that's electrically isolated and 
includes timing information in each packet. Same RJ45 jack, I think it 
even uses the same transceiver chip, but different protocol and signaling.)

> Is there pinmux and each pin can
> also be used for GPIO? Linux has software bit-banging MDIO, if you can
> make the two pins be standard Linux GPIOs, and can configure them
> correctly, i _think_ open drain on MDIO. It will be slow, but it
> works, and it is pretty much for free.
> 
> MDIO itself is simple, just a big shift register:

My vague recollection is this SOC only implemented full duplex 100baseT 
because they didn't have any hardware lying around that _couldn't_ talk 
to that. So it never needed to downshift to talk to anything they tested 
it against, and there were plenty of desktop switches if we wound up 
needing an adapter in future for some reason. (1995 was a while ago even 
back then.)

The negotiation stuff was slated to be part of implementing gigabit 
ethernet, but 11 megabytes/second is actually pretty decent throughput 
for an individual endpoint so nothing's really needed it yet.

Turtle's FPGA couldn't easily do gigabit anyway: a spartan 6 can handle 
a 50mhz phy interface but 125mhz for gigabit is pushing it. That really 
wants something like Kintex (WAY more expensive, and runs quite hot). 
Even with the SOC in ASIC, a gigabit phy chip is still more expensive 
and consumes more power so needs a reason to use it.

There's been more interest in wifi and bluetooth, which you either get 
as its own chip or in a micro-sdio card because rolling your own 
implementation is a regulatory hellscape of spectrum compliance 
certifications in a zillion different jurisdictions. (Implementing it 
isn't that hard, getting permission to deploy it in a city is hard.) USB 
dongles are also available but consume WAY too much power.

Oh, a few years ago we did a USB 2.0 implementation in a Turtle HAT:

https://www.raspberrypi.com/news/introducing-raspberry-pi-hats/

And implemented a VHDL CDC-ECM ethernet device in the turtle SOC 
bitstream to test it out with, which did 40 megabytes/second sustained 
throughput no problem. (With not so much a "driver" as a quick and dirty 
userspace realtime program marshalling packets in and out of the 
hardware buffers to a TAP device. Both the USB and Ethernet PHY are 
basically parallel to serial converters so their outsides can clock way 
slower than the line speed of the protocol they transceive. The USB 2.0 
one we used ran at 60mhz=3*5*2*2 and the ethernet needs 50mhz=5*5*2 so 
the voltage controlled oscillator could run at 3*5*5*2*2=300mhz and then 
get divided evenly down to drive both, and yes we had it run as a little 
gateway for testing.)

Alas, while CDC-EDM using the reference vendor:device IDs out of the USB 
standards document works fine out of the box on both Linux and MacOS, 
Windows refuses to recognize it because Microsoft demanded a five figure 
license fee from each hardware vendor to get a driver signed. (Lina Kahn 
didn't get around to them before the plutocrats plugged that hole in the 
pressure cooker.)

In an attempt to bypass the bastardry we changed the VHDL to do RNDIS 
instead (microsoft's own admittedly inferior version of CDC-EDM that 
they let you implement using an existing driver), and Greg KH went "my 
turn":

https://fosstodon.org/@kernellogger/109397395514594409

Which of course broke Android USB tethering.

*shrug* The 100baseT one works for us.

Rob

P.S. Way back when, we did slap quick wifi on an existing design once as 
a proof of concept using a three inch cat5 cable going to a $15 tiny 
single port wifi router from a store down the street in Akihabara. The 
100baseT connection worked fine. Alas the tiny router couldn't _not_ 
NAT, and writing software to automatically navigate its built-in web 
page to associate with an access point was a rathole we didn't go down.

P.P.S. Oh, and we've connected boards over optical fiber using this 
transceiver chip. Those didn't call for mdio either, I'm not sure the 
VHDL changed at all, just board-level schematic changes. Technically 
that's 100baseF I believe.

