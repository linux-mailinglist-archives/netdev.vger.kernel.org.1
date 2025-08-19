Return-Path: <netdev+bounces-215041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D3B2CDAD
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174801C40F11
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08013341AA0;
	Tue, 19 Aug 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/9mfs/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AF340DBD
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634555; cv=none; b=bvPA00/ILumudEVFM5cHi/5nfDFOCzaAVwS77Z/1/l4JV/5g01jzIXWxQyDGl8pAKgXPX0slfM875x165kZJ2vX6o17X1YlUVVzvi2t0WgPcYJGSC2WOZZ2acZV6+VUsBZ00+xfO0bhfWyJFTb2DEYP8hUPpGNtc1/Aw/0g8uNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634555; c=relaxed/simple;
	bh=haNt1ynrBslWuNN9po1WS/VqpVcCCWlCBE37zYZJkZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTPuUCBMBsWziW0m+hz9WQIK1/AhhPYRTMsCJwicgqQ2vAMYzjhTwgok8IdogqGn49PA+gbm1IsI8+iGRW6jyyV9BRsVIpnkjZLMgWVzz8Z7zpEivuED2tDdD8Jz+1HOehgD4Ltora0ddhPs/omSCyUgT1LnUm5ukjl/d5KPfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/9mfs/P; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55cef2f624fso1727e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755634552; x=1756239352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZMXm24uetgG6qUHWYUnf6IXKxtAndMosq8RvrZUKXE=;
        b=I/9mfs/PHAGZt8YkAqfLpi4PE+blLDReBlDuEI3RqONOhVw1dGX4jG0muHA+IeXKCZ
         qhk+S4LRxSX1K6b/8dZXlQ3vd7BTce8yNO7pkLwMwfginHA4pM7A5V14N0KagKwIdBA+
         nrGxp8jwOybRPa6nbHPAwPJ41VB1TtRK1BRiMSjdwnqJ0K1B3wRZ5+bcYyMrBFUeix+O
         7ymGb9fjpuYBoOAtqUdPzIb7iRLyUrakp2Ifld16hzr87UgfLrJhUsLeFO03HGsPL7FZ
         IuL+wZdzB2NanxW6xPs5/L10dP4pBLMCyeQsyHeFlwtvTiBCGLE4B1N4AymvzTxJVHQF
         OjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634552; x=1756239352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZMXm24uetgG6qUHWYUnf6IXKxtAndMosq8RvrZUKXE=;
        b=vk+G66cSrfAIpQb64D6dFyz+oxZUTNdc5lj/duhVYPecZiW5+dM5zUXMiC1wtMyD6U
         Nr7KIlY1pMPWdGcyhijl2PzreyLkqoCZRyQHuxFvFo8LjRCG7rwIpTo+WeG+pKba3DhR
         7pNVgjmd3LpHc3pKDCUZLOigPmAkMYnUsVhMMuzscu0rZvHdM9BytvE7xuwMOTwWD9Gi
         /V4pq3/5WvXJtJZViCIuXmv1C39agXYXRbzaZPSjX6PGSRPwWxjin52dygu8bmwdR1/P
         tkR6b2GMAd0PUle/Yh5pJTdzJZuudoNKLNwnXfpuqCDCyqva0YPXfFYPJMv43Hqw3wLT
         B0rg==
X-Forwarded-Encrypted: i=1; AJvYcCW+vpvPdjMdAuL+bbXfkh4ijv7kBkD6f/ULqRvpdt3N/szZggfT5jXk0EJrcjGBmlOLPTzIaYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZy7ribyTrtp5DdLDo9G4F4+ydnpPlXFctUfk9Yk77BfEgVk7
	yR8H7RbYnIYO2kDAhBZkVStAEY5cIAgNWyCils7zGDkEI7/HTRNSN4fVMy1oj9vyjAd//uWHGzP
	2uEQnhEelQy5bYog9P//joix/wUsYf4Ii0BtMMHX0
X-Gm-Gg: ASbGncsDHUrAsgqnsIQ9PH4+Sjqd5X+gayOwlxMH8Oqh7OVGql696TZqGL00V4bf455
	inKZQ5ZhdQLH9opQCI2iBwnzdzmMXyKrgCuSm072w2SETGf7c8VVH3i0y1mB79svr0B6A8+0X/K
	i71aaamTd3E7WOvJILEanBP2uyRrW2b5OIXAIf7+AJFgd6Ft2mex1UDoObUbFkEVj8Gj+cBPsuB
	g+I8X4CwJM2H/P+eu/A6wGGS8eFPJFA5gq2bhMtJsD0yO3VN+zTT0U=
X-Google-Smtp-Source: AGHT+IGOTSfoGmYaePWoFD5+meo3XBb2vpfJQKqJ4JTBJP5htoWmfFQaOrBPMHZxzbYyZtrHwdJp4c1LpY5fBwKAiAM=
X-Received: by 2002:a05:6512:609b:b0:55d:9f5:8846 with SMTP id
 2adb3069b0e04-55e066ac51cmr50748e87.0.1755634551686; Tue, 19 Aug 2025
 13:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <536e37960e3d75c633bdcdcfec37a89636581f2c.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <536e37960e3d75c633bdcdcfec37a89636581f2c.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 13:15:37 -0700
