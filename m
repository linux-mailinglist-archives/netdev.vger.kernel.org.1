Return-Path: <netdev+bounces-93432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCE8BBB63
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3B71C20BDB
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0921CD3F;
	Sat,  4 May 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU/y66aa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BE17C66
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826078; cv=none; b=eg71mpWEIAqmaLVFsFfY72SS0hlwq+9nuo/W4RLTpIJP8b8FWPxZk9OPNd67Sg9/cZmpZpThISQDHjC9Hu40cQyYP8/IEC4BoJWi76EZXMNpwpKYkYzy1jxoFZrDX1zE/aqhFfQCnCl6tUtKRVINAJVN5RSNNR21LCK413yx09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826078; c=relaxed/simple;
	bh=DHfMOjvQ1N3ZihKoa5hyI3psRu3FDg+jldsEdrSZkOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF85igo9yPIdCuTXa7n2AmSVuRLrhEclPaO2K6+Kmd28XNJPvHlKF8huLXxA3dJk1V79FRWTjW9QpocgJoLVcP0MwV5PCA7KyUFRPe98HXNiTJZpr+GICdlYIhaIpcQobEte6yefoCaaoaMg+iuUsucLw1Bu6hvS1f22FrMQWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU/y66aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09245C072AA;
	Sat,  4 May 2024 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714826078;
	bh=DHfMOjvQ1N3ZihKoa5hyI3psRu3FDg+jldsEdrSZkOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EU/y66aawxD0re72QsWqLM3lYsq3emt9/L0w/Ab2mfQ2PKMBcGqrrTRY4vYGGoObE
	 VGtL/xoB6f8V0acAnKQcCHYsULu7gfX106DjyXb1/T7ymqKu1y3hXWWWR7alRYslta
	 5JP+9DQBeZepHoDcOgrlbnoTyIu0bQipLOj7p1V1wQne5dR0ldxR7mvlkUcRfwPy7t
	 6kJBaSFWcDk5q14OZPhQuSE7bjFnGTk0BMRQDWSRMZJVruYIlAlSASB+CyWjevKFCK
	 uKNNztaLZqyFVZjn97jD+NYltErRXf+q+dJd2rNAELnNRIDjweVldUK0fQqiTlFoOB
	 Y9zYisy6bk0EA==
Date: Sat, 4 May 2024 13:34:32 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next v2 7/9] bnxt: add helpers for allocating rx
 ring mem
Message-ID: <20240504123432.GI3167983@kernel.org>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-8-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502045410.3524155-8-dw@davidwei.uk>

On Wed, May 01, 2024 at 09:54:08PM -0700, David Wei wrote:
> Add several helper functions for allocating rx ring memory. These are
> mostly taken from existing functions, but with unnecessary bits stripped
> out such that only allocations are done.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 87 +++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index b0a8d14b7319..21c1a7cb70ab 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14845,6 +14845,93 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
>  	.get_base_stats		= bnxt_get_base_stats,
>  };
>  
> +static int __bnxt_alloc_rx_desc_ring(struct pci_dev *pdev, struct bnxt_ring_mem_info *rmem)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < rmem->nr_pages; i++) {
> +		rmem->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
> +						     rmem->page_size,
> +						     &rmem->dma_arr[i],
> +						     GFP_KERNEL);
> +		if (!rmem->pg_arr[i]) {
> +			rc = -ENOMEM;
> +			goto err_free;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	while (i--) {
> +		dma_free_coherent(&pdev->dev, rmem->page_size,
> +				  rmem->pg_arr[i], rmem->dma_arr[i]);
> +		rmem->pg_arr[i] = NULL;
> +	}
> +	return rc;
> +}
> +
> +static int bnxt_alloc_rx_ring_struct(struct bnxt *bp, struct bnxt_ring_struct *ring)

Hi David,

W=1 builds fail because this and other functions introduced by
this patch are unused. I agree that it is nice to split up changes
into discrete patches. But in this case the change isn't really discrete.
So perhaps it is best to add helper functions in the same patch
where they are first used.

