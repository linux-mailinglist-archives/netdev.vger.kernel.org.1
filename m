Return-Path: <netdev+bounces-179525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66FA7D73B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CF188C350
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01610225797;
	Mon,  7 Apr 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDhx3DDZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204E19CC05
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013367; cv=none; b=nEPQm0MxoACBd5um3gE8UgJSD8qQduXc+fSXyUYOYaaGxAT6vcd2IkZEuYa/GTTGVvdBbYamU8ZPci56KmR2tAoi1IRNejPA1vMrNYEwtBGhdVkS5vIgwr9Hg8ufZVJty7g+tF9njrGKlakDMiYEU7QXYvbyAS7rLuR1n1vWxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013367; c=relaxed/simple;
	bh=AIcU3qGQw0vyLqEK981tZMF9Tv1Bj8Bx9LH29b6ile8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+6t7zKun4sx0IwUOiYjH/CbSs9eeg15y+3hgx6Mg74iaXloB8u4zHa3Qlm9xKwJDxAVhLU5o1WWZU4kxK6eY+zSIIFEs0ZRDrVFFrsFkLUSBnGPTNdmRHXVDWTqbrpmyV8eVfvLaqETZGhRQHKQY/p9QCgzOZSGQmRfbRVE69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDhx3DDZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744013365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25iyDw7sQyJUYeKPA+oSXr49j9oc0JtsKm/C1RWwbCM=;
	b=RDhx3DDZutqlVjm5RYjKiw+8eJmbVacuIRVMNYXCd25eWYsasBd/y/J+uasY0qNFvxt7iS
	cNULM1vXMPy45ak6/7Kgmd9p5B/hXTGmeMM9LIC1XGMQ1MSRmyNaqBqJy68TstYE8AhjJR
	HLOE2WDlfrAG2dHFmoeUv8QD81YcF3s=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-mxWSyKvNMiWqcUWqY7yU5A-1; Mon, 07 Apr 2025 04:09:24 -0400
X-MC-Unique: mxWSyKvNMiWqcUWqY7yU5A-1
X-Mimecast-MFC-AGG-ID: mxWSyKvNMiWqcUWqY7yU5A_1744013363
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6f2737d115eso54442127b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 01:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744013363; x=1744618163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25iyDw7sQyJUYeKPA+oSXr49j9oc0JtsKm/C1RWwbCM=;
        b=iHcZMvjqVeMQIjr+vrCKiLLZ3hUs/uxukgQjoukC1PcN/ULqODo14C6pmIl2VGJbNg
         1oMLMmXuJJ23ZxovilwL7lFbRZEqACJ2fZMoW4D3nM14R0oKYANn4yoP/jHte1Q58aXj
         X2DCAqJLbhnIQXSQTM9MH5P8NDz+dc9R/1MEosysa4ZQ1aRFwRUqShVtlAwbH3wBbuqL
         Bhu98KLZy/p40DNgUjOXFjhbNvc8tuCfmu669e7cXAK4k2PnWTbwEkEAHELEJ2I6GITy
         CuMcUMhrS3ZPmz/j7xTX+VSJ8Djk9I06iEYwzXmTdRIHGwos+DOnenwZKj10Q/j1yNtb
         ebfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVts1kjogbowbF4lxZHJn8sU3CaILtyid1gWA0pdOuQl1ktZxgmIhglDXfqze9YECrzgIdHv64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSe960tuJljj4xhBLjKRedL3dOOGYXVoFk/2zpMSjh3Hobdqc
	T7SZi/1MceL7EihBj7ekZAJejd1paoxna2wsHoBlPTLRbNcui48D84ENuTAccXQEp8qF+HqYhZp
	lzpviGxztikRawwX4WG5Wf55m+3ZutzKO2tNwUT8OntAqX+RGfA4PyyapvHAYCcYIZRuVCZ/G4n
	xXpB67fjOIt/UGbGcHVFPjEJizLi88OA+fRUPjucs=
