Return-Path: <netdev+bounces-233650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC7C16D10
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00B2F4E052B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BA2D12EB;
	Tue, 28 Oct 2025 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BABaMUMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2EC4502F
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684583; cv=none; b=fDmLK7RrR/FFOZtIVpqJz2pKAOK+EjQa7r9fzfLR0D9ceoeLLYbfJKrxDHut6q2Qk3PYOpLchB0jjotmxZEcJXFt2FQjbwP8ox+PmLzS6C4Ql6r40E0CEv0EX6zzpkFFADZxx5/5Kw+eIHJAvWSmaEc8kocI/vfYwrW7W/Pz74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684583; c=relaxed/simple;
	bh=3uRVfwobrviSUOQPmVoT1gxf3NUHjqRJW2+JVHbI8OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBCFgsUUgY3RKuBGG4bYib7chOXs1/5CJbOjdviE8a7KysbMDA4R2McNWet555vOTSBC6y+o2zVPECo1duq3XTy1dmyfN1bfDwrgrBlMMV16ZbT2FQN2Z6SHkrrysokYPBVkyFxbEPtoSF9FvprF1TqbyNWN2aWmbAXXqKLvCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BABaMUMQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-783fa3aa122so4813757b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761684580; x=1762289380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sM+8Xpw+fiWwGJwmnf4Q7eFZwklLCg+AbUQ10lHz4xM=;
        b=BABaMUMQNB/KXyNw/paiUVYKfnF9Die4eOeBjenkNb969xSczf5ybfJFIfoW/IG1iX
         McRrDaVVC6O3Kvqulq6obbrzCIIeWZqPBpatTMCaFwpGgZ8OsIlLTbFI3/sb/RVPky/c
         SdcBvsjJh8AdEdaGqJZLFH3srXkaUvtbt7tTeGfdhvnGUJf5KP4zoJQ1JQYO6ZUjyMF1
         BqSUZb4JcAWwe1RfHfMJ/KBFV5mmusgiZ6MWulj8A3JcQOTC6NmwpPDFUZjv72Gsvrjh
         Tu4ZGhz1S/3OZ84l2OTPH9leMJJgzMR2pyD6JfbDzO+WJxP8cf0ATWVn2B+XhHHpGG6H
         w0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761684580; x=1762289380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM+8Xpw+fiWwGJwmnf4Q7eFZwklLCg+AbUQ10lHz4xM=;
        b=IGdf2TVKYtd0rhf8cBtJ6ncOeNczkGzrGDooRuATVHuwOh8+0VXGhtc7IcKO2+2LgZ
         FbKVm057CwT5m0KPBiZ6Ghv2Ka2+5FkVnPpogrDoub3bJYcTdrNni0TAJYXeSWM4BiSf
         8+St4YAONmMtD1v9tavwlKUOKeHu8/Hs1BTJVkDuaW3K44WeP8X7YD+WqTbjHlYsBMgQ
         opTGYGDpGLW8twiSb5dKfdcfX5hdZr4irXXFRDMg/7Y5exyd6Ykg+AokAm/UpvXICVhA
         pKLi0efLaCFINo8WFhZzXsSbKviljwi4WcpGH0UC/BYIH5BJaEYzZ493bRPn99DkAE34
         Lhdw==
X-Forwarded-Encrypted: i=1; AJvYcCUFaIxkQODiQHPvM6KijXGbwabNYfGuuYgwq32VyZc/xwNb6R9OktZQnVzsuqWGuCZ0lWnLtGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZV+W4Jvf1eDFXL0u+rJ9FyFfidWSX5ejOHYIdxjylfASdMNry
	iMM3ey5OPOvHlmq8M+xc0kEVh1OwpK3O3kyUnsgAxZz3NPULodGqr15J
