Return-Path: <netdev+bounces-233560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D372CC1566F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46BF135510E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867782E7BAA;
	Tue, 28 Oct 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+BLODnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938F23E355
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664939; cv=none; b=fatxvfvEQG9m9e6KURxVGA9Icd1SjQ05R5yamSk640B2byFnx77M1LFxCGNzkNdmEvNvGmThZEAwJXLUjGh9aH5a6vQGUZsRDBqQXMrFC4w148SR7mQc+nAZYXeWj2CJBH3lxecq5a+ruwBEkghjnqh0O+I0j7qIocVyBqS17Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664939; c=relaxed/simple;
	bh=bZ55QK+UJTgOBscIivnjq8lKsYP/XcmuAJEd7jZIHFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcdTkRi2mI/BrctPHBhf4SjqJyLBFXwCqBM57xqjWNx2M2dmxJlxASBdZ7R91QsxpkzDYPSssCs0iH0yFMAWj34BoRH0sPvRK19gWaRw3knKQO03ajskihcyYGO/TSFqDqUzStaW2d81O/e/WJBDIdSBMi8C10OoZdH9SEbsCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+BLODnj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dd559a83so20346945e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761664936; x=1762269736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOG8l11v2spqZc+zU8CHcKzAc9L+U6Lb+jKyLh1lIIg=;
        b=d+BLODnjX1DWgk11JzX68j64oS35IM0vYfrAFWzBw34swFOxNo7gUAvHb1ZAl4HS6x
         ZttrKI0f05MPjIb86xsBRLGR6hwwBhFJLeVVcXRSI61zNTAP19ZJ44jjXR1ZWjG4HGZw
         nT3UdNsqvA6+LhJUw8EOhVeaEVYvLhuGoNUr8Rty4+R8aoEIhMZYsqtQ3WB6HnffiRcZ
         Fj5Cd4EOtae91td8DcIskeGR5G9F45fBnDDMYtaRl+/wrfops37BG8IE8DdwuA04erCV
         e+SxeMcdQf8oyLeS2n+E7j4pe8eW/UaNZu1ZlX7tGjQIb7l3u6oygVNjVPtbs6Ssb7zM
         AVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664936; x=1762269736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOG8l11v2spqZc+zU8CHcKzAc9L+U6Lb+jKyLh1lIIg=;
        b=hEINOMElZmpKqfLm5TLPwPrqg18OMDdKX9P4UGWzz8CYqHPvFylV68QUIUacspwi6J
         MNXaurKaGnvoTw7OMA5xRGF84B0EUrUqFtt+YjrR7c1QRcpGStZ/ZDhn9MOL0AEhwVl3
         u7r/dJ2qEfkeKxyakLln7QnWsA5XEaTegFGSqyItP94fD7o4nEo/eKL7TKuEYheY3dGz
         Q+a75jUVlDahAwfwdpbPB03Aaf9e1wz7/f0G6UQi7HBaF5wv0okNqQCXzAa7AHWkaDq9
         j9YGEt6KPg/pEalHsNn/+aO4x7haKd65yeeZn7cMb+6j2vJXxSpFsjXyRlVrIGE1Ar75
         UsOA==
X-Forwarded-Encrypted: i=1; AJvYcCWdUyDuZ/b/QxTCRYOJPdK2iA1Vv1KJfkp9MVCHKx9IR3/4ptSpjr8weBMMnAmL8uFaXnw1ZzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYW3QCx0wfxk0xyH7Xk9FrJqm6JHMZTBt2URGrIsXAPjiw7Yd/
	QE5dNk7NRg6IuUvDEMGVN84nuAlKhEVvemKDS7PxYrYCdFlTXloK5gmA
X-Gm-Gg: ASbGncvwASPt17OBR3QLf2L5yTKPeH41X09KJTwIRPNoqNpO/atZ8IK5zn6dQ7FabII
	OZaf3G0wGH3DTOESNGYGZ7G40q3BtMlOQJdU/gDoFL6wQI21hXACHlPxEkbEdeP+1QdoYtZvoy+
	ZOkQqh5SoU71sMPVQYahgU6C+lgKtUsQF3+Nu29ILkc0dzZCe3o/8s3hexNTWTk2BYO9i6zXS4F
	vEBr4qItCQC+FhzvEva0P0/X0TMMv/XHKBnEcUTPHrIg4NAdxPYhAqbPzpgWz8rCVSPliJqd1bX
	WQqDmiJ56U78sall7d+Hso8o7/h0V8UKzjma8O62mzi3tU0hJzj36WDzNUZQGJtbS9IIsT1abYU
	vRJ2KtFEsv7Ss5pCwPugySuxYUuAc0jCtlFYO/Z8SPnmwPlPEBn+iaYhDw2nUj9T5xGPaSq+Enw
	WVh+qFgvJKsrgbQrDpTGCoY4K2D+mnqsoCp+0U8L9IGRLUHAZZzXM=
