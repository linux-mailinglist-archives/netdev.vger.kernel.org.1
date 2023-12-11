Return-Path: <netdev+bounces-55773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8982380C473
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EE61F21295
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3670021340;
	Mon, 11 Dec 2023 09:24:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F578101
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:24:09 -0800 (PST)
Received: (qmail 12920 invoked by uid 5089); 11 Dec 2023 09:24:06 -0000
Received: by simscan 1.2.0 ppid: 12803, pid: 12804, t: 0.4622s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 11 Dec 2023 09:24:05 -0000
Message-ID: <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
Date: Mon, 11 Dec 2023 17:23:47 +0800
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
To: Jakub Kicinski <kuba@kernel.org>, vinschen@redhat.com
Cc: netdev@vger.kernel.org
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
In-Reply-To: <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> Richard Tresidder
>
>
> On 9/12/2023 3:06 pm, Richard Tresidder wrote:
>> On 9/12/2023 2:12 am, Jakub Kicinski wrote:
>>> On Fri, 8 Dec 2023 14:03:25 +0800 Richard Tresidder wrote:
>>>> I've looked through the diffset 6.3.3 >>> 6.6.3 on the driver
>>>> drivers\net\ethernet\stmicro\stmmac
>>>> But nothing is jumping out at me.
>>>>
>>>> I could use a pointer as to where to look to start tracing this.
>>> Bisection is good way to zero in on the bad change if you don't
>>> have much hard to rebase code in your tree.
>>>
>>> Otherwise you can dump the relevant registers and the descriptors
>>> (descriptors_status file in debugfs) and see if driver is doing
>>> anything differently on the newer kernel?
>>>
>> Thanks Jakub
>>   Yep I think I'll have to start bisecting things on Monday.
>> Luckily to work through this I shouldn't have to merge very much.
>> Have a great weekend
>>
>> Cheers
>>   Richard Tresidder
>>
> Hi Jakub
>    Ok the bad commit is the following:
> ************************************
> 6b2c6e4a938fece9b539c8085f21d17c5e6eb9de is the first bad commit
> commit 6b2c6e4a938fece9b539c8085f21d17c5e6eb9de
> Author: Corinna Vinschen <vinschen@redhat.com>
> Date:   Mon Apr 17 21:28:45 2023 +0200
>
>     net: stmmac: propagate feature flags to vlan
>
>     stmmac_dev_probe doesn't propagate feature flags to VLANs.  So 
> features
>     like offloading don't correspond with the general features and 
> it's not
>     possible to manipulate features via ethtool -K to affect VLANs.
>
>     Propagate feature flags to vlan features.  Drop TSO feature because
>     it does not work on VLANs yet.
>
>     Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
>     Link: 
> https://lore.kernel.org/r/20230417192845.590034-1-vinschen@redhat.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> ****************************************
> From back in the work for 6.4-rc1
>
> Theres a single line addition  approx line 7506 
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>
> ndev->vlan_features |= ndev->features;
>
> Commenting this out and things work again.
> ***   BAD COMMENT!  We're not using VLANs on this interface, or in 
> this system at all. ***   BAD COMMENT!
> Also verified I had reenabled tx crc offload during this test.
>
> Cheers
>   Richard Tresidder
>
Actually my apologies we are using VLAN. I'd forgot how a switch was 
linked in..
We use the SOC's internal  STMMAC interface to connect to a Marvel 
switch IC and expose each port individually using vlan, I'd forgot that 
part.
It's an  88E6352-xx-TFJ2I000  device utilising the 'marvell,mv88e6085' 
compatible driver  in drivers\net\dsa\mv88e6xxx

Cheers
    Richard Tresidder


