Return-Path: <netdev+bounces-219749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D54B42DBE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FA8567E37
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C32DCBEC;
	Wed,  3 Sep 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FOlDAg0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150A2F6587
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943855; cv=none; b=lZ9/sUVbKKCI9qnTHCzeYUdjYM3rdn9KXSdYBRf1t7Yy9f7T+gT6vCu8XeHt3KwL0l8eRRbK42WKTpRQHwm/IjWQ6QWRW37fuc4ywN9WZ25Y0ynfB2uQb4FkRctV3deDrRwqzzbis/pG/hnU9h6SYwhwMW+190NUR/eXockOY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943855; c=relaxed/simple;
	bh=SUFI4fwiX0pBPTs7+ouWpfjlXTs2fFG0hyy+3BztGSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frZwy9lhOqvE3MbaaAvR/cdHe0kYMv4a0bYKHRS6Tfa/GvC3xkeQdDbZv8/lwwZhpHU4BNqFoII1MVJBf2PKaRl01n7ICutdrcgk3Lwm5w0/8mVgj9enmT0XRmXkmWm4+QqbLOJKEkjX5m3SZDetERf3/qInepv2cXUgq917bH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FOlDAg0m; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so407014e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756943852; x=1757548652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv09e4Lt/OLR/n/FcaiPwgpNIdknD6J+E8y3JnmMEsw=;
        b=FOlDAg0mMvNaWa5svhyW/LaL4AT92V53zu6nuO774DA67WaCIVMPo63As4JuLuixZF
         e2TThcAT1YyJtsZCMTqI4tgV7Tz5sWO6Kz6TbhgOuU4ierlL6tBfEjilf+KcnRbLgAfx
         TKvPTcm1+tZ6t2QAD0lB78/3wfXvyTMsHnatI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943852; x=1757548652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv09e4Lt/OLR/n/FcaiPwgpNIdknD6J+E8y3JnmMEsw=;
        b=ODHdLaMKctPvWnIJW0jEaCJcfyP6/LVFy9cZR1B8BXkShFYif+hn3pIqmr2wVFqlSx
         3AFhrgzgiuAonFTEdxsSzqCXmQHjna99Na4/+ECLkskeswTVe4sXAsyQqS7eDV0grLHT
         dUK3IXaEWJZxnWJS3oXAG3fkXaD5ZA3P/fN3CfEE2Yk8Y0BiYvmObOoS8atG3UzlBOtQ
         P+SEndBCmjJN/ka6XN6SPsaDPilx+RVX0el4WnWom6+gK9iP32BQAOBShitUXyyMS3DJ
         WxhIun8mPaRib7ZjLQJFauFljdt3/syQNTujw5uTnoQ694LV/ioLFctcPLWrspSXA9sT
         2pyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx4+OrIRaqdbaCY5AyMlhweEqo08SJbFeFLZxCh2qs1T9QyDnnqHHoKqKVut6SUGLRbrYB0ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwntUN2NOA5yk4IR11I9NVplUXYGidhcY3T4kvUTTwCzbw6oYdD
	y071KLXuU9OQ22yWXk9pvSy0xx8IApe2DsYWrP5NyQVtL6eaZYHOCRvDA0tT5CCFxc9rlw/n+Aw
	YnjBK2HJReHLm+LPYZLiJd41NAnAvsjTPOpfLopUCaA==
X-Gm-Gg: ASbGncuwUnwrIo5hK60MNosdJG9ED30LuHFeSYB/kTbypPE8bhUqk3TeNKgP/Jar8FS
	QoHDuGQoqDRsaDt0YbG6ZEgvqeIc0y2FXiK+kynWqq6hNMLTUEJDSQFYjoW7du82jgxq1Kgcsf1
	40mhNB6V3A0UuhyLnD0yFrtb6IQDKy6/LkFOsunzDV3KzLyWyj19I41nQrxdWeNPqKqSXxOUQN7
	YWG8/3hajJXBcfg9Wu7yhDGsAA+SHyljBAZcr7NNsFAtavseFbZ6kik1/DXApf1QQ==
X-Google-Smtp-Source: AGHT+IGbfS54Qvlf3EmjlTU6FR8DV3xID1CvDF3YSGWCmbcuFezhFih12dZx/PfGzkY4crFSlHcgYjsHQ9Nf3+VX3fI=
X-Received: by 2002:a05:6512:4381:b0:55f:4e8a:19a4 with SMTP id
 2adb3069b0e04-55f708b6079mr4267537e87.23.1756943852379; Wed, 03 Sep 2025
 16:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
 <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com>
In-Reply-To: <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 3 Sep 2025 16:57:21 -0700
X-Gm-Features: Ac12FXwt9zGovKtsi3q9pwxQj_g5H63amgYnMGWNl5-bfcInmOgb5rKBGXq_9aY
Message-ID: <CADg4-L_83eNn9huME6tuZKeQWyG2xkKCUj9erqzMBGxWt=NKcA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:39=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
>
>
> On 8/28/25 8:36 PM, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > include part of the payload.
> >
> > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > (and skb->head_frag is not set), we end up aggregating packets in the
> > frag_list.
> >
> > This is of course not good when we are CPU-limited. Also causes a worse
> > skb->len/truesize ratio,...
> >
> > So, let's avoid copying parts of the payload to the linear part. We use
> > eth_get_headlen() to parse the headers and compute the length of the
> > protocol headers, which will be used to copy the relevant bits ot the
> > skb's linear part.
> >
> > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networki=
ng
> > stack needs to call pskb_may_pull() later on, we don't need to realloca=
te
> > memory.
> >
> > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC an=
d
> > LRO enabled):
> >
> > BEFORE:
> > =3D=3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.01    32547.82
> >
> > (netserver pinned to adjacent core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    52531.67
> >
> > AFTER:
> > =3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    52896.06
> >
> > (netserver pinned to adjacent core receiving interrupts)
> >   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    85094.90
> >
> > Additional tests across a larger range of parameters w/ and w/o LRO, w/
> > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), differen=
t
> > TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> > better performance with this patch.
> >
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..792bb647ba28668ad7789c3=
28456e3609440455d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >               dma_sync_single_for_cpu(rq->pdev, addr + head_offset, hea=
dlen,
> >                                       rq->buff.map_dir);
> >
> > +             headlen =3D eth_get_headlen(skb->dev, head_addr, headlen)=
;
> > +
>
> Hi,
>
> I am building on top of this patchset and got a kernel crash. It was
> triggered by attaching an xdp program.
>
> I think the problem is skb->dev is still NULL here. It will be set later =
by:
> mlx5e_complete_rx_cqe() -> mlx5e_build_rx_skb() -> eth_type_trans()

Hmmm... Not sure what happened here...
I'm almost certain I tested with xdp as well...

I will try again later/tomorrow.

Thanks!
Christoph

>
>
> >               frag_offset +=3D headlen;
> >               byte_cnt -=3D headlen;
> >               linear_hr =3D skb_headroom(skb);
> > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >                               pagep->frags++;
> >                       while (++pagep < frag_page);
> >               }
> > +
> > +             headlen =3D eth_get_headlen(skb->dev, mxbuf->xdp.data, he=
adlen);
> > +
> >               __pskb_pull_tail(skb, headlen);
> >       } else {
> >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> >
>

