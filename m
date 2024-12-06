Return-Path: <netdev+bounces-149728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890079E6F4F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C592873B0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFED207E13;
	Fri,  6 Dec 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhAlIXxw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4878207E19
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491807; cv=none; b=N/c/Vo7VR0pMgU2oZSPZx6QqdFKazG6iF4e3iWo2D/OrkPA1gC7GYlL87Vq7OK82Qw/1tMH0nXR1/2qIaNgdZf7RofOTkgw3eD9ouNeOcZArwkSqwcjCAlMwsFs26Cy3h20QbsIh28LYhEFAHe5F6vEiTp7fQ3Wz9K8iTR0hKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491807; c=relaxed/simple;
	bh=hSjn+Yo+zbCHri+Wt94Yceiwsk7Bbtsp1TsYWTdFm3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAJKRSK5cAcVaeJabRJuUjkxB5erDnrhV1AjJt8ciCDD7Kiw9AUKC43wfI65CkD13ynP9Yjqz7r2yc0qX3B8qXyglhdbygvYnhS15pNN45CHEUJJoAotmvfXJzk4meipjnHYXD1IPDWtcVuy1tTtWPwEe+EkwuPH1P6CuzHNHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhAlIXxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6329EC4CED1;
	Fri,  6 Dec 2024 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733491807;
	bh=hSjn+Yo+zbCHri+Wt94Yceiwsk7Bbtsp1TsYWTdFm3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhAlIXxwWNMU18OtfVKXk2rMjaaFmUmah/GrAgIBWbrYgwYOJtJcg7nf2fvMCnG3L
	 cCEhAw5sQ7g4Mwgjt9nT2HkMo/OBpaNmGKOLYDtLt/V4t4rg6LvDAEu/+Wr2t3/pGW
	 iw4XhiUyCEhUMGgX6ahD3WJ/pdsaUgk9QDc8x3Mx5K09m4kAvqnISM85AIhQtfBojT
	 KZmky/BkXwQ3UKEQkkY8KDUXMBt13qPfokh+UapdQAXj2eQQViQCHUhx93LkNyqqgl
	 x4gKmPsBV2cNu5zMRO5skr1EhGYGFfyH2g/wcP/giLG28tarBPPJ3ZUhHGbHtEsYRR
	 wQFgMVS1zkXUA==
Date: Fri, 6 Dec 2024 13:30:03 +0000
From: Simon Horman <horms@kernel.org>
To: Anton Nadezhdin <anton.nadezhdin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com, Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 1/5] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
Message-ID: <20241206133003.GQ2581@kernel.org>
References: <20241204180709.307607-1-anton.nadezhdin@intel.com>
 <20241204180709.307607-2-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180709.307607-2-anton.nadezhdin@intel.com>

On Wed, Dec 04, 2024 at 01:03:44PM -0500, Anton Nadezhdin wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_read_phy_tstamp_ll_e810 function repeatedly reads the PF_SB_ATQBAL
> register until the TS_LL_READ_TS bit is cleared. This is a perfect
> candidate for using rd32_poll_timeout. However, the default implementation
> uses a sleep-based wait.
> 
> Add a new rd32_poll_timeout_atomic macro which is based on the non-sleeping
> read_poll_timeout_atomic implementation. Use this to replace the loop
> reading in the ice_read_phy_tstamp_ll_e810 function.
> 
> This will also be used in the future when low latency PHY timer updates are
> supported.
> 
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_osdep.h  |  3 +++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 30 +++++++++------------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
>  3 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
> index b9f383494b3f..9bb343de80a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
> +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
> @@ -26,6 +26,9 @@
>  
>  #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
>  	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
> +#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
> +	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
> +				 a, addr)
>  
>  #define ice_flush(a)		rd32((a), GLGEN_STAT)
>  #define ICE_M(m, s)		((m ## U) << (s))
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index e55aeab0975c..b9cf8ce9644a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -4868,32 +4868,28 @@ static int
>  ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
>  {
>  	u32 val;
> -	u8 i;
> +	u8 err;
>  
>  	/* Write TS index to read to the PF register so the FW can read it */
>  	val = FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
>  	wr32(hw, PF_SB_ATQBAL, val);
>  
>  	/* Read the register repeatedly until the FW provides us the TS */
> -	for (i = TS_LL_READ_RETRIES; i > 0; i--) {
> -		val = rd32(hw, PF_SB_ATQBAL);
> -
> -		/* When the bit is cleared, the TS is ready in the register */
> -		if (!(FIELD_GET(TS_LL_READ_TS, val))) {
> -			/* High 8 bit value of the TS is on the bits 16:23 */
> -			*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
> +	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
> +				       !FIELD_GET(TS_LL_READ_TS, val),
> +				       10, TS_LL_READ_TIMEOUT);

Hi Jakob and Karol,

A minor nit from my side: rd32_poll_timeout_atomic may return a negative
error value but err is unsigned. This doesn't seem ideal.

Flagged by Smatch

> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
> +		return err;
> +	}
>  
> -			/* Read the low 32 bit value and set the TS valid bit */
> -			*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
> -			return 0;
> -		}
> +	/* High 8 bit value of the TS is on the bits 16:23 */
> +	*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
>  
> -		udelay(10);
> -	}
> +	/* Read the low 32 bit value and set the TS valid bit */
> +	*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
>  
> -	/* FW failed to provide the TS in time */
> -	ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
> -	return -EINVAL;
> +	return 0;
>  }
>  
>  /**

...

