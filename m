Return-Path: <netdev+bounces-233762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2856BC17FC4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87D0F34BA81
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0D2DFA25;
	Wed, 29 Oct 2025 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8JVWXpv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EA26FD9A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703473; cv=none; b=ImOOeAOjXKFQ6iBQ+DDkl826HyK4b9Vfe+SFZ9kzkoC4/BaWVoyB57cH0m8/0S6cil6bW0G+tvjvc7qVwgdOBA3yD+3EvxWr8Y06cSZyqMKrpwJh8Wd4WW/I7xwHti0Mdj8Q2T9Qlg0SyL0JZtWLVLs3RnPaUpuDWiy9YpHI7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703473; c=relaxed/simple;
	bh=ic2o7D44v91Fm7913b+yMMXAS1NcU+UDnTWA88Wz5Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrqDpVm5mTF2jCCT7rcmzJaewDrzJxqzMxd4n/xPB5kQQfDMPEuy1McHX31MkCXyEME9yL6mNysqRnbAvE+WdRclMNu/pDUqhUVnSPbOV8B0jyqJIrmNht/6/THywW636GmXWNtxWCN0a9ygf3DYtYcEvE3V0OReiSoPb5jksQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8JVWXpv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592f0dba1e6so3809e87.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761703469; x=1762308269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kajl/psTwo1g51TJY+gh/9JVh7qFhmWY8O7ADxUSNL4=;
        b=o8JVWXpv5AzRxkcmd5mz5OLE+9fR/MDq2JVtGQZ7cvlq1Ntvs85bV2gV74Bw+aSnea
         r/gNPGbeDuSNvO5EDfKbTupyqyUAS1952znTZLVx+3d98RaYU2fS2yeSxJhELrY3lWx/
         ODNhaAGbz+UjnYmgNg+6Qm2NETYhetZxJl1PeS8HHvMeOgnZzssAQSOY7SPCoaVIuiw4
         HeHTgMQizJbTFE8CN+MI/JUmuLDoAeHPAlLlTs71wmD5OnrbCUrNythc6AJY4Fd56h3N
         W+6AitCHFHTFu44VEPCLo+VZVQ5wBUNzN/RVJmuw6X8djZA3VNqEMdxYaW6hanPxWQQj
         pnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703469; x=1762308269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kajl/psTwo1g51TJY+gh/9JVh7qFhmWY8O7ADxUSNL4=;
        b=e3NvPmbf1880tmMeLV2Vc7A27+qnu1MvTSF1KUQY9xwDA52JUJ74LW3eFQ6uY8pv+A
         Lj/zWHd/0NbzY0ubsjevhG0bWCKCXkvSBsxVLZX5yU8L9TQ13iDjgOWqltkkU/HtsuUI
         wJwTTCV2NOh2nY1yqlq3vbIkQqMfYjZ+V0T0TKEHDwgZBt2/ijSEvhvJGJhAtUui8klc
         N2eEFctRIA2JG8vi7hTEnSRmwqMJVd8VVYst1KnsuudRfy490Wk1lx9WzLT8p6ysSpyG
         gYDH6SZgGVB50sxDiTvVSPLf6Ee3z5H2mFjsA5YwltNI7rZs9ci4NBbSXxi0oxaK06Aa
         tG1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKW0/PTw3Lmr/thhUcm/pVReZoyP+m/nZIyc5ABBGsmnP+iUu9nfVj4hqn/nYLEv5WdH40iEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YximRhWJ9f29TXGXsRSQkEZ4JwaB+uXlxHBzGrwJukJJbYTfMR9
	nqZZQye1EPCdy4tZSwh1ZNnGpc4RYTkIsDjSBYicWGNAXRLqyIFC73IynYSA1RjO2cuXnUDUj3R
	ZCpmZlEI288QsqzEwT8sZJrcq13PCaxc2QPvYC70M
X-Gm-Gg: ASbGncv9jqPFIQ+2qrR3cP5ZbM9ceAsH2AEFkye6G1qwwzfONivLJtZMSDJcsfKqPNd
	UN6tUJzSah1BOurQ6Z0q3j/2uGqvC0deeTIfQkmVjRxfMd/PdcSyYgEVHSMIm1jD45OsAGHHA/O
	saHXYnKm8vDgEWmllTA6f0wiqvz6oKj5NBLoy30LpRujrFxWZz0lOlJlj099lRi3KQx1IrToseW
	uWJIqZZ4VC3V9nnJU2c7930PTWaWOWeFft9xYnXwE9kqMrKpKUjNqxqNB8SgIJF7DArNW/HGTP7
	heXrRQ==
