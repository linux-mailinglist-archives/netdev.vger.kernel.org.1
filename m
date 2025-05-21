Return-Path: <netdev+bounces-192191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1241ABED02
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3574B3BB589
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CFA23372E;
	Wed, 21 May 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzZsrPuI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC522B8B0
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747812366; cv=none; b=RMJ4IvHBcl6xAYMUDIFQoZYgpTFHIVvH5Ze4+N/lDgRpLFd8q/Yr7oI7jGQHNzinJXkYq4D093ir3WupCO9RyOY8arex1nUmSFXWoOzCih2xREKLWz+Q2kR2subX+fqyYvntL3IqTp0BQ2QGzra5P4r82vSm6QT5ur1t5BZiDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747812366; c=relaxed/simple;
	bh=QvkoYyz4yEKzdS+qh+APzJHG+Y6oTY/83/pKMDuYEgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8TaoV5R68tzp/4p29y+RA69R+7p8s39/Ipc7ziKcymxdVbviVVFdzE7+QvP8Anl1z3rBz79WTPCjSeIV1ycsqTdByTKC/PxjVlKwMiIb5j9pgQd2vwJxcDKTYkRqX/dzzLuvqaEylBt8jHtFAEGNlQX5euL5g7lbhnjIOpnGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzZsrPuI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747812364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2kQxBY/wRZ5LnzY7MY1xCBEX/fMDUL/PD5PqVbjXirw=;
	b=EzZsrPuIlUQnYMraugUOuOF7rIFyHkVJwGz1btBvO107hW7L8MLwp0tUGDh7WIq4h4J8ou
	i9YiJYyWOqae4LVsVFGVM2XDu1/eMICqUhUuf1BJotMgjnr9Yb8f8onS4O/4XpNhjWLyKU
	dc7zxIb+Je5Xto+QBYxCrkXJ5Ng8Bc0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-QddmctRgOTu_B2xGhhplUQ-1; Wed, 21 May 2025 03:26:02 -0400
X-MC-Unique: QddmctRgOTu_B2xGhhplUQ-1
X-Mimecast-MFC-AGG-ID: QddmctRgOTu_B2xGhhplUQ_1747812362
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso19207685e9.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 00:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747812361; x=1748417161;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kQxBY/wRZ5LnzY7MY1xCBEX/fMDUL/PD5PqVbjXirw=;
        b=jWGuXiiTSUipdhn5+E0dmJSETsqj1UQk4OU66p/7G6q+8AhobDQrQD/hpdf3c66vkt
         Chp0MqPAr0YewJKIVfoWmTrBn9G4kF5GP1LQiD3cjeqWswx9sXHUmYXr0TxRDPywKLgU
         PiylVpSzr077a6gGi7L0/zjCJaISxkUI0c/wsFbC8QieIRyRomVYuFtDf2wGzgBnTRzf
         3qVfsSkLYbQ9vjE/mcci3XJZDKDRELwUwCYC0xbLCUvRMBlruOKPCMIrqlpGbd5i8vCi
         xmzoGfZ1uQu88OYOzZqIIbbk3IE8WHlBg9pDWe5ZfFviJJbTBugQuhGf5lzdc78TlVVY
         Y7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWpwUHth7J2geXDx+QZ+U+AOQvyiGTKCQNO3sdnn4kprXL6PjYrgxiRMh7lgHwsmEPTKH5XiNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxjj4YEJC1uB5oUwsexhOYoJnc7ZEn89HlTxdoWY9JEowPAE0Q
	HgPNShxyxDuJ/q1V83rf9nvweA+na49nP6kwc3Bu/Xqs9beoRfygoX+wGOGcIp9IFe4Vl9yYgT7
	cAg4FUvVVAXdCDHO+HgLNIoHoKx024Z8potDXcA1Ax/kaLNQyPQ+1R/7vxs0KYPOBKw==
