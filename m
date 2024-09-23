Return-Path: <netdev+bounces-129236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990997E682
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF751F21DCA
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857E34CDE;
	Mon, 23 Sep 2024 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="lUZGi4zE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFE1C6B8;
	Mon, 23 Sep 2024 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076429; cv=none; b=cxNipNWXlnVawZvD0zHO4xAhO2AqblgCrIuzTr50O96deW2oG4I/RMhD5iBXl5Jji2xNwTRfOue61YtZeA1JyGbVwBQX/QB7n5NzbXMuMreChuO61MsenNdSSBM1CVsQp/AqUtXk0Xjg4i6LNPcFMmDa5cBQwzAzSXMEv6fM4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076429; c=relaxed/simple;
	bh=2aH6XQuWemR1lNsSJNVlynLcDCscjjrjj8wknqDuQcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fecU62zh3j3JXfxTWju6SZ8rypZ0FI/AFwDpdFvX6wwyqgpjFxn5L//YkUSYyKC4iu5AcBenBNPAZVNzn3WUJTYwvXVM9TX+2OaLFNHUpeRy4pm8W4lCF6bnL0mIJ3NwI1itNQC9CHm6Khxz/iq7U/pYTeIefo3WZahy+co5xZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=lUZGi4zE; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1727076417; bh=2aH6XQuWemR1lNsSJNVlynLcDCscjjrjj8wknqDuQcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lUZGi4zEUUF3E6PwfEUnq1FVw7fIwWX7rbv0R6lx4MKNhaXsEL90hRpcVGpUymv/H
	 RhT1V9Husx1S1IAD1vI7pS9ka4/eZgC/EGYjpaVWBagzqcT5v2yUjsM0L2jsH++isQ
	 F98aQB4GR07fhLjThlnuhaUMvH4paDee6qOxpgT8=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 23 Sep 2024 09:26:56 +0200 (CEST)
Message-ID: <6372b85a-216c-472b-82de-2b4d2ca22008@avm.de>
Date: Mon, 23 Sep 2024 09:26:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
 <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
 <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
 <34a42cfa-9f72-4a66-be63-e6179e04f86e@blackwall.org>
 <74baea7a-318c-482b-9e27-4a9b057b58f3@avm.de>
 <298aa961-5827-4fa9-bfdc-66267d08198c@blackwall.org>
Content-Language: de-DE
From: Thomas Martitz <tmartitz-oss@avm.de>
In-Reply-To: <298aa961-5827-4fa9-bfdc-66267d08198c@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1727076416-C1D5B0CA-864F8123/0/0
X-purgate-type: clean
X-purgate-size: 11520
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Am 22.09.24 um 20:22 schrieb Nikolay Aleksandrov:
> On 9/20/24 16:28, Thomas Martitz wrote:
>> Am 20.09.24 um 08:42 schrieb Nikolay Aleksandrov:
>>> On 19/09/2024 14:13, Thomas Martitz wrote:
>>>> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>>>>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>>>>> Currently, there is only a warning if a packet enters the bridge
>>>>>> that has the bridge's or one port's MAC address as source.
>>>>>>
>>>>>> Clearly this indicates a network loop (or even spoofing) so we
>>>>>> generally do not want to process the packet. Therefore, move the check
>>>>>> already done for 802.1x scenarios up and do it unconditionally.
>>>>>>
>>>>>> For example, a common scenario we see in the field:
>>>>>> In a accidental network loop scenario, if an IGMP join
>>>>>> loops back to us, it would cause mdb entries to stay indefinitely
>>>>>> even if there's no actual join from the outside. Therefore
>>>>>> this change can effectively prevent multicast storms, at least
>>>>>> for simple loops.
>>>>>>
>>>>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>>>>> ---
>>>>>>    net/bridge/br_fdb.c   |  4 +---
>>>>>>    net/bridge/br_input.c | 17 ++++++++++-------
>>>>>>    2 files changed, 11 insertions(+), 10 deletions(-)
>>>>>>
>>>>>
>>>>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>>>>> of an additional lookup because you want to filter src address. You can filter
>>>>> it in many ways that won't affect others and don't require kernel changes
>>>>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>>>>> break some (admittedly weird) setup.
>>>>>
>>>>
>>>> Hello Nikolay,
>>>>
>>>> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
>>>>
>>>> So I understand that performance is your main concern. Some users might
>>>> be willing to pay for that cost, however, in exchange for increased
>>>> system robustness. May I suggest per-bridge or even per-port flags to
>>>> opt-in to this behavior? We'd set this from our userspace. This would
>>>> also address the concern to not break weird, existing setups.
>>>>
>>>
>>> That is the usual way these things are added, as opt-in. A flag sounds good
>>> to me, if you're going to make it per-bridge take a look at the bridge bool
>>> opts, they were added for such cases.
>>>
>>
>> Alright. I'll approach this. It may take a little while because the LPC
>> talks are so amazing that I don't want to miss anything.
>>
>> I'm currently considering a per-bridge flag because that's fits our use
>> case. A per-port flag would also work, though, and may fit the code
>> there better because it's already checking for other port flags
>> (BR_PORT_LOCKED, BR_LEARNING). Do you have a preference?
>>
> 
> Hi,
> Sorry for the delayed response, but I was traveling over the weekend
> and I got some more time to think about this. There is a more subtle
> problem with this change - you're introducing packet filtering based on
> fdb flags in the bridge, but it's not the bridge's job to filter
> packets. We have filtering subsystems - netfilter, tc or ebpf, if they
> lack some functionality you need to achieve this, then extend them.
> Just because it's easy to hard-code this packet filter in the bridge
> doesn't make it right, use the right subsystem if you want to filter.
> For example you can extend nft's bridge matching capabilities.
> More below.

