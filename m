Return-Path: <netdev+bounces-87309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7770D8A27E7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E091B1F227F1
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224D2C683;
	Fri, 12 Apr 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="S9DseIuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7934F20A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906662; cv=none; b=uxm8UtuvVUbaObknXALqWZYz+vovb1ImU0uUOQJwezFd77Te7+tGn6yiDv6+s/4ufqT3v8txWKlYO36cmeRd21vnnJudfpRqaEEf25Y8StO8nL8s5XSfO/zc4WOGK2tWMKfe8M5EtVg2lfzY2O6w4bVkpWZkTxP4yD0LZswbnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906662; c=relaxed/simple;
	bh=qE+iHkrJ4cug7JwM+Wk6XgOYjbIdKwAZ0hjywhGzv1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrcqUibpA5c6Fs4pbgHeWwM86IPYaVs500sz4+btIvmYExIl8caaBr5Ip+QIxF1KrKEu00JvJ/zRzauyw8fJo01Z/iwXKP4rLEw7UJIKk2AgGzMSaBGIGHbrkWSRrVI0vkcEvb4mx8GCwGZlYDg/oRj3yl3lcpGxCqbNUyM7sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=S9DseIuD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so756175e87.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712906658; x=1713511458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY+RglWT+YID+oXmo0lkPgvJUJViZHPWsquouwr1PuA=;
        b=S9DseIuDZMCN70Ae3IReu6TsTxNpciWQSQycVeCXWT1YOG3Rr4DlrVjkef4JR/lG5R
         9eVU0PliKzeGMXtbNyMDRXLwdCstTPmh7dUvSxr2qXE0Hak1YdMQPqVX2Y+OsX9u53yQ
         VM1601CN+a+e3juWJb8O4yq0iP4IFFYJsZ/tCoyZJ/7UeYXKf3IjvKDVSsmvDRt8Ogfw
         P3UlYLI5dcFzlT652SpbkdRClNMr5hXGHSGOkDruh3eM9q2fN5GfQYYEL8owPhEB4L8r
         xwRdGluZR9cU7GL9+nTMJuDEpGZeuB0Tfpn9p+BalBODDleBq9P+CfPYIWuIKN+Iy+WA
         wSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906658; x=1713511458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY+RglWT+YID+oXmo0lkPgvJUJViZHPWsquouwr1PuA=;
        b=dj4bMQ5s9zSlmKR9B2ObJ//SkgVPSj51zqUPbruO5mGBw9TBcZuMeNkF2M+JsUThQm
         wI6fYi8IKNZ2e/qpshdURCERQK3LpDQDA7TWOpKjtEbo4rHHLPmcyYjtwOEImvhVL/at
         eufk3INtCxxD3AtrTi2KuY6Vvll9VuL6BgSuScPqzlkwg9M1PEn6pCcz4hN1izpZ93vY
         9L1fhE716ao0ZKxFmGFJtniRxMcVTjb163B9sxwdZyYxUA1kTasgBm///bSo6qGIb5Oi
         5vAA3OqLAO4Iomea9wJ9+YL5h+wjabXZ20XqvegXOjcD/ak07Kc+qbmgH1PN6/kwCJpK
         w4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeNmc/9gqgb/v3IayWqaVbr33vUV8mQciSJZ+qefmeTWaoijQXGdMO8BAIgvvAIswAvQtjIOSVzw9KeRQ5mEt33kyxmHKl
X-Gm-Message-State: AOJu0Yx3PkiFLFHrs8LtVg0+rTpI7PWj2DTnRw3pX9uyvUOHUkuZlZkr
	EeGqhRc+AnJ1UGZcHUdoTI4UBHodkU3JRBKrphnSGN0In88Ks6OIftGEW7atzNE=
X-Google-Smtp-Source: AGHT+IHRclCn1vg83Xrf5+37yH2sMECpNPMG8FcNv1MsYlBHrcADf67xDgvx7m+4fxyWD2FGeUKzFw==
X-Received: by 2002:ac2:5f84:0:b0:516:d8e5:4e13 with SMTP id r4-20020ac25f84000000b00516d8e54e13mr1058548lfe.26.1712906658145;
        Fri, 12 Apr 2024 00:24:18 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j5-20020ac25505000000b00517374e92ecsm444602lfk.93.2024.04.12.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:24:17 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:24:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 4/7] ice: allocate devlink for subfunction
Message-ID: <Zhjhn2hu5ziVSq1h@nanopsycho>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-5-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412063053.339795-5-michal.swiatkowski@linux.intel.com>

