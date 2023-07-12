Return-Path: <netdev+bounces-17056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4674FF3D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05FA2817D6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091F1116;
	Wed, 12 Jul 2023 06:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA19C2F7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB96AC433C7;
	Wed, 12 Jul 2023 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689143402;
	bh=YmjH6pXE0duVWOXw/qLFsybrKOVBKUyWnoFq/rutZDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5P+lLvql3e7EWp6T0IB6J5a5NSrGzK0IsZ8eVSIbYrv6adEMIpRUCZWtdmBtemDB
	 N9GFKCav8RK6wL34bqwCwAUaxU/Qs1ruk5G46wFGRb3if/gbMHPYxaFp0msGxLM9b7
	 WPCY79fHT59A37FzRo5BsvxquvP8USm6RIh4yEAj5WxZ0wwuoh4A4tdG4s7qWgKR0h
	 nXj2H/k6UaX7smtmedbKQOuWzSmCUsU/KNEgjaboV2ZGu+sX1LiG1l4PjmBFrDPY9t
	 V5zenRpRG6FJ/AFSZpjh+FwrH0WyRQjwkSGl3JdKDglxMC/X1BDsiUsuDcigIaSjer
	 d6aq53Egpgomw==
Date: Wed, 12 Jul 2023 09:29:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v4] ice: Fix memory management in
 ice_ethtool_fdir.c
Message-ID: <20230712062958.GX41919@unreal>
References: <20230711100450.30492-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711100450.30492-1-jedrzej.jagielski@intel.com>

On Tue, Jul 11, 2023 at 12:04:50PM +0200, Jedrzej Jagielski wrote:
> Fix ethtool FDIR logic to not use memory after its release.
> In the ice_ethtool_fdir.c file there are 2 spots where code can
> refer to pointers which may be missing.
> 
> In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
> even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).
> 
> In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
> may first fail to be added via ice_fdir_update_list_entry() but then
> may be deleted by ice_fdir_update_list_entry.
> 
> Terminate in both cases when the returned value of the previous
> operation is other than 0, free memory and don't use it anymore.
> 
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2208423
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: extend CC list, fix freeing memory before return
> v3: correct typos in the commit msg
> v4: restore devm() approach
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index ead6d50fc0ad..b6308780362b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -1281,16 +1281,25 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>  				     ICE_FLOW_FLD_OFF_INVAL);
>  	}
>  
> -	/* add filter for outer headers */
>  	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
> +
> +	if (perfect_filter)
> +		set_bit(fltr_idx, hw->fdir_perfect_fltr);
> +	else
> +		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
> +

The code above is assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);

> +	/* add filter for outer headers */
>  	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
>  					ICE_FD_HW_SEG_NON_TUN);
> -	if (ret == -EEXIST)
> -		/* Rule already exists, free memory and continue */
> -		devm_kfree(dev, seg);
> -	else if (ret)
> +	if (ret == -EEXIST) {
> +		/* Rule already exists, free memory and count as success */
> +		ret = 0;
> +		goto err_exit;
> +	} else if (ret) {
>  		/* could not write filter, free memory */
> +		ret = -EOPNOTSUPP;

I see that original code returned -EOPNOTSUPP, but why?
Why do you rewrite return value? Why can't you return "ret" as is?

Thanks

>  		goto err_exit;
> +	}
>  
>  	/* make tunneled filter HW entries if possible */
>  	memcpy(&tun_seg[1], seg, sizeof(*seg));
> @@ -1305,18 +1314,13 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>  		devm_kfree(dev, tun_seg);
>  	}
>  
> -	if (perfect_filter)
> -		set_bit(fltr_idx, hw->fdir_perfect_fltr);
> -	else
> -		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
> -
>  	return ret;
>  
>  err_exit:
>  	devm_kfree(dev, tun_seg);
>  	devm_kfree(dev, seg);
>  
> -	return -EOPNOTSUPP;
> +	return ret;
>  }
>  
>  /**
> @@ -1914,7 +1918,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
>  
>  	/* input struct is added to the HW filter list */
> -	ice_fdir_update_list_entry(pf, input, fsp->location);
> +	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
> +	if (ret)
> +		goto release_lock;
>  
>  	ret = ice_fdir_write_all_fltr(pf, input, true);
>  	if (ret)
> -- 
> 2.31.1
> 
> 

