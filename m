Return-Path: <netdev+bounces-243002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65859C97F2F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CE844E1E78
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B431B829;
	Mon,  1 Dec 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTmeSQeU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C22305043
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601435; cv=none; b=TfViAdC8puCkiqBNKudODCWWioNWWzCZCX9fNm/dsNZlhV20LC3apTF+E/EtWEzImHezp3hr3UgkJF48FqaGNEXi3TlNoNMRcGmuFFWZIJRKPgZLLzs/mTE8LT669ZAhXW27FHWkMdlg3JHYJB7M9hOtBwXeT91FoMluIKRcs2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601435; c=relaxed/simple;
	bh=EXzDcH+w5Jl6eGdL/1XTbFsMDWschXz87blxBSftkBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/Y7673RWu31HrUgnG2/Kb+jU3fQAkU+q8qkoo8ClFeTscIKCFxl46Lh3Z5qsNrn65Y1rMPc4M4UOTSsxGK74B1gaBvQ5jJS5m7SEef7r0GweIjonMQIW/UrcXyDXACkacop4sMKAFx97rELbG1uFlusx/srGsdz5pVjA8wT9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTmeSQeU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so3787003b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764601433; x=1765206233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpw8LHvPdU6zlHMAMXTfZPDQrMbxfwldCPC5wqMja1s=;
        b=mTmeSQeUZ0NrsnUYmshCon0vaDA5QJpjJ1fpawYxxKzT9Uv7wl3Ufi6yagGfTciolq
         bfg9n+u/MViOgORULSRBWSPg99vIJe89NEAFNafQ7JMbpcF3UTzLnv8jR/paHRr3bznJ
         0lxQfb5J520sr1CGeY5B78PzEc0EhqoHKGy+7zIwEMG0lGS0+FnxQLH4eT9NLhhIH2BN
         3vsYriktRFP5Hb6EW0QncZ34gJOWKVtu77Cy3ymoQAXiXUgjm7X4UT3bsyIeK1vpWSNk
         Mfbe6mXY69IIwgB0R8FWckc+pbqRa215ZYfY6C/oFQBkAVzJ30dEMKQG/NC+EmG01r6T
         eURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764601433; x=1765206233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpw8LHvPdU6zlHMAMXTfZPDQrMbxfwldCPC5wqMja1s=;
        b=itarl6Kaek+iNlKlxGFyHDl/uounKC7Yh/OgdabxXr4Nfi72II+1h9t4tLQfoP6RPB
         fcAbXoCAS1qtaLkxAqUF3VjoAgQJgaaCfTHmhHM7tL4ztuH+qmOgJW3YFr+bGf5T6etc
         95zgMK+PhjJKJwU/2O6Mz4FtDWh1L5dpp2EPaL/9/cZftwbhbaypmz/6Wnjrx8pQYtjO
         J/EydeX8QsXXSSNRjrZQiXa/RZg5YNFvIWfijPvWBYZ+YS07OSYAYg2QCwbFFjpcnTnv
         ytyoPxrqZgupThSzElqSFzT74qeJ6e+FG07T8zSxOLcU0m1IRykGVOVAvF/imbBN5V/3
         4AdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtkaeIqHLRX7XBifk8gYyX8FD5iCc8lRLdp1Xh06+ayNv0TBY6Koho1OX8m12xof+OBq67P/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKZ2dZF7lhW7J7av5lapR47Y/xBUnPp4Uz6VeUV6LvXoeBqer
	LtQYq7PqdqCKnNf5cRzvSkw0NC4yXcqllsw8XMu1D8ygYIql1VPvt5Mx
X-Gm-Gg: ASbGnctGus96qUx2tNdTvTrUayRq4O6EefINbP9UAThzc6H3v58cH7nZpbgytHywbWR
	nrxH5wkj27AjmPQ4hPIPLrh5Yv9gg+o2vJOQuE4mG6ZkvCgKsb0S2qM8vyQoGSqBHaw32UzGFg6
	ucGAYn6aBbxELFoLKAZp+gGWQlU0yeylP5avJMQYySQRkqewAZepBisYt7rJUQgd+0yzpPtuvUx
	JHXtJMXBSb88CGq8yTxKdPdQFfEh5Pj0qXhQEDdP5am0h74lRRFM5fefoRBiRuqNnCKEmA4/Y2/
	l4br6UqUj7HWHUbt4Y8oGWL2zgpfIbrGq4cQHJF49OtWjsJEnWQlzxWgVJLD7/BYoqAzZAffm6S
	671XEbamzwoUy4COc+Iz4SyVynFnp60+4W128HiEgqfOlLmAfJng6QK90QsDRvd8bRa8uPPnSV/
	R1hmfQ8y9l92H2927LQXlF0iYMwnSsK5GqyuUE8dj3e2iatHXnsJtRGS36xkVIYw==
