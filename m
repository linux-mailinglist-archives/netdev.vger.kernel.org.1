Return-Path: <netdev+bounces-186763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D2BAA0F91
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644783AFA28
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00870215F6C;
	Tue, 29 Apr 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiK4NZ2O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C836213E67
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938155; cv=none; b=FrcbeOdkeUM2VDYY1nZGFFNo5eMpMNkmPrG+FtkQjh3ynMWHxLBnEXXmCjHaYeaUGS6p++nkwhEQmtYI5ly8L7VU0H4KHHar9vW8UnkvJU+nXf2EI41g08pBo7DgbED/03ctcJ4Pi9Xz6rNGUU4C/dKtBK57NvMpo3tT4WKzSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938155; c=relaxed/simple;
	bh=GLzAW9i8G2S790fvJT54iIGjcBXQWF5+pxqBgUrcd5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHuAhsCogT7X9mDuWk8p2EEh936wf1Wb95DeGpV6zqwTKrclIGZ9uKwJ4kh2rPJt+pPmDbWSsW+KskrsOHFG2fFEmBEp2lVkVUuktMdmIbA7f86EBk8CZlsoy6QjQmXyTnfrt4aL9d/N3REGKQt0iHBOPhzQ8gYGgExnIhkn6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiK4NZ2O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745938153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRLeE5mXTuY3mhtQAJn1s429K2TNKhmag459CJyPsyA=;
	b=UiK4NZ2ON7bMG5MjXReadolO1MzrsNJx4qP779bJGuY7n5VVeO33t8S1zh5Gss3r9ml1hY
	55kXfT/U5RH/ffUY6dkhTDhRhD90goqrAoPMG6KIivvg4pGG6MYHE5pWENabrQ+QDgQ2/Y
	+kwIeGdS2HCVvCqwetxhLcgJpKwqJuY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-zJVOpuxzN8KtbLi05BAl-A-1; Tue, 29 Apr 2025 10:49:10 -0400
X-MC-Unique: zJVOpuxzN8KtbLi05BAl-A-1
X-Mimecast-MFC-AGG-ID: zJVOpuxzN8KtbLi05BAl-A_1745938149
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-440a4e2bad7so17204715e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938149; x=1746542949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRLeE5mXTuY3mhtQAJn1s429K2TNKhmag459CJyPsyA=;
        b=ucmCTwZfnWkIZlI/1cU3YLbPvzkng+r48yO6GOf1SrLeqPMZw82KsQBXQsnQaIXLyt
         it2Pq+0kitEaNiOTFO9TjuDR8QqdBI1j+b5YcZ99uBcwF7RWJQUMtbUGlBWeiPXzF1jw
         qzYjW25svWXHgDpzK1TgY6A9tFLdu3RPTpzWycy+OjcwSGMjrwideWtZeFa5Eyj3LdSG
         KPrLnPFG+tCXMdgm2cmMNXgZpppXkH6vAp7MSxzf0ZyIcZNx+JRAvXT2AC3TrV0PvhR+
         tBcaetYr3bNaREX7HTFsE5ruGFQXqyBz4XlYU9Ri59+D/jniPrG+4WwqRncziElpZhL8
         MtCw==
X-Forwarded-Encrypted: i=1; AJvYcCU4nFc6WtGCiCrd1EWYLNuND2yxKjl0L0RtXMa8l0aq0egjzPQ5kCw5Ms9AfXViqrGvwJ1etu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMXPxNsLdYafSw5uxzxhUEL8XhgRwJ58OJrMwKjeCMUl5bSxe
	nrWN5PZeo8h4jawqsPRvuLEf15JoZ3+dK73BjuRfoZSY9WECj1vW45aGKx5knnPDiFXILs26NJR
	3CBCZNRZwYOBvCnIsa0C2I8Y8ygeVJ9ron8XO/L4+efGJzTmHHJD+5A==
X-Gm-Gg: ASbGncuRDbH4lImosxRYBKuXna3msIANz29XoAVoRSGOfyS9meH3G6Tz0c9S9y9tymg
	wT3VYMXM8BrXEiGkbLo+uQq27SIdKj17LPVlSlVFF4hxaYVfsBtpuuC5sUGXwdeTyA8dC95DQ7t
	tiTM1F48VpyJtwPdVXQsv+1sRXRA2yqRAxop5iggCVk7GPpLRD9x5ZzKtQEhsjrrS6uZ1vYWTQd
	E1S9k9joe0Z5Nltap48F4sQuCskAtWhm2Ykihs7KOB1lViVGMDUEpKRzNhmWbNowV1Cytz4QYEb
	x5XpNxoAqaqOfsrZ9Oc=
X-Received: by 2002:a7b:cb88:0:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-441acaa8d6amr27372775e9.1.1745938149541;
        Tue, 29 Apr 2025 07:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAU/uIt3jIn6qteBdEJpE7YYQmT2sXmtYbeftFAijdpp1guCLQBM3tVBZM1Yl/ZYHze6lAag==
X-Received: by 2002:a7b:cb88:0:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-441acaa8d6amr27372525e9.1.1745938149201;
        Tue, 29 Apr 2025 07:49:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5303c68sm158323505e9.12.2025.04.29.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:49:08 -0700 (PDT)
Message-ID: <6f9d20d9-8037-438f-8281-7eac82289696@redhat.com>
Date: Tue, 29 Apr 2025 16:49:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: exit cleanly on SIGTERM /
 timeout
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 willemb@google.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20250425151757.1652517-1-kuba@kernel.org>
 <680cf896280c4_193a06294a6@willemb.c.googlers.com.notmuch>
 <20250428132425.318f2a51@kernel.org>
 <68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <68102b0477fcc_2609d429482@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 3:27 AM, Willem de Bruijn wrote:
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Jakub Kicinski wrote:
>> On Sat, 26 Apr 2025 11:15:34 -0400 Willem de Bruijn wrote:
>>>> @@ -193,6 +198,19 @@ KSFT_DISRUPTIVE = True
>>>>      return env
>>>>  
>>>>  
>>>> +term_cnt = 0
>>>> +  
>>>
>>> A bit ugly to initialize this here. Also, it already is initialized
>>> below.
>>
>> We need a global so that the signal handler can access it.
>> Python doesn't have syntax to define a variable without a value.
>> Or do you suggest term_cnt = None ?
> 
> I meant that the "global term_cnt" in ksft_run below already creates
> the global var, and is guaranteed to do so before _ksft_intr, so no
> need to also define it outside a function.
> 
> Obviously not very important, don't mean to ask for a respin. LGTM.

FWIW I think it's better to avoid the unneeded assignment in global
scope, so I would suggest either follow-up or a v2, whatever is simpler.

Thanks,

Paolo


