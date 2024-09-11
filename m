Return-Path: <netdev+bounces-127475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8B975874
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4058A1C2289F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741A1A3AB0;
	Wed, 11 Sep 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euyoGohp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19B19AA4E;
	Wed, 11 Sep 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072356; cv=none; b=j9zZinzvvGiFgogmCxiyU1we5yMOp6xNnSCUzYU4sBohTOUF+5dJeSJ79JGdCkXuzv5Ppel/DGx7m/PHa8LrxcM5oevnOjKIuC1Mi2twxjqzcTBI+FC2PF5OcMF3v7khz/jTofVq8mfKEZ/P6E16rg0vvMt8U2OQtPJIEO6y8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072356; c=relaxed/simple;
	bh=l6tN1fB1DAUGHQRd1JAcl9CNS4Lv7CmIqTpjcfJtECc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZJo3Qd75nmS0ZJ7pB/8mpBWmdekYxMhyOuU2h9q1f318UJAhCT6PxLS4SZRIGy4LNcp3aiwGFavqDfNQZDLub+gsMk+v7YneDsIeHmHA3eUsz/x5mJFW+ghBQaAWXLI8chMivWmQeI4nToGD1nfdbVC/l4d4BjuI+5Apv2BYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euyoGohp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so3605997a12.2;
        Wed, 11 Sep 2024 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726072353; x=1726677153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqK7FUPjoKzTVulLCanmAP2mrsgWIO6hdgJkQDjRmGQ=;
        b=euyoGohpULHYIYx5toKbTmytdKNnThl/j8dOV1XKBD/jtEeZqCp490h9a3LDMtZIVM
         XRKB9rNjzVYEXycoqCGQFKs1Rdph7NUKvtkc4TczD6ymOHbdCQo7NBK0AEN+GFXdQ/nT
         Pwy4jO+dqDcN3EHFsYgLmsOB91soKwYCfyhSrbxp+j+R8HX2Ru4bVBUbE73j6Qby6LIn
         7flZNdYLD4y3Ev3WFbFjt5R6JDJmLDW7qLjmAruu721z5Q7DiNd8iD/OjCD6uQWjqBxA
         4udpnhiKMWHh0sWN3ao3revo3lQCXuZQD3L2Dm/ckb+gAdYjhun90tpK7lrMDiGzQe7j
         Tddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726072353; x=1726677153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqK7FUPjoKzTVulLCanmAP2mrsgWIO6hdgJkQDjRmGQ=;
        b=Gis2Ns2eG+nBGxgA+wuDUyDjUUJzx9p8TzrqGP/Xn7gQXC5kO0Ue3bj/mVNNXASTLy
         6cXoyo5jLuIce8I+nbOQCp5Xf4D3vRtCH1vBu56ftUw7jl7iPzwqJ3sm+iddw+XGfKMe
         NLsOCSYS0A16/scuHwVB0K0QVc1ueXTDhebb58d5vVhJkU24kiJnILAGvVMuISCFIc0a
         f+2V+ntYlbKTalX69BW98wSckIePvivm4eXMj4KwXf/Z57rX26Pj4LlNzWxVbEah4ZWw
         PHCPgrI4gMm0Mw/aCVQMz4DIOKsBE9qslEM7bT4ycmlTp/lWocQESqnviT7+SlOULwNd
         auNA==
X-Forwarded-Encrypted: i=1; AJvYcCXqtlR6VwbR323VT6A9EOi08QPEsVOaqrNqYnUFuxvrEcR9JNqUdw/LqsoMMvjb8QQVKQev7Tj1@vger.kernel.org, AJvYcCXx7fbz4gBhLyfESViDupbHakohVxEE55wLnESPs/NKUhn3KjpE27/xYGoI9+u9rXDtFDulVbAZY20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EzIntrVC4D9c2l+1SB/SHazNVGorAT+LSKOvSpOyoPXIHqCW
	G2waXFN4XiQEshRvY3WmVWPt3jr49xQMwAcLUntMVXLjbcMOuT2wW7z+og2BfsOA61O+jIctt5X
	xiEXx5/C7QuCdP/4zEuwhPicGQKM=
X-Google-Smtp-Source: AGHT+IF7DZiatRywXyOOdx/i3oUU+grJADTbDcg0ofOTBtjRyYpsEvwBe9W7y2PkLDtYdyHkiKlh8X5yp7bjJA5PSAI=
X-Received: by 2002:a05:6402:3596:b0:5c3:d0e1:9f81 with SMTP id
 4fb4d7f45d1cf-5c413e057bdmr88862a12.7.1726072352503; Wed, 11 Sep 2024
 09:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911145555.318605-1-ap420073@gmail.com> <20240911145555.318605-5-ap420073@gmail.com>
 <4973cca2-9e58-42cd-8b28-98fe08bf95a2@amd.com>
In-Reply-To: <4973cca2-9e58-42cd-8b28-98fe08bf95a2@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 12 Sep 2024 01:32:20 +0900
Message-ID: <CAMArcTUC7eKaUfsEWQyR=aH_OMOcKxN9w2pHvui35AXP_5_GUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
To: Brett Creeley <bcreeley@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, corbet@lwn.net, michael.chan@broadcom.com, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	kory.maincent@bootlin.com, ahmed.zaki@intel.com, paul.greenwalt@intel.com, 
	rrameshbabu@nvidia.com, idosch@nvidia.com, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:52=E2=80=AFAM Brett Creeley <bcreeley@amd.com> w=
rote:

Hi Brett,
Thank you so much for your review!

>
>
>
> On 9/11/2024 7:55 AM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > The bnxt_en driver has configured the hds_threshold value automatically
> > when TPA is enabled based on the rx-copybreak default value.
> > Now the tcp-data-split-thresh ethtool command is added, so it adds an
> > implementation of tcp-data-split-thresh option.
> >
> > Configuration of the tcp-data-split-thresh is allowed only when
> > the tcp-data-split is enabled. The default value of
> > tcp-data-split-thresh is 256, which is the default value of rx-copybrea=
k,
> > which used to be the hds_thresh value.
> >
> >     # Example:
> >     # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 2=
56
> >     # ethtool -g enp14s0f0np0
> >     Ring parameters for enp14s0f0np0:
> >     Pre-set maximums:
> >     ...
> >     Current hardware settings:
> >     ...
> >     TCP data split:         on
> >     TCP data split thresh:  256
> >
> > It enables tcp-data-split and sets tcp-data-split-thresh value to 256.
> >
> >     # ethtool -G enp14s0f0np0 tcp-data-split off
> >     # ethtool -g enp14s0f0np0
> >     Ring parameters for enp14s0f0np0:
> >     Pre-set maximums:
> >     ...
> >     Current hardware settings:
> >     ...
> >     TCP data split:         off
> >     TCP data split thresh:  n/a
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v2:
> >   - Patch added.
> >
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
> >   drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++++
> >   3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index f046478dfd2a..872b15842b11 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -4455,6 +4455,7 @@ static void bnxt_init_ring_params(struct bnxt *bp=
)
> >   {
> >          bp->rx_copybreak =3D BNXT_DEFAULT_RX_COPYBREAK;
> >          bp->flags |=3D BNXT_FLAG_HDS;
> > +       bp->hds_threshold =3D BNXT_DEFAULT_RX_COPYBREAK;
> >   }
> >
> >   /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO fl=
ags must
> > @@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
> >                                            VNIC_PLCMODES_CFG_REQ_FLAGS_=
HDS_IPV6);
> >                  req->enables |=3D
> >                          cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_=
THRESHOLD_VALID);
> > -               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> > +               req->hds_threshold =3D cpu_to_le16(bp->hds_threshold);
> >          }
> >          req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> >          return hwrm_req_send(bp, req);
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 35601c71dfe9..48f390519c35 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -2311,6 +2311,8 @@ struct bnxt {
> >          int                     rx_agg_nr_pages;
> >          int                     rx_nr_rings;
> >          int                     rsscos_nr_ctxs;
> > +#define BNXT_HDS_THRESHOLD_MAX 256
> > +       u16                     hds_threshold;
> >
> >          u32                     tx_ring_size;
> >          u32                     tx_ring_mask;
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index ab64d7f94796..5b1f3047bf84 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -839,6 +839,8 @@ static void bnxt_get_ringparam(struct net_device *d=
ev,
> >          else
> >                  kernel_ering->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLI=
T_DISABLED;
> >
> > +       kernel_ering->tcp_data_split_thresh =3D bp->hds_threshold;
> > +
> >          ering->tx_max_pending =3D BNXT_MAX_TX_DESC_CNT;
> >
> >          ering->rx_pending =3D bp->rx_ring_size;
> > @@ -864,6 +866,12 @@ static int bnxt_set_ringparam(struct net_device *d=
ev,
> >                  return -EINVAL;
> >          }
> >
> > +       if (kernel_ering->tcp_data_split_thresh > BNXT_HDS_THRESHOLD_MA=
X) {
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                                  "tcp-data-split-thresh size too big"=
);
>
> Should you print the BNXT_HDS_THRESHOLD_MAX value here so the user knows
> the max size?

Okay, I will print BNXT_HDS_THRESHOLD_MAX value with extack message.

>
> Actually, does it make more sense for ethtool get_ringparam to query the
> max threshold size from the driver and reject this in the core so all
> drivers don't have to have this same kind of check?

Ah, I didn't consider this.
You mean that like ETHTOOL_A_RINGS_RX_MAX, right?
So, we can check precise information in userspace without error.

We can check tcp-data-split-threshold-max information like below.
ethtool -g enp13s0f0np0
Ring parameters for enp13s0f0np0:
Pre-set maximums:
RX: 2047
RX Mini: n/a
RX Jumbo: 8191
TX: 2047
TX push buff len: n/a
TCP data split thresh: 256 <-- here
Current hardware settings:
RX: 511
RX Mini: n/a
RX Jumbo: 2044
TX: 511
RX Buf Len: n/a
CQE Size: n/a
TX Push: off
RX Push: off
TX push buff len: n/a
TCP data split: on
TCP data split thresh: 0

I agree with this suggestion.
So, I will try to add ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX
option in the ethtool core unless there is no objection.

>
> Thanks,
>
> Brett
>
> > +               return -EINVAL;
> > +       }
> > +
> >          if (netif_running(dev))
> >                  bnxt_close_nic(bp, false, false);
> >
> > @@ -871,6 +879,7 @@ static int bnxt_set_ringparam(struct net_device *de=
v,
> >          case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
> >          case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
> >                  bp->flags |=3D BNXT_FLAG_HDS;
> > +               bp->hds_threshold =3D (u16)kernel_ering->tcp_data_split=
_thresh;
> >                  break;
> >          case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
> >                  bp->flags &=3D ~BNXT_FLAG_HDS;
> > --
> > 2.34.1
> >
> >

Thanks a lot!
Taehee Yoo

