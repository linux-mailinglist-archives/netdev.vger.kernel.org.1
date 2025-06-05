Return-Path: <netdev+bounces-195171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F6ACEAE9
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE1A189B1F0
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C81F8725;
	Thu,  5 Jun 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVeOMwvK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8531ACEDC
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108884; cv=none; b=R68alMuExB7gVA1CXBqt6/r8ZKzH5r9ILeYuQfDmssPnwfJMwD8FoYRYQAuBCqs9rWB/0tlAQ3EQirxCqOxrYXnmmVrKzeKI7C1375BssRBxPugvZjA9+J176Vdp+tWd+kLcpcQEhEDf3wdYelGk1Zk/0fMm9ql25sOgU68CHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108884; c=relaxed/simple;
	bh=KvU6Opi9kGXzP56d+/qD/Di+CulXN96GXgpj2Q7ikZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M41UptRgCUaxFKlIcmO4TGwW9RxnGwpEb0kvfu03CvpypshQv7zpHfBIqtMEkwWDOImHYpyRK5XV+MnIFzNH9Lymu0VmmSj/oUjyUGq8l4WNV2Mg3Qq+nTWf4izLaKKoxi/wcdqMqnaV8EKlExb4RM3tG5c9K1IynVUUI89sqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVeOMwvK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749108880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHnzJv9LA2nj2uz8Wh287T9rM+Per3aLlUbT6DCwHiw=;
	b=PVeOMwvKAIVSbPs2VAZ2zhfAlobQqqPScvNpjEILM0gTE5+A9sYZIZI50qyLYxNpTlDD+m
	+TGtSwj7XD0akxcJhXOVa3KZpRNvY9ZoZ42sfA9bsAJdG08mt0d6QdTL/SQiNzQzFPVLmB
	BPB1rw7lCUcpQcXwXkQfnh+83sbLYN4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-t6jr1rf5OW265SAo2LYRyg-1; Thu, 05 Jun 2025 03:34:38 -0400
X-MC-Unique: t6jr1rf5OW265SAo2LYRyg-1
X-Mimecast-MFC-AGG-ID: t6jr1rf5OW265SAo2LYRyg_1749108878
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-52f3b70789bso142840e0c.2
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749108878; x=1749713678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHnzJv9LA2nj2uz8Wh287T9rM+Per3aLlUbT6DCwHiw=;
        b=U97gOjsH7tLu5V912HrUZ3nObfLPTQheN2kExvD/Od8ARaxl7MaoGEbvqnJ5V3t0ue
         U9WTehMPSsA5mUdvDatbT/vOB5pIiRxvkZrv7q0XpeKpz5nKrhjTm0BzqqDf5YeY+zUO
         wmOWCjdTeu0cB2Q4ZR41IjNZMl/HSPKbKfWeJPViqzoYNKhzCSo2X8KuvuwQ1B2gfcRy
         QTXW9oxBWVvL328oxNsQB4L6EfRRZoETY8Tjuq+WXrT+LZjmXbaruTytU+nqY78sJIFW
         xSmWa78F1TEjd6d/Hx+GBP8u+TkI9uOF7LQOLDRFYwJ+7BSgXYo9PmLTJNHSnyXijhuI
         LPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNC3cmYTUVmEmkNXawkRphKmQz98DhYEyVjzBJMyZeUNJdi6u95Pvi0D89E5J4gIgL+OVLyr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwttCdollHiUqfYI3aXTFZHQ3KjAIhOXLM7/foNaOXrtTk6bB+n
	R+Behav1DyCrwt6ayHcTCk7bT4YBhDYuVS5T9V+lHPaRvufofpA2zmrQL/QbOvqyU4XSQHeG8Kh
	M/utYu0x9jDgjXVqXIcmOsjVrp40ZknyHpU/584W81yGZpAlhHzhOIWQDDh5I6AEDbuZnPF+odn
	MVQbedR1jK9MUP/x9qgv0zy8Vcu3by2z3WJHqr6jsWBpM=
X-Gm-Gg: ASbGnctFWQqWjPtBzheq0SP3ksrLjO9mn1O3qG+OSyJZkBtmAq+TMZNyGZdOiKnIkZm
	yUz3b/+6vznhE8tJEDuMUuNLfeB1T6UJ021+0yQxiGkF6xlf8Q4xXb0z1uCaIZygoynFy1BygQz
	AeReVS
X-Received: by 2002:a05:6122:2a06:b0:520:64ea:c479 with SMTP id 71dfb90a1353d-530c738fb3cmr4593826e0c.10.1749108877965;
        Thu, 05 Jun 2025 00:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER5ITUNDLcK9grbqWm5Pg6Bli/9p0K1++5vEDb2JsKQLZyOL2hncqmDmJdkJXon3YT/PF2oQWgj25knXxdiUo=
