Return-Path: <netdev+bounces-214135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0BB2857C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1331891EEB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E361A1D9A5D;
	Fri, 15 Aug 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkbT/spB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE33176FE
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281172; cv=none; b=oOkHudtoNDV+mPzOLcBBCq86UX0RdMg83RhMqGIlHgbUit21bquK7DXaCUXi4K6Oo/4UWwD8DJxf6xHuvDNZnapAdKav1o8mNYMIHIzk3rE2M3YMGXhZbXwQOBcQjyrsza1R/GjgDKxIwrlC6lR9v0DCCkurfyDwQG9QMOInuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281172; c=relaxed/simple;
	bh=o4C/K9kuN6SgsaiX120leGhtiDj5AYur9LGTfIBJbFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBgfbUGW0dgKHAFh14qTJNZNsG+QVqD6z9LD51xVKiM9NScWDWXj0FPsnUuWt6LNqQYAi5izMH/fl6nJwz4Q0tDaQBLotia4Dz0g8SYUIy1pKcOOQ0FpLT2xjjK/V+ZvJSufMETZ35j36j9qkleFPNUeYk4fOuZwrDLBk9tRRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkbT/spB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cc715d0easo931e87.0
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755281169; x=1755885969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2ZpF6Xhf8sdc8cGQINUdzwJi6gGpHKzkLkR6iShE+Q=;
        b=WkbT/spBkMopPaD+1dTaPGQL8wR17y1VrZwCpPr2UuWLhTVCDIahEGV7LNv5fFBWAU
         BxiVYsPfEYu0sTEF5iFbr5lp6dExH2VQYTYpXo7Gq43JzrmTJbyugIFXLhWma4oTtAR9
         0JXVFtiLDQ4WCFTZ2BH/V+tF88LoNh1Aw8soWJZm/IkFATyKZv+RxLDhx0BNr0AqErwd
         sznPjmhGDHDMQRKdthDfGTLWHOwfbMmRLUNRy9EmvTZrggUmHEvOIoRUfsQ4bUY9z1b2
         j5KIZ5q8Okj7YynZYqWz6P/APUVU70kYUTC81aGG8CsbKJWlOmxfSQGHqE821DlMYbWa
         lvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755281169; x=1755885969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2ZpF6Xhf8sdc8cGQINUdzwJi6gGpHKzkLkR6iShE+Q=;
        b=Vw8SXVrip1kTU/1cqbSqv4YL2mvOEYyHodvVTaigiSqtRd9riUxI1fn5VZAUc1MAaw
         YPCFUlSIEBLZtLhLy7pvxJ0YUenTc+ZDu+1K4caLo7TpBKrBElGX0b6GAzWUZWgIHvfO
         WVMEbdlw5NWLPfPobHNvhx/7uX/4a20aDkaVNMbYemL04gWU2la5tZ2+zNTTHCC6MK01
         H32JI27Jv5uhH1xwkA2x6RpOM7WDMxLLUXXcqZaAavEAUHyAfDi3UmvcBayc70QKM+sv
         F/IJXF1iaudUsNDkP38OWOyDZ/H9Xf/rOXwSLWDqRG9gvliFLKz9fVUaNwMxfk93kZDj
         IfxA==
X-Forwarded-Encrypted: i=1; AJvYcCV/u8BVWeqbmd6dmojXpsscL+PO6vjKWAnN9voWLm3xwIu54eevkONbdUnGKrsPaWWapywaBj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydnkI6rSqwx3GliFSHud/Mw7f9vMw/wfeNxDEsciT1XRHbpqzC
	eJhGARr2ie0FSos9zNJjmE5cPBpFs0X0fHgDbHFh5c3ukip1MEE5yd6mRu3yXQQZi7oxPh49xCy
	kzAuZynfKYAueeQ/z0Db3tHbvtpiQPulr63rvlwhI
X-Gm-Gg: ASbGnctSPDErVf85EnIC2aosCMh1DjF7QS/xlBV4rEbPoaGsMB49D079MMgJ9bnbmE3
	Ox83vobGsNJTGfYWGXuV7mKc+uOugZjG2kl0Uso/wT2wSSgYwqI3bDy08wExH9CMXP65UchmMRN
	FY7SxliRmUyMPegKnD2e12FdmBqA5Tcg+FzevVATeaGNcSKEsJXrZW9egJgg7SdUSfxMNL1VrZ/
	Gw4LceQ5/hmC0291EK5fE2SacecYApiwN4dnmiCcDNbDKAvyGx56ec=
X-Google-Smtp-Source: AGHT+IFGSTnIS2inxo+YJAG3r8YTvJEGqU3WbEHhFKAzadPtmeB1iGjqbaomkoD956j6CwjFpMNrBS/wnMzF/mqZTHk=
X-Received: by 2002:a05:6512:1356:b0:558:fd83:bac6 with SMTP id
 2adb3069b0e04-55cf2c27bc3mr17545e87.4.1755281169063; Fri, 15 Aug 2025
 11:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-8-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-8-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 15 Aug 2025 11:05:56 -0700
X-Gm-Features: Ac12FXxQwQ1cmsO0KKkfg_zt7FzaquXwK6n4R84VsjkJSWUt974nWptkz-wAvtw
Message-ID: <CAHS8izM-2vdudZeRu51TNCRzVPQVBKmrj0YoK80nNgWvR-ft3g@mail.gmail.com>
Subject: Re: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues
 during bind
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
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

Is this code assuming that netdev->num_rx_queues (or
real_num_rx_queues) <=3D BITS_PER_ULONG? Aren't there devices out there
that support more than 64 hardware queues? If so, I guess you need a
different data structure than a bitmap (or maybe there is arbirary
sized bitmap library somewhere to use).



--=20
Thanks,
Mina

