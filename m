Return-Path: <netdev+bounces-233157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB99C0D470
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1488B19A78E0
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFCF2FFDD6;
	Mon, 27 Oct 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLHlXzjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CE2F6198
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565678; cv=none; b=EJuhbnAZ1WbFuyRkXJCi+UxInaMvVd1P5yCP/3vFf75LRYEzQYQmX37kV1ggOUc0eqoZOaOOWyCp0xWZEhbxnza/pH+O5UiEP6kaIK7iZfKYU9j8UdwtpymBfDAMt9UuiwCSzXT9K1gC+b6cWJVs3JSPdOQkmsiXvbqZZtfZdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565678; c=relaxed/simple;
	bh=U9SNMx+fV+Va8o/LukhMQZHECepGfJmsPoivgTCQKFg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VI4CZMu0dyKDfl4bF8+JfGLWl3VfvUixVTlj7NWhdfov8iH5ixu+6lRm/3UYIC8P8dCPXj4RRjxAc9TEvuSuFNV/tGDpwmrMj5AbcAJi2NEeYU2Ga9+Xoub13IyJlYKA8r1GvWnafuioNa/j6s/xLdURsQvahV+kYKgGkOKPBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLHlXzjB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso11162145e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565675; x=1762170475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWa46kCiP/0KhlYyyl/8q2vhghsnL07ZEKG4lLnpBpg=;
        b=GLHlXzjBIPx7UnNdTuy+VeVrFcd6LOFkXVGzJWJOc6VIUUE3Nu/m/c41Zrqq+4v9lq
         Ua4ElspusDr3CQyV7aM+LYyO1SdLaTfBWyWPkni1AnT4Wld/zIbjJpkMH8+NrMM0fBMF
         4gql1UZJpuV30brQK4Y32BBYOsWX7cSU7RRIBxDdOumY/Efh877anEtDjTB1z//otlfC
         vzslgcwH3vPhEXh5Gd4F1Q/jh/dOe5GgFhoVm6PrDCSu/RzNIL9IdeGJR+Ltb1nXlLKR
         5gyBfZww28GMmEQWoYYbprpYdzVvU7uY8Z0YUmHy7ANYRRA4SwlqD6pFGNqWY4Pp44xu
         LoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565675; x=1762170475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWa46kCiP/0KhlYyyl/8q2vhghsnL07ZEKG4lLnpBpg=;
        b=LUUrKD1XNdNc11FHJzm0XEuHOAXdDCylDNL+pDMVb63nLkIPzcxX3k6XG1q58m+9Cr
         nti0EWlbVnbyxwzmUYOWWpTM0aLdDs8xBClW6TQd6zNYLZgnNMZFBr9w0Ts0kcc47guy
         kfqiI4kemkT9XOvvm7nnFudygErKl1QztMOjZDOdOOyBht6e7Hzx3jqwx5C0ybIf8YjE
         qxfwWEq2ALTBL6dJpEPVLKj8M4N2rIsNKc1xCJaFLdmxdw7m7ieTKeIxAW09DiJ7EL2U
         UK3zQgkqj1xAaAQHyDR7c1ZYSgYvCQBrpYr7k5+lA8KR4/gc7RAZGKudDLT1aorP35QU
         om3g==
X-Forwarded-Encrypted: i=1; AJvYcCXjfSQ8VL+VD/Sn9BKlyIRnKlP62WLcnJwJ6896hqhZd87JsaY/4HSasmr2anHzpcRsY5kJggc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoWAeEiSf4Ajo8cYnppbnY0jJFRyOZ4qLh/aRbcHYLL1tk8S8
	poy9dZbMDDG0zf6x3ZctQT9sLc9LzBKEeFFF65qKQ2v1ye2bxCQE7Iv6M/LvIg==
