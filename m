Return-Path: <netdev+bounces-156174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244FA054B7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6567C161318
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3A1AAA29;
	Wed,  8 Jan 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrX8BoMY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58439A59
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322007; cv=none; b=PZnZ5CQxHaVVqOEkuu1sXB+QSqYta7t3zg56MehgdAFuiU4En2JwzkgmUHp6XbOMQkDTRQC4uCzlGuc4ch6WdCMxzzqn+Fx9FEeOItUTVE7mK0d1zhT0v6r3JmnwjwvrNxEWPLir8vELNLaN1fGHUQd+jnPvY1cSni8mYqhXRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322007; c=relaxed/simple;
	bh=kZXl25nfFWRZ156iUqrQf8k8ZQQgE63W71cWuTMebRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPzpXqk6QPVlUN2ePubU3v9ugxdt+pHmn81Kz09Qhj8xhSfiR6St9WxGBozLuxjmK9iU4cqDPcula85hAtcP+UH+i/dvhXFkK/eiJMIeDBPKjxw6ZLJ1UrMlbt3HU0yat0F6VzhtyD2cg8RNVz5/KoKayxj0waCYRqkEe5V4JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrX8BoMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736322004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRiLAMcY80WeK7MajdAzZCvNFuJtwb9jaSJlZhW8/IU=;
	b=GrX8BoMYCQKEYBUCMq9hpTtFS5iOcoa10AATIo0PsgiIw2QWzR2VSkqd6yl1vhyVtuVbVu
	KxTsbNM3hmfRXfDmAOQON0Hwthp+gEQarukYhKykUlnROxBVBu0OLL+3fKs9vTqupxbvEp
	d4l9MXL2ibFE8xHKsAjN7tQ1wENIGXk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-KNVksJ94MUGnba13z36v1w-1; Wed, 08 Jan 2025 02:40:02 -0500
X-MC-Unique: KNVksJ94MUGnba13z36v1w-1
X-Mimecast-MFC-AGG-ID: KNVksJ94MUGnba13z36v1w
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so24374829a91.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 23:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736322001; x=1736926801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRiLAMcY80WeK7MajdAzZCvNFuJtwb9jaSJlZhW8/IU=;
        b=d6/y6epYYFFBwZUMCA45U0UJK3YuoXGJA2v5ZdeyF8+U0qzBQtiLaE8DzMljk1XKlq
         R9sE+wtiUJKcN+Yvpu1Bm3GHlJAbsDHrSYKA2OlLd9Gvn0zJGtjvfJuEvt0O+kyteP8G
         jvPxx/o+PneWMqubjAIdGDYBJa0+6hJrGsxX2qt0uh61cqGOCHSziWs73BqYtpavtEnY
         U3sd6zB+y2vPQzkxC7L34XosyKoITh48a/ka9L2/jUNCU5redgtxbLeOBNG7xYwoJAjG
         6zC5Y0WAN8ULB2Nkq8wmSOK+4ieAoN8yN0ws4IjfxtfJ3BuFhomewvxsg697C13FLTct
         aIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/94na3vX4W91wa4I6Y6so0xrb8vojnjkHN7vsPYgztSgBVjwZYWgpEvsXTsemGdu9ExioYcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZwG4KiQw+Y1vHvmVaViFigbx4dq7rthapwi5hgTmc52w3R5l
	XLsgevmjSpXWM6iYWJpS5PyPJgTthJpw6wkwdeaMh3QxtXiVGAma58E/EwoGq7N52/nKHQ/CY4i
	JnQUhkjwuJ6p57C8Ln8sP3gdM7MjxLCxHIzgtQ/AsAJbDdKIsOXlyV7Q+nNWdyVC6xe7Bk/PD6f
	Ok5j//wF10jNI3/uPTQhHrigAi8IyR
X-Gm-Gg: ASbGncuPhkgt22NptmvnoPOq+sgDmsLjy5zfQAIwovrMk9RpjAfpHZ7f2R02CNZOvZz
	4+Uc9KCFeWu+5auCB0cFnefDELomLrCMONh+xrEo=
