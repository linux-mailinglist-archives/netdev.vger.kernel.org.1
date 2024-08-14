Return-Path: <netdev+bounces-118322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812719513E6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29D31C23529
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66D6F2FA;
	Wed, 14 Aug 2024 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlNnOAEF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAA433BD
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613377; cv=none; b=o7idy5wJAgybgGmKZkkjy8jorhVrY9vm0RX8HN+BBHf4Y9bwFADw3w3FENYNCf8urn+yz95T/OebpXEw2926epokO8T/Lpb1i5b8jl4xCqrk7fOIpQloF/LXbZOUFOzqrMxwoRZUnsi477Lvrc118LD9DC2+dcIiPCcFn2WX1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613377; c=relaxed/simple;
	bh=64CaOyzQDHd2TXA0O3hUFSnHfkbGMDRj8vJIgxCNCEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyNcLuEIxXHvLP2Ttb3mMAlyRe5FzpGbApEYdCN3VwXJeiYRpSsipxU/VHtqi+IzncBgvHZdvsn/x8LUnn8vnPWZNPbbPazjNdXZb+BvVcoMOWvinCZR86OPUy0t8iare36PdOzkEklfGWWPoYqRcmYKLXShUuL7rWl9qOG5C6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlNnOAEF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723613374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIlEfnFgmvlSdoONYnRaRyMO1JuqrT5E8kZFF0GMenY=;
	b=IlNnOAEFahmkIe/GmT/1AOCqug1RrNOhvDEdl4ETVA9JNPHBuX+340BIDzQY6S5SorCx4O
	0mX/ptXCvYFyc9peFv5zXZy3QktJZThjIYP4ACfF478dj6MAAiNi9RQp+2Nerjic0ZUs0Z
	01ZDzELOHrj9HX6vCJeDFad23etDvyc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Uf7Oq7d9N8eE6GDjSwipPQ-1; Wed, 14 Aug 2024 01:29:31 -0400
X-MC-Unique: Uf7Oq7d9N8eE6GDjSwipPQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb4bcd9671so7867660a91.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 22:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613370; x=1724218170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIlEfnFgmvlSdoONYnRaRyMO1JuqrT5E8kZFF0GMenY=;
        b=OJaG0r3D2V3IAtlYgJ4IKpyTNaWsqYiYqDZBOe0x9EcRw2lCsuY27BaQG3Lq461eo+
         WeAimo1sVMrEhEQx72x6Wmjwo6ZJHCMBC1utC3+tiYb51h8fpw/GIEvrLMPWZD8e0aUJ
         wVKn1Syh203RtyFYv5IMlRfdiGBfslRf7SjOkyCnVarkrI4RZJBqsWnx2G/7nM2lvhMd
         6t8Tgzf2VZUVGLyTJcXqFbZJsc/wURHDptjAm49mxA91r91tBZPiDrbuS3A6lIe2nIXh
         DaOoKDpaksnGHx88qFaT+vD7uxsJGQ10WWIY2lW8cvDvSB5VzdsxZ8PrExUY/Rw1mfJB
         MBRw==
X-Forwarded-Encrypted: i=1; AJvYcCUiRzCTQ7KRcUL6nSic8LrYcu9+xSh4CkYodM1QzZzBBO0U6rlHFebXbJr5yt3pu37B//TC2hyZEN1f55d/RTefNo7Ykzwb
X-Gm-Message-State: AOJu0YyciCUv3E2Ma7qN40G78tYw9tzSDUbGvZukk0rWQ5RU4yYxpMFN
	4EUSfM3rZeMflJlNVYc1iMi1cDhLkxtK3ZwbAfwq72o4NiU92gPgYqw7Yifv6j5c1R6IatCnjsO
	UgEPUcH0xDCGRosf4jHxON/7SisWK6mfQkCTx77a2kxypv4rd/99pz3J4Dh7wdLgHuqbp0Oq4di
	fo4jMqCMeuwFztf5nmB8V9COqbWKXR
X-Received: by 2002:a17:90a:3001:b0:2cb:3748:f5ce with SMTP id 98e67ed59e1d1-2d3aaa98514mr2155551a91.10.1723613370178;
        Tue, 13 Aug 2024 22:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa6fh1ig63jwprIC69ajFU+IdfDGPo7t7ub4vJrtt7Cvu2Oi2Xr3vNgt/E3WjC/otzyr/9sTrf/uIMgyCAACg=
