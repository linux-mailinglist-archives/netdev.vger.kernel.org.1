Return-Path: <netdev+bounces-90629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB808AF58A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCC01C2264C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEA13DDA5;
	Tue, 23 Apr 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="07DWhGIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC313CA85
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893619; cv=none; b=dgUcpyI6OqgRX67zkjd64tQBqxg5L/8HMMx4Z1WwU4SsN+jxcJ6Z6YnhO59E7g4TTqrq+ZvSii0/MzfFgikuT3zIDlZi+w0fxSMSHcut9C+5hV3tM7li4ulDp4oOxAf+EOl6P8V7q7kKFoyUjQ+FjFbTTqKnGE6bLwimvYKhpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893619; c=relaxed/simple;
	bh=tFD3sOvFiTjfPDSADfIbdWWan881qfO6V+ObufA+11s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iObPNvRLUzl7Q5nW1o3Ru6MayeCb17o+3q2CHQidKT+jJMo9wFIKH/5fKjzwSbhoRUXlVLCWz3zLo9LH6aUA7PgDRCajAyfA5EhTBNohfhMY0saCE3aNdXoHhPl+oui1t/xejtFx1mK9bZKxIujKBobDSSH5GuJylVIF4wrMvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=07DWhGIG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso4716187b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713893617; x=1714498417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWcNT8qfQKi7DbtbjC9KJesObFsaCo+0Yt+IIMin+3E=;
        b=07DWhGIGF3ePjCfONPue9TputVci0Al5RIgnUT7SStLoDST0446r3VbA+X/8VEwSei
         g6jh0XuO8aHWDozRAzbIVMOFItDRHWTkqe1R7vPeB8M+wukTs5qoZtRN2YltUZRuBucY
         1FyGvXMpAmVTLKyFUvESASgH+Dj4WjCIf/OJirkXfG53yE5S7eTlMXqjF5bTXuGzxNy9
         uWBBsW5KmrHlyxky4vTKrgPI4P9RxH2mXNpAsKZtkp5fM8tHeB0Z4oD4bpEZZlCti3cN
         V5jUQPpF3JCggSUkxgDK+bqlr3CNkCwJx7XeaxwL24TzLQT4seQ7Vyh3Lbq8aWN49NcW
         WMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713893617; x=1714498417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWcNT8qfQKi7DbtbjC9KJesObFsaCo+0Yt+IIMin+3E=;
        b=e9LWGBoWSY2J5pirYx1A+HsdS0K0/UUVeCiYN8q05h1XBw9VtCWF/rhq9E0JUJVT3b
         WQyZyo9uoCcfWshfbUZ2g5yhz2Sy/jta09LjStQGZo+graRUU0KZLjWC5G5pz2Zh21Iq
         l/Bstzx8z006l+wYqJsJG58yK5ysy+keVFh8nJqUMOKUL85T7xm+wsiVJpzbEn0Js1Yo
         G+HgVK8puErgwFzB+fhUs2cuuHu5xXBMRzPqCKEmxsP7OS3Q0cbunLlW7KSI3WWXJjqH
         Egg2EJjbFA9r01HAmrs8W56qBg8Y4T1QN7FBNACDgoU7hnI+YmtbQB1kwjAaRjMON7C0
         1RJg==
X-Forwarded-Encrypted: i=1; AJvYcCXpPTo1hegs4MPfKe+L5ZNwqTuIvkrLxW724ux7p0hoTMUAyEJ3LQzie3QZx0FLWrloJKvHBsjczBK34TjjWzUajM51pMuP
X-Gm-Message-State: AOJu0YxbSMW+2QgjD7XyND2SGIHJWM4Sn3Vrp8vxGs8DJWp+DDUlmv6C
	kYc6EcTXpLZ2JgoVdN5XdmkIpF1Ka6sSZsxpsWSoT7KpGAH1vG7o2v4uOR5gxmO5Yz0ZA+VzPpD
	0
X-Google-Smtp-Source: AGHT+IFUCXlwQWQb1xainngjFQx0FkIzU9OA5QknII/ltNS9pjNne6s/w7+NA3SldBu4zN1Rlx8iAw==
X-Received: by 2002:a05:6a00:b49:b0:6ea:afdb:6d03 with SMTP id p9-20020a056a000b4900b006eaafdb6d03mr291325pfo.19.1713893617018;
        Tue, 23 Apr 2024 10:33:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::6:5c90])
        by smtp.gmail.com with ESMTPSA id lw4-20020a056a00750400b006ea9108ec12sm9869241pfb.115.2024.04.23.10.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:33:36 -0700 (PDT)
