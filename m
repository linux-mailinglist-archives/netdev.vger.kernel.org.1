Return-Path: <netdev+bounces-242334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A2C8F4D9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C65C934CD7E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199BB337B9B;
	Thu, 27 Nov 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwndbZXb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6t5heAL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF03370EC
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257569; cv=none; b=RI4KfugWd+DJcD7/vIXIJmYoeQutuJlgZcVtfvEhlK634yT1woa3F1DjZD+hXyKXNoDv32J8MpILDZLpEc65w0+VVFEgQyUF0X8izVN80dfmDu45HYX3g9myXIvoqbCcaU7BPPhhK4T6ie4ybF2AyxcW2IjMpmX1+KVMJMZx9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257569; c=relaxed/simple;
	bh=xwWpsPu/p2TXGFyfS8pKhNxXZyonEZYzpGiCi7j/KIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldQkMGMy+uzWTmrJu6LyWfA24Qln9vg1jZ1ICkE4gvGZGIQ6o2W8RALeZ2DZyJrspUyKdNmK0P52z/0uIYGx6uNQ3hAedfj2cjWYutvvFrkNLfHRb/ZCHZqKAUdCybX848umbEaTsIUZ5jthJjBOPcMBysA9z5ydCOxkdEHxFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwndbZXb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6t5heAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764257566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+GkUi07d4ou28wY1RAuasUKgt2dm0TVZWT+hGEKfC0=;
	b=AwndbZXbHDSd0E4xOCVT8VIB38cjR6ilC9pZ/QMMeGNVRn2y+5esq3ahKbApLufwCSKw9g
	yPqRG5jC0pJNf6/e3W5u1+5v6nX3A7mpMHOtt1ojZkQmO6EA8SJ58sBVPQBps1nAjM7Cyf
	zlzsE/+Z/Zq9ynJmyL35BrO0mBrgBx0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ySpmFvaKPFCu-eDGiC8Teg-1; Thu, 27 Nov 2025 10:32:45 -0500
X-MC-Unique: ySpmFvaKPFCu-eDGiC8Teg-1
X-Mimecast-MFC-AGG-ID: ySpmFvaKPFCu-eDGiC8Teg_1764257564
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47788165c97so6458785e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764257564; x=1764862364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+GkUi07d4ou28wY1RAuasUKgt2dm0TVZWT+hGEKfC0=;
        b=G6t5heALUxLuC5YQBg2RFNoiJZvW0AMdYHBcLdrDA+nzYdRANojH6yLu2mascCQ+VY
         5VnvMk6y/LTq45o1Fpo/fpjt3rahkCDRMdM3ig42ZXMl/0TbkUG+go9IHb1/b8OEspC9
         025f/pfp6SIK5Ctc0v4+FurCrkBCOOZmWc1OGPEglCwvik4eTZ7s5dTi64HBxjoK6pjU
         QMUzE1E7JA+6G0mIsQMIuxazJ7GUVcxBCK+h1YAPwPkmJilta/TNExSOmTfL5p+DSdOu
         uNxxC0XFW+cmEqj8JLqWGQ1AVYFfxBqosyO+QlBayEZpL7OKFjLHKH4Wi0JVNo7G+GPG
         tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257564; x=1764862364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+GkUi07d4ou28wY1RAuasUKgt2dm0TVZWT+hGEKfC0=;
        b=ISmvtEXJsxKQd/KuS7GcujlWGAKvEKI7SiXpDU7z/9aoJUNcOa4TVk9sQEoT5YYIJd
         HVwFFOTiLcfRMap+FqL65uwHyPrAnTA8niUGYuDNJgTzhmqYUEif1/2oCqiRTyVF9gCl
         4qOItwlmdYUtE1A9yFEPTDsxhI9MukByOSKt9CPcibYeg7U3B0oMtBmKhvqfeb8NbNv6
         6gv+ANOX4m0fVmxUOMHrbjRB1mqYzDW8qn2mcokiotdqT4guYzSbtIRw8apkEV694hfD
         Ai3t+duKh+SSwVCOd7zDqvcj8pfxFonTpuO+xmsaUx8qlfxqcDkYTroaF5QXNbX69vdT
         N6tg==
