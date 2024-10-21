Return-Path: <netdev+bounces-137573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E49A6F72
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9743F1C22DC2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179F71E4919;
	Mon, 21 Oct 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="A9WQkMeK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A81E47AD
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528194; cv=none; b=hLo9R5tj9jJFcYp0763eFnNWVVMsu+9aZ4giviyLSIQTfufVxjUgAEh7iTCghIq4dGQNNNV+4EFVZLeYuWJ8lMJZaPW55V/QTgzMy9oJt4p6+mjg0Ph5XOgzFFt4El+1K0/n7AG376EEOc/r7EK4zDKx+lmK0JySjrohkpZq0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528194; c=relaxed/simple;
	bh=rAW3crsY0Q2t/2QQ33fUHXBxnBiPahgRhnKxHx+LOHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mthZ0f65BMvv0k6HSyyjrfKYWv52ulECn3PU4+qzKgtIxZzRBp8PfRHPvYAUEn0PL0pqVyQuOBrTk2Kf4gTnCscJFWWza151QDNqWGC7tNLwyvdkT7w0DIZC+kJcNLHsaUaqW0/btQc7U4eHQKvZdOjt64dr7mDKbZRB7NdTJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=A9WQkMeK; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ab9445254so137558439f.0
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729528191; x=1730132991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mapVLM0am5qDLkHJ+55nJBbAeli7XgLZzqMXCAm1BqY=;
        b=A9WQkMeK3kdPiaXMpY/J3/BvnAEcB8bTfq6tY9p9nAPqhwogN29wWZfOwzcB34qei3
         iUiGYBTPeXeYqydsc/vqHplj6I8MyfTFBIajhCzml0mRTKucN4G5jJkjL75x1rnfI0wt
         DHNri8MBCaMb4w2Y4XEEdz0T1024E/yoaxfRm3015/VTatCCvfXQ8fxRXQHseLBeDZRj
         TGdvsP4dpDPoJ/2QhlHFawOgXvzcEz0ZzB/wcx+YOOiUjtBMUSKBNd8Kzo2vyl0pwxCj
         txrf9nBkWfjOvkqtw4NKb3LTgvUSaRcr92Y2jhOpCbMBlP9+2lZfM2dHJHj1LPhSdjdv
         PZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528191; x=1730132991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mapVLM0am5qDLkHJ+55nJBbAeli7XgLZzqMXCAm1BqY=;
        b=Sca4bdRnnEFmkI1ir339CSPlY2RPrai1lJ03cP+tv8SpYA6p1yls3prrdiDiMMU5cc
         Gr7sX8YF+QtGr4cbwJQ45kkN+fN2AtPE/0x/TxOdpQk9YgzYz8W16bCriYlnuA6L1k12
         PUwIXdD9Cp6qtYvZAscKf0zTW0kYnCWWvcaYFiBmNYMlkb2R/oEuKGML6B3NkTNzaIyX
         LQhn+1AYBqB/59qNQd/2JFTI+9c+Ylg/Qv7yhZejs4hpLzUXXLM6KnhRXvff6u90jIOK
         Aec3cFatK0UXHhFTgKCXIwjPTjjjwPGGvafBVpcRKf3oPglwL5YLPLOh8oekaIzG69LF
         +Y0A==
X-Forwarded-Encrypted: i=1; AJvYcCUYQ6E6H+WmqTbv70/FoAm/xM46Fx6etsaF8nTzaJ1yQZSePOHAzipC4WGIw91dWY5VOSq1AWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz276QbqMzSKUlGnrNVgLdNST/itcA4QdcG/hLtd/LR7YLPgCcf
	sJzH6Ptw2BKHdADT+d6kO0kSwYCXaHPwhscAcfBM6xOqHRG0jzYgcMDbi8mBehM=
X-Google-Smtp-Source: AGHT+IFMr2rfQejlChYoU5CGZn9QBVZS8wpg7RfINN66ckGb2iJslDRdY7eRWwuCWSodwSSIEzB2TQ==
X-Received: by 2002:a05:6602:3410:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83aba645c6bmr108767839f.12.1729528190416;
        Mon, 21 Oct 2024 09:29:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6090b5sm1088983173.89.2024.10.21.09.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:29:49 -0700 (PDT)
