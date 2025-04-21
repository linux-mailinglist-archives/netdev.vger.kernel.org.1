Return-Path: <netdev+bounces-184329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F29A94BB1
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271923B1CA6
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E8257431;
	Mon, 21 Apr 2025 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a20AFbGM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68582116F2
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206774; cv=none; b=nCS4oI5cyHMQX7VMqXFrbZqeeSRpfj3BnWvD4lAUU/vNmFggwkFSncZqTKzZ4WvLATo0or3Y8Yt5s9oVIlV32mU7KBkC8U2XNhK9OTuvv+OKr6FZBz4kBLcNNVRxfnsMgl8il5DImguD5FOry5L+7fdsLlyizXYHYDo+Y8oFC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206774; c=relaxed/simple;
	bh=6oxFYPmLwuDaxdcExAaX5wiW2PfBY9E69djTpc+P7Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVKM8yeR2vrFc/6A/G0KisPn9lPLp7gSHQ+Il9nwa0Bvzd/9Rk3XFoR9U9oDUKTSZE7eJyq+tlWSac6YRQdty9FpikiqXmRmgAZR74Kh3Vu4fvqXxIDaeDJ8vTgMPM81ePfnjV2i/a9q9kme5nkuz6HmXqSozFPH4zhYO5hliJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a20AFbGM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745206771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5BnKrW/+iLpSyZ/tIFzeeGvAiccvF/rn1UPOilvOg0=;
	b=a20AFbGMAbrgiSDo6tK6szIOLzODBvFUMbOK+g8Vvfu/ITlu70wHT25a2KrWXe63FBRI6e
	zHgXKolWsNvWDy1FdlIzesPlCjxKxHk6Idt0ITKoo1T1PHQNW+oe7IYE8r8TzBEGwd6GQf
	7HrFfigxukrrI0DB27/uqW0W1o4QLuA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-4OkcRBcgOo-FLhwsto9SJg-1; Sun, 20 Apr 2025 23:39:28 -0400
X-MC-Unique: 4OkcRBcgOo-FLhwsto9SJg-1
X-Mimecast-MFC-AGG-ID: 4OkcRBcgOo-FLhwsto9SJg_1745206767
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af91ea9e884so1688638a12.0
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745206767; x=1745811567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5BnKrW/+iLpSyZ/tIFzeeGvAiccvF/rn1UPOilvOg0=;
        b=sCl1xOOEqkmn0Y0NcbNwFderQBUGvddaX9lLD2tVZ2wO9g96qg7r4qf8+6thMwYmfs
         8SEJIv7nMWKep7lXrtttrPcaIWGRgjUHrvKqGsCtfXTFKMs6cqbD7oN51HBSX2Utpx7i
         xJ9SUkauHQxQ1BsApGtyLNkdDmatr/F5W7zLyzriW7+Hu98hCjxXFDKqQ8UluvigRE9G
         3o5ilcJqclgXlwTgHmaKG0LSrdpeGSP88wXe+2nbnlO01BFDLVSSJFb7HgFkNX88S/F3
         QAbiXB4cZxO2HHcZNaHC+OiYkRaP6a+f3BStEU8DdgAWtwlXeL6GQBxxV0n4F484M9V5
         3psg==
X-Forwarded-Encrypted: i=1; AJvYcCUQih9CiHV4AJnFZlldcEoY5CdZO3REn5mFZ/covDR2Alpb+HjDs8dnYSJGajBXFCE/mJK0wv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOIX0yrMRTzRQuO+2F7Ec5intt9of9h9N860KylhBNiTq7H4v
	QoBRntF8fZ6v/elliVIvp6xtRJiF9qHmQUqRH2BvH2LuzPBzE6uoADQRdKW/TS2u+6BnrIu47wx
	JzaGQ8hrPv2QZWN9AwoWZuBfBVDGT2RT/D0GvqlOT6JCYyDVu3tmdbj5sfduDfp7pbDVeaWZrmx
	MfIVxCGJSgio82aGE/CFx1Fu1aQ/+I
X-Gm-Gg: ASbGnctyTFw3qW97ihc5Fk5o4NOnq13jSpmVr9l34R+hD/H6fq5w3ajk/8nkiLx4ZIV
	VHpWMVNVbA+pmF7YpDQMtcMWAKFckw7rg1+EkESHZk4XKFz23GBL+0NUaO+cle22t8IRHpA==
