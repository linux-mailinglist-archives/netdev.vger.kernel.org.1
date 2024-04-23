Return-Path: <netdev+bounces-90630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6E8AF5DE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C0B2899C6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23613E025;
	Tue, 23 Apr 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="22UmxW4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED013D88A
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894922; cv=none; b=GJjMpESu1mUkJj37oUZUYJFcwI8eYLPJ4JuQlMrMp6aiBq6OFnn0b2oQgKYQjy+DGYdbo+Twcn+JHxrHHOnw+btKX7gOiAcLwRHHKZ6Qclxx0hfQR05L9pDVoyDoOG9wn5MOS9oeHPjkQpoq5Wp5/SoIZblbfeU5YzpAmLG2VLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894922; c=relaxed/simple;
	bh=dWlxgui3m3pz+nORsFegToIG/L9gnCdRGGpVThfTzWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoZ0pSz4hOuUB2WeE8yEXO+Lq1R0ttbSqWfv/V1/0hrE4vdAhb7XxO5kjARB4jKTmDSisanN5ru1lcvUuUH2gAJoMCv2sQWkfKI7HsvW6tjufhq5FD5RPuxltLC1O6dTU5Ywzpswm9f1CIp1QV3wF2wNvHlW99BLlfomre1Gv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=22UmxW4G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4f341330fso50473555ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713894920; x=1714499720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RF70MGpH+hYKHGWhdqhRJwHJftC8Zx75bQYO1/H4Sj8=;
        b=22UmxW4G/Ysp+6mgP+Y6avqyBo4mnPXTMgymuzf6SN0vqE3pn0FRfyn5MsygzWs1nQ
         E9sqKzeB2MwiVWCVjvKIRfzlpGEUdzYKFu9jFLuQyFfCN3etO2M5j8HleaZsQNcogeLA
         k7+1zuShzxJChO1+7ddJ3msCouac7g5MhCYI0PE+3YH91jKUKXHpfqRDfxVSBbcSZ9pk
         DSOsr63LxHC2vRBpy4Uy9+xzeUoTD5oid8cnvwfjSutFYFuZpBIUkh7WfDCyNK1ZaTQF
         B0o1pfmSyAVOkWDG1eV1isUaCtger9+BfaHFnNJepMOUIXyD630Kns+CNycwMPyLBKWf
         bpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713894920; x=1714499720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF70MGpH+hYKHGWhdqhRJwHJftC8Zx75bQYO1/H4Sj8=;
        b=aCtWaaoYPLn9mZENdQoBQj48TjfnFb9A0hr7Wm+Ef5VmCN9F5yEKtL5Tos0/Fhovzz
         oqDK0ud3khiWAbnYh7z64zy9a9Sz5yCUdfIL4q5WD4LM8mOsKTS1XAdO9LNe4S7h2BpV
         QP7FwLeC0IIkWDnjTO/ZNOkQye4yTLlFe9lKRC3pzxRegYqvHTFD0kvQWCcm1CeEKQ/r
         xdmJUzHuvtGEgSwzaacn3UW1oS5ydwDZfOFfw1rtHAq9bh5reugsAZ7pbE3oZJKxEBW6
         i343+TrKUrTrsEypS18uBuaTkG2XfxammtjsJn+qoiUHxbYwEB1I4THDBns/yywcf47h
         1mnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu01bvaQPqWnqNVNkh6quJNEHI2UT8uCzroibM9HWWCk3JqAyevNwymEddxjfak/MKH4AzrWKhu9o9S7tqCXsHz76NnOPI
X-Gm-Message-State: AOJu0Yz8IfTZ4A5e+zXEkGLGMukAmIQoJnom1+IdCNGIRnpmCDacRe4o
	sq0ZcgOD5dEElzGofIRcFxRVvGx1WAAitbXh0yGrFKDvJGUzd1tS56ecXAhv86I=
X-Google-Smtp-Source: AGHT+IHKejzxgc/O+1tekCRyX5Adp4gl/axu2xjDQUrY+p54dO9OZbZT92YGmUAlX+oJG1cMNB6vpw==
X-Received: by 2002:a17:902:cecf:b0:1e0:f473:fd8b with SMTP id d15-20020a170902cecf00b001e0f473fd8bmr285577plg.9.1713894919893;
        Tue, 23 Apr 2024 10:55:19 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::6:5c90])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001e7b85f0f67sm10278228plh.217.2024.04.23.10.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:55:19 -0700 (PDT)
