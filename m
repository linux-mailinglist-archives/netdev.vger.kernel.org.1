Return-Path: <netdev+bounces-138755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF19AEC59
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A291D2807DD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22315A87C;
	Thu, 24 Oct 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR1MWIFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174F1F8188;
	Thu, 24 Oct 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787911; cv=none; b=aIfVs5TtvbYFrn3bocWXpyNli1WVEwxHAPgXjfH975FR9TKz/Imydp3AVwpXZ4OiU8uG5V4Cl9+diMwpCNxMWChPh3DAtZ6HWAsd1L0rK3dQjnycirpCMi3RKIkLVp8Hoe+++G5OzpYZBAszg8dR7ElOLRDN8eJGNeLrjd50dUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787911; c=relaxed/simple;
	bh=tkSNE6x8L3EpPPEaen1uj79Yl7nRKcfUt0+3bu2yz+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0mx69RSRRafK16MYZClPktC9HEj4FOagWlXpT3Fg2g5ROOx3GiwMGPkFiwaQmugbwgcvtNl6f+8FlSHkMGuKnUxnuHDe8Dqe89k4PdXlyy6B0Shcc/9C0C9cjPwblwHTzuDKHVHeMkb3G43suU1tOLXkAi5Yje2zpJdagAMLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR1MWIFA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so4005386a12.1;
        Thu, 24 Oct 2024 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729787907; x=1730392707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6OrnFlL53k5PbeOSCXvYwOxfZaO+J0U5NvlTNJMMDU=;
        b=OR1MWIFA0qFw6LgGSiUekYev6WHb+WK8etNhJD5Vxladt6rT0Z0fG2I2GTQTKoVKqq
         lXANP/T9YonWHhJZyVkO2hwCc34NG669a8Yd0eNX9ALMgR261mzsyx8sBMw5fupyfLCw
         s8YdSzFRV7II/oNoAjvX7zsjzkK6BCs9H4kGtwbQ+jv9Dlip9qiC33CZdClmOp+wFJJ5
         +9UGETtopif6ZvGblF0xr2YYHCl1Ihak6h9inMie1c7NkErBS0G71cBHKeBDIaf4Y3cp
         j2cQEpSXOX4a8P6r7jYbq1L/Ot/nVovf7V10x/MjWwf6jLH+qi/iUvIpPJ1nNvgDIqGc
         Xvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787907; x=1730392707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6OrnFlL53k5PbeOSCXvYwOxfZaO+J0U5NvlTNJMMDU=;
        b=DFZYHGzBGUvbs9qoNINRMDKSfTod6UqmUi+isDh85gHzx6YviRLmxBu2SDb5C3uT9I
         7iuoAoisBigNZ8w6vs179UmSK4ojwiPEbh5n/ll1xb9HnfYrhc9hOxdnWuEj6TiBwQt1
         GRVZuAHJw8+dh36PYy8k3O3hp5DlnLaXfgF5eOYSLBaAh0Y/aq1fZIzh4JynrAAcgGlP
         vNLrpYKk42ML1h2jE3DyIE6GTwmFqVs1+We7UAi21JN48tRsYsAP6uiniB/8REaO4oZc
         pgBUCadvZEJoGt1K22cvhMb1ex2nSNGb0/tJ48h0HmLEhN3MOxkH80PTssKT+J1OTBMV
         TlcA==
X-Forwarded-Encrypted: i=1; AJvYcCVV960dRgZyylr7RQpkhlmOzQB9Urpr+Ixf5oFUoy/l43oQVZf5seT5NOTfUYAac4AhLgk3MJgyD90=@vger.kernel.org, AJvYcCWSz8LUf7awRNs0QcbF334xFG3zYEilmDVzzmsAiqiFR7CS4pZp5OLW5zydyA2PE+S/GA2mMzs0@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhvdjjgFYJ+ROlNyRVsLyO1KwGsFWyZxTX4S6wnOtbFUu4gHC
	ZyFMEdv9Pf66E9qRGJNmKHAIYRPLsehZktOlpP/kIls+Zbia+Dj6+ZreOTqDeuBFDfzDPTV1i50
	ryGC0k9exiNJrKo/rIpi3oe2wCpo=
