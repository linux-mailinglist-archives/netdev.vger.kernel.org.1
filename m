Return-Path: <netdev+bounces-304884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4TyNAqZgS2qlQQEAu9opvQ
	(envelope-from <netdev+bounces-304884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:00:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5349370DDAE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b="tUeDE/MT";
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=x0OMHnTB;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304884-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304884-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8791530E477C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 06:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157C4BCAAE;
	Mon,  6 Jul 2026 06:29:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008A3DD536;
	Mon,  6 Jul 2026 06:29:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319355; cv=none; b=njL2aOM3w96I00EKmrvxbk702uDPNmL2HMkgMhRiuzvpZ9J+n0A/VeaMn/oGiX6HqJkinZzlMzoqt1X0P+SEtZbSlHGwR3bY9dFfp3MKXrWsNRXQNJ4G5zM7EPHNsVusZ5lEdyMfe43h6+GnIDzrYiznRPZPcbvWx+/pPlxtxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319355; c=relaxed/simple;
	bh=Jfb2fhUnJHvJozEGMpZ0vKLRGPAh0VFsp4j1GBbH0cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL+t6/2P8X/+tXBWWSIXq5EkvxycVgw/QqizXZSWy+nZAIOO6InWkOJvQyGUP4uUOvgTu7wzJMQvMB51w3198Ae9YGp0kQRIQLEdQCZG1wVNqpJhP0Tdk3kgECa93LI4XG/O+13E1/GoXcNvMjyiMIXOKwBSZILx8T0VLJrWSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tUeDE/MT; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=x0OMHnTB; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783319338;
	bh=Jfb2fhUnJHvJozEGMpZ0vKLRGPAh0VFsp4j1GBbH0cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tUeDE/MT9ULG8WhqQNqWcfKlClmBLLbB8Nuushfd4wd2FrpHbh/p6g1448Sxc/hPb
	 nK5GhC7FUBcq5Ds4qtanuxivKWeOSX8oYlTGDumi5KcSFhuDaFBAX2a8Wd/bE7arYH
	 uh3t28ouY8VmPThtaIffEr3ziU7bOSxOId1dXM8YJms0Eg680pLioT1/e8osvTMEdB
	 zwG3lTiFVSjhhPClP7AXF1nE3Bm2NbxOjF/6IgNUH7vFgpJ0gaYYWIBH9QyFT8Xz3G
	 gp2zXn6N7Tzf911juLUxifZGxel3RoAoPgxMjL0JH0ItFykao6GXWmkEAjv9DW5Hzg
	 GY7onGjyxG/CQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3A7CD3F36F; Mon,  6 Jul 2026 06:28:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783319337;
	bh=Jfb2fhUnJHvJozEGMpZ0vKLRGPAh0VFsp4j1GBbH0cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x0OMHnTBLjscgw0NOHc/8Ha2qwkmgPkj/ZQIoodovq2485kGSF7GJJ/G6HCTsUppw
	 vfz0itPMPhyOIFMj4G3gPcCJbBszEEMfdifjjoqe5V7dARPmGmY65qOSErxjy99rjw
	 U2dPZfaR3EluJd/MSVjkTCFGpX+NTlXl+GkroWOB37wsvTEhdbfhg1gmlt+WnOZKuH
	 BeLizbUWpsjY6KzdzFpRFEDRf1IPUdJOq0bZWL+dq9/X/09vjC2Gs4qcgpxbSpIwJw
	 ilKpkL0FAwxImozbMc3SXpPjQ0gI6e6uFVKXrdOM7gKfZDsnAK4my9QJmtj12M8B4q
	 eQnq45AgtHrBA==
Received: from [IPV6:2003:c6:9f1c:3c00:c446:95cc:f2ac:d401] (p200300c69f1c3c00c44695ccf2acd401.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:c446:95cc:f2ac:d401])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 193D93F338;
	Mon,  6 Jul 2026 06:28:57 +0000 (UTC)
