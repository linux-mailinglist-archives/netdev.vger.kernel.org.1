Return-Path: <netdev+bounces-86141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554089DB30
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92372289F7D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0C12FF65;
	Tue,  9 Apr 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCnrNlM9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8112F378
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670292; cv=none; b=nDKSdAcpasfndi6a3XiyxubRof8+AZ6haptXoi5UTGDHLlrJuZJGQ4ZAFZ3C6LDEddJ6n7bcDr9TBRK0HkH5UBKZqmkQfIK2Wxq1y9zAWqRRdJyW3WNqVEfMXsCcJE/lDtPKX9tguGMImC92fXdLuqkmylF0jsLW8X5iQ5pTnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670292; c=relaxed/simple;
	bh=I7A/k+EoTx5KaTh8f2Fg5IQqp7kQKQhArVWEv/AVccU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENffVcnRrUKaDbRIwPLNg2Jc5Vx36R2+VVU8NrOsV6RaqnIw/bfboRnAHlU9eL4cR13xBkjVLVlJcCeuZSElRWBG7e2geqeqOp/7MKKDVLY8h7SJne/eAS7XNnufEcjRenlgNl2v0wxOKWLzzkhAY57qzbCKyPIXrts3M4HHQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCnrNlM9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712670290; x=1744206290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7A/k+EoTx5KaTh8f2Fg5IQqp7kQKQhArVWEv/AVccU=;
  b=HCnrNlM9xfJuv1XjczFmYIMmYanJetb9mr7uhEH/KxfxejrWlsWOJbHq
   f71QNzMId95HQ9YhPlcj68q5VcDn0yyjdY7pNFG91bjUOhVjqkCvlSgXW
   3pQxnSTi+uiLp1/0pjpWwJNqI2J+ys9kqWXgvrIUKF1uJyXUNbrD9IuHV
   v4r5HWK92KP45vI+Ytg4GPp2VTl5Ke/br7Qdxk5j3y8AK9hipxDLEcmia
   uo+L94KQX1wMNqVN8SHm4sn8CkpLaep5HA1thhYbvbhV1fsnO2sf6UNRD
   UTbS/2rHIH/iMeTUoByf7PAuqLwpN8jp8MGXvpAR4FnJ069EjZPSBjSMG
   w==;
X-CSE-ConnectionGUID: IfUIGQ9lTLmTQc/1DSnvcQ==
X-CSE-MsgGUID: yQ4wPMoLQ0G5bc8y+50YoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25425641"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25425641"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:44:49 -0700
X-CSE-ConnectionGUID: 2yzFHN3RQFuRz+roTePX5g==
X-CSE-MsgGUID: Vnvj+d8STcKSOoVGz5mGjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="43433639"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:44:47 -0700
Date: Tue, 9 Apr 2024 15:44:28 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 4/7] ice: allocate devlink for subfunction
Message-ID: <ZhVGPAEmqYNHJywJ@mev-dev>
References: <20240408103049.19445-1-michal.swiatkowski@linux.intel.com>
 <20240408103049.19445-5-michal.swiatkowski@linux.intel.com>
 <4c99838f-3ee3-46ea-80e2-5b94336d7661@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c99838f-3ee3-46ea-80e2-5b94336d7661@intel.com>

On Tue, Apr 09, 2024 at 10:34:27AM +0200, Mateusz Polchlopek wrote:
> 
> 
> On 4/8/2024 12:30 PM, Michal Swiatkowski wrote:
> > From: Piotr Raczynski <piotr.raczynski@intel.com>
> > 
> > Make devlink allocation function generic to use it for PF and for SF.
> > 
> > Add function for SF devlink port creation. It will be used in next
> > patch.
> > 
> > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   .../net/ethernet/intel/ice/devlink/devlink.c  | 39 ++++++++++++--
> >   .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> >   .../ethernet/intel/ice/devlink/devlink_port.c | 51 +++++++++++++++++++
> >   .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> >   4 files changed, 89 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index 661af04c8eef..05a752fec316 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -10,6 +10,7 @@
> >   #include "ice_eswitch.h"
> >   #include "ice_fw_update.h"
> >   #include "ice_dcb_lib.h"
> > +#include "ice_sf_eth.h"
> >   /* context for devlink info version reporting */
> >   struct ice_info_ctx {
> > @@ -1286,6 +1287,8 @@ static const struct devlink_ops ice_devlink_ops = {
> >   	.port_new = ice_devlink_port_new,
> >   };
> > +static const struct devlink_ops ice_sf_devlink_ops;
> > +
> >   static int
> >   ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> >   			    struct devlink_param_gset_ctx *ctx)
> > @@ -1417,14 +1420,17 @@ static void ice_devlink_free(void *devlink_ptr)
> >   }
> >   /**
> > - * ice_allocate_pf - Allocate devlink and return PF structure pointer
> > + * ice_devlink_alloc - Allocate devlink and return devlink priv pointer
> >    * @dev: the device to allocate for
> > + * @priv_size: size of the priv memory
> > + * @ops: pointer to devlink ops for this device
> >    *
> > - * Allocate a devlink instance for this device and return the private area as
> > - * the PF structure. The devlink memory is kept track of through devres by
> > - * adding an action to remove it when unwinding.
> > + * Allocate a devlink instance for this device and return the private pointer
> > + * The devlink memory is kept track of through devres by adding an action to
> > + * remove it when unwinding.
> >    */
> > -struct ice_pf *ice_allocate_pf(struct device *dev)
> > +static void *ice_devlink_alloc(struct device *dev, size_t priv_size,
> > +			       const struct devlink_ops *ops)
> 
> Why do we need priv_size and ops if those are not used in the function?
> Shouldn't it be line:
> 
> devlink = devlink_alloc(&ice_devlink_ops, sizeof(struct ice_pf), dev);
> 
> in ice_devlink_alloc changed to take the passed param?
> 
> 

