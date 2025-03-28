Return-Path: <netdev+bounces-178067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F07A74551
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE067188F8A5
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5A1DD88D;
	Fri, 28 Mar 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpoJcvSy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A542AA5
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150299; cv=none; b=pogI/nqfkVHe6ml3LcXKtV+o1SXsJVD96JLq0imCIyEKJczF/LAZJtBt/D6t5YDSiuVbnIV6UXQZjLz+BMM05rXViV0yQ5ZEDlvY2CpqsPkr8R3djtXTIfXjNcORW/1l2TmLG4io5/B2coeUGCYSyK3KJwy/H3wym3Ez9YmSWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150299; c=relaxed/simple;
	bh=2SQ18ucLJlA/WDehkdf9V9I8lMbGgu+W41AmkvrU9lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW69/3Hq5JXNDR7/JEpJFPURltICt4RwCrVygYupIAGl+vpuWybf8nLKCrl80PdXf9GXm84wmgdhXPV9QGuLRHTEQ9kJOF66Y83hq0euhoCIc1DRt/9QtNnQlDVEB1sccOXxG8k6weezoHjYAjatB560ig54bYuiPajPxP7XEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpoJcvSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743150296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BByPHc1EbJ+bRVfFsgitlx6Z4FNGFeovzxNX8sqbyWM=;
	b=MpoJcvSyAdAWsUnpoz7k3IKn4Go5l/b/adLXT14egEtes93bfY9yT5RG1IkSBa1ISrooM4
	ZF8cTZlx175jglFhLx3gV0hOInpvsNnmpnQtTKKDAWEbWVsxPh9Ky0vVPH5rlbwX/4eXYg
	EoKHXArNblyGw1O4eWChwBitAkZ6z0Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-gvB1LwWzM-28DQnHooz7MQ-1; Fri, 28 Mar 2025 04:24:55 -0400
X-MC-Unique: gvB1LwWzM-28DQnHooz7MQ-1
X-Mimecast-MFC-AGG-ID: gvB1LwWzM-28DQnHooz7MQ_1743150294
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac25852291cso172583766b.2
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 01:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743150294; x=1743755094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BByPHc1EbJ+bRVfFsgitlx6Z4FNGFeovzxNX8sqbyWM=;
        b=XLoWAYREr2I3TUgglbaiic+oFjO6AnkrcpgXxAmdAUSuoMUvV1aAQ0O1HFdAukE3gl
         w6zC6N8gylJhbVTrmRc7ROBnqgJVTboP+tMbuhxJZymeai/3Rqk9NyUfcYDjsng7RiKh
         hPZ2U+pcOzeqegjLHlSSNbYgdyK920/AsTI1nmxQYb6dEkDedAR+ecB51lcQm+mSkf/S
         jCXSD+pa68KMpf8s5txbm4W6Mn1FkuXyewCF701MuIry6ZPtSSdFVASGLJK5kmqRhNzn
         I+qHHlLUHUBhqKK9L+WJIg5htBFzBpu/2QF31dwMw0GXsFucWHIytSKr9Ehaa3hLROGy
         IJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU80IZUnngwpO5lMLcAMKse3LiNbrNjUlVSOVcOTNNRbuQe82W1+LknPbLaN7+QoroRJmf7Cns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOHy8XAnoJYsVs4P38JsZ6HBc3AS9F2zfUFQpk92ABPeKVZJr
	wh+iPniKIFm//x++5TDLHm+Ri37zv40NO3RVGmc980G9/iQDwroNe0gjmS1Mgxy4LS+cscuAs8b
	Bacf6uvCLjHtiByAWO5OWlj/UBJlGeSiWVT8Eun9HZvpixFLQYGLBRVUnlHFyoQcZdCOni7zeso
	5AlNew4yjJOa/jGRrcKfCdisIs+Peg
X-Gm-Gg: ASbGnctm5mkWEzxI1aSZEgEcjR0CWPxGgKuEpS/jw2ss5KGPYubZMn05ovbdM/UiKWU
	UBBMKGvpPJuuUc/d113o6uiIwQrfw4tEpovqhRp+6hJyar66HSDxp7eHEOhK5rxlQhFBOuNLyIw
	==
X-Received: by 2002:a17:907:3da1:b0:ac2:6bb5:413c with SMTP id a640c23a62f3a-ac6faf45fbcmr606738466b.31.1743150293892;
        Fri, 28 Mar 2025 01:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtMhfeTWQPQjJeKYr+nJHbqXTHzDbGeqlUciCnVAp35iT66VTiKxpvEvBTFOnIR4IcWISTOodMTXSNsbNA918=
X-Received: by 2002:a17:907:3da1:b0:ac2:6bb5:413c with SMTP id
 a640c23a62f3a-ac6faf45fbcmr606736266b.31.1743150293417; Fri, 28 Mar 2025
 01:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com> <20250303122619-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250303122619-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 16:24:16 +0800
X-Gm-Features: AQ5f1JqvVP-O68vnR03mHsDRfnjJbKsFvNhVjO1Pg4znL65FpHw8MZuudqkctsg
Message-ID: <CACLfguWmXVDr6hgGvCEsNBpTEd-3zePR2fMk6BhBf7z8F4r0uA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> > On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > is disabled, and any attempt to use it will result in failure.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/Kconfig | 15 +++++++++++++++
> > >  drivers/vhost/vhost.c | 11 +++++++++++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >           If unsure, say "N".
> > >
> > >  endif
> > > +
> > > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > > +       default n
> > > +       help
> > > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which =
allows
> > > +         userspace applications to modify the thread mode for vhost =
devices.
> > > +
> > > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set =
to `n`,
> > > +          meaning the ioctl is disabled and any operation using this=
 ioctl
> > > +          will fail.
> > > +          When the configuration is enabled (y), the ioctl becomes
> > > +          available, allowing users to set the mode if needed.
> > > +
> > > +         If unsure, say "N".
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index fb0c7fb43f78..09e5e44dc516 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> > >                 r =3D vhost_dev_set_owner(d);
> > >                 goto done;
> > >         }
> > > +
> > > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > >                 u8 inherit_owner;
> > >                 /*inherit_owner can only be modified before owner is =
set*/
> > > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> > >                 r =3D 0;
> > >                 goto done;
> > >         }
> > > +
> > > +#else
> > > +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', =
return error */
> > > +               r =3D -ENOTTY;
> > > +               goto done;
> > > +       }
>
> why do we need this? won't it fail as any other unsupported ioctl?
>
Sure, will remove  this
thanks
cindy
> > > +#endif
> > > +
> > >         /* You must be the owner to do anything else */
> > >         r =3D vhost_dev_check_owner(d);
> > >         if (r)
> > > --
> > > 2.45.0
> >
> > Do we need to change the default value of the inhert_owner? For example=
:
> >
> > #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > inherit_owner =3D false;
> > #else
> > inherit_onwer =3D true;
> > #endif
> >
> > ?
>
> I feel it is best to keep the default consistent.
> All the kconfig should do, is block the ioctl.
>
>
> > Other patches look good to me.
> >
> > Thanks
> >
> > >
>


