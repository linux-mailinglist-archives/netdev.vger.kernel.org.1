Return-Path: <netdev+bounces-163827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A70A2BBA5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338FF16773F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 06:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAA176FB0;
	Fri,  7 Feb 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJNPpwM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EF155321
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738910549; cv=none; b=C0/2u5iartplBVGNt7+++YOJhFghIlD/v2mKby/Bdxej1NuoYUviG8TPZupKyOMfn2vUcH+FkWt/ChCnEcigc3/YeBanrQhp1asXkAFTqPX4Z3jLzIuJDpOswQNtxVeI8mYsZB+kJW2PBWW4uqVGNO0pK1jgKnHBKFTVUrBVPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738910549; c=relaxed/simple;
	bh=/+VyC0jOaCMoKfZK1fakHezSiikGBx6cHCax67Vebk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xecr1EDGYhJEiv6Cu3ymtB4M/JlZps0//BG3T0PuZ4PbP168fs+/0AJ3rb2TWho2eT+pki38uRyRPQ/3CW0O/QZXULiuI+DRifgF/O5sabDD9Tl1j68NZC2n7E26bvgc5qg7jTkhb+pvpO0R5VqGCUsd6ekmuylUBbUxpzpsm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJNPpwM7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab78863c312so92142766b.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 22:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738910546; x=1739515346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+R7WqbshtMT32enSkKL49UawuhpbNx8J7AnyusE3wM=;
        b=DJNPpwM7CgMguDJ61WNjl1p1ZAFCOq9GK8i0Aq/yoJwOE0O3+mnZbuzo4G9oAIQzLy
         HDwOPqhRzSA8FFVBaOVI/U142+emZy2I2c1aFvP2AlambGDQi5NX3xy/SpI+VG0zNdVO
         G9Hx81rWaCb7pMrXRUUWJwuOtsE84de9cOiQZtlGk2UJneeXrLXhL+BGbxzUJLPtuStB
         9GFuhVzyi3ZK1PhhirpKCYdTkfdZEHmtUqvDqMN4w+dLG+UKDK1bGdRGaKnyqycyugrd
         DRiaES2SLBGKB68zAm1CTuSvXBhg3bNUF6Y+epq4nHLUsX0eePzFDUu/9MxGF+xlw5SL
         gRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738910546; x=1739515346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+R7WqbshtMT32enSkKL49UawuhpbNx8J7AnyusE3wM=;
        b=dijuANKPdi2PzrMIJ7X4COsepdaPySlWKyIWzk0a53xTQPHfmfenaFs6y+n2mssYH+
         H825YbOM7tenSb7BUEScoAazDJnIXUVmnO/R82+NXhZeE3B7epi+ea8geUfIFApimdg+
         dKTA8YpLLGz9xz5GTuE00zZ7a2/lJBiMQZvNNGM9mHkvTrdibLu5lAeHeKbO1XgW26Gh
         YplamttePK7QNivE+PG/WhFMOKArYo/TQdPjLSAs3q0O/g7c+iXFW1ZFjdB2XrUCxdwg
         WLar9TvTDZBQ6F/as2LnOFLpeiNQBpsWV8I5CqX+jV1IIaYqqkHWkMB41/shA/0IOTPn
         lX9A==
X-Forwarded-Encrypted: i=1; AJvYcCXB8vpR2oGlKo3rQALXh51vzF/Wuywvo5RtAwIqjYuatdTzb9dbJSRx2UsFlmxvwyNRv3vSPro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/glIUOBSR9GChEuYhBCPCZ+0niBGRy97e1E91WdqpEgPcfb0
	wgX5Sek94RxU9NZMI6Xe+cxAfbq7XIM5BU86/jjCYmJYj1FnvViAhP9qwImbAbQJPh2GDI+SLfs
	j5wvEWGB9/GNMpnXQviNX9TwATlHwv7/sGcMG
X-Gm-Gg: ASbGncvUZw4lsmwaBVBSDyZnRbSVNtE5zbyb0H3bwAQwS3hxgeUZM8SxtxwHcYh+GC/
	iOh+2wOrmQSCtTKPJZVt1ZVFJPPTZNhwZezMaJWkT58j9aqNRxESZ153/3vBNPNgfNsKi2a83
X-Google-Smtp-Source: AGHT+IEGq73yGGMTc5e2OGs5A87wOVJZgtoiVngEnrIJ4ad44nyb16BRLXw/wmkL5PxfQeujllPyrkVLrfPubJeXuys=
X-Received: by 2002:a17:907:9719:b0:ab7:5901:c6b1 with SMTP id
 a640c23a62f3a-ab789bca5dcmr187115366b.25.1738910544185; Thu, 06 Feb 2025
 22:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207044251.65421-1-kuniyu@amazon.com> <20250207044251.65421-2-kuniyu@amazon.com>
