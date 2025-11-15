Return-Path: <netdev+bounces-238899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B9DC60C1E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17B34E0F2E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674C224244;
	Sat, 15 Nov 2025 22:39:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787BEEC0
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763246350; cv=none; b=iE+QozWNViXn370PktRi5Mdj5gNiQqDx40dALhmM14vO/dPoXxgCt0ZvfyTVa6DYQ2sRuo+TLr+wt+kI7xrjP4hrBVza7zwkixWTXtDd6U1BsjKi77vpVFE9sAC7dU3fA9EIKDKbrx/hzPMb6j7QLAyoLlXiFinggEWCz66YE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763246350; c=relaxed/simple;
	bh=7gnAuSnnJTmwcDxJRXyvafVjjrtaigFBHsbCYY0hhdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWhMcXjPmr1ZwBVr8yVcdD1AhPNPiSALyyn+GuPE9zGsR5/JIIt+Ucg9C8mmrcOdo7QljglOaBjbe056/250eOB/Vx61ODW2EEBllgqjfmQ0akHMs3Af0eX6eRc/LUIGsxYutUcwHaCbWFqOviy7X+HTy2pZeej9AiQBbA3DIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1vKOv3-00064s-4O; Sat, 15 Nov 2025 22:38:57 +0000
Message-ID: <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
Date: Sat, 15 Nov 2025 14:38:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org,
 mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>,
 Alexander Duyck <alexanderduyck@fb.com>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/25 5:58 AM, Andrew Lunn wrote:

>> I have PRBS testing and configuring TX coefficent support working in an
>> internal version of the fbnic driver. The problem is the interface. Right
>> now I'm using DebugFS, my understanding is write access in DebugFS is
>> frowned upon which is why it hasn't been up streamed yet. My original idea
>> was to extend ethtool, similar to what Susheela suggested, to add support
>> but I got some push back on that at netdev.
> I would say ethtool is the correct API to use. At minimum it needs to
> be netlink.
>
>> I received the suggestion that
>> this is really something that should be part of the phy subsystem which
>> would require a new tool to be written.
> phylib uses netlink/ethtool, e.g. cable test is purely in phylib, and
> it uses ethtool. ethtool also has --set-phy-tunable, --get-phy-tunable,
> --phy-statistics, etc.
>
> Also, PRBS is not just a PHY thing, 802.3 defines it as part of the
> PCS, and i don't see why a MAC could also implement it, not that i
> have seen such a thing.
>
> And maybe other networking technologies also have something like PRBS?
> Is there an 802.11 equivalent, used for testing the analogue front
> end? CAN?
PRBS testing can be used as a signal integrity test between any two end 
points, not just networking. For example we have CSRs to allow PRBS 
testing on PCIE with fbnic. My thought was always to limit the scope to 
network use case. The feedback I received at Netdev was we need to 
handle this generically for any phy, thus the suggestion to do this on 
phy. That adds a ton of complexity so I'd be supportive to narrow this 
down to just networking and leverage ethtool.
>
>> Alex had started to onboard fbnic to phy as part of his work to onboard
>> fbnic to phylink. My understanding is that Alex was recently asked to not
>> use the phy subsystem. So the question is where does this go? What user
>> space tool interacts with the API?
> Linux's understanding of a PHY is a device which takes the bitstream
> from the MAC and turns it into analogue signals on twisted pairs,
> mostly for an RJ45 connector, but automotive uses other
> connectors. Its copper, and 802.3 C22 and parts of C45 define how such
> a PHY should work. There is a second use case, where a PHY converts
> between say RGMII and SGMII, but it basically uses the same registers.
>
> fbnic is not copper. It has an SFP cage. Linux has a different
> architecture for that, MAC, PCS and SFP driver. Alex abused the design
> and put a PHY into it as a shortcut. It not surprising there was push
> back.
>
> So, i still think ethtool is the correct API. In general, that
> connects to the MAC driver, although it can shortcut to a PHY
> connected to a MAC. But such a short cut has caused issues in the
> past. So i would probably not do that. Add an API to phylink, which
> the MAC can use. And an API to the PCS driver, which phylink can
> use. And for when the PHY implements PRBS, add an API to phylib and
> get phylib to call the PHY driver.
>
> I'm not saying you need to implement all that, just the bits you need
> for a PCS packet generator. But lay out the architecture such that it
> can be extended with packet generators in other places.
I'll sync with Alex on Monday about this since he is leading the phylink 
work.
>   
>>> For PRBS pattern tests testing i think there needs to be a framework
>>> around it.
>>>
>>> When you enable testing, the netif becomes usable, so its state needs
>>> changing to "under test" as defined in RFC2863. We ideally want it
>>> revert to normal operation after a time period. There are a number of
>>> different PRBS patterns, so you need to be able to select one, and
>>> maybe pass the test duration. It can also be performed in different
>>> places. 802.3 defines a number of registers in the PCS for this. I
>>> would expect to see a library that any standards conforming PCS can
>>> use. There are also PHYs which support this features, but each vendor
>>> implements it differently, so we need some sort of generic API for
>>> PHYs. I expect we will also end up with a set of netlink message,
>>> similar to how cable testing working.
>> Nothing can touch the comphy while PRBS testing is running. The fbnic driver
>> rejects starting testing if the link is up.
> That actually seems odd to me. I assume you need to set the link mode
> you want. Having it default to 10/Half is probably not what you
> want. You want to use ethtool_ksettings_set to force the MAC and PCS
> into a specific link mode. Most MAC drivers don't do anything if that
> call is made when the interface is admin down. And if you look at how
> most MAC drivers are structured, they don't bind to phylink/phylib
> until open() is called. So when admin down, you don't even have a
> PCS/PHY. And some designs have multiple PCSes, and you select the one
> you need based on the link mode, set by ethtool_ksettings_set or
> autoneg. And if admin down, the phylink will turn the SFP laser off.

fbnic does not currently support autoneg, we know the settings that will 
be used for prod. At manufacturing time the EEPROM is configured with 
the expected lanes and mode(NRZ/PAM4). Firmware sends these settings to 
the driver which are stored in fbn->aui. ethtool -s  can change these 
settings when PRBS testing isn't running. Before starting testing I call 
fbnic_fw_xmit_comphy_set_msg() with those cached settings so we can test 
any configuration.

We could use the same pattern, user configures the device with ethtool 
-s before running ethtool --prbs. Devices which want to support PRBS 
will need to cache settings similar to fbnic.

>
>> When I spoke with test engineers internally in Meta I could not come up with
>> a time period and over night testing came up as a requirement. I decided to
>> just let the user start and stop testing with no time requirement. If
>> firmware loses the host heartbeat it automatically disables PRBS testing.
> O.K. So i would probably go for a blocking netlink call, and when ^C
> is used, to exits PRBS and allows normal traffic. You then need to
> think about RTNL, which you cannot hold for hours.
RTNL() is only held when starting testing, its released once testing has 
begun. We could set a flag on the netdev to say PRBS testing is running, 
don't do anything else with this device until the flag is reset.
>
> 	Andrew

