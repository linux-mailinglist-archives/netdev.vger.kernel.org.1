Return-Path: <netdev+bounces-232399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E956C054CD
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523EA4FF7C1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A6D30AAC4;
	Fri, 24 Oct 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hs1sfF9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0730AAA9
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297603; cv=none; b=XbUedxjpWfpLza4GNG+xzUjHLnxim1flLhA8qXUMFVx51JGYF2XPKeHKC+zQ9D3vDFtPJwgb4glkBmnpdPV74+/VQY7/LP1+7D1/RXhL/g/3fv3ivQmkVb0BRgNcpQFBZTqeF+wGQgsCap68RqFE/M30BavX+cB/PtHkzMx5oUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297603; c=relaxed/simple;
	bh=tj9sY++LZkzvHe1f64tI96u/mkvypwjhfSQvuJM76Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuNBFyIRUymMkuIFxl1wr/F+9g89osJUfMp4DQmv0aR9cwGv1nZ0Dy/HJly6HQhrcPp42aa/6YKE9bmv6eLy+lsSELWw2fd9K9xIZHdKLi2+cP8LycAeHRtgypz7874WZAmto8dX1M3kVgcaEI7dNUEJW6HuIpjSwbNR+dZtzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hs1sfF9M; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7f04816589bso199794685a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761297600; x=1761902400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twcKB1hm/Ie/5PoJp3KEG1N7Jytbx89hSg/ow35Xqp8=;
        b=Hs1sfF9MiKiU2UPXEjuMx0nkVjsDC3g62OD0HsNVYES4jcfe2qAuStcQyr9TDOvxfY
         Nw186GLYPWpHTTS9+whR0jcpEDggShy9+mogv1Nz6TI+np8cAkEIM3j5iYAIyPjssajk
         HFDb7wbFosnp4Pca897BC70lYKYsuPGe4WmN1FJaVmadoIfdi5C5Ra2I/Z/OqAyfcEfw
         Cyb4S9HwuInB453VlgaiIfFCt9QnkywIYbpfi2LTKrHFtQbM6zdU6g+r4Ka8a9hDHIwA
         gzaEZ/JVs3D3lunEZ5QnybHa3X42HnCjvZflITIj3jA7L1dctyQESgO070wREtrkr+jh
         JKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297600; x=1761902400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twcKB1hm/Ie/5PoJp3KEG1N7Jytbx89hSg/ow35Xqp8=;
        b=ADTABk/QB83F2dyzHRxlv96huKEhjcwgKby6r99JldfjGykS0UuYJwvoENCnJISm35
         zVMWKfNW3NBwzqRb82pf61ljVldOmGZBv/jOBeAO3M1Mnu3taNh5nko/0bhqXS30Ht+9
         ehBplOw9+4MBvfFUWJ8cpVK3kZDGymdWguWA5baeRPTqVGNzv71sdfSpYoxFqDhFUYDA
         EqbyX5rQfArU/pRtSxyfAZz4lqehr+ra5sv2/+WAKNufdjMkVghQAG/5NoezdapLdUgV
         HVDANuhKYycbp/4eiiYOm4C/f09rJfue1E9djKzkFyJeB6bgWGWHrNFCnOsdpQ3dSP+1
         OqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXsphYw5iIEI2FBq3apnyMb5GSijE1FrbzvXc1vsNl0sdrBpxeC5AIOjuETpvbR8zSPW9lpUL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEESdlJwb5WP/dO69dzk5f+0bsuOLgVfnl9Y7mUlXXJo+Kku05
	VJ7Lq7Ib6gFjBncl66W9YNhsR1eWyK68PyzzZC3fQy9cMR3d+acrX2dvVVhobQBNtQ/UuhOYKos
	kOHQQZnA8WPIniO4rHu8U6fJ12SyZq6z3dWQE5d6g
