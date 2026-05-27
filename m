Return-Path: <netdev+bounces-292144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLTUIY+fFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D128C5E08A8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CE563017FB5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6F3C945B;
	Wed, 27 May 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4lRRXRH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F13C09F1;
	Wed, 27 May 2026 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867530; cv=none; b=kCCWwOSomABXIIjyevVljKC+mZINK2SnV0/tyFU8XkoEeT9B96L25oXvfHXx0b/0JZilFtzn65LfMVsPu12ooZ2loGH8mqpKFdQziAibis/LAAueKdjciBE0h0DQOUYNTHlUOpq08eJ6GlqHngspYE4ABKryX0Gh4qz3aUWPqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867530; c=relaxed/simple;
	bh=SBJb5xXkmlqTV62Zt96/uXBoot0tdI5KLSLDqbjGfHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGQv4UrxmiyaeKx5noiCrHTSLC8PRh6tYiAhc9lfd1PfR0sTguX8Jf8j+beONUJVWeSoFkwWBXXH5DmNK/yYk9o3eGEaa8Cqi0E1VCcTKBlQyTYaxJApHxMFV+/jB4k+o9V9D4bPPSyf9sxKixT2sqllonv1cqUz/45bYWePtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4lRRXRH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA511F000E9;
	Wed, 27 May 2026 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779867529;
	bh=moBN3GrtjHAhIVhdHLFUyecY8ypcxSI1iGvi0iaI0Vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G4lRRXRHg+FOCfpsKaxZaYJl+4GIlVy8ZlBx1CI1XIOb8RqUe5TkBKrROWAXXz4tH
	 SBKclKS4BL6bq1KwtDTLyumC4F0RatlheWnO7HuljUVdI7CW/W0VStwxz+5H/+hQ63
	 WB/aPFcKhINMcFnl+LhOmrYaWemFrNnOTNtwxE6X0833dLvD3mJPgbQNCRwYDFYaLO
	 Q3XnBTWwOM8UJEAptyrp7AD3uJsCrln4ZVMWh1H7V2wAvR3vTEHxN8XFq2DiVmBTuk
	 hQFJoorjhkV7/N2IS9SHpg3COV1p9YkI6D9WOGXFtC7LkZWEL/cJdfP4COfQ7L7u9o
	 qpU5HAC6V+npw==
Message-ID: <80dc574b-f2da-4f04-8bc8-1b0793b1f296@kernel.org>
Date: Wed, 27 May 2026 09:38:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260508190626.4285fac0@kernel.org>
 <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
 <20260510085602.57c7a081@kernel.org>
 <daa05c21-dcfc-4cc4-aa22-9e25c7f6c743@kernel.org>
 <41023c34-87a3-4e4f-b3ab-3ed53d171910@schippers-hamm.de>
 <b78f002a-8cb9-4857-bf8f-0137e790f644@kernel.org>
 <873511fa-4316-4411-a76b-ec4c5805abd3@schippers-hamm.de>
 <18855e57-f050-411f-9958-d4babcc81ba3@kernel.org>
 <14348957-d061-4124-9bac-45df9cf6686c@schippers-hamm.de>
 <9a57bb41-114e-492b-9eaa-52237675bb7c@schippers-hamm.de>
 <4ae9400a-8919-4ffc-8db3-0c334e2aa462@tu-berlin.de>
 <8e8b877b-a7ce-4b2f-9567-64c8dbb48411@schippers-hamm.de>
 <463e91cb-6c45-4d91-8737-39779fec5a49@tu-berlin.de>
 <b1c2d2c1-a70a-4bf4-baff-d0ac2f878722@schippers-hamm.de>
 <24d10b53-c545-4141-95a5-5c49c35c5d6c@tu-berlin.de>
 <c5b3a7ef-8ec7-4361-80bb-cf06e910350c@schippers-hamm.de>
 <d23fd8e0-a0d3-4197-a130-2340d1c28fe0@tu-berlin.de>
 <e8be86b4-052f-4f4f-9cb9-2fb12d1e8922@schippers-hamm.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <e8be86b4-052f-4f4f-9cb9-2fb12d1e8922@schippers-hamm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D128C5E08A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 17.07, Simon Schippers wrote:
> On 5/26/26 16:55, Jonas Köppeler wrote:
>> On 5/26/26 4:35 PM, Simon Schippers wrote:
>>> On 5/26/26 11:54, Jonas Köppeler wrote:
>>>> On 5/23/26 6:09 PM, Simon Schippers wrote:
>>>>> On 5/22/26 18:26, Jonas Köppeler wrote:
>>>>>> On 5/22/26 10:41, Simon Schippers wrote:
>>>>>>> On 5/22/26 09:14, Jonas Köppeler wrote:
>>>>>>>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>>>>>>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>>>>>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>>>>>>>> Nope, I'm using a bpftrace program to keep track of the inflight/limit
>>>>>>>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>>>>>>>> Ah nice.
>>>>>>>>>>> Add the option --hist to have both NAPI and BQL histograms printed when
>>>>>>>>>>> script ends.  This will give you an accurate pattern of how inflight and
>>>>>>>>>>> limit evolves.
>>>>>>>>>>>
>>>>>>>>>>>>> I moved the selftests into a github repo [1] to allow us to collaborate
>>>>>>>>>>>>> and evaluate the changes more easily.  I explicitly kept the new BPF
>>>>>>>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>>>>>>>
>>>>>>>>>>>>>        [1] https://github.com/netoptimizer/veth-backpressure-performance-testing/tree/main/selftests

[... cut ...]

>>>
>>> I will wait for your new measurements, but there is no argument
>>> against a default tx-usecs of ~100us for now, right?
>> Yes, I think 100us is perfectly fine. I guess most of it was
>> just my curiosity why the latency values are as they are 🙂
> Which is great, because I was wondering the same 🙂
> 

Thank you Jonas and Simon for testing this via[1] on your systems.

One performance concern from my side is if/when BQL limit goes below 8
packets. This will cause cache-line bouncing and many qdisc requeues
between the two CPUs.  Notice that 8 packets for the ptr_ring is one
cache-line. This is why I suggested defaulting BQL min_limit to be 8.
This would work in combination with the tx-usecs coalesce tuning as a
lower bound.


>> But it feels like this will need some documentation, because
>> as we have seen, some values are a little different
>> from what you expect from bql. Inflight > veth_ring_size,
>> tx-usecs not necessarily achieving the configured value,
>> inflight can get stuck > 0. Wdyt?
>> But I think it works nicely overall.
>>
> Exactly, we should get ready for a v6 soon.
>

I want to send out a V6 today (and I'm busy rest of week).
I'm simply going to include Simon's patch[2]. Then we can iterate on
that email thread, making it easier for people to reply inline to the
code changes.

[2] 
https://lore.kernel.org/all/9a57bb41-114e-492b-9eaa-52237675bb7c@schippers-hamm.de/

> And I think we should move the BQL logic into a seperate .h file
> as a library. Then it is also usable for TUN/TAP in the future.
> 

I like the idea, but refactoring into a library seems out-of-scope for
this patchset.  As a first step, let us see if this works for veth
driver use-case.  I do encourage Simon to refactor when doing the work
for TUN/TAP in the future.

Alternatively netdev maintainers can choose to apply V5 patchset and we
can iterate on finding the right ethtool coalesce parameters for veth
and create a .h "library" file for this.


> Let's amend the commits. Should we do this on Github?

Kernel development for netdev [3] happens on the mailing list with 
patches via email.

--Jesper

[3] https://kernel.org/doc/html/latest/process/maintainer-netdev.html


