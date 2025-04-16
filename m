Return-Path: <netdev+bounces-183201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C4A8B597
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72053A97FE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B81233739;
	Wed, 16 Apr 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6koWO58"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83237226534
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796282; cv=none; b=mExny7azpitINjokuBObvOJISg2xtcOh7XGVjmn0t2ILrPyJEFp9UuBcJ75AlDgwv8dyheveaFO+q2FjsfOAQ1cQkfpue8B6qDhQTpdXVpIszKsj5u2H9hzDjynmnDT7kimEEl1m5vrhBIUTU3uWQjgAQftzHzNZRdtETHFsT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796282; c=relaxed/simple;
	bh=n/auY9tBH1HbU29j7F4IpdeorrbZ+Ic+bjDd/jijtw8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W3dq1ATP+KlEOn+rNPh0sx+ch/HoXD2W3I4STY4/L6Rgykktaf2F4h2yZU41D3ma0InWb5LK1mzg156Cyl/1SIAhQnjecA0M0oHXDTfehlLj7guTvtrerOi9tCIO2/614WPDt22clmRSaOnfG7EatbEuGIvwOx35w6zPFOUl3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6koWO58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744796279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wKUJHj93YV4mcifvbSh1COxgoyxp/xL4Ub3Cg2Og0w=;
	b=X6koWO5898LYkqAX/7IhQD9o7zLoCM0zPiIWJlxF03Im43wu1d1C57Xp65nxB4VTwkpnF1
	yC8lU+pr0g2OBQuPDq6tiubGQY3+Ayk48CKOj5Hy7twumZNxyKOt8s4Y2coijNuBF9MzP2
	GfbQXTHltsyanU5LH44NT2OfyxUVOKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-p1fgIr7oM0ylO40PeNze0A-1; Wed, 16 Apr 2025 05:37:58 -0400
X-MC-Unique: p1fgIr7oM0ylO40PeNze0A-1
X-Mimecast-MFC-AGG-ID: p1fgIr7oM0ylO40PeNze0A_1744796277
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so38914365e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796277; x=1745401077;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wKUJHj93YV4mcifvbSh1COxgoyxp/xL4Ub3Cg2Og0w=;
        b=cVgAykrGk2PlhwifPoIPqYuEKVCWjHc5BzcFGy7KheM0pNtANkl/A0HQgY80qA995x
         gdnHOKN8r82wrbXAjMQ4pc2xABUUEvpDu/gDSusemD18pSj0CH/+8ItLioLRU3D1vJa9
         PDeMDGCRsBq9J78rjJutwzuKU0LgAgqyrlv5ivrZIqLi6SdRr9s0tWB6GIK5Q4y1XlGh
         ePJwmBEGvEfEk+m4h8b+FjgzszDMeIdHpFCCSzt0Td5+SRhglZtKt1ztFEDifuXCYJ/U
         G9LHuFzZgZkq0c14NOfgldRuPfX7W2N+eI4T0vThdNwDTzukJzvkDzH1raME8qY8lMJ0
         0fpg==
X-Forwarded-Encrypted: i=1; AJvYcCVZN2NVI8GI8CwiafrsZ62OVOODxe0jPwYykB2OukF/N6Ka/wSDzaFVkvjL6SldNzbsYXJvg8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPV202ymDmHEPoK/sHiZeVZIffZdgBvMM9AjIOQz6DlABxx8R0
	H84JzJP86C7BAjfCIpYPTCxYC2hYZlOt4Au3Wf8geJ4yvWRM03qvN4fkEgDIa1y7Wnypo7nJ0xp
	Wbu1DbAB8UB054UqxHVHnps/VRjtH+A1xGJMlV+manE0O7SojVXzFKg==
X-Gm-Gg: ASbGnctZwX+bV/Ebj1zLybdJhC0lKo+jGQWUMrxLEK4/BjB0kF1KwMStPPPX+x3dA7a
	D4xLBy9GqQdG6Hvf1uVatZPeTlY9NZSoI2i0/Wuyjp/g8UUu3HT3fj93Wf4rhwrejx+xiFn/F5G
	pc6k2CBzMYpXGD1TeRVVHiu/WmSOam5FAePuVtjwyJiSF/l04R6xxb4XRn9AFN45tBKhnWphJkj
	Or2Fo5gYzaywN58DYCs3CHfujvYtu6m/OBWTBhyyQLlgN7tPnQX1osmlFsDlb7+oRbcFGSk6GUx
	5S/UQHBy79ElO61VtEl4+uuNUMSI+ul2xpZlvO8=
X-Received: by 2002:a05:600c:1da5:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-4405d624d60mr13379965e9.10.1744796276804;
        Wed, 16 Apr 2025 02:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1qFbeGxXx75pLES0IQ4Mobf3OPSxa1Crhfw1mqBMv+TOll2ZrcwzZt/9FhexLAR7EatqM0w==
X-Received: by 2002:a05:600c:1da5:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-4405d624d60mr13379655e9.10.1744796276389;
        Wed, 16 Apr 2025 02:37:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44577dsm16701726f8f.94.2025.04.16.02.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:37:55 -0700 (PDT)
Message-ID: <35c5934d-be33-45c1-b914-15f9a30e75a2@redhat.com>
Date: Wed, 16 Apr 2025 11:37:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 07/14] ipv6: Preallocate
 rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-8-kuniyu@amazon.com>
 <def2c29d-3226-4a64-a7d5-6e03c8d26804@redhat.com>
Content-Language: en-US
In-Reply-To: <def2c29d-3226-4a64-a7d5-6e03c8d26804@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/25 11:21 AM, Paolo Abeni wrote:
> On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index ce060b59d41a..404da01a7502 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -3664,10 +3664,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>>  		goto out;
>>  
>>  pcpu_alloc:
>> -	fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
>>  	if (!fib6_nh->rt6i_pcpu) {
>> -		err = -ENOMEM;
>> -		goto out;
>> +		fib6_nh->rt6i_pcpu = alloc_percpu_gfp(struct rt6_info *, gfp_flags);
> 
> 'rt6i_pcpu' has just been pre-allocated, why we need to try again the
> allocation here? 

Ah, I missed the shared code with ipv4. The next patch clarifies thing
to me. I guess it would be better to either squash the patches or add a
comment here (or in the commit message).

Thanks,

Paolo


