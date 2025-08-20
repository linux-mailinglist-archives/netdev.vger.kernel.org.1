Return-Path: <netdev+bounces-215088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46CB2D16B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D889526E75
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750E2367C0;
	Wed, 20 Aug 2025 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObZyYwPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2D2356C9
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653484; cv=none; b=M1R78XQPgL2qOfByTEIog4F0ZFgrBxth6nxo2V5n3jvTknqcJbrnJyv1trbo00wDgzUw87rY4nNjfgzuY5nM2VGr7IrgDxGUc6JPhHDjVOTLBoQVfxRXqATyCNkGxj/Wpme42UNthGjjV14QFGrmVFXra4EhNJEznq89gxdtdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653484; c=relaxed/simple;
	bh=oo/j3PfymDzX+Hfsh2NLLWeSisZgQLS8hkdxexH4V10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3C+6t4bguXhCaOrwR0vZm5clhZi04ESTljr8U+yDBqEzSaFvdpdQVNC7rHklAWj8wlurm7aulgMuVCon8MsRcn7G19NXj32cvJ9OueewzmjMB+/mbunfseUeGxhUuRiaCdnHHBT+uQXigjWmbdsD2YSl5oFFtH+KgwEbCRF5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObZyYwPj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cef2f624fso1527e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755653480; x=1756258280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTLUau1fwutTQtmzxY3qvClC5HiGTupDvi5aS9lWfFg=;
        b=ObZyYwPjB+5pQqWsOtcpzc58aj8MjwXOvv6cwfb/dgyVlHMgPqzC/rtg+UmYHvQHSW
         NHnTrCsCIioadokygKQcgJW2gQwx9RYNuPP/kW9wxe8LLdzCurA4YWvnSd0XWvPRdj+6
         a2lwlsWqMSh84vSad3SHq/sDZElm9ScBkjRmbi8ojPoWghQ2Bn/zFGzD5I5/H66gJmjy
         y37l6buj/VMZe4qZogj6AmmU71ywjU/OGH5f3QXzp0ESKqer6nyDGgYBApVPbZPfvavA
         9TaqupeqI8jGtpNrpVOV01nw0CobKt4VR0FhL6bOYY23AEpCbahtOLbWeuvmuw/sPjE1
         llTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755653480; x=1756258280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTLUau1fwutTQtmzxY3qvClC5HiGTupDvi5aS9lWfFg=;
        b=rj8qjxQkOQKoNDC05S90Y54IPI9WuUSPTgvgOkYDxgC5LLVlC4jRKxAVytGjkF+4yk
         UJ8hlNrfOME0I6ZmK9kNCjBpJ7x0kfUOmIZrXQ5RANk8c4BRZ9UZLCKAYdkcnCCqVCpn
         vUb+mJsz+GVeP9lEZvEPvo0B2w/uEe1Hc+x6enMcOBzUorbBsaJC5TJEs3a3exNOk7zp
         eFTREMQZE4N7HWlr4k1Wm4kEA5na5rV009vLun39dm4Mv62qcrUEewCOayVgQBwX5diw
         JP3YgkEwYDxFhgFYZbEA592JrUDxVttNeWfpARztnE/3VT6aLPZXSCO4Mqg9s8nlXjJN
         Gpxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrMjJnPd6pS31Xlp0rSdGQ1aUBK7XnzkjXmZgChBs1quXKzKJkjE1QW+FIxbGZ2c7DeSS9YIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM0zA7L4jKbQ7xgYK97hFsRDdcwt7cSkob5N4wuftukqxVzxp
	SZjXaAjIY3PAKuGKgJHO31yC8rotO6vzGeGZOXb6mlDUlaBYVlQQ3h4+eXnkB6rIZ5eAqNcHrKX
	BZM4GpL7n9Pmciuz7v9fbt83lrYy+MSXBnJ4/Mtq/
X-Gm-Gg: ASbGncvopwBTEou4nxToQQFd07ho/Do04m+3PuwDiQfHaBqGTUXHSIaDcrEkCjh2UsL
	066yVFbhc3H4+ZLHMPWaf8MmCvu7e+sBoJuSbNV60COjyYls7ePscmCLacWLxkBArw3t7RJZqhF
	UC1mnkbyz2Vm04Jb26fhRmETbdbI+fOVyW76jw3mNBc1S176+6gZp68Nclajy7OXOAJVfqXiW7J
	9AIgfyslHgnjG0=
X-Google-Smtp-Source: AGHT+IHT/6vjJ3shGdDPb9Fd3Wy97s1NrKmmnjPVT/7BhrMd3DmV+U6ospo8fL4BuQOHHl7LwakWHhHJqlcVvP+21aw=
X-Received: by 2002:a05:6512:288:b0:557:e3bc:4950 with SMTP id
 2adb3069b0e04-55e0706cc54mr65685e87.7.1755653480027; Tue, 19 Aug 2025
 18:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <819d46e1354b0c7cc97945c6c7bde09f12df1da6.1755499376.git.asml.silence@gmail.com>
 <CAHS8izOru3+zGPkOa5XMWOo1uhtzz+Zt7yDC7R=NZFfyPdeK9Q@mail.gmail.com>
