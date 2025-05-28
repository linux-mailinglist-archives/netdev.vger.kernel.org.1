Return-Path: <netdev+bounces-194015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B01AC6D2D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CB2A22F02
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463162798EB;
	Wed, 28 May 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ac76xMaz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868961C860C
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447283; cv=none; b=Vz39m/urw75s5CGOSthYorIiEZiHmsYD41ZQsELnkTButz729tPS/L0blVhfZjQUp1b51nr8l04CZ+c8chn1inPSZrZf4T8YQp6PdjdofaEDed0QpsfDk0Z6E2hDSK0QurSDMBI5pGwWQKKKF6iOmri+biARdMKZDzF9k2x76SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447283; c=relaxed/simple;
	bh=GK2S36QTN3Nh4IWhbg8RxsJgGLCZ3sVVlxu7y8BBk0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVU4VCyTKJsK1rCIaiOgkjE8ffweQqXanXAdMwGSwG2NaTBeSB3otMu6CchGmtAOu9RySmjanqBGFXThJDhALEi1Pq5S4uOZbUAWCO/5zRSfCVMHyQrebmJiiNEwXwXlMG/+WlQoSOYsRMRLRlWxpbak+nGo873T82GiG1FouWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ac76xMaz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748447280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pENshd8fJdbrAl1ktbn4RRSGUUMrg9nhqmtdO02uNko=;
	b=ac76xMazrc4rxGPe7ZWNBOws7h35Nip6TMiqWzIzKxApY+bNqU/qJ0WOp9sJrWEOwEw+xa
	kPq3hGeDEEg275OxA3yJmEL6T4A0b7UYNzeAOmJvyrZFMokF5D/mEA8sRE6nPymTB1EyX1
	FCvYFifeVn6TTun6KNoYir2fjq6BEKc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-t3r1b3S3PAinCV5cLuuX6A-1; Wed, 28 May 2025 11:47:58 -0400
X-MC-Unique: t3r1b3S3PAinCV5cLuuX6A-1
X-Mimecast-MFC-AGG-ID: t3r1b3S3PAinCV5cLuuX6A_1748447276
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso522466f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 08:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447276; x=1749052076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pENshd8fJdbrAl1ktbn4RRSGUUMrg9nhqmtdO02uNko=;
        b=M3DwJ7f4jAS1TIjVpqwEids6ud5luGcuB3p3FcQ2Z/BicFcRQ+Q/CCTYMmCUJEDRg6
         JOfCBxidckEbzhIekltXY146CKOTSVYX4vuZHUo0YHj+/mEL105uSnKm+GjnVpW79gsc
         cVSeMTZPGT6s5Yxw2qlxKvwOZUDa5QFTBr3yQ97bGACvtwxLnG3xp1FrCKeqXn2YYv6d
         hOUZyDZH1ojJqOacfCSQ0LKNhg3KQJIxv53vlkTHpED+kzk/61bK1Q6kOz/ITDVaQpl9
         H2vSoBpHxcvCMdNfK7FYQXOaTxal+QiyQDHGxIkLSZ15jQTtesuAnCfQs8lUPgQitpqh
         bMxw==
X-Gm-Message-State: AOJu0Yyntl0b+VMX7MaSJRff+9IXAoDmNPh/99CugomjC9iHVXkDtr8Y
	6r3t06zq0PbQr0FC6RzirvAERQnbidgQoPjMr+7lBDSXw9SCMuQfmuXlQgqLQ3Hdt1iybo8hBNv
	t2+m6mghmzutJHn9oMwKGPl+TLyo9zySoxZ9itCKq7Q8K4aGrvpqkZJY09g==
X-Gm-Gg: ASbGnctvEQV0ybfYkoL0x+EVOxa6Y6qdRm9kkOpcqOttlokkhDi1eeKD6rCUgtOPZ6z
	9hS0cwwr8MG7Zyver27/ZT5IaI6I1gjIf2sZenIc4UK3iB6BNAO2G5YYZLJt5zRYgWtOj1VzCIV
	LQ9lRhGST2uXvMA/ybttNSdHzCGJ91vRyp8v8I40SEFaslxUE1ql1cKp5ScEkmMsdBimvrItOgv
	dzTV5kWRI4WGp8fdaMVk82TCLqZA2ledXMGpmv4odp4dIUVBg0+C9ha+05VdU5xyBbA3O/rRX2k
	mFPS7Ew+xJL/XrDmbkU=
