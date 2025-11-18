Return-Path: <netdev+bounces-239498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5388C68C51
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 3D93D28AEC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB833FE18;
	Tue, 18 Nov 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJAPypSW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618A33C50C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461052; cv=none; b=PR+74OKOU8OxPuF+Y8G0qB+3GAo9uJ93c6ypLt3m6nBFgHWvZrIH4W/teoTDsVhEzDgmO6GPtCMJh0u8xW9a4SjlKu85AFbudzay9nJd9YDZ1BAH/GngGLrWb/dOhE8KYSZIpuq47ZgB9kfNKYhZOK7EdCV3V0y+7FSlZpLBhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461052; c=relaxed/simple;
	bh=WGyRfRweE8gMN9G6z26QdXogrnZa8vv3OP5CyS/P5CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAipkASFHndKoaCRYzVCVw7y/jFp6ZLMEPyM/72OelkfWH7sZT6IJCXNZW9yR3D59KjeJthzLoHhl3g2lYWeb9TIt6r03bwrDf+mmmQs4+aF6VZTDEpgv7NTfFjYJSiqbFRAmVbOBO4RpruBSsAFJ7cNFq3eaFB4Y6kcL8P5YTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJAPypSW; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so4303685f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763461047; x=1764065847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0qcjyaVhlP5nM7vHAz2cQaHwtAgAYgKJwnORS0gnzI=;
        b=FJAPypSWNasa5RPSjL7NrkYDUMjaNIC+M+ZMzRFR12yopsZ6H1KlEzJjaMFY/HnJxy
         7EsuRiapvYuLX1lqyJH7GgFMfk+MwKkK0JTL6LuyulGYzfJRwFNBJO5+BuNhwUMNdLsk
         zbmaieXCZ5wbm2BmRDss6v/3pmvGE8YugUbBLPUMLG+5O/UHfDSvd0DM2WVtuNLcBIrE
         RurnQs4Q/2KdoV0qHtAeTry1XhNkkoQnfgq+aMNwMU7Z1StbCEqpqH7U+07qhxEraEhZ
         UyiuMMlS+Ldzy3hEl44nL6dpOhTEjMGJo34Upa6y5VLQO+9eaVe/BnhHdsQH46yIvRWb
         9DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461047; x=1764065847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0qcjyaVhlP5nM7vHAz2cQaHwtAgAYgKJwnORS0gnzI=;
        b=MngDC/O+Td97DfOKE1duKtYxVYoTgrDESfA742NN+xwktjioV32wr4W2JidpSesen2
         05Ua+Y1x/63FitTcyiM8PksfiSbIQLGDxfh7ik3E3n9SXVtIGeL8rux38UPZR+0rjVKp
         JtzWvE1JVMr82thz/kZfqBvv2tz0KwQoE4olKWztdv9CCGAdUxY44MKuvkRy8/+SJvbi
         ODm4nd+jNciy7PRufh11v2gbCPbOpRkjscEZYaeNt2YBaPOseXEChvzdQ7Zy01t85vzz
         keZUqzEDNoru/yeDcF1heA55t5MMiBLL6JMu3d+nvwzH5V1tBSk6uV9DrNR+gi++a96F
         i4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsLz18jcxQdOThsJS+Pd3BPyPF10YvqBrdeP5OF4bCLi8jTJQ2YW6RC787PVcHXYNBTWWBI7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuV7SAFEo2h+NY4hRY03F69waC29wEQq8wZLKJ5oWzv3Qfq0y9
	RHyWRnVqoa4cIKqveT+lbT4m40ffqsuqvr+CwwxMw8HVxuIj4If9nc+S3Kk5H0Q2i7puONU13fd
	2tdy2gS/6VEcMePSrgn4SLZE6t2hB3s4=
X-Gm-Gg: ASbGnctF+o2b3gT2CgSA5mdee/XW+OqHAEck7YyIPDz9k7PlHxGNDJb/YDJHdD0kz7Z
	W4ZYv2n926h75ist1X2hxn9G3rrui5XxYUW9Npne0cKO/2wMl2X87gWcKzwep2vI+0gCYJ+mZYp
	zzOJrh92OdveHkAj87+uwndqG8hkQr4h0eQyLCHlEKiUCk9eWgO7n3P8I1gG9ty/FFYA39IUTRU
	d1StBw1H/unYPhyKoRGUoDL7L1jiywBZmBEzKwb9gLsNI8bLXT2nOfvJ8hQiKZ+w1cY2mkY6CPo
	lhh98rCyVjzrfWE4kuWGJrQxPHIumuN0Isdwe/A=
X-Google-Smtp-Source: AGHT+IHwJxZoUDnmazdklYmHMbP1/H4HnPJZoQbCxBJOzlKHV2m8KzkXKhpB+TIGiXcIG+3QwdTMusEsFkoig14pItE=
X-Received: by 2002:a05:6000:4210:b0:42b:3bd2:b2f8 with SMTP id
 ffacd0b85a97d-42b593849ffmr14736547f8f.46.1763461047222; Tue, 18 Nov 2025
 02:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com>
In-Reply-To: <20251117191515.2934026-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Nov 2025 05:16:50 -0500
X-Gm-Features: AWmQ_bm5b3yET3GvalhROehJP0Bxg1rdbxpkSaszeYmaUc-cP75qlrEfTxXkm2U
Message-ID: <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
>
> Locking a resilient queued spinlock can fail when deadlock or timeout
> happen. Mark the lock acquring functions with __must_check to make sure
> callers always handle the returned error.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Looks like it's working :)
I would just explicitly ignore with (void) cast the locktorture case.
After that is fixed, you can add:

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks!

>  include/asm-generic/rqspinlock.h | 47 +++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index 6d4244d643df..855c09435506 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry(void)
>   * * -EDEADLK  - Lock acquisition failed because of AA/ABBA deadlock.
>   * * -ETIMEDOUT - Lock acquisition failed because of timeout.
>   */
> -static __always_inline int res_spin_lock(rqspinlock_t *lock)
> +static __always_inline __must_check int res_spin_lock(rqspinlock_t *lock)
>  {
>         int val = 0;
>
> @@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
>  #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
>  #endif
>
> -#define raw_res_spin_lock(lock)                    \
> -       ({                                         \
> -               int __ret;                         \
> -               preempt_disable();                 \
> -               __ret = res_spin_lock(lock);       \
> -               if (__ret)                         \
> -                       preempt_enable();          \
> -               __ret;                             \
> -       })
> +static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t *lock)
> +{
> +       int ret;
> +
> +       preempt_disable();
> +       ret = res_spin_lock(lock);
> +       if (ret)
> +               preempt_enable();
> +
> +       return ret;
> +}
>
>  #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
>
> -#define raw_res_spin_lock_irqsave(lock, flags)    \
> -       ({                                        \
> -               int __ret;                        \
> -               local_irq_save(flags);            \
> -               __ret = raw_res_spin_lock(lock);  \
> -               if (__ret)                        \
> -                       local_irq_restore(flags); \
> -               __ret;                            \
> -       })
> +static __always_inline __must_check int
> +__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
> +{
> +       unsigned long __flags;
> +       int ret;
> +
> +       local_irq_save(__flags);
> +       ret = raw_res_spin_lock(lock);
> +       if (ret)
> +               local_irq_restore(__flags);
> +
> +       *flags = __flags;
> +       return ret;
> +}
> +
> +#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
>
>  #define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
>
> --
> 2.47.3
>

