Return-Path: <netdev+bounces-255585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKnoK3UTf2mrjQIAu9opvQ
	(envelope-from <netdev+bounces-255585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:48:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A64BC546C
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7D59300D61C
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88629DB65;
	Sun,  1 Feb 2026 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvjQkr4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5842A96
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769935730; cv=none; b=GAKr88iwr1VnM1xg6k9WHUWydEM8SRPW4RaPfuX2Mo1g3war9Ke5sh7vSX/AMucyFkWRffpNNvZq29NMj/4WeH4mFkmuPwgdDdpQgLHediJyaZHTGD4jWY2/cDq15RgZxleOpOAvyXZ2o8l5g/AAjSJZMNVJ3Lj1oRxDSu5NH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769935730; c=relaxed/simple;
	bh=Ere2kN2yFVT5obqH5hlnA5Ttr7Gyk7Tuo7w5BE8mSTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=un59wfIetVcM0leIJYFDjNnjmj4L8CwgeTen3ZFP0yNbuID/DXmwJKCwd1RlFCUbmTMeNTF8asTYl+niaWFCiZj6Eaeuzle/zQl8Sqmtpd00TNib59vB25RPb2wBGz32SxqoGLo+M7TMQoyq8JESDGCveGZprSZxjx7XmKz8i88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvjQkr4w; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso35207375e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 00:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769935727; x=1770540527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQYVo8wUUIsipjAaNjjpaYYLiKB8jCLHlOMiv+xcDBs=;
        b=XvjQkr4wmdmYCSAwn8lFzWLWXn51l/kFrPKiWDILhUdTpWUeNOZguvZSbFnZjC9WvA
         eWnIBGbVqYxRzTvNB9d40xFdZfAu0RId21RZCRd/M19oOyUrcXVhjNFa5T8HnBdobBHd
         AqRFA+eOZNDcAnCBRiYNLKWDyOPKvJQa2QNChk10G1VHlHYogVqkwNW4dCOpf60i+GDH
         6aNGLZbWKxFAJS9/ma+8HkLW+kbJUWzZl3wibKqLjIi3PZ14KV8bHEtthisbwNvrh6Ho
         PuJNFQw3PxW/N5iQs/gqna5upl8t5g+APFfGmDunB3i5nn2PUxh0xiW6LcCPVOaoZ4lF
         RgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769935727; x=1770540527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQYVo8wUUIsipjAaNjjpaYYLiKB8jCLHlOMiv+xcDBs=;
        b=uojJZYv4OfpeED/9TffYMHS1Fmz2EbLc5v2K1gRe8/CKv/fxE85QV3BbW1s9VnM6Hq
         NzsXVNBnJKJYfcP/5HZoqLhpIjNtPSF8NlT+6W7xJkyl0nWaf8aoDo8RakX72FiaDyHP
         8WnwZPXv1dlodF0bCjvwN+auhKiojJYYW+o7dFpOmO6JFwotDFjqCWiCgnvS7K/FlFHQ
         +lBQhmco/w0QJmTOgtzi5zJJnP919qprFChdXHYY65T6exTp8YXK/UgieSwLLYya9h0S
         RT7zFqUq0JJWdAuSv/Y5159YKFi/kAMH5f7IBxU47OIYB56hyOQbdWoEBWsz88oYuzMh
         zntA==
X-Forwarded-Encrypted: i=1; AJvYcCUAvwCzAFbjkcyQk955PvTPEl89tRNvOWI/0/uBxw8NPY7qF2DxpdijcPwZ+9YIaBgEYjo2WAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkeDqpk01wQR1GNyHv3vhMY976SI5/PtP+KxdNi41KFmyiCj3
	qsP8aHy9L83G1trB6BqWtRxlvo247lqprbAZ5EDtZtt/2Jk2mNf9qN1s8lI+4w==
X-Gm-Gg: AZuq6aLJIpkwCJWduG8tgQBwRTqIu1OqLGwlMziVUiABr4B21zLYc8y1howUE/kCyQT
	pt6rY9SqM5deMhz/Oujfi5H0Mu+CIs+V/U+r1PQE83jeXFA8QTZH/CRQl2I1SbWGqFqAsfTU+iO
	PQadXUuIU0Tm1yX61Uf3ll5dwt6TFqxlsnvc2K5nJgHsiHFdgQsCsXnM32BYgv1piI/yx3m5k4A
	P6dpZ90jPENUEJFmy5mFmNoNzM1Wk7GWdButo5MjVAB/x1Rb9S1XpZYjmai7VUK2VI3hEpyurUZ
	ezTn//PYsGSmmHCrK7dNfubfXwpPPybo3btbNEZwjwFN7hZH0BCt3up4GNYanSj2nGYfNotE0sh
	gO75PluoY1bRmpfAI6NyWWt790REgWXEDjxkw6TeyWIWvBE6fzuZUJnnaqHLzvnoeGo9shBtzeo
	xEotABl/oGrjGw5sx9aGfEBGQwXp6QYzJQSdsaGv24CBWuK2oqrRUMYUBR7K4/4aDTXQ==
X-Received: by 2002:a05:600c:1d1b:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-482db4939d8mr99095085e9.20.1769935727260;
        Sun, 01 Feb 2026 00:48:47 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:de84:3bd0:284c:aab5? ([2a02:a03f:a75e:9a00:de84:3bd0:284c:aab5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dffd47c2sm60863555e9.0.2026.02.01.00.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 00:48:47 -0800 (PST)
Message-ID: <d0b4b06a-94ba-4665-9593-2c507ffb552a@gmail.com>
Date: Sun, 1 Feb 2026 09:48:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
To: Tom Herbert <tom@herbertland.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-3-tom@herbertland.com>
 <willemdebruijn.kernel.235a1f46c52f8@gmail.com>
 <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
 <CALx6S35Z63WDMOkZLJ7PzR6BcEV4h5f7Jm-Okw9izcuFcygNoA@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <CALx6S35Z63WDMOkZLJ7PzR6BcEV4h5f7Jm-Okw9izcuFcygNoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,herbertland.com:email]
X-Rspamd-Queue-Id: 1A64BC546C
X-Rspamd-Action: no action

On 1/30/26 18:22, Tom Herbert wrote:
> On Thu, Jan 29, 2026 at 10:13 AM Justin Iurman <justin.iurman@gmail.com> wrote:
>>
>> On 1/29/26 06:30, Willem de Bruijn wrote:
>>> Tom Herbert wrote:
>>>> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
>>>> of the TLV definitions. Label each of the TLV definitions as to whether
>>>> they are a Hop-by-Hop option, Destination option, or both.
>>>>
>>>> Signed-off-by: Tom Herbert <tom@herbertland.com>
>>>> ---
>>>>    include/uapi/linux/in6.h        | 21 ++++++++++++++-------
>>>>    include/uapi/linux/ip6_tunnel.h |  1 -
>>>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
>>>> index 5a47339ef7d7..438283dc5fde 100644
>>>> --- a/include/uapi/linux/in6.h
>>>> +++ b/include/uapi/linux/in6.h
>>>> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
>>>>
>>>>    /*
>>>>     * IPv6 TLV options.
>>>> + *
>>>> + *  Hop-by-Hop and Destination options share the same number space.
>>>> + *  For each option below whether it is a Hop-by-Hop option or
>>>> + *  a Destination option is indicated by HBH or DestOpt.
>>>>     */
>>>> -#define IPV6_TLV_PAD1               0
>>>> -#define IPV6_TLV_PADN               1
>>>> -#define IPV6_TLV_ROUTERALERT        5
>>>> -#define IPV6_TLV_CALIPSO    7       /* RFC 5570 */
>>>> -#define IPV6_TLV_IOAM               49      /* RFC 9486 */
>>>> -#define IPV6_TLV_JUMBO              194
>>>> -#define IPV6_TLV_HAO                201     /* home address option */
>>>> +#define IPV6_TLV_PAD1               0       /* HBH or DestOpt */
>>>> +#define IPV6_TLV_PADN               1       /* HBH or DestOpt */
>>>> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4  /* RFC 2473, DestOpt */
>>>> +#define IPV6_TLV_ROUTERALERT        5       /* HBH */
>>>> +#define IPV6_TLV_CALIPSO    7       /* RFC 5570, HBH */
>>>> +#define IPV6_TLV_IOAM               49      /* RFC 9486, HBH or Destopt
>>>> +                                     * IOAM sent and rcvd as HBH
>>>
>>> Explicit labeling with HBH or Destopt is quite informative.
>>>
>>> Does this mean that IPV6_TLV_IOAM should also be accepted in ip6_parse_tlv
>>> in the Destopt branch? RFC 9486 indeed did reserve a number.
>>
>> Nope, not right now. The only IOAM option currently implemented in the
>> kernel is the Pre-allocated Trace, which uses a Hop-by-Hop option. It
>> wouldn't make sense to have it in a Destination option, although you
>> could (i.e., it's not forbidden, just weird). Actually, the only IOAM
>> option that would make sense to carry in a Destination Option is the
>> Edge-to-Edge (E2E), but it's not implemented in the kernel. Should it be
>> implemented at some point, then yes, you'd have IPV6_TLV_IOAM in the
>> Destopt branch as well.
> 
> Justin,
> 
> Conceptually, someone could put IOAM in Destination Options before the
> Routing Header. There's about 0% of that ever happening though.

Tom,

Correct. However, I wouldn't say there's about 0% of that ever 
happening. At some point, I remember that we even thought about using 
the IOAM Pre-allocated Trace in the Destination Options header (the 
first one, before the RH). The goal was to use it with SRv6 and collect 
telemetry for the overlay. There was also an attempt at including IOAM 
within SRv6 directly (draft-ali-spring-ioam-srv6), which didn't get 
consensus at that time.

Justin

> Tom
> 
>>
>>>> +                                     */
>>>> +#define IPV6_TLV_JUMBO              194     /* HBH */
>>>> +#define IPV6_TLV_HAO                201     /* home address option, DestOpt */
>>>>
>>>>    /*
>>>>     * IPV6 socket options
>>>> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
>>>> index 85182a839d42..35af4d9c35fb 100644
>>>> --- a/include/uapi/linux/ip6_tunnel.h
>>>> +++ b/include/uapi/linux/ip6_tunnel.h
>>>> @@ -6,7 +6,6 @@
>>>>    #include <linux/if.h>              /* For IFNAMSIZ. */
>>>>    #include <linux/in6.h>             /* For struct in6_addr. */
>>>>
>>>> -#define IPV6_TLV_TNL_ENCAP_LIMIT 4
>>>>    #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
>>>>
>>>>    /* don't add encapsulation limit if one isn't present in inner packet */
>>>> --
>>>> 2.43.0
>>>>
>>>
>>>
>>


