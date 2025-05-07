Return-Path: <netdev+bounces-188764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA75AAE909
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62594E2A45
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D588D28DF4C;
	Wed,  7 May 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnTJYrvX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648521504D
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642510; cv=none; b=e+hyn2Nfnp6YPWJ2RZRczL3/lWWzNJ+63xkTd4tp7ZZzLxmP27oJQl1HaoayJu3fsZted43z/RpvuXLJltjqemYBTk8U5sT7zyTssgFqP8G8Ktl+z9j11ps84esHyK40EVLDOEIVIkgwIpzpwbOx4A1HMRuA1vfaNOBhJj0D5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642510; c=relaxed/simple;
	bh=KsrIwiVgKyruxYASMU+sxnVRNY03Shx0uQjnTTd7f9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApS1L+G3Pa3z2tu4je3yMwo3BP4t9skcyZHlhm1IhPP7gX5Cnfj2GuXQKCOeHvbKPVbcRwd5a/JMoTpWjoioMV0Fd6g0nR8lwdnacZeasu4S0aK35uV1r7ml/WGIk/2/YYEkLds2Sy+TElcLqxtbUEakPgC+/vXi++3dW2eD6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnTJYrvX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e1eafa891so24695ad.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746642508; x=1747247308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmpEIvGyvToqi2vtnPZ9av5uDEejeoyzUKBlC9TAdJU=;
        b=RnTJYrvXDqoTkdETg0uyAN4LB/iltGdNjZxXOrCacwOmeidCKqqFWnjeEcj/bOD/fI
         Vm60BW5jmkbdmXaSTeXtarcwSOezWi0mxBh2SNkiyBbg59gFoy/JSG48T6chW/SCkGat
         HOE7Ej7+H0BAOypk0V+u3ndaiFuA4UvaM1w9GXBMXMR6pdSyLo6VBwQ0NNXDV9rjQ+Ua
         9HHKGAZEffsUo6EPew70VFfNZJfx6+GUysyH8L5HFz19jmyy4tIbOhgcv3CX0RFuCkUY
         b1J0gK7q3DiIQuFsmm7VX5f060/ntDj1ZW329VSn6ZGov5sqAWD898+nV/42TUsLVYnG
         pARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746642508; x=1747247308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmpEIvGyvToqi2vtnPZ9av5uDEejeoyzUKBlC9TAdJU=;
        b=vG4Hu9BH2uN/BFhatIdkpcB8Ydl+DxZ4qdtsYIT2NaOWsPIf5nXq/qcFgT4TgBjtUG
         8oJFo1uNhdCdXCG1txyD3gBONWW0HC4oVFLz5FFmfcEyg9xIJIRmbm9eqAAWtnHpbAfL
         oM4gYLGPrsHEJbY+ArbppGly5hyObmV2x/9+2VEYAwzHVOM2SkxRwXSMRlDBnTIQzCUe
         0TBKyeCYnyjcF1/B3GUqxIOczDMACj7lWAoXNeRwmmF6CcmZoCAvL4ckdSrPti+ySkZk
         IU0pNF6vpur41UBJFoFTDPTqg9+FXdtXWJCXn89LtvavCIeQlo3fD6C8XC7jOzK5mMdT
         sIIA==
X-Forwarded-Encrypted: i=1; AJvYcCWhOBVs71R6PhyVmauLa5bItzvQ5H9ZDTViJ+Uin3a3vv1sT6EHwqiMM7WKo0VIF4kRFdEGGLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPK5irW/ZM1g3v3Xmz59UFWuHKgGcz48BC6fSQXhR7y1daCa8
	DuhHiaumvEFrjO4vLUsewYygbmSrIk2ytSWriiqnRnxYJdgs2EV24up24mxCVAaCk9lqmRboxF6
	fCD/oG2uiPUJ04UBY3ufxUk2/hVYDCCD90Tpb
