Return-Path: <netdev+bounces-189604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C071AB2CB1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 02:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB442176E14
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EAD1A8403;
	Mon, 12 May 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee1JYwZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A012EB10
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747011377; cv=none; b=jgHlfT5RgxnkG+oC4qknPC1UxwC0v4IT2U3+EcuJXvN3+58V1tXjuuV/REUY4F+hbFefQiUmzoK9+b8Thv4iSQeG2agzKzUtL4EjVK7H8ymWYLiknOjiXjUs5nBzNxClUgGZck6mMzxxiAuWJzbqFRDVSSSD23SLgZQ8HPplvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747011377; c=relaxed/simple;
	bh=SvB4nlILXJW69eUX+3wl+xAXVYNeQ/3FXkeCMddHS2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dL9ZYAUjSInjXN6woatqHY4RB8YGLGjF2/kuFFsXW6S8SF92QEvOqjhn3FKpBZvw6qWehopnOcGjgeug5h+FH6Qn+2IkaiHHZc/YYCDeK9pcwHlbJ55MDCvDcDc2qjCG/iPIdxCkcim0XcIl/DPJMIy+gOJVa9/Y6e8m72FNvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee1JYwZh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so6362657a12.3
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 17:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747011373; x=1747616173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP70G7UGo5hUm9MLjbW/0IIqGSn7PcahyALfFJynBAU=;
        b=Ee1JYwZh8Ev5g7PP9scj7t4vEe4PDrgekRBZdy24aOSsPgcJ0y9mhi/COptOwEHCa7
         r57x+NCWzJC8ipIKGEVfAZz2OsTRDmxO5dEM+6hyrlEoO7t8+7a6P2gFqIRw3YEWZp9q
         3Ao2xEta4VfSpTLMjkXswWNTA67sFFB93V3BsnN6Bouo9ztOD2gnjMxmPnhmcExxXKUN
         9/1dH0QTcLPWPZ29U/KO1E3/4zsHNHUK5UBdD6bRqeVYKR/+dgzHAt7OyTb63ar7/CeH
         XM/1HX3qMAbbRU3DWNmhIG0X1eq288YX0gSAeH0OKjMdBNYsaJYaxhBaSMpPLamVhv3R
         VVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747011373; x=1747616173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP70G7UGo5hUm9MLjbW/0IIqGSn7PcahyALfFJynBAU=;
        b=Dw9+GViIit1AZdLoLpvKukskxZtgxi3CC2xUeLSIEcK4gjDoUogYOg1cuKY+isYMuL
         l7WtZr3YFhkhgp2SEjBSNN1yD+RMREblZ1NTb864hRepaAMq47ppSx4a5Xv7UVA8zH7i
         +9WAjUR5hpmp8g+Zo0RCw7xrrWT2BONcBtJTtiqbLd0V+7wIqWXSm5Ym1S2bWPl7ZLWn
         Etbk1H5sxkd8iyABIRbrkhVLhBtwZhaxHVK2jPpohQlPQm2vY76qn3HIq79cl5yRMRt/
         mpDWgXDszckAg+Olmb8jClG5k8BoED+FHktjBNKaAUfGMzJffvP+Qw/uWciASTOFWFKb
         XHvw==
X-Forwarded-Encrypted: i=1; AJvYcCUy1G6Xyr46H+xmwpGKmy+NXzqXgGUjFKXaNv5iMjcWpyJ0CTTn6w9RNZiXS9OGQvbNolGm1OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAjAD4/87lbbzhK5d5bee3YnpKYMTiQ2+a62FUjhn/NJBg/Dn
	w7/6AcBnhcKBoM8VArW6xQrfqb7HayqVeznAwF+f3R5Z5QWODGRbaWnZkkd5RF7QYcGqS6y8DEe
	xOJeprktDh+b/b3RHhY4uiwBklBI=
X-Gm-Gg: ASbGncv+sPSKliZGa1rP90hWHBWxMeixfrKcobamFiqyq2mBdWg16m8ui/zaAA/aNWn
	vvzK4KbcRDgsKWv2Zsdy+5RHc2NbY9z9vyUx1yjKBpCFPYtnXqFiEoT/O1TUf1mRZwWW0hDxYF0
	WKO/P04idEm6ZxLwcIcbMKZajEnsmmUeYvdFk=
X-Google-Smtp-Source: AGHT+IFqjWbJzx0/gD6sUzKH2R5pjRQEet2J4LWfeJ3k5cDs4nI6CujgmJYbckO/0h264RXAeqxLWEQmqcjE6iMAvE4=
X-Received: by 2002:a05:6402:35ca:b0:5fb:455f:ac25 with SMTP id
 4fb4d7f45d1cf-5fca0730764mr9879298a12.7.1747011373259; Sun, 11 May 2025
 17:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509160055.261803-1-ap420073@gmail.com> <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
