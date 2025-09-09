Return-Path: <netdev+bounces-221279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E527B500A8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C773ABB91
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A034F46F;
	Tue,  9 Sep 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gEsZQx7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E0345723
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430577; cv=none; b=irpCbVVUGa7cL1Dc3ceoL86EZ4bmTyE3MLdWnV4rQBaaDMs9umcV/bYlJefXSXaw9tgvhO0f3oOosW2oCGz/foFKjxLLGz2qqlEAA3U+XkwVbtQvLJrhSHV/4eYzl9TVVJPaBU6PO1PsiIoX8yxRbvFSZFQ0lNLpSB5obF4aueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430577; c=relaxed/simple;
	bh=G+q6VqDJLdzvmfgD7q0CGOEn2+Nfgn9RD17Iuc+VVi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPa7conCbs8iOXDFHny+U06CFMhTPTdkOZXZvs4haNYjccDCLJjfdnwfRNXK+j+0nl5TF2nuux2yB1w9ukl7kw8HEAzc9InwfRk3ZFiSOcyuVIa8CLji8LlIzI/QbN2XQ9ME5maULpWC4jrctOFkjNtV2de8tlTnYy/S1xnXWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gEsZQx7f; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88758c2a133so526688839f.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757430574; x=1758035374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBkHzWz2WSvAv3P+4fdRCtFI9r1yFcrUi6CJvq5A8BM=;
        b=gEsZQx7fFDPkJK6aZ1I0lahZmlTwQhO7hJeLSYqfOUsvLY34FLelVHfp4Jz33GM+DY
         j/kP3Y/MzgbWd6zo/E7bZM24pBwzMquyNxtkgcW1QXdzpij6oaBgIOYVGIUUZ1faA2fZ
         QoMiUrOE96g/7QgRt8cEQSvOSFqPHcz1TujNnWFkRRPyqdQj/exqViTeAF0TNxbsGTzy
         bQYlYkKHWE3WRdOspxSRmKKxpUVzcaUHugEMWxWpaCAbWFCOrDYi9OJF3t3Y9v7+1xTg
         VJYb5smNZeMhae/zIVBz2Y4kV3tx7fDnGd2RgjqtZVeA5+il7f46Vo9Q202F//hwDEXQ
         5NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430574; x=1758035374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBkHzWz2WSvAv3P+4fdRCtFI9r1yFcrUi6CJvq5A8BM=;
        b=g/iyYxSoRON9tPfLCGPye/MnJubn09RFsw8uDJtMh7ytckAe0351GDaWVyjBs1vJbe
         veAZVZ8/lBtrGoyfOqK2C1t0i2KLUvYmgoszduednpJZUtPXRjkaZrRP833wN2NjJaSG
         n0RUk8NuYAWFcydbIjSypZ3wxiQuJ5AY9FuHiL1hSyexWnKPuPybgT4zYYtYhZ4UCrxE
         UsPqxyV2Vghd8lccOn/t7Kah5FlDOKQdM6uJ8qFU1D1JVbpOCwhDTjOfIZJybJCBufix
         aLKVJMDvxeC9Wvi4vulhoi/SsKQ7xM/VtnwRGNPGOkjLsJlSXFV9D4jK2dAxFC5/2PoE
         OjCg==
X-Forwarded-Encrypted: i=1; AJvYcCWBOv9Mp50wRhWg+ZlEz20bqFnG/t11yPZhQ4Fn5clCdkWWzN3FepxECFmwxkz0Pcd+VZg28cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZgN51ydZdG0gA/VcvSiFd8XsJy4F+snoaYrGfNtl/yrJvKKj
	auAhCa0xlmPddBozzR2P+0WbRaiUjuHN2x+6JCsgN9As9JOQa+QKrjYetqlm07pV9tQ=
