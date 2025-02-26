Return-Path: <netdev+bounces-169713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B36A45562
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AEE189B3F9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53225D537;
	Wed, 26 Feb 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcCj1lsJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5719DF53
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550616; cv=none; b=P0lUyFbTwxA9iSo8MpDf7IwnWFteWDPhR1OmvPHhgcHwyJnk2CWrGB7xHp2A31KNi4ETPEm/IB3Dhc9SwVXc2cDUaq2/cPjTIarVy9c0ZoXdNYzqFq0MyPRTZpQSA+xCV92SQICglLBpD3WUral0bz2i2XhUEbs5ClkMibSo+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550616; c=relaxed/simple;
	bh=s7RNNwS1VeCqaA1MtGD3SocRHTpkYCAIDVHP7LurC8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us73U+PMuDKmz9yhigmXf0RcQmr88S73gddjMzQ8gvhB9XRUWa8abMcYSm73nnywRyriRLu06oK8TFzMbmNyIPXlchxqj039T06oKH5GjFCplW4X/0vGj3QRqjrmEIdyGC+Rcg1SNsC/4L7vbfHuO4Z85dlBuKTnAPWZlkgEHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcCj1lsJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740550613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FB4LOVmyku7dBx/0yNo7XDVAzCNkcepNULZYDZTsFo=;
	b=CcCj1lsJ1t1catbGbcbflC2snKGY+EM/xFWb3N6Ii0A5HbnOhj0k94ltNYpwPz8jF6vBM6
	cQ9uaGgNqRKEWsTgyx/6AUCKI9ksnn6wlXk4NUk1kNvhzuUsLnv/Z9LvWDWl1AI60VTkRW
	d1PQA3KgnMjv0bwHdlTapvke59IpPwk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-1XuNwx7tOFWlsz84nXweNw-1; Wed, 26 Feb 2025 01:16:49 -0500
X-MC-Unique: 1XuNwx7tOFWlsz84nXweNw-1
X-Mimecast-MFC-AGG-ID: 1XuNwx7tOFWlsz84nXweNw_1740550608
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9fb24f87bso10219054a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550608; x=1741155408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FB4LOVmyku7dBx/0yNo7XDVAzCNkcepNULZYDZTsFo=;
        b=qXVaBqj8JGu451eU43cDmv9m5k+noB1On2UzERBmJWiSGujwnqo9VMRFJC60HIr7Cb
         oM15j2xJ07W61CXXbUuJK6UHHM1vmocBBwpwioK+vcrR49PaeyFeEfvND8eHPrx5RKU9
         JVOe+9yaRd/TsZXAZpGcwH7Oa2RzpnNFOe7jGpGyPA1Z53cViFDKzGmEY3LNNUZ2fH69
         O9OWk7lcs5IV84UsBD128tySTyBOP4C62v+FEqqoOZ6/GKVNO/ggVs7iRN3eL2mOOyWH
         A7167mt7xe35H9XNxXRB51g3PLmZddMhSlhRDPD913yJ9VSlDBtWL6j12p88hY1VtPze
         q93g==
X-Forwarded-Encrypted: i=1; AJvYcCXSgUn7CWHoC9N/apETdKkWAgQdWQ8KDrMzr3dDPpFpyC5SW0yddSMaq643GBIjFkwyzgveuz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQgquLCOmn/MrOSGcR7SMjGYM8yL+1eO5FsnGZzr4ks3P50q5
	2USuAphNOzXob/hZ4jAXv8hoMpD75pvNRJTr1dA+Q5Rc2OJCL0uKUFzrPvReDbpSW22T7Y20s/j
	8uKEdR9ShavgOdUVWmczjDIH0kmymOODG3toj26yc0tJw6fFmRSzeNDN9B3vxeR824noKCk5gVz
	vh0R+WE2lToYNxOSPyOM1v0rEjsZBQ
X-Gm-Gg: ASbGncu3TnzOac7V0XeK8W27es2kSx85PzNUqRCwXZ5zqCLqOQwexD5/uzGldj0Fijc
	8NiVhEKeyGWu1cgCe3ksePRJ5RiDVAbmvy3hl5VWJz33RUPwynGOXCNNu3Kxq8YZDmQnhk04TUA
	==
X-Received: by 2002:a05:6402:34cc:b0:5dc:cfc5:9305 with SMTP id 4fb4d7f45d1cf-5e4a0dfc8b9mr2496854a12.25.1740550607929;
        Tue, 25 Feb 2025 22:16:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Svm9zCE7jvsU1DaFVhMr5yn9In9YqFnmIGZJOqqstdyPg6Py8o1nFKh/wslu91Gg/91zZXUIrxektg2nXhQ=
X-Received: by 2002:a05:6402:34cc:b0:5dc:cfc5:9305 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc8b9mr2496837a12.25.1740550607523; Tue, 25 Feb 2025
 22:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
 <20250224164312-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164312-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 14:16:09 +0800
X-Gm-Features: AQ5f1JoQwYeVFJ0uSnuf6OMlUOLtzkJzFZrJtoyQ-MQBSJ8pPR3vnflY_UdihLw
Message-ID: <CACLfguWpj=-Ad3o731xbRdGRr3NT6oEQ67Z-FPBmd93gYEhAXw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> better subject:
>
> vhost: uapi to control task mode (owner vs kthread)
>
>
> On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> > Add a new UAPI to enable setting the vhost device to task mode.
>
> better:
>
> Add a new UAPI to configure the vhost device to use the kthread mode
>
Thanks MST, will change this
>
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode
>
> ... to either owner or kthread.
>
sure, will change this
thanks
cindy
>
> > if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index d8c0ea118bb1..45d8f5c5bca9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev,=
 struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> > -
> > +     dev->inherit_owner =3D true;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> > @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >  {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> > -     long r;
> > +     long r =3D 0;
> >       int i, fd;
> > +     u8 inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> > +     if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
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
> > +             /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> > +             if (inherit_owner > 1) {
> > +                     r =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +
> > +             d->inherit_owner =3D (bool)inherit_owner;
> >
> > +             goto done;
> > +     }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..8f558b433536 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,22 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost de=
vice
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thre=
ad mode
> > + *
> > + * When inherit_owner is set to 1:
> > + *   - The VHOST worker threads inherit its values/checks from
> > + *     the thread that owns the VHOST device, The vhost threads will
> > + *     be counted in the nproc rlimits.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - The VHOST worker threads will use the traditional kernel thread=
 (kthread)
> > + *     implementation, which may be preferred by older userspace appli=
cations that
> > + *     do not utilize the newer vhost_task concept.
> > + */
> > +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
>


