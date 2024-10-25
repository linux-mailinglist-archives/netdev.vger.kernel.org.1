Return-Path: <netdev+bounces-139004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A892E9AFC1B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CDF1F249BA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6A1D1E8E;
	Fri, 25 Oct 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3Je+0zP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DA1D14FA;
	Fri, 25 Oct 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843672; cv=none; b=WNDf8NFEHbZFqTtmEuw5w7qC8jJGu0WHf/ex3UhFCU63ePMig7n7WrctE2MKxoViIxkRyB6y10pdG7Yut4X7xcXQ+ffM3OooQLPhT63cMSjGBu5lneZEKwtj6LoWTGjZielwRKlkB1oOlN0IdrBiP3MLPAX/RH8uzJ8MZ8JGuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843672; c=relaxed/simple;
	bh=o1gOBfIHtVLTrFgB2fq6Uowi2pWKiTyJjWht2uaM92A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bp4ZgbA548g0XE78jsl7rlBpN181Xx38ZdEfCbYpvLTa/+73ay4wty/t7KpoGb1rUHgXnwePFCQ54rVYN9TdDzajdthKv+HqmRTeTZap4B/u6Bzip80OHYk0pJz9uGS467WErqw8C+d2M/QBPJkWKPeK8eRPmC9FxSr2E7j2y70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3Je+0zP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cb74434bc5so2342524a12.0;
        Fri, 25 Oct 2024 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729843668; x=1730448468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCQ4m1wvtW2TgoNI4uf9Tu1TL7BPMbTivwjBwFu9sno=;
        b=I3Je+0zPdIxUfxbyLIem41nbptZaRT8XXj7bUIBl2eTtv1J7LEa3np5DIU5wl5VOt2
         4vTEECQFjeGNNuW+t7+dfedTdOHrTOJzoRca8pYBIozwsOlN0wdTM2ggPdbq/Ua6ZO2t
         ikfUtz6srptedKZXyFJRJ7Rizj8RaJkSM/ecZfnf7KwzaerA9oN0pKCnnkIeeNpFG/M0
         wNnJHJ7o06nb7mD0lnhejaisxfVnvxCoY3kV7NoF2jT8ih4KMJB7Gw+sQXbffOsftsOG
         tb+Msb4ECx14ZX/eDG3HLuNt23GEsjjUExny1u+lfCYz6lUdeQfJh+jXsdu9iMoPpOUE
         lP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843668; x=1730448468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCQ4m1wvtW2TgoNI4uf9Tu1TL7BPMbTivwjBwFu9sno=;
        b=lLiglS2HpHjizJ6UrWr4qBzmcjwnRj++YA8Q6eUmftFwg28MTgEHy57B9DnoyKnmqF
         DwFRprW5bH9q5F17kx8yg09PbsiXu4FT94drkDgHtETw6WP7dI+SMk6DzTyr/hUpRRaO
         jtdsUjtHmkZ9LgSyGGhC1KrDMcftcuw5NNbDSANnSBjsI4PE+313iA6+5DLRIJiClAi/
         7FQsuQhxyZcimDMi0bVY8E7hkHxDK9l/33dEKI1XCGEz53JSfNxm/wG1xeD/IBIyL83S
         Se9Lzk62FyHdZwoOqY2dDbjBy3qG3kscLdjG7nRNROjylxPiIEsk7kX350H61j0JT8np
         mPuA==
X-Forwarded-Encrypted: i=1; AJvYcCWUKcYtV4PrfIsuaXC2VvsVcB6q3DRRrq/EWtw9ZQbx2Jt5Yjz5N686REgA3t/hpx3Muaf1gkyU@vger.kernel.org, AJvYcCXqBi72UrILJT3j3aR/9/H9tOtKNLkAtiQBjYBiWQBUQ6AnDYu3Kv3ZqwSlYfe/O5DCThxMRHPi44k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3k1a6PfAmM1Gi+sU5E4Cvfpdr52tcqFVVI1IU6ffuk92FC/YO
	f9+u43iFu2Y1GYjZFyxaEj0kzjcYfIoAk3TSBIcaVCII2LJwuk6VqcWgx3wekyHMl+wLLhnfeIC
	lWHqw5rRhIHaAYu5DNf5AykzN5KQ=
