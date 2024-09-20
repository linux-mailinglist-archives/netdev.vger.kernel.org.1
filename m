Return-Path: <netdev+bounces-129085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD197D628
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665411F24D73
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5E1779BC;
	Fri, 20 Sep 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="AoMA2mq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15228176FA7;
	Fri, 20 Sep 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838902; cv=none; b=VY4sGz/BSoOXB2rSMACdSHNdrCFFdk3QdBrODPnK9nTsxoA5GAwfbvytiPkBQfEsIPBCfrRlB1NwzSp4RcCYgHGDGDcQ8HKymWUlI0i37G74YLYxRIdFZyueBtnic8sVRpVr9JcGwcN6C+jyksctw0dd6d9Xb26OQxFxUqhlgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838902; c=relaxed/simple;
	bh=tjut3LloppseGsR1O0G5COgVfq7OSaOJTi0Ue1s4EKU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HGwEi874tKimPMm0WkZBIUFmgyUd1loW+p9UsaMWadswFe/5or2lrd/v5rXWwJCG6QHU7yv0ZsDi89lk3lLd8i0o8zyTEzxux9VAB0DhihyFgcyrzdK1aivwH2+Ob6VP7t74dv4sx9Nm3N0UbQt2RT8SI8xVG2PqBu8j0mqaEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=AoMA2mq5; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1726838889; bh=tjut3LloppseGsR1O0G5COgVfq7OSaOJTi0Ue1s4EKU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=AoMA2mq5VpGfRJZAvdBg6fOB/VglXDRMDyP1izkluLXYR/24a1bNQEN3wVAmV/K3a
	 I8P/DXmkH81kk4uFdrdQBPaV4J56t+SecDC2wrAJuxl1eCRIIYsyyRqkxLfPJxFlK7
	 Xd3TVl1CYd0sd/xFNBv+pkaRZfrSEFdxEkazGyLg=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 15:28:09 +0200 (CEST)
Message-ID: <74baea7a-318c-482b-9e27-4a9b057b58f3@avm.de>
Date: Fri, 20 Sep 2024 15:28:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Thomas Martitz <tmartitz-oss@avm.de>
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
Content-Language: en-US-large
In-Reply-To: <34a42cfa-9f72-4a66-be63-e6179e04f86e@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1726838889-565B4B30-0132093B/0/0
X-purgate-type: clean
X-purgate-size: 7924
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Am 20.09.24 um 08:42 schrieb Nikolay Aleksandrov:
> On 19/09/2024 14:13, Thomas Martitz wrote:
>> Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
>>> On 19/09/2024 11:58, Thomas Martitz wrote:
>>>> Currently, there is only a warning if a packet enters the bridge
>>>> that has the bridge's or one port's MAC address as source.
>>>>
>>>> Clearly this indicates a network loop (or even spoofing) so we
>>>> generally do not want to process the packet. Therefore, move the check
>>>> already done for 802.1x scenarios up and do it unconditionally.
>>>>
>>>> For example, a common scenario we see in the field:
>>>> In a accidental network loop scenario, if an IGMP join
>>>> loops back to us, it would cause mdb entries to stay indefinitely
>>>> even if there's no actual join from the outside. Therefore
>>>> this change can effectively prevent multicast storms, at least
>>>> for simple loops.
>>>>
>>>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>>>> ---
>>>>    net/bridge/br_fdb.c   |  4 +---
>>>>    net/bridge/br_input.c | 17 ++++++++++-------
>>>>    2 files changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>
>>> Absolutely not, I'm sorry but we're not all going to take a performance hit
>>> of an additional lookup because you want to filter src address. You can filter
>>> it in many ways that won't affect others and don't require kernel changes
>>> (ebpf, netfilter etc). To a lesser extent there is also the issue where we might
>>> break some (admittedly weird) setup.
>>>
>>
>> Hello Nikolay,
>>
>> thanks for taking a look at the patch. I expected concerns, therefore the RFC state.
>>
>> So I understand that performance is your main concern. Some users might
>> be willing to pay for that cost, however, in exchange for increased
>> system robustness. May I suggest per-bridge or even per-port flags to
>> opt-in to this behavior? We'd set this from our userspace. This would
>> also address the concern to not break weird, existing setups.
>>
> 
> That is the usual way these things are added, as opt-in. A flag sounds good
> to me, if you're going to make it per-bridge take a look at the bridge bool
> opts, they were added for such cases.
> 

Alright. I'll approach this. It may take a little while because the LPC
talks are so amazing that I don't want to miss anything.

