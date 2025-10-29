Return-Path: <netdev+bounces-234039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BE6C1B9E8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C14F334A5F3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AF2ECD39;
	Wed, 29 Oct 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ZYqmWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89A2F7442
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751380; cv=none; b=b1bJMKoEMrzB6IB8F6w/dOMUpkJjMBUTbsKquWr0L9z/HGCsGfk3LNaVFopi+uwVWVwGipb+n5xyyN7J+iODQ9Bj3bfGQy11onWNxXSCLc9/+b4PQB8w+nMy3ZrFfWT8dKiK4df5FSXA48U5BRuae+pNcj1Hjn3Ji3CDxAAbcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751380; c=relaxed/simple;
	bh=GtXC8erq36iSAapayiGu69TxnlBUrsJsa3Oudd2SVys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn3vBnZQXeCC6hXWSqabM+3UvsEuJFyVv8cE/wS0/x10FQe/bxgRewenQHNeKFqugkfZzRcw4ZOd67MA55If4HSXyhsAEeYBxYd0+R83VJII4TiRL7AVyKp6ygSpx4JSnGsGI9P1QS9hW0/DfWuRAySihAomrXK8Fw5vmXUJOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ZYqmWy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso4524089f8f.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761751377; x=1762356177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmdYFPKBcg7OGgRd9/hvgQp4eKPVwVTBM5CS8RfXTdU=;
        b=V8ZYqmWyGpjS73+zF50jL+zS/Jmi3/G5bBI3CHPsX09oE0QAt93mC1J3eEjzzgfqij
         fSDYjyiw6t1/Ce8Kr2oprxRLVsfBwwmvT6Y4zT70tbiuVaVjuPGpYoenCBz3HNh379hV
         3Dwyeiz7QTPs7jfM2UhJSu7RVAMbHVnRvHldIS0vMf6ff5BPbOakS+8JMjZktc7utnD3
         qPrfj5xfVMpc/mExro17+3SJ9iVowKMHS9gK3rPDquN8unqTwJ7RKDS3dgPCdWkJFQR5
         WKzwKAWsqcl0HC2vGhXgOGhcApNOUrvnuFR0Nu6+HVnpH75Qs5x8Q/pYf2Akl/VfJNXh
         6Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751377; x=1762356177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmdYFPKBcg7OGgRd9/hvgQp4eKPVwVTBM5CS8RfXTdU=;
        b=Yqtu24r7VkD0IOOZ05+jZdGF5rQOc2+DKVH/YqBJffOomplAe4YWQFg+2GvI6KKEH6
         PGPOL6NJ/+um2l+U9u4fR6zhEBYy/nYrsmfXNcGrA/dTpSEDyjwB1/tsyNcCFbt6yzah
         gk34TPrratZ3XQhVDxW8wk1SGqNNBCr9pmxeZDzBGNhpsRHqPS9sQmyvD1+B1S7jKhp9
         KNmKiS31HvrmZV1xExfFZeDk4TtkdUgC4Rx75t23teu7FKmtsNC9cxZGaGq4yoq1qIBK
         AFOh+51lYNivK/RYRpnLthbv1nQIs9O5uOc/Z9eHrmwRO64Tx/kFa6ElrPQBTRos1kNf
         HrDg==
X-Forwarded-Encrypted: i=1; AJvYcCVctkoR9AvD8ef/sxxT4dQMBe/uM8dhqzhlxmRSTFc1JX4cR970rUYAB0Wm3mHs4TO7YNiwGE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlVPMc/nc2UuTCjVnjWNf0QBNJso8cY6LenfI7+77CauD/3tv
	QHgsIgZhyXYR1npCaS+4S3BJzqjr7iqWy0xufN8Chzzkh/P8S1Ah075qt2RANQ==
X-Gm-Gg: ASbGnctM0H88wPwMTzJg2HUfz84OJWOpHcSMMeM1Kk/gu7JxjuT7UmEhtxApx1WUyZi
	F5X8IqC4U82i5yZWvJ1kmrfo3W7oqNKB6FPVRZtUXlPCiZ8ppXIFwtZN/WGn9xTLoFTHQ0jGTy1
	dxmm8E43RGHh2VlcS2YZZ4oXM8twFULo/0PHYMtqE+qvtTk9vIhzMHZoWBLgqNNxrbPUxiM1kl/
	UNyg4lp3DHR1FMEXtvMI7+0kHQEmWpZQZ7qshLe+eKPptN7GjPuYzPvczL6QnWDK/BXx63ikrS7
	s0XrMkjgJho8LOQxLzG9sK8CiGLysMtPbVf6BH02EhaJ/LvT8Bo9FPlyk5joeALBD0+kDq6JDtO
	zC9vtBmW6jDayQeJLw3B81SvQQokZR8VWMLvTBJ9NE6Y9zzRWEMgLTbcpNREN8yNMk4ht+rubh7
	h+DGv9QDuLoIbEeMfVF8SCwhDkUW10hT8N1lJMFXq2Z5AbQzHNcvY=
