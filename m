Return-Path: <netdev+bounces-134854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF899B5D3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 17:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216C21C21B00
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780DE199934;
	Sat, 12 Oct 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsNzXrFk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE9148FF9
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745989; cv=none; b=J5LqfjZFcg6AjP5te3ZbIkQMFPFIRBd0KUdTu3gB5AZ9utRJvA8Q8PzASViAHitKnthGucQvu9qbKesUcgMKk515K1VXADGMhOd4NdZ//vjenUS1wqJXi+Pxrlwkf+10yEZVrtLuD5soJ2Bm60gOcmsKbIAkQeq549QaF7wkFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745989; c=relaxed/simple;
	bh=X9Ab7tshI5kNRSZBOc7vNlX5e2NKrp5MjV1nHpOxXps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9E/BFmxTpYzq95zk+/vjpUHrbbomTWT+KT925fL+ULxmX+6TWKohEcCTwPMlf+DoC99V8ToBY+S1PLyceTa5Yv3J5bh6Mqja8FtndoFToowykGfF4ywsN1vpgIUR7SPtgpSK6Ap9FCaIUT5J57q5qweFP7Be+JkKIvKwxKpHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsNzXrFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461B0C4CEC6;
	Sat, 12 Oct 2024 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728745988;
	bh=X9Ab7tshI5kNRSZBOc7vNlX5e2NKrp5MjV1nHpOxXps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsNzXrFkmWrwZ9Zg4euPqC9wPzuNeLZGPnJOSGoR9M/FQrCgRMfZpIJLEn6Gwa1K2
	 M+T8J+RGmQqtsAbTdJ6fB6vsa+rwJJFVjIXnkM7TEIXUgykbqjro8iAUtwnPPf+scU
	 GVeysPVsb7+UDLm8OjDDTm71atrDf97jh93IGnE6I8luZ2019UNrwMVgH+elIP1yRc
	 ZkKA4/EToUDo8qEQBLbsO67fjXhZp1QikZJN8ozAX2zMrOWtV6ZnEdnw5qHLdl3mvP
	 WqXvkj17wIH1DBo6CvgYj3mbOLDlaAJwWhfFDXYgk1dATEfI3pFsbqarR7dh1BQdiX
	 lcALNa9knsyng==
Date: Sat, 12 Oct 2024 16:13:04 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us,
	David Laight <David.Laight@aculab.com>
Subject: Re: [iwl-next v4 3/8] ice: get rid of num_lan_msix field
Message-ID: <20241012151304.GK77519@kernel.org>
References: <20240930120402.3468-1-michal.swiatkowski@linux.intel.com>
 <20240930120402.3468-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930120402.3468-4-michal.swiatkowski@linux.intel.com>

+ David Laight

On Mon, Sep 30, 2024 at 02:03:57PM +0200, Michal Swiatkowski wrote:
> Remove the field to allow having more queues than MSI-X on VSI. As
> default the number will be the same, but if there won't be more MSI-X
> available VSI can run with at least one MSI-X.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 -
>  drivers/net/ethernet/intel/ice/ice_base.c    | 10 +++-----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  8 +++---
>  drivers/net/ethernet/intel/ice/ice_irq.c     | 11 +++------
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 26 +++++++++++---------
>  5 files changed, 27 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index cf824d041d5a..1e23aec2634f 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -622,7 +622,6 @@ struct ice_pf {
>  	u16 max_pf_txqs;	/* Total Tx queues PF wide */
>  	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
>  	struct ice_pf_msix msix;
> -	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
>  	u16 num_lan_tx;		/* num LAN Tx queues setup */
>  	u16 num_lan_rx;		/* num LAN Rx queues setup */
>  	u16 next_vsi;		/* Next free slot in pf->vsi[] - 0-based! */

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 85a3b2326e7b..e5c56ec8bbda 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3811,8 +3811,8 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
>   */
>  static int ice_get_max_txq(struct ice_pf *pf)
>  {
> -	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
> -		    (u16)pf->hw.func_caps.common_cap.num_txq);
> +	return min_t(u16, num_online_cpus(),
> +		     pf->hw.func_caps.common_cap.num_txq);

It is unclear why min_t() is used here or elsewhere in this patch
instead of min() as it seems that all the entities being compared
are unsigned. Are you concerned about overflowing u16? If so, perhaps
clamp, or some error handling, is a better approach.

I am concerned that the casting that min_t() brings will hide
any problems that may exist.

>  }
>  
>  /**
> @@ -3821,8 +3821,8 @@ static int ice_get_max_txq(struct ice_pf *pf)
>   */
>  static int ice_get_max_rxq(struct ice_pf *pf)
>  {
> -	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
> -		    (u16)pf->hw.func_caps.common_cap.num_rxq);
> +	return min_t(u16, num_online_cpus(),
> +		     pf->hw.func_caps.common_cap.num_rxq);
>  }
>  
>  /**

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index d4e74f96a8ad..26cfb4b67972 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -157,6 +157,16 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
>  	}
>  }
>  
> +static u16 ice_get_rxq_count(struct ice_pf *pf)
> +{
> +	return min_t(u16, ice_get_avail_rxq_count(pf), num_online_cpus());
> +}
> +
> +static u16 ice_get_txq_count(struct ice_pf *pf)
> +{
> +	return min_t(u16, ice_get_avail_txq_count(pf), num_online_cpus());
> +}
> +
>  /**
>   * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
>   * @vsi: the VSI being configured
> @@ -178,9 +188,7 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
>  			vsi->alloc_txq = vsi->req_txq;
>  			vsi->num_txq = vsi->req_txq;
>  		} else {
> -			vsi->alloc_txq = min3(pf->num_lan_msix,
> -					      ice_get_avail_txq_count(pf),
> -					      (u16)num_online_cpus());
> +			vsi->alloc_txq = ice_get_txq_count(pf);
>  		}
>  
>  		pf->num_lan_tx = vsi->alloc_txq;
> @@ -193,17 +201,14 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
>  				vsi->alloc_rxq = vsi->req_rxq;
>  				vsi->num_rxq = vsi->req_rxq;
>  			} else {
> -				vsi->alloc_rxq = min3(pf->num_lan_msix,
> -						      ice_get_avail_rxq_count(pf),
> -						      (u16)num_online_cpus());
> +				vsi->alloc_rxq = ice_get_rxq_count(pf);
>  			}
>  		}
>  
>  		pf->num_lan_rx = vsi->alloc_rxq;
>  
> -		vsi->num_q_vectors = min_t(int, pf->num_lan_msix,
> -					   max_t(int, vsi->alloc_rxq,
> -						 vsi->alloc_txq));
> +		vsi->num_q_vectors = max_t(int, vsi->alloc_rxq,
> +					   vsi->alloc_txq);
>  		break;
>  	case ICE_VSI_SF:
>  		vsi->alloc_txq = 1;
> @@ -1173,12 +1178,11 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  static void
>  ice_chnl_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
>  {
> -	struct ice_pf *pf = vsi->back;
>  	u16 qcount, qmap;
>  	u8 offset = 0;
>  	int pow;
>  
> -	qcount = min_t(int, vsi->num_rxq, pf->num_lan_msix);
> +	qcount = vsi->num_rxq;
>  
>  	pow = order_base_2(qcount);
>  	qmap = FIELD_PREP(ICE_AQ_VSI_TC_Q_OFFSET_M, offset);
> -- 
> 2.42.0
> 
> 

