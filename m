Return-Path: <netdev+bounces-115219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2D945746
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EAA1C230E3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C71C2BD;
	Fri,  2 Aug 2024 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7PWBxIp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC58836
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575251; cv=none; b=COupseGT2rgrAsw7h1jL8FCFreFKTtuXLwwa5w6H9DiKIHHOuPSWpda+YHwEi2Rm9x5oxowfOJ8FHv4LEWSzCbFbbEMFbIY0T7gXNmjbEXtSH4f67ofxfI7c/K3uaGLpP/N0HP2QrppfuDAZwJBObt1JYx4HNjhfUFUGWts75Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575251; c=relaxed/simple;
	bh=qNzJaatA1vsqFXPdA0n0eZX4VGXkj/CeWcaQSTGn0k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kETDO53e/PT7eJWqD6VjUWIriN46nn2SLy37Q1QiUtJcoy1Xo6f7l6LtoRNiLCQZB5sLN+mwaiKkRU0oXBnNC31Ii+/pgbE9yKbNfJ3vpawZP6gpNG9cy/62PgKYjTRlOKRa3/RQPFHJdyvJ50nQK8iVZNMCsWuULLcwvPioqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7PWBxIp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722575249; x=1754111249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNzJaatA1vsqFXPdA0n0eZX4VGXkj/CeWcaQSTGn0k0=;
  b=f7PWBxIptRDaw+rdjjpZnExY5VoCNTmlNtyLL/jigWIfPNNt8raHb7CV
   eVBL+QRw9IYp6UUc7y34SxspjVa5wYP5gMuVvMiP+g/7bAfJL1tQN9wyS
   u61Pfm3p0NrqVFd/gQzCvfdc4+j+tfPL7u86j+Cb/1VH11nx+lewNLets
   VHNfg6kXfH4hdBPqX4JKCGkWleJjDR85+fXdcRgPHQ8Q5U95evI8eXewO
   21YNK+dYgArqLqkOMs/IV5Yiu2HdNfnU/bXG07wfdhWSIRN7OAqOOJCSo
   fQ5ly/GNuPZRvVNkdnK/7IPByjnYW9p6SumskiAJ7nG6OKzsJSrDxzhpY
   Q==;
X-CSE-ConnectionGUID: qS5dZxwVTEicp/5vkWVUCQ==
X-CSE-MsgGUID: 0oGDNYwhTXaaHhp429rYeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31974938"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="31974938"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 22:07:28 -0700
X-CSE-ConnectionGUID: BpAs+xmDTw+VMo4DZhFjMg==
X-CSE-MsgGUID: m1hlMT9UQTOFGIkm5rkFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="85866502"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 22:07:24 -0700
Date: Fri, 2 Aug 2024 07:05:45 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Piotr Raczynski <piotr.raczynski@intel.com>,
	jiri@nvidia.com, shayd@nvidia.com, wojciech.drewek@intel.com,
	horms@kernel.org, sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com, kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com, pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v2 05/15] ice: allocate devlink for subfunction
Message-ID: <ZqxpKcmR3cN0/Nm0@mev-dev.igk.intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <20240731221028.965449-6-anthony.l.nguyen@intel.com>
 <Zquer9HA1ErveURV@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zquer9HA1ErveURV@nanopsycho.orion>

On Thu, Aug 01, 2024 at 04:41:51PM +0200, Jiri Pirko wrote:
> Thu, Aug 01, 2024 at 12:10:16AM CEST, anthony.l.nguyen@intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Make devlink allocation function generic to use it for PF and for SF.
> 
> Where is this "generic allocation function". I see only
> ice_allocate_sf() which doesn't look like one...
> 

I forgot to reprhase the commit message after changes.

> 
> >
> >Add function for SF devlink port creation. It will be used in next
> >patch.
> 
> Second patch, unrelated to the first part. Please split.
> 
> 
> Btw, why you don't have the functions added in the same patch where they
> are used? Why to need to add them in a separate patch?
> 

Because the follow up patch was too big (according to your comment). I
really don't want to move the patches around another time. In previous
version you agreed that it can be like that (I have 15/15 patches in
this patchset).

I will move the port creation to the next patch.

> 
> >
> >Create header file for subfunction device. Define subfunction device
> >structure there as it is needed for devlink allocation and port
> >creation.
> >
> >Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >Reviewed-by: Simon Horman <horms@kernel.org>
> >Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> >Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >---
> > .../net/ethernet/intel/ice/devlink/devlink.c  | 32 +++++++++++++++
> > .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 41 +++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++++
> > 5 files changed, 98 insertions(+)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >index b7eb1b56f2c6..4bd7baebeb92 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >@@ -10,6 +10,7 @@
> > #include "ice_eswitch.h"
> > #include "ice_fw_update.h"
> > #include "ice_dcb_lib.h"
> >+#include "ice_sf_eth.h"
> > 
> > /* context for devlink info version reporting */
> > struct ice_info_ctx {
> >@@ -1282,6 +1283,8 @@ static const struct devlink_ops ice_devlink_ops = {
> > 	.port_new = ice_devlink_port_new,
> > };
> > 
> >+static const struct devlink_ops ice_sf_devlink_ops;
> >+
> > static int
> > ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> > 			    struct devlink_param_gset_ctx *ctx)
> >@@ -1548,6 +1551,7 @@ static void ice_devlink_free(void *devlink_ptr)
> >  * Allocate a devlink instance for this device and return the private area as
> >  * the PF structure. The devlink memory is kept track of through devres by
> >  * adding an action to remove it when unwinding.
> >+ *
> 
> Leftover?

