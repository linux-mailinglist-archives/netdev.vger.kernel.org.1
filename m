Return-Path: <netdev+bounces-187423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B0AA70E9
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08933BBCF2
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03D246794;
	Fri,  2 May 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqA0BRXi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37023E34D
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186675; cv=none; b=Ng0PVLgbYwZftKbmUsbLyd6gi2IWx2KIsGulN+MyjPnVoawqgqpgEkp+gTe9KKIMudjsaBD8DI652RiJKyaLZMVNGtGJQ+I9xNBzjoxLnruPDfCDT5PNVCz/qCN3PB0vqrgvO0QtrZVW9uYO5PsTDsXFYQIX0QV8J9cXFG9P6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186675; c=relaxed/simple;
	bh=+0d8CwTuHrJs/E25TFaoH65v9LAce4x6lhTEyfS7GV8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qwf3dvrHYf00qoIw5qfolpxwWqn++VvlhKd3yEcKyG4ZxZQyQwaufAupyWUxS6L+D+LKVaDgeITkkXXT6jVcNUgpseAmG8I8nlej5CyPrDo5FQr1D8+XDqTyqc10Wpz/B6iXwdd/aBEkmtYgme1zQBztx1ELE7oSNWbAiAr9cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqA0BRXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746186670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZIQ1vSgG4BCH48a70PyavGFGPqBvO/w0OyHX60QmKc=;
	b=SqA0BRXi1yO0TlYbIoRJI/oS2OpGQjLSuH0RBW1r33/aetqs+KF/gsXu9mQVG3vkIe3beX
	XLuFoB/gIZoQdNu1D8P01T1mhaq4hintAfmReMKRuEf+9mygIDHOjxX+Z+iN2vYpM/BTiM
	hWmdAQ+oZUeq2v751Vbv6yo7hxq+/RY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-zN6x0J95N5uOmCHl15lyiw-1; Fri, 02 May 2025 07:51:09 -0400
X-MC-Unique: zN6x0J95N5uOmCHl15lyiw-1
X-Mimecast-MFC-AGG-ID: zN6x0J95N5uOmCHl15lyiw_1746186668
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39c2da64df9so887399f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746186668; x=1746791468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZIQ1vSgG4BCH48a70PyavGFGPqBvO/w0OyHX60QmKc=;
        b=KMW+RBD8NVusXJQqYNrM4WIoG+2LNQ60nD5DEogheyF8sFASzvKvLjQh1a7pW+wtFf
         cKPBJjm9DUtIMrupCiBGYdJdrpKBnCoU90qlWeH6ppcn5X5rdbttdrBZVpzQMHuKJR5K
         DR2RQP/nfObJ04vM69IBNPTqYFFgZqjHjXcvUdWLZlZFZ7qMof36VZGx626wrbjg41sr
         aqSz+AJO7AJY5zT+AVEQXX7LwZOtnsLjTZ8hoUQp5+6dMLbDk8CGWObLsh2ergc9f6xO
         axcNRUzGWzU6NxiCb7sOe+NoJPCjUBCQXuUpp8uIbie5fozVjzXHLqrabaCaB0n7dlNi
         H+8g==
X-Forwarded-Encrypted: i=1; AJvYcCXesuGG5hnq5HfHu1iIRwb0rmMyR8BXxuz7+bJdvUSezIxI9VFYmd7dnU2dCtSFyGJ7R9OMl8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05azY4wM+U01KDCXGDQDp6BSXVhlPlx+vAJooQpkSWE7Kz96b
	1cGfwaxaJluL0/BVuPLvnTXMGBgQMIDk/KLpJsS14iPwE2VEcl/UbHIn/dI75/GYVvBZZiWf9pI
	qQPEDP/uwtoPQ7/JaG9aIVnhgLyy1UX22qDhRScwx4ClOSnKuoBq/SA==
X-Gm-Gg: ASbGncvRLALC3s5UMgKGN/u0BNWbWL7/R2y1+4OaMcYiV3BB5jjBaQpgBA3VprPdeKU
	4Y9uFSFDViPdDoKfRNa3VB8bM+vT7AHNNsWpCNL7jXcUfvA4NKhKSyDhrOMFb6/2wtzg84HXOtg
	4X1hSgpdnNBA7fbXHYVUciR2bVXAYrQLbDK99w3qOJCRdcH99r8YEHYAIuegHNW/Y2LoFzjc+zR
	ptXp0sBFudDQlZ4a0oysdCrzwKDpF7P/VJb3F35Aya3AZ+zhiuz4eNBIFdwSAYr+iz5nl4oHGsa
	1RuxfiYecd2+cfgLiaI=
X-Received: by 2002:a05:6000:2a6:b0:3a0:89e9:bb4 with SMTP id ffacd0b85a97d-3a099aea7f7mr2048309f8f.47.1746186667994;
        Fri, 02 May 2025 04:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwOQCZM3FMB5HKcpzIblBW1hsxg0qNkNXGCkUBBPHwGkLVJaHQAHnvurydrDJEy7YqzuycIQ==
X-Received: by 2002:a05:6000:2a6:b0:3a0:89e9:bb4 with SMTP id ffacd0b85a97d-3a099aea7f7mr2048272f8f.47.1746186667564;
        Fri, 02 May 2025 04:51:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b10083sm1959004f8f.62.2025.05.02.04.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 04:51:07 -0700 (PDT)
Message-ID: <fd7f21d9-3f45-4f68-85cb-dd160a0a95ca@redhat.com>
Date: Fri, 2 May 2025 13:51:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
 <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
Content-Language: en-US
In-Reply-To: <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 1:47 PM, Paolo Abeni wrote:
> On 4/29/25 5:26 AM, Mina Almasry wrote:
>> Augment dmabuf binding to be able to handle TX. Additional to all the RX
>> binding, we also create tx_vec needed for the TX path.
>>
>> Provide API for sendmsg to be able to send dmabufs bound to this device:
>>
>> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
>> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
>>
>> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
>> implementation, while disabling instances where MSG_ZEROCOPY falls back
>> to copying.
>>
>> We additionally pipe the binding down to the new
>> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
>> instead of the traditional page netmems.
>>
>> We also special case skb_frag_dma_map to return the dma-address of these
>> dmabuf net_iovs instead of attempting to map pages.
>>
>> The TX path may release the dmabuf in a context where we cannot wait.
>> This happens when the user unbinds a TX dmabuf while there are still
>> references to its netmems in the TX path. In that case, the netmems will
>> be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
>> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
>>
>> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
>> of the implementation came from devmem TCP RFC v1[1], which included the
>> TX path, but Stan did all the rebasing on top of netmem/net_iov.
>>
>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> I'm sorry for the late feedback. A bunch of things I did not notice
> before...

The rest LGTM, and my feedback here ranges from nit to corner-cases, so
we are probably better off with a follow-up than with a repost, other
opinions welcome!

/P


