Return-Path: <netdev+bounces-233362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B749C12847
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F8B1897922
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108E22258C;
	Tue, 28 Oct 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQDeDYPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF81E5018
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614442; cv=none; b=sCm1ItXlrI/GDc9hh2rHHe3w52AeGm37xkthT8yt6TfRbka+l9voYfoxceAXMMhSnXYGCBDB//o8UrkLlZLf2Gf5ZWIwb62xUL9hT+L76lsJIaajWsER6nLA/uvT7OlfUNuq+3FD/Zmk82EO9WMxPt07Ndczfw56aPa3fICrxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614442; c=relaxed/simple;
	bh=Vic9i6J8O/gl+3KLWnPe1WnGMzFUaYbztHj9cvi4uNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKnvzuA1OGRRLWTn1xq8HSnWZTuRj4JaRh8JlkiDXPHGm88nPez5BRYEA0dZCiQ23H6AM/0ns7f1cp8GUIn+WHE+ogbZPiHQukQKlN50wlmd1pfPYgNLEsdtnSUGE0OrvYBlO5S4RujaPzQj9PMrDW/x4Nz6oCQd1bybeCQ3ZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQDeDYPW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592efe88994so2605e87.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761614439; x=1762219239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDbcrVhv9tpYV7Az13jX0IPgRbUKzpczNcjzyJ1DHvk=;
        b=UQDeDYPWH/ZPkdN1qBtsDo1TZmDiGmQmqZL3dG4V/J7LltBhJhbiJAi1WGU0ih38hA
         llA9oApbnW3pW64lrXWk7+VVf2z/gWp37LIhWiyXlj297i1r8qPw6l3o5ypTTg1JFdFo
         aILPLssFSknHJ1F/rCIajMmmwqbS30ULfuw4d0BQPEesXdUWvVD0wbS9GJDCJAjt8LgA
         VAErU8urIs0X1zNypp1HtwAb8KxUH+JH7jYwFOjgml6IaKkTzX2Xn+gr+e9/EXz0BZ4/
         RFQ1eTlN8nuZmcPxoCBaoJwqEAme4zAv36//puAJ/w+/AS2P1yBe7fhncFuWeLaTuDob
         ukGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614439; x=1762219239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDbcrVhv9tpYV7Az13jX0IPgRbUKzpczNcjzyJ1DHvk=;
        b=fzTYE7bhVr53TnzUKQ2LclkY6mASym+lUGnRL71qtfUfPXTPcuZoZpY6ldoINJ3KA1
         +S+kwQGP7/2g9vDdYnSvjSO+5yV7QhEU2dvZwmJlFUyV84ArVQFdMD7LaLh+8IYJVnQn
         AYDU6vs7xVeJ+/5jAA1mfCZyuIckvK3n9UZlYIgvc3owLYYw1icCNnuRMVyAHZJ0xiQf
         9SlL5A4T07S1rq+7G96RsoDTTcgkGsfmpMDjEOLIp8Sq85d4apBV5YOw7lKnj3WF42kw
         BlzlZkKNerqJIwsomlMP/9GZjSqLknro4x7O+l7yN/VNtK0MgCqbRGNU19fKIVZB7CJD
         z8jg==
X-Forwarded-Encrypted: i=1; AJvYcCURkdZSmAmUUDFPHw5HMZQOXY2uIAHxhrgAvSnj3cHfjgqxXKAQzxkexwztEfssYigW4K1ZWg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICsZEnxre6ZPvcD4U4xwBHX/2QXL39zz8dqYnWIqyg6ZGp0vQ
	POBmuOUJPMCqpLravf894QNPWVsSHlpwSXM+9NMyyEsL/AhXElPyteAu2EbcsNzhthh/o1Dpu/h
	XU6LPbZYNbDRHM4lvKlSi1z1KE4lW2o3SPMFQHQd2
