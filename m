Return-Path: <netdev+bounces-54977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4C809106
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379C9B20ADE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03654EB5C;
	Thu,  7 Dec 2023 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/iIM2BX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFA10DC
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:08:26 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d77a1163faso9159627b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701976105; x=1702580905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6U2+inr26Dmt3V3+d158tRJFivcLqrjt1dddv9U6sP0=;
        b=T/iIM2BXrh5zKOr4RIy205AG52qR+lFJy7V+TBYBX3AT6P6A5w/ZnGtDX7OjqABKto
         N1V8ik4+9Isr5Fvox2zb2hgLdNzsgzMZyH0oByCTWGuSNr0fbF7/SSBJLD/WlSq/rBhs
         RF17XoESxsGg+0faBOmoDCyv5myefHuGLwU2DIS1E4+ah/uZXObA9jLSxtScmIm0StxQ
         Xw+j7op2/UBmy1OEOZBA4vTAm14MSFB0OfT/nYCPiWPItr8SRAodpfDC046NXcCXpgEw
         bb6G4UiJBFuu5moK+GFhStPInQOnDqSUxl5yDpbI7wR3l/k0uAfZq8+KKRGZe3EZJqsm
         gEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976105; x=1702580905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6U2+inr26Dmt3V3+d158tRJFivcLqrjt1dddv9U6sP0=;
        b=g7q8ZH+842AUmdPQZziBJdFrYKx7t/0QTXwYVhV1B5KpzXQ4WW3Koj1/hNvm4tAHrg
         bA5vsAHgOQLM3hg3gOmqDih3ErK2Tg8vZkhHqrbpe49tdFmk1cLW2BP/HU1pZUgOEM8D
         jY9K0//EyswYF76VhWghjGO4gDPs4NrbcPe09ebP1gNtDPn+FGmKgBDpZDdUQ+OORilc
         zA3IypqIE+PbKKg451JU8Kh5xcSYexCK6nIB+/0ch6E0NtohvbOl5UN5Ir6GRxZp/1nR
         p9X+9pAF3tJprKi+CktBNSa8L/PauO5P+bwflTEWAvbs5nkmu5wPkDE5koxrsB3X5a3a
         CrfA==
X-Gm-Message-State: AOJu0YxoVCItrUc4udQnR5rIkkaD9gU5dlCzuT8ZIehLdXA0PEnq+OD8
	w0/Uh5xCgrcNsPDec1b/C1g=
X-Google-Smtp-Source: AGHT+IGXBohUnowWbUxeoh1yJ/gaNY4zDvXJ7JPl8oZ2uLe83bQwcG9zqJC12lbwB/bCPAS22FVxfw==
X-Received: by 2002:a05:690c:c0e:b0:5d3:dacc:63bd with SMTP id cl14-20020a05690c0c0e00b005d3dacc63bdmr2598936ywb.19.1701976105025;
        Thu, 07 Dec 2023 11:08:25 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id j68-20020a0df947000000b005b37c6e01f9sm82517ywf.90.2023.12.07.11.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:08:24 -0800 (PST)
Message-ID: <dd9aefd4-b436-4ef7-8d1f-e966bccb2a14@gmail.com>
Date: Thu, 7 Dec 2023 11:08:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, patchwork-bot+netdevbpf@kernel.org,
 Kui-Feng Lee <thinker.li@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
 <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
 <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
 <CANn89i+2NJ4sp8iGQHG9wKakRD+uzvo7juqAFpE4CdRbg8F6gQ@mail.gmail.com>
 <590c27ae-c583-4404-ace7-ea68548d07a2@kernel.org>
 <d7ffcd2b-55b0-4084-a18d-49596df8b494@gmail.com>
 <3b432fa3-8cfc-4d50-8363-848cbe775621@gmail.com>
 <d973fd6a-4fd0-4578-a784-00ed7fd1c927@gmail.com>
 <CANn89iJo6i67tf=k8_KHYNFXy1DyPoOZKLB2NbyY4xqmp_qWgw@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CANn89iJo6i67tf=k8_KHYNFXy1DyPoOZKLB2NbyY4xqmp_qWgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 11:05, Eric Dumazet wrote:
