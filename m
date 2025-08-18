Return-Path: <netdev+bounces-214720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB79B2B02C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D20565912
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11992D24B4;
	Mon, 18 Aug 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZMHZXlp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D52D24AB
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541472; cv=none; b=XOExy05rajV4Swh6AwV7OHP8I+s6031zKiK0JQDZJ/2jS3E3EAE09yjWpnUzyP3abG4tVDeBZ/6JjiLFG8TJYbmgh6uvegYjTk+ltkJNKsMoWLv41ioJqinUX8JuewSaOZidL/wcWojQnh0DkVkqDKuRQPndKhlm5YnC4So8Vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541472; c=relaxed/simple;
	bh=r3ziF6FIpOSnICwnBOocc54X14Txmjt3KuGTLFZl7Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0Vxh6hLhpoUM3cYY92wJA6EwsX0oAUK5fRI6dTICrxbTSvRCvflquXTHM7gsuxfxRl7rsYpROxfY/VBlLShljX5mpXqB0NJ6A294vtO5RVdU1mGTTXff5qNyvaMM7XfaMw6Lbe7rCPwtfHd5uCy7LgOI7PvMzuf954Qu4DAt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZMHZXlp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cc715d0easo1318e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541469; x=1756146269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Gk6e/YH5FgbMYAJ5Vg7RUZfD8zoa8dDrVdER5p5QR0=;
        b=lZMHZXlpdcHUsePCWWzZzr6egM8IswmVTURNWT/bEpUsU1shOuqbLaHUpgOqHACe9J
         p3voqVjFj3gJMEOL03mkOm+btKsAJ3T9lSO5ZemS2aLOvFmO7NhJVvLHZWmNFZr4LOp1
         xEPwcrs4o1HRu81OxgPMEs6aqGL9cCGROyvH+T4VhPS+zobH7ou/jplXZ1nxwfeQhVYI
         NhZA+stxCTpOjW+aN9btx5cuTreDXAudF5bSvIUunl2VMuiOwO7t+YS121jvnjZxkjgf
         TarS1uOYMcwrRzRYpBqz1E0F96UKQwnkvumwa1+kF5yGxJP6TiBvHQyjuqNkLxRfaRYe
         HAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541469; x=1756146269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Gk6e/YH5FgbMYAJ5Vg7RUZfD8zoa8dDrVdER5p5QR0=;
        b=HHRl7JTypSWwWZT2K9pC0WtPyLMKuPH4N0tQc2XBwLmDCZLEbo8Z2AmvGvw87hPmeM
         m49Wl9Vnub3IHACXAfJcd8ewX4Gtp9udOZNpKY1uNVcnxnqJHeRJuYykkmd9KpWmjT6z
         IlimqSsNTM7E75rK7xnrzypDkrvyKN4l1EkfTg10WMwYYB8bGtbfPWcUaxv9dTSFidz7
         NIc2ej1ifANsTTvNnoT0lVn5jvucvDHIlPLjrt7CDaMd6Y0sSMWASGFZJy81JH7AckMW
         /R3r7JWNFn9kna5ZIgIMGYYielBCRCM+2xp71k7SxAj/yUCkS6dwADGqTLSPBUAD56bu
         Q7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUfxfZgE3/y8Z06QO/oLlfWNBcCKDOmbTsafwYfTsMmGV4iyz3gHRA0puUFUZ3lknfh38P2kWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhcPS/huP3hopZkrb4FwgO/UA+jFzqsSPs0/5hlqiimihl4rXa
	B0RAtVBQN64JNMZTAIC/zqQqTcBaG2PChNwvZifgKkF2+j2uaVm7akOVBb77YxOU+Jg1meDXETD
	RW/Vn8Z+BE7SsuknouRA0M70z/Msj7K1qtK30WaTw
X-Gm-Gg: ASbGncspqiPuK3TfQxJP8bgJYxIl2uxsZwaRkN5drpGxSSrWw92xfcfEsFsMYqOsQyF
	M45IUQtu1BzncA2gv8YxGu0Q71P4DF5Amwph2et0x4JGaRMp2IZ28KKb4Y5yUYu8m+yCHsOwklZ
	DGKO/Uo8Gd7kn7UyjG6/G+dq4yDH6FmAymj+uEWvw+5TAtvDZEbevCHzmeEBeGqeqsnpaG39tGK
	t0MVfwpVQAGDQyXvseVil39CVDc3o9cHyKB3RXwiBsmF2me
X-Google-Smtp-Source: AGHT+IGAn4WnT8Lg5FsEQjh8Eec0AI1a1VEmxVb3umr5BGReigNnH+f589U2FdTwi+/AtO0vqKp9HuJBrX9X1gU2UUQ=
X-Received: by 2002:a05:6512:4406:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-55e001b1b0bmr15723e87.3.1755541468733; Mon, 18 Aug 2025
 11:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-8-dtatulea@nvidia.com>
 <CAHS8izM-2vdudZeRu51TNCRzVPQVBKmrj0YoK80nNgWvR-ft3g@mail.gmail.com> <nv2z4vvycay3eygcjfmxcqjgrftmmqm3nmesui4vjenexjbnvk@ll7km6oblghm>
