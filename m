Return-Path: <netdev+bounces-98475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20238D18C8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517401F2311D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396216B72B;
	Tue, 28 May 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8IkBRVa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAE139D11
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892867; cv=none; b=FgpRTlnqZKPyYMF4Sm3IRrO2je5oKYH9+JQAIixI1QVbzDNRNLAPyCColuqV4L2dfV9mYBbnJ1lz92bYLOkTEc4Aw+lXbioUw5Y5sYQL8l6fWU6ixQOWL9Z6LqyfCqBEgJWVePIx6UEJehAX7t4WQEfi3g6bgXPBhtQX4Cw2oHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892867; c=relaxed/simple;
	bh=nxdU+VENU/erFXbdsBxA1qWDuwfs5LOt+I/fApCoaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba36BUO5PRn9xhR8IhZb4o2cTskIfDBiuaOF6LWegNZcsuzswkI/r7i19wsNpDZpmls7KBhvo3K2Ykx8EHWb6Vkaq3D1ldtoVsa8YwIyxBaQQtnOTP3J/w6lQR3rY14YZtSYst0jceKeLuH/GE5DuPIVok56A2pr0M5ufpUo9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8IkBRVa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716892865; x=1748428865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nxdU+VENU/erFXbdsBxA1qWDuwfs5LOt+I/fApCoaek=;
  b=c8IkBRVaY+8mwHLoP4FEqkchabV95+p1/Ng/u+pHYe6puFRT8L9oLhVQ
   yI6RdAGV72R0He+UgnlIbwZkpZa66ItPs4bv0sDkOwjdImo9g3I6Itowl
   hTQBC7dJ1ImScK+CxrZ0iTqW0KFnyc6JCVF+jdHLF8veugpljlyY6IkR6
   JuDKH1iBsetE0LihC0B+5DYNSyrYvSMaShPUmoawhCa36qppQ0lD0JyM4
   ixdNuE7y85AIenuubRLc/lZkv4iohjfrYC7FTlzHL1OjsEhWp0oNRlbgN
   eACtAP02aRDhhtccxS/RdHBj+plN1tYR1z9PCst8uxHE4wSpcAL1MmI8C
   w==;
X-CSE-ConnectionGUID: tcu3K4fGSUOGXsYWouTuaA==
X-CSE-MsgGUID: 3YYiesLqQvqIPICCmUEcFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13102217"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13102217"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:41:04 -0700
X-CSE-ConnectionGUID: mAEjigb4THeBy6MqwAD+sg==
X-CSE-MsgGUID: dIrYKWfERP2/s4X2Ty4/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="34967932"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:41:01 -0700
Date: Tue, 28 May 2024 12:40:13 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com, pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 05/15] ice: allocate devlink for subfunction
Message-ID: <ZlW0jYW/yY/qe+jN@mev-dev>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-6-michal.swiatkowski@linux.intel.com>
 <b938506f-953f-477b-9496-8ff948824a56@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b938506f-953f-477b-9496-8ff948824a56@intel.com>