X-Gm-Gg: ASbGnct5HrW8UFfEgFrU0XnH+Oe1SPGbbohHoV6p5mIw9zaWFq456vK8HUuveo8yMw1
	Pi8ImZz4n+PLzwBhyFtHBfEBGpICDFvbFm8fjzZaFk5vYxcwckNJyxR5wLUdQg7qvANZ5bvgOty
	Pqz+mrq15jcRSK6AOv/SQCa5gt9M4GjJ76Rxdoybj4pH18rMcl4YFA+ZumSrEUHrFywh6fmSF47
	gufeMLwEe0J9ELSWymYm1jUtdgZtxeAn1jGK5DVuDLdsfmiksx0G4UDZ+gkyjCMHuljOAREFAYe
	+qhD4A==
X-Google-Smtp-Source: AGHT+IGmuUi6TbhWa6Lcy/otqfYc86kXrF7DARFB5RPGpiSjYn9uIS3SHwjh93a96Ju3vc7ljRb3XZZzxFck7NeV1zc=
X-Received: by 2002:ac2:4548:0:b0:57b:f611:f918 with SMTP id
 2adb3069b0e04-5930ff51c65mr112667e87.3.1761614437865; Mon, 27 Oct 2025
 18:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-3-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-3-47cb85f5259e@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 18:20:20 -0700
X-Gm-Features: AWmQ_blvYPAoT1aar6C1hsauuM-3Lsq4fcTcwdzq3zZwS8_KxYtIq5SOwa6rnv0
Message-ID: <CAHS8izOKWxw=T8zk1jQL6sB8bTSK0HvNxnX=XXYLCAFtuiAwRw@mail.gmail.com>
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

