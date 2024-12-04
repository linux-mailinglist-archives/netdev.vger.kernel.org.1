Return-Path: <netdev+bounces-148913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF479E365A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119E8166B40
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAA18D622;
	Wed,  4 Dec 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiyRqeJq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139A17B50E
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303793; cv=none; b=ZAqb5T2U131CqUQ++jTFU/LvRVeWSP5XdEMZIm2s9DJhHbpXcWFrN8riAyqAfBjvCQ3EzfA3l3HgLZ3lgwfMmamjBusNQmencBKiyZFZ910VRaiMva2mDb3Y/KPZs2EGgPwNi/fJtlc/aGeB21QXEadCNwle2u1E3KwrhwLWtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303793; c=relaxed/simple;
	bh=ibk2X5xMifwupme3XLk+QjWD+QzDK5xYtKtQgco38lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSEKd2DDAMzhEhnzr6yj5cqo1uUJnFKpzW/NNrnfK/fnraSMkoc2DJMS1tT2mUbd0hFVfKu7alz/MP3vniOZ5rmglXnYTLbzjHr1GJ1sv1vaHGx+DUJvHyoMYwnmdzwV4F/h0Zm50M4g0J1BcTpbQxHMjLREopoE1IRIFajEl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiyRqeJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733303790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgFpL0B8vjjKyZGWgs2zY9JYUdcih2TCuk31mjSgHYE=;
	b=EiyRqeJqT5XiRQoKP9QGpe/KL0srTmAhFk2HOsd9hZmvyWnkwh2TPHBYcHB9oH+NHeuuer
	jtbffS62bsPNM5TzxxUDbM1ScrLR3cdWIVvHqBwnI6me7X/MlEZPdyduLIplYP40bEMTkV
	z8KRTJOvBxKS2SCczfyL8RZJ819m1EQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-pPg97CUsOWuxBFwe0cLo8g-1; Wed, 04 Dec 2024 04:16:29 -0500
X-MC-Unique: pPg97CUsOWuxBFwe0cLo8g-1
X-Mimecast-MFC-AGG-ID: pPg97CUsOWuxBFwe0cLo8g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so37056065e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 01:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733303788; x=1733908588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgFpL0B8vjjKyZGWgs2zY9JYUdcih2TCuk31mjSgHYE=;
        b=O2oCC0AiWTakWzo0bmtmFzAdPmEvyNkXfbpiL+RFxb1/E7/MJ7Dptk7Rm1TJ38MvXh
         fW1MOn+YHppQ+NYKZXj6xMBBcse3WrG7Qi/Zu1orXZ0h4SUWIbCo3mAlPME3blkpVDMH
         lYiEE1wcXZdV9VJKMl83RAUeMyykgRSwi3lgq3NoDQKq/bB1AxGfWVrM0l9kXAKIuphY
         6Gd9mIk/3SNDeTBkdnP9bZevU95Qgp2/hPMdfpukxmYbNVaFKLkNQALmLBryg1cqaMFC
         ppyQ6a8W1hDYq5/t2XsgtIzBMrEBhLu2r8YtE/CCBN04mqduPFCe8+mdbcgWSJtvaaJ5
         YSVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6y7mTO+O2ZNt2n0kuPtxzGVQrYCBmi9n1/PVG2ESTzqJRQ2NDF3E+Irm6/zW3lL/w1BYBY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gsjUamEEov5nvyuhcvhLGbTVx8Y/ob0oGmi7wTAAhGKshJ3p
	SxrVZ1ES+Bs6YJgfZZPOribeQUyRYZnHENFt5oUXPVJaV9VFGHHAZ3XG/x/lJAo/lez9P7Z6VvL
	4sIPn3Kq8DlCTz+Zay8XHkH5Da3VG4gHlufhOATtZNnHv8upubsfh7Q==
X-Gm-Gg: ASbGnctjR7HHXd3SZSBg8WPC2M/5fO9wOCOByOcwjGZHxsbQbIUVTQyDojVJdYZo8z3
	dwzIFdsP/FL2SPaJQwpWRnnm8sBEheJWONUGi7lTqgS0K4bNc0ot/ZY5Q7tB3KNw1xTM7c1fJsq
	mMo5OkArauxCilXOSXu1yEVi316LWuOteXdZBJ2zHTXVuDoR++s8iatNlyi5U3bG2vh7ymv+CJf
	0bG4AHYQbf4XZyxNQpfPj1WkKtR8UfYbYPlJB28J6IfQdflz+SQr3yTXfzVTm3V7GGjz22wpeLM
X-Received: by 2002:a05:600c:1906:b0:434:942c:1466 with SMTP id 5b1f17b1804b1-434d3fe3665mr27640255e9.29.1733303788461;
        Wed, 04 Dec 2024 01:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK9MD6pk2It8khfwvqfSOyPhVtV7cQT458emg6eJ9NRMu53vk35IjzdEiWXAV6YQQw9CTUhg==
X-Received: by 2002:a05:600c:1906:b0:434:942c:1466 with SMTP id 5b1f17b1804b1-434d3fe3665mr27640035e9.29.1733303788021;
        Wed, 04 Dec 2024 01:16:28 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52aa0b4sm17280675e9.35.2024.12.04.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:16:27 -0800 (PST)
Message-ID: <cbd3f835-0d01-46fa-9125-a0fbd5f50919@redhat.com>
Date: Wed, 4 Dec 2024 10:16:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: remove useless arg
To: tianyu2 <tianyu2@kernelsoft.com>
Cc: eric.dumazet@gmail.com, Pablo Neira Ayuso <pablo@netfilter.org>,
 netdev@vger.kernel.org
References: <20241202033230.870313-1-tianyu2@kernelsoft.com>
 <85376cf2-0c95-4a08-bcbb-33c30c2f2c51@redhat.com>
 <68a6773c.8deb.1938faae78c.Coremail.tianyu2@kernelsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <68a6773c.8deb.1938faae78c.Coremail.tianyu2@kernelsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/24 04:16, tianyu2 wrote:
>> On 12/2/24 04:32, tianyu2 wrote:
>>> The "struct sock *sk" parameter in ip_rcv_finish_core is unused, which
>>> leads the compiler to optimize it out. As a result, the
>>> "struct sk_buff *skb" parameter is passed using x1. And this make kprobe
>>> hard to use.
>>>
>>> Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>
>>
>> The patch code good, but the above does not look like a real name?!?
>>
>> If so, please re-submit, using your real full name and including the
>> target tree (net-next in this case) in the subj prefix.
>>
>> See:
>> https://elixir.bootlin.com/linux/v6.12.1/source/Documentation/process/submitting-patches.rst#L440
>> https://elixir.bootlin.com/linux/v6.12.1/source/Documentation/process/maintainer-netdev.rst#L12
>>
>> @Pablo: after this change will be merged, I *think* that a possible
>> follow-up could drop the 'sk' arg from NF_HOOK_LIST and ip_rcv_finish() too.
>>
>> Thanks!
>>
>> Paolo
> 
> Thank you for the reminder. I’ll adjust the patch format in the next version.
> 
> If ip_rcv_finish is modified,  NF_HOOK/NF_HOOK_LIST also needs to be adjusted. I noticed that many places use NF_HOOK. These modifications should be fine, right?

Ouch, I missed the NF_HOOK implication. Touching all NF_HOOK()
call-sites looks IMHO way to invasive to justify this change.

> However, I found that the ip_rcv_finish function doesn’t seem to be optimized by the compiler.
> (ARM64)( gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC) )

FTR, that is quite an old one :) You should try with gcc 13.

Thanks,

Paolo


