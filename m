Return-Path: <netdev+bounces-189605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B5AB2CB2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A661898615
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E818C031;
	Mon, 12 May 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExvNcAOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8E320B
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747011916; cv=none; b=PMkApxa1KANH82c8aMPPZwUVjBOSd1cBTxMS99hXfcuFywlY3s9WoQkqJmXjHU4PUsnkRniiRPlyBW1aP4512ITnibAzo0VreEeHN2JM1BiCpQkyWwDgYib2ATx+aZFF0iWwe03JtB72Ac1eR5JSutL+DOsjdj0lEzMmqI2ONHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747011916; c=relaxed/simple;
	bh=YZMjhlB63/cYWuKN7wNuC44rU0fGEjiWnAXFrwwZNDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWiViJUHoPO92GXQIuU9waIagTsxV1RA7FXMv4agUhXHbgkD1sh7h1LXiupprAbd+iYPpMqDndCPBekPF+ydm4/vwcfYWgktlFuSTDAe0VIqIn6wVq3+jy7dkKu17TZBoQImqzwmGhY5+Rs/ZF9xlxc/7wXaClkLuHRURQmMTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExvNcAOw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so6372509a12.3
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747011912; x=1747616712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFuERigEJ8ymuXKknpEzSEeqbpEDQsI7V0hYK86G3w0=;
        b=ExvNcAOwmHNpAcOtBG6fBq03mRy1GET2jVy/w9/KZdFJ/4CXkpT0uDqn4zivUCeCVl
         htlJ95fEcmeNnx1g9opDe8s3se9+JfsenoX1SfZgNZPghVhrXtVZpxABcs8/6G4xzzNK
         JL2C7Zn7ofyo3jxf4OPnMpEgLnGyOqWH84XORVX8ucpW6Nv0TgpkYtEFz05U5GiQPwqB
         Qi/ZLeU3uJ0BSdNJZxfet/m8iAV6BCNtMhWeUB13b5kicBdXQc7OXyYzM7VEI0VeEots
         6L1Sh/qLGLZmORqlF9nTJEQFWbB8q+jem6WRZ0VGffrvJzdZsC3IMgrcsRGQPCYP3JKl
         HKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747011912; x=1747616712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFuERigEJ8ymuXKknpEzSEeqbpEDQsI7V0hYK86G3w0=;
        b=nLvTQ+FUG+rH6XL/aMVsxwxA5hYPxJmDUr2gT1oIsc2+lXh/d5IVmLLUzZ1PKMrg8P
         3tjTyxn48Cn5FuUsbLJU/7MDLy2XY0h0Rx1JCCqwfgl6kWIkV6McAcaKMvzW3pE0ItAY
         A5TtYrAF66XP8GrpRN0pF1AUwJKTSujjaHZRmw2gnLnCQXwO9MWMI4EeR4dfiYe6G3I0
         frR+i9bccnTIwOK+pdr42G9kURa04PUd856ulCTnUvzZ06fpNda+NLzH2fQrBdp/oUCz
         3PB8Y2zV09vqh3BkUbjz0BFpzzhSdwSy+w6frnXgSA8AUJCjWVkD4CaUWcFjTUtG9grw
         a0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaPxMsBX+qft4j9ND8IL4qLBy09H1ljvv//KPbmmXWJjAzBEbL9nzn3hesKeTpxBZ+azpYLSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzoNjHfK8JASUGNdjn8jTbERJXJrIz5UeqciRbs3qWWtFgbBZG
	jedzczW8cwBNmVwNnSJCzFjruYwgUlsNjyoKhBtkVVHP+LR9PA0hqGcK3el4n0wdLU8STXGQtHF
	ic6e2ruwrE9r91nQSRoUQLyzxGkQ=
X-Gm-Gg: ASbGncsHkttbd31mkERLrK0uNB/YBpOoRmatAeJ8rHJg0YslTdTNLyRUWJHiBzG6+cq
	LR0Vugy47aRVB/8XiaXK4HGU28T5TeFgsk7HL91uJapj8qS9LEAPI2zEbvyxncJ0Asq3zaMHSjW
	fJ9x90PvuFZzD8BG9rtvsWQtbFjGhC9BPNqGKZuNv7zc8Zpw==