I'm currently considering a per-bridge flag because that's fits our use
case. A per-port flag would also work, though, and may fit the code
there better because it's already checking for other port flags
(BR_PORT_LOCKED, BR_LEARNING). Do you have a preference?

But on the performance topic: In our environment (home routers for
end-users) the bridge ports are always in BR_LEARNING mode (and this is
the default port mode). In this mode, I don't actually introduce an
additional lookup. br_fdb_update() is currenty always called for the source
MAC and in that function there is already the check for BR_FDB_LOCAL and
the warning. I basically only added the drop as a result of that test. So
when you are worried about an additional lookup, are you considering
scenarios where BR_LEARNING is not set on the ports? I do wonder how
common these are, I currently don't have a good feeling for that. I hope
you can expand a bit on that and enlighten me.

If you prefer, I could also make a patch that limits drop to BR_LEARNING
mode. I could extend br_fdb_update() to return an indication and make
the drop conditional on that (after the existing call). Something
like the below pseudo-code:

	if (p->flags & BR_LEARNING) {
		if (br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0) & BR_FDB_LOCAL)
			goto drop;
	}

Although that would risk breaking existing weird set-ups. So unless you
signal preference for this I will not persue that any further.


>> This would be analogous to the check added for MAB in 2022
>> (commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").
>>
>> While there are maybe other methods, only in the bridge code I may
>> access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
>> typically not only a single MAC adress to check for, but such a local
>> FDB is maintained for the enslaved port's MACs as well. Replicating
>> the check outside of the bridge receive code would be orders more
>> complex. For example, you need to update the filter each time a port is
>> added or removed from the bridge.
>>
> 
> That is not entirely true, you can make a solution that dynamically compares
> the mac addresses of net devices with src mac of incoming frames, you may need
> to keep a list of the ports themselves or use ebpf though. It isn't complicated
> at all, you just need to keep that list updated when adding/removing ports
> you can even do it with a simple ip monitor and a bash script as a poc, there's nothing
> complicated about it and we won't have to maintain another bridge option forever.

I'm really trying to be open-minded about other possible ways, but I'm struggling.

For one, you know we're making a firmware for our home routers. We control all the
code, from boot-loader to kernel to user space, so it's often both easier and more 
reliable to make small modifications to the kernel than to come up with complex
user space. In other words, we don't have any eBPF tooling in place currently and
that would be a major disruption to our workflow. We don't even use LLVM, just GCC
everywhere. I'd have to justify introducing all the eBPF tooling and processes (in
order to avoid having a small patch to kernel) to my colleagues and my manager. I
don't think that'd work out well. I'm pretty sure other companies in our field are
in the same situation.

Furthermore, from what I understand, an eBPF filter would not perform as good
(performance also matters for us!) because there is no hook at this point. I'd need
to hook earlier, perhaps using XDP (?), and that might have to process many more
packets than those that enter the bridge. On the user space side, I'd need to have
a daemon that update bpf maps or something like that to keep the list updated. I'm
new to eBPF, so sorry if it seems more complex to me than it is.

For netfilter, I looked into that also, but the NF_BR_LOCAL_IN hook is too late. One
of the biggest problems we try to solve is that looping IGMP packets enter the bridge
and acually refresh MDBs that should normally timeout (we send JOINs for the addresses
out but the MDB should only refresh when JOINs from other systems are received). Then,
even if the filter location would fit, I'd effectively just re-implement the bridge's
FDB lookup which rings bells that it's not an effective approach.

So both alternatives you projected are not a good fit to the actual problem and may
require vastly more complex user space.

So I did consider alternatives, however making the check that's already there also
drop the packets, is the most effective solution to our problems from my point of
view.


> 
>> Since a very similar check exists already using a per-port opt-in flag,
>> would a similar approach acceptable for you? If yes, I'd send a
>> follow-up shortly.
>>
> 
> Yeah, that would work although I try to limit the new options as the bridge
> has already too many options.

I understand that. I hope that new options are still possible if they're justified.

> 
>> PS: I haven't spottet you, but in case you're at LPC in Vienna we can
>> chat in person about it, I'm here.
>>
> 
> That would've been nice, but unfortunately I couldn't make it this year.

Too bad. I hope we get a chance on another conference. I first need to convince
my managers that this trip was useful use of the company's resources, though!

Best regards,
Thomas Martitz

> 
> Cheers,
>   Nik
> 
>> Best regards.
>>
>>
>>> Cheers,
>>>    Nik
>>>
>>
> 
> 