Message-ID: <f731b2e0-f952-4ec3-b05a-7522c73457c7@davidwei.uk>
Date: Tue, 23 Apr 2024 10:55:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
Content-Language: en-GB
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com
References: <20240418195159.3461151-1-shailend@google.com>
 <20240418195159.3461151-10-shailend@google.com>
 <CANLc=asOJE-pGV74hXaZT5C73gVvbmDC1Zr6F4wJ31cqLFqcFg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CANLc=asOJE-pGV74hXaZT5C73gVvbmDC1Zr6F4wJ31cqLFqcFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-04-19 3:23 pm, Shailend Chand wrote:
> On Thu, Apr 18, 2024 at 12:52 PM Shailend Chand <shailend@google.com> wrote:
>>
>> An api enabling the net stack to reset driver queues is implemented for
>> gve.
>>
>> Signed-off-by: Shailend Chand <shailend@google.com>
>> ---
>>  drivers/net/ethernet/google/gve/gve.h        |   6 +
>>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
>>  drivers/net/ethernet/google/gve/gve_main.c   | 143 +++++++++++++++++++
>>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
>>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
>>  5 files changed, 167 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
>> index 9f6a897c87cb..d752e525bde7 100644
>> --- a/drivers/net/ethernet/google/gve/gve.h
>> +++ b/drivers/net/ethernet/google/gve/gve.h
>> @@ -1147,6 +1147,12 @@ bool gve_tx_clean_pending(struct gve_priv *priv, struct gve_tx_ring *tx);
>>  void gve_rx_write_doorbell(struct gve_priv *priv, struct gve_rx_ring *rx);
>>  int gve_rx_poll(struct gve_notify_block *block, int budget);
>>  bool gve_rx_work_pending(struct gve_rx_ring *rx);
>> +int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
>> +                         struct gve_rx_alloc_rings_cfg *cfg,
>> +                         struct gve_rx_ring *rx,
>> +                         int idx);
>> +void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
>> +                         struct gve_rx_alloc_rings_cfg *cfg);
>>  int gve_rx_alloc_rings(struct gve_priv *priv);
>>  int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
>>                            struct gve_rx_alloc_rings_cfg *cfg);
>> diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
>> index b81584829c40..e83773fb891f 100644
>> --- a/drivers/net/ethernet/google/gve/gve_dqo.h
>> +++ b/drivers/net/ethernet/google/gve/gve_dqo.h
>> @@ -44,6 +44,12 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
>>                            struct gve_tx_alloc_rings_cfg *cfg);
>>  void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx);
>>  void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx);
>> +int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>> +                         struct gve_rx_alloc_rings_cfg *cfg,
>> +                         struct gve_rx_ring *rx,
>> +                         int idx);
>> +void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>> +                         struct gve_rx_alloc_rings_cfg *cfg);
>>  int gve_rx_alloc_rings_dqo(struct gve_priv *priv,
>>                            struct gve_rx_alloc_rings_cfg *cfg);
>>  void gve_rx_free_rings_dqo(struct gve_priv *priv,
>> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
>> index c348dff7cca6..5e652958f10f 100644
>> --- a/drivers/net/ethernet/google/gve/gve_main.c
>> +++ b/drivers/net/ethernet/google/gve/gve_main.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/workqueue.h>
>>  #include <linux/utsname.h>
>>  #include <linux/version.h>
>> +#include <net/netdev_queues.h>
>>  #include <net/sch_generic.h>
>>  #include <net/xdp_sock_drv.h>
>>  #include "gve.h"
>> @@ -2070,6 +2071,15 @@ static void gve_turnup(struct gve_priv *priv)
>>         gve_set_napi_enabled(priv);
>>  }
>>
>> +static void gve_turnup_and_check_status(struct gve_priv *priv)
>> +{
>> +       u32 status;
>> +
>> +       gve_turnup(priv);
>> +       status = ioread32be(&priv->reg_bar0->device_status);
>> +       gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
>> +}
>> +
>>  static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
>>  {
>>         struct gve_notify_block *block;
>> @@ -2530,6 +2540,138 @@ static void gve_write_version(u8 __iomem *driver_version_register)
>>         writeb('\n', driver_version_register);
>>  }
>>
>> +static int gve_rx_queue_stop(struct net_device *dev, int idx,
>> +                            void **out_per_q_mem)
>> +{
>> +       struct gve_priv *priv = netdev_priv(dev);
>> +       struct gve_rx_ring *rx;
>> +       int err;
>> +
>> +       if (!priv->rx)
>> +               return -EAGAIN;
>> +       if (idx < 0 || idx >= priv->rx_cfg.max_queues)
>> +               return -ERANGE;
>> +
>> +       /* Destroying queue 0 while other queues exist is not supported in DQO */
>> +       if (!gve_is_gqi(priv) && idx == 0)
>> +               return -ERANGE;
>> +
>> +       rx = kvzalloc(sizeof(*rx), GFP_KERNEL);
>> +       if (!rx)
>> +               return -ENOMEM;
>> +       *rx = priv->rx[idx];
>> +
>> +       /* Single-queue destruction requires quiescence on all queues */
>> +       gve_turndown(priv);
>> +
>> +       /* This failure will trigger a reset - no need to clean up */
>> +       err = gve_adminq_destroy_single_rx_queue(priv, idx);
>> +       if (err) {
>> +               kvfree(rx);
>> +               return err;
>> +       }
>> +
>> +       if (gve_is_gqi(priv))
>> +               gve_rx_stop_ring_gqi(priv, idx);
>> +       else
>> +               gve_rx_stop_ring_dqo(priv, idx);
>> +
>> +       /* Turn the unstopped queues back up */
>> +       gve_turnup_and_check_status(priv);
>> +
>> +       *out_per_q_mem = rx;
>> +       return 0;
>> +}
>> +
>> +static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
>> +{
>> +       struct gve_priv *priv = netdev_priv(dev);
>> +       struct gve_rx_alloc_rings_cfg cfg = {0};
>> +       struct gve_rx_ring *rx;
>> +
>> +       gve_rx_get_curr_alloc_cfg(priv, &cfg);
>> +       rx = (struct gve_rx_ring *)per_q_mem;
>> +       if (!rx)
>> +               return;
>> +
>> +       if (gve_is_gqi(priv))
>> +               gve_rx_free_ring_gqi(priv, rx, &cfg);
>> +       else
>> +               gve_rx_free_ring_dqo(priv, rx, &cfg);
>> +
>> +       kvfree(per_q_mem);
>> +}
>> +
>> +static void *gve_rx_queue_mem_alloc(struct net_device *dev, int idx)
>> +{
>> +       struct gve_priv *priv = netdev_priv(dev);
>> +       struct gve_rx_alloc_rings_cfg cfg = {0};
>> +       struct gve_rx_ring *rx;
>> +       int err;
>> +
>> +       gve_rx_get_curr_alloc_cfg(priv, &cfg);
>> +       if (idx < 0 || idx >= cfg.qcfg->max_queues)
>> +               return NULL;
>> +
>> +       rx = kvzalloc(sizeof(*rx), GFP_KERNEL);
>> +       if (!rx)
>> +               return NULL;
>> +
>> +       if (gve_is_gqi(priv))
>> +               err = gve_rx_alloc_ring_gqi(priv, &cfg, rx, idx);
>> +       else
>> +               err = gve_rx_alloc_ring_dqo(priv, &cfg, rx, idx);
>> +
>> +       if (err) {
>> +               kvfree(rx);
>> +               return NULL;
>> +       }
>> +       return rx;
>> +}
>> +
>> +static int gve_rx_queue_start(struct net_device *dev, int idx, void *per_q_mem)
>> +{
>> +       struct gve_priv *priv = netdev_priv(dev);
>> +       struct gve_rx_ring *rx;
>> +       int err;
>> +
>> +       if (!priv->rx)
>> +               return -EAGAIN;
>> +       if (idx < 0 || idx >= priv->rx_cfg.max_queues)
>> +               return -ERANGE;
>> +       rx = (struct gve_rx_ring *)per_q_mem;
>> +       priv->rx[idx] = *rx;
>> +
>> +       /* Single-queue creation requires quiescence on all queues */
>> +       gve_turndown(priv);
>> +
>> +       if (gve_is_gqi(priv))
>> +               gve_rx_start_ring_gqi(priv, idx);
>> +       else
>> +               gve_rx_start_ring_dqo(priv, idx);
>> +
>> +       /* This failure will trigger a reset - no need to clean up */
>> +       err = gve_adminq_create_single_rx_queue(priv, idx);
>> +       if (err)
>> +               return err;
>> +
>> +       if (gve_is_gqi(priv))
>> +               gve_rx_write_doorbell(priv, &priv->rx[idx]);
>> +       else
>> +               gve_rx_post_buffers_dqo(&priv->rx[idx]);
>> +
>> +       /* Turn the unstopped queues back up */
>> +       gve_turnup_and_check_status(priv);
>> +       return 0;
>> +}
> 
> I realized that due to not kvfree-ing the passed-in `per_q_mem`, there
> is a leak. The alloc and stop hooks kvzalloc
> a temp ring struct, which means the start and free hooks ought to have
> kvfreed them to keep symmetry and avoid leaking.
> The free hook is doing it but I forgot to do it in the start hook.
> 
> If we go down the route of making core aware of the ring struct size,
> then none of the four hooks
> need to worry about the temp struct: core can just alloc and free it
> for both the old and new queue.

