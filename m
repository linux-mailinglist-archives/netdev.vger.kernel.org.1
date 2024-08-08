Return-Path: <netdev+bounces-116796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8494BC05
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F122E1F21187
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7108918B473;
	Thu,  8 Aug 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaZ/1X+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4C18A95F
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115594; cv=none; b=mRbXM7wlnZ7511YgENZiKO21ScqQ/I2ao81GRUEt1UaR92QJ6taq8RCTQWhxvQBzVAoZouv+maR5iMb5jqHWAGOI8Y6RATVRMRSZg/4YHbEs54FgcyiKAxzaJRTepkwTMUcPHtJ9p6lS0qpOSzGnjxeSEl6FyzT8vCCNBhy9Jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115594; c=relaxed/simple;
	bh=e3rNXlZ10ELIlQWpr9qqs/CKAZESNlEBtBZkbG071Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeoELQVtg4kEh1Ya0oS/G8LeNthve8qkobCAZik1oFzhVFdUM5z1ObbQu5whdZ9pX27cKIvoY65huAGwj392EJQalqXuz9cuyTSA7/CyBF08jEQXlPkw1c9pJLL0xhpUMTlqpZA858v5oDY5YpWKTejPXmG+L7e41Pf0LwzZ7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaZ/1X+g; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso623399a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723115592; x=1723720392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAV2E4vxR8BP5/8RJxwMfQoFjwiDDylV7XP0wv404b8=;
        b=zaZ/1X+gr5ruFtBg0hUfhwHz7d39LHQO9IxWnfAvCHSJgD0OqyAmLwrFq69ipwZaj8
         n5mPFkxmFkNPyTyx+dWmua0Li+tXVc2pvjKn3wmQr9o1Cw+eJfdmq/V6UyO51NruroiC
         C9x/R7HdydGZDme2FEyIEK0sE3eesx5G8BSojFPC7VPJE6aJJ0vri/HRhlNNdyPKWuMl
         j1InKP6kitHyW6U8JDEtIcMmMqdLz9d+0s15d24r7RTUQWCwxLaskGjBLyHfFoJ1XYgK
         kJhcfN8C373+rCaZwLbSmtW0WyDCt3ZqFyEEbRqQtGPlw/xRa0qVx6YyJROKEm/tibi/
         R49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723115592; x=1723720392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAV2E4vxR8BP5/8RJxwMfQoFjwiDDylV7XP0wv404b8=;
        b=MAdtij9uzcDTfexPpZD3viquuPaH1XYlWURtum45BTNWQZC1NG8obebdL5aJgcILTQ
         ulQsEV+BsGbtieVFnoTTBVf3ExdxueYwzfF5nq3KEwkk7d9XqP4LmwnVCGh7d+Vnhqer
         clRVgDxnEUq+E2WuiHBjUSqqjxT4AQSUDfLH+qcp73y0n11BpyKO/XjHetfYkgdgeZXP
         W3nyD59susTULHcmYK9pAJphvB8KOTGHzZQQjv7ZQIbYho+HHZxeGhHmL8AqI2F1lXZC
         Y6kaMW7IYv1WdNgUQ83mCfU77AOEvnspyqRG6cky9LAPJbTODhbQig29P1rQrnuW1qt2
         aVvA==
X-Gm-Message-State: AOJu0YyGLKVJLayTYU3fAK0XpWaZcrte+xX9wudglbbO9u89BmNW+OsN
	451MQdnAdIhkP+PVQq9xLNhhqsCa0oHcdBXetyu7GaE3xFchJLVgvo3cYR3/bvW2Va4EDBDeb8e
	3pnc8T5pUjlYtAfebfoRHZLeZdiNO8bO9Qf2Gdg==
X-Google-Smtp-Source: AGHT+IHMezTcWSm5ve0dAeWi8A/lECidxOti6kREtkrL7FMXRSnyVgUDmAye4BHqyBxE/nYKdnKXRZsiS4c5Hduvb40=
X-Received: by 2002:a05:6a20:7284:b0:1c6:f859:542d with SMTP id
 adf61e73a8af0-1c6fcebedd4mr1541164637.16.1723115591764; Thu, 08 Aug 2024
 04:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806151618.1373008-1-kuba@kernel.org>
In-Reply-To: <20240806151618.1373008-1-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 14:12:34 +0300
Message-ID: <CAC_iWj+G_Rrqw8R5PR3vZsL5Oid+_tzNOLOg6Hoo1jt3vhGx5A@mail.gmail.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Alexander Duyck <alexander.duyck@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 6 Aug 2024 at 18:16, Jakub Kicinski <kuba@kernel.org> wrote:
>
> There appears to be no clean way to hold onto the IOMMU, so page pool
> cannot outlast the driver which created it. We have no way to stall
> the driver unregister, but we can use netdev unregistration as a proxy.

Isn't the inflight machinery enough?
Looking at the page_pool_destroy() path, we eventually call
page_pool_return_page() which will try to unmap memory. That won't be
called if we have inflight packets.
In any case why do you want to hold on the IOMMU? The network
interface -- at least in theory -- should be down and we wont be
processing any more packets.

