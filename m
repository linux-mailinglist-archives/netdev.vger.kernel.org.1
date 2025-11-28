Return-Path: <netdev+bounces-242521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCAC9142A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061B3AF85B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569812F7AAD;
	Fri, 28 Nov 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbnQHvey";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUp1JPjx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878B2E8B9B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319230; cv=none; b=NkaRXBPnDqikuNabe5n26IESRcPjWNnL/B+Ri9Dwj49hjrqPumuQoUV/frjbajLXSTqLLgZhrZIU5iXTBX8UQsef/xF8zO351S2BVkefnd/UojMqoWnoXq/Soxsh+NsKenhHiPIap6CXcjubqGA7NrfTMZhSq8+W7wXYLMFuCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319230; c=relaxed/simple;
	bh=FAr/GGpauPyMQGkemE6ZZD1cchU8P44wQZ64H/RgQSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED3ma9ZVEYNxDgp2RMwfSPymiCnlCNK0QJax7LHfE3ug0VHnkeycpQ6bwmmw+lMTbncPnfuwloN2Z4KWi0IHJ48kGy6GJIQI0YrYnKtyqARyksqYFaRi86Xs1V7IbwMHu4IjHMY6BioSJ9sCqhIaAGOftYI7xESwuF5gEi8mmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbnQHvey; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUp1JPjx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764319223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOXCyi+N+bccxvaPF3v4Z/F/wizbKPeceUefBWj6M50=;
	b=JbnQHveyqATP4yRrnhWDkh0+RkhsbgV+wtqDBsff6fAe+iFzuhd25RQclWFIWTafAK+2Bc
	Mld1iT1t8EVbgUJNLDsG9FkZZXcL38hLFm9K+rFWuZb7pFVNO/KvEo5oWTQyshPJPI/n7W
	dLr8RlzV2hQuXSLSJUlJV3OMYgN/BfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-TAD54T56PBSLNLs7pz2OoA-1; Fri, 28 Nov 2025 03:40:21 -0500
X-MC-Unique: TAD54T56PBSLNLs7pz2OoA-1
X-Mimecast-MFC-AGG-ID: TAD54T56PBSLNLs7pz2OoA_1764319220
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47106720618so17417905e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764319220; x=1764924020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOXCyi+N+bccxvaPF3v4Z/F/wizbKPeceUefBWj6M50=;
        b=RUp1JPjxLc2QvlSfGlJcvPfsStR0TDGxWdwlKorle1aiRS3rPt+IIXRt6GGYx74u5v
         hN50NNYHKlI+UcHWidE21bg3IOWrVlE+Jjh3mVNFFHxRwCCYO6vCZ67WkzVZuW3TQBm3
         CDLefF6DDB0sJ1tZIghzmc1ZeBFfHlN50qvYL0K/QMmBJgZj2NQot35Ff5nPPZ368Hd6
         0RF7O6QFwC+45Xpq7Oiunk2eJTdg+XTxPb63cP8rpTMeZpjntzlHZTApwE25X69Dnd02
         3myfP9UZXgAEu4sILKaPQHXbiiG8iDde2PmZm0kEtmEC9l+O1JGQa716ZiLAMqzHUTiW
         arzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764319220; x=1764924020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOXCyi+N+bccxvaPF3v4Z/F/wizbKPeceUefBWj6M50=;
        b=bbR2/NVIxcTP9oEX2TxkiTsNK92jfdv9RcVgRCwFq6ZqzdPYZ11c6eqXHsIdAMsoja
         c2JKFKqqxcG7ikx8VPWbWd0FFgVCq6tNrMmg98a9+9RgFD8ijRoWzs1Pp7y2FigpTuQA
         cVFiqbRlY5AtmjOXT5TZtWKZiQaRUkQfE6fuE21NwIcIS3zd0bbO1V5yIFE/yqlUmzGk
         d8vGhjjOINCiMTDfF698HU7Bkx7N8oXpFulQicJFKh+KfdTp4G64pD0phTzpJM7LAgkz
         7WBgV0tOyrby0C67uOt9NIvsSxvuOpeWF4bU1dG3yWCyQ0y9/Ty1YfmQ/6w1hwG5LkE6
         Cvzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpYl0LlfkXn4+23Y79vtio1RgAPDV6nmYdW0J0nZlFxysDpjnEY6E9FkqBYDrQOvGa+VWpZEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mpWJkGVf3GAGGgdbJeyUF+8wWma2Naxa06Iuwo1vqp6C4OCX
	sjccRlwMvpXqzELqm3kcoYRzursQPLrnyTqAhYvb7koS4UeBkheiJYFQEWAUrKToqvn16g4CTcm
	sLMJR25SVsRQKxvpX30KL7kDZMda4UZ/HrI37j+EOV3aocz2XhcAWndiFFg==
