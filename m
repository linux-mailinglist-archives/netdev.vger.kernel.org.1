Return-Path: <netdev+bounces-238907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477BC60E36
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 02:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 31346241E4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 01:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B41DFDE;
	Sun, 16 Nov 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfqG6LuO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C635CBC5
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763255312; cv=none; b=mDVF3r1xyiYzAmWMED+5EqaIXbk68DTHllhGSA7pUKLu1f4Yc5JNKwqsqz3Falz/EB2t8YDmfX/YXQdJfR++b0PcDSs17UzBiLht/Anj8kRtNUd36YiHyaKmC3dBbquoXhBp2cYqo26775Tc7AD5IgUulAIcWMEvUINwVuL7RSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763255312; c=relaxed/simple;
	bh=gymZunq3ztjTX2tDOwRswf7M7gjU58xCtU93U59orx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUhEsHUSnGY3WUy5ckXAZRGHawmUWzlAWUWiPHOyR4oEP86FzMEb2OiY8x0Si7j0GBQ3sEXBdUYrvFTJu2KBaL4FRoTO35aHpLGCoOjythVPGCjUr4mlG7tPAMlum38n3MD8xQPOeuf8bCR+9MHIZmPdD14LJndC10tEbOWczNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfqG6LuO; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4336f8e97c3so27577115ab.3
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763255310; x=1763860110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL3u+BBPsl4zXBqOXf7sCWnLpw1c6IddzzOF6gyZC6Q=;
        b=mfqG6LuOtjaPxJjxHc9C+zNyR24a5dr3Aiq10ocHOGSnF+xzIfNDlq9PvxIU/4NzDC
         BP/VCbliiuYwA8Mn5aeNR3PiBx2kxi9PV9UtoV5eAt+AjSulMrtiLFokSQaIazCb+DxR
         kAttLkNoXi+JuWKEGtoxaDRcDxdfCjxPOmrHWFTOUCfbbcajeU+dlx/x+GygqalHmdhM
         SXbxiFOnnGjzFqFAGMCRbQQmijknnyXlAy9SlQEqZdd1h9ojDszuaZUWDxitzz54/8Hn
         JIG9u0ul49wUj3kLeldpCG+xIAUTZoFsmvTOr4Ky4sD4v6JCASjbQWlpq5GrtYbV9XgL
         ORPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763255310; x=1763860110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DL3u+BBPsl4zXBqOXf7sCWnLpw1c6IddzzOF6gyZC6Q=;
        b=QCUbPygJo8NcOYy0QlNynh1Sh5ihsGd5ZlJxhRHe/fiBAR2JxHONYZDsN73pwTPQS1
         ENkPtKr3pRvIY780pTvTv8G7+guHV/DyqgaNN4qefnNllHxR2t5hNZjq5v2pb5z6F/Bq
         Sy6lZVlmeJ0giTRTBp1qV3JWjh84Kcyr5USuPt1iFjCngBOh01hsK88vQ4jBBVSjGVFj
         m04LPet/WzqTYkK5SQ59x06/JQhyTvTz0GxWQkqqG02vy7BNfGXv9MyZma+L+YRoVLqx
         2yNQA05fz0ci4Y+usbjmvPYsUcKZ537YhDy+DdILJySKuLQm/+UC0NCmHifZwGGblf9a
         y5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCULeH2G5abvYIvfRYrBJbDUFnvmxKHyd4G/Nr11czPTFPU12I7nzu+NrHfkW0jZ//I7W8vSgEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDY51wN+Sh4LnytjkyNQIC/95NGiyPyFGIfFfP1HcoIHelp94x
	KKqrh7c6QIUUmsnDBCIqlMYzbTlWEZIV9QChPWOqrHIF7iFjkQaBPhFStb2RScvl3eMHYzAEwIN
	RR4WtvqZ/EEDGRxpXg0E95OyRtqTE2nQ=
