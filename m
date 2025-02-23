Return-Path: <netdev+bounces-168816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05698A40EEE
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA6189075D
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65767205ACB;
	Sun, 23 Feb 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAaJfAie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79029201270
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740313596; cv=none; b=HNe1wlwv0nZWQ/BA0hvHi2oa+CVEN8JNuePSzyqNTsJ7DNtgnHqGuQaZUxlSuyj59boVQ0w/UxXNM9e1c//ckJVqSzMhs1BiXcrdhX261VLgkYjfxHKQ5JjJCqEvat16H+BiFLb9aDG5yjICcTadDxGb34xafAS348Sti2wvlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740313596; c=relaxed/simple;
	bh=s8AOoNrCqWdyhcW9O7mdZ80AfyEeIKBxPexW2Cxz3cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9Y7K7Qtq9HhfEFhqi4eZdrvptzk1QU6qNh9RqIvPSAsaq5Bku0DY/eziHU1yoUI2jczdUQLi9Zyy0h0JwL0A9oS3wVDiFhye3Lyy73VTK2OBEi9KOaHI36AHw6WOmUxnjUNQFsiAziK4qET6gUQwzyTNtONy31akZEWUhUAjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAaJfAie; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so5391440a12.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 04:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740313593; x=1740918393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKD74bouquq/FLvIeXibzGClzn59CJ5pTvjsEW3LoBI=;
        b=TAaJfAieaLqWQtebgwJK/Dvrr6/7sYwksVSNXgjVN2VBn285m7/oCIegQs1pbHXJ0z
         QBys4KnfjwXh6vr24b6LXgaCnVQF+NwjNA9xRce0oej0igsUHBeHOR9PjSLxJBD+6giJ
         HUoxZn4uHybj62exvY0Vy36LYYeyE3fnLWKJbLRHb0W5J4xFzrQqjwkKIGHD4LfzxyjM
         0ZttYV20Ts1R89xFGHIGjy9etfafJdMjwMz/th+2ZkpOrST5scAd1+x9eVNVifCV4l1c
         5kWD7muW2mBvZHCxoL0Pbb92horzhVjv0FVNNw2u3si40CzlYM71GhRfJewex2NlRONi
         objw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740313593; x=1740918393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKD74bouquq/FLvIeXibzGClzn59CJ5pTvjsEW3LoBI=;
        b=hOnQZCux6xGRDjGtb2YpZU1S7IGt5EQDoUxc11NU60GzQGTVc8vTH4k287M7MFI+Xu
         xTydFQ3KR6imlnPVq2hTqPLONk77aPIDqtKfuUI3F1drDR4xn8bQ42nfgUwKVhseHJVp
         J+b2U6SAbVOpE6fYQp06LUjkOvn5rqRU2riQbnZfJPCiPvIrUm8A6rVIEJpwsmd+OAeF
         cw+ZePxrjJbZsZH96QdpcDuR42EVcUybv9CanGeiXWjyie956ziBaK8EnfX8iPaFxD3j
         SO6HYM6eNOxxEUgcQYWv39AYWdAOrTi2ZBN31uqaEWsMn2JGY6dKuPLwrONH6wQB6C8j
         eFIg==
X-Forwarded-Encrypted: i=1; AJvYcCW79Ph2gO2wwM21uyq9xcj7O9B6Mck3SvkBUu5egBr1AgG1ZuW2LZJpoGj3BF4g78JUSmPDoKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tPtggy3XOKGeQk2LB5xQe83YLr128emIMhvai8+F2nYibht0
	NtjLBQi2gD8QQHQ8OCdbPpr5Jp3f8sX24neGNhk8Fo5vUIfUcLhFeHmvVHSxe8Ml3SRq7tZWonC
	YIu/Fzdtd/sGF6HdWGwxUvR1v/tw=
X-Gm-Gg: ASbGncs9Y/V8J34shPvmv7XYMmkGqaJD+BukumRTjhBHyBLxtWaRER+0jqgLoKfW3Pt
	lyFb2mj5OGCLJ7VNlROwYAWEMAVY3JBzwRXmR0Flku/Y9/j0oLTLYnOLTtE4SvsGw0yZ2sOLEUV
	pRT4rxNyJ/
X-Google-Smtp-Source: AGHT+IGtKfbRyVWTaZYEppZgEtyG7/j96Wr867oKx57G+OBc4N3YDhtYzi4M3PINK9tFsNVuBxa4Adh16kW/eTidNgo=
X-Received: by 2002:a05:6402:13cd:b0:5d4:1ac2:277f with SMTP id
 4fb4d7f45d1cf-5e0b70e96f1mr9514502a12.9.1740313592376; Sun, 23 Feb 2025
 04:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221025141.1132944-1-kuba@kernel.org>
In-Reply-To: <20250221025141.1132944-1-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 23 Feb 2025 21:26:20 +0900
X-Gm-Features: AWEUYZnZ7vBQoq_-QaWVZy5lEbbzOlAuVh4uAorR6NVXCkJEtq6nuIwIeXuhEa4
Message-ID: <CAMArcTWRb6uxQcgCg4=v1BkTjTGuOy-x_N8uyFt4m4TXzfQV3w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: ethtool: fix ioctl confusing drivers
 about desired HDS user config
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dxu@dxuuu.xyz, 
	michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> The legacy ioctl path does not have support for extended attributes.
