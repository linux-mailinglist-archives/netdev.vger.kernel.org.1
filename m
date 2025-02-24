Return-Path: <netdev+bounces-168874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD70A412C5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D127E16DCAB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B31581F1;
	Mon, 24 Feb 2025 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eG/eCUhb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823BC147
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361500; cv=none; b=aIL09nnj8KHnxsnavXdz2wDSCigaCnOz8UGuS1m4ipQcuAJX9Y6s0amKcQvoktGEvcbqiPCBGu9cKXYF42dI3YNR6fB3w7Qe/gfI4vS8K3KtQphYZv5zoUBbl4GlqcF/rsoew9aLcvpSEDFJDND/mDABWX2UZhT+u1IwXiWX/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361500; c=relaxed/simple;
	bh=ROt/kKCekqAhb6NgtR+HvYeVGgTyqwp4jif/BNvDLrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR4vh80pkY8M7eBTxTxK3Y+4X6nF1/rG5C7SYhQIlN70FiHJUeqyYgHam4yxS3K3svBWcxJHzbhda6cbPsI/JkL1qg8Ys3tkAHyBUKOHSdY674W6a1LkMqJrflaFC/ssV3TneicK4fPSK4tSyYDbhZEic5u2Rm6W8MBs21IqcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eG/eCUhb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9lqHCtMZZ5R8IZL9yYVIqfG02lS0lhbZnyZNMXSQMM=;
	b=eG/eCUhbKmhfYa86REl8stSCLV/iwwwEyQ7pTVnkT1R5THMwVnmbdsLYoIoc53CJAkMEOT
	OAKytI9T/HNyRpN8yizjkm0RxqWpn6nV4WhwNyrtrgy+5B0hAqOYNVkr+7gQpwtOnI61wG
	Iac3OzoBRRAI6XbAoYSa0hxZOqwu1a8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-cga1r8duME-jzGqOhchOFQ-1; Sun, 23 Feb 2025 20:44:56 -0500
X-MC-Unique: cga1r8duME-jzGqOhchOFQ-1
X-Mimecast-MFC-AGG-ID: cga1r8duME-jzGqOhchOFQ_1740361495
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so8394614a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 17:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361495; x=1740966295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9lqHCtMZZ5R8IZL9yYVIqfG02lS0lhbZnyZNMXSQMM=;
        b=KafLnMzhbrgGQRulboi8zLe3sGKkbVqpXLYWDJU+tl7/ykmYG2KxqN0yyL5P1okiQ1
         9B/yNSQeoH+vg+3drpmTngE3xcYAWodU7lthHXCW/6xw4bYrr8QfMyE+JTma4o/FayOr
         19a0WKJ55SZyG37t0yp4uMPx0OfJJYLcbOZKuJ/3mHlLEv13hNonPt1gLEdhY8W7Blcx
         UbgdxmBfpZ7n61mmZl/PTrhT2ARHeolNZRotK72RIu/ch9iKjGX/84HtCfADEmp+ajNB
         5ZyojykmdsWDSIA0ukrhvLtKW5cNF+BoBu/l4srmnpQbdFptSeIBxwNsmyRGVZyrJ/dM
         4WOA==
X-Forwarded-Encrypted: i=1; AJvYcCVG8pBOvz3GAHmflKX7ke4L4S+KfqK/5LDt+IGxZk5DTA1ExcoOOSbIpG92Eh1C3Vq/FTDJ+I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjcfqixSTNCAVmTycGX3HgrOazxaYLdAfIhLWZoPVf2yxqIZJ
	bQ/5XLkh09LM2CUo+/cGDl569TF+nlxmFX9dHAVdJ5lRqVnLwb7utLbLJyJshjdiYYbQccWjpfI
	oy0KkHr9uze/8BKaNNoQaxD1HvqI/vvExQfwFJ9e2In+0GcqJMFkgtVy4fieJKqXoejI3QOK2OR
	mu9FvU66nxGmiVrtBfN41Qc8q4YRTI
X-Gm-Gg: ASbGnctgUy6sh4WCk/d3Li4geTHq3UpVaySkOeEWH29m284mjvLYufHCGPEVVd4+TaP
	Wlu9Xjir+GOjJHbZn1TzlKDzn90YAEUuIK/BEUOoQvkudfEdEjt0QYLILP8seqdQDfzDnXHOPog
	==
X-Received: by 2002:a17:90b:2d4d:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2fce7699f42mr18043517a91.5.1740361495061;
        Sun, 23 Feb 2025 17:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH03WEjLmvDoT5qvup32c+sEHKZnDhkRywH5c7qogJFIwKUMBOIb7mTmJ6KFgxZ4ezoRXFO9NnnD5eX1vnbi9I=
X-Received: by 2002:a17:90b:2d4d:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2fce7699f42mr18043491a91.5.1740361494616; Sun, 23 Feb 2025
 17:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-5-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:44:42 +0800
X-Gm-Features: AWEUYZmHdhB41i3YJOmI8KaWVoLC4HBbRpKYemT6ZzkL8YZHj56ZsQVVWWGRtl0
Message-ID: <CACGkMEvhiq2FWKZwPmemCMq-tcS=HG1MCs8Yyoj_EdOdPBQBHQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] vhost: introduce worker ops to support multiple
 thread models
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This commit restores the previously removed functions kthread_wakeup and
> kthread_stop, and introduces a new ops structure to handle worker wakeup,
> stop, and creation. The function vhost_worker_create initializes these
> ops pointers based on the inherit_owner value.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Patch looks good but I have some some nits:

It might be better to have a separate patch to introduce the ops then
doing the kthread stuff on top.

> ---
>  drivers/vhost/vhost.c | 115 +++++++++++++++++++++++++++++++++++-------
>  drivers/vhost/vhost.h |  12 +++++
>  2 files changed, 110 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index adbb957c8b5f..d8c0ea118bb1 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *w=
orker,
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->ops->wakeup(worker);
>         }
>  }
>
> @@ -697,7 +697,7 @@ static void vhost_worker_destroy(struct vhost_dev *de=
v,
>
>         WARN_ON(!llist_empty(&worker->work_list));
>         xa_erase(&dev->worker_xa, worker->id);
> -       vhost_task_stop(worker->vtsk);
> +       worker->ops->stop(worker);
>         kfree(worker);
>  }
>
> @@ -720,42 +720,123 @@ static void vhost_workers_free(struct vhost_dev *d=
ev)
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
> +static int vhost_task_worker_create_fn(struct vhost_worker *worker,
> +                                      struct vhost_dev *dev, const char =
*name)
> +{
> +       struct vhost_task *vtsk;
> +       u32 id;
> +       int ret;
> +
> +       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> +                                worker, name);
> +       if (!vtsk)
> +               return -ENOMEM;
> +
> +       worker->vtsk =3D vtsk;
> +       vhost_task_start(vtsk);
> +       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> +       if (ret < 0) {
> +               vhost_task_stop_fn(worker);
> +               return ret;
> +       }
> +       worker->id =3D id;
> +       return 0;
> +}
> +
> +static int kthread_worker_create_fn(struct vhost_worker *worker,

Let's have a consistent name, e.g vhost_kthread_worker_create.

> +                                   struct vhost_dev *dev, const char *na=
me)
> +{
> +       struct task_struct *task;
> +       u32 id;
> +       int ret;
> +
> +       task =3D kthread_create(vhost_run_work_kthread_list, worker, "%s"=
, name);
> +       if (IS_ERR(task))
> +               return PTR_ERR(task);
> +
> +       worker->kthread_task =3D task;
> +       wake_up_process(task);
> +       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> +       if (ret < 0)
> +               goto stop_worker;
> +
> +       ret =3D vhost_attach_task_to_cgroups(worker);
> +       if (ret)
> +               goto stop_worker;
> +
> +       worker->id =3D id;
> +       return 0;
> +
> +stop_worker:
> +       vhost_kthread_stop_fn(worker);
> +       return ret;
> +}
> +
> +static const struct vhost_worker_ops vhost_task_ops =3D {
> +       .create =3D vhost_task_worker_create_fn,

I think we can get rid of the fn suffix as "fn".

> +       .stop =3D vhost_task_stop_fn,
> +       .wakeup =3D vhost_task_wakeup_fn,
> +};
> +
> +static const struct vhost_worker_ops kthread_ops =3D {
> +       .create =3D kthread_worker_create_fn,
> +       .stop =3D vhost_kthread_stop_fn,
> +       .wakeup =3D vhost_kthread_wakeup_fn,
> +};
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>         struct vhost_worker *worker;
> -       struct vhost_task *vtsk;
>         char name[TASK_COMM_LEN];
>         int ret;
> -       u32 id;
> +       const struct vhost_worker_ops *ops =3D
> +               dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
>
>         worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>         if (!worker)
>                 return NULL;
>
>         worker->dev =3D dev;
> +       worker->ops =3D ops;
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
> -
> -       vhost_task_start(vtsk);
> +       /*
> +        * If inherit_owner is true we use vhost_tasks to create
> +        * the worker so all settings/limits like cgroups, NPROC,
> +        * scheduler, etc are inherited from the owner. If false,
> +        * we use kthreads and only attach to the same cgroups
> +        * as the owner for compat with older kernels.
> +        */

Is this better to move this to the definition of the inherit_owner?

>
> -       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> +       ret =3D ops->create(worker, dev, name);
>         if (ret < 0)
> -               goto stop_worker;
> -       worker->id =3D id;
> +               goto free_worker;
>
>         return worker;
>
> -stop_worker:
> -       vhost_task_stop(vtsk);
>  free_worker:
>         kfree(worker);
>         return NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index c650c4506c70..029c203147be 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -26,7 +26,18 @@ struct vhost_work {
>         unsigned long           flags;
>  };
>
> +struct vhost_worker;
> +struct vhost_dev;
> +
> +struct vhost_worker_ops {
> +       int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
> +                     const char *name);
> +       void (*stop)(struct vhost_worker *worker);
> +       void (*wakeup)(struct vhost_worker *worker);
> +};
> +
>  struct vhost_worker {
> +       struct task_struct *kthread_task;
>         struct vhost_task       *vtsk;
>         struct vhost_dev        *dev;
>         /* Used to serialize device wide flushing with worker swapping. *=
/
> @@ -36,6 +47,7 @@ struct vhost_worker {
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> +       const struct vhost_worker_ops *ops;
>  };
>
>  /* Poll a file (eventfd or socket) */
> --
> 2.45.0
>

Thanks


