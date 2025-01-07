Return-Path: <netdev+bounces-155866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D4A041CE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20725167844
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AD1F4276;
	Tue,  7 Jan 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0vK0rMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA091F4E3D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258639; cv=none; b=Q4rNJv9udMGvPRwZGItfZHwOQaEgu4qwG/MMNC6QPoW0KX26jv5WvaEnbCVtNwf8uYreFVOtPxRxWlRLNXB0SalFqdsqmPYQjVvKCZMDZSlxC6gvSC5ZqVl4njnPK/ErZSbJaRBVFHxpbo4RnIXtdOIgUwRj0WwfFZZOZmrsQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258639; c=relaxed/simple;
	bh=C60U/0SmuwX4yUOyIWZb/WvrYDfFpfqIqmcuN5r+ZKA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mkFUhNyJMoI47AJ/RszlvS3/jJDaOzaAJu8k9m8CyK2NGZK8fi2fMysHiiBIxphlRO/EjIM5JLdivT/BOeC+n29YEEckOFb1zkuM/kOmHadXhqH5z7HWSxliokQRC7gdYan7biNPxwj0o+oZw0iAmRO2fRZ+mnciXYfsPXbW2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0vK0rMi; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e9586b82so1270443085a.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258635; x=1736863435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C937JUnNrvgXER32oHdbkJJBgEm6M1AKGYqcOWmWYA0=;
        b=g0vK0rMix8vBvG5Fkanfsm+/qUMjqOWl1+3yJPV5y9v4Mb4U4qzwxGcaGyUS0pk464
         Zl3gc4BNSUF8s6cEzM3RbJLS9HheyKvyAwiR4m73CRu23/mzzCc6WtYPy54e24UItWv6
         2oAVXua5OKBjiMmFsG0H62j5inJ1oDp/U6gP9025w056ZllxGAHLpq41B3BY26RB6RBO
         wLm7NeQMYXIlQ6nxlgILq7X4i2r+OmmSXv3pbL/JfVg20uCPlxFVvmO/XDdC7Mhdm+l6
         2eE2utYjb7624TDOVDz4wP3jqVPPc7fsPeeoCD00YgdRrA6fPoZzPfaxi80tEHAU+NiB
         yH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258635; x=1736863435;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C937JUnNrvgXER32oHdbkJJBgEm6M1AKGYqcOWmWYA0=;
        b=i/TCDIczfho6zQcBbvRzNCvMhI9WRm+z3eHxGTI2VolnIe2reObDIcSCJ9+61PVJxd
         5yogWh0g53RGoUCdmgOYXzGNwiiFqJOnxYll8pEczWN0rOVct4Lr+/yWbj8zo5z7z3eE
         +sKQ91+4Xt/t1I8M9R6sx6k1GOrbd60rR4p3ncyebK0zrtdowK59k8ylAQSjJB55f2Gm
         4m71sSrOLmg6v4yDFUpKkk9DJYZ0hz1x/QDyw1CqX6LVL12MS5ahxOWnoXF7uWgKc9ER
         16ud8sasMcCINex4RfrkCwekZ3MgE7z2piF/SoVUXjkDQX8/NiqAkGUD7vCHcr52h2zu
         BPfQ==
X-Gm-Message-State: AOJu0Yx7hfMpwBGTd6akySxtSAm3RZwAZjzaaDfruBVJ77p9ZpTIRffL
	0k0pkV5tiZTqA3CTjCapjN+w5go/QaFg0+C/Xl+nqj0BzyD0ViFl
X-Gm-Gg: ASbGncvjCag90ybyGJ5RsSmTabjnwwDGKimbzQ1Qm71uvVnDrGDgaUCIJNoOShkGFjx
	7QbakvZCJIQsqJ1w4UJi5124+A/EcQ20yGexRDXi8Az9s9I+/FcTRhWD8DeznWYfBENRDxiKVot
	azOhH3UiWnLtOgiEcs/If8Ni/TKAMKWq5HqkwWyqfk7ch8qRiUZ2Hmfu+SUHTdQ3pNuV6LkiWIc
	0KDMmG0FT1WBGakQWndxQs3+70aFGoqP+IlLYdGncTciyMaJ2W6xbuYVvnnEX426SEoBMqxuZ6N
	Rdgd6b9E8SmESrVOwIjAjClE7zlc
X-Google-Smtp-Source: AGHT+IFGkdBgM3XuVmEIi+gf9/r0aSki5NrpZuGqzMMd4olQFilvvqlAV2mbER4WGoPLOMNQwwcPNg==
X-Received: by 2002:a05:620a:2a09:b0:7b6:d1e1:a22e with SMTP id af79cd13be357-7b9ba79c0f8mr8978892185a.29.1736258635146;
        Tue, 07 Jan 2025 06:03:55 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac47a661sm1589047185a.79.2025.01.07.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:03:54 -0800 (PST)
Date: Tue, 07 Jan 2025 09:03:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dw@davidwei.uk, 
 almasrymina@google.com, 
 jdamato@fastly.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <677d344a30383_25382b29446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250103185954.1236510-7-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-7-kuba@kernel.org>
