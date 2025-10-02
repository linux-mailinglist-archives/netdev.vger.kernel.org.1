Return-Path: <netdev+bounces-227644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B038CBB48CB
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63744168E9B
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B0261B9C;
	Thu,  2 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX+tRdOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93C1E3DCF
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422835; cv=none; b=MUb/MaPvvXuinq5J8f0WhCKdUHSwU4wZbwVeMeh8qffH/qDn54ScBb+Zodrit/g7DNcK/MqUTBgYZqTExEutZHiUO7s8RGcOAmpjvjVMXvpeIKiKj3Ga6mhWz/IO6LmsriWjWQtyBu4hZ83lxDg2bPTHYv7ZixLrvDGlWG7FovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422835; c=relaxed/simple;
	bh=zUsGNXp4QJMzq1MLf4iEvgk5tgIN3duC9LmqJCNfesQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+D8py0m+mxaZrvQ05tuFnHKM2hoDVx7qksBtsPtcsvdkmLBrqWqmyFuL7xamTdEHceTYxRdDpV0JsMXDjWPhWuEC3BzDsC3AveVAYstpfrlmBhixEvPW0ASDYe9Yeqs+upZ29nrjKeCVkn8wPAhpL9PsJvlM7/5efh/pJh/l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX+tRdOo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1255712a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422833; x=1760027633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jof7laRiTqrKkCMc9l/uQGXsUkRpLxL+KnAjdmADKPo=;
        b=WX+tRdOolcsV550ywqixeOk/57imETEazI/pdRB1IbLb1covyNDwTddzB2VshhsNFD
         wLA8VAIc+hxo+LreJPfURF+XxcF/4fnna6srjsRE2UCxik5ubPbrG2zGQUQk4+qZECcA
         Hkg/jmHIgPYEhwATZjnyhiGpY2r4ZILO4SbSDhjv1Walm9kO4sEn4p2LYqyOMT5wDSqo
         m4AJIEXuuAi0JpaoMdUBj5cEpkBkB2NFRLIqRLHEqVI3uPfXyDTr/vRlXpCEZGd8DvJL
         mFaSw1mA6EV1+Jcy/d7DkTkO8IJUUS1OiCwR2DhN774DvYC9b2S/cp9ywbwTISJHTSa8
         bmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422833; x=1760027633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jof7laRiTqrKkCMc9l/uQGXsUkRpLxL+KnAjdmADKPo=;
        b=s6Zjm/Ds9HyTBvW+5UffKkl1VAN7EHgcYXaCDRswjUQwB4gyly2K7h1+m0JqmMSvP3
         xBAzxtZOYzBHiYcvdzSGY/mcq5KF+JiptdIaRRDUke/CR4P8U9e/H6Fj+hhZ0ZZkentf
         MQuHmiXam62xSdqkFf7QnPBCAYcICA5JL4BMgI9iHip0jiVj+0GFgHZ6Jc8BKTZ3/xam
         bh3PSyfd+UYDhwBwUIlDMT9v6j7przrsh9RwXCxTALdLVsbZ7oQWQ/NYTxsobyTrc614
         pMW1mawrkMMk25qUY6Q5ja039BoUrw95erNYskjQub8JfipgPVpwSInNNqzn57zSoqz7
         mZtg==
X-Forwarded-Encrypted: i=1; AJvYcCX6fA0Y5pzYjC6WZAXTxsqMgI2byBSYnrllQ6wY9LwB4af4fAcWFyN49MW0yPi+uI9K4kKkdvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyggnreYTzFSqMOxlnwFtlJMSwg+f/DcO24UDihSrOjGNIq7f54
	TNmMJ+qPe9JfEShxJ2Nwn1WjnFSnpsk9mtEE6n/A3LWOXfXAReuAwRD2buDqx2ynYg3tV79PP8I
	2jh6ZRitWEfI3OL9EeELk9VgI1B9oIU0=
X-Gm-Gg: ASbGncullEJLSNJ6EAePrttWFJNv9R7YLyohf+cTRISPXrmZyBrS+9mx1bWDOdwlqzi
	7pI6xwbGOsBzxrll+MSQd6sb8liYQdP4eY9lfctnFEnJoO6zyVoMzm/g9oV760qlyE41i8ik3B6
	HwMZAoOllz2nkqejntu3GNSFzSvek0ncGR/jgPt5VioY3LxhFLEzaNexSZz63uKG3mnStf6T0OI
	xNs+DxaOCLTeaMAxYxUH6NNXrCBxKY=