> So we issue a GET to fetch the current settings from the driver,
> in an attempt to keep them unchanged. HDS is a bit "special" as
> the GET only returns on/off while the SET takes a "ternary" argument
> (on/off/default). If the driver was in the "default" setting -
> executing the ioctl path binds it to on or off, even tho the user
> did not intend to change HDS config.
>
> Factor the relevant logic out of the netlink code and reuse it.
>
> Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool com=
mand")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Tested-by: Taehee Yoo <ap420073@gmail.com>

> v2:
>  - fix the core rather than the driver
> v1: https://lore.kernel.org/20250220005318.560733-1-kuba@kernel.org
>
> CC: michael.chan@broadcom.com
> CC: ap420073@gmail.com
> ---
>  net/ethtool/common.h |  6 ++++++
>  net/ethtool/common.c | 16 ++++++++++++++++
>  net/ethtool/ioctl.c  |  4 ++--
>  net/ethtool/rings.c  |  9 ++++-----
>  4 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> index 58e9e7db06f9..a1088c2441d0 100644
> --- a/net/ethtool/common.h
> +++ b/net/ethtool/common.h
> @@ -51,6 +51,12 @@ int ethtool_check_max_channel(struct net_device *dev,
>                               struct ethtool_channels channels,
>                               struct genl_info *info);
>  int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context);
> +
> +void ethtool_ringparam_get_cfg(struct net_device *dev,
> +                              struct ethtool_ringparam *param,
> +                              struct kernel_ethtool_ringparam *kparam,
> +                              struct netlink_ext_ack *extack);
> +
>  int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_=
ts_info *info);
>  int ethtool_get_ts_info_by_phc(struct net_device *dev,
>                                struct kernel_ethtool_ts_info *info,
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index d88e9080643b..b97374b508f6 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -6,6 +6,7 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/phy_link_topology.h>
> +#include <net/netdev_queues.h>
>
>  #include "netlink.h"
>  #include "common.h"
> @@ -771,6 +772,21 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
>         return 0;
>  }
>
> +void ethtool_ringparam_get_cfg(struct net_device *dev,
> +                              struct ethtool_ringparam *param,
> +                              struct kernel_ethtool_ringparam *kparam,
> +                              struct netlink_ext_ack *extack)
> +{
> +       memset(param, 0, sizeof(*param));
> +       memset(kparam, 0, sizeof(*kparam));
> +
> +       param->cmd =3D ETHTOOL_GRINGPARAM;
> +       dev->ethtool_ops->get_ringparam(dev, param, kparam, extack);
> +
> +       /* Driver gives us current state, we want to return current confi=
g */
> +       kparam->tcp_data_split =3D dev->cfg->hds_config;
> +}
> +
>  static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
>  {
>         memset(info, 0, sizeof(*info));
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 7609ce2b2c5e..1c3ba2247776 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -2059,8 +2059,8 @@ static int ethtool_get_ringparam(struct net_device =
*dev, void __user *useraddr)
>
>  static int ethtool_set_ringparam(struct net_device *dev, void __user *us=
eraddr)
>  {
> -       struct ethtool_ringparam ringparam, max =3D { .cmd =3D ETHTOOL_GR=
INGPARAM };
>         struct kernel_ethtool_ringparam kernel_ringparam;
> +       struct ethtool_ringparam ringparam, max;
>         int ret;
>
>         if (!dev->ethtool_ops->set_ringparam || !dev->ethtool_ops->get_ri=
ngparam)
> @@ -2069,7 +2069,7 @@ static int ethtool_set_ringparam(struct net_device =
*dev, void __user *useraddr)
>         if (copy_from_user(&ringparam, useraddr, sizeof(ringparam)))
>                 return -EFAULT;
>
> -       dev->ethtool_ops->get_ringparam(dev, &max, &kernel_ringparam, NUL=
L);
> +       ethtool_ringparam_get_cfg(dev, &max, &kernel_ringparam, NULL);
>
>         /* ensure new ring parameters are within the maximums */
>         if (ringparam.rx_pending > max.rx_max_pending ||
> diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> index 7839bfd1ac6a..aeedd5ec6b8c 100644
> --- a/net/ethtool/rings.c
> +++ b/net/ethtool/rings.c
> @@ -215,17 +215,16 @@ ethnl_set_rings_validate(struct ethnl_req_info *req=
_info,
>  static int
>  ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>  {
> -       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> -       struct ethtool_ringparam ringparam =3D {};
> +       struct kernel_ethtool_ringparam kernel_ringparam;
>         struct net_device *dev =3D req_info->dev;
> +       struct ethtool_ringparam ringparam;
>         struct nlattr **tb =3D info->attrs;
>         const struct nlattr *err_attr;
>         bool mod =3D false;
>         int ret;
>
> -       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> -                                       &kernel_ringparam, info->extack);
> -       kernel_ringparam.tcp_data_split =3D dev->cfg->hds_config;
> +       ethtool_ringparam_get_cfg(dev, &ringparam, &kernel_ringparam,
> +                                 info->extack);
>
>         ethnl_update_u32(&ringparam.rx_pending, tb[ETHTOOL_A_RINGS_RX], &=
mod);
>         ethnl_update_u32(&ringparam.rx_mini_pending,
> --
> 2.48.1
>

