Return-Path: <netdev+bounces-160166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0276A189CA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 03:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767BC188835A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31113DDB9;
	Wed, 22 Jan 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClnifUr0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F6249F9
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737511685; cv=none; b=LReSut7GNxWIuLj5s6pzQTnjA01mlhTOyXNYnsyliOWciMz4jBVgfyoc2l0Nl55XGso934LgIyzCPbKw44nZuBwKBO9PCkDe1fMas/8XGHNldnytW4TX/L8YddB+iSDrG7G1wIq54tKqz7I1tk+1+2yUnIY19PoXV0S7m1QfLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737511685; c=relaxed/simple;
	bh=ls9psBx7TPq9ztMIH0aRG9uDFRZpcTRyuBXhHRTLCbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCRpemPUWpxaWj4clx5gKkOHaxLvNUlaD7PNCNgKmrGyFHn6d4G+twK+O0yZDE35fLbI6CGyrLdYefagpq+ckrMMRjwM/ZSNltXve6sGWkLfWcvglxlK9vskXsAdxeDe5CSYEGLE6hm6xBcVmDUVLvB7xD1BY0VAFEK1BqCpL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClnifUr0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737511682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSiDnxfmG50D8AZ5O1R9UgcZ+8BuAhlML/4D6Zy6YNo=;
	b=ClnifUr0oLHel8SlO+2Wo4XoOwJIwBSht01L4Rg7gw5c2geaj6ujqtDPY2gTbyDU/T7SLN
	tpdUs9x1/s8WCdn3FELgjzp0FSdRTQfgF0iTKBD/F6uMvnn8N8M1MgfM7zY/SrXBPQ0wtL
	IGE4gGBYRzGaSJtY95YGuwqTzGTsgJU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629--YTw2AfXMvC8yhaF97RXTw-1; Tue, 21 Jan 2025 21:07:59 -0500
X-MC-Unique: -YTw2AfXMvC8yhaF97RXTw-1
X-Mimecast-MFC-AGG-ID: -YTw2AfXMvC8yhaF97RXTw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf8f016bb1so665684566b.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 18:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737511678; x=1738116478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSiDnxfmG50D8AZ5O1R9UgcZ+8BuAhlML/4D6Zy6YNo=;
        b=d9MXdRb5+lGP86Opbea7UrPSfORvAQ3a5jPQjini3EEEmPuWP58xK/t5/l/tMNt5Yt
         JBeVd2M6iaI//DaxTtX8yNe90gw9S0mlLo3HWXRbW0soTCAqr0UM3tmQUHr46YnTfBgj
         S8ia5xfXg30F/HmPxEtS9VnwiWultP662HU+BnddGm1Y2/PEA4fx3mMUCRg/DcTRxxLn
         PdBeR+5bHIK/GqM317zSKwSgqYdbxvPLAMY/lLYtWOHAiurwQhccHMOGAWYlgAu9hnDq
         9xh2cdmzvDcvZmZ+/Db7sNcG0y3EP9ecLNOVaumfH7TNJbB9l/Fnlz+1NKD3KEmCvzKZ
         lbCA==
X-Forwarded-Encrypted: i=1; AJvYcCU3EsxUxS50CHMVkK5IG5vzqw0ap5RzJ5ikK1erbUa809YBBNx/EDICySQbsnpifhKFaw9HeiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOSiUOZNGtlOr4Qk8CHAOUhd69buorcgS6ZI8n8hJo26+966e
	O9scXmRB5uVIAs34//2PP5Z25andfNK8MmeBMltb8cifRp3ywO039WBF7iRqeNZoNjw2XkgswwN
	QZC0aE3PJw/nwqsj+0twEd0oxrE5acqEmV/pNgkd8pus4Y27SdzRXWCXrdaYNv8JRVUJpVpF6yJ
	zYud/WdJ3pgkmERSSx4d56rrbZ+OiF
X-Gm-Gg: ASbGncvKvG9mqBxniX6EXKnwKWnBO9hEENMbcCtVt0RcDkfIJgNtZn7FObmbzh16b0a
	3Aqn5HJXVm5FepgNm1ELcYIm9UBSC4i4CP0plSHCSrZXMl2sHXzSc
X-Received: by 2002:a17:907:3da5:b0:aae:b259:ef6c with SMTP id a640c23a62f3a-ab38ada039bmr1677540966b.0.1737511676957;
        Tue, 21 Jan 2025 18:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwXFN3ZUYNclGwr/w4DStIS7fDxdix4SunnRl5ysFfEyziUEJ9MDWE4e37xf9sRCWG7qUgv33RbTGMhX9AwhI=
