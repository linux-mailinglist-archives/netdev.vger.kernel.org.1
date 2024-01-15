Return-Path: <netdev+bounces-63500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86D82D782
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 11:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345031C21584
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0221426A;
	Mon, 15 Jan 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYg2DvHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE22207B
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 10:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB4CC433C7;
	Mon, 15 Jan 2024 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705315184;
	bh=STrOEhkymZJkCIxgkd4dhYeqrav6C0xWH76/KX5CIGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYg2DvHbjWDTSI4oKgzkCyJaRcHhTdzsL4s2kAs/YLH/02elCd70tMwan4jM+kvGw
	 E7AZhhBsgcYmwF2VYE5xqJi7mk3KQGmQWqBc613vf+E+PhkDpCo9ik/7pvt33tkjgb
	 gXgKjRhRMjzPvXOy16x2GVjHJ4ivCEVFlnP39tO8DNZqtEcMzl2fBlXaD3PW6RCxMF
	 NaIlceJ43ZeitkJl+ZkvJv/BV8rjWWW816T6vg4STlUctys8kBqGgj9E/lI9h33CzY
	 vSvLEtM4lDYiihIWjzioR1iaLVpmQsJxhjveGNpQOxHPQUYvvjcPSi8FIS++GN++Ct
	 4seHVTvV028bg==
Date: Mon, 15 Jan 2024 10:39:40 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 iwl-next 5/6] ice: factor out ice_ptp_rebuild_owner()
Message-ID: <20240115103940.GN392144@kernel.org>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108124717.1845481-6-karol.kolacinski@intel.com>

On Mon, Jan 08, 2024 at 01:47:16PM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_reset() function uses a goto to skip past clock owner
> operations if performing a PF reset or if the device is not the clock
> owner. This is a bit confusing. Factor this out into
> ice_ptp_rebuild_owner() instead.
> 
> The ice_ptp_reset() function is called by ice_rebuild() to restore PTP
> functionality after a device reset. Follow the convention set by the
> ice_main.c file and rename this function to ice_ptp_rebuild(), in the
> same way that we have ice_prepare_for_reset() and
> ice_ptp_prepare_for_reset().

nit: This feels more like two changes than one,
     which I might have put into two patches.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index fe2d8389627b..8a589f853e96 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2665,11 +2665,13 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  }
>  
>  /**
> - * ice_ptp_reset - Initialize PTP hardware clock support after reset
> + * ice_ptp_rebuild_owner - Initialize PTP clock owner after reset
>   * @pf: Board private structure
> - * @reset_type: the reset type being performed
> + *
> + * Companion function for ice_ptp_rebuild() which handles tasks that only the
> + * PTP clock owner instance should perform.
>   */
> -void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
> +static int ice_ptp_rebuild_owner(struct ice_pf *pf)
>  {
>  	struct ice_ptp *ptp = &pf->ptp;
>  	struct ice_hw *hw = &pf->hw;
> @@ -2677,34 +2679,21 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	u64 time_diff;
>  	int err;
>  
> -	if (ptp->state != ICE_PTP_RESETTING) {
> -		if (ptp->state == ICE_PTP_READY) {
> -			ice_ptp_prepare_for_reset(pf, reset_type);
> -		} else {
> -			err = -EINVAL;
> -			dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
> -			goto err;
> -		}
> -	}
> -
> -	if (reset_type == ICE_RESET_PFR || !ice_pf_src_tmr_owned(pf))
> -		goto pfr;
> -
>  	err = ice_ptp_init_phc(hw);
>  	if (err)
> -		goto err;
> +		return err;
>  
>  	/* Acquire the global hardware lock */
>  	if (!ice_ptp_lock(hw)) {
>  		err = -EBUSY;
> -		goto err;
> +		return err;
>  	}
>  
>  	/* Write the increment time value to PHY and LAN */
>  	err = ice_ptp_write_incval(hw, ice_base_incval(pf));
>  	if (err) {
>  		ice_ptp_unlock(hw);
> -		goto err;
> +		return err;
>  	}
>  
>  	/* Write the initial Time value to PHY and LAN using the cached PHC
> @@ -2720,7 +2709,7 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	err = ice_ptp_write_init(pf, &ts);
>  	if (err) {
>  		ice_ptp_unlock(hw);
> -		goto err;
> +		return err;
>  	}
>  
>  	/* Release the global hardware lock */
> @@ -2729,11 +2718,41 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (!ice_is_e810(hw)) {
>  		/* Enable quad interrupts */
>  		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
> +		if (err)
> +			return err;
> +
> +		ice_ptp_restart_all_phy(pf);

The conditions for calling ice_ptp_restart_all_phy() seem to have
changed (though perhaps in practice they are the same).
And the ordering of this operation relative to the following code has
changed:

	/* Init Tx structures */
	if (ice_is_e810(&pf->hw)) {
		err = ice_ptp_init_tx_e810(pf, &ptp->port.tx);
	} else {
		kthread_init_delayed_work(&ptp->port.ov_work,
					  ice_ptp_wait_for_offsets);
		err = ice_ptp_init_tx_e82x(pf, &ptp->port.tx,
					   ptp->port.port_num);
	}

	ptp->state = ICE_PTP_READY;

Is this intentional?

I do see that the above code is removed in the following patch,
and replaced by a call to ice_ptp_flush_all_tx_tracker()
in ice_ptp_rebuild_owner(). But perhaps this patch
should move this code block code to that location?

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_ptp_rebuild - Initialize PTP hardware clock support after reset
> + * @pf: Board private structure
> + * @reset_type: the reset type being performed
> + */
> +void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
> +{
> +	struct ice_ptp *ptp = &pf->ptp;
> +	int err;
> +
> +	if (ptp->state != ICE_PTP_RESETTING) {
> +		if (ptp->state == ICE_PTP_READY) {
> +			ice_ptp_prepare_for_reset(pf, reset_type);
> +		} else {
> +			err = -EINVAL;
> +			dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
> +			goto err;
> +		}
> +	}
> +
> +	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
> +		err = ice_ptp_rebuild_owner(pf);
>  		if (err)
>  			goto err;
>  	}
>  
> -pfr:
>  	/* Init Tx structures */
>  	if (ice_is_e810(&pf->hw)) {
>  		err = ice_ptp_init_tx_e810(pf, &ptp->port.tx);
> @@ -2748,11 +2767,6 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  
>  	ptp->state = ICE_PTP_READY;
>  
> -	/* Restart the PHY timestamping block */
> -	if (!test_bit(ICE_PFR_REQ, pf->state) &&
> -	    ice_pf_src_tmr_owned(pf))
> -		ice_ptp_restart_all_phy(pf);
> -
>  	/* Start periodic work going */
>  	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
>  

...

