Return-Path: <netdev+bounces-233623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B82C166B3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EB534E4983
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8CF34B1A7;
	Tue, 28 Oct 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0tiKs/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74934A3A7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675314; cv=none; b=DLJaeBgWQfliuVJ5EVL7KqKAHQO52VPWgpRhBMhuOBwDkxs4ba83dR77WRawQ9eCALa0qymA1pHEGZ8o8eeuyVaCcc39dYTS9WV8TcMrS6/0G27Acc6uujrjhpq8fcDKJbMYRzWcf6uIkipmqb6WumS+gZt6Lpnr+vKA3WpUfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675314; c=relaxed/simple;
	bh=zcodzi+mOUD575N1xZUuQjOVYQWEPdnlbLws09uvbS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoklD5If+NCZ3T5b4dz/vBbn0zrsA3luxUDwXWWu9G1yGf8koGcLvbvOybwUx1ctzOb3hpWI8Rkgw4AeMgJLgOiOgp7eHv3GzHGHwBudIjVCN/+7fZmXLaR9ymyJkLvkj7YBHvFRDkTaL7VXSflD1N4XGKzAz3CQkvd4VpzRMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0tiKs/r; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so1835a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761675310; x=1762280110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90CnYkLqp/HfEgrb/R2001RwImjbO3xI814fyvRa22M=;
        b=r0tiKs/rZibsCd8ahmR55owTUYeh6bHRd4nIwH2ileRjsH43Rj6/yZUkEq+eF0foBy
         CJ8Q9CGGDLvFdnpJwEKb7cXwmpPkhHY/rCa+5SGuRBEwWnmnDRG2l+yB1hzEIzWcg4+d
         cC8OS7Eiu2IymWkMiaaRrJhqwQZG+DaemBr1t97Doqa/IOMnEL53zosbK1EQwUjOsU4I
         EMydPxhrkIETG+gT5AFyAWGT3Xpa8SlLaFJWxhO+pBxg7TEUm9U6nORo+fDirsPmvpM2
         d8R3p0GQrcBVR1Riz2kVknfwL7O6RMQ3VBKjmrdeXBHFSHMAC7ic7LqOzv6k5QnSaCrw
         /3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675310; x=1762280110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90CnYkLqp/HfEgrb/R2001RwImjbO3xI814fyvRa22M=;
        b=W5TWNaO72By/vfpiO1I6azSh1tPRtQG/vk84NmmHkxj6tGabi2G0bnjpguinFFwJDI
         ookqbyssAqmFDStXYeSfiNZPE0a4jTBdlYEvGTUNRnQHxjXOrkHwpX1g8kiizuvJfUmz
         jVC4BQ7AmAEdPthdfaRRrYLBmHq6mLk7O/Cp11jZGJJua8clN44MQKjlxldmzyF+WB8O
         V3WE0vpGF/7uGUYTU16EYgRlmILjcbbLt67RCdyli8rXLQbeHa9ncg64bOXTtmrPJK/O
         eYWVO3D846I8JMa2Zo+WqIDZpeRvCEFrPINHY7AcAv2L0+3eqcZ8NTkVOOwhegL8l+eg
         SdZA==
X-Gm-Message-State: AOJu0YwLRJUN/IqUPZo66U9f+PXR2ay6yIteMQVOdQRa+GYFfYI5XqJ+
	WvB1TRPPswBTFSop4+mWwmuLN9RnAydMBLyLW0xJWENGDeDiKRJ1L6YvDJgmdGZlMn9VwCsmG4P
	ApwsU7566vHVPfBhXQADLuflFvY09VGP/h2zNWEUQ
X-Gm-Gg: ASbGncvUlxaQhAkVz04qUSQYrRPb9nzwSeN1re+EvBnJfHHjCyxGKheeKLZBniVuTIH
	mDc7gedBl6+TvMjhAsLvnE6BRKezbIk8nnu7tYRYu1cPoS5Mj8uktEr+XjRsH4kMo+T+wvNSVKE
	rmwkuI7s2ypfVDFJGTY4VcwgI6FNeIscnnC0GyLdTUxNIdDCbXCUVKCSMvj2NAP7UAanJhds7sb
	B4wv1Fbri9p1W1kxKTMcdNTJPRDHRDFenG5YlYPyA5VNicoYyv1xbXCXBiKZDbZemTMrUbFGJXw
	zj5gGeiI