Message-ID: <833f79c1-39be-4c04-bc4f-3ec7a983ab56@birger-koblitz.de>
Date: Mon, 6 Jul 2026 08:28:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause parameter
 configuration
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
 <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5349370DDAE



On 7/1/26 19:05, Andrew Lunn wrote:
> On Wed, Jul 01, 2026 at 06:22:31PM +0200, Birger Koblitz wrote:
>> Hi Andrew,
>>
>> thanks for reviewing this patch-series! I will answer to the other questions later,
>> so that the answers stay together. But it is probably best if I give this answer
>> immediately:
>> On 7/1/26 17:08, Andrew Lunn wrote:
>>>>> +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
>>>>> +	if (!(bmcr & BMCR_ANENABLE)) {
>>>>> +		pause->autoneg = 0;
>>>>> +		pause->rx_pause = 0;
>>>>> +		pause->tx_pause = 0;
>>>> The best way to have this correct is to use phylink, but for that you'd need to
>>>> have a proper PHY driver instead of using the mii_ API here.
>>>
>>> I said the some to one of the other patches.
>>>
>>> Do we know what PHYs are being used? Can register 2 and 3 be read to
>>> get the PHY IDs?
>>>
>>> 	Andrew
>>
>> I tested
>>    id1 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID1);
>>    id2 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID2);
>>
>> and got:
> 
> Thanks for these numbers.
> 
>> Renkforce AX88179A: ID1 7c9f, ID2 7061
>> Delock AX88279  ID1 03a2, ID2 a411
> 
> air_en8811h.c:#define EN8811H_PHY_ID		0x03a2a411
> 
>> UGreen AX88772D ID1 e65b, ID2 2c61
>> TP-Link AX88179A ID1 e65b, ID2 2c61
> 
> The two ID registers contain part of an OUI, but it has some bits
> missing. So it is not so easy to look it up.
> 
> However, anything using the MII framework basically assumes a very
> simple PHY and only looks at the 802.3 defined registers. So the
> genphy generic PHY driver might be sufficient for when there is not a
> specific driver. At lot depends on how much extra code there is
> accessing the PHY registers in the driver.
I started converting the driver to phylink, but hit rock-bottom. There definitely is
an Airoha EN8811H as IP-core in the AX88279, which is clear from the PHY-ID and quirks
such as only Full-Duplex and ANEG being supported by the phy, but the firmware is
completely different, leading to different register content. The most striking example
is that the 2.5GBit advertising bit in the firmware for the AX88279 abuses the
ADVERTISE_RESV bit of the MII_ADVERTISE register, but in the EN8811H this is the
standard bit in the 10GBit advertising register. There is no firmware needed for the
PHY in the AX88279. The EN8811H mechanism for vendor register access is using a so-called
buckpbus using phy-register reads/writes for access, whereas similar vendor registers
of the AX88279 are just standard AX88279 registers, also to avoid USB-transfers.
The pbuckbus logic is not implemented in the AX88279 firmware, but in any case a
vendor register read for the EN8811H would need 5 URBs, where as the AX88279 just needs
1. The vendor registers also have very different content, for example the WoL bits
are entirely different.

I am also relatively sure that the PHY in the AX88179a/b is an Airoha AN8801, but
again the firmware is so different it looks like a completely different chip with
regards to registers. Again it uses the pbuckbus to access the vendor registers,
which is not implemented in the AX88179a firmware.

Changing the behaviour of the EN8811H driver to also accept the firmware of the
AX88279 IP-core implementation does not appear to make sense, it would be cleaner
to add a separate driver, but that would not work from the phylink-logic as it would
grab the same PHY-IDs.

I could simulate the EN8811H firmware in the ax88179_178a.c driver, but I guess that
would beat the purpose, plus it would cost quite an overhead in URBs.

For me the way ahead is to stick with the simple MII-driver and just make sure that
features such as pause configuration are properly implemented. Please tell me if that
makes sense or there are better ways.

Birger

