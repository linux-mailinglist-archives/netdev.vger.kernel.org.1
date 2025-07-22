Return-Path: <netdev+bounces-208972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF87B0DDB5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42FC7B5944
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3E2EBDD4;
	Tue, 22 Jul 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfih1Qj5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D712EBDCB;
	Tue, 22 Jul 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193673; cv=none; b=UwNKS/bv0+DXZHJA+Dl4D/t0jEgiFLHrbwoEUUBZGm4q7bNqG2vcSI9HJ7hxIP1gaouGAINs2jEqBt6vLrLgA3QJ/RM5ZmR1/7yy8OazJHsb3DozVrGz6KDprOGRNgZnEqJAvCPXCaFrOE72RP8B6vdnMWl3N8zxbJh4l6NEjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193673; c=relaxed/simple;
	bh=hzuiwjAJr375VSC/o2t+RI8D3combwUEbaFo9X2LmfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2U6tsFPTreKmwNF7sjoxRj41vlIa9Esf7jqXBf1/67FkR3Ypt/pJnYTBZ763cUBqZgS3LcSp73tMzMx3AToqO+41NGCJrL8dEMkCHaWcjxxG7NNoCxFx/wAd3894JI+JQzCCEF8/NfjIs4OHhzTK2Z/BT1AZEcOY7OVbNf0Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfih1Qj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C99C4CEEB;
	Tue, 22 Jul 2025 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753193672;
	bh=hzuiwjAJr375VSC/o2t+RI8D3combwUEbaFo9X2LmfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wfih1Qj5v4wHeXDEOnOj3fHFeMho/5AsJN2GRWOO+wPf18r68eL71w0NRb3IuM5NG
	 1HijnDHoiQ3ajejJUNirOs2XSLTbxHjxY+pQGaoLvfjM85PVf1KaSCaqT6YYq1VMuN
	 2Yp7cnTxtJFSPcDiJc0HRltN+W+6cBxyuGsHH0h4zG95XjbYTiD0dblzaC4ffVIh3I
	 +cV5k8DAbe+od+qhDyRurdXIE9zNvVDtnlNMkecvi6Jj66PxXmz6LYm+Vn4EEyxfNG
	 vwZCLKLelzv2QUT10vsGLhNsN7JGnWlWAkqWNumP3y3vXxsCoN066yluUoRqPsxUc0
	 IoWGQTZGe+niQ==
Date: Tue, 22 Jul 2025 15:14:26 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] net: rnpgbe: Add base rx function
Message-ID: <20250722141426.GK2459@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-15-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-15-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:37PM +0800, Dong Yibo wrote:
> Initialize rx clean function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

...

> @@ -299,12 +707,27 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
>  	struct mucse_q_vector *q_vector =
>  		container_of(napi, struct mucse_q_vector, napi);
>  	struct mucse *mucse = q_vector->mucse;
> +	int per_ring_budget, work_done = 0;
>  	bool clean_complete = true;
>  	struct mucse_ring *ring;
> -	int work_done = 0;
> +	int cleaned_total = 0;

cleaned_total is set but otherwise unused in this function.

Flagged by Clang 20.1.8 builds with KCFLAGS=-Wunused-but-set-variable.

>  
>  	mucse_for_each_ring(ring, q_vector->tx)
>  		clean_complete = rnpgbe_clean_tx_irq(q_vector, ring, budget);
> +	if (q_vector->rx.count > 1)
> +		per_ring_budget = max(budget / q_vector->rx.count, 1);
> +	else
> +		per_ring_budget = budget;
> +
> +	mucse_for_each_ring(ring, q_vector->rx) {
> +		int cleaned = 0;
> +
> +		cleaned = rnpgbe_clean_rx_irq(q_vector, ring, per_ring_budget);
> +		work_done += cleaned;
> +		cleaned_total += cleaned;
> +		if (cleaned >= per_ring_budget)
> +			clean_complete = false;
> +	}
>  
>  	if (!netif_running(mucse->netdev))
>  		clean_complete = true;

...

> @@ -871,6 +1323,8 @@ static int rnpgbe_setup_rx_resources(struct mucse_ring *rx_ring,
>  	memset(rx_ring->desc, 0, rx_ring->size);
>  	rx_ring->next_to_clean = 0;
>  	rx_ring->next_to_use = 0;
> +	if (mucse_alloc_page_pool(rx_ring)

There is a trailing ')' missing from the line above.

> +		goto err;
>  
>  	return 0;
>  err:

...

