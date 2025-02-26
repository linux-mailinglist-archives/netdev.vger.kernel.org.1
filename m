Return-Path: <netdev+bounces-169746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA22A458B8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0293F16CE74
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4C189F3F;
	Wed, 26 Feb 2025 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwuFI9dm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A7258CF3
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559583; cv=none; b=PYcebWoAHsquQRyRrbwHIWLQDKGMU/v0vLAfnP8rBVoT/REBl3l/ZE6k3R6Kbw5jlWaoOcscjdY9+DjnyZ2wyYXZytzcov/rU3B7YrcE34wDxDGZ86aY3URpiTxh672esVWe/8yl7ADUOTnZlYUUYrWggxde1b/mM6RhHZRcZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559583; c=relaxed/simple;
	bh=wIFKbS85eOb3/S4qRQtbgqZshrM7VAEcqE/gBDTCPr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVhXRwdikkORPyhNlcI6TDtPM/gtNt4wCeUP3ySf1iuH0UMuYNJud2LvJ+BZNT9HbHfX7AXiWMr84gpnLWEUZxl6POS4xi0ro0wahH3T7fRmTdXnRj9xEzaFvBWKABol8hp+mUgD64fSm9JSgv5GsMfBaIGfrpWbjBsGhWFY5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwuFI9dm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740559580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HhWFHTtLqRTKGNYZHFqREUf9Kb3AFGzGIEE9cBLMoM=;
	b=FwuFI9dmTY6eGFrPW9ZnPoNU9pjJIb+v7JFuHGQbRkLb9s1219Z1va1obV5i0q6ch5MQh/
	MlnZ+8KogIXtNTWbinmX/Yuw3NJFkHZ9QLucjwh7wMiS05MO2V/AjZwPq16+6E+d376AGe
	burHRNWLC79vdDO/V6oNSi9p1J7XE5M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-prNOsyvxO3esrc3DyGklhw-1; Wed, 26 Feb 2025 03:46:18 -0500
X-MC-Unique: prNOsyvxO3esrc3DyGklhw-1
X-Mimecast-MFC-AGG-ID: prNOsyvxO3esrc3DyGklhw_1740559578
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6fcfa304ef4so10110717b3.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559578; x=1741164378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HhWFHTtLqRTKGNYZHFqREUf9Kb3AFGzGIEE9cBLMoM=;
        b=aNi5Gb0qmFQO6HnwowUxa2AaK2haRnACA2035EfDKpGIjTHgWM3bqpoHGntiNySz2E
         9vQUB7T+WcjEaaAsacpMi4d/xmvTemTs1+xDp1wf9ILhaWQpsgdBlRveb4TL4SE+otZT
         yIHmprIZlHDRGTKXz39YnxE1q8kaYGO7Ds3UDuaYXpENj26BnaGf/C0qPBoHQcoEihXu
         5BJKnpq/yMOwmuDNqsiTNImc6Vnrnn0VDE6H7wC38K5OzePkm6AxhwLfpIc8LQPQRfxn
         1e6AO6cLlnZ7lABzCmP1VJLKOk90enqTQIysoAHZUA00SjRWSwZvFKVgQKeYpCNdd+lg
         ZTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuTa9JNYf9GGTaPNkxbgDP0BxS1pxX/J/im7rTDXk9riEGTB8oMbHK9t4SOg9Byitq6rQUEtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YworfJkHmGCSgCx36VRa8Ioyrq5AJWnGU6usal4D7JZpO8inFgU
	EcYHBR4r0I9l8Uy4488dkiXTWL5vhKflv160zklEzKxVCEkCQxxnvPYIpGZ4UZKNkGbl++r0qGx
	ZWI5oswd6LnWE9l+gTWEH1sycFtv+GLYh4EY7W334sfMn1KyqcX/Q4W2WOrGPTD7pEPqC4U8o06
	yIAs1z0F41b0XbcPlCSoy+KxCWnnnt
X-Gm-Gg: ASbGncvezfBAlHu66QWHzlf/PAIKwBvS0+y444Xu+20z+Vdgwsk/j1LcrkeLpkd2UQc
	py9jy5SCkXb46PpNaIOegeS/ZmQ95LxlcQ+bpOpsPi99ACQEFD4diosXSh3lBbc4hvwVYuOJX
X-Received: by 2002:a05:690c:c0b:b0:6fb:9e2e:93ed with SMTP id 00721157ae682-6fbcbe5e2aamr168560297b3.18.1740559578072;
        Wed, 26 Feb 2025 00:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKcMeU7iACAVvx7cPhCpmaATkm6R5lrHmtMjxwYPJIelmHPb54T40NA1E/fqr9s+weB43Wqwu3tWV8JhPGevg=