Message-ID: <b2810a26-7f03-45c5-9354-c8ab21ae411e@kernel.dk>
Date: Mon, 21 Oct 2024 10:29:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/15] io_uring/zcrx: add io_zcrx_area
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-11-dw@davidwei.uk>
 <3aebbd91-6f2f-4c8c-82db-4d09e39e7946@kernel.dk>
 <433d21ff-6d7f-4123-8b11-c5d3c9a9deb1@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <433d21ff-6d7f-4123-8b11-c5d3c9a9deb1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 10:28 AM, Pavel Begunkov wrote:
> On 10/21/24 16:35, Jens Axboe wrote:
>> On 10/16/24 12:52 PM, David Wei wrote:
>>> +static int io_zcrx_create_area(struct io_ring_ctx *ctx,
>>> +                   struct io_zcrx_ifq *ifq,
>>> +                   struct io_zcrx_area **res,
>>> +                   struct io_uring_zcrx_area_reg *area_reg)
>>> +{
>>> +    struct io_zcrx_area *area;
>>> +    int i, ret, nr_pages;
>>> +    struct iovec iov;
>>> +
>>> +    if (area_reg->flags || area_reg->rq_area_token)
>>> +        return -EINVAL;
>>> +    if (area_reg->__resv1 || area_reg->__resv2[0] || area_reg->__resv2[1])
>>> +        return -EINVAL;
>>> +    if (area_reg->addr & ~PAGE_MASK || area_reg->len & ~PAGE_MASK)
>>> +        return -EINVAL;
>>> +
>>> +    iov.iov_base = u64_to_user_ptr(area_reg->addr);
>>> +    iov.iov_len = area_reg->len;
>>> +    ret = io_buffer_validate(&iov);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = -ENOMEM;
>>> +    area = kzalloc(sizeof(*area), GFP_KERNEL);
>>> +    if (!area)
>>> +        goto err;
>>> +
>>> +    area->pages = io_pin_pages((unsigned long)area_reg->addr, area_reg->len,
>>> +                   &nr_pages);
>>> +    if (IS_ERR(area->pages)) {
>>> +        ret = PTR_ERR(area->pages);
>>> +        area->pages = NULL;
>>> +        goto err;
>>> +    }
>>> +    area->nia.num_niovs = nr_pages;
>>> +
>>> +    area->nia.niovs = kvmalloc_array(nr_pages, sizeof(area->nia.niovs[0]),
>>> +                     GFP_KERNEL | __GFP_ZERO);
>>> +    if (!area->nia.niovs)
>>> +        goto err;
>>> +
>>> +    area->freelist = kvmalloc_array(nr_pages, sizeof(area->freelist[0]),
>>> +                    GFP_KERNEL | __GFP_ZERO);
>>> +    if (!area->freelist)
>>> +        goto err;
>>> +
>>> +    for (i = 0; i < nr_pages; i++) {
>>> +        area->freelist[i] = i;
>>> +    }
>>> +
>>> +    area->free_count = nr_pages;
>>> +    area->ifq = ifq;
>>> +    /* we're only supporting one area per ifq for now */
>>> +    area->area_id = 0;
>>> +    area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
>>> +    spin_lock_init(&area->freelist_lock);
>>> +    *res = area;
>>> +    return 0;
>>> +err:
>>> +    if (area)
>>> +        io_zcrx_free_area(area);
>>> +    return ret;
>>> +}
>>
>> Minor nit, but I think this would be nicer returning area and just using
>> ERR_PTR() for the errors.
> 
> I'd rather avoid it. Too often null vs IS_ERR checking gets
> messed up down the road and the compiler doesn't help with it
> at all.

The main issue imho is when people mix NULL and ERR_PTR, the pure "valid
pointer or non-null error pointer" seem to be OK in terms of
maintainability. But like I said, not a huge deal, and it's not hot path
material so doesn't matter in terms of that.

> Not related to the patch, but would be nice to have a type safer
> way for that, e.g. returning some new type not directly
> cast'able to the pointer.

Definitely, room for improvement in the infrastructure for this.

-- 
Jens Axboe