X-Google-Smtp-Source: AGHT+IFRElJe62Xb8s7qSrjr6kyFkD31Ah3etFBxj6GTGAkmpSgwGWXZOzawiteETRfJZI44QPlxIg==
X-Received: by 2002:a05:600c:354c:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-47717df8437mr38712565e9.3.1761664935742;
        Tue, 28 Oct 2025 08:22:15 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd48942dsm204991395e9.4.2025.10.28.08.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 08:22:14 -0700 (PDT)
Message-ID: <4efc2d91-49df-4606-894e-92ac89c3ae9c@gmail.com>
Date: Tue, 28 Oct 2025 15:22:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] io_uring/zcrx: share an ifq between rings
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
 <20251026173434.3669748-4-dw@davidwei.uk>
 <309cb5ce-b19a-47b8-ba82-e75f69fe5bb3@gmail.com>
 <acb27d6b-5602-41c8-8fe5-4e88827713a4@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <acb27d6b-5602-41c8-8fe5-4e88827713a4@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/28/25 14:55, David Wei wrote:
> On 2025-10-27 03:20, Pavel Begunkov wrote:
>> On 10/26/25 17:34, David Wei wrote:
>>> Add a way to share an ifq from a src ring that is real i.e. bound to a
>>> HW RX queue with other rings. This is done by passing a new flag
>>> IORING_ZCRX_IFQ_REG_SHARE in the registration struct
>>> io_uring_zcrx_ifq_reg, alongside the fd of the src ring and the ifq id
>>> to be shared.
>>>
>>> To prevent the src ring or ifq from being cleaned up or freed while
>>> there are still shared ifqs, take the appropriate refs on the src ring
>>> (ctx->refs) and src ifq (ifq->refs).
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>> ---
>>>   include/uapi/linux/io_uring.h |  4 ++
>>>   io_uring/zcrx.c               | 74 ++++++++++++++++++++++++++++++++++-
>>>   2 files changed, 76 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>>> index 569cc0338acb..7418c959390a 100644
>>> --- a/io_uring/zcrx.c
>>> +++ b/io_uring/zcrx.c
> [...]
>>> @@ -541,6 +541,67 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
>>>       return ifq ? &ifq->region : NULL;
>>>   }
>>> +static int io_share_zcrx_ifq(struct io_ring_ctx *ctx,
>>> +                 struct io_uring_zcrx_ifq_reg __user *arg,
>>> +                 struct io_uring_zcrx_ifq_reg *reg)
>>> +{
>>> +    struct io_ring_ctx *src_ctx;
>>> +    struct io_zcrx_ifq *src_ifq;
>>> +    struct file *file;
>>> +    int src_fd, ret;
>>> +    u32 src_id, id;
>>> +
>>> +    src_fd = reg->if_idx;
>>> +    src_id = reg->if_rxq;
>>> +
>>> +    file = io_uring_register_get_file(src_fd, false);
>>> +    if (IS_ERR(file))
>>> +        return PTR_ERR(file);
>>> +
>>> +    src_ctx = file->private_data;
>>> +    if (src_ctx == ctx)
>>> +        return -EBADFD;
>>> +
>>> +    mutex_unlock(&ctx->uring_lock);
>>> +    io_lock_two_rings(ctx, src_ctx);
>>> +
>>> +    ret = -EINVAL;
>>> +    src_ifq = xa_load(&src_ctx->zcrx_ctxs, src_id);
>>> +    if (!src_ifq)
>>> +        goto err_unlock;
>>> +
>>> +    percpu_ref_get(&src_ctx->refs);
>>> +    refcount_inc(&src_ifq->refs);
>>> +
>>> +    scoped_guard(mutex, &ctx->mmap_lock) {
>>> +        ret = xa_alloc(&ctx->zcrx_ctxs, &id, NULL, xa_limit_31b, GFP_KERNEL);
>>> +        if (ret)
>>> +            goto err_unlock;
>>> +
>>> +        ret = -ENOMEM;
>>> +        if (xa_store(&ctx->zcrx_ctxs, id, src_ifq, GFP_KERNEL)) {
>>> +            xa_erase(&ctx->zcrx_ctxs, id);
>>> +            goto err_unlock;
>>> +        }
>>
>> It's just xa_alloc(..., src_ifq, ...);
>>
>>> +    }
>>> +
>>> +    reg->zcrx_id = id;
>>> +    if (copy_to_user(arg, reg, sizeof(*reg))) {
>>> +        ret = -EFAULT;
>>> +        goto err;
>>> +    }
>>
>> Better to do that before publishing zcrx into ctx->zcrx_ctxs
> 
> I can only do one of the two suggestions above. No valid id until
> xa_alloc() returns, so I either split xa_alloc()/xa_store() with
> copy_to_user() in between, or I do a single xa_alloc() and
> copy_to_user() after.

Makes sense, I'd do splitting then, at least this way it's
not exposing it to the user space for a brief moment.

-- 
Pavel Begunkov


