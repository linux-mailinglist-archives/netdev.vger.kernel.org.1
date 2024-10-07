Return-Path: <netdev+bounces-132824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A835B993591
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F71F2486D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0A1DDC17;
	Mon,  7 Oct 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPooHSne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E41DDA31;
	Mon,  7 Oct 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323992; cv=none; b=D/CoSXFs/lmnqk6VZdMZY/zfFkPItCyyfFOBDdZ3MvAxn0pBldldeup1upzmG0xo6xQXMrrqwhOKNRgyB0t9LWT34ZBEoMDKGBECUqW8tMw7DV+WTiZ1rc1yM/iqddvas2vhYLSz9j9vgOl/P561JrFinPEamU1MpmVisGoPg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323992; c=relaxed/simple;
	bh=EUlWizb9qTNXNSwceWCAoESPNWkMER7LCnbUJBIutpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntAvLS+MqdjEGtP2tGJXA/QcuSceRbXtRh9gBIxAkZFQuTLTIq9BSFpo1Z30mniyDy7Z+rKumzwCCVwkwhf9t3xO3U50YC4JFAj9pJwYwtAbH+jKDIqVWzhfqO2PgByqBGEA4F0rtFMLWIPPC0A7DW58dBfbdo/bvgBBAVmz6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPooHSne; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb806623eso43590745e9.2;
        Mon, 07 Oct 2024 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728323989; x=1728928789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9xZYbFeTtqUEIDmhYiuRtqlhbs+1HC2zRWNMJ8YMIU=;
        b=QPooHSnegSpzFGprOyKWwTorW3JqT3dbRhpXv/fE/YS56+debBZ8q3fY4Pq4/gf01r
         Mt/kMxtIhzz1JFDo7DtUQaNKyIOWwkjDt0lFt+4HsUqIciP+GEAquI8K2eRc6mSeQCNd
         Ad5KAG8IPraaS7hpNk6pcWvvZ886jUHzQQMLYtNkapQfWKCisKrjMrjt8II21q+GOSWA
         Y1NR+esUXjEQvGEIczDqZftOyEHLdjP85gKlUgSU2AqOt6oIV2Q1NhP0Kd7u6ezDdYbV
         Ewsw5T0jwp6tHnVPqnNlK5aI+0viNKrhX/2o8BxldNzAq1aaDWnpgZlv9DFuxQwMaUe/
         53IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323989; x=1728928789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9xZYbFeTtqUEIDmhYiuRtqlhbs+1HC2zRWNMJ8YMIU=;
        b=bepqv1JdcNHuDnsyFu15+qhQet+QbYZBULps085sz3pr5gFiHBxDWt0LmaVetghhj6
         QhS+2gP2BA58fsbfkJprcRNee2aTKOqSRyh2VppzLu9Cvl2iUluWOeqTStMfoW45DFbR
         DNvNG5fQeAK5CNCWkreDMxm6OBOUO8CEl/l0BD7DyUl4xJLHlhsDPtt01IYAqE6ka8NE
         njAtyT262SyYQIlZqewGJhhY5C4OUsHhoMbN0awQxh2GD3QjGru38VOAefvo7Wo7gaa4
         dkg1U6rSfAFUzLuZzcdWBsZRG3WW6Ti6KnQfiySkJ+G6qugCBe+GY1B7b5EeCNaa8yzv
         9bTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNpxFNfA6eAoSi/BS8aPPV00F2z6/16Vwjp+cacfFDaqCoasumx+ZpCT3WDQJ4S6CWnqHj64CimWXcobvE@vger.kernel.org, AJvYcCWUmTqN0DrsFrmE1RW/K0L5tshuIEwqRIWVdR101gq++IDBT2GO3IdyT6/KfP2yqQXzPCtXLsLHayU=@vger.kernel.org, AJvYcCWw17jz/plfz6RSinxsapRjQuv45UcnpLtZBnN3f2tA8QJVMjG3Z6/ogOmpFtZ06RiXJ44qiUEi@vger.kernel.org
X-Gm-Message-State: AOJu0YzpadvtN7DwREDEEkIhVTTsRqMZPXfOKKSBtl84OdcN5b2B1+uS
	wm9TnyhUtRNcXGabRwKb9a9I1LIDtX9TNfr17eE2fLCSDgOXInOiCSw+SQ==
