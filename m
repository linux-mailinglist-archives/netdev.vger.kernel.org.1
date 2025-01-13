Return-Path: <netdev+bounces-157568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C86A0AD65
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 03:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB73188590A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AEF42065;
	Mon, 13 Jan 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goPjVVfW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD32CA6F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735512; cv=none; b=VKDsHnsoAIByBRjTbyUCPptxj02SBEI1puPnvhsjFRIGAlBfFr32BF+jLjQ91acBW0Rnf4hSffWnWza2Xn4fxEj/JPp4aaVusmrGMc7y+f7GUjBrw5NGi5JHgb7tqOe7w4LDY3hGEI230HW7R8VwbJ9/XnafzVhgGC9axKGi80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735512; c=relaxed/simple;
	bh=27Y0gK4L2Ir0MQmlP0rp2H+j3B9I6vSN5t7U4PlYxKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSYX89Py7fullw96d6/OCXLag7CWZmoaxbyDBTxwZJYka6h6gZ5g9fparTq1xhTP58icGeCqF8gGPpHJtFx0X6chU8iFgPO1PSsy9wusjLP3Q/VY2tr65adPJWq7GJNXm7sqa2p+DgLwOW2szXfCRhV/tHwfAoQrFRZv9dHvV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goPjVVfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GD5D3g1MYQ6YHvDRRBZ1hnRcR9rg7HTZmwugqswcwaE=;
	b=goPjVVfWJyjymgBawWMx1y9LNPG4s9u8NUQfkJRxAT7pCQvJbtMcCEgsGkhYP8nnNz0Ten
	cRY7YrDTyJLdxthXeqXvCkHFuEtp60aQk+WdJlWLskWbZtPzj3vhyGt4D0RNWH3PYHKyRr
	508TlGeUp3GsHeI3LmrsfL6WZFA9X6o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-x4soCvEIO_CcsRmt7xGsRg-1; Sun, 12 Jan 2025 21:31:47 -0500
X-MC-Unique: x4soCvEIO_CcsRmt7xGsRg-1
X-Mimecast-MFC-AGG-ID: x4soCvEIO_CcsRmt7xGsRg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa67fcbb549so482705466b.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 18:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735506; x=1737340306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GD5D3g1MYQ6YHvDRRBZ1hnRcR9rg7HTZmwugqswcwaE=;
        b=UkVcNZbq0Z/AoBlC2n0pRAYwU8rXAKWUfOH8OBLwfsInwGWEp68ODln1nfSWpgKuQj
         Wkw1jzc0V1FK1THm2/l7r407XvRTonbFsYI/Sh/KOaOs8RpJ7f8/1JhKb+wyr05Uvwsk
         pP5AimnzTAJtBQ1JhZM03VBnVbL4+SPTuYEI+hyYGyzgqz5iUWbObV+DagSdfX+cR8BB
         ikefuaT1BkoFIMM2tneviP4tR3w4ufAHjwARMLuKe78gVpSRKlanLSvnql8FIyuWB/2S
         BWDvqSCYlnIoQxlT/poVpG0F2qUnQrbQkpgStcZRCoALkJ3L1vNcyJL1wL4vEe2tXcVy
         yTMA==
X-Forwarded-Encrypted: i=1; AJvYcCWpZtz+ehfhMkSGuVvvnkovP6i/9LvBCrLFVwzVmIxyQnL1GH9OrOgf4MOLdVUhUg3SwYTPxbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9OITvE5hHL4D+XBV5Gi1832BZoick6gRYuHlohBL+uiLeVop
	iqhT2fAu/o/QQoqnM/63Rb3Qp0aLfKutz3JzzlpyTKsU6O/BYgdFCjgTgdAPFg35/d9wOl+YyVg
	XkR3oXtd7QpWHIW7qa8wehCChLUBnzkLxOJc85OZS8tMdGZ4n9QBu/UiCSrsyXvn95xKEO8Xquy
	BoG8SVxtut6/W9rQ2HwQEpGa2vxCcG
X-Gm-Gg: ASbGncu7e1cMKLloKmkXh0Wxe+eoe1J6qGQu9oOrdz3VR7XqerjMp8baXU0/VNvrOgY
	Tusy5ZwNZGDW1NBv6TZCa0TAZE1ICYVIoIC3CSTk=
X-Received: by 2002:a17:906:6a22:b0:aa6:8ed8:a82d with SMTP id a640c23a62f3a-ab2ab5f52a3mr1560752866b.31.1736735506062;
        Sun, 12 Jan 2025 18:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV8pe7eInXvsrS3jw6Yxy6UMQZiOAUszXpoPhqezK3o9e/+/dYUX9B+9RVhWonAOcoDQcsOB/6rNtY6pFuulA=
X-Received: by 2002:a17:906:6a22:b0:aa6:8ed8:a82d with SMTP id
 a640c23a62f3a-ab2ab5f52a3mr1560752266b.31.1736735505767; Sun, 12 Jan 2025
 18:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-5-lulu@redhat.com>
 <foiitmbzkjjjbnz46sfy627jsfwkvya42zujxiigykzj2dluya@iumroiukvfld>
