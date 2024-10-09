Return-Path: <netdev+bounces-133742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94128996DA8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199061F21D4B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54A19C55C;
	Wed,  9 Oct 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCsuQe4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1545948;
	Wed,  9 Oct 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483972; cv=none; b=VsxX95TAgsIrI01wtjPAFEvjMu7k+LxcTzUFFD24XXPPozcWrlkCN7LFJhAY51022Omtrzozjl002jlyf9rEYgxIMzTKuN7MKbVGEmjcRuBdGA0qBHgwJjM24hSEaxWrGHJU8aP4EL41yez0USYYqwvi2WEaDXTadFMSoKF7r1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483972; c=relaxed/simple;
	bh=Nh2vdkAii9d9F/EIG8QOWV2J5Alv52vKdmuaIFapp2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDXWRj0b3xyPvNM8deO1H06KGWMygEs7W3qtqrFCfRjh1bFV5LtIGVpKZGbf36DDjwpCleW3FsabCnu4tYsrtoCLnQmslcPADWmQ62VdvrCYtKJYdpigU6B2he6pyS7fRfZw6YuY+c1Aj6lBqY+PguQCUsfHExMIp+K7uWwu5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCsuQe4k; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso404660a91.3;
        Wed, 09 Oct 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728483970; x=1729088770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOB06Ug3h/KF5kA+MQO1vNSf26yPJaws72ej/LwI+Qg=;
        b=JCsuQe4k4c/ntSU1Ddojm/eaqtOWjgcFX1ZcMD5FHOF4w3vxYczdCJ4RNG8l09dSNI
         mKOTNXf6y/r3EgzPVCL5JVWjRfXdHixrYSSi8ZohpE9l163ReFjy/yxeTkCL/LQFJ9XA
         QTbj3/i+acFnPXDwQRuE3r+6G+0LTx3MLcerZ7ygLkL7MR5NV/yQzxl7zXOpOAYXEEY5
         VeqxJpFUnFk5bDIfcN5mvlT8vRuWlsiVSbkM5B6M5wD8V7HAQXRPdToEVbmsJc3nejjj
         9e4zJv3JeqwrY5O9jgj8XHzZCbmOcebE0PfzeTVXTha8+C5mza7WEmoShr3ygY6hJ3Tm
         iQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728483970; x=1729088770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOB06Ug3h/KF5kA+MQO1vNSf26yPJaws72ej/LwI+Qg=;
        b=j/qXRVp4Wpd9WSBMHSWDK+FAH+CzFzagZCL0sbdCg4ByiVVWvl/+QETKeRoN2IYE0M
         rClEc20NpKBOzMMy83Y4ls1xcBiDHBCwYz2OmgASdAgyawf2U+irlxaOnQwhmXRGVNND
         GuSHRoLrizXnKAH2AD84/o0D6dx3GeqRpAmVOIR6ZUptl9TiiMWwQyBCgsXYspPzfQ02
         JodxymvcZ3oSlpmd729YT45nsti3kJxVYHC6budxUWNU7VhuWqYl95Yhk6RaoWKwM6WP
         kDvaWA6T+Hhx03lNTqat0rFVNlx/7G5wD5sBlWIWCNMoarnaaW8cr7brjnxfakYhd4h1
         nuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDDBBWfM3inKf6HhveWXM44BBpqL0JCqj6u8XB4lJ+rEbLmcNbv5DgIfgVav1eoDY0Wy/gi/nC@vger.kernel.org, AJvYcCV1lPoN1Nq6Ybq5N8lF7v6TgEBvlozn1IXPWwm3M4wE6b1whY7YHrPLKtX0zTkXEwUgpJ/y01dCHAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNtkIpSB6ovpepd8W13b4jCD0FF96o57K1bIe0S85qxH73XHs
	AOAOBltPymfaYdyTJJJXdlVH9eleluIVnJ7gux0BfQ5rFV56cmSEdgIcVNsOhQYtCmp3RiJTny5
	01Nux+kQgzca53nxwcQnRi/Omgqo=
