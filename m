Return-Path: <netdev+bounces-196706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11561AD6022
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C716E1BC0179
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D72BE7BC;
	Wed, 11 Jun 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BA0LVJxC"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042052BD5A8;
	Wed, 11 Jun 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674142; cv=none; b=KRI8L7CwLPl6X6iqigLoO+fFxtdxTvJyBOLwGB3zJf75la8IUU8JnMVSLMmcXOtGww3MKqSDLkXLTBJvul4bdTp/mmx7XcLERYKiYNAceOL982N2yZu2jAe6cbvK/MybrrvjAZGRr/73Ks8knKMAEOjhNafCmhKMQYBZRxTWn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674142; c=relaxed/simple;
	bh=QiXBEMEzmyoBDvyEoQPaNuaco9guwmAehbE+mQvdTBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9FCjC5YA0cIJkMxMg4hFfVv8yQCFeUWPSGqMuXllFIdq+PQFwPH71/zdnqP9KZeAPVAeRRlv6CjtURw9YeQfVHTsijq46lkN26oWivDAshoCflDOU40l3Giar8ZlubrR5URRTSVS9+Z0baGKLhmWltrfKEO9NzH4RcODJ/fcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BA0LVJxC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uPSAa-00BQ9T-Pq; Wed, 11 Jun 2025 22:35:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=GgklFZOTewVrA9C7u7gto1zxk0cgMJ26MqFoXlbGv+g=; b=BA0LVJxCiQTkIOqTIhHwjpP8su
	MkqjE7pzdg4lmPQP0PTkFfL17bS7o/UjZkv3+hkGiIuLkU/HeE/3Z6sMnqrx9jc0Rxmd5Xcz9WRtl
	y92wT+6GV5y3Gf/+hBAgxuKBvAh5gsondGDPEH7zFZLb+xxZYYIUpOVHbwv8afrhyT0bMdVbHporQ
	7TpYAPmUwOpG7iRNnkdGxKxi5C72sC9kThRv5GEgVmTqKdxa0k0xqX4NAK1qoqN0NgGoOvT1TzmDb
	PG+Lusl4JHshD7HftExb1kTR+5YGfBMkl97FUjTaF1f/x2i8knY/BQ2Z3vJebahThhxH+is2dtZzq
	Cw94TCEw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uPSAZ-0008RJ-W4; Wed, 11 Jun 2025 22:35:36 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uPSAK-00C9yV-Lr; Wed, 11 Jun 2025 22:35:20 +0200
Message-ID: <9f1f41eb-e23e-48c9-a6bc-db9d34dbae5e@rbox.co>
Date: Wed, 11 Jun 2025 22:35:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 2/3] vsock/test: Introduce
 get_transports()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
 <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
 <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>
 <hxnugz3xrrn3ze2arcvjumvjqekvjfsrvd32wi7e3zgdagdaqb@cm3y6fipqdf3>
 <adae2539-2a48-45c3-a340-e9ab3776941f@rbox.co>
 <lvduahetdnmshgo7tus7kezq6ddps5wjouefkmfwxkw7ckbhpg@nvjhai4xt5kl>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <lvduahetdnmshgo7tus7kezq6ddps5wjouefkmfwxkw7ckbhpg@nvjhai4xt5kl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 16:20, Stefano Garzarella wrote:
