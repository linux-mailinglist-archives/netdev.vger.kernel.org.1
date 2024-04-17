Return-Path: <netdev+bounces-88538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509028A79D8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8297E1C20DA0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA637B;
	Wed, 17 Apr 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKPD34Pg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36357F8
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313651; cv=none; b=Oub+gp/WXINjTPhquiw4UMS/UQRIjhsH32admRxkAtNJeoBpAn+dIBf5OLRGcRZ57a3mH9ibZkmaC78/xKFU1zftPvObuXUNesOLrSqWm9CmY7pd5dEGlgAJwpyQUmxqiUxU+l0ywi7ogbKX6XHHSCctq98pnXm3DP0E9ncI320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313651; c=relaxed/simple;
	bh=EF2zXhy4hq4LcXMfRKQeBpUlGP93GlWlGupOb6GX3kU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ0j1O5MV1hItuOoOD9G0lLvLZMVcQ+PWZus70hDB0D4x50Tlk6yBTrqXR40Zmo3wptY8C+Vz9MfbC90nOk6s6WtTVRszAPUjulJrJZknymatSZ/OYDqAt9icAhvL9Y0dh0dBHtx2rWs3Z7w9JwZvo/OxDwlrbroTSOlu+BBhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKPD34Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF03AC113CE;
	Wed, 17 Apr 2024 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313651;
	bh=EF2zXhy4hq4LcXMfRKQeBpUlGP93GlWlGupOb6GX3kU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKPD34PgHt0UhLME+0ogAcEKLhfI8cov7dmq0x4Q1BZw81B/U2OlyWrw3NXPrCxg5
	 PNAb5B6rLJk9JP8hqEnZi1K7sV04s8Sb9K8JwURlia8HRkPseCW0TReCT9viOSpve9
	 SJU0oHzeF8hL1I41OER8X/7SLglYpbjdWW7ihpkacIiqEh5cKexvmJUVaFAOH5bsIQ
	 apWmrtLSVMwbNbO/RyjvRRN+MHNnHPttK4EUW7+r1cQi9Fjj/5+KfmkQZyvq/X4PPP
	 7vUc7Q4GWq2IOZ5KFAqY9l6KjAnPBWBANDMdSPa2E9Jgr9dzP1keJEWRupjyLTNTfP
	 FG6nesSeqx6Ng==
Date: Tue, 16 Apr 2024 17:27:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 1/2] netdevsim: add NAPI support
Message-ID: <20240416172730.1b588eef@kernel.org>
In-Reply-To: <20240416051527.1657233-2-dw@davidwei.uk>
References: <20240416051527.1657233-1-dw@davidwei.uk>
	<20240416051527.1657233-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 22:15:26 -0700 David Wei wrote:
> Add NAPI support to netdevim, similar to veth.
> 
> * Add a nsim_rq rx queue structure to hold a NAPI instance and a skb
>   queue.
> * During xmit, store the skb in the peer skb queue and schedule NAPI.
> * During napi_poll(), drain the skb queue and pass up the stack.
> * Add assoc between rxq and NAPI instance using netif_queue_set_napi().

> +#define NSIM_RING_SIZE		256
> +
> +static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
> +{
> +	if (list_count_nodes(&rq->skb_queue) > NSIM_RING_SIZE) {
> +		dev_kfree_skb_any(skb);
> +		return NET_RX_DROP;
> +	}
> +
> +	list_add_tail(&skb->list, &rq->skb_queue);

Why not use struct sk_buff_head ?
It has a purge helper for freeing, and remembers its own length.

> +static int nsim_poll(struct napi_struct *napi, int budget)
> +{
> +	struct nsim_rq *rq = container_of(napi, struct nsim_rq, napi);
> +	int done;
> +
> +	done = nsim_rcv(rq, budget);
> +
> +	if (done < budget && napi_complete_done(napi, done)) {
> +		if (unlikely(!list_empty(&rq->skb_queue)))
> +			napi_schedule(&rq->napi);

I think you can drop the re-check, NAPI has a built in protection 
for this kind of race.

> +	}
> +
> +	return done;
> +}

>  static int nsim_open(struct net_device *dev)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
> -	struct page_pool_params pp = { 0 };
> +	int err;
> +
> +	err = nsim_init_napi(ns);
> +	if (err)
> +		return err;
> +
> +	nsim_enable_napi(ns);
>  
> -	pp.pool_size = 128;
> -	pp.dev = &dev->dev;
> -	pp.dma_dir = DMA_BIDIRECTIONAL;
> -	pp.netdev = dev;
> +	netif_carrier_on(dev);

Why the carrier? It's on by default.
Should be a separate patch if needed.

> -	ns->pp = page_pool_create(&pp);
> -	return PTR_ERR_OR_ZERO(ns->pp);
> +	return 0;
> +}

> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index 7664ab823e29..87bf45ec4dd2 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -90,11 +90,18 @@ struct nsim_ethtool {
>  	struct ethtool_fecparam fec;
>  };
>  
> +struct nsim_rq {
> +	struct napi_struct napi;
> +	struct list_head skb_queue;
> +	struct page_pool *page_pool;

You added the new page_pool pointer but didn't delete the one
I added recently to the device?

> +};
> +
>  struct netdevsim {
>  	struct net_device *netdev;
>  	struct nsim_dev *nsim_dev;
>  	struct nsim_dev_port *nsim_dev_port;
>  	struct mock_phc *phc;
> +	struct nsim_rq *rq;
>  
>  	u64 tx_packets;
>  	u64 tx_bytes;


