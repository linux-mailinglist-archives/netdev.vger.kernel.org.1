Return-Path: <netdev+bounces-141321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704B9BA787
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1447281469
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F215D5C1;
	Sun,  3 Nov 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvsEtOJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE81E52D;
	Sun,  3 Nov 2024 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660469; cv=none; b=Tj5elew/RPxVI/RLeBL9cco4Xne45K7JufpbqjUirflN4SHmCz4oK1LKT0DC9xOtGwvLtTtlAtQ25On8BPGtx55gXfrzh7pc7tYU3E+p2RYhEsIO1i3l9WsHMocNhBQUDuKeKPfff/OuIdPwGF6ZvlCAis3ioqNe2TbiufXP7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660469; c=relaxed/simple;
	bh=1zDalwuuocg7o7SMSPIdz221LR5IyYdeAeYYXwUg9ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVpQEKhjVfioXD6cSSrFMT8ug3h5A+d9EhImn09G1sL+zpRZ/pVNo4mMhJK0/vLTtKC6DcJNZhleU2c72DOmFdYh1q2tUu0LreyuTyOQ1xhd12RsQediuf2NK5rcTB3qYc1IT+XVqTEzh7Tc3Ma7CkchBSMdUf60PAH+RC+mYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvsEtOJr; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so31605151fa.0;
        Sun, 03 Nov 2024 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730660465; x=1731265265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY4A+T6RqHEnnohZAogeCURTdPYG3z7nSaBdYQpTNlM=;
        b=cvsEtOJr8rejxm2ZkBVt1JZ5vgmAO13L/FdgEMCbDbpqMouOTb4z8tbMVb0kSATSuD
         XH2soMKS+U29wBOvYdEL5v2dhvWyi7/4cx3wmn1hpxbz0X1C/FB6xHJswAqdNqPdz9o3
         tnVPNHqYovqk+JtMELQPOjjmr7spmcvwkS0MCh8NV+IwYSUuyntzQxuI41jsSIV/7Zge
         +2DX/BEs0EaylKK/MtKCGiWx5igcmj3mUieNGyqhX9opXxRC4rN8002dXCfb56ID6e/7
         2T5JCad1+0nNizrA2kELAkS5kjFfF1Vz2nIcTPN63GC4fmnl2XGNGzD4L8emuqvDb1pE
         r5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730660465; x=1731265265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY4A+T6RqHEnnohZAogeCURTdPYG3z7nSaBdYQpTNlM=;
        b=SxEuKUxNewPeDXzGtmvy0VgousLXAc5kREmwgFOdr2nPqJZ73RkNc9iSxIj0dAicgu
         JHZ4rnIGba9oPAuidhhMMeMUyH4xt+fC+ew0KMeWO1fRHYZZvl99EUmk2v68I39j/sZ0
         L4P1Z4XHCjikfCJQzLYAHSbdFUtqj5n7P55xqd05K4jnaNaipLYlT0BHfwcBGh9Ia2tq
         KmYcHCh2iNx7xmxy1fV/7uF2Gr88x5XMhSldiDsERJeQQHzn6oL4LBxWBzPdJIQ3saJm
         ubN7htXrgxXHqDL/ORSY6EWjy+Dr0cw3hnrNA3L4q/GSBJnmwCu3moNaVaKrYIKTfdsB
         Sz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYicaEbNdSnpRENfT2CdpU6QRtXtKp9BevrXOyaGyn4ARzhO9Ns0JvjG3aPRUbfTMPmbLSFsKsD662Zro=@vger.kernel.org, AJvYcCXR5WRLU42lgpleD+r+RXqxwaM+liO4n2A8HleAfU4eB8OuNSkNHkutzV8zFbXvP5goNFEeprRh@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3cVO0oFvgHiwaOg3LPCF1qBIIy8Q4CS52noDohufXaZmASoK
	5PxjkdIshFCfXGXMH68MUIRcotH2XJsRSQBIO+7ObkdRgFsh8206HJTP56f4NebsQ/nDsIVuyI3
	adAVYUiUJodraTGoWlC+W2LeDyQ==
X-Google-Smtp-Source: AGHT+IE51hefYOe5xiZP51bcZsQgIVA1y18RQ54UhBWiTXSEaDmaXWZuzRMyPOLYfnY5HJkrGKV6WAz/1UPB2tYCDoM=
X-Received: by 2002:a2e:bc15:0:b0:2fb:6181:8ca1 with SMTP id
 38308e7fff4ca-2fcbdf5f91emr154565771fa.6.1730660465205; Sun, 03 Nov 2024
 11:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKKbWA7e0TmU4z4O8tHfwE=dvqPFaZbSPjxR-==fQSsNq6ELCQ@mail.gmail.com>