Regards
/Ilias
>
> Note that page pool pages may last forever, we have seen it happen
> e.g. when application leaks a socket and page is stuck in its rcv queue.
> Hopefully this is fine in this particular case, as we will only stall
> unregistering of devices which want the page pool to manage the DMA
> mapping for them, i.e. HW backed netdevs. And obviously keeping
> the netdev around is preferable to a crash.
>
> More work is needed for weird drivers which share one pool among
> multiple netdevs, as they are not allowed to set the pp->netdev
> pointer. We probably need to add a bit that says "don't expose
> to uAPI for them".
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Untested, but I think it would work.. if it's not too controversial.
>
> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Yonglong Liu <liuyonglong@huawei.com>
> CC: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/netdevice.h |  4 ++++
>  net/core/page_pool_user.c | 44 +++++++++++++++++++++++++++++++--------
>  2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0ef3eaa23f4b..c817bde7bacc 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2342,6 +2342,8 @@ struct net_device {
>         struct lock_class_key   *qdisc_tx_busylock;
>         bool                    proto_down;
>         bool                    threaded;
> +       /** @pp_unreg_pending: page pool code is stalling unregister */
> +       bool                    pp_unreg_pending;
>
>         struct list_head        net_notifier_list;
>
> @@ -2371,6 +2373,8 @@ struct net_device {
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
>         /** @page_pools: page pools created for this netdevice */
>         struct hlist_head       page_pools;
> +       /** @pp_dev_tracker: ref tracker for page pool code stalling unreg */
> +       netdevice_tracker       pp_dev_tracker;
>  #endif
>
>         /** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 3a3277ba167b..1a4135f01130 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -349,22 +349,36 @@ static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
>         struct page_pool *pool;
>         struct hlist_node *n;
>
> -       mutex_lock(&page_pools_lock);
>         hlist_for_each_entry_safe(pool, n, &netdev->page_pools, user.list) {
>                 hlist_del_init(&pool->user.list);
>                 pool->slow.netdev = NET_PTR_POISON;
>         }
> -       mutex_unlock(&page_pools_lock);
>  }
>
> -static void page_pool_unreg_netdev(struct net_device *netdev)
> +static void page_pool_unreg_netdev_stall(struct net_device *netdev)
> +{
> +       if (!netdev->pp_unreg_pending) {
> +               netdev_hold(netdev, &netdev->pp_dev_tracker, GFP_KERNEL);
> +               netdev->pp_unreg_pending = true;
> +       } else {
> +               netdev_warn(netdev,
> +                           "page pool release stalling device unregister");
> +       }
> +}
> +
> +static void page_pool_unreg_netdev_unstall(struct net_device *netdev)
> +{
> +       netdev_put(netdev, &netdev->pp_dev_tracker);
> +       netdev->pp_unreg_pending = false;
> +}
> +
> +static void page_pool_unreg_netdev_reparent(struct net_device *netdev)
>  {
>         struct page_pool *pool, *last;
>         struct net_device *lo;
>
>         lo = dev_net(netdev)->loopback_dev;
>
> -       mutex_lock(&page_pools_lock);
>         last = NULL;
>         hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
>                 pool->slow.netdev = lo;
> @@ -375,7 +389,6 @@ static void page_pool_unreg_netdev(struct net_device *netdev)
>         if (last)
>                 hlist_splice_init(&netdev->page_pools, &last->user.list,
>                                   &lo->page_pools);
> -       mutex_unlock(&page_pools_lock);
>  }
>
>  static int
> @@ -383,17 +396,30 @@ page_pool_netdevice_event(struct notifier_block *nb,
>                           unsigned long event, void *ptr)
>  {
>         struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> +       struct page_pool *pool;
> +       bool has_dma;
>
>         if (event != NETDEV_UNREGISTER)
>                 return NOTIFY_DONE;
>
> -       if (hlist_empty(&netdev->page_pools))
> +       if (hlist_empty(&netdev->page_pools) && !netdev->pp_unreg_pending)
>                 return NOTIFY_OK;
>
> -       if (netdev->ifindex != LOOPBACK_IFINDEX)
> -               page_pool_unreg_netdev(netdev);
> -       else
> +       mutex_lock(&page_pools_lock);
> +       has_dma = false;
> +       hlist_for_each_entry(pool, &netdev->page_pools, user.list)
> +               has_dma |= pool->slow.flags & PP_FLAG_DMA_MAP;
> +
> +       if (has_dma)
> +               page_pool_unreg_netdev_stall(netdev);
> +       else if (netdev->pp_unreg_pending)
> +               page_pool_unreg_netdev_unstall(netdev);
> +       else if (netdev->ifindex == LOOPBACK_IFINDEX)
>                 page_pool_unreg_netdev_wipe(netdev);
> +       else /* driver doesn't let page pools manage DMA addrs */
> +               page_pool_unreg_netdev_reparent(netdev);
> +       mutex_unlock(&page_pools_lock);
> +
>         return NOTIFY_OK;
>  }
>
> --
> 2.45.2
>

