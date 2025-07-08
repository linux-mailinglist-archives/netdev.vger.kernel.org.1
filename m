Return-Path: <netdev+bounces-205106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64715AFD685
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1D856109F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB321D018;
	Tue,  8 Jul 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqmk7XTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A018A6AE;
	Tue,  8 Jul 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999785; cv=none; b=taUymvq1+nQk+jkFmxqgy+OpIigSPZWOiMDrCjOkPfcT7xrHV/i9zrSTH/+8W3Q0r4MKjBQ1jurLffycaf4ncBD8Vw8fSzSg6QaPngucUkE4OeHlgwDr9EEv1hp8e9ipB4VyH3aF3FOSzKznkFzaRFPf7YNRfRbDxXTuuR2jjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999785; c=relaxed/simple;
	bh=+wDb55masaQIrXES/8KNFPSYi1OWO4Ce1wHyf8x2E3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9I9xPg2vp/kHKVG1PRAzdfxuHgPX3cHsunqabGqFecXhZaTcGYbzUsTC8D8VAJ1W2lHeGVkwdsXQEcepMHSKCCexQpP3CxrrhbIFKc2q/clm4pug7lSl7NbePaJgZOCB/PKWpOSArb8QcH/MPqs2SAmOA/OVLtP6IVEud+RHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqmk7XTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596DAC4CEED;
	Tue,  8 Jul 2025 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751999785;
	bh=+wDb55masaQIrXES/8KNFPSYi1OWO4Ce1wHyf8x2E3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xqmk7XTCw1qNIQ2m/Hqs9+1DvdsIJ4F/i75HixRU7hFnqttwm4nuZQsAeEhygK6cV
	 XP+fCojM3Hs024mlSotVfbp5cbSZVTg+WYQ99s+F3Mi0eSQHHBPmUc60I088hGissc
	 DvzjpoZl8QA99MtF3sUrdD/uhhGPNC2xomBd7JlJon9V20bqc65dy48bd/lDlroEBL
	 HOTwtkBEyOAtOHxeL8PsU9m1FfUxMr5ztBs/qI8EHMZ+NBsjjLq5ruzTEpwDbEUVAG
	 hFv/sU65r4BfXuJKFDnWkrFYe7DCHSj+Gjcx3KOdpRwncCbSCdzeTOxTQ8hS2I5nNW
	 ynxBQTkFTeKlQ==
Date: Tue, 8 Jul 2025 19:36:20 +0100
From: Simon Horman <horms@kernel.org>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	m-malladi@ti.com, pratheesh@ti.com, prajith@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Message-ID: <20250708183620.GV452973@horms.kernel.org>
References: <20250708103516.1268876-1-h-mittal1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708103516.1268876-1-h-mittal1@ti.com>

On Tue, Jul 08, 2025 at 04:05:16PM +0530, Himanshu Mittal wrote:
> Fixes overlapping buffer allocation for ICSSG peripheral
> used for storing packets to be received/transmitted.
> There are 3 buffers:
> 1. Buffer for Locally Injected Packets
> 2. Buffer for Forwarding Packets
> 3. Buffer for Host Egress Packets
> 
> In existing allocation buffers for 2. and 3. are overlapping
> causing packet corruption.

Hi Himanshu,

I think it would be useful to describe the old layoyt, or otherwise
how the overlap occurs. And contrast that with the new layout.

There was a minimal ASCII diagram of in prueth_emac_buffer_setup().
Perhaps expanding (on) that would be useful.

> 
> Packet corruption observations:
> During tcp iperf testing, due to overlapping buffers the received ack packet
> overwrites the packet to be transmitted. So, we see packets on wire with the
> ack packet content inside the content of next TCP packet from sender device.
> 
> Fixes: abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c

...

> @@ -297,43 +301,60 @@ static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)

...

> +	/* Configure buffer pools for Local Injection buffers
> +	 *  - used by firmware to store packets received from host core
> +	 *  - 16 total pools per slice
> +	 */
> +	for (i = 0; i < PRUETH_NUM_LI_BUF_POOLS_PER_SLICE; i++) {
> +		/* The driver only uses first 4 queues per PRU so only initialize buffer for them */

> +		if ((i % PRUETH_NUM_LI_BUF_POOLS_PER_PORT_PER_SLICE)
> +			 < PRUETH_SW_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE) {
> +			writel(addr, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].addr);
> +			writel(PRUETH_SW_LI_BUF_POOL_SIZE,
> +			       &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].len);
> +			addr += PRUETH_SW_LI_BUF_POOL_SIZE;
>  		} else {
> -			writel(0, &bpool_cfg[i].addr);
> -			writel(0, &bpool_cfg[i].len);
> +			writel(0, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].addr);
> +			writel(0, &bpool_cfg[i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE].len);
>  		}
>  	}

It is still preferred for Networking code to be 80 columns wide of less
unless it affects readability. checkpatch.pl has an option to tell you
about this. And I think that it would be good to apply that guideline
throughout this patch.

E.g. for the for loop above, something like this (completely untested):

	for (i = 0; i < PRUETH_NUM_LI_BUF_POOLS_PER_SLICE; i++) {
		int cfg_idx = i + PRUETH_NUM_FWD_BUF_POOLS_PER_SLICE;

		/* The driver only uses first 4 queues per PRU so only
		 * initialize buffer for them */
		if ((i % PRUETH_NUM_LI_BUF_POOLS_PER_PORT_PER_SLICE)
			 < PRUETH_SW_USED_LI_BUF_POOLS_PER_PORT_PER_SLICE) {
			writel(addr, &bpool_cfg[cfg_idx].addr);
			writel(PRUETH_SW_LI_BUF_POOL_SIZE,
			       &bpool_cfg[cfg_idx].len);
			addr += PRUETH_SW_LI_BUF_POOL_SIZE;
		} else {
			writel(0, &bpool_cfg[cfg_idx].addr);
			writel(0, &bpool_cfg[cfg_idx].len);
		}
	}

...

> @@ -347,13 +368,13 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)

It's probably out of scope for this patch, being a bug fix.
But it seems to me that there is significant commonality
between prueth_fw_offload_buffer_setup() and prueth_emac_buffer_setup().
It would be nice to consolidate the implementation somehow,
say in a follow-up for net-next.

...

-- 
pw-bot: changes-requested

