Return-Path: <netdev+bounces-178304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10115A767A3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483AD168E1C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB23213E7A;
	Mon, 31 Mar 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Npxf20l8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7591E1E06
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430781; cv=none; b=U0ltfu4CauHvv9Bz5IAPmjuv+cgUqNgFuIZ+xS/qGKb9aGWww2Z960D50N4c3gMCjGUCTkLCUVOcl0u3K98brXZOsKkd0EA7A2Q3V6CW9irMyP2W9d+j8awwYWip3//48s2ZMsohvLSvC8icBFEGCfdbT6IZdi/H1HJgTa4A3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430781; c=relaxed/simple;
	bh=+t488dEmHQJAO3jFfrt8V7/UCzMav5WFnaBdBdPDxaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihSrMejVbLCBSJ84sXYkt+LO9V6RpxG3h57HZy1Gh2sE6C7YLGlHm49Rkyu3A7k5wGHNtsktiE2FTf1j/kZhcooc+1VYAUYChnOLSPwJfE+KroT0+3v4JtOeA8ktAC+5Um7bdhUhzM2iDSyADbBZ1+OMz4gx8+Ad8qgyMYr8la0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Npxf20l8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743430778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYj0pUIwEANUtr1SIrZWSom30G8/htq+S+uugiq5mDU=;
	b=Npxf20l8YbWyQpsxekouNvP9q3BCjwQZ+xji+LjfePNNaqx2oe88dLDEoTUX2q3wvxLKku
	FsUocKa7yWBzzoBQJ4q8J7KelYW0u5WzuT9csFXmSROBVhsAq+6kYsbu9LXTyP0JmK3u0R
	5cZIM/AbFc3ZTVH9jhk80xpWxyPDg4s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-2BND096PMoiNBL2EsF6ghA-1; Mon, 31 Mar 2025 10:19:36 -0400
X-MC-Unique: 2BND096PMoiNBL2EsF6ghA-1
X-Mimecast-MFC-AGG-ID: 2BND096PMoiNBL2EsF6ghA_1743430776
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84cdae60616so495149139f.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 07:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743430776; x=1744035576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYj0pUIwEANUtr1SIrZWSom30G8/htq+S+uugiq5mDU=;
        b=Bex7pfV9vy8h0zC3vawF4P/Eowf8k9P8C63AVDJkEs2LpB5H/tULoLPQGToMVkTFWL
         fgvnLqCqyY56vct7vc3UxeB+uu3zbBx0YLN5v1YEq5tJ5KIY5vMQ/AY9wcu5qFq2cabB
         PfTKo2z99v1iojwsqcZkp+dnVWHgc8pd+heqvz0S88wDvoAiHgEFQjnJjF/jbCtPPBxe
         APCXHs3H4NRp6eT8OHwAWEpf+EibdsZFlGuzUx2i//CqY2PIpaHW4CzJTs3F4qcEwTCX
         vUEfrKC8ZVBA5esZxNLN4tdYnXlL37skKhgZye6za4+osFzgmKjlYK+2H2qNjPUmxRIQ
         Zwqg==
X-Forwarded-Encrypted: i=1; AJvYcCXt70GDpvcn2DObGtRu1Bev4E+h4DN78bCj/TkHgz2NdB7pvcxmaA1C4i8BtFdMRToKPMoIWcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiaTsAZh2GDeVawVsg9UAVD3h+XFsCMs9zoJychGUmTEa1IEL
	90302Nf69BiBfRrslfOX1U3kVhJUFw2tecyW3+QUHHXzkcTWMEyW8VG0UY0tnYmz0lb1Aenbc9Z
	tNpajZklC/WM+f1KfF+inWOKTZjHyYAR6mT5Qf2PEl6Z7gL6JcSVM6w==
X-Gm-Gg: ASbGnctfYKqT6jYxky5pNWWXDVGBF4g/nyNJlSCQ4sj1gyAyBPJumDDfseNekkF+Ced
	0L2TJ6EVxuSwSLFqFnHvOVW1dr3GShulunYVNXoEI8IolnBptEiPo4c1UTaBJ7Kb4y/5AvZsJNW
	isldZMh4xLjDP27QkOKEDxuz6TQuaQS4gtsObLp2I24mxAiVQP+PqSsZzbkhkRPQEAYdhLJVR9E
	PvZhCJk17RnTPFQOGsSoJNiukdyZqMAUWdbBo3SlXKf5KqYIwehm1zg+hAWmkBXjbcMvleIMXaK
	eufF3kX8eDqcJASzxlE1gQZHkKoaBUV7nM72UDaBrUgk71nuG0lP8f7zGSUhNQv+p6vCUjuslJn
	h1mEoQA==
X-Received: by 2002:a05:6602:7510:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-85e9e86ba74mr916824939f.6.1743430775808;
        Mon, 31 Mar 2025 07:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5pTCoJhS0f0R2nEGIYPWp4mq7Cak4xheeVR+42CL4J7sT1W2wZ0prBJdDzgXZr37+OQwcbg==
X-Received: by 2002:a05:6602:7510:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-85e9e86ba74mr916821639f.6.1743430775499;
        Mon, 31 Mar 2025 07:19:35 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-20-70-53-200-211.dsl.bell.ca. [70.53.200.211])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464751ea2sm1831919173.52.2025.03.31.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 07:19:35 -0700 (PDT)
Message-ID: <7e816e0f-19af-4ef2-bf84-fc762ecbae26@redhat.com>
Date: Mon, 31 Mar 2025 10:19:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250311120422.1d9a8f80@canb.auug.org.au>
 <20250331102749.205e92cc@canb.auug.org.au>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20250331102749.205e92cc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-30 19:27, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 11 Mar 2025 12:04:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>
>>    mm/page_owner.c
>>
>> between commit:
>>
>>    a5bc091881fd ("mm: page_owner: use new iteration API")
>>
>> from the mm-unstable branch of the mm tree and commit:
>>
>>    8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
>>
>> from the bpf-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>>
>> diff --cc mm/page_owner.c
>> index 849d4a471b6c,90e31d0e3ed7..000000000000
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@@ -297,11 -293,17 +297,17 @@@ void __reset_page_owner(struct page *pa
>>    
>>    	page_owner = get_page_owner(page_ext);
>>    	alloc_handle = page_owner->handle;
>>   +	page_ext_put(page_ext);
>>    
>> - 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>> + 	/*
>> + 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() == false
>> + 	 * to prevent issues in stack_depot_save().
>> + 	 * This is similar to try_alloc_pages() gfp flags, but only used
>> + 	 * to signal stack_depot to avoid spin_locks.
>> + 	 */
>> + 	handle = save_stack(__GFP_NOWARN);
>>   -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
>>   +	__update_page_owner_free_handle(page, handle, order, current->pid,
>>    					current->tgid, free_ts_nsec);
>>   -	page_ext_put(page_ext);
>>    
>>    	if (alloc_handle != early_handle)
>>    		/*
> 
> This is now a conflict between the mm-stable tree and Linus' tree.

What's the best way to resolve this? Should I post again or can we just use your fix?