X-Received: by 2002:a05:6a00:2908:b0:728:e745:23d8 with SMTP id d2e1a72fcca58-72d21ffab83mr3083092b3a.24.1736322001682;
        Tue, 07 Jan 2025 23:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdnsUUHo4MoHt26TfNW7e8VJxNZZsJ/umVVZ2UoiKS3JeJ5xt0Act67i2nSAwnjqlqptLKLf9nz7CUvhNbJoo=
X-Received: by 2002:a05:6a00:2908:b0:728:e745:23d8 with SMTP id
 d2e1a72fcca58-72d21ffab83mr3083065b3a.24.1736322001229; Tue, 07 Jan 2025
 23:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-4-lulu@redhat.com>
 <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com> <CACLfguWQ6q1wmKi5anF=2ofbDzWaTjgY27T9WO_Xtyh3FkVDYg@mail.gmail.com>
In-Reply-To: <CACLfguWQ6q1wmKi5anF=2ofbDzWaTjgY27T9WO_Xtyh3FkVDYg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jan 2025 15:39:50 +0800
X-Gm-Features: AbW1kvZ3XdY5-P2kwC3YoDfIq6i9PSM0nU40ETthuxPqRIN4fuKVjfX9nYolz0k
Message-ID: <CACGkMEuGLDmYq6igW3U6dKGd0WYmtQgzNu6C02ae5ZRP0_Nq+w@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 10:57=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Thu, Jan 2, 2025 at 11:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Reintroduce the previously removed functions vhost_attach_cgroups_wor=
k()
> > > and vhost_attach_cgroups() to support kthread mode. Rename
> > > vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
> > > the implementation of the old function vhost_dev_flush() in this
> > > new function.
> > >
> > > These function was removed in
> > > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 1feba29abf95..812dfd218bc2 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/kthread.h>
> > > +#include <linux/cgroup.h>
> > >  #include <linux/module.h>
> > >  #include <linux/sort.h>
> > >  #include <linux/sched/mm.h>
> > > @@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev=
)
> > >  }
> > >  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> > >
> > > +struct vhost_attach_cgroups_struct {
> > > +       struct vhost_work work;
> > > +       struct task_struct *owner;
> > > +       int ret;
> > > +};
> > > +
> > > +static void vhost_attach_cgroups_work(struct vhost_work *work)
> > > +{
> > > +       struct vhost_attach_cgroups_struct *s;
> > > +
> > > +       s =3D container_of(work, struct vhost_attach_cgroups_struct, =
work);
> > > +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> > > +}
> > > +
> > > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > > +{
> > > +       struct vhost_flush_struct flush;
> > > +       struct vhost_attach_cgroups_struct attach;
> > > +
> > > +       attach.owner =3D current;
> > > +
> > > +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> > > +       vhost_worker_queue(worker, &attach.work);
> > > +
> > > +       init_completion(&flush.wait_event);
> > > +       vhost_work_init(&flush.work, vhost_flush_work);
> > > +       vhost_worker_queue(worker, &flush.work);
> > > +       wait_for_completion(&flush.wait_event);
> > > +
> > > +       return attach.ret;
> > > +}
> >
> > This seems to be inconsistent with what you said above which is
> >
> > """
> > > These function was removed in
> > > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > """
> >
> > As 6e890c5d5021 had:
> >
> > static int vhost_attach_cgroups(struct vhost_dev *dev)
> > {
> >         struct vhost_attach_cgroups_struct attach;
> >
> >         attach.owner =3D current;
> >         vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> >         vhost_work_queue(dev, &attach.work);
> >         vhost_dev_flush(dev);
> >         return attach.ret;
> > }
> >
> > It seems current vhost_dev_flush() will still work or the open coding
> > of the flush logic needs to be explained.
> >
> > Thanks
> >
> the current vhost_dev_flush was changed to support xarray, So it does
> not work here , I will add more information here

Any reason it can't work here?

Thanks

> Thanks
> cindy
> > > +
> > >  /* Caller should have device mutex */
> > >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> > >  {
> > > --
> > > 2.45.0
> > >
> >
>


