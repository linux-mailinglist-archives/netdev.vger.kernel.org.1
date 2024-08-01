Return-Path: <netdev+bounces-115018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45D1944E3D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148D11C2307B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909F1A57F3;
	Thu,  1 Aug 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GWN3WTsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CD1A4F36
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523318; cv=none; b=AEcf+8nuD/mXJPfewZcT17YfQfNZP+/262H1Yl0ETZm8BMN215oLWWwS6rFGe9PeMYM/WqqfsaQNGLuNQZv71ZXF/3Js/T78rCwlcsVz11VHgsi1CsVDzO+PxYEh1L4aeYtlsSdCGEMGwfFftZ58syt1HvJR4RXZOPRMHL1I11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523318; c=relaxed/simple;
	bh=16/GAeSuuN2JwBo96jFZyxV8qVrmNNpFhYMA3aWjr5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPvcAXxcZ2dUgri5sXoUBDlbS+jxhN5xsFM3TfLrE+m9AfRWUJHzPDU+aff/kvy6o6ETRbMlhWy7Bfx37whZaT/7zMYH2shF01Gr5F5lhgeinxOnn5KBphiMk8MYVbbs8HOxtVmWpH8P7g2MiZ5knB1CEbQqZdkcyzm4FGVCigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GWN3WTsr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso44241795e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722523314; x=1723128114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLc/ul0ohkpPmbZ7IgGZ3QwAaHdSid25TPEsSWtGbPI=;
        b=GWN3WTsr9orRqpZwBrTtO8QfymJ8+2u5ToQADabafDylc7vEpS/zPwm50m5qPPuJ+B
         3ufiuxhnkbJ55F9uIWPsmxFdVrtshQl74CaqCk8wZynAshabBg1JctPYjnBbx+YRoSZn
         8GYtDjUQyHFpHyO+oKVUlKpYlBf+v1vJaaNn66jzkhmtOJKoc2V9SsaTI/S+HevxeZM5
         WjD615mMtXQQiUcHKRnpkm3F1QFTVOmM1hdaB0VlIvIpDEdQWFGWFo4SGFgXC5bd8wKE
         KSW73LRz/CSVr5ag8ReP15HPJiyf/JTal5G0GmVx3p0Np+70oyq89jLDlDjmVbSKbPq8
         hEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523314; x=1723128114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLc/ul0ohkpPmbZ7IgGZ3QwAaHdSid25TPEsSWtGbPI=;
        b=IYrKWCwx0CrBI5ccWgjgZi6+PfiByhUY+nMo0UBej9EHYig4icgDGbeKfVbM4DX67W
         CZ6x4athxy0sBROwztKOoMOiMcqVNLk1x7d2REdFH0fkhs0E0s392+DtverX9T2zVJRx
         YwR6uJzfZpIs5goTj++rzyMZs3/eJziJiSCU+grRLn90kmPr5HDdl6JRm0qVaJnk6gZB
         EFMSNelEoyRGP0UtsKSKT3fondN1Yf1bgZRJvVRx/7eq3E5VMOUx/YLX0s1i7F3QRrvS
         p72wpshAt4eYUsv9fKzrOevLbntheTxRvHhtGqPlPbhNdGKqBWxriWwZXKv+fe6TnJ5e
         K5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU5gEPOP+MoMKQ2az05uEO9ciD1ZiU6vZvkP8bhBAesSYe9ZKeWN9Q4zdp9UQhkLEXcV3+vj5iqDNr5zQTyDIWTrs3ky4Th
X-Gm-Message-State: AOJu0YyQhgP8p3Dzsh/mD77z2T4VkN0xcGdRfMhEES4AzDmIxyRwrA2S
	XRHj/RiKWHeZJ7T8Q024KmEm4mRlmuLzoJYB9O7Sb+U1L9cu1qbAkfDnYavyh35hdFAyGXO39NV
	kSNU=
X-Google-Smtp-Source: AGHT+IHuOEuhQ6I6aae11ToywUEGk6ZFV0K9HF7ssJx2yqLYV005fRkgulUqLtWnli03toYbDJ9nNw==
X-Received: by 2002:a05:600c:4ec6:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-428e6afea7fmr826165e9.14.1722523314296;
        Thu, 01 Aug 2024 07:41:54 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0344sm19724153f8f.2.2024.08.01.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:41:53 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:41:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v2 05/15] ice: allocate devlink for subfunction
Message-ID: <Zquer9HA1ErveURV@nanopsycho.orion>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <20240731221028.965449-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731221028.965449-6-anthony.l.nguyen@intel.com>

Thu, Aug 01, 2024 at 12:10:16AM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Make devlink allocation function generic to use it for PF and for SF.

Where is this "generic allocation function". I see only
ice_allocate_sf() which doesn't look like one...


>
>Add function for SF devlink port creation. It will be used in next
>patch.

Second patch, unrelated to the first part. Please split.


Btw, why you don't have the functions added in the same patch where they
are used? Why to need to add them in a separate patch?


>
>Create header file for subfunction device. Define subfunction device
>structure there as it is needed for devlink allocation and port
>creation.
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>---
> .../net/ethernet/intel/ice/devlink/devlink.c  | 32 +++++++++++++++
> .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 41 +++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++++
> 5 files changed, 98 insertions(+)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>index b7eb1b56f2c6..4bd7baebeb92 100644
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
>@@ -1548,6 +1551,7 @@ static void ice_devlink_free(void *devlink_ptr)
>  * Allocate a devlink instance for this device and return the private area as
>  * the PF structure. The devlink memory is kept track of through devres by
>  * adding an action to remove it when unwinding.
>+ *

Leftover?

>  */
> struct ice_pf *ice_allocate_pf(struct device *dev)
> {
>@@ -1564,6 +1568,34 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
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
>+	devlink = devlink_alloc(&ice_sf_devlink_ops, sizeof(struct ice_sf_priv),
>+				dev);
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