On Tue, May 28, 2024 at 09:11:09AM +0200, Przemek Kitszel wrote:
> On 5/28/24 06:38, Michal Swiatkowski wrote:
> > From: Piotr Raczynski <piotr.raczynski@intel.com>
> > 
> > Make devlink allocation function generic to use it for PF and for SF.
> > 
> > Add function for SF devlink port creation. It will be used in next
> > patch.
> > 
> > Create header file for subfunction device. Define subfunction device
> > structure there as it is needed for devlink allocation and port
> > creation.
> > 
> > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   .../net/ethernet/intel/ice/devlink/devlink.c  | 33 +++++++++++++++
> >   .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> >   .../ethernet/intel/ice/devlink/devlink_port.c | 41 +++++++++++++++++++
> >   .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> >   drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++++
> >   5 files changed, 99 insertions(+)
> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> 
> just two minor nitpicks, so:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index bfb3d5b59a62..58196c170b1b 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -10,6 +10,7 @@
> >   #include "ice_eswitch.h"
> >   #include "ice_fw_update.h"
> >   #include "ice_dcb_lib.h"
> > +#include "ice_sf_eth.h"
> >   /* context for devlink info version reporting */
> >   struct ice_info_ctx {
> > @@ -1282,6 +1283,8 @@ static const struct devlink_ops ice_devlink_ops = {
> >   	.port_new = ice_devlink_port_new,
> >   };
> > +static const struct devlink_ops ice_sf_devlink_ops;
> > +
> >   static int
> >   ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> >   			    struct devlink_param_gset_ctx *ctx)
> > @@ -1422,6 +1425,7 @@ static void ice_devlink_free(void *devlink_ptr)
> >    * Allocate a devlink instance for this device and return the private area as
> >    * the PF structure. The devlink memory is kept track of through devres by
> >    * adding an action to remove it when unwinding.
> > + *
> >    */
> >   struct ice_pf *ice_allocate_pf(struct device *dev)
> >   {
> > @@ -1438,6 +1442,35 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
> >   	return devlink_priv(devlink);
> >   }
> > +/**
> > + * ice_allocate_sf - Allocate devlink and return SF structure pointer
> > + * @dev: the device to allocate for
> > + * @pf: pointer to the PF structure
> > + *
> > + * Allocate a devlink instance for SF.
> > + *
> > + * Return: void pointer to allocated memory
> 
> nit: it's not void; you could add "or ERR_PTR in case of error"
> 

Right, will fix

> > + */
> > +struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
> > +{
> > +	struct devlink *devlink;
> > +	int err;
> > +
> > +	devlink = devlink_alloc_ns(&ice_sf_devlink_ops,
> > +				   sizeof(struct ice_sf_priv),
> > +				   devlink_net(priv_to_devlink(pf)), dev);
> > +	if (!devlink)
> > +		return NULL;
> 
> ERR_PTR(-ENOMEM) would be more consistent with the other error exit path
>

Ok

> > +
> > +	err = devl_nested_devlink_set(priv_to_devlink(pf), devlink);
> > +	if (err) {
> > +		devlink_free(devlink);
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	return devlink_priv(devlink);
> > +}
> > +
> >   /**
> >    * ice_devlink_register - Register devlink interface for this PF
> >    * @pf: the PF to register the devlink for.
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > index d291c0e2e17b..1af3b0763fbb 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> > @@ -5,6 +5,7 @@
> >   #define _ICE_DEVLINK_H_
> >   struct ice_pf *ice_allocate_pf(struct device *dev);
> > +struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf);
> >   void ice_devlink_register(struct ice_pf *pf);
> >   void ice_devlink_unregister(struct ice_pf *pf);
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > index 5d1fe08e4bab..f06baabd0112 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> > @@ -489,6 +489,47 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> >   	devl_port_unregister(&vf->devlink_port);
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
> > +	struct ice_dynamic_port *dyn_port;
> > +	struct devlink_port *devlink_port;
> > +	struct devlink *devlink;
> > +	struct ice_vsi *vsi;
> > +
> > +	dyn_port = sf_dev->dyn_port;
> > +	vsi = dyn_port->vsi;
> > +
> > +	devlink_port = &sf_dev->priv->devlink_port;
> > +
> > +	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
> 
> (just comment, not an issue)
> we have (among others):
> 198│ enum devlink_port_flavour {
> 199│         DEVLINK_PORT_FLAVOUR_PHYSICAL, /* Any kind of a port physically
> 200│                                         * facing the user.
> 201│                                         */
> 210│         DEVLINK_PORT_FLAVOUR_PCI_VF, /* Represents eswitch port
> 211│                                       * for the PCI VF. It is an
> internal
> 212│                                       * port that faces the PCI VF.
> 213│                                       */
> 214│         DEVLINK_PORT_FLAVOUR_VIRTUAL, /* Any virtual port facing the
> user. */
> 216│                                       * is not used in any way.
> 217│                                       */
> 218│         DEVLINK_PORT_FLAVOUR_PCI_SF, /* Represents eswitch port
> 219│                                       * for the PCI SF. It is an
> internal
> 220│                                       * port that faces the PCI SF.
> 221│                                       */
> 
> from that I conclude that _PCI_ ones are internal, and you are adding
> user-facing port, so your choice is good, even if there is one with SF
> in the name. Perhaps the enum should have this piece of documentation ;)
>

DEVLINK_PORT_FLAVOUR_PCI_SF is created during port representor creation
and linked with his netdev.

According to the documentation:
Documentation/networking/devlink/devlink-port.rst

Thanks,
Michal

[...]

