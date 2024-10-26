Return-Path: <netdev+bounces-139294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808009B14F7
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 07:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E461FB21653
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 05:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854B91632D9;
	Sat, 26 Oct 2024 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZWl4Z9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE414EC47;
	Sat, 26 Oct 2024 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729919491; cv=none; b=Q+0ZWccjFNk0Xn/YKhF6RCVu1AdFuvycvj9vQ378kSTnjvc42LzBDU+ca9r9BU9mrW+buSnxq18hpxGVlxpj1YPCMMi4BBc3jwvuXaIfI5v4UNxdr0ZelkzhDEgpY83pEa8j/y00VvhL9APQuZ3E0iRBngv9pALTw6R4aLbPFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729919491; c=relaxed/simple;
	bh=McFv6i9UQcN/k/nhaQP/YsTf1hwbsUeQnG0tS0NSIzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4aiuekyILLQbO37wRWq7AUZnYFZBN46/57+cJWNrJgeXqV53VVmSoxBQe6cpunc56jLgjsQ3wGSnnN7zr04yP138SOoMniwiqIkHp0c02ccmVFJ5Tq6s07+2PCDh9ZvnBsEnP1AuhsphAFky/6AUqX/hSxqREl9gCRbWRA9/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZWl4Z9/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99ea294480so183710466b.2;
        Fri, 25 Oct 2024 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729919487; x=1730524287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxqf2Vbhgw6HqjwNVbbcfem37l/wnYntm54FveWHRgM=;
        b=UZWl4Z9/YVh7Oys/gsXgGueV8ZOcY6g2q4b0CbPZlMsNfcCKc85RlEhRCKA6ST2CSR
         8PDlxRypRmwJvZIXmuH+cxUtkTHTKqnTG/Oiqj1YI1STEO0hQ3UR56Z0gP7x2YeXMKud
         zm3+kV6uU73ztWWUoSdxknb8HpepACTqk3TrAcCGpEXgHnzLfFkNXDvPEXGM7DLUftD+
         ahxl0EzK5UhrvImzXbW5IgG086tJUIlrrRGV5L6ZL3t1RLcwSga/fs0SW6a9bojj76YZ
         LsMXvDNF0yXpeRKVAxZnMVofAyASmt41zUmDVa2ZBxmVEVlsklhs10+PCgq6yUrhqo2o
         9lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729919487; x=1730524287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxqf2Vbhgw6HqjwNVbbcfem37l/wnYntm54FveWHRgM=;
        b=cN8ZKE31xM8oQiVaShRQvBOd5mUFU3XAZ+dl+ziDbetw3UCLd18QrPFMSUx3e1H3tO
         Q6jxEuiIhT0n85Y+GttV8DjiVQj3YspuXP4UDX43GfMc7SEolgVoX+ZtXrHhEJAEYQcJ
         mGz4fb3QF2vU8Se8e6nHyQcdSxjGDJdXBU75cTleQ6/Asu9XRndjlm6bA+S9Oy2WCAT3
         uQBLzD9wbna4YSfbPyHxtYIkRj7GCZ9soEPUqrdwJ4k4e76UfHRBXegTh/b4EWPOCBuC
         ZBcrynPP8q8IDnXWVRPhFURKtsVT8ddz2x+r+bGK5gowgcvP23YJuvQ9hsDk6r721e6Q
         8ypQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVi70xC1biUsQbM5L+rBvobegB+LUbtFuRgNWX5alucUMuHFpadZeDpT88f3/pAfx9Jsd6k6HO@vger.kernel.org, AJvYcCXkuz8hHgaR2tn5z+ZfjbrzQvJigep+D1NlmTnRQMOOgsmpLn9djPGH6AbaKAFJZw3uITica6H1LrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9fMI0VCKaXb24lhTTW4RqNY/xHIsxrjRyaSV9DpaHb4b538H
	X7UZiFPOSoWV/ohiLW3eR9y8JsPlPJXWVV2NeHUupZZLINDiOfNSH1lKAc+g0t85tZDfCZhjDnu
	Sj/j/PQ3YHfUhiiiVpnIpLvzF6QU=
X-Google-Smtp-Source: AGHT+IFQYE/UT9oHGzFoJnp/9TIsc6W3ik2NF0iTGv/VM1ntvMxNHiwy/m2+cv0S/llQ+YY71LqUhCGKBH+t/IwLqXE=
X-Received: by 2002:a05:6402:1f4b:b0:5c8:9529:1b59 with SMTP id
 4fb4d7f45d1cf-5cbbf8dec0bmr1387729a12.20.1729919486838; Fri, 25 Oct 2024
 22:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-3-ap420073@gmail.com>
 <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com>
 <ZxvwZmJsdFOStYcV@JRM7P7Q02P.dhcp.broadcom.net> <CACKFLinbsMQE1jb0G-7iMKAo4ZMKp42xiSCZ0XznBV9pDAs3-g@mail.gmail.com>
In-Reply-To: <CACKFLinbsMQE1jb0G-7iMKAo4ZMKp42xiSCZ0XznBV9pDAs3-g@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 26 Oct 2024 14:11:15 +0900
Message-ID: <CAMArcTWrA0ib9XHnSGGH-sNqQ9TG0BaRq+5nsGC3iQv6Zd40rQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split
 ethtool command
