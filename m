Return-Path: <netdev+bounces-129200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4697E2E3
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 20:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779102813B3
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7AE2CCAA;
	Sun, 22 Sep 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ewRP9qBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C182C1AC
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727029355; cv=none; b=bOeyvORbfR9c18bJBZFPTFxyrHT8TvI2pNfn6mGn38mO+UUG2uC94I0TtVk1NRtnxshl7LMTTTvA2edxmcNIXg9xpVoakzQXTvKpzOyeulr6+3XH5VMCAq/OxBb7k/FOAS4xhRQ6IKweoToFfdcpYaIJk3v6VVDdxANUkIwWMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727029355; c=relaxed/simple;
	bh=b/R2SwfuMm037MMujP7PtuDdEuxKb9MvubIzT8juS5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbbCloki7lDlwHgmDHcJ8IR85B2oRCojywyK6LLAJ0+Rs6q43CEjH02oFCs1KG7bLSj94fdbwuzIkREYZE5Ofk0KZwScS+jfwOHoAzNeDoVXWZvywJwJ7OgIxs3Gml21UT+XotzFJn/DdL2q2lFvd1aovSKlZYjfWRxKWEMHvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ewRP9qBs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75de9a503so31859541fa.0
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727029351; x=1727634151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNA03ERbIlH39Szbd3vyP1tsJQ3hmLb/bAIchoa/XuQ=;
        b=ewRP9qBsRrAp8n5kMrRrWvxYj6f0Bpf7lgYEpdj+t2nWL8BUHk/HiTHNJQ6kZZcLmK
         9WDlpxvjYFrfnfoRvVHdjFN1tf5f7KS9RBZatK4g3dieBZa9aM1wvZmV6TNYAqGsyXRG
         +23XNeby+4rqFZDfcRFszQwG7tJ5bLrZ0DB+ph/QqaCpbNRzJiINiRaxJ7ms4CWrGdQ5
         REMn5JWlInpo6FNCq0ErmaKHGBY0Y9p+nUQnUsoWrOEn6Xm48iL/QhWozJKXXv7IXjFV
         UPZdeHDICPu1pEix0lswuyJPy6CcJppYp/Ki1sn5U6syW+SyQ47Eego/355WAyeGis1F
         UTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727029351; x=1727634151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNA03ERbIlH39Szbd3vyP1tsJQ3hmLb/bAIchoa/XuQ=;
        b=R2PgNboZhxyyJ1i4L3lBaGT+w9tZ2wDlqnUdknU1aZ/xyV6Bo2yMXaEonaJ8eIZBn8
         xo4crol72rsjn4kygYjOYKaFc6uaaYpNOuIugWDSgMVzGqNH5pg93KikjpcvwJgXOU/l
         VSPOiy28K+zhLnmn8CeYWzuh5JyVWLHvkeuI++WJC9/CxEqCaL8r47vxaSeMPO3cgVZ+
         R66MP8u7JpZEv8tZ45mRDXYzduTSC6xCpcWgJOdloXIBBPcSN80bpjqOtcHG0MoKSvmq
         xXE13MjeK0jOd/nc4HUxK2vZ1X9qoKM/h1RR2eSGA/n01Ja/NtPsjovZVxf4/4Yuraub
         W0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXOxyzpG7YuZOZEz49WF04TEPthX/QAO8kI1kaGL0IP0YGca+PiOi4wkmnnk+0N3ziQXSTU7qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfk6lt2ft+67jTsaXpgQ5VeM9mUC4CWa3gHyetrWcbIUp3XS+
	n8F77Bda8hE8vHrnLF8FAr7gquvNndOnezvYbxFU/BIU8sscFpCfEwu4q0+4g4lNOSmJX8StJPR
	j
X-Google-Smtp-Source: AGHT+IE5L/5PeUJb6j6IAjoz++K1l5ogr9SpTnOKfhAFOJDA44xV8TO6/MXVnyIM4wQHcvS7dNeUDA==
X-Received: by 2002:a05:6512:3b86:b0:536:796b:4d72 with SMTP id 2adb3069b0e04-536ac340923mr4941606e87.55.1727029350990;
        Sun, 22 Sep 2024 11:22:30 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096936sm3021955e87.150.2024.09.22.11.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 11:22:30 -0700 (PDT)
Message-ID: <298aa961-5827-4fa9-bfdc-66267d08198c@blackwall.org>
Date: Sun, 22 Sep 2024 21:22:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: Thomas Martitz <tmartitz-oss@avm.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
 <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
 <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
 <34a42cfa-9f72-4a66-be63-e6179e04f86e@blackwall.org>
 <74baea7a-318c-482b-9e27-4a9b057b58f3@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <74baea7a-318c-482b-9e27-4a9b057b58f3@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/20/24 16:28, Thomas Martitz wrote:
