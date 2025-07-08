Return-Path: <netdev+bounces-204992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60929AFCD02
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B661C1BC3B7E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA212DECD4;
	Tue,  8 Jul 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeXY37Wh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61C2DECD6
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983860; cv=none; b=nEmhuMmbIQma0GZ/GD4qNkio2TjEYGp5B5fBefq1KxUQehB1d+orSFBQVjmQ/Bev+PjSS3Q5ra0GBDVliVhKfkQhCiahajNgXmT8+4v9b4JQQgkybOxd7vGou/KqOaYYt80efEnJ7VFKksljSO4xDmU/gBb4RzZoCc80rtCxRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983860; c=relaxed/simple;
	bh=NVjqdhu5MdSRKBGNek4XlylKWFxybxxXICy1cl8riNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMOqcZS3e+/ocu/8JupltRG76wfkgXbPuFjHwPn7pbEAt/TbeUBEAy12ZOPuu8yMj1ju9JAuw5JZnn5+86L/cmST++9JmzxYnRYP0pTbxu/a5C2JWZULnQw7akzma8DhKltuVa6llbnqgcp0LciJgEwOaCsCh6995Lu3P4wfAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeXY37Wh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237f270513bso153805ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751983859; x=1752588659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R+ttIE6jMf85AIcqVLpVvfjGMpffrgdz2K6zZMM6tY=;
        b=GeXY37WhAG3dHBiITnLnvOl2cbofgIzW4PXB8596IGPmGf195owCsBjyP/dRJXvIF1
         JrdDt3Mh8poWQLD9lGw6ePoZij4yNkcWYGpZwonzyfQ96sDoimRuw1THfx42pYsznnuS
         KTR2gVj3dyIv/GjyHgF60lhF6sLADEKUI7PqcoaZqMPANUbyB9Qr1mnVh23Hk8/dHw5d
         icWkpfzOSuIBqjBuui9nK+tktIdtLE6ArdInrBRAHmCUcfcyO17KBEgSC9gpQesCGXdV
         vQAwokPhrYg7a4Y1U/mf+1abtD/dagQPxR6c2T63kD0E7DxDI0pr6Rv+MJMFY7G1HPX8
         ++mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983859; x=1752588659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R+ttIE6jMf85AIcqVLpVvfjGMpffrgdz2K6zZMM6tY=;
        b=r+Ko1apwiWMYCjdMcNL05O5fNPBSAdcsNyimuiTEcRYOB1bU1+BEC0QXOKRtXpJzaa
         dhlVWEmt6xCXfgKbRuW4k+qC9P5Ekb44B0aN9aQ1SccM8KglOOmkSu5SYKyVnbBcFvy1
         KncxBnQRuSAXl7GOzgGzePxfCYde4wmCvOuQHnHo9UeVAWOf7HH+dfZm3QRC8jv8gYL7
         iBH+gEl2T5wNKRZ8y6mnPThWewrIux6GntxG44fQw370VnjPGXrFSBChnVF5dolhVLhd
         tqd/MvROPaCa/6rRuqaKNogj1k1im/v7JhiQsY5mUSvqn7o/BxUnZBWHPUgRI0+uYD2T
         BaoA==
X-Forwarded-Encrypted: i=1; AJvYcCUlur7cNDp9pQKxJgYW8aBADTdBdEoM8cVMQh6WRhdbWATy0xRXgPgHRIs0KBpUCq9F49H0gSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5oQadKP6rJ7dBIOf+FgqOGkYECu655epR7fXiZmGZP8WPdsQ
	vjbFt+cMQELInnBwrWpP/GtV/rO263TfHWDS2DDg3yXq4CnAZt8GNeb1MIDa7cnQGcMNiJ28Mtc
	qaHIqPVY018+UMF84S+bpxqfMYSNzFCwHn3mHfzPO
X-Gm-Gg: ASbGncucTm3Ln5fWBw/xQPi88K7J6Tnd7QXSQzMRmdpYDp3TIEDK9yjdEy9bthIvCBI
	8+CVpbtp74Kk+mDxX0prg3e5Tb6wXxLFD7zG8CMoLqqaqL+reAao1qOlhEhyna2dSXp1CPclkmu
	F+xSeVysrefZanZCQ0+QRzTiPFCmDfDCcgEgZbjPuaLY0P
X-Google-Smtp-Source: AGHT+IGgR3YJL4Cv9d91nITpzqfLlvlKCqkAxqZa6HzK8G9frbE1twuSpJ0F3xPbZVEu+sQavu/vmiArmEM2cu+TwIU=
X-Received: by 2002:a17:903:124d:b0:235:e1d6:5343 with SMTP id
 d9443c01a7336-23dd44dd4f0mr1488785ad.20.1751983858310; Tue, 08 Jul 2025
 07:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702172433.1738947-1-dtatulea@nvidia.com> <20250702172433.1738947-2-dtatulea@nvidia.com>
 <32cb77d8-a4a5-4fc7-a427-d723e60efc59@gmail.com>
In-Reply-To: <32cb77d8-a4a5-4fc7-a427-d723e60efc59@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 8 Jul 2025 07:10:45 -0700
X-Gm-Features: Ac12FXwxO67LrfeF7nw7Zs98ROVPk3-KRGG03IeOj2L4OXF0Bem8veXcTjOIapU
Message-ID: <CAHS8izP5rLBYq-cdbEVmuaHBhFAd2ayRmvoiE-fqxr48zMp-qQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com, cratiu@nvidia.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:05=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 7/2/25 18:24, Dragos Tatulea wrote:
> > For zerocopy (io_uring, devmem), there is an assumption that the
> > parent device can do DMA. However that is not always the case:
> > for example mlx5 SF devices have an auxiliary device as a parent.
> >
> > This patch introduces the possibility for the driver to specify
> > another DMA device to be used via the new dma_dev field. The field
> > should be set before register_netdev().
> >
> > A new helper function is added to get the DMA device or return NULL.
> > The callers can check for NULL and fail early if the device is
> > not capable of DMA.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >   include/linux/netdevice.h | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 5847c20994d3..83faa2314c30 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2550,6 +2550,9 @@ struct net_device {
> >
> >       struct hwtstamp_provider __rcu  *hwprov;
> >
> > +     /* To be set by devices that can do DMA but not via parent. */
> > +     struct device           *dma_dev;
> > +
> >       u8                      priv[] ____cacheline_aligned
> >                                      __counted_by(priv_len);
> >   } ____cacheline_aligned;
> > @@ -5560,4 +5563,14 @@ extern struct net_device *blackhole_netdev;
> >               atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
> >   #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__#=
#FIELD)
> >
> > +static inline struct device *netdev_get_dma_dev(const struct net_devic=
e *dev)
> > +{
> > +     struct device *dma_dev =3D dev->dma_dev ? dev->dma_dev : dev->dev=
.parent;
> > +
> > +     if (!dma_dev->dma_mask)
>
> dev->dev.parent is NULL for veth and I assume other virtual devices as we=
ll.
>
> Mina, can you verify that devmem checks that? Seems like veth is rejected
> by netdev_need_ops_lock() in netdev_nl_bind_rx_doit(), but IIRC per netde=
v
> locking came after devmem got merged, and there are other virt devices th=
at
> might already be converted.
>

We never attempt devmem binding on any devices that don't support the
queue API, even before the per netdev locking was merged (there was an
explicit ops check).

even then, dev->dev.parent =3D=3D NULL isn't disasterous, as far as I
could surmise from a quick look. Seems to be only used with
dma_buf_attach which NULL checks it.

--=20
Thanks,
Mina

