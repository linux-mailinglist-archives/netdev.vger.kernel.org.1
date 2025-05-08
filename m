Return-Path: <netdev+bounces-189080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB4AB04E1
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C9F3A586E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984B72628;
	Thu,  8 May 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyV6uq9g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2C4B1E72
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737171; cv=none; b=F3R0S7pylqLaqp6n3DNf8siizzSTGWvVkZOCV09UVlkAyK4RkrIzfa8HSW9i/cx8qYVybZRofX5vqkQw7eDC+v6b6QVtIRA7iLBWGvqa30diilvjzCdw2cPso2u0mK6jMVeS/QHYlGg8Q3Nm7mAzsNSRp5ObV/EVJsHt4mc3sZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737171; c=relaxed/simple;
	bh=cyDBtSdk5Qmz66vYOuz4mtaD4I+h0kkcn4NjkEYh2IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl4x9FkC1X8prcsHiKyP0nX4h20Wvz86H+8kOw8hiFiGD0UHc5YkhNLctJCVHP3Di+w1zRmrWWTDg4Kbbt32Dlkn4hQm4z9aSrfibNNUBVqxHxKgwJGcBrWzn69SDZtkm2WFMJzZTKy0ZTZlvbaMpx7TVDq+qDGPjR0N8hz5Qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyV6uq9g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22fa47f295dso11725ad.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746737169; x=1747341969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqu/uccifUm6mt8hDzTuYhF8+XvYT62qanCWrfsUrOs=;
        b=RyV6uq9gRGUY8AlZQmbFl4bMHQMyZa/IbkDpGZxKZK3opppUuw5TMdOcAH8NelzOT0
         doeuzYRcO2KPcg8hBFhD3RZlrg4N+2v2VVjSxl34FttwZYkEPBYjWRBH/qFk5vNpNR0d
         uArLZsqP5huK44fBnFeMNjeG+JEFtrzTKPzKJLISxbdI/wfOEQngisaPQzgKLhtDayHO
         /1XcIrbCEUA481gkpsf4t+nvmbMtEy5sb5Q+is/dsdVlZOfu9viD5rl50ybYp2nrLGUZ
         PT7+G1nitsYw3+OxZI0rC4SlP2JvIJecPCTGIKKSVjL2ZBegv1nl+xcHQUBk+4cSwDkK
         /V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737169; x=1747341969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqu/uccifUm6mt8hDzTuYhF8+XvYT62qanCWrfsUrOs=;
        b=u4KRug+gqOIjBaYoGE7dF4Fn3RzCW6wHLKIj9ZAfbA3ZuP6dwmnQIy1GWYoIriarvC
         Ruytl5HCQRo/uFagMd0AJ3UHh5tSZycMZmeNr4umiUb4opcnMSH7dQ1QUipSlzJlDBSu
         VhVfAuW4e7WVVhFu5/tuqWuIm07oHyOLZtbmyeWXIcoOI2VRUal9EpE42xmvbJ2brylB
         YK5AgQwvtGaU/R2VXb5m1omLSq8FYpBDmVMAD13W1G6LRd59HNy49Hvpujle5soM7bco
         7sqZ81GS55CnFyenxdM3MuC2RH+36ZgAXpFXWhkv9S7WBxZUyyNCkDBotgCIm2uoKiDy
         uoQA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ktE387HWRgIHma0wWivxWSQQmiw+EVEzZTqXsKvXDSVY4FT7KWk+95iI1favjpSy1GxXdC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDZClB7LCOWCLzlqI51lOvHm2Fqma/mmJaZ5VuxFDowRO6zCK
	sMSCYy6oT1IBip+M2gBEX4LkYZo/wQqdnBY6NzMYFhnXmrDKS+S1V2LrwWd75JkarHwi9+4yQj7
	gpxO9z8xvbHmG6XEqKEAUgVbuxbkjD5wgPmtT
X-Gm-Gg: ASbGncvH76IhqDCN73VCSYi6n/U5BZl5hO/fXvewAcTnkWYmGKv8HLhsbGZlFxcXa2o
	UHvgHneAC/xaTdpeLN3aKg+glI5edtR/gktrh/8Uq8a1Sy1pek7xyFcnkdxqiWgHW2AAjgv+IXL
	VqOJQt3t+SsNk3Jo3P7tpyj7GrSAVBwbLmCHkzaebyGSbTggDtJlM=
X-Google-Smtp-Source: AGHT+IENT4OFDbvUk0a7fos8YoEC4lI8cwjkfs4ItgQn8YpKPDaAWNftg0/uhzunxoQNjF7X4Z8+QwTkne+JLwTR3K0=
X-Received: by 2002:a17:903:2f8f:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-22fca880a59mr738265ad.6.1746737168705; Thu, 08 May 2025
 13:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506140858.2660441-1-ap420073@gmail.com> <CAHS8izNmrrO=q4vqGJ+mAQg52s3KqBXjdbrf=AgCUpHpS4oB7w@mail.gmail.com>
 <CAMArcTWV6YBzPN7e6y6Zf6LYAL8gnyVdGAnGuXbV4CFLP65f5w@mail.gmail.com>