X-Received: by 2002:a17:90a:3001:b0:2cb:3748:f5ce with SMTP id
 98e67ed59e1d1-2d3aaa98514mr2155531a91.10.1723613369590; Tue, 13 Aug 2024
 22:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
 <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
 <CACGkMEvAVM+KLpq7=+m8q1Wajs_FSSfftRGE+HN16OrFhqX=ow@mail.gmail.com>
 <ede5a20f-0314-4281-9100-89a265ff6411@nvidia.com> <CACGkMEtVMq83rK9ykrN3OvGDYKg6L1Jnpa2wsnfDEbswpcnM1g@mail.gmail.com>
 <b4c144f8-5941-4bca-afdb-5feeb23b14c1@nvidia.com>
In-Reply-To: <b4c144f8-5941-4bca-afdb-5feeb23b14c1@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Aug 2024 13:29:18 +0800
Message-ID: <CACGkMEs2Sr_uEd+7Ry1e5MOcD5eKuSeCzHDLRodD0RbuweJ0qA@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:53=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 13.08.24 08:26, Jason Wang wrote:
> > On Mon, Aug 12, 2024 at 7:22=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >>
> >>
> >>
> >> On 12.08.24 08:49, Jason Wang wrote:
> >>> On Mon, Aug 12, 2024 at 1:47=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>>
> >>>> On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 08.08.24 10:20, Jason Wang wrote:
> >>>>>> We used to call irq_bypass_unregister_producer() in
> >>>>>> vhost_vdpa_setup_vq_irq() which is problematic as we don't know if=
 the
> >>>>>> token pointer is still valid or not.
> >>>>>>
> >>>>>> Actually, we use the eventfd_ctx as the token so the life cycle of=
 the