Message-ID: <a9461863-d064-4014-a65a-7381ff8d1f7b@davidwei.uk>
Date: Tue, 23 Apr 2024 10:33:35 -0700
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
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240418195159.3461151-10-shailend@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-18 12:51 pm, Shailend Chand wrote:
> An api enabling the net stack to reset driver queues is implemented for
> gve.
> 
> Signed-off-by: Shailend Chand <shailend@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |   6 +
>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
>  drivers/net/ethernet/google/gve/gve_main.c   | 143 +++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
>  5 files changed, 167 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 9f6a897c87cb..d752e525bde7 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1147,6 +1147,12 @@ bool gve_tx_clean_pending(struct gve_priv *priv, struct gve_tx_ring *tx);
>  void gve_rx_write_doorbell(struct gve_priv *priv, struct gve_rx_ring *rx);
>  int gve_rx_poll(struct gve_notify_block *block, int budget);
>  bool gve_rx_work_pending(struct gve_rx_ring *rx);
> +int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
> +			  struct gve_rx_alloc_rings_cfg *cfg,
> +			  struct gve_rx_ring *rx,
> +			  int idx);
> +void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
> +			  struct gve_rx_alloc_rings_cfg *cfg);
>  int gve_rx_alloc_rings(struct gve_priv *priv);
>  int gve_rx_alloc_rings_gqi(struct gve_priv *priv,
>  			   struct gve_rx_alloc_rings_cfg *cfg);
> diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
> index b81584829c40..e83773fb891f 100644
> --- a/drivers/net/ethernet/google/gve/gve_dqo.h
> +++ b/drivers/net/ethernet/google/gve/gve_dqo.h
> @@ -44,6 +44,12 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
>  			   struct gve_tx_alloc_rings_cfg *cfg);
>  void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx);
>  void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx);
> +int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> +			  struct gve_rx_alloc_rings_cfg *cfg,
> +			  struct gve_rx_ring *rx,
> +			  int idx);
> +void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> +			  struct gve_rx_alloc_rings_cfg *cfg);
>  int gve_rx_alloc_rings_dqo(struct gve_priv *priv,
>  			   struct gve_rx_alloc_rings_cfg *cfg);
>  void gve_rx_free_rings_dqo(struct gve_priv *priv,
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index c348dff7cca6..5e652958f10f 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -17,6 +17,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/utsname.h>
>  #include <linux/version.h>
> +#include <net/netdev_queues.h>
>  #include <net/sch_generic.h>
>  #include <net/xdp_sock_drv.h>
>  #include "gve.h"
> @@ -2070,6 +2071,15 @@ static void gve_turnup(struct gve_priv *priv)
>  	gve_set_napi_enabled(priv);
>  }
>  
> +static void gve_turnup_and_check_status(struct gve_priv *priv)
> +{
> +	u32 status;
> +
> +	gve_turnup(priv);
> +	status = ioread32be(&priv->reg_bar0->device_status);
> +	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
> +}
> +
>  static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  {
>  	struct gve_notify_block *block;
> @@ -2530,6 +2540,138 @@ static void gve_write_version(u8 __iomem *driver_version_register)
>  	writeb('\n', driver_version_register);
>  }
>  
> +static int gve_rx_queue_stop(struct net_device *dev, int idx,
> +			     void **out_per_q_mem)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +	struct gve_rx_ring *rx;
> +	int err;
> +
> +	if (!priv->rx)
> +		return -EAGAIN;
> +	if (idx < 0 || idx >= priv->rx_cfg.max_queues)
> +		return -ERANGE;
> +
> +	/* Destroying queue 0 while other queues exist is not supported in DQO */
> +	if (!gve_is_gqi(priv) && idx == 0)
> +		return -ERANGE;
> +
> +	rx = kvzalloc(sizeof(*rx), GFP_KERNEL);
> +	if (!rx)
> +		return -ENOMEM;
> +	*rx = priv->rx[idx];
> +
> +	/* Single-queue destruction requires quiescence on all queues */
> +	gve_turndown(priv);
> +
> +	/* This failure will trigger a reset - no need to clean up */
> +	err = gve_adminq_destroy_single_rx_queue(priv, idx);
> +	if (err) {
> +		kvfree(rx);
> +		return err;
> +	}
> +
> +	if (gve_is_gqi(priv))
> +		gve_rx_stop_ring_gqi(priv, idx);
> +	else
> +		gve_rx_stop_ring_dqo(priv, idx);

Could these be pulled out into a helper? I see it repeated a lot.

> +
> +	/* Turn the unstopped queues back up */
> +	gve_turnup_and_check_status(priv);
> +
> +	*out_per_q_mem = rx;
> +	return 0;
> +}
> +
> +static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +	struct gve_rx_alloc_rings_cfg cfg = {0};
> +	struct gve_rx_ring *rx;
> +
> +	gve_rx_get_curr_alloc_cfg(priv, &cfg);
> +	rx = (struct gve_rx_ring *)per_q_mem;
> +	if (!rx)
> +		return;

This can be checked earlier.

