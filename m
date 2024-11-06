Return-Path: <netdev+bounces-142296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC019BE246
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911651C23249
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC271D9591;
	Wed,  6 Nov 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzRSzj1Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758E1D79B8
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884916; cv=none; b=XFTw27OBAUrFurbCrfoqZbGiD1I97SAWj2HiNX8HX/gEkIsalVj3U2Zs4i2lSVkZO7K3gZgkwL8ojtygWNC+qvZ7DUnHMXodeq0KenCKU2bi2SRLsr4lGBs2ZQjY8Juzf6YBWINceednmNF1WSvpiaV4AsuawGw32nxVPLzkTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884916; c=relaxed/simple;
	bh=Pw+CI4bHxgFkgqeCayKSDMkesfgD/0zFa0vhtdOxMjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz5sMfYy+qUvOnCofla2UVGH6taRbeqFI8vAfPidTdv308+6lcIfgAopSCTZ/h76tGGCfzjxLdqTXLMkiuiA2wTH/u7sIRCxlX/+YwVKdI3mlQ5ENUac4k9avgEFHWZ6Znvod2OeTKM3wZBLmU/j4dWbvADX27csQNwSpzHBNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzRSzj1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+/r8y82t5LpcD8J2mPdZCtNa7f1NkKmPiS7dBnIVQM=;
	b=LzRSzj1QtfE55vThDQ7W/jSWeVibHoSYst8EA9HmWOxc4ATh3ic9MkgxBDOzKxCAwkNPRe
	HNJa2VgA9Vsy8l8FNbMrnrUuE8nxNkixEr0BAVMpLwwHtINttlTfDQ+TqMdgy6m7RJllPR
	8y1DMKonvcFgisvG9E6oOUN/xQcfIPw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-xFq-Cim0MpuDSKiBm5t8mg-1; Wed, 06 Nov 2024 04:21:51 -0500
X-MC-Unique: xFq-Cim0MpuDSKiBm5t8mg-1
X-Mimecast-MFC-AGG-ID: xFq-Cim0MpuDSKiBm5t8mg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9e0eb26f08so76692166b.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884911; x=1731489711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+/r8y82t5LpcD8J2mPdZCtNa7f1NkKmPiS7dBnIVQM=;
        b=T5Sx2EIF+FBcQtpRw3Yf5Jh3+5S3vuij4Mftsgx9KgCi8x7TE5Wq6JV67XwBDkVGaj
         Ixp8fRM2xX2WZCNvs2j4chjsc0436J0LnNsGTHhy2jsNxPOIlNPivDTav95tmQoNY2Lv
         Iz6qrT83oQlrT0RwjI2+QeQ/7rmPrEqBUjLzlSFZy79oMMYzVgmqvmfbzWXctqAZeVeB
         jGwMxYHv5h13L5/52xc1P6nOHZe/HZpgo/uiNPn3Zi6fa5WaRzIeGjbSIokPTthfOV+0
         +MZnZ/1/7F0LOienLHdnL+2Qu0LyWM7jUJfPf4oK5Yaoj/tUHBqgTtNZjv5itJwXkAM3
         JSpw==
X-Forwarded-Encrypted: i=1; AJvYcCXX5OLaQMTrH31kcjVyh7zbw6SqdXOF3z/WW2DGAHk7gsHAX0K0i23ap0f+j0cNSZsbw7BxbIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN96Q3w4qhF+Mg8XxqiJGN6NIYk6/XHSGcHLaFkbHv+56Yv9Mo
	rTmqKM7TFCIme/PRvVw0tLj/qn9k8bW3w00AUqPElYjL7TEW6TZh8YTO0fwJyF//Cj23sZg9ivO
	AnTtoU3gxgK9DncIEphciUFiykn+4YCSDkzeEj8HTBHdF7YPO+pLwX2s2N3XkNO8YZ+HsUyjyLt
	VJsgfujjTDHoLsHmHJYipX7dnQcz0M
X-Received: by 2002:a17:906:dc91:b0:a9a:4f78:c3 with SMTP id a640c23a62f3a-a9e3a5a0da3mr2632258566b.21.1730884909160;
        Wed, 06 Nov 2024 01:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaDNg6wSMGmRW4F0u9QWcnzmzJVMDxrKOMNX8UWkiv8lV8hKePP9x5R6DeNMjld7k4M/mJKlB64IX5d/Yhcbk=
X-Received: by 2002:a17:906:dc91:b0:a9a:4f78:c3 with SMTP id
 a640c23a62f3a-a9e3a5a0da3mr2632249266b.21.1730884907353; Wed, 06 Nov 2024
 01:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-5-lulu@redhat.com>
 <CACGkMEvwirx3C7QL_xYB_niYBYfugCR9OMWqwcPfAPX=E1Qm=Q@mail.gmail.com>
