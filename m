Return-Path: <netdev+bounces-168164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A4A3DD72
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42227A3059
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697801D5CE7;
	Thu, 20 Feb 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+4m2CYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D61D5160;
	Thu, 20 Feb 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063407; cv=none; b=AGameXdXcMkGGR0ABzP91qmjgXfBeP95J1J9gWCYBySYsY7xymVl84FEofWFBtJYuJ9+/9e+92+qQ7OSxKJx+MQNimXjRyjfmCF9nAm78MYJdmNlL/RxaQc3gxxZVRPkmTk5wXjCfuyNFgTvr61ShhyjFxVUFdftMz4cAfBw4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063407; c=relaxed/simple;
	bh=QiwnkF0UwAVnyULwhSlHoGTh1+lJb0Epz5yXz5sNWO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWsivbEEQV/nvUtPeYvu/WTEZLPVgrF4sEb7sy/2pl9GNz2COfKM92oK7vtS82SiZW7tHi98++14A+sWCQaan39w2C7hqbTyFTefkflXgMJs1lerN/31MWcSON4kHRYshCBpfNt41IaHn36Nno/N5r9jk+flUqZWz1S/v9zTsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+4m2CYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A0C4CED1;
	Thu, 20 Feb 2025 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063407;
	bh=QiwnkF0UwAVnyULwhSlHoGTh1+lJb0Epz5yXz5sNWO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+4m2CYpSkgijm+ur0lwT45RhojCSbFVS/e4S+PVccsAmjOE0DCvfiEWhqgKYLTlc
	 LY/hEzRjK6a2UY1fyZwouKCHJLbGUxcUpv/szZgUW8k9sWUP+tr/acU320eBt/7zLh
	 sEg5M3pzflsn0Gu99aZ/UcWR9A8Mjm/xroDvJhAO9Wp5bWtPgd8mbVxOJvy+59DtMy
	 9EePASrsQ6iLZWq/ha3Gg2tQjmc60q81xaYEpazBpHR/86YqRDp/ZC0A03/WQtSlcC
	 aRcvO7Fo5318UvaAX0rw4fVFOrouBm90EJCVDPHds30lEtCu/9iav7SzP56PUuBy21
	 BT+2RvmPUII9g==
Date: Thu, 20 Feb 2025 14:56:42 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: Re: [PATCH iwl-next v4 2/6] ice: do not add LLDP-specific filter if
 not necessary
Message-ID: <20250220145642.GZ1615191@kernel.org>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-3-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214085215.2846063-3-larysa.zaremba@intel.com>

On Fri, Feb 14, 2025 at 09:50:36AM +0100, Larysa Zaremba wrote:
> Commit 34295a3696fb ("ice: implement new LLDP filter command")
> introduced the ability to use LLDP-specific filter that directs all
> LLDP traffic to a single VSI. However, current goal is for all trusted VFs
> to be able to see LLDP neighbors, which is impossible to do with the
> special filter.
> 
> Make using the generic filter the default choice and fall back to special
> one only if a generic filter cannot be added. That way setups with "NVMs
> where an already existent LLDP filter is blocking the creation of a filter
> to allow LLDP packets" will still be able to configure software Rx LLDP on
> PF only, while all other setups would be able to forward them to VFs too.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index aaa592ffd2d8..f2e51bacecf8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -6010,15 +6010,21 @@ bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
>  /**
>   * ice_lldp_fltr_add_remove - add or remove a LLDP Rx switch filter
>   * @hw: pointer to HW struct
> - * @vsi_num: absolute HW index for VSI
> + * @vsi: VSI to add the filter to
>   * @add: boolean for if adding or removing a filter
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the operation cannot be performed
> + *	   with this HW or VSI, otherwise an error corresponding to
> + *	   the AQ transaction result.
>   */

Thanks for adding the Return section to the kernel doc.

> -int
> -ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add)
> +int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add)
>  {
>  	struct ice_aqc_lldp_filter_ctrl *cmd;
>  	struct ice_aq_desc desc;
>  
> +	if (vsi->type != ICE_VSI_PF || !ice_fw_supports_lldp_fltr_ctrl(hw))
> +		return -EOPNOTSUPP;
> +
>  	cmd = &desc.params.lldp_filter_ctrl;
>  
>  	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_lldp_filter_ctrl);

...