X-Google-Smtp-Source: AGHT+IEAyy9tEx8oYuWswFNWC4nWxTYauc70DwildHjsygXPLQlSxIGMAU2u+3VQUlNUOgewCyfbfzwVnalvnD2tsww=
X-Received: by 2002:a05:6402:2396:b0:5fc:45c5:7a04 with SMTP id
 4fb4d7f45d1cf-5fca07933c6mr7368316a12.17.1747011912128; Sun, 11 May 2025
 18:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509160055.261803-1-ap420073@gmail.com> <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
 <20250509153252.76f08c14@kernel.org>
In-Reply-To: <20250509153252.76f08c14@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 12 May 2025 10:05:00 +0900
X-Gm-Features: AX0GCFtr03nozBhAoK9N8AUuJyJ67ebyBc5enq3omVe--VVKftJFayGjMmZpkr4
Message-ID: <CAMArcTUYz=fv-Uisk-9xFDZBKwt0Es+dm97iZaRjs_q4_5d-Mw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 7:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review!

> On Fri, 9 May 2025 12:43:42 -0700 Mina Almasry wrote:
> > > @@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_d=
mabuf_binding *binding)
> > >         unsigned long xa_idx;
> > >         unsigned int rxq_idx;
> > >
> > > -       if (binding->list.next)
> > > -               list_del(&binding->list);
> > > -
> >
> > Unfortunately if you're going to delete this, then you need to do
> > list_del in _all_ the callers of net_devmem_unbind_dmabuf, and I think
> > there is a callsite in netdev_nl_bind_rx_doit that is missed?
> >
> > But also, it may rough to continually have to remember to always do
> > list_del when we do unbind. AFAIR Jakub asked for uniformity in the
> > bind/unbind functions. Can we instead do the list_add inside of
> > net_devmem_bind_dmabuf? So net_devmem_bind_dmabuf can take the struct
> > list_head as an arg and do the list add, then the unbind can do the
> > list_del, so it is uniform, but we don't have to remember to do
> > list_add/del everytime we call bind/unbind.
> >
> > Also, I suspect that clean up can be a separate patch.
>
> Right. Let's leave it for a cleanup. And you can also inline
> net_devmem_unset_dev() in that case. My ask was to separate
> devmem logic from socket logic more clearly but the "new lock"
> approach doesn't really go in such direction. It's good enough
> for the fix tho.

Thanks!
I will make net_devmem_unset_dev() the inline function.

>
> > > +       struct mutex lock;
> > >
> > >         /* The user holds a ref (via the netlink API) for as long as =
they want
> > >          * the binding to remain alive. Each page pool using this bin=
ding holds
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index dae9f0d432fb..bd5d58604ec0 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_=
nl_sock *priv)
> > >  {
> > >         struct net_devmem_dmabuf_binding *binding;
> > >         struct net_devmem_dmabuf_binding *temp;
> > > +       netdevice_tracker dev_tracker;
> > >         struct net_device *dev;
> > >
> > >         mutex_lock(&priv->lock);
> > >         list_for_each_entry_safe(binding, temp, &priv->bindings, list=
) {
> > > +               list_del(&binding->list);
> > > +
> > > +               mutex_lock(&binding->lock);
> > >                 dev =3D binding->dev;
> > > +               if (!dev) {
> > > +                       mutex_unlock(&binding->lock);
> > > +                       net_devmem_unbind_dmabuf(binding);
> > > +                       continue;
> > > +               }
> > > +               netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> > > +               mutex_unlock(&binding->lock);
> > > +
> >
> > Consider writing the above lines as something like:
> >
> > mutex_lock(&binding->lock);
> > if (binding->dev) {
> >     netdev_hold(binding->dev, &dev_tracker, GPF_KERNEL);
> > }
> >
> > net_devmem_unbind_dmabuf(binding);
> >
> > if (binding->dev) {
> >    netdev_put(binding->dev, &dev_tracker);
> > }
> > mutex_unlock(&binding->lock);
> >
> > i.e., don't duplicate the net_devmem_unbind_dmabuf(binding); call.
>
> I think it's fine as is.
>
> > Other than that, I could not find issues. I checked lock ordering. The
> > lock hierarchy is:
> >
> > priv->lock
> >   binding->lock
> >     netdev_lock(dev)
>
> Did you mean:
>
>   priv->lock
>     netdev_lock(dev)
>       binding->lock

Thanks a lot!
Taehee Yoo

