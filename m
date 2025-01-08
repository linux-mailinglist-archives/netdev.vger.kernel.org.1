Return-Path: <netdev+bounces-156143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3BA05139
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A8188AA6D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740BF18A6A7;
	Wed,  8 Jan 2025 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuZyauQm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D80178CC8
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304811; cv=none; b=i02/AAaloBhCI/vbJFwegD/JOgE8IPXYB+ldK4t8OGpAz7o1ERwVVjG+UFalh8Y8hDwwxShDp/lsiZ44jRPhvfTPmvgs74125SYatZVX/80LWLouSH6AhbjmEUbjLntNacgPcaLWf7GVMYfWvNzfIthTQqy9JrpAuDptbtVMIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304811; c=relaxed/simple;
	bh=9/pE+Wxa2elnqfrhvZzQFH6KidAABa/ga48rEB7fwpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItwpPqpv0g3J/dREcfCZ/o30qVMBrGjlHBVsOgebUu1NjlxCdEhcH/RyKCnI8XGmMeGdixOjQYmpqsbEultfvEeukqBRnq3/GU63s6SlezsmCLLG7J7rc4/fxv19mTJSTfaLqQuSzqauDXjG8G7s/bt/TjxmctNePbV7ukvL1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuZyauQm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736304808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQMvGNjNOaImMQjWKefQj0whMcqK1Tw9cLRw5LgT9nA=;
	b=PuZyauQmcZuoM6UJReqFUnAAAbMth/ab8Fd7OnAo5H2fExhWoDsr9d4PnvzrrOnXFF23x0
	eeiJ1YG2/ElcwOQoUstL2nvR/ucdrQtv86LEQYUXOKD0St03eM57BUnu2Z6cJCy4ntSqHt
	/ZDF25XTDs2kFnY/r2yjOnJKAo9IXKk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-KciJaR0iMCOrpY9zFlR1yg-1; Tue, 07 Jan 2025 21:53:26 -0500
X-MC-Unique: KciJaR0iMCOrpY9zFlR1yg-1
X-Mimecast-MFC-AGG-ID: KciJaR0iMCOrpY9zFlR1yg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6a6dcf9a3so1157014266b.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 18:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736304805; x=1736909605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQMvGNjNOaImMQjWKefQj0whMcqK1Tw9cLRw5LgT9nA=;
        b=tCDwXJ6c/4Uz9dL6VE4R/Dn5ldB1W3QMmGY+H3DOj/dvR58i6cjzuK1VuUlm3DZtF2
         8EBDwlJD1Yt65dHz11l417MlJMcb9B0NMpinJlVrqn/MVRUoAP7sFmgwprR6ZtfarWpN
         A0ReXq5sw4K01wwzaECNPDNRJD0cgLRkGtTQSmWJDPnyIejCNRHUJRIVoHbhXK3K+S+6
         ARTc9yuhm5Y7xEDlehnuhDKj4DCIi/r+2R6wcrQKFQ/G4QvC1pTkrpgatwllF/rvyC0Y
         tNxopWwMGWEM1WdM9Csf8c+IzB4Nf3tDoSKxPhDKH0MNxCVIQh8iX/4Kj4XRkbyDVpaI
         eqfA==
X-Forwarded-Encrypted: i=1; AJvYcCVcOfKp8K415SdzHY+TYZOgHSN2wWP7J805wyIkb8BrWMx3Utcnimv+Nb52V56AJNKbc0G9o5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6etzzM8BbuIDur4Cdur7UQV0nMuJzNo6m4qQDDhd4N2hSDa5
	QY2CxG7a/oiiulFe7JRA2/75i+Q9c1oDqMIcxcVKV2QuR2TM3D58CPdXIPKKZCuqCoY5GDnb8Ug
	6lQCLeBz1K7i3S86PnKD5rAvoDHUCoTlunu8FfLraD1O0Dr3Eg7gw53ZdleOh9fPquDjLu45IBp
	2RXO6ovcHusAupA8lD2cj4VocQzRSF
X-Gm-Gg: ASbGncviNs1MH79xeKCm9uqq1EsGeYmVHjSg4MhMsPbNsl578xLwG6WOBSgrH4b6LOU
	LCl3/toZmShgZvimWREjy+qX3DR9HywEERP0ysrc=
X-Received: by 2002:a17:907:9413:b0:aa6:7165:504b with SMTP id a640c23a62f3a-ab2ab709c3bmr85848566b.31.1736304805103;
        Tue, 07 Jan 2025 18:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtPSFx+Jii2SB4GYn24I+sV9fGHmwOuatLxGKAITlhomw3MUBXt2Bqv1FQS5ZmDP8pn7IL2KfgAlaxq9DFtcc=
X-Received: by 2002:a17:907:9413:b0:aa6:7165:504b with SMTP id
 a640c23a62f3a-ab2ab709c3bmr85847066b.31.1736304804697; Tue, 07 Jan 2025
 18:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-5-lulu@redhat.com>
 <CACGkMEtq3yRB=7r54=rdPC1TPrz00ayEkt+L1n=dQTTTTD58FA@mail.gmail.com>
