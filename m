Return-Path: <netdev+bounces-156732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C7A07B26
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E4D18872DD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773413BC26;
	Thu,  9 Jan 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8BpYmIf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA421517A
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435204; cv=none; b=KtpGNs7ffJ2Z1DsACYti6kzElUp7hLDh7o0CmbiaXU8HAqiqux/4Xos+O16JUMnpUNHSn2hvWOHoiKqdXx1oAO64W26I+o1U4fAMtJiarK/FDySTr1nYArHKUIoi/2q8Swrz6oOLSesn0RsQBI7H7u/onPmBH89YGY6wCSBvV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435204; c=relaxed/simple;
	bh=KGbI5pPhLzNCM9VEkBDwt6zaLBtDufCoMPl6NgkguZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrtQxeVwA6buKA8634TF4VavlVTmuPfY+/AtGotN1wxKPKpjaGfoU6rc9b87sJMAuArVy9eG3yTyj1m/zi/zrFtMy79VntRpjLhX84TrNqyIn7HZEwlBIbaNkyKnDOEmt5pwTLRIu7XCo1Gy4j+xbolulqexP123nam+O1pP4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8BpYmIf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736435200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzcRoRMpLXdkB7rzsc91g4b2b0MisGJnEZzQL6cNwJI=;
	b=i8BpYmIfPPzbz+qrtxrfFmjUGEAdIT2tqBhOeYgFEJvukr5HAFsliSA1WL1+vcD6pqTXGs
	NEbd0H9z+jlhWOEVEAG5re/ib33wTmb5NB/4OVNIc0DaysmUpHdfor7DjBjyHRKUSh4LsQ
	HE/sAUCD7XYykFAp04DY1LozXR6TTRs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-oheYxFBOP1egVCSzacZxow-1; Thu, 09 Jan 2025 10:06:39 -0500
X-MC-Unique: oheYxFBOP1egVCSzacZxow-1
X-Mimecast-MFC-AGG-ID: oheYxFBOP1egVCSzacZxow
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so5756115e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435198; x=1737039998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzcRoRMpLXdkB7rzsc91g4b2b0MisGJnEZzQL6cNwJI=;
        b=U6xmKcJZbDgbN4mWvvgZIBp7ygQugfSQistFmRsvFpOyiuo+5blOoPShFUecw8Hd1D
         XQBItvKmbtSlA8NQR6Lmp8jmyCnBJg3aeYRDtoLgwOdlDizSfZB6LCZkRipHibHQDBwY
         H4oOy5BZ3M17fM+/z35ec6YSCAP/d9PnMDwOvJjZHi5YQkZVM8FMitJ3O/hKO5fxfsrs
         EOV0fQkBoBe8Ng+F415MZX1QouZw2+IElSK62smFXpvLfji+NSieZDJyaKvqeo0mOWPy
         50wVEdISuRRwRmyu0jDUjeUycR0pkxOqj9R9eTWTx3iGwfkZePHF1gRtRrXx9s9c668w
         iacw==
X-Forwarded-Encrypted: i=1; AJvYcCV16vjSzQ763KuuubFHGnxLFp91rHYsf4cy1h4W/Iuy1VzhR/gbSyGDGDIfrvi0v5fKiBsI+kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBBUG72E8ENda9fRuaFtVddbyQs4K9/XYZlCHm7acpMIHwlvh
	+P5nCAEvFrxR/S/ztV5eREbWtl1eQ3oVk92KvNcBurp1jCIk/wYmmkNZk7Qr2FuyiXiHcYsJ1P4
	S/qcdlVL8beG0036SBxQ39Hh8Z6bPwqCpO33g1IULHPwtwI73HbOsiw==
