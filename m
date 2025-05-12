Return-Path: <netdev+bounces-189606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B43AB2CC0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A853816E1D3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281EC1A23A1;
	Mon, 12 May 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld2UDkJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150151BC4E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747012945; cv=none; b=aVD5cckyz5LQKuXkbztO9S66+fJN02R6t9yG1M/F/wm8SGCWJkhQidhzHPlVsa9N0HVjgJ4srkNYUExCEPhNucNuG2fgM4ZbPCzZlzRSXMefObHwMUARhQ8BCs3Jn0xCLq0WUQDOPNG0CNn5SOxibYtU6KoJN21z0mZgf8bDN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747012945; c=relaxed/simple;
	bh=J9vbhw73OQLM/3IeKttBeEAS+5NAsXifJaBMI0yHxXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwGNvRkuEkdTXRpZojUfO/b84POj0iy0eMkGOnG7hglFbeqOyJP4eqOppQt+nIA9BJjSBrwW59AKGjKzhMeJxcYN3sOvQOzTEr1p+JdzkC8UlWwOt3FrVQvf1TWtrAWAzo+aT0w3giHiIiSqGmmSKgxFAbiaHpztCwN/j+HfsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld2UDkJ3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso7348054a12.3
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747012941; x=1747617741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JNgSRDMsp0pMVFWiK2JHRkPC9eZpxSa1GYBJcwGxqw=;
        b=ld2UDkJ3MQ7xYZj/xwAftwpFlhKoJj48rC1+dlzrUjIt/FokAZQLf8VpXF7bfR82jZ
         5SwM6YhRH5mowJjxEeIhvdC5Dq79AH0kyP8kwPy8bNLV8+L90Kg0GXz5UvwxF3Dkgu45
         MfgFOgjm/7sNmHEDKKHcFGd/bv7Hcxzw5IchCC2lVNI1wChmZj2pmSR9/QfdooLVRues
         /ta9SkU8Nu5s+C0Eduz7pQg03StopomS0T9KkPJ3HbaNhHU6omofHxBr2sKKSgQZrM5J
         EmGhyc+i/H/OmiPojwQmCqGzhCNGYT9acEz1fSxacoHRn3QnOrI9gR925D/2aaZDE/pw
         Qovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747012941; x=1747617741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JNgSRDMsp0pMVFWiK2JHRkPC9eZpxSa1GYBJcwGxqw=;
        b=d/KBkvMh2RGUXyG4wd8A2hVqDgdWuDQVs3jx7E3NT5C+Fhqf9zbNCfeAQ64QTPKYVs
         MlHDQwM8J8UVorOUzgkSrOs5sTUAlz9Id6FM9pXkB8BqQ+Z4/859DBtwyAuMJIH8uUDG
         ufWhp9NCr9SmqcH3MCh4aMSs3qc7RTdvWMA0YJ9k/DhcVxUZibE2y0/0k/QIirj0Mh0R
         WoAsPcMzHl79JovNF7jnkW4w8BL9BZtbCK+Fneqm3tuRrGAHN2SdEDLURH+PgWHfKean
         rMNjbymuCbwEBTdE2clZJoPdu4iKMI9UTSUbR6NBvZfK1HkZyObXG084lnwzAqkKN/ux
         SItQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdY2dmt5CLSnpyKL8R5z9+Btb5tcCQLvlI3CF0667tWMFxy8n+A0QGm4sK06ewLGXviwjs5YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUH0X1cKZ1WJYnkJKHg4d9zZt7gTGUQ4esGhfVtkv/9MThvqT3
	f6nkgZ89wNk5b2s4viBcv8NSqTkqNy01CwkPI7YTo1IQF54D3YpqBThiPIDWPl+Jn4MeeuaYLwE
	glwObo79vit1rrLffdOp0SSz1DCw=
X-Gm-Gg: ASbGncvcBYFGzgYXW2etM11nZmvSRqBXEh0Rd53on6aKKzWHb4mKwJSt7Ij8prB1xS3
	bnsc52NalLZoGRPBOOe34mGqc9dTCLwE4vTYgo3wOgWc3bdizWJ6R2wyJB7ty9J4BzinOqWyxBe
	Rs2QUEAmZvTzjZ/RFhBCwXYiJjJZkKWOZRgRFl9f5FFvme0g==
