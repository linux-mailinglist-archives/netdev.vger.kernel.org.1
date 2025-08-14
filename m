Return-Path: <netdev+bounces-213844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2CBB270BF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32E11BC8467
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF612741A0;
	Thu, 14 Aug 2025 21:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0B274B3E;
	Thu, 14 Aug 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206469; cv=none; b=YNKid9ThVQg7uzGIjhnZfJHiKObBhDfz32nx7QYr12m7CXdEATEH1cllX9T9zRKxdM67RVaNG4uAlC7PseUtSd0OJ3BKFqibBlBIX9PEkn5qakSInun8VI9qj0ncPqZKmwASx6N1HiQBoKlQUGrh4eUEuJ4uSGuDvm6ZD9uZt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206469; c=relaxed/simple;
	bh=GfR1wFsXqekm0mREd7DhEbR7nS/9EEZE/7j3/ebdc/0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fEuJizMoXReu5NSiIIkD8vyZNtx32k14LheyMLcmTPVzXPiMDVBq3PikhKTFbsZv1LSIi8eBpq0d/5vHnqoBlZkelb6uDlkICeZVwiFZBBU8lRu2RVgDMCc/balhd0BhsdAIbBBxq5CkX7Mg2WXlP3y3+cAVwBF720EuCOJnEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6188b6548adso2593764a12.1;
        Thu, 14 Aug 2025 14:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206464; x=1755811264;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpEyLhDrutOg2+CX5znFGorQ1pdiyp6hG2QJCAm4zkw=;
        b=JSp/RzUo11p/UuJzYVisn27TIjAFfAwv+eEmFhfj7HySonVJIDNbwpoWBftqUWDBNs
         Svfdw+yN4IRTfJ2hR5AQz/h4HGoFRYFwkOcOvz7sVZFPhzehxppPOFyEMMg91iNSQu0J
         Oia4Twq7mRjxspl31XGuYmhwvRF8SEcJxEHsvh+LcUGWD1AP1VAOEdbKdNS14YIik7d8
         ZcgP5oB7Nhjj5CLhqN1hNeMtwPl9H7vDsp+5dULlycTUUfEQAFL1XX3vibpUKhGMIOC0
         xEfBZ66hoXhSw9RGV+xdYqYx7BFaiqgqLdvW894YL0F07se0Px1QDnQdVynQT80754WG
         SgtA==
X-Forwarded-Encrypted: i=1; AJvYcCUFGfi9sPjeCG9BuJ5j7rYD6lw30hjPScXsvjZLbl9Dt1PEO2Mmed25RlKIjY77q6ua828YkSlHWh/1KXk=@vger.kernel.org, AJvYcCXBNhV1FAOop7ZZ+VvVVACfh8OvkfEJnuPIae02Kr3MvJe8cL5RlsexznBioyiVtgXEVHF6S/tS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8/AFF7F/twDaEQKbPz3/btgvc6ylv/jI5CAI/D7UAwmf9D0T
	vAvTYgrLv91V2cm1RgaCIu8cRAye+s3w5gaAzK+d30ZIjO87qHPM12cz
X-Gm-Gg: ASbGncteKvZp/Kfaemso86Kz49/dwyBfQlhn7U5NCfrUNp9JROhdJNk8w9eWSG171fN
	xQ0IM4Ty1CHNMBNB3BZrWP8lgUKahaWwkap9VhlMs/oy86m/l0A3k8DfDBiz3TLSn9S4oQ3RJ+w
	AN8EVmmUTm46vl8Mglzd76yZ7xGvojv323x8o1Jml28wTlxVXe+5niW/MemyH+c+EYBy9NUACR9
	E53cRe5UGAuwYQ8ffYETmPlY7GjOoTMAMZ/dKCelnos4pduFqvntjv7EAYv7BXBjzbKhzoMjd9x
	gmFGeBHXwES41YfsWH53V0VCpJD/oFxwexnbRlo6KNchMe+6p36PiqVL9KAsPJnIs2h+o0qiEuL
	siCfCzx2cO9h5cVwy/wfZwSe5t30tl34ngFRDvNK4M835fMVAtajT52wQhzRTiQ==
