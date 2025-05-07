Return-Path: <netdev+bounces-188763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F1AAE82E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184201B69969
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38328D8FB;
	Wed,  7 May 2025 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0dJgUZp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6C28D8F3
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640165; cv=none; b=FKiNc6zmrYCvuesQnEG/SMNxd9R5smUDeMeTR2+dzEJwiDqv1UIFT4mOU/7w9Q5/F9tKk16wbcKvcxHSn44C5cpUIYAXsW8hxDQeB58ueirmD4Q/ph8zErR5+C5nLKJS5OrQClDmyqaF2mwbpG7jBGFMoxhdzPF+VXMyxZmksxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640165; c=relaxed/simple;
	bh=3svOs8G3Vs4bSx2GgPxx8f6d2+6AYf+qkrrwRVF6Mtc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KKqmzmiQf4jVhAiaSX8GMdasI1Gm4bWvUR95+vg755aZoBdbxGB3KRACbbGHmyL/fBlRFZycF5E9rpNwrQS7IYQvnHVZtGn5S6lg3JiDhMTUG4asOS+UQhgmSanraA7kYh8I5e7jHgReGIuYvyxJZjvVz+qN5k8aVyt6CQqpr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0dJgUZp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f54079e54bso1563846d6.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746640163; x=1747244963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfz6uyoMRfhTnypRiFCmoqot29/UxOPXHyP1KOR63r4=;
        b=k0dJgUZp7sSodTdXVF/9i2QxqRSNpyJzkKzKPv4LCTFDHyhPYq2aSNoUVwWxRxQjYw
         Vc2yM07Avd2wEm0O81rzSUpF63Sfa7V/sGH3ee8boGEnj6T7Egw/zi2TiZOD9ByCQ1tS
         PgCLHbbfTEysJBmd7cERCuG6B5uFOz016fYu6rHB75AJftCQ/0tEi3fWBqMdcAP2NmfB
         1DgAWKb3WoUvltcMAMaxCgmMmixcHnKkemb+mDK1xsTy1R7iLmTs2/qzRZqRcdtdw43I
         f522b4oOLne7BVaNIEjJOEs/hvaIse6uBxLoazZzjnfHetgkgFigPmlmvQ9WTUJm0e2/
         erYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746640163; x=1747244963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kfz6uyoMRfhTnypRiFCmoqot29/UxOPXHyP1KOR63r4=;
        b=hOA6OgCIo50AFpsiw1jKtMUeb5L5qy6/v7NU4DQ+lRNEGZ0mWoUX/7+c1krS2uXL+5
         fmP3ouJY5iFFELskO9BVS8weQnmV+DcNLZH2XLL3/FYICSakycdTzAlZaiX3tdez6f0q
         Y3e13CW/W/dhLjFrAUHDngsoq0MlNjux737yTV6tfi1JyY+IN9ZXuA7pQm4R3ry639Oj
         HgBaLCNhhgBVK9TphQJlDzpA+g4ytXzcv1qHlt3zIpSwSC8y9+6PLCYKKgPpoTHZBT5G
         FeeNS0HLJ8qwZlB85fiBK1OIcMpI8o1NvuTEq5cXXnF88N7vXwVzQxNMmV2EwUSuFvg8
         iqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGniJFEfGYk00ww6xW+48GGZNC3IF/NGnO/v2aLzVzSF3hw4i/zdo9ptZJfc98VfjYvRbEr3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsSPL4NYV64l3B3bjBILWKk+2ubTqp0FaJ9+i8G3Vlua8LZe0
	npN9XG5Np0qfs/KB3B98yLjRvOxtxYH6ZYLAZcZyqk7e8P/UaZDD
X-Gm-Gg: ASbGncslCKe2jLNfR6Pdbn5usGtS0jlDGQrZgaqZeczCwR4AncZH24eQ7ElHmty1/VY
	TB1iFff8RM4o4XKGdUZpxHsDhKnnrqgk86M1z3FBv1A2XvnUl+I2NPjiyplYvz0JFKvmuy+AJT7
	dK4i0GACPFnUWXwsvoFkiHp1pDo5f49rSDhumM2jQrQ6xGCdF13/dgW9YcsSXhbVQ1DOGG8vqI0
	Tb2KE0PFovFzrnc7JBIpZUOggiSSwBYHkDRX8g+ZrLa4uQA8iDXegXASpTlOXYr7rhz1/mqlmN6
	Koyah9iO5bkiXZQ74YQlNRkJABR8L5fqlzfeMAygtbDwXRbKKXZf7K13qf7Ft/Zbu6xzr0v6nha
	BMeVK+s3dMWHoDTP1bxQv
X-Google-Smtp-Source: AGHT+IEdmDz6bgqyCAX+DBi2xQ6M9zcA4fwpG7/l9puBW+mKy97fTNnoENSya6bjigpX9N0Iatt+jg==
X-Received: by 2002:a05:6214:190f:b0:6f5:437a:dd5d with SMTP id 6a1803df08f44-6f5437ae0d2mr44414396d6.0.1746640162842;
        Wed, 07 May 2025 10:49:22 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f54278112dsm16751986d6.91.2025.05.07.10.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:49:22 -0700 (PDT)
Date: Wed, 07 May 2025 13:49:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 sgoutham@marvell.com, 
 andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <681b9d2210879_1f6aad294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC606GBfwo3BY_7vn3jPQJdC=78h9q-110hC3DCYRg7jQ@mail.gmail.com>
