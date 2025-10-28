Return-Path: <netdev+bounces-233544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632FC154C6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85B35653C4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2133509F;
	Tue, 28 Oct 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tzwMF8yJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB53093BF
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663310; cv=none; b=Ztz0lmih/Lm46w4pceirRPGRZb4b/YiWLA+QHODeUB71otTwpMnLvhkCOZ9OpT1lznPqXytmQ/malSBQz10Aomq3FbA5n6Dzq56je6+8oom/kC13FweD1/lVRQXp8a36Ec16ZpUopw1j3bTFmTHDUz2c+SbBjq65FD2uWKuDcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663310; c=relaxed/simple;
	bh=2I0r3P5d/UEBH1YdN21pkRqapy66sLLhaClEI6Go1So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1lnFU8rrzPt46/PIUIHSrEPffmxsq3dZfvWoztfO4vmIrjCFfjsn4weiTKaH6u4NLYDKiLyF5BjWJ3BUS8mBnXo5zfkkleCbGfGBqNeL3RU8YWVeuubtngkQfXfhuCYm+IUm8LPwdD1J1+iV6iuWoliVSF/gqdFngUT4UTq79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tzwMF8yJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so4800934b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761663308; x=1762268108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwvZrAciGHwI1h8u17a83XAFIwPrzerC9qrqBkMWNZs=;
        b=tzwMF8yJT2U2YHyTyyTetizmvJ2U6Fl5+d3r+SsXVXdBcaXXTjhbbLm13CeYykf8DK
         mTo1QNJi/18c68Fr2CByx/pdfgTaIXdr6hJIisIVUOsbXtIWyNu1po3i1nnXjZgozB5P
         XWfQuHS5Af/5Df3F88z0r/FxyJMg34jZqaFIwt1lJJBeFSr4rLiTGnq++9SN+c79GEEa
         HTbLo29TEH32uH0oon+QEc/EV6f8Lie2YcyCSX3LQ+V9jChykF/K0MtFaFOM4Z4fcJDx
         /Ehr2aJDgXG4ve7+1s5OcJiApWNP76ozgvvMF7TiOEuUlnPV59iZolnQRtX5i9MqOQLf
         0ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663308; x=1762268108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwvZrAciGHwI1h8u17a83XAFIwPrzerC9qrqBkMWNZs=;
        b=NXGJbuEn0NBVAjjo2jG6bwNNru2w49j7DvGLl0AZe4D0cWdBopO3laUHGj/9hP7gRM
         fiHTFKExCtzHXnmdI6ufUC4dc9OvtG0zhHk+D7DiIKqVF4CJvkYIrTmw9FFS7e4IkF2l
         4+QxhG9BDuaz9utq0/HbEUUgEQQPJ30SqanbPBcSxubs7F6HaM5sR+Sv8ODet4bZUzvd
         nkHBRtZl4xZxvlc+VsghdNNPJ82YJzB3s72m1EqnZjxVFgtCFO48+Vr3Jvl2C2e6y4b6
         OnaKKmLZ2HPANZBS/P8RLFMOuKMU686yA7qNWU98j7s/jRzy1aykBEQ3eFN+EbXd6cIp
         ACjg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZsE5x6MLGXn9OG8sMdhCq39JDC+H7CknpZG+yMeqoqu/3WEZ/4ZrIC3GuepR1/SWRj6xJtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EBvwNlBRFCrzxh5WxOrTi4oefdq95lFVdta2TILk6kVux4hJ
	lJ7rz5daTcqsImRJg2ACqVp5FVeNPoZpSKZXmx6QfeRookYB7YRdZJa5ds4LBE5GZFGyxYE1MHi
	sTTZdaVI=
X-Gm-Gg: ASbGncsv3I5AZmnrrShTAsz0mp0jkITH6Hmm/4Y4WD+iOGMbTXUlkl60yzoKbWYx8DE
	mTrZTCMn039rlvenBqAUjhuaWu47wRHEpXyb2i+wMkqYqmRbMSBBsrw+uYpLEnCtRJtnxOyZB+c
	oeI1laf/somTpjcTNnbFSkA4GlflW9swRxwrnTh55ZasS1jUxwliSTe+fnuyJYh2dc2XZG0AmEo
	iwj1vdumk9Cury+jH2Dgdr5eHEsRdnMJn9r0tCVDEggAoYG5fPRtwqGrJaLSNowdQovygtjBhA5
	X3Y18ItV+AKr1lRI9i5yFqQMa5XT+1czZb/yuLiBgUb4ofi3Enb+M3ghnScJMQ/rOeDciGB/0Za
	PGfXl7u5yc/aAxhAF1A7iS9cPXrl74S7FWZZ9+tDiGoqhkdyztsCaQ7u3NhO2AyPYi7xumgfUwf
	0Q6+Y4CbOTVR8AaEqjKrDGzRhcMGctnXbYMh5tV2/I4AozM5WtSX9sTUZBZ8GrAm6EvMSM