On Thu, Oct 23, 2025 at 2:00=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Replace xarray-based token lookups with direct array access using page
> offsets as dmabuf tokens. When enabled, this eliminates xarray overhead
> and reduces CPU utilization in devmem RX threads by approximately 13%.
>
> This patch changes the meaning of tokens. Tokens previously referred to
> unique fragments of pages. In this patch tokens instead represent
> references to pages, not fragments. Because of this, multiple tokens may
> refer to the same page and so have identical value (e.g., two small
> fragments may coexist on the same page). The token and offset pair that
> the user receives uniquely identifies fragments if needed.  This assumes
> that the user is not attempting to sort / uniq the token list using
> tokens alone.
>
> This introduces a restriction: devmem RX sockets cannot switch dmabuf
> bindings. This is necessary because 32-bit tokens lack sufficient bits
> to encode both large dmabuf page counts and binding/queue IDs. For
> example, a system with 8 NICs and 32 queues needs 8 bits for binding
> IDs, leaving only 24 bits for pages (64GB max). This restriction aligns
> with common usage, as steering flows to different queues/devices is
> often undesirable for TCP.
>
> This patch adds an atomic uref counter to net_iov for tracking user
> references via binding->vec. The pp_ref_count is only updated on uref
> transitions from zero to one or from one to zero, to minimize atomic
> overhead. If a user fails to refill and closes before returning all
> tokens, the binding will finish the uref release when unbound.
>
> A flag "autorelease" is added. This will be used for enabling the old
> behavior of the kernel releasing references for the sockets upon
> close(2) (autorelease), instead of requiring that socket users do this
> themselves. The autorelease flag is always true in this patch, meaning
> that the old (non-optimized) behavior is kept unconditionally. A future
> patch supports a user-facing knob to toggle this feature and will change
> the default to false for the improved performance.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v5:
> - remove unused variables
> - introduce autorelease flag, preparing for future patch toggle new
>   behavior
>
> Changes in v3:
> - make urefs per-binding instead of per-socket, reducing memory
>   footprint
> - fallback to cleaning up references in dmabuf unbind if socket leaked
>   tokens
> - drop ethtool patch
>
> Changes in v2:
> - always use GFP_ZERO for binding->vec (Mina)
> - remove WARN for changed binding (Mina)
> - remove extraneous binding ref get (Mina)
> - remove WARNs on invalid user input (Mina)
> - pre-assign niovs in binding->vec for RX case (Mina)
> - use atomic_set(, 0) to initialize sk_user_frags.urefs
> - fix length of alloc for urefs
> ---
>  include/net/netmem.h     |  1 +
>  include/net/sock.h       |  8 ++++--
>  net/core/devmem.c        | 45 ++++++++++++++++++++++-------
>  net/core/devmem.h        | 11 ++++++-
>  net/core/sock.c          | 75 ++++++++++++++++++++++++++++++++++++++++++=
++----
>  net/ipv4/tcp.c           | 69 +++++++++++++++++++++++++++++++++---------=
--
>  net/ipv4/tcp_ipv4.c      | 12 ++++++--
>  net/ipv4/tcp_minisocks.c |  3 +-
>  8 files changed, 185 insertions(+), 39 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 651e2c62d1dd..de39afaede8d 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -116,6 +116,7 @@ struct net_iov {
>         };
>         struct net_iov_area *owner;
>         enum net_iov_type type;
> +       atomic_t uref;
>  };
>
>  struct net_iov_area {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 01ce231603db..1963ab54c465 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -350,7 +350,7 @@ struct sk_filter;
>    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
>    *    @sk_scm_unused: unused flags for scm_recv()
>    *    @ns_tracker: tracker for netns reference
> -  *    @sk_user_frags: xarray of pages the user is holding a reference o=
n.
> +  *    @sk_devmem_info: the devmem binding information for the socket
>    *    @sk_owner: reference to the real owner of the socket that calls
>    *               sock_lock_init_class_and_name().
>    */
> @@ -579,7 +579,11 @@ struct sock {
>         struct numa_drop_counters *sk_drop_counters;
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
> -       struct xarray           sk_user_frags;
> +       struct {
> +               struct xarray                           frags;
> +               struct net_devmem_dmabuf_binding        *binding;
> +               bool                                    autorelease;

Maybe autorelease should be a property of the binding, no? I can't
wrap my head around a binding that has some autorelease sockets and
some non-autorelease sockets, semantically.

> +       } sk_devmem_info;
>
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>         struct module           *sk_owner;
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index b4c570d4f37a..8f3199fe0f7b 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -11,6 +11,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/mm.h>
>  #include <linux/netdevice.h>
> +#include <linux/skbuff_ref.h>
>  #include <linux/types.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
> @@ -115,6 +116,29 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>  }
>
> +static void
> +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *bi=
nding)
> +{
> +       int i;
> +
> +       if (binding->autorelease)
> +               return;
> +

I think cosmetically it's better to put this check in the caller.

> +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> +               struct net_iov *niov;
> +               netmem_ref netmem;
> +
> +               niov =3D binding->vec[i];
> +
> +               if (!net_is_devmem_iov(niov))
> +                       continue;
> +

This is an extremely defensive check. I have no idea how we could
possibly have a non devmem iov here. Maybe DEBUG_NET_WARN_ON instead?
Or remove.

> +               netmem =3D net_iov_to_netmem(niov);
> +               if (atomic_xchg(&niov->uref, 0) > 0)
> +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));

This is subtle enough that it can use a comment. Multiple urefs map to
only 1 netmem ref.

> +       }
> +}
> +
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  {
>         struct netdev_rx_queue *rxq;
> @@ -142,6 +166,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabu=
f_binding *binding)
>                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
>         }
>
> +       net_devmem_dmabuf_binding_put_urefs(binding);
>         net_devmem_dmabuf_binding_put(binding);
>  }
>
> @@ -230,14 +255,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                 goto err_detach;
>         }
>
> -       if (direction =3D=3D DMA_TO_DEVICE) {
> -               binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> -                                             sizeof(struct net_iov *),
> -                                             GFP_KERNEL);
> -               if (!binding->vec) {
> -                       err =3D -ENOMEM;
> -                       goto err_unmap;
> -               }
> +       /* used by tx and also rx if !binding->autorelease */
> +       binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +                                     sizeof(struct net_iov *),
> +                                     GFP_KERNEL | __GFP_ZERO);
> +       if (!binding->vec) {
> +               err =3D -ENOMEM;
> +               goto err_unmap;
>         }
>
>         /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> @@ -291,10 +315,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                         niov =3D &owner->area.niovs[i];
>                         niov->type =3D NET_IOV_DMABUF;
>                         niov->owner =3D &owner->area;
> +                       atomic_set(&niov->uref, 0);
>                         page_pool_set_dma_addr_netmem(net_iov_to_netmem(n=
iov),
>                                                       net_devmem_get_dma_=
addr(niov));
> -                       if (direction =3D=3D DMA_TO_DEVICE)
> -                               binding->vec[owner->area.base_virtual / P=
AGE_SIZE + i] =3D niov;
> +                       binding->vec[owner->area.base_virtual / PAGE_SIZE=
 + i] =3D niov;
