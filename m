Return-Path: <netdev+bounces-142770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C59C04DE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7549B1C23A9E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219D20F5B7;
	Thu,  7 Nov 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAOhShBF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82F2101AE
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980255; cv=none; b=VosvcV/vsguRlGZUzdu8sK+eVmc8gikaG36Dx6wRgXKnr2whs3i7XCeobeEspALg2aJXX/6cJDYPDNsa/e2vNs6opglYu19eNOWkcN1X6qJf1OZDk2mPrOEpSMdKO0Yp79jWRdiFr1wrrm9RSF91uJPIodsaK1vns3RABDJUNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980255; c=relaxed/simple;
	bh=n0QCEHl2jaF3c2bkOmUtYZCm3S+xz14biBzyHvcU+EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSbHAR7hMWbvUqXnYsm1kVqRV/jTnGl85wCjEXJMpYetgYK3dPAr3hMHFuj94cB6T5vAgUF9DTBRon1RuRl4bzv5GiJq6iTOQunG71jehZy8kVfoNBYdNJx+SS0913ASXhgiwfgN/W7J5Ky4LFI6m3ghoipnZYi1fDe3aRhtmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAOhShBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730980252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=648oAdh71ykdlsYI2PO1sVV/3rqyVjApi3Xls/dCZBk=;
	b=HAOhShBF9rLeBZnIcvzXxb+R9JMwTMmHjPs1Ceus8dKLHYxmNSOJicEdmJxPCcl1nlXrIc
	DZWKlfUbyhClynG1DUFWpYUxzAr1rp7SoQkCiQlV9roADMt99QJ81QdhTAqs0sBaBAqsMF
	PakSyBfXcxqIz5kyEBqq76rH3V9cCGg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-7nxohZpfPQGPiK8eEsEwYA-1; Thu, 07 Nov 2024 06:50:51 -0500
X-MC-Unique: 7nxohZpfPQGPiK8eEsEwYA-1
X-Mimecast-MFC-AGG-ID: 7nxohZpfPQGPiK8eEsEwYA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99ea3e1448so73966766b.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 03:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980250; x=1731585050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=648oAdh71ykdlsYI2PO1sVV/3rqyVjApi3Xls/dCZBk=;
        b=WtUWQt0Qu1KX8XlZa1DtRbbY/Bc8SgwA/O9WBi+V+reTHXoCPl9E8cj0jSSKcJWj3h
         AEFOipuWePYYzFUcdeY3GNoG/WltZqYIEy03QbR+RmbWs8rt+qBrKNhvZ/sVzXKlVwa9
         PZeONomjQugJXfq2NWzJOteHJ8If7LJaUCL9hRGBkQeJ5L/UJS5bqlCnV9gv0aHj1341
         d55rgghlv0jfnX5yAvKs0v5PVkWYZCS7gH+1IIQzbtx9uDen3obUz/se9N3f0/lwnNil
         dmD4KlK19B3atg4m0NjtZaKioHblPnJ1pwX9NnCrOfpq8GGwkG2D2RORnU+/vS/5r4Nk
         pKXA==
X-Forwarded-Encrypted: i=1; AJvYcCUJMhncq9m7tPy2CnPK6xuYtQ4GR2Cxq690s3IUUtH+5z1GtrOrf6GYW9jVCsbr8Mu50hkbaVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNJUPxJ/dXTiAgQ6xqhGAmod+blrhs4tXbZ4wAFSTYT189kQ5
	6eAjYxyl7CyNmLtkNeG7eLRKSLw7govY0v+W8y1lWU0/hNiPSkAFPCPMCbL1iv9fhVQw58NTgdh
	dQSsyvCthJe3be7UCaT3lTZlhoYw4QjelwzwM6OlwSB8vUBKwF2gA+BEFCgqYnrApVHD0dExrKE
	c2+QfGjnDHb3mnEgmuhwv5iSQdxft8
X-Received: by 2002:a17:907:728d:b0:a86:8e3d:86e2 with SMTP id a640c23a62f3a-a9de5d6e1f2mr4840613466b.11.1730980250168;
        Thu, 07 Nov 2024 03:50:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPfRWKKC2Mmw7qsLwNWsUWk9YcB3oP04KpCrk49fXxZ1eFzL9rc53cMZIp1x03OUPvMyR3Ccw7QTwYX9l0OHc=
X-Received: by 2002:a17:907:728d:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a9de5d6e1f2mr4840608566b.11.1730980249462; Thu, 07 Nov 2024
 03:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-8-lulu@redhat.com>
 <6dtic6ld6p6kyzbjjewj4cxkc6h6r5t6y2ztazrgozdanz6gkm@vlj3ubpam6ih>
 <CACLfguVNM_b9LdiMyj+pZH0WHu=-Nrit8-cr+QH9=f7tMLDd4w@mail.gmail.com> <zkamzruq5e3diahm7vyjansnaowkw42toh5evwgq6vqal7h4pk@3w4e47ggogyr>