X-Google-Smtp-Source: AGHT+IGu7XLsfPxYqrqrfvCELtshLC+TIylBQZBtWjeuQPYR3cRQl4cZDx73hKggNF7h7MylW6+mQg==
X-Received: by 2002:a5d:5887:0:b0:427:7cd:7b1d with SMTP id ffacd0b85a97d-429aefbdf10mr2781055f8f.40.1761751376488;
        Wed, 29 Oct 2025 08:22:56 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e2e06sm26985958f8f.46.2025.10.29.08.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:22:55 -0700 (PDT)
Message-ID: <810d45da-7d60-460a-a250-eacf07f3d005@gmail.com>
Date: Wed, 29 Oct 2025 15:22:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] io_uring/zcrx: add refcount to ifq and remove
 ifq->ctx
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251028174639.1244592-1-dw@davidwei.uk>
 <20251028174639.1244592-8-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251028174639.1244592-8-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 17:46, David Wei wrote:
> Add a refcount to struct io_zcrx_ifq to track the number of rings that
> share it. For now, this is only ever 1 i.e. not shared.
> 
> This refcount replaces the ref that the ifq holds on ctx->refs via the
> page pool memory provider. This was used to keep the ifq around until
> the ring ctx is being freed i.e. ctx->refs fall to 0. But with ifq now
> being refcounted directly by the ring, and ifq->ctx removed, this is no
> longer necessary.
> 
> Since ifqs now no longer hold refs to ring ctx, there isn't a need to
> split the cleanup of ifqs into two: io_shutdown_zcrx_ifqs() in
> io_ring_exit_work() while waiting for ctx->refs to drop to 0, and
> io_unregister_zcrx_ifqs() after. Remove io_shutdown_zcrx_ifqs().
> 
> So an ifq now behaves like a normal refcounted object; the last ref from
> a ring will free the ifq.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   io_uring/io_uring.c |  5 -----
>   io_uring/zcrx.c     | 24 +++++-------------------
>   io_uring/zcrx.h     |  6 +-----
>   3 files changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 7d42748774f8..8af5efda9c11 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3042,11 +3042,6 @@ static __cold void io_ring_exit_work(struct work_struct *work)
>   			io_cqring_overflow_kill(ctx);
>   			mutex_unlock(&ctx->uring_lock);
>   		}
> -		if (!xa_empty(&ctx->zcrx_ctxs)) {
> -			mutex_lock(&ctx->uring_lock);
> -			io_shutdown_zcrx_ifqs(ctx);
> -			mutex_unlock(&ctx->uring_lock);
> -		}
>   
>   		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
>   			io_move_task_work_from_local(ctx);
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index b3f3d55d2f63..6324dfa61ce0 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -479,7 +479,6 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
>   		return NULL;
>   
>   	ifq->if_rxq = -1;
> -	ifq->ctx = ctx;
>   	spin_lock_init(&ifq->rq_lock);
>   	mutex_init(&ifq->pp_lock);
>   	return ifq;
> @@ -592,6 +591,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>   	ifq = io_zcrx_ifq_alloc(ctx);
>   	if (!ifq)
>   		return -ENOMEM;
> +	refcount_set(&ifq->refs, 1);
>   	if (ctx->user) {
>   		get_uid(ctx->user);
>   		ifq->user = ctx->user;
> @@ -714,19 +714,6 @@ static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
>   	}
>   }
>   
> -void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
> -{
> -	struct io_zcrx_ifq *ifq;
> -	unsigned long index;
> -
> -	lockdep_assert_held(&ctx->uring_lock);
> -
> -	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
> -		io_zcrx_scrub(ifq);
> -		io_close_queue(ifq);
> -	}
> -}
> -
>   void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>   {
>   	struct io_zcrx_ifq *ifq;
> @@ -743,7 +730,10 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>   		}
>   		if (!ifq)
>   			break;
> -		io_zcrx_ifq_free(ifq);
> +		if (refcount_dec_and_test(&ifq->refs)) {
> +			io_zcrx_scrub(ifq);
> +			io_zcrx_ifq_free(ifq);
> +		}
>   	}
>   
>   	xa_destroy(&ctx->zcrx_ctxs);
> @@ -894,15 +884,11 @@ static int io_pp_zc_init(struct page_pool *pp)
>   	if (ret)
>   		return ret;
>   
> -	percpu_ref_get(&ifq->ctx->refs);
>   	return 0;

refcount_inc();

>   }
>   
>   static void io_pp_zc_destroy(struct page_pool *pp)
>   {
> -	struct io_zcrx_ifq *ifq = io_pp_to_ifq(pp);
> -
> -	percpu_ref_put(&ifq->ctx->refs);

refcount_dec_and_test + destroy. Otherwise, seems like
nothing protects it from going away under pp.

-- 
Pavel Begunkov