In-Reply-To: <foiitmbzkjjjbnz46sfy627jsfwkvya42zujxiigykzj2dluya@iumroiukvfld>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 13 Jan 2025 10:31:08 +0800
X-Gm-Features: AbW1kvbbiB_Bh_EjsWzsPUgcpcsdsFwxWoDelDB6yBhgsYzI5bQ7RGQ1GHdfzfc
Message-ID: <CACLfguX9KrGPwhefy9LJZ9h5Qv1msFcO7_naBDi4DqR2V3wgKg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] vhost: Add worker related functions to support kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:35=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Dec 30, 2024 at 08:43:51PM +0800, Cindy Lu wrote:
> >Restore the previously removed functions kthread_wakeup and
> >kthread_stop, and add two new function pointers to wake up and stop
> >the workers. The function vhost_worker_create will initialize these
> >pointers based on the value of inherit_owner.
> >
> >The functions vhost_worker_queue() and vhost_worker_destroy() will
> >use the function pointer in vhost_worker, which is initialized
> >according to the inherit_owner value.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
> > drivers/vhost/vhost.h |  3 ++
> > 2 files changed, 71 insertions(+), 16 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 812dfd218bc2..ff17c42e2d1a 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
>
> [...]
>
> >@@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(st=
ruct vhost_dev *dev)
> >       worker->dev =3D dev;
> >       snprintf(name, sizeof(name), "vhost-%d", current->pid);
> >
> >-      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> >-                               worker, name);
> >-      if (!vtsk)
> >-              goto free_worker;
> >-
> >       mutex_init(&worker->mutex);
> >       init_llist_head(&worker->work_list);
> >       worker->kcov_handle =3D kcov_common_handle();
> >-      worker->vtsk =3D vtsk;
> >+    /*
> >+     * If inherit_owner is true we use vhost_tasks to create
> >+     * the worker so all settings/limits like cgroups, NPROC,
> >+     * scheduler, etc are inherited from the owner.
> >+     * If false,we use kthreads and only attach to the same
> >+     * cgroups as the owner for compat with older kernels.
> >+     */
>
> This comment block seems to have incorrect indentation, perhaps you need
> to replace the spaces with at least one tab.
>
sure will do
Thanks
cindy
> >+      if (dev->inherit_owner) {
> >+              vtsk =3D vhost_task_create(vhost_run_work_list,
> >+                                       vhost_worker_killed, worker, nam=
e);
> >+              if (!vtsk)
> >+                      goto free_worker;
> >+
> >+              worker->vtsk =3D vtsk;
> >+              worker->worker_wakeup =3D vhost_task_wakeup_fn;
> >+              worker->worker_stop =3D vhost_task_stop_fn;
> >+
> >+              vhost_task_start(vtsk);
> >+              ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_3=
2b,
> >+                             GFP_KERNEL);
> >+              if (ret < 0)
> >+                      goto stop_worker;
> >+      } else {
> >+              task =3D kthread_create(vhost_run_work_kthread_list, work=
er,
> >+                                    "vhost-%d", current->pid);
> >+              if (IS_ERR(task)) {
> >+                      ret =3D PTR_ERR(task);
> >+                      goto free_worker;
> >+              }
> >+              worker->kthread_task =3D task;
> >+              worker->worker_wakeup =3D vhost_kthread_wakeup_fn;
> >+              worker->worker_stop =3D vhost_kthread_stop_fn;
> >
> >-      vhost_task_start(vtsk);
> >+              wake_up_process(task);
> >+              ret =3D xa_alloc(&dev->worker_xa, &id, worker,
> >xa_limit_32b,
> >+                             GFP_KERNEL);
> >+              if (ret < 0)
> >+                      goto stop_worker;
> >
> >-      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> >-      if (ret < 0)
> >-              goto stop_worker;
> >-      worker->id =3D id;
> >+              ret =3D vhost_attach_task_to_cgroups(worker);
> >+              if (ret)
> >+                      goto stop_worker;
> >+      }
> >
> >+      worker->id =3D id;
> >       return worker;
> >-
> > stop_worker:
> >-      vhost_task_stop(vtsk);
> >+      worker->worker_stop(worker);
> > free_worker:
> >       kfree(worker);
> >       return NULL;
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index c650c4506c70..63b1da08a2b0 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -27,6 +27,7 @@ struct vhost_work {
> > };
> >
> > struct vhost_worker {
> >+      struct task_struct *kthread_task;
> >       struct vhost_task       *vtsk;
> >       struct vhost_dev        *dev;
> >       /* Used to serialize device wide flushing with worker swapping. *=
/
> >@@ -36,6 +37,8 @@ struct vhost_worker {
> >       u32                     id;
> >       int                     attachment_cnt;
> >       bool                    killed;
> >+      void (*worker_wakeup)(struct vhost_worker *worker);
> >+      void (*worker_stop)(struct vhost_worker *worker);
> > };
> >
> > /* Poll a file (eventfd or socket) */
> >--
> >2.45.0
> >
>


