Return-Path: <netdev+bounces-103592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39D908C08
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DB31C2169D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE37195F1D;
	Fri, 14 Jun 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZx1kG1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739E14884B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369241; cv=none; b=Jfb2J2ujCDhxYVfK9mcE1fYzb2SQpPDij3bevM4Sey4ifU1OpOHQmmsxC5wV/SvwfTcaCHgmzpK8MWBWOXUpFo6CWZKeFVpJ01kfI3qZdYtR7NyQ5uoNpEYVBLS0WurhVtaq9fl4a4jS3BN6Q/hTW7kvD0uBSXW7zzMVDmVvlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369241; c=relaxed/simple;
	bh=YirVsUgdMKOdT3YPWw2piLtEiAj5wWa579Q69Tql3zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktf4ymiLZdeckVDuZglJKlQoQs2xtILoRcRKlbbYHYTZ2YJZQ8rmRswplAIQvDHMnplouUXlFYVI4wpvHD3PodfytM7djLaMBA4CC1SoIM1O6PuQacRlCVP5tGUmj/E4N3BoC98D0qrCY1HB1q1ZxZ4iqXQn6gaBdgs1sY9euW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZx1kG1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B037C2BD10;
	Fri, 14 Jun 2024 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718369240;
	bh=YirVsUgdMKOdT3YPWw2piLtEiAj5wWa579Q69Tql3zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZx1kG1Yxkw38vPMC/WuJeZKNxl7URnyOKJYikiVBwT5ClEOZD6qh8QL8Wn4YVoz9
	 ePpGRwFsIu60myr7Vo0qSmGFHfWMFNaknCCGfPf7ni+D5p5aRYhFLpEtfFULIgsS1L
	 c7f/HnswwIPsIVbfJlUJp1TYlSDy5K54NBMCAfvAWwCGcHyMfrcxcYBS4IW8vJDx6m
	 mZuquRuUsyrX6eHxb2vjx0sk+X5xBorzKxrVQLw0zzh6rpuPNRsFMtQNAej67RHk+J
	 f1yZDtcW1Ojco7i2msXylxrx1t86Hw6O4qByI3jN7t72Bt8zmrWlUI4NSkuXVqTn4L
	 SZ1qaDnnuIcNw==
Date: Fri, 14 Jun 2024 13:47:16 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com, kuba@kernel.org
Subject: Re: [iwl-next v3 4/4] ice: update representor when VSI is ready
Message-ID: <20240614124716.GN8447@kernel.org>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-5-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610074434.1962735-5-michal.swiatkowski@linux.intel.com>

On Mon, Jun 10, 2024 at 09:44:34AM +0200, Michal Swiatkowski wrote:
> In case of reset of VF VSI can be reallocated. To handle this case it
> should be properly updated.
> 
> Reload representor as vsi->vsi_num can be different than the one stored
> when representor was created.
> 
> Instead of only changing antispoof do whole VSI configuration for
> eswitch.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks Michal,

My comment below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 21 +++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 3f73f46111fc..4f539b1c7781 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -178,16 +178,16 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
>   * @repr_id: representor ID
>   * @vsi: VSI for which port representor is configured
>   */
> -void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
> +void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi)
>  {
>  	struct ice_pf *pf = vsi->back;
>  	struct ice_repr *repr;
> -	int ret;
> +	int err;
>  
>  	if (!ice_is_switchdev_running(pf))
>  		return;
>  
> -	repr = xa_load(&pf->eswitch.reprs, repr_id);
> +	repr = xa_load(&pf->eswitch.reprs, *repr_id);
>  	if (!repr)
>  		return;
>  
> @@ -197,12 +197,19 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
>  	if (repr->br_port)
>  		repr->br_port->vsi = vsi;
>  
> -	ret = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
> -	if (ret) {
> -		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
> -					       ICE_FWD_TO_VSI);
> +	err = ice_eswitch_cfg_vsi(vsi, repr->parent_mac);
> +	if (err)
>  		dev_err(ice_pf_to_dev(pf), "Failed to update VSI of port representor %d",
>  			repr->id);
> +
> +	/* The VSI number is different, reload the PR with new id */
> +	if (repr->id != vsi->vsi_num) {
> +		xa_erase(&pf->eswitch.reprs, repr->id);
> +		repr->id = vsi->vsi_num;
> +		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
> +			dev_err(ice_pf_to_dev(pf), "Failed to reload port representor %d",
> +				repr->id);
> +		*repr_id = repr->id;
>  	}
>  }

FWIIW, I think it would be nicer if ice_eswitch_decfg_vsi returned
the repr_id rather than passing repr_id by reference. This is because,
in general, I think it's nicer to reduce side-effects of functions.

...

