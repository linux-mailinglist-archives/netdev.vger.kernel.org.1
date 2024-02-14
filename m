Return-Path: <netdev+bounces-71745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56370854EC9
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2601C28088
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43A5DF03;
	Wed, 14 Feb 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0IXz2WD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D62604A3
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928754; cv=none; b=HUwHdCNpiyeQB13AsqocBFEitsJiFcCUS7mePb+BjAdI+tFmvTpGyAO3N4EPBwvUbPEX2KonOYUOIna/L8Qet7qWXmhMeo0aZYFEKPqxwRcK/EAM6wJLdrNeGS4/rijn2VSZ8Vwe6ryPmijT6oRSIr6HFaVwCprZuJ0Twl7vLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928754; c=relaxed/simple;
	bh=nttmJ+jTAO5V2LTBqxjyS5ZLK66cAwYXoazfIiT/FJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tskxJxhvFshMhmPDZiEr+YYgizYLWWL8aUiL3+l233qEVkHYVQkQQx+nLITHAYEUOeFGXqcpgGqSdVz0Tu7ASgrwqR0jke2XUHpO0kduIDjrFlLHR80nldMD1wYicNA1gy+e54uS8Yi77UW6VXBMJqoQLmAU/7RJm6s2dA3D7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0IXz2WD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5638ae09ec1so953333a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707928751; x=1708533551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBNebMn83RS2gWNUXknQM5an4qP55hULzmFLGEKJjOc=;
        b=J0IXz2WDckyWIsXRoCUl0sO5SkZla3bcqf5ecQNuNgQLRqiHVK8xFY+Ybv84jyTbFX
         nG1Ep5gK5qflZwNbFJ0+vE0J1t+zNIudNTxDKXpqFsPgVeV2hydtC2jWU0WGrrPunqdF
         PFhSend+TOv7j9OV7WvloWYTF64lHxnH2PK5rBZz9oxpgKLeAmKu/DfXTjbQET8bD0e+
         iPMCDX2TMoPjVkPTdYHJlYGPUh+QEolykORyYOpJgJkFajZuQHUmJQhcFR22dcP+pK+h
         9St0WOuLiroOhCQZX5lGsH14e8EAPzeDfASPsUqZIRg/iwYrUwYzxjrZCa2rwxP3OeiE
         XOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707928751; x=1708533551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBNebMn83RS2gWNUXknQM5an4qP55hULzmFLGEKJjOc=;
        b=EDmPyXoWCPhX0TbXEM0bXE7dP+npVmuJCHB0fNBPFw8Hfy9OfNY0D0r+OAHmaW2bmm
         PRJ8Ef4et4N4q7ok2/67uCPd/mAiLIQ8US5o2PfAJmfXjCe7nXXe5hgKmSEjAGmVdykC
         hROtacTcLTqkwqNOy+KoM+1GU8lm5FRzzJnXCEQqkPJyfLLuTl9qCB6/iWU9Hz6giezz
         Vc6hLtrKdBOGAzcuDNvglgpf0ncuhKOY/mhacrTAToRR6I62HHiapxNAQa1qet+KUB1X
         tS6Xntwop5dcrT1jNnLjR3ZZk9EqpceG6doqoO6dmNQijV/07Dq88/lO/Z1iiTewkMlL
         jfvw==
X-Forwarded-Encrypted: i=1; AJvYcCWWeHDQREEfZMxrhFEFsNaMbQ1EnRJ327wxzldOpb0Bk8gWDRjOuuT/R9xj3t3/8udXuGS2N7Rh+Ec7a4H1fHZteBI/suP5
X-Gm-Message-State: AOJu0YwaN3Lty5DhBf0/nTrWKXDAVYJoZ7cHX5APKkPmjBWcasTGRc7e
	8PfywMwZWvBm3GN28XsxpsxSVXk91uMc2+RvGhWArO/UBM5J/3TL
X-Google-Smtp-Source: AGHT+IHJZ96JzXwy+SujP+BLjpVXBzieeOhT8TXUJrHCZWu3N755ZF5YgSa4shq98f7GhEBCHuksaw==
X-Received: by 2002:a05:6402:530d:b0:561:f0f1:5e01 with SMTP id eo13-20020a056402530d00b00561f0f15e01mr2171520edb.10.1707928750602;
        Wed, 14 Feb 2024 08:39:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqI5+BalssfgbclntHNF+gOVrCd0yTexn80Cm/zmUNt3Kt68Ns0v4LQ5yt00OBz3UDFkUyE4YRcK2t9m4EWZn5YSbOJbEOhLqIT2JqiWtTbs8MSCOOLBRkwJ32Up5zgYVGJF3T1T4a628zJIpS/8G3dBh8uQ0PpBg60lhM5PQdIIrg
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:1e51])
        by smtp.gmail.com with ESMTPSA id dc11-20020a056402310b00b005613cbbdb81sm4832717edb.80.2024.02.14.08.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:39:10 -0800 (PST)
Message-ID: <d8948716-ed07-48ab-a933-671f1fc4ee58@gmail.com>
Date: Wed, 14 Feb 2024 16:37:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com
References: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
 <CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com>
 <457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
 <20240213191341.3370a443@kernel.org>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240213191341.3370a443@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 03:13, Jakub Kicinski wrote:
> On Tue, 13 Feb 2024 14:07:24 +0000 Pavel Begunkov wrote:
>>>> +       local_bh_disable();
>>>> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
>>>
>>> I am trying to understand why we use false instead of true here ?
>>> Or if you prefer:
>>> local_bh_disable();
>>> __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
>>> local_bh_enable();
> 
> FWIW I had the same reaction. napi_safe = false followed by
> napi_skb_cache_put() looks sus. No argument that naming is bad,
> not the first time it comes up :(
> 
>> Maybe it's my misunderstanding but disabled bh != "napi safe",
>> e.g. the napi_struct we're interested in might be scheduled for
>> another CPU. Which is also why "napi" prefix in percpu
>> napi_alloc_cache sounds a bit misleading to me.
> 
> FWIW the skb recycling is called napi_* to hint to driver authors that
> if they are in NAPI context this is a better function to call.

Which is absolutely reasonable, napi_skb_cache_put() on the
other hand is rather internal and wouldn't be used by drivers
directly.
I guess I'll just do a little bit of renaming later hopefully after
this patch is taken in, unless there are other comments / objections.

> The connection to a particular NAPI instance matters only for the page
> pool recycling, but that's handled. The conditions you actually
> need to look out for are hardware IRQs and whatever async paths which
> can trigger trigger while NAPI is half way thru touching the cache of
> the local CPU.

Yeah the usual percpu (bh protected) caching stuff and likes, and
the question is rather about the semantics.

To draw some conclusion, do you suggest to change anything
in the patch?

>> The second reason is that it shouldn't change anything
>> performance wise
>>
>> napi_pp_put_page(napi_safe) {
>>       ...
>>       if (napi_safe || in_softirq()) { ... }
>> }

-- 
Pavel Begunkov