X-Received: by 2002:a05:6000:22c6:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3a4eedae9eamr18609f8f.24.1748447275803;
        Wed, 28 May 2025 08:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfe5mU+8sYz2bs9Uc7MqVa9kiKwrhfenTU2kWd1rbGnnelJswvX5D667Fl6g18WH0MpriPCQ==
X-Received: by 2002:a05:6000:22c6:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3a4eedae9eamr18585f8f.24.1748447275395;
        Wed, 28 May 2025 08:47:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac8a85asm1790366f8f.48.2025.05.28.08.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 08:47:54 -0700 (PDT)
Message-ID: <3ae72579-7259-49ba-af37-a2eaba719e7e@redhat.com>
Date: Wed, 28 May 2025 17:47:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
 <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>
 <CACGkMEsHn7q8BvfkaiknQTW9=WONLC_eB9DV0bcqL=oLa62Dxg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsHn7q8BvfkaiknQTW9=WONLC_eB9DV0bcqL=oLa62Dxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/25 5:51 AM, Jason Wang wrote:
> On Mon, May 26, 2025 at 3:20 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/26/25 2:43 AM, Jason Wang wrote:
>>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
>>>> new file mode 100644
>>>> index 0000000000000..2f742eeb45a29
>>>> --- /dev/null
>>>> +++ b/include/linux/virtio_features.h
>>>> @@ -0,0 +1,23 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef _LINUX_VIRTIO_FEATURES_H
>>>> +#define _LINUX_VIRTIO_FEATURES_H
>>>> +
>>>> +#include <linux/bits.h>
>>>> +
>>>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
>>>> +#define VIRTIO_HAS_EXTENDED_FEATURES
>>>> +#define VIRTIO_FEATURES_MAX    128
>>>> +#define VIRTIO_FEATURES_WORDS  4
>>>> +#define VIRTIO_BIT(b)          _BIT128(b)
>>>> +
>>>> +typedef __uint128_t            virtio_features_t;
>>>
>>> Consider:
>>>
>>> 1) need the trick for arch that doesn't support 128bit
>>> 2) some transport (e.g PCI) allows much more than just 128 bit features
>>>
>>>  I wonder if it's better to just use arrays here.
>>
>> I considered that, it has been discussed both on the virtio ML and
>> privatelly, and I tried a resonable attempt with such implementation.
>>
>> The diffstat would be horrible, touching a lot of the virtio/vhost code.
> 
> Let's start with the driver. For example, driver had already used
> array for features:
> 
>         const unsigned int *feature_table;
>         unsigned int feature_table_size;
> 
> For vhost, we need new ioctls anyhow:
> 
> /* Features bitmask for forward compatibility.  Transport bits are used for
>  * vhost specific features. */
> #define VHOST_GET_FEATURES      _IOR(VHOST_VIRTIO, 0x00, __u64)
> #define VHOST_SET_FEATURES      _IOW(VHOST_VIRTIO, 0x00, __u64)
> 
> As we can't change uAPI for existing ioctls.
> 
>> Such approach will block any progress for a long time (more likely
>> forever, since I will not have the capacity to complete it).
>>
> 
> Well, could we at least start from using u64[2] for virtio_features_t?
> 
>> Also the benefit are AFAICS marginal, as 32 bits platform with huge
>> virtualization deployments on top of it (that could benefit from GSO
>> over UDP tunnel) are IMHO unlikely,
> 
> I think it's better to not have those architecture specific assumptions since:
> 
> 1) need to prove the assumption is correct or
> 2) we may also create blockers for 64 bit archs that don't support
> ARCH_SUPPORTS_INT128.
> 
>> and transport features space
>> exhaustion is AFAIK far from being reached (also thanks to reserved
>> features availables).
> 
> I wouldn't be worried if a straightforward switch to int128 worked,
> but it looks like that is not the case:
> 
> 1) ARCH_SUPPORTS_INT128 dependency
> 2) new uAPI
> 3) we might want a new virtio config ops as well as most of transport
> can only return 64 bit now
>>
>> TL;DR: if you consider a generic implementation for an arbitrary wide
>> features space blocking, please LMK, because any other consideration
>> would be likely irrelevant otherwise.

I read your comments above as the only way forward is abandoning the
uint128_t usage. Could you please confirm that?

Side note: new uAPI will be required by every implementation of
feature-space extension, as the current ones are 64-bits bound.

Thanks,

Paolo


