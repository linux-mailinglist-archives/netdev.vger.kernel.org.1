Return-Path: <netdev+bounces-234980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A5C2A998
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA293A2002
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73BB2E228D;
	Mon,  3 Nov 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbPSugoH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FC2E1C4E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159305; cv=none; b=SrhdrvgMSMoJNyEOPZY6D+SRUr1ek0d0kwU3KxzYy+RONlIIgwaY/0ZNAw9tYwjGubxLvkrgrBzLMXAh/1aSaXJ2bt5jsH3uuCKxHvc399wZ+RLsXEh3csPuIOhNJ9ujY4/yEg+b36GHZc0LUgxt3l9x2Q1OJjYs+uXvROoNsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159305; c=relaxed/simple;
	bh=S54nXXo/aFrvMC7QiuJUF89PwUrNEP2rWkjH7sjr3UQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ndeX+RfdTY1VvhscJBj+6N6ruZE4acefbyEtG9SnfNgK6EnOh11mwSvaF4t7AdygFib8TnSqEAeNsRYMHbLzsitjX3ArwjJ0aRvI7gqaJ3cHR6p4PHbF6v7Zm5xvWSt1t7BOqilR7wPZB1o8had10jCuZCL2lpnAvgvvOT3QXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbPSugoH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-794e300e20dso4094250b3a.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 00:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762159303; x=1762764103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9IlYd8PBv158GdcOw6rn4rqU0pymAVgCcTAXsADiI14=;
        b=gbPSugoHdSCeMmpTd+jHuI8rJyR8vNuPTK6wYW4DH1RiQYNUFx0/znQpX9bAChVbWF
         roXpw9EHzdff6UPY0GqhwLYxeBDygVt5PxXv1sZGikscpiLXmEdllwUQfSbxMeJ8nhf4
         6xa1CuGihra5zD+fuLEsdespU1jubzery4pgCIECTg7B064Oj6Y3vme8s/GmcxBj5CSU
         hVcQ1CcHO7VckrHXDDTfkGdqgoOq8hxU/QNsmUuXSp56J+XbIS3kTn7N/LQSgSHTSo5U
         d/GlF4nXVeGxkRxTx6GrkT+mNhs1Gn6WkWNPMFS1/DxoMaAkbjae10h5ORkj0D1043Hb
         zSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159303; x=1762764103;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IlYd8PBv158GdcOw6rn4rqU0pymAVgCcTAXsADiI14=;
        b=o/MIo5TyT+ZDZQfILgeD3g4tEFLxCyNRPoNTQGYAxvvD+rKamZpU/smsFDiasoZ82P
         SYIbmbO7TW7rxGzR/w87rr8XeE7XXEv5BwWwLtgOfdd6U+6MYVzycV90niDpphh17Xnp
         tJKRexKDA94octjXOpFI1i0Rr33wruLzcKElNrGHQrSiKPtdkLIUBBQ0UuwhyapFmMn6
         rxs+UHSxx5utN9wqPcfrPsqL8zWk4G9Ba4I5oacJmLZK5YpgbyEJYbvjVk5bzIKigGpF
         Nxf6Nv0TsAtGLdlrZAjRNVVagXOQPogR3aeSDCRzOBe2YS3s3eGl6Z9Zi6IRGxvDpBb8
         sIIA==
X-Forwarded-Encrypted: i=1; AJvYcCXVuMQxuwk18AvGTKn/8Gzdm3cdZ2HvhbNU/Cd9cth4XCdDbxSpGKPV+OF2QlAHRtKJT/2T+QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymB5vD9GpfPRmMHv9gJEJb+vWBsxaYsgE1Z//LdzU/8pJ7aCWK
	lDxGti3GQAcF9ZoZjVMK1n3gwYHsDdfxdEOJDuS60x5zZT5bN4RR5Rnm
X-Gm-Gg: ASbGncst3UXVkKAghkdCWpW56aOFy+9RNIpX1eXZpmLLwsMAv52nWhvZNI3/MIUZ2Zk
	Abj/RpOM95nuIR7c5siqCgrZTDt3Y4D3t0S9jdMSxHtMXTohOQvAymoXdwKZGQD93Ke3xUtDRZ3
	eGjTE6JStvvggUleN2HR0k5jiA5Su7UlHfJV2RYB7HK9EfgqtsEfsIdTEqKStNVOPoFJK3HdzPv
	eIOVFYh/PY0QyiaNGczXf0LOKKP8l7/rzExdiV+AqTIqClTShDncFcjEuy2+wWd636cYYZu68hT
	DktWIi8FeiZhXplvisoan04e/4WZ08b9tjbrpwm/4VqsStIHLKB1NAKFjoWPoLaCDt0yoACKYK5
	C32ioLmD6I+wvIpGawfJ9vdMjwZz+PE4zqD+qRsHAVxGmRHZjUjdADA9OVlgLbsekfQDwWec60G
	GvBV6alLNnMcPl5E+y9Nc57Uag/7rNCRp12WT89A5Z+Tqwd0YqKHUTJVN+/mHPY6CPWeoQ+MfHU
	eheR0MBFMQ=
