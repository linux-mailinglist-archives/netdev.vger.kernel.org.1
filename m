Return-Path: <netdev+bounces-184361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF1A94FB8
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5412166509
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FF1C8610;
	Mon, 21 Apr 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCRkoA+e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7817CA17
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233224; cv=none; b=AmK6QBak3+BCgT1ZHF5vTreOsjW/ksxQ54P90o89x51xj2c3fBf6zVtnhdUyKEeVMpgGVrA3ncyCUA/CJdNrgFVpPPnVrFOdUJtm/yJEabvErCJYu6QtFBARhR96WjmQ7xY97KRp3/MdK4p2q+Um1HYZwPhWtNVWO0F/JWq7IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233224; c=relaxed/simple;
	bh=uPpZZxMf34MjghpZtlEufZPaYCSS3j9kbC9t6YttDGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMN663pAjgsEdiGYfNAyWKUCHA8ZtG3p2TSOVcInh2pDoK3+dZ4alwF00Gs577Q3J9hhoLaRoAN0V4FxB1ZZR/riBNAlgyF+CU2QDblcpe0TpWtpedDcJ7eAcGk5w2K+UKd2l4MxQWcMYMCT+tgefVET7uUPx29FYJh2xyDeKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCRkoA+e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745233221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVl17+DIhdQKB5hKQKjqnZV/7Ux7S0MiBzai4RYraAo=;
	b=DCRkoA+eXMyAegYT3tcHJsUszCpWEUlgNIVhrFgXnD9zJsXGhjtZ2p47Qhgum6IN5rgMeG
	HIYfypuiD9yZjZgdF3bx0R3RNU2lYL9PWgv/l62Chl9HAVpVGpO1eKPuxIZIDKPOxOxTez
	ixzRVSra77htkYZGO5kHBdbSgkudpZg=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-UILQxdLSNcqGS0LgbyEISg-1; Mon, 21 Apr 2025 06:59:41 -0400
X-MC-Unique: UILQxdLSNcqGS0LgbyEISg-1
X-Mimecast-MFC-AGG-ID: UILQxdLSNcqGS0LgbyEISg_1745233180
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-86da7e4b5baso409849241.1
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233180; x=1745837980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVl17+DIhdQKB5hKQKjqnZV/7Ux7S0MiBzai4RYraAo=;
        b=PvAesTDl3+c9fcjPTCm1tHrBLRXm22/EN97E0ZaNxmMACsNIDeuwQRoF5OU37ioLjU
         kzB5WIWa47a69tJgalm7y9/pJ0qdTmZtYVkJ07+s9nbWjEfiUIaRVKV79A2wwNPcg8wj
         6NUXBukzy0D17Ico4v0wRlY7pzFlQNPIVI2GldTGl9CiFY3R/L2Lyjx6aR146V7imc1M
         tdwJZ2m40LzPnIEc/moBegDzdAbPjHvbGrO6rYwfBrw+yPZC0gB3e9nCBXLg/qKB/1FL
         3fIs0fiP+pw/6Oenjo6pQTz6AxEW00bCtbFfzaeOPI9nqRlp7g4rL1XBIAyAvzACBqSZ
         TOog==
X-Forwarded-Encrypted: i=1; AJvYcCVQuFqu7hLLbztlwPlCEcusT5qB/kEHJa4hjrlMl2yWhlkEKoWDYOJMZYUTQTbehv+6ksnEu9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8oqc9N9UklqZvucte3lO3n2PNo1MnIUmAh7YIFDFrCObzZWd
	ysMQW4tGKg50q7fwZ3239tX0ESuMtvwq6WVgyHwoo8CyH7u/m5O+DgTcJo0CgvEfRMJZpAl+uWZ
	tJwBB1h1j1rg8Mde3IqueZsSUcCfJG6QEuY1/sEa/RkS92msuh3SmAQ==
X-Gm-Gg: ASbGncsOFx+ROu7rvjSCDOK/tH+66xj7l2xs/KqXx6kNd+Yf3pXPDtYZ8YcHiVTJJ/J
	9DdyBxpZP3uTWl0yOZ0y0m45V9id0P2PyEuHENC6ABVLWkZvAMc+oOQ6pMaaowvrZuayBRaDArO
	9N1kknnhSHGalPacy1n9GkM4Ae1LyU1DgXeRZ65BAY+V7nmDu7CAPIBO7Ktkdl8NjzzkpUajC3j
	/9VhSwczjwOjHb7lzJR8gXKfzgLvpTY2kr+49zK/lTNxQhv93IPEyB7oPBn7QRrFZM95aBH3wbT
	BA==
X-Received: by 2002:a05:6122:1791:b0:526:483:95fd with SMTP id 71dfb90a1353d-529255099femr7267945e0c.10.1745233180619;
        Mon, 21 Apr 2025 03:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+Ga+p67ZBPcoJxP2RVNKC3Q+2U8jBxD/W2ry20b9xTbJ0FUlhUWa12DS5U5nxkuEf6T8ikw==
