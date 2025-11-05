Return-Path: <netdev+bounces-235817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E89C36103
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 145CC4F2274
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525032A3E5;
	Wed,  5 Nov 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLWiJu/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94A12CDBE
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352797; cv=none; b=f3mx7RN6cf7uyI/z3suc8VEiuTdwXj4S5EeRo2MpcadJAqkqiOJmzMKk482Ekx/pIvbnYeNxgCahdAgpXOZZQlPE2em2azo+HsVIXtZshVjbKTCbfNl10NRwZzKObN3rMCjoNoA3BrgPwbdEhCHK0Q66rW1mnUdBKD11oKa/ffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352797; c=relaxed/simple;
	bh=UNLeQYL51m+DVasBcWR7PNTrx8XW9tm4YcPbq3YJCTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DC/SJ+1/7V/EwsWmoeQup6ONas/XIcuGHmsrckPjlT8MXysepPaWm/yPzIu5WMFXErKb5QQB37KDVaYAgcTHf4Qjp3jpNsh068crtf+ky54NhpxWVtZcbpd20wDqvnRfj4N3zrytuQ2Qd6CEbQcMhgLWup8+f6Evf+LV0NE0va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLWiJu/C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed612ac7a7so22507321cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762352794; x=1762957594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn1Akn56TAK9vxYVpNAmwzoyFjP8WhPaxNLUGZGYjkM=;
        b=uLWiJu/CoXQzzp40yTT9Q02+Yr46Xz5hL6nHYdW8LNVCbBaT1XWa/CmfAcBlhLb1bg
         77lz7tMA5pk12nds7S0eNIJ8PnapTj6d2LYNkYSTWSpfttWWg4UOGRsAKg/kv9XfIDq+
         Zfd42QumaLkTDJD3dQ4PSmehIKfKkPfV2TiWLRenRLUMKS+oEBbsvaPWdfiPm9EDnhG0
         uJzLbhoyha2mQOqitlyEjw8K9UEXFhdGUjWj6DuW7CHIj/2BxX1UQQexRkjfzg/WxI5W
         Yt2IGmhBYbE8LqTJzbmWfFC15/a/xj/RhLDs8w7sBS5yFWu/klp4Ld4ciVlctYE5X6DH
         tlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352794; x=1762957594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn1Akn56TAK9vxYVpNAmwzoyFjP8WhPaxNLUGZGYjkM=;
        b=JfHA9hdHdyxG9fFlk9WnEOwVXkNm0ALZZAmEpaNzShF8yeS1bTV5b0gJA33HOZAt7t
         D1w5KOQ2/g+DlCalUI1Gydzqna+Eu7lRXis8FWqWtMLdiX/11Dzoi0npjXHPZYSHlRhX
         drrS5EwCTRMm/ciHtzEMVA7to1IV+bdC/nXvKRXlytMGRRTglQZktsMwAqJkaJ+vB6qK
         QMMC/HMkYzxHMcSGMADE9J8CWS0m+Vcm7mph9KSRVajMnpVAlJTNRx7B0JB6ZGCwZbgd
         R8CehluHlJcfgmBguvkKAbo549xdtuldj10Pa9jymeRwFmTze+AkVGdRDxGbNDnNIvbD
         CPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeeYYo6CepyFJJmHQbylK0EDThZ/oWrwncDK3qPsDsW4lp1/6Vc8y9RV555/H6FPEIcZSPHAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxytM7LPyBmdv+rbCSR7xqX4TduRTRib43af1VW567pmeApKgOQ
	shejZPzEsW25tJXpOhKcb9WdFkFXjnQQCDxSILRUznDmj6bGAtKwQz2j8bjvX3Lg+8syWkV6JPp
	ntrbj5fv7lufqhP/R7Cm3YszAVU10IDw5JinQg3y/
X-Gm-Gg: ASbGncu6HxR3aYjWQ4gJXl97EmF3pm57gwvlHESg3st0NFgX7gzabf6EHDcm9V6NUBB
	B7YDcGk0HZ4skP4yGKDdbf17QIqNVgBlSge1o3IIj0knFrlFIga68QaKU7W0hCf4Vx0bS1BMHIh
	cq4zZLBAuqAnbrToyrXB+Z5UbsPcMBjLkX85FH0F78o1MOk3Ei1sdnuMaVY4aoxPx7z6zpV0jZ9
	f/HE0bL3xKtmKSqNHboK030KWZfZNOdUfYjkWdlAK5CpPBP+4MTZJXTEt2XL1CTVVJpwx3HzrCA
	aMz9yA==
X-Google-Smtp-Source: AGHT+IEyRyguqmLTVuV/+p4rWmG9dIhs2YGO8hfZ3uT7d0TjJn2hFD71728jqAvX+zyf0Qlwg6ZcF52UU2ueLDMEGK4=
X-Received: by 2002:a05:622a:1cc3:b0:4ed:42ba:9bd5 with SMTP id
 d75a77b69052e-4ed7262edbcmr35915681cf.72.1762352793343; Wed, 05 Nov 2025
 06:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
In-Reply-To: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 06:26:22 -0800
X-Gm-Features: AWmQ_bkdl5RhKS829nQ2M5b3RoWq2JzXUH6E0i1Wig8_xYGoL3cCA0DzQqGNDNg
Message-ID: <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: chuang <nashuiliang@gmail.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Networking <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com> wrote=
:
>
> From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2001
> From: Chuang Wang <nashuiliang@gmail.com>
> Date: Tue, 4 Nov 2025 02:52:11 +0000
> Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebind=
ing
>  stale fnhe
>
> A race condition exists between fnhe_remove_oldest() and
> rt_bind_exception() where a fnhe that is scheduled for removal can be
> rebound to a new dst.
>
> The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> for deletion, but before it can be flushed and freed via RCU,
> CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
>
> CPU 0                             CPU 1
> __mkroute_output()
>   find_exception() [fnheX]
>                                   update_or_create_fnhe()
>                                     fnhe_remove_oldest() [fnheX]
>   rt_bind_exception() [bind dst]
>                                   RCU callback [fnheX freed, dst leak]
>
> If rt_bind_exception() successfully binds fnheX to a new dst, the
> newly bound dst will never be properly freed because fnheX will
> soon be released by the RCU callback, leading to a permanent
> reference count leak on the old dst and the device.
>
> This issue manifests as a device reference count leak and a
> warning in dmesg when unregistering the net device:
>
>   unregister_netdevice: waiting for ethX to become free. Usage count =3D =
N
>
> Fix this race by clearing 'oldest->fnhe_daddr' before calling
> fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> setting it to zero prevents the stale fnhe from being reused and
> bound to a new dst just before it is freed.
>
> Cc: stable@vger.kernel.org
> Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")

I do not see how this commit added the bug you are looking at ?

> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  net/ipv4/route.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 6d27d3610c1c..b549d6a57307 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> fnhe_hash_bucket *hash)
>                         oldest_p =3D fnhe_p;
>                 }
>         }
> +
> +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> +        * rebound with new dsts in rt_bind_exception().
> +        */
> +       oldest->fnhe_daddr =3D 0;
>         fnhe_flush_routes(oldest);
>         *oldest_p =3D oldest->fnhe_next;
>         kfree_rcu(oldest, rcu);
> --