Hi,

Alright, I understand that you basically object to the whole idea of
filtering in the bridge code directly (based on fdb flags). While that
makes some sense, I found that basically the same filter that I already
exists for mac802.11 use cases:

                } else if (READ_ONCE(fdb_src->dst) != p ||
                           test_bit(BR_FDB_LOCAL, &fdb_src->flags)) { <-- drop if local source on ingress
                        /* FDB mismatch. Drop the packet without roaming. */
                        goto drop;

In fact, this very code motivated me because I'm just adding one more
condition to an existing drop mechanism after all. In this area there
are also further drops based on fdb flags. 

Anyway, dropping isn't actually my main intent, although it's a welcome
side effect because it immediately stops loops. What I'm after most is
avoiding local proccessing, both in the IGMP/MLD snooping code and up in
the stack. In my opinion, it would be good if the bridge code can be more
resilient against loops (and spoofers) by not processing its own packets
as if it came from somebody else. My main issue is: the IGMP/MLD snooping
code becomes convinced that there are subscribers on the network even if
here aren't, just by processing IGMP/MLD joins that were send out a moment
ago. That said, we could still decide to forward these packets and not
filter them completely.

And I still think that should also be the default, especially if we block
only local processing but not forwarding. You don't feel this robustness
is not necessary (or consider the performance impact too high) then I
accept that and withdraw my proposal. I just thought it would be a useful
addition to the bridge's out-of-the-box stability.

All that said, I'll explore a netfilter solution (see below) to avoid
maintaing out-of-tree patches.


> 
> 
>> Although that would risk breaking existing weird set-ups. So unless you
>> signal preference for this I will not persue that any further.
>>
>>
>>>> This would be analogous to the check added for MAB in 2022
>>>> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
>>>>
>>>> While there are maybe other methods, only in the bridge code I may
>>>> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
>>>> typically not only a single MAC adress to check for, but such a local
>>>> FDB is maintained for the enslaved port's MACs as well. Replicating
>>>> the check outside of the bridge receive code would be orders more
>>>> complex. For example, you need to update the filter each time a port is
>>>> added or removed from the bridge.
>>>>
>>>
>>> That is not entirely true, you can make a solution that dynamically compares
>>> the mac addresses of net devices with src mac of incoming frames, you may need
>>> to keep a list of the ports themselves or use ebpf though. It isn't complicated
>>> at all, you just need to keep that list updated when adding/removing ports
>>> you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
>>> complicated about it and we won't have to maintain another bridge option forever.
>>
>> I'm really trying to be open-minded about other possible ways, but I'm struggling.
>>
>> For one, you know we're making a firmware for our home routers. We control all the
>> code, from boot-loader to kernel to user space, so it's often both easier and more 
>> reliable to make small modifications to the kernel than to come up with complex
>> user space. In other words, we don't have any eBPF tooling in place currently and
>> that would be a major disruption to our workflow. We don't even use LLVM, just GCC
>> everywhere. I'd have to justify introducing all the eBPF tooling and processes (in
>> order to avoid having a small patch to kernel) to my colleagues and my manager. I
>> don't think that'd work out well. I'm pretty sure other companies in our field are
>> in the same situation.
> 
> That really is your problem, it doesn't change the fact it can be solved
> using eBPF or netfilter. I'm sorry but this is not an argument for this
> mailing list or for accepting a patch. It really is a pretty simple
> solution - take ipmonitor (from iproute2/ip), strip all and just look
> for NEWLINK then act on master changes: on new master add port/mac to
> table and vice-versa. What's so complex? You can also do it with
> netfilter and nftables, just update a matching nft table on master
> changes. Moreover these events are not usually many. In fact since you
> control user-space entirely I'd add it to the enslave/release pieces in
> whatever network management tools you're using, so when an interface is
> enslaved its mac is added to that filter and removed when it's released,
> then you won't need to have a constantly running process to monitor,
> even simpler.
> 
> Actually it took me about 15 minutes to get a working solution to this
> problem just by reusing the ipmonitor and iproute2 netlink code with a
> nft table hooked on port's ingress. It is that simple, but I'd prefer to
> do it in the network manager on port add/del and avoid monitoring
> altogether.


