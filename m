Return-Path: <netdev+bounces-192192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A9ABED45
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C7C4A7F85
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807B235BE8;
	Wed, 21 May 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh0PqJYM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B623536A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813555; cv=none; b=gAbkNeS+uVPX6Ql0TfbMSRZORgY0/RapB/eTQm2mtLmzYknN2PTXri4QKXSYU674lxfpgRkNhsOcA8U+PLS22dbElVc++uwDWrORpxLkxnJ98X0gdWEGnhfPpF5J1w9WD0nUMbFnMBAZRwh2fhvEL7S/gFB1C6wFFUMf8f901Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813555; c=relaxed/simple;
	bh=2jT2/BhImvh/xQv2Gn11Ou3TzYZzamtAUv0h/9Rd7Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKWSlZCPeQRhy2NxI0uv6cSj08NQsUInwxHxbEkBUD88weTGVJ+A7ByN6oO+5nTs3RN07bCOiFa+kmrYD3OZpncciYhufTv4NjGPNi2EqUPGEk9zGzO4cpVS2ZUC1pYUv/Eb9uPvvuJAmMmPGsfCpChr8X7D3kXRu86OiZqVctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zh0PqJYM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747813552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k6InROaYIp/hjJJTFSrU2kwf2UIGw3R3lidiyuJYGKs=;
	b=Zh0PqJYMB7hMin/2CVvc6VrIBTtYB9iF+Mn6vZq113mxoH5s1fxobBOlQKdeITR8uvAu14
	ZS89a3LMs6VDC7eOPa8BTB9FGWEXO0Zxi7UZxc9AHvkb2dlQ0FZRaz5BHzV4hiipP/NZBr
	AuQe84Dug9eXRWdNB0Hnsfh6xtxpe8M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-JV9t9uuIM2mS-X01M4wFVA-1; Wed, 21 May 2025 03:45:50 -0400
X-MC-Unique: JV9t9uuIM2mS-X01M4wFVA-1
X-Mimecast-MFC-AGG-ID: JV9t9uuIM2mS-X01M4wFVA_1747813549
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so34772575e9.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 00:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747813549; x=1748418349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6InROaYIp/hjJJTFSrU2kwf2UIGw3R3lidiyuJYGKs=;
        b=ujv9eYvnIymZwF1sQWhiY3sNA8oY0RV4rKP47wiUK+RVlWgvQVxPnv4rxNatEBZAbf
         GdZ0qoMt9NV43miPl+XXCCwSttB/wQTsESDnnZlMDaqk+Dv3NM+7QUu3rC5Fpx3zwYoR
         2xaySiJTlH/jlJbuOc2FAbFZ1J0z9BEb8a2p8Re6x2ClvOlfpMI56p2gtE+ytJMF/xJA
         M45qXFrU+U9mmsZBvQwJWcKXUgluQXl8YwdNONfFjpsnG4lveIacWQsCELBcx7cNvgsN
         5fdIMjgHlUu88PiASpTuFHZIJZhhwh9PNFVrtqox5MHPD3j0QD8M7GB8FI/Y/trhR2RX
         9c3A==
X-Forwarded-Encrypted: i=1; AJvYcCWePUpvwZSM2P7E2NDo547XkdLZ+IHlLs8rWtOlKSs6bjABb3uqkLolwLuBP6DEfrsaV55xpmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuflImG40PjOy/xXxHtkfQ9eS2GpC2YkzyQBvsnhOIJUugrh/
	E9lBPYoSLB9Zn69fIEjcE92IRtsm6KkiaVTtSRCisYgJ5jnVIxvbgi2ASUTfj0tAu8BOwNGG+NA
	PQb2mhcuB15y6bmHrWqo974T5Xf3jZNBUSTjGqDYHIz3vAh/EFyoMQkRx/A==
X-Gm-Gg: ASbGnctCfsEKwr77DX+NczGmDw6hVCXd2TOX6u1TtHAaY2TJpnk5hJ01ceIrMw1Z8ap
	8MtK57AfKp6lPE1PVit7LNI4j52q/zWbOJEba5nmxAzpJAEbsFsS48PpYHo32Ka+5FlX0CZBCre
	Eo1yzMRppyjhEJRYmtKHO6aMewEIbp88oi45jy6l21MpEgauGbrPcfPh/gOiwWd4hQ+jnJuXj7G
	vkxUzhBQ7hC4kJguhX9ND4GmQDY0KwSsPbXQAeQAjNibR0qqM1cjJVXe6akKTsy3Myh4wjI20Zk
	KZVmJAI5rN7dkXspV8ae268Q2NwtjzPNX5+yxUYZeOjpXRNBWw==
X-Received: by 2002:a05:600c:5295:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-442f8514e9emr216647465e9.12.1747813548853;
        Wed, 21 May 2025 00:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOlN81A6u79AjDlrNdCaCFslfB4YKDqZDDVqdQG7IHvUcdjC1/J0btazs2rwK5s5M43keDCw==
X-Received: by 2002:a05:600c:5295:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-442f8514e9emr216647265e9.12.1747813548519;
        Wed, 21 May 2025 00:45:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aea59sm61321405e9.25.2025.05.21.00.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 00:45:48 -0700 (PDT)
Message-ID: <4085eec2-6d1c-4769-9b0e-5b5771b3e4bf@redhat.com>
Date: Wed, 21 May 2025 09:45:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio_net: Enforce minimum TX ring size for
 reliability
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250520110526.635507-1-lvivier@redhat.com>
 <20250520110526.635507-3-lvivier@redhat.com>
 <CACGkMEudOrbPjwLbQKXeLc9K4oSq8vDH5YD-hbrsJn1aYK6xxQ@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEudOrbPjwLbQKXeLc9K4oSq8vDH5YD-hbrsJn1aYK6xxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/05/2025 03:01, Jason Wang wrote:
> On Tue, May 20, 2025 at 7:05 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> The `tx_may_stop()` logic stops TX queues if free descriptors
>> (`sq->vq->num_free`) fall below the threshold of (2 + `MAX_SKB_FRAGS`).
>> If the total ring size (`ring_num`) is not strictly greater than this
>> value, queues can become persistently stopped or stop after minimal
>> use, severely degrading performance.
>>
>> A single sk_buff transmission typically requires descriptors for:
>> - The virtio_net_hdr (1 descriptor)
>> - The sk_buff's linear data (head) (1 descriptor)
>> - Paged fragments (up to MAX_SKB_FRAGS descriptors)
>>
>> This patch enforces that the TX ring size ('ring_num') must be strictly
>> greater than (2 + MAX_SKB_FRAGS). This ensures that the ring is
>> always large enough to hold at least one maximally-fragmented packet
>> plus at least one additional slot.
>>
>> Reported-by: Lei Yang <leiyang@redhat.com>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..866961f368a2 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
>>   {
>>          int qindex, err;
>>
>> +       if (ring_num <= 2+MAX_SKB_FRAGS) {
> 
> Nit: space is probably needed around "+"

I agree, but I kept the original syntax used everywhere in the file. It eases the search 
of the value in the file.

> 
>> +               netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
>> +                          ring_num, 2+MAX_SKB_FRAGS);
> 
> And here.
> 
>> +               return -EINVAL;
>> +       }
>> +
>>          qindex = sq - vi->sq;
>>
>>          virtnet_tx_pause(vi, sq);
>> --
>> 2.49.0
>>
> 
> Other than this.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> (Maybe we can proceed on don't stall if we had at least 1 left if
> indirect descriptors are supported).

But in this case, how to know when to stall the queue?

Thank,
Laurent
> 
> Thanks
> 


