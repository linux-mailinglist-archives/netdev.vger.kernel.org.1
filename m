Return-Path: <netdev+bounces-133851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737459973C9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C99FB23311
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312891CEEAD;
	Wed,  9 Oct 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uWuC1gbF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16932152E1C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496264; cv=none; b=VdQVchxE4hGLf7iiPzu0hxfZE0ItdMRLmlFIsjwWJDpoP5U37ys0SezkgxADc1r8YNv/JyuCdTUy8gqix79Y9TX9c7GbO4cJAP8k97Bwq1W3qa5wxVyv08YPKY0iMC+VwKRpAvE3/LbNmhbuwEbLw0GbhpM5dMWA42Su4g+sLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496264; c=relaxed/simple;
	bh=4i36E0HSCccunx0kzjIUDX+/+nDKsSBowEeA9pn9rIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjrx5atgBHCbJXVQqZ9x6gXS4zJ+gwDgsoQrJqQpXaFeTcCNBtc8KXt8LHQbb6BZD3TcpuWYEJ272V7HewiVBSRL2iigBe6N0DizmY/Wn6EX3D/GYmFjkbCbvBiFL+IWnJZsTFKOXlnjgm9pS7X99/WhvkdpgPOB7sNE6qI1EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uWuC1gbF; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-835426c0fefso2889939f.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728496260; x=1729101060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XFwGgVNjw/cDgrOx9m5m+ogNycoQ9YJxefk4jhY6aU=;
        b=uWuC1gbF3ryzbFBBJxh++F6YmHf2u1z6olaEvMTolxCf8q9rTl7NcbWKQOJb0v0H1r
         v2a6wnr0rvGSL0QX1o/CTJQ+Y368N4GsHA1oYo5u5Dov9d4HZ/aYp65lCJCYYurJVs9H
         K5YMD9UcTQWvlV0mLq94I91F4W/weMY9bS2fwAqfcRp9JTmbEr1gKooo+Tj8WdqdzQmE
         xJ955xodcQQA40AEo5fnOmjj66aVf9O84zg4UsEdyiYknEyrLsKPg6GEPoUnz5wyvJJk
         LnBLM+cw5/DG7iEumpOsKWpzGiw0fINg65VpS1je1pqY750+sl9vdB00zpHhAZGIdvc6
         uAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496260; x=1729101060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XFwGgVNjw/cDgrOx9m5m+ogNycoQ9YJxefk4jhY6aU=;
        b=ZAX27DVCl/UWcIEs8SRyatVag68nsrN3s/lCwY2qv2QE/gXClr8WVGFJNGRDenDLig
         nF4LQAZ7SfIC361dLVpzuvs/65pZOlzpKCKBqKUcCSpd5Ytj8pyLHsMqdzBvspBbtEpP
         K+T/ph4ToCTzC06WbrXosLs5tOYonEnJTlR4ZX8yNyvIBDmWs24fCoPitt5uIwXyWlSN
         q9hWQm7CSz4gzu1kLqbbxLSQgX8gxqjE2Q0U+vddiIMLXe8/J+LglfzOGjZT/ZIPPm80
         zX158msElIabsNTeGcdDdE7xpvivr7SC8uuD2ZcVoZTOsupFiEF73sVx7671vUC2ls5H
         BpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2x9YM1QwYREtMYte1VHd15LqEnEBAAls+av+Ubuo6z5TtZgok1zU8rzzJHN055PzfPVysQCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjJHfkzjMIxwxxUtKFDiWDmoRF/OQ4aYEU/5ISwzsnRcUkdNN
	pJhm5YZxTdvtPynthN/6RPIeYkiE02rRMwrXvtukYZaK8lhc66eZqzVqdWjqFNk=
X-Google-Smtp-Source: AGHT+IE4Df99qpBr7EzorPpyTK9nax5lgyUMWyHwUmcD328v6/A4stlyvSaKLj6v7C5qL3p8pFGvpQ==
X-Received: by 2002:a05:6e02:1a86:b0:3a0:abd0:122 with SMTP id e9e14a558f8ab-3a3a71d1c4fmr4583275ab.8.1728496260028;
        Wed, 09 Oct 2024 10:51:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb35fd9sm2143665173.16.2024.10.09.10.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 10:50:59 -0700 (PDT)