> +
> +	if (gve_is_gqi(priv))
> +		gve_rx_free_ring_gqi(priv, rx, &cfg);
> +	else
> +		gve_rx_free_ring_dqo(priv, rx, &cfg);
> +
> +	kvfree(per_q_mem);
> +}
> +
> +static void *gve_rx_queue_mem_alloc(struct net_device *dev, int idx)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +	struct gve_rx_alloc_rings_cfg cfg = {0};
> +	struct gve_rx_ring *rx;
> +	int err;
> +
> +	gve_rx_get_curr_alloc_cfg(priv, &cfg);
> +	if (idx < 0 || idx >= cfg.qcfg->max_queues)
> +		return NULL;
> +
> +	rx = kvzalloc(sizeof(*rx), GFP_KERNEL);
> +	if (!rx)
> +		return NULL;
> +
> +	if (gve_is_gqi(priv))
> +		err = gve_rx_alloc_ring_gqi(priv, &cfg, rx, idx);
> +	else
> +		err = gve_rx_alloc_ring_dqo(priv, &cfg, rx, idx);
> +
> +	if (err) {
> +		kvfree(rx);
> +		return NULL;
> +	}
> +	return rx;
> +}
> +
> +static int gve_rx_queue_start(struct net_device *dev, int idx, void *per_q_mem)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +	struct gve_rx_ring *rx;
> +	int err;
> +
> +	if (!priv->rx)
> +		return -EAGAIN;
> +	if (idx < 0 || idx >= priv->rx_cfg.max_queues)
> +		return -ERANGE;
> +	rx = (struct gve_rx_ring *)per_q_mem;
> +	priv->rx[idx] = *rx;
> +
> +	/* Single-queue creation requires quiescence on all queues */
> +	gve_turndown(priv);
> +
> +	if (gve_is_gqi(priv))
> +		gve_rx_start_ring_gqi(priv, idx);
> +	else
> +		gve_rx_start_ring_dqo(priv, idx);
> +
> +	/* This failure will trigger a reset - no need to clean up */
> +	err = gve_adminq_create_single_rx_queue(priv, idx);
> +	if (err)
> +		return err;
> +
> +	if (gve_is_gqi(priv))
> +		gve_rx_write_doorbell(priv, &priv->rx[idx]);
> +	else
> +		gve_rx_post_buffers_dqo(&priv->rx[idx]);
> +
> +	/* Turn the unstopped queues back up */
> +	gve_turnup_and_check_status(priv);
> +	return 0;
> +}
> +
> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
> +	.ndo_queue_mem_alloc	=	gve_rx_queue_mem_alloc,
> +	.ndo_queue_mem_free	=	gve_rx_queue_mem_free,
> +	.ndo_queue_start	=	gve_rx_queue_start,
> +	.ndo_queue_stop		=	gve_rx_queue_stop,
> +};
> +
>  static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	int max_tx_queues, max_rx_queues;
> @@ -2584,6 +2726,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	pci_set_drvdata(pdev, dev);
>  	dev->ethtool_ops = &gve_ethtool_ops;
>  	dev->netdev_ops = &gve_netdev_ops;
> +	dev->queue_mgmt_ops = &gve_queue_mgmt_ops;
>  
>  	/* Set default and supported features.
>  	 *
> diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
> index 1d235caab4c5..307bf97d4778 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> @@ -101,8 +101,8 @@ void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx)
>  	gve_rx_reset_ring_gqi(priv, idx);
>  }
>  
> -static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
> -				 struct gve_rx_alloc_rings_cfg *cfg)
> +void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
> +			  struct gve_rx_alloc_rings_cfg *cfg)
>  {
>  	struct device *dev = &priv->pdev->dev;
>  	u32 slots = rx->mask + 1;
> @@ -270,10 +270,10 @@ void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx)
>  	gve_add_napi(priv, ntfy_idx, gve_napi_poll);
>  }
>  
> -static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
> -				 struct gve_rx_alloc_rings_cfg *cfg,
> -				 struct gve_rx_ring *rx,
> -				 int idx)
> +int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
> +			  struct gve_rx_alloc_rings_cfg *cfg,
> +			  struct gve_rx_ring *rx,
> +			  int idx)
>  {
>  	struct device *hdev = &priv->pdev->dev;
>  	u32 slots = cfg->ring_size;
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index dc2c6bd92e82..dcbc37118870 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -299,8 +299,8 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
>  	gve_rx_reset_ring_dqo(priv, idx);
>  }
>  
> -static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> -				 struct gve_rx_alloc_rings_cfg *cfg)
> +void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
> +			  struct gve_rx_alloc_rings_cfg *cfg)
>  {
>  	struct device *hdev = &priv->pdev->dev;
>  	size_t completion_queue_slots;
> @@ -373,10 +373,10 @@ void gve_rx_start_ring_dqo(struct gve_priv *priv, int idx)
>  	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
>  }
>  
> -static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> -				 struct gve_rx_alloc_rings_cfg *cfg,
> -				 struct gve_rx_ring *rx,
> -				 int idx)
> +int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> +			  struct gve_rx_alloc_rings_cfg *cfg,
> +			  struct gve_rx_ring *rx,
> +			  int idx)
>  {
>  	struct device *hdev = &priv->pdev->dev;
>  	size_t size;

