Return-Path: <netdev+bounces-183722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90CA91AF4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9162A7AC4CA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC023956D;
	Thu, 17 Apr 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sejp419X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDC23BD0C
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889482; cv=none; b=inDftym7S7E6OBSLu2Og5zTHRx7G1gVoICadQu2I3KFW3N7ob4dt96ks20/Ub+wmlPuhWVjewJhD2exfkxmQ4hggg2PTVUrSrPwPB3EcNoZGAsyJbN3tTPon+cBM4QBSTnbS24pesBjaD4xw5qjGHxNntRD7r4uHe7BxvBTRbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889482; c=relaxed/simple;
	bh=1RJ/CV4N2DVmoWSVYLenzw7jqr9hxjWOzIF5NG74DiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp2oOaJ4VXhqwVDFsN74b4+yGSzwfPDTmCTpYUZcMh5EGOj6L/07vRnuqFKxaZENiJXV10ao6HLNz6t9wjDeKP4UYnn1BgVoY2u9TUrSTPz4RepZuffPuSt3r9he4al2/lo/hhjyDZOWAz8TrJMugU/0QRIDkrlaNqJnm6lHGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sejp419X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744889477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEHMEBHjvrO7PpcasZwzrx+ZnESuX/sK9Us9aU6KrI0=;
	b=Sejp419XrU/+XKOD1gNZUrRvd+mNYv5wZUGwIpj+Gh06kJWBZ5360nSTt71F7f1khrHmzh
	32s6hugF+rByI6yAcL8rXkxDc5HSQ+AaArrKm9izt+7j7sBgIcCmsb2fFf3Q2SZ2TPQYVd
	nFSXU9KMfFIPZvjePysS8IK5rRsv7as=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-kZNiV9u3OeCo9uqTFR3Zkw-1; Thu, 17 Apr 2025 07:31:15 -0400
X-MC-Unique: kZNiV9u3OeCo9uqTFR3Zkw-1
X-Mimecast-MFC-AGG-ID: kZNiV9u3OeCo9uqTFR3Zkw_1744889474
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39c184b20a2so327513f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744889474; x=1745494274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEHMEBHjvrO7PpcasZwzrx+ZnESuX/sK9Us9aU6KrI0=;
        b=sQVam9a/3BBlCzbmDKDUuCUJOcYCEVYnuuD3rr/2b9vKdsvhxKRdgjvejDj79mUwwe
         AEhHh+cCJvU6cLYfDQYtDoIQDRN/AcBYjKwJnAP3aeMU40IowLXEKoUINYgIfJjXS8Vy
         TP90eQPbMT2sOp6IGUwdxh2keXep72sob+mugAE0CkHPKLrnoGdBnP+prFxR0XGlgfSr
         LEQQ9OxNbM+dCweO+pEpwermpyiLmd7QtJ6D7A07Kg/8TfAirwo1EkQsupVN1y4p3J8q
         y1wFh2pP+ynaOr/CU8PCCQ7pz9/uNcZ3AVbgxALdcVVAEbgaC5tMGni8HER0WphgRRda
         WceA==
X-Gm-Message-State: AOJu0YxJBpZvgUm4bo1yuzs53BTvi9Dse2D/PnSu6JZX6eboYzS/C+iG
	dTd4VQGSjjtIeyx9P7huMKFHy4bzhxkgiu2UYsuX6gVKtTlNhKl4smBjtmcb3ieS4Sg+n5zL0BK
	rvkEAp0ZXSYbcdkGh7XwBQyZAU/t/NXyWQgWz12M5HbVdJLLl2P/rIg==
X-Gm-Gg: ASbGncsm+4M2yFX5ayThLXoQLERkrN0s8YFN4fhC1jeLzY7Cy89GrEkirDc8OMmR7xU
	tDO0NdDS1gzcLpa32FZOK75Jy/cNxgC6ppS1eGVN8ixsqACGmQMBsSoq4LOPHuDLUVug+AMJGIY
	N822lGk/3PdEZNrtchvuJpRVMemQHdv/bW3VzdQ1crzF7ePNHfbP0mXmcfdsBX/TAte7XS8A2qU
	Bklpl9pDyHKdbdqjnMhFVwzKVHXPG3Qm1j7eSH7C5iCti4TpYWI6nUpj2oaz5bYj4wsA+VGZrwQ
	TLle1hv27gp1QajRMPSDHz4BbnWNf6sce+TNq70a8Q==
