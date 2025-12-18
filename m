Return-Path: <netdev+bounces-245367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94216CCC50B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A1630E0E11
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57A338591;
	Thu, 18 Dec 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aI7kV/Vc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D663337BB6
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068127; cv=none; b=oAU2/dRBF7JbfDl73RGB306D3380KXswuY1M9WUoJ0khDDxlUCA/b4P8nbhq1T6wETzbWj4s75oceLzw+i1Yl4PS1nO6guG2YG/2Atkhx7yrnIIrfZw+42SRW3UeLt08loDG3mxPa41S2D5yw4NGDSqgRpvOshwGruX1m5LVtAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068127; c=relaxed/simple;
	bh=Qh/o0My9IXFqpNIxAnsLudR9BCeT6bwNQ7IvDYD6MXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1BWkEotBagCVCbbQtbwvHUVkUDmKKU/NmOh4Snu3EfVKbnmsGX7AvCW8ruq7ZpE92by6k/tQoJdzJyF9v7O23lhjMQ/o6jMlP9hdEp+qKIckbc6tVveyOVX7SmGwzsEiiQQFPsdkzoV3r25ZSABPd+dxeewNU+cg8FjhOgLPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=aI7kV/Vc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47928022b93so1541955e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 06:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1766068123; x=1766672923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wsG+uhBVnyABo0WRb8gG8p3JTTGBZ7OJ2w3pDH7XoxI=;
        b=aI7kV/Vc36XwXOd7zN6MumgeXB1bd5dbvD7y6HWYp+dI+cJcjwiISpky+HWvwEsw9R
         B6ChLTLXXEMmBDFt7U0W9pRtn7Wt+rUiPkQi9sFmSACgfiCCB7O0vRjJZRaT+yVTI5fs
         KimzJHrIWBdBjHb3f1Uku3eF7sgfhs49ozrXoa7aIxbpKmIuBz+q7wiRLCgqVCVKonz3
         mg5+4ADVGaEljJ6TcWSmIF9g42ojoEtLP6pg9yUhw8e/xN6AJQDzmWympiSnXnag4S3M
         977pG70xLtQmaxIwVH9s+7AsHod6y6uFSDVsRZ8U4xFqGG6jYez6BJJjUKg14PlrH4sb
         17Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766068123; x=1766672923;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsG+uhBVnyABo0WRb8gG8p3JTTGBZ7OJ2w3pDH7XoxI=;
        b=v1UwOdoqxQ04w0Vz0A6r6nXgZXJv3EAps4elsXHcUeRyL1HIYDDhJK53MFC7c9GGqd
         s0cpwP1I4zUdrTRXsUnT3lzl6Ks90GmadJY971FBhBtdUSGnEdCx2MOloKy8ZAv04WZ2
         mN24QccxLubBg3wJ+kGbrVn/46uFfzr1UEsrwgwWauNmWNGfxjRKfnZa0sogOZjoJp7M
         OYzNkddnGA2bcr76Bq/Nvs1kdhsCglv5hP08zGTBZ4Om09v+ffolC7HGwV59b7cPNxxV
         +OiFVIkpv1Cm9Z+JAV7nQyMEKE00i75hyexsb6d6jcMrwYjFZe165oq43IQAhoCQbNpZ
         i6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVMf8jBrKEaLOTJB7CPZCojxm8AqoyvLcg4laY5NtIW770dEzLnERHlYGEK6uzDHMkCH6rvY00=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJxlWmYq1UNbTF9z+JoZrxeM0XneI6VjeNE8RQemLfLXrLEU6
	oxCgu68tTIQboxhcOsZyRdyzFfn5pupZ2iA3IKzFA6W38SbAfPkbA5aObn/wL/C9VgvQk/nWVtp
	fIQrCzk0=