X-Google-Smtp-Source: AGHT+IHKMV+AJY8Tb1LU+dA/Plrh7jg2FM20W+BAC6x22KvfJu0LccgTFCo8W+4hyXOzGtvDEYoQkgf67T6p75lMfXw=
X-Received: by 2002:a05:6512:1343:b0:592:f589:b76e with SMTP id
 2adb3069b0e04-594133fa923mr141781e87.5.1761703468844; Tue, 28 Oct 2025
 19:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-3-47cb85f5259e@meta.com>
 <CAHS8izOKWxw=T8zk1jQL6sB8bTSK0HvNxnX=XXYLCAFtuiAwRw@mail.gmail.com> <aQEsYs5yJC7eXgKS@devvm11784.nha0.facebook.com>
In-Reply-To: <aQEsYs5yJC7eXgKS@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 28 Oct 2025 19:04:15 -0700
X-Gm-Features: AWmQ_bmOjxhyou1022t3z0xWpcvMg2iM9V4h5pa8C_Qo4CzjM-0T66_LWxjniHs
Message-ID: <CAHS8izOnir-YHPH+R0cQzu1i0HD2Z0csW6qUT8FFXh1PkmHabQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] net: devmem: use niov array for token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:49=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
...
> > > @@ -307,6 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > >                 goto err_free_chunks;
> > >
> > >         list_add(&binding->list, &priv->bindings);
> > > +       binding->autorelease =3D true;
> > >
> >
> > So autorelease is indeed a property of the binding. Not sure why a
> > copy exists in sk_devmem_info. Perf optimization to reduce pointer
> > chasing?
> >
>
> Just stale code from prior design... Originally, I was going to try to
> allow the autorelease =3D=3D true case to be free of the
> one-binding-per-socket restriction, in which case sk_devmem_info.binding
> would be NULL (or otherwise meaningless). sk_devmem_info.autorelease
> allowed sock_devmem_dontneed to choose the right path even when
> sk_devmem_info.binding =3D=3D NULL.
>
> ...but then I realized we still needed some restriction to avoid sockets
> from steering into different dmabufs with different autorelease configs,
> so kept the one-binding restriction for both modes. I abandoned the
> effort, but forgot to revert this change.
>
> Now I'm realizing that we could relax the restriction more though... We
> could allow sockets to steer into other bindings if they all have the
> same autorelease value? Then we could still use
> sk_devmem_info.binding->autorelease in the sock_devmem_dontneed path and
> relax the restriction to "steering must only be to bindings of the same
> autorelease mode"?
>

Hmpf. I indeed forgot to think thoroughly about the case where, for
some god-forsaken reason, we have bindings on the system with
different auto-release values.

But now that I think more, I don't fully grasp why that would be a
problem. I think we can make it all work by making autorelease a
property of the socket, not the binding:

So if sk->devmem_info.autorelease is on, in recevmsg we store the
token in the xarray and dontneed frees from the xarray (both can check
skb->devmem_info.autorelease).

If sk->devmem_info.autorelease is off, then in recvmsg we grab the
binding from sk->devmem_info.binding, and we do a uref inc and netmem
get ref, then in dontneed dec uref and napi_pp_put_page if necessary.

The side effect of that is that for the same binding, we may
simultaneously have refs in the sk->xarray and in the binding->uref,
because the data landing on the binding sometimes belonged to a socket
with sk->devmem_info.autorelease on or off, but I don't immediately
see why that would be a problem. The xarray refs would be removed on
socket close, the urefs would be freed on unbind.

Doesn't it all work? Or am I insane?

