Return-Path: <netdev+bounces-243194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787EC9B3A1
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FC824E2021
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D4228506B;
	Tue,  2 Dec 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L73OeXPm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfY9Z6So"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941B30CDBE
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672735; cv=none; b=mlScqf3sx/vyie2JSgsi/iKNAloZF1VfaSxJ+cFSfCXtO21iklu5uIxyZyhDHUlCncmdCmZJdUMjwGiIUFAd813J9frcyuKJ1o4x/zZh1C8RJTQk7TuPAWzPgfBHS11DJmgNPHAReCovn/EgFnl2v0okP6a/fJ1h0L4t8llnars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672735; c=relaxed/simple;
	bh=GIQeF0jmFXqExxjXJyiy2TdUikFM6nsxXMzGDatFXJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhcDkWZ9fXHigJdX11ZDNdbH49TBlnDMU+6TtXsbT/WvejsfQ2RMIEqvb7yEYcTADNZT4GRhQQnZCnULzowOV3DM+uUCpp871hTB5TMObGlC/JJWO3nYB1CAinlRd8M8ExNnJyhrS59YzEDn6qk6+cYX+khmSxO6ORN/ZW9R/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L73OeXPm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfY9Z6So; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764672732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmhfHrPQTFVWagp2s/Ebbdc6h6Z/4SsYa6hWCM83C2E=;
	b=L73OeXPmwh6z6iHTyN9bYMxnxQCSll/lP1CYi8UZi+INgshvZv/PoDnl7b5kIJU7F34qvl
	goodB9FlgO/jYJYufzSg1j6ToHIKcDe9LHZej781Uz0+tXc741a3Q+mvlefVNPdq4KQ+gS
	qEVz2pZzYedCxWoxv2CAN8eqJMo89ao=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-PDk8kZmUNZuHVTwBzAOCpA-1; Tue, 02 Dec 2025 05:52:11 -0500
X-MC-Unique: PDk8kZmUNZuHVTwBzAOCpA-1
X-Mimecast-MFC-AGG-ID: PDk8kZmUNZuHVTwBzAOCpA_1764672731
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e32e1737aso5887590d50.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 02:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764672731; x=1765277531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmhfHrPQTFVWagp2s/Ebbdc6h6Z/4SsYa6hWCM83C2E=;
        b=FfY9Z6SobtuJfwWXJqmX+Dda09ViuYcrglzhY4qt8RttvDM5iIGSbCXbJHvdQRZ24E
         3I0c8LXIdA8vZK3nuyj0+Amq6e0/fdCyEP2tuha2M7Ewmn0Gw2KwiIUL+qrVOF+JSbt3
         m1wCYaiEQhB4JxXRU8cKRk5MZ9fhG9+j6hmTqmANNfJfwdcEtz0KDMBdu/vfDCVTm3+9
         BmdhxvgEXgafUj1MxfmH47F8/5vS6QxPDRnu6VXbUx3Gh5ZNiF85OzbLHl1T8cGTh2DZ
         pKZuUGor8LX7uB74W8NkNsz3m5eFj8GLjX9PRXZ4pdRADbbS4QEJGZf0gewu+xf8ZxEY
         KcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764672731; x=1765277531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmhfHrPQTFVWagp2s/Ebbdc6h6Z/4SsYa6hWCM83C2E=;
        b=s9/K8y86vJsiBwezS/8UgAqYptZZS4dUE4xDqo2ULxcMKDUZasifBN7Bn1kZ0FG8HL
         bBrRC7PTn7JqzNkNGhg1LjlcUexYXJQCo+t9ctTrkscUG13PVvbHDf3xUoz4p53Qg6+y
         5VJeLsNLLPBdwG3pXdYYdvRdTYpBbBs2bMvyFAzTx1HssozsNaAWC50tkFsXeagvIxbL
         pHiLvnAQtez+ITg2X5SM9XdSBgWqPPZAZWvyr7EY0q9qE5t7QccOuHsenTaHkqntpXYb
         XI0U4GYVbKlKhi2MY6E5n1NFbqFq7A5UpV+o5+7URXqUHAj0ftYbAoacv1tshwYS71X2
         wbfg==