X-Gm-Gg: ASbGncu9Ru9MbbyXKiZoZVXGCzRnQwLdvzXsDkvmvEI9QGuUvKf8B40JY2HOG0ODCbk
	vrhNq6sOYXgOsh1tx1e1NYPNcbguvb3dZT3ZZDXFHwxFWJFYF+A0JXNHoIU9RYit5xeZPjuo=
X-Received: by 2002:a05:690c:7011:b0:6fb:a4e6:7d52 with SMTP id 00721157ae682-703e1625d65mr224051517b3.35.1744013362960;
        Mon, 07 Apr 2025 01:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb7hTIHt+NuAmVBBXpHYp02iOd0Zq7ltlx2Dmrw3wGkGid4PjxSlXl7aFHxqXXb8FYdr8XlOdtIB0TH3sudVc=
X-Received: by 2002:a05:690c:7011:b0:6fb:a4e6:7d52 with SMTP id
 00721157ae682-703e1625d65mr224051167b3.35.1744013362628; Mon, 07 Apr 2025
 01:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-5-lulu@redhat.com>
 <3hsgi4a2kj5fg65zz7q463ypxbstf2x73avupayyrexjonkheo@utoyktego6as> <CACLfguV5v8Pm9=+0jkDnZFLp-MiyoYT=cFsA2rqeVgNJ2O7zvQ@mail.gmail.com>
In-Reply-To: <CACLfguV5v8Pm9=+0jkDnZFLp-MiyoYT=cFsA2rqeVgNJ2O7zvQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 7 Apr 2025 10:09:11 +0200
X-Gm-Features: ATxdqUGcClEaKZlXIh_kQkwLsnROHag_isA2bwLbYX3EtHi3Lr3hxio_8weYAPw
Message-ID: <CAGxU2F5mCHdByvcuj8SOiXCj+MtD5=GM4yEprpeiDU8ZZAVsLw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Apr 2025 at 05:14, Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> > >Abstract vhost worker operations (create/stop/wakeup) into an ops
> > >structure to prepare for kthread mode support.
> > >
> > >Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >---
> > > drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++------------=
-
> > > drivers/vhost/vhost.h | 11 ++++++++
> > > 2 files changed, 56 insertions(+), 18 deletions(-)
> > >
> > >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > >index 20571bd6f7bd..c162ad772f8f 100644
> > >--- a/drivers/vhost/vhost.c
> > >+++ b/drivers/vhost/vhost.c
> > >@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker=
 *worker,
> > >                * test_and_set_bit() implies a memory barrier.
> > >                */
> > >               llist_add(&work->node, &worker->work_list);
> > >-              vhost_task_wake(worker->vtsk);
> > >+              worker->ops->wakeup(worker);
> > >       }
> > > }
> > >
> > >@@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev =
*dev,
> > >
> > >       WARN_ON(!llist_empty(&worker->work_list));
> > >       xa_erase(&dev->worker_xa, worker->id);
> > >-      vhost_task_stop(worker->vtsk);
> > >+      worker->ops->stop(worker);
> > >       kfree(worker);
> > > }
> > >
> > >@@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev =
*dev)
> > >       xa_destroy(&dev->worker_xa);
> > > }
> > >
> > >+static void vhost_task_wakeup(struct vhost_worker *worker)
> > >+{
> > >+      return vhost_task_wake(worker->vtsk);
> > >+}
> > >+
> > >+static void vhost_task_do_stop(struct vhost_worker *worker)
> > >+{
> > >+      return vhost_task_stop(worker->vtsk);
> > >+}
> > >+
> > >+static int vhost_task_worker_create(struct vhost_worker *worker,
> > >+                                  struct vhost_dev *dev, const char *=
name)
> > >+{
> > >+      struct vhost_task *vtsk;
> > >+      u32 id;
> > >+      int ret;
> > >+
> > >+      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > >+                               worker, name);
> > >+      if (IS_ERR(vtsk))
> > >+              return PTR_ERR(vtsk);
> > >+
> > >+      worker->vtsk =3D vtsk;
> > >+      vhost_task_start(vtsk);
> > >+      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > >+      if (ret < 0) {
> > >+              vhost_task_do_stop(worker);
> > >+              return ret;
> > >+      }
> >
> > In the final code, xa_alloc() is duplicated among the functions that
> > create ktrhead or task, might it make sense to leave it out and do it i=
n
> > vhost_worker_create() ?
> >
> > Thanks,
> > Stefano
> >
> Thanks a lot Stefano. I previously tried moving xa_alloc() out, but
> that made the code strange.
> I think keeping xa_alloc() in the create_ops function completes the
> job in  a single function, and maybe it could be used in some other
> functions in the future

