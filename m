Return-Path: <netdev+bounces-211881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C55B1C2A1
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB31885993
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A881FECD4;
	Wed,  6 Aug 2025 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="RfpTy5cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9014A8B
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470851; cv=none; b=pb+twsr/3s+wu/zIh2tAQETUJiRt0VxIyUG3+FThAKMK36Z+h+KFvucvQlz+l3avc3JHz1aFNCwN0QiZ49vHdBegxtlbQgGzFxJKIRToo1Y1ykhffeGnllzxVbzWVBunkYIbxtkXhGQy2nk2xeyJaylsNM+vy0RU2d2SteQPUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470851; c=relaxed/simple;
	bh=Rjfi1UQGZ6KFWUZLLSfDhUXwb/P+ihESd3Zl3g/srsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBYrSHRGR99xB3oRWqKcAGFUh8rBw1oB3d5drUcVDhbF0X0zIWujAadmBUIi3Bap9V33XCI4DI1bCy6KitJMiHtqryiF22ZDxCayyAiYvPAAY4JSH3oXOCIWcw0cSaIHWH/ZRGIPFxKNwHD0rOxZIvwcxPve/rDzxD850RWjHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=RfpTy5cz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458b2c1a7ddso3177005e9.3
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1754470846; x=1755075646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AS20fYcg+JBveakkFyf9zBX11AsBWg1BQHTkOuw0RRo=;
        b=RfpTy5czTuwbyBW0bn1OIt0BipEiVy3nfa/0n1wun6AebS0/ue/N1qXO8ci0h1ou6e
         8JflSI3a/ex2A+OZjV3RarIszQuygIlrYkOqaV7gx21Q0J+FwHovJnsYkF0jgEtzkqIs
         oGYdH9q4kNuIXLSG3LvglFQyiCb1yrZ2MEkDFJ/GTPXv1YYDG34B1vqv9nBuCgmyPVsb
         bHXAha9Js/hkK33htYrcOcEWpip2TAVdQXgNMYHrp65nFZOpl7XJjKvILZznZ3iQj6pE
         iKH9IQpc5qwuhDFi4qr8y3/DFOImioXlbXZohhTq/IZmGzHFFXFOgaCcnzHGA/mxuOcB
         cUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470846; x=1755075646;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS20fYcg+JBveakkFyf9zBX11AsBWg1BQHTkOuw0RRo=;
        b=tCAVWp5pbCwKGOfAlSyOCjdCT6qOUNnqic4J4BjqUO+tVzVdnbBXBekduSU5bJWRsi
         ZgBJUw2Q7HTNijk6Ly/pdywBdz3LPrKfEtpnh7ha1o3OGts37JRfxppQZrlngd/hnUar
         iVjIVOzIWLKDA5NB5pj0FW72B5A6EulpCDAkuvJyMph8FHZltbPim7Na46XORKfa320v
         9GyiZGb/eV3Wf5suDy9bEU7DJ9HC72b0F6sLenNQxjLWPDBD4WrBv2bAlcCG9zMoY8Ei
         H/P5Z/hKMXywevGlmx8IVE1Yej3eLpSU8tEKNzuaF4f/xb1sd3RPRAD2worAnyOOKX0P
         WrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHgS8s77gJ0ZEwYGzMoZS8DXMi7fkx1Rbk6WnIiYRgJ08oY0liibj526Wfwa17oo38abAlAzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEiwzH5wW/RWeSFnnbF8iudunuEEwAsxgrHvLIOc14RPb0rYaS
	cx2W6zf+RhCJ0R7WWC5UF6MZTfCSl58uki86OftmwC2Uiz8akG13pWIXyR4FAJHzOMvsH9uJMkt
	gC1Fr
X-Gm-Gg: ASbGncv4MSilLoB1Lw31Z4zeRl77TIs3b2Wtz28d/rjyTYiJcRb8DAFEpAi5WlJSTcM
	FJ0ReewBagjr7QvA7QqZ9oG9ifX3KkeCPe0e8eRS041qiXWLHNzWdugnserfZWoVz+Wl62Lphv8
	VgLIOhacqO+ZL4dDw5EAbBVDLv24z76tT6vriYGcVNWhsPCqCCwmqI9UIxIT+m72r8tmZSoC6Lv
	MzFzIWzi7NlGzBpXjD0ZaM7aUcC3vN+XWgkC/Vd8DlhWkQMqo3ArowEeC6DADDQXnl7uVGwfkoN
	3cLe5GxtJ47lU3yVUkkwUrE/NOH7R/OfVfGf9g08BQQtam6MgE/rfMJ13sBnZP30m0REpC6dFug
	a4s4uVOBaI/7erF/EHzUfXrLcT4+eWrJtzxdcdjc0o+qoeKXc5N7pFoePCdglEh5Yh7rMsectVC
	sUlGhDuFUrxg==
