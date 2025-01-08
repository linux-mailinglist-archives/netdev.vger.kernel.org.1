Return-Path: <netdev+bounces-156145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1CA05165
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 04:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F8A3A93AC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A11ACEB7;
	Wed,  8 Jan 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDD6O45W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864839FF3
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305222; cv=none; b=gjazdht6uoepTUgGtMnG66D31yMGjyB2sabv2jtb/B/3vViHTKvxij/gcFz/Z86l+JkxLOTbeyaSsBlQt5+rO+8Q7D8UIkTdQ1DNfCVEzNQHg7x1svhDD1I7jh13CS8TfwjzDFoVIjXOGAUaBgGlk/4CDaOHk06KzFbRbZo3BWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305222; c=relaxed/simple;
	bh=Dciqjvlx2H/R6YN5xtBjgCX46H21JuTpbwkAJGiEdAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYP5lYffIYHxh8Z/C1yBYQNUHmPHhydjf4XkmuIgd/JfOdRJNEQ2sUtrIYIIJ5qiSlqumvWLiii6NLVEB1rtzBdS5v0wRB30Ab2rvMLfFh+1dOYGlNzcsIcq+zmH76vZ0F+1P+KGkW6wDZvv7z86iKyKr5we4SjAWbZsYnxYR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDD6O45W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736305216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V79OcuD49cIJZohEbmJe69JuNmGmHHtDUlNMPt0oqHY=;
	b=SDD6O45WSgsYvubW04ZNXJOuq9XtfBCojBn/E1mX2og6UFhCeYkm1HyAC8pVyGsaW8fbGC
	LhRv9sowh/bjeIwZI81f4DUHzymBzwHIu8SnhwNc5nvSWBu2/JKE3EnMgf7dRaAtwPyA0B
	1mVt130Y+Cxg7MY8injVhDDV7xJ+tsA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-iSks6eyPOpur6EArQUUYMQ-1; Tue, 07 Jan 2025 22:00:15 -0500
X-MC-Unique: iSks6eyPOpur6EArQUUYMQ-1
X-Mimecast-MFC-AGG-ID: iSks6eyPOpur6EArQUUYMQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aafc90962ffso373535966b.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 19:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305214; x=1736910014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V79OcuD49cIJZohEbmJe69JuNmGmHHtDUlNMPt0oqHY=;
        b=XTJKQPa3/OoIbXECpEAnU2ZNJe/txaq9aiPeFl4vaXFUfLWVpFjHSsfjjm0NgCDoAo
         hj6k0WlO9hHU0Q26CXGh9UhjZMdk2MAL51FZ/q67VSFG+avatCbY1KcVsHA36X0GoFKM
         Au+21t+++Z1KK2VOhwr5uCVApQEKDf91ZB1UB0V0maUDfJqYx31euS746wboFkcXdak2
         iaPC34XZmPDQbQu48X/6fmQBMQN8QhM1+3u4RHWVkxpqQuEbhkk7D79EvtDXkckBfaYr
         2HhX8qtDb6SqQabzKjhWI5slUoH/I1DK2mY+Dtm7PW6wnDoymMAO7DFcmPEz6s27EPAp
         0zNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDxg8hjCTBIvcqNqHwcaDtewFYl6L167v02kvdb32JK/7IpZkFAFxeK1btkPCO/DGJehNtpcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TfkPTdET/KNX1QaLSk8IF7+1/wwgOJsQXjxhekS587n5Xy2r
	Mnx/rKziipDlT5/0ldxGJR8aYjkTlT4MYX7+ahpev1+uSIdJRkqXs/3YdhvaUhFuLSpBeMjNQoU
	KlNHix9xPyGcMht+giJ4S8LTyLUKsEbVgQcVmy69/Sh7SoR5pnGHJR1RFgNobsXclbhKi3zaGB7
	5TTQt+M1h4vun5z3dZiAdH0QgemKqmywdaFICi
X-Gm-Gg: ASbGnctk2wDT2f7oaJtS494eAjhBXqw64qk7uHixsc7nwhYpn+zCgwEWsCP4rZurwIx
	m5lcvflMpqYHNE7cQpv0DmjZif8mO5tqjfRgjf/w=
X-Received: by 2002:a17:907:3da8:b0:aae:ce4c:ca40 with SMTP id a640c23a62f3a-ab2ab740698mr70740966b.32.1736305214140;
        Tue, 07 Jan 2025 19:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgP52S4qE/N+6vyL1S81I9hJPIsqy66nodr1Pp2Y+yokSkk63j2GOn+8boM7mJWTzOpreQfQRZbVEpr6TCCdE=
X-Received: by 2002:a17:907:3da8:b0:aae:ce4c:ca40 with SMTP id
 a640c23a62f3a-ab2ab740698mr70739566b.32.1736305213805; Tue, 07 Jan 2025
 19:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-3-lulu@redhat.com>
 <CACGkMEuA_O5bgwLNz47sWJTQGqqOvq==_vNnhqrH-eGtbg-Fuw@mail.gmail.com>
In-Reply-To: <CACGkMEuA_O5bgwLNz47sWJTQGqqOvq==_vNnhqrH-eGtbg-Fuw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Jan 2025 10:59:37 +0800
X-Gm-Features: AbW1kvbzKsocE9MoY2y3BpGkLVoAP0F5ST9KJOD7MBCiRYxaH_6OoiW7WzjZjUo
Message-ID: <CACLfguVFHV2HZoAzOfpSvYZL0a3ehGqnJiwnnZqjctDGYAxDPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] vhost: Add the vhost_worker to support kthread
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:19=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the previously removed function vhost_worker() back to support the
> > kthread and rename it to vhost_run_work_kthread_list.
> >
> > The old function vhost_worker() was changed to support tasks in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > and to support multiple workers per device using xarray in
> > commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
).
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> I think we need to tweak the title as this patch just brings back the
> kthread worker?
>
> Other than that,
>
sure will do
Thanks
cindy
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index eaddbd39c29b..1feba29abf95 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >         __vhost_vq_meta_reset(vq);
> >  }
> >
> > +static int vhost_run_work_kthread_list(void *data)
> > +{
> > +       struct vhost_worker *worker =3D data;
> > +       struct vhost_work *work, *work_next;
> > +       struct vhost_dev *dev =3D worker->dev;
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
> > +               node =3D llist_del_all(&worker->work_list);
> > +               if (!node)
> > +                       schedule();
> > +
> > +               node =3D llist_reverse_order(node);
> > +               /* make sure flag is seen after deletion */
> > +               smp_wmb();
> > +               llist_for_each_entry_safe(work, work_next, node, node) =
{
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
> >         struct vhost_worker *worker =3D data;
> > --
> > 2.45.0
> >
>


