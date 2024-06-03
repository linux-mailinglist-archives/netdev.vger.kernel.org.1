Return-Path: <netdev+bounces-100237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B88D847F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A71C21568
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D112DDAF;
	Mon,  3 Jun 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhqbLBX9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8212D769
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423080; cv=none; b=MjyFWGdKIp/T2dzTorUUkhBjKBFz8+6vcsYZjIBidwscFKqKSm98mrslIebY+P/gF4Kgl07pFyraS31kmhFT4C+Ki2Imt6mr/XKodA37a++qsn0+tVh5MI8wJb1Gq4aEj1BpI6y+mHFu/nyT+XeCSRT8ByLCaIdEb5h71Eb2a9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423080; c=relaxed/simple;
	bh=CawHBvqKyTFOvcMEG4pFUuZsEECSzKzJ+3g5yzoRS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktgpRhP8yGv/gBWza0UL7zNgPT/+iIehGavAHd6Q/2UZOW3XeZofKPmfX+QpsIit9kG5vM/WbIPy+QtB0xx+BI9xRLnkorxFIFBfS54hr0ZPd2/zX5lbKLDcW2q7MstRqOxADj4+FtwolqeysEZtAsjYwqmcIlYp3d0t/NgAzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhqbLBX9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717423078; x=1748959078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CawHBvqKyTFOvcMEG4pFUuZsEECSzKzJ+3g5yzoRS+U=;
  b=nhqbLBX9/+zdkzOJdYuQCcnGK6n+fOicBGhIOwrWZfkwT7cTpUPjLNC4
   Jq3C+vtgT2EMh/ZmcD+/ZKlFV8eyJNwvFAWk5doR9G9f9PwHOpIfGbmOX
   8BnndnYwvAzDIq2/70hTqwHs3k3aGWJkmPSh8rnPoi4zmNq2tRUGY11B8
   sZEZ73OJFP3/iRkOyWXn+0V5/71aJvp451h1RThfIcDwvtnrc0txLXBR+
   DsYEUGqSa1bJI4NVPrUoSYkbXF/iGthPYTwzekWKB+PwYSiPLITwjG6EC
   gz0w3ksRcPDwNPbGxD2bGcRcC5JUqskkSNkl5uXbMdFK+kR3NnHgXSTGV
   Q==;
X-CSE-ConnectionGUID: QBZ9U9dgTHGVEaFJTLKFhQ==
X-CSE-MsgGUID: kKDLGzziSgO9l28pXxuDGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="39318032"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="39318032"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:57:58 -0700
X-CSE-ConnectionGUID: w7KGDaM1Qua7oiZsx7yHGg==
X-CSE-MsgGUID: ilSZv5AXQE+el6BnDZDrbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="68046983"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 06:57:54 -0700
Date: Mon, 3 Jun 2024 15:57:04 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com, horms@kernel.org
Subject: Re: [iwl-next v4 05/15] ice: allocate devlink for subfunction
Message-ID: <Zl3LsLK6LZGUZkkA@mev-dev>
References: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
 <20240603095025.1395347-6-michal.swiatkowski@linux.intel.com>
 <Zl25Rioa4K2BmYe6@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl25Rioa4K2BmYe6@nanopsycho.orion>

On Mon, Jun 03, 2024 at 02:38:30PM +0200, Jiri Pirko wrote:
> Mon, Jun 03, 2024 at 11:50:15AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Make devlink allocation function generic to use it for PF and for SF.
> >
> >Add function for SF devlink port creation. It will be used in next
> >patch.
> >
> >Create header file for subfunction device. Define subfunction device
> >structure there as it is needed for devlink allocation and port
> >creation.
> >
> >Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../net/ethernet/intel/ice/devlink/devlink.c  | 33 +++++++++++++++
> > .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 41 +++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++++
> > 5 files changed, 99 insertions(+)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >index bfb3d5b59a62..00f549daca57 100644
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
> >@@ -1422,6 +1425,7 @@ static void ice_devlink_free(void *devlink_ptr)
> >  * Allocate a devlink instance for this device and return the private area as
> >  * the PF structure. The devlink memory is kept track of through devres by
> >  * adding an action to remove it when unwinding.
> >+ *
> >  */
> > struct ice_pf *ice_allocate_pf(struct device *dev)
> > {
> >@@ -1438,6 +1442,35 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
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
> >+	devlink = devlink_alloc_ns(&ice_sf_devlink_ops,
> >+				   sizeof(struct ice_sf_priv),
> >+				   devlink_net(priv_to_devlink(pf)), dev);
> 
> I don't think this is correct. This is devlink instance for the actual
> SF. It is probed on auxiliary bus. I don't see any reason why the
> devlink instance netns should be determined by the PF devlink netns.
> For VFs, you also don't do it. In mlx5, the only SF implementation, SF
> devlink instances are created in initial netns. Please follow that.
> 

Ok, I will change it, thanks.

> 
> 
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

