Return-Path: <netdev+bounces-90065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF59E8AC9F9
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F44AB21801
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549A142633;
	Mon, 22 Apr 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="SuQAJ1u5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE91304AF
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779679; cv=none; b=JKtTu/Ju3XHLnbBTvkpCboAfPAzM2xVb+KRkI+3bWUHMin5MOGK3G0EylZR8D1SPT3PhotfJgoSgh2GB2hwD4ju2Vlmib07QiMIhbW9BZUu6xnpRks70a0O4W7VbFLOxlalG73JTOPWdHzsGXxo4deYGOKf7cbT4b28b4aJ7tsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779679; c=relaxed/simple;
	bh=hl5oJbsNf4gzOInXJ8W066yRacSaTuoXx+ReKspm1Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdHeQjxcA9ETFP3WLvqtk+mPSoARw1uM8uAoBOnF8M6lQh+bYPZ9SCVeoXC0tPViK2WWGTfKwUNKA2uVn7xIZA7RaiGziSAIqxt76VsA9mw/6Xm2j1HAGo8k998VfOGOpPByn1MyOwYT9qn7DxMqIVNiV85nS0Ox3tSNNr2u8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SuQAJ1u5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a4f291f60so5681085e9.3
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1713779675; x=1714384475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rHPfb79adxY9tsrQzERreXnc7LYXAY8HlWJ0DAd35OA=;
        b=SuQAJ1u56U4u4jM5sFdYUiMmK7OAGCZ+f/sTeNpVCepaME/GsxnbwJHGFwa3Udmy78
         f97gzP8QzGu645BQEopiqhedm53kPpqgxe7nqXmgEb7Rov8VvGYc1RuOlduEAWvs6tIh
         1AuXJUrR3+3CGymNscl0XwADukIctOFKe30RDMTkpoNzDsOOP5YmBEI2B6HhkcGCdqI8
         OJmUgfzoKy+VD5C4sHeo44Xiu2H2s7q0A7VuMYPq0PALw6VCXe9hR8+afdsKxseuFVpw
         rQyYxoNqvKxv5no0P+RDcTmrw0rIkAVMgRADp9142cxXFCVcv1yR4Rvqwxtw6XXcDk35
         rJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713779675; x=1714384475;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHPfb79adxY9tsrQzERreXnc7LYXAY8HlWJ0DAd35OA=;
        b=tMURSSPLJQDBdrU26KSw8w9Alq8O5M1xCehGmT4QXZFmQLk2sjmVAihjGgx+aPVNDF
         I0a1SOsReTQfdkzQ4+LWvbgoQu3acDL6zRxhM6lBaMPKxR+mLahYKcX2PreYOz87FhG8
         q8N5KpHoqSXGCqgXtZgcNbXVfPJN7GVsYSsD+lgqI6wAb9+dszsWwvdeC/ZlIKyhtHbA
         p6CpWLNiqsLYHt72iICi6f/2zm0gp/jkielQ+Jqwa97nM3jLB+06WV2gVIWxdvOYIPoS
         7Rx2vr/0BVPBVJL+Ka3TccAaDhSUec21eKDQZG0cZ39y7zuWVs66SOKf2wSYCotQFhvJ
         uo+w==
X-Forwarded-Encrypted: i=1; AJvYcCU8zzNhUMNg32kBxuVqTs8ti7TGdsfB2WgMPpvKAR4OpMrob5Z2UUKaUh6SXp06ZlZrOyx6Rcr0G8lodEfpQZA6YkKxJJi8
X-Gm-Message-State: AOJu0YxmBwbfbtwLB8jF6VvhP8LzJqY+Q8avj/3VvKXw7ZaF8GgX13HU
	EQ+HY0LxEGsM+loBoEH4eUrwj8PkmBjApV7qBxCjKf99piL7M44vmSIwBfgTr0k=
X-Google-Smtp-Source: AGHT+IFnKBxF0gq6pwmneb2wszkAlBvEBLNC1etoafugT39Z3xKvZlPAjYKb6coeYTrU7hXBv59eMw==
X-Received: by 2002:a05:600c:3549:b0:417:29a3:3f59 with SMTP id i9-20020a05600c354900b0041729a33f59mr5739555wmq.36.1713779675526;
        Mon, 22 Apr 2024 02:54:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bf25:d37c:a088:52d2? ([2a01:e0a:b41:c160:bf25:d37c:a088:52d2])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b00414659ba8c2sm16199455wmq.37.2024.04.22.02.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:54:34 -0700 (PDT)
Message-ID: <796e4bce-2e10-4aea-9d97-3b492616a4f8@6wind.com>
Date: Mon, 22 Apr 2024 11:54:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to
 the SA in or out
To: Sabrina Dubroca <sd@queasysnail.net>, Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
 Eyal Birger <eyal.birger@gmail.com>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
 <Zh0b3gfnr99ddaYM@hog> <Zh4kYUjvDtUq69-h@Antony2201.local>
 <Zh44gO885KtSjBHC@hog> <ZiWNh-Hz9TYWVofO@Antony2201.local>
 <ZiYq729Q1AF2Xq8M@hog>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZiYq729Q1AF2Xq8M@hog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 22/04/2024 à 11:16, Sabrina Dubroca a écrit :
[snip]
>>>> And also this looks like a general cleanup up to me. I wonder how Steffen 
>>>> would add such a check for the upcoming PCPU attribute! Should that be 
>>>> prohibited DELSA or XFRM_MSG_FLUSHSA or DELSA?
>>>
>>> IMO, new attributes should be rejected in any handler that doesn't use
>>> them. That's not a general cleanup because it's a new attribute, and
>>> the goal is to allow us to decide later if we want to use that
>>> attribute in DELSA etc. Maybe in one year, we want to make DELSA able
>>> to match on SA_DIR. If we don't reject SA_DIR from DELSA now, we won't
>>> be able to do that. That's why I'm insisting on this.
>>
>> I have implemented a method to reject in v11, even though it is not my 
>> preference:) My argument xfrm has no precedence of limiting unused 
>> attributes in most types. We are not enforcing on all attributes such as 
>> upcoming PCPU.
> 
> I'll ask Steffen to enforce it there as well :)
> I think it's a mistake that old netlink APIs were too friendly to invalid input.
+1

This is an old problem in Netlink. There has been work during the last years to
be more strict about new attributes.

For example, see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56738f4608417

