Return-Path: <netdev+bounces-77192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4487083D
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22791F21A5F
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21900612C5;
	Mon,  4 Mar 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4o/t8Gh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A91756D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573282; cv=none; b=HNM28wyXiBslJB7ceD7f17QIxZ4+AbpjFTul4REiZZjOZbbPQs8QneANW/5lQk+y844xuvINjkM+BacLjve8gIXfvuriYNEwerM/AwD3/QO/T2A6BkHnBf3wiVveD/QIc0xMKOJZoksrriVz8EF09H1RQuj89f48bn0gYdHkXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573282; c=relaxed/simple;
	bh=iSicQohsdDWhHnJPrXAs46hsWMD5ViwBr5mAOJcxOT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SObLhs9Cj315MoOVAot034Jfoq3bdbm8tORnmP24O+SooZEI9cXVktbIm5tcmcCTn0GBKsJXDW0/8maphessg1m1KpTMREOE8vioYnJu5UWFvVQ385H3M+xN5pfBEgYjDeJIy4by2x0sjAldE9gO91/VGB2kjfDa8Y/hAXlEdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4o/t8Gh; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60925d20af0so47551617b3.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709573279; x=1710178079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu5qeyiZ6/gWVRFQPGCgyLbvL47YdCn4qFbGfJUg1Ig=;
        b=h4o/t8GhVdT+GGCi5tDkEUH4iYP4IfUFgspqkwem8ATnX9o8yCL2gSUpx9+aPOxYDH
         l6pYxjG3RihfVbbHeMLIxIJJCQwk9DWuGxjG8yqHaIm4UHK2Y9zklQ3ii4DVsid2xFl1
         nV1VJCEtcFr4p+jK0aAG6TKGYAeDWgfZMfsYq+qvzypW2ZpC2woLCeoElPhcpBuEjmf7
         psTgfBDaBCkMXlWlceWzBbWkkU4mXAvdl5aiLIdqJZWWMW26xZyHin6JlpKov7ZTf7+Z
         HWe5OzO1ZSmgHzwDn/BlKlqOGFzJWfI8FvMebojWp5ucxhEftCMbPqxq65ZkkAN5pSUO
         mVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573279; x=1710178079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu5qeyiZ6/gWVRFQPGCgyLbvL47YdCn4qFbGfJUg1Ig=;
        b=DCHL6rUXpvYYie/pkTqoXLRS0rAMIeG2Ztl2v2Kg4FbDfu6PMDBbnSbClBzAvMlco0
         SfWNYe+6vTEJ6bn9hIar+4f4TBsX2g9cMU4Y5rrQTE9xcoXj2f297NpoqN6gmpC02ISw
         /QJJdrddfJB4Nq4HJMZSJ+HcS0xQnh1Z30QkkDf72tusWoOy3mUMjn2IxB7z4kpbhjXD
         DO4wEw/zgMWcM+mVtb7SQlmwGdkBB1GvvPee//KFeefhWDNTq5YAlB4d8092JxoyKkGy
         RcO4GNXSG2jXn4JZy3LygKgxozvCu8/r9M08COAghNHflgOqYoM8pE5tWWgnEYTWeJit
         ss2A==
X-Forwarded-Encrypted: i=1; AJvYcCXB9wR6+02MERHbeeELP+oC4ZI0sAU3vnz1yd6NedEuRARusgSPZBEdGxTllCyY3aq9NdfSSkDJFRjaE9IvxSzaov4FrHQG
X-Gm-Message-State: AOJu0YxDzh+CfgQuOzRRvVSyPKLbYxTILRMwhotkpjsSd7HUpf8UUZqr
	8UIafUpRqxSlAvm0MaRMh2mF7E1+bfKKFAmBvfz27u2Aw5yPnALg
X-Google-Smtp-Source: AGHT+IFf4HbRIUv58VQVWtDO0nZywLUFL0AhXGMWHBQba4/4uM6bVLJz5ZJRWxlKb17e2xeZN8phBA==
X-Received: by 2002:a81:6f06:0:b0:608:5af9:b486 with SMTP id k6-20020a816f06000000b006085af9b486mr8708184ywc.11.1709573279532;
        Mon, 04 Mar 2024 09:27:59 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ad4b:71f8:5ca6:be31? ([2600:1700:6cf8:1240:ad4b:71f8:5ca6:be31])
        by smtp.gmail.com with ESMTPSA id z4-20020a81ac44000000b00607a957c82dsm2735832ywj.3.2024.03.04.09.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:27:58 -0800 (PST)
Message-ID: <4d6a8397-5f8c-45f8-a996-80768cc1c401@gmail.com>
Date: Mon, 4 Mar 2024 09:27:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
 <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
 <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
 <d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
 <20240304074421.41726c4d@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240304074421.41726c4d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 07:44, Jakub Kicinski wrote:
> On Fri, 1 Mar 2024 16:45:58 -0800 Kui-Feng Lee wrote:
>> However, some extra waiting may be added to it.
>> There are two possible extra waiting. The first one is calling
>> round_jiffies() in fib6_run_gc(), that may add 750ms at most. The second
>> one is the granularity of waiting for 5 seconds (in our case) is 512ms
>> for HZ 1000 according to the comment at the very begin of timer.c.
>> In fact, it can add 392ms for 5750ms (5000ms + 750ms). Overall, they may
>> contribute up to 1144ms.
>>
>> Does that make sense?
>>
>> Debug build is slower. So, the test scripts will be slower than normal
>> build. That means the script is actually waiting longer with a debug build.
> 
> Meaning bumping the wait to $((($EXPIRE + 1) * 2))
> should be enough for the non-debug runner?

Yes, it should be enough. I will send out another patch base on this.