X-Forwarded-Encrypted: i=1; AJvYcCVPG8GH+Wlnh9XmsEidW97LFj388vTJJSfvHr90cyujqapwa8GdMqfrfAuv7Mq+dJyVC+A8tJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFN8d8K8uiK0MIagdpy9pRSlaKH0zRMoxkSFc4aG0e7d6QP4i
	IjoRMfAWxM2JCvA7w1VHMrzvrqPPeUUOSOY9KlbqykyRQG7LRZr4DunQ8HHDu9MBlBGoYqwCH5v
	+MO80/Dn+ZigectSd7sSATh8WxfxWtzKs3wTjaDidmFxAUCCWyIVTwzOxXg==
X-Gm-Gg: ASbGncvIfvoAspw0g+IMjN1pXkG8jnSwws/iFUkHwAga7QYSVt0KCDje+W3GxvT3/Kv
	jBByDHK1D2hRjb4lfgdrIBr39htJuxuUf3rWSIOTeePe/P+wXiNg3vN5AS7BMdqEy4hxWl2QANR
	OVApS7O9EkKk7tNhXX81sgAfhWG0zcSa+I2TWnvAvJiCzW5ik4e71iHYoVMu6Dq/B7ZuCdqZIGn
	F1R57z37TpKR9QN4UShqy7G+3w1H45j6xwNP5T4pVlMaycQ7J6bsnXBaQs2dscadvMZGDHkyOCS
	kpRBwOvSlh78/VQQKHWDusel9X8QFGy3JFfxkdH6mODAgBLpXeHmf1QwAEVTezihwLwak6CW9br
	3gDQnVCKzeFtfww==
X-Received: by 2002:a05:690e:144a:b0:641:f5bc:695d with SMTP id 956f58d0204a3-64302b3eb26mr30127682d50.73.1764672731074;
        Tue, 02 Dec 2025 02:52:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH55jhk9op4wRd+kvcWYNQ8k0jF4OpaR73DWiZugbdkkZhYjIweyrtxIoxXz8UAKqjmEQRy9w==
X-Received: by 2002:a05:690e:144a:b0:641:f5bc:695d with SMTP id 956f58d0204a3-64302b3eb26mr30127661d50.73.1764672730622;
        Tue, 02 Dec 2025 02:52:10 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c4692a2sm6000138d50.17.2025.12.02.02.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:52:10 -0800 (PST)
Message-ID: <871f34ca-e417-4e46-8593-b3e10b64b8b9@redhat.com>
Date: Tue, 2 Dec 2025 11:52:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: devmem: convert binding refcount to
 percpu_ref
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com>
 <aS3Md9EuAGIl8Bd0@mini-arch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aS3Md9EuAGIl8Bd0@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 6:12 PM, Stanislav Fomichev wrote:
