Return-Path: <netdev+bounces-219689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D54FB42AC9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783C8683D99
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8636998D;
	Wed,  3 Sep 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlkrVRL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E92DE718
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930875; cv=none; b=Fa12LTnIvIgFMHtcZThNhQTkM89zQsM2Dn3WbrrGNYsOle7eeIRBDi2nGx39D6RuznOE4FeFdbbw/xvb++ejs+3iY3xBZILdILn2sxJkcaeg5xtKDnJvjwguBn0kW+M4uVK+lsUcpt94P7w5UxN8wlC7o3UDOiKmnSJYNiFzasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930875; c=relaxed/simple;
	bh=tHjNsviCGo1l5rnXD4rX5YQFTY92PhBbg5Xh5TGBdpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2ZlCJ0qFEJlQZNnYrXAt2YxlJrMmQ/HqB6zxEacmIYRYm+5ZHrKpeZn8+l6pLR6wfIj1hMNcse0er3N8zvRUmkTG0WgL+SoeYeeH4/8k6FrZbD+fUkKe1yXWsjeyRdynie3ymqWI9PC+JEnwsaSu+Ao1UHU5N0ajIzKiKEYVQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlkrVRL2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso1804e87.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756930871; x=1757535671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i97Rh77tk+oabqZJ1EdJ7T8qyxTMJxxh7DJxtd7n30w=;
        b=IlkrVRL2tU1W6JFt8KnYtJrSmbq7klAd7UbOZd0eWJ9t+AJKVOQtnhLoFTzD3folJv
         bPJXpwPxv+IKxsd/8HK4OrA0yjdBgdtCswm1KqdMd4jzLvkmt76CUffjeoVGDBmaAd4+
         m/tmOuazv/O+M4Som8H1kqX35sbGlhRnTN4Do3n/rLBQODDgZgN8Ab8DG9z6C6R/KHkt
         rpvp62cWH4VHDX5hH5CJga9atiaV1Mfh7/D04lUCWu7VfawM4iVYI2qM25+vcDfHtgJ8
         QWInEAmfhVvMLNS7ELXv9Wrs7t2RF1fu5vlT6WJ2nA/kkfnCS+bV7ok1Oh5JjjTut5qS
         ZxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756930871; x=1757535671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i97Rh77tk+oabqZJ1EdJ7T8qyxTMJxxh7DJxtd7n30w=;
        b=nIEeeNcmi/9astibwOTKXk5GgKq5PclVaB9FouFsxRm+iCZynmnMuxMk1a2UtKYlrF
         1iESWB3gzrM6l6qbmTxJD5AVJzPLMGfjiXM5JFVW5AAJ2ke8vq4e7XmlFlGSC3gxphDC
         xTT6vl1PFB51uXkkIQIpB/1KjGGVL9Xpjxg4MGLGuXj5tEmhNXQGI/xLXjaFeyAYgBhg
         T+i7aH7mlYSZ+2QwaknI12uCrOx77inQvWcWsSsAnfzYCfEd0FBBwYSuDURu296yrp7h
         0A0076kL2s88cbHwpJoEinbwi7Y5l3GNjX2uuDgl4k6cYL6WbSvaCDr0CmO0JpJpuGvr
         azUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtCOSQKGqeoD4dVoiCziLMK/W07W4Nj5Zz0zmQzKWb0bkqKCNGsO8Irz8QnP62jzS+iy+7UQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LVxltihpzpmrRJNyCJAqzuIsMxMhNnDNjNoJg0ZwYOrC9QPU
	J08udQ2PdJo+AWNWDWmymrlqvqJCgaWz8lpAV8uGn+Q4ZPXuaIghb9cfMuxJCEZ+gl5K3Cd605M
	Bg+wKwucIA21s7qOcRtSyXkxL41OPZ/IZ92QA5MAd
X-Gm-Gg: ASbGnctxHCjlIAjPP4gANcivssxCltqfOAkgopm+psu7I37g0kOIbTWPAV4Zf4hxQXB
	1CKnNMkPMouNoFUWD3ANKbaeNKHasZfo0C6DWeWI4CM4N+WrZHrNyfXm+DVyBdy77Oyh27kGyfg
	ABYF7t5+gS/xVC6laGa29DdLi6Yab10l1rRNVnYR+bMR2rxu6wB4B7xJrPCcMDxvs2vH9tPUAOd
	oov9N/H2F/LGE1oLWUHc2TEmhcPcJ9I3tX8Cf9/RQ==
