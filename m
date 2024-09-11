Return-Path: <netdev+bounces-127463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2B9757E9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9156728B37A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942341AE869;
	Wed, 11 Sep 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3+mFxcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117F1AC8B3;
	Wed, 11 Sep 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070626; cv=none; b=KtAE4fmucFRzIW7Ozd573tJSngOGdwI1p42PYVHSkCPzAbBuL/DwcyJHLonKTGl1hGbOzIz715SLsiNf1/eJmooTyu+sMG+bu9jSs8fuI7piErqTlzj4X36rCLOASQdvOwm5+k6wXUmms+jCLyZw3PQ2uudjLZmL2sNOrYhC82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070626; c=relaxed/simple;
	bh=6UJNWcYhZ0+Abc5v3gWuTGkOC/BBkRHnVdgHXiveTvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PomiHp/IN0muJpDNC/6yL2SYfm127XRecWXeWBGb1qZeguSIjUILEB62q2FwcRItxCxk8pO6iv9zP2N4jwmgbgE9S4Is9n45sNjGypQ95Rok2OBBukWHO3YZni7CkTz4GnLnPOesdyllSiH5nrCGz1KZTFiqyGSEeHvUrnATSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3+mFxcb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so7629289a12.1;
        Wed, 11 Sep 2024 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070623; x=1726675423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElpmT7FAh3dblRYoaSgM75lYxXLYXY/hphJl7+bVEIc=;
        b=i3+mFxcbLKQ48aTzuembeW3wIpBKZvESn2gMs6v59gPIc649HEZh5p+XLRLX0VRqyk
         O/yJoBaXJ8dZF5er/GfwmycuIo41sBica9DoVjtyLfE87GaAIqAGtN3Wder56Fj+HIxV
         29n+UcrzLgJ2VXmkAr3NnJhLJlxVXEHI38HAbH+yRGK5Ixo2FuduOO39sJAhEvRNnHK+
         QnutYvvdMeTNXa1YItqtmCTU4xiMU8qMd7+g9aMOys1CULLklWNyEUK77Io7xv2xRnSf
         9Y74V/M99GGXXi3gSgg4j2xi6Ap5rf+vCbkLWRvJxKl6Fj1l6C+Zr4RzgcaMgRcjr2Rt
         AxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070623; x=1726675423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElpmT7FAh3dblRYoaSgM75lYxXLYXY/hphJl7+bVEIc=;
        b=t6XnRVEJmXvcE/JIGkuI59shjheeXrN4fj06R6pTTtbi0/DKkfK7ObJkD2Fl0s6d+g
         DVYJfop2/cH9PIJ35p+CJ5cZhnvM2A6fXhwWhAmEk35/DIIVil9nuR8njhZoQcjy+IxN
         cDirm0O4nJjSgeZBKnRE00XjwPUEzNnPK99KTe11UnUGQhZ9XTPB82eZtHu38W+75uu8
         5VclHLCRE0HQzVr7V9RRt0n6qlxyGIkRI0grXlDKbNqPXH/zxq2YemrmM7HYQkIhV9U9
         ticaBXqVE8/HYbOi95FE4JKZyn/1ZeogZww7Lx/r1fBS8YR3+fJXZMYxUooJ8SnOKRjs
         MIvg==
X-Forwarded-Encrypted: i=1; AJvYcCWcxuw/6IeyRdIiaHEfmGQvFrL6hYa9OqqYDvMJH8K9UvWXFCWrdkNY1lXDahHnjR9bOB6GDHeG@vger.kernel.org, AJvYcCWob3vJF629c6nymjL8m9Od2d/XDntowjPFPNh/fcETHtQG4bdqPwXHJdtXlKagfHtKmDCdDnlQ4ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz133lIJuz9DMVvlcGjR7X5z5kbiGUQVE5C2iuEPQOT6dLeBIjm
	ZPBN9w2zsyy6JlctMnbp17V52gc8e0/lCkxP6S3xIsAD9k0twoGfOiO1mlOrbPNBeoU/KrKA8nM
	Mcq0rhYtDf6kkl3jqc6CJuhUKdtiudOD9
X-Google-Smtp-Source: AGHT+IHF1nMy1cqURZvWhIvgNoyynyIp1R7cYQpSvBQSVGY24NV7e1TqIRlIui0IdwI0RpXkqJKPvxgUzZSpTXvyGQ4=
X-Received: by 2002:a05:6402:2807:b0:5c2:4a98:7520 with SMTP id
 4fb4d7f45d1cf-5c3e974d66dmr11577003a12.31.1726070622545; Wed, 11 Sep 2024
 09:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911145555.318605-1-ap420073@gmail.com> <20240911145555.318605-4-ap420073@gmail.com>
 <1eec50e5-6a6d-4ad8-a3ad-b0bbb8e72724@amd.com>
In-Reply-To: <1eec50e5-6a6d-4ad8-a3ad-b0bbb8e72724@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 12 Sep 2024 01:03:31 +0900
Message-ID: <CAMArcTXh9+s_JUEh4AgLuYVnWSnqzr7zzQq3m+Hc2dc4Nd2jQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring tcp-data-split-thresh
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

On Thu, Sep 12, 2024 at 12:47=E2=80=AFAM Brett Creeley <bcreeley@amd.com> w=
rote:

Hi Brett,
Thanks a lot for your review!