X-Google-Smtp-Source: AGHT+IHmv0QxInfFB/jZapSApAINRmF451TKrxhW5iPzZqBDqwn6NRIZ2O7dcTdimLEG9yOOxzaRZQ==
X-Received: by 2002:a05:6a20:548d:b0:2d5:264c:e4a1 with SMTP id adf61e73a8af0-3637daaa237mr27333954637.8.1764601430946;
        Mon, 01 Dec 2025 07:03:50 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:adfb:c7fd:bfdc:f0bb? ([2001:ee0:4f4c:210:adfb:c7fd:bfdc:f0bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1516f6621sm13760828b3a.16.2025.12.01.07.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 07:03:50 -0800 (PST)
Message-ID: <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
Date: Mon, 1 Dec 2025 22:03:42 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
 <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/25 09:20, Jason Wang wrote:
> On Fri, Nov 28, 2025 at 1:47 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> I think the the requeue in refill_work is not the problem here. In
>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
>> will disable work -> flush work -> enable again. So if the work requeue
>> itself in flush work, the requeue will fail because the work is already
>> disabled.
> Right.
>
>> I think what triggers the deadlock here is a bug in
>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
>> __virtnet_rx_resume() which calls napi_enable() and may schedule
>> refill. It schedules the refill work right after napi_enable the first
>> receive queue. The correct way must be napi_enable all receive queues
>> before scheduling refill work.
> So what you meant is that the napi_disable() is called for a queue
> whose NAPI has been disabled?
>
> cpu0] enable_delayed_refill()
> cpu0] napi_enable(queue0)
> cpu0] schedule_delayed_work(&vi->refill)
> cpu1] napi_disable(queue0)
> cpu1] napi_enable(queue0)
> cpu1] napi_disable(queue1)
>
> In this case cpu1 waits forever while holding the netdev lock. This
> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
> NAPI enablement with netdev_lock()")?

Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed 
refill when pausing rx"), but it has flaws.

>> The fix is like this (there are quite duplicated code, I will clean up
>> and send patches later if it is correct)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 8e04adb57f52..892aa0805d1b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3482,20 +3482,25 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>    static void virtnet_rx_resume_all(struct virtnet_info *vi)
>>    {
>>        int i;
>> +    bool schedule_refill = false;
>> +
>> +    for (i = 0; i < vi->max_queue_pairs; i++)
>> +        __virtnet_rx_resume(vi, &vi->rq[i], false);
>>
>>        enable_delayed_refill(vi);
>> -    for (i = 0; i < vi->max_queue_pairs; i++) {
>> -        if (i < vi->curr_queue_pairs)
>> -            __virtnet_rx_resume(vi, &vi->rq[i], true);
>> -        else
>> -            __virtnet_rx_resume(vi, &vi->rq[i], false);
>> -    }
>> +
>> +    for (i = 0; i < vi->curr_queue_pairs; i++)
>> +        if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> +            schedule_refill = true;
>> +
>> +    if (schedule_refill)
>> +        schedule_delayed_work(&vi->refill, 0);
>>    }
>>
>>    static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>>    {
>> -    enable_delayed_refill(vi);
>>        __virtnet_rx_resume(vi, rq, true);
>> +    enable_delayed_refill(vi);
> This seems to be odd. I think at least we need to move this before:
>
>> +    if (schedule_refill)
>> +        schedule_delayed_work(&vi->refill, 0);
> ?

Yes, I think helper __virtnet_rx_resume does not work well, because 
virtnet_rx_resume_all and virtnet_rx_resume have slightly different 
logic. So I think it's better to open-code the helper and do the logic 
directly in virtnet_rx_resume_all and virtnet_rx_resume.

>>    }
>>
>>    static int virtnet_rx_resize(struct virtnet_info *vi,
>>
>> I also move the enable_delayed_refill() after we __virtnet_rx_resume()
>> to ensure no refill is scheduled before napi_enable().
>>
>> What do you think?
> This has been implemented in your patch or I may miss something.

Yes, I move the enable_delayed_refill after the call __virtnet_rx_resume 
in the above diff because I see it creates a window where delayed refill 
is enabled before napi is enabled. However, AFAICS, other places that 
schedule the delayed refill work must acquire the rtnl_lock and/or 
netdev_lock, so it cannot happen while we are in virtnet_rx_resume[_all].

Thanks,
Quang Minh.