In-Reply-To: <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 12 May 2025 09:56:01 +0900
X-Gm-Features: AX0GCFsG4paA7ZoEw6XHUz0YdAnndMuEOQBmqB6TVG9OhXdREU-lBfnIrjUMaG4
Message-ID: <CAMArcTXXfPz_bxOwHJOTeiu-P4gufjB5dvZBsi4JX0v8HGLfrw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 4:43=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,
Thanks a lot for the review!

> On Fri, May 9, 2025 at 9:01=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > Kernel panic occurs when a devmem TCP socket is closed after NIC module
> > is unloaded.
> >
> > This is Devmem TCP unregistration scenarios. number is an order.
> > (a)netlink socket close    (b)pp destroy    (c)uninstall    result
> > 1                          2                3               OK
> > 1                          3                2               (d)Impossib=
le
> > 2                          1                3               OK
> > 3                          1                2               (e)Kernel p=
anic
> > 2                          3                1               (d)Impossib=
le
> > 3                          2                1               (d)Impossib=
le
> >
> > (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
> >     closed.
> > (b) page_pool_destroy() is called when the interface is down.
> > (c) mp_ops->uninstall() is called when an interface is unregistered.
> > (d) There is no scenario in mp_ops->uninstall() is called before
> >     page_pool_destroy().
> >     Because unregister_netdevice_many_notify() closes interfaces first
> >     and then calls mp_ops->uninstall().
> > (e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
> >     netdev_lock().
> >     But if the interface module has already been removed, net_device
> >     pointer is invalid, so it causes kernel panic.
> >
> > In summary, there are only 3 possible scenarios.
> >  A. sk close -> pp destroy -> uninstall.
> >  B. pp destroy -> sk close -> uninstall.
> >  C. pp destroy -> uninstall -> sk close.
> >
> > Case C is a kernel panic scenario.
> >
> > In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
> > binding->dev to NULL.
> > It indicates an bound net_device was unregistered.
> >
> > It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
> > if binding->dev is NULL.
> >
> > A new binding->lock is added to protect members of a binding.
> >
> > Tests:
> > Scenario A:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=3D$!
> >     sleep 10
> >     kill $pid
> >     ip link set $interface down
> >     modprobe -rv $module
> >
> > Scenario B:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=3D$!
> >     sleep 10
> >     ip link set $interface down
> >     kill $pid
> >     modprobe -rv $module
> >
> > Scenario C:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=3D$!
> >     sleep 10
> >     modprobe -rv $module
> >     sleep 5
> >     kill $pid
> >
> > Splat looks like:
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> > KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000=
000fffd4fbf]
> > CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.=
15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> > Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> > RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mut=
ex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locki=
ng/mutex.c:746)
> > Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48=
 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> > RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> > RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> > RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> > RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> > R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> > R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> > FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> >  ...
> >  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator=
 3))
> >  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 =
net/netlink/genetlink.c:705)
> >  ...
> >  netlink_release (net/netlink/af_netlink.c:737)
> >  ...
> >  __sock_release (net/socket.c:647)
> >  sock_close (net/socket.c:1393)
> >
> > Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> >  - Add binding->lock for protecting members of a binding.
> >  - Add a net_devmem_unset_dev() helper function.
> >  - Do not reorder locks.
> >  - Fix build failure.
> >
>
> Thanks for addressing the feedback Taehee. I think this diff looks
> much much nicer.
>
> > v2:
> >  - Fix commit message.
> >  - Correct Fixes tag.
> >  - Inverse locking order.
> >  - Do not put a reference count of binding in
> >    mp_dmabuf_devmem_uninstall().
> >
> > In order to test this patch, driver side implementation of devmem TCP[1=
]
> > is needed to be applied.
> >
> > [1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gm=
ail.com/T/#u
> >
> >  net/core/devmem.c      | 14 +++++++++++---
> >  net/core/devmem.h      |  2 ++
> >  net/core/netdev-genl.c | 13 +++++++++++++
> >  3 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 6e27a47d0493..ffbf50337413 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -33,6 +33,13 @@ bool net_is_devmem_iov(struct net_iov *niov)
> >         return niov->pp->mp_ops =3D=3D &dmabuf_devmem_ops;
> >  }
> >
> > +static void net_devmem_unset_dev(struct net_devmem_dmabuf_binding *bin=
ding)
> > +{
> > +       mutex_lock(&binding->lock);
> > +       binding->dev =3D NULL;
> > +       mutex_unlock(&binding->lock);
> > +}
> > +
> >  static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpoo=
l,
> >                                                struct gen_pool_chunk *c=
hunk,
> >                                                void *not_used)
> > @@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> >         unsigned long xa_idx;
> >         unsigned int rxq_idx;
> >
> > -       if (binding->list.next)
> > -               list_del(&binding->list);
> > -
>
> Unfortunately if you're going to delete this, then you need to do
> list_del in _all_ the callers of net_devmem_unbind_dmabuf, and I think
> there is a callsite in netdev_nl_bind_rx_doit that is missed?

