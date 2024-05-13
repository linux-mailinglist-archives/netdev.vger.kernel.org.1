Return-Path: <netdev+bounces-95885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439CC8C3C0E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB371F216FE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB7146A89;
	Mon, 13 May 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="so7U/oaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA23214
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585385; cv=none; b=J58LJ+N8f7WVbqsEHoK87vpAOEXQr8ES5W/96PAPq2jrpNQIoCn7nKiGio/JGv7gm+O7YNgicWNhZPJEG94SfeZHBUtIV2sd/seUOzcCr6ZkttkLJSAoEM0sAtU/WwZgjbf+ysysGBw0sWuiNU249QphjQTtGs1TKEA0CHZ3YDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585385; c=relaxed/simple;
	bh=IzPgdw0K49eRhw5jtIZPmynlarK4dqQ229YsGJcycyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2dKY1KJYPKbaSSQ7v0pNyIGVYcXs/Xakgd4616xUf0wMj4ZWGhZ2ChbK+g3B0uVwtSgxtdaLwwZ1JAQuVuoaFLvU0FerSNXiffzTuiSRs6mHPpthFNguE2SVD0hfDfNerxFwxEB+w5fmJlGDGIUVC/8+PBiupTDMV12UKFexns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=so7U/oaT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso8794a12.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715585382; x=1716190182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAY4/lorGsuZXDngCKORi6jmMI4bRdFCzdsTXkDAPOg=;
        b=so7U/oaTH/1My0EXDal3lNbOVdwa4Pb2lXxhCe1w/KPWh8LrWgdOyXwvyL+6gE5ZqP
         aVVvwQAx8YxYKuKTgG+sxq0UDSkTK3VK7iWyTIVcnlBb6fTHSLFQo1z9TMljFTZxTtgZ
         csIeaBVTqGwQC7Y5S7qXmNQpSUXSzFR1PZOItHZnikuHDJDJnFDKOIqNKoO2PFKi2LSD
         2iLFrL40RGmDGFQ0DdUOnHyJsrIY4C9htfBT4B51/CAIY9HMiNXhx4IXfzD9cQ2A7rKq
         Rg51rvqr22Cj3k5Hlt2vZjFU+wuYVl1ieiJ0YxDCV7UG0AhEQK5qRb+Y2BZt8lbppfKG
         5UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585382; x=1716190182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAY4/lorGsuZXDngCKORi6jmMI4bRdFCzdsTXkDAPOg=;
        b=U9EbUB7v54rs3Ym0TbLqIMKqhcbCh1CxtkesnOjvj3YuUVeZgdwJVTr/OcvCRwrzUZ
         p0GqYpJpJt+ByT1TUYd+yFDl2A0Ap5Zvo1ONVG9k0sOYYytIKdfX/CRav8bt6q84412S
         ZEgyDLT0gPyZ4LgUVI/XkVVNUkgEyEiiAeWnn1IgnAmC6iDp0KFzaZ6CnMZ+A4HYSoZl
         CgblMMnnnn+bfntUcGa9+gJ+TAvHxOIkfKZZ4PqcoOFLrZTN3o7A0EV++U72X6Qpgu6l
         jymEOh77C5yQJDsY/YZXzXTHJT5EOvSAQ9oqNktL1nY4cTzMIhB3mVb7vEKE4s0thbbF
         lROQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfxxozPFkRwKGgRUuUmbqwLEkAuGoOiVe0gQctj+L360HSNo/usXuPmvj9mHelXS1nzIQ35o0Q9y3gO0gThhs2dB4sBmrq
X-Gm-Message-State: AOJu0YzxoaBl+rVWA7GPvc2KiJfhUrhSAcMg0Yo7BMfdHpTH27j8NDMN
	34phaACLrvH1/529xQNc3zCDhPhW/GKpzXS/RzTbMtf1n5xt1qB1Vb9CB0KoKVhEvWPjWjyugIr
	uRpV3AKYQ0pbq/kdqDTKWgqAvwT8LhrsC1Pgg
X-Google-Smtp-Source: AGHT+IGhtol7Ka3Q9hALBhyjhXgfG9C+/LulSKbBCs7IbilYl6XQXtTboOY2HfvABdOkS/zVQlGEo51pnJ6tSHLdWqg=
X-Received: by 2002:a05:6402:2228:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5743a09ba38mr227370a12.2.1715585382186; Mon, 13 May 2024
 00:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513015127.961360-1-wei.fang@nxp.com>
In-Reply-To: <20240513015127.961360-1-wei.fang@nxp.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 May 2024 09:29:28 +0200
Message-ID: <CANn89i+EQDCFrhC3mN8g2k=KFpaKtrDusgaUo9zBvv0JCw8eYg@mail.gmail.com>
Subject: Re: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, richardcochran@gmail.com, 
	andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 4:02=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
>
> The assignment of pps_enable is protected by tmreg_lock, but the read
> operation of pps_enable is not. So the Coverity tool reports a lock
> evasion warning which may cause data race to occur when running in a
> multithread environment. Although this issue is almost impossible to
> occur, we'd better fix it, at least it seems more logically reasonable,
> and it also prevents Coverity from continuing to issue warnings.
>
> Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock=
")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ether=
net/freescale/fec_ptp.c
> index 181d9bfbee22..8d37274a3fb0 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -104,14 +104,16 @@ static int fec_ptp_enable_pps(struct fec_enet_priva=
te *fep, uint enable)
>         struct timespec64 ts;
>         u64 ns;
>
> -       if (fep->pps_enable =3D=3D enable)
> -               return 0;
> -
>         fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
>         fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;

Why are these writes left without the spinlock protection ?


>
>         spin_lock_irqsave(&fep->tmreg_lock, flags);
>
> +       if (fep->pps_enable =3D=3D enable) {
> +               spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +               return 0;
> +       }
> +
>         if (enable) {
>                 /* clear capture or output compare interrupt status if ha=
ve.
>                  */
> --
> 2.34.1
>