X-Google-Smtp-Source: AGHT+IFWbRWnVFeLrjtUwkkq1K+AnwY6DsQ7gjIkcTS8ifjEkI+SBL+0e17TgDEmuII0v6e616PBgA==
X-Received: by 2002:a05:6a20:e212:b0:33e:779e:fa7f with SMTP id adf61e73a8af0-344d1d98e48mr4993022637.1.1761663308489;
        Tue, 28 Oct 2025 07:55:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm10469726b3a.3.2025.10.28.07.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:55:08 -0700 (PDT)
Message-ID: <acb27d6b-5602-41c8-8fe5-4e88827713a4@davidwei.uk>
Date: Tue, 28 Oct 2025 07:55:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] io_uring/zcrx: share an ifq between rings
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
 <20251026173434.3669748-4-dw@davidwei.uk>
 <309cb5ce-b19a-47b8-ba82-e75f69fe5bb3@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <309cb5ce-b19a-47b8-ba82-e75f69fe5bb3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-27 03:20, Pavel Begunkov wrote:
> On 10/26/25 17:34, David Wei wrote:
>> Add a way to share an ifq from a src ring that is real i.e. bound to a
>> HW RX queue with other rings. This is done by passing a new flag
>> IORING_ZCRX_IFQ_REG_SHARE in the registration struct
>> io_uring_zcrx_ifq_reg, alongside the fd of the src ring and the ifq id
>> to be shared.
>>
>> To prevent the src ring or ifq from being cleaned up or freed while
>> there are still shared ifqs, take the appropriate refs on the src ring
>> (ctx->refs) and src ifq (ifq->refs).
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   include/uapi/linux/io_uring.h |  4 ++
>>   io_uring/zcrx.c               | 74 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 569cc0338acb..7418c959390a 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
[...]
>> @@ -541,6 +541,67 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
>>       return ifq ? &ifq->region : NULL;
>>   }
>> +static int io_share_zcrx_ifq(struct io_ring_ctx *ctx,
>> +                 struct io_uring_zcrx_ifq_reg __user *arg,
>> +                 struct io_uring_zcrx_ifq_reg *reg)
>> +{
>> +    struct io_ring_ctx *src_ctx;
>> +    struct io_zcrx_ifq *src_ifq;
>> +    struct file *file;
>> +    int src_fd, ret;
>> +    u32 src_id, id;
>> +
>> +    src_fd = reg->if_idx;
>> +    src_id = reg->if_rxq;
>> +
>> +    file = io_uring_register_get_file(src_fd, false);
>> +    if (IS_ERR(file))
>> +        return PTR_ERR(file);
>> +
>> +    src_ctx = file->private_data;
>> +    if (src_ctx == ctx)
>> +        return -EBADFD;
>> +
>> +    mutex_unlock(&ctx->uring_lock);
>> +    io_lock_two_rings(ctx, src_ctx);
>> +
>> +    ret = -EINVAL;
>> +    src_ifq = xa_load(&src_ctx->zcrx_ctxs, src_id);
>> +    if (!src_ifq)
>> +        goto err_unlock;
>> +
>> +    percpu_ref_get(&src_ctx->refs);
>> +    refcount_inc(&src_ifq->refs);
>> +
>> +    scoped_guard(mutex, &ctx->mmap_lock) {
>> +        ret = xa_alloc(&ctx->zcrx_ctxs, &id, NULL, xa_limit_31b, GFP_KERNEL);
>> +        if (ret)
>> +            goto err_unlock;
>> +
>> +        ret = -ENOMEM;
>> +        if (xa_store(&ctx->zcrx_ctxs, id, src_ifq, GFP_KERNEL)) {
>> +            xa_erase(&ctx->zcrx_ctxs, id);
>> +            goto err_unlock;
>> +        }
> 
> It's just xa_alloc(..., src_ifq, ...);
> 
>> +    }
>> +
>> +    reg->zcrx_id = id;
>> +    if (copy_to_user(arg, reg, sizeof(*reg))) {
>> +        ret = -EFAULT;
>> +        goto err;
>> +    }
> 
> Better to do that before publishing zcrx into ctx->zcrx_ctxs

I can only do one of the two suggestions above. No valid id until
xa_alloc() returns, so I either split xa_alloc()/xa_store() with
copy_to_user() in between, or I do a single xa_alloc() and
copy_to_user() after.