X-Gm-Gg: ASbGncuudWck1eh577bXwWIFGarveFqsWAk3ijGPdIcXuHpgKBdPOBtIaaIyNLvSrAk
	Y+z1OsIV+JA7w75hRfL5zl204knZBkO2FA/4V+HfCirgbsItE84nwbx3dKybLEcmenTZS5jA8wh
	/JHD/zGAriPU8K+6lsDu6hCJn1WuhLhdR/R4R8bodPmhlDFn0uwHEsxNuscSZKyMKre1PfOKyMM
	ngNUoXcqX6C6r1F0z9bYHNJm/4z7TgjtSd23QddVmU7evVmAILFQcfoTvvXNqfFRfRt0TvYqZ4N
	U5b0RT6STVQ7esKE8j2SIOJVz1aNVNlsKMTjOENDgBuJp+JaONzQPS7InACR5lXmLUL7YnVOlBJ
	PwbbKfUaeKTQ/BODcykSOeZR2dUPRc9rWUo9ZIuxRgQDVUYGPUYJbAVIrjr9tiQXoWi7+obgd0j
	o0lMaaKlGggk5UXmSn3aErKFw31C9dWqz8W9uQN6AgltM=
X-Google-Smtp-Source: AGHT+IFuKsBzi+0bBlURymc3hSXFC5LQaTmO0O5eBsOEF/yGhEgbbdb0jNBilwg3MuycxW+6wEs8PA==
X-Received: by 2002:a05:600c:8410:b0:477:b83:7d1 with SMTP id 5b1f17b1804b1-4770b830926mr43938765e9.40.1761565675133;
        Mon, 27 Oct 2025 04:47:55 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6fd4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d3532sm14259036f8f.20.2025.10.27.04.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:47:54 -0700 (PDT)
Message-ID: <60f630cf-0057-4675-afcd-2b4e46430a44@gmail.com>
Date: Mon, 27 Oct 2025 11:47:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] io_uring/zcrx: share an ifq between rings
From: Pavel Begunkov <asml.silence@gmail.com>
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
 <20251026173434.3669748-4-dw@davidwei.uk>
 <309cb5ce-b19a-47b8-ba82-e75f69fe5bb3@gmail.com>