In-Reply-To: <CACGkMEtq3yRB=7r54=rdPC1TPrz00ayEkt+L1n=dQTTTTD58FA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Jan 2025 10:52:46 +0800
X-Gm-Features: AbW1kvb2RCGvKUnY-7tWHQnYGLfCkOm23poS8_VnJbEgsYOa3razX23Js-8Zq3s
Message-ID: <CACLfguVT_5Njx3Sq18st3K=+dzE2Rv7HUa+oX_XV+WXrzOjD_Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] vhost: Add worker related functions to support kthread
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Restore the previously removed functions kthread_wakeup and
> > kthread_stop, and add two new function pointers to wake up and stop
> > the workers. The function vhost_worker_create will initialize these
> > pointers based on the value of inherit_owner.
> >
> > The functions vhost_worker_queue() and vhost_worker_destroy() will
> > use the function pointer in vhost_worker, which is initialized
> > according to the inherit_owner value.
>
> I'd suggest using "vhost: introduce worker ops to support multiple
> thread models" as the title.
>
sure will change this
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
> >  drivers/vhost/vhost.h |  3 ++
> >  2 files changed, 71 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 812dfd218bc2..ff17c42e2d1a 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker =
*worker,
> >                  * test_and_set_bit() implies a memory barrier.
> >                  */
> >                 llist_add(&work->node, &worker->work_list);
> > -               vhost_task_wake(worker->vtsk);
> > +               worker->worker_wakeup(worker);
> >         }
> >  }
> >
> > @@ -698,7 +698,7 @@ static void vhost_worker_destroy(struct vhost_dev *=
dev,
> >
> >         WARN_ON(!llist_empty(&worker->work_list));
> >         xa_erase(&dev->worker_xa, worker->id);
> > -       vhost_task_stop(worker->vtsk);
> > +       worker->worker_stop(worker);
> >         kfree(worker);
> >  }
> >
> > @@ -721,14 +721,36 @@ static void vhost_workers_free(struct vhost_dev *=
dev)
> >         xa_destroy(&dev->worker_xa);
> >  }
> >
> > +static void vhost_task_wakeup_fn(struct vhost_worker *worker)
> > +{
> > +       return vhost_task_wake(worker->vtsk);
> > +}
> > +
> > +static void vhost_kthread_wakeup_fn(struct vhost_worker *worker)
> > +{
> > +       wake_up_process(worker->kthread_task);
> > +}
> > +
> > +static void vhost_task_stop_fn(struct vhost_worker *worker)
> > +{
> > +       return vhost_task_stop(worker->vtsk);
> > +}
> > +
> > +static void vhost_kthread_stop_fn(struct vhost_worker *worker)
> > +{
> > +       kthread_stop(worker->kthread_task);
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
> > @@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(s=
truct vhost_dev *dev)
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
> > +    /*
> > +     * If inherit_owner is true we use vhost_tasks to create
> > +     * the worker so all settings/limits like cgroups, NPROC,
> > +     * scheduler, etc are inherited from the owner.
> > +     * If false,we use kthreads and only attach to the same
> > +     * cgroups as the owner for compat with older kernels.
> > +     */
> > +       if (dev->inherit_owner) {
> > +               vtsk =3D vhost_task_create(vhost_run_work_list,
> > +                                        vhost_worker_killed, worker, n=
ame);
> > +               if (!vtsk)
> > +                       goto free_worker;
> > +
> > +               worker->vtsk =3D vtsk;
> > +               worker->worker_wakeup =3D vhost_task_wakeup_fn;
> > +               worker->worker_stop =3D vhost_task_stop_fn;
> > +
> > +               vhost_task_start(vtsk);
> > +               ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit=
_32b,
> > +                              GFP_KERNEL);
> > +               if (ret < 0)
> > +                       goto stop_worker;
>
> Let's simply have a new ops like worker_create to avoid the if/else here.
>
will change this
> > +       } else {
> > +               task =3D kthread_create(vhost_run_work_kthread_list, wo=
rker,
> > +                                     "vhost-%d", current->pid);
> > +               if (IS_ERR(task)) {
> > +                       ret =3D PTR_ERR(task);
> > +                       goto free_worker;
> > +               }
> > +               worker->kthread_task =3D task;
> > +               worker->worker_wakeup =3D vhost_kthread_wakeup_fn;
> > +               worker->worker_stop =3D vhost_kthread_stop_fn;
> >
> > -       vhost_task_start(vtsk);
> > +               wake_up_process(task);
> > +               ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit=
_32b,
> > +                              GFP_KERNEL);
> > +               if (ret < 0)
> > +                       goto stop_worker;
> >
> > -       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > -       if (ret < 0)
> > -               goto stop_worker;
> > -       worker->id =3D id;
> > +               ret =3D vhost_attach_task_to_cgroups(worker);
> > +               if (ret)
> > +                       goto stop_worker;
> > +       }
> >
> > +       worker->id =3D id;
> >         return worker;
> > -
> >  stop_worker:
> > -       vhost_task_stop(vtsk);
> > +       worker->worker_stop(worker);
> >  free_worker:
> >         kfree(worker);
> >         return NULL;
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index c650c4506c70..63b1da08a2b0 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -27,6 +27,7 @@ struct vhost_work {
> >  };
> >
> >  struct vhost_worker {
> > +       struct task_struct *kthread_task;
> >         struct vhost_task       *vtsk;
> >         struct vhost_dev        *dev;
> >         /* Used to serialize device wide flushing with worker swapping.=
 */
> > @@ -36,6 +37,8 @@ struct vhost_worker {
> >         u32                     id;
> >         int                     attachment_cnt;
> >         bool                    killed;
> > +       void (*worker_wakeup)(struct vhost_worker *worker);
> > +       void (*worker_stop)(struct vhost_worker *worker);
>
> Let's use a dedicated ops structure for this.
>
> Thanks
>
sure will do
Thanks
cindy
> >  };
> >
> >  /* Poll a file (eventfd or socket) */
> > --
> > 2.45.0
> >
>