X-Google-Smtp-Source: AGHT+IERdKml9VYdmwJMWlyh1h6bg1EtMlosf0TdXjw/KcUOIXsRzGSEXkiHfvDN1G2Aq4dfWj2nPc3NDHo7Cex+kKE=
X-Received: by 2002:a17:90a:e7d0:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-339a6f5b61amr9601685a91.26.1759422833496; Thu, 02 Oct 2025
 09:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-8-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-8-dtatulea@nvidia.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:38:50 -0400
X-Gm-Features: AS18NWAZmI1ZNkM_0sg1UW1Qgy80TTExwOLB3IyIYO5zs9gB-CLNFF0SCAa73sM
Message-ID: <CALC8CXeXUGGujKjZbzCTXa5iyrk5XGWaCXTvtQODu+HCEDOYmw@mail.gmail.com>
Subject: Re: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues
 during bind
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mina sounds like a girls name. Do you DOMINATE her?

On Fri, Aug 15, 2025 at 7:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Instead of reading the requested rx queues after binding the buffer,
> read the rx queues in advance in a bitmap and iterate over them when
> needed.
>
> This is a preparation for fetching the DMA device for each queue.
>
> This patch has no functional changes.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  net/core/netdev-genl.c | 76 +++++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 27 deletions(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 3e2d6aa6e060..3e990f100bf0 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -869,17 +869,50 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb=
,
>         return err;
>  }
>
> -int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> +static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
> +                                    unsigned long *rxq_bitmap)
>  {
>         struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> +       struct nlattr *attr;
> +       int rem, err =3D 0;
> +       u32 rxq_idx;
> +
> +       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> +                              genlmsg_data(info->genlhdr),
> +                              genlmsg_len(info->genlhdr), rem) {
> +               err =3D nla_parse_nested(
> +                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, at=
tr,
> +                       netdev_queue_id_nl_policy, info->extack);
> +               if (err < 0)
> +                       return err;
> +
> +               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_ID) ||
> +                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_TYPE))
> +                       return -EINVAL;
> +
> +               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D NETDEV_QUEU=
E_TYPE_RX) {
> +                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_T=
YPE]);
> +                       return -EINVAL;
> +               }
> +
> +               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> +
> +               bitmap_set(rxq_bitmap, rxq_idx, 1);
> +       }
> +
> +       return 0;
> +}
> +
> +int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> +{
>         struct net_devmem_dmabuf_binding *binding;
>         u32 ifindex, dmabuf_fd, rxq_idx;
>         struct netdev_nl_sock *priv;
>         struct net_device *netdev;
> +       unsigned long *rxq_bitmap;
>         struct device *dma_dev;
>         struct sk_buff *rsp;
> -       struct nlattr *attr;
> -       int rem, err =3D 0;
> +       int err =3D 0;
>         void *hdr;
>
>         if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> @@ -922,37 +955,22 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>                 goto err_unlock;
>         }
>
> +       rxq_bitmap =3D bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL);
> +       if (!rxq_bitmap) {
> +               err =3D -ENOMEM;
> +               goto err_unlock;
> +       }
> +       netdev_nl_read_rxq_bitmap(info, rxq_bitmap);
> +
>         dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVI=
CE,
>                                          dmabuf_fd, priv, info->extack);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
> -               goto err_unlock;
> +               goto err_rxq_bitmap;
>         }
>
> -       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> -                              genlmsg_data(info->genlhdr),
> -                              genlmsg_len(info->genlhdr), rem) {
> -               err =3D nla_parse_nested(
> -                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, at=
tr,
> -                       netdev_queue_id_nl_policy, info->extack);
> -               if (err < 0)
> -                       goto err_unbind;
> -
> -               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_ID) ||
> -                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QU=
EUE_TYPE)) {
> -                       err =3D -EINVAL;
> -                       goto err_unbind;
> -               }
> -
> -               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) !=3D NETDEV_QUEU=
E_TYPE_RX) {
> -                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_T=
YPE]);
> -                       err =3D -EINVAL;
> -                       goto err_unbind;
> -               }
> -
> -               rxq_idx =3D nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> -
> +       for_each_set_bit(rxq_idx, rxq_bitmap, netdev->num_rx_queues) {
>                 err =3D net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, =
binding,
>                                                       info->extack);
>                 if (err)
> @@ -966,6 +984,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>         if (err)
>                 goto err_unbind;
>
> +       bitmap_free(rxq_bitmap);
> +
>         netdev_unlock(netdev);
>
>         mutex_unlock(&priv->lock);
> @@ -974,6 +994,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>
>  err_unbind:
>         net_devmem_unbind_dmabuf(binding);
> +err_rxq_bitmap:
> +       bitmap_free(rxq_bitmap);
>  err_unlock:
>         netdev_unlock(netdev);
>  err_unlock_sock:
> --
> 2.50.1
>
>

