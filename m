Return-Path: <netdev+bounces-144958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795079C8E6E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF7B1F2811D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266D18C01A;
	Thu, 14 Nov 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDEwDeLz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6718C000
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598317; cv=none; b=T/8g+rOxZ+AWgQ3/qISy3XGU2L7g1XrdPRN5/22hFrObYlQsbvEaP64HEPM1VN45f30db7XQZHK9KfqA2k91e8wQoV/OG2lp2eYW7qnwPkGEAdq5bo2pJjNZwMX8CvakpyT6Ns+m5d5GikUxAjgeWijPagTZBW6L4xlg8fpZri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598317; c=relaxed/simple;
	bh=elZcEIWbM+FonZh52q8SQKFDhUN9+ww+JFkalMcfTrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHpWBwk9sq64NbDbbZym7CJNf/DQmAzMDEA2cCsqWnaBg30Klbz/pGwYhzQH78kGD8yUWOECV/h+5uSUIg6yrs0uzoiDi/zxs8DWOQtKxUbiu0SrBHhCO/G6EacR5FjAu1zvq/+HHr+11GA+5Mr2IedFM4VeMoYjqbmuT7+/oLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDEwDeLz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731598315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwFSSM9eqv7k2dtBpy8OyIsJJYNLsTYiFi7OpUJPB7I=;
	b=fDEwDeLz5LNWOWwCM3IpW+Fk/fIcybTuMpwJOpWP0KOooSD1SrvRa54VgR5V5YqLkGo2W6
	C+w16sxY42jazOtYjexabmL8tcetrJstw/0qSHupP2VCI2e7zf/wsXFdYevJQ0nUgGu8Uy
	3BtC4nnf+8NXb44k8WRFhpCKuxL00Yk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-FBUjYE6zPUKeuUxKXP8plg-1; Thu, 14 Nov 2024 10:31:53 -0500
X-MC-Unique: FBUjYE6zPUKeuUxKXP8plg-1
X-Mimecast-MFC-AGG-ID: FBUjYE6zPUKeuUxKXP8plg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so5790585e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598311; x=1732203111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwFSSM9eqv7k2dtBpy8OyIsJJYNLsTYiFi7OpUJPB7I=;
        b=SNSR6+zXJT3mRm2vD1FdKEs8BxZwuSkjeUmHN12FMNBw0SwaVy2WmfKBlfgl76HdEA
         tiMuRNPjaLk7Vr6ABv4kQGLrYeD/07hj0Vp/JCfGq4NGl2+Tgl54y6S+ssfltL5YAIbj
         yi/9/FhDqIP/6daToMOWcSfQWwMf2zisJU8SNBl4xtI0fvysWYOrv8E320FEE0KM/sBZ
         32kYdazXch+dhVkdGTqk7p/1mFqJh3CaOBfHc+S44Pi8nn5CmQh3APpSWm+WGfbkOdGF
         EXgm2b0KhCrtPbd1V+OhzFRHIiMytSf8t8rohLgC5I7A19jRAGMAQU4bXzzoYBGghBpC
         VNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYfiuR9NBo+UY0rdzKELG3VIr2py7sU4LInJfhCDHjv1vwRKfS07yHF+IBDMh9AMX4hfCvcYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fiA03EE4fpHmuutE8gC91KAwP24N/P0vZcesooax1o1XcBJ3
	Cu9d3ivqxxw/9XgycGDF5QcOx0Gk5ZRI+EJOw0u9oU6yX3PLMQcVofRSQQBt9T+bCgG5RHuad//
	TFDb+khkmWf+Loye40IklbFsG4SahxOpAnkF7EGhtX9y2VLokAO12sW6eCqkv+clz
X-Received: by 2002:a05:600c:3488:b0:431:588a:44a2 with SMTP id 5b1f17b1804b1-432d4ab0f0dmr71550785e9.12.1731598311509;
        Thu, 14 Nov 2024 07:31:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdQvDjx0b5T4Gq7b/DQtBFSa0qbpCQiXe7UAHRq2YzzHyZIIFDqpdKg9WLDdCIRfCdsq6UOQ==
X-Received: by 2002:a05:600c:3488:b0:431:588a:44a2 with SMTP id 5b1f17b1804b1-432d4ab0f0dmr71550565e9.12.1731598311178;
        Thu, 14 Nov 2024 07:31:51 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48baa42sm48761555e9.1.2024.11.14.07.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:31:50 -0800 (PST)
Message-ID: <bc284081-8df8-42a5-8f19-8cb1e06d3330@redhat.com>
Date: Thu, 14 Nov 2024 16:31:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] Netfilter fixes for net
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com, fw@strlen.de
References: <20241114125723.82229-1-pablo@netfilter.org>
 <119bdb03-3caf-4a1a-b5f1-c43b0046bf37@redhat.com>
 <ZzYQpRTItgINeyg4@calendula>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZzYQpRTItgINeyg4@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 16:00, Pablo Neira Ayuso wrote:
> On Thu, Nov 14, 2024 at 03:54:56PM +0100, Paolo Abeni wrote:
>> On 11/14/24 13:57, Pablo Neira Ayuso wrote:
>>> The following patchset contains Netfilter fixes for net:
>>>
>>> 1) Update .gitignore in selftest to skip conntrack_reverse_clash,
>>>    from Li Zhijian.
>>>
>>> 2) Fix conntrack_dump_flush return values, from Guan Jing.
>>>
>>> 3) syzbot found that ipset's bitmap type does not properly checks for
>>>    bitmap's first ip, from Jeongjun Park.
>>>
>>> Please, pull these changes from:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-11-14
>>
>> Almost over the air collision, I just sent the net PR for -rc8. Do any
>> of the above fixes have a strong need to land into 6.12?
> 
> selftests fixes are trivial.
> 
> ipset fix would be good to have.
> 
> But if this is pushing things too much too the limit on your side,
> then skip.

I would need to take back the already shared net PR. I prefer to avoid
such a thing to avoid confusion with the process, especially for non
critical stuff.

It looks like the ipset fix addresses a quite ancient issue, I
guess/hope it's not extremely critical.

/P