X-Gm-Gg: ASbGncsL5ze0YvmoMhIcoiBZ8YWtXOVkoQ1u2hKCCpf4ijnMGW9kZhKI0GByMhhNYO+
	+1C34L3Fgsc9n8BEHZkrb2IHBwu7Ukv8RQpKC0Ya8T3UMs8wEVryfAM8UerVA9vP2A2NgOF1HrJ
	MSTR8FJkwP5HetaULvMGWLJjhiWTlJbKzit866krKkQWJMUxWG4oREpvLifYt70mJzB9HGtO1IS
	/WdTGx/+JzagQHVKRxFNk5VLnsymUZUXUv1K2m+sOVS635PC4b1HOBrOpu22t0=
X-Google-Smtp-Source: AGHT+IEVOxO7i1rsULg4ASQaC7ScDou2N3DXE16FWmTGhHwOaHa6bRuYC6D/qxKJLyQuYUN+xgShQ5qcawdTXV+2whc=
X-Received: by 2002:a05:6e02:1542:b0:434:96ea:ff79 with SMTP id
 e9e14a558f8ab-43496eb02e3mr82737015ab.33.1763255310012; Sat, 15 Nov 2025
 17:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114121243.3519133-1-edumazet@google.com> <20251114121243.3519133-3-edumazet@google.com>
In-Reply-To: <20251114121243.3519133-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Nov 2025 09:07:53 +0800
X-Gm-Features: AWmQ_bnVlRbgFRVODceR9HNKa4S1efXTTfnCOp8UhHGvsLEYunEZIX4igFdvaKo
Message-ID: <CAL+tcoCdLA2_N4sC-08X8d+UbE50g-Jf-CTkg-LSi4drVi2ENw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] net: __alloc_skb() cleanup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:12=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This patch refactors __alloc_skb() to prepare the following one,
> and does not change functionality.

Well, I think it changes a little bit. Please find below.

>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/skbuff.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 88b5530f9c460d86e12c98e410774444367e0404..c6b065c0a2af265159ee61884=
69936767a295729 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -646,25 +646,31 @@ static void *kmalloc_reserve(unsigned int *size, gf=
p_t flags, int node,
>  struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>                             int flags, int node)
>  {
> +       struct sk_buff *skb =3D NULL;
>         struct kmem_cache *cache;
> -       struct sk_buff *skb;
>         bool pfmemalloc;
>         u8 *data;
>
> -       cache =3D (flags & SKB_ALLOC_FCLONE)
> -               ? net_hotdata.skbuff_fclone_cache : net_hotdata.skbuff_ca=
che;
> -
>         if (sk_memalloc_socks() && (flags & SKB_ALLOC_RX))
>                 gfp_mask |=3D __GFP_MEMALLOC;
>
> -       /* Get the HEAD */
> -       if ((flags & (SKB_ALLOC_FCLONE | SKB_ALLOC_NAPI)) =3D=3D SKB_ALLO=
C_NAPI &&
> -           likely(node =3D=3D NUMA_NO_NODE || node =3D=3D numa_mem_id())=
)
> +       if (flags & SKB_ALLOC_FCLONE) {
> +               cache =3D net_hotdata.skbuff_fclone_cache;
> +               goto fallback;
> +       }
> +       cache =3D net_hotdata.skbuff_cache;
> +       if (unlikely(node !=3D NUMA_NO_NODE && node !=3D numa_mem_id()))
> +               goto fallback;
> +
> +       if (flags & SKB_ALLOC_NAPI)
>                 skb =3D napi_skb_cache_get(true);

IIUC, if it fails to allocate the skb, then...

> -       else
> +
> +       if (!skb) {
> +fallback:
>                 skb =3D kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA,=
 node);

...it will retry another way to allocate skb?

Thanks,
Jason

> -       if (unlikely(!skb))
> -               return NULL;
> +               if (unlikely(!skb))
> +                       return NULL;
> +       }
>         prefetchw(skb);
>
>         /* We do our best to align skb_shared_info on a separate cache
> --
> 2.52.0.rc1.455.g30608eb744-goog
>

