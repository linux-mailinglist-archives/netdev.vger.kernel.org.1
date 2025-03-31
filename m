Return-Path: <netdev+bounces-178289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE37A7665E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0DD3A9330
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B921127D;
	Mon, 31 Mar 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zb1k7fF7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0557210F5A
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425531; cv=none; b=XJqgMOKjt//ArpnrqNjMz89V4eT0GdSvTaRanM7fyBErsU+VF+RXNcW762KkMAYlhkSVsqvQB5H50/csOhjDuZMhEtFDi8NrBPKX2TtXDHNl/Op7lPEqVXZuvvC2tFIfWlm4xlkmia/mffemYB06pW4ZrLGL28L8yJsEAbxFbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425531; c=relaxed/simple;
	bh=Zc0HI/HpPRp4LKMEY0BpJbXpuNHzAcrT5EXAtIL0Yfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNdEf8Qp20STLWHFLXmw5a3eQbPeULv2y1GRxxjee3hpeIMkbRBWpjQQbcD/fzg3scSAndj5x4k0cV5get0eOd4tiTM75X8OGF6gjktDeWGbR/CodBntZIqLmAn6aWjwFOzFIib8VZ7EB1OJ33505211gezaTtkVzNadXTg/V58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zb1k7fF7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso5905372a12.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743425527; x=1744030327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6T65GxNTfj24quUriuBkHJ+dt0mRwDTK5ChQlYE9MI=;
        b=zb1k7fF78L7p2lW8pwD7S9ihYCto8WqhjkRCdivZba8VBtv5RoyVSt44MV4l5NcQ8I
         3mJUUzSof9a7Vvylag7RkP3+YqJt+TXv+/cke+TNwzXWouhwrXWK64Nq5PMxusjU9WjB
         bSejx+Jf1Csp6Y5CD2rMvezZO7dQUHTfE+bVhFZ+AUzXxKRWephW1LrMPfnCnZK8juaT
         HIvW0Z90WU0e7WBMOUzSZyB9SfNKGy2AAB8Dvnmu75ZLq2iba23rslw2qpXZA7YIn2Wo
         /YREvS8JumeNe7ZuwS79bUlONihU41+dvvoRH8mWePZ6d/57J/6AyYhGaKnko70KRfxZ
         Dnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743425527; x=1744030327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6T65GxNTfj24quUriuBkHJ+dt0mRwDTK5ChQlYE9MI=;
        b=ZgAacz//ElL8QCYY0C4dGtH1Vt3SlsswLfyPtWwRZpewJHIUC7oRx2N1dYbYYTl75C
         RRctDoe5ufNznn9WB7YD7gQzRi5IhllhXeqFUclAzylBFiImKiHDm47n+mc6LrX1kQb6
         raqW+GV+p8hV+Fl1fkV4vm1hdDMKkyvDLvmPahmAsO0byjMD31+rqiLLSwiUWeENgREH
         Zaa3HnZt0z6cbVP+lmqj62uyW8sGwZcmhVICmxn6GAWtuKnMwcHCX8ORHkB5qwQ9jNBw
         daID3gYEl/zWNcc2EdP7lzXUXWFjo283Rs5cIMb3oK/KJUKDnUtzq4qnt8OEXcNtJWzj
         Od9w==
X-Forwarded-Encrypted: i=1; AJvYcCW09UKHyxujuhwiYgKgF7qTFwJrXKAxSt7PYYagp6xiE4H0wzOKzoRAdQ3q1Lic5ou7vbTj0go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBv8sfGp/YG5LUkMZT9F+U2dmi6LsahPiUuOgnFPZKSK25jslT
	en9fhINetGDSMla+alvi1gJAig3odcMnxhGiGPE779EFrzIR4jm5LGrDibfp4/0=