X-Received: by 2002:a05:6122:1791:b0:526:483:95fd with SMTP id 71dfb90a1353d-529255099femr7267938e0c.10.1745233180298;
        Mon, 21 Apr 2025 03:59:40 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922c3a570sm1396339e0c.28.2025.04.21.03.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:59:39 -0700 (PDT)
Date: Mon, 21 Apr 2025 06:59:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/4] vhost: Reintroduce kthread mode support in vhost
Message-ID: <20250421065847-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-3-lulu@redhat.com>
 <CACGkMEtCxn7rZfvo9_nUwC1TwqJ+5F2XDdU89rz=iyO3U0pCEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtCxn7rZfvo9_nUwC1TwqJ+5F2XDdU89rz=iyO3U0pCEQ@mail.gmail.com>

On Mon, Apr 21, 2025 at 11:39:14AM +0800, Jason Wang wrote:
> On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> >
> > This patch reintroduces kthread mode support in vhost,
> > It also introduces struct vhost_worker_ops to abstract
> > worker create/stop/wakeup operations.
> >
> > * Bring back the original vhost_worker() implementation,
> >   and renamed to vhost_run_work_kthread_list().
> >
> > * Add cgroup support for the kthread
> >
> > * Introduce struct vhost_worker_ops:
> >   - Encapsulates create / stop / wake‑up callbacks.
> >   - vhost_worker_create() selects the proper ops according to
> >     inherit_owner.
> >
> > This partially reverts or improves upon:
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 188 ++++++++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h |  12 +++
> >  2 files changed, 182 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 250dc43f1786..be97028a8baf 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/kthread.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/module.h>
> >  #include <linux/sort.h>
> >  #include <linux/sched/mm.h>
> > @@ -242,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
> >                  * test_and_set_bit() implies a memory barrier.
> >                  */
> >                 llist_add(&work->node, &worker->work_list);
> > -               vhost_task_wake(worker->vtsk);
> > +               worker->ops->wakeup(worker);
> >         }
> >  }
> >
> > @@ -388,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >         __vhost_vq_meta_reset(vq);
> >  }
> >
> > +static int vhost_run_work_kthread_list(void *data)
> > +{
> > +       struct vhost_worker *worker = data;
> > +       struct vhost_work *work, *work_next;
> > +       struct vhost_dev *dev = worker->dev;
> > +       struct llist_node *node;
> > +
> > +       kthread_use_mm(dev->mm);
> > +
> > +       for (;;) {
> > +               /* mb paired w/ kthread_stop */
> > +               set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +               if (kthread_should_stop()) {
> > +                       __set_current_state(TASK_RUNNING);
> > +                       break;
> > +               }
> > +               node = llist_del_all(&worker->work_list);
> > +               if (!node)
> > +                       schedule();
> > +
> > +               node = llist_reverse_order(node);
> > +               /* make sure flag is seen after deletion */
> > +               smp_wmb();
> > +               llist_for_each_entry_safe(work, work_next, node, node) {
> > +                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > +                       __set_current_state(TASK_RUNNING);
> > +                       kcov_remote_start_common(worker->kcov_handle);
> > +                       work->fn(work);
> > +                       kcov_remote_stop();
> > +                       cond_resched();
> > +               }
> > +       }
> > +       kthread_unuse_mm(dev->mm);
> > +
> > +       return 0;
> > +}
> > +
> >  static bool vhost_run_work_list(void *data)
> >  {
> >         struct vhost_worker *worker = data;
> > @@ -582,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> >
> > +struct vhost_attach_cgroups_struct {
> > +       struct vhost_work work;
> > +       struct task_struct *owner;
> > +       int ret;
> > +};
> > +
> > +static void vhost_attach_cgroups_work(struct vhost_work *work)
> > +{
> > +       struct vhost_attach_cgroups_struct *s;
> > +
> > +       s = container_of(work, struct vhost_attach_cgroups_struct, work);
> > +       s->ret = cgroup_attach_task_all(s->owner, current);
> > +}
> > +
> > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > +{
> > +       struct vhost_attach_cgroups_struct attach;
> > +       int saved_cnt;
> > +
> > +       attach.owner = current;
> > +
> > +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> > +       vhost_worker_queue(worker, &attach.work);
> > +
> > +       mutex_lock(&worker->mutex);
> > +
> > +       /*
> > +        * Bypass attachment_cnt check in __vhost_worker_flush:
> > +        * Temporarily change it to INT_MAX to bypass the check
> > +        */
> > +       saved_cnt = worker->attachment_cnt;
> > +       worker->attachment_cnt = INT_MAX;
> > +       __vhost_worker_flush(worker);
> > +       worker->attachment_cnt = saved_cnt;
> 
> I wonder if it's easier to re-introduce the flush that was used before
> vhost kthread to avoid the tricks here. We can have flush ops for
> example.
> 
> Thanks

Nah we do not need ops, __vhost_worker_flush is just an internal
function. Refactor it so we can call the part without the check.

-- 
MST