> On Thu, Dec 7, 2023 at 8:00 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 12/7/23 10:40, Kui-Feng Lee wrote:
>>>
>>>
>>> On 12/7/23 10:36, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 12/7/23 10:25, David Ahern wrote:
>>>>> On 12/7/23 11:22 AM, Eric Dumazet wrote:
>>>>>> Feel free to amend the patch, but the issue is that we insert a fib
>>>>>> gc_link to a list, then free the fi6 object without removing it first
>>>>>> from the external list.
>>>>>
>>>>> yes, move the insert down:
>>>>>
>>>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>>>> index b132feae3393..7257ba0e72b7 100644
>>>>> --- a/net/ipv6/route.c
>>>>> +++ b/net/ipv6/route.c
>>>>> @@ -3762,12 +3762,6 @@ static struct fib6_info
>>>>> *ip6_route_info_create(struct fib6_config *cfg,
>>>>>           if (cfg->fc_flags & RTF_ADDRCONF)
>>>>>                   rt->dst_nocount = true;
>>>>>
>>>>> -       if (cfg->fc_flags & RTF_EXPIRES)
>>>>> -               fib6_set_expires_locked(rt, jiffies +
>>>>> -
>>>>> clock_t_to_jiffies(cfg->fc_expires));
>>>>> -       else
>>>>> -               fib6_clean_expires_locked(rt);
>>>>> -
>>>>
>>>> fib6_set_expires_locked() here actually doesn't insert a fib gc_link
>>>> since rt->fib6_table is not assigned yet.  The gc_link will
>>>> be inserted by fib6_add() being called later.
>>>>
>>>>
>>>>>           if (cfg->fc_protocol == RTPROT_UNSPEC)
>>>>>                   cfg->fc_protocol = RTPROT_BOOT;
>>>>>           rt->fib6_protocol = cfg->fc_protocol;
>>>>> @@ -3824,6 +3818,12 @@ static struct fib6_info
>>>>> *ip6_route_info_create(struct fib6_config *cfg,
>>>>>           } else
>>>>>                   rt->fib6_prefsrc.plen = 0;
>>>>>
>>>>> +
>>>>> +       if (cfg->fc_flags & RTF_EXPIRES)
>>>>> +               fib6_set_expires_locked(rt, jiffies +
>>>>> +
>>>>> clock_t_to_jiffies(cfg->fc_expires));
>>>>> +       else
>>>>> +               fib6_clean_expires_locked(rt);
>>>>>           return rt;
>>>>>    out:
>>>>>           fib6_info_release(rt);
>>>>
>>>> However, this should fix the warning messages.
>>> Just realize this cause inserting the gc_link twice.  fib6_add()
>>> will try to add it again!
>>
>> I made a minor change to the patch that fix warning messages
>> provided by David Ahern. Will send an official patch later.
>>
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -3762,17 +3762,10 @@ static struct fib6_info
>> *ip6_route_info_create(struct fib6_config *cfg,
>>           if (cfg->fc_flags & RTF_ADDRCONF)
>>                   rt->dst_nocount = true;
>>
>> -       if (cfg->fc_flags & RTF_EXPIRES)
>> -               fib6_set_expires_locked(rt, jiffies +
>> -
>> clock_t_to_jiffies(cfg->fc_expires));
>> -       else
>> -               fib6_clean_expires_locked(rt);
>> -
>>           if (cfg->fc_protocol == RTPROT_UNSPEC)
>>                   cfg->fc_protocol = RTPROT_BOOT;
>>           rt->fib6_protocol = cfg->fc_protocol;
>>
>> -       rt->fib6_table = table;
>>           rt->fib6_metric = cfg->fc_metric;
>>           rt->fib6_type = cfg->fc_type ? : RTN_UNICAST;
>>           rt->fib6_flags = cfg->fc_flags & ~RTF_GATEWAY;
>> @@ -3824,6 +3817,17 @@ static struct fib6_info
>> *ip6_route_info_create(struct fib6_config *cfg,
>>           } else
>>                   rt->fib6_prefsrc.plen = 0;
>>
>> +       if (cfg->fc_flags & RTF_EXPIRES)
>> +               fib6_set_expires_locked(rt, jiffies +
>> +
>> clock_t_to_jiffies(cfg->fc_expires));
>> +       else
>> +               fib6_clean_expires_locked(rt);
> 
> Note that I do not see why we call fib6_clean_expires_locked() on a
> freshly allocated object.
> 
> f6i->expires should already be zero...
> 

Agree! I will remove it as well.

>> +       /* Set fib6_table after fib6_set_expires_locked() to ensure the
>> +        * gc_link is not inserted until fib6_add() is called to insert the
>> +        * fib6_info to the fib.
>> +        */
>> +       rt->fib6_table = table;
>> +
>>           return rt;
>>    out:

