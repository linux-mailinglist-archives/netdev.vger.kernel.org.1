Return-Path: <netdev+bounces-141088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA19B970B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BE31F21EC4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3CC1CBE9B;
	Fri,  1 Nov 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIfuhPQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBD1C9DFE;
	Fri,  1 Nov 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484190; cv=none; b=m//abxCBt0W3DxWIwlt48RymDPorxzDfqtNfweZNZ3gyg0i6inG4IWoJLzlEe8WBItCEsit+Xk3Qtlj/nkZHY72NDh0JPisdyxaFy4zmHbmLD59mRGslkZotvSlLRJdxlOwTEZx8pFRJnxQ4ATC3N/Tv10Fh9ESgcQ/k1qFoBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484190; c=relaxed/simple;
	bh=2PFCJ1jIx50CTh8mnAHhd/LEOEjk5EjjiciJxGv0MQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG/HN7/yVF0o8ACsXAvAFZ7bTZ16OiXxGPH1xabz6X37Wc6cPLUjg9w4cSk4rE8SQwZKTRAV56UVq7zofyDItSD+oCtWwuDxHU2jCx8OQxEcjj8zN3wJc8iZASz3oIJwpQBPJZkBhFkAPI1vCvWkL1PuXFbh6seb6fnQSvSRucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIfuhPQB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so3062772a12.2;
        Fri, 01 Nov 2024 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484187; x=1731088987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtBrptE3IDFDm9Nqxu1m5bjFJws/Kg65BIqj6cJbQgA=;
        b=GIfuhPQBcKnv2sBYIUJJ4dRMiblU7RgAeSiKu4guOESFLYPxINK/xNeJF4rtM4woYY
         w8+D5NM4qAUjCByuS3ADXm/Ge+dMd4g6R6kI2Yo0euzJLbOu2nBFUj5qLLGH27GPgEmY
         KYD0OSaRgtH/NSCjBujHqas+PHv/ZTLW1fBA+Yh0V+pm6vNaRzs/sMbHMH2GpmIUhPBy
         vHU3KPZV+RueuqBc/Y5uvC2LvQ+veTF1UIgghOqgXojhY9oGDDJCN+HlGRDi+81XisP3
         iFCD557WxHbt4sjrpjvSxywNH2PL4Y4RHD8kbHTzkV6rl/ampVh73qDxiU+q4nQ4hYWu
         HB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484187; x=1731088987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtBrptE3IDFDm9Nqxu1m5bjFJws/Kg65BIqj6cJbQgA=;
        b=UMRkeSv6C5dIURHdSrJaP2FNYusai0VCRt2jeTl6/7ML0JR+9gFYtscLXRd7RWBm/0
         sK8YKS+uoCWCD7+Fyc/u22yMp/P62M2PbQiRjo9+1f1FzPaAkud8yFDm44xPbCcSmFXl
         0ookEsfFCTIi+6/mx5cQFMHMp2vl6ruPNTNv1iTY/mN1MPAPxIhdP+BGLNEFihLAuU5d
         MkWnvAGLYXfxDwB7/YUJYEgByMUHoUH86a/9kVpJqdYi/W+AhmUeCR1YINC7f21/1LsS
         kBNxlOpuT/tBaeCswRQD5Zk01C0j6kWuVX/HoIGMH3QvKYZE51N3Mls8J8QXr9ICEXaj
         jPHg==
X-Forwarded-Encrypted: i=1; AJvYcCULCIB4CYk+u7gSg5DL95tgrna4BeiEX194v/I6Lrxsj+gGj6j7XwR9Zp5L7obORyAXy4UeVDoQuuo=@vger.kernel.org, AJvYcCXuviOuLwb1FrgmY49rgApkU9wyCsPNwYa8fxPeA9tTzGB20ZP8QqimMdhlTsG6iT2A2/vxIO+R@vger.kernel.org
X-Gm-Message-State: AOJu0YxhucpbYFzt72jn7lF0L8yNrDCHb4ShUfuG6o/8DZa1qCb42Zhr
	GrX87o6a1XO3KIV3vXJsnhf6A6IprXKBwLTSDz6zFe7RrJocccshE/ORWBs4sg04CmrR6WBFsEM
	Qp8/av4jyggi9bkv/EltaHPebGog=
X-Google-Smtp-Source: AGHT+IFhQJCnptmvwLhKeIjfTGQ5k2d5GHSh4lMOwbeuYhq+xdA6qKUWY+D9NFMnMwaY2AJ7ZxR4X2PoXz5p/69Qclk=
X-Received: by 2002:aa7:c88d:0:b0:5ce:ade2:a26b with SMTP id
 4fb4d7f45d1cf-5ceade2a8afmr4303157a12.8.1730484187068; Fri, 01 Nov 2024
 11:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-6-ap420073@gmail.com>
 <CAHS8izNbS4i+ke0bK07-rNLuq6RGXD-H73DhVb1-tsUOzSCBog@mail.gmail.com>
In-Reply-To: <CAHS8izNbS4i+ke0bK07-rNLuq6RGXD-H73DhVb1-tsUOzSCBog@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 2 Nov 2024 03:02:54 +0900
Message-ID: <CAMArcTUGTF2Qr9=W_mcrA9au2jhm0Ru6hC+Nt3V2tk=LODQs+A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/8] net: devmem: add ring parameter filtering
To: Mina Almasry <almasrymina@google.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, donald.hunter@gmail.com, 
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

On Fri, Nov 1, 2024 at 11:29=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Hi Taehee, sorry for the late reply. I was out on vacation and needed
> to catch up on some stuff when I got back.

Hi Mina,
Thank you so much for your review :)

>
> On Tue, Oct 22, 2024 at 9:25=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > If driver doesn't support ring parameter or tcp-data-split configuratio=
n
> > is not sufficient, the devmem should not be set up.
> > Before setup the devmem, tcp-data-split should be ON and
> > header-data-split-thresh value should be 0.
> >
> > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v4:
> >  - Check condition before __netif_get_rx_queue().
> >  - Separate condition check.
> >  - Add Test tag from Stanislav.
> >
> > v3:
> >  - Patch added.
> >
> >  net/core/devmem.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 11b91c12ee11..3425e872e87a 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -8,6 +8,8 @@
> >   */
> >
> >  #include <linux/dma-buf.h>
> > +#include <linux/ethtool.h>
> > +#include <linux/ethtool_netlink.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/mm.h>
> >  #include <linux/netdevice.h>
> > @@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_devi=
ce *dev, u32 rxq_idx,
> >                                     struct net_devmem_dmabuf_binding *b=
inding,
> >                                     struct netlink_ext_ack *extack)
> >  {
> > +       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> > +       struct ethtool_ringparam ringparam =3D {};
> >         struct netdev_rx_queue *rxq;
> >         u32 xa_idx;
> >         int err;
> > @@ -140,6 +144,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_dev=
ice *dev, u32 rxq_idx,
> >                 return -ERANGE;
> >         }
> >
> > +       if (!dev->ethtool_ops->get_ringparam)
> > +               return -EOPNOTSUPP;
> > +
>
> Maybe an error code not EOPNOTSUPP. I think that gets returned when
> NET_DEVMEM is not compiled in and other situations like that. Lets
> pick another error code? Maybe ENODEV.

There are several same code in the ethtool core.
It returns EOPNOTSUPP consistently.
In the v3 series, Brett reviewed it.
So, I changed it from EINVAL to EOPNOTSUPP it was reasonable to me.
So I prefer EOPNOTSUPP but I will follow your decision.
What do you think?

>
> Also consider extack error message. But it's very unlikely to hit this
> error, so maybe not necessary.

I removed extack from the v3. because ethtool doesn't use extack for
the same logic. It was reasonable to me.

>
> > +       dev->ethtool_ops->get_ringparam(dev, &ringparam, &kernel_ringpa=
ram,
> > +                                       extack);
> > +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED) {
> > +               NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
> > +               return -EINVAL;
> > +       }
> > +       if (kernel_ringparam.hds_thresh) {
> > +               NL_SET_ERR_MSG(extack, "header-data-split-thresh is not=
 zero");
> > +               return -EINVAL;
> > +       }
> > +
>
> Thinking about drivers that support tcp-data-split, but don't support
> any kind of hds_thresh. For us (GVE), the hds_thresh is implicitly
> always 0.
>
> Does the driver need to explicitly set hds_thresh to 0? If so, that
> adds a bit of churn to driver code. Is it possible to detect in this
> function that the driver doesn't support hds_thresh and allow the
> binding if so?
>
> I see in the previous patch you do something like:
>
> supported_ring_params & ETHTOOL_RING_USE_HDS_THRS
>
> To detect there is hds_thresh support. I was wondering if something
> like this is possible so we don't have to update GVE and all future
> drivers to explicitly set thresh to 0.

How about setting maximum hds_threshold to 0?
The default value of hds_threshold of course 0.
I think gve code does not need to change much, just adding like below
will be okay.

I think if drivers don't support setting hds_threshold explicitly, it
is actually the same as support only 0.
So, there is no problem I think.

I didn't analyze gve driver code, So I might think it too optimistically.

#define GVE_HDS_THRESHOLD_MAX 0
kernel_ering->hds_thresh =3D GVE_HDS_THRESHOLD_MAX;
kernel_ering->hds_thresh_max =3D GVE_HDS_THRESHOLD_MAX;
...
.supported_ring_params  =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT |
ETHTOOL_RING_USE_HDS_THRS,

ethtool command may show like this.
ethtool -g enp7s0f3np3
Ring parameters for enp7s0f3np3:
Pre-set maximums:
...
Header data split thresh:       0
Current hardware settings:
...
TCP data split:         on
Header data split thresh:       0

If a driver can't set up hds_threshold, ethtool command may show like this.
ethtool -g enp7s0f3np3
Ring parameters for enp7s0f3np3:
Pre-set maximums:
TX push buff len:       n/a
Header data split thresh:       n/a
Current hardware settings:
...
TCP data split:         on
Header data split thresh:       n/a

Thanks a lot!
Taehee Yoo

>
> Other than that, looks fine to me.
>
>
> --
> Thanks,
> Mina

