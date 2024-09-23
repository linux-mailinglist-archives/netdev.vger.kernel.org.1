Return-Path: <netdev+bounces-129300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D597EBFC
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591DC1C20FF8
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83C198E79;
	Mon, 23 Sep 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C/QdCn7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51021198857
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096611; cv=none; b=YmKhRxj7FVaH5Q20QDupEkOC9c0uWgjoR4dkCJUYOTd3dtDxGN3sJ5XLloPopTWeAR3/uTlvZFQgNw4X+Qt49tpkGM9OBAsOWR6vYawglIdqELTiLf+L71YO9NzbLeRHZhzPG5EOlQHH4Zt3BjpRC25kA+pj5rg6alRf7Nlnbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096611; c=relaxed/simple;
	bh=Ove3L3BSfoCTMLs6EgReDh0zoAt3oF6Ly4/dt67jBSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXpez/9n4qWvOn6RFTnb1VUVtw7PzMeF/Rv3fwJlShOUXMMBajuxq46zJHH+UYv5N5Lbvts0F5aQeBRkd2eIRzBDu/oPsNW/9rnlwJov0WWdagSkwBQc9cOq3SpK6J2knu6FFeJKSwutqt/Rw345fe28hwKyK0UwZPT2e+Gtx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C/QdCn7W; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-536748c7e9aso5184215e87.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727096607; x=1727701407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVcx1KWj97AoUyMrh8lgNL2QRY1e59cxTG7tBGdTdos=;
        b=C/QdCn7Wh7KvFwFmedT9u4GcwPV9n2GGHYScfIjb214237aLabZfNmsnYINAbtNC2s
         l4KwSqOlM2HnBlEMtEb2dSEdXxbeAkH0Wbc3DSjmUenVxyWWUVwzGXbcKFTK9Myzxf30
         ZkcpndK90gaKwHh4wQ3Hv+/wDVSIeu7GNlBr7YhkX43sPDbr/vEMqmqBTHN7oqFEPb5u
         +Nwi6ttvmrdEtSeec2r75/vbytXVSlcQkLrUumxheHdhSSF5Aqo/cftWN2pCwAp4QN0U
         ZQr7j9c0dXPPRrvHZ3P0yQ0yOzbNREvd9pukOLgxIkiulHWEcLJ/I2iO/AdzrG2Tb14c
         kVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096607; x=1727701407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVcx1KWj97AoUyMrh8lgNL2QRY1e59cxTG7tBGdTdos=;
        b=BswlXdduyAr1aeU5Egxc3ernVoPpHfNXt6zv1cq31vPyFFYZrUW4Z++f/2Fx4S3uCE
         m2NKHlNtxgHf0rnQTknv6XDNiryc89m7k+MiHJeoVu+yBps+zARYGrqTdeB1Bd9t2PM/
         HFmhzyNhbUsx3O5e2u8JlzKSigTWJFlO0IwXYxE+rJQ/9t0xEmvJOcnB9Ei5jh+1jVvG
         6qiWOjAgyz9E51mCCrrU2yrU5HwonXbR+dqxYgNrHrRpYiLavFF+VANGues5xQlgLKVh
         0h05fS9PEh/qyJ1f9WftPYND5t1iRUy0CiuKSJtK4GIoj9Z+C1qlvQewKI/1+k07Pt25
         Nt4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZCI6LI1bPo3uC4NaAuQ1HKSDofJzCzMRflbIVX4bpjgetcYWvsvo0wbK2Pd84aGAirpn6SrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztsKUOX2iOx//7vWKpYD2nlMRMmi2XYpqAOm7+Zp4F6nB6HDXe
	SlVF572YRvZj/4Vo0URK24wFpyPK1KQafQwofdDDGdHDGwXMBROiizpKLWYfBrj5sRI5Ow65iI1
	r8W8=
