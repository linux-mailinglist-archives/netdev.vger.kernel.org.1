Return-Path: <netdev+bounces-267362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHZhESres2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:51:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEE7280D6C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B8EE31C67B5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672B346760;
	Fri, 13 Mar 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="d1ob8u2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168435A3AE
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395233; cv=none; b=Ijije3l70AQvWtRj3imIjlHGVabXpIvOW+SUo0eIpWRagZuxtHJ6+IXbD+KjaqbRZhHSJqaLfHrQItfBCy9+7iAIlF7dujOaRf0Mt41fv/DcS5oy4DKnoV/M21TDuS5WtrWMuOWynQ8cX2b5yshvm/ULcAFT6Aqa5x0r2byrVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395233; c=relaxed/simple;
	bh=riFcQF2BEYasyIZWANU3L4biJkzrfXJrCIA1tGExzcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiK+ETQtNjNBUxXOrk4E93ThOJoB/nTd55TjasATRKt39ZpzjH6zV1gDrHT4omVyjiGKBXiZeQuuBQP7g18m249187aadl+k2nwDJhsuvcjWV9AP9bFV6YT8r2jqG+XhZ3AQMt6RWjd3WLGlRvi/nDdoOo9hwo2Z8bUER2ni+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=d1ob8u2F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853589700fso993705e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773395230; x=1774000030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qMokjq4X75xk3aQqEzawH6WxLom7kkQ8J0PIPKkrvog=;
        b=d1ob8u2FktfjqCO7DTN4WCPSKBAdJECY5m3Ilg5WxqZzBO3VFsA9SQGPMaVNHKjKHN
         KtpSCJGUnV+t7J6ZvGrUZFiKWft7FZh2TXQ5PTliyVZVDQLh9qRq7wTxfE6WEyf4iyJ2
         rrCS34SAtQ+fIDyM5JnqVjBLhkjXCLrMqLWdaCO/CQvNJ/KCDDu62sRZarnQ/7ODoxmW
         uKRKzCdPDqEHqfSSXFCMz1W+ZJatqee/+aFznvvKR2hyXQUrdTPzrfUltv2ssK4bIZHg
         X5DcveI2ZKHmBNAp0LtMysFoOInULqEF4wR3Z7KyHVNZS1jEAafcYYakbfKiZsKRjSf9
         36Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773395230; x=1774000030;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMokjq4X75xk3aQqEzawH6WxLom7kkQ8J0PIPKkrvog=;
        b=AybyHrd92YdahaNkRFZR2uuYvhiPf0ifViGi0SU/v/TRGo7gyWJwARfHyZWjg0SzDH
         yjgdQJ4FJV+AZx7QBphSBdaGYbmoQjhJnSfVflSBaMyOk7UYHQ1N4xTH3MSuOCgAPfi1
         TPOhUoM4rftGqE2tw7eOOTb481pboLw7FlwbSPucoAFRi1DAoeNQXDrBkLlnwk87RViq
         iBnCtNeGGxYXHr4NKYnQf4RtX7XHkjOsfX/RhpJEjyHilRrd5PuozlCJZ4pNggL37zZT
         M0BzwjUfaBuwFiB4Y7v/0EkC4VrQxSKzddYvS1cwmhAryzjXryUirOw5ZfLsnXOUKTu5
         KnuQ==
X-Gm-Message-State: AOJu0Yyx0mwU9pjdPE/HRKqO7OsoUdRqaznz90X8XhzTZ/31gM/zkTOM
	sTqHRFNymy4TXNgR7d5P0qBcBmpGza3OJU2FPfd/CUcsDzIk5SWxPZFfdEId/Htqlng=