> Am 20.09.24 um 08:42 schrieb Nikolay Aleksandrov:
>> On 19/09/2024 14:13, Thomas Martitz wrote:
>>> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>>>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>>>> Currently, there is only a warning if a packet enters the bridge
>>>>> that has the bridge's or one port's MAC address as source.
>>>>>
>>>>> Clearly this indicates a network loop (or even spoofing) so we
>>>>> generally do not want to process the packet. Therefore, move the check
>>>>> already done for 802.1x scenarios up and do it unconditionally.
>>>>>
>>>>> For example, a common scenario we see in the field:
>>>>> In a accidental network loop scenario, if an IGMP join
>>>>> loops back to us, it would cause mdb entries to stay indefinitely
>>>>> even if there's no actual join from the outside. Therefore
>>>>> this change can effectively prevent multicast storms, at least
>>>>> for simple loops.
>>>>>
>>>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>>>> ---
>>>>>    net/bridge/br_fdb.c   |  4 +---
>>>>>    net/bridge/br_input.c | 17 ++++++++++-------
>>>>>    2 files changed, 11 insertions(+), 10 deletions(-)
>>>>>
>>>>
>>>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>>>> of an additional lookup because you want to filter src address. You can filter
>>>> it in many ways that won't affect others and don't require kernel changes
>>>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>>>> break some (admittedly weird) setup.
>>>>
>>>
>>> Hello Nikolay,
>>>
>>> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
>>>
>>> So I understand that performance is your main concern. Some users might
>>> be willing to pay for that cost, however, in exchange for increased
>>> system robustness. May I suggest per-bridge or even per-port flags to
>>> opt-in to this behavior? We'd set this from our userspace. This would
>>> also address the concern to not break weird, existing setups.
>>>
>>
>> That is the usual way these things are added, as opt-in. A flag sounds good
>> to me, if you're going to make it per-bridge take a look at the bridge bool
>> opts, they were added for such cases.
>>
> 
> Alright. I'll approach this. It may take a little while because the LPC
> talks are so amazing that I don't want to miss anything.
> 
> I'm currently considering a per-bridge flag because that's fits our use
> case. A per-port flag would also work, though, and may fit the code
> there better because it's already checking for other port flags
> (BR_PORT_LOCKED, BR_LEARNING). Do you have a preference?
> 

Hi,
Sorry for the delayed response, but I was traveling over the weekend
and I got some more time to think about this. There is a more subtle
problem with this change - you're introducing packet filtering based on
fdb flags in the bridge, but it's not the bridge's job to filter
packets. We have filtering subsystems - netfilter, tc or ebpf, if they
lack some functionality you need to achieve this, then extend them.
Just because it's easy to hard-code this packet filter in the bridge
doesn't make it right, use the right subsystem if you want to filter.
For example you can extend nft's bridge matching capabilities.
More below.

> But on the performance topic: In our environment (home routers for
> end-users) the bridge ports are always in BR_LEARNING mode (and this is
> the default port mode). In this mode, I don't actually introduce an
> additional lookup. br_fdb_update() is currenty always called for the source
> MAC and in that function there is already the check for BR_FDB_LOCAL and
> the warning. I basically only added the drop as a result of that test. So
> when you are worried about an additional lookup, are you considering
> scenarios where BR_LEARNING is not set on the ports? I do wonder how
> common these are, I currently don't have a good feeling for that. I hope
> you can expand a bit on that and enlighten me.
> 
> If you prefer, I could also make a patch that limits drop to BR_LEARNING
> mode. I could extend br_fdb_update() to return an indication and make
> the drop conditional on that (after the existing call). Something
> like the below pseudo-code:
> 
> 	if (p->flags & BR_LEARNING) {
> 		if (br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0) & BR_FDB_LOCAL)
> 			goto drop;
> 	}
> 

Oh no, this is worse.. definitely not.

