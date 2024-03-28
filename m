Return-Path: <netdev+bounces-82701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A9488F4DB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84AC1C261EE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D61804A;
	Thu, 28 Mar 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amffU/x0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC284D29E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590162; cv=none; b=AdHiLJ/vOlgGcx09liu5GYM/qrVRQA9QdeyjPdzJ9ckkxQp9aXjflVRMwO+vteKESN3TTSBDQPD86ViPyoggMC22TMXC13+qbH6u8/i6/8I8ZSny+du57bT2pTw3IdpLrRZOllr9TvPQXan+OgYtrkgg0RiRayXzLcmMTfBMXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590162; c=relaxed/simple;
	bh=xllegEYyIZMK02qj1Gk4ytrBu4a/+9PZfvN7d690eks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZpwWcZ1dI037dklOb9HD45jz/bN7s7w2m3pR2sOW/nkWJRO10oODTcHf5gn0VTbkyzOF+fW1gP7fx//bo/ztsrZMg7wWmBQXJJ26kuvspW36MBRFwHMyqSqRyMjDhKdE3iWtTTgtisBIz/2u+PsaDv70BmKOnDcnQlXAafFGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amffU/x0; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a4930d9c48so71232eaf.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711590160; x=1712194960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czxS4t81Dmi/uYnZl3buo2l0xGMl2l97jLzliCzgeMk=;
        b=amffU/x0B8fLCN5qx5RuykUOri19NFtb4OsIf/Cfj1x/Qu58v27qqa1tcH3Yl7+h6n
         hmfv02hRb4kbaW5gdsSXIMhi79jlCWkJivWExAfc5oZ3gt9vaH+O7ukXzPHFhYCygNbZ
         tMZEwM3eUueieBYVxr3vVwYQtIsv0giAW8vik5IFB9oZCQkvVFKWCWIxeOgiYT2T3HQu
         pYy6xBv7tQyCDvl3XfDa9OsyPcwH5duK/6BwZMJBUsJLWzza2p4ziIPu5+4ggjNI+t1M
         Bt62bLM6Q8hSFojwoLYBeNcMMYbFpHVgKxIfizWC/4FwfozMMfi1VA+9n135kiLQOkOS
         PVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711590160; x=1712194960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czxS4t81Dmi/uYnZl3buo2l0xGMl2l97jLzliCzgeMk=;
        b=BsHwa5w0eOrGwACh9R3G2uem118AExlWDlF/eJsd6mh3Gw+Y99AS5GrLxZHl2EzV7z
         z6VorKvCGjPQkO+w87cPk3O/7hPy40SA5jk0HBp/W3FLif/14ZRCJfaRTU+etqWDLRHU
         KNXtDpcBwNONLUPMfsD4Obp7gzVCb0k6lOWTXdlv5F7hXvp4nKUAitZC78ewkkN9h56w
         f/XbYwr+WqVHmtmYtEpVzNCsoam2e8uqZu/Nx1LxHRYQ/kBHiktsp6yYNAe9cpFBWERE
         e8mknIdpsBmkmyjuQZ++RPnCHWJ2pWB9zLY9TvFBgO6LkM0t1gOR760L+Z+0SrXQ5usM
         UcOw==
X-Forwarded-Encrypted: i=1; AJvYcCVGq58trHQaWvUjWZXz8jTFCEdy5uO/IqxtDHk8rSVAy6jZv3dIvz3fCiG7nilb4dW1vVs1UxnuutS5uO+OAE7Su1tFFU7H
X-Gm-Message-State: AOJu0YyXC+Lm2v3uy9gcYu6LOUR0uc8tU9o0UYJOK0eIPfxFAJgxRdHQ
	PFHEWsT+3luPlhugs/Bu1aLvoLX8xMXxh11qkbePjSFHaGK+sDvNWKcNWimqFB2BIr6rQssWoWR
	rhSwWSLm5qAwiTc4SCR/BtEIy/NKMeG8uN/R6DQ==