X-Google-Smtp-Source: AGHT+IGwGZ8p3kOcbpV/Nfgo4am2O/68lrJ7hT1yoEssfaxz3mDLVVseOk39H5vJSuDz1y+noyukOnHJvckqZQkK43I=
X-Received: by 2002:ac2:5f4f:0:b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-55f6f4fa412mr771466e87.6.1756930870623; Wed, 03 Sep 2025
 13:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
 <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
In-Reply-To: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 3 Sep 2025 13:20:57 -0700
X-Gm-Features: Ac12FXzGhUxBTdRSlqWj0UYapuGi-o9yy28Bbj403WgH46O-lqgkO92lGPKC2Co
Message-ID: <CAHS8izPrf1b_H_FNu2JtnMVpaD6SwHGvg6bC=Fjd4zfp=-pd6w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: devmem: use niov array for token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:36=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Improve CPU performance of devmem token management by using page offsets
> as dmabuf tokens and using them for direct array access lookups instead
> of xarray lookups. Consequently, the xarray can be removed. The result
> is an average 5% reduction in CPU cycles spent by devmem RX user
> threads.
>

Great!

> This patch changes the meaning of tokens. Tokens previously referred to
> unique fragments of pages. In this patch tokens instead represent
> references to pages, not fragments.  Because of this, multiple tokens
> may refer to the same page and so have identical value (e.g., two small
> fragments may coexist on the same page). The token and offset pair that
> the user receives uniquely identifies fragments if needed.  This assumes
> that the user is not attempting to sort / uniq the token list using
> tokens alone.
>
> A new restriction is added to the implementation: devmem RX sockets
> cannot switch dmabuf bindings. In practice, this is a symptom of invalid
> configuration as a flow would have to be steered to a different queue or
> device where there is a different binding, which is generally bad for
> TCP flows.

Please do not assume configurations you don't use/care about are
invalid. Currently reconfiguring flow steering while a flow is active
works as intended today. This is a regression that needs to be
resolved. But more importantly, looking at your code, I don't think
this is a restriction you need to introduce?

> This restriction is necessary because the 32-bit dmabuf token
> does not have enough bits to represent both the pages in a large dmabuf
> and also a binding or dmabuf ID. For example, a system with 8 NICs and
> 32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queues
> =3D=3D 256 queues total =3D=3D 2^8), which leaves only 24 bits for dmabuf=
 pages
> (2^24 * 4096 / (1<<30) =3D=3D 64GB). This is insufficient for the device =
and
> queue numbers on many current systems or systems that may need larger
> GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory per
> device).
>
> Using kperf[1] with 4 flows and workers, this patch improves receive
> worker CPU util by ~4.9% with slightly better throughput.
>
> Before, mean cpu util for rx workers ~83.6%:
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
> Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0.00 =
   0.00    0.00   17.41
> Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0.00 =
   0.00    0.00   16.67
> Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0.00 =
   0.00    0.00   16.54
> Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0.00 =
   0.00    0.00   14.86
>
> After, mean cpu util % for rx workers ~78.7%:
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
> Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0.00 =
   0.00    0.00   23.20
> Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0.00 =
   0.00    0.00   21.94
> Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0.00 =
   0.00    0.00   22.73
> Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0.00 =
   0.00    0.00   17.32
>

I think effectively all you're doing in this patch is removing xarray
with a regular array, right? I'm surprised an xarray account for 5%
cpu utilization. I wonder if you have debug configs turned on during
these experiments. Can you perf trace what about the xarray is taking
so long? I wonder if we're just using xarrays improperly (maybe
hitting constant resizing slow paths or something), and a similar
improvement can be gotten by adjusting the xarray flags or what not.