Message-ID: <8075828d-74c8-4a0c-8505-45259181f6bb@kernel.dk>
Date: Wed, 9 Oct 2024 11:50:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/15] io_uring/zcrx: add interface queue and refill
 queue
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-10-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007221603.1703699-10-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 4:15 PM, David Wei wrote:
> From: David Wei <davidhwei@meta.com>
> 
> Add a new object called an interface queue (ifq) that represents a net rx queue
> that has been configured for zero copy. Each ifq is registered using a new
> registration opcode IORING_REGISTER_ZCRX_IFQ.
> 
> The refill queue is allocated by the kernel and mapped by userspace using a new
> offset IORING_OFF_RQ_RING, in a similar fashion to the main SQ/CQ. It is used
> by userspace to return buffers that it is done with, which will then be re-used
> by the netdev again.
> 
> The main CQ ring is used to notify userspace of received data by using the
> upper 16 bytes of a big CQE as a new struct io_uring_zcrx_cqe. Each entry
> contains the offset + len to the data.
> 
> For now, each io_uring instance only has a single ifq.

Looks pretty straight forward to me, but please wrap your commit
messages at ~72 chars or it doesn't read so well in the git log.

A few minor comments...

> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index adc2524fd8e3..567cdb89711e 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -595,6 +597,9 @@ enum io_uring_register_op {
>  	IORING_REGISTER_NAPI			= 27,
>  	IORING_UNREGISTER_NAPI			= 28,
>  
> +	/* register a netdev hw rx queue for zerocopy */
> +	IORING_REGISTER_ZCRX_IFQ		= 29,
> +

Will need to change as the current tree has moved a bit beyond this. Not
a huge deal, just an FYI as it obviously impacts userspace too.

> +struct io_uring_zcrx_rqe {
> +	__u64	off;
> +	__u32	len;
> +	__u32	__pad;
> +};
> +
> +struct io_uring_zcrx_cqe {
> +	__u64	off;
> +	__u64	__pad;
> +};

Would be nice to avoid padding for this one as it doubles its size. But
at the same time, always nice to have padding for future proofing...

Always a good idea to add padding, but 

> diff --git a/io_uring/Makefile b/io_uring/Makefile
> index 61923e11c767..1a1184f3946a 100644
> --- a/io_uring/Makefile
> +++ b/io_uring/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
>  					epoll.o statx.o timeout.o fdinfo.o \
>  					cancel.o waitid.o register.o \
>  					truncate.o memmap.o
> +obj-$(CONFIG_PAGE_POOL)	+= zcrx.o
>  obj-$(CONFIG_IO_WQ)		+= io-wq.o
>  obj-$(CONFIG_FUTEX)		+= futex.o
>  obj-$(CONFIG_NET_RX_BUSY_POLL) += napi.o

I wonder if this should be expressed a bit differently. Probably have a
CONFIG_IO_URING_ZCRX which depends on CONFIG_INET and CONFIG_PAGE_POOL.
And then you can also use that rather than doing:

#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_INET)

in some spots. Not a big deal, it'll work as-is. And honestly should
probably cleanup the existing IO_WQ symbol while at it, so perhaps
better left for after the fact.

> +static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
> +				 struct io_uring_zcrx_ifq_reg *reg)
> +{
> +	size_t off, size;
> +	void *ptr;
> +
> +	off = sizeof(struct io_uring);
> +	size = off + sizeof(struct io_uring_zcrx_rqe) * reg->rq_entries;
> +
> +	ptr = io_pages_map(&ifq->rqe_pages, &ifq->n_rqe_pages, size);
> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
> +
> +	ifq->rq_ring = (struct io_uring *)ptr;
> +	ifq->rqes = (struct io_uring_zcrx_rqe *)((char *)ptr + off);
> +	return 0;
> +}

No need to cast that ptr to char *.

Rest looks fine to me.

-- 
Jens Axboe

