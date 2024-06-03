Return-Path: <netdev+bounces-100210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C88D8277
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2C91C20750
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134612C475;
	Mon,  3 Jun 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XNk13hLD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1ED12C473
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418319; cv=none; b=g8HkpC1nroJDQHPG43CS0nU4ATpS78YOwIfOhTr3bG/i2wKR+mQJzuG8UPd12qY+PS2m1HvP80Zj53MVIXV7ehkvc6vZC5RYXGbEcC6s4yK0ybKAsxEqCh5fCB/R2zt50a3JXzsvC2XGQONZOduDUBP7U47bKWjPQM009wvsSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418319; c=relaxed/simple;
	bh=Zxn1/qVG6d74CZ8OocS6/qQcaxg2Xbsr0bbUkMzz+o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBgnA1BBWPCNJCdSHlsbVoGaAb4h2rh5y69zwiNgqc5lE83sS+KsDXMVnaUC5K/c7pAIRIKV03A9Zy860AnhixHcaARwF6KmwSMzd+O2IBpujYXIyRddYj1zMFzwo2Px42/H7ZrKsKmHCwPC14cpbz2hgUQHnuOpGmFfYNz6OEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XNk13hLD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b840cfecdso4090755e87.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717418315; x=1718023115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66sQ4OCDCpaCDV4/jKK7MhZm8aGeMyEaPiYZ1qH50os=;
        b=XNk13hLDO0czd60Ph3Mz9bay9kibVtCkqf3KJltrbXX7wCOETPkhSJ8SN3fd2G9P8E
         1nfLN8weowxHJFkLRGbUu8Zer4gVjwtZHYj3wpdvIJM5QEcaTRXi80XGFC/K4eSloKNY
         r/q2k9Jp4YdEMTzTkqAAiRbcvHkblQFnrS6BGU5ypd5+eFhREAldeQ1+SlOtTMhnljfZ
         MrKkk9rSVXDr+h9TjJbfQj//5j9Mvy1jsROb8G3ZHe8SeMe7TD817VBSkDfJllP/8FaR
         k9N2TCGc0RyPULCA4rOdBzYkfUwtURM9BcoCJSPGA1pKH5n0+PU5iUIBoQpxsK+dBCfH
         akwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418315; x=1718023115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66sQ4OCDCpaCDV4/jKK7MhZm8aGeMyEaPiYZ1qH50os=;
        b=EVfnRMsr/DY+vrU/JtaWDfYt+oqpCL/9Z/ZLOrZryx+Kf5p5GPM8DK7pFEPinzPrat
         h0DCAZwNFy9aAzCSV4HBfmUhEsA0xQ90lRGYIsW8jdNQyZb8BJqTvZSEBjoKX4WIVkt5
         zxnNZek1I8//SgrHCRJ7nujyVveKyIOuXly6uhqSaydR/MyxbTKWZmi3fMmncIinDSas
         HDuwVMVRXDiY7uV6fA1WVW5zlZz5rIn6mBAZlzU5c5Pi6aOywFOcv7W0jVwPi9pzXXu+
         IKbKRE39EMqTIKrUORVyimk57iwvyg6RBg8oNFZwED5lZvP4vmwTkmC9kQBQXxfdkHsV
         wzrg==
X-Forwarded-Encrypted: i=1; AJvYcCWleF3znpU1obqwaKleknAme+kLDEDI/2oBmrXSeaDRvwLLlSMDtdFWXmpV4Dxrh6bkx4gh4wewuJpxVBvlRG/v9gF30Z4b
X-Gm-Message-State: AOJu0Yz3bPs1U6i8NsaijTLpc6YNV5GzVOO7sgbsLmVWu81OFClt2kY/
	WRkXxASBavjby2B0NrkEP+G0ilhqee7a+OF0VbWmLv6khRQ3pG2V6r1Gh28qEJ/xhCe3MYyJTbL
	QUILFfA==
X-Google-Smtp-Source: AGHT+IHZrMbd4rwiIHWpYvTAswn9KEG+TUH8crWWVgs7kGrnY962S77WYVCCeIkVfCVSzHCtlzg8Kg==
X-Received: by 2002:a05:6512:1152:b0:52b:9c8a:7356 with SMTP id 2adb3069b0e04-52b9c8a74e6mr1718565e87.49.1717418314441;
        Mon, 03 Jun 2024 05:38:34 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84ae09sm116408985e9.18.2024.06.03.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:38:33 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:38:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com, horms@kernel.org
Subject: Re: [iwl-next v4 05/15] ice: allocate devlink for subfunction
Message-ID: <Zl25Rioa4K2BmYe6@nanopsycho.orion>
References: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
 <20240603095025.1395347-6-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603095025.1395347-6-michal.swiatkowski@linux.intel.com>