In-Reply-To: <CAHS8izOru3+zGPkOa5XMWOo1uhtzz+Zt7yDC7R=NZFfyPdeK9Q@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 18:31:08 -0700
X-Gm-Features: Ac12FXxQQ5U6eRVSrC6zCcNwvwL1-NkxxJKMgfbxZblDH0DrKqPtvKdkhFJsl34
Message-ID: <CAHS8izMLPkw1y93iRwoT5yuscSHZGuwhg1tfkF7SSkKAbgQKsg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/23] net: add queue config validation callback
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:54=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmai=
l.com> wrote:
> >
> > From: Jakub Kicinski <kuba@kernel.org>
> >
> > I imagine (tm) that as the number of per-queue configuration
> > options grows some of them may conflict for certain drivers.
> > While the drivers can obviously do all the validation locally
> > doing so is fairly inconvenient as the config is fed to drivers
> > piecemeal via different ops (for different params and NIC-wide
> > vs per-queue).
> >
> > Add a centralized callback for validating the queue config
> > in queue ops. The callback gets invoked before each queue restart
> > and when ring params are modified.
> >
> > For NIC-wide changes the callback gets invoked for each active
> > (or active to-be) queue, and additionally with a negative queue
> > index for NIC-wide defaults. The NIC-wide check is needed in
> > case all queues have an override active when NIC-wide setting
> > is changed to an unsupported one. Alternatively we could check
> > the settings when new queues are enabled (in the channel API),
> > but accepting invalid config is a bad idea. Users may expect
> > that resetting a queue override will always work.
> >
> > The "trick" of passing a negative index is a bit ugly, we may
> > want to revisit if it causes confusion and bugs. Existing drivers
> > don't care about the index so it "just works".
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > ---
> >  include/net/netdev_queues.h | 12 ++++++++++++
> >  net/core/dev.h              |  2 ++
> >  net/core/netdev_config.c    | 20 ++++++++++++++++++++
> >  net/core/netdev_rx_queue.c  |  6 ++++++
> >  net/ethtool/rings.c         |  5 +++++
> >  5 files changed, 45 insertions(+)
> >
> > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > index b850cff71d12..d0cc475ec51e 100644
> > --- a/include/net/netdev_queues.h
> > +++ b/include/net/netdev_queues.h
> > @@ -147,6 +147,14 @@ void netdev_stat_queue_sum(struct net_device *netd=
ev,
> >   *                     defaults. Queue config structs are passed to th=
is
> >   *                     helper before the user-requested settings are a=
pplied.
> >   *
> > + * @ndo_queue_cfg_validate: (Optional) Check if queue config is suppor=
ted.
> > + *                     Called when configuration affecting a queue may=
 be
> > + *                     changing, either due to NIC-wide config, or con=
fig
> > + *                     scoped to the queue at a specified index.
> > + *                     When NIC-wide config is changed the callback wi=
ll
> > + *                     be invoked for all queues, and in addition to t=
hat
> > + *                     with a negative queue index for the base settin=
gs.
> > + *
> >   * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specif=
ied index.
> >   *                      The new memory is written at the specified add=
ress.
> >   *
> > @@ -167,6 +175,10 @@ struct netdev_queue_mgmt_ops {
> >         void    (*ndo_queue_cfg_defaults)(struct net_device *dev,
> >                                           int idx,
> >                                           struct netdev_queue_config *q=
cfg);
> > +       int     (*ndo_queue_cfg_validate)(struct net_device *dev,
> > +                                         int idx,
> > +                                         struct netdev_queue_config *q=
cfg,
> > +                                         struct netlink_ext_ack *extac=
k);
> >         int     (*ndo_queue_mem_alloc)(struct net_device *dev,
> >                                        struct netdev_queue_config *qcfg=
,
> >                                        void *per_queue_mem,
> > diff --git a/net/core/dev.h b/net/core/dev.h
> > index a553a0f1f846..523d50e6f88d 100644
> > --- a/net/core/dev.h
> > +++ b/net/core/dev.h
> > @@ -99,6 +99,8 @@ void netdev_free_config(struct net_device *dev);
> >  int netdev_reconfig_start(struct net_device *dev);
> >  void __netdev_queue_config(struct net_device *dev, int rxq,
> >                            struct netdev_queue_config *qcfg, bool pendi=
ng);
> > +int netdev_queue_config_revalidate(struct net_device *dev,
> > +                                  struct netlink_ext_ack *extack);
> >
> >  /* netdev management, shared between various uAPI entry points */
> >  struct netdev_name_node {
> > diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> > index bad2d53522f0..fc700b77e4eb 100644
> > --- a/net/core/netdev_config.c
> > +++ b/net/core/netdev_config.c
> > @@ -99,3 +99,23 @@ void netdev_queue_config(struct net_device *dev, int=
 rxq,
> >         __netdev_queue_config(dev, rxq, qcfg, true);
> >  }
> >  EXPORT_SYMBOL(netdev_queue_config);
> > +
> > +int netdev_queue_config_revalidate(struct net_device *dev,
> > +                                  struct netlink_ext_ack *extack)
> > +{
> > +       const struct netdev_queue_mgmt_ops *qops =3D dev->queue_mgmt_op=
s;
> > +       struct netdev_queue_config qcfg;
> > +       int i, err;
> > +
> > +       if (!qops || !qops->ndo_queue_cfg_validate)
> > +               return 0;
> > +
> > +       for (i =3D -1; i < (int)dev->real_num_rx_queues; i++) {
> > +               netdev_queue_config(dev, i, &qcfg);
>
> This function as written feels very useless tbh. There is no config
> passed in from the caller, so the function does a netdev_queue_config,
> which grabs the current-or-default-config (I'm not sure which tbh),
> and then validates that is applicable. But of course the current or
> default configs can be applied, right?
>
> I thought there would be a refactor in a future patch that makes this
> function useful, but I don't see one.
>
> The qcfg being applied needs to be passed in by the caller of this
> function, no? That would make sense to me (the caller is wondering if
> this new config is applicable).
>

OK, I misunderstood how this works on first read. netdev_queue_config
returns the pending config, not the current one, and that is what's
being validated. I'll give this a closer look.



--=20
Thanks,
Mina

