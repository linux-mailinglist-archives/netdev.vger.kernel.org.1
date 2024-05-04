Return-Path: <netdev+bounces-93431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1388BBB54
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA078282B7A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3DE37700;
	Sat,  4 May 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BICRf05G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804423774
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825843; cv=none; b=p2xQnJDN4gAP9apMcKZEUGFCesxUb64tXCYMDHJXr7KMlykmzj7qUlXaz0iN24k78z+JA9Muy+rMKEl3Y+Pm9kIRGK6ud5MbYaoRFX8w4MeQLhlaCDLqoWbk2fQ41VsvlnBz0xgrJMX8xULJhgCUzCXnvLxnxzozU7qPWZssEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825843; c=relaxed/simple;
	bh=yXJDfP1PYI+TE5fhFbWEmCo7WTiYGdIBgmiOBzK1R/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG1wcSy91kO92+Bwphh1V6P/3WPN2/l+sh3ui6oSqY7+prrTh8JJ9NFlgl93n7VVmbY0p/nL/jYQIinHzB5MGZrRJAG/LUtrJY+uzhDQpky13MfXYGVZljhJPJZxQ/t6wddShvru53gsiuVMyWvE1P94nzg+DSRSy3ZiUfjcfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BICRf05G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660BAC4AF14;
	Sat,  4 May 2024 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714825842;
	bh=yXJDfP1PYI+TE5fhFbWEmCo7WTiYGdIBgmiOBzK1R/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BICRf05G4OUGTMqndIl9Q6SGFJsEk1oAi+F6ebMqsV+01aWX8j2SOEdry032oXKKx
	 gxioVOZDs9ewDFDVv0W7nEdxEjasN4y0ncT+k3ZExtoyxFm6UBhoWnuJFL2ogAgKin
	 B6e6CTgHQz8yLcpPtH1dbc3pJosjhTBbXoQnoMPMQ9bfgvPrqJ9SxF8J0DSmD7fMwk
	 DUr0YvO3r6k5pgirvbClpPW5GdNDWL4zMS6jFeWjapypAHZqHgvCrQ2UC1bTZj3xGb
	 U3d0VzbQ6hC68mHGEqh0cJdiL4ZX2AC/UIm5t7CwC1TM/GRs3farc+b9EfS630rxD0
	 LAi3YasSYN8dg==
Date: Sat, 4 May 2024 13:30:35 +0100
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
Subject: Re: [RFC PATCH net-next v2 5/9] bnxt: refactor
 bnxt_{alloc,free}_one_tpa_info()
Message-ID: <20240504123035.GH3167983@kernel.org>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-6-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502045410.3524155-6-dw@davidwei.uk>

On Wed, May 01, 2024 at 09:54:06PM -0700, David Wei wrote:
> Refactor the allocation of each rx ring's tpa_info in
> bnxt_alloc_tpa_info() out into a standalone function
> __bnxt_alloc_one_tpa_info().
> 
> In case of allocation failures during bnxt_alloc_tpa_info(), clean up
> in-place.
> 
> Change bnxt_free_tpa_info() to free a single rx ring passed in as a
> parameter. This makes bnxt_free_rx_rings() more symmetrical.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Hi David,

Some minor nits flagged by

./scripts/checkpatch.pl --codespell --max-line-length=80 --strict

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 95 +++++++++++++++--------
>  1 file changed, 62 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> +static int __bnxt_alloc_one_tpa_info(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
> +{

Please consider limiting Networking code to 80 columns wide where
it can be trivially achieved.

In this case, perhaps:

static int __bnxt_alloc_one_tpa_info(struct bnxt *bp,
				     struct bnxt_rx_ring_info *rxr)

> +	struct rx_agg_cmp *agg;
> +	int i, rc;
> +
> +	rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
> +				GFP_KERNEL);

The indentation here is not quite right.

	rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
			      GFP_KERNEL);

> +	if (!rxr->rx_tpa)
> +		return -ENOMEM;
> +
> +	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
> +		return 0;
> +
> +	for (i = 0; i < bp->max_tpa; i++) {
> +		agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
> +		if (!agg) {
> +			rc = -ENOMEM;
> +			goto err_free;
>  		}
> -		kfree(rxr->rx_tpa);
> -		rxr->rx_tpa = NULL;
> +		rxr->rx_tpa[i].agg_arr = agg;
> +	}
> +	rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
> +					GFP_KERNEL);
> +	if (!rxr->rx_tpa_idx_map) {
> +		rc = -ENOMEM;
> +		goto err_free;
>  	}
> +
> +	return 0;
> +
> +err_free:
> +	while(i--) {

Space before '(' here please.

> +		kfree(rxr->rx_tpa[i].agg_arr);
> +		rxr->rx_tpa[i].agg_arr = NULL;
> +	}
> +	kfree(rxr->rx_tpa);
> +	rxr->rx_tpa = NULL;
> +
> +	return rc;
>  }

...