Sure, if you tried, and it doesn't add benefits, that's perfectly fine
to ignore this suggestion! ;-)

Thanks,
Stefano

> thanks
> cindy
>
> > >+      worker->id =3D id;
> > >+      return 0;
> > >+}
> > >+
> > >+static const struct vhost_worker_ops vhost_task_ops =3D {
> > >+      .create =3D vhost_task_worker_create,
> > >+      .stop =3D vhost_task_do_stop,
> > >+      .wakeup =3D vhost_task_wakeup,
> > >+};
> > >+
> > > static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev=
)
> > > {
> > >       struct vhost_worker *worker;
> > >-      struct vhost_task *vtsk;
> > >       char name[TASK_COMM_LEN];
> > >       int ret;
> > >-      u32 id;
> > >+      const struct vhost_worker_ops *ops =3D &vhost_task_ops;
> > >
> > >       worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> > >       if (!worker)
> > >               return NULL;
> > >
> > >       worker->dev =3D dev;
> > >+      worker->ops =3D ops;
> > >       snprintf(name, sizeof(name), "vhost-%d", current->pid);
> > >
> > >-      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > >-                               worker, name);
> > >-      if (IS_ERR(vtsk))
> > >-              goto free_worker;
> > >-
> > >       mutex_init(&worker->mutex);
> > >       init_llist_head(&worker->work_list);
> > >       worker->kcov_handle =3D kcov_common_handle();
> > >-      worker->vtsk =3D vtsk;
> > >-
> > >-      vhost_task_start(vtsk);
> > >-
> > >-      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > >+      ret =3D ops->create(worker, dev, name);
> > >       if (ret < 0)
> > >-              goto stop_worker;
> > >-      worker->id =3D id;
> > >+              goto free_worker;
> > >
> > >       return worker;
> > >
> > >-stop_worker:
> > >-      vhost_task_stop(vtsk);
> > > free_worker:
> > >       kfree(worker);
> > >       return NULL;
> > >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > >index 19bb94922a0e..98895e299efa 100644
> > >--- a/drivers/vhost/vhost.h
> > >+++ b/drivers/vhost/vhost.h
> > >@@ -26,6 +26,16 @@ struct vhost_work {
> > >       unsigned long           flags;
> > > };
> > >
> > >+struct vhost_worker;
> > >+struct vhost_dev;
> > >+
> > >+struct vhost_worker_ops {
> > >+      int (*create)(struct vhost_worker *worker, struct vhost_dev *de=
v,
> > >+                    const char *name);
> > >+      void (*stop)(struct vhost_worker *worker);
> > >+      void (*wakeup)(struct vhost_worker *worker);
> > >+};
> > >+
> > > struct vhost_worker {
> > >       struct vhost_task       *vtsk;
> > >       struct vhost_dev        *dev;
> > >@@ -36,6 +46,7 @@ struct vhost_worker {
> > >       u32                     id;
> > >       int                     attachment_cnt;
> > >       bool                    killed;
> > >+      const struct vhost_worker_ops *ops;
> > > };
> > >
> > > /* Poll a file (eventfd or socket) */
> > >--
> > >2.45.0
> > >
> >
>