X-Google-Smtp-Source: AGHT+IF7mAD6XLmR4n3Gt/pClSzupL0+3U5AGiMLZ/7qav1f6YrsKvLOZpqZD1c+WfnbDN3udqxetHFYPB/m+t6gm1o=
X-Received: by 2002:a4a:a647:0:b0:5a4:6ac7:de6d with SMTP id
 j7-20020a4aa647000000b005a46ac7de6dmr2030707oom.1.1711590159712; Wed, 27 Mar
 2024 18:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327082128.942818-1-wenjian1@xiaomi.com> <40b3371a-5966-4140-922e-7c62a1c73e6c@intel.com>
In-Reply-To: <40b3371a-5966-4140-922e-7c62a1c73e6c@intel.com>
From: Jian Wen <wenjianhn@gmail.com>
Date: Thu, 28 Mar 2024 09:42:03 +0800
Message-ID: <CAMXzGWKmo7VDZw=xymcfcqC1diusBsj0QeV1zVHDCzgqeqk_gw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] devlink: use kvzalloc() to allocate devlink
 instance resources
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: jiri@mellanox.com, edumazet@google.com, davem@davemloft.net, 
	Jian Wen <wenjian1@xiaomi.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:15=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jian Wen <wenjianhn@gmail.com>
> Date: Wed, 27 Mar 2024 16:21:28 +0800
>
> > During live migration of a virtual machine, the SR-IOV VF need to be
> > re-registered. It may fail when the memory is badly fragmented.
> >
> > The related log is as follows.
> >
> > Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa=
 eth0: VF slot 1 added
> > ...
> > Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7,=
 mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=3D(null),cpuset=
=3D/,mems_allowed=3D0
> > Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G=
            E     5.4...x86_64 #1
> > Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual M=
achine/Virtual Machine, BIOS 090008  12/07/2018
> > Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
> > Mar  1 18:54:13  kernel: Call Trace:
> > Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
> > Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
> > Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
> > Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
> > Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
> > Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
> > Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
> > Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
> > Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
> > Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
> > Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
> > Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
> > Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
> > Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
> > Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
> > Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
> > Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
> > Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
> > Mar  1 18:54:13  kernel: kthread+0x105/0x140
> > Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
> > Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
> > Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50
> >
> > Changes since v1:
> > - Use struct_size(devlink, priv, priv_size) as suggested by Alexander L=
obakin
> >
> > Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
>
> Since it actually fixes a bug splat, you may want to send it with prefix
> "net" instead of "net-next" and add a "Fixes:" tag here blaming the
> first commit which added Devlink instance allocation. Let's see what
> others think.
Many commits that replace kzalloc()  with kvzalloc() don't include the
"Fixes:'' tag.

Jiri, what do you think?




>
> > ---
> >  net/devlink/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/devlink/core.c b/net/devlink/core.c
> > index 7f0b093208d7..f49cd83f1955 100644
> > --- a/net/devlink/core.c
> > +++ b/net/devlink/core.c
> > @@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *wor=
k)
> >       mutex_destroy(&devlink->lock);
> >       lockdep_unregister_key(&devlink->lock_key);
> >       put_device(devlink->dev);
> > -     kfree(devlink);
> > +     kvfree(devlink);
> >  }
> >
> >  void devlink_put(struct devlink *devlink)
> > @@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devli=
nk_ops *ops,
> >       if (!devlink_reload_actions_valid(ops))
> >               return NULL;
> >
> > -     devlink =3D kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> > +     devlink =3D kvzalloc(struct_size(devlink, priv, priv_size), GFP_K=
ERNEL);
> >       if (!devlink)
> >               return NULL;
> >
> > @@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devli=
nk_ops *ops,
> >       return devlink;
> >
> >  err_xa_alloc:
> > -     kfree(devlink);
> > +     kvfree(devlink);
> >       return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(devlink_alloc_ns);
>
> Thanks,
> Olek