X-Gm-Gg: ASbGncuBeXg0ZDmKc35IRzHfHx5cYgbGGPivXIO68HXO9fKNorxKLp2M0vU1oP/hrMY
	azKJmJRNA8nzIu1+jsOx0BDxISHmKMdeay+erWG5/YlYbxp2/XXzJ2OkrfNvhxRHVCROopFctVX
	lP4MwiYEWaF+fD88iWV5wjV0sgGAUyux79STpWwqNXYNNHUrcje5x+BXUxxKdUOyPB8xz4Cz7QP
	JfBLEfmIH6PJOJpUWUrKi+125lhbP3ggfiRAUt+nPQTL3ctfsTQkTGK7WTFJKOWq/CZaRsLlzvK
	eSrvhNTVbcjL4wpWM3v+gWeKMgA7z2blM8qthwtZaAsKd0M7HA==
X-Received: by 2002:a05:600c:4e0e:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-442fd608293mr216469265e9.2.1747812361407;
        Wed, 21 May 2025 00:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENCIihMnh+stlRr+F+Xo4bk2Wfb9JNvGDV9zaqKB6WEc8xi16Upduw7gnDhFYYS0ukhFtYvg==
X-Received: by 2002:a05:600c:4e0e:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-442fd608293mr216469055e9.2.1747812361049;
        Wed, 21 May 2025 00:26:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4a3csm60781785e9.22.2025.05.21.00.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 00:26:00 -0700 (PDT)
Message-ID: <434ab5d7-313c-4835-b0d9-47a1eec31551@redhat.com>
Date: Wed, 21 May 2025 09:25:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_ring: Fix error reporting in virtqueue_resize
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250520110526.635507-1-lvivier@redhat.com>
 <20250520110526.635507-2-lvivier@redhat.com>
 <CACGkMEsO2XFFmJm4Y__9ELo5YQOve1DgE2TVOO2FgB1rmZh58g@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEsO2XFFmJm4Y__9ELo5YQOve1DgE2TVOO2FgB1rmZh58g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/05/2025 03:00, Jason Wang wrote:
> On Tue, May 20, 2025 at 7:05 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> The virtqueue_resize() function was not correctly propagating error codes
>> from its internal resize helper functions, specifically
>> virtqueue_resize_packet() and virtqueue_resize_split(). If these helpers
>> returned an error, but the subsequent call to virtqueue_enable_after_reset()
>> succeeded, the original error from the resize operation would be masked.
>> Consequently, virtqueue_resize() could incorrectly report success to its
>> caller despite an underlying resize failure.
>>
>> This change restores the original code behavior:
>>
>>         if (vdev->config->enable_vq_after_reset(_vq))
>>                 return -EBUSY;
>>
>>         return err;
>>
>> Fix: commit ad48d53b5b3f ("virtio_ring: separate the logic of reset/enable from virtqueue_resize")
>> Cc: xuanzhuo@linux.alibaba.com
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index b784aab66867..4397392bfef0 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -2797,7 +2797,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>>                       void (*recycle_done)(struct virtqueue *vq))
>>   {
>>          struct vring_virtqueue *vq = to_vvq(_vq);
>> -       int err;
>> +       int err, err_reset;
>>
>>          if (num > vq->vq.num_max)
>>                  return -E2BIG;
>> @@ -2819,7 +2819,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>>          else
>>                  err = virtqueue_resize_split(_vq, num);
>>
>> -       return virtqueue_enable_after_reset(_vq);
>> +       err_reset = virtqueue_enable_after_reset(_vq);
> 
> I wonder if we should call virtqueue_enable_after_reset() when
> virtqueue_resize_xxx() fail.

Original code modified by ad48d53b5b3f did the reset. And the commit removes it without 
explanation.

And as we did a virtqueue_disable_and_recycle(), I think we need the 
virtqueue_enable_after_reset() to restart the queue.

In virtnet_tx_resize(), we have virtnet_tx_resume() unconditionnaly, even in case of error 
of virtqueue_resize(). virtnet_tx_resize() is called by virtnet_set_ringparam(), that is 
the function called by 'ethtool -G' and I think a failure of ethtool should not break the 
virtqueue.

Thanks,
Laurent


> 
> Thanks
> 
>> +       if (err_reset)
>> +               return err_reset;
>> +
>> +       return err;
>>   }
>>   EXPORT_SYMBOL_GPL(virtqueue_resize);
>>
>> --
>> 2.49.0
>>
> 


