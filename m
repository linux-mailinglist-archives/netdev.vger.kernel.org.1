Return-Path: <netdev+bounces-189351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF637AB1D68
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363DE167CBC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E925DB17;
	Fri,  9 May 2025 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIQQBLLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F01E1DE8
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819837; cv=none; b=oksEoQHLL179P9uN5OK0ZTqRJYn4bbKNduLImk4nR3A1NS2UrLVE43Z8DtPnMeZlTuaEYkSuIlo6Ick/VdxOyUqkEFqg5zNa6t3fdA3+xojUh0SPDuZzKUgMuUzyalTXFgazJ48Vllyl6nDclHQkHaAne7ej0ONVuJMRV5fVIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819837; c=relaxed/simple;
	bh=2DRWwmL5/Lgjmg4h7mDw9M8Ge+i0ZYzUIbG0ph6ZzbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NG7Szg82YJpyRS+HdLcUxSyMJHJ2DTxlmPGyXeeJT8VDoCGd3lH+FYGXHW+PgR3XLwdFbrDECKKc78ozbdTt0vX01sSOqPH9zeiFA2GKkwA0DGJLFQN6VQQjQ4iagH897H1MVgUROpLpEXfoWhQFOLROBYYBnj+XUzLa+eymb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIQQBLLk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22fa47f295dso2445ad.1
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746819835; x=1747424635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA3LSC8zeEVjxxhOwgY18p6Cj5DHAHpTyd0VuWQGoFU=;
        b=CIQQBLLkQXRG0Rr7rG7okD7O3RvxHbIdOw7/mEIxkip7a9IJ9SEk6TYRjgKxATVqeW
         hFIuHopFK3RG4KZKKNDIBKBvuEz2ibb6xeQ52yr9h6hLoBA8FiSE0tVaBiCAw2aoG9nt
         janx6mDAeU1KY45g6ML2k7xEbQGCQ6/loFbPoEmpJTk/5/B8iAedlOnl6LPbyV64lcJ3
         hWeLnqccObnZTEcrVFCHZQHhmRr1jwfCPVVUQ/GIUOv1xJhvf3AyGzVJt/7u6bhfccJv
         etHVSvzrlmSRDZWyDNzLpqVpaDomDsp62F78iN7cYb/E7QJK/r5gR9A0Uyk/90wl95VO
         YUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746819835; x=1747424635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA3LSC8zeEVjxxhOwgY18p6Cj5DHAHpTyd0VuWQGoFU=;
        b=wNX/b1xYqCD2QayFIV/CUkdtaWLK+FMe4I5qIgeGLoduCB2dMHajuU3JlJvxEpIU+R
         YfW72ksUTP19txEUfdFphezCpltntEuiIuHbXTc2WdQ2+Uk1S/IyxQbUs+yRuZ4/cIIF
         dCCkhArWK26TH8O9jkOMC5qGgPrdaQuNXylIDfvWZ/UqPq1rQIgoVyalNUj3SRUPEaQ7
         wl4Xmay5TB2GDD7dcvyOHjl8S889xqxd/s3csym/ShEtEKA/3ZsJAullsxmhp60PhnDx
         6F8D86UPlv0Mizmhadn+dXC8g2u6+EEZDB+ocRT9+MYcpOXsB8q3iLC89faihZ5gplz2
         rJmw==
X-Forwarded-Encrypted: i=1; AJvYcCWwWIXfal/bIq2zGbcP/N+TXDhMNUKlglaQMySW55fOTwOMh6He+RE8OBQARrfOFWsncp+MUHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpu42bRIzgD2vmaY7Jrm+Aq/20a8Y8zE08gtbIlspFye8DrbvN
	ZfxmP408JazgsGdIH6srLfdVWvhfZbAaVdaaYdjdWqm7rgE8V33Fe7jclnxxOdOFtFWqzfMwEO2
	mwShk+aQ3NHQMs0SoZkeAcVdbzesN9szwlxNDY31XhKoGwI2/gRjV
