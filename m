Return-Path: <netdev+bounces-286506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BDbOXqPAWoVeQEAu9opvQ
	(envelope-from <netdev+bounces-286506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:12:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E39509E6A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0998D300D4C4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B33B9D91;
	Mon, 11 May 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jITHngpl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392A3B8BC0;
	Mon, 11 May 2026 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487083; cv=none; b=WU7d3nmOKqZHFzvivBS1JXDkA12rAGBJmP3tlbZurxTh+Uh+KmZeD55HX4QrlQPUrl/8ZqZwugPYVsiYrmnkXbuTbsVlgizJ/jX8mw0+hJ98I13wz0C8FU5wNQs1Atjfuqp1Zj7gaph4RpS34vOHotvTojy4Y7j2AuxMQ/ZNScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487083; c=relaxed/simple;
	bh=G3GLlXZt5VJM3r0uBJedbztGA5LM9PkcJ1qqFAxAG8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T080Jjv/4p+dSY3lQ1vioGOL0SfGavwDHyVTSgc3RaxWKC/JJpi8Rn4CSL53YjomRkJANW+y7eAf6zR4gqd5UIggAUM/ywRFBufmG5AV3GMrlhPO4Xgf0BQXsjKPeR53QqmnSCgiIWFANc3c8uy97U46GFTrRWXUM9FMi+w8yCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jITHngpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED01C2BCF6;
	Mon, 11 May 2026 08:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778487077;
	bh=G3GLlXZt5VJM3r0uBJedbztGA5LM9PkcJ1qqFAxAG8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jITHngpl3ZEVsBQTBjt8BFCnxHLyAYshpmvV1uhTnbcFQrs0r1CY1xklP22b0kER5
	 qNJy4Ej8OYjUJ/pYfk9gFNIWeJZqPv2EC3fCnU/1ImCvMtf2YjMKhIS15he2HwN+J7
	 yCPIkrBznRDrWKC//4aTkoWuWxDSvBNreslsxn0/2FEVm7boDa/hZhMnoE8JDv8u2U
	 cWz9oX6H8IeIRBUcrBWaB7p+bcKoITJSdfu12BFD12m/wCzOIhh/2UUti66PrgBkl5
	 P7ab1DPRl264ouUeQCpVFdZ0Zeak8bAqXedd7Kvtr8dIPVJ3CtOEKZQIUJiT7OJlU0
	 EhbiE8Xp1tizg==
Message-ID: <daa05c21-dcfc-4cc4-aa22-9e25c7f6c743@kernel.org>
Date: Mon, 11 May 2026 10:11:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Schippers <simon@schippers-hamm.de>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
 <20260508190626.4285fac0@kernel.org>
 <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
 <20260510085602.57c7a081@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260510085602.57c7a081@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 18E39509E6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286506-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[schippers-hamm.de,redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 10/05/2026 17.56, Jakub Kicinski wrote:
> On Sat, 9 May 2026 11:09:51 +0200 Jesper Dangaard Brouer wrote:
>> On 09/05/2026 04.06, Jakub Kicinski wrote:
>>> On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:
>>>> Not against being able to modify VETH_RING_SIZE, but I don't think it is
>>>> the solution here.
>>>
>>> Was it evaluated, tho?
>>>
>>> It's obviously super easy these days have AI spew no end of complex
>>> code. So it'd be great to have some solid, ideally production-like
>>> data to back this all up.
>>>
>>> VETH_RING_SIZE seems trivial, ethtool set ringparam
>>
>> No, unfortunately we cannot just decrease the VETH_RING_SIZE.
> 
> To be clear - I said may it configurable with ethtool -G
> not change the default.
> 

Sure, I understand the desire to make VETH_RING_SIZE configurable.
If doing so we are making Linux network stack harder to tune and setup
correctly. E.g. adding a qdisc to veth would also require changing the
ring size, but if system also uses XDP then tuning below 64 (likely 128)
will lead to hard-to-find packet drops.

I prefer adding something (like BQL) that auto-tune how much of the ring
queue we are using.  Good queues function as shock absorbers when
concurrent processes in the OS have scheduling noise.

I acknowledge that Simon Schippers found that the BQL implementation was
actually not auto-tuning.  We need to work on this, my prototype
implementation [1] [2] works surprisingly well.


- [1] 
https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org/2-09-veth-time-based-bql-coalescing.patch
- [2] 
https://lore.kernel.org/all/3e43117f-356d-4086-a176-abd7fe2e6f0a@kernel.org/


>> The reason is that XDP-redirect into veth don't have any
>> back-pressure and would simply drop packets if queue size becomes
>> less than the NAPI budget (64). (Yes, we use both normal path and
>> XDP-redirect in production).
> 
> Doesn't this mean you have a queue which is not under BQL control?
> 

It is a matter of perspective. BQL needs between 17-55 elements in the
256 queue.  At the same time we handle if the ring runs full, e.g. due
to a sudden burst of XDP redirected packets, which pushes packets into
the qdisc layer.


>> My benchmarking shows that an optimal BQL limit is dynamically
>> adjusted between 17-55 depending on veth consumer namespace
>> overhead/speed, when balancing throughput and latency.
> 
> Testing with prod-approximating traffic pattern and load would be great.

That is what I'm doing.  I'm testing with prod-approximating traffic
pattern and changing the number of iptables rules to simulate the
overhead I measured from production.  I think I explained this in the
cover letter. We are going to use this in a production environment (to
be clear).

Simon found an issue testing the overload scenario.

--Jesper


