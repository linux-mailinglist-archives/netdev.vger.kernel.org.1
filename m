Return-Path: <netdev+bounces-110414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD192C40D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02837B21B4F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B417B05A;
	Tue,  9 Jul 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQWOkfXV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FE146D74
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554451; cv=none; b=A1udenRQebnDHB3/W4p29d/YI6Vu7JmmkV1tcitIbnroQZt84csjwWJe0aVLkqImEed3FYJ4NjdB6t7pCk9y+pR9pl5dca0do/BN2fhme3Zf1j1heT67Og9drLz0rEXcQpWI/U3PFTOoai+jWHHvmWSHq1KhI19O8Qkh950RJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554451; c=relaxed/simple;
	bh=usPhssK9WjfWwgT5IfGwxoiTPx1hEMjLfWUX3AgQ3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwq/+iPFRGs4awU/ObVEoXKjRXmpDxoxXtNRF2qAcsWiuyEsQAzoDHVTuWoONDMrI6Rue2UB1bdYbVHXOtZMKSiYmYdvFSasuuNQ3IPEdbJKdXDDVbGCNEaDy2D7hFdkEPpFyIffzEo6Kx5eCccVwGAIk0G3ltnhurYQnbQWxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQWOkfXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91181C3277B;
	Tue,  9 Jul 2024 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720554451;
	bh=usPhssK9WjfWwgT5IfGwxoiTPx1hEMjLfWUX3AgQ3c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQWOkfXV4tXT/2QX+I/Nk8eMRXSGZTrzcpDQ3IrP5rd6N5NOQXPuds+dF/jN5I5+D
	 bLXW1uFZkl5KY3wiVcSFFJLdrh1fES/dIUszVRObv+q9C14ah/0nYXiMSvUtIYPVPF
	 FTx2aa0W6zuUjHsc06qQPEaRs0aq5ZkJSDfKl+eDPdkDJm2nS5pQYEoRR//A3JXfle
	 1NHQWBn70+l+uuhYXJs9toS/KZ1ptV9OWnu0W1Uo6K492YwV/0VzY6Cpm9i4DYMoRJ
	 /eLubgcM3vskIVyEHjC60nqg5uoHZ1ZNgAdpZzmVdvqLUFNwk21MP9hFr6ZwXp12oW
	 RrSf/PDDth8Ug==
Date: Tue, 9 Jul 2024 20:47:27 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Michal Michalik <michal.michalik@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-next 1/4] ice: Implement PTP support for E830 devices
Message-ID: <20240709194727.GP346094@kernel.org>
References: <20240709123629.666151-6-karol.kolacinski@intel.com>
 <20240709123629.666151-7-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709123629.666151-7-karol.kolacinski@intel.com>

On Tue, Jul 09, 2024 at 02:34:55PM +0200, Karol Kolacinski wrote:
> From: Michal Michalik <michal.michalik@intel.com>
> 
> Add specific functions and definitions for E830 devices to enable
> PTP support.
> Introduce new PHY model ICE_PHY_E830.
> E830 devices support direct write to GLTSYN_ registers without shadow
> registers and 64 bit read of PHC time.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 009716a12a26..005054439204 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -307,6 +307,17 @@ bool ice_is_e825c(struct ice_hw *hw)
>  	}
>  }
>  
> +/**
> + * ice_is_e830
> + * @hw: pointer to the hardware structure
> + *
> + * returns true if the device is E830 based, false if not.

Hi Michal, Karol, all,

Please consider documenting return values using a "Return:" or "Returns:"
section.

Flagged by: kernel-doc -none -Wall

> + */
> +bool ice_is_e830(const struct ice_hw *hw)
> +{
> +	return hw->mac_type == ICE_MAC_E830;
> +}
> +
>  /**
>   * ice_clear_pf_cfg - Clear PF configuration
>   * @hw: pointer to the hardware structure

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 06500028c760..3a5dd65a9a80 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -327,6 +327,7 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
>  #define ICE_E810_PLL_FREQ		812500000
>  #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
>  #define ICE_E810_OUT_PROP_DELAY_NS	1
> +#define ICE_E810_E830_SYNC_DELAY	0
>  #define ICE_E825C_OUT_PROP_DELAY_NS	11
>  
>  /* Device agnostic functions */
> @@ -673,18 +674,21 @@ static inline bool ice_is_primary(struct ice_hw *hw)
>  /* E810 timer command register */
>  #define E810_ETH_GLTSYN_CMD		0x03000344
>  
> +/* E830 timer command register */
> +#define E830_ETH_GLTSYN_CMD		0x00088814
> +
> +/* E810 PHC time register */
> +#define E830_GLTSYN_TIME_L(_tmr_idx)	(0x0008A000 + 0x1000 * (_tmr_idx))
> +
>  /* Source timer incval macros */
>  #define INCVAL_HIGH_M			0xFF
>  
> -/* Timestamp block macros */
> +/* PHY 40b registers macros */
> +#define PHY_EXT_40B_LOW_M		GENMASK(31, 0)
> +#define PHY_EXT_40B_HIGH_M		GENMASK(39, 32)
> +#define PHY_40B_LOW_M			GENMASK(7, 0)
> +#define PHY_40B_HIGH_M			GENMASK(39, 8)

I think that GENMASK_ULL needs to be used here
to avoid breakage on systems with 32bit unsigned long.

>  #define TS_VALID			BIT(0)
> -#define TS_LOW_M			0xFFFFFFFF
> -#define TS_HIGH_M			0xFF
> -#define TS_HIGH_S			32
> -
> -#define TS_PHY_LOW_M			0xFF
> -#define TS_PHY_HIGH_M			0xFFFFFFFF
> -#define TS_PHY_HIGH_S			8
>  
>  #define BYTES_PER_IDX_ADDR_L_U		8
>  #define BYTES_PER_IDX_ADDR_L		4

...