Mon, Jun 03, 2024 at 11:50:15AM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Make devlink allocation function generic to use it for PF and for SF.
>
>Add function for SF devlink port creation. It will be used in next
>patch.
>
>Create header file for subfunction device. Define subfunction device
>structure there as it is needed for devlink allocation and port
>creation.
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/devlink/devlink.c  | 33 +++++++++++++++
> .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 41 +++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++++
> 5 files changed, 99 insertions(+)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>index bfb3d5b59a62..00f549daca57 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>@@ -10,6 +10,7 @@
> #include "ice_eswitch.h"
> #include "ice_fw_update.h"
> #include "ice_dcb_lib.h"
>+#include "ice_sf_eth.h"
> 
> /* context for devlink info version reporting */
> struct ice_info_ctx {
>@@ -1282,6 +1283,8 @@ static const struct devlink_ops ice_devlink_ops = {
> 	.port_new = ice_devlink_port_new,
> };
> 
>+static const struct devlink_ops ice_sf_devlink_ops;
>+
> static int
> ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> 			    struct devlink_param_gset_ctx *ctx)
>@@ -1422,6 +1425,7 @@ static void ice_devlink_free(void *devlink_ptr)
>  * Allocate a devlink instance for this device and return the private area as
>  * the PF structure. The devlink memory is kept track of through devres by
>  * adding an action to remove it when unwinding.
>+ *
>  */
> struct ice_pf *ice_allocate_pf(struct device *dev)
> {
>@@ -1438,6 +1442,35 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
> 	return devlink_priv(devlink);
> }
> 
>+/**
>+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
>+ * @dev: the device to allocate for
>+ * @pf: pointer to the PF structure
>+ *
>+ * Allocate a devlink instance for SF.
>+ *
>+ * Return: ice_sf_priv pointer to allocated memory or ERR_PTR in case of error
>+ */
>+struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
>+{
>+	struct devlink *devlink;
>+	int err;
>+
>+	devlink = devlink_alloc_ns(&ice_sf_devlink_ops,
>+				   sizeof(struct ice_sf_priv),
>+				   devlink_net(priv_to_devlink(pf)), dev);

I don't think this is correct. This is devlink instance for the actual
SF. It is probed on auxiliary bus. I don't see any reason why the
devlink instance netns should be determined by the PF devlink netns.
For VFs, you also don't do it. In mlx5, the only SF implementation, SF
devlink instances are created in initial netns. Please follow that.



>+	if (!devlink)
>+		return ERR_PTR(-ENOMEM);
>+
>+	err = devl_nested_devlink_set(priv_to_devlink(pf), devlink);
>+	if (err) {
>+		devlink_free(devlink);
>+		return ERR_PTR(err);
>+	}
>+
>+	return devlink_priv(devlink);
>+}
>+
> /**
>  * ice_devlink_register - Register devlink interface for this PF
>  * @pf: the PF to register the devlink for.
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
>index d291c0e2e17b..1af3b0763fbb 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
>@@ -5,6 +5,7 @@
> #define _ICE_DEVLINK_H_
> 
> struct ice_pf *ice_allocate_pf(struct device *dev);
>+struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf);
> 
> void ice_devlink_register(struct ice_pf *pf);
> void ice_devlink_unregister(struct ice_pf *pf);
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index 5d1fe08e4bab..f06baabd0112 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -489,6 +489,47 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> 	devl_port_unregister(&vf->devlink_port);
> }
> 
>+/**
>+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
>+ * @sf_dev: the subfunction device to create a devlink port for
>+ *
>+ * Register virtual flavour devlink port for the subfunction auxiliary device
>+ * created after activating a dynamically added devlink port.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ */
>+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
>+{
>+	struct devlink_port_attrs attrs = {};
>+	struct ice_dynamic_port *dyn_port;
>+	struct devlink_port *devlink_port;
>+	struct devlink *devlink;
>+	struct ice_vsi *vsi;
>+
>+	dyn_port = sf_dev->dyn_port;
>+	vsi = dyn_port->vsi;
>+
>+	devlink_port = &sf_dev->priv->devlink_port;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+	devlink = priv_to_devlink(sf_dev->priv);
>+
>+	return devl_port_register(devlink, devlink_port, vsi->idx);
>+}
>+
>+/**
>+ * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
>+ * @sf_dev: the subfunction device to create a devlink port for
>+ *
>+ * Unregisters the virtual port associated with this subfunction.
>+ */
>+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
>+{
>+	devl_port_unregister(&sf_dev->priv->devlink_port);
>+}
>+
> /**
>  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
>  * @dyn_port: dynamic port instance to deallocate
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>index 08ebf56664a5..97b21b58c300 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>@@ -5,6 +5,7 @@
> #define _DEVLINK_PORT_H_
> 
> #include "../ice.h"
>+#include "../ice_sf_eth.h"
> 
> /**
>  * struct ice_dynamic_port - Track dynamically added devlink port instance
>@@ -34,6 +35,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
> void ice_devlink_destroy_vf_port(struct ice_vf *vf);
> int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
> void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
>+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
>+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> 
> #define ice_devlink_port_to_dyn(port) \
> 	container_of(port, struct ice_dynamic_port, devlink_port)
>diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>new file mode 100644
>index 000000000000..a08f8b2bceef
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
>@@ -0,0 +1,21 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/* Copyright (c) 2024, Intel Corporation. */
>+
>+#ifndef _ICE_SF_ETH_H_
>+#define _ICE_SF_ETH_H_
>+
>+#include <linux/auxiliary_bus.h>
>+#include "ice.h"
>+
>+struct ice_sf_dev {
>+	struct auxiliary_device adev;
>+	struct ice_dynamic_port *dyn_port;
>+	struct ice_sf_priv *priv;
>+};
>+
>+struct ice_sf_priv {
>+	struct ice_sf_dev *dev;
>+	struct devlink_port devlink_port;
>+};
>+
>+#endif /* _ICE_SF_ETH_H_ */
>-- 
>2.42.0
>
>