Thanks for catching it, I missed applying it to netdev_nl_bind_rx_doit().
I will fix this in the next patch.

>
> But also, it may rough to continually have to remember to always do
> list_del when we do unbind. AFAIR Jakub asked for uniformity in the
> bind/unbind functions. Can we instead do the list_add inside of
> net_devmem_bind_dmabuf? So net_devmem_bind_dmabuf can take the struct
> list_head as an arg and do the list add, then the unbind can do the
> list_del, so it is uniform, but we don't have to remember to do
> list_add/del everytime we call bind/unbind.
>
> Also, I suspect that clean up can be a separate patch.

Okay, it's good to me.
I think there is no problem with changing it in the next patch.

>
> >         xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
> >                 const struct pp_memory_provider_params mp_params =3D {
> >                         .mp_priv        =3D binding,
> > @@ -200,6 +204,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsi=
gned int dmabuf_fd,
> >
> >         refcount_set(&binding->ref, 1);
> >
> > +       mutex_init(&binding->lock);
> > +
> >         binding->dmabuf =3D dmabuf;
> >
> >         binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->de=
v.parent);
> > @@ -379,6 +385,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
v,
> >         xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
> >                 if (bound_rxq =3D=3D rxq) {
> >                         xa_erase(&binding->bound_rxqs, xa_idx);
> > +                       if (xa_empty(&binding->bound_rxqs))
> > +                               net_devmem_unset_dev(binding);
> >                         break;
> >                 }
> >         }
> > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > index 7fc158d52729..b69adca6cd44 100644
> > --- a/net/core/devmem.h
> > +++ b/net/core/devmem.h
> > @@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
> >         struct sg_table *sgt;
> >         struct net_device *dev;
> >         struct gen_pool *chunk_pool;
> > +       /* Protect all members */
>
> nit: i would say here "Protect *dev". Protect all members implies this
> lock should be acquired before accessing any members, which is not
> true as of this patch, right? binding->lock needs to be acquired only
> for accessing binding->dev (other members are either thread safe, like
> the genpool, or have other concurrency guarantees, like netdev_lock).

Okay, I will change it too.

>
> > +       struct mutex lock;
> >
> >         /* The user holds a ref (via the netlink API) for as long as th=
ey want
> >          * the binding to remain alive. Each page pool using this bindi=
ng holds
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index dae9f0d432fb..bd5d58604ec0 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl=
_sock *priv)
> >  {
> >         struct net_devmem_dmabuf_binding *binding;
> >         struct net_devmem_dmabuf_binding *temp;
> > +       netdevice_tracker dev_tracker;
> >         struct net_device *dev;
> >
> >         mutex_lock(&priv->lock);
> >         list_for_each_entry_safe(binding, temp, &priv->bindings, list) =
{
> > +               list_del(&binding->list);
> > +
> > +               mutex_lock(&binding->lock);
> >                 dev =3D binding->dev;
> > +               if (!dev) {
> > +                       mutex_unlock(&binding->lock);
> > +                       net_devmem_unbind_dmabuf(binding);
> > +                       continue;
> > +               }
> > +               netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> > +               mutex_unlock(&binding->lock);
> > +
>
>
> Consider writing the above lines as something like:
>
> mutex_lock(&binding->lock);
> if (binding->dev) {
>     netdev_hold(binding->dev, &dev_tracker, GPF_KERNEL);
> }
>
> net_devmem_unbind_dmabuf(binding);
>
> if (binding->dev) {
>    netdev_put(binding->dev, &dev_tracker);
> }
> mutex_unlock(&binding->lock);
>
> i.e., don't duplicate the net_devmem_unbind_dmabuf(binding); call.
>
>
> Other than that, I could not find issues. I checked lock ordering. The
> lock hierarchy is:
>
> priv->lock
>   binding->lock
>     netdev_lock(dev)
>
> and AFAICT it is not violated anywhere. I ran my regression tests and
> did not see issues. Just holding my reviewed-by because I see the
> issue with list_del. I recommend that Stan also takes a look, since he
> implemented the locking change.
>
> --
> Thanks,
> Mina

Thanks a lot!
Taehee Yoo