X-Forwarded-Encrypted: i=1; AJvYcCU7wN9Ux/qxBnH+L8KJMg8UCTjOknGjNZF7OjzyVjesUQQQQjQ43t1zB66/oInv93DYE3XDJH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBv+hep05KuS58DO7JNddjxZ/7ZOgXi1EcIHJl3Sh8RS4WqiX
	T01p3dBDAj5pJxtXeSWzU12VxLKBLI1Hcd1vd5cyT3XIx1e3WL6nAzcNEOb/5zmrA66WMn1i+qc
	NddfTupMyLjNG0t5KXmFMKpBi6sotWtvtEqM/2btqsjRLYn/nKMre47Fnrg==
X-Gm-Gg: ASbGncsghIN3tMObyaaWaq3f+Bz81M4bOX55+9jOx/CSppXXYX3tZo3JjndqT/Cu9w0
	osBE2pi+k6lMVzNIstyDeyHDmuNzVwdqCghS5XuPn7mLttnvdNouThGwq76bQHDL6ovmQQ4jvbe
	gYAtundvnuu1179BOmXOfj9rMLI/ddWj/qIvw2XQkHJOz+4a7ATF1AqUYPmHV19D3Q+hGhE78+K
	HWhlssnGTjbC+49TvwCWt2hFXEb21K/oKIfCNZlDkhOI2WF/SCb7f6vvzejIZSyVXSCXtT+pQX1
	kanG8aQqu08JpdRfVxEl6shgxYAn0Ejpu6QKWpepCMsibJ16JBrwToqP2wg6Q0q1WYFWTd9d1R0
	Mub26e+gVZZ7wcw==
X-Received: by 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-477c01c001bmr287759575e9.24.1764257563599;
        Thu, 27 Nov 2025 07:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgKL4NpJlfgAXWy2V91NL1cZHR73ojsGcmF1eX6oiBCPiBiIVYB93AIsjchnm+PuI1k/NaRQ==
X-Received: by 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-477c01c001bmr287759265e9.24.1764257563187;
        Thu, 27 Nov 2025 07:32:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47903c7360fsm75115715e9.0.2025.11.27.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:32:42 -0800 (PST)
Message-ID: <f4ca72ea-e975-431e-9b7a-e32c449248ca@redhat.com>
Date: Thu, 27 Nov 2025 16:32:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-3-kerneljasonxing@gmail.com>
 <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
 <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/27/25 2:55 PM, Jason Xing wrote:
> On Thu, Nov 27, 2025 at 7:35 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/25/25 9:54 AM, Jason Xing wrote:
>>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>>> index 44cc01555c0b..3a023791b273 100644
>>> --- a/net/xdp/xsk_queue.h
>>> +++ b/net/xdp/xsk_queue.h
>>> @@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
>>>       q->cached_prod -= cnt;
>>>  }
>>>
>>> -static inline int xskq_prod_reserve(struct xsk_queue *q)
>>> +static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
>>>  {
>>> -     if (xskq_prod_is_full(q))
>>> +     u32 cached_prod = atomic_read(&q->cached_prod_atomic);
>>> +     u32 free_entries = q->nentries - (cached_prod - q->cached_cons);
>>> +
>>> +     if (free_entries)
>>> +             return true;
>>> +
>>> +     /* Refresh the local tail pointer */
>>> +     q->cached_cons = READ_ONCE(q->ring->consumer);
>>> +     free_entries = q->nentries - (cached_prod - q->cached_cons);
>>> +
>>> +     return free_entries ? true : false;
>>> +}
>> _If_ different CPUs can call xsk_cq_cached_prod_reserve() simultaneously
>> (as the spinlock existence suggests) the above change introduce a race:
>>
>> xsk_cq_cached_prod_nb_free() can return true when num_free == 1  on
>> CPU1, and xsk_cq_cached_prod_reserve increment cached_prod_atomic on
>> CPU2 before CPU1 completed xsk_cq_cached_prod_reserve().
> 
> I think you're right... I will give it more thought tomorrow morning.
> 
> I presume using try_cmpxchg() should work as it can detect if another
> process changes @cached_prod simultaneously. They both work similarly.
> But does it make any difference compared to spin lock? I don't have
> any handy benchmark to stably measure two xsk sharing the same umem,
> probably going to implement one.
> 
> Or like what you suggested in another thread, move that lock to struct
> xsk_queue?

I think moving the lock should be preferable: I think it makes sense
from a maintenance perspective to bundle the lock in the structure it
protects, and I hope it should make the whole patch simpler.

Cheers,

Paolo


