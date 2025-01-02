Return-Path: <netdev+bounces-154670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D79FF5C9
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 04:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CFE3A322E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF42BB15;
	Thu,  2 Jan 2025 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT/g0KTf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B99383
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788799; cv=none; b=NRxVJ1GLey/oOTdF0YwUgdyandfICPAYlZzOAHoUjyuoocRhGPPtkyUXjNaVyIyuFlLhwvHoMgRxpQsZwH53P1f6f4cIVlSx+oHs5Fr9EPgLQ24txAG7U5zNTh7URqU6gH5zkU+uk3mNcz75FPcmE1x9OsjWKDI/86QFc8trne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788799; c=relaxed/simple;
	bh=8UPwYJRsztniqz2DZoYaOHrAI87CM8RMohG/bh2PQ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdluISBB2dxBZiJxNlIYU0cJPGaVmuPRBqp0hURLqW7vlIXIzqnGV3riSlq8gFQFy3/y0swy2HfxfN2rnizOPBtmbKOx+/jdHsC6HTByjpHOWxCqTLPO5/J9exF/kYa4uc9uT7hglSCj9UZ6TJLF6ohLSh2MfBf4BkmNupt+p9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT/g0KTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735788794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwi/cEGzVsTuOsP+zDgdSCie/y22AEKtZAKDaSUvUoU=;
	b=YT/g0KTfpNaOgrtkrFvoJZuNpzzFEmsMPh3WG6KCyZ4esNAgs86BQL6AFVKfgX8d2/DhBN
	GGcw3RZlciANknakcYn2VawBznPn/0w71MUNW++MgC2bz2k4ligfc/Dj9LeHXOGhe6AQ3q
	eYz5pLHUmFA+FScUNpY2wHw9OKYgR00=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-nCr1_M9zPuyTFxKz5bQ8WA-1; Wed, 01 Jan 2025 22:33:13 -0500
X-MC-Unique: nCr1_M9zPuyTFxKz5bQ8WA-1
X-Mimecast-MFC-AGG-ID: nCr1_M9zPuyTFxKz5bQ8WA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso22760296a91.0
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 19:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735788792; x=1736393592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwi/cEGzVsTuOsP+zDgdSCie/y22AEKtZAKDaSUvUoU=;
        b=hfxXwL0sbFKp0OklXmU/B4zTcP9a5siCDwQNZm1hAdHBy1gyS2ZRlmk8hNy91Ybsze
         VqikY+lBrhaCmiyMt6VjLLGfxNkzflcGu+7r5MZNqTs+qOY0EA+d8Ub6xhI3WEf+OUpD
         lXXvfRuQHFhuQ+U8CqC5Ntwjq5SfAjOYAuVKIXFzMQnJ5hcXK2RZH9x5MUlAlyIsygg8
         0brdQd6Nw37dS+2Ea5LuBbiAnt3RcdeygECguqdyTJO5sspWYsSkpfKM+MjbdMevhIeV
         h9AgjTp0nd+FmCeVxawHzNPqGabDh6vG/kITq8S47/jcyuJnRryvUlUrt5p8kRtkQ9Hh
         sCTA==
X-Forwarded-Encrypted: i=1; AJvYcCXi5AcBA+Ht01ljFZfjCHxflsWWxt16WQyYrXUi3l75Md52JsuKGevv8avtQUA7btKEFRqYZJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKicApDl1cXFirbyz4aN5q+zfyH6dTO5eCs3Y+1G52ysQMoV4D
	1foj0C8tW+B64V2e6F13rHPBbKIY6l9rRLeJzXIyFgd5fDXefLfQPCKZZhq6fDSKcgzYuCVBgOl
	WmnRGK4T5dlaWBP582yLjMa3ZlQJJjKxZqIZYU8rFAbM1C6FcZ4NTsnr7OqTx9aLLKsgxX+JvnN
	WWVVxjwdgOogs5/x8cSPIYyySrZRRo
X-Gm-Gg: ASbGncvK7s5j1fKd9MCyO0DsgCZ08ACYjfzOuTvwy0y+W2+VQxmeZMZWpPFy030Q6C/
	+zrd9gsluVOPYcwE89IKHA8GT5BFBanqNH3rFwqY=
X-Received: by 2002:a05:6a00:6f0b:b0:725:ab14:6249 with SMTP id d2e1a72fcca58-72abdd20f0emr65838262b3a.2.1735788792242;
        Wed, 01 Jan 2025 19:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLVIYdDgn70wDLrrgDEW/j8nHxOPS5L6zrTTVrhEd03L8ZoOgY4WUhHJEGakRnMQvpVDlp4g4SeZBSbLlkRaI=
X-Received: by 2002:a05:6a00:6f0b:b0:725:ab14:6249 with SMTP id
 d2e1a72fcca58-72abdd20f0emr65838239b3a.2.1735788791727; Wed, 01 Jan 2025
 19:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-5-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:33:00 +0800