X-Gm-Features: Ac12FXyFNa4-6VDkMH60R1X9jCiq4Lpoo0jyzvsCmWd87zW1qTO99gzjyPNMFJA
Message-ID: <CAHS8izPWODE0sdVe0KTT69Wm8-LJLnXGjNFi+j77PrVGzK1FgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/23] net: move netdev_config manipulation to
 dedicated helpers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> netdev_config manipulation will become slightly more complicated
> soon and we will need to call if from ethtool as well as queue API.
> Encapsulate the logic into helper functions.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/core/Makefile        |  2 +-
>  net/core/dev.c           |  7 ++-----
>  net/core/dev.h           |  5 +++++
>  net/core/netdev_config.c | 43 ++++++++++++++++++++++++++++++++++++++++
>  net/ethtool/netlink.c    | 14 ++++++-------
>  5 files changed, 57 insertions(+), 14 deletions(-)
>  create mode 100644 net/core/netdev_config.c
>
> diff --git a/net/core/Makefile b/net/core/Makefile
> index b2a76ce33932..4db487396094 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -19,7 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) +=3D dev_addr_lists=
_test.o
>
>  obj-y +=3D net-sysfs.o
>  obj-y +=3D hotdata.o
> -obj-y +=3D netdev_rx_queue.o
> +obj-y +=3D netdev_config.o netdev_rx_queue.o
>  obj-$(CONFIG_PAGE_POOL) +=3D page_pool.o page_pool_user.o
>  obj-$(CONFIG_PROC_FS) +=3D net-procfs.o
>  obj-$(CONFIG_NET_PKTGEN) +=3D pktgen.o
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5a3c0f40a93f..7cd4e5eab441 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11873,10 +11873,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_p=
riv, const char *name,
>         if (!dev->ethtool)
>                 goto free_all;
>
> -       dev->cfg =3D kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
> -       if (!dev->cfg)
> +       if (netdev_alloc_config(dev))
>                 goto free_all;
> -       dev->cfg_pending =3D dev->cfg;
>
>         dev->num_napi_configs =3D maxqs;
>         napi_config_sz =3D array_size(maxqs, sizeof(*dev->napi_config));
> @@ -11947,8 +11945,7 @@ void free_netdev(struct net_device *dev)
>                 return;
>         }
>
> -       WARN_ON(dev->cfg !=3D dev->cfg_pending);
> -       kfree(dev->cfg);
> +       netdev_free_config(dev);
>         kfree(dev->ethtool);
>         netif_free_tx_queues(dev);
>         netif_free_rx_queues(dev);
> diff --git a/net/core/dev.h b/net/core/dev.h
> index d6b08d435479..7041c8bd2a0f 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -92,6 +92,11 @@ extern struct rw_semaphore dev_addr_sem;
>  extern struct list_head net_todo_list;
>  void netdev_run_todo(void);
>
> +int netdev_alloc_config(struct net_device *dev);
> +void __netdev_free_config(struct netdev_config *cfg);
> +void netdev_free_config(struct net_device *dev);
> +int netdev_reconfig_start(struct net_device *dev);
> +
>  /* netdev management, shared between various uAPI entry points */
>  struct netdev_name_node {
>         struct hlist_node hlist;
> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> new file mode 100644
> index 000000000000..270b7f10a192
> --- /dev/null
> +++ b/net/core/netdev_config.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/netdevice.h>
> +#include <net/netdev_queues.h>
> +
> +#include "dev.h"
> +
> +int netdev_alloc_config(struct net_device *dev)
> +{
> +       struct netdev_config *cfg;
> +
> +       cfg =3D kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
> +       if (!cfg)
> +               return -ENOMEM;
> +
> +       dev->cfg =3D cfg;
> +       dev->cfg_pending =3D cfg;
> +       return 0;
> +}
> +
> +void __netdev_free_config(struct netdev_config *cfg)
> +{
> +       kfree(cfg);
> +}
> +
> +void netdev_free_config(struct net_device *dev)
> +{
> +       WARN_ON(dev->cfg !=3D dev->cfg_pending);
> +       __netdev_free_config(dev->cfg);
> +}
> +
> +int netdev_reconfig_start(struct net_device *dev)
> +{
> +       struct netdev_config *cfg;
> +
> +       WARN_ON(dev->cfg !=3D dev->cfg_pending);
> +       cfg =3D kmemdup(dev->cfg, sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
> +       if (!cfg)
> +               return -ENOMEM;
> +
> +       dev->cfg_pending =3D cfg;
> +       return 0;

There are a couple of small behavior changes in this code. (a) the
WARN_ON is new, and (b) this helper retains dev->cfg_pending on error
while the old code would clear it. But both seem fine to me, so,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