I will remove it.

> 
> >  */
> > struct ice_pf *ice_allocate_pf(struct device *dev)
> > {
> >@@ -1564,6 +1568,34 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
> > 	return devlink_priv(devlink);
> > }
> > 
> >+/**
> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
> >+ * @dev: the device to allocate for
> >+ * @pf: pointer to the PF structure
> >+ *
> >+ * Allocate a devlink instance for SF.
> >+ *
> >+ * Return: ice_sf_priv pointer to allocated memory or ERR_PTR in case of error
> >+ */
> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
> >+{
> >+	struct devlink *devlink;
> >+	int err;
> >+
> >+	devlink = devlink_alloc(&ice_sf_devlink_ops, sizeof(struct ice_sf_priv),
> >+				dev);
> >+	if (!devlink)
> >+		return ERR_PTR(-ENOMEM);
> >+
> >+	err = devl_nested_devlink_set(priv_to_devlink(pf), devlink);
> >+	if (err) {
> >+		devlink_free(devlink);
> >+		return ERR_PTR(err);
> >+	}
> >+
> >+	return devlink_priv(devlink);
> >+}
> >+
> > /**
> >  * ice_devlink_register - Register devlink interface for this PF
> >  * @pf: the PF to register the devlink for.
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> >index d291c0e2e17b..1af3b0763fbb 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> >@@ -5,6 +5,7 @@
> > #define _ICE_DEVLINK_H_
> > 
> > struct ice_pf *ice_allocate_pf(struct device *dev);
> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf);
> > 
> > void ice_devlink_register(struct ice_pf *pf);
> > void ice_devlink_unregister(struct ice_pf *pf);
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >index 5d1fe08e4bab..f06baabd0112 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >@@ -489,6 +489,47 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> > 	devl_port_unregister(&vf->devlink_port);
> > }
> > 
> >+/**
> >+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
> >+ * @sf_dev: the subfunction device to create a devlink port for
> >+ *
> >+ * Register virtual flavour devlink port for the subfunction auxiliary device
> >+ * created after activating a dynamically added devlink port.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
> >+{
> >+	struct devlink_port_attrs attrs = {};
> >+	struct ice_dynamic_port *dyn_port;
> >+	struct devlink_port *devlink_port;
> >+	struct devlink *devlink;
> >+	struct ice_vsi *vsi;
> >+
> >+	dyn_port = sf_dev->dyn_port;
> >+	vsi = dyn_port->vsi;
> >+
> >+	devlink_port = &sf_dev->priv->devlink_port;
> >+
> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
> >+
> >+	devlink_port_attrs_set(devlink_port, &attrs);
> >+	devlink = priv_to_devlink(sf_dev->priv);
> >+
> >+	return devl_port_register(devlink, devlink_port, vsi->idx);
> >+}
> >+
> >+/**
> >+ * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
> >+ * @sf_dev: the subfunction device to create a devlink port for
> >+ *
> >+ * Unregisters the virtual port associated with this subfunction.
> >+ */
> >+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
> >+{
> >+	devl_port_unregister(&sf_dev->priv->devlink_port);
> >+}
> >+
> > /**
> >  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
> >  * @dyn_port: dynamic port instance to deallocate
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >index 08ebf56664a5..97b21b58c300 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >@@ -5,6 +5,7 @@
> > #define _DEVLINK_PORT_H_
> > 
> > #include "../ice.h"
> >+#include "../ice_sf_eth.h"
> > 
> > /**
> >  * struct ice_dynamic_port - Track dynamically added devlink port instance
> >@@ -34,6 +35,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
> > void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> > int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
> > void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
> >+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
> >+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> > 
> > #define ice_devlink_port_to_dyn(port) \
> > 	container_of(port, struct ice_dynamic_port, devlink_port)
> >diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >new file mode 100644
> >index 000000000000..a08f8b2bceef
> >--- /dev/null
> >+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >@@ -0,0 +1,21 @@
> >+/* SPDX-License-Identifier: GPL-2.0 */
> >+/* Copyright (c) 2024, Intel Corporation. */
> >+
> >+#ifndef _ICE_SF_ETH_H_
> >+#define _ICE_SF_ETH_H_
> >+
> >+#include <linux/auxiliary_bus.h>
> >+#include "ice.h"
> >+
> >+struct ice_sf_dev {
> >+	struct auxiliary_device adev;
> >+	struct ice_dynamic_port *dyn_port;
> >+	struct ice_sf_priv *priv;
> >+};
> >+
> >+struct ice_sf_priv {
> >+	struct ice_sf_dev *dev;
> >+	struct devlink_port devlink_port;
> >+};
> >+
> >+#endif /* _ICE_SF_ETH_H_ */
> >-- 
> >2.42.0
> >
> >

