Return-Path: <netdev+bounces-229099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4EBD82C2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AABA4ECCEB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703F30F945;
	Tue, 14 Oct 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHQHXUxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8430F937
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430448; cv=none; b=FMu/SML1gkwUBWg8pmYPY1AiAWRaMRJUPjZI9OpEZl/VPTyocnBPTWjugjd8CQvoXaCNg55MG/6Rt8ir59Q5kG6RczVr4NVE8rbjI9O4ovFfb+m40HyhSqd705osUaJThrk/C/kpsCKFl8OpohzlwSvjo8Fimr9eRxnky2FY2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430448; c=relaxed/simple;
	bh=K84EjEhf0h/bYUMH127PKABNYAUmSlPeAQBRCe81/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIWG4bsXwMVMAUoPiyUNiBMm9PXTORawvafyiMfNEXtTx4xHYWjC4jH+fYLY/Q05idEABITKCXqPSTGm1LuBVeoVnV/SkcfFeAKqtRTBFIb5oprNL0FRUofo0ep9FB5B17r3JijpOgEjeQGHv+OKf44AI/HUjupxQUlpe7clyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHQHXUxW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-856701dc22aso718435685a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760430445; x=1761035245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmGWIGmWbe+QDeaI/b/uAmC+5E4N4/LpsA0dDJg3tr8=;
        b=EHQHXUxWWmld1a16fJpVmRoRiV+5I+WHnJ0M7m7VQgkaYlj7YfPspbVMEXokHcpPwj
         nsVRmP+xU4kuAKKBNItP1scmZ9wS6JJhIXBkbjmW6GdqJMFv8VIIWfRaPANCVH+TrDrY
         VzsK9y1yFNWsZGLtwo58udIEdxpYKmp/2zSikdzdVMVzddOSNR/L9swFJYyn/2UCbYUc
         /95/A2wpAXVtG33HGQo1eX2762IuVRryn+MrefS2LUQYv1B3qCf3AP3UOHLm+AtIu9Vf
         jJb/c+5PnYZuMrn72oxeb0B5eGBKXxc5fSYveBJTJfx2PbcfSfWOua6shwnpHEoSUCgn
         QRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430445; x=1761035245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmGWIGmWbe+QDeaI/b/uAmC+5E4N4/LpsA0dDJg3tr8=;
        b=RG4+3+Uxhn2ZhVMEfpL5WY0xSHSJUpK2Vs5Ln+LfOmrhu0tJQubKm4l1vwd2TYywQo
         pCFFM/R7NSiBhjn86aDKU+M8L12Hy1YJcwFJFV6tXLk3zFXlz2StTGerT5/uMg3HBWcP
         pMOl4u+p+Xboul7U8hulrJZX3J9xSpCkG+QJ/xyN1gbCK/KXRpcCMMAANeHkUQUQ9yx/
         N2zdibEbeNnk9JUQyUb/umjeP88GKbX7AZY5SPjNNVZdKqyPFAA0PULtTE9h2Qi/ZdMF
         mp0vEHC+3gny4Pbl4l8QC+X6ynCr1hEdlLkps5yoyccD6omj9l9axUjMDxf5KHdZFhkT
         KESQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1JGv5Ssx7uLZwLe221Lygz1VPh+wM/MYlygUZpEC5yTSExSHgzgHMk3jKkgQnQZZOFeB3fUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvq9f2+en973ilq2iPutacRwgBDEGvBJATxb+1Z0QFxAATauhI
	3+v5urbKCifCr+JYg4TsNhPReAO+GOioy7it70TJE935jDGNex7ufkK++IDiS8Qa5uVlfywDcHY
	qV0DNYhR/2s4goJGyt47uX5plFEzj3+nrzInUkurB
