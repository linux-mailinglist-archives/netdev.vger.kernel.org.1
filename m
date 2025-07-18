Return-Path: <netdev+bounces-208197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F81B0A8E9
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A40D7A7BD3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E32E5B1F;
	Fri, 18 Jul 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o19tsUFq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784772DEA8E
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857428; cv=none; b=kmz+9aaqZlZkxnFCrNz54mNM5zSsPMfv7GANQD8vIHiEq2EHLa5t3HtLBtDwmysT0Pk+s8BHRI2/Wh3VDhrprKGQ6QEM48KU9xWdXWg1vwgoQufWKWOYRKU9V+gFqRAcR7LdHZBBW2yfT0kn/fpyOTmZErf69DCL8/yiQ9qeTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857428; c=relaxed/simple;
	bh=Yrt9C5FDpyKeWT+IusbcQMTwKDDHDL8C5S5pPR5NU2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS2F6/qol2jYEF6ekt3zNflUwZDACUjb7qnZHOR4aLrxkoc3WRYdXfiA/ZWpigBQYuUcNYRc0YK4NW87+E6hgIuIwUwVCDHwkPucuyhkL8G12FEWhmWb98XBCMfR6dfGqktYIKpk/iMKzVHn+f2PfHMzSyS4u7qUFVtdTlMoEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o19tsUFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA5C4CEEB;
	Fri, 18 Jul 2025 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752857428;
	bh=Yrt9C5FDpyKeWT+IusbcQMTwKDDHDL8C5S5pPR5NU2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o19tsUFq9RKErO5gMYBQaeaVXovy2hEdA7VQ51V+hjB8lxb93mj7m8PJYgBm0lHzt
	 lbRWJi+zsW5xnzRLK/yHiNdkkVulb58lioqVrsbDRkfGpw1OsCaand+T+a8TpiXmm2
	 tXYaGzRHwovuYrwpKibrUzVzkyhRN+LqTM8bNldlNKdqZqWWOVvt1xzKeh5yH3qQrH
	 dCnFXY1IWj12khJtffSjChcvANUDCy+XpBaqrCkjV5pc0jhpNZb4IsMoX4xiCqbyMp
	 TMhdDfseHkd1kX3zRWYbSArBVIfVx53dpjIZwRmm/BV1lDEEb89opMfIuE+pOcT+DN
	 Fwu26gIKMEiJQ==
Date: Fri, 18 Jul 2025 17:50:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	vgrinber@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net 2/2] ice: don't leave device non-functional if Tx
 scheduler config fails
Message-ID: <20250718165024.GI2459@horms.kernel.org>
References: <20250717-jk-ddp-safe-mode-issue-v1-0-e113b2baed79@intel.com>
 <20250717-jk-ddp-safe-mode-issue-v1-2-e113b2baed79@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-jk-ddp-safe-mode-issue-v1-2-e113b2baed79@intel.com>

On Thu, Jul 17, 2025 at 09:57:09AM -0700, Jacob Keller wrote:
> The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
> configuration based on NVM parameters, selecting either a 5 or 9 layer
> topology.
> 
> As part of this flow, the driver acquires the "Global Configuration Lock",
> which is a hardware resource associated with programming the DDP package
> to the device. This "lock" is implemented by firmware as a way to
> guarantee that only one PF can program the DDP for a device. Unlike a
> traditional lock, once a PF has acquired this lock, no other PF will be
> able to acquire it again (including that PF) until a CORER of the device.
> Future requests to acquire the lock report that global configuration has
> already completed.
> 
> The following flow is used to program the Tx topology:
> 
>  * Read the DDP package for scheduler configuration data
>  * Acquire the global configuration lock
>  * Program Tx scheduler topology according to DDP package data
>  * Trigger a CORER which clears the global configuration lock
> 
> This is followed by the flow for programming the DDP package:
> 
>  * Acquire the global configuration lock (again)
>  * Download the DDP package to the device
>  * Release the global configuration lock.
> 
> However, if configuration of the Tx topology fails, (i.e.
> ice_get_set_tx_topo returns an error code), the driver exits
> ice_cfg_tx_topo() immediately, and fails to trigger CORER.
> 
> While the global configuration lock is held, the firmware rejects most
> AdminQ commands, as it is waiting for the DDP package download (or Tx
> scheduler topology programming) to occur.
> 
> The current driver flows assume that the global configuration lock has been
> reset by CORER after programming the Tx topology. Thus, the same PF
> attempts to acquire the global lock again, and fails. This results in the
> driver reporting "an unknown error occurred when loading the DDP package".
> It then attempts to enter safe mode, but ultimately fails to finish
> ice_probe() since nearly all AdminQ command report error codes, and the
> driver stops loading the device at some point during its initialization.
> 
> The only currently known way that ice_get_set_tx_topo() can fail is with
> certain older DDP packages which contain invalid topology configuration, on
> firmware versions which strictly validate this data. The most recent
> releases of the DDP have resolved the invalid data. However, it is still
> poor practice to essentially brick the device, and prevent access to the
> device even through safe mode or recovery mode. It is also plausible that
> this command could fail for some other reason in the future.
> 
> We cannot simply release the global lock after a failed call to
> ice_get_set_tx_topo(). Releasing the lock indicates to firmware that global
> configuration (downloading of the DDP) has completed. Future attempts by
> this or other PFs to load the DDP will fail with a report that the DDP
> package has already been downloaded. Then, PFs will enter safe mode as they
> realize that the package on the device does not meet the minimum version
> requirement to load. The reported error messages are confusing, as they
> indicate the version of the default "safe mode" package in the NVM, rather
> than the version of the file loaded from /lib/firmware.
> 
> Instead, we need to trigger CORER to clear global configuration. This is
> the lowest level of hardware reset which clears the global configuration
> lock and related state. It also clears any already downloaded DDP.
> Crucially, it does *not* clear the Tx scheduler topology configuration.
> 
> Refactor ice_cfg_tx_topo() to always trigger a CORER after acquiring the
> global lock, regardless of success or failure of the topology
> configuration.
> 
> We need to re-initialize the HW structure when we trigger the CORER. Thus,
> it makes sense for this to be the responsibility of ice_cfg_tx_topo()
> rather than its caller, ice_init_tx_topology(). This avoids needless
> re-initialization in cases where we don't attempt to update the Tx
> scheduler topology, such as if it has already been programmed.
> 
> There is one catch: failure to re-initialize the HW struct should stop
> ice_probe(). If this function fails, we won't have a valid HW structure and
> cannot ensure the device is functioning properly. To handle this, ensure
> ice_cfg_tx_topo() returns a limited set of error codes. Set aside one
> specifically, -ENODEV, to indicate that the ice_init_tx_topology() should
> fail and stop probe.
> 
> Other error codes indicate failure to apply the Tx scheduler topology. This
> is treated as a non-fatal error, with an informational message informing
> the system administrator that the updated Tx topology did not apply. This
> allows the device to load and function with the default Tx scheduler
> topology, rather than failing to load entirely.
> 
> Note that this use of CORER will not result in loops with future PFs
> attempting to also load the invalid Tx topology configuration. The first PF
> will acquire the global configuration lock as part of programming the DDP.
> Each PF after this will attempt to acquire the global lock as part of
> programming the Tx topology, and will fail with the indication from
> firmware that global configuration is already complete. Tx scheduler
> topology configuration is only performed during driver init (probe or
> devlink reload) and not during cleanup for a CORER that happens after probe
> completes.
> 
> Fixes: 91427e6d9030 ("ice: Support 5 layer topology")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the extensive explanation.

