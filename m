Return-Path: <netdev+bounces-95247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAFB8C1BA6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4130B2855C9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C4125B9;
	Fri, 10 May 2024 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hj1zd51h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE24CA6B
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300308; cv=none; b=XnAW19q/JrJvkboEYY7Xo0oJ3MeADd7AudeeyXhlfIRKkApjurXWw3hXbh81Vv04yvrXbwBTwZwjFyrydWE6HLP1FvVoL2qLal8dpL/Mzesdij/v90fhSRXMUQ+nnjwEUhU6PAG3f8E1TIClD4/mS5AtImiXXX/yBrMVTKvj/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300308; c=relaxed/simple;
	bh=uBI6muGg2LUHewxBbL3Q804DYTwy8KcBitG3ZqgBURE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBUKbEILfiUbcu9LrUY28cdLBdZKOdZPMzHbUrcyECDAAF/xPRoVvD41Wqe91IGgUo7HK7AJJj/IVuqp1a/6b6eBNdv3/zAFgKnzw+80kxf8AXKA7YwkjflcCGdKzk80B1PJtXqTPd2mIHxkajoNSqrECdG4xAtube4XDTcjKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hj1zd51h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so962281f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300305; x=1715905105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNxvqWloC5NwFVPsMXWaj67YNJ/lJ6Hhh2MkAXokG+o=;
        b=Hj1zd51hV1iJBrgdIUL5+AjXKWnS6N71He/x93DF2Sk51vlsdkvrhqm5uDljYAnYxl
         wfns49tYVeHnkbuiufwmqtf+89fV5An0NGcqUEk2Dla556P/IrT07Vo3RyQflVWMAZNw
         6QPdLZFsb7AKkXAK+10zhjQM3RliXXjQbzEQkJjqmjZEqc3gTFvO5MtovLu7kioQ2mMv
         YuzEowVhqTTQuLgWycGYPhtSE8PX1721zLZOqZVr2DmnwYdHvMiAGORbRcqrewqGdmCj
         7K6UPiLXUeoO+jqZ6UxFjvBEGe0xYx20XMmf+s697rJg46TQnA2tBRhPa+WMC2rsPRMB
         pvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300305; x=1715905105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNxvqWloC5NwFVPsMXWaj67YNJ/lJ6Hhh2MkAXokG+o=;
        b=RNxy/EFOUqsQMubpEtopLr6nmg1rmwOXuErCEsOkpJcrlMzrcouQccl43ZdHUvtvmH
         xzCXKfncylDbQ5ICr3PECyY+Sf4XBrZj6wm7YNmYndvm2zw4etNAoyiQC56WC0kd2OL0
         bZLUPnA/kF9mXrGorS1dfln5a9Ek+axn6HfCvvNc/I2ySre5J0v9YDvI/lQo06NC4aQL
         wEkF/fq5k7BYfYVqDRRZRZbnXPD0i+nA2bZF+ugb/5PEhB9cInFqrwgdm8Umwas8C/6m
         jmj+dP1tyJWdpMlrxsV9As/htipw4Z1LKWjkSESHWynLhwPLOBLF3Dq3ZIQEAkmjsHmy
         WmuQ==
X-Gm-Message-State: AOJu0Yzlbpsj89XDfm85GohNNPguIfF1vRSGIACR1H7jkOKj2AN/pEwV
	eKG6MOfvFwBtUr/Bj+D2CnFaaX3ChEhICQgEGB5+MeDLJQnVpkfajerHMMphX3/utn9aEP0lWkk
	qaUnL2Al3NJh5QOrLI0oz2hAvUC32IvujQu66
X-Google-Smtp-Source: AGHT+IGEdZ2ExF/g4PkMyb+bHCJZqXWQ0s54ii0EmiA9WXhQJOSQ6c4f7IfWEF0EN2cW90UR5vP1IDzmB2e9/2eMuE4=
X-Received: by 2002:adf:e586:0:b0:34f:3293:85c6 with SMTP id
 ffacd0b85a97d-3504a96b7c9mr1100172f8f.64.1715300304486; Thu, 09 May 2024
 17:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-4-ziweixiao@google.com> <6a98fda2-54f4-4c1d-9b4a-bd39abe27179@davidwei.uk>
