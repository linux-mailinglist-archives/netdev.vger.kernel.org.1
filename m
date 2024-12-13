Return-Path: <netdev+bounces-151792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C63F9F0E2A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDA9188045C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20DD1E04B3;
	Fri, 13 Dec 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+z1AV5m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FF1E0487;
	Fri, 13 Dec 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098302; cv=none; b=fXEltJU51f7vjfxFMq+uGB66F87n/2+9VG1UyNgyTWe+OPb1tnM3nWwR3TvpRamss99GXoNo84iagnotlUSe7ycD4y2CeE0jZKR76pC7fGJt5UCIGXFelbE2H1QwjUyVOHyTfbRn0DWcb73eO4Trxx6ldcyPQpjym/JhVxsFEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098302; c=relaxed/simple;
	bh=ZsRyVA73HFtwT3ge1nfoMMlMTV+JQGwl5qrL9G5GfZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SufS4JECPNU+DXoPOD/ngxr0dOVfU61XcUCRUuxSAFZ4nZbFS7l89+OmGkzDiz4+OrI7eTUCEQRHqPoIIma15c4Jy2//xYFbpJQC4olRD81iFBhpwOj3IV1a3FPv5Zulwep+h4NcuNg0b3JRjfRJQmFiijs0EFXqhJTnQrgxJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+z1AV5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724CFC4CED0;
	Fri, 13 Dec 2024 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734098302;
	bh=ZsRyVA73HFtwT3ge1nfoMMlMTV+JQGwl5qrL9G5GfZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+z1AV5msD8rGWqVXJycPT7c07RUiX10NqhQGdARQsGYkzCOl0uSwo+aJVS118w4i
	 H2IrmSA1F7mxVAHrP7ovJJOYKKksMcPYOLV5hj+Vceo9QgNDWKako6LWsqkjrT3NBz
	 NylOHh6iEF7RAW60NX4Nqjfl4XjeTGkvsGInZ1UObwrg7YAQyJCIfKkv+XZcj0xER/
	 OBR+bvxz1xupBa2ZNljdU2DqzOyKrYnHcM2G+XZJpp8+E3KKoShM+zmzNxYcTM4vGm
	 bcU/uwsi6a8zYWFQ+tCREF6N58K6JCmcfcAHLGmjB1frZ1pDB5FE24N+/rI7TcBBvb
	 C2sd1QVY+xfZQ==
Date: Fri, 13 Dec 2024 13:58:18 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenz Brun <lorenz@brun.one>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manuel Ullmann <labre@posteo.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: keep rings across suspend/resume
Message-ID: <20241213135818.GC561418@kernel.org>
References: <20241212023946.3979643-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212023946.3979643-1-lorenz@brun.one>

On Thu, Dec 12, 2024 at 03:39:24AM +0100, Lorenz Brun wrote:
> The rings are order-6 allocations which tend to fail on suspend due to
> fragmentation. As memory is kept during suspend/resume, we don't need to
> reallocate them.
> 
> This does not touch the PTP rings which, if enabled, still reallocate.
> Fixing these is harder as the whole structure is reinitialized.
> 
> Fixes: cbe6c3a8f8f4 ("net: atlantic: invert deep par in pm functions, preventing null derefs")
> Signed-off-by: Lorenz Brun <lorenz@brun.one>

...

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> index 9769ab4f9bef..3b51d6ee0812 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -132,6 +132,16 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
>  	unsigned int i = 0U;
>  	int err = 0;
>  
> +	if (self && self->tx_rings == aq_nic_cfg->tcs && self->rx_rings == aq_nic_cfg->tcs) {
> +		/* Correct rings already allocated, nothing to do here */
> +		return 0;
> +	} else if (self && (self->tx_rings > 0 || self->rx_rings > 0)) {
> +		/* Allocated rings are different, free rings and reallocate */
> +		pr_notice("%s: cannot reuse rings, have %d, need %d, reallocating", __func__,
> +			  self->tx_rings, aq_nic_cfg->tcs);
> +		aq_vec_ring_free(self);
> +	}
> +

Hi Lorenzo,

Can self be NULL here?

In the for loop below it is dereferenced unconditionally and
thus assumed not to be NULL there.

Flagged by Smatch.

>  	for (i = 0; i < aq_nic_cfg->tcs; ++i) {
>  		const unsigned int idx_ring = AQ_NIC_CFG_TCVEC2RING(aq_nic_cfg,
>  								    i, idx);
> -- 
> 2.44.1
> 
> 

