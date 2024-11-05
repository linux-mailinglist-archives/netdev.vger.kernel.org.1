Return-Path: <netdev+bounces-141909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6509BCA1E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1921C21F94
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB91CF2B6;
	Tue,  5 Nov 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INEYPjOj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFD1CC881
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801768; cv=none; b=S1rbhRMzLWJBdjZ0LhWVn5TcdUYkJhz49B48o2WFv7v75JR8ZdUIGJc2M0O3Rh7H4bsB5bIpy+1e4ckLz8M/pqricpu9vh7eE9eN2ZHODbqPtB4qWkXjfwPjaZA+v3I70Rz4MKC+1r6hijb12DFLr8R3gfS6040FfwJKJd6C3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801768; c=relaxed/simple;
	bh=Xuk/u4Y1wo1an0+3YH7TXxlFiN/I+/FRYsm7CWEZN8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0+tEi3dRUuU1JmMDQuEkOJeDWeH0ID30ogWoNEo3Z4lZrPr9jHrMUzgMdLhsnpJhxM3snZcxDzy01CjWiOZT680xKXw9YsotK0/S2C54i/Qb7kxrsfCf5AzzhwQYLIBoVJPrvBZ8Cts5qSCE8QcuaRIcgpUM66ie//AUsAcQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INEYPjOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730801765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9fd1dKaPQIPH/cxq3ULDyAPt2vS2bxUAZ7dSlR5X7w=;
	b=INEYPjOj0a4/NjTUMFJwcgryyKuMXQ8oGTvClAJb1mMQRyIiee46pT9WoU+qFT8sN8ZTbY
	g9A4kStK54LbdErnEDFmzGpfClGCDifTpzDLYTnoeuqcdBhPm48e/FBKolV3wcN0/2gfWg
	Trpl81mnbXSjLHQIKfEgJYJyzHxv+yM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-H-aHJPYmN526lJwN7SB4Ng-1; Tue, 05 Nov 2024 05:16:03 -0500
X-MC-Unique: H-aHJPYmN526lJwN7SB4Ng-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso44718375e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801763; x=1731406563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9fd1dKaPQIPH/cxq3ULDyAPt2vS2bxUAZ7dSlR5X7w=;
        b=RFXYSyf9xuhM3c1SbVFpZGKKXtdRIJ1vj/d950FJp811PBzcOXKG25FvVpzonWeIGb
         upiHvRbnjmGe8RDKuC2pnxxQnO9U/pzIed4Po8d2b1HHP5VWyOValddyA1AeADzkW48R
         fnIYzleSAgN2TsZ48V0r5c6dm2aNDUIjFAu7zWu30b3EjsPYYLlOBtOEUwBRcxptzgee
         RF0C9WHgo/YFNuenXjGrt/km9Q0nSBksClrYoRTlo/auuD2Cy9QmCtZ7N0LX2W4gpozQ
         jKmBHVSH9FuQeKnklkrYXcILJGCnCwiBC7sCT2SUZC/7hSfZQcWIGNPQ4azAK1EHs9hW
         WeQg==
X-Forwarded-Encrypted: i=1; AJvYcCUSSp2kVlJKmPI4p8vK/K1UCJlkJP6slLAeurc4seLd4FbFCAECDMU7cZKrk3l++KN4lpqYe8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyPTbgIxnv2Brh6edfx2zErJ6voGgTmDmy15q08oiLx57U7AY
	7oLMNfSMr7DPBWFYPBeIlSnTAqEVGLMcupGzH65UOObmZeqdXiequ5NrLy0ufHMqkccq4U8DuIw
	55FvSP9t6TAQTWril6WPT/RBDgsLhIdmhgAWoCw929jtimDa6gJSd2A==
X-Received: by 2002:a05:600c:1c9c:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-43283255a50mr154680355e9.15.1730801762691;
        Tue, 05 Nov 2024 02:16:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPyIE/6Ubt8aNt9o/1m96XMFpdOrVsGTqLHa7tCuoz6UJRjjkZD5OYGfTN5QYgXvNx0klblw==
X-Received: by 2002:a05:600c:1c9c:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-43283255a50mr154679985e9.15.1730801762293;
        Tue, 05 Nov 2024 02:16:02 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432a267dfadsm17097735e9.0.2024.11.05.02.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:16:01 -0800 (PST)
Message-ID: <7569a727-ad3e-4dfa-8c9e-e135c61e1493@redhat.com>
Date: Tue, 5 Nov 2024 11:16:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
To: Halil Pasic <pasic@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Nils Hoppmann
 <niho@linux.ibm.com>, Niklas Schnell <schnelle@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>
References: <20241025074619.59864-1-wenjia@linux.ibm.com>
 <20241025235839.GD36583@linux.alibaba.com>
 <20241031133017.682be72b.pasic@linux.ibm.com>
 <20241104174215.130784ee.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241104174215.130784ee.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 17:42, Halil Pasic wrote:
> On Thu, 31 Oct 2024 13:30:17 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Sat, 26 Oct 2024 07:58:39 +0800
>> Dust Li <dust.li@linux.alibaba.com> wrote:
>>
>>>> For some reason include/linux/wait.h does not offer a top level wrapper
>>>> macro for wait_event with interruptible, exclusive and timeout. I did
>>>> not spend too many cycles on thinking if that is even a combination that
>>>> makes sense (on the quick I don't see why not) and conversely I
>>>> refrained from making an attempt to accomplish the interruptible,
>>>> exclusive and timeout combo by using the abstraction-wise lower
>>>> level __wait_event interface.
>>>>
>>>> To alleviate the tx performance bottleneck and the CPU overhead due to
>>>> the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.    
>>>
>>> Hi,
>>>
>>> Have you tested other values, such as 64? In our internal version, we
>>> have used 64 for some time.  
>>
>> Yes we have, but I'm not sure the data is still to be found. Let me do
>> some digging.
>>
> 
> We did some digging and according to that data 64 is not likely to cut
> it on the TX end for highly parallel request-response workload. But we
> will measure some more these days just to be on the safe side.
> 
>>>
>>> Increasing this to 256 will require a 36K continuous physical memory
>>> allocation in smc_wr_alloc_link_mem(). Based on my experience, this may
>>> fail on servers that have been running for a long time and have
>>> fragmented memory.  
>>
>> Good point! It is possible that I did not give sufficient thought to
>> this aspect.
>>
> 
> The failing allocation would lead to a fallback to TCP I believe. Which
> I don't consider a catastrophic failure.
> 
> But let us put this patch on hold and see if we can come up with
> something better.

FTR, I marked this patch as 'changes requested' given the possible risk
of regressions (more frequent fallback to TCP).

We can revive it should an agreement be reached.

Thanks,

Paolo