In-Reply-To: <CAKKbWA7e0TmU4z4O8tHfwE=dvqPFaZbSPjxR-==fQSsNq6ELCQ@mail.gmail.com>
From: Avi Fishman <avifishman70@gmail.com>
Date: Sun, 3 Nov 2024 21:00:54 +0200
Message-ID: <CAKKbWA6zRee9Rzee-ebLnEAvwLqnmsPswGaUo_ineyzw-b=EgQ@mail.gmail.com>
Subject: Re: [RFC PATCH] net: stmmac: Fix the problem about interrupt storm
To: cathycai0714@gmail.com, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: cathy.cai@unisoc.com, cixi.geng1@unisoc.com, 
	David Miller <davem@davemloft.net>, edumazet@google.com, kuba@kernel.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	mcoquelin.stm32@gmail.com, Network Development <netdev@vger.kernel.org>, pabeni@redhat.com, 
	romain.gantois@bootlin.com, wade.shu@unisoc.com, xuewen.yan94@gmail.com, 
	zhiguo.niu@unisoc.com, Alexandre Torgue <alexandre.torgue@st.com>, 
	Murali <murali.somarouthu@dell.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	"Silva, L Antonio" <Luis.A.Silva@dell.com>, Arias Pablo <Pablo_Arias@dell.com>, 
	Somarouthu Murali <Murali_Somarouthu@dell.com>, uri.trichter@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

We recently encountered the same interrupt storm and the root cause
was the same as here.
The suggested patch solved 99% of the issues, but indeed as written
below on rare cases the issue happens between the dev_open() and
clear_bit(STMMAC_DOWN) calls.
I also agree that stmmac_interrupt() unconditionally ignores
interrupts when the driver is in STMMAC_DOWN state is dangerous.

The issue happened for us in linux 5.10 but I see that this behaviour
wasn't changed also in newer versions.
maybe we should disable the device interrupts before dev_close(), and
enable it after dev_open().

>
> Hi Romain,
>
> On Sun, Mar 31, 2024 at 4:35=E2=80=AFPM Romain Gantois
> <romain.gantois@bootlin.com> wrote:
> >
> > Hello Cathy,
> >
> > On Wed, 27 Mar 2024, Cathy Cai wrote:
> >
> > > Tx queue time out then reset adapter. When reset the adapter, stmmac =
driver
> > > sets the state to STMMAC_DOWN and calls dev_close() function. If an i=
nterrupt
> > > is triggered at this instant after setting state to STMMAC_DOWN, befo=
re the
> > > dev_close() call.
> > >
> > ...
> > > -     set_bit(STMMAC_DOWN, &priv->state);
> > >       dev_close(priv->dev);
> > > +     set_bit(STMMAC_DOWN, &priv->state);
> > >       dev_open(priv->dev, NULL);
> > >       clear_bit(STMMAC_DOWN, &priv->state);
> > >       clear_bit(STMMAC_RESETING, &priv->state);
> >
> > If this IRQ issue can happen whenever STMMAC_DOWN is set while the net =
device is
> > open, then it could also happen between the dev_open() and
> > clear_bit(STMMAC_DOWN) calls right? So you'd have to clear STMMAC_DOWN =
before
> > calling dev_open() but then I don't see the usefulness of setting STMMA=
C_DOWN
> > and clearing it immediately. Maybe closing and opening the net device s=
hould be
> > enough?
Indeed we encounter an issue between the dev_open() and clear_bit(STMMAC_DO=
WN)..
> >
>  Yes. It could also happen between the dev_open() and
> clear_bit(STMMAC_DOWN) calls.
> Although we did not reproduce this scenario, it should have happened
> if we had increased
> the number of test samples. In addition, I found that other people had
> similar problems before.
> The link is:
> https://lore.kernel.org/all/20210208140820.10410-11-Sergey.Semin@baikalel=
ectronics.ru/
>
> >
> > Moreover, it seems strange to me that stmmac_interrupt() unconditionnal=
ly
> > ignores interrupts when the driver is in STMMAC_DOWN state. This seems =
like
> > dangerous behaviour, since it could cause IRQ storm issues whenever som=
ething
> > in the driver sets this state. I'm not too familiar with the interrupt =
handling
> > in this driver, but maybe stmmac_interrupt() could clear interrupts
> > unconditionnally in the STMMAC_DOWN state?
> >
> Clear interrupts unconditionally in the STMMAC_DOWN state directly
> certainly won't cause this problem.
> This may be too rough, maybe this design has other considerations.
>
But then after the dev_open() you might miss interrupt, no?
> >
> > Best Regards,
> >
> > --
> > Romain Gantois, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>
>  Best Regards,
> Cathy



--=20
Regards,
Avi

