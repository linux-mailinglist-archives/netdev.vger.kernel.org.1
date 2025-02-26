Return-Path: <netdev+bounces-169757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FBA459D8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972093A87AD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4D9226CF6;
	Wed, 26 Feb 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNn+iCk1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AEA1DC997
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561606; cv=none; b=ay+Ys4Az72EXsG+FS319MhkXE5pYRe4ODkqFfXCvpQGEZSNscIFRMDPuC4aeKzkI89Trrbu76VYL7plwsO56eCGZ0l592j4mEA9rsEzobCazMZsGsigmWG+/lpAwPkNawKkLHWxIfmfgerKPETTEo8MNOgH8sgUuBwzFekuEl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561606; c=relaxed/simple;
	bh=Jp7DsSJNpcfNT0CFEGmkK+aELPo5dLQUpXCi4cWUXjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMDYQLzNZWCJjIUKuajQ8lCRMIp/98lQh6vkRHj0RGu7HiuhQDp9FCpuFjV5YanH9bPKekMbEdEKFnP4KwfvXgCqieR+wWSj61jlYMq0+VSFJ/+dvmVryHN/v6w8N5yi4030IdEs3iHqwxcWKbiSlK54+pDmo47nRQIi1JNj+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNn+iCk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740561603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qamVRmWcTIvwYGQRYcThfVWLwYEjJIZL/VLEodyLJX8=;
	b=RNn+iCk1ljvP+HYBVMliUr+VZOMNdMLiZL4lcGjmbq7djfQrwyUb6A872pjDuUPP7A7N1X
	Z38Up6s4e3MhfW+T2YBHdiZ8b48IiUfTNd5a+D5QkZxDDg7lR/Aj21J89/nUfhyLZ79RWQ
	EZx21+y4pbrZZ/AveBIBnl19fjy1fr0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-n3I8lPYYMLWr6AjtsLP5GA-1; Wed, 26 Feb 2025 04:20:01 -0500
X-MC-Unique: n3I8lPYYMLWr6AjtsLP5GA-1
X-Mimecast-MFC-AGG-ID: n3I8lPYYMLWr6AjtsLP5GA_1740561600
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abecbdb4272so361800266b.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740561600; x=1741166400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qamVRmWcTIvwYGQRYcThfVWLwYEjJIZL/VLEodyLJX8=;
        b=HX1oP5Yo+78SSf0aWlXHv9vtVb6Bcx+2r34agbvcDzmIJ8PdQ/IeXwNkJIM2zTIh45
         yJ48i9wNm9v2tSjm+eXuL0VG26qX5a7PKmBYr/hlfi83pQfoCnZsnAdnqbnyHDfF+fFy
         2dY5/jXYkdhKtBhXZ3Il2Pw97dVm26SAuLU9as8BG243YH27k4h++HhA9gBpoN0t/O6/
         F8FLKCAbyagStA5gFOMT+S/ZeD/Ug57N37CLgAdknbg0FEQfjdJnTn/Z/z9qOe3ByiAQ
         yTOKtLWJBvUC+K8KUWegwia3hhjQ0hgkck+rdDw5MyKd8RBiqgzrI3sWvqy5e7zLl3dX
         S6bg==
X-Forwarded-Encrypted: i=1; AJvYcCVetxGZVsGcvfOJpTL7gZvCSDSZJv42rcILB9XNrMdfrmo0v80ge5WVtfUipZUU9MmLomuVz34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjg6FqAVnJnYUyeR1KG/unXA/oZiJuGxRDfmckd37jwRmokbcS
	Fz+Z6LCP/8QnjvUe841DK4y94A6LvlndIBh4V0Gbr1cXaISeV0vGpMwi+bSWwMDyy9JzmzMISyS
	yMr/CPWJqk99tCP+q0u7iR32ZTLM1fnR6P6bh1vapnYUGY9qbiNOH4aq/+43+VjJtus/zHb1cmH
	9o0ZKj/xdVFOhAEN3bM6dLgK5yH8ji
X-Gm-Gg: ASbGnct/3tJkzh2ecZk93gH9X5btHxjDg056zNxl4vZyK+zK2uJU7rXmWrZvALg1oGN
	Ysr3cWbYi2vzWwMmzrDfQk55xgTmYgdAnnaKZk3XJCVJ/2iIEUjFgaUqs6s92Gzmg640TGwlt3g
	==
X-Received: by 2002:a17:907:7f90:b0:ab7:bc17:b3a4 with SMTP id a640c23a62f3a-abed0e098a3mr857198066b.34.1740561600253;
        Wed, 26 Feb 2025 01:20:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq/1+GO76nciGzUO6OLY0Y0viW56ZZAsvuEGMjL/VfBPfvMa64SWBIsCqRKjKGGHtNNpyhasK00aF+MVnveas=
X-Received: by 2002:a17:907:7f90:b0:ab7:bc17:b3a4 with SMTP id
 a640c23a62f3a-abed0e098a3mr857194066b.34.1740561599907; Wed, 26 Feb 2025
 01:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
 <77uzlntuxfzcj4qxggac23g73hslbkstygunqus33hzwrmotzq@f2t22l52xqdo>
In-Reply-To: <77uzlntuxfzcj4qxggac23g73hslbkstygunqus33hzwrmotzq@f2t22l52xqdo>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 17:19:21 +0800
X-Gm-Features: AQ5f1Jr2O2CIo5FFjfNcFqF4MyEk2kekFqek0tAlOMhRgLtqUwdc-WmDHsxc7j4
Message-ID: <CACLfguX7Y17YBdXRri5Q=8qGDyuL+mUrrWD680Y=zoQvjzrJ7A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 5:05=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> >Add a new UAPI to enable setting the vhost device to task mode.
> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> >to configure the mode if necessary.
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > 2 files changed, 40 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index d8c0ea118bb1..45d8f5c5bca9 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, =
struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> >-
> >+      dev->inherit_owner =3D true;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> >@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> > {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> >-      long r;
> >+      long r =3D 0;
> >       int i, fd;
> >+      u8 inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >+              /*inherit_owner can only be modified before owner is set*=
/
> >+              if (vhost_dev_has_owner(d)) {
> >+                      r =3D -EBUSY;
> >+                      goto done;
> >+              }
> >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> >+                      r =3D -EFAULT;
> >+                      goto done;
> >+              }
> >+              /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..8f558b433536 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,22 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost dev=
ice
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1:
> >+ *   - The VHOST worker threads inherit its values/checks from
> >+ *     the thread that owns the VHOST device, The vhost threads will
> >+ *     be counted in the nproc rlimits.
>
> Should we document that this (inherit_owner =3D 1) is the default, so if
> the user doesn't call VHOST_FORK_FROM_OWNER, this mode will be
> automatically selected?
>
> Thanks,
> Stefano
sure, I will add this
thanks
cindy
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - The VHOST worker threads will use the traditional kernel thread =
(kthread)
> >+ *     implementation, which may be preferred by older userspace applic=
ations that
> >+ *     do not utilize the newer vhost_task concept.
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> >+
> > #endif
> >--
> >2.45.0
> >
>


