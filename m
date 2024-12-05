Return-Path: <netdev+bounces-149519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA39E6059
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 23:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437DC283BAF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D841CDA14;
	Thu,  5 Dec 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsu4IjdA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307B1B412C
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733436558; cv=none; b=YJPzTmeeQHeH/AyPvStLuA4gSQ6xKw/xo5dEqmt9/CHB4D8KmFjgRN9B1wUfZoEwlLKLuF1+rHcydmzc50X72iX1HHDYELLJ7z9kW0Yq7iyTklqPBdmBAVe22QXzgyprvDLc1iv1fpgFiMvsXH9a1s9wK1WtsdFrBmRsmtH8iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733436558; c=relaxed/simple;
	bh=oPAB8MNm/iYqvLD6+mGpPmmrKeETDoECwuYXRM1gEMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXeYVbZmoRwAvnZAGfkFXURmepc2My49otrF6YujbikwX3EykjVGQORaH0bAqlATMWwqeXrlc9fIetjl0GrONnw8htIGHox4RqHxuQv/f4egy2OIivVASjAe3JFUNWjnm7NiMYbdzlnjGxUJArVO25YhLDP79OkFY0H/qP7i2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tsu4IjdA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733436556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K6rRhTbjPHZKmtt9u1Jwfy29Ftx4XKSLjb1u2blmbw=;
	b=Tsu4IjdA5f/QZc2lqkewDKhRjNlTIXKhRQi94W7kufwlC3/YsXAjWYMxqn9wH62AtKf7So
	Uk9LohsKh22536TB9FdFcaQTwd/Pzwtftjml/OQZ8ABgdJkt3BNK1w5HX8NadHs48Yw7V7
	blX+4YrdNCAO+7+ljys7KoyE8dDfUz8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75--UimCEXyOV-Ocmqo5kMPUw-1; Thu, 05 Dec 2024 17:09:14 -0500
X-MC-Unique: -UimCEXyOV-Ocmqo5kMPUw-1
X-Mimecast-MFC-AGG-ID: -UimCEXyOV-Ocmqo5kMPUw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d6ee042eso956268f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 14:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733436553; x=1734041353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K6rRhTbjPHZKmtt9u1Jwfy29Ftx4XKSLjb1u2blmbw=;
        b=AyiZ5gI8ARV6TEC+31cLHJNxdrjquAkuGN6g4GGVsUKLP7fYSDxe1QbywMtzzfY8ii
         Tyfj6cPjV8H6seztTD8yNt0fp0BUG5gW/0AgyI6rqsNymuV9zNaeeiq/vf2Xw5AQpW60
         pUTnqIWaECk3k2OAo/uqhEHJBLukxTkv++S+fYSvmWiZt5dyQtJBJy0K24siWP9G8PRe
         4gHJt3LT2eajdB1vHUbnyBWqqqyuBe0ZjXWvLO813BC+iz0rlDEvNooM9buBpE/lQyZM
         +mjxnCycO82OtTQ4hIDghCfFF8EFqQ7vheub8XNjrQuvk128/3Sht1mTINPnOQcM6ZiR
         YZqw==
X-Forwarded-Encrypted: i=1; AJvYcCX2/zN8vo6o7rG9i3MUeKSpRNZ3m+0azKoChBkUtMRHgkNW7F2oSU9V1oIOHff1KKhi7YbTikk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlaiHM26HlzVSlVGGWnjl+8sFB0+ltBq//9/blcldVkeHk4bE
	et5znoTrB4n3TZknEulEW4ERzWcwZD2eqXJ3ciU4skix00aOz5ZfjpzwxiqiV8yPUccV11IixhQ
	DZsFX5TqhW8MXr0PXnNSQP15Dw3E3dg2R8sYsGfcKHq1xfBWqncpw9Q==
X-Gm-Gg: ASbGncvzsMcx9sV4B7SRXQaO44lfavO+325b3ceqtVXfPRLG++kql90po+rpZPb2Nh7
	4KVwChZLyjgy6a5V4rpxtJKKSfTHrhu3+CZo3mdFuVr3MmxMnD7TJPQoBiaHQjPf6q2IGqWe9H+
	UGUc5gEg9ny5wa6TuSL4Sge5nSdbkS6ynCTo7Md1yewlEU1IjV3zVLfPucdJ0u+2YumtH0DK40a
	XaJxbYoUZm4eykgYUi4us7Dkec6BReKmt/7JckxyrdDnNnYvUzy1RNvefz7JKG0FqEPgI2ha2S2
X-Received: by 2002:a05:6000:1846:b0:37d:4647:154e with SMTP id ffacd0b85a97d-3862b333747mr495658f8f.9.1733436553557;
        Thu, 05 Dec 2024 14:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4bpW7oxOHiLbTlpB9y5vzRVJL+BszHvE+Mvo8k7nQKzPIEp6Zvxvrkrxa6ZZ+N2u5tislaw==
X-Received: by 2002:a05:6000:1846:b0:37d:4647:154e with SMTP id ffacd0b85a97d-3862b333747mr495642f8f.9.1733436553151;
        Thu, 05 Dec 2024 14:09:13 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862294b1e3sm2977213f8f.109.2024.12.05.14.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 14:09:12 -0800 (PST)
Message-ID: <56f68ea6-9605-4120-afda-6ed5beb0c12d@redhat.com>
Date: Thu, 5 Dec 2024 23:09:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: defer final 'struct net' free in netns
 dismantle
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Ilya Maximets <i.maximets@ovn.org>,
 Dan Streetman <dan.streetman@canonical.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <20241204125455.3871859-1-edumazet@google.com>
 <a88b242a-a6ca-466e-9ca2-627e9193b1e3@redhat.com>
 <CANn89i+-Syy2spK6V3MK1RYT71nwuNYrMMVCJ0-wv0LAUwHvkQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+-Syy2spK6V3MK1RYT71nwuNYrMMVCJ0-wv0LAUwHvkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/5/24 10:14, Eric Dumazet wrote:
> On Thu, Dec 5, 2024 at 9:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 12/4/24 13:54, Eric Dumazet wrote:
>>> Ilya reported a slab-use-after-free in dst_destroy [1]
>>>
>>> Issue is in xfrm6_net_init() and xfrm4_net_init() :
>>>
>>> They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
>>>
>>> But net structure might be freed before all the dst callbacks are
>>> called. So when dst_destroy() calls later :
>>>
>>> if (dst->ops->destroy)
>>>     dst->ops->destroy(dst);
>>>
>>> dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been freed.
>>>
>>> See a relevant issue fixed in :
>>>
>>> ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
>>>
>>> A fix is to queue the 'struct net' to be freed after one
>>> another cleanup_net() round (and existing rcu_barrier())
>>
>> I'm sorry for the late feedback.
>>
>> If I read correctly the above means that the actual free could be
>> delayed for an unlimited amount of time, did I misread something?
>>
>> I guess the reasoning is that the total amount of memory used by the
>> netns struct should be neglicible?
>>
>> I'm wondering about potential ill side effects WRT containers
>> deployments under memory pressure.
> 
> One net_namespace structure is about 3328 bytes today, a fraction of
> the overall cost of a live netns.
> 
> It would be very unlikely a deployment would have one cleanup_net(),
> adding these in a long list,
> then no other cleanup_net().

I agree it should be fine, I wanted to double check I did not misread
the patch nor missed any side effect.

Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks,

Paolo