Content-Language: en-US
In-Reply-To: <309cb5ce-b19a-47b8-ba82-e75f69fe5bb3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/25 10:20, Pavel Begunkov wrote:
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
>>   include/uapi/linux/io_uring.h |  4 ++
>>   io_uring/zcrx.c               | 74 ++++++++++++++++++++++++++++++++++-
>>   2 files changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index 04797a9b76bc..4da4552a4215 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -1063,6 +1063,10 @@ struct io_uring_zcrx_area_reg {
>>       __u64    __resv2[2];
>>   };
>> +enum io_uring_zcrx_ifq_reg_flags {
>> +    IORING_ZCRX_IFQ_REG_SHARE    = 1,
>> +};
>> +
>>   /*
>>    * Argument for IORING_REGISTER_ZCRX_IFQ
>>    */
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 569cc0338acb..7418c959390a 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -22,10 +22,10 @@
>>   #include <uapi/linux/io_uring.h>
>>   #include "io_uring.h"
>> -#include "kbuf.h"
>>   #include "memmap.h"
>>   #include "zcrx.h"
>>   #include "rsrc.h"
>> +#include "register.h"
>>   #define IO_ZCRX_AREA_SUPPORTED_FLAGS    (IORING_ZCRX_AREA_DMABUF)
>> @@ -541,6 +541,67 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
>>       return ifq ? &ifq->region : NULL;
>>   }
>> +static int io_share_zcrx_ifq(struct io_ring_ctx *ctx,
>> +                 struct io_uring_zcrx_ifq_reg __user *arg,
>> +                 struct io_uring_zcrx_ifq_reg *reg)
>> +{
>> +    struct io_ring_ctx *src_ctx;
>> +    struct io_zcrx_ifq *src_ifq;
>> +    struct file *file;
>> +    int src_fd, ret;
>> +    u32 src_id, id;
>> +
>> +    src_fd = reg->if_idx;
>> +    src_id = reg->if_rxq;
>> +
>> +    file = io_uring_register_get_file(src_fd, false);
>> +    if (IS_ERR(file))
>> +        return PTR_ERR(file);
>> +
>> +    src_ctx = file->private_data;
>> +    if (src_ctx == ctx)
>> +        return -EBADFD;
>> +
>> +    mutex_unlock(&ctx->uring_lock);
>> +    io_lock_two_rings(ctx, src_ctx);
>> +
>> +    ret = -EINVAL;
>> +    src_ifq = xa_load(&src_ctx->zcrx_ctxs, src_id);
>> +    if (!src_ifq)
>> +        goto err_unlock;
>> +
>> +    percpu_ref_get(&src_ctx->refs);
>> +    refcount_inc(&src_ifq->refs);
>> +
>> +    scoped_guard(mutex, &ctx->mmap_lock) {
>> +        ret = xa_alloc(&ctx->zcrx_ctxs, &id, NULL, xa_limit_31b, GFP_KERNEL);
>> +        if (ret)
>> +            goto err_unlock;
>> +
>> +        ret = -ENOMEM;
>> +        if (xa_store(&ctx->zcrx_ctxs, id, src_ifq, GFP_KERNEL)) {
>> +            xa_erase(&ctx->zcrx_ctxs, id);
>> +            goto err_unlock;
>> +        }
> 
> It's just xa_alloc(..., src_ifq, ...);
> 
>> +    }
>> +
>> +    reg->zcrx_id = id;
>> +    if (copy_to_user(arg, reg, sizeof(*reg))) {
>> +        ret = -EFAULT;
>> +        goto err;
>> +    }
> 
> Better to do that before publishing zcrx into ctx->zcrx_ctxs
> 
>> +    mutex_unlock(&src_ctx->uring_lock);
>> +    fput(file);
>> +    return 0;
>> +err:
>> +    scoped_guard(mutex, &ctx->mmap_lock)
>> +        xa_erase(&ctx->zcrx_ctxs, id);
>> +err_unlock:
>> +    mutex_unlock(&src_ctx->uring_lock);
>> +    fput(file);
>> +    return ret;
>> +}
>> +
>>   int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>>                 struct io_uring_zcrx_ifq_reg __user *arg)
>>   {
>> @@ -566,6 +627,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>>           return -EINVAL;
>>       if (copy_from_user(&reg, arg, sizeof(reg)))
>>           return -EFAULT;
>> +    if (reg.flags & IORING_ZCRX_IFQ_REG_SHARE)
>> +        return io_share_zcrx_ifq(ctx, arg, &reg);
>>       if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
>>           return -EFAULT;
>>       if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) ||
>> @@ -663,7 +726,7 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>>               if (ifq)
>>                   xa_erase(&ctx->zcrx_ctxs, id);
>>           }
>> -        if (!ifq)
>> +        if (!ifq || ctx != ifq->ctx)
>>               break;
>>           io_zcrx_ifq_free(ifq);
>>       }
>> @@ -734,6 +797,13 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
>>           if (xa_get_mark(&ctx->zcrx_ctxs, index, XA_MARK_0))
>>               continue;
>> +        /*
>> +         * Only shared ifqs want to put ctx->refs on the owning ifq
>> +         * ring. This matches the get in io_share_zcrx_ifq().
>> +         */
>> +        if (ctx != ifq->ctx)
>> +            percpu_ref_put(&ifq->ctx->refs);
> 
> After you put this and ifq->refs below down, the zcrx object can get
> destroyed, but this ctx might still have requests using the object.
> Waiting on ctx refs would ensure requests are killed, but that'd
> create a cycle.

Another concerning part is long term cross ctx referencing,
which is even worse than pp locking it up. I mentioned
that it'd be great to reverse the refcounting relation,
but that'd also need additional ground work to break
dependencies.

> 
>> +
>>           /* Safe to clean up from any ring. */
>>           if (refcount_dec_and_test(&ifq->refs)) {
>>               io_zcrx_scrub(ifq);
> 

-- 
Pavel Begunkov