X-Google-Smtp-Source: AGHT+IGq1shxJ05d44RR8/D5IqiFd7aIjNGegKhr0T28JAEWbNO9HKqc2zRDnExdtv9TR7gskTFwASmnCitIBynxf7U=
X-Received: by 2002:a17:90b:430f:b0:2e2:bd9a:4ff4 with SMTP id
 98e67ed59e1d1-2e2bd9a5225mr1075485a91.24.1728483969625; Wed, 09 Oct 2024
 07:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-4-ap420073@gmail.com>
 <20241008113314.243f7c36@kernel.org>
In-Reply-To: <20241008113314.243f7c36@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 9 Oct 2024 23:25:55 +0900
Message-ID: <CAMArcTXvMi_QWsYFgt8TJcQQz6=edoGs3-5th=4mKaHO_X+hhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for configuring tcp-data-split-thresh
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  3 Oct 2024 16:06:16 +0000 Taehee Yoo wrote:
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
> >    # ethtool -G <interface name> tcp-data-split-thresh <value>
> >
> >    # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 25=
6
> >    # ethtool -g enp14s0f0np0
> >    Ring parameters for enp14s0f0np0:
> >    Pre-set maximums:
> >    ...
> >    TCP data split thresh:  256
> >    Current hardware settings:
> >    ...
> >    TCP data split:         on
> >    TCP data split thresh:  256
> >
> > The tcp-data-split is not enabled, the tcp-data-split-thresh will
> > not be used and can't be configured.
> >
> >    # ethtool -G enp14s0f0np0 tcp-data-split off
> >    # ethtool -g enp14s0f0np0
> >    Ring parameters for enp14s0f0np0:
> >    Pre-set maximums:
> >    ...
> >    TCP data split thresh:  256
> >    Current hardware settings:
> >    ...
> >    TCP data split:         off
> >    TCP data split thresh:  n/a
>
> My reply to Sridhar was probably quite unclear on this point, but FWIW
> I do also have a weak preference to drop the "TCP" from the new knob.
> Rephrasing what I said here:
> https://lore.kernel.org/all/20240911173150.571bf93b@kernel.org/
> the old knob is defined as being about TCP but for the new one we can
> pick how widely applicable it is (and make it cover UDP as well).

I'm not sure that I understand about "knob".
The knob means the command "tcp-data-split-thresh"?
If so, I would like to change from "tcp-data-split-thresh" to
"header-data-split-thresh".

>
> > The default/min/max values are not defined in the ethtool so the driver=
s
> > should define themself.
> > The 0 value means that all TCP and UDP packets' header and payload
> > will be split.
>
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index 12f6dc567598..891f55b0f6aa 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -78,6 +78,8 @@ enum {
> >   * @cqe_size: Size of TX/RX completion queue event
> >   * @tx_push_buf_len: Size of TX push buffer
> >   * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
> > + * @tcp_data_split_thresh: Threshold value of tcp-data-split
> > + * @tcp_data_split_thresh_max: Maximum allowed threshold of tcp-data-s=
plit-threshold
>
> Please wrap at 80 chars:
>
> ./scripts/checkpatch.pl --max-line-length=3D80 --strict $patch..

Thanks, I will fix this in v4 patch.

>
> >  static int rings_fill_reply(struct sk_buff *skb,
> > @@ -108,7 +110,13 @@ static int rings_fill_reply(struct sk_buff *skb,
> >            (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
> >                         kr->tx_push_buf_max_len) ||
> >             nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
> > -                       kr->tx_push_buf_len))))
> > +                       kr->tx_push_buf_len))) ||
> > +         (kr->tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
>
> Please add a new ETHTOOL_RING_USE_* flag for this, or fix all the
> drivers which set ETHTOOL_RING_USE_TCP_DATA_SPLIT already and use that.
> I don't think we should hide the value when HDS is disabled.
>
> > +          (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
> > +                      kr->tcp_data_split_thresh))) ||
>
> nit: unnecessary brackets around the nla_put_u32()