>                 }
>
>                 virtual +=3D len;
> @@ -307,6 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                 goto err_free_chunks;
>
>         list_add(&binding->list, &priv->bindings);
> +       binding->autorelease =3D true;
>

So autorelease is indeed a property of the binding. Not sure why a
copy exists in sk_devmem_info. Perf optimization to reduce pointer
chasing?

I thought autorelease would be 'false' by default. I.e. the user gets
better perf by default. Maybe this is flipped in the following patch I
haven't opened yet.

>         return binding;
>
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 2ada54fb63d7..7662e9e42c35 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -61,11 +61,20 @@ struct net_devmem_dmabuf_binding {
>
>         /* Array of net_iov pointers for this binding, sorted by virtual
>          * address. This array is convenient to map the virtual addresses=
 to
> -        * net_iovs in the TX path.
> +        * net_iovs.
>          */
>         struct net_iov **vec;
>
>         struct work_struct unbind_w;
> +
> +       /* If true, outstanding tokens will be automatically released upo=
n each
> +        * socket's close(2).
> +        *
> +        * If false, then sockets are responsible for releasing tokens be=
fore
> +        * close(2). The kernel will only release lingering tokens when t=
he
> +        * dmabuf is unbound.
> +        */

Needs devmem.rst doc update.

> +       bool autorelease;
>  };
>
>  #if defined(CONFIG_NET_DEVMEM)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7b378753763..595b5a858d03 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -87,6 +87,7 @@
>
>  #include <linux/unaligned.h>
>  #include <linux/capability.h>
> +#include <linux/dma-buf.h>
>  #include <linux/errno.h>
>  #include <linux/errqueue.h>
>  #include <linux/types.h>
> @@ -151,6 +152,7 @@
>  #include <uapi/linux/pidfd.h>
>
>  #include "dev.h"
> +#include "devmem.h"
>
>  static DEFINE_MUTEX(proto_list_mutex);
>  static LIST_HEAD(proto_list);
> @@ -1081,6 +1083,57 @@ static int sock_reserve_memory(struct sock *sk, in=
t bytes)
>  #define MAX_DONTNEED_TOKENS 128
>  #define MAX_DONTNEED_FRAGS 1024
>
> +static noinline_for_stack int
> +sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token=
 *tokens,
> +                                   unsigned int num_tokens)
> +{
> +       unsigned int netmem_num =3D 0;
> +       int ret =3D 0, num_frags =3D 0;
> +       netmem_ref netmems[16];
> +       struct net_iov *niov;
> +       unsigned int i, j, k;
> +
> +       for (i =3D 0; i < num_tokens; i++) {
> +               for (j =3D 0; j < tokens[i].token_count; j++) {
> +                       struct net_iov *niov;
> +                       unsigned int token;
> +                       netmem_ref netmem;
> +
> +                       token =3D tokens[i].token_start + j;
> +                       if (token >=3D sk->sk_devmem_info.binding->dmabuf=
->size / PAGE_SIZE)
> +                               break;
> +

This requires some thought. The correct thing to do here is EINVAL
without modifying the urefs at all I think. You may need an
input-verification loop. Breaking and returning success here is not
great, I think.

> +                       if (++num_frags > MAX_DONTNEED_FRAGS)
> +                               goto frag_limit_reached;
> +                       niov =3D sk->sk_devmem_info.binding->vec[token];
> +                       netmem =3D net_iov_to_netmem(niov);
> +
> +                       if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(ne=
tmem)))
> +                               continue;
> +

This check is extremely defensive. There is no way netmem is not a
netiov (you just converted it). It's also very hard for it to be NULL.
Remove maybe.

> +                       netmems[netmem_num++] =3D netmem;
> +                       if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> +                               for (k =3D 0; k < netmem_num; k++) {
> +                                       niov =3D netmem_to_net_iov(netmem=
s[k]);

No need to upcast to netmem only to downcast here back to net_iov.
Just keep it net_iov?

> +                                       if (atomic_dec_and_test(&niov->ur=
ef))
> +                                               WARN_ON_ONCE(!napi_pp_put=
_page(netmems[k]));

I see. So you're only only napi_pp_put_pageing the last uref dec, but
why? How about you
> +                               }
> +                               netmem_num =3D 0;
> +                       }

