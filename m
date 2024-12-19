Return-Path: <netdev+bounces-153377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E196D9F7CCB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E381617B3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C550433CA;
	Thu, 19 Dec 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0UbVWwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD922075;
	Thu, 19 Dec 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617146; cv=none; b=lNo5ZSoMfEErFxms7ot5zGeM2Z6rgAB3tk969FnYPCapiCDLVP6g+ahuK7g8zh/ZjvhGgoYQL1X/++xRHV9UYJMHKXZpPk9Y8rgehcIseYLnvyvRViKAPBBeiGeZIG2FVxwJg199oish1kao+lHF8c4CZYvdEfyjztIpXs/GDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617146; c=relaxed/simple;
	bh=LQuvRPkkECRjuBxoMm5LisEmYoylQlr8GMS9zFI1Hx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAbeYub4bQpijMBljHMUFrrTnckWMalBy1+T9xEsryi3gZTW+YRbMc6ZvwQCeB0lYpZNR92PYyzcH7UGm6vfi9Fs9UC/EcTn10AQlmm+mCVvLEzbqxb6PkUpoEwDC8a7zguKLwA+uPTnXbsFBnRK0myU9MrGpKQpXO7C/ynGGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0UbVWwe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aab925654d9so158783666b.2;
        Thu, 19 Dec 2024 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617143; x=1735221943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntEgSIINYUFJbAGsxQmLJiThHyN2BlQp6rPy7mWVRSI=;
        b=T0UbVWweTrS63zlS9DmMgqlrgZjkB3OsyIat2yos6aKr9Q+EfM5gk9kZKWOt2mo8T8
         +A4G/PC9/Urk6Ozd/ZZ/xSRUIF0hIdMXeFAkZ6hgpJpE5JO8drYlj9II5yFGSy1S6AQp
         T2pEJMpo6DcD4d/g/kTDefqhmI4kle7+XXV/LUcGJzNQH2zI/70En3qadhQ/criMKdXR
         P6r/SJT+5LCxmTSEhdjhJuYWp5M2HK08MF3DJA6fwPH+WVexoD7ayGE2rxlAr08T4bDn
         ecKV7tH6blpYkldOm3ZXvWUNVnQOPUMRP0S6mGyYOAiwuRC3EKPe5gs9BwdhCYP7fpEW
         3Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617143; x=1735221943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntEgSIINYUFJbAGsxQmLJiThHyN2BlQp6rPy7mWVRSI=;
        b=taBL0+Ugn5GNqCyZ0RkBMDzB4ft2RFeHLCHJsc3moQupQSf6tjC1AFQcKeDc9wua2h
         wbGyiqZsVk8HexN7nW6JTKLw0HxNce/b4k5ZwEUG0U6O70BZV6qo1lrnB4zBmYsxFA9I
         k270QY1ObR1NfNdcTLMZ6QaER4RZcxsfs9gRbQYPWK0j+1YZ9F12xCc8qO6da6txI7w8
         k+e/gwq8ANsYeHzw8ysPJOkhIY+EfiRrLN91ko4lzb590AA1lyVOyCVw77EFa2MBOI91
         LJUJp5gbcM6UKADmvDGprBl2+KSHJoY7jldBWZ4qcx2CAD6gKWjZ+K8eQkdahbj3SRz2
         uhug==
X-Forwarded-Encrypted: i=1; AJvYcCVIe6KMdN8poR2RUcc3b+2N3e6P3kkDhBOUdvgLa36hulMGHMpUp4tK+CvhBFLT8rp6iPD/Ze8H@vger.kernel.org, AJvYcCVb3HIqGKfGtszbm34w9o/T3pNXAPiMaxNTLfBzc2bNIofTM0UradaGFxCq5ntiUql8e4GUw5Iw8oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Dxf8iU9ZiQ/faaOp91kxNTS8AzjSCNzYUqdQr65WJHQhPjl2
	AVpyljjwYfvsR+jlB5gvTd2Uyt+xHCeL2l7tROsRf204kWt2lH4V1/yW7R8/SnchQrauTtajwlf
	W5x5CZ+io5b/JKhO1r7QvO/pFjr0=
X-Gm-Gg: ASbGnctWDgWxb/yBfzUckL7MmzySBcgzBgzjJ3KaM/LJ9Pa76z4pQtrrguRccwzFWoX
	dp987ubbdzeDGw4J+acOMyndB1Jl4r5NA+01eP30=
