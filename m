Return-Path: <netdev+bounces-157570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0026AA0AD71
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 03:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDE63A64AC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657554315A;
	Mon, 13 Jan 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avwzXWE8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60342065
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735816; cv=none; b=BXjQf/PhKc3frNlpACtvpdl+LF9Z2l11If5OybYkMfR4OgzARqNpZc5frFp9L764wlo9FgJnAgZ4riMVjthnbSqfhLFV9MkiZKdxMmPCf3DGnJEdGni8ljnNeQ5Q3NFAjMx52CANko+7cmnm420ubmT9aYfvnWeUDTBjqIChDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735816; c=relaxed/simple;
	bh=33atN2c5q5MV+wEeaURs0G2Pk1+6beFwxSOU9ZHJ4zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDhV+j8YlM4ZX+Uw5AIlb+pnyo97EPApKMngWTZfrYNMBcV+Pi4uT6IEUHgH2YoLkbKmMzagRjMAIHHEqe7byhnAwLlC1I8Noa2xi5Bp1+h8EzFO85zAHOOdhz5j2H2C2/p/dqk7tPYWlyzUqUlocO6f2zqpvHCodT2ypMhwgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avwzXWE8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjbGZVtKCla7smHmd/NdDBnCwHIsn6ZbQJ8PT6NLfpE=;
	b=avwzXWE808V1GDdWOFBizTtqII0M6iBe3lfkWM9GcXKXDu1dBoh1smszeC5FUkwhOOk5Ar
	u/x/dHqoL06otZJf6NgUTXMObMQ3R8TVyeOSaeiGHRNF6EH1qKI1Ob0l0PQzQXWsKpGjgj
	ay4+5mAxRkgFhDb2NtRxUeyRl17ugpM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-IS-2yEJJPnGw2y82Ten3aQ-1; Sun, 12 Jan 2025 21:36:51 -0500
X-MC-Unique: IS-2yEJJPnGw2y82Ten3aQ-1
X-Mimecast-MFC-AGG-ID: IS-2yEJJPnGw2y82Ten3aQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa67fcbb549so482897666b.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 18:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735810; x=1737340610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjbGZVtKCla7smHmd/NdDBnCwHIsn6ZbQJ8PT6NLfpE=;
        b=ss9fzaqnm6L1Kw5Bw/XLUUYMgV+q1obV2WEgxGYvW6OeLzfUoSgfcf2b7nlustr373
         03VYxUAwibpUQLQqJiZAPs8mT913wdWpp3mYt+3aCznOrCc+3j8bi25hGwVFkTAqNd3l
         d8AUFdLrfKeOwnannLIvBVCv80hjyNTqXnuBxrcrG4wx4dkIdeoYxzeiqlaU0BKsa0DT
         AuMJ5MDUqaOe7SlSezGZnBC5EO7q7ALfWU3yyD1tWNGZxdLnyCVj6bkYgQOfgmFpsKrU
         yZLtz5zfegVBLYl5ZFyCRWxuYs7RYgofH5O3ATCn7q5t3wqTGwF2gXHNHLEXZuWkuNNf
         8cfA==
X-Forwarded-Encrypted: i=1; AJvYcCVw7B8KJ9sPg9OkFKtv4etNq5SExIzr3TK2dTFtSbLVM4MTwAVOkKK8XLYOjte4RNAY4wFlZx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYcn374vTa+uH+2aE8rbEAm4oC/NQY60VUwzWywmirkwsm7ek
	hoAy89NDmfO+fkNS+Xfl/JX+5hqXd6JrFjZFiYDiXFYwfNOylTXYmWelQHw5Vb1La2ZuxQD3ssX
	JhIljIgiZGYsRw0bATTrTmdmuzTjYBwKgeWreH7Ol0wbp+O1kRIpVYon4Ns2PgUS7/pMQ0WqdOO
	zQ1MYZekEQA1Qf8+jBSgGUmUU9gvU0
X-Gm-Gg: ASbGncu84T4Nsp6r0LQm/jUxHrML8wyOm5Q/1Zrw2ylt8uk3RlWcj7QWUlshgJ2ThXE
	qwMmhBw8ODZC4C6VF2HHGwvmI9lRgctbgtUJOWTk=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id a640c23a62f3a-ab2ab5f6f1cmr1637968466b.32.1736735810510;
        Sun, 12 Jan 2025 18:36:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaKJ+N3gTUuKbOesPp5xfJ0dnGbxjrRb2BcOPB+C8M6hWol16j29uHgmFXOoNXM/nAg72lLh9aCgqO/JMIO6Q=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab2ab5f6f1cmr1637966866b.32.1736735810150; Sun, 12 Jan 2025
 18:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108071107-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 13 Jan 2025 10:36:12 +0800
X-Gm-Features: AbW1kvZzKRu6zgb1uk7BzXKIMdzPKzlbctv6VkNibULKkSY0RJRzGOOzIN9zHaQ
Message-ID: <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> > Add a new UAPI to enable setting the vhost device to task mode.
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Good.  I would like to see an option to allow/block this ioctl,
> to prevent exceeding nproc limits. A Kconfig option is probably
> sufficient.  "allow legacy threading mode" and default to yes?
>
sure I will add this in the new version, the legacy thread mode here
is  kthread mode
I will change these commit comments and make it more clear
Thanks
Cindy

>
> > ---
> >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> >  2 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 3e9cb99da1b5..12c3bf3d1ed4 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
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
> > +     if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
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
> > index b95dd84eef2d..d7564d62b76d 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,22 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the v=
host device
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
> > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
>