X-Gm-Gg: ASbGncvzxoECmMwtRnFAw0GWD05AbYLkaKtGIg5MJL5TF/u7HpQvTULBgd7WOSZcts1
	HwwKeBgR2298lN+3I+VylFigF6753nOPhi1BQ7X4LAaUwk+WR1DO7UAjcaBIJy6lKjFXtKrtm53
	p2l0zNW8mv5L64Ktg67n9ScuafT6xzOsRly39sYM/uSHtaYJhfPcqbwAYMNQjO9sv4HRGvmwP2L
	DixEca4fTD0sxHfj5MrXzRAyLeGd2qtbbu8+oGamVihfIUa9n17cpK6hqNwoLc2k3E9h9ZpYo7w
	AOcza+iBUyCAVf6JmgUm+QH9ECgFdhnyUJ5OPgyNmJ5WNuq9+IXnh0hi3aHa1dnC3auAEzPLfUl
	NFTQVUhGbAurwlDADlzq6Xr9jIlHzUg==
X-Google-Smtp-Source: AGHT+IEaLNl8zaGVmv/a45LKfh9YWrlicYBfVn4ysOSEgq8X+b4uOPf1vxmee+GBDunypTo5Eyf8Ug==
X-Received: by 2002:a05:6e02:1d99:b0:3fd:5836:2318 with SMTP id e9e14a558f8ab-3fd8e98d323mr176147975ab.11.1757430573191;
        Tue, 09 Sep 2025 08:09:33 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-403952954dasm31357415ab.26.2025.09.09.08.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:09:32 -0700 (PDT)
Message-ID: <e1161184-e2fa-49eb-8093-0b754dc362c1@kernel.dk>
Date: Tue, 9 Sep 2025 09:09:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Eric Dumazet <edumazet@google.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
 Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, nbd@other.debian.org
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 8:47 AM, Eric Dumazet wrote:
> On Tue, Sep 9, 2025 at 7:37?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/9/25 8:35 AM, Eric Dumazet wrote:
>>> On Tue, Sep 9, 2025 at 7:04?AM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>> On Tue, Sep 9, 2025 at 6:32?AM Richard W.M. Jones <rjones@redhat.com> wrote:
>>>>>
>>>>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
>>>>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
>>>>>>
>>>>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
>>>>>> made sure the socket supported a shutdown() method.
>>>>>>
>>>>>> Explicitely accept TCP and UNIX stream sockets.
>>>>>
>>>>> I'm not clear what the actual problem is, but I will say that libnbd &
>>>>> nbdkit (which are another NBD client & server, interoperable with the
>>>>> kernel) we support and use NBD over vsock[1].  And we could support
>>>>> NBD over pretty much any stream socket (Infiniband?) [2].
>>>>>
>>>>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>>>>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
>>>>> [2] https://libguestfs.org/nbd_connect_socket.3.html
>>>>>
>>>>> TCP and Unix domain sockets are by far the most widely used, but I
>>>>> don't think it's fair to exclude other socket types.
>>>>
>>>> If we have known and supported socket types, please send a patch to add them.
>>>>
>>>> I asked the question last week and got nothing about vsock or other types.
>>>>
>>>> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
>>>>
>>>> For sure, we do not want datagram sockets, RAW, netlink, and many others.
>>>
>>> BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
>>> in net/vmw_vsock/virtio_transport.c
>>>
>>> So you will have to fix this.
>>
>> Rather than play whack-a-mole with this, would it make sense to mark as
>> socket as "writeback/reclaim" safe and base the nbd decision on that rather
>> than attempt to maintain some allow/deny list of sockets?
> 
> Even if a socket type was writeback/reclaim safe, probably NBD would
> not support arbitrary socket type, like netlink, af_packet, or
> af_netrom.
> 
> An allow list seems safer to me, with commits with a clear owner.
> 
> If future syzbot reports are triggered, the bisection will point to
> these commits.

That's fine too, either approach will result in fixups, at the end of
the day. And followup related fixes to solve issues with socket types
that we do deem useful, like the vsock one you already found.

-- 
Jens Axboe