Impressive!


> 
>>
>> Furthermore, from what I understand, an eBPF filter would not perform as good
>> (performance also matters for us!) because there is no hook at this point. I'd need
>> to hook earlier, perhaps using XDP (?), and that might have to process many more
>> packets than those that enter the bridge. On the user space side, I'd need to have
>> a daemon that update bpf maps or something like that to keep the list updated. I'm
>> new to eBPF, so sorry if it seems more complex to me than it is.
> 
> It will process the same amount of packets that the bridge would.


If we add vlan devices the tagged packets that don't enter the bridge would still be
processed by eBPF.

On top, we have also a custom hook that may consume packets for other reasons before
they enter the bridge. But that's not your problem.


> 
>>
>> For netfilter, I looked into that also, but the NF_BR_LOCAL_IN hook is too late. One
>> of the biggest problems we try to solve is that looping IGMP packets enter the bridge
>> and acually refresh MDBs that should normally timeout (we send JOINs for the addresses
>> out but the MDB should only refresh when JOINs from other systems are received). Then,
>> even if the filter location would fit, I'd effectively just re-implement the bridge's
>> FDB lookup which rings bells that it's not an effective approach.
>>
>> So both alternatives you projected are not a good fit to the actual problem and may
>> require vastly more complex user space.
> 
> Is that all the research? You read 2 minutes of webpages and diagonally
> scanned some source code, did you see the other bridge netfilter
> hooks? You can extend netfilter and match in any of them if you insist
> on having a kernel solution. For example match in NF_BR_PRE_ROUTING.
> You can extend nft's bridge support and match anything you need.


Thank you very much for this! I literally looked for NF_HOOK in br_input.c
to find suitable entry points and the NF_BR_PRE_ROUTING hook didn't occur
to me (it's handled differently). I really should have looked more carefully
over the entire file.

Also, I should have known it anyway, I'm working with the bridge code for
quite a long time already and considered myself experienced in this area
(have to reconsider this now...).

So sorry for my incomplete research, NF_BR_PRE_ROUTING seems like a nice
fit actually. I'll explore this further, and assuming this works, we can
drop my proposal altogether. From a first look it should work, altough we
wouldn't be able to just block out local processing (can just have drop or
not) if need arises and we have to re-implement MAC lookup.

I have to apologize for wasting your time but at least I have lerned a lesson.

Best regards.

