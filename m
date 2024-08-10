Return-Path: <netdev+bounces-117391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CD394DB64
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170271F22045
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC8114AD03;
	Sat, 10 Aug 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk80tMFd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEC83CA1
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277935; cv=none; b=tGzBa7rKxeKYUOsqp9Zi74pd6HYRpFuAml9PbzkRs/JpV9X0Ag4478IIMccns+ao2rQDotDXrAAQiUlJ3UeQ1bcuIAA3B5+2EB9A++i6QplkLP7fzQJGdw0N1hzeKbqhPGSzlDj12f5Q/0q8OzMHefrzSk32xkAqanMzZAQOoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277935; c=relaxed/simple;
	bh=ulVYvznxTRZMqqILWZs03OP5L+uvnM9aJD2LtFQDyuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea/KFRs6p6gnLLS31vu2B6z0uroilZX4ZUZ7Vrmat+2B+mr3tttiDIEMxVtPJezLRRJAHqSWZSjDbqKOk1TvIg+E4IgNu99HxSYGRawD3kc9YVcC5/jXAQQ/Dm2RraJx14r56Kj3kq1cT7Ya4Djytcf1ZNPEINFE9vhTI4Ih+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk80tMFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2288EC32781;
	Sat, 10 Aug 2024 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723277935;
	bh=ulVYvznxTRZMqqILWZs03OP5L+uvnM9aJD2LtFQDyuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sk80tMFdm9VLZR8AO2ikkMzgGUchySmfw28rQqPj3yrmog6HZ6ETQGV57BtKa74zl
	 FmkrV6D1dZcb1GAuMac/vLbm1V8vJoCEZfOjuV3IpJIHNolq4XmaOci+ig0vP8XbHB
	 qHvqDmutQ/iOUC5OUk6C+NvL+XBF+pSm2nV8582r7BYsKIAv285s9S1Bdt2hBdQlFV
	 wqVMUoe7VPwX5e1g5qBvmiGFHSMKk7tDuwTrVUvT+hFKo0sDuXo5PAdPC6DReh9TZF
	 Tp82wK1H+YNLnUgimhLaKbg7BLQG7xjRWPrcP+4zr7XqJJMcsPv3SM1VdbSboylFpF
	 r4NMkcyFfZRjw==
Date: Sat, 10 Aug 2024 09:18:51 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v5 iwl-next 2/6] ice: Use FIELD_PREP for timestamp values
Message-ID: <20240810081851.GE1951@kernel.org>
References: <20240808125825.560093-8-karol.kolacinski@intel.com>
 <20240808125825.560093-10-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808125825.560093-10-karol.kolacinski@intel.com>

On Thu, Aug 08, 2024 at 02:57:44PM +0200, Karol Kolacinski wrote:
> Instead of using shifts and casts, use FIELD_PREP after reading 40b
> timestamp values.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  6 ++++--
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 +++++--------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 00c6483dbffc..d1b87838986d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1520,7 +1520,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>  	 * lower 8 bits in the low register, and the upper 32 bits in the high
>  	 * register.
>  	 */
> -	*tstamp = ((u64)hi) << TS_PHY_HIGH_S | ((u64)lo & TS_PHY_LOW_M);
> +	*tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
> +		  FIELD_PREP(PHY_40B_LOW_M, lo);
>  
>  	return 0;
>  }
> @@ -4952,7 +4953,8 @@ ice_read_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
>  	/* For E810 devices, the timestamp is reported with the lower 32 bits
>  	 * in the low register, and the upper 8 bits in the high register.
>  	 */
> -	*tstamp = ((u64)hi) << TS_HIGH_S | ((u64)lo & TS_LOW_M);
> +	*tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
> +		  FIELD_PREP(PHY_EXT_40B_LOW_M, lo);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 8a28155b206f..df94230d820f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -673,15 +673,12 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
>  /* Source timer incval macros */
>  #define INCVAL_HIGH_M			0xFF
>  
> -/* Timestamp block macros */
> +/* PHY 40b registers macros */
> +#define PHY_EXT_40B_LOW_M		GENMASK(31, 0)
> +#define PHY_EXT_40B_HIGH_M		GENMASK_ULL(39, 32)
> +#define PHY_40B_LOW_M			GENMASK(7, 0)
> +#define PHY_40B_HIGH_M			GENMASK_ULL(39, 8)
>  #define TS_VALID			BIT(0)
> -#define TS_LOW_M			0xFFFFFFFF
> -#define TS_HIGH_M			0xFF
> -#define TS_HIGH_S			32
> -
> -#define TS_PHY_LOW_M			0xFF
> -#define TS_PHY_HIGH_M			0xFFFFFFFF

I think it it would be best to defer removing (at least)
TS_PHY_LOW_M and TS_PHY_HIGH_M until the following patch,
as they are still in use until then.

As is, this patch results in build failures.

> -#define TS_PHY_HIGH_S			8
>  
>  #define BYTES_PER_IDX_ADDR_L_U		8
>  #define BYTES_PER_IDX_ADDR_L		4
> -- 
> 2.45.2
> 
> 