X-Google-Smtp-Source: AGHT+IHPsmrA0copI05sBYS89t7i/SP6Stajmg4ws//IGyvseTFSJ/RQfZ8PevW6axe9DU63Vt7qQA==
X-Received: by 2002:a05:6402:27d3:b0:618:2f5c:d93a with SMTP id 4fb4d7f45d1cf-6188ba1b4c4mr3622785a12.19.1755206463581;
        Thu, 14 Aug 2025 14:21:03 -0700 (PDT)
Received: from [192.168.88.248] (89-24-36-92.nat.epc.tmcz.cz. [89.24.36.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f25739sm24866382a12.21.2025.08.14.14.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 14:21:03 -0700 (PDT)
Message-ID: <2dc70249-7de2-4178-9184-2d50cc0dffe9@ovn.org>
Date: Thu, 14 Aug 2025 23:21:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu_from() where
 appropriate
To: Yury Norov <yury.norov@gmail.com>
References: <20250814195838.388693-1-yury.norov@gmail.com>
 <c5b583a8-65da-4adb-8cf1-73bf679c0593@ovn.org> <aJ5Pl1i0RczgaHyI@yury>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <aJ5Pl1i0RczgaHyI@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 11:05 PM, Yury Norov wrote:
> On Thu, Aug 14, 2025 at 10:49:30PM +0200, Ilya Maximets wrote:
>> On 8/14/25 9:58 PM, Yury Norov wrote:
>>> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>>
>>> Openvswitch opencodes for_each_cpu_from(). Fix it and drop some
>>> housekeeping code.
>>>
>>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>> ---
>>>  net/openvswitch/flow.c       | 14 ++++++--------
>>>  net/openvswitch/flow_table.c |  8 ++++----
>>>  2 files changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
>>> index b80bd3a90773..b464ab120731 100644
>>> --- a/net/openvswitch/flow.c
>>> +++ b/net/openvswitch/flow.c
>>> @@ -129,15 +129,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
>>>  			struct ovs_flow_stats *ovs_stats,
>>>  			unsigned long *used, __be16 *tcp_flags)
>>>  {
>>> -	int cpu;
>>> +	/* CPU 0 is always considered */
>>> +	unsigned int cpu = 1;
>>
>> Hmm.  I'm a bit confused here.  Where is CPU 0 considered if we start
>> iteration from 1?
> 
> I didn't touch this part of the original comment, as you see, and I'm
> not a domain expert, so don't know what does this wording mean.
> 
> Most likely 'always considered' means that CPU0 is not accounted in this
> statistics.
>   
>>>  	*used = 0;
>>>  	*tcp_flags = 0;
>>>  	memset(ovs_stats, 0, sizeof(*ovs_stats));
>>>  
>>> -	/* We open code this to make sure cpu 0 is always considered */
>>> -	for (cpu = 0; cpu < nr_cpu_ids;
>>> -	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
>>> +	for_each_cpu_from(cpu, flow->cpu_used_mask) {
>>
>> And why it needs to be a for_each_cpu_from() and not just for_each_cpu() ?
> 
> The original code explicitly ignores CPU0.

No, it's not.  The loop explicitly starts from zero.  And the comments
are saying that the loop is open-coded specifically to always have zero
in the iteration.

> If we use for_each_cpu(),
> it would ignore initial value in 'cpu'. Contrary, for_each_cpu_from()
> does respect it.
> 
>> Note: the original logic here came from using for_each_node() back when
>> stats were collected per numa, and it was important to check node 0 when
>> the system didn't have it, so the loop was open-coded, see commit:
>>   40773966ccf1 ("openvswitch: fix flow stats accounting when node 0 is not possible")
>>
>> Later the stats collection was changed to be per-CPU instead of per-NUMA,
>> th eloop was adjusted to CPUs, but remained open-coded, even though it
>> was probbaly safe to use for_each_cpu() macro here, as it accepts the
>> mask and doesn't limit it to available CPUs, unlike the for_each_node()
>> macro that only iterates over possible NUMA node numbers and will skip
>> the zero.  The zero is importnat, because it is used as long as only one
>> core updates the stats, regardless of the number of that core, AFAIU.
>>
>> So, the comments in the code do not really make a lot of sense, especially
>> in this patch.
> 
> I can include CPU0 and iterate over it, but it would break the existing
> logic. The intention of my work is to minimize direct cpumask_next()
> usage over the kernel, and as I said I'm not a domain expert here.
> 
> Let's wait for more comments. If it's indeed a bug in current logic,
> I'll happily send v2.
> 
> Thanks,
> Yury


