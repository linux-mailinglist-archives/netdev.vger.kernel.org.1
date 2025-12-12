Return-Path: <netdev+bounces-244509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88981CB93A1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087B6303FE66
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C723B609;
	Fri, 12 Dec 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8wGMSzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4144C8F;
	Fri, 12 Dec 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555647; cv=none; b=tZlby216ieqcPAfWa4NKQyppPChBm9eNdh7x8Nros4DYIR2X6OZ1Ksz9bFETdIIj5w1P3QHW65haBspYyc50uHD9nLyrZFX1XOBuEIpGjJYCi6Q4BTwihvquDvIEIDcmcXuuR/dbf+JTvJMQQXjuWFhWe49Y/wN9R5CoI+nQNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555647; c=relaxed/simple;
	bh=MKQzlstlg1IG9jT2vvHFof/BP3rK+NlYQDP9+HgmlMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAKH6wFtyx3wdEOdfDIN9QZ1Y89sFVDZlrGRCHBIby8wCf+/kjZmolZSptWqAPmv0p5b0kNFTloLZFhxOjRElGJ9SpZRXme40bOKNitTEVCDWahlXNA2kjJUYWTNHspGAgu8HglfOuNkZb0oubr/eISdnqMsc4U4IRZsurcVIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8wGMSzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD63C4CEF1;
	Fri, 12 Dec 2025 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765555647;
	bh=MKQzlstlg1IG9jT2vvHFof/BP3rK+NlYQDP9+HgmlMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8wGMSzPahxtNs76VBRkZMG5ec+PS3tl/jL1D3q58AHFKt4nz7yuJR4Q65K9rbj/o
	 5+l23R6kS+bagDxMaHNDDHhjcOw6FjjMAkXn281hGO9XNvjet3Wy2wMHRrRsGZcjCe
	 cTHIgaH5WUw7xH45g3BLD6igB3AEg24IUl/AuhuTDH99A4/5zQkA9lAne51xfXYPb5
	 2gjlW3LiAQAHPd6zIord91qR1079b4LeeaYo6DoWdQCHskWuWb4xhkyjxXNjr1uvWW
	 UGAx3qm/nHph1mEun9fCy3Vn6FWJaQ7XI2foXdpi8LDIM0pvIYn39kr7BWw6gQ3Lyn
	 SihtzhrBru5mA==
Date: Fri, 12 Dec 2025 16:07:22 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 2/3] octeon_ep: ensure dbell BADDR updation
Message-ID: <aTw9uutDeFnKDX1d@horms.kernel.org>
References: <20251212122304.2562229-1-vimleshk@marvell.com>
 <20251212122304.2562229-3-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212122304.2562229-3-vimleshk@marvell.com>

On Fri, Dec 12, 2025 at 12:23:01PM +0000, Vimlesh Kumar wrote:
> Make sure the OUT DBELL base address reflects the
> latest values written to it.
> 
> Fix:
> Add a wait until the OUT DBELL base address register
> is updated with the DMA ring descriptor address,
> and modify the setup_oq function to properly
> handle failures.
> 
> Fixes: 0807dc76f3bf5("octeon_ep: support Octeon CN10K devices")

Hi Vimlesh,

Thanks for your patch.

Some feedback from my side.
First, there is a space missing in the Fixes tag:

Fixes: 0807dc76f3bf ("octeon_ep: support Octeon CN10K devices")

> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>

...

>  /* Setup registers for a PF mailbox */
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c

...

> @@ -343,6 +344,23 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
>  			reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
>  		} while (!(reg_val & CNXK_R_OUT_CTL_IDLE));
>  	}
> +	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no),  oq->max_count);
> +	/* Wait for WMARK to get applied */
> +	usleep_range(10, 15);
> +
> +	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);

Please line-wrap Networking code to 80 columns wide or less where it can
be done without reducing readability (which is the case here).

checkpatch.pl --max-line-length=80 should flag this.

> +	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
> +	reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
> +	if (reg_ba_val != oq->desc_ring_dma) {
> +		do {
> +			if (reg_ba_val == UINT64_MAX)

I think that ULLONG_MAX here, rather than defining UINT64_MAX
elsewhere in this patch.

It might be better if the Kernel provided UINT64_MAX and friends.
But it doesn't. (And I'm sure there are many opinions on why.)

> +				return -1;

This should be a standard error code.
Perhaps -EFAULT?

> +			octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
> +					  oq->desc_ring_dma);
> +			octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
> +			reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
> +		} while (reg_ba_val != oq->desc_ring_dma);

I am concerned that this loop is unbounded.
Could some limit be placed on it?

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> index 81ac4267811c..76622cdf577d 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> @@ -55,6 +55,10 @@
>  				  (iq_)->max_count - IQ_INSTR_PENDING(iq_); \
>  				})
>  
> +#ifndef UINT64_MAX
> +#define UINT64_MAX ((u64)(~((u64)0)))        /* 0xFFFFFFFFFFFFFFFF */
> +#endif
> +
>  /* PCI address space mapping information.
>   * Each of the 3 address spaces given by BAR0, BAR2 and BAR4 of
>   * Octeon gets mapped to different physical address spaces in

...

-- 
pw-bot: cr