> >>>>>> token should be bound to the VHOST_SET_VRING_CALL instead of
> >>>>>> vhost_vdpa_setup_vq_irq() which could be called by set_status().
> >>>>>>
> >>>>>> Fixing this by setting up  irq bypass producer's token when handli=
ng
> >>>>>> VHOST_SET_VRING_CALL and un-registering the producer before callin=
g
> >>>>>> vhost_vring_ioctl() to prevent a possible use after free as eventf=
d
> >>>>>> could have been released in vhost_vring_ioctl().
> >>>>>>
> >>>>>> Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhos=
t_vdpa")
> >>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>> ---
> >>>>>> Note for Dragos: Please check whether this fixes your issue. I
> >>>>>> slightly test it with vp_vdpa in L2.
> >>>>>> ---
> >>>>>>  drivers/vhost/vdpa.c | 12 +++++++++---
> >>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>>>> index e31ec9ebc4ce..388226a48bcc 100644
> >>>>>> --- a/drivers/vhost/vdpa.c
> >>>>>> +++ b/drivers/vhost/vdpa.c
> >>>>>> @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vh=
ost_vdpa *v, u16 qid)
> >>>>>>       if (irq < 0)
> >>>>>>               return;
> >>>>>>
> >>>>>> -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> >>>>>>       if (!vq->call_ctx.ctx)
> >>>>>>               return;
> >>>>>>
> >>>>>> -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> >>>>>>       vq->call_ctx.producer.irq =3D irq;
> >>>>>>       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer)=
;
> >>>>>>       if (unlikely(ret))
> >>>>>> @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vho=
st_vdpa *v, unsigned int cmd,
> >>>>>>                       vq->last_avail_idx =3D vq_state.split.avail_=
index;
> >>>>>>               }
> >>>>>>               break;
> >>>>>> +     case VHOST_SET_VRING_CALL:
> >>>>>> +             if (vq->call_ctx.ctx) {
> >>>>>> +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> >>>>>> +                     vq->call_ctx.producer.token =3D NULL;
> >>>>>> +             }
> >>>>>> +             break;
> >>>>>>       }
> >>>>>>
> >>>>>>       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> >>>>>> @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vh=
ost_vdpa *v, unsigned int cmd,
> >>>>>>                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> >>>>>>                       cb.private =3D vq;
> >>>>>>                       cb.trigger =3D vq->call_ctx.ctx;
> >>>>>> +                     vq->call_ctx.producer.token =3D vq->call_ctx=
.ctx;
> >>>>>> +                     vhost_vdpa_setup_vq_irq(v, idx);
> >>>>>>               } else {
> >>>>>>                       cb.callback =3D NULL;
> >>>>>>                       cb.private =3D NULL;
> >>>>>>                       cb.trigger =3D NULL;
> >>>>>>               }
> >>>>>>               ops->set_vq_cb(vdpa, idx, &cb);
> >>>>>> -             vhost_vdpa_setup_vq_irq(v, idx);
> >>>>>>               break;
> >>>>>>
> >>>>>>       case VHOST_SET_VRING_NUM:
> >>>>>> @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *ino=
de, struct file *filep)
> >>>>>>       for (i =3D 0; i < nvqs; i++) {
> >>>>>>               vqs[i] =3D &v->vqs[i];
> >>>>>>               vqs[i]->handle_kick =3D handle_vq_kick;
> >>>>>> +             vqs[i]->call_ctx.ctx =3D NULL;
> >>>>>>       }
> >>>>>>       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> >>>>>>                      vhost_vdpa_process_iotlb_msg);
> >>>>>
> >>>>> No more crashes, but now getting a lot of:
> >>>>>  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) r=
egistration fails, ret =3D  -16
> >>>>>
> >>>>> ... seems like the irq_bypass_unregister_producer() that was remove=
d
> >>>>> might still be needed somewhere?
> >>>>
> >> My statement above was not quite correct. The error comes from the
> >> VQ irq being registered twice:
> >>
> >> 1) VHOST_SET_VRING_CALL ioctl gets called for vq 0. VQ irq is unregist=
ered
> >>    (vhost_vdpa_unsetup_vq_irq() and re-registered (vhost_vdpa_setup_vq=
_irq())
> >>    successfully. So far so good.
> >>
> >> 2) set status !DRIVER_OK -> DRIVER_OK happens. VQ irq setup is done
> >>    once again (vhost_vdpa_setup_vq_irq()). As the producer unregister
> >>    was removed in this patch, the register will complain because the p=
roducer
> >>    token already exists.
> >
> > I see. I think it's probably too tricky to try to register/unregister
> > a producer during set_vring_call if DRIVER_OK is not set.
> >
> > Does it work if we only do vhost_vdpa_unsetup/setup_vq_irq() if
> > DRIVER_OK is set in vhost_vdpa_vring_ioctl() (on top of this patch)?
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 388226a48bcc..ab441b8ccd2e 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -709,7 +709,9 @@ static long vhost_vdpa_vring_ioctl(struct
> > vhost_vdpa *v, unsigned int cmd,
> >                 break;
> >         case VHOST_SET_VRING_CALL:
> >                 if (vq->call_ctx.ctx) {
> > -                       vhost_vdpa_unsetup_vq_irq(v, idx);
> > +                       if (ops->get_status(vdpa) &
> > +                           VIRTIO_CONFIG_S_DRIVER_OK)
> > +                               vhost_vdpa_unsetup_vq_irq(v, idx);
> >                         vq->call_ctx.producer.token =3D NULL;
> I was wondering if it's safe to set NULL also for !DRIVER_OK case,
> but then I noticed that the !DRIVER_OK transition doesn't set .token to
> NULL so this is actually beneficial. Did I get it right?

Yes, actually the reason is that we use eventfd as the token, so the
life cycle of the token is tied to eventfd itself. If we don't set the
token to NULL here the vhost_vring_ioctl() may just release it which
may lead to a use-after-free. So this patch doesn't set a token during
DRIVER_OK transition but during SET_VRING_CALL.

>
> >                 }
> >                 break;
> > @@ -752,7 +754,9 @@ static long vhost_vdpa_vring_ioctl(struct
> > vhost_vdpa *v, unsigned int cmd,
> >                         cb.private =3D vq;
> >                         cb.trigger =3D vq->call_ctx.ctx;
> >                         vq->call_ctx.producer.token =3D vq->call_ctx.ct=
x;
> > -                       vhost_vdpa_setup_vq_irq(v, idx);
> > +                       if (ops->get_status(vdpa) &
> > +                           VIRTIO_CONFIG_S_DRIVER_OK)
> > +                               vhost_vdpa_setup_vq_irq(v, idx);
> >                 } else {
> >                         cb.callback =3D NULL;
> >                         cb.private =3D NULL;
> >
> Yup, this works.
>
> I do understand the fix, but I don't fully understand why this is
> better than setting the .token to NULL in vhost_vdpa_unsetup_vq_irq()
> and keeping the token logic inside the vhost_vdpa_setup/unsetup_vq_irq()
> API.

See the above explanation, hope it clarifies things.

>
> In any case, if you send this fix:
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks

>
> Thanks,
> Dragos
> >>
> >>
> >>>> Probably, but I didn't see this when testing vp_vdpa.
> >>>>
> >>>> When did you meet those warnings? Is it during the boot or migration=
?
> >> During boot, on the first 2 VQs only (so before the QPs are resized).
> >> Traffic does work though when the VM is booted.
> >
> > Right.
> >
> >>
> >>>
> >>> Btw, it would be helpful to check if mlx5_get_vq_irq() works
> >>> correctly. I believe it should return an error if the virtqueue
> >>> interrupt is not allocated. After a glance at the code, it seems not
> >>> straightforward to me.
> >>>
> >> I think we're good on that front:
> >> mlx5_get_vq_irq() returns EOPNOTSUPP if the vq irq is not allocated.
> >
> > Good to know that.
> >
> > Thanks
> >
> >>
> >>
> >> Thanks,
> >> Dragos
> >>
> >
>