X-Gm-Gg: ASbGnct+ntczV+JeLddU4Q3/I3dtRxq7XKcZKzjGZ9KazR9nDSm96pWpewlHqgtGMWD
	HFuibHpo+bQKGGrCTheH8145jVfVlmXXKDk7x3wLjFEIL4HyNVN24WoEOTP5eGLylMOf3H1AuWC
	YBUrtRbxc4qk8lo3Wb+NCuX1nIyGz0FcfJOYFG8RGfKBbnR5DVUcHau9Qe3NBm092pYnADRUHeb
	vUwWWlXOVi4tDkBllUc3l0Q9xshLnFVTKn+GJ9/NsoRYxGw7/UZTvjUIIrGkL4/Gjx6p1WMndKd
	erEfSJNmrGRnhllvEqHR3mtSYWX83R49LXXBp97WY78oiDFuPG/33DO9Qoe+d9R2Hxg+k6gJvo1
	yZuK8zCkHVAn2/EC+4criFj1pa4kSCwwzwtCBLEvH2DiLwAxw8t1PDCQwf4PbPsZxBMxf06xyM/
	p2V2ExaQr3Ah5U6Xs2c2YH89gTpXeEjD/Eoec=
X-Google-Smtp-Source: AGHT+IGMIk7G4VEIOcnQjRo7HDDcQFq7QrXC6UjkgP+zjw6QKkpZyY4VxxNdWhbQkLBWbXGpSCSzWw==
X-Received: by 2002:a05:690c:3604:b0:782:9291:493b with SMTP id 00721157ae682-786191d385amr46890717b3.32.1761684580372;
        Tue, 28 Oct 2025 13:49:40 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed17ec77sm30280977b3.23.2025.10.28.13.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 13:49:40 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:49:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/4] net: devmem: use niov array for token
 management
Message-ID: <aQEsYs5yJC7eXgKS@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-3-47cb85f5259e@meta.com>
 <CAHS8izOKWxw=T8zk1jQL6sB8bTSK0HvNxnX=XXYLCAFtuiAwRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOKWxw=T8zk1jQL6sB8bTSK0HvNxnX=XXYLCAFtuiAwRw@mail.gmail.com>

On Mon, Oct 27, 2025 at 06:20:20PM -0700, Mina Almasry wrote:
> On Thu, Oct 23, 2025 at 2:00 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >

[...]

> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 01ce231603db..1963ab54c465 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -350,7 +350,7 @@ struct sk_filter;
> >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> >    *    @sk_scm_unused: unused flags for scm_recv()
> >    *    @ns_tracker: tracker for netns reference
> > -  *    @sk_user_frags: xarray of pages the user is holding a reference on.
> > +  *    @sk_devmem_info: the devmem binding information for the socket
> >    *    @sk_owner: reference to the real owner of the socket that calls
> >    *               sock_lock_init_class_and_name().
> >    */
> > @@ -579,7 +579,11 @@ struct sock {
> >         struct numa_drop_counters *sk_drop_counters;
> >         struct rcu_head         sk_rcu;
> >         netns_tracker           ns_tracker;
> > -       struct xarray           sk_user_frags;
> > +       struct {
> > +               struct xarray                           frags;
> > +               struct net_devmem_dmabuf_binding        *binding;
> > +               bool                                    autorelease;
> 
> Maybe autorelease should be a property of the binding, no? I can't
> wrap my head around a binding that has some autorelease sockets and
> some non-autorelease sockets, semantically.
> 

Right, it is definitely ill placed here. It never deviates from
binding->autorelease, so no need for it.

> > +       } sk_devmem_info;
> >
> >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> >         struct module           *sk_owner;
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index b4c570d4f37a..8f3199fe0f7b 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/genalloc.h>
> >  #include <linux/mm.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/skbuff_ref.h>
> >  #include <linux/types.h>
> >  #include <net/netdev_queues.h>
> >  #include <net/netdev_rx_queue.h>
> > @@ -115,6 +116,29 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
> >         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> >  }
> >
> > +static void
> > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
> > +{
> > +       int i;
> > +
> > +       if (binding->autorelease)
> > +               return;
> > +
> 
> I think cosmetically it's better to put this check in the caller.
> 

Sounds good!

> > +       for (i = 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> > +               struct net_iov *niov;
> > +               netmem_ref netmem;
> > +
> > +               niov = binding->vec[i];
> > +
> > +               if (!net_is_devmem_iov(niov))
> > +                       continue;
> > +
> 
> This is an extremely defensive check. I have no idea how we could
> possibly have a non devmem iov here. Maybe DEBUG_NET_WARN_ON instead?
> Or remove.
> 

Makes sense. I did not run into any real issues, I mistakenly borrowed
this check from the skb->frag handling code... will remove.

> > +               netmem = net_iov_to_netmem(niov);
> > +               if (atomic_xchg(&niov->uref, 0) > 0)
> > +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> 
> This is subtle enough that it can use a comment. Multiple urefs map to
> only 1 netmem ref.
> 

Will do.

[...]

> > @@ -291,10 +315,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                         niov = &owner->area.niovs[i];
> >                         niov->type = NET_IOV_DMABUF;
> >                         niov->owner = &owner->area;
> > +                       atomic_set(&niov->uref, 0);
> >                         page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
> >                                                       net_devmem_get_dma_addr(niov));
> > -                       if (direction == DMA_TO_DEVICE)
> > -                               binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> > +                       binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> >                 }
> >
> >                 virtual += len;
> > @@ -307,6 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                 goto err_free_chunks;
> >
> >         list_add(&binding->list, &priv->bindings);
> > +       binding->autorelease = true;
> >
> 
> So autorelease is indeed a property of the binding. Not sure why a
> copy exists in sk_devmem_info. Perf optimization to reduce pointer
> chasing?
> 

