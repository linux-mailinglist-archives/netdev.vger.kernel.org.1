Return-Path: <netdev+bounces-179503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D6A7D25E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5919416B9C9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840CF2135AC;
	Mon,  7 Apr 2025 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWTh2UGp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31B17BA5
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995665; cv=none; b=fEoY42Fe4clEckeNomBkUNGdPYctQ+bWCmwJOThaCNV8c35g2WRgEOa6PvL/N1qh9wZuJsv/ju+54TuRo5N+a0vJc6LCkHBBPrZffnbUVK+2Bnv5eRwsYDXyT3s+9rSyOnv3DtUB2EsvkhDZeOFqIIQCpiLjlXpOZjM1Xi4p4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995665; c=relaxed/simple;
	bh=mXJAmxybI6UA4lfjqnhnYvdlcYJUljSoCZLa9BbD4is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7EKjUb8/eGp5I9sceMzjAHlZ+e9yBV+ufkbnOGzEt4ALw+ccE9gWbF4Iw8RUaBxtZp1vO/sdmzU45QgMcJz2S6tckK2EXgv74LGdTZ2o58qU3XFFo6K945xh8cM63aJtqvwTwQ1RF3UoqAq1yafrPq2t6w8xGLfr/+cvHQ3hhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWTh2UGp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743995662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EOfyJkW8Qr+KfhHOJXKNdiT0oP5UcDYVoU1kH9CCUI=;
	b=ZWTh2UGpxoGCo0myhAC6IDnP6eKbWN23rfKdxbWASgaty0LTkRcFD6KompwaEcbKUtpmf7
	r93aDLf7GA+QRQTTG12e6uZJRwed4gnX6gQWfNBTnXiJVZ8apf6OQzLVoDeV7HSmUysZD2
	Wqu/KcHX7TAy93OI7WOs7twiLwdIvag=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-IprYiZvTOUqAsoJOvwEgbQ-1; Sun, 06 Apr 2025 23:14:20 -0400
X-MC-Unique: IprYiZvTOUqAsoJOvwEgbQ-1
X-Mimecast-MFC-AGG-ID: IprYiZvTOUqAsoJOvwEgbQ_1743995659
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso383369966b.2
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 20:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743995659; x=1744600459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EOfyJkW8Qr+KfhHOJXKNdiT0oP5UcDYVoU1kH9CCUI=;
        b=r37J9LVGfLT2O2BuSPE6bZm29osxncOTb75IviASiysCw9XTi6C9z0XL1qll6E7QLJ
         kJscwoMBRKpAhTF463WrMp34R2e1Up29TJS1v4Eizlb5RWQyjTkOwJsvhdv2U3W7MWTf
         hMjk3Xn9d6LtCKNFuxg7Ny0RvPAqMrReuN+1/XkyzoF4HBfC1WB59h5l9KhPQau7orlV
         2N9ILyg2/h5n9Dly7yeZl0/ljn6ulUYfAh64lH+Xs8b7KzZR8SsMBU3tBXL8CZWuBc1W
         /6+wE4qzxvg8AJs2WyyKGZE6ygBXKAJp3qcMSYCEjQiPf2h0xqs/Q94kaumIvhnwUuUi
         Dx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWwrWKA9NscDX+cYvty5+nqywefl/VYzz8Vzp0CR8VskvvgHRwmARMnA8UUx9JqJlIwTaQz9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqE8ZR86Ndd2aFn2aUQAQDvQRjH2F7X2N04nrUmjaN3SwhdZU0
	yz8AbRq7ERSSL7pxQGFRx5T1GBL+I8BTeen4jqxeIGXl3jSOiiGPORLKgglie/wYxSnPPf6epQQ
	9gxYI4QhBj2F2gjlMNHzxk5nUERy33DWwiLvoLmE5YYocHq8fjRk7ilCe35pFTo/d2uabqCSEvR
	EbLt3PYFdQji7M39qOzSj88inL0eMP
X-Gm-Gg: ASbGncsRjAZODMfc9jpH37EpcS3+D9jBsZemI4hnAzpHzbhsDBU+L8MuyOuA/iEhswv
	HbLZ0r/OjhCLQgU3guIV4fFUZ6T3NF3DO9pOonqD8+QN2K/oGgk4tOCVe8jBhN87U2E8DE9Y8QQ
	==
X-Received: by 2002:a17:907:7e91:b0:ac7:c66a:4702 with SMTP id a640c23a62f3a-ac7e7778fccmr672850566b.57.1743995659401;
        Sun, 06 Apr 2025 20:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCWk0xdNUItKSUltbDcxn9ctHyrAE4G2otpueHZlPsmxRr87Wrg5z580eF4IAEek7EI0SxS57Fmv8i+q3owI8=
X-Received: by 2002:a17:907:7e91:b0:ac7:c66a:4702 with SMTP id
 a640c23a62f3a-ac7e7778fccmr672848866b.57.1743995659075; Sun, 06 Apr 2025
 20:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-5-lulu@redhat.com>
 <3hsgi4a2kj5fg65zz7q463ypxbstf2x73avupayyrexjonkheo@utoyktego6as>