Message-ID: <CACGkMEtq3yRB=7r54=rdPC1TPrz00ayEkt+L1n=dQTTTTD58FA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] vhost: Add worker related functions to support kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Restore the previously removed functions kthread_wakeup and
> kthread_stop, and add two new function pointers to wake up and stop
> the workers. The function vhost_worker_create will initialize these
> pointers based on the value of inherit_owner.
>
> The functions vhost_worker_queue() and vhost_worker_destroy() will
> use the function pointer in vhost_worker, which is initialized
> according to the inherit_owner value.

I'd suggest using "vhost: introduce worker ops to support multiple
thread models" as the title.

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
>  drivers/vhost/vhost.h |  3 ++
>  2 files changed, 71 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 812dfd218bc2..ff17c42e2d1a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *w=
orker,
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->worker_wakeup(worker);
>         }
>  }
>
> @@ -698,7 +698,7 @@ static void vhost_worker_destroy(struct vhost_dev *de=
v,
>
>         WARN_ON(!llist_empty(&worker->work_list));
>         xa_erase(&dev->worker_xa, worker->id);
> -       vhost_task_stop(worker->vtsk);
> +       worker->worker_stop(worker);
>         kfree(worker);
>  }
>
> @@ -721,14 +721,36 @@ static void vhost_workers_free(struct vhost_dev *de=
v)
>         xa_destroy(&dev->worker_xa);
>  }
>
> +static void vhost_task_wakeup_fn(struct vhost_worker *worker)
> +{
> +       return vhost_task_wake(worker->vtsk);
> +}
> +
> +static void vhost_kthread_wakeup_fn(struct vhost_worker *worker)
> +{
> +       wake_up_process(worker->kthread_task);
> +}
> +
> +static void vhost_task_stop_fn(struct vhost_worker *worker)
> +{
> +       return vhost_task_stop(worker->vtsk);
> +}
> +
> +static void vhost_kthread_stop_fn(struct vhost_worker *worker)
> +{
> +       kthread_stop(worker->kthread_task);
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
> @@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(str=
uct vhost_dev *dev)
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
> +    /*
> +     * If inherit_owner is true we use vhost_tasks to create
> +     * the worker so all settings/limits like cgroups, NPROC,
> +     * scheduler, etc are inherited from the owner.
> +     * If false,we use kthreads and only attach to the same
> +     * cgroups as the owner for compat with older kernels.
> +     */
> +       if (dev->inherit_owner) {
> +               vtsk =3D vhost_task_create(vhost_run_work_list,
> +                                        vhost_worker_killed, worker, nam=
e);
> +               if (!vtsk)
> +                       goto free_worker;
> +
> +               worker->vtsk =3D vtsk;
> +               worker->worker_wakeup =3D vhost_task_wakeup_fn;
> +               worker->worker_stop =3D vhost_task_stop_fn;
> +
> +               vhost_task_start(vtsk);
> +               ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_3=
2b,
> +                              GFP_KERNEL);
> +               if (ret < 0)
> +                       goto stop_worker;

Let's simply have a new ops like worker_create to avoid the if/else here.

> +       } else {
> +               task =3D kthread_create(vhost_run_work_kthread_list, work=
er,
> +                                     "vhost-%d", current->pid);
> +               if (IS_ERR(task)) {
> +                       ret =3D PTR_ERR(task);
> +                       goto free_worker;
> +               }
> +               worker->kthread_task =3D task;
> +               worker->worker_wakeup =3D vhost_kthread_wakeup_fn;
> +               worker->worker_stop =3D vhost_kthread_stop_fn;
>
> -       vhost_task_start(vtsk);
> +               wake_up_process(task);
> +               ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_3=
2b,
> +                              GFP_KERNEL);
> +               if (ret < 0)
> +                       goto stop_worker;
>
> -       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> -       if (ret < 0)
> -               goto stop_worker;
> -       worker->id =3D id;
> +               ret =3D vhost_attach_task_to_cgroups(worker);
> +               if (ret)
> +                       goto stop_worker;
> +       }
>
> +       worker->id =3D id;
>         return worker;
> -
>  stop_worker:
> -       vhost_task_stop(vtsk);
> +       worker->worker_stop(worker);
>  free_worker:
>         kfree(worker);
>         return NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index c650c4506c70..63b1da08a2b0 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -27,6 +27,7 @@ struct vhost_work {
>  };
>
>  struct vhost_worker {
> +       struct task_struct *kthread_task;
>         struct vhost_task       *vtsk;
>         struct vhost_dev        *dev;
>         /* Used to serialize device wide flushing with worker swapping. *=
/
> @@ -36,6 +37,8 @@ struct vhost_worker {
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> +       void (*worker_wakeup)(struct vhost_worker *worker);
> +       void (*worker_stop)(struct vhost_worker *worker);

Let's use a dedicated ops structure for this.

Thanks

>  };
>
>  /* Poll a file (eventfd or socket) */
> --
> 2.45.0
>


