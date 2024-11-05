Return-Path: <netdev+bounces-141874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4B9BC961
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126311C2276A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890A1D0F4D;
	Tue,  5 Nov 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSOYgzjd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFC1CFEC2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799388; cv=none; b=H8fFiU1moZkL3R2LqmRSW4vMEsso7DiSPxw9D065C9yrfKHTza9bY4QdwTywvCp2QsUMTMu4vlAEo9nIjm5fCbOilLIQVsjfBETN6F3ZJ1rNtvIvH68ARq670XXUq8IJAI/SHHRWYXK5EC+M8dNKzxfny/2lSlDEcOLcKUB2KbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799388; c=relaxed/simple;
	bh=HK61foKF9sfhHn911lfsPH3oJNxHw0IxahFyjACuxXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVxHCUib6t0VjTT0UB2V6OAMb9SBH4pggMnkA5uiqNv9qGzprqLXWCPSbcW8kJ8oR0kI9xbN0mMIphTS/D4KmtR3H94jU7AcYkdKl0y1pfEPU645KHx64QSQi2dgAEsfdYxcPGy6WDlLMHAAbHAebXoVVm+adUb530gMYTUkr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSOYgzjd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnbUshi+Btrnsiq2772uBIQUdGC3j4HTKK/alQkcEt8=;
	b=YSOYgzjdkzy3hbj4UNdpZ5PEN4/2goMIktMaDjuBfPjABytgsvmv+rD8N2p/gXxze2GA6B
	K51Ph8K07ctu0yw1yo9wQYtWreeQPW4Grc8V66aZWzNpRSJmf6nYXuPVJPNe92hTzw95aP
	haSB5Fc2bRxXF/IQwEP9N4wwj+aJmeY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-GA5jWCurPda4_LzrFLYp-Q-1; Tue, 05 Nov 2024 04:36:23 -0500
X-MC-Unique: GA5jWCurPda4_LzrFLYp-Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e33e5fc515so5394167a91.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799382; x=1731404182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnbUshi+Btrnsiq2772uBIQUdGC3j4HTKK/alQkcEt8=;
        b=rZ+LMej6ZwBw0YIrLMZbAHRxlwZw123rovzqM2QANRJjELPBvyHN+Km8rZ7RhBJM+V
         gRts9QpT6GosPOqXhLKoEtDvIFrz3pJeW0NduA3hl8uZuAg/6RlcyzfFZ+6mqVjre/oH
         pFpwpA+Fnbp/eB8MrseeIc2TtutXE6OLfTF/QjjkxOcQUvXQAVpTBz/96Rsz3KxlaZuZ
         2Qy5F4AQ12OrabDThAi0NErJQCP6O3llcsL1j/ZTi0YHfBOSHglFvd6RrBFcTZn/eDk1
         cjdPb7OYM9CK5S7/Abc9nPLRPAz/eFaCpLZSrokyYaZy/du/mEKjGSiBCPrtwutD1xr7
         x30w==
X-Forwarded-Encrypted: i=1; AJvYcCWXhq9Vv6V0aIrWbfgequUpM7bfFFZzwfNYMWyjQ3qfWL3lCnQ4P0QT9hP6+FF2l2hDkHRcONQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5fOpMT8ym3bN+LbBfPWmS4EGrK0AOFGadz+3W/tyaNS+A/js
	oMDChA1UvniM8H0r0+/sO38w1KHYZ4U4zSQ/Z2sKbsgqZnAqg7e4TgfeWRvX6edJ9pm9lcPKpYT
	uhEjZCXlt0EdhdPYsnEAZ0xuMw13V4WXDzbfJsXawHAvmlrAEVDEkJWnDR127zqFQCxX7keXieI
	m1Z6Ecxd5fcfVezuPapwabsJJzcA/n
X-Received: by 2002:a17:90a:7c06:b0:2e0:921a:3383 with SMTP id 98e67ed59e1d1-2e92ce2e140mr28075383a91.1.1730799382283;
        Tue, 05 Nov 2024 01:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJg2fGkDrPlr2g7lZBsioz2F06wiAP/oru+C0TIQLdkUIHO4sELJOq1Pr2P31GnsK5t0S2801xgDQ+dR9Kfek=
X-Received: by 2002:a17:90a:7c06:b0:2e0:921a:3383 with SMTP id
 98e67ed59e1d1-2e92ce2e140mr28075363a91.1.1730799381807; Tue, 05 Nov 2024
 01:36:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-5-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:36:10 +0800
