Return-Path: <netdev+bounces-167665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9CA3BAAA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F00F1883C25
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26D1B85EC;
	Wed, 19 Feb 2025 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpONM+FW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163D15B971
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958096; cv=none; b=TAWJm9e2nO+Sy2iR8sm4RZ/eqHdo7jEBsGFW59rIeEbDEe9M3klPmyABZ518mB09tCfEaBXVjELltI1Lg64SGqOTfKeh4/VbSfSlzcxUwmMUE5mz77CNX9Wl9rYIfMexAW3HpeyXeDEa5X0d5nl/qkYdNPLozOvcKUc+FvB8sUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958096; c=relaxed/simple;
	bh=v2KLgziDLI2JVysYzMMszw6RybzprazFv1InI2kbyFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8yq8bKv7K44bS6U6nuBBToCQXssPDseUI6XHfNg6DoTTd3VOdSzf9UGA9yvsCoboJn/4a1ir/wjUFfa3UpkMtIvfMgfLPkTqt0Fw340/EzW22jOHociuFo34Oizl2YUcmZcQ4EKf26aIZazFPsFdTLkUuCmZYD1GoiOk7IODpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpONM+FW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739958095; x=1771494095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2KLgziDLI2JVysYzMMszw6RybzprazFv1InI2kbyFU=;
  b=gpONM+FWgUMc+gWA5lC7YxQBSc82k1p0btWdaEo2NuRQn8zJALCdRV0b
   Snpr/83AY4Vl0Nvrab/i+74H9lqgKtaANIwGOA2hHjtuSiuJKqlm+QXZI
   M7SOyScgQlYtwO1/ftFAsZjKzWdTmWOlRuatixXeqsYi31hfwRW2J9LJh
   lDym+rOd9/DtyFXADAMgb4XwI7i/oAZ6kZv5gwhRmf8jx+tWhL5h3745D
   7QgwjOKtq7ZityNXDO6MoYntplZUQ4H3luij4pRAxqMfzvrnNIHGNizbH
   190gRRyTQuOGSMIFl/oiD7XhPxiADzRnJA+uh7NqN+reAgd3J0EknpCEy
   w==;
X-CSE-ConnectionGUID: sXTIdS7GTOuPr3BrRNxiTg==
X-CSE-MsgGUID: WnRmmw8wSeWT7yBHrgeZHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44443628"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="44443628"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 01:41:34 -0800
X-CSE-ConnectionGUID: ZZIxJgZ5RCKieousb9JNzA==
X-CSE-MsgGUID: K3VY4FQgRP+GpYrZVFFa+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="114517753"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 01:41:32 -0800
Date: Wed, 19 Feb 2025 10:37:53 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix Get Tx Topology AQ command error on E830
Message-ID: <Z7WmcXf8J5j/ksNX@mev-dev.igk.intel.com>
References: <20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-jk-e830-ddp-loading-fix-v1-1-47dc8e8d4ab5@intel.com>

On Tue, Feb 18, 2025 at 04:46:34PM -0800, Jacob Keller wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> With E830 Get Tx Topology AQ command (opcode 0x0418) returns an error when
> setting the AQ command read flag, and since the get command is a direct
> command there is no need to set the read flag.
> 
> Fix this by only setting read flag on set command.

Why it isn't true for other hw? I mean, why not:
if (set)
	RD_FLAG
else 
	NOT_RD_FLAG
Other hw needs RD flag in case of get too?

> 

Don't you need fixes tag?
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index 03988be03729b76e96188864896527060c8c4d5b..49bd49ab3ccf36c990144894e887341459377a2d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
>  			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
>  					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
>  
> -		if (ice_is_e825c(hw))
> -			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> +		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
>  	} else {
>  		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
>  		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
> -	}
>  
> -	if (!ice_is_e825c(hw))
> -		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> +		if (hw->mac_type != ICE_MAC_GENERIC_3K_E825 &&
> +		    hw->mac_type != ICE_MAC_E830)
> +			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
> +	}
>  
>  	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
>  	if (status)
>

In general looks fine, only one question.

Thanks,
Michal

> ---
> base-commit: f5da7c45188eea71394bf445655cae2df88a7788
> change-id: 20250218-jk-e830-ddp-loading-fix-9efdbdfc270a
> 
> Best regards,
> -- 
> Jacob Keller <jacob.e.keller@intel.com>