X-Gm-Gg: ASbGncuKlQNzIZMvp3Iha3A6jO4Mn9WIN85oE5BryybKLJ5lRANK3ziAlp7+bLiuPta
	YIp180jshmz7wTWerYMEN9v81mRgG36WEQtMhfJQKLZl450JwRJkch72gqMXxkMnhd5YgiNaFjF
	v8Lg5nMKgdK2Xp1riYEkB6MVuxE1Vzbf7yHsRUxkXnXjZQjLztd54RRZMA2qWJ2KKLx7Uf3ePNM
	loxrZY+gVa4Uk/ugYOon0axz2A8EpY2a1FYw7mCEFeP4E0vMg0MZNJwBf3XOW1l2M+yog==
X-Google-Smtp-Source: AGHT+IELThhQ8ILVw5nuo5976ycY9bB+OZ/LcmK2ueQZ09CwFSYkjJaTgg0wCVkT81qczhOxurRBwaO1v9J6HO5i8hI=
X-Received: by 2002:a05:620a:31a4:b0:893:b99:7114 with SMTP id
 af79cd13be357-8930b997cabmr2102715285a.82.1761297596672; Fri, 24 Oct 2025
 02:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024090630.1053294-1-lizhi.xu@windriver.com>
In-Reply-To: <20251024090630.1053294-1-lizhi.xu@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 02:19:45 -0700
X-Gm-Features: AS18NWDEKpX6DxQFX-E95G22l0XMZHGoUhV3IsKo9AGOEPWAGImfkcQ19Hdmzz8
Message-ID: <CANn89iKS3ZOSva0EUjLFD+CmJeT=JgX3-7bHxgHChMMQpx+7=g@mail.gmail.com>
Subject: Re: [PATCH V2] net: rose: Prevent the use of freed digipeat
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: kuniyu@google.com, davem@davemloft.net, horms@kernel.org, jreuter@yaina.de, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:06=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2=
.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat=
,
> a UAF is triggered.
>
> To avoid this UAF, defer the put operation to rose_t0timer_expiry() and
> stop restarting t0timer after putting the neighbor.
>
> When putting the neighbor, set the neighbor to NULL. Setting neighbor to
> NULL prevents rose_t0timer_expiry() from restarting t0timer.
>
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_a=
x25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
>
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>
> Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: Putting the neighbor stops t0timer from automatically starting
>
>  include/net/rose.h   | 1 +
>  net/rose/rose_link.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..ecf37c8e24bb 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -164,6 +164,7 @@ static inline void rose_neigh_put(struct rose_neigh *=
rose_neigh)
>                         ax25_cb_put(rose_neigh->ax25);
>                 kfree(rose_neigh->digipeat);
>                 kfree(rose_neigh);
> +               rose_neigh =3D NULL;

What is the purpose of this added line ?

@rose_neigh is a local variable. Setting it to NULL while this
function no longer uses it is
going to be optimized out by the compiler. Even if not optimized, this
has no effect.


>         }
>  }
>
> diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
> index 7746229fdc8c..524e7935bd02 100644
> --- a/net/rose/rose_link.c
> +++ b/net/rose/rose_link.c
> @@ -43,6 +43,9 @@ void rose_start_ftimer(struct rose_neigh *neigh)
>
>  static void rose_start_t0timer(struct rose_neigh *neigh)
>  {
> +       if (!neigh)
> +               return;

This will never fire. callers would have crashed already it neigh was NULL.

> +
>         timer_delete(&neigh->t0timer);
>
>         neigh->t0timer.function =3D rose_t0timer_expiry;
> @@ -80,10 +83,12 @@ static void rose_t0timer_expiry(struct timer_list *t)
>  {
>         struct rose_neigh *neigh =3D timer_container_of(neigh, t, t0timer=
);
>

Can you explain (in a comment) why this is needed ?
What is the precise scenario you want to avoid ?

> +       rose_neigh_hold(neigh);
>         rose_transmit_restart_request(neigh);
>
>         neigh->dce_mode =3D 0;
>
> +       rose_neigh_put(neigh);

I am pretty sure this patch fixes nothing at all.

>         rose_start_t0timer(neigh);
>  }
>
> --
> 2.43.0
>

