Return-Path: <netdev+bounces-137222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA4A9A4E6C
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581E71C219C3
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D32770E;
	Sat, 19 Oct 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEmR7A/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944331E48A;
	Sat, 19 Oct 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346116; cv=none; b=fMJAdwJGsfsTl0SyKSTLLNjIkfTSVa5dxvV2PX8Dd5PzpZY/2VXqETqHa+z/kPPI1zdP08N1mQGlHcR93VYXMTgpFdflsW6IJyvzg21nY8RREL/OuPbFxhQ83Qr0RV37+SfWY5eoMmUtjMGhu5vZfODhPrNGzDmKIitPxqj6AB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346116; c=relaxed/simple;
	bh=IrgiAjib0KZYOu+o4DmsmotW6DwjJuvMhmIahAtPlKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np+3IQNAmoQP0hICELv0SD0nzSlBHd8bDKAjOMbqX9N/k/cJ6Wa/TCJuovNGt/E8pqLi/x2lGISbi81I0l/Xq6JqbX5gmH6unz1r5VjVkHg3EPNYMSIVEif+93nikmLGiZ4tMi9wU10tkBDUE4SlyRt975/R1zvgqm574xS2VVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEmR7A/0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso7005153a12.0;
        Sat, 19 Oct 2024 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729346113; x=1729950913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrgiAjib0KZYOu+o4DmsmotW6DwjJuvMhmIahAtPlKE=;
        b=mEmR7A/0E3PRHPrl4Ya4AmkN+vb6lNXrFHHGo0K6vHlveRawigDRduPOyXTM72EKQW
         K1X32dDNSggxR43RzYOIIci2qZ/Ii3Rm7yd9CXQwvZtzln8j6QfFEnssAxa/cXxPL+95
         ZLdFVmvYKbJcc4qw1rzBn9yrno0L6PQfakUwB9RiYDosy7ys0ZJZXyXYU1RyUB7z+FG6
         lL1xDhQwnPTFNpl3493Z1JFgAmdeTiv4WAMGfVnOwFXwP5ErupgTJ1CquHRyFfNOoIlw
         Swg6KEcVlsv5B4ciMcCoPff6qPNyfQv6rUXEeR0h2PuZC+VDjJkr2xQY15Ri8rg30FAX
         WFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729346113; x=1729950913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrgiAjib0KZYOu+o4DmsmotW6DwjJuvMhmIahAtPlKE=;
        b=hsnFFREIhXgFufKLvz5ErWNN/55mJBK/G7REQo7L5RwpuelQdac6arR+p832xshZ3v
         Lw33BmYq4O8PuawYBKnofsT3aaWdFp6lb5VtGeeSUhRPP0i6Rl9VnjSFzXUhK3D+phfp
         Z+D8m1ZYya6dHV/i3xI9eT537hVjfK/cVJ85aKOeAoPH8XYCW/jmg26eqTB9cJJlEfWy
         EusdiDPn4aJ7rtR42AnkWaF510C8GMKN9SKj5kY7BE749mwYJ2a/JClddvN3DBUqL9wa
         Dbe4IgtEMtgaegVSsJDsERsMfwbuisHL87VjFYnp7u9cJ+dAbZJ/s33spPPakVO4/Gz2
         n3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+4eq3z+dB016P6vl9u4TrfqeGmdd4VQMYu0ESemr5yDFCf/B2+emgbIowxz+K0bYHq8MgUnH4Qpg=@vger.kernel.org, AJvYcCWxc1Rjn3ilbfmF1qeuGHJJp3ABGKs7RDv2KS7vMQv5wBT8AUqDWgUeaarATZv6S1tnVvx+FnFX@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAMI80zjDrXb41hcdVBZhO+blqSu/OOaFwS+uFZHqrYMOWkFt
	gSkbQ2EIqPyLYzQH46SSP78us+KnA1K3JVLd04OONdGw5I3aF0VMH8wFR0SrxAOnUM/SwAhHxQ5
	ADkpTAszqYjUYD6ZhEqlL7SQLtP8=