X-Google-Smtp-Source: AGHT+IHfEy+l2gpD6X5F+qzS9831iLWHNoWbWMk02+H/m1ztTUDqXX6dz/7RZNjjOZMAT2j0pNe1Stme/jmpFkDCMbM=
X-Received: by 2002:a17:906:32ce:b0:aa6:8814:1545 with SMTP id
 a640c23a62f3a-aabf48ce201mr648682766b.41.1734617142495; Thu, 19 Dec 2024
 06:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-4-ap420073@gmail.com>
 <20241218182547.177d83f8@kernel.org>
In-Reply-To: <20241218182547.177d83f8@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Dec 2024 23:05:30 +0900
Message-ID: <CAMArcTXAm9_zMN0g_2pECbz3855xN48wvkwrO0gnPovy92nt8g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 18 Dec 2024 14:45:24 +0000 Taehee Yoo wrote:
> > +     if (tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_=
config_mod)
> > +             return -EOPNOTSUPP;
>
> I think ethtool ops generally return -EINVAL when param not supported.
> EOPNOTSUPP means entire op is not supported (again, that's just how
> ethtool ops generally work, not a kernel-wide rule).

Thanks! I will use -EINVAL instead of EOPNOTSUPP.

>
> > +     if (tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> > +         hds_config_mod && BNXT_RX_PAGE_MODE(bp)) {
>
> Looks like patch 4 adds this check in the core. I think adding the
> check in the core can be a separate patch. If you put it before this
> patch in the series this bnxt check can be removed?
>
> I mean this chunk in the core:
>
> +       hds_config_mod =3D old_hds_config !=3D kernel_ringparam.tcp_data_=
split;
> +       if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED &&
> +           hds_config_mod && dev_xdp_sb_prog_count(dev)) {
> +               NL_SET_ERR_MSG(info->extack,
> +                              "tcp-data-split can not be enabled with si=
ngle buffer XDP");
> +               return -EINVAL;
> +       }
>

Right, The core checks single buffer XDP.
But there was a review that bnxt_en driver doesn't support both
single and multi buffer XDP if HDS is in use.
So, this is the reason why logic exists.

> It's currently in the hds-thresh patch but really it's unrelated
> to the threshold..

Thanks, I will move this code to a HDS related patch, not hds-threshold,
or create new patch for this.

>
> > +             NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed =
when XDP is attached");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (netif_running(dev))
> >               bnxt_close_nic(bp, false, false);
> >
> > +     if (hds_config_mod) {
> > +             if (tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED)
> > +                     bp->flags |=3D BNXT_FLAG_HDS;
> > +             else if (tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_UNK=
NOWN)
> > +                     bp->flags &=3D ~BNXT_FLAG_HDS;
> > +     }
> > +
> >       bp->rx_ring_size =3D ering->rx_pending;
> >       bp->tx_ring_size =3D ering->tx_pending;
> >       bnxt_set_ring_params(bp);
> > @@ -5354,6 +5374,7 @@ const struct ethtool_ops bnxt_ethtool_ops =3D {
> >                                    ETHTOOL_COALESCE_STATS_BLOCK_USECS |
> >                                    ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> >                                    ETHTOOL_COALESCE_USE_CQE,
> > +     .supported_ring_params  =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> >       .get_link_ksettings     =3D bnxt_get_link_ksettings,
> >       .set_link_ksettings     =3D bnxt_set_link_ksettings,
> >       .get_fec_stats          =3D bnxt_get_fec_stats,
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_xdp.c
> > index f88b641533fc..1bfff7f29310 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > @@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bp=
f_prog *prog)
> >                           bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
> >               return -EOPNOTSUPP;
> >       }
> > +     if (prog && bp->flags & BNXT_FLAG_HDS) {
> > +             netdev_warn(dev, "XDP is disallowed when HDS is enabled.\=
n");
> > +             return -EOPNOTSUPP;
> > +     }
>
> And this check should also live in the core, now that core has access
> to dev->ethtool->hds_config ? I think you can add this check to the
> core in the same patch as the chunk referred to above.

The bnxt_en disallows setting up both single and multi buffer XDP, but core
checks only single buffer XDP. So, if multi buffer XDP is attaching to
the bnxt_en driver when HDS is enabled, the core can't filter it.

Thanks a lot!
Taehee Yoo

