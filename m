Return-Path: <netdev+bounces-221274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B231B4FFA7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200231C241D6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C3352078;
	Tue,  9 Sep 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uMSbsfVL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294735206F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428651; cv=none; b=S3SlMV3BRLnIv7aeqOYnNNB20XfuafNjNZ4nXXD0ElW0jnGry3ZGF9aCIOK9qAQbKFRkLtIpRHVp5ibwuHXru1ZVjEdQchV1UPKjY0FP4G6xuTQMnl+pqzgfUmee+Vnhz44BCEyygAJFV8d9u8OytofOEEYnFAQAzZaoDl/Kbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428651; c=relaxed/simple;
	bh=FLvfa7fq92v+sqqn62k81V/o5eNgNqP5wcAxdiLtk/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXAmpIx0zkSeRgU96zShgQfaFuoABygPdfUnPLSe66TtIvIUmWiS9Gdna60mAYMAxRxlDhw3NzJOQDQZBzoRUKgYVjCPCEThEFMmsUWkBtWaojZkhmhttp4CpgiWiWO2usFuQ5Xsbl5q6RI7wdkF/iBlT9CtFxRwERn0GT03RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uMSbsfVL; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-412a2fe2f31so2602455ab.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757428649; x=1758033449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJnzswevlDUuq/OfoxD0pVudGLoTsCpDMKvJC+rT6Cg=;
        b=uMSbsfVLIICn9znjJfaJzX0EzI9htlDDlvRX+uXbaSpQjgcfX1TG4lJgO4PLITIrpo
         pMLon5sn5DYWkRWHWLkJhskWwKSGklfeQOuQAP++62MRXfUpPjkNWZVEy5qNLDcJfZZh
         R7oNxauWVw+rlIDhJu7vGa+oITK9XoWuiYLCRDcfQOegAYvy2z3c3WNk20L6wqoT/ofg
         yuLMogVaeSnK8F1ValpoPBDhno2wnwAJA1VfIsznZhO7gjZQ4US6EjhiiGeLvXSsXxtN
         Wxim49H8gM81f3Fte3cFNFbNXhTYdLwh+2aMrDIz1uCuaiTVp15oPqxaCeoRF/fJS66R
         d8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428649; x=1758033449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJnzswevlDUuq/OfoxD0pVudGLoTsCpDMKvJC+rT6Cg=;
        b=xU7XXA5Iq3PimBcAJrcOrl+/UviAhNLaAU2ba+4v2JccZP2SDhZXSH4aYdpd/Mc7ba
         om/+TO+SyrU1TQRt2Z1pW+RT5xrz8kwhyrMasPglXQfO6NgiXTI2In8gGvuoLdtF/IOe
         hQZtvfYsXO7xCYQuIgt9wWKo90I5sUhWRpfr1BU4DTbfJplfU2bIYodooP7JMF8mtymu
         lpezv0/rhm8Y/yDycQGZOoGlnzaHJz9HCq8rZmdnxxJhLgaLFTYAU7h4YMePFgiVr79g
         HF81g/TMzL08gyTFsoJL9znvIXDo0sFqLuEdE/rgoePw9JM5NCAV8K74gjVPztuDaqA0
         tW+g==
X-Forwarded-Encrypted: i=1; AJvYcCVoqi+wMFSAEKvTi4ExtFyBcQ+ZVfJK4A0xPrWkZUh1UQgwhEyamU8/Hs+Yw0zvukeNm/1FtCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnR/a6gFD+RZdzINjWG0w/bQFCzMzov+Ah1IvuRl0+IWfhbeP
	GMSZ+9SDx/aGwdX93SSFDMkvyi6EgVfFCiD524RlGd3S7Q+KtDd+W4ouPOA8nkDMrM4=
X-Gm-Gg: ASbGnctJUOYUkgmN6Fca+mKkmFChhKWRFDyXaMJsHhlHGdvfVUz86P0qL55E/0q3o/o
	vEt3YYFxb1xKv2eTANOSe67LeGxW8Xwdr8cx61ISgpFv09kiF4oZT/gxiia03M7ITgRGo4voc6R
	6zOpeTjVDUzPxH6e2XUjy4GtYWC3JaaECDqDYTdsO/quNJIN7zhjr+MDwBmuizQ0JzsDV2kJQhD
	Ads+E2wwseypztXgDsngOmKRkn/1Q4E1EKO3XB9ohX43bCN+pzlDn1QbSitQ5cwp80wMl57Hbdv
	XWm+/Bpjb5jJwMz6HUJqsJ/0aUXkOIUErcA3fxRbWUY4ZS5oQB1HS2zpRfNEy48onWYSTU/al4p
	l2BPcawPLvVL0WgnY7qa25JOt96R5zw==
X-Google-Smtp-Source: AGHT+IFFRSb/tnom+YwXf9uhxtCm5e69yWnLr+MwUSsv+r9w/hXHhYam53Z1HpV1oSqQ0qe9EVHAew==
X-Received: by 2002:a05:6e02:1a63:b0:414:cb8e:a801 with SMTP id e9e14a558f8ab-414cb8ebdffmr10529905ab.29.1757428648340;
        Tue, 09 Sep 2025 07:37:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ece96399csm9130641173.20.2025.09.09.07.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:37:27 -0700 (PDT)
Message-ID: <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
Date: Tue, 9 Sep 2025 08:37:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Eric Dumazet <edumazet@google.com>, "Richard W.M. Jones"
 <rjones@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
 Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, nbd@other.debian.org
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/25 8:35 AM, Eric Dumazet wrote:
> On Tue, Sep 9, 2025 at 7:04 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Sep 9, 2025 at 6:32 AM Richard W.M. Jones <rjones@redhat.com> wrote:
>>>
>>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
>>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
>>>>
>>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
>>>> made sure the socket supported a shutdown() method.
>>>>
>>>> Explicitely accept TCP and UNIX stream sockets.
>>>
>>> I'm not clear what the actual problem is, but I will say that libnbd &
>>> nbdkit (which are another NBD client & server, interoperable with the
>>> kernel) we support and use NBD over vsock[1].  And we could support
>>> NBD over pretty much any stream socket (Infiniband?) [2].
>>>
>>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
>>> [2] https://libguestfs.org/nbd_connect_socket.3.html
>>>
>>> TCP and Unix domain sockets are by far the most widely used, but I
>>> don't think it's fair to exclude other socket types.
>>
>> If we have known and supported socket types, please send a patch to add them.
>>
>> I asked the question last week and got nothing about vsock or other types.
>>
>> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
>>
>> For sure, we do not want datagram sockets, RAW, netlink, and many others.
> 
> BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
> in net/vmw_vsock/virtio_transport.c
> 
> So you will have to fix this.

Rather than play whack-a-mole with this, would it make sense to mark as
socket as "writeback/reclaim" safe and base the nbd decision on that rather
than attempt to maintain some allow/deny list of sockets?

-- 
Jens Axboe


