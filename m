Return-Path: <netdev+bounces-229093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82986BD8186
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3173E761B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC4B301712;
	Tue, 14 Oct 2025 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yg/Vb1qZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77A30F812
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429179; cv=none; b=fCENVA7uWR0tK63Nh7RdRrE9zrCHq9kjaHbfpIQ8hTQv9M/bEbLwmqhOQGZwVMogR/nRm5sPqSuvp0WJ9JC+hcJUVpyWvqj3Y6rDp/qepj1hxi1+Z/0/b+NAECi0uk2JRRTqwFkx3oyZR84UIMZRpB7ozt6CCUSXIZ48yLQNzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429179; c=relaxed/simple;
	bh=F3G1G3p2hOku1tMlDLXq4FQY+qT4eMi4tD7Y7d3KUOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4a9dLP+OaaMYM3eXI/EgzOw03mZF0g519QvnlRhCEt7mmrMf6wjadJfwtNmNUEAOTBINmzqRHO9mQn65poNCAr9CYFRAhNjP+9n8tQxd7hqKHhwS4GFYjJxtME/UMytN/aVLdVI5BSzNVCenAMJ7XMoZwGCk/0C2cnLt+kttg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yg/Vb1qZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7ea50f94045so74523016d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760429176; x=1761033976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYqq5yuUz+kcoeHO4a7HlJXL0rYsAVlQamKS1jtV998=;
        b=yg/Vb1qZgLRZrTPrVOYnlZF4numL5HGWXAmrqESVDRd80l0tlVxRefVXvtX4/IPPwN
         8yKF1nXwp8GN2i78thmTnrQdkoRodABa+eLAdz5tacaow77WWTxhIUOhs23QE0Axm7Sv
         EAY+ta4te8zSg6qk5xNmA5CQwwpXOwJ/ra6IrrVfU1KXeS+6zVAnj5WkSSuN83rlhVa8
         0U/Ucl4hNpI9DGlMtwXtWFZa/0kUMMwyr9Iq7kRAG7UuRMk6hSIPg0ajYSqCCeOZZadn
         uvRdUDFrqDaSemEvt8lJc0GDBDAromotePR31YK5ORNiafqHK/oqMnO+zbDcLCbOIN75
         yA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429176; x=1761033976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYqq5yuUz+kcoeHO4a7HlJXL0rYsAVlQamKS1jtV998=;
        b=ph340yCCE4xGOdv6Ef7X7AA1zLDbN5fu3kTV2nLr5QkrX63vc0N5yhy4vJ+rshHgsA
         k1C4ZVs6873CN5eRNX1HvqI/pfRbL6GIQNnYHGJyCSAEpAb2JCqYuUfD0RIG47kyJZ4B
         d/e3zyxWReGLQsMwzJDgYnrnzv/Q3n3sIs1N0/Rs3F0NhiZWPkiqKf4tlitBN2LtQnCn
         dKvftEEV8+CGjH86aIgG97DhTeaEaNHF+CW6kmAj2YdKeBf6MxxPsBXDvvzfZ2zCZSf+
         AuLhDOXlFpr6nof0w5FJDOY6O3blVge4fSKPsE/JHVQBcf4ZLsWxW0LZ8r7j/EGz1vD9
         vXlg==
X-Forwarded-Encrypted: i=1; AJvYcCUP1nqcYewlitOxO0697oUpFMqsHd9dwBDIRn6oU/7XMyEMk/JXRRhrczWSfa+9DYpBUgw+8Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Y/Z3xazet6di1CYLq5sDvjHU6sKMwzeIZur9uKWk2F/k2BVg
	hnFh95Rj9wAx42NCB0K4TaviQy16rw1PX8AGXMPXozIcC2kuzdY6P1frlT9GFcm5GSICwmL48pX
	8RVau5Kdj8BwbMjjUasWBnwj5Z7K+sSNL4PtAR2Lp
X-Gm-Gg: ASbGncuYI8PMRoRFdwp72YnY97dn2yKjA1gElIXKmDo2vlv7z8QjZGcB54YXaIIp0xh
	L3TiO1dg2MNuTrgEz0mPFgbcKm1TvE1L+8OQRd2i+y4ss8zuwpq0M7WdatnKO+i1ItYvfwHtC7p
	jzzQ4rkErip7F+4KNo9mHQec8coxSxkd/j/lh42M/8EQiWH6wJQ7j6Gbv0yZ1Yo40BpbHn5+Ho7
	+FYtlRUqGf+rtJ2a97wY3ZCg67iZh/p
X-Google-Smtp-Source: AGHT+IGYK0GZALIN+dr7ZI3egJ8TMIFhQdN8aTcypIwz8QSD1KvcpeQWxJHY1Miw4WHu/PFhTEXDE/DRrGVokxcqdgE=
X-Received: by 2002:a05:6214:daa:b0:878:ff84:a2b6 with SMTP id
 6a1803df08f44-87a05103754mr404277516d6.0.1760429176013; Tue, 14 Oct 2025
 01:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com> <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
In-Reply-To: <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:06:04 -0700
X-Gm-Features: AS18NWB9pH9FUqTYVW8xOYl4BiSkBPoLhpHS-dnUA21W5oBLO87cmVZQYu9cpm8
Message-ID: <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:01=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 14, 2025 at 12:43=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Oct 14, 2025 at 12:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >
> > >
> > >
> > > On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > > > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> > > >> Michal reported and bisected an issue after recent adoption
> > > >> of skb_attempt_defer_free() in UDP.
> > > >>
> > > >> We had the same issue for TCP, that Sabrina fixed in commit 9b6412=
e6979f
> > > >> ("tcp: drop secpath at the same time as we currently drop dst")
> > > >
> > > > I'm not convinced this is the same bug. The TCP one was a "leaked"
> > > > reference (delayed put). This looks more like a double put/missing
> > > > hold to me (we get to the destroy path without having done the prop=
er
> > > > delete, which would set XFRM_STATE_DEAD).
> > > >
> > > > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> > > > x->tunnel as we delete x").
> > >
> > > I think Sabrina is right. If the skb carries a secpath,
> > > UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will be
> > > called by skb_consume_udp().
> > >
> > > skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> > > skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache()=
),
> > > the skb will go through again skb_release_head_state(), with a double=
 free.
> > >
> > > I think something alike the following (completely untested) should wo=
rk:
> > > ---
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 95241093b7f0..4a308fd6aa6c 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> > > sk_buff *skb, int len)
> > >                 sk_peek_offset_bwd(sk, len);
> > >
> > >         if (!skb_shared(skb)) {
> > > -               if (unlikely(udp_skb_has_head_state(skb)))
> > > +               if (unlikely(udp_skb_has_head_state(skb))) {
> > >                         skb_release_head_state(skb);
> > > +                       skb->active_extensions =3D 0;
>
> We probably also want to clear CONNTRACK state as well.

Perhaps not use skb_release_head_state() ?

We know there is no dst, and no destructor.

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..98628486c4c5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
sk_buff *skb, int len)
                sk_peek_offset_bwd(sk, len);

        if (!skb_shared(skb)) {
-               if (unlikely(udp_skb_has_head_state(skb)))
-                       skb_release_head_state(skb);
+               if (unlikely(udp_skb_has_head_state(skb))) {
+                       nf_reset_ct(skb);
+                       skb_ext_reset(skb);
+               }
                skb_attempt_defer_free(skb);
                return;
        }