In-Reply-To: <20250207044251.65421-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 07:42:13 +0100
X-Gm-Features: AWEUYZmZpsbtAjBY_juyCzqxn8hbKyd2DulbvxRBwFdVKZVssADtjmQ-dRuk12I
Message-ID: <CANn89iKdg=_uf-gis1knki-XSTbp-oHSXM0=kP-HFm2H39AWcg@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yael Chemla <ychemla@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:43=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> After the cited commit, dev_net(dev) is fetched before holding RTNL
> and passed to __unregister_netdevice_notifier_net().
>
> However, dev_net(dev) might be different after holding RTNL.
>
> In the reported case [0], while removing a VF device, its netns was
> being dismantled and the VF was moved to init_net.
>
> So the following sequence is basically illegal when dev was fetched
> without lookup:
>
>   net =3D dev_net(dev);
>   rtnl_net_lock(net);
>
> Let's use a new helper rtnl_net_dev_lock() to fix the race.
>
> It calls maybe_get_net() for dev_net_rcu(dev) and checks dev_net_rcu(dev)
> before/after rtnl_net_lock().
>
> The dev_net_rcu(dev) pointer itself is valid, thanks to RCU API, but the
> netns might be being dismantled.  maybe_get_net() is to avoid the race.
> This can be done by holding pernet_ops_rwsem, but it will be overkill.
>
>
> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevic=
e_notifier_dev_net().")
> Reported-by: Yael Chemla <ychemla@nvidia.com>
> Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09b=
c3@nvidia.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Tested-by: Yael Chemla <ychemla@nvidia.com>
> ---
> v2:
>   * Use dev_net_rcu().
>   * Use msleep(1) instead of cond_resched() after maybe_get_net()
>   * Remove cond_resched() after net_eq() check
>
> v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.c=
om/
> ---
>  net/core/dev.c | 63 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b91658e8aedb..f7430c9d9bc3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2070,6 +2070,51 @@ static void __move_netdevice_notifier_net(struct n=
et *src_net,
>         __register_netdevice_notifier_net(dst_net, nb, true);
>  }
>
> +static bool from_cleanup_net(void)
> +{
> +#ifdef CONFIG_NET_NS
> +       return current =3D=3D cleanup_net_task;
> +#else
> +       return false;
> +#endif
> +}
> +
> +static void rtnl_net_dev_lock(struct net_device *dev)
> +{
> +       struct net *net;
> +
> +       DEBUG_NET_WARN_ON_ONCE(from_cleanup_net());

I would rather make sure rtnl_net_dev_lock() _can_ be called from cleanup_n=
et()


> +again:
> +       /* netns might be being dismantled. */
> +       rcu_read_lock();
> +       net =3D maybe_get_net(dev_net_rcu(dev));

I do not think maybe_get_net() is what we want here.

If the netns is already in dismantle phase, the count will be zero.

Instead:

net =3D dev_net_rcu(dev);
refcount_inc(&net->passive);


> +       rcu_read_unlock();

> +       if (!net) {
> +               msleep(1);
> +               goto again;
> +       }

> +
> +       rtnl_net_lock(net);
> +
> +       /* dev might have been moved to another netns. */
> +       rcu_read_lock();

As we do not dereference the net pointer, I would not acquire
rcu_read_lock() and instead use

if (!net_eq(net, rcu_access_pointer(dev->nd_net.net)) {



> +       if (!net_eq(net, dev_net_rcu(dev))) {
> +               rcu_read_unlock();
> +               rtnl_net_unlock(net);

> +               put_net(net);
instead :
         net_drop_ns(net);

> +               goto again;
> +       }
> +       rcu_read_unlock();
> +}
> +
> +static void rtnl_net_dev_unlock(struct net_device *dev)
> +{
> +       struct net *net =3D dev_net(dev);
> +
> +       rtnl_net_unlock(net);

And replace the put_net() here and above with:

net_drop_ns(net);

> +       put_net(net);
> +}
> +
>  int register_netdevice_notifier_dev_net(struct net_device *dev,
>                                         struct notifier_block *nb,
>                                         struct netdev_net_notifier *nn)
> @@ -2077,6 +2122,8 @@ int register_netdevice_notifier_dev_net(struct net_=
device *dev,
>         struct net *net =3D dev_net(dev);
>         int err;
>

> +       DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->dev_list));
/* Why is this needed ? */

> +
>         rtnl_net_lock(net);
>         err =3D __register_netdevice_notifier_net(net, nb, false);
>         if (!err) {
> @@ -2093,13 +2140,12 @@ int unregister_netdevice_notifier_dev_net(struct =
net_device *dev,
>                                           struct notifier_block *nb,
>                                           struct netdev_net_notifier *nn)
>  {
> -       struct net *net =3D dev_net(dev);
>         int err;
>
> -       rtnl_net_lock(net);
> +       rtnl_net_dev_lock(dev);
>         list_del(&nn->list);
> -       err =3D __unregister_netdevice_notifier_net(net, nb);
> -       rtnl_net_unlock(net);
> +       err =3D __unregister_netdevice_notifier_net(dev_net(dev), nb);
> +       rtnl_net_dev_unlock(dev);
>
>         return err;
>  }
> @@ -10255,15 +10301,6 @@ static void dev_index_release(struct net *net, i=
nt ifindex)
>         WARN_ON(xa_erase(&net->dev_by_index, ifindex));
>  }
>
> -static bool from_cleanup_net(void)
> -{
> -#ifdef CONFIG_NET_NS
> -       return current =3D=3D cleanup_net_task;
> -#else
> -       return false;
> -#endif
> -}
> -
>  /* Delayed registration/unregisteration */
>  LIST_HEAD(net_todo_list);
>  DECLARE_WAIT_QUEUE_HEAD(netdev_unregistering_wq);
> --
> 2.39.5 (Apple Git-154)
>

