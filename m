Return-Path: <netdev+bounces-176418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D5A6A2CD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B4B8A565F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D20224251;
	Thu, 20 Mar 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqy++d2u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290202236F4
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463536; cv=none; b=ANJ5CGwl1xGFZyIkWx0APp4g+8b0kLlS7FNfPmU0v0bAOji+fIcVhq8YkdOFr7PKBbfF2yrw3sfLVgDgOI3LM6mXw+/aeGtmN9aWIJEHzZr8W3jjWb3mS4QAbN6AHX1U/nueqQFPXhTzRAALaoW9PKmdThX61gXxoW/oGatYnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463536; c=relaxed/simple;
	bh=NvwTEgcqIQvgrhKODadoVctVr9hgRnboYsTfyWDoafM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmZxx/er45M0cUzXdvlz2dk2G0I10HjDgBdwPue7JL2Lkh4xry6ycLOmKEtAwMB7KhX6Nk3OzOMYr6k0eTIEuf1f3llaP4A1T9zgDJULZRnArbS38xL9YwUYMNJPuZBa3g9Ex2NODLpAMlpEipsh/lHIv+4/0D0JuKyqio4VJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uqy++d2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742463534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwCB+221NA1HlCUbvrDRan+r1+9WR16dtU0FT1clSQc=;
	b=Uqy++d2u8m7m4Ep2kff/F9HDCja6Dg3WNZA3dYa2OeiN7ad7yjxYlhTF5LbXkBNOJE4MLA
	s5Gg6T4qrBSxmxpR+KEn1YKV2FPTF6Bfth79cFnj1JR4kBrKKQstDOAnVYxDXLJlmCExOm
	89N+Pi6tjV4OpBRNUPFfRoGJsH5JOsU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-OmXRAGEHMF6VkTiJDC3xCQ-1; Thu, 20 Mar 2025 05:38:48 -0400
X-MC-Unique: OmXRAGEHMF6VkTiJDC3xCQ-1
X-Mimecast-MFC-AGG-ID: OmXRAGEHMF6VkTiJDC3xCQ_1742463528
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac384a889easo160901766b.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 02:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742463527; x=1743068327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwCB+221NA1HlCUbvrDRan+r1+9WR16dtU0FT1clSQc=;
        b=CL2L/CNGz5wx2ewix5bOCsIkwv/fm/wjlQ6dauBGu5fBevQk/lIrye+ZUlElxUFvfH
         VWEqh5Q73UAxKPP7HlZyX3QWkuTVjgZbRbJzcUc31Xe/ppO7MZurLS8wNistahKJRfYB
         9Ma09ovF9aP6t1UaV+NiHbAWU0mHMsi+JZGMPsS7bT/tXe7XsvQufVx+HbLLG70iI5HH
         UGA97781LTcG8RjGEQfk5pNvNY5dSk/EOWRNghhaIWu0ikNJdKeE0Vt/1MJCJwUNtQ0U
         Z+mfFDiEOzOEn5HKHQo/TnrlThguK/taV1mbn9VKWd9BHOHB8K/MXr3kXnCBuD9Gl01G
         I9aA==
X-Forwarded-Encrypted: i=1; AJvYcCXwyNKK9CQ/DAz1mjfgIH7wPGu1lSZaw4blIaROECdXiLBNK+JmC1tnoosg08wyF/B7x/Mzvy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXu6BOXKYr/umdvCs1EHLlTXtPCnCQ6pSxmkC/7rLjQs2BArA5
	dMIk/79Obw9eXw0UAb8sEywr1nifDF5Dbe0rwxwocC5rHJ9OhYrE+mE4AZqVMpXMbSmpCQZadk+
	3AJqxQiKZiEu0YwWAoIpL1NR1nv4V7HL8fYYYIBcML/jymoWxxeYDqRMNX44cReUUX3uVYYxIeV
	OWqGkzy8h7GPkdnv54S/gv8LFAquB4JZy9i00n
X-Gm-Gg: ASbGncvSZauPNUgwMA+alo23EvWpTIP149IugNzJuj1DYfBjqSfjRC8OEu/gJwHDdco
	39QoxJFRWZPF6fW18MY6tiqgk2OXchihuQ2nABoHoSx/VWuRMQvprDOBpjW0rXO4J0Mqs5Nu/6A
	==