>
>
>
> On 9/11/2024 7:55 AM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > The tcp-data-split-thresh option configures the threshold value of
> > the tcp-data-split.
> > If a received packet size is larger than this threshold value, a packet
> > will be split into header and payload.
> > The header indicates TCP header, but it depends on driver spec.
> > The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> > FW level, affecting TCP and UDP too.
> > So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> > it affects UDP and TCP packets.
> >
> > The tcp-data-split-thresh has a dependency, that is tcp-data-split
> > option. This threshold value can be get/set only when tcp-data-split
> > option is enabled.
> >
> > Example:
> >     # ethtool -G <interface name> tcp-data-split-thresh <value>
> >
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
> > The tcp-data-split is not enabled, the tcp-data-split-thresh will
> > not be used and can't be configured.
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
> > The default/min/max values are not defined in the ethtool so the driver=
s
> > should define themself.
> > The 0 value means that all TCP and UDP packets' header and payload
> > will be split.
> > Users should consider the overhead due to this feature.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v2:
> >   - Patch added.
> >
> >   Documentation/networking/ethtool-netlink.rst | 31 +++++++++++--------
> >   include/linux/ethtool.h                      |  2 ++
> >   include/uapi/linux/ethtool_netlink.h         |  1 +
> >   net/ethtool/netlink.h                        |  2 +-
> >   net/ethtool/rings.c                          | 32 +++++++++++++++++--=
-
> >   5 files changed, 51 insertions(+), 17 deletions(-)
> >
>
> <snip>
>
> > diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> > index b7865a14fdf8..0b68ea316815 100644
> > --- a/net/ethtool/rings.c
> > +++ b/net/ethtool/rings.c
> > @@ -61,7 +61,8 @@ static int rings_reply_size(const struct ethnl_req_in=
fo *req_base,
> >                 nla_total_size(sizeof(u8))  +    /* _RINGS_TX_PUSH */
> >                 nla_total_size(sizeof(u8))) +    /* _RINGS_RX_PUSH */
> >                 nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_=
LEN */
> > -              nla_total_size(sizeof(u32));     /* _RINGS_TX_PUSH_BUF_L=
EN_MAX */
> > +              nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_L=
EN_MAX */
> > +              nla_total_size(sizeof(u32));     /* _RINGS_TCP_DATA_SPLI=
T_THRESH */
> >   }
> >
> >   static int rings_fill_reply(struct sk_buff *skb,
> > @@ -108,7 +109,10 @@ static int rings_fill_reply(struct sk_buff *skb,
> >               (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
> >                            kr->tx_push_buf_max_len) ||
> >                nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
> > -                         kr->tx_push_buf_len))))
> > +                         kr->tx_push_buf_len))) ||
> > +           (kr->tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED &=
&
> > +            (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
> > +                        kr->tcp_data_split_thresh))))
> >                  return -EMSGSIZE;
> >
> >          return 0;
> > @@ -130,6 +134,7 @@ const struct nla_policy ethnl_rings_set_policy[] =
=3D {
> >          [ETHTOOL_A_RINGS_TX_PUSH]               =3D NLA_POLICY_MAX(NLA=
_U8, 1),
> >          [ETHTOOL_A_RINGS_RX_PUSH]               =3D NLA_POLICY_MAX(NLA=
_U8, 1),
> >          [ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]       =3D { .type =3D NLA_U3=
2 },
> > +       [ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] =3D { .type =3D NLA_U32=
 },
> >   };
> >
> >   static int
> > @@ -155,6 +160,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *re=
q_info,
> >                  return -EOPNOTSUPP;
> >          }
> >
> > +       if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
> > +           !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SP=
LIT)) {
> > +               NL_SET_ERR_MSG_ATTR(info->extack,
> > +                                   tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_T=
HRESH],
> > +                                   "setting TDS threshold is not suppo=
rted");
>
> Small nit.
>
> Here you use "TDS threshold", but based on the TCP data split extack
> message, it seems like it should be the following for consistency:
>
> "setting TCP data split threshold is not supported"
>
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >          if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
> >              !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE))=
 {
> >                  NL_SET_ERR_MSG_ATTR(info->extack,
> > @@ -196,9 +209,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, st=
ruct genl_info *info)
> >          struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> >          struct ethtool_ringparam ringparam =3D {};
> >          struct net_device *dev =3D req_info->dev;
> > +       bool mod =3D false, thresh_mod =3D false;
> >          struct nlattr **tb =3D info->attrs;
> >          const struct nlattr *err_attr;
> > -       bool mod =3D false;
> >          int ret;
> >
> >          dev->ethtool_ops->get_ringparam(dev, &ringparam,
> > @@ -222,9 +235,20 @@ ethnl_set_rings(struct ethnl_req_info *req_info, s=
truct genl_info *info)
> >                          tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
> >          ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
> >                           tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
> > -       if (!mod)
> > +       ethnl_update_u32(&kernel_ringparam.tcp_data_split_thresh,
> > +                        tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> > +                        &thresh_mod);
> > +       if (!mod && !thresh_mod)
> >                  return 0;
> >
> > +       if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPL=
IT_DISABLED &&
> > +           thresh_mod) {
> > +               NL_SET_ERR_MSG_ATTR(info->extack,
> > +                                   tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_T=
HRESH],
> > +                                   "tcp-data-split-thresh can not be u=
pdated while tcp-data-split is disabled");
> > +               return -EINVAL;
>
> I think using the userspace command line argument names makes sense for
> this extack message.

I agree, that using "TDS" is not good for users.
I will use "tcp-data-split-threshold" instead of "TDS threshold".

>
> Thanks,
>
> Brett
>
> > +       }
> > +
> >          /* ensure new ring parameters are within limits */
> >          if (ringparam.rx_pending > ringparam.rx_max_pending)
> >                  err_attr =3D tb[ETHTOOL_A_RINGS_RX];
> > --
> > 2.34.1
> >
> >

Thanks a lot!
Taehee Yoo