X-Gm-Gg: ASbGnctSkh+0CXxeHjzzw/yZZHRnYB5/4E5kn/3piZVx99WAy+rwTZT1HW2a3qXSJwI
	YPyTTCkpDxH/F1+wbPmcdx2xbQ/hG3fF2oQZcgN7K7d5XI6ituV862ozJmJck7H8Y4+EJ4Fgc/q
	tobLtCvMGjVR72ZztmZERs/LFkTCPq9Z9KVgCIV7RxbTE7jJdcjoNvJ7vU2If0Bw0=
X-Google-Smtp-Source: AGHT+IGL+huZSRMVCH3qU7LbjIfe/RG5e1PDO7uoFaJEZWSMfBRte8D8CuCn2N03EN8vMJDCqPRoe6P3j9rwZRTprug=
X-Received: by 2002:a17:903:2c9:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-22fef806b96mr609295ad.0.1746819834608; Fri, 09 May 2025
 12:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509160055.261803-1-ap420073@gmail.com>
In-Reply-To: <20250509160055.261803-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 12:43:42 -0700
X-Gm-Features: ATxdqUH99PbJiOVi1bG1idneAk4eUURP4c8G9SYZ-H6BdcmX3oa4E0k6OpgkxlA
Message-ID: <CAHS8izNgKzusVLynOpWLF_KqmjgGsE8ey_SFMF4zVU66F5gt5w@mail.gmail.com>
Subject: Re: [PATCH net v3] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 9:01=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
>
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)netlink socket close    (b)pp destroy    (c)uninstall    result
> 1                          2                3               OK
> 1                          3                2               (d)Impossible
> 2                          1                3               OK
> 3                          1                2               (e)Kernel pan=
ic
> 2                          3                1               (d)Impossible
> 3                          2                1               (d)Impossible
>
> (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
>     closed.
> (b) page_pool_destroy() is called when the interface is down.
> (c) mp_ops->uninstall() is called when an interface is unregistered.
> (d) There is no scenario in mp_ops->uninstall() is called before
>     page_pool_destroy().
>     Because unregister_netdevice_many_notify() closes interfaces first
>     and then calls mp_ops->uninstall().
> (e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
>     netdev_lock().
>     But if the interface module has already been removed, net_device
>     pointer is invalid, so it causes kernel panic.
>
> In summary, there are only 3 possible scenarios.
>  A. sk close -> pp destroy -> uninstall.
>  B. pp destroy -> sk close -> uninstall.
>  C. pp destroy -> uninstall -> sk close.
>
> Case C is a kernel panic scenario.
>
> In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
> binding->dev to NULL.
> It indicates an bound net_device was unregistered.
>
> It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
> if binding->dev is NULL.
>
> A new binding->lock is added to protect members of a binding.
>
> Tests:
> Scenario A:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     kill $pid
>     ip link set $interface down
>     modprobe -rv $module
>
> Scenario B:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     ip link set $interface down
>     kill $pid
>     modprobe -rv $module
>
> Scenario C:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     modprobe -rv $module
>     sleep 5
>     kill $pid
>
> Splat looks like:
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x0000000=
0fffd4fbf]
> CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15=
.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex=
.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking=
/mutex.c:746)
> Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b=
8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
>  ...
>  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3=
))
>  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 ne=
t/netlink/genetlink.c:705)
>  ...
>  netlink_release (net/netlink/af_netlink.c:737)
>  ...
>  __sock_release (net/socket.c:647)
>  sock_close (net/socket.c:1393)
>
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v3:
>  - Add binding->lock for protecting members of a binding.
>  - Add a net_devmem_unset_dev() helper function.
>  - Do not reorder locks.
>  - Fix build failure.
>

Thanks for addressing the feedback Taehee. I think this diff looks
much much nicer.

> v2:
>  - Fix commit message.
>  - Correct Fixes tag.
>  - Inverse locking order.
>  - Do not put a reference count of binding in
>    mp_dmabuf_devmem_uninstall().
>
> In order to test this patch, driver side implementation of devmem TCP[1]
> is needed to be applied.
>
> [1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gmai=
l.com/T/#u
>
>  net/core/devmem.c      | 14 +++++++++++---
>  net/core/devmem.h      |  2 ++
>  net/core/netdev-genl.c | 13 +++++++++++++
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..ffbf50337413 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -33,6 +33,13 @@ bool net_is_devmem_iov(struct net_iov *niov)
>         return niov->pp->mp_ops =3D=3D &dmabuf_devmem_ops;
>  }
>
> +static void net_devmem_unset_dev(struct net_devmem_dmabuf_binding *bindi=
ng)
> +{
> +       mutex_lock(&binding->lock);
> +       binding->dev =3D NULL;
> +       mutex_unlock(&binding->lock);
> +}
> +
>  static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
>                                                struct gen_pool_chunk *chu=
nk,
>                                                void *not_used)
> @@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabu=
f_binding *binding)
>         unsigned long xa_idx;
>         unsigned int rxq_idx;
>
> -       if (binding->list.next)
> -               list_del(&binding->list);
> -