In-Reply-To: <6a98fda2-54f4-4c1d-9b4a-bd39abe27179@davidwei.uk>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 9 May 2024 17:18:13 -0700
Message-ID: <CAG-FcCM5-c3vCRWenUoxdswfKAfaVNkBEpzkvKRhy6UfSzbu0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] gve: Add flow steering device option
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	hramamurthy@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:33=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-07 15:59, Ziwei Xiao wrote:
> > From: Jeroen de Borst <jeroendb@google.com>
> >
> > Add a new device option to signal to the driver that the device support=
s
> > flow steering. This device option also carries the maximum number of
> > flow steering rules that the device can store.
> >
> > Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> > Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h        |  2 +
> >  drivers/net/ethernet/google/gve/gve_adminq.c | 42 ++++++++++++++++++--
> >  drivers/net/ethernet/google/gve/gve_adminq.h | 11 +++++
> >  3 files changed, 51 insertions(+), 4 deletions(-)
>
> Think something went wrong here. The title is different but patch is
> same as 2/5.
This is the patch for adding the device option(3/5), while the
previous patch you commented is actually for adding extended
adminq(2/5). I don't see any wrong with these two patches. Maybe it's
replying in the wrong thread?

>
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index ca7fce17f2c0..58213c15e084 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -786,6 +786,8 @@ struct gve_priv {
> >
> >       u16 header_buf_size; /* device configured, header-split supported=
 if non-zero */
> >       bool header_split_enabled; /* True if the header split is enabled=
 by the user */
> > +
> > +     u32 max_flow_rules;
> >  };
> >
> >  enum gve_service_task_flags_bit {
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 514641b3ccc7..85d0d742ad21 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -44,6 +44,7 @@ void gve_parse_device_option(struct gve_priv *priv,
> >                            struct gve_device_option_jumbo_frames **dev_=
op_jumbo_frames,
> >                            struct gve_device_option_dqo_qpl **dev_op_dq=
o_qpl,
> >                            struct gve_device_option_buffer_sizes **dev_=
op_buffer_sizes,
> > +                          struct gve_device_option_flow_steering **dev=
_op_flow_steering,
> >                            struct gve_device_option_modify_ring **dev_o=
p_modify_ring)
> >  {
> >       u32 req_feat_mask =3D be32_to_cpu(option->required_features_mask)=
;
> > @@ -189,6 +190,23 @@ void gve_parse_device_option(struct gve_priv *priv=
,
> >               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> >                       priv->default_min_ring_size =3D true;
> >               break;
> > +     case GVE_DEV_OPT_ID_FLOW_STEERING:
> > +             if (option_length < sizeof(**dev_op_flow_steering) ||
> > +                 req_feat_mask !=3D GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STE=
ERING) {
> > +                     dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERRO=
R_FMT,
> > +                              "Flow Steering",
> > +                              (int)sizeof(**dev_op_flow_steering),
> > +                              GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING,
> > +                              option_length, req_feat_mask);
> > +                     break;
> > +             }
> > +
> > +             if (option_length > sizeof(**dev_op_flow_steering))
> > +                     dev_warn(&priv->pdev->dev,
> > +                              GVE_DEVICE_OPTION_TOO_BIG_FMT,
> > +                              "Flow Steering");
> > +             *dev_op_flow_steering =3D (void *)(option + 1);
> > +             break;
> >       default:
> >               /* If we don't recognize the option just continue
> >                * without doing anything.
> > @@ -208,6 +226,7 @@ gve_process_device_options(struct gve_priv *priv,
> >                          struct gve_device_option_jumbo_frames **dev_op=
_jumbo_frames,
> >                          struct gve_device_option_dqo_qpl **dev_op_dqo_=
qpl,
> >                          struct gve_device_option_buffer_sizes **dev_op=
_buffer_sizes,
> > +                        struct gve_device_option_flow_steering **dev_o=
p_flow_steering,
> >                          struct gve_device_option_modify_ring **dev_op_=
modify_ring)
> >  {
> >       const int num_options =3D be16_to_cpu(descriptor->num_device_opti=
ons);
> > @@ -230,7 +249,7 @@ gve_process_device_options(struct gve_priv *priv,
> >                                       dev_op_gqi_rda, dev_op_gqi_qpl,
> >                                       dev_op_dqo_rda, dev_op_jumbo_fram=
es,
> >                                       dev_op_dqo_qpl, dev_op_buffer_siz=
es,
> > -                                     dev_op_modify_ring);
> > +                                     dev_op_flow_steering, dev_op_modi=
fy_ring);
> >               dev_opt =3D next_opt;
> >       }
> >
> > @@ -838,6 +857,8 @@ static void gve_enable_supported_features(struct gv=
e_priv *priv,
> >                                         *dev_op_dqo_qpl,
> >                                         const struct gve_device_option_=
buffer_sizes
> >                                         *dev_op_buffer_sizes,
> > +                                       const struct gve_device_option_=
flow_steering
> > +                                       *dev_op_flow_steering,
> >                                         const struct gve_device_option_=
modify_ring
> >                                         *dev_op_modify_ring)
> >  {
> > @@ -890,10 +911,22 @@ static void gve_enable_supported_features(struct =
gve_priv *priv,
> >                       priv->min_tx_desc_cnt =3D be16_to_cpu(dev_op_modi=
fy_ring->min_tx_ring_size);
> >               }
> >       }
> > +
> > +     if (dev_op_flow_steering &&
> > +         (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
> > +             if (dev_op_flow_steering->max_flow_rules) {
> > +                     priv->max_flow_rules =3D
> > +                             be32_to_cpu(dev_op_flow_steering->max_flo=
w_rules);
> > +                     dev_info(&priv->pdev->dev,
> > +                              "FLOW STEERING device option enabled wit=
h max rule limit of %u.\n",
> > +                              priv->max_flow_rules);
> > +             }
> > +     }
> >  }
> >
> >  int gve_adminq_describe_device(struct gve_priv *priv)
> >  {
> > +     struct gve_device_option_flow_steering *dev_op_flow_steering =3D =
NULL;
> >       struct gve_device_option_buffer_sizes *dev_op_buffer_sizes =3D NU=
LL;
> >       struct gve_device_option_jumbo_frames *dev_op_jumbo_frames =3D NU=
LL;
> >       struct gve_device_option_modify_ring *dev_op_modify_ring =3D NULL=
;
> > @@ -930,6 +963,7 @@ int gve_adminq_describe_device(struct gve_priv *pri=
v)
> >                                        &dev_op_gqi_qpl, &dev_op_dqo_rda=
,
> >                                        &dev_op_jumbo_frames, &dev_op_dq=
o_qpl,
> >                                        &dev_op_buffer_sizes,
> > +                                      &dev_op_flow_steering,
> >                                        &dev_op_modify_ring);
> >       if (err)
> >               goto free_device_descriptor;
> > @@ -969,9 +1003,8 @@ int gve_adminq_describe_device(struct gve_priv *pr=
iv)
> >       /* set default descriptor counts */
> >       gve_set_default_desc_cnt(priv, descriptor);
> >
> > -     /* DQO supports LRO. */
> >       if (!gve_is_gqi(priv))
> > -             priv->dev->hw_features |=3D NETIF_F_LRO;
> > +             priv->dev->hw_features |=3D NETIF_F_LRO | NETIF_F_NTUPLE;
> >
> >       priv->max_registered_pages =3D
> >                               be64_to_cpu(descriptor->max_registered_pa=
ges);
> > @@ -991,7 +1024,8 @@ int gve_adminq_describe_device(struct gve_priv *pr=
iv)
> >
> >       gve_enable_supported_features(priv, supported_features_mask,
> >                                     dev_op_jumbo_frames, dev_op_dqo_qpl=
,
> > -                                   dev_op_buffer_sizes, dev_op_modify_=
ring);
> > +                                   dev_op_buffer_sizes, dev_op_flow_st=
eering,
> > +                                   dev_op_modify_ring);
> >
> >  free_device_descriptor:
> >       dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net=
/ethernet/google/gve/gve_adminq.h
> > index e0370ace8397..e64a0e72e781 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> > @@ -146,6 +146,14 @@ struct gve_device_option_modify_ring {
> >
> >  static_assert(sizeof(struct gve_device_option_modify_ring) =3D=3D 12);
> >
> > +struct gve_device_option_flow_steering {
> > +     __be32 supported_features_mask;
> > +     __be32 reserved;
> > +     __be32 max_flow_rules;
> > +};
> > +
> > +static_assert(sizeof(struct gve_device_option_flow_steering) =3D=3D 12=
);
> > +
> >  /* Terminology:
> >   *
> >   * RDA - Raw DMA Addressing - Buffers associated with SKBs are directl=
y DMA
> > @@ -163,6 +171,7 @@ enum gve_dev_opt_id {
> >       GVE_DEV_OPT_ID_DQO_QPL                  =3D 0x7,
> >       GVE_DEV_OPT_ID_JUMBO_FRAMES             =3D 0x8,
> >       GVE_DEV_OPT_ID_BUFFER_SIZES             =3D 0xa,
> > +     GVE_DEV_OPT_ID_FLOW_STEERING            =3D 0xb,
> >  };
> >
> >  enum gve_dev_opt_req_feat_mask {
> > @@ -174,12 +183,14 @@ enum gve_dev_opt_req_feat_mask {
> >       GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL               =3D 0x0,
> >       GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES          =3D 0x0,
> >       GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING           =3D 0x0,
> > +     GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING         =3D 0x0,
> >  };
> >
> >  enum gve_sup_feature_mask {
> >       GVE_SUP_MODIFY_RING_MASK        =3D 1 << 0,
> >       GVE_SUP_JUMBO_FRAMES_MASK       =3D 1 << 2,
> >       GVE_SUP_BUFFER_SIZES_MASK       =3D 1 << 4,
> > +     GVE_SUP_FLOW_STEERING_MASK      =3D 1 << 5,
> >  };
> >
> >  #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0

