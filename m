Return-Path: <netdev+bounces-107760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E496091C3C3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CB61F23932
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55056154420;
	Fri, 28 Jun 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHxalcyQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176EB645
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592352; cv=none; b=OHgSW0V+mWjWWvMXSR/TFGSwaMWS0SqojblMBBwSIOKLQ7aMxAtTalFTuzz5oyu+bGSZuXItujuInN4Q2xVor7oLOPhxiCxvfq0RhvZItfR2Q2R0GYNubFqEdGx83FbL3SM2xLX5d/cNJq7YYKiFyGJtgd7vq+NPSg2A7kxEyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592352; c=relaxed/simple;
	bh=12FeweWdT5erYQcQNuT9OiEIqXz4Fbo93Lh15ZIsd4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE2MLmXIiSNeJgagvMV6Is1n+HukbDdglIWeNdMn+1EYDXbhkPG+l6/pSvQknblrKt6yJ0ujDKDb8gmDMj32lQR4PaAxSGtyJLs9ZYoH2LDAef241VL3bl3wlS1wMZaEE0jJ/Ykf7wsHmVarpqs9cGV0DIcb9ylYZzkqHry9DWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHxalcyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF65C116B1;
	Fri, 28 Jun 2024 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592350;
	bh=12FeweWdT5erYQcQNuT9OiEIqXz4Fbo93Lh15ZIsd4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHxalcyQUvyRqN+tpUHLDlZIbqFmE8RCdbekJ7ZfajRSegUxJzBEz4/M2jt0HGkrJ
	 MwcTbuVgnwyiwyzlJ/JoV8HMHD3qaAmFYqIZO+I8Pv6ZlZ9OH3zg8VRVex0Q01ImlH
	 /vtQ9TXX6wydwfBiZFn6wj4g84jw1kygj0uJTvQ9FZ6Nr+NqMze4+lOTleOu40nryI
	 bNfCVNFTq0v+ggt/AgM5jKsZtKef+2xolystoQabHJr1+7LBOyAicYZBpkd/TjNRzg
	 V0T0lv4yA2Cs+uHpBGHUw3WAnlfVvoQLRSOMV3slY4iZqlwwaFC49g9aEPOTyDfxd8
	 H+t6rXhy/Yqcg==
Date: Fri, 28 Jun 2024 17:32:26 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/4] crypto: caam: Unembed net_dev structure from qi
Message-ID: <20240628163226.GJ783093@kernel.org>
References: <20240624162128.1665620-1-leitao@debian.org>
 <20240624162128.1665620-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624162128.1665620-3-leitao@debian.org>

On Mon, Jun 24, 2024 at 09:21:21AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_devices from struct caam_qi_pcpu_priv by converting them
> into pointers, and allocating them dynamically. Use the leverage
> alloc_netdev_dummy() to allocate the net_device object at
> caam_qi_init().
> 
> The free of the device occurs at caam_qi_shutdown().
> 
> Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> PS: Unfortunately due to lack of hardware, this was not tested in real
> hardware.
> 
>  drivers/crypto/caam/qi.c | 43 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c

...

> @@ -530,6 +530,7 @@ static void caam_qi_shutdown(void *data)
>  
>  		if (kill_fq(qidev, per_cpu(pcpu_qipriv.rsp_fq, i)))
>  			dev_err(qidev, "Rsp FQ kill failed, cpu: %d\n", i);
> +		free_netdev(pcpu_qipriv.net_dev);

Hi Breno,

I don't think you can access pcpu_qipriv.net_dev like this,
as pcpu_qipriv is a per-cpu variable. Perhaps this?

	free_netdev(per_cpu(pcpu_qipriv.net_dev, i));

Flagged by Sparse.

>  	}
>  
>  	qman_delete_cgr_safe(&priv->cgr);

...

