Return-Path: <netdev+bounces-134517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7914999F47
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C95DB22C21
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FE20C467;
	Fri, 11 Oct 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0UJkOeO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269920B1FE
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636590; cv=none; b=RRZeCvTOPAD/XX44a2guWKirj5o2KeKg8x1V4LCFT6cGLfgdKqOatb/o/RvlbLXNq8K5+5qw0xzOJ1QxSdQbuDMxVA/pjVm3gUxHgdDlczloI/yoCPk3/n97cGXi1ePxyMH4Bp76f2drue71AbL9voUfMqv5S15lwHPnGje+ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636590; c=relaxed/simple;
	bh=W9xhJYell6X3xTMZnLLEOB7BcG/GnmwDX6moREFNgI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq9Yslwwl2JFMobQ2laVGNCIFtK3FS8DzehltpE5VQA1TMIk/2xZ+6sStN5Xtsi85n5TYxpCdESuqZRoF/0lNYv7YNj3vDKorqXBtjWuANAjzC8dKj+wQ/4kGwJD8Rp9bxnYFosvY/7FfH8ZP9XBjdIKdc706GrNdYT4fbZE6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0UJkOeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728636586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlK04rC90ckCmvgBVby2uJQqFmhQZdLdAq9X4rPawD0=;
	b=Q0UJkOeOHTE44Et0eX+fAcVwdzDpKiF79lhoGpOiMltLHeUgvMERom7EAGs0bdE1A/ubxv
	HqU0tJtX7UugZHuNEGFfQZxfWV5W3Criwk8RRfdG3rXpK2hdoUqfXajPMLWphfRKxBKDI3
	DS9j3kQMld/KqPgs8T0wZlmSa7patxE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-78fQDcQaMMy9oLo1393kXQ-1; Fri, 11 Oct 2024 04:49:44 -0400
X-MC-Unique: 78fQDcQaMMy9oLo1393kXQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso381149f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728636583; x=1729241383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlK04rC90ckCmvgBVby2uJQqFmhQZdLdAq9X4rPawD0=;
        b=l1rhMisi7W9jBalAn3oyc64oCV53Ds2WuBAVnLJXHkWcKSkVopT8MWNbHVcscf18oK
         aoYkfUpY6w1CRHymbUBv6NcjJWQLXMKf5mDZrtRr9uv+e0c+FjW2v+1PlaGbx/pJ9a5H
         OJvBFXJZUSI6jr2x5FpTRYQ0pt77HECpwVk1stwiX3Oezc1RajJkwpa2TSKTWTMpbEtd
         tHNN/5DiAzvLjnv0X6FVcmJZ0LwG7IdRt6c8TGe4xSU0A6Ac0vdZOu54+tQlAZGz1x95
         4pm1AQUPJ5hEHYbSKc2RDtCjjQ1AWlR+2xt+0U5cwk1TWnO3DBDBW8b/09TQRtMwkZ9G
         ECKg==
X-Forwarded-Encrypted: i=1; AJvYcCW7f+4ZD+yxlp8L0tz9E0VPPmht8JeqLUNkTXNBvbP8noT3eEcLd0l8RW+Tna0Pxe56UrmiTKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkbEHKBScxQgDL2yDpcPovS60fbyY95/hYkid0K0W+23Cu8Q4
	d4X0icgrAHep5Mso7B7vtidU7ivYHzV63UA/NEcAga7TyGeBCYf+tsOdxpnzdnvn/YxoPlOpALN
	lDq199cFxsZNLSie+fg1vreckoTFzMUpT3EsxeP4IWRR7spVs1Q7m2Q==
X-Received: by 2002:a05:6000:100a:b0:37d:50a5:6cf0 with SMTP id ffacd0b85a97d-37d551aaad3mr1198774f8f.6.1728636583305;
        Fri, 11 Oct 2024 01:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/pSBYKVExbOk6Qqwxls2kbf2KVOJ5g9IUliZH/Hn2JKE+1qei48NVv+9YwlgG+bMfY2K0cQ==
