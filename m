Return-Path: <netdev+bounces-49914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8067F3CF5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 05:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE6282772
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 04:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57F2BAF6;
	Wed, 22 Nov 2023 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecC+UzFY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63492C135
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 04:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDAC433C8;
	Wed, 22 Nov 2023 04:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700628069;
	bh=R237Zq7bAkchInPLGKnptOv10qr1OYjffPRZO9QaOQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ecC+UzFYq3/KKgaESeYlwjiuUG52hBysJMZKx4Z641NKZtNmD+DikmjDhD5RHYgDD
	 c8rRrhTjREjPRxN2e5lHP3umTtbglLx18vI4mWnmiRyIC0Y+LmqgfCyjQP3z3SwwSJ
	 uS8MVhGoSkSTB75eWeWmFlgldMLYHMEecvnWjysM431FHtTKpn8XpQten8DkM7qwIS
	 wQYHHsJN3o/PVBH7o4HRFcZh42LBCt38BaVgZW8RLFXz47BDcEFzeG3NNF4K6Kl+94
	 7sVD55ltdLDHz3xSFJf42rBtmCZMjkGgqSzLFzskWS8semurVGDtTLSctvBfEwvT25
	 I2v5JCgajlhQA==
Message-ID: <56cb8302-b6a0-4c95-86cc-769fd7ddf815@kernel.org>
Date: Wed, 22 Nov 2023 14:41:04 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: require supported_interfaces to be
 filled
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1q0K1u-006EIP-ET@rmk-PC.armlinux.org.uk>
 <13087238-6a57-439e-b7cb-b465b9e27cd6@kernel.org>
 <ZVzBokGsPvLKWV7s@shell.armlinux.org.uk>
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <ZVzBokGsPvLKWV7s@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/11/23 00:41, Russell King (Oracle) wrote:
> On Wed, Nov 22, 2023 at 12:19:38AM +1000, Greg Ungerer wrote:
>> Hi Russell,
>>
>> On 20/5/23 20:41, Russell King (Oracle) wrote:
>>> We have been requiring the supported_interfaces bitmap to be filled in
>>> by MAC drivers that have a mac_select_pcs() method. Now that all MAC
>>> drivers fill in the supported_interfaces bitmap, it is time to enforce
>>> this. We have already required supported_interfaces to be set in order
>>> for optical SFPs to be configured in commit f81fa96d8a6c ("net: phylink:
>>> use phy_interface_t bitmaps for optical modules").
>>>
>>> Refuse phylink creation if supported_interfaces is empty, and remove
>>> code to deal with cases where this mask is empty.
>>>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>> ---
>>> I believe what I've said above is indeed the case, but there is always
>>> the chance that something has been missed and this will cause breakage.
>>> I would post as RFC and ask for testing, but in my experience that is
>>> a complete waste of time as it doesn't result in any testing feedback.
>>> So, it's probably better to get it merged into net-next and then wait
>>> for any reports of breakage.
>>
>> This commit breaks a platform I have with a Marvell 88e6350 switch.
>> During boot up it now fails with:
>>
>>      ...
>>      mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
>>      mv88e6085 d0072004.mdio-mii:11: phylink: error: empty supported_interfaces
>>      error creating PHYLINK: -22
>>      mv88e6085: probe of d0072004.mdio-mii:11 failed with error -22
>>      ...
>>
>> The 6350 looks to be similar to the 6352 in many respects, though it lacks
>> a SERDES interface, but it otherwise mostly seems compatible. Using the 6352
>> phylink_get_caps function instead of the 6185 one fixes this:
>>
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -5418,7 +5418,7 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
>>          .set_max_frame_size = mv88e6185_g1_set_max_frame_size,
>>          .stu_getnext = mv88e6352_g1_stu_getnext,
>>          .stu_loadpurge = mv88e6352_g1_stu_loadpurge,
>> -       .phylink_get_caps = mv88e6185_phylink_get_caps,
>> +       .phylink_get_caps = mv88e6352_phylink_get_caps,
>>   };
> 
> Based on what you say, this is probably correct, but I've no idea as I
> don't have any data on the 88e6350.

I am thinking a dedicated 6350 phylink_get_caps may be better here now,
since the 6350 does not have a SERDES lane like the 6352.


>> The story doesn't quite end here though. With this fix in place support
>> for the 6350 is then again broken by commit b92143d4420f ("net: dsa:
>> mv88e6xxx: add infrastructure for phylink_pcs"). This results in a dump
>> on boot up:
>>
>>      ...
>>      mv88e6085 d0072004.mdio-mii:11: switch 0x3710 detected: Marvell 88E6350, revision 2
>>      8<--- cut here ---
>>      Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
>>      [00000000] *pgd=00000000
>>      Internal error: Oops: 5 [#1] ARM
>>      Modules linked in:
>>      CPU: 0 PID: 8 Comm: kworker/u2:0 Not tainted 6.7.0-rc2-dirty #26
>>      Hardware name: Marvell Armada 370/XP (Device Tree)
>>      Workqueue: events_unbound deferred_probe_work_func
>>      PC is at mv88e6xxx_port_setup+0x1c/0x44
>>      LR is at dsa_port_devlink_setup+0x74/0x154
>>      pc : [<c057ea24>]    lr : [<c0819598>]    psr: a0000013
>>      sp : c184fce0  ip : c542b8f4  fp : 00000000
>>      r10: 00000001  r9 : c542a540  r8 : c542bc00
>>      r7 : c542b838  r6 : c5244580  r5 : 00000005  r4 : c5244580
>>      r3 : 00000000  r2 : c542b840  r1 : 00000005  r0 : c1a02040
>>      ...
>>
>> I can see that the mv88e6350_ops struct doesn't have an initializer for
>> pcs_ops.
> 
> You mentioned that the 6350 doesn't have serdes, so there should be no
> PCS. mv88e6xxx_port_setup() probably should be doing:
> 
> -	if (chip->info->ops->pcs_ops->pcs_init) {
> +	if (chip->info->ops->pcs_ops &&
> +	    chip->info->ops->pcs_ops->pcs_init) {

Yes, that probably makes more sense.
With that change in place the probing works again, and does not need
a pcs_ops entry for the 6350.

Thanks
Greg



>> This gets the 6350 switch back to working again (on current linux 6.7-rc2).
>> I am not entirely sure if this needs a dedicated phylink_get_caps
>> and pcs_ops for the 6350, or if it is safe to use the 6352 ones?
> 
> Without knowing what the 6350 cmode values are, I can't comment.
> 
>> Looking at the mv88e6351_ops I am guessing it is going to suffer the
>> same problems too.
> 
> Again, it's a similar problem - I have no information for the 6351
> so I could only make guesses.
> 

