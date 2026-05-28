Return-Path: <netdev+bounces-292666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFcdJQwnGGqZeQgAu9opvQ
	(envelope-from <netdev+bounces-292666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:29:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790D5F14CA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D65E301D588
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D13DDDA9;
	Thu, 28 May 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RN64s2/N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y8inKTBd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X6FIbVlr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SAUZNmo8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F833B6ED
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967753; cv=none; b=G8xIVQTyhheqMOxHWqLejk0XYPjYdhmceCJ8eNZZqUjJAwapNN8vjOhiTi53H1olH7oPeWOVOEoBixLTgwel7b77RirfraYzgazbmpUF6SkOjXyOJb3MLGzQ+HZmo37UFtqRwaPj8bKsEjpaq0DcPOYSoQsB1SrbWm/B9Gg/YwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967753; c=relaxed/simple;
	bh=y8aKZFXuYyW+1QiG1HJtZR6PSGzqXkhJzBJ53aMBEd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3c03wwUiaDNo0I9HEtYo6gzbOl341vKo8txcuawoT8+whKRz40Mh2MpkhDVii8krsOU37uHNqG8t2+KHI6OSAwTQEe2fLeeEuZC1voVdy2YGNpl79yabI5JhTK6L8JeIjhb6p9089aXV0U7CuBzbxwNJvQsULgdag85JzcEhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RN64s2/N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y8inKTBd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X6FIbVlr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SAUZNmo8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8E9866D81;
	Thu, 28 May 2026 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779967750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idyFvH88nJZtL54XD9Z+Ezn9TzkFokARsLHZV8owmfU=;
	b=RN64s2/NimApsCSH1zio967uejmchsLtJUTLGIHaC2NnBWWBxggaLzKoh0HmX8Uoeu+0M1
	Un0jVGkXc6WEELURnPy2tZhPesw9SbpDiTgpa3Jda3bbjaqe3aaDr5VlwZpv2IOcH+NbZf
	36yoHr9lo8/oVx3uR/v56qNUpXyDyGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779967750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idyFvH88nJZtL54XD9Z+Ezn9TzkFokARsLHZV8owmfU=;
	b=Y8inKTBdsweycNSRe0bNsnu19XSWFVyp3uIvskDyypK/m2sja2CgpRXgAbWLFmMGDAe1tZ
	VD2VxphAFMLfEXAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X6FIbVlr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SAUZNmo8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779967749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idyFvH88nJZtL54XD9Z+Ezn9TzkFokARsLHZV8owmfU=;
	b=X6FIbVlrqShYuk3KBYxV7iylDXFXISXK9R/EGSYBEoFD7IJzbcuhKJf0K6ZJlo5t82LjHB
	HdnGZPyj7SyWspw3YGRXyNdPPx058NYq2GybJ2okfPs/FC3tc5GeMh5O333H4hEDURn6yg
	9WaxClB0kDETrTDsNHJctfIrRuziNSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779967749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idyFvH88nJZtL54XD9Z+Ezn9TzkFokARsLHZV8owmfU=;
	b=SAUZNmo8aFv0pxOv38aJBMmbo8D0Dt08wU7Dd6j+Y43LtgjQqkjC9RwP0nPlIGsk+ilLKx
	692udTtZnYaQiTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B7105AD70;
	Thu, 28 May 2026 11:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5aB0DwUnGGozQgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 28 May 2026 11:29:09 +0000
Message-ID: <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
Date: Thu, 28 May 2026 13:29:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>, ihuguet@redhat.com,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org> <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org> <20260527215135.GB16443@cmadams.net>
 <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260528131250.1352ab48@elisabeth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-292666-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,passt.top:url]
