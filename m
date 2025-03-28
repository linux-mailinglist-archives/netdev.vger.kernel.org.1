Return-Path: <netdev+bounces-178057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5693A7439B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 06:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF10A3B986A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 05:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D9211469;
	Fri, 28 Mar 2025 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODvD75/u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0173010C
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140680; cv=none; b=fY0HC4xRHo84o9T52vmnElolvyHSYClc3ZMmC/jTRqoXY1Z2lF106uepwt6I5P7iL7H5V+vEdtDMMkkloWxZVSfiDQ+rUskBgF5JAomqN3NqkgRuGfiyZzEW/d/rgwcVGoL0Y6qsJd39P9ux81UUbmat5FWMlDY65Zl/Bt1qTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140680; c=relaxed/simple;
	bh=XQtprkEDEsNATdaVZNN4W5lGHi2fIAWaW+Dfp7jzqhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsUNI/rkELGpHz0IiUPbaE5zI3ymaKPPwCid/AF2z/s30LYO4O3YGtX4yelZk/v0zYC6LiMDnGWqB30Xj9ZYEeQRU14vOo8Vhbnw/b7F52nSVq6YmKYJbVEC1NVeRujCFFA4exbvKv9UJ/NQWUEYLjbwumlPB/8Ay8qxjp0zCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODvD75/u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743140676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QutikAf8CzdrkFZy4fbFiEuK2llYIXRXcPk92xeA3Cs=;
	b=ODvD75/ufZ7uL8RtjQscqX7/XvaVF5WnftV8ve4b5VZHgCINyTRMFInccTZCt/hbygN5z5
	0XwRWCYdzSwyeVKCNpRuGE5oq3Hvzmbgxb8NODJoT9SP6F8Fx+SRDf8tKyG8i5b12NlLvG
	f8ZWUpxV4YVwZ0ZDs1jDtV3FCy76lYI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-wsWPxfYdMMardotSGtfMAw-1; Fri, 28 Mar 2025 01:44:34 -0400
X-MC-Unique: wsWPxfYdMMardotSGtfMAw-1
X-Mimecast-MFC-AGG-ID: wsWPxfYdMMardotSGtfMAw_1743140673
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e82ed0f826so1797347a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140673; x=1743745473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QutikAf8CzdrkFZy4fbFiEuK2llYIXRXcPk92xeA3Cs=;
        b=VpRxRi7nHINe42Zo6aE02Lvu8xjc6SxP62pmyrM3s8kiSn2uCo7uS/ihlmGHyVXBVB
         3Fakyqs71OimPh89EMBXaSKxKPGeocucEhtf2OuRDxBC0Xy4rkznOGjxKmjhl4cRug3k
         l+H371YMhaaCaCfJoX2Xlooiau1lUiSAolTja6Rw8iORlwBuL78k/oOMd3JjjyZb8j8W
         /XS8/b+bNAhdevmrzEBPUHmNTol5W8IwRYgFohQjdAztWXKHgz/kuPwHd/B0k0U815RY
         rlCDaKAENPykg0kbfHzuFCWPCg66Lj1XkiL5VQ3Za4PQk6YhKIrYHT4aSlQfgktPAh6Z
         W4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWJMHuKenx6gXQbUpNKCxe69dmid/o3k28c399CAAQcQLFNilQ/37+8P138spsvfI6DNb+FCiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5Y75P/SWZHXJTOHhZniS6AH+BPBI/eFBCCJ57ixdx7lihulv
	fnpvd6rBBxXWxsESPUPprmY90adcn2IWkai8Vs+QaEcaN1n2wVZZ+g/eT0+i4yywkWzne+PXbPi
	x/pcz+w5tjkzvn4uTQ5VRnnIZc13VgGhxOmXg2hYsgcg8c2FwfHFmEh38MedNjvQeuRQxyJLYQg
	fbLllUzh2t51zGuWSU9f2F+F6QQyJR
X-Gm-Gg: ASbGnctkBEzN44iIX/YoGiZKUAEdyz0Wu9zuyIXtNlTfQoXvXIFSnVhxrsvR5J+qa2q
	AMzJCnYfsceBPsPwsKq0DAhIBOhImbkYPm83zQFupVf8IgqBfLwtE6aTy1+czjYi80OCYN7iAQg
	==
X-Received: by 2002:a17:907:97d3:b0:ac2:842c:8d04 with SMTP id a640c23a62f3a-ac6faefc2demr579369466b.17.1743140673123;
        Thu, 27 Mar 2025 22:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJb11SZdo5gIc5Cpkf/Foi1hoNnZtutCCOu5oz1dTbJqGdShPR2w9s/elEfvXF2PGDrqfGoK9Uujk0qNWiQVc=
X-Received: by 2002:a17:907:97d3:b0:ac2:842c:8d04 with SMTP id
 a640c23a62f3a-ac6faefc2demr579367866b.17.1743140672665; Thu, 27 Mar 2025
 22:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-7-lulu@redhat.com>
 <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
In-Reply-To: <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 13:43:56 +0800
X-Gm-Features: AQ5f1JoqnO2FywuK703ia-cevncP3vP4nSex8V3LYpufvkKolFtpzyEbcR13XLU
Message-ID: <CACLfguXUUwpsyRV2L+wM4cFZ3qSbBNEht8J-JG4ppaLY-_9Sow@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] vhost: uapi to control task mode (owner vs kthread)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:58=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Sun, Mar 02, 2025 at 10:32:08PM +0800, Cindy Lu wrote:
> >Add a new UAPI to configure the vhost device to use the kthread mode
> >The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
> >to choose between owner and kthread mode if necessary
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> > include/uapi/linux/vhost.h | 15 +++++++++++++++
> > 2 files changed, 35 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index be97028a8baf..ff930c2e5b78 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, =
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
> >@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >-
> >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >+              u8 inherit_owner;
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
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >+              r =3D 0;
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..547b4fa4c3bd 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,19 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost dev=
ice
>
> Should we mention that this IOCTL must be called before VHOST_SET_OWNER?
>
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1(default value):
> >+ *   - Vhost will create tasks similar to processes forked from the own=
er,
> >+ *     inheriting all of the owner's attributes..
>                                                    ^
> nit: there 2 points here
>
Thanks Stefano, I will change this
Thanks
cindy
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - Vhost will create tasks as kernel thread
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> >+
> > #endif
> >--
> >2.45.0
> >
>


