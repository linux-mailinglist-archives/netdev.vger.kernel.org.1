Return-Path: <netdev+bounces-56261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02780E46E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 07:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C5AB21A15
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2E15AF2;
	Tue, 12 Dec 2023 06:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D022BF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 22:49:25 -0800 (PST)
Received: (qmail 12247 invoked by uid 5089); 12 Dec 2023 06:49:23 -0000
Received: by simscan 1.2.0 ppid: 12150, pid: 12151, t: 0.8583s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 12 Dec 2023 06:49:22 -0000
Message-ID: <54ec4385-0cce-4c0b-a288-871af0ab1a70@electromag.com.au>
Date: Tue, 12 Dec 2023 14:49:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: STMMAC Ethernet Driver support
Content-Language: en-US
From: Richard Tresidder <rtresidd@electromag.com.au>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
  netdev@vger.kernel.org
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
 <ZXbecbaUnTwiX3l1@calimero.vinschen.de>
 <efdf22b0-af7b-4ecc-8f34-603ef59bccbc@electromag.com.au>
In-Reply-To: <efdf22b0-af7b-4ecc-8f34-603ef59bccbc@electromag.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2023 12:13 pm, Richard Tresidder wrote:

> On 11/12/2023 6:03 pm, Corinna Vinschen wrote:
>> On Dec 11 17:23, Richard Tresidder wrote:
>>>> Richard Tresidder
>>>> On 9/12/2023 3:06 pm, Richard Tresidder wrote:
>>>>> On 9/12/2023 2:12 am, Jakub Kicinski wrote:
>>>>>> On Fri, 8 Dec 2023 14:03:25 +0800 Richard Tresidder wrote:
>>>>>>> I've looked through the diffset 6.3.3 >>> 6.6.3 on the driver
>>>>>>> drivers\net\ethernet\stmicro\stmmac
>>>>>>> But nothing is jumping out at me.
>>>>>>> I could use a pointer as to where to look to start tracing this.
>>>>>> Bisection is good way to zero in on the bad change if you don't
>>>>>> have much hard to rebase code in your tree.
>>>>>> Otherwise you can dump the relevant registers and the descriptors
>>>>>> (descriptors_status file in debugfs) and see if driver is doing
>>>>>> anything differently on the newer kernel?
>>>>> Thanks Jakub
>>>>>     Yep I think I'll have to start bisecting things on Monday.
>>>>> Luckily to work through this I shouldn't have to merge very much.
>>>>> Have a great weekend
>>>>> Cheers
>>>>>     Richard Tresidder
>>>> Hi Jakub
>>>>      Ok the bad commit is the following:
>>>> ************************************
>>>> 6b2c6e4a938fece9b539c8085f21d17c5e6eb9de is the first bad commit
>>>> commit 6b2c6e4a938fece9b539c8085f21d17c5e6eb9de
>>>> Author: Corinna Vinschen <vinschen@redhat.com>
>>>> Date:   Mon Apr 17 21:28:45 2023 +0200
>>>>       net: stmmac: propagate feature flags to vlan
>>>>       stmmac_dev_probe doesn't propagate feature flags to VLANs.  So
>>>> features
>>>>       like offloading don't correspond with the general features and it's
>>>> not
>>>>       possible to manipulate features via ethtool -K to affect VLANs.
>>>>       Propagate feature flags to vlan features.  Drop TSO feature because
>>>>       it does not work on VLANs yet.
>>>>       Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
>>>>       Link:
>>>> https://lore.kernel.org/r/20230417192845.590034-1-vinschen@redhat.com
>>>>       Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>> ****************************************
>>>>   From back in the work for 6.4-rc1
>>>> Theres a single line addition  approx line 7506
>>>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>> ndev->vlan_features |= ndev->features;
>> This is missing the 2nd line
>>       ndev->vlan_features &= ~NETIF_F_TSO;
>> I assume that another flag or two have to be dropped from being
>> propagated as well.  That may depend on the platform, just like the
>> feature flags depend on STMMAC_VLAN_TAG_USED, for instance.
>> I'm sorry, but I'm not working on stmmac anymore.  Can you perhaps test
>> removing flags from vlan_features and see what actual flag is breaking
>> your scenario?
>> Other than that, maybe reverting the patch is the better option and the
>> vlan_feature flags should be set explicitely in the various
>> platform-specific code.
>> Corinna
> Hi Corinna    Sorry you are correct, there is that additional line in
> the patch. I'd had an earlier version of it open on lore.kernel.org I
> was reading while I was performing the bisect. I'm rather new down in
> the network driver infrastructure, so I'm learning as I go. But I'll
> have a crack at understanding the flags and try to seeing whats causing
> the problem specifically. No problems if you're off on other things,
> just included you in the look as it was that patch that seemed to
> uncover a problem with how things are chained.
> Cheers     Richard
These are the flags that are being applied to the vlan_features set.
ndev->features  0x0000410000000133
ndev->vlan_features is empty prior to this.

So we have
NETIF_F_SG_BIT
NETIF_F_IP_CSUM_BIT

NETIF_F_IPV6_CSUM_BIT
NETIF_F_HIGHDMA_BIT

NETIF_F_HW_VLAN_CTAG_RX_BIT      Interestingly not 
NETIF_F_HW_VLAN_CTAG_TX_BIT   also

NETIF_F_RXCSUM_BIT
NETIF_F_HW_VLAN_STAG_RX_BIT

These flags are set with the following macros:
NETIF_F_SG
NETIF_F_IP_CSUM
NETIF_F_IPV6_CSUM
NETIF_F_HIGHDMA
NETIF_F_HW_VLAN_CTAG_RX
NETIF_F_RXCSUM
NETIF_F_HW_VLAN_STAG_RX

Down in the slave ports on the Marvel switch we have:

In function   int dsa_slave_create(struct dsa_port *port)
about line 2640 of slave.c
     slave_dev->vlan_features = master->vlan_features;

and a few lines later, this function   void 
dsa_slave_setup_tagger(struct net_device *slave)    is called
about line 2553 of slave.c
     slave->features = master->vlan_features | NETIF_F_HW_TC;

Possibly a bit superfluous in regards to the fact that 
master->vlan_features is already applied in dsa_slave_create?
luckily it doesn't look like anything touches that before going to the 
setu pfunction.
Anyway.
Added a debug print prior to that to get the features values prior to copy.
(Without modified vlan_features in stmmac driver)
mv88e6085 stmmac-0:00 wifi (uninitialized): slave->features 
0x0000000000000000  master->vlan_features   0x0000000000000020
So thats just:
NETIF_F_HIGHDMA_BIT

And with the modified vlan features in the stmmac driver we get:
mv88e6085 stmmac-0:00 wifi (uninitialized): slave->features 
0x0000000000000000  master->vlan_features   0x0000410000000133

So the stmmac vlan_feature flags are ending up in the marvells port 
feature flags?
Kind of makes sense? put I'm not sure how that gets applied down the 
chain at each stage.
Thats about where I'm at sofar as I'm not sure where this "feature" flag 
gets used.

Possibly
nt skb_csum_hwoffload_help(struct sk_buff *skb,
                 const netdev_features_t features)

But thats getting well into the mud for me..

Cheers
     Richard