In-Reply-To: <3hsgi4a2kj5fg65zz7q463ypxbstf2x73avupayyrexjonkheo@utoyktego6as>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 7 Apr 2025 11:13:42 +0800
X-Gm-Features: ATxdqUF29XmCj9-AK-IDg-1ou2ZB2wD6PcpkfDmhvou-lIdz_Dc0jfCjIxAbUfg
Message-ID: <CACLfguV5v8Pm9=+0jkDnZFLp-MiyoYT=cFsA2rqeVgNJ2O7zvQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> >Abstract vhost worker operations (create/stop/wakeup) into an ops
> >structure to prepare for kthread mode support.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++-------------
> > drivers/vhost/vhost.h | 11 ++++++++
> > 2 files changed, 56 insertions(+), 18 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 20571bd6f7bd..c162ad772f8f 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *=
worker,
> >                * test_and_set_bit() implies a memory barrier.
> >                */
> >               llist_add(&work->node, &worker->work_list);
> >-              vhost_task_wake(worker->vtsk);
> >+              worker->ops->wakeup(worker);
> >       }
> > }
> >
> >@@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *d=
ev,
> >
> >       WARN_ON(!llist_empty(&worker->work_list));
> >       xa_erase(&dev->worker_xa, worker->id);
> >-      vhost_task_stop(worker->vtsk);
> >+      worker->ops->stop(worker);
> >       kfree(worker);
> > }
> >
> >@@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev *d=
ev)
> >       xa_destroy(&dev->worker_xa);
> > }
> >
> >+static void vhost_task_wakeup(struct vhost_worker *worker)
> >+{
> >+      return vhost_task_wake(worker->vtsk);
> >+}
> >+
> >+static void vhost_task_do_stop(struct vhost_worker *worker)
> >+{
> >+      return vhost_task_stop(worker->vtsk);
> >+}
> >+
> >+static int vhost_task_worker_create(struct vhost_worker *worker,
> >+                                  struct vhost_dev *dev, const char *na=
me)
> >+{
> >+      struct vhost_task *vtsk;
> >+      u32 id;
> >+      int ret;
> >+
> >+      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> >+                               worker, name);
> >+      if (IS_ERR(vtsk))
> >+              return PTR_ERR(vtsk);
> >+
> >+      worker->vtsk =3D vtsk;
> >+      vhost_task_start(vtsk);
> >+      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> >+      if (ret < 0) {
> >+              vhost_task_do_stop(worker);
> >+              return ret;
> >+      }
>
> In the final code, xa_alloc() is duplicated among the functions that
> create ktrhead or task, might it make sense to leave it out and do it in
> vhost_worker_create() ?
>
> Thanks,
> Stefano
>
Thanks a lot Stefano. I previously tried moving xa_alloc() out, but
that made the code strange.
I think keeping xa_alloc() in the create_ops function completes the
job in  a single function, and maybe it could be used in some other
functions in the future
thanks
cindy

> >+      worker->id =3D id;
> >+      return 0;
> >+}
> >+
> >+static const struct vhost_worker_ops vhost_task_ops =3D {
> >+      .create =3D vhost_task_worker_create,
> >+      .stop =3D vhost_task_do_stop,
> >+      .wakeup =3D vhost_task_wakeup,
> >+};
> >+
> > static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >-      struct vhost_task *vtsk;
> >       char name[TASK_COMM_LEN];
> >       int ret;
> >-      u32 id;
> >+      const struct vhost_worker_ops *ops =3D &vhost_task_ops;
> >
> >       worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> >       if (!worker)
> >               return NULL;
> >
> >       worker->dev =3D dev;
> >+      worker->ops =3D ops;
> >       snprintf(name, sizeof(name), "vhost-%d", current->pid);
> >
> >-      vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_kill=
ed,
> >-                               worker, name);
> >-      if (IS_ERR(vtsk))
> >-              goto free_worker;
> >-
> >       mutex_init(&worker->mutex);
> >       init_llist_head(&worker->work_list);
> >       worker->kcov_handle =3D kcov_common_handle();
> >-      worker->vtsk =3D vtsk;
> >-
> >-      vhost_task_start(vtsk);
> >-
> >-      ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> >+      ret =3D ops->create(worker, dev, name);
> >       if (ret < 0)
> >-              goto stop_worker;
> >-      worker->id =3D id;
> >+              goto free_worker;
> >
> >       return worker;
> >
> >-stop_worker:
> >-      vhost_task_stop(vtsk);
> > free_worker:
> >       kfree(worker);
> >       return NULL;
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index 19bb94922a0e..98895e299efa 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -26,6 +26,16 @@ struct vhost_work {
> >       unsigned long           flags;
> > };
> >
> >+struct vhost_worker;
> >+struct vhost_dev;
> >+
> >+struct vhost_worker_ops {
> >+      int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
> >+                    const char *name);
> >+      void (*stop)(struct vhost_worker *worker);
> >+      void (*wakeup)(struct vhost_worker *worker);
> >+};
> >+
> > struct vhost_worker {
> >       struct vhost_task       *vtsk;
> >       struct vhost_dev        *dev;
> >@@ -36,6 +46,7 @@ struct vhost_worker {
> >       u32                     id;
> >       int                     attachment_cnt;
> >       bool                    killed;
> >+      const struct vhost_worker_ops *ops;
> > };
> >
> > /* Poll a file (eventfd or socket) */
> >--
> >2.45.0
> >
>