From a quick look, I don't think you need the netmems[] array or this
inner loop.

dontneed_autorelease is complicatingly written because it acquires a
lock, and we wanted to minimize the lock acquire. You are acquiring no
lock here. AFAICT you can just loop over the tokens and free all of
them in one (nested) loop.

> +                       ret++;
> +               }
> +       }
> +
> +frag_limit_reached:
> +       for (k =3D 0; k < netmem_num; k++) {
> +               niov =3D netmem_to_net_iov(netmems[k]);
> +               if (atomic_dec_and_test(&niov->uref))
> +                       WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +       }
> +
> +       return ret;
> +}
> +
>  static noinline_for_stack int
>  sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *t=
okens,
>                                  unsigned int num_tokens)
> @@ -1089,32 +1142,32 @@ sock_devmem_dontneed_autorelease(struct sock *sk,=
 struct dmabuf_token *tokens,
>         int ret =3D 0, num_frags =3D 0;
>         netmem_ref netmems[16];
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>         for (i =3D 0; i < num_tokens; i++) {
>                 for (j =3D 0; j < tokens[i].token_count; j++) {
>                         if (++num_frags > MAX_DONTNEED_FRAGS)
>                                 goto frag_limit_reached;
>
>                         netmem_ref netmem =3D (__force netmem_ref)__xa_er=
ase(
> -                               &sk->sk_user_frags, tokens[i].token_start=
 + j);
> +                               &sk->sk_devmem_info.frags, tokens[i].toke=
n_start + j);
>
>                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(ne=
tmem)))
>                                 continue;
>
>                         netmems[netmem_num++] =3D netmem;
>                         if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> -                               xa_unlock_bh(&sk->sk_user_frags);
> +                               xa_unlock_bh(&sk->sk_devmem_info.frags);
>                                 for (k =3D 0; k < netmem_num; k++)
>                                         WARN_ON_ONCE(!napi_pp_put_page(ne=
tmems[k]));
>                                 netmem_num =3D 0;
> -                               xa_lock_bh(&sk->sk_user_frags);
> +                               xa_lock_bh(&sk->sk_devmem_info.frags);
>                         }
>                         ret++;
>                 }
>         }
>
>  frag_limit_reached:
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>         for (k =3D 0; k < netmem_num; k++)
>                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
>
> @@ -1135,6 +1188,12 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t op=
tval, unsigned int optlen)
>             optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
>                 return -EINVAL;
>
> +       /* recvmsg() has never returned a token for this socket, which ne=
eds to
> +        * happen before we know if the dmabuf has autorelease set or not=
.
> +        */
> +       if (!sk->sk_devmem_info.binding)
> +               return -EINVAL;
> +

Hmm. At first glance I don't think enforcing this condition if
binding->autorelease is necessary, no?

If autorelease is on, then we track the tokens the old way, and we
don't need a binding, no? If it's off, then we need an associated
binding, to look up the urefs array.