X-Google-Smtp-Source: AGHT+IGk5LXxDFSADfMP53rSfYNysnQY2zGTq15dY7QMdU7dpyMwa998PnEDbnAom3DOUfWh4ru8WcsxeBqvmG1FcKo=
X-Received: by 2002:a05:6402:2748:b0:5c9:60a:5025 with SMTP id
 4fb4d7f45d1cf-5ca0b0b7e8dmr6139274a12.9.1729346112520; Sat, 19 Oct 2024
 06:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008125023.7fbc1f64@kernel.org> <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
 <20241009170102.1980ed1d@kernel.org> <CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
 <20241010183440.29751370@kernel.org> <CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>
 <20241011234227.GB1825128@ziepe.ca> <CAHS8izNzK4=6AMdACfn9LWqH9GifCL1vVxH1y2DmF9mFZbB72g@mail.gmail.com>
 <20241014171636.3b5b7383@kernel.org> <CAHS8izOVzOetQH5Dr6sJzRpO6Bihv=66Z2OttGS7vU7xjC=POw@mail.gmail.com>
 <20241015124455.GH1825128@ziepe.ca> <CAHS8izPLyTa=rUbFo0B29HWHdmLV4rF4q3qC6XkgksGMSFxjyA@mail.gmail.com>
In-Reply-To: <CAHS8izPLyTa=rUbFo0B29HWHdmLV4rF4q3qC6XkgksGMSFxjyA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 19 Oct 2024 22:55:00 +0900
Message-ID: <CAMArcTWcc6KaBkV1ozxCMmBzHF4tNTv+Khr1=Tfi+JSgdN08PQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: Mina Almasry <almasrymina@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Samiullah Khawaja <skhawaja@google.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:25=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Oct 15, 2024 at 3:44=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Tue, Oct 15, 2024 at 04:10:44AM +0300, Mina Almasry wrote:
> > > On Tue, Oct 15, 2024 at 3:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Tue, 15 Oct 2024 01:38:20 +0300 Mina Almasry wrote:
> > > > > Thanks Jason. In that case I agree with Jakub we should take in h=
is change here:
> > > > >
> > > > > https://lore.kernel.org/netdev/20241009170102.1980ed1d@kernel.org=
/
> > > > >
> > > > > With this change the driver would delegate dma_sync_for_device to=
 the
> > > > > page_pool, and the page_pool will skip it altogether for the dma-=
buf
> > > > > memory provider.
> > > >
> > > > And we need a wrapper for a sync for CPU which will skip if the pag=
e
> > > > comes from an unreadable pool?
> > >
> > > This is where it gets a bit tricky, no?
> > >
> > > Our production code does a dma_sync_for_cpu but no
> > > dma_sync_for_device. That has been working reliably for us with GPU
> >
> > Those functions are all NOP on systems you are testing on.
> >
>
> OK, thanks. This is what I wanted to confirm. If you already know this
> here then there is no need to wait for me to confirm.
>
> > The question is what is correct to do on systems where it is not a
> > NOP, and none of this is really right, as I explained..
> >
> > > But if you or Jason think that enforcing the 'no dma_buf_sync_for_cpu=
'
> > > now is critical, no problem. We can also provide this patch, and seek
> > > to revert it or fix it up properly later in the event it turns out it
> > > causes issues.
> >
> > What is important is you organize things going forward to be able to
> > do this properly, which means the required sync type is dependent on
> > the actual page being synced and you will eventually somehow learn
> > which is required from the dmabuf.
> >
> > Most likely nobody will ever run this code on system where dma_sync is
> > not a NOP, but we should still use the DMA API properly and things
> > should make architectural sense.
> >
>
> Makes sense. OK, we can do what Jakub suggested in the thread earlier.
> I.e. likely some wrapper which skips the dma_sync_for_cpu if the
> netmem is unreadable.
>

Thanks a lot for confirmation about it.
I will pass the PP_FLAG_ALLOW_UNREADABLE_NETMEM flag
regardless of enabling/disabling devmem TCP in a v4 patch.
The page_pool core logic will handle flags properly.

I think patches for changes of page_pool are worked on by Mina,
so I will not include changes for page_pool in a v4 patch.

If you think I missed something, please let me know :)

Thanks a lot!
Taehee Yoo