> Mean throughput improves, but falls within a standard deviation (~45GB/s
> for 4 flows on a 50GB/s NIC, one hop).
>
> This patch adds an array of atomics for counting the tokens returned to
> the user for a given page. There is a 4-byte atomic per page in the
> dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.
>
> [1]: https://github.com/facebookexperimental/kperf
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  include/net/sock.h       |   5 ++-
>  net/core/devmem.c        |  17 ++++----
>  net/core/devmem.h        |   2 +-
>  net/core/sock.c          |  24 +++++++----
>  net/ipv4/tcp.c           | 107 +++++++++++++++--------------------------=
------
>  net/ipv4/tcp_ipv4.c      |  40 +++++++++++++++---
>  net/ipv4/tcp_minisocks.c |   2 -
>  7 files changed, 99 insertions(+), 98 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 1e7f124871d2..70c97880229d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -573,7 +573,10 @@ struct sock {
>  #endif
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
> -       struct xarray           sk_user_frags;
> +       struct {
> +               struct net_devmem_dmabuf_binding        *binding;
> +               atomic_t                                *urefs;
> +       } sk_user_frags;
>

AFAIU, if you made sk_user_frags an array of (unref, binding) tuples
instead of just an array of urefs then you can remove the
single-binding restriction.

Although, I wonder what happens if the socket receives the netmem at
the same index on 2 different dmabufs. At that point I assume the
wrong uref gets incremented? :(

One way or another the single-binding restriction needs to be removed
I think. It's regressing a UAPI that currently works.

>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>         struct module           *sk_owner;
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index b4c570d4f37a..50e92dcf5bf1 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -187,6 +187,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>         struct dma_buf *dmabuf;
>         unsigned int sg_idx, i;
>         unsigned long virtual;
> +       gfp_t flags;
>         int err;
>
>         if (!dma_dev) {
> @@ -230,14 +231,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
> +       flags =3D (direction =3D=3D DMA_FROM_DEVICE) ? __GFP_ZERO : 0;
> +

Why not pass __GFP_ZERO unconditionally?

> +       binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +                                     sizeof(struct net_iov *),
> +                                     GFP_KERNEL | flags);
> +       if (!binding->vec) {
> +               err =3D -ENOMEM;
> +               goto err_unmap;
>         }
>
>         /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 2ada54fb63d7..d4eb28d079bb 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -61,7 +61,7 @@ struct net_devmem_dmabuf_binding {
>
>         /* Array of net_iov pointers for this binding, sorted by virtual
>          * address. This array is convenient to map the virtual addresses=
 to
> -        * net_iovs in the TX path.
> +        * net_iovs.
>          */
>         struct net_iov **vec;
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9a8290fcc35d..3a5cb4e10519 100644
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
> @@ -1100,32 +1102,40 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t o=
ptval, unsigned int optlen)
>                 return -EFAULT;
>         }
>
> -       xa_lock_bh(&sk->sk_user_frags);
>         for (i =3D 0; i < num_tokens; i++) {
>                 for (j =3D 0; j < tokens[i].token_count; j++) {
> +                       struct net_iov *niov;
> +                       unsigned int token;
> +                       netmem_ref netmem;
> +
> +                       token =3D tokens[i].token_start + j;
> +                       if (WARN_ONCE(token >=3D sk->sk_user_frags.bindin=
g->dmabuf->size / PAGE_SIZE,
> +                                     "invalid token passed from user"))
> +                               break;

WARNs on invalid user behavior are a non-starter AFAIU. For one,
syzbot trivially reproduces them and files a bug. Please remove all of
them. pr_err may be acceptable for extremely bad errors. Invalid user
input is not worthy of WARN or pr_err.

> +
>                         if (++num_frags > MAX_DONTNEED_FRAGS)
>                                 goto frag_limit_reached;
> -
> -                       netmem_ref netmem =3D (__force netmem_ref)__xa_er=
ase(
> -                               &sk->sk_user_frags, tokens[i].token_start=
 + j);
> +                       niov =3D sk->sk_user_frags.binding->vec[token];
> +                       netmem =3D net_iov_to_netmem(niov);

So token is the index to both vec and sk->sk_user_frags.binding->vec?

xarrays are a resizable array. AFAIU what you're doing abstractly here
is replacing a resizable array with an array of max size, no? (I
didn't read too closely yet, I may be missing something).

Which makes me think either due to a bug or due to specifics of your
setup, xarray is unreasonably expensive. Without investigating the
details I wonder if we're constantly running into a resizing slowpath
in xarray code and I think this needs some investigation.

>
>                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(ne=
tmem)))
>                                 continue;
>
> +                       if (WARN_ONCE(atomic_dec_if_positive(&sk->sk_user=
_frags.urefs[token])
> +                                               < 0, "user released token=
 too many times"))

Here and everywhere, please remove the WARNs for weird user behavior.

> +                               continue;
> +
>                         netmems[netmem_num++] =3D netmem;
>                         if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> -                               xa_unlock_bh(&sk->sk_user_frags);
>                                 for (k =3D 0; k < netmem_num; k++)
>                                         WARN_ON_ONCE(!napi_pp_put_page(ne=
tmems[k]));
>                                 netmem_num =3D 0;
> -                               xa_lock_bh(&sk->sk_user_frags);

You remove the locking but it's not clear to me why we don't need it
anymore. What's stopping 2 dontneeds from freeing at the same time?
I'm guessing it's because urefs are atomic so we don't need any extra
sync?

>                         }
>                         ret++;
>                 }
>         }
>
>  frag_limit_reached:
> -       xa_unlock_bh(&sk->sk_user_frags);
>         for (k =3D 0; k < netmem_num; k++)
>                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 40b774b4f587..585b50fa8c00 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -261,6 +261,7 @@
>  #include <linux/memblock.h>
>  #include <linux/highmem.h>
>  #include <linux/cache.h>
> +#include <linux/dma-buf.h>
>  #include <linux/err.h>
>  #include <linux/time.h>
>  #include <linux/slab.h>
> @@ -475,7 +476,8 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> -       xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       sk->sk_user_frags.binding =3D NULL;
> +       sk->sk_user_frags.urefs =3D NULL;
>  }
>  EXPORT_IPV6_MOD(tcp_init_sock);
>
> @@ -2386,68 +2388,6 @@ static int tcp_inq_hint(struct sock *sk)
>         return inq;
>  }
>
> -/* batch __xa_alloc() calls and reduce xa_lock()/xa_unlock() overhead. *=
/
> -struct tcp_xa_pool {
> -       u8              max; /* max <=3D MAX_SKB_FRAGS */
> -       u8              idx; /* idx <=3D max */
> -       __u32           tokens[MAX_SKB_FRAGS];
> -       netmem_ref      netmems[MAX_SKB_FRAGS];
> -};
> -
> -static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_poo=
l *p)
> -{
> -       int i;
> -
> -       /* Commit part that has been copied to user space. */
> -       for (i =3D 0; i < p->idx; i++)
> -               __xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_EN=
TRY,
> -                            (__force void *)p->netmems[i], GFP_KERNEL);
> -       /* Rollback what has been pre-allocated and is no longer needed. =
*/
> -       for (; i < p->max; i++)
> -               __xa_erase(&sk->sk_user_frags, p->tokens[i]);
> -
> -       p->max =3D 0;
> -       p->idx =3D 0;
> -}
> -
> -static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
> -{
> -       if (!p->max)
> -               return;
> -
> -       xa_lock_bh(&sk->sk_user_frags);
> -
> -       tcp_xa_pool_commit_locked(sk, p);
> -
> -       xa_unlock_bh(&sk->sk_user_frags);
> -}
> -
> -static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> -                             unsigned int max_frags)
> -{
> -       int err, k;
> -
> -       if (p->idx < p->max)
> -               return 0;
> -
> -       xa_lock_bh(&sk->sk_user_frags);
> -
> -       tcp_xa_pool_commit_locked(sk, p);
> -
> -       for (k =3D 0; k < max_frags; k++) {
> -               err =3D __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> -                                XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL)=
;
> -               if (err)
> -                       break;
> -       }
> -
> -       xa_unlock_bh(&sk->sk_user_frags);
> -
> -       p->max =3D k;
> -       p->idx =3D 0;
> -       return k ? 0 : err;
> -}
> -
>  /* On error, returns the -errno. On success, returns number of bytes sen=
t to the
>   * user. May not consume all of @remaining_len.
>   */
> @@ -2456,14 +2396,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, co=
nst struct sk_buff *skb,
>                               int remaining_len)
>  {
>         struct dmabuf_cmsg dmabuf_cmsg =3D { 0 };
> -       struct tcp_xa_pool tcp_xa_pool;
>         unsigned int start;
>         int i, copy, n;
>         int sent =3D 0;
>         int err =3D 0;
>
> -       tcp_xa_pool.max =3D 0;
> -       tcp_xa_pool.idx =3D 0;
>         do {
>                 start =3D skb_headlen(skb);
>
> @@ -2510,8 +2447,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, con=
st struct sk_buff *skb,
>                  */
>                 for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
>                         skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> +                       struct net_devmem_dmabuf_binding *binding;
>                         struct net_iov *niov;
>                         u64 frag_offset;
> +                       size_t size;
> +                       u32 token;
>                         int end;
>
>                         /* !skb_frags_readable() should indicate that ALL=
 the
> @@ -2544,13 +2484,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, co=
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
> +                               if (!sk->sk_user_frags.binding) {
> +                                       sk->sk_user_frags.binding =3D bin=
ding;
> +
> +                                       size =3D binding->dmabuf->size / =
PAGE_SIZE;
> +                                       sk->sk_user_frags.urefs =3D kzall=
oc(size,
> +                                                                        =
 GFP_KERNEL);
> +                                       if (!sk->sk_user_frags.urefs) {
> +                                               sk->sk_user_frags.binding=
 =3D NULL;
> +                                               err =3D -ENOMEM;
> +                                               goto out;
> +                                       }
> +
> +                                       net_devmem_dmabuf_binding_get(bin=
ding);

It's not clear to me why we need to get the binding. AFAIR the way it
works is that we grab a reference on the net_iov, which guarantees
that the associated pp is alive, which in turn guarantees that the
binding remains alive and we don't need to get the binding for every
frag.

> +                               }
> +
> +                               if (WARN_ONCE(sk->sk_user_frags.binding !=
=3D binding,
> +                                             "binding changed for devmem=
 socket")) {

Remove WARN_ONCE. It's not reasonable to kernel splat because the user
reconfigured flow steering me thinks.

> +                                       err =3D -EFAULT;
>                                         goto out;
> +                               }
> +
> +                               token =3D net_iov_virtual_addr(niov) >> P=
AGE_SHIFT;
> +                               binding->vec[token] =3D niov;

I don't think you can do this? I thought vec[token] was already =3D=3D niov=
.

binding->vec should be initialized when teh binding is initialized,
not re-written on every recvmsg, no?

> +                               dmabuf_cmsg.frag_token =3D token;
>
>                                 /* Will perform the exchange later */
> -                               dmabuf_cmsg.frag_token =3D tcp_xa_pool.to=
kens[tcp_xa_pool.idx];
>                                 dmabuf_cmsg.dmabuf_id =3D net_devmem_iov_=
binding_id(niov);
>
>                                 offset +=3D copy;
> @@ -2563,8 +2525,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                                 if (err)
>                                         goto out;
>
> +                               atomic_inc(&sk->sk_user_frags.urefs[token=
]);
> +
>                                 atomic_long_inc(&niov->pp_ref_count);
> -                               tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
=3D skb_frag_netmem(frag);
>
>                                 sent +=3D copy;
>
> @@ -2574,7 +2537,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                         start =3D end;
>                 }
>
> -               tcp_xa_pool_commit(sk, &tcp_xa_pool);
>                 if (!remaining_len)
>                         goto out;
>
> @@ -2592,7 +2554,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>         }
>
>  out:
> -       tcp_xa_pool_commit(sk, &tcp_xa_pool);
>         if (!sent)
>                 sent =3D err;
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 1e58a8a9ff7a..bdcb8cc003af 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -87,6 +87,9 @@
>  #include <crypto/hash.h>
>  #include <linux/scatterlist.h>
>
> +#include <linux/dma-buf.h>
> +#include "../core/devmem.h"
> +
>  #include <trace/events/tcp.h>
>
>  #ifdef CONFIG_TCP_MD5SIG
> @@ -2529,11 +2532,38 @@ static void tcp_md5sig_info_free_rcu(struct rcu_h=
ead *head)
>  static void tcp_release_user_frags(struct sock *sk)
>  {
>  #ifdef CONFIG_PAGE_POOL
> -       unsigned long index;
> -       void *netmem;
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct net_iov *niov;
> +       unsigned int token;
> +       netmem_ref netmem;
> +
> +       if (!sk->sk_user_frags.urefs)
> +               return;
> +
> +       binding =3D sk->sk_user_frags.binding;
> +       if (!binding || !binding->vec)
> +               return;
> +
> +       for (token =3D 0; token < binding->dmabuf->size / PAGE_SIZE; toke=
n++) {
> +               niov =3D binding->vec[token];
> +
> +               /* never used by recvmsg() */
> +               if (!niov)
> +                       continue;
> +
> +               if (!net_is_devmem_iov(niov))
> +                       continue;
> +
> +               netmem =3D net_iov_to_netmem(niov);
>
> -       xa_for_each(&sk->sk_user_frags, index, netmem)
> -               WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem=
));
> +               while (atomic_dec_return(&sk->sk_user_frags.urefs[token])=
 >=3D 0)
> +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +       }
> +
> +       net_devmem_dmabuf_binding_put(binding);
> +       sk->sk_user_frags.binding =3D NULL;
> +       kvfree(sk->sk_user_frags.urefs);
> +       sk->sk_user_frags.urefs =3D NULL;
>  #endif
>  }
>
> @@ -2543,8 +2573,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
>
>         tcp_release_user_frags(sk);
>
> -       xa_destroy(&sk->sk_user_frags);
> -
>         trace_tcp_destroy_sock(sk);
>
>         tcp_clear_xmit_timers(sk);
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index d1c9e4088646..4e8ea73daab7 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -639,8 +639,6 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>
>         __TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>
> -       xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
> -
>         return newsk;
>  }
>  EXPORT_SYMBOL(tcp_create_openreq_child);
>
> --
> 2.47.3
>


--=20
Thanks,
Mina