References: <20250507030804.70273-1-kerneljasonxing@gmail.com>
 <681b5ebc80a81_1e440629460@willemb.c.googlers.com.notmuch>
 <CAL+tcoC606GBfwo3BY_7vn3jPQJdC=78h9q-110hC3DCYRg7jQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: thunder: make tx software timestamp
 independent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> Hi Willem,
> =

> On Wed, May 7, 2025 at 9:23=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > skb_tx_timestamp() is used for tx software timestamp enabled by
> > > SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is controlled by=

> > > SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are differen=
t
> > > timestamps in two dimensions, this patch makes the software one
> > > standalone.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/d=
rivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > > index 06397cc8bb36..d368f381b6de 100644
> > > --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > > @@ -1389,11 +1389,11 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic,=
 struct snd_queue *sq, int qentry,
> > >               this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
> > >       }
> > >
> > > +     skb_tx_timestamp(skb);
> > > +
> > >       /* Check if timestamp is requested */
> >
> > Nit: check if hw timestamp is requested.
> =

> Thanks for the review. Will change it.
> =

> >
> > > -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> > > -             skb_tx_timestamp(skb);
> > > +     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> > >               return;
> > > -     }
> >
> > The SO_TIMESTAMPING behavior around both software and hardware
> > timestamps is a bit odd.
> =

> Just a little bit. The reason why I looked into this driver is because
> I was reviewing this recent patch[1]. Then I found that the thunder
> driver uses the HW flag to test if we can generate a software
> timestamp which is also a little bit odd. Software timestamp function
> is controlled by the SW flag or SWHW flag instead of the pure HW flag.
> =

> [1]: https://lore.kernel.org/all/20250506215508.3611977-1-stfomichev@gm=
ail.com/
> =

> >
> > Unless SOF_TIMESTAMPING_OPT_TX_SWHW is set, by default a driver will
> > only return software if no hardware timestamp is also requested.
> =

> Sure thing. SOF_TIMESTAMPING_OPT_TX_SWHW can be used in this case as
> well as patch [1].
> =

> >
> > Through the following in __skb_tstamp_tx
> >
> >         if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &=
&
> >             skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> >                 return;
> >
> > There really is no good reason to have this dependency. But it is
> > historical and all drivers should implement the same behavior.
> =

> As you said, this morning when I was reviewing patch[1], I noticed
> that thunder code is not that consistent with others.
> =

> >
> > This automatically happens if the software timestamp request
> > skb_tx_timestamp is called after the hardware timestamp request
> > is configured, i.e., after SKBTX_IN_PROGRESS is set. That usually
> > happens because the software timestamp is requests as close to kickin=
g
> > the doorbell as possible.
> =

> Right. In most cases, they implemented in such an order:
> =

>                 if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
>                         skb_shinfo(skb)->tx_flags |=3D
> SKBTX_IN_PROGRESS;
> =

>                 skb_tx_timestamp(skb);
> =

> Should I adjust this patch to have the same behavior in the next
> revision like below[2]?

Best is just to do what other drivers do with the software
timestamp: take it as late as possible in ndo_start_xmit,
meaning just before ringing the doorbell.

For this driver, that is in two places, as said.

> Then we can get the conclusion:1) if only the
> HW or SW flag is set, nothing changes and only corresponding timestamp
> will be generated, 2) if HW and SW are set without the HWSW flag, it
> will check the HW first. In non TSO mode, If the non outstanding skb
> misses the HW timestamp, then the software timestamp will be
> generated, 3) if HW and SW and HWSW are set with the HWSW flag, two
> types of timestamp can be generated. To put it in a simpler way, after
> [2] patch, thunder driver works like other drivers. Or else, without
> [2], the HWSW flag doesn't even work.
> =

> [2]
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> index 06397cc8bb36..4be562ead392 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> @@ -1389,28 +1389,24 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic,
> struct snd_queue *sq, int qentry,
>                 this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
>         }
> =

> -       /* Check if timestamp is requested */
> -       if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> -               skb_tx_timestamp(skb);
> -               return;
> -       }
> =

> -       /* Tx timestamping not supported along with TSO, so ignore requ=
est */
> -       if (skb_shinfo(skb)->gso_size)
> -               return;
> -
> -       /* HW supports only a single outstanding packet to timestamp */=

> -       if (!atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1))
> -               return;
> -
> -       /* Mark the SKB for later reference */
> -       skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +       /* Check if hw timestamp is requested */
> +       if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
> +           /* Tx timestamping not supported along with TSO, so ignore
> request */
> +           !skb_shinfo(skb)->gso_size &&
> +           /* HW supports only a single outstanding packet to timestam=
p */
> +           atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1)) {
> +               /* Mark the SKB for later reference */
> +               skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +
> +               /* Finally enable timestamp generation
> +                * Since 'post_cqe' is also set, two CQEs will be poste=
d
> +                * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_=
PTP.
> +                */
> +               hdr->tstmp =3D 1;
> +       }
> =

> -       /* Finally enable timestamp generation
> -        * Since 'post_cqe' is also set, two CQEs will be posted
> -        * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
> -        */
> -       hdr->tstmp =3D 1;
> +       skb_tx_timestamp(skb);
>  }
> =

>  /* SQ GATHER subdescriptor
> =

> Thanks,
> Jason
> =

> >
> > In this driver, that would be not in nicvf_sq_add_hdr_subdesc, but
> > just before calling nicvf_sq_doorbell. Unfortunately, there are two
> > callers, TSO and non-TSO.
> >
> > >
> > >       /* Tx timestamping not supported along with TSO, so ignore re=
quest */
> > >       if (skb_shinfo(skb)->gso_size)
> > > --
> > > 2.43.5
> > >
> >
> >