X-Google-Smtp-Source: AGHT+IEzhPtdiCdhY65VTMNrpBco+30HzckOjVn5NCTaiNhCZTvT9mWvdNjc32SVqYLsqE1nRyhxG2OVMKSGZtV5OLk=
X-Received: by 2002:a05:6402:358c:b0:5c9:3070:701e with SMTP id
 4fb4d7f45d1cf-5cba2037cc9mr3252493a12.9.1729787907328; Thu, 24 Oct 2024
 09:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-2-ap420073@gmail.com>
 <CACKFLikH-8fdqpvFouoNaFGq011+XvR0+C-8ryq-SutAs=RdsQ@mail.gmail.com>
In-Reply-To: <CACKFLikH-8fdqpvFouoNaFGq011+XvR0+C-8ryq-SutAs=RdsQ@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 25 Oct 2024 01:38:15 +0900
Message-ID: <CAMArcTV3U62Rz+FPCJWVOqqNJOZBLnBvb+yRcjJ+drspm5nxbw@mail.gmail.com>
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

On Thu, Oct 24, 2024 at 3:41=E2=80=AFPM Michael Chan

Hi Michael,
Thank you so much for the review!

<michael.chan@broadcom.com> wrote:
>
> On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> > userspace. Only the default value(256) has worked.
> > This patch makes the bnxt_en driver support following command.
> > `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> > `ethtool --get-tunable <devname> rx-copybreak`.
> >
> > Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v4:
> >  - Remove min rx-copybreak value.
> >  - Add Review tag from Brett.
> >  - Add Test tag from Stanislav.
> >
> > v3:
> >  - Update copybreak value after closing nic and before opening nic when
> >    the device is running.
> >
> > v2:
> >  - Define max/vim rx_copybreak value.
> >
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 +++++----
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +-
> >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 48 ++++++++++++++++++-
> >  3 files changed, 65 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index bda3742d4e32..0f5fe9ba691d 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>
> > @@ -4510,7 +4513,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
> >                                   ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEA=
DROOM), 8) -
> >                                   SKB_DATA_ALIGN(sizeof(struct skb_shar=
ed_info));
> >                 } else {
> > -                       rx_size =3D SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH =
+ NET_IP_ALIGN);
> > +                       rx_size =3D SKB_DATA_ALIGN(bp->rx_copybreak +
> > +                                                NET_IP_ALIGN);
>
> When rx_copybreak is 0 or very small, rx_size will be very small and
> will be a problem.  We need rx_size to be big enough to contain the
> packet header, so rx_size cannot be below some minimum (256?).
>
> >                         rx_space =3D rx_size + NET_SKB_PAD +
> >                                 SKB_DATA_ALIGN(sizeof(struct skb_shared=
_info));
> >                 }
> > @@ -6424,8 +6428,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
> >                                           VNIC_PLCMODES_CFG_REQ_FLAGS_H=
DS_IPV6);
> >                 req->enables |=3D
> >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_T=
HRESHOLD_VALID);
> > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh);
> > -               req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);
> > +               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak);
> > +               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
>
> Similarly, these thresholds should not go to 0 when rx_copybreak becomes =
small.
>
> >         }
> >         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> >         return hwrm_req_send(bp, req);
>
> > @@ -4769,7 +4813,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
> >         cpr =3D &rxr->bnapi->cp_ring;
> >         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
> >                 cpr =3D rxr->rx_cpr;
> > -       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh);
> > +       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copybreak);
>
> The loopback test will also not work if rx_copybreak is very small.  I
> think we should always use 256 bytes for the loopback test packet
> size.  Thanks.
>
> >         skb =3D netdev_alloc_skb(bp->dev, pkt_size);
> >         if (!skb)
> >                 return -ENOMEM;

I tested `ethtool -t eth0` and I checked it fails if rx-copybreak is too
small. Sorry for missing that.
I think we can use max(BNXT_DEFAULT_RX_COPYBREAK,
bp->rx_copybreak) for both cases.
I tested it, it works well.
So I will use that if you are okay!

Thank you so much,
Tahee Yoo