X-Google-Smtp-Source: AGHT+IHVqhieNuVGLPgUB+hpjN6Vf9ZUu7T1hKfxCCQidwT8I97GOgul3IVD0bS7e1uzQqBSFCZNtw==
X-Received: by 2002:a17:902:d4ce:b0:295:6b98:6d65 with SMTP id d9443c01a7336-2956b986f84mr76085715ad.22.1762159303320;
        Mon, 03 Nov 2025 00:41:43 -0800 (PST)
Received: from [192.168.99.24] (i218-47-167-230.s42.a013.ap.plala.or.jp. [218.47.167.230])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2952689f15csm110200325ad.29.2025.11.03.00.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 00:41:42 -0800 (PST)
Message-ID: <8b70ba1d-323b-4e76-be7f-9df45b8f53d5@gmail.com>
Date: Mon, 3 Nov 2025 17:41:37 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
 <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
 <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
 <4aa74767-082c-4407-8677-70508eb53a5d@gmail.com>
 <e3abd249-f348-4504-b1d9-4b5cd3df5822@kernel.org>
Content-Language: en-US
In-Reply-To: <e3abd249-f348-4504-b1d9-4b5cd3df5822@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/10/31 4:06, Jesper Dangaard Brouer wrote:
> On 29/10/2025 16.00, Toshiaki Makita wrote:
>> On 2025/10/29 19:33, Jesper Dangaard Brouer wrote:
>>> On 28/10/2025 15.56, Toshiaki Makita wrote:
>>>> On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:
>>>>> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
>>>>> about to complete (napi_complete_done), it now also checks if the peer TXQ
>>>>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>>>>> reschedule itself. This prevents a new race where the producer stops the
>>>>> queue just as the consumer is finishing its poll, ensuring the wakeup is not 
>>>>> missed.
>>>> ...
>>>>
>>>>> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>>>>       if (done < budget && napi_complete_done(napi, done)) {
>>>>>           /* Write rx_notify_masked before reading ptr_ring */
>>>>>           smp_store_mb(rq->rx_notify_masked, false);
>>>>> -        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
>>>>> +        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
>>>>> +                 (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>>>>
>>>> Not sure if this is necessary.
>>>
>>> How sure are you that this isn't necessary?
>>>
>>>>  From commitlog, your intention seems to be making sure to wake up the queue,
>>>> but you wake up the queue immediately after this hunk in the same function,
>>>> so isn't it guaranteed without scheduling another napi?
>>>>
>>>
>>> The above code catches the case, where the ptr_ring is empty and the
>>> tx_queue is stopped.  It feels wrong not to reach in this case, but you
>>> *might* be right that it isn't strictly necessary, because below code
>>> will also call netif_tx_wake_queue() which *should* have a SKB stored
>>> that will *indirectly* trigger a restart of the NAPI.
>>
>> I'm a bit confused.
>> Wrt (3), what you want is waking up the queue, right?
>> Or, what you want is actually NAPI reschedule itself?
> 
> I want NAPI to reschedule itself, the queue it woken up later close to
> the exit of the function.  Maybe it is unnecessary to for NAPI to
> reschedule itself here... and that is what you are objecting to?
> 
>> My understanding was the former (wake up the queue).
>> If it's correct, (3) seems not necessary because you have already woken up the 
>> queue in the same function.
>>
>> First NAPI
>>   veth_poll()
>>     // ptr_ring_empty() and queue_stopped()
>>    __napi_schedule() ... schedule second NAPI
>>    netif_tx_wake_queue() ... wake up the queue if queue_stopped()
>>
>> Second NAPI
>>   veth_poll()
>>    netif_tx_wake_queue() ... this is what you want,
>>                              but the queue has been woken up in the first NAPI
>>                              What's the point?
>>
> 
> So, yes I agree that there is a potential for restarting NAPI one time
> too many.  But only *potential* because if NAPI is already/still running
> then the producer will not actually start NAPI.
> 
> I guess this is a kind of optimization, to avoid the time it takes to
> restart NAPI. When we see that TXQ is stopped and ptr_ring is empty,
> then we know that a packet will be sitting in the qdisc requeue queue,
> and netif_tx_wake_queue() will very soon fill "produce" a packet into
> ptr_ring (via calling ndo_start_xmit/veth_xmit).

In some cases it may be an optimization but not in every case because it can 
prematurely start NAPI before tx side fills packets?

> As this is a fixes patch I can drop this optimization. It seems both
> Paolo and you thinks this isn't necessary.

I think it's better to drop (3) as a fix.

Toshiaki Makita