> On Fri, Jun 06, 2025 at 09:51:29AM +0200, Michal Luczaj wrote:
>> On 6/5/25 12:46, Stefano Garzarella wrote:
>>> On Wed, Jun 04, 2025 at 09:10:19PM +0200, Michal Luczaj wrote:
>>>> On 6/4/25 11:07, Stefano Garzarella wrote:
>>>>> On Wed, May 28, 2025 at 10:44:42PM +0200, Michal Luczaj wrote:
>>>>>> +static int __get_transports(void)
>>>>>> +{
>>>>>> +	/* Order must match transports defined in util.h.
>>>>>> +	 * man nm: "d" The symbol is in the initialized data section.
>>>>>> +	 */
>>>>>> +	const char * const syms[] = {
>>>>>> +		"d loopback_transport",
>>>>>> +		"d virtio_transport",
>>>>>> +		"d vhost_transport",
>>>>>> +		"d vmci_transport",
>>>>>> +		"d hvs_transport",
>>>>>> +	};
>>>>>
>>>>> I would move this array (or a macro that define it), near the transport
>>>>> defined in util.h, so they are near and we can easily update/review
>>>>> changes.
>>>>>
>>>>> BTW what about adding static asserts to check we are aligned?
>>>>
>>>> Something like
>>>>
>>>> #define KNOWN_TRANSPORTS	\
>>>
>>> What about KNOWN_TRANSPORTS(_) ?
>>
>> Ah, yeah.
>>
>>>> 	_(LOOPBACK, "loopback")	\
>>>> 	_(VIRTIO, "virtio")	\
>>>> 	_(VHOST, "vhost")	\
>>>> 	_(VMCI, "vmci")		\
>>>> 	_(HYPERV, "hvs")
>>>>
>>>> enum transport {
>>>> 	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
>>>> 	#define _(name, symbol)	\
>>>> 		TRANSPORT_##name = _BITUL(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>>>> 	KNOWN_TRANSPORTS
>>>> 	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
>>>> 	#undef _
>>>> };
>>>>
>>>> static char * const transport_ksyms[] = {
>>>> 	#define _(name, symbol) "d " symbol "_transport",
>>>> 	KNOWN_TRANSPORTS
>>>> 	#undef _
>>>> };
>>>>
>>>> static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
>>>>
>>>> ?
>>>
>>> Yep, this is even better, thanks :-)
>>
>> Although checkpatch complains:
>>
>> ERROR: Macros with complex values should be enclosed in parentheses
>> #105: FILE: tools/testing/vsock/util.h:11:
>> +#define KNOWN_TRANSPORTS(_)	\
>> +	_(LOOPBACK, "loopback")	\
>> +	_(VIRTIO, "virtio")	\
>> +	_(VHOST, "vhost")	\
>> +	_(VMCI, "vmci")		\
>> +	_(HYPERV, "hvs")
>>
>> BUT SEE:
>>
>>   do {} while (0) advice is over-stated in a few situations:
>>
>>   The more obvious case is macros, like MODULE_PARM_DESC, invoked at
>>   file-scope, where C disallows code (it must be in functions).  See
>>   $exceptions if you have one to add by name.
>>
>>   More troublesome is declarative macros used at top of new scope,
>>   like DECLARE_PER_CPU.  These might just compile with a do-while-0
>>   wrapper, but would be incorrect.  Most of these are handled by
>>   detecting struct,union,etc declaration primitives in $exceptions.
>>
>>   Theres also macros called inside an if (block), which "return" an
>>   expression.  These cannot do-while, and need a ({}) wrapper.
>>
>>   Enjoy this qualification while we work to improve our heuristics.
>>
>> ERROR: Macros with complex values should be enclosed in parentheses
>> #114: FILE: tools/testing/vsock/util.h:20:
>> +	#define _(name, symbol)	\
>> +		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>>
>> WARNING: Argument 'symbol' is not used in function-like macro
>> #114: FILE: tools/testing/vsock/util.h:20:
>> +	#define _(name, symbol)	\
>> +		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>>
>> WARNING: Argument 'name' is not used in function-like macro
>> #122: FILE: tools/testing/vsock/util.h:28:
>> +	#define _(name, symbol) "d " symbol "_transport",
>>
>> Is it ok to ignore this? FWIW, I see the same ERRORs due to similarly used
>> preprocessor directives in fs/bcachefs/alloc_background_format.h, and the
>> same WARNINGs about unused macro arguments in arch/x86/include/asm/asm.h
>> (e.g. __ASM_SEL).
> 
> It's just test, so I think it's fine to ignore, but please exaplain it 
> in the commit description with also references to other ERRORs/WARNINGs 
> like you did here. Let's see what net maintainers think.

Sure, I've added a note. I've also switched the magic macro name '_' to
'x', this seems to be more common.

https://lore.kernel.org/netdev/20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co/

Thanks,
Michal