X-Google-Smtp-Source: AGHT+IHFl1ARzxSegLxQgrCowJEOWjJLRn1KdPZcEGzeQRjWkg0xnr9cgnFcUjTOHOny/7W+xCSIpw==
X-Received: by 2002:a05:6512:6d1:b0:52e:74d5:89ae with SMTP id 2adb3069b0e04-536ac32e458mr5810813e87.39.1727096607129;
        Mon, 23 Sep 2024 06:03:27 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a4777sm3257216e87.210.2024.09.23.06.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:03:26 -0700 (PDT)
Message-ID: <f6d3b34c-49d5-4d20-9e76-6c5158e56acd@blackwall.org>
Date: Mon, 23 Sep 2024 16:03:25 +0300
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
 <298aa961-5827-4fa9-bfdc-66267d08198c@blackwall.org>
 <6372b85a-216c-472b-82de-2b4d2ca22008@avm.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <6372b85a-216c-472b-82de-2b4d2ca22008@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/24 10:26, Thomas Martitz wrote:
> Am 22.09.24 um 20:22 schrieb Nikolay Aleksandrov:
>> On 9/20/24 16:28, Thomas Martitz wrote:
>>> Am 20.09.24 um 08:42 schrieb Nikolay Aleksandrov:
>>>> On 19/09/2024 14:13, Thomas Martitz wrote:
>>>>> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>>>>>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>>>>>> Currently, there is only a warning if a packet enters the bridge
>>>>>>> that has the bridge's or one port's MAC address as source.
>>>>>>>
>>>>>>> Clearly this indicates a network loop (or even spoofing) so we
>>>>>>> generally do not want to process the packet. Therefore, move the check
>>>>>>> already done for 802.1x scenarios up and do it unconditionally.
>>>>>>>
>>>>>>> For example, a common scenario we see in the field:
>>>>>>> In a accidental network loop scenario, if an IGMP join
>>>>>>> loops back to us, it would cause mdb entries to stay indefinitely
>>>>>>> even if there's no actual join from the outside. Therefore
>>>>>>> this change can effectively prevent multicast storms, at least
>>>>>>> for simple loops.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>>>>>> ---
>>>>>>>    net/bridge/br_fdb.c   |  4 +---
>>>>>>>    net/bridge/br_input.c | 17 ++++++++++-------
>>>>>>>    2 files changed, 11 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>
>>>>>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>>>>>> of an additional lookup because you want to filter src address. You can filter
>>>>>> it in many ways that won't affect others and don't require kernel changes
>>>>>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>>>>>> break some (admittedly weird) setup.
>>>>>>
>>>>>
>>>>> Hello Nikolay,
>>>>>
>>>>> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
>>>>>
>>>>> So I understand that performance is your main concern. Some users might
>>>>> be willing to pay for that cost, however, in exchange for increased
>>>>> system robustness. May I suggest per-bridge or even per-port flags to
>>>>> opt-in to this behavior? We'd set this from our userspace. This would
>>>>> also address the concern to not break weird, existing setups.
>>>>>
>>>>
>>>> That is the usual way these things are added, as opt-in. A flag sounds good
>>>> to me, if you're going to make it per-bridge take a look at the bridge bool
>>>> opts, they were added for such cases.
>>>>
>>>
>>> Alright. I'll approach this. It may take a little while because the LPC
>>> talks are so amazing that I don't want to miss anything.
>>>
>>> I'm currently considering a per-bridge flag because that's fits our use
>>> case. A per-port flag would also work, though, and may fit the code
>>> there better because it's already checking for other port flags
>>> (BR_PORT_LOCKED, BR_LEARNING). Do you have a preference?
>>>
>>
>> Hi,
>> Sorry for the delayed response, but I was traveling over the weekend
>> and I got some more time to think about this. There is a more subtle
>> problem with this change - you're introducing packet filtering based on
>> fdb flags in the bridge, but it's not the bridge's job to filter
>> packets. We have filtering subsystems - netfilter, tc or ebpf, if they
>> lack some functionality you need to achieve this, then extend them.
>> Just because it's easy to hard-code this packet filter in the bridge
>> doesn't make it right, use the right subsystem if you want to filter.
>> For example you can extend nft's bridge matching capabilities.
>> More below.
> 
> Hi,
> 
> Alright, I understand that you basically object to the whole idea of
> filtering in the bridge code directly (based on fdb flags). While that
> makes some sense, I found that basically the same filter that I already
> exists for mac802.11 use cases:
> 
>                 } else if (READ_ONCE(fdb_src->dst) != p ||
>                            test_bit(BR_FDB_LOCAL, &fdb_src->flags)) { <-- drop if local source on ingress
>                         /* FDB mismatch. Drop the packet without roaming. */
>                         goto drop;
> 
> In fact, this very code motivated me because I'm just adding one more
> condition to an existing drop mechanism after all. In this area there
> are also further drops based on fdb flags. 
> 

I was expecting you'd bring this code up :) but you've also taken it out
of context. It is a part of a larger feature which also creates locked
fdbs, and enforces certain policies which give user-space a chance to
authenticate user macs, i.e. MAC Authentication Bypass. Creating and
managing such fdbs can only be done from the bridge but also with the
help of user-space.

> Anyway, dropping isn't actually my main intent, although it's a welcome
> side effect because it immediately stops loops. What I'm after most is
> avoiding local proccessing, both in the IGMP/MLD snooping code and up in
> the stack. In my opinion, it would be good if the bridge code can be more
> resilient against loops (and spoofers) by not processing its own packets
> as if it came from somebody else. My main issue is: the IGMP/MLD snooping
> code becomes convinced that there are subscribers on the network even if
> here aren't, just by processing IGMP/MLD joins that were send out a moment
> ago. That said, we could still decide to forward these packets and not
> filter them completely.
> 
> And I still think that should also be the default, especially if we block
> only local processing but not forwarding. You don't feel this robustness
> is not necessary (or consider the performance impact too high) then I
> accept that and withdraw my proposal. I just thought it would be a useful
> addition to the bridge's out-of-the-box stability.
> 

You can decide to filter, I don't mind, but do it within the filtering
subsystems and not in the bridge. This is better for everyone -
interested parties would take the performance hit, but also you get more
flexibility and matching opportunities, tomorrow you might decide to
have more complex criteria.

> All that said, I'll explore a netfilter solution (see below) to avoid
> maintaing out-of-tree patches.
> 
> 
>>
>>
>>> Although that would risk breaking existing weird set-ups. So unless you
>>> signal preference for this I will not persue that any further.
>>>
>>>
>>>>> This would be analogous to the check added for MAB in 2022
>>>>> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
>>>>>
>>>>> While there are maybe other methods, only in the bridge code I may
>>>>> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
>>>>> typically not only a single MAC adress to check for, but such a local
>>>>> FDB is maintained for the enslaved port's MACs as well. Replicating
>>>>> the check outside of the bridge receive code would be orders more
>>>>> complex. For example, you need to update the filter each time a port is
>>>>> added or removed from the bridge.
>>>>>
>>>>
>>>> That is not entirely true, you can make a solution that dynamically compares
>>>> the mac addresses of net devices with src mac of incoming frames, you may need
>>>> to keep a list of the ports themselves or use ebpf though. It isn't complicated
>>>> at all, you just need to keep that list updated when adding/removing ports
>>>> you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
>>>> complicated about it and we won't have to maintain another bridge option forever.
>>>
>>> I'm really trying to be open-minded about other possible ways, but I'm struggling.
>>>
>>> For one, you know we're making a firmware for our home routers. We control all the
>>> code, from boot-loader to kernel to user space, so it's often both easier and more 
>>> reliable to make small modifications to the kernel than to come up with complex
>>> user space. In other words, we don't have any eBPF tooling in place currently and
>>> that would be a major disruption to our workflow. We don't even use LLVM, just GCC
>>> everywhere. I'd have to justify introducing all the eBPF tooling and processes (in
>>> order to avoid having a small patch to kernel) to my colleagues and my manager. I
>>> don't think that'd work out well. I'm pretty sure other companies in our field are
>>> in the same situation.
>>
>> That really is your problem, it doesn't change the fact it can be solved
>> using eBPF or netfilter. I'm sorry but this is not an argument for this
>> mailing list or for accepting a patch. It really is a pretty simple
>> solution - take ipmonitor (from iproute2/ip), strip all and just look
>> for NEWLINK then act on master changes: on new master add port/mac to
>> table and vice-versa. What's so complex? You can also do it with
>> netfilter and nftables, just update a matching nft table on master
>> changes. Moreover these events are not usually many. In fact since you
>> control user-space entirely I'd add it to the enslave/release pieces in
>> whatever network management tools you're using, so when an interface is
>> enslaved its mac is added to that filter and removed when it's released,
>> then you won't need to have a constantly running process to monitor,
>> even simpler.
>>
>> Actually it took me about 15 minutes to get a working solution to this
>> problem just by reusing the ipmonitor and iproute2 netlink code with a
>> nft table hooked on port's ingress. It is that simple, but I'd prefer to
>> do it in the network manager on port add/del and avoid monitoring
>> altogether.
> 
> 
> Impressive!
> 
> 
>>
>>>
>>> Furthermore, from what I understand, an eBPF filter would not perform as good
>>> (performance also matters for us!) because there is no hook at this point. I'd need
>>> to hook earlier, perhaps using XDP (?), and that might have to process many more
>>> packets than those that enter the bridge. On the user space side, I'd need to have
>>> a daemon that update bpf maps or something like that to keep the list updated. I'm
>>> new to eBPF, so sorry if it seems more complex to me than it is.
>>
>> It will process the same amount of packets that the bridge would.
> 
> 
> If we add vlan devices the tagged packets that don't enter the bridge would still be
> processed by eBPF.
> 

