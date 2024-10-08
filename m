Return-Path: <netdev+bounces-133013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04C6994448
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66501C22E58
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE716EB76;
	Tue,  8 Oct 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOuJNJQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC41684A4;
	Tue,  8 Oct 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379769; cv=none; b=iUsk00yMBp97q3vregSHH22whw1ARXO8Tk2198+x0ApJUzlxb09/RHTh4O1nhrY6b2KC8t8VvRqP9z6tVTTDAiGJ9wCpd7TagHnMjd3PFzv74//q/ug8YO57bgfq5u2TR4xNgsVX/bxI4iUnCWWDGH8cxEUvXFXqD1IVcS5hRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379769; c=relaxed/simple;
	bh=eWN/MaFojHAW9m6Ae/35VSjoROU+iItX2kOUEWuuCUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkQyuc/lqfAkXLQVdjMGRTSjAteq3zGQsAkXeyN3va0AxSEctx5Xvt/W1Q8nJqINwRj9RelrRjRyrFPxlXZHgOWXDjVZ7dLGbH/yxWkQ53vCgRJzw9smVArCgbswwjWJOgD/8jCPddYwZM3f3LW2oUVnfmM04EwsLwqruvB+5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOuJNJQ1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e232e260c2so45317427b3.0;
        Tue, 08 Oct 2024 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728379765; x=1728984565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQNyfPSCVIG01EOy/uu8Bi4UqKVZ2bxP52ZD84vL7uY=;
        b=ZOuJNJQ1j+p1fMtJQyTvmDmWMfF2Frot5crI9O8Feki239qg+ffxJURM4Pds9gz4us
         Yg62N4cW4ZOQFcXPpeI4P8hpgiPJKWmzEKw9zGicLLvUHWKNoPtipaMEoNQ/EmEITiTy
         CEdA6BqUn8tOhbVGPqG7I+jFPqzThXdS4+135rIbDR/9JA++NqmyrdRJVwp+Aj+0I/WU
         4rlCq96u1y32sb3cr+mYugFUKfVHeMKJPyTMY1mh/6D1pQBzLqghRkR2AtpIm4vwBkOU
         uaYYHqSlyTzp1qEH+vp+1OBDMsZYGiDNVth/qgUCdzi+lyu3wMXqvl1/psrGPrnyL7Ia
         GW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728379765; x=1728984565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQNyfPSCVIG01EOy/uu8Bi4UqKVZ2bxP52ZD84vL7uY=;
        b=az51IHs1YBYKsgtut4g2jt40l9sZCsHQZ5EXd8CG+58yxZthv4AcaZvns62sNLN33P
         UN/VeDgM3DG10Tnm8Dp2e4ceis83q2ZI8BewhqT3dMTSeZoxsrm1oy4tUplGQHOnv0Bi
         CLx092IMgdQLwWzri9wT7p0Foz+wjFmpv43XCmV2mtBmbpFYCzYES+BWmbZBViA7z0K7
         Mub5sDFb26tLTHzRv3767L6lsMFjFJmb367HwoHCqs6iSYUacW9HRYZd01erTpB3xfSu
         hHQ+wY+1iNEvjdJhDKaZAB+XsGVA5p4PCCifElE4r3tlMO7YGCYY2R8lcDztnF9CgqcK
         GKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1LKIK+XPZMbJSHLPISNua4IfCYJ8ieROtSvYRUZMU387J0B8k+GohcQQx3JRel7sZUvHq5Bk+YXeMDZo=@vger.kernel.org, AJvYcCVWWuIGluCEmXq5eIbgSq6oIhXW0Preaad1P7VSGMkTDQToSkULu0YiaOY38lxX8K/pXgKrR+F0@vger.kernel.org
X-Gm-Message-State: AOJu0YymDnObHd8qrbL1pDTi8wJZ48I5oUfrVyhGrrjEbEDh9giF7os2
	/Lixq1mh6snyAn1FtX1QU0gaPpRl5HEzANTe4owF4P/rcmQLXbqY6R2hxRIg30+12NxcE1kFW4s
	jPmqsQ3qc2YPocOdpB4H9RioJUlI=
X-Google-Smtp-Source: AGHT+IEhq3KmwZVymDz4Fd++jHViv8z0hh+44qM6R8bbFsO1VjRYVuySILrif1O42D+aB2/WwvvxlKICDyBFTZBy9O8=
X-Received: by 2002:a05:6902:1b87:b0:e26:2aa0:a3b0 with SMTP id
 3f1490d57ef6-e289392b426mr9499416276.45.1728379765172; Tue, 08 Oct 2024
 02:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091817.977999-1-dillon.minfei@gmail.com> <PAXPR04MB85106420DA87BA00EF755A85887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB85106420DA87BA00EF755A85887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Dillon Min <dillon.minfei@gmail.com>
Date: Tue, 8 Oct 2024 17:28:49 +0800
Message-ID: <CAL9mu0K9YJT_tvpV6C01yhBgU2=eiD7Q4jUnnu1priBchA8mkQ@mail.gmail.com>
Subject: Re: [PATCH v1] net: ethernet: fix NULL pointer dereference at fec_ptp_save_state()
To: Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, 
	"csokas.bence@prolan.hu" <csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wei