X-Received: by 2002:a17:90b:3d47:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-3087c37c06emr13653780a91.16.1745206766998;
        Sun, 20 Apr 2025 20:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEIrGzGPwpjGKHQC1F/RF3H9cL/pjElpuRMFvFA29JaCU37Nr1gUW4xh8WpYSPiB50aHILQd2VfjJS8pLlvAM=
X-Received: by 2002:a17:90b:3d47:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-3087c37c06emr13653758a91.16.1745206766608; Sun, 20 Apr 2025
 20:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-3-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:39:14 +0800
X-Gm-Features: ATxdqUEsTuLK2yRKipuFBGShT8e-kODU4mIJ9z2UVs1nOfSu0ypFzVw0B46MNuM
Message-ID: <CACGkMEtCxn7rZfvo9_nUwC1TwqJ+5F2XDdU89rz=iyO3U0pCEQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] vhost: Reintroduce kthread mode support in vhost
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode support in vhost,
> It also introduces struct vhost_worker_ops to abstract
> worker create/stop/wakeup operations.
>
> * Bring back the original vhost_worker() implementation,
>   and renamed to vhost_run_work_kthread_list().
>
> * Add cgroup support for the kthread
>
> * Introduce struct vhost_worker_ops:
>   - Encapsulates create / stop / wake=E2=80=91up callbacks.
>   - vhost_worker_create() selects the proper ops according to
>     inherit_owner.
>
> This partially reverts or improves upon:
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 188 ++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  12 +++
>  2 files changed, 182 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 250dc43f1786..be97028a8baf 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> +#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -242,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *w=
orker,
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->ops->wakeup(worker);
>         }
>  }
>
> @@ -388,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>         __vhost_vq_meta_reset(vq);
>  }
>
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +       struct vhost_worker *worker =3D data;
> +       struct vhost_work *work, *work_next;
> +       struct vhost_dev *dev =3D worker->dev;
> +       struct llist_node *node;
> +
> +       kthread_use_mm(dev->mm);
> +
> +       for (;;) {
> +               /* mb paired w/ kthread_stop */
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               if (kthread_should_stop()) {
> +                       __set_current_state(TASK_RUNNING);
> +                       break;
> +               }
> +               node =3D llist_del_all(&worker->work_list);
> +               if (!node)
> +                       schedule();
> +
> +               node =3D llist_reverse_order(node);
> +               /* make sure flag is seen after deletion */
> +               smp_wmb();
> +               llist_for_each_entry_safe(work, work_next, node, node) {
> +                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +                       __set_current_state(TASK_RUNNING);
> +                       kcov_remote_start_common(worker->kcov_handle);
> +                       work->fn(work);
> +                       kcov_remote_stop();
> +                       cond_resched();
> +               }
> +       }
> +       kthread_unuse_mm(dev->mm);
> +
> +       return 0;
> +}
> +
>  static bool vhost_run_work_list(void *data)
>  {
>         struct vhost_worker *worker =3D data;
> @@ -582,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
> +struct vhost_attach_cgroups_struct {
> +       struct vhost_work work;
> +       struct task_struct *owner;
> +       int ret;
> +};
> +
> +static void vhost_attach_cgroups_work(struct vhost_work *work)
> +{
> +       struct vhost_attach_cgroups_struct *s;
> +
> +       s =3D container_of(work, struct vhost_attach_cgroups_struct, work=
);
> +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> +}
> +
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
> +       struct vhost_attach_cgroups_struct attach;
> +       int saved_cnt;
> +
> +       attach.owner =3D current;
> +
> +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> +       vhost_worker_queue(worker, &attach.work);
> +
> +       mutex_lock(&worker->mutex);
> +
> +       /*
> +        * Bypass attachment_cnt check in __vhost_worker_flush:
> +        * Temporarily change it to INT_MAX to bypass the check
> +        */
> +       saved_cnt =3D worker->attachment_cnt;
> +       worker->attachment_cnt =3D INT_MAX;
> +       __vhost_worker_flush(worker);
> +       worker->attachment_cnt =3D saved_cnt;

I wonder if it's easier to re-introduce the flush that was used before
vhost kthread to avoid the tricks here. We can have flush ops for
example.

Thanks