I will fix this too.

>
> > +         (kr->tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> > +          (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX,
> > +                      kr->tcp_data_split_thresh_max))))
> >               return -EMSGSIZE;
> >
> >       return 0;
>
> > +     if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
> > +         !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLI=
T)) {
>
> here you use the existing flag, yet gve and idpf set that flag and will
> ignore the setting silently. They need to be changed or we need a new
> flag.

Okay, I would like to add the ETHTOOL_RING_USE_TCP_DATA_SPLIT_THRESH flag.
Or ETHTOOL_RING_USE_HDS_THRESH, which indicates header-data-split thresh.
If you agree with adding a new flag, how do you think about naming it?

>
> > +             NL_SET_ERR_MSG_ATTR(info->extack,
> > +                                 tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THR=
ESH],
> > +                                 "setting tcp-data-split-thresh is not=
 supported");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
> >           !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
> >               NL_SET_ERR_MSG_ATTR(info->extack,
> > @@ -196,9 +213,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, st=
ruct genl_info *info)
> >       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> >       struct ethtool_ringparam ringparam =3D {};
> >       struct net_device *dev =3D req_info->dev;
> > +     bool mod =3D false, thresh_mod =3D false;
> >       struct nlattr **tb =3D info->attrs;
> >       const struct nlattr *err_attr;
> > -     bool mod =3D false;
> >       int ret;
> >
> >       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> > @@ -222,9 +239,30 @@ ethnl_set_rings(struct ethnl_req_info *req_info, s=
truct genl_info *info)
> >                       tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
> >       ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
> >                        tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
> > -     if (!mod)
> > +     ethnl_update_u32(&kernel_ringparam.tcp_data_split_thresh,
> > +                      tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
> > +                      &thresh_mod);
> > +     if (!mod && !thresh_mod)
> >               return 0;
> >
> > +     if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT=
_DISABLED &&
> > +         thresh_mod) {
> > +             NL_SET_ERR_MSG_ATTR(info->extack,
> > +                                 tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THR=
ESH],
> > +                                 "tcp-data-split-thresh can not be upd=
ated while tcp-data-split is disabled");
> > +             return -EINVAL;
> > +     }
>
> I'm not sure we need to reject changing the setting when HDS is
> disabled. Driver can just store the value until HDS gets enabled?
> WDYT? I don't have a strong preference.

I checked similar options, which are tx-push and tx-push-buff-len,
updating tx-push-buff-len may not fail when tx-push is disabled.

I think It's too strong condition check and it's not consistent with
similar options.

The disabling HDS option is going to be removed in v4 patch.
I asked about how to handle hds_threshold when it is UNKNOWN mode in the
previous patch thread. If the hds_threshold should follow rx-copybreak
value in the UNKNOWN mode, this condition check is not necessary.

>
> > +     if (kernel_ringparam.tcp_data_split_thresh >
> > +         kernel_ringparam.tcp_data_split_thresh_max) {
> > +             NL_SET_ERR_MSG_ATTR_FMT(info->extack,
> > +                                     tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT=
_THRESH_MAX],
> > +                                     "Requested tcp-data-split-thresh =
exceeds the maximum of %u",
>
> No need for the string, just NL_SET_BAD_ATTR() + ERANGE is enough

Thanks, I will fix it.

>
> > +                                     kernel_ringparam.tcp_data_split_t=
hresh_max);
> > +
> > +             return -EINVAL;
>
> ERANGE

I will fix it too.

>
> > +     }
> > +
> >       /* ensure new ring parameters are within limits */
> >       if (ringparam.rx_pending > ringparam.rx_max_pending)
> >               err_attr =3D tb[ETHTOOL_A_RINGS_RX];
>