X-Gm-Gg: ASbGnctrfoIPVwr1Xn+05SJskNEtuRfYftE3BB4rLVCaLYX2nYsVis2TwG5ST57Wmfp
	0/sq59NnYua+zmkPuy2dWcXDrgDMMyLT8u73Y3wreDVXGNa/A3wkiz73rubKzK4YYvSI0nu8jvB
	F2bGn9RRHAZxrDKY1cnvV+gTG1/euo9bfcL2/KQdWCHOSr6FHGmae95TfYuQ3+1Q+sybfBEXB+b
	CPqqMmaEl5Zyy1MTLtKPZxdTZIp4UHIZ7WE+e6JGAex6lXI6jTXm36rxjXbExcQ61yhCmVz/n/Q
	jlkRVi9P
X-Received: by 2002:a05:600c:4f4e:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-436e26935cbmr44133945e9.12.1736435197657;
        Thu, 09 Jan 2025 07:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4fqEltbHoSuDNDTp1SE8zUB62F/bzYqQ5DX0WgJpNw0B1w2i4HNjw+Zz7/wY/VcFCtkUvA==
X-Received: by 2002:a05:600c:4f4e:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-436e26935cbmr44133285e9.12.1736435197100;
        Thu, 09 Jan 2025 07:06:37 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89de4sm57384505e9.34.2025.01.09.07.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 07:06:36 -0800 (PST)
Message-ID: <11915c70-ec5e-4d94-b890-f07f41094e2c@redhat.com>
Date: Thu, 9 Jan 2025 16:06:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk
 flow fairness counts
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
References: <20250107120105.70685-1-toke@redhat.com>
 <fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com> <87plkwi27e.fsf@toke.dk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87plkwi27e.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/9/25 1:47 PM, Toke Høiland-Jørgensen wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>> On 1/7/25 1:01 PM, Toke Høiland-Jørgensen wrote:
>>> Even though we fixed a logic error in the commit cited below, syzbot
>>> still managed to trigger an underflow of the per-host bulk flow
>>> counters, leading to an out of bounds memory access.
>>>
>>> To avoid any such logic errors causing out of bounds memory accesses,
>>> this commit factors out all accesses to the per-host bulk flow counters
>>> to a series of helpers that perform bounds-checking before any
>>> increments and decrements. This also has the benefit of improving
>>> readability by moving the conditional checks for the flow mode into
>>> these helpers, instead of having them spread out throughout the
>>> code (which was the cause of the original logic error).
>>>
>>> v2:
>>> - Remove now-unused srchost and dsthost local variables in cake_dequeue()
>>
>> Small nit: the changelog should come after the '---' separator. No need
>> to repost just for this.
> 
> Oh, I was under the impression that we wanted them preserved in the git
> log (and hence above the ---). Is that not the case (anymore?)?

It was some time ago. Is this way since a while:

https://elixir.bootlin.com/linux/v6.13-rc3/source/Documentation/process/maintainer-netdev.rst#L229

[...]
>> dithering is now applied on both enqueue and dequeue, while prior to
>> this patch it only happened on dequeue. Is that intentional? can't lead
>> to (small) flow_deficit increase?
> 
> Yeah, that was deliberate. The flow quantum is only set on enqueue when
> the flow is first initialised as a sparse flow, not for every packet.
> The only user-visible effect I can see this having is that the maximum
> packet size that can be sent while a flow stays sparse will now vary
> with +/- one byte in some cases. I am pretty sure this won't have any
> consequence in practice, and I don't think it's worth complicating the
> code (with a 'dither' argument to cake_flow_get_quantum(), say) to
> preserve the old behaviour.

Understood, and fine by me.

> I guess I should have mentioned in the commit message that this was
> deliberate. Since it seems you'll be editing that anyway (cf the above),
> how about adding a paragraph like:
> 
>  As part of this change, the flow quantum calculation is consolidated
>  into a helper function, which means that the dithering applied to the
>  host load scaling is now applied both in the DRR rotation and when a
>  sparse flow's quantum is first initiated. The only user-visible effect
>  of this is that the maximum packet size that can be sent while a flow
>  stays sparse will now vary with +/- one byte in some cases. This should
>  not make a noticeable difference in practice, and thus it's not worth
>  complicating the code to preserve the old behaviour.

It's in Jakub's hands now, possibly he could prefer a repost to reduce
the maintainer's overhead.

Thanks,

Paolo


