Return-Path: <netdev+bounces-100627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F88FB62D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238A81C23AFF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CC14884D;
	Tue,  4 Jun 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxjSqW/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E014884C
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512436; cv=none; b=ELr6VsXVJj3HQkQ4tmxJwStAKtyCd68PtRvKYhfHxafS+ID/+nZBvtaIvs1Fhj5cWS/f8JxJ400DLO00p/i7y6nkLlNl9beXej+ar7VBUPg53pV8SOS4EIRm2m3Q0dn4g73KrabgdfEdBfVbtKi7huIpMo8GYKMWVNRtkwsCGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512436; c=relaxed/simple;
	bh=DQpc3H/iGHBzXEnXirKC4DTb+vp4yIJgxU2+Hd02O04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XON5ma0twroGuaUHZH9eS9RPCMaRKjLVitLdCgmgevqqEmQf4qU5F+UbPr2ibaIxAw8Uu1vMb36ZOyRXXRRT7q6KFozaS6OWrrCS8YPhJcPnFy6H3zHiLX1XXO3XWUoM3lEcdkDGV1MiGv5pNMfd9DlVRG/skxolzo6+21MGSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxjSqW/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DA7C2BBFC;
	Tue,  4 Jun 2024 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717512436;
	bh=DQpc3H/iGHBzXEnXirKC4DTb+vp4yIJgxU2+Hd02O04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxjSqW/ewt4Dy+GkrFEJ5uErXcctItLMmHKgt/gRpY3Axxf9BDJUjOchF8VsNgtIu
	 s3Gaj8MBBe15ZJbhTrQdLfIgoTBywyCYYdBoXPrjCyLiKjXU1aDTXP3qFL107jtJ42
	 uF6oh4SwYbd9MSGsjZobJ974Dzhc5Jqrsm1HVK9PRRslB7H2g8GWwTbdgehnI9ky6w
	 uVCJLk0ts02C+afV9Ed8h409n7kq2CautYClAVeMm9eyylsVVqVQzkcGrJnz+pX4iq
	 wW+OZSqnkCXI7dlHHv0+6WXGd26G8mgbdkLsqI0s+ys8dJE5qWUB6zyMKb+3kdc9vP
	 r9TiJywyFe1qw==
Date: Tue, 4 Jun 2024 15:47:12 +0100
From: Simon Horman <horms@kernel.org>
To: Karen Ostrowska <karen.ostrowska@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Eric Joyner <eric.joyner@intel.com>,
	netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in function
Message-ID: <20240604144712.GR491852@kernel.org>
References: <20240528090140.221964-1-karen.ostrowska@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528090140.221964-1-karen.ostrowska@intel.com>

On Tue, May 28, 2024 at 11:01:40AM +0200, Karen Ostrowska wrote:
> From: Eric Joyner <eric.joyner@intel.com>
> 
> Check the return value from ice_vsi_rebuild() and prevent the usage of
> incorrectly configured VSI.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index f60c022f7960..e8c30b1730a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4135,15 +4135,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>  
>  	/* set for the next time the netdev is started */
>  	if (!netif_running(vsi->netdev)) {
> -		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		if (err)
> +			goto rebuild_err;
>  		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
>  		goto done;
>  	}
>  
>  	ice_vsi_close(vsi);
> -	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	if (err)
> +		goto rebuild_err;
> +
>  	ice_pf_dcb_recfg(pf, locked);
>  	ice_vsi_open(vsi);

Hi Karen,

This seems to be a good improvement to me, thanks.
But I do winder if we can go a bit further:

* Should the return value of ice_vsi_open() also be checked?
* Should the return value of ice_vsi_recfg_qs() be checked?

Also, I think the following is appropriate here:

	goto done;

> +
> +rebuild_err:
> +	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
>  done:
>  	clear_bit(ICE_CFG_BUSY, pf->state);
>  	return err;
> -- 
> 2.31.1
> 
> 