>         num_tokens =3D optlen / sizeof(*tokens);
>         tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL=
);
>         if (!tokens)
> @@ -1145,7 +1204,11 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t op=
tval, unsigned int optlen)
>                 return -EFAULT;
>         }
>
> -       ret =3D sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
> +       if (sk->sk_devmem_info.autorelease)
> +               ret =3D sock_devmem_dontneed_autorelease(sk, tokens, num_=
tokens);
> +       else
> +               ret =3D sock_devmem_dontneed_manual_release(sk, tokens,
> +                                                         num_tokens);
>
>         kvfree(tokens);
>         return ret;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e15b38f6bd2d..cfa77c852e64 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -260,6 +260,7 @@
>  #include <linux/memblock.h>
>  #include <linux/highmem.h>
>  #include <linux/cache.h>
> +#include <linux/dma-buf.h>
>  #include <linux/err.h>
>  #include <linux/time.h>
>  #include <linux/slab.h>
> @@ -492,7 +493,9 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> -       xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
> +       sk->sk_devmem_info.binding =3D NULL;
> +       sk->sk_devmem_info.autorelease =3D false;
>  }
>  EXPORT_IPV6_MOD(tcp_init_sock);
>
> @@ -2422,11 +2425,11 @@ static void tcp_xa_pool_commit_locked(struct sock=
 *sk, struct tcp_xa_pool *p)
>
>         /* Commit part that has been copied to user space. */
>         for (i =3D 0; i < p->idx; i++)
> -               __xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_EN=
TRY,
> +               __xa_cmpxchg(&sk->sk_devmem_info.frags, p->tokens[i], XA_=
ZERO_ENTRY,
>                              (__force void *)p->netmems[i], GFP_KERNEL);
>         /* Rollback what has been pre-allocated and is no longer needed. =
*/
>         for (; i < p->max; i++)
> -               __xa_erase(&sk->sk_user_frags, p->tokens[i]);
> +               __xa_erase(&sk->sk_devmem_info.frags, p->tokens[i]);
>
>         p->max =3D 0;
>         p->idx =3D 0;
> @@ -2437,11 +2440,11 @@ static void tcp_xa_pool_commit(struct sock *sk, s=
truct tcp_xa_pool *p)
>         if (!p->max)
>                 return;
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>
>         tcp_xa_pool_commit_locked(sk, p);
>
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>  }
>
>  static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> @@ -2452,18 +2455,18 @@ static int tcp_xa_pool_refill(struct sock *sk, st=
ruct tcp_xa_pool *p,
>         if (p->idx < p->max)
>                 return 0;
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>
>         tcp_xa_pool_commit_locked(sk, p);
>
>         for (k =3D 0; k < max_frags; k++) {
> -               err =3D __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> +               err =3D __xa_alloc(&sk->sk_devmem_info.frags, &p->tokens[=
k],
>                                  XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL)=
;
>                 if (err)
>                         break;
>         }
>
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>
>         p->max =3D k;
>         p->idx =3D 0;
> @@ -2477,6 +2480,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                               unsigned int offset, struct msghdr *msg,
>                               int remaining_len)
>  {
> +       struct net_devmem_dmabuf_binding *binding =3D NULL;
>         struct dmabuf_cmsg dmabuf_cmsg =3D { 0 };
>         struct tcp_xa_pool tcp_xa_pool;
>         unsigned int start;
> @@ -2534,6 +2538,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                         skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
>                         struct net_iov *niov;
>                         u64 frag_offset;
> +                       u32 token;
>                         int end;
>
>                         /* !skb_frags_readable() should indicate that ALL=
 the
> @@ -2566,13 +2571,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, co=
nst struct sk_buff *skb,
>                                               start;
>                                 dmabuf_cmsg.frag_offset =3D frag_offset;
>                                 dmabuf_cmsg.frag_size =3D copy;
> -                               err =3D tcp_xa_pool_refill(sk, &tcp_xa_po=
ol,
> -                                                        skb_shinfo(skb)-=
>nr_frags - i);
> -                               if (err)
> +
> +                               binding =3D net_devmem_iov_binding(niov);
> +
> +                               if (!sk->sk_devmem_info.binding) {
> +                                       sk->sk_devmem_info.binding =3D bi=
nding;
> +                                       sk->sk_devmem_info.autorelease =
=3D
> +                                               binding->autorelease;
> +                               }
> +
> +                               if (sk->sk_devmem_info.binding !=3D bindi=
ng) {
> +                                       err =3D -EFAULT;
>                                         goto out;
> +                               }
> +
> +                               if (binding->autorelease) {
> +                                       err =3D tcp_xa_pool_refill(sk, &t=
cp_xa_pool,
> +                                                                skb_shin=
fo(skb)->nr_frags - i);
> +                                       if (err)
> +                                               goto out;
> +
> +                                       dmabuf_cmsg.frag_token =3D
> +                                               tcp_xa_pool.tokens[tcp_xa=
_pool.idx];
> +                               } else {
> +                                       token =3D net_iov_virtual_addr(ni=
ov) >> PAGE_SHIFT;
> +                                       dmabuf_cmsg.frag_token =3D token;
> +                               }
> +

Consider refactoring this into a helper:

tcp_xa_pool_add(...., autorelease);

>
>                                 /* Will perform the exchange later */
> -                               dmabuf_cmsg.frag_token =3D tcp_xa_pool.to=
kens[tcp_xa_pool.idx];
>                                 dmabuf_cmsg.dmabuf_id =3D net_devmem_iov_=
binding_id(niov);
>
>                                 offset +=3D copy;
> @@ -2585,8 +2612,14 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, con=
st struct sk_buff *skb,
>                                 if (err)
>                                         goto out;
>
> -                               atomic_long_inc(&niov->pp_ref_count);
> -                               tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
=3D skb_frag_netmem(frag);
> +                               if (sk->sk_devmem_info.autorelease) {
> +                                       atomic_long_inc(&niov->pp_ref_cou=
nt);
> +                                       tcp_xa_pool.netmems[tcp_xa_pool.i=
dx++] =3D
> +                                               skb_frag_netmem(frag);
> +                               } else {
> +                                       if (atomic_inc_return(&niov->uref=
) =3D=3D 1)
> +                                               atomic_long_inc(&niov->pp=
_ref_count);

I think we have a helper that does the pp_ref_count increment with a
nice name, so we don't have to look into the niov details in this
function.

Consider also factoring this into a helper, maybe:

tcp_xa_pool_get_niov(...., tcp_xa_pool, autorelease);

> +                               }
>
>                                 sent +=3D copy;
>
> @@ -2596,7 +2629,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                         start =3D end;
>                 }
>
> -               tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +               if (sk->sk_devmem_info.autorelease)
> +                       tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +

Consider doing the autorelease cehck inside of tcp_xa_pool_commit to
remove the if statements from this function, maybe nicer.

>                 if (!remaining_len)
>                         goto out;
>
> @@ -2614,7 +2649,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>         }
>
>  out:
> -       tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +       if (sk->sk_devmem_info.autorelease)
> +               tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +
>         if (!sent)
>                 sent =3D err;
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 40a76da5364a..feb15440cac4 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -89,6 +89,9 @@
>
>  #include <crypto/md5.h>
>
> +#include <linux/dma-buf.h>
> +#include "../core/devmem.h"
> +
>  #include <trace/events/tcp.h>
>
>  #ifdef CONFIG_TCP_MD5SIG
> @@ -2493,7 +2496,7 @@ static void tcp_release_user_frags(struct sock *sk)
>         unsigned long index;
>         void *netmem;
>
> -       xa_for_each(&sk->sk_user_frags, index, netmem)
> +       xa_for_each(&sk->sk_devmem_info.frags, index, netmem)
>                 WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem=
));
>  #endif
>  }
> @@ -2502,9 +2505,12 @@ void tcp_v4_destroy_sock(struct sock *sk)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
> -       tcp_release_user_frags(sk);
> +       if (sk->sk_devmem_info.binding &&
> +           sk->sk_devmem_info.binding->autorelease)
> +               tcp_release_user_frags(sk);
>
> -       xa_destroy(&sk->sk_user_frags);
> +       xa_destroy(&sk->sk_devmem_info.frags);
> +       sk->sk_devmem_info.binding =3D NULL;
>
>         trace_tcp_destroy_sock(sk);
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index ded2cf1f6006..512a3dbb57a4 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -663,7 +663,8 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>
>         __TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>
> -       xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       xa_init_flags(&newsk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
> +       newsk->sk_devmem_info.binding =3D NULL;
>
>         return newsk;
>  }
>
> --
> 2.47.3
>


--=20
Thanks,
Mina

