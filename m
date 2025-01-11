Return-Path: <netdev+bounces-157411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E8A0A3F7
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F8188B3BD
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E36FBF;
	Sat, 11 Jan 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWqjLJVb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076524B22A;
	Sat, 11 Jan 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736603127; cv=none; b=FK/3ccwt5H46lLZJKiYisTkXA1XaI8Em85ZF1MCsL8gGsvx7VlquKIPZ8GlU98kIzUlgUD+upe+odvZw9TXJRT+eEn1YYslV0f9sNT9vPLL8qFiL9tiOYCBpE9Ib5n+4qdybit3OafAcMdxbl3nDVRkv1wqkG5ZsBSRemrcm61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736603127; c=relaxed/simple;
	bh=plJ5l5dhx6gUE80P4bXSr2/X35gI50O+7t23jOEXrlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwOPj+ZO++1B8MAJz9WuR0ig8CMuf1N80v6FsJRC7AGpl6jQQXlxNHV7o6HZnXPp+fxafCOnR0kLxHWYFToxIcwfLOyOLV4EhSISh2jqjISBAGXzZwl4Z04Dc3MsZOAITnPM3bWRAVYGqiyWomtpVcjgKo6s1QuOjxCOxRjStL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWqjLJVb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so7665229a12.1;
        Sat, 11 Jan 2025 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736603124; x=1737207924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2VkHxnXVvczOiim35DmLDoGGBLm6dk8vE3eitMmdBc=;
        b=ZWqjLJVbU8tqdFgaZXfySbZje9rT1mb10PIn7bRure0a2xULV4AZeuUKjgPYJJMQo2
         kS/61FLl+EwFLQ9BmTezglnh3Th+8kkl6vrdFGi3K7Fl1pIUdKEjZH4cTaih1HwY9E0t
         5farv/UZWeGwa/eM8ZyrjBCqujsOonceELKSDmZQJ0M4BuDnsN9eSQ2VrzFX4OnkFtiw
         cUOm76gM97QataD85zOjWiHXrcLgOJex9xeMEO9ilHE8ZXjLD2ysTlbEXnxxv5THcFK3
         3cp13RA7gevSee2AB6WqNkj8fNvAXJgC2ZviYx8LgZkIopcVBYnjbYfFkobwWxiEhRXF
         roDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736603124; x=1737207924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2VkHxnXVvczOiim35DmLDoGGBLm6dk8vE3eitMmdBc=;
        b=uxd0yUjL4iLJ2ylXV0CoEw/Y7IP5D+N2kJPXvukkLVRNXjp46H8v4h7NbsFTu6dKgr
         FxrbnnCLAYZpQQVBECP2UJMS/b1+v5g0B9dWvll0uQgx+MJoGd0n9Ld7NWagvdJZ1nVP
         b37VkLYk9odx0DzajOg2P0NPbJ/rUn25aeFZWV5XF8MAU+Ykqfw3qfeDOoubRMQi2q0C
         R7nF6Hk8rQTg8GotA+2qb57Z1tkxz4QOLtZsggNxiEhZ2wb/HRXz29I9JZcn1eCN9Zdu
         Ecue14j3ZzVOxkl+IAyM/iiQLugDg9UguBGgnv3XEI9B1znuKPWAtewCGmqCPWANZhGo
         DXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5s3+QHpKcNqEf0TmvU/+3HIlV4aaJvuPmt12fhyTTYLjQLWsqVXlT3ZbjzsGVAgXpQQYiA5Iw@vger.kernel.org, AJvYcCXSf7jpnURdDYJaAHl3lTBeBEpDLP3fFvSFj6XMixsk5m/K5Hv7m/PkgtuJh4M2Od0j6GmuWOqkh1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrdsiUK/MSz9tqyVA3OS25awq1aojAL+ZBfLegAIhJ06zZV+p
	snNj/pmhw3UEQgWjTkfuqCg+xfLog4ifIVlo0tOBQn419JUiUdYLfSh8Fw47DaYHCd5TWODQlMP
	qgaFZNf1Lxw2mtxXIy06mGepDS5M=
X-Gm-Gg: ASbGncudJL9NpgfwRLWi6IZpiXBJg4iFbeXwiW2XLUm008MSug8StEWZzEKSdYWaqyI
	wB5mxDTrBNqQmLAoZauBjX6996dMoszliu10cUVs=
X-Google-Smtp-Source: AGHT+IHBY4UN5s2GFcT273rm7SVawsHEwUksSjTsp7Zq1VGFhu2AfK0FcVpoFHSu8RtmcdCzj0JBiLgR3v7eH2O/O0Q=
X-Received: by 2002:a05:6402:50d1:b0:5d3:f041:140e with SMTP id
 4fb4d7f45d1cf-5d98627dfa5mr9216536a12.13.1736603123353; Sat, 11 Jan 2025
 05:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103150325.926031-1-ap420073@gmail.com> <20250103150325.926031-9-ap420073@gmail.com>
 <Z4FwxI-HcjcP2SIt@JRM7P7Q02P.dhcp.broadcom.net>
In-Reply-To: <Z4FwxI-HcjcP2SIt@JRM7P7Q02P.dhcp.broadcom.net>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 11 Jan 2025 22:45:11 +0900
X-Gm-Features: AbW1kvb9AXIRqFJ_FFNP8HHqTzF4VRHJLZS2B84xyFtkFbb3FI1Rs9_gz9f-ZLo
Message-ID: <CAMArcTWCh-z7q0b=p9Q_x3T18xZFP_JSOwyM_ygox0OZwyvmBA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/10] bnxt_en: add support for hds-thresh
 ethtool command
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk, 
	sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 4:11=E2=80=AFAM Andy Gospodarek