> > I thought autorelease would be 'false' by default. I.e. the user gets
> > better perf by default. Maybe this is flipped in the following patch I
> > haven't opened yet.
> >
>
> That is right, it is in the next patch. I didn't want to change the
> default without also adding the ability to revert back.
>
> > >         return binding;
> > >
> > > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > > index 2ada54fb63d7..7662e9e42c35 100644
> > > --- a/net/core/devmem.h
> > > +++ b/net/core/devmem.h
> > > @@ -61,11 +61,20 @@ struct net_devmem_dmabuf_binding {
> > >
> > >         /* Array of net_iov pointers for this binding, sorted by virt=
ual
> > >          * address. This array is convenient to map the virtual addre=
sses to
> > > -        * net_iovs in the TX path.
> > > +        * net_iovs.
> > >          */
> > >         struct net_iov **vec;
> > >
> > >         struct work_struct unbind_w;
> > > +
> > > +       /* If true, outstanding tokens will be automatically released=
 upon each
> > > +        * socket's close(2).
> > > +        *
> > > +        * If false, then sockets are responsible for releasing token=
s before
> > > +        * close(2). The kernel will only release lingering tokens wh=
en the
> > > +        * dmabuf is unbound.
> > > +        */
> >
> > Needs devmem.rst doc update.
> >
>
> Will do.
>
> > > +       bool autorelease;
> > >  };
> > >
> > >  #if defined(CONFIG_NET_DEVMEM)
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index e7b378753763..595b5a858d03 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -87,6 +87,7 @@
> > >
> > >  #include <linux/unaligned.h>
> > >  #include <linux/capability.h>
> > > +#include <linux/dma-buf.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/errqueue.h>
> > >  #include <linux/types.h>
> > > @@ -151,6 +152,7 @@
> > >  #include <uapi/linux/pidfd.h>
> > >
> > >  #include "dev.h"
> > > +#include "devmem.h"
> > >
> > >  static DEFINE_MUTEX(proto_list_mutex);
> > >  static LIST_HEAD(proto_list);
> > > @@ -1081,6 +1083,57 @@ static int sock_reserve_memory(struct sock *sk=
, int bytes)
> > >  #define MAX_DONTNEED_TOKENS 128
> > >  #define MAX_DONTNEED_FRAGS 1024
> > >
> > > +static noinline_for_stack int
> > > +sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_t=
oken *tokens,
> > > +                                   unsigned int num_tokens)
> > > +{
> > > +       unsigned int netmem_num =3D 0;
> > > +       int ret =3D 0, num_frags =3D 0;
> > > +       netmem_ref netmems[16];
> > > +       struct net_iov *niov;
> > > +       unsigned int i, j, k;
> > > +
> > > +       for (i =3D 0; i < num_tokens; i++) {
> > > +               for (j =3D 0; j < tokens[i].token_count; j++) {
> > > +                       struct net_iov *niov;
> > > +                       unsigned int token;
> > > +                       netmem_ref netmem;
> > > +
> > > +                       token =3D tokens[i].token_start + j;
> > > +                       if (token >=3D sk->sk_devmem_info.binding->dm=
abuf->size / PAGE_SIZE)
> > > +                               break;
> > > +
> >
> > This requires some thought. The correct thing to do here is EINVAL
> > without modifying the urefs at all I think. You may need an
> > input-verification loop. Breaking and returning success here is not
> > great, I think.
> >
>
> Should this also be changed for the other path as well? Right now if
> __xa_erase returns NULL (e.g., user passed in a bad token), then we hit
> "continue" and process the next token... eventually just returning the
> number of tokens that were successfully processed and omitting the wrong
> ones.
>

Ugh. I did not notice that :(

I guess the existing dontneed doesn't handle that well anyway. Lets
not fix too much in this series. It's fine to carry that behavior in
the new implementation and if anything improve this in a separate
patch (for me at least). It'd be a bit weird if the userspace is
sending us bad tokens anyway, in theory.

> > > +                       if (++num_frags > MAX_DONTNEED_FRAGS)
> > > +                               goto frag_limit_reached;
> > > +                       niov =3D sk->sk_devmem_info.binding->vec[toke=
n];
> > > +                       netmem =3D net_iov_to_netmem(niov);
> > > +
> > > +                       if (!netmem || WARN_ON_ONCE(!netmem_is_net_io=
v(netmem)))
> > > +                               continue;
> > > +
> >
> > This check is extremely defensive. There is no way netmem is not a
> > netiov (you just converted it). It's also very hard for it to be NULL.
> > Remove maybe.
> >
>
> Removing sounds good to me.
>
> > > +                       netmems[netmem_num++] =3D netmem;
> > > +                       if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> > > +                               for (k =3D 0; k < netmem_num; k++) {
> > > +                                       niov =3D netmem_to_net_iov(ne=
tmems[k]);
> >
> > No need to upcast to netmem only to downcast here back to net_iov.
> > Just keep it net_iov?
> >
>
> Sounds good.
>
> > > +                                       if (atomic_dec_and_test(&niov=
->uref))
> > > +                                               WARN_ON_ONCE(!napi_pp=
_put_page(netmems[k]));
> >
> > I see. So you're only only napi_pp_put_pageing the last uref dec, but
> > why? How about you
>
> Just to minimize cache bus noise from the extra atomic.
>
> > > +                               }
> > > +                               netmem_num =3D 0;
> > > +                       }
> >
> > From a quick look, I don't think you need the netmems[] array or this
> > inner loop.
> >
> > dontneed_autorelease is complicatingly written because it acquires a
> > lock, and we wanted to minimize the lock acquire. You are acquiring no
> > lock here. AFAICT you can just loop over the tokens and free all of
> > them in one (nested) loop.
>
> Oh good point. There is no need to batch at all here.
>
> >
> > > +                       ret++;
> > > +               }
> > > +       }
> > > +
> > > +frag_limit_reached:
> > > +       for (k =3D 0; k < netmem_num; k++) {
> > > +               niov =3D netmem_to_net_iov(netmems[k]);
> > > +               if (atomic_dec_and_test(&niov->uref))
> > > +                       WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static noinline_for_stack int
> > >  sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_toke=
n *tokens,
> > >                                  unsigned int num_tokens)
> > > @@ -1089,32 +1142,32 @@ sock_devmem_dontneed_autorelease(struct sock =
*sk, struct dmabuf_token *tokens,
> > >         int ret =3D 0, num_frags =3D 0;
> > >         netmem_ref netmems[16];
> > >
> > > -       xa_lock_bh(&sk->sk_user_frags);
> > > +       xa_lock_bh(&sk->sk_devmem_info.frags);
> > >         for (i =3D 0; i < num_tokens; i++) {
> > >                 for (j =3D 0; j < tokens[i].token_count; j++) {
> > >                         if (++num_frags > MAX_DONTNEED_FRAGS)
> > >                                 goto frag_limit_reached;
> > >
> > >                         netmem_ref netmem =3D (__force netmem_ref)__x=
a_erase(
> > > -                               &sk->sk_user_frags, tokens[i].token_s=
tart + j);
> > > +                               &sk->sk_devmem_info.frags, tokens[i].=
token_start + j);
> > >
> > >                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_io=
v(netmem)))
> > >                                 continue;
> > >
> > >                         netmems[netmem_num++] =3D netmem;
> > >                         if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> > > -                               xa_unlock_bh(&sk->sk_user_frags);
> > > +                               xa_unlock_bh(&sk->sk_devmem_info.frag=
s);
> > >                                 for (k =3D 0; k < netmem_num; k++)
> > >                                         WARN_ON_ONCE(!napi_pp_put_pag=
e(netmems[k]));
> > >                                 netmem_num =3D 0;
> > > -                               xa_lock_bh(&sk->sk_user_frags);
> > > +                               xa_lock_bh(&sk->sk_devmem_info.frags)=
;
> > >                         }
> > >                         ret++;
> > >                 }
> > >         }
> > >
> > >  frag_limit_reached:
> > > -       xa_unlock_bh(&sk->sk_user_frags);
> > > +       xa_unlock_bh(&sk->sk_devmem_info.frags);
> > >         for (k =3D 0; k < netmem_num; k++)
> > >                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > >
> > > @@ -1135,6 +1188,12 @@ sock_devmem_dontneed(struct sock *sk, sockptr_=
t optval, unsigned int optlen)
> > >             optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > >                 return -EINVAL;
> > >
> > > +       /* recvmsg() has never returned a token for this socket, whic=
h needs to
> > > +        * happen before we know if the dmabuf has autorelease set or=
 not.
> > > +        */
> > > +       if (!sk->sk_devmem_info.binding)
> > > +               return -EINVAL;
> > > +
> >
> > Hmm. At first glance I don't think enforcing this condition if
> > binding->autorelease is necessary, no?
> >
> > If autorelease is on, then we track the tokens the old way, and we
> > don't need a binding, no? If it's off, then we need an associated
> > binding, to look up the urefs array.
> >
>
> We at least need the binding to know if binding->autorelease is on,
> since without that we don't know whether the tokens are in the xarray or
> binding->vec... but I guess we could also check if the xarray is
> non-empty and infer that autorelease =3D=3D true from that?
>

I think as above, if autorelease is (only) a property of the sockets,
then the xarray path works without introducing the socket-to-binding
mapping restriction, yes?

--=20
Thanks,
Mina

