Return-Path: <netdev+bounces-154532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5B9FE5E3
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745381882686
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7161A83FA;
	Mon, 30 Dec 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+GVD7sQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D01A2C25
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562344; cv=none; b=T9C0mGTx5eYATKUIVMQX5m/BkvHaWF2+aq3bZLOIprFgXK4qy7nV+TRE3NcQGDQfJJE02vBcbi2LUl2vRJXtdbSZzxXR8i62UT09vZKjkCYQ/twvJqFPjuS4EfSHQqmvYVXPQWizZthK55GVLjdi76gFrZKr4U8JHB1Q8XWpEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562344; c=relaxed/simple;
	bh=zNaBfnIZKPu0apVtwnn/KH+i1YsjpT9qIBWhouoaFIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmY/8GS+S1EaADIHHHOf0NVwFKZg/+JAglzKT2GnazYx6Z02GvJXAgbJACAVxevvYP3A3ZDn74kVNBTjU8/V93Mezle1dn1un5ZmeS4w+BSfS+zxLb1dHMvN/o59EgYyHcMt1pzY/chLK2aYGwD06VTPX0LzFZsQ4OElrRsZMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+GVD7sQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EN5GR/R8rnvHhX9xh4AO6pkHNi8GGSvhfwqYdRHPJsE=;
	b=C+GVD7sQi8YMqPRnQbtFQQjgKYqlS0zBrNHU5Wl8dsK8I+4zJx+b91JBT3c7wTf62LOHIP
	YOrXinKau8YlklYqEiQRqJTBmxie3WMI4YDP5z+ebfRE4W4qDaWRYZmnzKoAP8HdK1JDmU
	mhNevsviQasRkR/+jlVKSTXAhNSbqO0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-J21l7anIOJyVFOGNnuPOaQ-1; Mon, 30 Dec 2024 07:38:58 -0500
X-MC-Unique: J21l7anIOJyVFOGNnuPOaQ-1
X-Mimecast-MFC-AGG-ID: J21l7anIOJyVFOGNnuPOaQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6732a1af5so845933566b.3
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 04:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735562337; x=1736167137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN5GR/R8rnvHhX9xh4AO6pkHNi8GGSvhfwqYdRHPJsE=;
        b=WAfjPCbTlUzXktpRB4o1N5q8y/6mWMTXw+08/Ft2HO+O9jujWAE6U7rDGkw2GNfT5C
         KdFkd15Oufb9z2j8VpP/UuGOxAs7AufYMVEwEZLaErW7j86fHXRSnKLL2EOSiropw/o/
         iXwxfYgIxjjf9zFlGtZC5BrQVRH7k/Hg7IkawU+BV+L4wX+cgCJYTB3e7d6IEpk71JlA
         UNZrs9tFoae1KqPBdaOHFin7gFLAYDC3NNKnQI/hbSnwNKdqTZ4U0UDbSYSUlp0Roj+m
         3XRIsGipX99sPdU0dnh/W+qA0ESgBtQ1S9gDLHlagc+WUgYVJN1X856qrCSG9tbAaIen
         BHIA==
X-Forwarded-Encrypted: i=1; AJvYcCVIjlKlWRKipibxYKcZiJ1UH1muUI7JGWU7LUZiejfMz7f+V5098SNl5ZwI4nQ6Odttdfev5a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55EGtn0ctI+HrzJckYl9/xKnPU6YkzyUkG2YOAI+R6T+Hhe1T
	NHscrk1hao/Pq43qHB1YzwK91HJePYyUBszJ7V7pyI0xnUBeu7xMNEuPXFejp5yYw2EEEriDnPV
	Wvzt7VIcU84DII4zG7WH/mnU1mMAZ8XAVl9X1QgqLKZN5QQG/yNkpp5Y7XuftcRAFfuKrDwz/HB
	X0QH19JwK4f0JejGTJomSi9PpFZaVn
X-Gm-Gg: ASbGnctbJDh6b6F6Z87k2M1B+Xy/Xrn0BTxlAzdsWIOGkZJzIZ1T95Gq1zfGzoGOzOL
	QAc3dryBQU/ktewQEOFYsImRsytGrrLCg9q3MYqg=
X-Received: by 2002:a17:906:730f:b0:aab:de31:52d0 with SMTP id a640c23a62f3a-aac2b28ee4dmr3994879366b.18.1735562337363;
        Mon, 30 Dec 2024 04:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOeG8aLdv/SamEPxjMO+a6SoNp9akAxI4C2LKfbhpTR/FoGO/ovccvC1DC9qvCnLAaB9M+8GlyZGGmsYBssOY=
X-Received: by 2002:a17:906:730f:b0:aab:de31:52d0 with SMTP id
 a640c23a62f3a-aac2b28ee4dmr3994876366b.18.1735562336959; Mon, 30 Dec 2024
 04:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <2on4eblmkzkhecpyiwtauel6hxw6upnlh6wunfxgxvfp45cej3@6z5lzdermzeg>
In-Reply-To: <2on4eblmkzkhecpyiwtauel6hxw6upnlh6wunfxgxvfp45cej3@6z5lzdermzeg>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 30 Dec 2024 20:38:19 +0800
Message-ID: <CACLfguW=WciC77tRzfjFNLzrKcxUCBRy_z0V9rpFhEOQhDvhiw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:55=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> >Add a new UAPI to enable setting the vhost device to task mode.
> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> >to configure the mode if necessary.
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > 2 files changed, 39 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 3e9cb99da1b5..12c3bf3d1ed4 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
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
> >+      if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
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
> >index b95dd84eef2d..d7564d62b76d 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,22 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,
> > \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vh=
ost device
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1:
> >+ *   - The VHOST worker threads inherit its values/checks from
> >+ *     the thread that owns the VHOST device, The vhost threads will
> >+ *     be counted in the nproc rlimits.
>
> We should mention that this is the default behaviour, so the user does
> not need to call VHOST_SET_INHERIT_FROM_OWNER if the default is okay.
>
sure will fix this
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
> >+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>
> Do we really need a parameter? I mean could we just have an IOCTL to set
> the old behavior, since the new one is enabled by default?
>
> Not a strong opinion on that, but just an idea to reduce confusion in
> the user. Anyway, if we want the parameter, maybe we can use int instead
> of u8, since we don't particularly care about the length.
>
> Thanks,
> Stefano
>
I think we could keep this, just in case the userspace app needs to
switch back from kthread mode.
Thanks
Cindy
> >+
> > #endif
> >--
> >2.45.0
> >
>