X-Gm-Gg: ASbGncua9J8/W6oyAS1t3yoqV+QsuEqIK7psyVPUOahRI5Dzo4aOnqeoSCG5QuZ3xQ7
	PrdE0QTOLBsxFPxxtQ9kP9hgogmBKES7nEP2FQ+iiiqUO7mEZrh9wOnJCrhz56buPEcmyH0B1ND
	FSqQAEKomwSY69ytuNbAIdaBlM9oCynQ89VKKj/yaimy7j5v+etcfFTEAV6qvWNe5dgri89AjpJ
	AmAGycJbyxPCTjAVHVnn7G0gAFPKHYpX3V/lCKH0GQbXCsYkxnIAjwCsneviRL5H/VcOW2BNFaT
	XZIugpSxrQ0SelL9sKsQg2rd6x1FMyZk33lh5Rnr9WsAb9oFyc0=
X-Google-Smtp-Source: AGHT+IFxhdtbJTpnPbhUgLUozMESZ9/aqB70JTwf+Ggby43nXPU4gPgaePZldfj2ATJIUcnPh/2Ssw==
X-Received: by 2002:a17:907:8686:b0:ac3:ef11:8787 with SMTP id a640c23a62f3a-ac738b910e3mr905521466b.54.1743425526894;
        Mon, 31 Mar 2025 05:52:06 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.74.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b150sm623687666b.46.2025.03.31.05.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 05:52:06 -0700 (PDT)
Message-ID: <da181580-56bd-460c-b2bf-16ebb86bbff5@blackwall.org>
Date: Mon, 31 Mar 2025 15:51:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Joseph Huang <joseph.huang.2024@gmail.com>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
 <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
 <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
 <8f51bb33-c5a5-4046-93d6-f58e841256e5@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8f51bb33-c5a5-4046-93d6-f58e841256e5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/28/25 17:53, Joseph Huang wrote:
> On 3/27/2025 6:52 PM, Nikolay Aleksandrov wrote:
>> On 3/27/25 00:38, Joseph Huang wrote:
>>> On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>>>>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct 
>>>>> net_device *dev, int err, void *pri
>>>>>            pp = &p->next) {
>>>>>           if (p->key.port != port)
>>>>>               continue;
>>>>> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>>> +
>>>>> +        if (err)
>>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>>>>> +        else
>>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>>
>>>> These two should be mutually exclusive, either it's offloaded or it 
>>>> failed an offload,
>>>> shouldn't be possible to have both set. I'd recommend adding some 
>>>> helper that takes
>>>> care of that.
>>>
>>> It is true that these two are mutually exclusive, but strictly 
>>> speaking there are four types of entries:
>>>
>>> 1. Entries which are not offload-able (i.e., the ports are not backed 
>>> by switchdev)
>>> 2. Entries which are being offloaded, but results yet unknown
>>> 3. Entries which are successfully offloaded, and
>>> 4. Entries which failed to be offloaded
>>>
>>> Even if we ignore the ones which are being offloaded (type 2 is 
>>> transient), we still need two flags, otherwise we won't be able to 
>>> tell type 1 from type 4 entries.
>>>
>>> If we need two flags anyway, having separate flags for type 3 and 
>>> type 4 simplifies the logic.
>>>
>>> Or did I misunderstood your comments?
>>>
>>> Thanks,
>>> Joseph
>>
>> I think you misunderstood me, I don't mind having the two flags. :)
> 
> Got it. Thanks.
> 
>> My point is that they must be managed correctly and shouldn't be allowed
>> to be set simultaneously.
>>
>> Cheers,
>>   Nik
>>
> 
> Helper function like this?
> 
> +static void set_mdb_pg_offload_flags(bool err, u8 *flags)
> +{
> +    *flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
> +    *flags |= (err ? MDB_PG_FLAGS_OFFLOAD_FAILED : MDB_PG_FLAGS_OFFLOAD);
> +}

This could work, but I have to see how it aligns with the rest of the
code to be able to answer well. Also why not just pass the pg?
Please also choose another helper name, e.g.
br_multicast_set_pg_offload_flags() or something in these lines. You
can check br_private.h for other helpers to get an idea.

> 
> and then from the call site
> 
> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +        set_mdb_pg_offload_flags(err, &p->flags);
> 
> ?
> 
> Or simply clearing the flags in-line:
> 
> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +        p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
> +
> +        if (err)
> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
> +        else
> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
> 
> ?

I'd prefer using a  helper. Thanks.

> 
> Thanks,
> Joseph

Cheers,
  Nik