In-Reply-To: <nv2z4vvycay3eygcjfmxcqjgrftmmqm3nmesui4vjenexjbnvk@ll7km6oblghm>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 11:24:16 -0700
X-Gm-Features: Ac12FXzSXHRpYaU6ywQMy4iDz4kSaLsPVJl0HDldMx4UTYWk5Icx9_nwhewKjtA
Message-ID: <CAHS8izOosrkGw_aaL4-Rf1ue8UOMvaWWYXc48OBjO4F2UQa3VQ@mail.gmail.com>
Subject: Re: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues
 during bind
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 1:59=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Fri, Aug 15, 2025 at 11:05:56AM -0700, Mina Almasry wrote:
> > On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > Instead of reading the requested rx queues after binding the buffer,
> > > read the rx queues in advance in a bitmap and iterate over them when
> > > needed.
> > >
> > > This is a preparation for fetching the DMA device for each queue.
> > >
> > > This patch has no functional changes.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  net/core/netdev-genl.c | 76 +++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 49 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index 3e2d6aa6e060..3e990f100bf0 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -869,17 +869,50 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff =
*skb,
> > >         return err;
> > >  }
> > >
> > > -int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > > +static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
> > > +                                    unsigned long *rxq_bitmap)
> > >  {
> > >         struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> > > +       struct nlattr *attr;
> > > +       int rem, err =3D 0;
> > > +       u32 rxq_idx;
> > > +
> > > +       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> > > +                              genlmsg_data(info->genlhdr),
> > > +                              genlmsg_len(info->genlhdr), rem) {
> > > +               err =3D nla_parse_nested(
> > > +                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1=
, attr,
> > > +                       netdev_queue_id_nl_policy, info->extack);
> > > +               if (err < 0)
> > > +                       return err;
> > > +
> > > +               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_=
A_QUEUE_ID) ||
> > > +                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_=
A_QUEUE_TYPE))
> > > +                       return -EINVAL;
> > > +
> > > +               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D NETDEV_=
QUEUE_TYPE_RX) {
> > > +                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUE=
UE_TYPE]);
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > > +               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> > > +
> > > +               bitmap_set(rxq_bitmap, rxq_idx, 1);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > > +{
> > >         struct net_devmem_dmabuf_binding *binding;
> > >         u32 ifindex, dmabuf_fd, rxq_idx;
> > >         struct netdev_nl_sock *priv;
> > >         struct net_device *netdev;
> > > +       unsigned long *rxq_bitmap;
> > >         struct device *dma_dev;
> > >         struct sk_buff *rsp;
> > > -       struct nlattr *attr;
> > > -       int rem, err =3D 0;
> > > +       int err =3D 0;
> > >         void *hdr;
> > >
> > >         if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> > > @@ -922,37 +955,22 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb,=
 struct genl_info *info)
> > >                 goto err_unlock;
> > >         }
> > >
> > > +       rxq_bitmap =3D bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL=
);
> > > +       if (!rxq_bitmap) {
> > > +               err =3D -ENOMEM;
> > > +               goto err_unlock;
> > > +       }
> > > +       netdev_nl_read_rxq_bitmap(info, rxq_bitmap);
> > > +
> > >         dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
> > >         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_=
DEVICE,
> > >                                          dmabuf_fd, priv, info->extac=
k);
> > >         if (IS_ERR(binding)) {
> > >                 err =3D PTR_ERR(binding);
> > > -               goto err_unlock;
> > > +               goto err_rxq_bitmap;
> > >         }
> > >
> > > -       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> > > -                              genlmsg_data(info->genlhdr),
> > > -                              genlmsg_len(info->genlhdr), rem) {
> > > -               err =3D nla_parse_nested(
> > > -                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1=
, attr,
> > > -                       netdev_queue_id_nl_policy, info->extack);
> > > -               if (err < 0)
> > > -                       goto err_unbind;
> > > -
> > > -               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_=
A_QUEUE_ID) ||
> > > -                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_=
A_QUEUE_TYPE)) {
> > > -                       err =3D -EINVAL;
> > > -                       goto err_unbind;
> > > -               }
> > > -
> > > -               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D NETDEV_=
QUEUE_TYPE_RX) {
> > > -                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUE=
UE_TYPE]);
> > > -                       err =3D -EINVAL;
> > > -                       goto err_unbind;
> > > -               }
> > > -
> > > -               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> > > -
> > > +       for_each_set_bit(rxq_idx, rxq_bitmap, netdev->num_rx_queues) =
{
> >
> > Is this code assuming that netdev->num_rx_queues (or
> > real_num_rx_queues) <=3D BITS_PER_ULONG? Aren't there devices out there
> > that support more than 64 hardware queues? If so, I guess you need a
> > different data structure than a bitmap (or maybe there is arbirary
> > sized bitmap library somewhere to use).
> >
> The bitmap API can handle any number of bits. Can it not?
>

Ah, yes, I missed this:

+       rxq_bitmap =3D bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL);


Which allocates netdev->num_rx_queues bits. I was confused by the fact
that rxq_bitmap is an unsigned long * and thought that was the # of
bits in the map.

This patch should be good just with conversion to netdev->real_num_rx_queue=
s.

--=20
Thanks,
Mina