X-Received: by 2002:a05:6122:2a06:b0:520:64ea:c479 with SMTP id
 71dfb90a1353d-530c738fb3cmr4593815e0c.10.1749108877663; Thu, 05 Jun 2025
 00:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com> <20250531095800.160043-4-lulu@redhat.com>
 <20250601064429-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250601064429-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 5 Jun 2025 15:34:01 +0800
X-Gm-Features: AX0GCFsucvW1N5vvL9k5P8A2rP0lcWEDUo_lq6fMWFm6KBSsQNV3SxnYbfjllj4
Message-ID: <CACLfguWWcTNRXt7KO4D-Bwno2QF14Tkptw3HwM3P_RX62zu=uw@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 3/3] vhost: Add new UAPI to select kthread mode
 and KConfig to enable this IOCTL
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 6:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sat, May 31, 2025 at 05:57:28PM +0800, Cindy Lu wrote:
> > This patch introduces a new UAPI that allows the vhost device to select
> > in kthread mode. Userspace applications can utilize IOCTL
> > VHOST_FORK_FROM_OWNER to select between task and kthread modes, which
> > must be invoked before IOCTL VHOST_SET_OWNER, as the worker will be
> > created during that call.
> >
> > The VHOST_NEW_WORKER requires the inherit_owner setting to be true, and
> > a check has been added to ensure proper configuration.
> >
> > Additionally, a new KConfig option, CONFIG_VHOST_ENABLE_FORK_OWNER_IOCT=
L,
> > is introduced to control the availability of the IOCTL
> > VHOST_FORK_FROM_OWNER. When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set
> > to n, the IOCTL is disabled, and any attempt to use it will result in a
> > failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> I propose renaming
> CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> to
> CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> and it should also control the presence of the module parameter
> and a get ioctl (more on which below).
>
> Otherwise we can get a situation where task mode is disabled and
> there is no way for userspace to override or check.
>
>
sure, will do
Thanks
cindy
>
> > ---
> >  drivers/vhost/Kconfig      | 13 +++++++++++++
> >  drivers/vhost/vhost.c      | 30 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/vhost.h | 16 ++++++++++++++++
> >  3 files changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 020d4fbb947c..300e474b60fd 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -96,3 +96,16 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +     bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +     default n
> > +     help
> > +       This option enables the IOCTL VHOST_FORK_FROM_OWNER, allowing
> > +       userspace applications to modify the thread mode for vhost devi=
ces.
> > +
> > +       By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n=
`,
> > +       which disables the IOCTL. When enabled (y), the IOCTL allows
> > +       users to set the mode as needed.
> > +
> > +       If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2d2909be1bb2..cfa60dc438f9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1022,6 +1022,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, u=
nsigned int ioctl,
> >       switch (ioctl) {
> >       /* dev worker ioctls */
> >       case VHOST_NEW_WORKER:
> > +             /*
> > +              * vhost_tasks will account for worker threads under the =
parent's
> > +              * NPROC value but kthreads do not. To avoid userspace ov=
erflowing
> > +              * the system with worker threads inherit_owner must be t=
rue.
> > +              */
> > +             if (!dev->inherit_owner)
> > +                     return -EFAULT;
> >               ret =3D vhost_new_worker(dev, &state);
> >               if (!ret && copy_to_user(argp, &state, sizeof(state)))
> >                       ret =3D -EFAULT;
> > @@ -1138,7 +1145,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev,=
 struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> > -
> > +     dev->inherit_owner =3D inherit_owner_default;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> > @@ -2292,6 +2299,27 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> >               goto done;
> >       }
> >
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > +     if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > +             u8 inherit_owner;
> > +             /*inherit_owner can only be modified before owner is set*=
/
> > +             if (vhost_dev_has_owner(d)) {
> > +                     r =3D -EBUSY;
> > +                     goto done;
> > +             }
> > +             if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > +                     r =3D -EFAULT;
> > +                     goto done;
> > +             }
> > +             if (inherit_owner > 1) {
> > +                     r =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +             d->inherit_owner =3D (bool)inherit_owner;
> > +             r =3D 0;
> > +             goto done;
> > +     }
> > +#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index d4b3e2ae1314..d2692c7ef450 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,20 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost de=
vice,
> > + * This ioctl must called before VHOST_SET_OWNER.
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thre=
ad mode
> > + *
> > + * When inherit_owner is set to 1(default value):
> > + *   - Vhost will create tasks similar to processes forked from the ow=
ner,
> > + *     inheriting all of the owner's attributes.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - Vhost will create tasks as kernel thread.
> > + */
> > +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>
>
>
> Given default now depends on the module parameter, we should
> have both GET and SET ioctls. All controlled by the kconfig knob.
>
Sure, will do
Thanks
cindy

> > +
> >  #endif
> > --
> > 2.45.0
>


