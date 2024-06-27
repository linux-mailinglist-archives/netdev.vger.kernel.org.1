Return-Path: <netdev+bounces-107244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AEB91A6A5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C29286D97
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50A15ECC2;
	Thu, 27 Jun 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBODptP1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF715E5AE
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491650; cv=none; b=l2MUOMT7P/JBUqWosc0T53lYIhimEb76nOig69vE47/aVWD4HaubeUVGPfZjt0wLcSBxxWsxqMdQT2caol717O2gbx6RUYinUpr2yE1fHwDAjeEFxesAxdYXN9UlHICbk0GzMJzZE5ZyDQydT2Td/ehJBR7OEOe051DOzhpE5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491650; c=relaxed/simple;
	bh=XeClFF9nR2HbQTvgm9WthQIZl3E1UEObfYLLxcDjXTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgwC7pVuxulhUQ8TDdWafVKsaskdLtZwWO/OQX452YKc4j5SV3USS/OTLs8jte/e8eOCFPCvuCMKvnfUzS2XxxpklbPAYtfcaLpGbM+FwIdaU0C25tV8nrHbNABwWwef9xGl3cXUddOjcQf3e1xr1R1/Nb6h7cWutsTaJ+hMpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBODptP1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719491649; x=1751027649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XeClFF9nR2HbQTvgm9WthQIZl3E1UEObfYLLxcDjXTA=;
  b=cBODptP1hYm/ERUBAdkVlmFo8ZnS2NSDYyh1qsiR5lElNpQQuNpIHPtP
   jhEX9s+qXN2zWQmRrz35NqIg8z1y4Ojp9XTwXLsGmX16ilTwlRbGUi+bt
   0Igv1BUmNBysE5rFu+8a9yDhNg3s4uZezCFPeQAm5T+Rb5wE0Bpd6TnEt
   rdMIBcKcneCCzNcqn48CjSISOjwCJjigRfQ6CC7chbbIK5RMze3dwvWax
   DfEttsgZX2EdX23icVA+QojEPaCDEXJ7OhUtOEPiEEfjsM7tHNyN47llx
   8oTlT05y7D2R9L2xe6eoWwneQgfSxVND27fC58lKc+HOUnPgX1HVjXTbH
   A==;
X-CSE-ConnectionGUID: Ew64EwFJSFmJfDWjcg9YZw==
X-CSE-MsgGUID: vLob9a70TQaaJiQdJMbPsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="34067231"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="34067231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:34:08 -0700
X-CSE-ConnectionGUID: bLgUQAkTQIuemEUCriarkQ==
X-CSE-MsgGUID: 8aI/ikpcSDmZSbsf7AUMvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44187520"
Received: from mev-dev.igk.intel.com (HELO mev-dev) ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:34:04 -0700
Date: Thu, 27 Jun 2024 14:32:58 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	sridhar.samudrala@intel.com, przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com, pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com, horms@kernel.org
Subject: Re: [iwl-next v5 07/15] ice: implement netdev for subfunction
Message-ID: <Zn1b+huDn5tzyQ16@mev-dev>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-8-michal.swiatkowski@linux.intel.com>
 <Zn1JaxkObIWjkVAZ@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1JaxkObIWjkVAZ@boxer>

