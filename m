Return-Path: <netdev+bounces-238543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F9C5AD72
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D4F4E86F8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC721E097;
	Fri, 14 Nov 2025 00:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A0221F29
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081102; cv=none; b=FOR/cJxJ8K6FEH700oU8iJjoxAMUVccr9kVBLaaRF8WnKQYDtwvMct5Eoz+GEHT+rMggBr5dynOvbOMo9/S7CxP4YyNTgJ8k8eeOsaXn/4dq4pdGuUsSOd+PYlEMFJA4lcJqvFvhjh+gmYpbCCJ6dCXtgy0f4uhwe9nQbxNjjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081102; c=relaxed/simple;
	bh=VFxzxVwJ2PEBFZc0AIz2gAD0d5vblCRY8PlOiHNzmGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUJFTgLWwrI16ZQX0lwrnFG8m04Yu1Z1pGLrc6ZO9jKbCKcLQyAOCFC17vSj21I/hrvx/50ugYfn8eKQ02o5M7XuVOUvRUBI+vR0Kpl4TgTD54JYDccD45mUB1pAx6b0pxzwhsvko9qasH9sfHbzmfOfMKJU3/E/0zcQAR6wx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1vJhLM-00044e-G1; Fri, 14 Nov 2025 00:07:12 +0000
Message-ID: <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
Date: Thu, 13 Nov 2025 16:07:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org,
 mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>,
 Alexander Duyck <alexanderduyck@fb.com>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 5:28 AM, Andrew Lunn wrote:

> On Thu, Nov 13, 2025 at 12:11:08PM +0100, Maxime Chevallier wrote:
>> Hi,
>>
>> On 13/11/2025 06:12, Susheela Doddagoudar wrote:
>>> Hi All/ Michal Kubecek,
>>>
>>> To support Advanced PHY Debug operations like
>>> PRBS pattern tests,  EHM tests, TX_EQ settings, Various PHY loopback etc.....
>> Added a bunch of people in CC:
>>
>> I don't have feedback on your current proposition, however people have
>> showed interest in what you mention, it may be a good idea to get everyone
>> in the loop.
>>
>> For the Loopback you're mentionning, there's this effort here [1] that
>> Hariprasad is working on, it may be a good idea to sync the effort :)
>>
>> [1] : https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
>>
>> As for the PRBS, there was a discussion on this at the last Netdevconf,
>> see the slides and talk here [2], I've added Lee in CC but I don't
>> really know what's the state of that work.
>>
>> [2] : https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-management-and-testing.html

I have PRBS testing and configuring TX coefficent support working in an 
internal version of the fbnic driver. The problem is the interface. 
Right now I'm using DebugFS, my understanding is write access in DebugFS 
is frowned upon which is why it hasn't been up streamed yet. My original 
idea was to extend ethtool, similar to what Susheela suggested, to add 
support but I got some push back on that at netdev. I received the 
suggestion that this is really something that should be part of the phy 
subsystem which would require a new tool to be written.

Alex had started to onboard fbnic to phy as part of his work to onboard 
fbnic to phylink. My understanding is that Alex was recently asked to 
not use the phy subsystem. So the question is where does this go? What 
user space tool interacts with the API?

> For PRBS pattern tests testing i think there needs to be a framework
> around it.
>
> When you enable testing, the netif becomes usable, so its state needs
> changing to "under test" as defined in RFC2863. We ideally want it
> revert to normal operation after a time period. There are a number of
> different PRBS patterns, so you need to be able to select one, and
> maybe pass the test duration. It can also be performed in different
> places. 802.3 defines a number of registers in the PCS for this. I
> would expect to see a library that any standards conforming PCS can
> use. There are also PHYs which support this features, but each vendor
> implements it differently, so we need some sort of generic API for
> PHYs. I expect we will also end up with a set of netlink message,
> similar to how cable testing working.

Nothing can touch the comphy while PRBS testing is running. The fbnic 
driver rejects starting testing if the link is up. Once testing has 
begun I actually detach the netdev to prevent the link from coming up. 
To help enforce this I added a test mode to firmware to ensure both 
driver and firmware are hands off the comphy while testing is running.

When I spoke with test engineers internally in Meta I could not come up 
with a time period and over night testing came up as a requirement. I 
decided to just let the user start and stop testing with no time 
requirement. If firmware loses the host heartbeat it automatically 
disables PRBS testing.

fbnic controls the comphy in firmware due to limitations in 4 slice 
mode. Even if it didn't the controls are non-standard.

Lee