Ok, Thanks, just ignore this patch.

Br.

On Tue, 8 Oct 2024 at 17:24, Wei Fang <wei.fang@nxp.com> wrote:
>
> > -----Original Message-----
> > From: dillon.minfei@gmail.com <dillon.minfei@gmail.com>
> > Sent: 2024=E5=B9=B410=E6=9C=888=E6=97=A5 17:18
> > To: Wei Fang <wei.fang@nxp.com>; Shenwei Wang <shenwei.wang@nxp.com>;
> > Clark Wang <xiaoning.wang@nxp.com>; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > u.kleine-koenig@baylibre.com; csokas.bence@prolan.hu
> > Cc: imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kern=
el.org;
> > Dillon Min <dillon.minfei@gmail.com>
> > Subject: [PATCH v1] net: ethernet: fix NULL pointer dereference at
> > fec_ptp_save_state()
> >
> > From: Dillon Min <dillon.minfei@gmail.com>
> >
> > fec_ptp_init() called at probe stage when 'bufdesc_ex' is true.
> > so, need add 'bufdesc_ex' check before call fec_ptp_save_state(), else
> > 'tmreg_lock' will not be init by spin_lock_init().
> >
> > run into kernel panic:
> > [    5.735628] Hardware name: Freescale MXS (Device Tree)
> > [    5.740816] Call trace:
> > [    5.740853]  unwind_backtrace from show_stack+0x10/0x14
> > [    5.748788]  show_stack from dump_stack_lvl+0x44/0x60
> > [    5.753970]  dump_stack_lvl from register_lock_class+0x80c/0x888
> > [    5.760098]  register_lock_class from __lock_acquire+0x94/0x2b84
> > [    5.766213]  __lock_acquire from lock_acquire+0xe0/0x2e0
> > [    5.771630]  lock_acquire from _raw_spin_lock_irqsave+0x5c/0x78
> > [    5.777666]  _raw_spin_lock_irqsave from fec_ptp_save_state+0x14/0x6=
8
> > [    5.784226]  fec_ptp_save_state from fec_restart+0x2c/0x778
> > [    5.789910]  fec_restart from fec_probe+0xc68/0x15e0
> > [    5.794977]  fec_probe from platform_probe+0x58/0xb0
> > [    5.800059]  platform_probe from really_probe+0xc4/0x2cc
> > [    5.805473]  really_probe from __driver_probe_device+0x84/0x19c
> > [    5.811482]  __driver_probe_device from
> > driver_probe_device+0x30/0x110
> > [    5.818103]  driver_probe_device from __driver_attach+0x94/0x18c
> > [    5.824200]  __driver_attach from bus_for_each_dev+0x70/0xc4
> > [    5.829979]  bus_for_each_dev from bus_add_driver+0xc4/0x1ec
> > [    5.835762]  bus_add_driver from driver_register+0x7c/0x114
> > [    5.841444]  driver_register from do_one_initcall+0x4c/0x224
> > [    5.847205]  do_one_initcall from kernel_init_freeable+0x198/0x224
> > [    5.853502]  kernel_init_freeable from kernel_init+0x10/0x108
> > [    5.859370]  kernel_init from ret_from_fork+0x14/0x38
> > [    5.864524] Exception stack(0xc4819fb0 to 0xc4819ff8)
> > [    5.869650] 9fa0:                                     00000000
> > 00000000 00000000 00000000
> > [    5.877901] 9fc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [    5.886148] 9fe0: 00000000 00000000 00000000 00000000 00000013
> > 00000000
> > [    5.892838] 8<--- cut here ---
> > [    5.895948] Unable to handle kernel NULL pointer dereference at virt=
ual
> > address 00000000 when read
> >
> > Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
> > Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index 60fb54231ead..1b55047c0237 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -1077,7 +1077,8 @@ fec_restart(struct net_device *ndev)
> >       u32 rcntl =3D OPT_FRAME_SIZE | 0x04;
> >       u32 ecntl =3D FEC_ECR_ETHEREN;
> >
> > -     fec_ptp_save_state(fep);
> > +     if (fep->bufdesc_ex)
> > +             fec_ptp_save_state(fep);
> >
> >       /* Whack a reset.  We should wait for this.
> >        * For i.MX6SX SOC, enet use AXI bus, we use disable MAC @@ -1340=
,7
> > +1341,8 @@ fec_stop(struct net_device *ndev)
> >                       netdev_err(ndev, "Graceful transmit stop did not =
complete!\n");
> >       }
> >
> > -     fec_ptp_save_state(fep);
> > +     if (fep->bufdesc_ex)
> > +             fec_ptp_save_state(fep);
> >
> >       /* Whack a reset.  We should wait for this.
> >        * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> > --
> > 2.25.1
>
> Hi Dillon,
>
> I have sent the same patch this morning.
> https://lore.kernel.org/lkml/20241008061153.1977930-1-wei.fang@nxp.com/