This processing could come down to a simple conditional statement
depending on how much vlan filtering you need. You wouldn't notice
its impact if implemented properly.

> On top, we have also a custom hook that may consume packets for other reasons before
> they enter the bridge. But that's not your problem.
> 
> 
>>
>>>
>>> For netfilter, I looked into that also, but the NF_BR_LOCAL_IN hook is too late. One
>>> of the biggest problems we try to solve is that looping IGMP packets enter the bridge
>>> and acually refresh MDBs that should normally timeout (we send JOINs for the addresses
>>> out but the MDB should only refresh when JOINs from other systems are received). Then,
>>> even if the filter location would fit, I'd effectively just re-implement the bridge's
>>> FDB lookup which rings bells that it's not an effective approach.
>>>
>>> So both alternatives you projected are not a good fit to the actual problem and may
>>> require vastly more complex user space.
>>
>> Is that all the research? You read 2 minutes of webpages and diagonally
>> scanned some source code, did you see the other bridge netfilter
>> hooks? You can extend netfilter and match in any of them if you insist
>> on having a kernel solution. For example match in NF_BR_PRE_ROUTING.
>> You can extend nft's bridge support and match anything you need.
> 
> 
> Thank you very much for this! I literally looked for NF_HOOK in br_input.c
> to find suitable entry points and the NF_BR_PRE_ROUTING hook didn't occur
> to me (it's handled differently). I really should have looked more carefully
> over the entire file.
> 
> Also, I should have known it anyway, I'm working with the bridge code for
> quite a long time already and considered myself experienced in this area
> (have to reconsider this now...).
> 
> So sorry for my incomplete research, NF_BR_PRE_ROUTING seems like a nice
> fit actually. I'll explore this further, and assuming this works, we can
> drop my proposal altogether. From a first look it should work, altough we
> wouldn't be able to just block out local processing (can just have drop or
> not) if need arises and we have to re-implement MAC lookup.
> 
> I have to apologize for wasting your time but at least I have lerned a lesson.
> 
> Best regards.

No need to apologize, it's good to have these discussions and to make
things clearer.

Cheers,
 Nik

