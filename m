Return-Path: <netdev+bounces-157138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A7A08FCE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F9916A2E7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AD20B7E0;
	Fri, 10 Jan 2025 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6EKDKf5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342220ADFF
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510154; cv=none; b=UyHHw/FEoExDKbFDr3+mYemijA4mzznvYVDfdktNuIC/KyFiwdIe/SqfxdufLgHHoirDbrghUvlxad4qUTnVKnkFPRfBAV9tHQd6zjR8IEM5KGPW4rAKS7QmItv2aN3x/mdiNp0W2BfTpjOVIGsQbyIW8nh282W/M++NiChWxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510154; c=relaxed/simple;
	bh=Fsfxz2Yqi9F5DV6PEsxBP8dlNuNGhbGhsOkKNA8EEb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJHupuvkOlpay7rfItYHjs6DVTvykW3un6yPDBLrCqPKURQLZ9BJdYyjOsxU1kw5flJ4myi0S4FJvgbeGk2+dd6soXOiWPYjEsc10R9CwRXfB5a72GdrpHxGsBbPKVtB6XrF+jq2Xpwh79vvM9iexR1+nnmA8dl+MROIkPxo8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6EKDKf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ACCC4CED6;
	Fri, 10 Jan 2025 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736510153;
	bh=Fsfxz2Yqi9F5DV6PEsxBP8dlNuNGhbGhsOkKNA8EEb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6EKDKf5/bJffVT0v2JPBVVBPjpF8/VDbkvWMu39fxOdLEWKgjDirUPqpe5c6Bepb
	 LdnxgStqEtxN3zgATBQX6ss5QF7GSSr8OgbbP5SB3VyZQ8riD1+6BjDyvNo91bhMDI
	 /7T9JyaXXllefxVicPxFfoqPewpx5Bb+kcT6L6Kt2PIRyfUhEvQm2Wkj4+u9Mbm2wp
	 zWQkCr7T8Qx5TZ7eZ7rdL4+W17T8qfkEQwV1+70neNPdZ9F8ekZf1esO8lZVeZx59T
	 rE012vXJGapv89/MmgSSnJCkl+Dx5kGLXyWvjTvXDyWn+K/SCYBRrxZ7ancYXhPwwq
	 yM8yj5v7U5G6A==
Date: Fri, 10 Jan 2025 11:55:48 +0000
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v4 2/6] net: napi: add internal ARFS rmap
 management
Message-ID: <20250110115548.GB7706@kernel.org>
References: <20250109233107.17519-1-ahmed.zaki@intel.com>
 <20250109233107.17519-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109233107.17519-3-ahmed.zaki@intel.com>

On Thu, Jan 09, 2025 at 04:31:03PM -0700, Ahmed Zaki wrote:
> For drivers using the netif_enable_cpu_rmap(), move the IRQ rmap notifier
> inside the napi_struct.
> 
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/net/core/dev.c b/net/core/dev.c

...

> +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> +{
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int rc;
> +
> +	if (!napi || !rmap)
> +		return -EINVAL;

Hi Ahmed,

Here it is assumed that napi may be NULL.  But it is dereferenced
unconditionally on the first like of this function.

Flagged by Smatch.

> +	napi->notify.notify = netif_irq_cpu_rmap_notify;
> +	napi->notify.release = netif_napi_affinity_release;
> +	cpu_rmap_get(rmap);
> +	rc = cpu_rmap_add(rmap, napi);
> +	if (rc < 0)
> +		goto err_add;
> +
> +	napi->napi_rmap_idx = rc;
> +	rc = irq_set_affinity_notifier(irq, &napi->notify);
> +	if (rc)
> +		goto err_set;
> +
> +	return 0;
> +
> +err_set:
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +err_add:
> +	cpu_rmap_put(rmap);
> +	return rc;
> +}
>  #endif
>  
>  void netif_napi_set_irq(struct napi_struct *napi, int irq)

...

-- 
pw-bot: changes-requested