I have a minor nit below, but that notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c  | 44 ++++++++++++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++----
>  2 files changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index 59323c019544..bc525de019de 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -2374,7 +2374,13 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
>   * The function will apply the new Tx topology from the package buffer
>   * if available.
>   *
> - * Return: zero when update was successful, negative values otherwise.
> + * Return:
> + * * 0 - Successfully applied topology configuration.
> + * * -EBUSY - Failed to acquire global configuration lock.
> + * * -EEXIST - Topology configuration has already been applied.
> + * * -EIO - Unable to apply topology configuration.
> + * * -ENODEV - Failed to re-initialize device after applying configuration.
> + * * Other negative error codes indicate unexpected failures.
>   */
>  int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
>  {
> @@ -2407,7 +2413,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
>  
>  	if (status) {
>  		ice_debug(hw, ICE_DBG_INIT, "Get current topology is failed\n");
> -		return status;
> +		return -EIO;
>  	}
>  
>  	/* Is default topology already applied ? */
> @@ -2494,31 +2500,45 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
>  				 ICE_GLOBAL_CFG_LOCK_TIMEOUT);
>  	if (status) {
>  		ice_debug(hw, ICE_DBG_INIT, "Failed to acquire global lock\n");
> -		return status;
> +		return -EBUSY;
>  	}
>  
>  	/* Check if reset was triggered already. */
>  	reg = rd32(hw, GLGEN_RSTAT);
>  	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
> -		/* Reset is in progress, re-init the HW again */
>  		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. Layer topology might be applied already\n");
>  		ice_check_reset(hw);
> -		return 0;
> +		/* Reset is in progress, re-init the HW again */
> +		goto reinit_hw;
>  	}
>  
>  	/* Set new topology */
>  	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
>  	if (status) {
> -		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology\n");
> -		return status;
> +		ice_debug(hw, ICE_DBG_INIT, "Failed to set Tx topology, status %pe\n",
> +			  ERR_PTR(status));
> +		/* only report -EIO here as the caller checks the error value
> +		 * and reports an informational error message informing that
> +		 * the driver failed to program Tx topology.
> +		 */
> +		status = -EIO;
>  	}
>  
> -	/* New topology is updated, delay 1 second before issuing the CORER */
> +	/* Even if Tx topology config failed, we need to CORE reset here to
> +	 * clear the global configuration lock. Delay 1 second to allow
> +	 * hardware to settle then issue a CORER
> +	 */
>  	msleep(1000);
>  	ice_reset(hw, ICE_RESET_CORER);
> -	/* CORER will clear the global lock, so no explicit call
> -	 * required for release.
> -	 */
> +	ice_check_reset(hw);
>  
> -	return 0;
> +reinit_hw:

nit: I think you can move this label above ice_check_reset().
     As the only place that jumps to this label calls ice_check_reset()
     immediately before doing so. If so, renaming the label might
     also be appropriate (up to you on all fronts:)

> +	/* Since we triggered a CORER, re-initialize hardware */
> +	ice_deinit_hw(hw);
> +	if (ice_init_hw(hw)) {
> +		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setting Tx topology\n");
> +		return -ENODEV;
> +	}
> +
> +	return status;
>  }

...

