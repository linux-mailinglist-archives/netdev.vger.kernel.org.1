Return-Path: <netdev+bounces-156144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEBEA05144
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FE51653FF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427B198A17;
	Wed,  8 Jan 2025 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVj+Ihp5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA719309C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305064; cv=none; b=lPpp1xo7M6v4Ml4LJ3Fs6cIsmKWUv43iUizza1k3LzHparA63yfExW+kxudjn7v5LSkCcoyYRJEanoWN8Y8NnNRbNjdsrsx74q17EXtUak+e2rFE/OASZTxNQhtHnLUVNkd1ourgLmP0NlqlH8ieJ6bXgfGUDeY087tbjrPTvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305064; c=relaxed/simple;
	bh=sHvuZIdbeJegOmhd71Ge7UzOuAL01BQvI6jcWgi4ktk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihsEZ8eu/hls7wTBSncMK5nzv2tqXn+xAKkfgRo8aOC3kGSLn1rJmyxdRTuxftk2GqhA8GaYnV2MxTE4Rpum5m7W4ly9nLw1ZHSDZkPEcOf/U0QbQEK1pAfCldyuSYKpfgaMO9hUkIpLd/+H/pnh3BoP13s0K6LB1SaCUK8esrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVj+Ihp5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736305062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cnOHVG02IznAe7LlU1y6kbZH/WfJVV7zpJZ7lUn+8I=;
	b=WVj+Ihp5W186a43icz47PBzDBgPuagdceK/tq17T8sWB+lC9bSZ1XjHaH+0/obNe/WoYTo
	zYvexEZbu0S/pbnGuUgpTuNFsaF6PL0n+iG28efwrEwC9VMBoRGER45Qj4Hj2yzQn320Cu
	RdrXRmd11iNqwVcW0yMtHir1imRHqTA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-DfSLTHWTO72pD5UdXAafuQ-1; Tue, 07 Jan 2025 21:57:40 -0500
X-MC-Unique: DfSLTHWTO72pD5UdXAafuQ-1
X-Mimecast-MFC-AGG-ID: DfSLTHWTO72pD5UdXAafuQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aafc90962ffso373389966b.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 18:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305059; x=1736909859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cnOHVG02IznAe7LlU1y6kbZH/WfJVV7zpJZ7lUn+8I=;
        b=rLsY8fvWlqKMdkxfKm4wjuM3qwfSKduMbUJY9WIJGe/nEq39+XetU4o2FyV5iIZ0t1
         ar4T+8Lzl8DLEIhv7eveyo/R38SCAtm8R2CgA8RgFZnCX74UjLIRnsRHbOgRJz9TmpQM
         5P72MJ01/Gpb5FB90jQMZU7O7lJUnJaCAikHuE9M5yZgXLyaqniHCvuasjQJ/34TuZyE
         +rYFk/T6gqdSKkM70W/c8lRdDXaYtQa3bCcpd5FALrkObpDEJymWXF/VRqiX+xfFW+E3
         y6Gzt/YTwvPOaOioOmj6D+gIVRTTaG3+YUl0oOVQqC6XXduFmOZGQe8h+3XFQv/wcC3y
         XARw==
X-Forwarded-Encrypted: i=1; AJvYcCWXrOllg4/pvOQPj/NmZnRQNlamd/g8Sp8AzVrHkNga3+M+RF8rtFj+v6WC1bt94VDNupcAWpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgeuKthWfLhaAPKsyKOxB6OMdR+yc97sYvgV/k+4UygdQVy7r
	4dClRblmPAHDidwfGojKIqMrM2k8Z/6oyPl5ATLqRBWqSOxwIIzy6sQGH10p8lVRHKOqkdsiPj0
	KGDpbNi30R8o/kl2fTArPvZ/p/Zq6GjOyn5ptoMcrSxzBc+WR3X+4qnctVOhoDK9PG+om+TW56d
	5OQT7Map6SmZDUt7bCeuaZc526m/bX
X-Gm-Gg: ASbGnctbyRDmNwShs2QdR9DFJVP0nLfdWF/7cxEj4KynjwpD+kC2D6w8YcI6OVBQXPJ
	S19v1fi7TmaCm0KZPSF928Ypd3CHW3Jy+EiXUhFw=
X-Received: by 2002:a17:907:3e02:b0:aaf:ab6f:da49 with SMTP id a640c23a62f3a-ab2abc918cbmr76970766b.39.1736305059676;
        Tue, 07 Jan 2025 18:57:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqCuzRuABNRCXnnbuc+CQ5gQPv1i8FaV+q0mVz5zA94KQZADBZrJH8FkV7qGXqFBThQ4qqRUDX6I8J60CrLyc=
X-Received: by 2002:a17:907:3e02:b0:aaf:ab6f:da49 with SMTP id
 a640c23a62f3a-ab2abc918cbmr76969666b.39.1736305059388; Tue, 07 Jan 2025
 18:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-4-lulu@redhat.com>
 <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com>
In-Reply-To: <CACGkMEu29fZxNoyLOytScwFqFSFP+o3-ETSgG8u4Kgq_yEt6Gw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Jan 2025 10:57:01 +0800
X-Gm-Features: AbW1kvaikX7u2IKF2_-xCzowI1S4aMKft9ae65Nw2XLy-bJsC-qZ2LImiVUZODk
Message-ID: <CACLfguWQ6q1wmKi5anF=2ofbDzWaTjgY27T9WO_Xtyh3FkVDYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vhost: Add the cgroup related function
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Reintroduce the previously removed functions vhost_attach_cgroups_work(=
)
> > and vhost_attach_cgroups() to support kthread mode. Rename
> > vhost_attach_cgroups() to vhost_attach_task_to_cgroups(), and include
> > the implementation of the old function vhost_dev_flush() in this
> > new function.
> >
> > These function was removed in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 1feba29abf95..812dfd218bc2 100644
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
> > @@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
> > +       s =3D container_of(work, struct vhost_attach_cgroups_struct, wo=
rk);
> > +       s->ret =3D cgroup_attach_task_all(s->owner, current);
> > +}
> > +
> > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > +{
> > +       struct vhost_flush_struct flush;
> > +       struct vhost_attach_cgroups_struct attach;
> > +
> > +       attach.owner =3D current;
> > +
> > +       vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> > +       vhost_worker_queue(worker, &attach.work);
> > +
> > +       init_completion(&flush.wait_event);
> > +       vhost_work_init(&flush.work, vhost_flush_work);
> > +       vhost_worker_queue(worker, &flush.work);
> > +       wait_for_completion(&flush.wait_event);
> > +
> > +       return attach.ret;
> > +}
>
> This seems to be inconsistent with what you said above which is
>
> """
> > These function was removed in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> """
>
> As 6e890c5d5021 had:
>
> static int vhost_attach_cgroups(struct vhost_dev *dev)
> {
>         struct vhost_attach_cgroups_struct attach;
>
>         attach.owner =3D current;
>         vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>         vhost_work_queue(dev, &attach.work);
>         vhost_dev_flush(dev);
>         return attach.ret;
> }
>
> It seems current vhost_dev_flush() will still work or the open coding
> of the flush logic needs to be explained.
>
> Thanks
>
the current vhost_dev_flush was changed to support xarray, So it does
not work here , I will add more information here
Thanks
cindy
> > +
> >  /* Caller should have device mutex */
> >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> >  {
> > --
> > 2.45.0
> >
>