In-Reply-To: <CAMArcTWV6YBzPN7e6y6Zf6LYAL8gnyVdGAnGuXbV4CFLP65f5w@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 8 May 2025 13:45:55 -0700
X-Gm-Features: ATxdqUHRDWbo3GEHqBou7kUZidxGjUDgoaLfbLFAXQg9ZBUDwt4irbaIceofPXg
Message-ID: <CAHS8izPgzJUe8t73K6=pG2g--7MYD_M0Nn_ZJhEMCFSKELENRw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:00=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
> >
> > Instead of this, if you need to protect concurrent access to
> > binding->dev, either:
> >
> > 1. create new spin_lock, binding->dev_lock, which protects access to
> > binding->dev, or
>
> Would a mutex be sufficient, or is a spinlock required?
>

AFAICT a mutex would be fine.

> > 2. Use rcu protection to lockelessly set binding->dev, or
> > 3. Use some cmpxchg logic to locklessly set/query binding->dev and
> > detect if it got modified in a racing thread.
> >
> > But please no multiplexing priv->lock to protect both priv->bindings
> > and binding->dev.
>
> Okay, I think introducing a new lock for protecting a binding would
> be enough. Not only protect binding->dev, all members of a binding.
> So, binding->lock would be more fit as a name.
>
> All members except a dev are not required to be protected so far.
> Because they are initialized when binding is initialized, and they are
> not changed in live.
> So, binding is alive, members are valid except for a dev.
> However, introducing binding->lock makes the code obvious, and it will
> not confuse us someday we want to protect other members of a binding.
>

Thanks, yes AFAICT we don't really need to synchronize access to any
other members of the binding in this patch, it's just binding->dev
that can be NULL'd while another thread is reading it. Maybe for now
we can have binding->lock protect binding->dev and in the future if
more sync it's needed, binding->lock can be re-used. A comment above
binding->lock can explain what it protects and doesn't.

> >
> > >                         break;
> > >                 }
> > >         }
> > > +       mutex_unlock(&binding->priv->lock);
> > >  }
> > >
> > >  static const struct memory_provider_ops dmabuf_devmem_ops =3D {
> > > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > > index 7fc158d52729..afd6320b2c9b 100644
> > > --- a/net/core/devmem.h
> > > +++ b/net/core/devmem.h
> > > @@ -11,6 +11,7 @@
> > >  #define _NET_DEVMEM_H
> > >
> > >  #include <net/netmem.h>
> > > +#include <net/netdev_netlink.h>
> > >
> > >  struct netlink_ext_ack;
> > >
> > > @@ -20,6 +21,7 @@ struct net_devmem_dmabuf_binding {
> > >         struct sg_table *sgt;
> > >         struct net_device *dev;
> > >         struct gen_pool *chunk_pool;
> > > +       struct netdev_nl_sock *priv;
> > >
> > >         /* The user holds a ref (via the netlink API) for as long as =
they want
> > >          * the binding to remain alive. Each page pool using this bin=
ding holds
> > > @@ -63,6 +65,7 @@ struct dmabuf_genpool_chunk_owner {
> > >  void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_bindi=
ng *binding);
> > >  struct net_devmem_dmabuf_binding *
> > >  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_f=
d,
> > > +                      struct netdev_nl_sock *priv,
> > >                        struct netlink_ext_ack *extack);
> > >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *bind=
ing);
> > >  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_=
idx,
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index 230743bdbb14..b8bb73574276 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -859,13 +859,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb,=
 struct genl_info *info)
> > >                 goto err_genlmsg_free;
> > >         }
> > >
> > > -       mutex_lock(&priv->lock);
> > > -
> > >         err =3D 0;
> > >         netdev =3D netdev_get_by_index_lock(genl_info_net(info), ifin=
dex);
> > >         if (!netdev) {
> > >                 err =3D -ENODEV;
> > > -               goto err_unlock_sock;
> > > +               goto err_genlmsg_free;
> > >         }
> > >         if (!netif_device_present(netdev))
> > >                 err =3D -ENODEV;
> > > @@ -877,10 +875,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb,=
 struct genl_info *info)
> > >                 goto err_unlock;
> > >         }
> > >
> > > -       binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->e=
xtack);
> > > +       mutex_lock(&priv->lock);
> > > +       binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, i=
nfo->extack);
> >
> > I'm not so sure about this as well. priv->lock should protect access
> > to priv->bindings only. I'm not sure why it's locked before
> > net_devmem_bind_dmabuf? Can it be locked around the access to
> > priv->bindings only?
>
> As you mentioned, this lock is unnecessary to protect
> netdev_devmem_bind_dmabuf().
> It is required to protect only priv->bindings.
> So,  I will move priv->lock to lock only around priv->bindings
> in the next patch.
>

Thanks!

--=20
Thanks,
Mina