In-Reply-To: <zkamzruq5e3diahm7vyjansnaowkw42toh5evwgq6vqal7h4pk@3w4e47ggogyr>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 7 Nov 2024 19:50:12 +0800
Message-ID: <CACLfguXH7oEgjaOYWC05742n0dsUGaFWM-i7Fykuzbxv9xQ9HA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:03=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, Nov 07, 2024 at 03:12:49PM +0800, Cindy Lu wrote:
> >On Tue, Nov 5, 2024 at 6:32=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
> >> >Add a new UAPI to enable setting the vhost device to task mode.
> >> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> >> >to configure the mode if necessary.
> >> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >> >will be created in the VHOST_SET_OWNER function
> >> >
> >> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> >---
> >> > drivers/vhost/vhost.c      | 15 ++++++++++++++-
> >> > include/uapi/linux/vhost.h |  2 ++
> >> > 2 files changed, 16 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> >index c17dc01febcc..70c793b63905 100644
> >> >--- a/drivers/vhost/vhost.c
> >> >+++ b/drivers/vhost/vhost.c
> >> >@@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >> > {
> >> >       struct eventfd_ctx *ctx;
> >> >       u64 p;
> >> >-      long r;
> >> >+      long r =3D 0;
> >>
> >> I don't know if something is missing in this patch, but I am confused:
> >>
> >> `r` is set few lines below...
> >>
> >> >       int i, fd;
> >> >+      bool inherit_owner;
> >> >
> >> >       /* If you are not the owner, you can become one */
> >> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >> ...
> >>
> >>         /* You must be the owner to do anything else */
> >>         r =3D vhost_dev_check_owner(d);
> >>         if (r)
> >>                 goto done;
> >>
> >> So, why we are now initializing it to 0?
> >>
> >r =3D 0 mean return successfully here.
> >Therefore, in the case VHOST_SET_INHERIT_FROM_OWNER function, I don't
> >need to set it again and can simply return.
> >....
> >    if (vhost_dev_has_owner(d))
> >       break;
> >.....
>
> Okay, but vhost_dev_check_owner() already set it to 0, so we can avoid
> that, no?
>
> >> >@@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> >> >               if (ctx)
> >> >                       eventfd_ctx_put(ctx);
> >> >               break;
> >> >+      case VHOST_SET_INHERIT_FROM_OWNER:
> >> >+              /*inherit_owner can only be modified before owner is s=
et*/
> >> >+              if (vhost_dev_has_owner(d))
> >>
> >> And here, how this check can be false, if at the beginning of the
> >> function we call vhost_dev_check_owner()?
> >>
> >> Maybe your intention was to add this code before the
> >> `vhost_dev_check_owner()` call, so this should explain why initialize
> >> `r` to 0, but I'm not sure.
> >>
> >Yes, in the function beginning, the code is
> >if (ioctl =3D=3D VHOST_SET_OWNER) {
> >r =3D vhost_dev_set_owner(d);
> >goto done;
> >}
> >if the ioctl is not VHOST_SET_OWNER,  then the  code will not run the
> >function vhost_dev_set_owner.
>
> Sorry, I meant vhost_dev_check_owner(), not vhost_dev_set_owner().
>
> I'll try to explain again.
>
> After applying this series we have this code:
>
> long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user=
 *argp)
> {
>         struct eventfd_ctx *ctx;
>         u64 p;
>         long r =3D 0;
>         int i, fd;
>         bool inherit_owner;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
>
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
>                 goto done;
>
>         switch (ioctl) {
>         ...
>         case VHOST_SET_INHERIT_FROM_OWNER:
>                 /*inherit_owner can only be modified before owner is
>                  * set*/
>                 if (vhost_dev_has_owner(d))
>                         break;
>
> IIUC this check is always true, so we always call `break` because at
> the beginning of this function we call vhost_dev_check_owner() which
> if `dev->mm !=3D current->mm` (so it can't be null I guess) jumps directl=
y
> into `done`, returning an error.
>
> So I still don't understand in which condition we can run the code after
> this check.
>
oh sorry I missed that check. I will move the new case back to the top
of function,
I didn't think it through before making this change; I just wanted to
clean up the code but forgot about the status.
Thanks
cindy
> Thanks,
> Stefano
>
>                 if (copy_from_user(&inherit_owner, argp,
>                                    sizeof(inherit_owner))) {
>                         r =3D -EFAULT;
>                         break;
>                 }
>                 d->inherit_owner =3D inherit_owner;
>                 break;
>
>
> >This ioctl is used by userspace applications, so we cannot be certain
> >of the type and sequence of their calls; therefore, I added this
> >check.
> >
> >> >+                      break;
> >>
> >> Should we return an error (e.g. -EPERM) in this case?
> >>
> >sure=EF=BC=8Cwill add this back
> >thanks
> >Cindy
> >> >+
> >> >+              if (copy_from_user(&inherit_owner, argp,
> >> >+                                 sizeof(inherit_owner))) {
> >> >+                      r =3D -EFAULT;
> >> >+                      break;
> >> >+              }
> >> >+              d->inherit_owner =3D inherit_owner;
> >> >+              break;
> >> >       default:
> >> >               r =3D -ENOIOCTLCMD;
> >> >               break;
> >> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >> >index b95dd84eef2d..1e192038633d 100644
> >> >--- a/include/uapi/linux/vhost.h
> >> >+++ b/include/uapi/linux/vhost.h
> >> >@@ -235,4 +235,6 @@
> >> >  */
> >> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,     =
  \
> >> >                                             struct vhost_vring_state=
)
> >> >+
> >>
> >> Please add a documentation here, this is UAPI, so the user should
> >> know what this ioctl does based on the parameter.
> >>
> >> Thanks,
> >> Stefano
> >>
> >> >+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
> >> > #endif
> >> >--
> >> >2.45.0
> >> >
> >>
> >
>