X-Received: by 2002:a05:690c:c0b:b0:6fb:9e2e:93ed with SMTP id
 00721157ae682-6fbcbe5e2aamr168560047b3.18.1740559577778; Wed, 26 Feb 2025
 00:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
 <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz> <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
In-Reply-To: <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 26 Feb 2025 09:46:06 +0100
X-Gm-Features: AQ5f1JrMmNoSkoKLKrZ-gssaJb3Hgne6ydzR99UUBf8jlpyWbdpp35nP5uJ9whE
Message-ID: <CAGxU2F7-UB+Jh41HkHKOqM+KNqSi2chEzVnFe9XAFmNun=0CTA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cindy,

On Wed, 26 Feb 2025 at 07:14, Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Feb 25, 2025 at 7:31=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> > >Add a new UAPI to enable setting the vhost device to task mode.
> > >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > >to configure the mode if necessary.
> > >This setting must be applied before VHOST_SET_OWNER, as the worker
> > >will be created in the VHOST_SET_OWNER function
> > >
> > >Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >---
> > > drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> > > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > > 2 files changed, 40 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > >index d8c0ea118bb1..45d8f5c5bca9 100644
> > >--- a/drivers/vhost/vhost.c
> > >+++ b/drivers/vhost/vhost.c
> > >@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev=
, struct vhost_iotlb *umem)
> > >       int i;
> > >
> > >       vhost_dev_cleanup(dev);
> > >-
> > >+      dev->inherit_owner =3D true;
> > >       dev->umem =3D umem;
> > >       /* We don't need VQ locks below since vhost_dev_cleanup makes s=
ure
> > >        * VQs aren't running.
> > >@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> > > {
> > >       struct eventfd_ctx *ctx;
> > >       u64 p;
> > >-      long r;
> > >+      long r =3D 0;
> > >       int i, fd;
> > >+      u8 inherit_owner;
> > >
> > >       /* If you are not the owner, you can become one */
> > >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> > >               r =3D vhost_dev_set_owner(d);
> > >               goto done;
> > >       }
> > >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > >+              /*inherit_owner can only be modified before owner is se=
t*/
> > >+              if (vhost_dev_has_owner(d)) {
> > >+                      r =3D -EBUSY;
> > >+                      goto done;
> > >+              }
> > >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > >+                      r =3D -EFAULT;
> > >+                      goto done;
> > >+              }
> > >+              /* Validate the inherit_owner value, ensuring it is eit=
her 0 or 1 */
> > >+              if (inherit_owner > 1) {
> > >+                      r =3D -EINVAL;
> > >+                      goto done;
> > >+              }
> > >+
> > >+              d->inherit_owner =3D (bool)inherit_owner;
> > >
> > >+              goto done;
> > >+      }
> > >       /* You must be the owner to do anything else */
> > >       r =3D vhost_dev_check_owner(d);
> > >       if (r)
> > >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > >index b95dd84eef2d..8f558b433536 100644
> > >--- a/include/uapi/linux/vhost.h
> > >+++ b/include/uapi/linux/vhost.h
> > >@@ -235,4 +235,22 @@
> > >  */
> > > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,      =
 \
> > >                                             struct vhost_vring_state)
> > >+
> > >+/**
> > >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost d=
evice
> > >+ *
> > >+ * @param inherit_owner: An 8-bit value that determines the vhost thr=
ead mode
> > >+ *
> > >+ * When inherit_owner is set to 1:
> > >+ *   - The VHOST worker threads inherit its values/checks from
> > >+ *     the thread that owns the VHOST device, The vhost threads will
> > >+ *     be counted in the nproc rlimits.
> > >+ *
> > >+ * When inherit_owner is set to 0:
> > >+ *   - The VHOST worker threads will use the traditional kernel threa=
d (kthread)
> > >+ *     implementation, which may be preferred by older userspace appl=
ications that
> > >+ *     do not utilize the newer vhost_task concept.
> > >+ */
> > >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> >
> > I don't think we really care of the size of the parameter, so can we
> > just use `bool` or `unsigned int` or `int` for this IOCTL?
> >
> > As we did for other IOCTLs where we had to enable/disable something (e.=
g
> > VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).
> >
> hi Stefano
> I initially used it as a boolean, but during the code review, the
> maintainers considered it was unsuitable for the bool use as the

I see, indeed I found only 1 case of bool:

include/uapi/misc/xilinx_sdfec.h:#define XSDFEC_SET_BYPASS
_IOW(XSDFEC_MAGIC, 9, bool)

> interface in ioctl (I think in version 3 ?). So I changed it to u8,
> then will check if this is 1/0 in ioctl and the u8 should be
> sufficient for us to use

Okay, if Michael and Jason are happy with it, it's fine.
It just seemed strange to me that for other IOCTLs we use int or
unsigned int when we need a boolean instead of a sized type.

Thanks for looking at it,
Stefano