X-Received: by 2002:a17:907:3da5:b0:aae:b259:ef6c with SMTP id
 a640c23a62f3a-ab38ada039bmr1677539866b.0.1737511676585; Tue, 21 Jan 2025
 18:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org> <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
 <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
In-Reply-To: <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 22 Jan 2025 10:07:19 +0800
X-Gm-Features: AbW1kvataw9AB8chSnUK8KAVGfVrKXAdOPIKjIbzy_TzUq55ESNJ0F3WLqwBZa4
Message-ID: <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping for review, Hi MST and Jason, do you have any comments on this?
Thanks
Cindy
On Mon, Jan 13, 2025 at 11:09=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jan 13, 2025 at 10:36=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > On Wed, Jan 8, 2025 at 8:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> > > > Add a new UAPI to enable setting the vhost device to task mode.
> > > > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > > > to configure the mode if necessary.
> > > > This setting must be applied before VHOST_SET_OWNER, as the worker
> > > > will be created in the VHOST_SET_OWNER function
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > Good.  I would like to see an option to allow/block this ioctl,
> > > to prevent exceeding nproc limits.
>
> VHOST_SET_INHERIT_FROM_OWNER is for fork() alike behaviour. Without
> this ioctl we will go for kthread.
>
> > A Kconfig option is probably
> > > sufficient.  "allow legacy threading mode" and default to yes?
>
> How could we block legacy threading mode in this case?
>
> > >
> > sure I will add this in the new version, the legacy thread mode here
> > is  kthread mode
> > I will change these commit comments and make it more clear
> > Thanks
> > Cindy
>
> Thanks
>
> >
> > >
> > > > ---
> > > >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> > > >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > > >  2 files changed, 39 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 3e9cb99da1b5..12c3bf3d1ed4 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, u=
nsigned int ioctl, void __user *argp)
> > > >  {
> > > >       struct eventfd_ctx *ctx;
> > > >       u64 p;
> > > > -     long r;
> > > > +     long r =3D 0;
> > > >       int i, fd;
> > > > +     u8 inherit_owner;
> > > >
> > > >       /* If you are not the owner, you can become one */
> > > >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> > > >               r =3D vhost_dev_set_owner(d);
> > > >               goto done;
> > > >       }
> > > > +     if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> > > > +             /*inherit_owner can only be modified before owner is =
set*/
> > > > +             if (vhost_dev_has_owner(d)) {
> > > > +                     r =3D -EBUSY;
> > > > +                     goto done;
> > > > +             }
> > > > +             if (copy_from_user(&inherit_owner, argp, sizeof(u8)))=
 {
> > > > +                     r =3D -EFAULT;
> > > > +                     goto done;
> > > > +             }
> > > > +             /* Validate the inherit_owner value, ensuring it is e=
ither 0 or 1 */
> > > > +             if (inherit_owner > 1) {
> > > > +                     r =3D -EINVAL;
> > > > +                     goto done;
> > > > +             }
> > > > +
> > > > +             d->inherit_owner =3D (bool)inherit_owner;
> > > >
> > > > +             goto done;
> > > > +     }
> > > >       /* You must be the owner to do anything else */
> > > >       r =3D vhost_dev_check_owner(d);
> > > >       if (r)
> > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.=
h
> > > > index b95dd84eef2d..d7564d62b76d 100644
> > > > --- a/include/uapi/linux/vhost.h
> > > > +++ b/include/uapi/linux/vhost.h
> > > > @@ -235,4 +235,22 @@
> > > >   */
> > > >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,    =
   \
> > > >                                             struct vhost_vring_stat=
e)
> > > > +
> > > > +/**
> > > > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for t=
he vhost device
> > > > + *
> > > > + * @param inherit_owner: An 8-bit value that determines the vhost =
thread mode
> > > > + *
> > > > + * When inherit_owner is set to 1:
> > > > + *   - The VHOST worker threads inherit its values/checks from
> > > > + *     the thread that owns the VHOST device, The vhost threads wi=
ll
> > > > + *     be counted in the nproc rlimits.
> > > > + *
> > > > + * When inherit_owner is set to 0:
> > > > + *   - The VHOST worker threads will use the traditional kernel th=
read (kthread)
> > > > + *     implementation, which may be preferred by older userspace a=
pplications that
> > > > + *     do not utilize the newer vhost_task concept.
> > > > + */
> > > > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8=
)
> > > > +
> > > >  #endif
> > > > --
> > > > 2.45.0
> > >
> >
>