X-Gm-Gg: ASbGncuN+wKk1br5UHNOAPduUL20byeUNV07tAjvqnXWtgaUvrJz5yNCPtT4QDaxCR6
	VgcyUS9SBaoI5eW3/7uKGUTtMSjQtDI+ll1GsrPTP6dzp2snhizJY3JXf/0WvIJarKGKIEwPm6k
	nX0Ks0okoT2xOw4McD5fFRzQsUnwVZ0okj/ON0TGN8CljHk1ltSsQ6
X-Google-Smtp-Source: AGHT+IFV8A93DiDkJrAxZCykd4bgwKKXJtbWp2Ql/IKukBZEZY19o56Pg695dmK6sY4HbysKbX+a0JWzeQsGqyI2KSk=
X-Received: by 2002:a17:902:f688:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-22ed8a768f6mr222325ad.22.1746642507837; Wed, 07 May 2025
 11:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506140858.2660441-1-ap420073@gmail.com>
In-Reply-To: <20250506140858.2660441-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 7 May 2025 11:28:14 -0700
X-Gm-Features: ATxdqUE76BkZuETy39aFefqjvnZLq46tbnV3FYzmqif9aLpJ4NCtpokIzh04prI
Message-ID: <CAHS8izNmrrO=q4vqGJ+mAQg52s3KqBXjdbrf=AgCUpHpS4oB7w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:09=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
>
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)socket close

Lets call this "netlink socket close", to differentiate between
netlink and data sockets.

>    (b)pp destroy
>    (c)uninstall    result
> 1                  2                3               OK
> 1                  3                2               (d)Impossible
> 2                  1                3               OK
> 3                  1                2               (e)Kernel panic
> 2                  3                1               (d)Impossible
> 3                  2                1               (d)Impossible
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
> It inverts socket/netdev lock order like below:
>     netdev_lock();
>     mutex_lock(&priv->lock);
>     mutex_unlock(&priv->lock);
>     netdev_unlock();
>
> Because of inversion of locking ordering, mp_dmabuf_devmem_uninstall()
> acquires socket lock from now on.
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
>  net/core/devmem.c      |  6 ++++++
>  net/core/devmem.h      |  3 +++
>  net/core/netdev-genl.c | 27 ++++++++++++++++++---------
>  3 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..636c1e82b8da 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -167,6 +167,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device=
 *dev, u32 rxq_idx,