Right, it is an error. I will fix it in v2. Thanks for pointing it.

Michal

> >   {
> >   	struct devlink *devlink;
> > @@ -1439,6 +1445,29 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
> >   	return devlink_priv(devlink);
> >   }
> > +/**
> > + * ice_allocate_pf - Allocate devlink and return PF structure pointer
> > + * @dev: the device to allocate for
> > + *
> > + * Allocate a devlink instance for PF.
> > + */
> > +struct ice_pf *ice_allocate_pf(struct device *dev)
> > +{
> > +	return ice_devlink_alloc(dev, sizeof(struct ice_pf), &ice_devlink_ops);
> > +}
> > +
> > +/**
> > + * ice_allocate_sf - Allocate devlink and return SF structure pointer
> > + * @dev: the device to allocate for
> > + *
> > + * Allocate a devlink instance for SF.
> > + */
> > +struct ice_sf_priv *ice_allocate_sf(struct device *dev)
> > +{
> > +	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
> > +				 &ice_sf_devlink_ops);
> > +}
> > +
> >   /**
> >    * ice_devlink_register - Register devlink interface for this PF
> >    * @pf: the PF to register the devlink for.
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > index d291c0e2e17b..1b2a5980d5e8 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > @@ -5,6 +5,7 @@
> >   #define _ICE_DEVLINK_H_
> >   struct ice_pf *ice_allocate_pf(struct device *dev);
> > +struct ice_sf_priv *ice_allocate_sf(struct device *dev);
> >   void ice_devlink_register(struct ice_pf *pf);
> >   void ice_devlink_unregister(struct ice_pf *pf);
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > index f5e305a71bd0..1b933083f551 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > @@ -432,6 +432,57 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> >   	devlink_port_unregister(&vf->devlink_port);
> >   }
> > +/**
> > + * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
> > + * @sf_dev: the subfunction device to create a devlink port for
> > + *
> > + * Register virtual flavour devlink port for the subfunction auxiliary device
> > + * created after activating a dynamically added devlink port.
> > + *
> > + * Return: zero on success or an error code on failure.
> > + */
> > +int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
> > +{
> > +	struct devlink_port_attrs attrs = {};
> > +	struct devlink_port *devlink_port;
> > +	struct ice_dynamic_port *dyn_port;
> > +	struct devlink *devlink;
> > +	struct ice_vsi *vsi;
> > +	struct device *dev;
> > +	struct ice_pf *pf;
> > +	int err;
> > +
> > +	dyn_port = sf_dev->dyn_port;
> > +	vsi = dyn_port->vsi;
> > +	pf = dyn_port->pf;
> > +	dev = ice_pf_to_dev(pf);
> > +
> > +	devlink_port = &sf_dev->priv->devlink_port;
> > +
> > +	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
> > +
> > +	devlink_port_attrs_set(devlink_port, &attrs);
> > +	devlink = priv_to_devlink(sf_dev->priv);
> > +
> > +	err = devl_port_register(devlink, devlink_port, vsi->idx);
> > +	if (err)
> > +		dev_err(dev, "Failed to create virtual devlink port for auxiliary subfunction device %d",
> > +			vsi->idx);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
> > + * @sf_dev: the subfunction device to create a devlink port for
> > + *
> > + * Unregisters the virtual port associated with this subfunction.
> > + */
> > +void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> > +{
> > +	devl_port_unregister(&sf_dev->priv->devlink_port);
> > +}
> > +
> >   /**
> >    * ice_activate_dynamic_port - Activate a dynamic port
> >    * @dyn_port: dynamic port instance to activate
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > index 30146fef64b9..1f66705e0261 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > @@ -5,6 +5,7 @@
> >   #define _DEVLINK_PORT_H_
> >   #include "../ice.h"
> > +#include "ice_sf_eth.h"
> >   /**
> >    * struct ice_dynamic_port - Track dynamically added devlink port instance
> > @@ -30,6 +31,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf);
> >   void ice_devlink_destroy_pf_port(struct ice_pf *pf);
> >   int ice_devlink_create_vf_port(struct ice_vf *vf);
> >   void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> > +int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
> > +void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> >   #define ice_devlink_port_to_dyn(p) \
> >   	container_of(port, struct ice_dynamic_port, devlink_port)

