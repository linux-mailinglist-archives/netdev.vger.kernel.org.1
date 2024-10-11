Return-Path: <netdev+bounces-134650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640099AB28
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7662847A3
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820D1CEAB1;
	Fri, 11 Oct 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="RRklVcYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0D1C9EAC
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672282; cv=none; b=fPilqEUOYh6Jy3+MDQAH/I4jmRiVyZrypVpl0CCoIu0wjpCBumWRrG+m7+rDfpRTv7ZEj11aOa1FuiWltsvdjs/KJgN9nCz3yMEj2PmrTZIANplx/jOB0sZovIpX4i+/cDNazo4TQlIxtyc8ImTxJMD7ltMFW8cLCuLq6chl0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672282; c=relaxed/simple;
	bh=+CrjRFmuRBhakr4lGSUJwfVpywUbknE5IX8tnyZ1I64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHvpZuwhStse+9+eOUu/ipIFHCTUyJ/q1IeSfFaObh/Yp4zQAWbMt0gBu2qkXrQqFzEYjaHnuuXUFupNq4Pr0G8NwjoIHrIWzFrWjcNWnOUJFbfsLNF7ushnqd1UKZr05fVD9TrBnQbwwMhFn2G6k+DaozlT3FoHzaYcoSSAllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=RRklVcYr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20caccadbeeso7917675ad.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728672280; x=1729277080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXJkaI14eGa0xZB9hgsghdQZjRzdnP97+WPOm8D2LtA=;
        b=RRklVcYrD4BoTsQIjyF2EHmH7gBCFUon8Q6mnu4kzrgQ+NoDj8hjvS/JTxr/HsGTDP
         optMz2hhGjZcuaq9pcJ64aa/nDbRbEKI9p2zUOoDuOgEZSQpJUPjUvXsKbIs1+QyXfBE
         CXbcK/o/zadmm8UmObeU1UyeRmHqGftjs4doPTsllx0ZJQZzVOkBm3G9Xr/0OChjIJAQ
         zVppii+X/T4tUoUBypfbfctToyGIlXlaxTNdy/wj6lqAMlQdraq1pMogwCl6zQRrmoLA
         xA7LmQtxzZI6EJrFgt5z7gYDwIjViXP6zOcREHdn6sEe3M76RxkaeHdUQqYDFuOiRhFx
         Abaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672280; x=1729277080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXJkaI14eGa0xZB9hgsghdQZjRzdnP97+WPOm8D2LtA=;
        b=Ydwj6OucgChr2jwpXkviZTj1n91mR+z8Lp07n7hxBJxst1No3OOKjohwvxFM5S0vUa
         c93aY1Du0rBue41kqntBfPRkBXE+hbsyCKZbLiqZn/hU+rXetwRaaWLzv4fhnVI9jWK4
         NXyDdp7j8wVz+VpRmxHAnTgtAEpMG1/BTiYmWykKwoVDtgwZHXyHKZRb6nAOOoVR9wOL
         0u9Wu1dO5oxSuhoijGEG2FkPZRJvBUA0wjgF0Pj+JoD/onpoWCpHO1f04nq9DitOywL8
         4CwoeAnco/syIoJEpbl8QklpT6/pAaMB/KRROHvgMPxlWOYkXrzHUX1g07QTLwHyPJtL
         PLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV3ZyVG8aOVjaTv620CoGvcbsyqZlfkKIE0Fha18CQbND0CynLAbt2ftpL5wbiG3pwdefHLYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOSargkt6vYqCNQPBoODKPjq7YfSl76krUjjGdPXrPd64haZ8
	f4CaiZ5/MohCeNAdfWU6+Xr5mByucUHFkJLzSpoR4a5z8SE4CXpgb7V2T6RAFLY=
X-Google-Smtp-Source: AGHT+IESg0X/mbRRf8DMPNZmcIB4i+1z+3SJHm0Fz37PItVLeEBmfLD87NQcIQZeMDevsGSg2nDlEw==
X-Received: by 2002:a17:902:e801:b0:20c:9821:6997 with SMTP id d9443c01a7336-20ca142a39amr37682845ad.8.1728672279750;
        Fri, 11 Oct 2024 11:44:39 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::7:4e3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e791esm26312445ad.132.2024.10.11.11.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 11:44:39 -0700 (PDT)
Message-ID: <b2aa16ac-a5fe-4bab-a047-8f38086f4d43@davidwei.uk>
Date: Fri, 11 Oct 2024 11:44:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] net: generalise net_iov chunk owners
Content-Language: en-GB
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-4-dw@davidwei.uk> <ZwVT8AnAq_uERzvB@mini-arch>
 <ade753dd-caab-4151-af30-39de9080f69b@gmail.com> <ZwavJuVI-6d9ZSuh@mini-arch>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZwavJuVI-6d9ZSuh@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-09 09:28, Stanislav Fomichev wrote:
> On 10/08, Pavel Begunkov wrote:
>> On 10/8/24 16:46, Stanislav Fomichev wrote:
>>> On 10/07, David Wei wrote:
>>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>>
>>>> Currently net_iov stores a pointer to struct dmabuf_genpool_chunk_owner,
>>>> which serves as a useful abstraction to share data and provide a
>>>> context. However, it's too devmem specific, and we want to reuse it for
>>>> other memory providers, and for that we need to decouple net_iov from
>>>> devmem. Make net_iov to point to a new base structure called
>>>> net_iov_area, which dmabuf_genpool_chunk_owner extends.
>>>>
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>>> ---
>>>>   include/net/netmem.h | 21 ++++++++++++++++++++-
>>>>   net/core/devmem.c    | 25 +++++++++++++------------
>>>>   net/core/devmem.h    | 25 +++++++++----------------
>>>>   3 files changed, 42 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>>> index 8a6e20be4b9d..3795ded30d2c 100644
>>>> --- a/include/net/netmem.h
>>>> +++ b/include/net/netmem.h
>>>> @@ -24,11 +24,20 @@ struct net_iov {
>>>>   	unsigned long __unused_padding;
>>>>   	unsigned long pp_magic;
>>>>   	struct page_pool *pp;
>>>> -	struct dmabuf_genpool_chunk_owner *owner;
>>>> +	struct net_iov_area *owner;
>>>
>>> Any reason not to use dmabuf_genpool_chunk_owner as is (or rename it
>>> to net_iov_area to generalize) with the fields that you don't need
>>> set to 0/NULL? container_of makes everything harder to follow :-(
>>
>> It can be that, but then io_uring would have a (null) pointer to
>> struct net_devmem_dmabuf_binding it knows nothing about and other
>> fields devmem might add in the future. Also, it reduces the
>> temptation for the common code to make assumptions about the origin
>> of the area / pp memory provider. IOW, I think it's cleaner
>> when separated like in this patch.
> 
> Ack, let's see whether other people find any issues with this approach.
> For me, it makes the devmem parts harder to read, so my preference
> is on dropping this patch and keeping owner=null on your side.

I don't mind at this point which approach to take right now. I would
prefer keeping dmabuf_genpool_chunk_owner today even if it results in a
nullptr in io_uring's case. Once there are more memory providers in the
future, I think it'll be clearer what sort of abstraction we might need
here.