On Thu, Jun 27, 2024 at 01:13:47PM +0200, Maciej Fijalkowski wrote:
> On Thu, Jun 06, 2024 at 01:24:55PM +0200, Michal Swiatkowski wrote:
> > From: Piotr Raczynski <piotr.raczynski@intel.com>
> > 
> > Configure netdevice for subfunction usecase. Mostly it is reusing ops
> > from the PF netdevice.
> > 
> > SF netdev is linked to devlink port registered after SF activation.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_sf_eth.c | 85 ++++++++++++++++++++-
> >  1 file changed, 84 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> > index abe495c2d033..3a540a2638d1 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> > @@ -2,11 +2,85 @@
> >  /* Copyright (c) 2024, Intel Corporation. */
> >  #include "ice.h"
> >  #include "ice_lib.h"
> > +#include "ice_txrx.h"
> >  #include "ice_fltr.h"
> >  #include "ice_sf_eth.h"
> >  #include "devlink/devlink_port.h"
> >  #include "devlink/devlink.h"
> >  
> > +static const struct net_device_ops ice_sf_netdev_ops = {
> > +	.ndo_open = ice_open,
> > +	.ndo_stop = ice_stop,
> > +	.ndo_start_xmit = ice_start_xmit,
> > +	.ndo_vlan_rx_add_vid = ice_vlan_rx_add_vid,
> > +	.ndo_vlan_rx_kill_vid = ice_vlan_rx_kill_vid,
> > +	.ndo_change_mtu = ice_change_mtu,
> > +	.ndo_get_stats64 = ice_get_stats64,
> > +	.ndo_tx_timeout = ice_tx_timeout,
> > +	.ndo_bpf = ice_xdp,
> > +	.ndo_xdp_xmit = ice_xdp_xmit,
> > +	.ndo_xsk_wakeup = ice_xsk_wakeup,
> > +};
> > +
> > +/**
> > + * ice_sf_cfg_netdev - Allocate, configure and register a netdev
> > + * @dyn_port: subfunction associated with configured netdev
> > + * @devlink_port: subfunction devlink port to be linked with netdev
> > + *
> > + * Return: 0 on success, negative value on failure
> > + */
> > +static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
> > +			     struct devlink_port *devlink_port)
> > +{
> > +	struct ice_vsi *vsi = dyn_port->vsi;
> > +	struct ice_netdev_priv *np;
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
> > +				    vsi->alloc_rxq);
> > +	if (!netdev)
> > +		return -ENOMEM;
> > +
> > +	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
> > +	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
> > +	vsi->netdev = netdev;
> > +	np = netdev_priv(netdev);
> > +	np->vsi = vsi;
> > +
> > +	ice_set_netdev_features(netdev);
> > +
> > +	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
> > +			       NETDEV_XDP_ACT_RX_SG;
> 
> please include:
> 
> 	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
> 
> so that xsk ZC multi-buffer is also supported on SF netdevs.
> 

I am going to send it as a separate patch after checking that it is
working fine with subfunction.

Thanks,
Michal

> > +
> > +	eth_hw_addr_set(netdev, dyn_port->hw_addr);
> > +	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
> > +	netdev->netdev_ops = &ice_sf_netdev_ops;
> > +	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
> > +
> > +	err = register_netdev(netdev);
> > +	if (err) {
> > +		free_netdev(netdev);
> > +		vsi->netdev = NULL;
> > +		return -ENOMEM;
> > +	}
> > +	set_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
> > +	netif_carrier_off(netdev);
> > +	netif_tx_stop_all_queues(netdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ice_sf_decfg_netdev(struct ice_vsi *vsi)
> > +{
> > +	unregister_netdev(vsi->netdev);
> > +	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
> > +	free_netdev(vsi->netdev);
> > +	vsi->netdev = NULL;
> > +	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
> > +}
> > +
> >  /**
> >   * ice_sf_dev_probe - subfunction driver probe function
> >   * @adev: pointer to the auxiliary device
> > @@ -57,10 +131,16 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
> >  		goto err_vsi_decfg;
> >  	}
> >  
> > +	err = ice_sf_cfg_netdev(dyn_port, &sf_dev->priv->devlink_port);
> > +	if (err) {
> > +		dev_err(dev, "Subfunction netdev config failed");
> > +		goto err_devlink_destroy;
> > +	}
> > +
> >  	err = devl_port_fn_devlink_set(&dyn_port->devlink_port, devlink);
> >  	if (err) {
> >  		dev_err(dev, "Can't link devlink instance to SF devlink port");
> > -		goto err_devlink_destroy;
> > +		goto err_netdev_decfg;
> >  	}
> >  
> >  	ice_napi_add(vsi);
> > @@ -70,6 +150,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
> >  
> >  	return 0;
> >  
> > +err_netdev_decfg:
> > +	ice_sf_decfg_netdev(vsi);
> >  err_devlink_destroy:
> >  	ice_devlink_destroy_sf_dev_port(sf_dev);
> >  err_vsi_decfg:
> > @@ -98,6 +180,7 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
> >  
> >  	ice_vsi_close(vsi);
> >  
> > +	ice_sf_decfg_netdev(vsi);
> >  	ice_devlink_destroy_sf_dev_port(sf_dev);
> >  	devl_unregister(devlink);
> >  	devl_unlock(devlink);
> > -- 
> > 2.42.0
> > 