X-Google-Smtp-Source: AGHT+IEhb+BggPN/CI2vNE/LgY/nbRZn/giDOrRTOMSN8GN+JdcTwX5Rvb8hvEEs/+aNZlsz8gDb0g==
X-Received: by 2002:a05:6000:381:b0:3b7:98bc:b853 with SMTP id ffacd0b85a97d-3b8f41cb986mr744335f8f.9.1754470845857;
        Wed, 06 Aug 2025 02:00:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:c0b8:f5d8:24be:e371? ([2a01:e0a:b41:c160:c0b8:f5d8:24be:e371])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b8aab8c0sm171537685e9.19.2025.08.06.02.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:00:45 -0700 (PDT)
Message-ID: <0e6f765c-89a1-4628-9234-3d89425c3ca6@6wind.com>
Date: Wed, 6 Aug 2025 11:00:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: When routed to VRF, NF _output_ hook is run unexpectedly
To: Eugene Crosser <crosser@average.org>, netdev@vger.kernel.org
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <f55f7161-7ddc-46d1-844e-0f6e92b06dda@average.org>
 <2211ec87-b794-4d74-9d3d-0c54f166efde@6wind.com>
 <7a4c2457-0eb5-43bc-9fb0-400a7ce045f2@average.org>
 <ed8f88e7-103a-403b-83ed-c40153e9bef0@6wind.com>
 <c5909e04-35c7-4775-bd17-e17115037792@average.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <c5909e04-35c7-4775-bd17-e17115037792@average.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/06/2025 à 17:27, Eugene Crosser a écrit :
> On 20/06/2025 18:20, Nicolas Dichtel wrote:
> 
>>>>> It is possible, and very useful, to implement "two-stage routing" by
>>>>> installing a route that points to a VRF device:
>>>>>
>>>>>     ip link add vrfNNN type vrf table NNN
>>>>>     ...
>>>>>     ip route add xxxxx/yy dev vrfNNN
>>>>>
>>>>> however this causes surprising behaviour with relation to netfilter
>>>>> hooks. Namely, packets taking such path traverse _output_ nftables
>>>>> chain, with conntracking information reset. So, for example, even
>>>>> when "notrack" has been set in the prerouting chain, conntrack entries
>>>>> will still be created. Script attached below demonstrates this behaviour.
>>>> You can have a look to this commit to better understand this:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c9c296adfae9
>>>
>>> I've seen this commit.
>>> My point is that the packets are _not locally generated_ in this case,
>>> so it seems wrong to pass them to the _output_ hook, doesn't it?
>> They are, from the POV of the vrf. The first route sends packets to the vrf
>> device, which acts like a loopback.
> 
> I see, this explains the behaviour that I observe.
> I believe that there are two problems here though:
> 
> 1. This behaviour is _surprising_. Packets are not really "locally
> generated", they come from "outside", but treated as is they were
> locally generated. In my view, it deserves an section in
> Documentation/networking/vrf.rst (see suggestion below).
> 
> 2. Using "output" hook makes it impossible(?) to define different
> nftables rules depending on what vrf was used for routing (because iif
> is not accessible in the "output" chain). For example, traffic from
> different tenants, that is routed via different VRFs but egress over the
> same uplink interface, cannot be assigned different zones. Conntrack
> entries of different tenants will be mixed. As another example, one
> cannot disable conntracking of tenant's traffic while continuing to
> track "true output" traffic from he processes running on the host.
> 
Sorry for the late reply. I'll let netfiler/vrf experts answer these points.

> Thanks for consideration,
> 
> Eugene
> 
> ========================
> Suggested update to the documentation:
You can send a formal patch for this.


Regards,
Nicolas

> 
> diff --git a/Documentation/networking/vrf.rst
> b/Documentation/networking/vrf.rst
> index 0a9a6f968cb9..74c6a69355df 100644
> --- a/Documentation/networking/vrf.rst
> +++ b/Documentation/networking/vrf.rst
> @@ -61,6 +61,11 @@ domain as a whole.
>         the VRF device. For egress POSTROUTING and OUTPUT rules can be
> written
>         using either the VRF device or real egress device.
> 
> +.. [3] When a packet is forwarded to a VRF interface, it gets further
> +       routed according to the route table associated with the VRF, but
> +       processed by the "output" netfilter hook instead of "forwarding"
> +       hook.
> +
>  Setup
>  -----
>  1. VRF device is created with an association to a FIB table.


