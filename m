Return-Path: <netdev+bounces-193842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC3AC5FFD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3281889631
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212351E32D6;
	Wed, 28 May 2025 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0d1Qa5uG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEF1DDA09
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402508; cv=none; b=FeJgVNrqsnwmJYgl/V8ES8+Ka19IcRZe86iJetVuXC0WPnbTfj5QJMrvBYN0SpZ4yrPBLMBuGpXCmGh4gg81knuP1Vb499YODgtHNoDsGIroqwnEvQZX8npXGbG4hSvmMgvyRBknpJAnJXVLttory/UBH38XXZqjUKCIZArF8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402508; c=relaxed/simple;
	bh=NCjG12I8e9v4tbFYWsDY0jzDx/gYU5XqMSNRRjnDooE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLxFKwcOSrEU6wGWoFWbCwmBiFKGVQZ+xAfUIcTXd3pWSMP4D5ISynh7eR9csD98wDcc7pmVW7g2gU3ud76klCeSVKB7i4sNhvSHrvhKTRDTQoAS6PB8ODiG3esv83hcb3q5O5YSsmeEkWTbRxa9LlPaSBLtUPlu14QpzXZ2Hxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0d1Qa5uG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231ba6da557so81495ad.1
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402506; x=1749007306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhQg5ilX/7ks5QXGrPE6JGn51EXjxRWzA8aArpEVP8o=;
        b=0d1Qa5uGmSoUTHlwR2KqteuJH/C36jiGYEJEqY1hCEEA/pi1+q9moPlQJDbkDMUV3p
         2wYOqbO8duI/ZbnjxIGat5VLNAyXAqGXI3IQaUaWATnbjB5EeUmsumvh0ydB1+7I+3Sv
         n2jc4+kAXWUcg9zjk7CcRd9jziT8cGLvaVX6xaZRVlG593jZVpR98mRorOv3WmdkDeoL
         fzdNsnxly4+wsN9EYrPdEB33lDRTwkiE70n+/3NKdxLG7MoR0Rl1xdZDLJbVoA8uK5rl
         s1m9VJn6zPN/cQk3d8J884MdaBIh2iJGhdKfN0MzK+3k8d0tIFeqr26fdrj2PBtTuhVA
         hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402506; x=1749007306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhQg5ilX/7ks5QXGrPE6JGn51EXjxRWzA8aArpEVP8o=;
        b=EQ6tq5ySUq/Kn2BUgKfJ4VQVRHCkdD5Ykq2ZCbX2J7zTZZnADNkIej3CoN/NgvR3c1
         lBxgSVoKi+EgwyulH+8OdQQ32k4xrGVfrs4qhBmWEkmRWeWzhsxvKZpdNYtPBaw03lMC
         6uTyktsjzp69xcPjp4md6gcffeH/DNQzL7ezxb31MoZiN/C364Vzrc31TEQGRZFIXfk1
         L5WYU3MODZofrLqgZLGe+O2r/RORoyotQe6z8cWHyUBCPvrJQsIr56/8+u5aRN0x3Z/3
         vPx8xbBBAStp0aqLcU1JA/Gh4oGTlfZ17AG8EtZd2mrF0x57wB3xlTIfox0H3g+qstYE
         WkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyBm1wRelitQXChoZfmjCj6UPhX0mdRTPD8OQYwDozng2zXMqJyg3yquCbnXGQ0PIlYro5Qbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR46PVonY/FauCGU66OZUNnMkXt4/GYQ4XQDSZ2Xcz9UiLLURM
	QERpzLYxVJGSoTLFjSr0xI7ZliWZzMXY+iAbkMu+pDpX1bSp1YSuorGtwjWz4Sm1tw/3czqrKGb
	ERc9BEvMwu4mt1CYJEFfXwjfUQrsrZ2V8rGI+x0ok
X-Gm-Gg: ASbGnctkDjLXIBsctQ3Y8SANVTwR9QDImB6pj+dL4zZcMKdwyhdZMA6o4VLrvoNqE4A
	DeyYR49XygT9uxwagwp73y6VA+8RZDNxxGXOoIaUNj4NBuWcs4qEzOgLaOlL0fZiaopnT0of00E
	0BpR8iruc1wkmPkwsIZodSxpqJOfqO0IbkmkLeRAQWIKxe
X-Google-Smtp-Source: AGHT+IGZGnQ5Nmgjax4hfouh4pp4GgqporWXwvbytliAh+njgVO1gpTaYGIF9zH1gwkhGw9nWKCJTA0EdVPWxStUTNs=
X-Received: by 2002:a17:902:d4c2:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-234cbe4f90fmr1102095ad.25.1748402505375; Tue, 27 May 2025
 20:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-9-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-9-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:21:32 -0700
X-Gm-Features: AX0GCFuYtIrmK-Wu9BHLQmtJy90lb0ReYg5ZuhjcJ5k8V6K_B7GDLKrd1odKdxE
Message-ID: <CAHS8izMmsHa4taaujEbTK5PM+APYsRJzv1LqGESJf2x6BRnxag@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that __page_pool_release_page_dma() is for releasing netmem, not
> struct page, rename it to __page_pool_release_netmem_dma() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/page_pool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index fb487013ef00..af889671df23 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
>         netmem_set_pp(netmem, NULL);
>  }
>
> -static __always_inline void __page_pool_release_page_dma(struct page_poo=
l *pool,
> -                                                        netmem_ref netme=
m)
> +static __always_inline void __page_pool_release_netmem_dma(struct page_p=
ool *pool,
> +                                                          netmem_ref net=
mem)
>  {
>         struct page *old, *page =3D netmem_to_page(netmem);
>         unsigned long id;
> @@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_pool =
*pool, netmem_ref netmem)
>         if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
>                 put =3D pool->mp_ops->release_netmem(pool, netmem);
>         else
> -               __page_pool_release_page_dma(pool, netmem);
> +               __page_pool_release_netmem_dma(pool, netmem);
>
>         /* This may be the last page returned, releasing the pool, so
>          * it is not safe to reference pool afterwards.
> @@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *pool)
>                 }
>
>                 xa_for_each(&pool->dma_mapped, id, ptr)
> -                       __page_pool_release_page_dma(pool, page_to_netmem=
(ptr));
> +                       __page_pool_release_netmem_dma(pool, page_to_netm=
em((struct page *)ptr));

I think this needs to remain page_to_netmem(). This static cast should
generate a compiler warning since netmem_ref is a __bitwise.

--=20
Thanks,
Mina