X-Gm-Gg: ASbGnct8jgezK/SC1qe60hGYIZT+Sukh7J2s8GUgO00X9/Dp9q5SMQQdS1aTbPhTPpq
	3PaTMSccmJNuxRWIZSyupvbdhNxwwjMOgblZphjiOBRtd5QcVup8tcoUClzQhmtlCvXZjv219vw
	o3BDcl1N+wzSrtJ0JTCh0sUl07HcjQjF1288BQnXBUC0F38/eFDPVqLPW3AtweFJyJ8MXSR7HC2
	xqH/VFvWuzOnaiSJ86rBZMZIxIhpQl5tPe3GwnGE9ptmGYg4ZhJcg==
X-Google-Smtp-Source: AGHT+IHDPqHCKTjvmfmzMQilHwvJB2Y2BEEfnEh7nscvZH8lI2kesitwhJakBZDNaTHNi+MJjNyZPEACGDcUDfN+KZw=
X-Received: by 2002:a05:622a:7e09:b0:4e6:eb5b:beba with SMTP id
 d75a77b69052e-4e6eb5bd42amr249534601cf.71.1760430444939; Tue, 14 Oct 2025
 01:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com> <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com> <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
In-Reply-To: <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:27:13 -0700
X-Gm-Features: AS18NWBmPu4lV9M4BQU3C0eC9ZA0J6hiMmpSffXcM4BTAXzWOUFd7e1qO868klc
Message-ID: <CANn89iLKAm=Pe=S=7727hDZSTGhrodqO-9aMhT0c4sFYE38jxA@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:06=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 14, 2025 at 1:01=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Oct 14, 2025 at 12:43=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 12:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > >
> > > >
> > > >
> > > > On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > > > > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> > > > >> Michal reported and bisected an issue after recent adoption
> > > > >> of skb_attempt_defer_free() in UDP.
> > > > >>
> > > > >> We had the same issue for TCP, that Sabrina fixed in commit 9b64=
12e6979f
> > > > >> ("tcp: drop secpath at the same time as we currently drop dst")
> > > > >
> > > > > I'm not convinced this is the same bug. The TCP one was a "leaked=
"
> > > > > reference (delayed put). This looks more like a double put/missin=
g
> > > > > hold to me (we get to the destroy path without having done the pr=
oper
> > > > > delete, which would set XFRM_STATE_DEAD).
> > > > >
> > > > > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> > > > > x->tunnel as we delete x").
> > > >
> > > > I think Sabrina is right. If the skb carries a secpath,
> > > > UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will =
be
> > > > called by skb_consume_udp().
> > > >
> > > > skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> > > > skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache=
()),
> > > > the skb will go through again skb_release_head_state(), with a doub=
le free.
> > > >
> > > > I think something alike the following (completely untested) should =
work:
> > > > ---
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index 95241093b7f0..4a308fd6aa6c 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> > > > sk_buff *skb, int len)
> > > >                 sk_peek_offset_bwd(sk, len);
> > > >
> > > >         if (!skb_shared(skb)) {
> > > > -               if (unlikely(udp_skb_has_head_state(skb)))
> > > > +               if (unlikely(udp_skb_has_head_state(skb))) {
> > > >                         skb_release_head_state(skb);
> > > > +                       skb->active_extensions =3D 0;
> >
> > We probably also want to clear CONNTRACK state as well.
>
> Perhaps not use skb_release_head_state() ?
>
> We know there is no dst, and no destructor.
>

An no conntrack either from UDP

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..932c21838b9b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,8 +1851,13 @@ void skb_consume_udp(struct sock *sk, struct
sk_buff *skb, int len)
                sk_peek_offset_bwd(sk, len);

        if (!skb_shared(skb)) {
-               if (unlikely(udp_skb_has_head_state(skb)))
-                       skb_release_head_state(skb);
+               if (unlikely(udp_skb_has_head_state(skb))) {
+                       /* Make sure that skb_release_head_state()
will have nothing to do. */
+                       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+                       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+                       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
+                       skb_ext_reset(skb);
+               }
                skb_attempt_defer_free(skb);
                return;
        }