X-Received: by 2002:a05:6000:1a8d:b0:39a:c9ac:cd3a with SMTP id ffacd0b85a97d-39ee5bb18cemr4883753f8f.51.1744889474037;
        Thu, 17 Apr 2025 04:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVh2XSH9ICxYx7OtIie2cVOvMLCFJqq0rQsaoeQZZs4AayYJ6WUwXCYLPEbxTa1fEk3zWwYA==
X-Received: by 2002:a05:6000:1a8d:b0:39a:c9ac:cd3a with SMTP id ffacd0b85a97d-39ee5bb18cemr4883732f8f.51.1744889473682;
        Thu, 17 Apr 2025 04:31:13 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43d053sm20106093f8f.68.2025.04.17.04.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 04:31:13 -0700 (PDT)
Message-ID: <090c7522-34a0-4e9b-bfb8-1b8d5698b902@redhat.com>
Date: Thu, 17 Apr 2025 13:31:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/18] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-14-bigeasy@linutronix.de>
 <75e10631-00a3-405a-b4d8-96b422ffbe41@redhat.com>
 <20250417104736.pD2sMYXv@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417104736.pD2sMYXv@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 12:47 PM, Sebastian Andrzej Siewior wrote:
> + Ingo/ PeterZ for sched, see below.
> 
> On 2025-04-17 10:29:05 [+0200], Paolo Abeni wrote:
>>
>> How many of such recursion counters do you foresee will be needed?
> 
> I audited the static per-CPU variables and I am done with this series. I
> need to go through the dynamic allocations of per-CPU but I don't expect
> to see any there.
> 
>> AFAICS this one does not fit the existing hole anymore; the binary
>> layout before this series is:
>>
>>  struct netdev_xmit {
>>                 /* typedef u16 -> __u16 */ short unsigned int recursion;
>>                 /*  2442     2 */
>>                 /* typedef u8 -> __u8 */ unsigned char      more;
>>                 /*  2444     1 */
>>                 /* typedef u8 -> __u8 */ unsigned char
>> skip_txqueue;                /*  2445     1 */
>>         } net_xmit; /*  2442     4 */
>>
>>         /* XXX 2 bytes hole, try to pack */
>>
>> and this series already added 2 u8 fields. Since all the recursion
>> counters could be represented with less than 8 bits, perhaps using a
>> bitfield here could be worthy?!?
> 
> The u8 is nice as the CPU can access in one go. The :4 counting fields
> (or so) are usually loaded and shifted so there is a bit more assembly.
> We should be able to shorten "recursion" down to an u8 as goes to 8
> only.
> 
> I still used holes according to pahole on my RT build (the non-RT
> shouldn't change):> 

Please disregard my comment here. I misread the netdevice_xmit struct
layout. You are right it still fit an hole.

>>> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>>> index 5b38143659249..5f01f567c934d 100644
>>> --- a/net/sched/act_mirred.c
>>> +++ b/net/sched/act_mirred.c
>>> @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
>>>  static DEFINE_SPINLOCK(mirred_list_lock);
>>>  
>>>  #define MIRRED_NEST_LIMIT    4
>>> -static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
>>> +
>>> +#ifndef CONFIG_PREEMPT_RT
>>> +static u8 tcf_mirred_nest_level_inc_return(void)
>>> +{
>>> +	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
>>> +}
>>> +
>>> +static void tcf_mirred_nest_level_dec(void)
>>> +{
>>> +	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
>>> +}
>>> +
>>> +#else
>>> +static u8 tcf_mirred_nest_level_inc_return(void)
>>> +{
>>> +	return current->net_xmit.sched_mirred_nest++;
>>> +}
>>> +
>>> +static void tcf_mirred_nest_level_dec(void)
>>> +{
>>> +	current->net_xmit.sched_mirred_nest--;
>>> +}
>>> +#endif
>>
>> There are already a few of this construct. Perhaps it would be worthy to
>> implement a netdev_xmit() helper returning a ptr to the whole struct and
>> use it to reduce the number of #ifdef
> 
> While I introduced this in the beginning, Jakub asked if there would be
> much difference doing this and I said on x86 at least one opcode because
> it replaces "var++" with "get-var, inc-var". I didn't hear back on this
> so I assumed "keep it".

I forgot about that discussion. Given that note, I'm ok with the current
implementation, but please add a comment (or a sentence in the commit
message) for future memory.

Thanks!

Paolo


