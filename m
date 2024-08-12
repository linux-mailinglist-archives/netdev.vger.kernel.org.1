Return-Path: <netdev+bounces-117597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810494E724
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF2B239DA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BE152790;
	Mon, 12 Aug 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc2i8VZT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1014F9E1
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445420; cv=none; b=CbJa7fAggJqK0BhICqLzP5YXUcDU5ZV4Xde7rovNPCrcd4Uw3mIsXaRtNVFWb2+U7dhc0XsIopbilSZOkxTqj312q8zg6iUObYIpuqWJSjK6doScL0hlPlTwyEDjV6byO9g5bv45QBZJqXLnwkCVXw4MEsIXfvDMMv8plIusTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445420; c=relaxed/simple;
	bh=W0eY8Xq3o3fHaz8bN7dG7yytV8UUgXdPUr5ycR0qiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpT3/WERheYpGEgza68WInHA97Mk1JYMxVxJZhDIz0orJQQGYw1FvJOzATjPfeHM6Chl+fNYYAIYI1pj0lu29dKXP+lgvcdqskTOK8tmwlIRlsRbWjMe4x3/73pwziGUudYbQjWC8lkI7TYRmzfzOmgjsmMJm0n88rORQcITljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc2i8VZT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723445417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD7Wwk8kOu+4mm0l1d/x7a1qMGGKB1sRxp0z9/NXgwQ=;
	b=bc2i8VZTzWTSNYzgJsdsARXrC3aXeMSqeq4rM6XM/44pUdzor5LOHRngETERrFvSXf4w/f
	3Sm59XI3SHTs6oAXGsXoeAzly4IeABQPWTaCTVU3IQ8rSTtfEUe9BEb7hbaNkitZpNhgOb
	5EXnXCOm2ifJlSjsH7lIO0wPrA5Ck48=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-hIaVft-FMYCU9ke5RIwgHg-1; Mon, 12 Aug 2024 02:50:09 -0400
X-MC-Unique: hIaVft-FMYCU9ke5RIwgHg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cfe41af75eso5516200a91.2
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 23:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445408; x=1724050208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD7Wwk8kOu+4mm0l1d/x7a1qMGGKB1sRxp0z9/NXgwQ=;
        b=nz5H5MUW++AvLagx48dhYcbbUdipIGrq/N9NLk2sxTvi/Q7wgo5oA4yH9Y5XbfZ5DV
         Ie6B/zZbR2Bguuypf8xk+O8fn87GgeVFuKePa+kKd2cl3pDGSO1J93gmwXDPYoysnIT9
         SU4B2AA+opgByWmJVqRNYbBw8qS4fbq+quXBhURPj1PqjEuFY0DTmQcmcMpa10j1SXPa
         BrSiRKyeq2hYiBEL5PW5McxoV3qMl6ow4eKb3aJsVGEb4FPxfIH5eS5ERsjgAicnKcwZ
         5kqyJjFDO+wWkRHr/iX+b3N0URoot/lGydtDlwhVfPl4t2AoqsZKwZUtUX7d2RdQVB3P
         JZAA==
X-Forwarded-Encrypted: i=1; AJvYcCXxwRHAXffLXiLDKGmS8Coduu9+UDdv15iZJGU+1TzjYAf2T6x2eSQM8Qh6bMvOkU2KGbPRQ1WEU9QwuaXXNeEqb4tu8JzU
X-Gm-Message-State: AOJu0YwxQR542NSenfavItZnvKkV+pkgEHWWR0fVCQCTEOPL11VS9ss1
	6XfEP/rCr2SR634irkJnUR3bkfEJMJ+UtJTP8sq0bdShV47nqUHeoW4Rb2M2EiEycs6n7TVxh/a
	9cozjdKO4+V2qKSBstlZXIWjK2EZRBm6whNic5IfrYJQ0d6N5s+gtRjoHJDZyPIKlBgcdQS4ecj
	TpVI2DyxCsBRP++O7n6dJ/h63qXVdB
X-Received: by 2002:a17:90b:207:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2d1e80535d9mr10033992a91.34.1723445408336;
        Sun, 11 Aug 2024 23:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLGdwLYNX0VkuJKSx7I3Z1IUqAOr4ykW1cwWLQquNN9Af/9UdiPhu4hOno89xx+1HV9TCUE70bE5DOF3ax+PY=
