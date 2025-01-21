Return-Path: <netdev+bounces-159896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB79A17557
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4047169D02
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92914F90;
	Tue, 21 Jan 2025 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdB95HXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587158BFF
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737421169; cv=none; b=IhE9yQr99VvFFhRLCtCm6TErwq4yV+t1hWo4BK4pxMVM8vwWDYYZb/d1/UIEeAGAiK5+tcW9uoeTVBpVF7LCCtBSsfxuzLX15I5hN3NOnm5/9ksS+nQKp5g8S9Q0CnKkNQEZfrlWxrX2Q+12w4k/fGMGjzorfxRBk3XQFDFRVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737421169; c=relaxed/simple;
	bh=fHXdg3iX4bq6wqIRVxcNQ1V8bivng2odeQZXh0DSpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwDzfJ3f/4QB0LbLYpj7GIF9TiN7HxWyY/tihT3726OLPdcEatf4NJ8Beg5oGAhQB/j32l7ahuZJWcHst5SzmmJqrM6HxHCzFrqiL7exSp97b361N0u7Sca1bqfup+7ZfG3sg1nqWUhHb+wD2aTEOs4L2jemVe5jIzZZylpVl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdB95HXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC4C4CEDD;
	Tue, 21 Jan 2025 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737421168;
	bh=fHXdg3iX4bq6wqIRVxcNQ1V8bivng2odeQZXh0DSpVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NdB95HXAxJ/Dxh74nUQrsFABf0K//3z4v/pG1ulbPWEEihXMYacST1+ukIOVUF7UU
	 SL9UMDUliXCbp2/bnZyhsh6j0wphlcHlKebtbMYuiSrwwM2IUmNRsm3Zqwy/LsjnzH
	 A1nUtmDKR29FbMJQJ8kLkCCBTQQi3Kw6hIbCACoErP+RWbgdTospFOQit31enjSpfx
	 BN43XSmKwT1Gl/bT1DGl7T+f0GVuyjSYsr0zWipimYlSXRRZvU4WW0CaML0rOgJ8tH
	 lSODmCaaZLyQJxYiPKS3N+gyzPte7jSu1c7IFIzjZ4eJPCjtTvF/qL+H554x/b5IKz
	 bEha5FZSyOztg==
Date: Mon, 20 Jan 2025 16:59:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com, David Arinzon <darinzon@amazon.com>
Subject: Re: [PATCH net-next v6 1/5] net: move ARFS rmap management to core
Message-ID: <20250120165927.45ef723b@kernel.org>
In-Reply-To: <20250118003335.155379-2-ahmed.zaki@intel.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
	<20250118003335.155379-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 17:33:31 -0700 Ahmed Zaki wrote:
> +#ifdef CONFIG_RFS_ACCEL
> +static void
> +netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
> +			  const cpumask_t *mask)
> +{
> +	struct napi_struct *napi =
> +		container_of(notify, struct napi_struct, notify);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int err;
> +
> +	if (napi->dev->rx_cpu_rmap_auto) {

Can this ever not be true?

> +		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
> +		if (err)
> +			pr_warn("%s: RMAP update failed (%d)\n",
> +				__func__, err);

netdev_warn(napi->dev, "...) ?

> +	}
> +}
> +
> +static void netif_napi_affinity_release(struct kref *ref)
> +{
> +	struct napi_struct *napi =
> +		container_of(ref, struct napi_struct, notify.kref);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +
> +	if (!napi->dev->rx_cpu_rmap_auto)

Similar question, can it possibly be false without driver bugs?
I think you disable rmap completely if we can't add a single IRQ,
that may be too drastic. Better miss one IRQ than the whole rmap, no?

> +		return;
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;

Why do we modify NAPI here? Shouldn't caller be responsible for this?

> +	cpu_rmap_put(rmap);
> +}
> +
> +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> +{
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int rc;
> +
> +	if (!rmap)

Should never happen, I'd ignore this and let the kernel crash below.

> +		return -EINVAL;
> +
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
> +	napi->napi_rmap_idx = -1;
> +err_add:
> +	cpu_rmap_put(rmap);
> +	return rc;
> +}