X-Received: by 2002:a17:907:3f07:b0:abf:6a8d:76b8 with SMTP id a640c23a62f3a-ac3cdb97e7fmr266785866b.11.1742463526689;
        Thu, 20 Mar 2025 02:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS736rGGx2A8+WSczB6W42Z9CwPd0Gn80UV17ss/taXw3kNNvyUUG1eyIF1rnivt0a3MXU2if5rE8Mt1epTsg=
X-Received: by 2002:a17:907:3f07:b0:abf:6a8d:76b8 with SMTP id
 a640c23a62f3a-ac3cdb97e7fmr266784166b.11.1742463526251; Thu, 20 Mar 2025
 02:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
 <20250303122619-mutt-send-email-mst@kernel.org> <CACGkMEtheNa905789WT20=p84HN9-B6=K7XA8dpB6=jJV0kh-g@mail.gmail.com>
In-Reply-To: <CACGkMEtheNa905789WT20=p84HN9-B6=K7XA8dpB6=jJV0kh-g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 20 Mar 2025 17:38:09 +0800
X-Gm-Features: AQ5f1JqJXFebt85nCNRI8OoWt-Lrzu6HfqTrrWTpquRBRX6_lR5liGMiQoa1h7Q
Message-ID: <CACLfguW-x76eBcrbicLqLirWDPkpmPB=v48mxVRjWmUwg24C2g@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>
Cc: michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping :)

On Mon, Mar 10, 2025 at 12:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Mar 4, 2025 at 1:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> > > On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > is disabled, and any attempt to use it will result in failure.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vhost/Kconfig | 15 +++++++++++++++
> > > >  drivers/vhost/vhost.c | 11 +++++++++++
> > > >  2 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > > > --- a/drivers/vhost/Kconfig
> > > > +++ b/drivers/vhost/Kconfig
> > > > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > > >           If unsure, say "N".
> > > >
> > > >  endif
> > > > +
> > > > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > > > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > > > +       default n
> > > > +       help
> > > > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, whic=
h allows
> > > > +         userspace applications to modify the thread mode for vhos=
t devices.
> > > > +
> > > > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is se=
t to `n`,
> > > > +          meaning the ioctl is disabled and any operation using th=
is ioctl
> > > > +          will fail.
> > > > +          When the configuration is enabled (y), the ioctl becomes
> > > > +          available, allowing users to set the mode if needed.
> > > > +
> > > > +         If unsure, say "N".
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index fb0c7fb43f78..09e5e44dc516 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, uns=
igned int ioctl, void __user *argp)
> > > >                 r =3D vhost_dev_set_owner(d);
> > > >                 goto done;
> > > >         }
> > > > +
> > > > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > > >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > >                 u8 inherit_owner;
> > > >                 /*inherit_owner can only be modified before owner i=
s set*/
> > > > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, un=
signed int ioctl, void __user *argp)
> > > >                 r =3D 0;
> > > >                 goto done;
> > > >         }
> > > > +
> > > > +#else
> > > > +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n'=
, return error */
> > > > +               r =3D -ENOTTY;
> > > > +               goto done;
> > > > +       }
> >
> > why do we need this? won't it fail as any other unsupported ioctl?
> >
> > > > +#endif
> > > > +
> > > >         /* You must be the owner to do anything else */
> > > >         r =3D vhost_dev_check_owner(d);
> > > >         if (r)
> > > > --
> > > > 2.45.0
> > >
> > > Do we need to change the default value of the inhert_owner? For examp=
le:
> > >
> > > #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > > inherit_owner =3D false;
> > > #else
> > > inherit_onwer =3D true;
> > > #endif
> > >
> > > ?
> >
> > I feel it is best to keep the default consistent.
>
> Just want to make sure we are on the same page.
>
> For "default", did you mean inherit_owner =3D false which is consistent
> with behaviour without the vhost task?
>
> Or inherit_onwer =3D true, then the new ioctl to make it false is
> useless. And if legacy applications want kthread behaviour it needs to
> be patched which seems self-contradictory.
>
> > All the kconfig should do, is block the ioctl.
> >
>
> Thanks
>
> >
> > > Other patches look good to me.
> > >
> > > Thanks
> > >
> > > >
> >
>