X-Received: by 2002:a17:90b:207:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2d1e80535d9mr10033967a91.34.1723445407662; Sun, 11 Aug 2024
 23:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
 <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
In-Reply-To: <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 14:49:56 +0800
Message-ID: <CACGkMEvAVM+KLpq7=+m8q1Wajs_FSSfftRGE+HN16OrFhqX=ow@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:47=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
> >
> >
> >
> > On 08.08.24 10:20, Jason Wang wrote:
> > > We used to call irq_bypass_unregister_producer() in
> > > vhost_vdpa_setup_vq_irq() which is problematic as we don't know if th=
e
> > > token pointer is still valid or not.
> > >
> > > Actually, we use the eventfd_ctx as the token so the life cycle of th=
e
> > > token should be bound to the VHOST_SET_VRING_CALL instead of
> > > vhost_vdpa_setup_vq_irq() which could be called by set_status().
> > >
> > > Fixing this by setting up  irq bypass producer's token when handling
> > > VHOST_SET_VRING_CALL and un-registering the producer before calling
> > > vhost_vring_ioctl() to prevent a possible use after free as eventfd
> > > could have been released in vhost_vring_ioctl().
> > >
> > > Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_v=
dpa")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Note for Dragos: Please check whether this fixes your issue. I
> > > slightly test it with vp_vdpa in L2.
> > > ---
> > >  drivers/vhost/vdpa.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index e31ec9ebc4ce..388226a48bcc 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost=
_vdpa *v, u16 qid)
> > >       if (irq < 0)
> > >               return;
> > >
> > > -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> > >       if (!vq->call_ctx.ctx)
> > >               return;
> > >
> > > -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> > >       vq->call_ctx.producer.irq =3D irq;
> > >       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer);
> > >       if (unlikely(ret))
> > > @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_=
vdpa *v, unsigned int cmd,
> > >                       vq->last_avail_idx =3D vq_state.split.avail_ind=
ex;
> > >               }
> > >               break;
> > > +     case VHOST_SET_VRING_CALL:
> > > +             if (vq->call_ctx.ctx) {
> > > +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> > > +                     vq->call_ctx.producer.token =3D NULL;
> > > +             }
> > > +             break;
> > >       }
> > >
> > >       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> > > @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost=
_vdpa *v, unsigned int cmd,
> > >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> > >                       cb.private =3D vq;
> > >                       cb.trigger =3D vq->call_ctx.ctx;
> > > +                     vq->call_ctx.producer.token =3D vq->call_ctx.ct=
x;
> > > +                     vhost_vdpa_setup_vq_irq(v, idx);
> > >               } else {
> > >                       cb.callback =3D NULL;
> > >                       cb.private =3D NULL;
> > >                       cb.trigger =3D NULL;
> > >               }
> > >               ops->set_vq_cb(vdpa, idx, &cb);
> > > -             vhost_vdpa_setup_vq_irq(v, idx);
> > >               break;
> > >
> > >       case VHOST_SET_VRING_NUM:
> > > @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode,=
 struct file *filep)
> > >       for (i =3D 0; i < nvqs; i++) {
> > >               vqs[i] =3D &v->vqs[i];
> > >               vqs[i]->handle_kick =3D handle_vq_kick;
> > > +             vqs[i]->call_ctx.ctx =3D NULL;
> > >       }
> > >       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> > >                      vhost_vdpa_process_iotlb_msg);
> >
> > No more crashes, but now getting a lot of:
> >  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) regis=
tration fails, ret =3D  -16
> >
> > ... seems like the irq_bypass_unregister_producer() that was removed
> > might still be needed somewhere?
>
> Probably, but I didn't see this when testing vp_vdpa.
>
> When did you meet those warnings? Is it during the boot or migration?

Btw, it would be helpful to check if mlx5_get_vq_irq() works
correctly. I believe it should return an error if the virtqueue
interrupt is not allocated. After a glance at the code, it seems not
straightforward to me.

Thanks

>
> Thanks
>
> >
> > Thanks,
> > Dragos
> >
> >