X-Google-Smtp-Source: AGHT+IFjLZT6hiIEPwSsji/FtpEBwtMTbjIeOS3XiFNgDDpyyoFecm6H7nOuAvi9qIBYIdbN9VQA1Glx+Gmim7vjtsI=
X-Received: by 2002:a05:6402:5110:b0:5f8:59b6:2ba8 with SMTP id
 4fb4d7f45d1cf-5fca075dd2amr9600395a12.14.1747012941192; Sun, 11 May 2025
 18:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509160055.261803-1-ap420073@gmail.com> <aB6El9LXnOEpgFQy@mini-arch>
In-Reply-To: <aB6El9LXnOEpgFQy@mini-arch>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 12 May 2025 10:22:09 +0900
X-Gm-Features: AX0GCFs-6XgU1DSB9xjsjiIhV4Hllxf6KDSu2sTRkRAJd4-YV6wmjsEXY4UkKFc
Message-ID: <CAMArcTWKPid7kmv7MoNGccNHUmUcH+QeDteQWM3dcOMBpZzFKg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, almasrymina@google.com, 
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com, 
	dw@davidwei.uk, skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>

Hi Stanislav,
Thanks a lot for the review!

> On 05/09, Taehee Yoo wrote:
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
> >       return niov->pp->mp_ops =3D=3D &dmabuf_devmem_ops;
> >  }
> >
> > +static void net_devmem_unset_dev(struct net_devmem_dmabuf_binding *bin=
ding)
> > +{
> > +     mutex_lock(&binding->lock);
> > +     binding->dev =3D NULL;
> > +     mutex_unlock(&binding->lock);
> > +}
>
> nit: there is just one place where we call net_devmem_unset_dev, why do
> we need an extra function? IMHO it makes it harder to read wrt
> locking.. Jakub is also hinting the same in
> https://lore.kernel.org/netdev/20250509153252.76f08c14@kernel.org/#t ?

Okay, I think it needs to be removed, not made inline.

>
> >  static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpoo=
l,
> >                                              struct gen_pool_chunk *chu=
nk,
> >                                              void *not_used)
> > @@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> >       unsigned long xa_idx;
> >       unsigned int rxq_idx;
> >
> > -     if (binding->list.next)
> > -             list_del(&binding->list);
> > -
> >       xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
> >               const struct pp_memory_provider_params mp_params =3D {
> >                       .mp_priv        =3D binding,
> > @@ -200,6 +204,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsi=
gned int dmabuf_fd,
> >
> >       refcount_set(&binding->ref, 1);
> >
> > +     mutex_init(&binding->lock);
> > +
> >       binding->dmabuf =3D dmabuf;
> >
> >       binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.=
parent);
> > @@ -379,6 +385,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
v,
> >       xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
> >               if (bound_rxq =3D=3D rxq) {
> >                       xa_erase(&binding->bound_rxqs, xa_idx);
> > +                     if (xa_empty(&binding->bound_rxqs))
> > +                             net_devmem_unset_dev(binding);
> >                       break;
> >               }
> >       }
> > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > index 7fc158d52729..b69adca6cd44 100644
> > --- a/net/core/devmem.h
> > +++ b/net/core/devmem.h
> > @@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
> >       struct sg_table *sgt;
> >       struct net_device *dev;
> >       struct gen_pool *chunk_pool;
> > +     /* Protect all members */
> > +     struct mutex lock;
> >
> >       /* The user holds a ref (via the netlink API) for as long as they=
 want
> >        * the binding to remain alive. Each page pool using this binding=
 holds
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index dae9f0d432fb..bd5d58604ec0 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl=
_sock *priv)
> >  {
> >       struct net_devmem_dmabuf_binding *binding;
> >       struct net_devmem_dmabuf_binding *temp;
> > +     netdevice_tracker dev_tracker;
> >       struct net_device *dev;
> >
> >       mutex_lock(&priv->lock);
> >       list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> > +             list_del(&binding->list);
> > +
> > +             mutex_lock(&binding->lock);
> >               dev =3D binding->dev;
> > +             if (!dev) {
> > +                     mutex_unlock(&binding->lock);
> > +                     net_devmem_unbind_dmabuf(binding);
> > +                     continue;
> > +             }
> > +             netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> > +             mutex_unlock(&binding->lock);
> > +
>
> Same suggestion as in v2: let's have a short comment here on the lock
> ordering (netdev outer, binding inner)?

Okay, I will add a comment about it.

>
> >               netdev_lock(dev);
> >               net_devmem_unbind_dmabuf(binding);
> >               netdev_unlock(dev);
> > +             netdev_put(dev, &dev_tracker);
> >       }
> >       mutex_unlock(&priv->lock);
> >  }
> > --
> > 2.34.1
> >

Thanks a lot!
Taehee Yoo