X-Gm-Gg: ASbGncvmPDfTqlcwYtzMONcfridADiKb/1E9EhShO5uG67s6TxXmaan8EAtw2FrydH4
	2hZe5vn201o+IFpUr9ZzlP4YM3zFUDMpBfBvoatJ05RLiMh/q62u0cPT5esFiuMlsgNklVrkFxL
	EkLXHBw+K3GPuzvVyAOTBcO5yGXpGzneotVwdBn+DVQLIXapaDL0Uno12aosOHvCvIO/08ZW575
	azVDmopXSKSd7soYN0VIs+ecbtMUIZYGfPyxG6+4ty9bPKKwsS/pF7EUl5G1jraaJaXAccRrD9v
	dUHl6Q7efk7xAGzxqxkwjFloXuerPQm5yN7tNMBuxIQa+mW1PUSU6OwOkK5vac8JH26t8GZZMHE
	/asMmlk4czK2MEQ==
X-Received: by 2002:a05:600c:470d:b0:471:1717:411 with SMTP id 5b1f17b1804b1-477c01edab1mr330071515e9.24.1764319220212;
        Fri, 28 Nov 2025 00:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc0xj3JcNVsG3D1+mRDnvoXzRumm+1p3khoPuro2XJiejhlWvTPbmuCWFmwSqh/cpTWZ4R1A==
X-Received: by 2002:a05:600c:470d:b0:471:1717:411 with SMTP id 5b1f17b1804b1-477c01edab1mr330070905e9.24.1764319219730;
        Fri, 28 Nov 2025 00:40:19 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47913870b38sm23292005e9.15.2025.11.28.00.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 00:40:19 -0800 (PST)
Message-ID: <66f0659a-c7f1-4ebd-8f75-98e053c9f390@redhat.com>
Date: Fri, 28 Nov 2025 09:40:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125115754.46793-1-kerneljasonxing@gmail.com>
 <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com>
 <CAL+tcoDdntkJ8SFaqjPvkJoCDwiitqsCNeFUq7CYa_fajPQL4A@mail.gmail.com>
 <f8d6dbe0-b213-4990-a8af-2f95d25d21be@redhat.com>
 <CAL+tcoAY5uaYRC2EyMQTn+Hjb62KKD1DRyymW+M27BT=n+MUOw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoAY5uaYRC2EyMQTn+Hjb62KKD1DRyymW+M27BT=n+MUOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/28/25 2:44 AM, Jason Xing wrote:
> On Fri, Nov 28, 2025 at 1:58 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/27/25 1:49 PM, Jason Xing wrote:
>>> On Thu, Nov 27, 2025 at 8:02 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> On 11/25/25 12:57 PM, Jason Xing wrote:
>>>>> This patch also removes total ~4% consumption which can be observed
>>>>> by perf:
>>>>> |--2.97%--validate_xmit_skb
>>>>> |          |
>>>>> |           --1.76%--netif_skb_features
>>>>> |                     |
>>>>> |                      --0.65%--skb_network_protocol
>>>>> |
>>>>> |--1.06%--validate_xmit_xfrm
>>>>>
>>>>> The above result has been verfied on different NICs, like I40E. I
>>>>> managed to see the number is going up by 4%.
>>>>
>>>> I must admit this delta is surprising, and does not fit my experience in
>>>> slightly different scenarios with the plain UDP TX path.
>>>
>>> My take is that when the path is extremely hot, even the mathematics
>>> calculation could cause unexpected overhead. You can see the pps is
>>> now over 2,000,000. The reason why I say this is because I've done a
>>> few similar tests to verify this thought.
>>
>> Uhm... 2M is not that huge. Prior to the H/W vulnerability fallout
>> (spectre and friends) reasonable good H/W (2016 old) could do ~2Mpps
>> with a single plain UDP socket.
> 
> Interesting number that I'm not aware of. Thanks.
> 
> But for now it's really hard for xsk (in copy mode) to reach over 2M
> pps even with some recent optimizations applied. I wonder how you test
> UDP? Could you share the benchmark here?
> 
> IMHO, xsk should not be slower than a plain UDP socket. So I think it
> should be a huge room for xsk to improve...

I can agree with that. Do you have baseline UDP figures for your H/W?

>> Also validate_xmit_xfrm() should be basically a no-op, possibly some bad
>> luck with icache?
> 
> Maybe. I strongly feel that I need to work on the layout of those structures.
>>
>> Could you please try the attached patch instead?
> 
> Yep, and I didn't manage to see any improvement.

That is unexpected. At very least that 1% due to validate_xmit_xfrm()
should go away. Could you please share the exact perf command line you
are using? Sometimes I see weird artifacts in perf reports that go away
adding the ":ppp" modifier on the command line, i.e.:

perf record -ag cycles:ppp <workload>

>> I think you still need to call validate_xmit_skb()
> 
> I can simplify the whole logic as much as possible that is only
> suitable for xsk: only keeping the linear check. That is the only
> place that xsk could run into.
What about checksum offload? If I read correctly xsk could build
CSUM_PARTIAL skbs, and they will need skb_csum_hwoffload_help().

Generally speaking if validate_xmit_skb() takes a relevant slice of time
for frequently generated traffic, I guess we should try to optimize it.

@Eric: if you have the data handy, do you see validate_xmit_skb() as a
relevant cost in your UDP xmit tests?

Thanks,

Paolo