Having the core own qmem is the direction to move towards. I have
patches that do this, so we could merge what you have so far (i.e. have
the ndos alloc/free qmem) then I'll build on top of it for FBNIC/bnxt.

What might be missing in this patchset is a user of
netdev_queue_mgmt_ops. I know Mina has a restart_rx_queue() somewhere
and perhaps that should be included.

> 
>> +
>> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
>> +       .ndo_queue_mem_alloc    =       gve_rx_queue_mem_alloc,
>> +       .ndo_queue_mem_free     =       gve_rx_queue_mem_free,
>> +       .ndo_queue_start        =       gve_rx_queue_start,
>> +       .ndo_queue_stop         =       gve_rx_queue_stop,
>> +};
>> +
>>  static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  {
>>         int max_tx_queues, max_rx_queues;
>> @@ -2584,6 +2726,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         pci_set_drvdata(pdev, dev);
>>         dev->ethtool_ops = &gve_ethtool_ops;
>>         dev->netdev_ops = &gve_netdev_ops;
>> +       dev->queue_mgmt_ops = &gve_queue_mgmt_ops;
>>
>>         /* Set default and supported features.
>>          *
>> diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
>> index 1d235caab4c5..307bf97d4778 100644
>> --- a/drivers/net/ethernet/google/gve/gve_rx.c
>> +++ b/drivers/net/ethernet/google/gve/gve_rx.c
>> @@ -101,8 +101,8 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
>>         gve_rx_reset_ring_gqi(priv, idx);
>>  }
>>
>> -static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
>> -                                struct gve_rx_alloc_rings_cfg *cfg)
>> +void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
>> +                         struct gve_rx_alloc_rings_cfg *cfg)
>>  {
>>         struct device *dev = &priv->pdev->dev;
>>         u32 slots = rx->mask + 1;
>> @@ -270,10 +270,10 @@ void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx)
>>         gve_add_napi(priv, ntfy_idx, gve_napi_poll);
>>  }
>>
>> -static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
>> -                                struct gve_rx_alloc_rings_cfg *cfg,
>> -                                struct gve_rx_ring *rx,
>> -                                int idx)
>> +int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
>> +                         struct gve_rx_alloc_rings_cfg *cfg,
>> +                         struct gve_rx_ring *rx,
>> +                         int idx)
>>  {
>>         struct device *hdev = &priv->pdev->dev;
>>         u32 slots = cfg->ring_size;
>> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>> index dc2c6bd92e82..dcbc37118870 100644
>> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>> @@ -299,8 +299,8 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
>>         gve_rx_reset_ring_dqo(priv, idx);
>>  }
>>
>> -static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>> -                                struct gve_rx_alloc_rings_cfg *cfg)
>> +void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>> +                         struct gve_rx_alloc_rings_cfg *cfg)
>>  {
>>         struct device *hdev = &priv->pdev->dev;
>>         size_t completion_queue_slots;
>> @@ -373,10 +373,10 @@ void gve_rx_start_ring_dqo(struct gve_priv *priv, int idx)
>>         gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
>>  }
>>
>> -static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>> -                                struct gve_rx_alloc_rings_cfg *cfg,
>> -                                struct gve_rx_ring *rx,
>> -                                int idx)
>> +int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
>> +                         struct gve_rx_alloc_rings_cfg *cfg,
>> +                         struct gve_rx_ring *rx,
>> +                         int idx)
>>  {
>>         struct device *hdev = &priv->pdev->dev;
>>         size_t size;
>> --
>> 2.44.0.769.g3c40516874-goog
>>