<andrew.gospodarek@broadcom.com> wrote:
>

Hi Andy,
Thank you so much for your review and testing!

> On Fri, Jan 03, 2025 at 03:03:23PM +0000, Taehee Yoo wrote:
> > The bnxt_en driver has configured the hds_threshold value automatically
> > when TPA is enabled based on the rx-copybreak default value.
> > Now the hds-thresh ethtool command is added, so it adds an
> > implementation of hds-thresh option.
> >
> > Configuration of the hds-thresh is applied only when
> > the tcp-data-split is enabled. The default value of
> > hds-thresh is 256, which is the default value of
> > rx-copybreak, which used to be the hds_thresh value.
> >
> > The maximum hds-thresh is 1023.
> >
> >    # Example:
> >    # ethtool -G enp14s0f0np0 tcp-data-split on hds-thresh 256
> >    # ethtool -g enp14s0f0np0
> >    Ring parameters for enp14s0f0np0:
> >    Pre-set maximums:
> >    ...
> >    HDS thresh:  1023
> >    Current hardware settings:
> >    ...
> >    TCP data split:         on
> >    HDS thresh:  256
> >
> > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Tested-by: Andy Gospodarek <gospo@broadcom.com>
>
> Still looks good.

I'm going to send v8 patch, and there is a change for bnxt driver.
Drivers no longer need to set dev->ethtool->hds_thresh by themselves
instead, the ethtool core sets hds_thresh value.

>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v7:
> >  - Use dev->ethtool->hds_thresh instead of bp->hds_thresh
> >
> > v6:
> >  - HDS_MAX is changed to 1023.
> >  - Add Test tag from Andy.
> >
> > v5:
> >  - No changes.
> >
> > v4:
> >  - Reduce hole in struct bnxt.
> >  - Add ETHTOOL_RING_USE_HDS_THRS to indicate bnxt_en driver support
> >    header-data-split-thresh option.
> >  - Add Test tag from Stanislav.
> >
> > v3:
> >  - Drop validation logic tcp-data-split and tcp-data-split-thresh.
> >
> > v2:
> >  - Patch added.
> >
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 +++-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 7198d05cd27b..df03f218a570 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -4603,6 +4603,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
> >  static void bnxt_init_ring_params(struct bnxt *bp)
> >  {
> >       bp->rx_copybreak =3D BNXT_DEFAULT_RX_COPYBREAK;
> > +     bp->dev->ethtool->hds_thresh =3D BNXT_DEFAULT_RX_COPYBREAK;
> >  }
> >
> >  /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO fla=
gs must
> > @@ -6562,6 +6563,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct =
bnxt *bp)
> >
> >  static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_in=
fo *vnic)
> >  {
> > +     u16 hds_thresh =3D (u16)bp->dev->ethtool->hds_thresh;
> >       struct hwrm_vnic_plcmodes_cfg_input *req;
> >       int rc;
> >
> > @@ -6578,7 +6580,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
> >                                         VNIC_PLCMODES_CFG_REQ_FLAGS_HDS=
_IPV6);
> >               req->enables |=3D
> >                       cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THR=
ESHOLD_VALID);
> > -             req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> > +             req->hds_threshold =3D cpu_to_le16(hds_thresh);
> >       }
> >       req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> >       return hwrm_req_send(bp, req);
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 7dc06e07bae2..8f481dd9c224 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -2779,6 +2779,8 @@ struct bnxt {
> >  #define SFF_MODULE_ID_QSFP28                 0x11
> >  #define BNXT_MAX_PHY_I2C_RESP_SIZE           64
> >
> > +#define BNXT_HDS_THRESHOLD_MAX                       1023
> > +
> >  static inline u32 bnxt_tx_avail(struct bnxt *bp,
> >                               const struct bnxt_tx_ring_info *txr)
> >  {
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index 413007190f50..829697bfdab3 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -833,6 +833,9 @@ static void bnxt_get_ringparam(struct net_device *d=
ev,
> >       ering->rx_pending =3D bp->rx_ring_size;
> >       ering->rx_jumbo_pending =3D bp->rx_agg_ring_size;
> >       ering->tx_pending =3D bp->tx_ring_size;
> > +
> > +     kernel_ering->hds_thresh =3D dev->ethtool->hds_thresh;
> > +     kernel_ering->hds_thresh_max =3D BNXT_HDS_THRESHOLD_MAX;
> >  }
> >
> >  static int bnxt_set_ringparam(struct net_device *dev,
> > @@ -869,6 +872,7 @@ static int bnxt_set_ringparam(struct net_device *de=
v,
> >                       bp->flags &=3D ~BNXT_FLAG_HDS;
> >       }
> >
> > +     dev->ethtool->hds_thresh =3D kernel_ering->hds_thresh;

This will be removed and the 2/10 patch includes setting hds_thresh value
in the ethnl_set_rings().

> >       bp->rx_ring_size =3D ering->rx_pending;
> >       bp->tx_ring_size =3D ering->tx_pending;
> >       bnxt_set_ring_params(bp);
> > @@ -5390,7 +5394,8 @@ const struct ethtool_ops bnxt_ethtool_ops =3D {
> >                                    ETHTOOL_COALESCE_STATS_BLOCK_USECS |
> >                                    ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> >                                    ETHTOOL_COALESCE_USE_CQE,
> > -     .supported_ring_params  =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> > +     .supported_ring_params  =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT |
> > +                               ETHTOOL_RING_USE_HDS_THRS,
> >       .get_link_ksettings     =3D bnxt_get_link_ksettings,
> >       .set_link_ksettings     =3D bnxt_set_link_ksettings,
> >       .get_fec_stats          =3D bnxt_get_fec_stats,
> > --
> > 2.34.1
> >

Thanks a lot!
Taehee Yoo

