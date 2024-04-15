Return-Path: <netdev+bounces-87794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997B8A4A8C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7442812AE
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E302381C7;
	Mon, 15 Apr 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7f/A/Zb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF639856
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170453; cv=none; b=Hppp0uewcmOHnuKdTrtgtBIqku/YwmqiVGcXPimzxS9tIVL2EKJStJGbjXAB1QlZKr5aNH4dRdO2RqNpJxvPN6Xppa7dp/zyw1gUPU0wl/XdLbJ0UUMaIpumjLP8R4BCDkJyvyv9Ya93FDzqQDOYGDyM9rK/K8M3kVFk3Hxqv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170453; c=relaxed/simple;
	bh=Kr0ak1k/sKvBmJQojvP56RuLnV3RRz/nrsvEucaqngo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGXGI5nVhlTrzk7NFlHcvPxX8nl0ImJppHhSnIIaGoAo9+lpbM3GXdrEQ7ZWu7dOGtEygxS6cR1f9U3J+1pT8BEw8Tzs66cbzy4b9QoEEw0NS5aIcHOOj13x5zDjVK09w86ituQAv8eiolmhLth2nlOfhtPCAJ1512x/Qj+y1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7f/A/Zb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713170452; x=1744706452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kr0ak1k/sKvBmJQojvP56RuLnV3RRz/nrsvEucaqngo=;
  b=V7f/A/ZbpGZc2nLl5aIhEzt8vdTSAJXHJv38UdNYZoqBuPX1/e+QBkvB
   lkLA63Lr8zqMTPzasRc2SkOodWfv8Iz61UgVmOcArXFjQ1d4f5EqfokT4
   uom2Jx6PXehZ8JmIkE5+oi2RkXvUIyYyENJtHGvZF8vuiSxHAJU0PsnJf
   G/Pvr3NXuah9dvkOGrZJrLO6ro1Uf22Xxr5dW87cRYFYR1I1VvdZqJDqh
   YUiZ9wkl9D8DRVgw5UJ9Y72J+t+v0f3Bg4upxOMqWZbWC85IcPuuFgyLi
   +CgAt/z2Y5NqHL+LHtzgPCXbA2BEIVspPoQ1ZanKBvnsWNoj8z6FMPg6A
   A==;
X-CSE-ConnectionGUID: TIMqScbxSy6d0Ul2URgPuw==
X-CSE-MsgGUID: MvNO+1/eTJ27uFN/qy/sOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9098644"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9098644"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:40:51 -0700
X-CSE-ConnectionGUID: XqWpYzdiQe6hJ1h5WZoNEw==
X-CSE-MsgGUID: Wv77vYFvTFqJTzWj4tdM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="59288892"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:40:48 -0700
Date: Mon, 15 Apr 2024 10:40:28 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 4/7] ice: allocate devlink for subfunction
Message-ID: <Zhzn/JZ04MlRe2rX@mev-dev>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-5-michal.swiatkowski@linux.intel.com>
 <Zhjhn2hu5ziVSq1h@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhjhn2hu5ziVSq1h@nanopsycho>