X-Google-Smtp-Source: AGHT+IFGnyCN3zgN8K6ce1633alPnV+t1u1HwJdU9ixfZelf0wNhCjeSiC9lfXC+1TzDuDePP/xzY2NeqRfJ0sklIhc=
X-Received: by 2002:a50:f69e:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-640427a26f9mr16444a12.0.1761675309791; Tue, 28 Oct 2025
 11:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028060714.2970818-1-shivajikant@google.com> <aQEHQReSmbXeIw15@devvm11784.nha0.facebook.com>
In-Reply-To: <aQEHQReSmbXeIw15@devvm11784.nha0.facebook.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Tue, 28 Oct 2025 23:44:56 +0530
X-Gm-Features: AWmQ_bk9Ft9L4-npWFOyIyWZjKp1gH6GTtSfFcauCkHpz5Kyx8u4ygXXvXcAjdA
Message-ID: <CAMEhMpmUxn2VS2T7PPaM0WtbJT02RWN-CEmD8dmsPGFPkH_tqw@mail.gmail.com>
Subject: Re: [PATCH] net: devmem: Remove dst (ENODEV) check in net_devmem_get_binding
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pavel Begunkov <asml.silence@gmail.com>, 
	Pranjal Shrivastava <praan@google.com>, Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:41=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
>
> On Tue, Oct 28, 2025 at 06:07:14AM +0000, Shivaji Kant wrote:
> > The Devmem TX binding lookup function, performs a strict
> > check against the socket's destination cache (`dst`) to
> > ensure the bound `dmabuf_id` corresponds to the correct
> > network device (`dst->dev->ifindex =3D=3D binding->dev->ifindex`).
> >
> > However, this check incorrectly fails and returns `-ENODEV`
> > if the socket's route cache entry (`dst`) is merely missing
> > or expired (`dst =3D=3D NULL`). This scenario is observed during
> > network events, such as when flow steering rules are deleted,
> > leading to a temporary route cache invalidation.
> >
> > The parent caller, `tcp_sendmsg_locked()`, is already
> > responsible for acquiring or validating the route (`dst_entry`).
> > If `dst` is `NULL`, `tcp_sendmsg_locked()` will correctly
> > derive the route before transmission.
> >
> > This patch removes the `dst` validation from
> > `net_devmem_get_binding()`. The function now only validates
> > the existence of the binding and its TX vector, relying on the
> > calling context for device/route correctness. This allows
> > temporary route cache misses to be handled gracefully by the
> > TCP/IP stack without ENODEV error on the Devmem TX path.
> >
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: Vedant Mathur <vedantmathur@google.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Signed-off-by: Shivaji Kant <shivajikant@google.com>
> > ---
> >  net/core/devmem.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index d9de31a6cc7f..1d04754bc756 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -17,6 +17,7 @@
> >  #include <net/page_pool/helpers.h>
> >  #include <net/page_pool/memory_provider.h>
> >  #include <net/sock.h>
> > +#include <net/tcp.h>
> >  #include <trace/events/page_pool.h>
> >
> >  #include "devmem.h"
> > @@ -357,7 +358,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_bi=
nding(struct sock *sk,
> >                                                        unsigned int dma=
buf_id)
> >  {
> >       struct net_devmem_dmabuf_binding *binding;
> > -     struct dst_entry *dst =3D __sk_dst_get(sk);
> > +     struct net_device *dst_dev;
> > +     struct dst_entry *dst;
> >       int err =3D 0;
> >
> >       binding =3D net_devmem_lookup_dmabuf(dmabuf_id);
> > @@ -366,16 +368,35 @@ struct net_devmem_dmabuf_binding *net_devmem_get_=
binding(struct sock *sk,
> >               goto out_err;
> >       }
> >
> > +     rcu_read_lock();
> > +     dst =3D __sk_dst_get(sk);
> > +     /* If dst is NULL (route expired), attempt to rebuild it. */
> > +     if (unlikely(!dst)) {
> > +             if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
> > +                     err =3D -EHOSTUNREACH;
> > +                     goto out_unlock;
> > +             }
>
> Echoing your discussion with Eric, I think the message might want to
> call out this part. Besides that, all looks good!
>
> Pending that nit:
>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Best,
> Bobby

Thanks Bobby for the review.
Will surely update the description in the v2 patch.

