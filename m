Return-Path: <netdev+bounces-158926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B18A13D2B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196FB161CB3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066822B5A4;
	Thu, 16 Jan 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YESEZZUb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CC22B8A8
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039843; cv=none; b=geWDaXLTGwHDhCcp7ehizR5f/DL5epreEdZTirGOEoiWzNdOg/THZW7A/eT7twJV5Y1AYLG9KpKvJa8eCu6HT1ClfsbOH+rmIVz1WZKpovPvKeAx34Q/MEnr/0IbLVpN2JSj8YIiKbQ12okQrwR/kyk4bIZa3X+KB8YoQFz71ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039843; c=relaxed/simple;
	bh=LOI/Zq1TNfYoRHMeo//q6o5DF9EgwbS+yo1GJ2vdWlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0d0EUIKTPbG5m9Y9RCI8t/dUaUzB+yJqypOPDqq1QWK6bSGiL26CR6LRnKCsEYkf1TT3LGPD5BmxRYP0I8LoDHn3S0USJJpB+K+pzdwcegW2n5uNPwdlHkra2go3DmjLrE/SUOHJcDcimEPf3Jc4CwycCbR9g+vLfhXIYkxDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YESEZZUb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737039842; x=1768575842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LOI/Zq1TNfYoRHMeo//q6o5DF9EgwbS+yo1GJ2vdWlw=;
  b=YESEZZUb8YjxO3lNAPm/Ede3dDpilcbWXpTkLJKIMU1sJ5HczCmHYTIY
   mFxb2GArs68WlwneGhZ9qB/F4mxduPND5nyAW8j/aIXUK68LDQ+CfWvUx
   +7BQ700NOLx4ucLY3ERg0R3ca4zn9W6i9uBaHOohH77JEU0ru/siHSKto
   0KFOtGEwQYwepsP7AH4On1EFOkw4gM3jWPb5QJUzg4BeVco1SlY2khYc4
   f/He0kvvJYYhzsQ7WKZ7c/CzWpO38zxW0FT9W+2ISO6upe0WhRerdFP90
   LOahGmxxK1OLUBEug6I5vqWyoI20yeWQ9kX1quIZ67cEBKU85kiDKmL4T
   w==;
X-CSE-ConnectionGUID: yy/Bop29QM6m4XT+Tdqymw==
X-CSE-MsgGUID: iwgs4Io4RayppYd7fnewQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54842593"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="54842593"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:04:01 -0800
X-CSE-ConnectionGUID: BZ0a8x0EQbqaLwrJgWlHAg==
X-CSE-MsgGUID: K7A5EQl4SUSMYonoy/wt2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="136353273"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:03:59 -0800
Date: Thu, 16 Jan 2025 16:00:38 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH net] net/mlxfw: Drop hard coded max FW flash image size
Message-ID: <Z4kfFlUx6GloTh6v@mev-dev.igk.intel.com>
References: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>

On Thu, Jan 16, 2025 at 02:33:16PM +0200, Moshe Shemesh wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Currently, mlxfw kernel module limits FW flash image size to be
> 10MB at most, preventing the ability to burn recent BlueField-3
> FW that exceeds the said size limit.
> 
> Thus, drop the hard coded limit. Instead, rely on FW's
> max_component_size threshold that is reported in MCQI register
> as the size limit for FW image.
> 
> Fixes: 410ed13cae39 ("Add the mlxfw module for Mellanox firmware flash process")
> Cc: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
> index 46245e0b2462..43c84900369a 100644
> --- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
> +++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
> @@ -14,7 +14,6 @@
>  #define MLXFW_FSM_STATE_WAIT_TIMEOUT_MS 30000
>  #define MLXFW_FSM_STATE_WAIT_ROUNDS \
>  	(MLXFW_FSM_STATE_WAIT_TIMEOUT_MS / MLXFW_FSM_STATE_WAIT_CYCLE_MS)
> -#define MLXFW_FSM_MAX_COMPONENT_SIZE (10 * (1 << 20))
>  
>  static const int mlxfw_fsm_state_errno[] = {
>  	[MLXFW_FSM_STATE_ERR_ERROR] = -EIO,
> @@ -229,7 +228,6 @@ static int mlxfw_flash_component(struct mlxfw_dev *mlxfw_dev,
>  		return err;
>  	}
>  
> -	comp_max_size = min_t(u32, comp_max_size, MLXFW_FSM_MAX_COMPONENT_SIZE);
>  	if (comp->data_size > comp_max_size) {
>  		MLXFW_ERR_MSG(mlxfw_dev, extack,
>  			      "Component size is bigger than limit", -EINVAL);

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.18.2

