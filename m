Return-Path: <netdev+bounces-117578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84694E643
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 07:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4391F2254B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 05:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB114E2D7;
	Mon, 12 Aug 2024 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMGHvAXB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5B14E2C1
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441647; cv=none; b=rFNJvgnGzRfdyf9AkWiXB0NCLsTbAcbYtTMlYn9HQjnh+eyAByFOAWZ5BJPQeHn1kYn8vU8s38RW2zYt1p74TleaDoHLkwQ1e7Piuh4Q1wjs9yIU3bDwfItyy6eY5y4OlvT4yye0kckIRiu/vVNJAtKIOiwl+AZ1AfzQX5S3mHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441647; c=relaxed/simple;
	bh=Uw8yb612ZKPbURrgt/Fv4sgrL3dUlccka3seY1ans64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZvQuiA0SzE1+nTIIWr8r6XfzbJA8V9fmEKb2udb8DOaeBWEIkc3UlXyLk11ql5fuh9CAHmgDfbCO7ZYztAVUZfQzxli/ygXvObiyGpK/k8BWXkit9+UxbBDchw61jUrkpHEDsDaQ0Oy0jvZ03GbJjXXIqG2ehcP+4dmsMxTEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMGHvAXB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723441644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5CsJWNFYLKrhPjV5w6+3TXZvOdH+ndcySRvBH2M9eo=;
	b=EMGHvAXBNu7hOT9aZv7WG2auUbqOf69O0YplC4Ao8wfwNxLbDZQfT3ys7lpHpuQBO07bQQ
	lPkmPbraTAzpkyzHNiHqa1C+FyEjje24enXdIcuUTIJ+vU6VZxVWV4R5GN/l1FgYvii/yY
	an4Nt/tQSrFxxiDQEK2w63OMIhAhDKk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-G0lNrugqMD-L0XcMB8n7jQ-1; Mon, 12 Aug 2024 01:47:22 -0400
X-MC-Unique: G0lNrugqMD-L0XcMB8n7jQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb576921b6so4825387a91.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 22:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441641; x=1724046441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5CsJWNFYLKrhPjV5w6+3TXZvOdH+ndcySRvBH2M9eo=;
        b=pHeJaQUFbzzbDE06iCVCrqx0DLMCk5a885GQ51xWKFWqnFqmYuk3Q+EcEaFUjKIsif
         O/5x1yONQgAOkY/OgyoN/OL9y2yeiG/60sGbXw8AjnVYgazqQPTu4UTBP1uMMsbzSIc3
         o8++BaLX9FUVM11CGuutTlqyjKPeVYdL+AYmrLEKQ3C4IJRN4z06yhYaF3SnqpedjIVc
         O+h6b2k2m8Vlk3ZKBXc8J6QlgrjYQ5LK2JV2TVjXHa5KRlb2SzPvpP9RJ3L3kwnJ54mc
         npY78Nwy98dvdhM9acr8jjngXX90Unx9o7M6Y578Dk/WetgF64YDlhFCKvdH7IV2Nf7H
         WP5A==
X-Forwarded-Encrypted: i=1; AJvYcCXAz5SQbFnYATv++Tmy4scyW+2Jvsg/DhkaetUKDRUzWOfIPr8ag0zDn94mbxOAUkgdltU/Va4DnIBxTg2uCxCiaaQlmH9O
X-Gm-Message-State: AOJu0YxODr2YPDtttV9BefCRmM3lw3197oE/Q2GrF18jgUNJ1Q3sbywF
	BsQoGml9j9jgySvg6Q5IpzGlaDAgtsPGqHO5sSHG+DnTgg0AEkKSoRhOoUPi9+TjxOKBIINqmlX
	oD8LnbKbwzMFQ5jDjO/Vh3Sa1XCdPJc9ebs8ulHbgr1tuTUh14bsbav3MB9s0/r0QUGwRY99tNe
	RmnVJOo0EaYY9rKZLmnwrwIKcnv4ng
X-Received: by 2002:a17:90b:4a01:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2d1e80512c7mr9791790a91.34.1723441641645;
        Sun, 11 Aug 2024 22:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcQ+XQNc52+i7y7nv+eFycOjVns25ofqhkZcSaAIAiL54PDiPb1KE6nRmNAupkKLE5WiXOivV/pbuxkhY+hnM=
X-Received: by 2002:a17:90b:4a01:b0:2c8:53be:fa21 with SMTP id
 98e67ed59e1d1-2d1e80512c7mr9791777a91.34.1723441641179; Sun, 11 Aug 2024
 22:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
In-Reply-To: <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 13:47:10 +0800
Message-ID: <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 08.08.24 10:20, Jason Wang wrote:
> > We used to call irq_bypass_unregister_producer() in
> > vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
> > token pointer is still valid or not.
> >
> > Actually, we use the eventfd_ctx as the token so the life cycle of the
> > token should be bound to the VHOST_SET_VRING_CALL instead of
> > vhost_vdpa_setup_vq_irq() which could be called by set_status().
> >
> > Fixing this by setting up  irq bypass producer's token when handling
> > VHOST_SET_VRING_CALL and un-registering the producer before calling
> > vhost_vring_ioctl() to prevent a possible use after free as eventfd
> > could have been released in vhost_vring_ioctl().
> >
> > Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdp=
a")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Note for Dragos: Please check whether this fixes your issue. I
> > slightly test it with vp_vdpa in L2.
> > ---
> >  drivers/vhost/vdpa.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index e31ec9ebc4ce..388226a48bcc 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_v=
dpa *v, u16 qid)
> >       if (irq < 0)
> >               return;
> >
> > -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> >       if (!vq->call_ctx.ctx)
> >               return;
> >
> > -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> >       vq->call_ctx.producer.irq =3D irq;
> >       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer);
> >       if (unlikely(ret))
> > @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vd=
pa *v, unsigned int cmd,
> >                       vq->last_avail_idx =3D vq_state.split.avail_index=
;
> >               }
> >               break;
> > +     case VHOST_SET_VRING_CALL:
> > +             if (vq->call_ctx.ctx) {
> > +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> > +                     vq->call_ctx.producer.token =3D NULL;
> > +             }
> > +             break;
> >       }
> >
> >       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> > @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_v=
dpa *v, unsigned int cmd,
> >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> >                       cb.private =3D vq;
> >                       cb.trigger =3D vq->call_ctx.ctx;
> > +                     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> > +                     vhost_vdpa_setup_vq_irq(v, idx);
> >               } else {
> >                       cb.callback =3D NULL;
> >                       cb.private =3D NULL;
> >                       cb.trigger =3D NULL;
> >               }
> >               ops->set_vq_cb(vdpa, idx, &cb);
> > -             vhost_vdpa_setup_vq_irq(v, idx);
> >               break;
> >
> >       case VHOST_SET_VRING_NUM:
> > @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode, s=
truct file *filep)
> >       for (i =3D 0; i < nvqs; i++) {
> >               vqs[i] =3D &v->vqs[i];
> >               vqs[i]->handle_kick =3D handle_vq_kick;
> > +             vqs[i]->call_ctx.ctx =3D NULL;
> >       }
> >       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> >                      vhost_vdpa_process_iotlb_msg);
>
> No more crashes, but now getting a lot of:
>  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) registr=
ation fails, ret =3D  -16
>
> ... seems like the irq_bypass_unregister_producer() that was removed
> might still be needed somewhere?

Probably, but I didn't see this when testing vp_vdpa.

When did you meet those warnings? Is it during the boot or migration?

Thanks

>
> Thanks,
> Dragos
>
>