Fri, Apr 12, 2024 at 08:30:50AM CEST, michal.swiatkowski@linux.intel.com wrote:
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
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../net/ethernet/intel/ice/devlink/devlink.c  | 47 ++++++++++++++---
> .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
> .../ethernet/intel/ice/devlink/devlink_port.c | 51 +++++++++++++++++++
> .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++
> 5 files changed, 117 insertions(+), 6 deletions(-)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
>
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>index 661af04c8eef..5a78bf08e731 100644
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
>@@ -1286,6 +1287,8 @@ static const struct devlink_ops ice_devlink_ops = {
> 	.port_new = ice_devlink_port_new,
> };
> 
>+static const struct devlink_ops ice_sf_devlink_ops;
>+
> static int
> ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
> 			    struct devlink_param_gset_ctx *ctx)
>@@ -1417,18 +1420,23 @@ static void ice_devlink_free(void *devlink_ptr)
> }
> 
> /**
>- * ice_allocate_pf - Allocate devlink and return PF structure pointer
>+ * ice_devlink_alloc - Allocate devlink and return devlink priv pointer
>  * @dev: the device to allocate for
>+ * @priv_size: size of the priv memory
>+ * @ops: pointer to devlink ops for this device
>+ *
>+ * Allocate a devlink instance for this device and return the private pointer
>+ * The devlink memory is kept track of through devres by adding an action to
>+ * remove it when unwinding.
>  *
>- * Allocate a devlink instance for this device and return the private area as
>- * the PF structure. The devlink memory is kept track of through devres by
>- * adding an action to remove it when unwinding.
>+ * Return: void pointer to allocated memory
>  */
>-struct ice_pf *ice_allocate_pf(struct device *dev)
>+static void *ice_devlink_alloc(struct device *dev, size_t priv_size,
>+			       const struct devlink_ops *ops)
> {
> 	struct devlink *devlink;
> 
>-	devlink = devlink_alloc(&ice_devlink_ops, sizeof(struct ice_pf), dev);
>+	devlink = devlink_alloc(ops, priv_size, dev);
> 	if (!devlink)
> 		return NULL;
> 
>@@ -1439,6 +1447,33 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
> 	return devlink_priv(devlink);
> }
> 
>+/**
>+ * ice_allocate_pf - Allocate devlink and return PF structure pointer
>+ * @dev: the device to allocate for
>+ *
>+ * Allocate a devlink instance for PF.
>+ *
>+ * Return: void pointer to allocated memory
>+ */
>+struct ice_pf *ice_allocate_pf(struct device *dev)
>+{
>+	return ice_devlink_alloc(dev, sizeof(struct ice_pf), &ice_devlink_ops);
>+}
>+
>+/**
>+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
>+ * @dev: the device to allocate for
>+ *
>+ * Allocate a devlink instance for SF.
>+ *
>+ * Return: void pointer to allocated memory
>+ */
>+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
>+{
>+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
>+				 &ice_sf_devlink_ops);
>+}
>+
> /**
>  * ice_devlink_register - Register devlink interface for this PF
>  * @pf: the PF to register the devlink for.
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
>index d291c0e2e17b..1b2a5980d5e8 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
>@@ -5,6 +5,7 @@
> #define _ICE_DEVLINK_H_
> 
> struct ice_pf *ice_allocate_pf(struct device *dev);
>+struct ice_sf_priv *ice_allocate_sf(struct device *dev);
> 
> void ice_devlink_register(struct ice_pf *pf);
> void ice_devlink_unregister(struct ice_pf *pf);
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>index f5e305a71bd0..1b933083f551 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
>@@ -432,6 +432,57 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
> 	devlink_port_unregister(&vf->devlink_port);
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
>+	struct devlink_port *devlink_port;
>+	struct ice_dynamic_port *dyn_port;
>+	struct devlink *devlink;
>+	struct ice_vsi *vsi;
>+	struct device *dev;
>+	struct ice_pf *pf;
>+	int err;
>+
>+	dyn_port = sf_dev->dyn_port;
>+	vsi = dyn_port->vsi;
>+	pf = dyn_port->pf;
>+	dev = ice_pf_to_dev(pf);
>+
>+	devlink_port = &sf_dev->priv->devlink_port;
>+
>+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
>+
>+	devlink_port_attrs_set(devlink_port, &attrs);
>+	devlink = priv_to_devlink(sf_dev->priv);
>+
>+	err = devl_port_register(devlink, devlink_port, vsi->idx);
>+	if (err)
>+		dev_err(dev, "Failed to create virtual devlink port for auxiliary subfunction device %d",
>+			vsi->idx);

I wonder if the value of vsi->idx is any useful to the user. I guess
he is not aware of it. Since this error happens upon user cmd active
call, the identification is pointless. User know on which object he is
working. Please remove.


>+
>+	return err;
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
>  * ice_activate_dynamic_port - Activate a dynamic port
>  * @dyn_port: dynamic port instance to activate
>diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>index 30146fef64b9..1f66705e0261 100644
>--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
>@@ -5,6 +5,7 @@
> #define _DEVLINK_PORT_H_
> 
> #include "../ice.h"
>+#include "ice_sf_eth.h"
> 
> /**
>  * struct ice_dynamic_port - Track dynamically added devlink port instance
>@@ -30,6 +31,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf);
> void ice_devlink_destroy_pf_port(struct ice_pf *pf);
> int ice_devlink_create_vf_port(struct ice_vf *vf);
> void ice_devlink_destroy_vf_port(struct ice_vf *vf);
>+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
>+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
> 
> #define ice_devlink_port_to_dyn(p) \
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