Just stale code from prior design... Originally, I was going to try to
allow the autorelease == true case to be free of the
one-binding-per-socket restriction, in which case sk_devmem_info.binding
would be NULL (or otherwise meaningless). sk_devmem_info.autorelease
allowed sock_devmem_dontneed to choose the right path even when
sk_devmem_info.binding == NULL.

...but then I realized we still needed some restriction to avoid sockets
from steering into different dmabufs with different autorelease configs,
so kept the one-binding restriction for both modes. I abandoned the
effort, but forgot to revert this change.

Now I'm realizing that we could relax the restriction more though... We
could allow sockets to steer into other bindings if they all have the
same autorelease value? Then we could still use
sk_devmem_info.binding->autorelease in the sock_devmem_dontneed path and
relax the restriction to "steering must only be to bindings of the same
autorelease mode"?

> I thought autorelease would be 'false' by default. I.e. the user gets
> better perf by default. Maybe this is flipped in the following patch I
> haven't opened yet.
> 

That is right, it is in the next patch. I didn't want to change the
default without also adding the ability to revert back.

> >         return binding;
> >
> > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > index 2ada54fb63d7..7662e9e42c35 100644
> > --- a/net/core/devmem.h
> > +++ b/net/core/devmem.h
> > @@ -61,11 +61,20 @@ struct net_devmem_dmabuf_binding {
> >
> >         /* Array of net_iov pointers for this binding, sorted by virtual
> >          * address. This array is convenient to map the virtual addresses to
> > -        * net_iovs in the TX path.
> > +        * net_iovs.
> >          */
> >         struct net_iov **vec;
> >
> >         struct work_struct unbind_w;
> > +
> > +       /* If true, outstanding tokens will be automatically released upon each
> > +        * socket's close(2).
> > +        *
> > +        * If false, then sockets are responsible for releasing tokens before
> > +        * close(2). The kernel will only release lingering tokens when the
> > +        * dmabuf is unbound.
> > +        */
> 
> Needs devmem.rst doc update.
> 

Will do.

> > +       bool autorelease;
> >  };
> >
> >  #if defined(CONFIG_NET_DEVMEM)
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index e7b378753763..595b5a858d03 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -87,6 +87,7 @@
> >
> >  #include <linux/unaligned.h>
> >  #include <linux/capability.h>
> > +#include <linux/dma-buf.h>
> >  #include <linux/errno.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/types.h>
> > @@ -151,6 +152,7 @@
> >  #include <uapi/linux/pidfd.h>
> >
> >  #include "dev.h"
> > +#include "devmem.h"
> >
> >  static DEFINE_MUTEX(proto_list_mutex);
> >  static LIST_HEAD(proto_list);
> > @@ -1081,6 +1083,57 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
> >  #define MAX_DONTNEED_TOKENS 128
> >  #define MAX_DONTNEED_FRAGS 1024
> >
> > +static noinline_for_stack int
> > +sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token *tokens,
> > +                                   unsigned int num_tokens)
> > +{
> > +       unsigned int netmem_num = 0;
> > +       int ret = 0, num_frags = 0;
> > +       netmem_ref netmems[16];
> > +       struct net_iov *niov;
> > +       unsigned int i, j, k;
> > +
> > +       for (i = 0; i < num_tokens; i++) {
> > +               for (j = 0; j < tokens[i].token_count; j++) {
> > +                       struct net_iov *niov;
> > +                       unsigned int token;
> > +                       netmem_ref netmem;
> > +
> > +                       token = tokens[i].token_start + j;
> > +                       if (token >= sk->sk_devmem_info.binding->dmabuf->size / PAGE_SIZE)
> > +                               break;
> > +
> 
> This requires some thought. The correct thing to do here is EINVAL
> without modifying the urefs at all I think. You may need an
> input-verification loop. Breaking and returning success here is not
> great, I think.
> 

Should this also be changed for the other path as well? Right now if
__xa_erase returns NULL (e.g., user passed in a bad token), then we hit
"continue" and process the next token... eventually just returning the
number of tokens that were successfully processed and omitting the wrong
ones.

> > +                       if (++num_frags > MAX_DONTNEED_FRAGS)
> > +                               goto frag_limit_reached;
> > +                       niov = sk->sk_devmem_info.binding->vec[token];
> > +                       netmem = net_iov_to_netmem(niov);
> > +
> > +                       if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> > +                               continue;
> > +
> 
> This check is extremely defensive. There is no way netmem is not a
> netiov (you just converted it). It's also very hard for it to be NULL.
> Remove maybe.
> 

Removing sounds good to me.

> > +                       netmems[netmem_num++] = netmem;
> > +                       if (netmem_num == ARRAY_SIZE(netmems)) {
> > +                               for (k = 0; k < netmem_num; k++) {
> > +                                       niov = netmem_to_net_iov(netmems[k]);
> 
> No need to upcast to netmem only to downcast here back to net_iov.
> Just keep it net_iov?
> 

Sounds good.

> > +                                       if (atomic_dec_and_test(&niov->uref))
> > +                                               WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> 
> I see. So you're only only napi_pp_put_pageing the last uref dec, but
> why? How about you

Just to minimize cache bus noise from the extra atomic.

> > +                               }
> > +                               netmem_num = 0;
> > +                       }
> 
> From a quick look, I don't think you need the netmems[] array or this
> inner loop.
> 
> dontneed_autorelease is complicatingly written because it acquires a
> lock, and we wanted to minimize the lock acquire. You are acquiring no
> lock here. AFAICT you can just loop over the tokens and free all of
> them in one (nested) loop.

Oh good point. There is no need to batch at all here.

> 
> > +                       ret++;
> > +               }
> > +       }
> > +
> > +frag_limit_reached:
> > +       for (k = 0; k < netmem_num; k++) {
> > +               niov = netmem_to_net_iov(netmems[k]);
> > +               if (atomic_dec_and_test(&niov->uref))
> > +                       WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static noinline_for_stack int
> >  sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
> >                                  unsigned int num_tokens)
> > @@ -1089,32 +1142,32 @@ sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
> >         int ret = 0, num_frags = 0;
> >         netmem_ref netmems[16];
> >
> > -       xa_lock_bh(&sk->sk_user_frags);
> > +       xa_lock_bh(&sk->sk_devmem_info.frags);
> >         for (i = 0; i < num_tokens; i++) {
> >                 for (j = 0; j < tokens[i].token_count; j++) {
> >                         if (++num_frags > MAX_DONTNEED_FRAGS)
> >                                 goto frag_limit_reached;
> >
> >                         netmem_ref netmem = (__force netmem_ref)__xa_erase(
> > -                               &sk->sk_user_frags, tokens[i].token_start + j);
> > +                               &sk->sk_devmem_info.frags, tokens[i].token_start + j);
> >
> >                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> >                                 continue;
> >
> >                         netmems[netmem_num++] = netmem;
> >                         if (netmem_num == ARRAY_SIZE(netmems)) {
> > -                               xa_unlock_bh(&sk->sk_user_frags);
> > +                               xa_unlock_bh(&sk->sk_devmem_info.frags);
> >                                 for (k = 0; k < netmem_num; k++)
> >                                         WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> >                                 netmem_num = 0;
> > -                               xa_lock_bh(&sk->sk_user_frags);
> > +                               xa_lock_bh(&sk->sk_devmem_info.frags);
> >                         }
> >                         ret++;
> >                 }
> >         }
> >
> >  frag_limit_reached:
> > -       xa_unlock_bh(&sk->sk_user_frags);
> > +       xa_unlock_bh(&sk->sk_devmem_info.frags);
> >         for (k = 0; k < netmem_num; k++)
> >                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> >
> > @@ -1135,6 +1188,12 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> >             optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> >                 return -EINVAL;
> >
> > +       /* recvmsg() has never returned a token for this socket, which needs to
> > +        * happen before we know if the dmabuf has autorelease set or not.
> > +        */
> > +       if (!sk->sk_devmem_info.binding)
> > +               return -EINVAL;
> > +
> 
> Hmm. At first glance I don't think enforcing this condition if
> binding->autorelease is necessary, no?
> 
> If autorelease is on, then we track the tokens the old way, and we
> don't need a binding, no? If it's off, then we need an associated
> binding, to look up the urefs array.
> 