X-Rspamd-Queue-Id: 3790D5F14CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 1:12 PM, Stefano Brivio wrote:
> On Thu, 28 May 2026 12:46:05 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
>> On 5/28/26 7:38 AM, Stefano Brivio wrote:
>>> Hi Fernando, Jakub,
>>>
>>> On Wed, 27 May 2026 23:59:47 +0200
>>> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>>>    
>>>> On 5/27/26 11:51 PM, Chris Adams wrote:
>>>>> Once upon a time, Jakub Kicinski <kuba@kernel.org> said:
>>>>>> On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote:
>>>>>>>> Hi! Adding more people to CC. Do you know if you upgraded from 6.18
>>>>>>>> or 6.19?
>>>>>>>
>>>>>>> It was 6.19 to 7.0.
>>>>>>>      
>>>>>>>> Would you be able to try testing with some commits reverted?
>>>>>>>> On a quick look the candidates would be:
>>>>>>>>
>>>>>>>> cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
>>>>>>>
>>>>>>> It's this one.
>>>>>>
>>>>>> Phew, the second one was mine :)
>>>>>>      
>>>>>>> I figured out that it happens after stopping a VM (and I usually
>>>>>>> start/stop a VM for a bit in the morning, which is why it happened more
>>>>>>> than once).  So I set up a VM with a nested VM, running up-to-date
>>>>>>> Fedora 44, and then was able to bisect pretty easily, and it landed on
>>>>>>> this commit.
>>>>>>>
>>>>>>> Fedora is using NetworkManager, and IIRC NM does some part of privacy
>>>>>>> address management (right?).  NM didn't change, so maybe this commit is
>>>>>>> confusing something in NM?
>>>>>>
>>>>>> Sounds plausible, pretty sure we knew this commit was risky to begin
>>>>>> with, but we had no direct proof that it'd break real life users.
>>>>>>
>>>>>> Revert is the right course of action here. Would you be willing/able
>>>>>> to send the revert with your problem description and a Fixes tag
>>>>>> pointing to the reverted commit?
>>>>>
>>>>> I did want to add a little more test note:
>>>>>
>>>>> It's definitely an interaction with NetworkManager.  If I stop NM and
>>>>> run my VM start/stop test, nothing unexpected happens after.  If NM is
>>>>> running and I do my VM test, when the next router advertisement is
>>>>> received, NM replaces the privacy addresses.
>>>>>       
>>>>
>>>> As someone that is experienced in NetworkManager, I can confirm it is
>>>> related. NetworkManager is querying the IPv6 address and when the
>>>> connection is configured with ipv6.ip6-privacy=2 (prefer-temp-addr),
>>>> NetworkManager creates a route to make the system use the temporary
>>>> address for outgoing connections by default.
>>>>
>>>> If the order is messed up, the address picked will likely be too. One
>>>> could argue that this is partially fault of NetworkManager and that it
>>>> should check the timestamps or preferred times rather than order.. but
>>>> well, the rule is "do not break userspace".
>>>>
>>>> I hope this clarifies things.
>>>
>>> Not entirely. I'm looking into this right now, but note that the purpose
>>> of that commit is to *preserve* the order of addresses as they were
>>> inserted, not to mess it up.
>>>
>>> Before that, addresses were stored and returned via netlink *reversed*
>>> compared to the insertion, which is rather surprising, also because
>>> it's the opposite of what we do for IPv4 addresses, and caused issues
>>> with pasta(1) as it copies addresses into containers in the same order
>>> as reported via netlink.
>>
>> Right, to make it clear. I agree with you here. The current order is the
>> *right* or rather intuitive order.
>>
>>> Do you happen to know exactly in which way the order happens to be wrong
>>> now?
>>
>> It is not wrong, but userspace applications were parsing addresses and
>> expecting them in the previous order whether it was correct or not. Now,
>> that parsing is broken because they are coming in an unexpected (maybe
>> more intuitive) order.
> 
> Ouch, I see.
> 
> Two questions:
> 
> - could there be other issues coming from the fact that NetworkManager
>    relies on a particular order (whether right or wrong) of addresses? If
>    yes, I guess NetworkManager would benefit from a fix in any case
>    (that is, we broke it a bit harder, but maybe it was already broken?)
> 

Yes, I believe the right way to pick a temporary address is to use the 
most recent one and the right way to see that is by looking to 
timestamps not looking at the order.

> - regardless of this, would there be a way to make NetworkManager
>    robust to the order?
> 
>    I'm asking this because yes, strictly speaking, you might say this
>    change breaks userspace (NetworkManager), but at the same time it
>    fixes another part of it (pasta), and changing it back would break
>    pasta again (in a way we can't really fix).
> 

Ugh, that is a mess.

>    Now, I suppose NetworkManager is much more universally used and it's
>    definitely a more mature project so it's a bigger userspace breakage,
>    but at the same time it's a ton of containers (Podman uses pasta by
>    default, Docker/moby optionally via rootlesskit) we might introduce a
>    regression for.
> 

I think the main argument here is: while we know it is affecting 
NetworkManager, we cannot know if it is breaking something else. The 
kernel rule is usually "do not break userspace" and this is likely 
considered a regression from my understanding. Cc'ing Thorsten as he is 
an expert on regressions.

> So I'm wondering if in practice it wouldn't be better to fix
> NetworkManager instead.
> 

We can fix future versions of NetworkManager but we cannot fix released 
versions. That is, if someone upgrade kernel but not NetworkManager, it 
would break. I guess the same applies to pasta.. so we must understand 
what has been the most prevalent behavior.

>> FWIW; Iñigo Huguet (CC'ed) pointed out that this is breaking a
>> NetworkManager test and they were going to report it.
>>
>>> Also note that userspace was broken and fixed a couple of times:
>>>
>>>     https://bugs.passt.top/show_bug.cgi?id=175#c10
>>>
>>> so I would look into fixing that properly if doable. If it takes too
>>> long and this is causing issues for a lot of people meanwhile of course
>>> it might make sense to revert, but I'd give it a quick try at least.
>>
>> I think the solution shouldn't modify the order of the list by default.
>> Maybe we can introduce a flag for the dump operation?
> 
> I'm a bit struggling with the name and how complicated a description
> would be. NLM_F_RIGHT_ORDER? I guess you're suggesting to get the
> "wrong" / reversed order by default... even though it's the opposite
> compared to IPv4? Or NLM_F_REVERSED, otherwise? Is it really worth it?
> 

I don't have a clear idea on how to do it so it is acceptable, right 
now. FWIW; I think consistent behavior between IPv4 and IPv6 isn't a 
goal. They are designed in different ways and implemented in different 
ways too. There are many situations where they behave completely 
different e.g ECMP routing.

I have sent the revert patch but more likely for AI review + CI. I do 
not want it to be merged until we reach a consensus, we can discard it 
if we decide to do so.

Thanks,
Fernando.

