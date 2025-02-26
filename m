Return-Path: <netdev+bounces-169712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0804A45556
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC431764B1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D388267B8C;
	Wed, 26 Feb 2025 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7o4M5jj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7B267AE9
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550455; cv=none; b=BQjWXABUG4UNyASnp/KNR/jIPLmWTB4t3nPnS/alSGxPXTOn5HaBt3aMN7bWqGYhWUWFyQmaMbG7v8KJcGZI3zJjrQU+j0ZcI4qYN8W5Cnq4XRRgES3xJdmfUXH8IU14SfCJt/qgX1ZMDCHPwldya6z+9yg9QKWNMVWfXa+jRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550455; c=relaxed/simple;
	bh=occPEZDucJVb8lBD1jQ1GAuOO0994gL1zBT5kTdiRNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwhWQG/g26YmfZJDnbMHzFNvTfKIeStm1KTPddmfphR5+lPGNZXc/54kBqw7T9e1Su1MMSrBkdDd2qwQd+R9OiDKDCAbaHLnDSUI61CWbv8+6ijJBcjUaJrMH5Sm0of/5xctugNUrtMM5e2hbiVTJrtfH1GVViQECY6tQtkye/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7o4M5jj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740550452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrYuHXAnjLqXKtPJWbNFQh22GoqGfQZfdjz3jbFGr6E=;
	b=U7o4M5jjn2mWAHWqZfkv8b72Noqn1G3mdq44tLhXJ7MbwDpY2IzY6XEZztfHuD+FAp/Z4Q
	1wTDOiBwYrf/RS5Gne/1g0RsXyVQrt034FisTmjODD7QMYs6bR6AeMbkMmTXhPN9VjGnwL
	FySscn+zuVB6hQx7sIvQt72j6cXIaQc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-8KfLQYnpMRm9hIsFOL_Zrw-1; Wed, 26 Feb 2025 01:14:07 -0500
X-MC-Unique: 8KfLQYnpMRm9hIsFOL_Zrw-1
X-Mimecast-MFC-AGG-ID: 8KfLQYnpMRm9hIsFOL_Zrw_1740550446
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab77e03f2c0so667782366b.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550446; x=1741155246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrYuHXAnjLqXKtPJWbNFQh22GoqGfQZfdjz3jbFGr6E=;
        b=a6PUUy517gmvm+HEBcCG51J0p0YoZiDa2PsV3bB1jhbaKBkTY6ndr/hU/FbXcigxGO
         pF2Tg736/bVbvvAjJgZncnBHkZKaZYomu92Ldq6xE8zY2ccnS/P46yzWeW/KV/w9+lyr
         A6o2OmoeirVzB1569iM+IN+x7B/CLyWCOn9/L9NFprFSXC9BByiA4mkqpuri452j01O9
         5+YmygpLKEfynNpOtzHBxOBYsCoqGz4aQ5166rqCrN+/FZrYIrSuILhDPmi6i7fHDy5z
         gjVL5crN8TPM0kcAExMr5v+L8nqK8+vTmb5eKKASsjvHUUhUrn+xG0NuKoXvtUcTIlTK
         MR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjcYC7sD7f0bgdHoIjii0a1vk9R4RGp/bqs1ZCL+rq2Z62k+Yz2lOOkLvOxr7MckZorN1zQZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeSHmikzn3kj3picTpNu3+GGzcJdeSxL2dnm0J1PBFtmHeqC6
	mML8J0B/kEdZr1V0nAujM7BR2zdkYcIc5DCXYl1imKsIDY/1kq1zZcrsAYwUb8aOdn0UOXuv1/c
	DAxsIV2WZTGBQxuJuHh1ro+5+enfji6qn+d1Vw7IGYjtB9yEuhoy+lSd9kpvG6FehXRsqJ+23Ib
	qVxgIjigxrejE03d5Yi2+F3u7MAq2S
X-Gm-Gg: ASbGncs8C95EUdcvw8NSzb/gjurYpHXCj4TgEUh0EncWrrf7foUgC62VWxRK4O9yfcf
	/y5FtgzI6/eKA2LlEAndMqeWE9tngY5+O/Oi9ydMvAF5ZKo3WAzl6t+rlIPCZNV2hH8pTmaByvg
	==
X-Received: by 2002:a17:907:6d05:b0:aba:598b:dbde with SMTP id a640c23a62f3a-abc0d97e504mr2119382766b.8.1740550446137;
        Tue, 25 Feb 2025 22:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEPM7VfuOk/Au93iZs65YIRLhsjQkDmCkNqmGnjdzf1TQUXJWU9PFxQBBs189DJw6J4yaO/kqbah0ezftoIDw=
X-Received: by 2002:a17:907:6d05:b0:aba:598b:dbde with SMTP id
 a640c23a62f3a-abc0d97e504mr2119381266b.8.1740550445828; Tue, 25 Feb 2025
 22:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
 <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
In-Reply-To: <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 14:13:27 +0800
X-Gm-Features: AQ5f1JoNoWEefztuGY9ylFIkLRXZ0YQ4UToF_h0n3mIP4S6r1pE-NAlUqjniIn0
Message-ID: <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
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
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - The VHOST worker threads will use the traditional kernel thread =
(kthread)
> >+ *     implementation, which may be preferred by older userspace applic=
ations that
> >+ *     do not utilize the newer vhost_task concept.
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>
> I don't think we really care of the size of the parameter, so can we
> just use `bool` or `unsigned int` or `int` for this IOCTL?
>
> As we did for other IOCTLs where we had to enable/disable something (e.g
> VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).
>
hi Stefano
I initially used it as a boolean, but during the code review, the
maintainers considered it was unsuitable for the bool use as the
interface in ioctl (I think in version 3 ?). So I changed it to u8,
then will check if this is 1/0 in ioctl and the u8 should be
sufficient for us to use
Thanks
cindy
> Thanks,
> Stefano
>