We at least need the binding to know if binding->autorelease is on,
since without that we don't know whether the tokens are in the xarray or
binding->vec... but I guess we could also check if the xarray is
non-empty and infer that autorelease == true from that?

[...]

> > +                               if (binding->autorelease) {
> > +                                       err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
> > +                                                                skb_shinfo(skb)->nr_frags - i);
> > +                                       if (err)
> > +                                               goto out;
> > +
> > +                                       dmabuf_cmsg.frag_token =
> > +                                               tcp_xa_pool.tokens[tcp_xa_pool.idx];
> > +                               } else {
> > +                                       token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
> > +                                       dmabuf_cmsg.frag_token = token;
> > +                               }
> > +
> 
> Consider refactoring this into a helper:
> 
> tcp_xa_pool_add(...., autorelease);
> 

Will do.

> >
> >                                 /* Will perform the exchange later */
> > -                               dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
> >                                 dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
> >
> >                                 offset += copy;
> > @@ -2585,8 +2612,14 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >                                 if (err)
> >                                         goto out;
> >
> > -                               atomic_long_inc(&niov->pp_ref_count);
> > -                               tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
> > +                               if (sk->sk_devmem_info.autorelease) {
> > +                                       atomic_long_inc(&niov->pp_ref_count);
> > +                                       tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
> > +                                               skb_frag_netmem(frag);
> > +                               } else {
> > +                                       if (atomic_inc_return(&niov->uref) == 1)
> > +                                               atomic_long_inc(&niov->pp_ref_count);
> 
> I think we have a helper that does the pp_ref_count increment with a
> nice name, so we don't have to look into the niov details in this
> function.
> 
> Consider also factoring this into a helper, maybe:
> 
> tcp_xa_pool_get_niov(...., tcp_xa_pool, autorelease);
> 

Sounds good.

> > +                               }
> >
> >                                 sent += copy;
> >
> > @@ -2596,7 +2629,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >                         start = end;
> >                 }
> >
> > -               tcp_xa_pool_commit(sk, &tcp_xa_pool);
> > +               if (sk->sk_devmem_info.autorelease)
> > +                       tcp_xa_pool_commit(sk, &tcp_xa_pool);
> > +
> 
> Consider doing the autorelease cehck inside of tcp_xa_pool_commit to
> remove the if statements from this function, maybe nicer.
> 

Sounds good.

[...]

> -- 
> Thanks,
> Mina

Thanks!

-Bobby