X-Received: by 2002:a05:6000:100a:b0:37d:50a5:6cf0 with SMTP id ffacd0b85a97d-37d551aaad3mr1198759f8f.6.1728636582870;
        Fri, 11 Oct 2024 01:49:42 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cf8dbsm3411142f8f.59.2024.10.11.01.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:49:42 -0700 (PDT)
Message-ID: <60a8fea1-e876-4174-bf32-9524204d63ed@redhat.com>
Date: Fri, 11 Oct 2024 10:49:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ip: make fib_validate_source()
 return drop reason
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de,
 toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
 <20241007074702.249543-2-dongml2@chinatelecom.cn>
 <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
 <CADxym3baw2nLvANd-D5D2kCNRRoDmdgexBeGmD-uCcYYqAf=EQ@mail.gmail.com>
 <CADxym3ZGR59ojS3HApT30G2bKzht1pbZG212t3E7ku61SX29kg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADxym3ZGR59ojS3HApT30G2bKzht1pbZG212t3E7ku61SX29kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 08:42, Menglong Dong wrote:
> On Thu, Oct 10, 2024 at 5:18 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> On Thu, Oct 10, 2024 at 4:25 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>> On 10/7/24 09:46, Menglong Dong wrote:
>>>> In this commit, we make fib_validate_source/__fib_validate_source return
>>>> -reason instead of errno on error. As the return value of them can be
>>>> -errno, 0, and 1, we can't make it return enum skb_drop_reason directly.
>>>>
>>>> In the origin logic, if __fib_validate_source() return -EXDEV,
>>>> LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it by
>>>> checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
>>>> effect only after the patch "net: ip: make ip_route_input_noref() return
>>>> drop reasons", as we can't pass the drop reasons from
>>>> fib_validate_source() to ip_rcv_finish_core() in this patch.
>>>>
>>>> We set the errno to -EINVAL when fib_validate_source() is called and the
>>>> validation fails, as the errno can be checked in the caller and now its
>>>> value is -reason, which can lead misunderstand.
>>>>
>>>> Following new drop reasons are added in this patch:
>>>>
>>>>     SKB_DROP_REASON_IP_LOCAL_SOURCE
>>>>     SKB_DROP_REASON_IP_INVALID_SOURCE
>>>>
>>>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>>>
>>> Looking at the next patches, I'm under the impression that the overall
>>> code will be simpler if you let __fib_validate_source() return directly
>>> a drop reason, and fib_validate_source(), too. Hard to be sure without
>>> actually do the attempt... did you try such patch by any chance?
>>>
>>
>> I analysed the usages of fib_validate_source() before. The
>> return value of fib_validate_source() can be -errno, "0", and "1".
>> And the value "1" can be used by the caller, such as
>> __mkroute_input(). Making it return drop reasons can't cover this
>> case.
>>
>> It seems that __mkroute_input() is the only case that uses the
>> positive returning value of fib_validate_source(). Let me think
>> about it more in this case.
> 
> Hello,
> 
> After digging into the code of __fib_validate_source() and __mkroute_input(),
> I think it's hard to make __fib_validate_source() return drop reasons
> directly.
> 
> The __fib_validate_source() will return 1 if the scope of the
> source(revert) route is HOST. And the __mkroute_input()
> will mark the skb with IPSKB_DOREDIRECT in this
> case (combine with some other conditions). And then, a REDIRECT
> ICMP will be sent in ip_forward() if this flag exists.
> 
> I don't find a way to pass this information to __mkroute_input
> if we make __fib_validate_source() return drop reasons. Can we?
> 
> An option is to add a wrapper for fib_validate_source(), such as
> fib_validate_source_reason(), which returns drop reasons. And in
> __mkroute_input(), we still call fib_validate_source().
> 
> What do you think?

Thanks for the investigation. I see that let __fib_validate_source() 
returning drop reasons does not look like a good design.

I think the additional helper will not help much, so I guess you can 
retain the current implementation here, but please expand the commit 
message with the above information.

Thanks!

Paolo