X-Gm-Gg: ATEYQzwPnRbeSj0Q5Yc7UEliIQpNRVLhDJlkj91OU4ImyXjCpuKVkMslR7VF8MSIDAL
	12quFALaL9KgRO59LgcnxUu5Mk+rytx25vQomUYATIJzuSP2cf3VvWL7ZAKKD1FhtvtWINSvwL/
	+IdgTZ3790rvYSHhfjfVYHO4WOQIqio/HJhyUHoAWxTjQapi5uMH1prAUPGqcmDQ0HAzAkJ2CYL
	c6m/lTCCwJ1PDMQzVGB+smrufoLIptFVpu/ONvvxkH/zs1BlV/Yr/j1xSXBov3MfhJBa3TzyeSl
	sDmy02npMLnhev3dCKuHnlf0IOrFGT26zCKI+/ei+8nF1+/tkwFrHlRrdxDlw9SifznnLYjtXAu
	BSyXtWKeUVySeLaC/TLTLV3v3Du9P2abNDZv/25877XFFd96auT41MvVv35p2xlAlWk2/NWoIaP
	/7ZAs00+Ut36ofz2ZwHMm+wkMVZR5jEIjkRu6ORrVCWBr/Yud9T4DKL8P5Rmwc3gm0GIH4VrRcU
	M6h
X-Received: by 2002:a05:600c:83c5:b0:485:2fe9:33a7 with SMTP id 5b1f17b1804b1-4855670529bmr20731065e9.3.1773395229579;
        Fri, 13 Mar 2026 02:47:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a78cesm15522975f8f.11.2026.03.13.02.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 02:47:09 -0700 (PDT)
Message-ID: <43e16e45-5fb1-4413-bbd1-4752bbcdec7d@6wind.com>
Date: Fri, 13 Mar 2026 10:47:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
To: Justin Iurman <justin.iurman@6wind.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 justin.iurman@gmail.com, stefano.salsano@uniroma2.it
References: <20260311152845.278354-1-justin.iurman@6wind.com>
 <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it>
 <CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,uniroma2.it];
	TAGGED_FROM(0.00)[bounces-267362-lists,netdev=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email]
X-Rspamd-Queue-Id: 9AEE7280D6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 13/03/2026 à 09:44, Justin Iurman a écrit :
> On Fri, Mar 13, 2026 at 2:02 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
>>
>> On Wed, 11 Mar 2026 16:28:45 +0100
>> Justin Iurman <justin.iurman@6wind.com> wrote:
[snip]

>>> @@ -702,13 +721,21 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>>>       slwt = seg6_lwt_lwtunnel(newts);
>>>
>>>       err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
>>> -     if (err) {
>>> -             kfree(newts);
>>> -             return err;
>>> -     }
>>> +     if (err)
>>> +             goto free_lwt_state;
>>>
>>>       memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
>>>
>>> +     if (tb[SEG6_IPTUNNEL_SRC]) {
>>> +             slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
>>> +
>>> +             if (ipv6_addr_any(&slwt->tunsrc)) {
>>> +                     err = -EINVAL;
>>> +                     NL_SET_ERR_MSG(extack, "tunsrc cannot be ::");
>>> +                     goto free_dst_cache;
>>> +             }
>>> +     }
>>> +
>>
>> build_state() only rejects ::. Multicast or loopback will be silently
>> accepted, leading to an asymmetric black hole:
>>
>>  - seg6_input() path: encapsulated packet enters ip6_forward()
>>    which has the "security critical" saddr check; drop on the same
>>    node, packet never leaves;
>>  - seg6_output() path: goes through ip6_output() which has no saddr
>>    check; packet leaves, first transit drops it in ip6_rcv_core()
>>    or ip6_forward().
>>
>> Either way, silent black hole.
>>
>> I think we could reject these at build_state time, matching a similar
>> logic already present in ip6_forward(), e.g.:
>>
>>         if (ipv6_addr_any(&slwt->tunsrc) ||
>>             ipv6_addr_is_multicast(&slwt->tunsrc) ||
>>             ipv6_addr_loopback(&slwt->tunsrc)) {
>>                 NL_SET_ERR_MSG(extack, "invalid tunsrc address");
>>                 err = -EINVAL;
>>                 goto free_dst_cache;
>>         }
> 
> +1, makes sense.
> 
>> Whether to also reject link-local is debatable: ip6_forward() does
>> drop it, but is there a legitimate use case where a link-local tunnel
>> source would actually be needed?!
>> I'd argue we should reject link-local addresses as well.
>> For instance, using them as a tunnel source violates scope boundaries and
>> breaks ICMPv6 error reporting.
> 
> IMHO, I also think we could reasonably forbid LLs.Why rejecting LL? It's legal to use LL as a source address of a tunnel (and
forwarding packets in this tunnel). Is this forbidden with srv6?