On Fri, Apr 12, 2024 at 09:24:15AM +0200, Jiri Pirko wrote:
> Fri, Apr 12, 2024 at 08:30:50AM CEST, michal.swiatkowski@linux.intel.com wrote:
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
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../net/ethernet/intel/ice/devlink/devlink.c  | 47 ++++++++++++++---
> > .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 51 +++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++
> > 5 files changed, 117 insertions(+), 6 deletions(-)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >index 661af04c8eef..5a78bf08e731 100644
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
> >@@ -1286,6 +1287,8 @@ static const struct devlink_ops ice_devlink_ops = {
> > 	.port_new = ice_devlink_port_new,
> > };
> > 
> >+static const struct devlink_ops ice_sf_devlink_ops;
> >+
> > static int
> > ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> > 			    struct devlink_param_gset_ctx *ctx)
> >@@ -1417,18 +1420,23 @@ static void ice_devlink_free(void *devlink_ptr)
> > }
> > 
> > /**
> >- * ice_allocate_pf - Allocate devlink and return PF structure pointer
> >+ * ice_devlink_alloc - Allocate devlink and return devlink priv pointer
> >  * @dev: the device to allocate for
> >+ * @priv_size: size of the priv memory
> >+ * @ops: pointer to devlink ops for this device
> >+ *
> >+ * Allocate a devlink instance for this device and return the private pointer
> >+ * The devlink memory is kept track of through devres by adding an action to
> >+ * remove it when unwinding.
> >  *
> >- * Allocate a devlink instance for this device and return the private area as
> >- * the PF structure. The devlink memory is kept track of through devres by
> >- * adding an action to remove it when unwinding.
> >+ * Return: void pointer to allocated memory
> >  */
> >-struct ice_pf *ice_allocate_pf(struct device *dev)
> >+static void *ice_devlink_alloc(struct device *dev, size_t priv_size,
> >+			       const struct devlink_ops *ops)
> > {
> > 	struct devlink *devlink;
> > 
> >-	devlink = devlink_alloc(&ice_devlink_ops, sizeof(struct ice_pf), dev);
> >+	devlink = devlink_alloc(ops, priv_size, dev);
> > 	if (!devlink)
> > 		return NULL;
> > 
> >@@ -1439,6 +1447,33 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
> > 	return devlink_priv(devlink);
> > }
> > 
> >+/**
> >+ * ice_allocate_pf - Allocate devlink and return PF structure pointer
> >+ * @dev: the device to allocate for
> >+ *
> >+ * Allocate a devlink instance for PF.
> >+ *
> >+ * Return: void pointer to allocated memory
> >+ */
> >+struct ice_pf *ice_allocate_pf(struct device *dev)
> >+{
> >+	return ice_devlink_alloc(dev, sizeof(struct ice_pf), &ice_devlink_ops);
> >+}
> >+
> >+/**
> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
> >+ * @dev: the device to allocate for
> >+ *
> >+ * Allocate a devlink instance for SF.
> >+ *
> >+ * Return: void pointer to allocated memory
> >+ */
> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
> >+{
> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
> >+				 &ice_sf_devlink_ops);
> >+}
> >+
> > /**
> >  * ice_devlink_register - Register devlink interface for this PF
> >  * @pf: the PF to register the devlink for.
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> >index d291c0e2e17b..1b2a5980d5e8 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
> >@@ -5,6 +5,7 @@
> > #define _ICE_DEVLINK_H_
> > 
> > struct ice_pf *ice_allocate_pf(struct device *dev);
> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev);
> > 
> > void ice_devlink_register(struct ice_pf *pf);
> > void ice_devlink_unregister(struct ice_pf *pf);
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >index f5e305a71bd0..1b933083f551 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >@@ -432,6 +432,57 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> > 	devlink_port_unregister(&vf->devlink_port);
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
> >+	struct devlink_port *devlink_port;
> >+	struct ice_dynamic_port *dyn_port;
> >+	struct devlink *devlink;
> >+	struct ice_vsi *vsi;
> >+	struct device *dev;
> >+	struct ice_pf *pf;
> >+	int err;
> >+
> >+	dyn_port = sf_dev->dyn_port;
> >+	vsi = dyn_port->vsi;
> >+	pf = dyn_port->pf;
> >+	dev = ice_pf_to_dev(pf);
> >+
> >+	devlink_port = &sf_dev->priv->devlink_port;
> >+
> >+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
> >+
> >+	devlink_port_attrs_set(devlink_port, &attrs);
> >+	devlink = priv_to_devlink(sf_dev->priv);
> >+
> >+	err = devl_port_register(devlink, devlink_port, vsi->idx);
> >+	if (err)
> >+		dev_err(dev, "Failed to create virtual devlink port for auxiliary subfunction device %d",
> >+			vsi->idx);
> 
> I wonder if the value of vsi->idx is any useful to the user. I guess
> he is not aware of it. Since this error happens upon user cmd active
> call, the identification is pointless. User know on which object he is
> working. Please remove.
> 
Right, will remove it.

> 
> >+
> >+	return err;
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
> >  * ice_activate_dynamic_port - Activate a dynamic port
> >  * @dyn_port: dynamic port instance to activate
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >index 30146fef64b9..1f66705e0261 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> >@@ -5,6 +5,7 @@
> > #define _DEVLINK_PORT_H_
> > 
> > #include "../ice.h"
> >+#include "ice_sf_eth.h"
> > 
> > /**
> >  * struct ice_dynamic_port - Track dynamically added devlink port instance
> >@@ -30,6 +31,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf);
> > void ice_devlink_destroy_pf_port(struct ice_pf *pf);
> > int ice_devlink_create_vf_port(struct ice_vf *vf);
> > void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> >+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
> >+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> > 
> > #define ice_devlink_port_to_dyn(p) \
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

