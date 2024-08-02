Return-Path: <netdev+bounces-115215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5F945733
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5023C1F240B9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AD1C2A3;
	Fri,  2 Aug 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHkf/uwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECF18054
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574367; cv=none; b=NC9ckzreC8RULCt5J50b64weXta9qwbneluF3J3uHqNYZRsNIvomgkqBhDB0Hqku25966Xn3AQd4IYZ32bzGX0ot+d4dNWh1ojJzge8q1FZaZFC5ghVM0RnE98ZLEGZ8zyM9g7NpRtduzAhVGdI8qsjt5wddpKLpbOZsJE1YY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574367; c=relaxed/simple;
	bh=/9Q/GO6DOhcl3LIdvsbvSFzhAayRRCl2Z+Qn6mC7P9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRsR6fVGPwoaVFT1MeUu+D+Woh49WY6J73WnCzYmGszvLHHT5DEKyoHuXv8OXmvSCkpZfrDhbuXJJ5X3A2EO5mCSeQx96sNdeYY+PhMaEciZPIbz5DlMF4AzqlBTQ3daEkkbhdxDxwrXXZljGa2l/1Vy4GTLxSUbHTwOlAzvoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHkf/uwg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so10736644a12.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722574364; x=1723179164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/OwP0HWmAYbwAlwncrcInrprEFEISTp1aSwrhyMmlc=;
        b=dHkf/uwgwfDKoXV+6x8JHAqYCPJoN2rSbs0A8tcklZ9Eu56Be2jThrvpWUkbVeIX0j
         /0HGbGQXh4d4BUQxFyPmn+4rHC2Y+zrhz05X17iux7Uq2Y2yfVlIXHfnvtNYqtXrYZ2A
         Jqz2ax6+kFKVRVZXMZ9m9doMJapFVxVK+Ot18XRbIdMBCyoYlHEQJgz6flMgdfc80HDl
         Dx+i85/BwUD8fRRmujOu4qxF/Egzk/Q1CFqw2kETdq/ojkgjYAkOp0slANSu3qhju3DJ
         T6lCJeNajv4HovQolS6/ooaAsOU4zrNQLoD4IQk2xSe2eNQClsphvCl65CYU+Lrr0fUk
         gG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722574364; x=1723179164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/OwP0HWmAYbwAlwncrcInrprEFEISTp1aSwrhyMmlc=;
        b=l6BeMyKe+PZcB143ZOIANRs/XzIzSY1N34VvyZD9GbWpPVCfv4xLhAbOR2V0a0VF9Q
         y1ybHG13xWnBhxIWyp1BopamrIPLiez2TF5zsQZoTo7DogYR/lOAodDDJUIf1EDiXLki
         yQ0uKhYuStT+5KmZmOTWrULf3nWc1DT/BDzsLxpvs4WdEDLqN2mMdd9P/jqrCL/9bNmP
         Zm36VO530F6U/LtSgniX2bTvHz6KWqQDTDoQxjNo2hhzjkxTRuFhrca+KrG6uUIffiSg
         kQkIVFbu3dgZscMfLmxJlUsEn+yCja8Oj2C60k40uPNS5azfuHvkGwigEqAbIYGKj5ff
         /L6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsHx9E7Utf77GFcmqVxX+jRF0ilMmbSFibV+ZVyIeB9pnrq5rym94BDr+6xVW6TwosbhKn4WII+c0B8RBj71Ypo0U0bsPI
X-Gm-Message-State: AOJu0Yy7k6zVjmi2eQ+J9/f09H2ha/dHrQ7o93nEl60eYFdoyuLpk5nj
	c70GXBU/Iktje2GxKkB7N4TxRtyZ3QnzhG6SJDbGOLQT6PiHNTtbpFliaJg8qs5cPv++4xqPAOJ
	alpE15lUxsIN/3Wi99hOXBAfJ6Pv1SvNC