> On 11/26, Bobby Eshleman wrote:
>> From: Bobby Eshleman <bobbyeshleman@meta.com>
>>
>> Convert net_devmem_dmabuf_binding refcount from refcount_t to percpu_ref
>> to optimize common-case reference counting on the hot path.
>>
>> The typical devmem workflow involves binding a dmabuf to a queue
>> (acquiring the initial reference on binding->ref), followed by
>> high-volume traffic where every skb fragment acquires a reference.
>> Eventually traffic stops and the unbind operation releases the initial
>> reference. Additionally, the high traffic hot path is often multi-core.
>> This access pattern is ideal for percpu_ref as the first and last
>> reference during bind/unbind and normally book-ends activity in the hot
>> path.
>>
>> __net_devmem_dmabuf_binding_free becomes the percpu_ref callback invoked
>> when the last reference is dropped.
>>
>> kperf test:
>> - 4MB message sizes
>> - 60s of workload each run
>> - 5 runs
>> - 4 flows
>>
>> Throughput:
>> 	Before: 45.31 GB/s (+/- 3.17 GB/s)
>> 	After: 48.67 GB/s (+/- 0.01 GB/s)
>>
>> Picking throughput-matched kperf runs (both before and after matched at
>> ~48 GB/s) for apples-to-apples comparison:
>>
>> Summary (averaged across 4 workers):
>>
>>   TX worker CPU idle %:
>>     Before: 34.44%
>>     After: 87.13%
>>
>>   RX worker CPU idle %:
>>     Before: 5.38%
>>     After: 9.73%
>>
>> kperf before:
>>
>> client: == Source
>> client:   Tx 98.100 Gbps (735764807680 bytes in 60001149 usec)
>> client:   Tx102.798 Gbps (770996961280 bytes in 60001149 usec)
>> client:   Tx101.534 Gbps (761517834240 bytes in 60001149 usec)
>> client:   Tx 82.794 Gbps (620966707200 bytes in 60001149 usec)
>> client:   net CPU 56: usr: 0.01% sys: 0.12% idle:17.06% iow: 0.00% irq: 9.89% sirq:72.91%
>> client:   app CPU 60: usr: 0.08% sys:63.30% idle:36.24% iow: 0.00% irq: 0.30% sirq: 0.06%
>> client:   net CPU 57: usr: 0.03% sys: 0.08% idle:75.68% iow: 0.00% irq: 2.96% sirq:21.23%
>> client:   app CPU 61: usr: 0.06% sys:67.67% idle:31.94% iow: 0.00% irq: 0.28% sirq: 0.03%
>> client:   net CPU 58: usr: 0.01% sys: 0.06% idle:76.87% iow: 0.00% irq: 2.84% sirq:20.19%
>> client:   app CPU 62: usr: 0.06% sys:69.78% idle:29.79% iow: 0.00% irq: 0.30% sirq: 0.05%
>> client:   net CPU 59: usr: 0.06% sys: 0.16% idle:74.97% iow: 0.00% irq: 3.76% sirq:21.03%
>> client:   app CPU 63: usr: 0.06% sys:59.82% idle:39.80% iow: 0.00% irq: 0.25% sirq: 0.05%
>> client: == Target
>> client:   Rx 98.092 Gbps (735764807680 bytes in 60006084 usec)
>> client:   Rx102.785 Gbps (770962161664 bytes in 60006084 usec)
>> client:   Rx101.523 Gbps (761499566080 bytes in 60006084 usec)
>> client:   Rx 82.783 Gbps (620933136384 bytes in 60006084 usec)
>> client:   net CPU  2: usr: 0.00% sys: 0.01% idle:24.51% iow: 0.00% irq: 1.67% sirq:73.79%
>> client:   app CPU  6: usr: 1.51% sys:96.43% idle: 1.13% iow: 0.00% irq: 0.36% sirq: 0.55%
>> client:   net CPU  1: usr: 0.00% sys: 0.01% idle:25.18% iow: 0.00% irq: 1.99% sirq:72.80%
>> client:   app CPU  5: usr: 2.21% sys:94.54% idle: 2.54% iow: 0.00% irq: 0.38% sirq: 0.30%
>> client:   net CPU  3: usr: 0.00% sys: 0.01% idle:26.34% iow: 0.00% irq: 2.12% sirq:71.51%
>> client:   app CPU  7: usr: 2.22% sys:94.28% idle: 2.52% iow: 0.00% irq: 0.59% sirq: 0.37%
>> client:   net CPU  0: usr: 0.00% sys: 0.03% idle: 0.00% iow: 0.00% irq:10.44% sirq:89.51%
>> client:   app CPU  4: usr: 2.39% sys:81.46% idle:15.33% iow: 0.00% irq: 0.50% sirq: 0.30%
>>
>> kperf after:
>>
>> client: == Source
>> client:   Tx 99.257 Gbps (744447016960 bytes in 60001303 usec)
>> client:   Tx101.013 Gbps (757617131520 bytes in 60001303 usec)
>> client:   Tx 88.179 Gbps (661357854720 bytes in 60001303 usec)
>> client:   Tx101.002 Gbps (757533245440 bytes in 60001303 usec)
>> client:   net CPU 56: usr: 0.00% sys: 0.01% idle: 6.22% iow: 0.00% irq: 8.68% sirq:85.06%
>> client:   app CPU 60: usr: 0.08% sys:12.56% idle:87.21% iow: 0.00% irq: 0.08% sirq: 0.05%
>> client:   net CPU 57: usr: 0.00% sys: 0.05% idle:69.53% iow: 0.00% irq: 2.02% sirq:28.38%
>> client:   app CPU 61: usr: 0.11% sys:13.40% idle:86.36% iow: 0.00% irq: 0.08% sirq: 0.03%
>> client:   net CPU 58: usr: 0.00% sys: 0.03% idle:70.04% iow: 0.00% irq: 3.38% sirq:26.53%
>> client:   app CPU 62: usr: 0.10% sys:11.46% idle:88.31% iow: 0.00% irq: 0.08% sirq: 0.03%
>> client:   net CPU 59: usr: 0.01% sys: 0.06% idle:71.18% iow: 0.00% irq: 1.97% sirq:26.75%
>> client:   app CPU 63: usr: 0.10% sys:13.10% idle:86.64% iow: 0.00% irq: 0.10% sirq: 0.05%
>> client: == Target
>> client:   Rx 99.250 Gbps (744415182848 bytes in 60003297 usec)
>> client:   Rx101.006 Gbps (757589737472 bytes in 60003297 usec)
>> client:   Rx 88.171 Gbps (661319475200 bytes in 60003297 usec)
>> client:   Rx100.996 Gbps (757514792960 bytes in 60003297 usec)
>> client:   net CPU  2: usr: 0.00% sys: 0.01% idle:28.02% iow: 0.00% irq: 1.95% sirq:70.00%
>> client:   app CPU  6: usr: 2.03% sys:87.20% idle:10.04% iow: 0.00% irq: 0.37% sirq: 0.33%
>> client:   net CPU  3: usr: 0.00% sys: 0.00% idle:27.63% iow: 0.00% irq: 1.90% sirq:70.45%
>> client:   app CPU  7: usr: 1.78% sys:89.70% idle: 7.79% iow: 0.00% irq: 0.37% sirq: 0.34%
>> client:   net CPU  0: usr: 0.00% sys: 0.01% idle: 0.00% iow: 0.00% irq: 9.96% sirq:90.01%
>> client:   app CPU  4: usr: 2.33% sys:83.51% idle:13.24% iow: 0.00% irq: 0.64% sirq: 0.26%
>> client:   net CPU  1: usr: 0.00% sys: 0.01% idle:27.60% iow: 0.00% irq: 1.94% sirq:70.43%
>> client:   app CPU  5: usr: 1.88% sys:89.61% idle: 7.86% iow: 0.00% irq: 0.35% sirq: 0.27%
>>
>> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> ---
>>  net/core/devmem.c | 38 +++++++++++++++++++++++++++++++++-----
>>  net/core/devmem.h | 18 ++++++++++--------
>>  2 files changed, 43 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>> index 1d04754bc756..83989cf4a987 100644
>> --- a/net/core/devmem.c
>> +++ b/net/core/devmem.c
>> @@ -54,10 +54,26 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
>>  	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
>>  }
>>  
>> -void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>> +/*
>> + * percpu_ref release callback invoked when the last reference to the binding
>> + * is dropped. Schedules the actual cleanup in a workqueue because
>> + * ref->release() cb is not allowed to sleep as it may be called in RCU
>> + * callback context.
>> + */
> 
> Can we drop this and the rest of the comments? I feel like they mostly
> explain how percpu_ref works, nothing devmem specific.

I agree with Stan, the code looks good, but the comments are a bit
distracting. It should be assumed that people touching this code has
read/studied percpu_ref documentation.

Please strip them, thanks!

Paolo


