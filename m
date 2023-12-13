Return-Path: <netdev+bounces-56807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B8810E2D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7022A1C2082C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8F224E0;
	Wed, 13 Dec 2023 10:16:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096583
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:16:16 -0800 (PST)
Received: (qmail 9390 invoked by uid 5089); 13 Dec 2023 10:16:12 -0000
Received: by simscan 1.2.0 ppid: 9309, pid: 9310, t: 0.7506s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.1.24?) (rtresidd@electromag.com.au@202.90.244.20)
  by anchovy3.45ru.net.au with ESMTPA; 13 Dec 2023 10:16:11 -0000
Message-ID: <c98a33d3-8895-4aaa-8658-538fc42ff0c5@electromag.com.au>
Date: Wed, 13 Dec 2023 18:15:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: STMMAC Ethernet Driver support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, vinschen@redhat.com,
  netdev@vger.kernel.org
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
 <2139624b-e098-457a-bda4-0387d576b53a@lunn.ch>
 <8ba4d31f-9436-43ad-afd7-997a4d3a4bf2@electromag.com.au>
 <d0b7cc4b-2322-469b-b588-00c69e3afa46@lunn.ch>
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <d0b7cc4b-2322-469b-b588-00c69e3afa46@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/12/2023 5:17 pm, Andrew Lunn wrote:

> On Tue, Dec 12, 2023 at 11:57:22AM +0800, Richard Tresidder wrote:
>> <font face="monospace">Richard Tresidder</font>
>>
>>
>> On 12/12/2023 12:16 am, Andrew Lunn wrote:
>>>> We use the SOC's internal  STMMAC interface to connect to a Marvel switch IC
>>>> and expose each port individually using vlan, I'd forgot that part.
>>>> It's an  88E6352-xx-TFJ2I000  device utilising the 'marvell,mv88e6085'
>>>> compatible driver  in drivers\net\dsa\mv88e6xxx
>>> Its odd you need VLANs. Each port should already be exposed to the
>>> host as netdev interfaces. That is what DSA does.
>>>
>>>        Andrew
>> Hi Andrew
>>     I'll read further on that one as this is the first time I've had to dig
>> into this side of the system.
>> It had always "just worked".
>> The ports show up in an 'ip l' list in the same style as a vlan with an @
>> symbol, naming isn't quite vlan style though.
>> That in concert with the fact this 'vlan_feature' line broke things has
>> possibly distorted my view of how they're propagated.
>> It's a rather trimmed down busybox image, so I'm missing some tools I'd
>> usually use to examine stuff.
>>
>> This is the config in the dts
>> **************************************
>> //------------------------------------------------------------------------------
>> // connected to dsa network switch
>> &gmac1 {
>>    clock-names = "stmmaceth", "clk_ptp_ref";
>>    clocks = <&emac1_clk &hps_eosc1>;
>>    f2h_ptp_ref_clk;
>>    fixed-link {
>>      speed = <1000>;
>>      full-duplex;
>>    };
>> };
>>
>> //------------------------------------------------------------------------------
>> &mdio1 {
>>    #address-cells = <1>;
>>    #size-cells = <0>;
>>
>>    switch0: switch0@0 {
>>      compatible = "marvell,mv88e6085";
>>      #address-cells = <1>;
>>      reg = <0>;
>>      //reset-gpios = <&pio_a0 2 GPIO_ACTIVE_LOW>;
>>
>>      dsa,member = <0 0>;
>>
>>      ports {
>>        #address-cells = <1>;
>>        #size-cells = <0>;
>>
>>        port@2 {
>>          reg = <2>;
>>          label = "lan1";
>>          phy-handle = <&switch1phy2>;
>>        };
>>
>>        port@3 {
>>          reg = <3>;
>>          label = "lan2";
>>          phy-handle = <&switch1phy3>;
>>        };
>>
>>        port@4 {
>>          reg = <4>;
>>          label = "lan3";
>>          phy-handle = <&switch1phy4>;
>>        };
>>
>>        port@5 {
>>          reg = <5>;
>>          label = "wifi";
>>          fixed-link {
>>            speed = <100>;
>>            full-duplex;
>>          };
>>        };
>>
>>        port@6 {
>>          reg = <6>;
>>          label = "cpu";
>>          ethernet = <&gmac1>;
>>          fixed-link {
>>            speed = <1000>;
>>            full-duplex;
>>          };
>>        };
>>
>>      };
>>
>>      mdio {
>>        #address-cells = <1>;
>>        #size-cells = <0>;
>>        switch1phy2: switch1phy2@2 {
>>          reg = <2>;
>>          marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
>> Detect, no FLPs sents
>>        };
>>        switch1phy3: switch1phy3@3 {
>>          reg = <3>;
>>          marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
>> Detect, no FLPs sents
>>        };
>>        switch1phy4: switch1phy4@4 {
>>          reg = <4>;
>>          marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx Energy
>> Detect, no FLPs sents
>>        };
>>      };
>>
>>      };
>> };
> That all looks normal, expect the marvell,reg-init. That is a pretty
> ugly hack, from years and years ago, which should not be used any
> more. It would be better to add a DT property for what you want, or a
> PHY tunable.
>
Yep this dts chunk is what was done back from a 4.7 kernel level
We've been running a 5.1.7 kernel for a while now while we were 
concentrating on getting the rest of the system running and the software 
stack done.
I'm just starting pulling the kernel up to near the latest now so I'll 
have to look at how to get those flags set under whats available in the 
devicetree now.
>> This is how they appear using 'ip l'
>> The @ symbol got me as I've usually associated this with vlan's in my day to
>> day networking.
> The @ is just trying to show there is a relationship between to
> interfaces. Its a VLAN on top of a base interface, or its a DSA user
> port on top of a conduit interface.
>
> So there is nothing odd at all here. What i have seen is user space
> hacks to run Marvell SDK to program the switch to map a VLAN to a
> port. There is no point doing that when you have a perfectly good
> kernel driver.
>
>       Andrew
Yep this is the first time I've looked at a dsa style link.
So from my initial glimpse without digging it looked like a VLAN which I 
think I'd seen done with some other switch IC's in the past.
Definitely not using any marvel userspace trickery here.

Any idea on what should be done about that 'vlan_feature' permeating 
through and breaking stuff in this instance?
I'm really not sure how this 'feature' set is meant to propagate or be 
applied at each stage in a chained set of devices.
When the feature is on there does appear to be a value in the 
transmitted CRC but it's bad.
Not sure if thats just uninitialized data or the CRC is being applied at 
multiple stages and breaking stuff.
Pretty sure the stmmac ip needs zeros in the packets CRC field for it to 
be applied correctly.
maybe something similar is occurring in the marvel device.  But I'm not 
sure if thats where the problem is.

I can definitely dig further, but it'd be nice to be given a starting point?
Theres a LOT of stuff in the network stack..

I can just disable this patch in our systems, but seems like a missed 
opportunity to track down the problem.

Cheers
   Richard