>
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +                      struct netdev_nl_sock *priv,
>                        struct netlink_ext_ack *extack)
>  {
>         struct net_devmem_dmabuf_binding *binding;
> @@ -189,6 +190,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsign=
ed int dmabuf_fd,
>         }
>
>         binding->dev =3D dev;
> +       binding->priv =3D priv;
>
>         err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
>                               binding, xa_limit_32b, &id_alloc_next,
> @@ -376,12 +378,16 @@ static void mp_dmabuf_devmem_uninstall(void *mp_pri=
v,
>         struct netdev_rx_queue *bound_rxq;
>         unsigned long xa_idx;
>
> +       mutex_lock(&binding->priv->lock);
>         xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
>                 if (bound_rxq =3D=3D rxq) {
>                         xa_erase(&binding->bound_rxqs, xa_idx);
> +                       if (xa_empty(&binding->bound_rxqs))
> +                               binding->dev =3D NULL;

priv->lock is meant to protect priv->bindings only. To be honest, I
find priv->lock being used to protect both priv->bindings and
bindings->dev is extremely confusing. I think it may be contributing
to the convoluted lock ordering in netdev_nl_sock_priv_destroy. It
also makes it such that the binding needs to have a reference to the
netlink socket that owns it which is mentally confusing to me. The
binding should abstractly speaking not need to know anything about the
netlink socket that holds it. Also, AFAICT this may be buggy. The
binding may outlive the netlink socket. For example when the netlink
socket is closed but the binding is kept alive because there are
references to the netmems in it, UAF may happen.

Instead of this, if you need to protect concurrent access to
binding->dev, either:

1. create new spin_lock, binding->dev_lock, which protects access to
binding->dev, or
2. Use rcu protection to lockelessly set binding->dev, or
3. Use some cmpxchg logic to locklessly set/query binding->dev and
detect if it got modified in a racing thread.

But please no multiplexing priv->lock to protect both priv->bindings
and binding->dev.

>                         break;
>                 }
>         }
> +       mutex_unlock(&binding->priv->lock);
>  }
>
>  static const struct memory_provider_ops dmabuf_devmem_ops =3D {
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 7fc158d52729..afd6320b2c9b 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -11,6 +11,7 @@
>  #define _NET_DEVMEM_H
>
>  #include <net/netmem.h>
> +#include <net/netdev_netlink.h>
>
>  struct netlink_ext_ack;
>
> @@ -20,6 +21,7 @@ struct net_devmem_dmabuf_binding {
>         struct sg_table *sgt;
>         struct net_device *dev;
>         struct gen_pool *chunk_pool;
> +       struct netdev_nl_sock *priv;
>
>         /* The user holds a ref (via the netlink API) for as long as they=
 want
>          * the binding to remain alive. Each page pool using this binding=
 holds
> @@ -63,6 +65,7 @@ struct dmabuf_genpool_chunk_owner {
>  void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *=
binding);
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +                      struct netdev_nl_sock *priv,
>                        struct netlink_ext_ack *extack);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 230743bdbb14..b8bb73574276 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -859,13 +859,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>                 goto err_genlmsg_free;
>         }
>
> -       mutex_lock(&priv->lock);
> -
>         err =3D 0;
>         netdev =3D netdev_get_by_index_lock(genl_info_net(info), ifindex)=
;
>         if (!netdev) {
>                 err =3D -ENODEV;
> -               goto err_unlock_sock;
> +               goto err_genlmsg_free;
>         }
>         if (!netif_device_present(netdev))
>                 err =3D -ENODEV;
> @@ -877,10 +875,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>                 goto err_unlock;
>         }
>
> -       binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extac=
k);
> +       mutex_lock(&priv->lock);
> +       binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info-=
>extack);

I'm not so sure about this as well. priv->lock should protect access
to priv->bindings only. I'm not sure why it's locked before
net_devmem_bind_dmabuf? Can it be locked around the access to
priv->bindings only?

>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
> -               goto err_unlock;
> +               goto err_unlock_sock;
>         }
>
>         nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> @@ -921,18 +920,17 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>         if (err)
>                 goto err_unbind;
>
> -       netdev_unlock(netdev);
> -
>         mutex_unlock(&priv->lock);
> +       netdev_unlock(netdev);
>
>         return 0;
>
>  err_unbind:
>         net_devmem_unbind_dmabuf(binding);
> -err_unlock:
> -       netdev_unlock(netdev);
>  err_unlock_sock:
>         mutex_unlock(&priv->lock);
> +err_unlock:
> +       netdev_unlock(netdev);
>  err_genlmsg_free:
>         nlmsg_free(rsp);
>         return err;
> @@ -948,14 +946,25 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_s=
ock *priv)
>  {
>         struct net_devmem_dmabuf_binding *binding;
>         struct net_devmem_dmabuf_binding *temp;
> +       netdevice_tracker dev_tracker;
>         struct net_device *dev;
>
>         mutex_lock(&priv->lock);
>         list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
>                 dev =3D binding->dev;
> +               if (!dev) {
> +                       net_devmem_unbind_dmabuf(binding);
> +                       continue;
> +               }
> +               netdev_hold(dev, &dev_tracker, GFP_KERNEL);
> +               mutex_unlock(&priv->lock);
>                 netdev_lock(dev);
> +               mutex_lock(&priv->lock);
>                 net_devmem_unbind_dmabuf(binding);
> +               mutex_unlock(&priv->lock);
>                 netdev_unlock(dev);
> +               netdev_put(dev, &dev_tracker);
> +               mutex_lock(&priv->lock);
>         }
>         mutex_unlock(&priv->lock);
>  }
> --
> 2.34.1
>


--=20
Thanks,
Mina

