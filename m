Return-Path: <netdev+bounces-203352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A63AF586A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5057BAAB0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0027816D;
	Wed,  2 Jul 2025 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFpLAVJ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49D253F35
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462199; cv=none; b=JoFk4EHpucOJdAGXxsDpbV++l0MEKe4/r9q9Tx87H3bnvV7P688xiKr7nIKygJDHmOo3BTG2W99pdWCObH104EUIhk/6XrB20qe6NzmljIwCKIyiuxH+NFoUc0+oIikkhykbtAREIKY2p+AHU97uWLaoIINeBr5KIj22ZRyfTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462199; c=relaxed/simple;
	bh=1j1LyNigN5AHD08zHiexmmDlfFxiEshK30KkAloLUzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV1Lg5GEloH0kqhL9D/esfF/akFSXyQe13wYK2Kq8dMde++Ky5ENd6MSUiTS8DfJmkWoSY5pL8yd2swjwIZGr99sHSsa4Wz/kR2z9NpFjgqKeEA1RXDkbKDWDR+1oaaKhCQOmKavaIMqtMMjqOejhcIqIegtVlD0rI+w8f9yl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFpLAVJ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751462196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sy4nWTHPkpPaaqEvDu9i4dBMnt5aD41NB3JYr++qf2M=;
	b=OFpLAVJ9oUFP22/fqBDFeDG2TxYkk269JUXoghx6Xy/AoVsGzPGiuJLpDgBLs/cM4TC+NQ
	ODguOszPhSit7aUOrHml/aHiA6dH0DVBPgOsbrx1hhyerxpiAqwA2aAHHzUieOPi9R7bdH
	LpLhE1tUfkJ45jNm1iag+zQ8Qtci26g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-4B43POM5N1iQhlZla6rhdA-1; Wed, 02 Jul 2025 09:16:35 -0400
X-MC-Unique: 4B43POM5N1iQhlZla6rhdA-1
X-Mimecast-MFC-AGG-ID: 4B43POM5N1iQhlZla6rhdA_1751462194
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451deff247cso37106535e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751462194; x=1752066994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy4nWTHPkpPaaqEvDu9i4dBMnt5aD41NB3JYr++qf2M=;
        b=G+7hJ9VCzP74B1RgniJBGGfMN2P+pyo9T5dBEopi40Jz6MeNvvVN7/1be5Z9FPaQgR
         l/Bgi2KPOdXzIM9ZRmMvhpw3imMWdQydGHsCXaY45nc0ZYrPbK89Iyq+h8VsbHFCwfgC
         HlG1QHM5ShWpNlLPLedyiBBMNNQfooQkoA93b3lRpoXCtXmDqu70N+UWlbxp+EvhSENx
         8JT/V4jGRwIkWyw56ET8rx3d0Ocr/DEj+vAaT3cBVMTg/X8W5Fm15hgHb+k13yeEkE/k
         WAJHdPQna3WXhBJcaKOD/voLg35xQA77z32qTb8BS5LU7MpXTzw8TErdihFTCrwhEI6d
         16Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUw/vDjKIbs8aItDFbkb2MpLKOQuYH4lhTrUkFFAhy2zcHxxa+ip/yKc3eh7SG56gc2zB53CqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYSGhyQO7C1JjdNtrMH1t+mVCAUlS3v6SgZR0iW1X2zUjGJqP
	mkL7S6soAKCgtchcQHT/k12rGy8ufc4YskAoTcTxNThgqm20eGSsFR3l59ub4xYUbm464JVi1mN
	2MjzguUo+FQOjvDHRRR1PI1Vduh6idhKxzEcayBDfsWzATi6+dWr5sfRiYA==
X-Gm-Gg: ASbGncs9THpjwkopqD2z04CNtWbqaw7u78f8HpHEkkqNCscj/uALqOXX56VY8S6axNM
	xEYWupl1F/EoFm0DGqUhRoZPzIS1Ju54rrBvhvD6GRQA060pZWImW6ND7aVDxNLQwO7u19HWedd
	96Z+HVBKbYGaX23G/BQoI3xiGa3dyYcPJBNggSg0Nv/H3h2kaGK3SWn6U3Dj973TCUf6pjuk/1D
	SXFjVSMos6hTR3ppg6OgAz6oMGPhzz+pq8/Rn1lWRCWi5rJMXfDHGtuYKHHT+smZTV0h2rh9tBF
	vTEv434uoObH+c7cvnLY1HhW3zWd
X-Received: by 2002:a05:600c:c0dc:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-454a3c610camr23628635e9.14.1751462193946;
        Wed, 02 Jul 2025 06:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK+MShUn1qdie/bqB3hm1XM6IQ/XjWSETD0pYwme5TdPq6afvGUkaA/cLuoccNQG7Dhu4OBw==
X-Received: by 2002:a05:600c:c0dc:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-454a3c610camr23628285e9.14.1751462193306;
        Wed, 02 Jul 2025 06:16:33 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e72c1sm15900209f8f.1.2025.07.02.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:16:32 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:16:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 4/8] vsock/virtio: Resize receive buffers so that each
 SKB fits in a page
Message-ID: <3s4lvbnzdj72dcvvh2nnx4s7skyco4pbpwuyycccqv3iudqhnn@5szfvvgxojkb>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-5-will@kernel.org>
 <20250701201400.52442b0e@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701201400.52442b0e@pumpkin>

On Tue, Jul 01, 2025 at 08:14:00PM +0100, David Laight wrote:
>On Tue,  1 Jul 2025 17:45:03 +0100
>Will Deacon <will@kernel.org> wrote:
>
>> When allocating receive buffers for the vsock virtio RX virtqueue, an
>> SKB is allocated with a 4140 data payload (the 44-byte packet header +
>> VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
>> overhead, the resulting 8KiB allocation thanks to the rounding in
>> kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
>> higher-order page allocation for the sake of a few hundred bytes of
>> packet data.
>>
>> Limit the vsock virtio RX buffers to a page per SKB, resulting in much
>> better memory utilisation and removing the need to allocate higher-order
>> pages entirely.
>>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> ---
>>  include/linux/virtio_vsock.h     | 1 -
>>  net/vmw_vsock/virtio_transport.c | 7 ++++++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> index eb6980aa19fd..1b5731186095 100644
>> --- a/include/linux/virtio_vsock.h
>> +++ b/include/linux/virtio_vsock.h
>> @@ -109,7 +109,6 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
>>  	return (size_t)(skb_end_pointer(skb) - skb->head);
>>  }
>>
>> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>>  #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
>>  #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 488e6ddc6ffa..3daba06ed499 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -307,7 +307,12 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>>
>>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>>  {
>> -	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
>> +	/* Dimension the SKB so that the entire thing fits exactly into
>> +	 * a single page. This avoids wasting memory due to alloc_skb()
>> +	 * rounding up to the next page order and also means that we
>> +	 * don't leave higher-order pages sitting around in the RX queue.
>> +	 */
>> +	int total_len = SKB_WITH_OVERHEAD(PAGE_SIZE);
>
>Should that be an explicit 4096?
>Otherwise it is very wasteful of memory on systems with large pages.

This is a good point!

What about SKB_WITH_OVERHEAD(VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE) ?

Thanks,
Stefano

>
>	David
>
>>  	struct scatterlist pkt, *p;
>>  	struct virtqueue *vq;
>>  	struct sk_buff *skb;
>
>