X-Gm-Gg: AY/fxX4BU31tDuDYEg6F/nEwA97FGN4asNSz2d315ICNw3FpM7Wbg0jYlDgMxypozce
	7oZEPaFV23jvAPc966a1cFaZxNwl+dxSJvA7ts6y6E3yt4tAHHZn3h5pUGX70+FqmVohIcxoBBv
	bW7/V6zbxJZGxGM6zo5yIjLgtbbcMUrj3a1pu4jmS1J1OYHANSDzYq5UZkIk8C4jWqkjHS6n/2V
	Sv6O0NZICgvNvtJI/I/M9672Znaot8Myu5fHIuUaP81D2njKebhn2pd01FL5yHFfelrgk7vWC9L
	nUY73/qZFuJgzRukkLSWe1ZZ0HVdA4eVJQmJCwXStgOI45BEZnwdD1Q0kZvpJFzmTrVyWVabMTS
	G/LfsjcF6CFH+FmOyCvymwo15VjdEr0PKtzE5grkwjXDpfGEpz7cxjyZQHhgHQ5/xhxkLBxt0YY
	vko15FzWjxvOSMSgNU4WtlAhMy02lgy8HzjFA69Hma1tflrSc9lliPFnrMxAZr2O0=
X-Google-Smtp-Source: AGHT+IGRpqq2j5/cFryODQP666Y4zlWz3rVkctq9z8wXzLm4joAqtBvzf1C9TK9x3m6rkgag3VUcJg==
X-Received: by 2002:a05:600c:4e8a:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-47ce8776b26mr12151065e9.3.1766068123376;
        Thu, 18 Dec 2025 06:28:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934cf5sm5391877f8f.1.2025.12.18.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 06:28:42 -0800 (PST)
Message-ID: <364fe528-87a1-4bc3-bcff-7fa73eb9eb44@6wind.com>
Date: Thu, 18 Dec 2025 15:28:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] seg6: fix route leak for encap routes
To: Paolo Abeni <pabeni@redhat.com>, Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Lebrun <david.lebrun@uclouvain.be>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 stefano.salsano@uniroma2.it
References: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
 <20251210113745.145c55825034b2fe98522860@uniroma2.it>
 <051053d9-65f2-43bf-936b-c12848367acd@6wind.com>
 <20251214143942.ccc2ec1a46ce6a8fcc3ede55@uniroma2.it>
 <3394763c-c546-4c80-8157-98467c8e8698@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <3394763c-c546-4c80-8157-98467c8e8698@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/12/2025 à 11:35, Paolo Abeni a écrit :
> On 12/14/25 2:39 PM, Andrea Mayer wrote:
>> On Wed, 10 Dec 2025 18:00:39 +0100
>> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>> Le 10/12/2025 à 11:37, Andrea Mayer a écrit :
>>>> I've got your point. However, I'm still concerned about the implications of
>>>> using the *dev* field in the root lookup. This field has been ignored for this
>>>> purpose so far, so some existing configurations/scripts may need to be adapted
>>>> to work again. The adjustments made to the self-tests below show what might
>>>> happen.
>>> Yes, I was wondering how users use this *dev* arg. Maybe adding a new attribute,
>>> something like SEG6_IPTUNNEL_USE_NH_DEV will avoid any regressions.
>>>
>>
>> IMHO using a new attribute seems to be a safer approach.
I agree.

> 
> Given the functional implication I suggest using a new attribute. Given
> that I also suggest targeting net-next for the next revision of this patch.
I see this as a bug. A route such as
cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0
with veth0 completely ignored but mandatory is buggy.

> 
>>>>> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
>>>>> index 3e1b9991131a..9535aea28357 100644
>>>>> --- a/net/ipv6/seg6_iptunnel.c
>>>>> +++ b/net/ipv6/seg6_iptunnel.c
>>>>> @@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>>>>>  	 * now and use it later as a comparison.
>>>>>  	 */
>>>>>  	lwtst = orig_dst->lwtstate;
>>>>> +	if (orig_dst->dev) {
> 
> Here you should probably use dst_dev_rcu(), under the rcu lock, avoiding
> touching dev twice.
Ok.

Thanks,
Nicolas

