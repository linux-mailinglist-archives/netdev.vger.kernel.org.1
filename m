Return-Path: <netdev+bounces-188803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A209DAAEF2B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BD49C5648
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504928C027;
	Wed,  7 May 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgzZECxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A37260E
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659748; cv=none; b=qgh2g9N7bDWIxv4yoOEjCRtoPKmDuistKJV10uW9g2WwoWYr3vaJR24mLWH9g6F5A62fSM7aNB1jnixyxQd9M0Eqmftq/u7q6TElZLlZvGGo8qFGIPlPipBUkFB1LcYy9Tjci3Mac1YlFR08EU5D2ilcXAYIE6h8GNms96ysRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659748; c=relaxed/simple;
	bh=+rnd5QB9PRcS3o34WMWIqxIYpK1tZAHhDZMZFtstzzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifwwyc6O6AfXashImVVPNpCWxVJW34w1e2gKFZ3K6ejJOw3zZV+WzqvX4jPd4/sLT1hxPwBlGhW/LXjV05ZLzghrnc6GmfpoCdMxLBfqjKlkt9mq4NQlV69n3Msuv658yVpVhLnH+PQ6AHrbMBKpbXuCyHRXq2HlE/pUarw4LfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgzZECxT; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so1665305ab.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746659745; x=1747264545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RImuKL11AWw27VGnXGt5AKSYaF75iEDxt4FG+PZZJZo=;
        b=LgzZECxTXDqjJ9bAb6ui7iPzDZtJmVryl3SX1F3o8GU8Ci3qO8ivRnnbDo7ho15eGP
         fSqLxBOJqy0UMUxDkqtgcnYT30lM35gRRpzZmVXZBfktLIIsQKYZIp8F76D6W3br8Xss
         9MuL8zddnkUlzTg8uMcamv1XsJAhqz9gKtJI4FSaG3PoEibCQ2GB7QGP2blm47EuCkbs
         2cKf96+36++yhvcRSluDUNRjIwpRMTwUi/UMtE6ugARSv5/ZRetudgzrll9/kOw/F6Ox
         GVG1zb1miRvVCke0ktY1dps5c7ArwMFKrzZuQclhZcJeY1F5FOSkqMIXlvs204cGgB9x
         j63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746659745; x=1747264545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RImuKL11AWw27VGnXGt5AKSYaF75iEDxt4FG+PZZJZo=;
        b=rUdiwe7MEWw7C3BZb/dVR5SiHjaZ37QnlC0g6MrJ8K5aJCdxg71mV+FVHkTMu9NWQ/
         mw5GIk9BJR02UpKdkIyen7G5sO7qoH3aoBddP5glJ4GSBVaLYFSJH+0302XJP35QM9yp
         q302JXlOa512zc8s8Zsux+J8Qm8mQ1Xc7qRAZDLRq625ZzvUbwH487xrTnZAB6BWj14H
         JoBb8dhz5+WCgT39QgMvWn82Q/rZ7aT+HqDqSIdMQeseW1Z7rTqEIxbczNddpNNTj6w4
         guOiV9mcsA3KdBtfL539C27EOyO8FiSJXx7iguv24awuUhxge/yTLVgo+9kCrRM3RhX4
         DpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWflC3cksiI6u+Ouo2LnszPA2D5kaz1EDOfQvChwq9n07sFUmoBOLriH5GeZrzPLGS3fvKkHZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBWlxxlmYOhxRvCwEkS0FqJQ33ZEWOCa6AicQw1x3o/3Rr2C8
	PR6/mRPZKEiwOe7tPuHQ7zNAkDZfz0Di4VmmkbN2nOoerZZS3ZIRlNIEvQ8oL3CudYhBprXhb1F
	+I3YrEZ0b6lwJSghmXPFU+ggglqU=
X-Gm-Gg: ASbGncsJg988fCt+VLo6/uyN+Z6TX9hDATxFmr+eC+71pfbObyuIAoxLEx+lNkxx4yc
	JTv2E5xVu4MF3FUEUCw5g+ENb7fPlWHktLxaWKc1YF4JoZnaX64sfKH2T1Pk7qen/032ukWN/mE
	mEaLJixHB6GJGOUzczHpPh
X-Google-Smtp-Source: AGHT+IGtSYttpG1zZ5PGkPf2Vbh+MmEc34Y+/FIKQTM3ZkuCIGnzwVXYb/erKuYvJnGgpIXx6irfFTWYc3vMqMU6DkU=
X-Received: by 2002:a05:6e02:1445:b0:3d9:6379:86e9 with SMTP id
 e9e14a558f8ab-3da738ed6d2mr53358505ab.5.1746659745190; Wed, 07 May 2025
 16:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507030804.70273-1-kerneljasonxing@gmail.com>
 <681b5ebc80a81_1e440629460@willemb.c.googlers.com.notmuch>
 <CAL+tcoC606GBfwo3BY_7vn3jPQJdC=78h9q-110hC3DCYRg7jQ@mail.gmail.com> <681b9d2210879_1f6aad294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <681b9d2210879_1f6aad294bc@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 May 2025 07:14:59 +0800
X-Gm-Features: ATxdqUHKm-VYQ08mqLoWYWANXneFqy01jhG7ZahId-T1A1Q1JXLo7PVvCxSKSr4
Message-ID: <CAL+tcoC13tUNTjmfuueExPtNX6TOvH_q6NJw_7KX4rEDDSwyvg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: thunder: make tx software timestamp independent
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sgoutham@marvell.com, 
	andrew+netdev@lunn.ch, willemb@google.com, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:49=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Hi Willem,