> Although that would risk breaking existing weird set-ups. So unless you
> signal preference for this I will not persue that any further.
> 
> 
>>> This would be analogous to the check added for MAB in 2022
>>> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
>>>
>>> While there are maybe other methods, only in the bridge code I may
>>> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
>>> typically not only a single MAC adress to check for, but such a local
>>> FDB is maintained for the enslaved port's MACs as well. Replicating
>>> the check outside of the bridge receive code would be orders more
>>> complex. For example, you need to update the filter each time a port is
>>> added or removed from the bridge.
>>>
>>
>> That is not entirely true, you can make a solution that dynamically compares
>> the mac addresses of net devices with src mac of incoming frames, you may need
>> to keep a list of the ports themselves or use ebpf though. It isn't complicated
>> at all, you just need to keep that list updated when adding/removing ports
>> you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
>> complicated about it and we won't have to maintain another bridge option forever.
> 
> I'm really trying to be open-minded about other possible ways, but I'm struggling.
> 
> For one, you know we're making a firmware for our home routers. We control all the
> code, from boot-loader to kernel to user space, so it's often both easier and more 
> reliable to make small modifications to the kernel than to come up with complex
> user space. In other words, we don't have any eBPF tooling in place currently and
> that would be a major disruption to our workflow. We don't even use LLVM, just GCC
> everywhere. I'd have to justify introducing all the eBPF tooling and processes (in
> order to avoid having a small patch to kernel) to my colleagues and my manager. I
> don't think that'd work out well. I'm pretty sure other companies in our field are
> in the same situation.

That really is your problem, it doesn't change the fact it can be solved
using eBPF or netfilter. I'm sorry but this is not an argument for this
mailing list or for accepting a patch. It really is a pretty simple
solution - take ipmonitor (from iproute2/ip), strip all and just look
for NEWLINK then act on master changes: on new master add port/mac to
table and vice-versa. What's so complex? You can also do it with
netfilter and nftables, just update a matching nft table on master
changes. Moreover these events are not usually many. In fact since you
control user-space entirely I'd add it to the enslave/release pieces in
whatever network management tools you're using, so when an interface is
enslaved its mac is added to that filter and removed when it's released,
then you won't need to have a constantly running process to monitor,
even simpler.

Actually it took me about 15 minutes to get a working solution to this
problem just by reusing the ipmonitor and iproute2 netlink code with a
nft table hooked on port's ingress. It is that simple, but I'd prefer to
do it in the network manager on port add/del and avoid monitoring
altogether.

> 
> Furthermore, from what I understand, an eBPF filter would not perform as good
> (performance also matters for us!) because there is no hook at this point. I'd need
> to hook earlier, perhaps using XDP (?), and that might have to process many more
> packets than those that enter the bridge. On the user space side, I'd need to have
> a daemon that update bpf maps or something like that to keep the list updated. I'm
> new to eBPF, so sorry if it seems more complex to me than it is.

It will process the same amount of packets that the bridge would.

> 
> For netfilter, I looked into that also, but the NF_BR_LOCAL_IN hook is too late. One
> of the biggest problems we try to solve is that looping IGMP packets enter the bridge
> and acually refresh MDBs that should normally timeout (we send JOINs for the addresses
> out but the MDB should only refresh when JOINs from other systems are received). Then,
> even if the filter location would fit, I'd effectively just re-implement the bridge's
> FDB lookup which rings bells that it's not an effective approach.
> 
> So both alternatives you projected are not a good fit to the actual problem and may
> require vastly more complex user space.

Is that all the research? You read 2 minutes of webpages and diagonally
scanned some source code, did you see the other bridge netfilter
hooks? You can extend netfilter and match in any of them if you insist
on having a kernel solution. For example match in NF_BR_PRE_ROUTING.
You can extend nft's bridge support and match anything you need.

> 
> So I did consider alternatives, however making the check that's already there also
> drop the packets, is the most effective solution to our problems from my point of
> view.
> 

Again just because it's easy to hardcode the filter there, doesn't make
it right. If you want to filter then either extend one of the filtering
subsystems or do a hybrid solution.

> 
>>
>>> Since a very similar check exists already using a per-port opt-in flag,
>>> would a similar approach acceptable for you? If yes, I'd send a
>>> follow-up shortly.
>>>
>>
>> Yeah, that would work although I try to limit the new options as the bridge
>> has already too many options.
> 
> I understand that. I hope that new options are still possible if they're justified.
> 

This is not justified because the bridge is not about packet filtering
and hardcoding a packet filter in it is not ok.

Cheers,
 Nik

>>
>>> PS: I haven't spottet you, but in case you're at LPC in Vienna we can
>>> chat in person about it, I'm here.
>>>
>>
>> That would've been nice, but unfortunately I couldn't make it this year.
> 
> Too bad. I hope we get a chance on another conference. I first need to convince
> my managers that this trip was useful use of the company's resources, though!
> 
> Best regards,
> Thomas Martitz
> 
>>
>> Cheers,
>>   Nik
>>
>>> Best regards.
>>>
>>>
>>>> Cheers,
>>>>    Nik
>>>>
>>>
>>
>>
> 