X-Google-Smtp-Source: AGHT+IEPwigtp63g7ZbwNcZF+22zDt1BYB461Ot6r+xxGAgYpt+8duzU4J2lrxHzsolPnuNsngsndQ==
X-Received: by 2002:a05:600c:4ec7:b0:42c:b9dd:93ee with SMTP id 5b1f17b1804b1-42f85af8d63mr110960195e9.34.1728323988617;
        Mon, 07 Oct 2024 10:59:48 -0700 (PDT)
Received: from [192.168.42.137] ([85.255.234.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8a05173dsm81449905e9.5.2024.10.07.10.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:59:48 -0700 (PDT)
Message-ID: <058e38c4-ead9-42bf-8a11-a97d0ead35fb@gmail.com>
Date: Mon, 7 Oct 2024 19:00:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
To: Breno Leitao <leitao@debian.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 Jonathan Corbet <corbet@lwn.net>, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
 Willem de Bruijn <willemb@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20241002113316.2527669-1-leitao@debian.org>
 <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>
 <20241007-flat-steel-cuscus-9bffda@leitao>
 <9386a9fc-a8b5-41fc-9f92-f621e56a918d@gmail.com>
 <20241007-phenomenal-literate-hog-619ad0@leitao>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241007-phenomenal-literate-hog-619ad0@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/24 18:09, Breno Leitao wrote:
> Hello Pavel,
> 
> On Mon, Oct 07, 2024 at 05:48:39PM +0100, Pavel Begunkov wrote:
>> On 10/7/24 17:20, Breno Leitao wrote:
>>> On Sat, Oct 05, 2024 at 01:38:59PM +0900, Akinobu Mita wrote:
>>>> 2024年10月2日(水) 20:37 Breno Leitao <leitao@debian.org>:
>>>>>
>>>>> Introduce a fault injection mechanism to force skb reallocation. The
>>>>> primary goal is to catch bugs related to pointer invalidation after
>>>>> potential skb reallocation.
>>>>>
>>>>> The fault injection mechanism aims to identify scenarios where callers
>>>>> retain pointers to various headers in the skb but fail to reload these
>>>>> pointers after calling a function that may reallocate the data. This
>>>>> type of bug can lead to memory corruption or crashes if the old,
>>>>> now-invalid pointers are used.
>>>>>
>>>>> By forcing reallocation through fault injection, we can stress-test code
>>>>> paths and ensure proper pointer management after potential skb
>>>>> reallocations.
>>>>>
>>>>> Add a hook for fault injection in the following functions:
>>>>>
>>>>>    * pskb_trim_rcsum()
>>>>>    * pskb_may_pull_reason()
>>>>>    * pskb_trim()
>>>>>
>>>>> As the other fault injection mechanism, protect it under a debug Kconfig
>>>>> called CONFIG_FAIL_SKB_FORCE_REALLOC.
>>>>>
>>>>> This patch was *heavily* inspired by Jakub's proposal from:
>>>>> https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
>>>>>
>>>>> CC: Akinobu Mita <akinobu.mita@gmail.com>
>>>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>>
>>>> This new addition seems sensible.  It might be more useful to have a filter
>>>> that allows you to specify things like protocol family.
>>>
>>> I think it might make more sense to be network interface specific. For
>>> instance, only fault inject in interface `ethx`.
>>
>> Wasn't there some error injection infra that allows to optionally
>> run bpf? That would cover the filtering problem. ALLOW_ERROR_INJECTION,
>> maybe?
> 
> Isn't ALLOW_ERROR_INJECTION focused on specifying which function could
> be faulted? I.e, you can mark that function as prone for fail injection?
> 
> In my the case I have in mind, I want to pass the interface that it
> would have the error injected. For instance, only inject errors in
> interface eth1. In this case, I am not sure ALLOW_ERROR_INJECTION will
> help.

I've never looked into it and might be wrong, but I view
ALLOW_ERROR_INJECTION'ed functions as a yes/no (err code) switch on
steroids enabling debug code but not doing actual failing. E.g.

if (should_fail_bio(bio)) {
	bio->bi_status = status;
	bio_endio(bio);
	return;
}

Looking at your patch, in this case it'd be not failing a request but
pskb_expand_head(). Not exactly a perfect match as there are no "errors"
here, but if not usable directly maybe it's trivial to adapt.

That's assuming it supports bpf and lets it to specify the result of
the function, from where bpf can dig into the skb argument and do
custom filtering.

-- 
Pavel Begunkov