Subject: Re: [PATCH net-next 6/8] netdevsim: add queue management API support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add queue management API support. We need a way to reset queues
> to test NAPI reordering, the queue management API provides a
> handy scaffolding for that.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/netdev.c    | 135 +++++++++++++++++++++++++++---
>  drivers/net/netdevsim/netdevsim.h |   2 +
>  2 files changed, 125 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index e1bd3c1563b7..86614292314a 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -359,25 +359,24 @@ static int nsim_poll(struct napi_struct *napi, int budget)
>  	return done;
>  }
>  
> -static int nsim_create_page_pool(struct nsim_rq *rq)
> +static int nsim_create_page_pool(struct page_pool **p, struct napi_struct *napi)
>  {
> -	struct page_pool_params p = {
> +	struct page_pool_params params = {
>  		.order = 0,
>  		.pool_size = NSIM_RING_SIZE,
>  		.nid = NUMA_NO_NODE,
> -		.dev = &rq->napi.dev->dev,
> -		.napi = &rq->napi,
> +		.dev = &napi->dev->dev,
> +		.napi = napi,
>  		.dma_dir = DMA_BIDIRECTIONAL,
> -		.netdev = rq->napi.dev,
> +		.netdev = napi->dev,
>  	};
> +	struct page_pool *pool;
>  
> -	rq->page_pool = page_pool_create(&p);
> -	if (IS_ERR(rq->page_pool)) {
> -		int err = PTR_ERR(rq->page_pool);
> +	pool = page_pool_create(&params);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
>  
> -		rq->page_pool = NULL;
> -		return err;
> -	}
> +	*p = pool;
>  	return 0;
>  }
>  
> @@ -396,7 +395,7 @@ static int nsim_init_napi(struct netdevsim *ns)
>  	for (i = 0; i < dev->num_rx_queues; i++) {
>  		rq = ns->rq[i];
>  
> -		err = nsim_create_page_pool(rq);
> +		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
>  		if (err)
>  			goto err_pp_destroy;
>  	}
> @@ -613,6 +612,117 @@ static void nsim_queue_free(struct nsim_rq *rq)
>  	kfree(rq);
>  }
>  
> +/* Queue reset mode is controled by ns->rq_reset_mode.

controlled

also perhaps an enum for the modes?

> + * - normal - new NAPI new pool (old NAPI enabled when new added)
> + * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
> + * - mode 2 - new NAPI new pool (old NAPI removed before new added)
> + * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
> + */
> +struct nsim_queue_mem {
> +	struct nsim_rq *rq;
> +	struct page_pool *pp;
> +};
> +
> +static int
> +nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
> +{
> +	struct nsim_queue_mem *qmem = per_queue_mem;
> +	struct netdevsim *ns = netdev_priv(dev);
> +	int err;
> +
> +	if (ns->rq_reset_mode > 3)
> +		return -EINVAL;
> +
> +	if (ns->rq_reset_mode == 1)
> +		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
> +
> +	qmem->rq = nsim_queue_alloc();
> +	if (!qmem->rq)
> +		return -ENOMEM;
> +
> +	err = nsim_create_page_pool(&qmem->rq->page_pool, &qmem->rq->napi);
> +	if (err)
> +		goto err_free;
> +
> +	if (!ns->rq_reset_mode)
> +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> +
> +	return 0;
> +
> +err_free:
> +	nsim_queue_free(qmem->rq);
> +	return err;
> +}
> +
> +static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
> +{
> +	struct nsim_queue_mem *qmem = per_queue_mem;
> +	struct netdevsim *ns = netdev_priv(dev);
> +
> +	if (qmem->pp)
> +		page_pool_destroy(qmem->pp);
> +	if (qmem->rq) {
> +		if (!ns->rq_reset_mode)
> +			netif_napi_del(&qmem->rq->napi);
> +		page_pool_destroy(qmem->rq->page_pool);
> +		nsim_queue_free(qmem->rq);
> +	}
> +}
> +
> +static int
> +nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
> +{
> +	struct nsim_queue_mem *qmem = per_queue_mem;
> +	struct netdevsim *ns = netdev_priv(dev);
> +
> +	if (ns->rq_reset_mode == 1) {
> +		ns->rq[idx]->page_pool = qmem->pp;
> +		napi_enable(&ns->rq[idx]->napi);
> +		return 0;
> +	}
> +
> +	/* netif_napi_add()/_del() should normally be called from alloc/free,
> +	 * here we want to test various call orders.
> +	 */
> +	if (ns->rq_reset_mode == 2) {
> +		netif_napi_del(&ns->rq[idx]->napi);
> +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> +	} else if (ns->rq_reset_mode == 3) {
> +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> +		netif_napi_del(&ns->rq[idx]->napi);

Just to make sure my understanding: this is expected to not change
anything, due to test_and_(set|clear)_bit(NAPI_STATE_LISTED, ..),
right?