To: Michael Chan <michael.chan@broadcom.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, almasrymina@google.com, 
	donald.hunter@gmail.com, corbet@lwn.net, andrew+netdev@lunn.ch, 
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

On Sat, Oct 26, 2024 at 7:00=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Fri, Oct 25, 2024 at 12:24=E2=80=AFPM Andy Gospodarek
> <andrew.gospodarek@broadcom.com> wrote:

Hi Andy,
Thank you so much for your review!

> >
> > On Thu, Oct 24, 2024 at 10:02:30PM -0700, Michael Chan wrote:
> > > On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.co=
m> wrote:
> > > >
> > > > NICs that uses bnxt_en driver supports tcp-data-split feature by th=
e
> > > > name of HDS(header-data-split).
> > > > But there is no implementation for the HDS to enable or disable by
> > > > ethtool.
> > > > Only getting the current HDS status is implemented and The HDS is j=
ust
> > > > automatically enabled only when either LRO, HW-GRO, or JUMBO is ena=
bled.
> > > > The hds_threshold follows rx-copybreak value. and it was unchangeab=
le.
> > > >
> > > > This implements `ethtool -G <interface name> tcp-data-split <value>=
`
> > > > command option.
> > > > The value can be <on>, <off>, and <auto> but the <auto> will be
> > > > automatically changed to <on>.
> > > >
> > > > HDS feature relies on the aggregation ring.
> > > > So, if HDS is enabled, the bnxt_en driver initializes the aggregati=
on
> > > > ring.
> > > > This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
> > > >
> > > > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > > ---
> > > >
> > > > v4:
> > > >  - Do not support disable tcp-data-split.
> > > >  - Add Test tag from Stanislav.
> > > >
> > > > v3:
> > > >  - No changes.
> > > >
> > > > v2:
> > > >  - Do not set hds_threshold to 0.
> > > >
> > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++-----
> > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
> > > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++++++=
++
> > > >  3 files changed, 19 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt.c
> > > > index 0f5fe9ba691d..91ea42ff9b17 100644
> > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > >
> > > > @@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bn=
xt *bp, struct bnxt_vnic_info *vnic)
> > > >
> > > >         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMB=
O_PLACEMENT);
> > > >         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_=
JUMBO_THRESH_VALID);
> > > > +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> > > >
> > > > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_si=
ze);
> > >
> > > Please explain why this "if" condition is removed.
> > > BNXT_RX_PAGE_MODE() means that we are in XDP mode and we currently
> > > don't support HDS in XDP mode.  Added Andy Gospo to CC so he can also
> > > comment.
> > >
> >
> > In bnxt_set_rx_skb_mode we set BNXT_FLAG_RX_PAGE_MODE and clear
> > BNXT_FLAG_AGG_RINGS
>
> The BNXT_FLAG_AGG_RINGS flag is true if the JUMBO, GRO, or LRO flag is
> set.  So even though it is initially cleared in
> bnxt_set_rx_skb_mode(), we'll set the JUMBO flag if we are in
> multi-buffer XDP mode.  Again, we don't enable HDS in any XDP mode so
> I think we need to keep the original logic here to skip setting the
> HDS threshold if BNXT_FLAG_RX_PAGE_MODE is set.

I thought the HDS is disallowed only when single-buffer XDP is set.
By this series, Core API disallows tcp-data-split only when
single-buffer XDP is set, but it allows tcp-data-split to set when
multi-buffer XDP is set.

+       if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_E=
NABLED &&
+           dev_xdp_sb_prog_count(dev)) {
+               NL_SET_ERR_MSG(info->extack,
+                              "tcp-data-split can not be enabled with
single buffer XDP");
+               return -EINVAL;
+       }

I think other drivers would allow tcp-data-split on multi buffer XDP,
so I wouldn't like to remove this condition check code.

I will not set HDS if XDP is set in the bnxt_hwrm_vnic_set_hds()
In addition, I think we need to add a condition to check XDP is set in
bnxt_set_ringparam().

>
> > , so this should work.  The only issue is that we
> > have spots in the driver where we check BNXT_RX_PAGE_MODE(bp) to
> > indicate that XDP single-buffer mode is enabled on the device.
> >
> > If you need to respin this series I would prefer that the change is lik=
e
> > below to key off the page mode being disabled and BNXT_FLAG_AGG_RINGS
> > being enabled to setup HDS.  This will serve as a reminder that this is
> > for XDP.
> >
> > @@ -6418,15 +6418,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *=
bp, struct bnxt_vnic_info *vnic)
> >
> >         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PL=
ACEMENT);
> >         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMB=
O_THRESH_VALID);
> > +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> >
> > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> > -       } else {
> > +       if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RINGS)=
) {
> >                 req->flags |=3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS=
_HDS_IPV4 |
> >                                           VNIC_PLCMODES_CFG_REQ_FLAGS_H=
DS_IPV6);
> >                 req->enables |=3D
> >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_T=
HRESHOLD_VALID);
> > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh);
> >                 req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);
> >         }
> >         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> >

Thanks a lot!
Taehee Yoo