X-Google-Smtp-Source: AGHT+IHyN/fkHr9kBOO3SbDEvBTTZO90qRq8TLpf2ILw3cu3aYcYwh5foVjD/so3SmEY0GxBOe8cLYVZgjzLCQn0NoA=
X-Received: by 2002:a05:6402:1d4d:b0:5cb:7294:fc71 with SMTP id
 4fb4d7f45d1cf-5cb8b190801mr6636356a12.13.1729843667864; Fri, 25 Oct 2024
 01:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-2-ap420073@gmail.com>
 <CACKFLikH-8fdqpvFouoNaFGq011+XvR0+C-8ryq-SutAs=RdsQ@mail.gmail.com>
 <CAMArcTV3U62Rz+FPCJWVOqqNJOZBLnBvb+yRcjJ+drspm5nxbw@mail.gmail.com> <CACKFLikK0p1e41sbkBt1MCL=gxoWbKNHvqzEfcaV=rBfvQjB4w@mail.gmail.com>
In-Reply-To: <CACKFLikK0p1e41sbkBt1MCL=gxoWbKNHvqzEfcaV=rBfvQjB4w@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 25 Oct 2024 17:07:36 +0900
Message-ID: <CAMArcTWzxhHcX=iowgNy=W89gqhRfrqmsoa1j7d2UzMpyd9wbw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] bnxt_en: add support for rx-copybreak
 ethtool command
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 1:55=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Thu, Oct 24, 2024 at 9:38=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > On Thu, Oct 24, 2024 at 3:41=E2=80=AFPM Michael Chan
>
> > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt.c
> > > > index bda3742d4e32..0f5fe9ba691d 100644
> > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > >
> > > > @@ -4510,7 +4513,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
> > > >                                   ALIGN(max(NET_SKB_PAD, XDP_PACKET=
_HEADROOM), 8) -
> > > >                                   SKB_DATA_ALIGN(sizeof(struct skb_=
shared_info));
> > > >                 } else {
> > > > -                       rx_size =3D SKB_DATA_ALIGN(BNXT_RX_COPY_THR=
ESH + NET_IP_ALIGN);
> > > > +                       rx_size =3D SKB_DATA_ALIGN(bp->rx_copybreak=
 +
> > > > +                                                NET_IP_ALIGN);
> > >
> > > When rx_copybreak is 0 or very small, rx_size will be very small and
> > > will be a problem.  We need rx_size to be big enough to contain the
> > > packet header, so rx_size cannot be below some minimum (256?).
> > >
> > > >                         rx_space =3D rx_size + NET_SKB_PAD +
> > > >                                 SKB_DATA_ALIGN(sizeof(struct skb_sh=
ared_info));
> > > >                 }
> > > > @@ -6424,8 +6428,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt=
 *bp, struct bnxt_vnic_info *vnic)
> > > >                                           VNIC_PLCMODES_CFG_REQ_FLA=
GS_HDS_IPV6);
> > > >                 req->enables |=3D
> > > >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_H=
DS_THRESHOLD_VALID);
> > > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thres=
h);
> > > > -               req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thre=
sh);
> > > > +               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak)=
;
> > > > +               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak=
);
> > >
> > > Similarly, these thresholds should not go to 0 when rx_copybreak beco=
mes small.
> > >
> > > >         }
> > > >         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> > > >         return hwrm_req_send(bp, req);
> > >
> > > > @@ -4769,7 +4813,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
> > > >         cpr =3D &rxr->bnapi->cp_ring;
> > > >         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
> > > >                 cpr =3D rxr->rx_cpr;
> > > > -       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thres=
h);
> > > > +       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copybreak)=
;
> > >
> > > The loopback test will also not work if rx_copybreak is very small.  =
I
> > > think we should always use 256 bytes for the loopback test packet
> > > size.  Thanks.
> > >
> > > >         skb =3D netdev_alloc_skb(bp->dev, pkt_size);
> > > >         if (!skb)
> > > >                 return -ENOMEM;
> >
> > I tested `ethtool -t eth0` and I checked it fails if rx-copybreak is to=
o
> > small. Sorry for missing that.
> > I think we can use max(BNXT_DEFAULT_RX_COPYBREAK,
> > bp->rx_copybreak) for both cases.
> > I tested it, it works well.
> > So I will use that if you are okay!
> >
>
> Yes, please go ahead.  I think all 3 places I commented above should
> use max(BNXT_DEFAULT_RX_COPYBREAK, bp->rx_copybreak).  Thanks.

Thanks a lot for your confirmation :)

I asked about jumbo_thresh in another thread, I would like to do it
based on that thread for jumbo_thresh.
And hds_thresh value will be configured by
`ethtool -G eth0 header-data-split-thresh 0", so that we need to
allow 0 ~ 256 value.
I think you indicated jumbo_thresh only, right?

Thank you so much!
Taehee Yoo

