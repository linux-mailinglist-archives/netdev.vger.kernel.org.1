Return-Path: <netdev+bounces-184332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E820A94BC0
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C53B1E82
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998F25742E;
	Mon, 21 Apr 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQKqd+bg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7DBA36
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745207183; cv=none; b=nft4Fv3jXu0OAVldXqEwkcT74quvxP+ZVecOA0iV9IueV14Tli8gHIf2RJ1EupG/PBvMY5TIiRXwS0RKT+uRND1XMY4Ggr1MSfETw06FsTEtQdDriYxT9jSdPLhFHtSziteCzu7EzH1/UgX/WV/ZP1CtyL0zHrSOOcW0Jq29t24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745207183; c=relaxed/simple;
	bh=WDWbIvSU773gRjsi9Bt8QnyBPdTx2jqcvGDaCCgw+xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASzqBfx89IkTilaLPV9+eNICbP05jMKudPJAvZCMt3WG8AuOO3AEqcl9uzCrn7WsoJD3EcJFoUNuGwO+SkA3cGnZVqxH/blkBzyPdEtqRAMcThBInrnUKJQZK//W1OYnpUMWH4WrnWKbgGh87azYO5W9T1RHT/BpXgQhyRwawRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQKqd+bg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745207179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MmNHzTsOXktJvVrWiuSPufs0RXIPgJ4SHes9h94zrI=;
	b=eQKqd+bgySb3n2oFtJqPLi1otd/z9soAeg19HEUnkJcvX4/9NQSeKbMFZZlWUH4AVTRoav
	joar3A38i2HZBznNOsl5pDJ2iTIJu6dtSEIc8EFT20Wa4HOx1ZJl1Ags31R84rFfq7FB0f
	9A9qaclVCv0chkEJlqf5iOUyPTikz80=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-1iwne2ybPbyLVfTdoqUApQ-1; Sun, 20 Apr 2025 23:46:18 -0400
X-MC-Unique: 1iwne2ybPbyLVfTdoqUApQ-1
X-Mimecast-MFC-AGG-ID: 1iwne2ybPbyLVfTdoqUApQ_1745207177
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-523f74690afso792473e0c.3
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745207177; x=1745811977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MmNHzTsOXktJvVrWiuSPufs0RXIPgJ4SHes9h94zrI=;
        b=kdwJRoShmhBxcntfJ8YQjumvRtOOR7R5kAVnXzQWmAyZIrpwXSwLHPvJRLAtEJXjG3
         8WwgQrcPeADCIWt6GoSuIeQQyrvPjKyZz1tAGyCV5W0b/Pu8GOhgrAWNxoLbC/QOBV5/
         YZcgFp7T3ht7tV1vMtTrOnLyrg0bAxDQ66txPkRjmkWyDGLCCm5ajhHksSI4S+XuZv06
         Cp6qOAeJpS/C9XRZlQxVpgw1jAD+Bx/hsCTc9/RX9DKmxYeKdPkj3Ie4V6vWNAj4VSFQ
         buIB94b2sSBsEgExxobaU6ApWl4616fdrUe1duX9srF/4mxVlC3hD5Uj5WVdiLj/HVpY
         oefA==
X-Forwarded-Encrypted: i=1; AJvYcCVYK8GjBGsGeUzyWm+OEVAhtztafkfWc5z/NpTctenLeSI9657btt2nDapB/MZXFgsBkpbHcsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMQH7u2WNLCuqX11IoL/WZYPisKN0juRtMMcScuvggAnVJZsr
	GlhH627J3do/xS2zBU7TDdI0im8GaP6fBNUMZKMmgd8xOHZ8fehQ/0rb+m3pU1qTLeotOJ4gKKT
	amOifvNoPqduWXFiPs8w5HwJFxOOhBSYtTil/dSvsoqoLh93bpWfffT66nDwKPVCrK0APa36XWi
	n4DpzsDtg0VrzlEFDBqbZ7NRhk1qxz
X-Gm-Gg: ASbGncshmfmaIC4EVgjyPestOBpWKwr+9tSJgCWwmtmfiiZsjrzS1hVhSj3rGv66JLf
	hh0wnyqKx8PO6WXf1bW9uBWEFgG2ZPJUJiouXEQxQGJ8DZkga05YX6uJYXcZfwS0QbPiXVA==
X-Received: by 2002:a67:f085:0:b0:4cb:5d6e:e6c8 with SMTP id ada2fe7eead31-4cb80128dcamr5512633137.9.1745207177639;
        Sun, 20 Apr 2025 20:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjeQwKCOfHzvN3lUTtfHim7VBEQTh/TCbfRNy3QnFlzQ8hxPYthyT/QZOXVv5k8ci+MMU+1s1BplANJT3lPBo=
X-Received: by 2002:a67:f085:0:b0:4cb:5d6e:e6c8 with SMTP id
 ada2fe7eead31-4cb80128dcamr5512625137.9.1745207177278; Sun, 20 Apr 2025
 20:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
In-Reply-To: <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:46:04 +0800
X-Gm-Features: ATxdqUHeO85TtbIdV-aJBSr0-Cr6xqgcKTQNuiFED9cSXLQ7VllgtcbY3bYiDRg
Message-ID: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
>
> I think we need to describe why the default value was chosen to be false.
>
> What's more, should we document the implications here?
>
> inherit_owner was set to false: this means "legacy" userspace may

I meant "true" actually.

> still be broken unless it can do VHOST_FORK_FROM_OWNER which is
> impractical. Does this defeat the purpose of this series actually?
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c |  3 +++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 020d4fbb947c..bc8fadb06f98 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >           If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +       default n
> > +       help
> > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which al=
lows
> > +         userspace applications to modify the thread mode for vhost de=
vices.
> > +
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to=
 `n`,
> > +          meaning the ioctl is disabled and any operation using this i=
octl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
> > +
> > +         If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..568e43cb54a9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >                 r =3D vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >                 u8 inherit_owner;
> >                 /*inherit_owner can only be modified before owner is se=
t*/
> > @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >                 r =3D 0;
> >                 goto done;
> >         }
> > +#endif
> >         /* You must be the owner to do anything else */
> >         r =3D vhost_dev_check_owner(d);
> >         if (r)
> > --
> > 2.45.0
> >
>
> Thanks

Thanks