Unfortunately if you're going to delete this, then you need to do
list_del in _all_ the callers of net_devmem_unbind_dmabuf, and I think
there is a callsite in netdev_nl_bind_rx_doit that is missed?

But also, it may rough to continually have to remember to always do
list_del when we do unbind. AFAIR Jakub asked for uniformity in the
bind/unbind functions. Can we instead do the list_add inside of
net_devmem_bind_dmabuf? So net_devmem_bind_dmabuf can take the struct
list_head as an arg and do the list add, then the unbind can do the
list_del, so it is uniform, but we don't have to remember to do
list_add/del everytime we call bind/unbind.

Also, I suspect that clean up can be a separate patch.

>         xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
>                 const struct pp_memory_provider_params mp_params =3D {
>                         .mp_priv        =3D binding,
> @@ -200,6 +204,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsign=
ed int dmabuf_fd,
>
>         refcount_set(&binding->ref, 1);
>
> +       mutex_init(&binding->lock);
> +
>         binding->dmabuf =3D dmabuf;
>
>         binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.=
parent);
> @@ -379,6 +385,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
>         xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
>                 if (bound_rxq =3D=3D rxq) {
>                         xa_erase(&binding->bound_rxqs, xa_idx);
> +                       if (xa_empty(&binding->bound_rxqs))
> +                               net_devmem_unset_dev(binding);
>                         break;
>                 }
>         }
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 7fc158d52729..b69adca6cd44 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
>         struct sg_table *sgt;
>         struct net_device *dev;
>         struct gen_pool *chunk_pool;
> +       /* Protect all members */

nit: i would say here "Protect *dev". Protect all members implies this
lock should be acquired before accessing any members, which is not
true as of this patch, right? binding->lock needs to be acquired only
for accessing binding->dev (other members are either thread safe, like
the genpool, or have other concurrency guarantees, like netdev_lock).

> +       struct mutex lock;
>
>         /* The user holds a ref (via the netlink API) for as long as they=
 want
>          * the binding to remain alive. Each page pool using this binding=
 holds
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index dae9f0d432fb..bd5d58604ec0 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_s=
ock *priv)
>  {
>         struct net_devmem_dmabuf_binding *binding;
>         struct net_devmem_dmabuf_binding *temp;
> +       netdevice_tracker dev_tracker;
>         struct net_device *dev;
>
>         mutex_lock(&priv->lock);
>         list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> +               list_del(&binding->list);
> +
> +               mutex_lock(&binding->lock);
>                 dev =3D binding->dev;
> +               if (!dev) {
> +                       mutex_unlock(&binding->lock);
> +                       net_devmem_unbind_dmabuf(binding);
> +                       continue;
> +               }
> +               netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> +               mutex_unlock(&binding->lock);
> +


Consider writing the above lines as something like:

mutex_lock(&binding->lock);
if (binding->dev) {
    netdev_hold(binding->dev, &dev_tracker, GPF_KERNEL);
}

net_devmem_unbind_dmabuf(binding);

if (binding->dev) {
   netdev_put(binding->dev, &dev_tracker);
}
mutex_unlock(&binding->lock);

i.e., don't duplicate the net_devmem_unbind_dmabuf(binding); call.


Other than that, I could not find issues. I checked lock ordering. The
lock hierarchy is:

priv->lock
  binding->lock
    netdev_lock(dev)

and AFAICT it is not violated anywhere. I ran my regression tests and
did not see issues. Just holding my reviewed-by because I see the
issue with list_del. I recommend that Stan also takes a look, since he
implemented the locking change.

--=20
Thanks,
Mina