X-Google-Smtp-Source: AGHT+IGVRqK+c12XxuV2yNkzKJ9OUCXIYfVjuJAyCIIcWCvKxqCAOpSznqdC86GG8uyS+RyN9HlkSPR7PlchkQbFgbQ=
X-Received: by 2002:a05:6402:549:b0:5a1:5dce:3427 with SMTP id
 4fb4d7f45d1cf-5b7f56fe9d4mr1665849a12.23.1722574364062; Thu, 01 Aug 2024
 21:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802001956.566242-1-kuba@kernel.org>
In-Reply-To: <20240802001956.566242-1-kuba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 2 Aug 2024 12:52:06 +0800
Message-ID: <CAL+tcoBNPUCCBhH_7iy4cNXQ0Mtrpe597DXos+s+NS7FVQ__zg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skbuff: sprinkle more __GFP_NOWARN on
 ingress allocs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Fri, Aug 2, 2024 at 8:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> build_skb() and frag allocations done with GFP_ATOMIC will
> fail in real life, when system is under memory pressure,

It's true. It can frequently happen under huge pressure.

> and there's nothing we can do about that. So no point
> printing warnings.

As you said, we cannot handle it because of that flag, but I wonder if
we at least let users/admins know about this failure, like: adding MIB
counter or trace_alloc_skb() tracepoint, which can also avoid printing
too many useless/necessary warnings. Or else, people won't know what
exactly happens in the kernel.

Thanks,
Jason

>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/skbuff.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83f8cd8aa2d1..de2a044cc665 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -314,8 +314,8 @@ void *__napi_alloc_frag_align(unsigned int fragsz, un=
signed int align_mask)
>         fragsz =3D SKB_DATA_ALIGN(fragsz);
>
>         local_lock_nested_bh(&napi_alloc_cache.bh_lock);
> -       data =3D __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
> -                                      align_mask);
> +       data =3D __page_frag_alloc_align(&nc->page, fragsz,
> +                                      GFP_ATOMIC | __GFP_NOWARN, align_m=
ask);
>         local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
>         return data;
>
> @@ -330,7 +330,8 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, =
unsigned int align_mask)
>                 struct page_frag_cache *nc =3D this_cpu_ptr(&netdev_alloc=
_cache);
>
>                 fragsz =3D SKB_DATA_ALIGN(fragsz);
> -               data =3D __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
> +               data =3D __page_frag_alloc_align(nc, fragsz,
> +                                              GFP_ATOMIC | __GFP_NOWARN,
>                                                align_mask);
>         } else {
>                 local_bh_disable();
> @@ -349,7 +350,7 @@ static struct sk_buff *napi_skb_cache_get(void)
>         local_lock_nested_bh(&napi_alloc_cache.bh_lock);
>         if (unlikely(!nc->skb_count)) {
>                 nc->skb_count =3D kmem_cache_alloc_bulk(net_hotdata.skbuf=
f_cache,
> -                                                     GFP_ATOMIC,
> +                                                     GFP_ATOMIC | __GFP_=
NOWARN,
>                                                       NAPI_SKB_CACHE_BULK=
,
>                                                       nc->skb_cache);
>                 if (unlikely(!nc->skb_count)) {
> @@ -418,7 +419,8 @@ struct sk_buff *slab_build_skb(void *data)
>         struct sk_buff *skb;
>         unsigned int size;
>
> -       skb =3D kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
> +       skb =3D kmem_cache_alloc(net_hotdata.skbuff_cache,
> +                              GFP_ATOMIC | __GFP_NOWARN);
>         if (unlikely(!skb))
>                 return NULL;
>
> @@ -469,7 +471,8 @@ struct sk_buff *__build_skb(void *data, unsigned int =
frag_size)
>  {
>         struct sk_buff *skb;
>
> -       skb =3D kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
> +       skb =3D kmem_cache_alloc(net_hotdata.skbuff_cache,
> +                              GFP_ATOMIC | __GFP_NOWARN);
>         if (unlikely(!skb))
>                 return NULL;
>
> --
> 2.45.2
>
>