> >
> > On Wed, May 7, 2025 at 9:23=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > skb_tx_timestamp() is used for tx software timestamp enabled by
> > > > SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is controlled by
> > > > SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are differen=
t
> > > > timestamps in two dimensions, this patch makes the software one
> > > > standalone.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/d=
rivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > > > index 06397cc8bb36..d368f381b6de 100644
> > > > --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > > > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > > > @@ -1389,11 +1389,11 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic,=
 struct snd_queue *sq, int qentry,
> > > >               this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
> > > >       }
> > > >
> > > > +     skb_tx_timestamp(skb);
> > > > +
> > > >       /* Check if timestamp is requested */
> > >
> > > Nit: check if hw timestamp is requested.
> >
> > Thanks for the review. Will change it.
> >
> > >
> > > > -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> > > > -             skb_tx_timestamp(skb);
> > > > +     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> > > >               return;
> > > > -     }
> > >
> > > The SO_TIMESTAMPING behavior around both software and hardware
> > > timestamps is a bit odd.
> >
> > Just a little bit. The reason why I looked into this driver is because
> > I was reviewing this recent patch[1]. Then I found that the thunder
> > driver uses the HW flag to test if we can generate a software
> > timestamp which is also a little bit odd. Software timestamp function
> > is controlled by the SW flag or SWHW flag instead of the pure HW flag.
> >
> > [1]: https://lore.kernel.org/all/20250506215508.3611977-1-stfomichev@gm=
ail.com/
> >
> > >
> > > Unless SOF_TIMESTAMPING_OPT_TX_SWHW is set, by default a driver will
> > > only return software if no hardware timestamp is also requested.
> >
> > Sure thing. SOF_TIMESTAMPING_OPT_TX_SWHW can be used in this case as
> > well as patch [1].
> >
> > >
> > > Through the following in __skb_tstamp_tx
> > >
> > >         if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &=
&
> > >             skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> > >                 return;
> > >
> > > There really is no good reason to have this dependency. But it is
> > > historical and all drivers should implement the same behavior.
> >
> > As you said, this morning when I was reviewing patch[1], I noticed
> > that thunder code is not that consistent with others.
> >
> > >
> > > This automatically happens if the software timestamp request
> > > skb_tx_timestamp is called after the hardware timestamp request
> > > is configured, i.e., after SKBTX_IN_PROGRESS is set. That usually
> > > happens because the software timestamp is requests as close to kickin=
g
> > > the doorbell as possible.
> >
> > Right. In most cases, they implemented in such an order:
> >
> >                 if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
> >                         skb_shinfo(skb)->tx_flags |=3D
> > SKBTX_IN_PROGRESS;
> >
> >                 skb_tx_timestamp(skb);
> >
> > Should I adjust this patch to have the same behavior in the next
> > revision like below[2]?
>
> Best is just to do what other drivers do with the software
> timestamp: take it as late as possible in ndo_start_xmit,
> meaning just before ringing the doorbell.
>
> For this driver, that is in two places, as said.

Oh, now I see your other core suggestion. Thanks!

Probably I will split it into a small series to make each patch only
do one thing.

Thanks,
Jason

>
> > Then we can get the conclusion:1) if only the
> > HW or SW flag is set, nothing changes and only corresponding timestamp
> > will be generated, 2) if HW and SW are set without the HWSW flag, it
> > will check the HW first. In non TSO mode, If the non outstanding skb
> > misses the HW timestamp, then the software timestamp will be
> > generated, 3) if HW and SW and HWSW are set with the HWSW flag, two
> > types of timestamp can be generated. To put it in a simpler way, after
> > [2] patch, thunder driver works like other drivers. Or else, without
> > [2], the HWSW flag doesn't even work.
> >
> > [2]
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > index 06397cc8bb36..4be562ead392 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > @@ -1389,28 +1389,24 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic,
> > struct snd_queue *sq, int qentry,
> >                 this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
> >         }
> >
> > -       /* Check if timestamp is requested */
> > -       if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> > -               skb_tx_timestamp(skb);
> > -               return;
> > -       }
> >
> > -       /* Tx timestamping not supported along with TSO, so ignore requ=
est */
> > -       if (skb_shinfo(skb)->gso_size)
> > -               return;
> > -
> > -       /* HW supports only a single outstanding packet to timestamp */
> > -       if (!atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1))
> > -               return;
> > -
> > -       /* Mark the SKB for later reference */
> > -       skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> > +       /* Check if hw timestamp is requested */
> > +       if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
> > +           /* Tx timestamping not supported along with TSO, so ignore
> > request */
> > +           !skb_shinfo(skb)->gso_size &&
> > +           /* HW supports only a single outstanding packet to timestam=
p */
> > +           atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1)) {
> > +               /* Mark the SKB for later reference */
> > +               skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> > +
> > +               /* Finally enable timestamp generation
> > +                * Since 'post_cqe' is also set, two CQEs will be poste=
d
> > +                * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_=
PTP.
> > +                */
> > +               hdr->tstmp =3D 1;
> > +       }
> >
> > -       /* Finally enable timestamp generation
> > -        * Since 'post_cqe' is also set, two CQEs will be posted
> > -        * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
> > -        */
> > -       hdr->tstmp =3D 1;
> > +       skb_tx_timestamp(skb);
> >  }
> >
> >  /* SQ GATHER subdescriptor
> >
> > Thanks,
> > Jason
> >
> > >
> > > In this driver, that would be not in nicvf_sq_add_hdr_subdesc, but
> > > just before calling nicvf_sq_doorbell. Unfortunately, there are two
> > > callers, TSO and non-TSO.
> > >
> > > >
> > > >       /* Tx timestamping not supported along with TSO, so ignore re=
quest */
> > > >       if (skb_shinfo(skb)->gso_size)
> > > > --
> > > > 2.43.5
> > > >
> > >
> > >
>
>