Message-ID: <CACGkMEvwirx3C7QL_xYB_niYBYfugCR9OMWqwcPfAPX=E1Qm=Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] vhost: Add kthread support in function vhost_worker_create
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Restored the previous functions kthread_wakeup and kthread_stop.
> Also add a new structure, vhost_task_fn. The function vhost_worker_create
> Will initializes this structure based on the value of inherit_owner.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 71 ++++++++++++++++++++++++++++++++++++-------
>  drivers/vhost/vhost.h |  6 ++++
>  2 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e40cef3a1fa5..603b146fccc1 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -741,43 +741,92 @@ static void vhost_workers_free(struct vhost_dev *de=
v)
>         xa_destroy(&dev->worker_xa);
>  }
>
> +static int vhost_task_wakeup_fn(void *vtsk)
> +{
> +       vhost_task_wake((struct vhost_task *)vtsk);
> +       return 0;
> +}

Let's have a newline between two functions.

> +static int vhost_kthread_wakeup_fn(void *p)
> +{
> +       return wake_up_process((struct task_struct *)p);
> +}
> +static int vhost_task_stop_fn(void *vtsk)
> +{
> +       vhost_task_stop((struct vhost_task *)vtsk);
> +       return 0;
> +}
> +static int vhost_kthread_stop_fn(void *k)
> +{
> +       return kthread_stop((struct task_struct *)k);
> +}
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>         struct vhost_worker *worker;
> -       struct vhost_task *vtsk;
> +       struct vhost_task *vtsk =3D NULL;
> +       struct task_struct *task =3D NULL;
>         char name[TASK_COMM_LEN];
>         int ret;
>         u32 id;
>
> +       /* Allocate resources for the worker */
>         worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>         if (!worker)
>                 return NULL;
>
> +       worker->fn =3D kzalloc(sizeof(struct vhost_task_fn), GFP_KERNEL_A=
CCOUNT);
> +       if (!worker->fn) {
> +               kfree(worker);
> +               return NULL;
> +       }
> +
>         worker->dev =3D dev;
>         snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
> -       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> -                                worker, name);
> -       if (!vtsk)
> -               goto free_worker;
> -
>         mutex_init(&worker->mutex);
>         init_llist_head(&worker->work_list);
>         worker->kcov_handle =3D kcov_common_handle();
> -       worker->vtsk =3D vtsk;
>
> -       vhost_task_start(vtsk);
> +       if (dev->inherit_owner) {
> +               /* Create and start a vhost task */
> +               vtsk =3D vhost_task_create(vhost_run_work_list,
> +                                        vhost_worker_killed, worker, nam=
e);
> +               if (!vtsk)
> +                       goto free_worker;
> +
> +               worker->vtsk =3D vtsk;
> +               worker->fn->wakeup =3D vhost_task_wakeup_fn;
> +               worker->fn->stop =3D vhost_task_stop_fn;
> +
> +               vhost_task_start(vtsk);
> +       } else {
> +               /* Create and start a kernel thread */
> +               task =3D kthread_create(vhost_run_work_kthread_list, work=
er,
> +                                     "vhost-%d", current->pid);
> +               if (IS_ERR(task)) {
> +                       ret =3D PTR_ERR(task);
> +                       goto free_worker;
> +               }
> +               worker->task =3D task;
> +               worker->fn->wakeup =3D vhost_kthread_wakeup_fn;
> +               worker->fn->stop =3D vhost_kthread_stop_fn;
> +
> +               wake_up_process(task);
> +               /* Attach to the vhost cgroup */
> +               ret =3D vhost_attach_cgroups(dev);
> +               if (ret)
> +                       goto stop_worker;
> +       }
>
>         ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
>         if (ret < 0)
>                 goto stop_worker;
>         worker->id =3D id;
> -
>         return worker;
> -
>  stop_worker:
> -       vhost_task_stop(vtsk);
> +       worker->fn->stop(dev->inherit_owner ? (void *)vtsk : (void *)task=
);
>  free_worker:
> +       kfree(worker->fn);
>         kfree(worker);
>         return NULL;
>  }
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index c650c4506c70..ebababa4e340 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -25,8 +25,13 @@ struct vhost_work {
>         vhost_work_fn_t         fn;
>         unsigned long           flags;
>  };
> +struct vhost_task_fn {
> +       int (*wakeup)(void *task);

Let's have comments to explain the semantics of each operation.

> +       int (*stop)(void *task);
> +};

I think the goal is to reduce if/else, so while at this, let's
introduce more ops. For example the create_worker one?

>
>  struct vhost_worker {
> +       struct task_struct      *task;
>         struct vhost_task       *vtsk;
>         struct vhost_dev        *dev;
>         /* Used to serialize device wide flushing with worker swapping. *=
/
> @@ -36,6 +41,7 @@ struct vhost_worker {
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> +       struct vhost_task_fn *fn;
>  };
>
>  /* Poll a file (eventfd or socket) */
> --
> 2.45.0
>

Thanks


