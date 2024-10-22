Return-Path: <netdev+bounces-137874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0329AA363
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E582841FD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09CA19F131;
	Tue, 22 Oct 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfkPK3la"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8619F116;
	Tue, 22 Oct 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604424; cv=none; b=pS+f1+vznUEuC3/vzdOQAuSYs3V5i4esZIeCJ9ir523nWRDqUq/IgGUkzxk+kSkQtiYWA9PeX+FikRAhky6W1i2Cm9AHsGJJJb7rwr393A4M5ddKfZnOQTqiV24Rrcfq6zYFSjBH0Qj/hZ3APG6En+Gj7nMCgSwARj2vacLSslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604424; c=relaxed/simple;
	bh=pF1IpggiByKmR/27T8AuIrXxWJtE41D0QTv9xCkVc10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofwnk5CnvP8Ta5QGquaCHXfK+kZQgUGrcwY6a/AOMO2KVE9G2FXME8BO5r/3u0LElydOmSQqBQWBMNCmG1wSocC3MR2pwQR/PedWFEsU5BTvGGVsjawsiC5AnSXU5NbZa62sBh5F2IY9ZgTpuY9i0hxhYlPvYT91/p8eDATggL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfkPK3la; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2605DC4CEE7;
	Tue, 22 Oct 2024 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729604424;
	bh=pF1IpggiByKmR/27T8AuIrXxWJtE41D0QTv9xCkVc10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfkPK3laOvGMLmLXPWmlZQYjnKGZYfmLVjoSud/9pHb1oGrBGH5owNOBlBZMxITiN
	 Wfeo1WUPww6IdL4oKAsJ9g2hjG81OfKQcrIz15rmtwnxAVT7kQp+Hqo+l4jPWv5/dh
	 6LCP8JMeanhag874fVC9MgNLDIj5Psx/uai4OMq/zMG5tSMwm71wonLjUAX8GqHB3n
	 B/0gm5Ov8WVFuxyaIfsjMPBGPy2nP8Rz6TWX0fJNKgts2LmpG1ftL5se5J3Ouf/z7Y
	 ilYKHwxupDGQPwG2NJooHzf311+e8L2YeGD1QmTOxw6oRTmWnNYQk2VGk2xwlr3BBi
	 X1lcFNAX1zo6g==
Date: Tue, 22 Oct 2024 14:40:20 +0100
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 2/2] ice: ptp: add control over HW timestamp
 latch point
Message-ID: <20241022134020.GU402847@kernel.org>
References: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
 <20241021141955.1466979-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021141955.1466979-3-arkadiusz.kubalewski@intel.com>

On Mon, Oct 21, 2024 at 04:19:55PM +0200, Arkadiusz Kubalewski wrote:
> Allow user to control the latch point of ptp HW timestamps in E825
> devices.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 46 +++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 57 +++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
>  3 files changed, 105 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a999fface272..47444412ed9a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2509,6 +2509,50 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
>  	return 0;
>  }
>  
> +/**
> + * ice_get_ts_point - get the tx timestamp latch point
> + * @info: the driver's PTP info structure
> + * @point: return the configured tx timestamp latch point
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +static int
> +ice_get_ts_point(struct ptp_clock_info *info, enum ptp_ts_point *point)
> +{
> +	struct ice_pf *pf = ptp_info_to_pf(info);
> +	struct ice_hw *hw = &pf->hw;
> +	bool sfd_ena;
> +	int ret;
> +
> +	ice_ptp_lock(hw);
> +	ret = ice_ptp_hw_ts_point_get(hw, &sfd_ena);
> +	ice_ptp_unlock(hw);
> +	if (!ret)
> +		*point = sfd_ena ? PTP_TS_POINT_SFD : PTP_TS_POINT_POST_SFD;
> +
> +	return ret;
> +}
> +
> +/**
> + * ice_set_ts_point - set the tx timestamp latch point
> + * @info: the driver's PTP info structure
> + * @point: requested tx timestamp latch point

nit: Please include documentation of the return value,
     as was done for ice_get_ts_point.

     Flagged by ./scripts/kernel-doc -none -Warn

> + */
> +static int
> +ice_set_ts_point(struct ptp_clock_info *info, enum ptp_ts_point point)
> +{
> +	bool sfd_ena = point == PTP_TS_POINT_SFD ? true : false;
> +	struct ice_pf *pf = ptp_info_to_pf(info);
> +	struct ice_hw *hw = &pf->hw;
> +	int ret;
> +
> +	ice_ptp_lock(hw);
> +	ret = ice_ptp_hw_ts_point_set(hw, sfd_ena);
> +	ice_ptp_unlock(hw);
> +
> +	return ret;
> +}
> +
>  /**
>   * ice_ptp_set_funcs_e82x - Set specialized functions for E82X support
>   * @pf: Board private structure

...