In-Reply-To: <CACGkMEvwirx3C7QL_xYB_niYBYfugCR9OMWqwcPfAPX=E1Qm=Q@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 6 Nov 2024 17:21:09 +0800
Message-ID: <CACLfguXEc85-59966iK-aO2uzKthcv2TqGpK3VLhNs1K0pBq9w@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] vhost: Add kthread support in function vhost_worker_create
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:36=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Restored the previous functions kthread_wakeup and kthread_stop.
> > Also add a new structure, vhost_task_fn. The function vhost_worker_crea=
te
> > Will initializes this structure based on the value of inherit_owner.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 71 ++++++++++++++++++++++++++++++++++++-------
> >  drivers/vhost/vhost.h |  6 ++++
> >  2 files changed, 66 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index e40cef3a1fa5..603b146fccc1 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -741,43 +741,92 @@ static void vhost_workers_free(struct vhost_dev *=
dev)
> >         xa_destroy(&dev->worker_xa);
> >  }
> >
> > +static int vhost_task_wakeup_fn(void *vtsk)
> > +{
> > +       vhost_task_wake((struct vhost_task *)vtsk);
> > +       return 0;
> > +}
>
> Let's have a newline between two functions.
>
will fix this
> > +static int vhost_kthread_wakeup_fn(void *p)
> > +{
> > +       return wake_up_process((struct task_struct *)p);
> > +}
> > +static int vhost_task_stop_fn(void *vtsk)
> > +{
> > +       vhost_task_stop((struct vhost_task *)vtsk);
> > +       return 0;
> > +}
> > +static int vhost_kthread_stop_fn(void *k)
> > +{
> > +       return kthread_stop((struct task_struct *)k);
> > +}
> > +
> >  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> >  {
> >         struct vhost_worker *worker;
> > -       struct vhost_task *vtsk;
> > +       struct vhost_task *vtsk =3D NULL;
> > +       struct task_struct *task =3D NULL;
> >         char name[TASK_COMM_LEN];
> >         int ret;
> >         u32 id;
> >
> > +       /* Allocate resources for the worker */
> >         worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> >         if (!worker)
> >                 return NULL;
> >
> > +       worker->fn =3D kzalloc(sizeof(struct vhost_task_fn), GFP_KERNEL=
_ACCOUNT);
> > +       if (!worker->fn) {
> > +               kfree(worker);
> > +               return NULL;
> > +       }
> > +
> >         worker->dev =3D dev;
> >         snprintf(name, sizeof(name), "vhost-%d", current->pid);
> >
> > -       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > -                                worker, name);
> > -       if (!vtsk)
> > -               goto free_worker;
> > -
> >         mutex_init(&worker->mutex);
> >         init_llist_head(&worker->work_list);
> >         worker->kcov_handle =3D kcov_common_handle();
> > -       worker->vtsk =3D vtsk;
> >
> > -       vhost_task_start(vtsk);
> > +       if (dev->inherit_owner) {
> > +               /* Create and start a vhost task */
> > +               vtsk =3D vhost_task_create(vhost_run_work_list,
> > +                                        vhost_worker_killed, worker, n=
ame);
> > +               if (!vtsk)
> > +                       goto free_worker;
> > +
> > +               worker->vtsk =3D vtsk;
> > +               worker->fn->wakeup =3D vhost_task_wakeup_fn;
> > +               worker->fn->stop =3D vhost_task_stop_fn;
> > +
> > +               vhost_task_start(vtsk);
> > +       } else {
> > +               /* Create and start a kernel thread */
> > +               task =3D kthread_create(vhost_run_work_kthread_list, wo=
rker,
> > +                                     "vhost-%d", current->pid);
> > +               if (IS_ERR(task)) {
> > +                       ret =3D PTR_ERR(task);
> > +                       goto free_worker;
> > +               }
> > +               worker->task =3D task;
> > +               worker->fn->wakeup =3D vhost_kthread_wakeup_fn;
> > +               worker->fn->stop =3D vhost_kthread_stop_fn;
> > +
> > +               wake_up_process(task);
> > +               /* Attach to the vhost cgroup */
> > +               ret =3D vhost_attach_cgroups(dev);
> > +               if (ret)
> > +                       goto stop_worker;
> > +       }
> >
> >         ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> >         if (ret < 0)
> >                 goto stop_worker;
> >         worker->id =3D id;
> > -
> >         return worker;
> > -
> >  stop_worker:
> > -       vhost_task_stop(vtsk);
> > +       worker->fn->stop(dev->inherit_owner ? (void *)vtsk : (void *)ta=
sk);
> >  free_worker:
> > +       kfree(worker->fn);
> >         kfree(worker);
> >         return NULL;
> >  }
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index c650c4506c70..ebababa4e340 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -25,8 +25,13 @@ struct vhost_work {
> >         vhost_work_fn_t         fn;
> >         unsigned long           flags;
> >  };
> > +struct vhost_task_fn {
> > +       int (*wakeup)(void *task);
>
> Let's have comments to explain the semantics of each operation.
>
sure, will fix this
> > +       int (*stop)(void *task);
> > +};
>
> I think the goal is to reduce if/else, so while at this, let's
> introduce more ops. For example the create_worker one?
>
sure, will change this part
thanks
cindy
> >
> >  struct vhost_worker {
> > +       struct task_struct      *task;
> >         struct vhost_task       *vtsk;
> >         struct vhost_dev        *dev;
> >         /* Used to serialize device wide flushing with worker swapping.=
 */
> > @@ -36,6 +41,7 @@ struct vhost_worker {
> >         u32                     id;
> >         int                     attachment_cnt;
> >         bool                    killed;
> > +       struct vhost_task_fn *fn;
> >  };
> >
> >  /* Poll a file (eventfd or socket) */
> > --
> > 2.45.0
> >
>
> Thanks
>


